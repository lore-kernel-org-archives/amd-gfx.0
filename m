From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: add prefix for all powerplay pr_*
 prints
Date: Fri, 23 Dec 2016 20:59:15 +1100
Message-ID: <7f5e9c3e-68d0-0e26-2e2f-2aba1104818a@folklore1984.net>
References: <1482461108-8463-1-git-send-email-ray.huang@amd.com>
 <a4500215-e3d3-fd84-2444-f028241f6c4a@folklore1984.net>
 <20161223095408.GA11638@hr-amur2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1089418020=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161223095408.GA11638@hr-amur2>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Nath,
 Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1089418020==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AVoptVKsih1s2TWAfWqsLp7PK6PavhnCO"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AVoptVKsih1s2TWAfWqsLp7PK6PavhnCO
Content-Type: multipart/mixed; boundary="86OUua7V6SDTLxt2OEsHG0VbKl6ibG4fT";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>,
 "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>,
 "Nath, Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>
Message-ID: <7f5e9c3e-68d0-0e26-2e2f-2aba1104818a-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: add prefix for all powerplay pr_*
 prints
References: <1482461108-8463-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
 <a4500215-e3d3-fd84-2444-f028241f6c4a-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
 <20161223095408.GA11638@hr-amur2>
In-Reply-To: <20161223095408.GA11638@hr-amur2>

--86OUua7V6SDTLxt2OEsHG0VbKl6ibG4fT
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 12/23/2016 08:54 PM, Huang Rui wrote:
> On Fri, Dec 23, 2016 at 05:32:58PM +0800, Edward O'Callaghan wrote:
>> Hi,
>>
>> I would say drop all the header relocation churn, it distracts away fr=
om
>> the functional changes in this commit. Also see inline comments.
>>
>=20
> Yes, if double check undef, it needn't move macro before <linux/xxx.h>

If you want to reshuffle headers I would say that is a seperate patch
and the functional changes as their own changeset. That's my view any way=
=2E

>=20
>> With those fixes,
>> Acked-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
>>
>> Kindest Regards,
>> Edward.
>>
>> On 12/23/2016 01:45 PM, Huang Rui wrote:
>>> Powerplay will be used them instead of raw printk, and we can dynamic=

>>> change the debug level with it.
>>>
>>> The prefix is like below:
>>>
>>> [  197.755167] [powerplay] amdgpu: powerplay initialized
>>
>> Ideally I think it would be better to look like this:
>>
>> [  xxx.xxxxxx ] amdgpu: [powerplay] initialized.
>>
>> but certainly drop repeating "powerplay" twice..
>>
>=20
> We define it as below:=20
>=20
> #define pr_fmt(fmt) "amdgpu: [powerplay] " fmt
>=20
> But we need refine most detail prints message with more patches in the
> codes.

I suggest if your going to touch it you may as well go all the way and
get the thing fixed up properly, then its done.

>=20
>>>
>>> Suggested-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
>>> Cc: Arindam Nath <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>  drivers/gpu/drm/amd/powerplay/amd_powerplay.c               |  2 +-
>>>  drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c              |  3 +--=

>>>  drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c       |  2 +-
>>>  drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c                 |  3 ++-=

>>>  drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c            |  2 +-
>>>  drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c |  2 +-
>>>  drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c       |  2 +-
>>>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c            |  2 +-
>>>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c        |  2 +-
>>>  drivers/gpu/drm/amd/powerplay/inc/pp_debug.h                | 10 +++=
+++++--
>>>  drivers/gpu/drm/amd/powerplay/smumgr/fiji_smc.c             |  2 +-
>>>  drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c          |  2 +-
>>>  drivers/gpu/drm/amd/powerplay/smumgr/iceland_smc.c          |  2 +-
>>>  drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c       |  2 +-
>>>  drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c        |  2 +-
>>>  drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c     |  2 +-
>>>  drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c          |  2 +-
>>>  drivers/gpu/drm/amd/powerplay/smumgr/tonga_smc.c            |  2 +-
>>>  drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c         |  2 +-
>>>  19 files changed, 27 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/=
gpu/drm/amd/powerplay/amd_powerplay.c
>>> index cc72190..8b85153 100644
>>> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>>> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>>> @@ -20,6 +20,7 @@
>>>   * OTHER DEALINGS IN THE SOFTWARE.
>>>   *
>>>   */
>>> +#include "pp_debug.h"
>>>  #include <linux/types.h>
>>>  #include <linux/kernel.h>
>>>  #include <linux/gfp.h>
>>> @@ -29,7 +30,6 @@
>>>  #include "pp_instance.h"
>>>  #include "power_state.h"
>>>  #include "eventmanager.h"
>>> -#include "pp_debug.h"
>>> =20
>>> =20
>>>  #define PP_CHECK(handle)						\
>>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
>>> index 74dbbd1..d043337 100644
>>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
>>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
>>> @@ -20,13 +20,13 @@
>>>   * OTHER DEALINGS IN THE SOFTWARE.
>>>   *
>>>   */
>>> +#include "pp_debug.h"
>>>  #include <linux/types.h>
>>>  #include <linux/kernel.h>
>>>  #include <linux/slab.h>
>>>  #include "atom-types.h"
>>>  #include "atombios.h"
>>>  #include "processpptables.h"
>>> -#include "pp_debug.h"
>>>  #include "cgs_common.h"
>>>  #include "smu/smu_8_0_d.h"
>>>  #include "smu8_fusion.h"
>>> @@ -38,7 +38,6 @@
>>>  #include "cz_hwmgr.h"
>>>  #include "power_state.h"
>>>  #include "cz_clockpowergating.h"
>>> -#include "pp_debug.h"
>>> =20
>>>  #define ixSMUSVI_NB_CURRENTVID 0xD8230044
>>>  #define CURRENT_NB_VID_MASK 0xff000000
>>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c b/=
drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
>>> index c355a0f..0eb8e886 100644
>>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
>>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
>>> @@ -20,11 +20,11 @@
>>>   * OTHER DEALINGS IN THE SOFTWARE.
>>>   *
>>>   */
>>> +#include "pp_debug.h"
>>>  #include <linux/errno.h>
>>>  #include "hwmgr.h"
>>>  #include "hardwaremanager.h"
>>>  #include "power_state.h"
>>> -#include "pp_debug.h"
>>> =20
>>>  #define PHM_FUNC_CHECK(hw) \
>>>  	do {							\
>>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gp=
u/drm/amd/powerplay/hwmgr/hwmgr.c
>>> index b036064..fcfd648 100644
>>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
>>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
>>> @@ -20,6 +20,8 @@
>>>   * OTHER DEALINGS IN THE SOFTWARE.
>>>   *
>>>   */
>>> +
>>> +#include "pp_debug.h"
>>>  #include "linux/delay.h"
>>>  #include <linux/types.h>
>>>  #include <linux/kernel.h>
>>> @@ -29,7 +31,6 @@
>>>  #include "power_state.h"
>>>  #include "hwmgr.h"
>>>  #include "pppcielanes.h"
>>> -#include "pp_debug.h"
>>>  #include "ppatomctrl.h"
>>>  #include "ppsmc.h"
>>>  #include "pp_acpi.h"
>>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c b/drive=
rs/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c
>>> index ddaea1d..2c60f7b 100644
>>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c
>>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c
>>> @@ -20,6 +20,7 @@
>>>   * OTHER DEALINGS IN THE SOFTWARE.
>>>   *
>>>   */
>>> +#include "pp_debug.h"
>>>  #include <linux/module.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/fb.h>
>>> @@ -27,7 +28,6 @@
>>>  #include "ppatomctrl.h"
>>>  #include "atombios.h"
>>>  #include "cgs_common.h"
>>> -#include "pp_debug.h"
>>>  #include "ppevvmath.h"
>>> =20
>>>  #define MEM_ID_MASK           0xff000000
>>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_=
0.c b/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
>>> index 7925185..f2f0fcc 100644
>>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
>>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
>>> @@ -20,6 +20,7 @@
>>>   * OTHER DEALINGS IN THE SOFTWARE.
>>>   *
>>>   */
>>> +#include "pp_debug.h"
>>>  #include <linux/module.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/fb.h>
>>> @@ -27,7 +28,6 @@
>>>  #include "process_pptables_v1_0.h"
>>>  #include "ppatomctrl.h"
>>>  #include "atombios.h"
>>> -#include "pp_debug.h"
>>>  #include "hwmgr.h"
>>>  #include "cgs_common.h"
>>>  #include "pptable_v1_0.h"
>>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c b/=
drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
>>> index a4e9cf4..ed6c934 100644
>>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
>>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
>>> @@ -20,6 +20,7 @@
>>>   * OTHER DEALINGS IN THE SOFTWARE.
>>>   *
>>>   */
>>> +#include "pp_debug.h"
>>>  #include <linux/types.h>
>>>  #include <linux/kernel.h>
>>>  #include <linux/slab.h>
>>> @@ -27,7 +28,6 @@
>>>  #include "processpptables.h"
>>>  #include <atom-types.h>
>>>  #include <atombios.h>
>>> -#include "pp_debug.h"
>>>  #include "pptable.h"
>>>  #include "power_state.h"
>>>  #include "hwmgr.h"
>>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drive=
rs/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>>> index ae5517a..9dc0e52 100644
>>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>>> @@ -20,13 +20,13 @@
>>>   * OTHER DEALINGS IN THE SOFTWARE.
>>>   *
>>>   */
>>> +#include "pp_debug.h"
>>>  #include <linux/module.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/fb.h>
>>>  #include <asm/div64.h>
>>>  #include "linux/delay.h"
>>>  #include "pp_acpi.h"
>>> -#include "pp_debug.h"
>>>  #include "ppatomctrl.h"
>>>  #include "atombios.h"
>>>  #include "pptable_v1_0.h"
>>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c b/d=
rivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c
>>> index 6cd1287..0f2325e 100644
>>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c
>>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c
>>> @@ -20,11 +20,11 @@
>>>   * OTHER DEALINGS IN THE SOFTWARE.
>>>   *
>>>   */
>>> +#include "pp_debug.h"
>>>  #include "hwmgr.h"
>>>  #include "smumgr.h"
>>>  #include "smu7_hwmgr.h"
>>>  #include "smu7_powertune.h"
>>> -#include "pp_debug.h"
>>>  #include "smu7_common.h"
>>> =20
>>>  #define VOLTAGE_SCALE  4
>>> diff --git a/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h b/drivers/g=
pu/drm/amd/powerplay/inc/pp_debug.h
>>> index bfdbec1..8301b82 100644
>>> --- a/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h
>>> +++ b/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h
>>> @@ -24,6 +24,12 @@
>>>  #ifndef PP_DEBUG_H
>>>  #define PP_DEBUG_H
>>> =20
>>> +#ifdef pr_fmt
>>> +#undef pr_fmt
>>> +#endif
>>> +
>>> +#define pr_fmt(fmt) "[powerplay] " fmt
>>> +
>>>  #include <linux/types.h>
>>>  #include <linux/kernel.h>
>>>  #include <linux/slab.h>
>>> @@ -31,7 +37,7 @@
>>>  #define PP_ASSERT_WITH_CODE(cond, msg, code)	\
>>>  	do {					\
>>>  		if (!(cond)) {			\
>>> -			printk("%s\n", msg);	\
>>> +			pr_warning("%s\n", msg);	\
>>>  			code;			\
>>>  		}				\
>>>  	} while (0)
>>> @@ -39,7 +45,7 @@
>>> =20
>>>  #define PP_DBG_LOG(fmt, ...) \
>>>  	do { \
>>> -		if(0)printk(KERN_INFO "[ pp_dbg ] " fmt, ##__VA_ARGS__); \
>>> +		if(0)pr_info(fmt, ##__VA_ARGS__); \
>>
>> Just squash the next commit into this one to remove the 'if(0)' cond.
>>
>=20
> Actually, this patch just adds prefix. "remove 'if(0)'" is another
> behavior even it's minor change.
>=20
> Anyway, I am fine to squash it.

Yes, just to make clear - squash it with the other functional change as
they are interdependent and keep the pure header churn as a separate patc=
h.

>=20
> Thanks,
> Rui
>=20

Cheers,
Edward.


--86OUua7V6SDTLxt2OEsHG0VbKl6ibG4fT--

--AVoptVKsih1s2TWAfWqsLp7PK6PavhnCO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYXPVzAAoJEP4bvbfZuWjb1XYP/j4k8iYl3alQX2qfljyItPDY
J5tcciXwWFIyq3hYvEcPez+mN72aAZ1dLc4DqPgcHbEkSuYqA7Y/t+IkK9HSL15T
jykhirVv+XRvblBN8qaw+ebA31tDxCX/nyA+k0MzQYO7aycQEhv/QQ7630oYIiNy
eBaPKiZGq2lp8GXn9z9fnViCwjFUJ3yPZMiTJKk/AjsLGaU6wUE3CCQKqM7MpHrS
2wjHGnGzlP0L9VcGnI37mgT8xVa2lj8B7R8+02qf/XfgUXzdmqViwIyEILmsg/DB
XB81SzYwA5EEuoeYsDw/ZPABTvla9U48cVHR/YqkUMA3zI0ZBGRma9OrZ/zW6NvS
/A3kD/vXDfk5VLT9IZeKS4SvtRkUN57TjV6sTwxT/nP77AxsHR87xmfUwyIqq3l5
ag69AdJr/GF53ReXqF7QIdbAZNc1PIEW+zq6O1kElVzF0hBaEe/MyISoRLfaAaY8
wmLvoApgxuFxPOwVexNm/0ofbjYNKrGWEJhTVNMhCX/d6jmSqmePbAs+mRU7kHvu
QMLZonXU1s2XoBcDvm/y546CM0LkfjkG0IejNtCilCzH3hMf/ZsnqJSNN1JBiKnI
Vcr+DGjkpzrWN4OMH/hU+Oss3wZxwunbLw/0wr88W1b2QowlT2x/ocbh/Dll931q
EUAQtIrn0FnXN4YUSebH
=W+o2
-----END PGP SIGNATURE-----

--AVoptVKsih1s2TWAfWqsLp7PK6PavhnCO--

--===============1089418020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1089418020==--
