# 🛡️ Dkript Governance & Specialized Subagents Pack

Repositorio oficial del estándar de gobernanza, arquitectura, calidad y subagentes autónomos de **Dkript Inc.** para Google Antigravity, Claude Code, Cursor y plataformas compatibles.

---

## 📦 Contenido del Paquete

### 1. Reglas Globales de Gobernanza (`rules/AGENTS.md`)
- **Inviolabilidad de lo Aprobado:** Prohibición estricta de alterar código, diseño o funcionalidades aprobadas sin un Plan de Implementación previo.
- **Arquitectura de Código Limpio:** CSS centralizado en `public/assets/css/custom.css`, JavaScript modular en `public/assets/js/custom.js` y vistas Blade limpias.
- **Calidad y Bitácora:** Validación obligatoria (`php artisan test`) con 0 fallos y registro estandarizado en `BITACORA.md`.
- **Estándares Laravel & Móvil:** Prevención de N+1 (Eager Loading obligatorio), validación estricta FormRequest y contrato API uniforme de 5 posiciones RBAC (`ApiResponse`).

### 2. Subagentes Especializados (`agents/`)
- 🐘 **`php-reviewer`**: Auditor senior de PHP 8.x y Laravel (PSR-12, FormRequests, Anti-N+1, Tipado estricto).
- 🗄️ **`database-reviewer`**: Especialista en MySQL/MariaDB, migraciones Laravel y matriz RBAC de 5 posiciones.
- ♿ **`a11y-architect`**: Auditor de accesibilidad WCAG 2.2 AA para interfaces Web, iOS y Android.
- 🔧 **`build-error-resolver`**: Solucionador ágil de errores de build, runtime y dependencias con diffs mínimos.

---

## 🚀 Instalación Rápida (1 Solo Comando)

### En Windows (PowerShell):
```powershell
irm https://raw.githubusercontent.com/dkript-web/Dkript-Governance/main/install.ps1 | iex
```

### En Linux / macOS (Bash):
```bash
curl -fsSL https://raw.githubusercontent.com/dkript-web/Dkript-Governance/main/install.sh | bash
```

---

## 🛠️ Instalación Nativa en Antigravity / Claude Code

También puedes instalarlo directamente usando la CLI:

```bash
# Vía CLI directa
agy plugin install https://github.com/dkript-web/Dkript-Governance.git

# O en el chat del asistente
/plugin marketplace add https://github.com/dkript-web/Dkript-Governance.git
/plugin install dkript-governance
```

---

## 👥 Uso en Proyectos de Equipo

Para que todo el equipo utilice automáticamente este paquete en un proyecto específico sin configuraciones locales previas, clona este repositorio en la raíz de tu proyecto dentro de la carpeta `.agents/`:

```bash
git submodule add https://github.com/dkript-web/Dkript-Governance.git .agents/plugins/dkript-governance
```
Antigravity detectará automáticamente las reglas y subagentes para todos los desarrolladores del repositorio.

---

## 📄 Licencia
Propiedad exclusiva de Dkript Inc.
