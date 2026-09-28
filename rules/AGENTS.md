# 🛡️ Reglas Globales de Desarrollo, Calidad y Gobernanza (Dkript Inc.)

Como asistente de desarrollo y agente de código en el ecosistema de proyectos de Dkript, debes cumplir **ESTRICTAMENTE y SIN EXCEPCIÓN** las siguientes directrices en cada interacción:

## 1. Prohibición de Modificar Código, Diseño o Funcionalidades Aprobadas
- **Inviolabilidad de lo Aprobado:** Queda estrictamente prohibido alterar, eliminar, refactorizar o reescribir código, componentes visuales, estilos, animaciones o funcionalidades que ya hayan sido previamente probadas y aprobadas por el usuario.
- **Plan de Implementación Requerido:** Cualquier modificación estructural, rediseño o alteración de funcionalidades preexistentes **solo se puede realizar si forma parte de un Plan de Implementación previamente presentado y explícitamente aprobado por el usuario**.
- **Respeto a la Estructura Interna y Base de Datos:** Se debe respetar al máximo el funcionamiento y la estructura interna del sistema, incluyendo esquemas de Base de Datos relacionales (migraciones, relaciones, foreign keys) y la regla inviolable de 5 posiciones del RBAC (1=Crear, 2=Editar, 3=Eliminar, 4=Ver/PDF, 5=Especial/Excel). Ninguna tabla o migración debe alterarse de forma destructiva.

## 2. Arquitectura de Código Limpio (Separation of Concerns & DRY)
- **CSS Centralizado:** Todo estilo CSS nuevo o modificado debe residir exclusivamente en public/assets/css/custom.css.
- **JavaScript Modular:** Toda lógica de cliente debe estructurarse modularmente con namespaces (ej. DkriptUser, DkriptRole, DkriptParameters, DkriptErrorScene) en public/assets/js/custom.js, preservando retrocompatibilidad global con window.
- **Vistas Blade Limpias:** Las vistas en esources/views deben contener exclusivamente maquetación semántica y llamadas o configuraciones mínimas de carga asíncrona o envío AJAX. Queda prohibido añadir bloques <style> o scripts procedurales extensos dentro de las vistas Blade.
  - *Excepción técnica aprobada:* esources/views/reports/layout.blade.php mantiene sus estilos internos para renderizado PDF en backend con Dompdf.

## 3. Validación Previa Obligatoria (Quality Gate)
- Antes de dar por finalizada cualquier tarea o registrarla en Bitácora, es **obligatorio ejecutar la suite completa de pruebas automatizadas**:
  `ash
  php artisan test
  `
- El 100% de las pruebas debe pasar con éxito (0 fallos). Si alguna prueba falla o se detecta una regresión, debe corregirse de inmediato antes de dar por terminada la respuesta.

## 4. Registro Obligatorio y Estandarizado en BITACORA.md
- Al concluir cada requerimiento o fase de desarrollo, es **mandatorio registrar los cambios al final de BITACORA.md**.
- Cada nueva fase debe cumplir con la siguiente estructura fija:
  1. **Título de Fase y Número Consecutivo**
  2. **Requerimiento Original del Usuario** (fiel a lo solicitado).
  3. **Diagnóstico / Causa Raíz** (análisis técnico del problema o necesidad).
  4. **Solución Implementada & Decisiones de Diseño** (Backend, Frontend, DB, Seguridad, UX).
  5. **Archivos Modificados y Creados** (rutas completas y exactas).
  6. **Resultado de Validación** (métricas de php artisan test, número de pruebas y aserciones).
  7. **Estampado Temporal y Rama Git** (fecha, hora local exacta y nombre de la rama activa).
- **Actualización de la Tabla de Contenido:** Es obligatorio actualizar el índice de BITACORA.md en la cabecera del documento añadiendo el ancla correspondiente de la nueva fase.

## 5. Estándares Avanzados de Ingeniería y Código Limpio en Laravel
- **Métricas de Complejidad y Modularidad:**
  - Los métodos y controladores deben ser concisos (< 50 líneas). La lógica de negocio compleja debe residir en Servicios (app/Services/) o Acciones (app/Actions/).
  - Máximo 4 niveles de anidamiento; priorizar guard clauses y retornos tempranos (early returns).
- **Control Estricto de Eloquent y Rendimiento (Anti-N+1):**
  - Toda consulta con relaciones dentro de bucles o serializaciones debe aplicar Eager Loading explícito con with() o load().
  - Queda prohibido el uso de $guarded = []. Todos los modelos deben declarar $fillable y $casts.
- **Validación en Frontera y Manejo de Errores:**
  - Prohibido el uso de $request->all() para mutaciones en base de datos. Se debe exigir FormRequest o validación explícita con $request->validated().
  - Prohibido el silenciamiento de errores con bloques catch (\Exception $e) {} vacíos (Silent Failure Hunter). Todo fallo debe auditarse con contexto en AuditService o Log.

## 6. Arquitectura API First y Compatibilidad Móvil (iOS & Android)
- **Contrato Universal de Respuestas API (Envelope):**
  - Todo endpoint o controlador que devuelva datos estructurados (AJAX o API móvil) debe utilizar el formato canónico { success, message, data, meta, errors } (vía ApiResponse trait).
- **Desacoplamiento con API Resources:**
  - Prohibido exponer modelos Eloquent crudos en respuestas API. Se deben transformar mediante JsonResource para garantizar contratos fuertemente tipados compatibles con Swift (Codable) y Kotlin (Serialization).
- **Mapeo RBAC Móvil:**
  - La matriz de 5 posiciones del RBAC (1=Crear, 2=Editar, 3=Eliminar, 4=Ver/PDF, 5=Especial/Excel) es la misma que gobierna los permisos en clientes móviles.