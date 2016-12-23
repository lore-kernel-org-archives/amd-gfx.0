From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: add prefix for all powerplay pr_*
 prints
Date: Fri, 23 Dec 2016 20:32:58 +1100
Message-ID: <a4500215-e3d3-fd84-2444-f028241f6c4a@folklore1984.net>
References: <1482461108-8463-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0082317980=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1482461108-8463-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Arindam Nath <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0082317980==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rP9OIiXH4WWCvAKqCrMNLn2UJ7axaSo6A"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rP9OIiXH4WWCvAKqCrMNLn2UJ7axaSo6A
Content-Type: multipart/mixed; boundary="cnCFeL6iq0rjwP6iITJpSjQIU4hSso3TQ";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Arindam Nath <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>
Message-ID: <a4500215-e3d3-fd84-2444-f028241f6c4a-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: add prefix for all powerplay pr_*
 prints
References: <1482461108-8463-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1482461108-8463-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>

--cnCFeL6iq0rjwP6iITJpSjQIU4hSso3TQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I would say drop all the header relocation churn, it distracts away from
the functional changes in this commit. Also see inline comments.

With those fixes,
Acked-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

Kindest Regards,
Edward.

On 12/23/2016 01:45 PM, Huang Rui wrote:
> Powerplay will be used them instead of raw printk, and we can dynamic
> change the debug level with it.
>=20
> The prefix is like below:
>=20
> [  197.755167] [powerplay] amdgpu: powerplay initialized

Ideally I think it would be better to look like this:

[  xxx.xxxxxx ] amdgpu: [powerplay] initialized.

but certainly drop repeating "powerplay" twice..

>=20
> Suggested-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> Cc: Arindam Nath <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/amd_powerplay.c               |  2 +-
>  drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c              |  3 +--
>  drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c       |  2 +-
>  drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c                 |  3 ++-
>  drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c            |  2 +-
>  drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c |  2 +-
>  drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c       |  2 +-
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c            |  2 +-
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c        |  2 +-
>  drivers/gpu/drm/amd/powerplay/inc/pp_debug.h                | 10 +++++=
+++--
>  drivers/gpu/drm/amd/powerplay/smumgr/fiji_smc.c             |  2 +-
>  drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c          |  2 +-
>  drivers/gpu/drm/amd/powerplay/smumgr/iceland_smc.c          |  2 +-
>  drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c       |  2 +-
>  drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c        |  2 +-
>  drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c     |  2 +-
>  drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c          |  2 +-
>  drivers/gpu/drm/amd/powerplay/smumgr/tonga_smc.c            |  2 +-
>  drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c         |  2 +-
>  19 files changed, 27 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gp=
u/drm/amd/powerplay/amd_powerplay.c
> index cc72190..8b85153 100644
> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> @@ -20,6 +20,7 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   *
>   */
> +#include "pp_debug.h"
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/gfp.h>
> @@ -29,7 +30,6 @@
>  #include "pp_instance.h"
>  #include "power_state.h"
>  #include "eventmanager.h"
> -#include "pp_debug.h"
> =20
> =20
>  #define PP_CHECK(handle)						\
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> index 74dbbd1..d043337 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> @@ -20,13 +20,13 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   *
>   */
> +#include "pp_debug.h"
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include "atom-types.h"
>  #include "atombios.h"
>  #include "processpptables.h"
> -#include "pp_debug.h"
>  #include "cgs_common.h"
>  #include "smu/smu_8_0_d.h"
>  #include "smu8_fusion.h"
> @@ -38,7 +38,6 @@
>  #include "cz_hwmgr.h"
>  #include "power_state.h"
>  #include "cz_clockpowergating.h"
> -#include "pp_debug.h"
> =20
>  #define ixSMUSVI_NB_CURRENTVID 0xD8230044
>  #define CURRENT_NB_VID_MASK 0xff000000
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c b/dr=
ivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
> index c355a0f..0eb8e886 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
> @@ -20,11 +20,11 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   *
>   */
> +#include "pp_debug.h"
>  #include <linux/errno.h>
>  #include "hwmgr.h"
>  #include "hardwaremanager.h"
>  #include "power_state.h"
> -#include "pp_debug.h"
> =20
>  #define PHM_FUNC_CHECK(hw) \
>  	do {							\
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/=
drm/amd/powerplay/hwmgr/hwmgr.c
> index b036064..fcfd648 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> @@ -20,6 +20,8 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   *
>   */
> +
> +#include "pp_debug.h"
>  #include "linux/delay.h"
>  #include <linux/types.h>
>  #include <linux/kernel.h>
> @@ -29,7 +31,6 @@
>  #include "power_state.h"
>  #include "hwmgr.h"
>  #include "pppcielanes.h"
> -#include "pp_debug.h"
>  #include "ppatomctrl.h"
>  #include "ppsmc.h"
>  #include "pp_acpi.h"
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c
> index ddaea1d..2c60f7b 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c
> @@ -20,6 +20,7 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   *
>   */
> +#include "pp_debug.h"
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/fb.h>
> @@ -27,7 +28,6 @@
>  #include "ppatomctrl.h"
>  #include "atombios.h"
>  #include "cgs_common.h"
> -#include "pp_debug.h"
>  #include "ppevvmath.h"
> =20
>  #define MEM_ID_MASK           0xff000000
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.=
c b/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
> index 7925185..f2f0fcc 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
> @@ -20,6 +20,7 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   *
>   */
> +#include "pp_debug.h"
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/fb.h>
> @@ -27,7 +28,6 @@
>  #include "process_pptables_v1_0.h"
>  #include "ppatomctrl.h"
>  #include "atombios.h"
> -#include "pp_debug.h"
>  #include "hwmgr.h"
>  #include "cgs_common.h"
>  #include "pptable_v1_0.h"
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c b/dr=
ivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
> index a4e9cf4..ed6c934 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
> @@ -20,6 +20,7 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   *
>   */
> +#include "pp_debug.h"
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> @@ -27,7 +28,6 @@
>  #include "processpptables.h"
>  #include <atom-types.h>
>  #include <atombios.h>
> -#include "pp_debug.h"
>  #include "pptable.h"
>  #include "power_state.h"
>  #include "hwmgr.h"
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> index ae5517a..9dc0e52 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> @@ -20,13 +20,13 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   *
>   */
> +#include "pp_debug.h"
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/fb.h>
>  #include <asm/div64.h>
>  #include "linux/delay.h"
>  #include "pp_acpi.h"
> -#include "pp_debug.h"
>  #include "ppatomctrl.h"
>  #include "atombios.h"
>  #include "pptable_v1_0.h"
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c b/dri=
vers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c
> index 6cd1287..0f2325e 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c
> @@ -20,11 +20,11 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   *
>   */
> +#include "pp_debug.h"
>  #include "hwmgr.h"
>  #include "smumgr.h"
>  #include "smu7_hwmgr.h"
>  #include "smu7_powertune.h"
> -#include "pp_debug.h"
>  #include "smu7_common.h"
> =20
>  #define VOLTAGE_SCALE  4
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h b/drivers/gpu=
/drm/amd/powerplay/inc/pp_debug.h
> index bfdbec1..8301b82 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h
> @@ -24,6 +24,12 @@
>  #ifndef PP_DEBUG_H
>  #define PP_DEBUG_H
> =20
> +#ifdef pr_fmt
> +#undef pr_fmt
> +#endif
> +
> +#define pr_fmt(fmt) "[powerplay] " fmt
> +
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> @@ -31,7 +37,7 @@
>  #define PP_ASSERT_WITH_CODE(cond, msg, code)	\
>  	do {					\
>  		if (!(cond)) {			\
> -			printk("%s\n", msg);	\
> +			pr_warning("%s\n", msg);	\
>  			code;			\
>  		}				\
>  	} while (0)
> @@ -39,7 +45,7 @@
> =20
>  #define PP_DBG_LOG(fmt, ...) \
>  	do { \
> -		if(0)printk(KERN_INFO "[ pp_dbg ] " fmt, ##__VA_ARGS__); \
> +		if(0)pr_info(fmt, ##__VA_ARGS__); \

Just squash the next commit into this one to remove the 'if(0)' cond.

>  	} while (0)
> =20
> =20
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smc.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/fiji_smc.c
> index 6aeb1d2..5d5b8a0 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smc.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smc.c
> @@ -21,13 +21,13 @@
>   *
>   */
> =20
> +#include "pp_debug.h"
>  #include "fiji_smc.h"
>  #include "smu7_dyn_defaults.h"
> =20
>  #include "smu7_hwmgr.h"
>  #include "hardwaremanager.h"
>  #include "ppatomctrl.h"
> -#include "pp_debug.h"
>  #include "cgs_common.h"
>  #include "atombios.h"
>  #include "fiji_smumgr.h"
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drive=
rs/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
> index 26eff56..7a87e5a 100755
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
> @@ -21,6 +21,7 @@
>   *
>   */
> =20
> +#include "pp_debug.h"
>  #include "smumgr.h"
>  #include "smu73.h"
>  #include "smu_ucode_xfer_vi.h"
> @@ -36,7 +37,6 @@
>  #include "gca/gfx_8_0_d.h"
>  #include "bif/bif_5_0_d.h"
>  #include "bif/bif_5_0_sh_mask.h"
> -#include "pp_debug.h"
>  #include "fiji_pwrvirus.h"
>  #include "fiji_smc.h"
> =20
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smc.c b/drive=
rs/gpu/drm/amd/powerplay/smumgr/iceland_smc.c
> index a24971a..ef435f1 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smc.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smc.c
> @@ -21,13 +21,13 @@
>   *
>   */
> =20
> +#include "pp_debug.h"
>  #include "iceland_smc.h"
>  #include "smu7_dyn_defaults.h"
> =20
>  #include "smu7_hwmgr.h"
>  #include "hardwaremanager.h"
>  #include "ppatomctrl.h"
> -#include "pp_debug.h"
>  #include "cgs_common.h"
>  #include "atombios.h"
>  #include "pppcielanes.h"
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/dr=
ivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
> index eeafefc..1fde30d 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
> @@ -22,6 +22,7 @@
>   * Author: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
>   *
>   */
> +#include "pp_debug.h"
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> @@ -29,7 +30,6 @@
> =20
>  #include "smumgr.h"
>  #include "iceland_smumgr.h"
> -#include "pp_debug.h"
>  #include "smu_ucode_xfer_vi.h"
>  #include "ppsmc.h"
>  #include "smu/smu_7_1_1_d.h"
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c b/dri=
vers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c
> index 5190e82..c2889b5 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c
> @@ -21,13 +21,13 @@
>   *
>   */
> =20
> +#include "pp_debug.h"
>  #include "polaris10_smc.h"
>  #include "smu7_dyn_defaults.h"
> =20
>  #include "smu7_hwmgr.h"
>  #include "hardwaremanager.h"
>  #include "ppatomctrl.h"
> -#include "pp_debug.h"
>  #include "cgs_common.h"
>  #include "atombios.h"
>  #include "polaris10_smumgr.h"
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/=
drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> index f38a687..7e1e330 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> @@ -21,6 +21,7 @@
>   *
>   */
> =20
> +#include "pp_debug.h"
>  #include "smumgr.h"
>  #include "smu74.h"
>  #include "smu_ucode_xfer_vi.h"
> @@ -36,7 +37,6 @@
>  #include "bif/bif_5_0_sh_mask.h"
>  #include "polaris10_pwrvirus.h"
>  #include "ppatomctrl.h"
> -#include "pp_debug.h"
>  #include "cgs_common.h"
>  #include "polaris10_smc.h"
>  #include "smu7_ppsmc.h"
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drive=
rs/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
> index f49b548..d0a77be 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
> @@ -22,12 +22,12 @@
>   */
> =20
> =20
> +#include "pp_debug.h"
>  #include "smumgr.h"
>  #include "smu_ucode_xfer_vi.h"
>  #include "smu/smu_7_1_3_d.h"
>  #include "smu/smu_7_1_3_sh_mask.h"
>  #include "ppatomctrl.h"
> -#include "pp_debug.h"
>  #include "cgs_common.h"
>  #include "smu7_ppsmc.h"
>  #include "smu7_smumgr.h"
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smc.c b/drivers=
/gpu/drm/amd/powerplay/smumgr/tonga_smc.c
> index 2e1493c..93bfb19 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smc.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smc.c
> @@ -21,13 +21,13 @@
>   *
>   */
> =20
> +#include "pp_debug.h"
>  #include "tonga_smc.h"
>  #include "smu7_dyn_defaults.h"
> =20
>  #include "smu7_hwmgr.h"
>  #include "hardwaremanager.h"
>  #include "ppatomctrl.h"
> -#include "pp_debug.h"
>  #include "cgs_common.h"
>  #include "atombios.h"
>  #include "tonga_smumgr.h"
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/driv=
ers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
> index eff9a232..d0aef72 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
> @@ -20,6 +20,7 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   *
>   */
> +#include "pp_debug.h"
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> @@ -27,7 +28,6 @@
> =20
>  #include "smumgr.h"
>  #include "tonga_smumgr.h"
> -#include "pp_debug.h"
>  #include "smu_ucode_xfer_vi.h"
>  #include "tonga_ppsmc.h"
>  #include "smu/smu_7_1_2_d.h"
>=20


--cnCFeL6iq0rjwP6iITJpSjQIU4hSso3TQ--

--rP9OIiXH4WWCvAKqCrMNLn2UJ7axaSo6A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYXO9KAAoJEP4bvbfZuWjbVVIQAKt9fS+MvR4+6Q1D7VAxzXy0
XiqK5Axa/+ssMKFEwdmt3tcAX33uZWzjlsDi3wIkDgCEM4NFQWL68o48o2rx8Toy
Kr81AWKaP5lcW+KdxR0x5/eoyy53QsHspIEHBNlFq0YkBSBNs33mnUrSKA1OlET6
N9ccWh+s5vnv+VfkWCoTz413dilDI+nUNgGmGWSPYYlVW+vAZSVmQ2FplExW2rkf
ybcgPJPRYI+61UpR+kM0fqHvV2TL0ys/hLdckvVWH3ya/8/0ljkzVk05U1toff4e
YUA+4etrxNN5mJSAaDo3JfGO0bYM1MCvxp3s/kGGeLDGXO7V9YtaRxk96h5EGM/G
q72m1s+ixl82tVmgJsQ5XINJNY087Xvtm2OIUTKAcehb2drXDI+9SklKRHjThOzN
HeLJ6fm5O4oRV9jh4hYHKPqdB4riiR/yeMnHqIIBQiVrxVlxGsnRHHW4D6plpv0A
7ZuQuhoDyK3R01RaFDuNjlN6+IQSZiBED9gvbBxCQgw7jOGu+YqmMOFfFNvY4TH2
FuW5D9rRxeCEVe09ZutpNkE2cuuBn8CjsTciK5XTSRK3HQnHObBX+8jlgukz+rvq
U6ihCWBosd7SjvEcnnmNDcAfXM9oWN2XIK3FS1EjSmNWxM6SQICL9mo6nBoC4FIu
Sb4zNvAJZeTUTyzlwxWf
=Ov9r
-----END PGP SIGNATURE-----

--rP9OIiXH4WWCvAKqCrMNLn2UJ7axaSo6A--

--===============0082317980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0082317980==--
