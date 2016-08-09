From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Change the virtual_display type from int to
 char*.
Date: Tue, 9 Aug 2016 13:54:16 +1000
Message-ID: <9f669359-5f58-6f91-5a3c-ef0e780a7970@folklore1984.net>
References: <1470714427-1930-1-git-send-email-Emily.Deng@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0498847565=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1470714427-1930-1-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>
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
To: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0498847565==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XTA4S2HsNalSHihhPvi447l1RiOeVnFrh"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XTA4S2HsNalSHihhPvi447l1RiOeVnFrh
Content-Type: multipart/mixed; boundary="TLRxKhbc9QrcinDncbr3Ui42bmd26sBMd"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <9f669359-5f58-6f91-5a3c-ef0e780a7970-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Change the virtual_display type from int to
 char*.
References: <1470714427-1930-1-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1470714427-1930-1-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>

--TLRxKhbc9QrcinDncbr3Ui42bmd26sBMd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/09/2016 01:47 PM, Emily Deng wrote:
> For virtual display feature, as there may be mutiple GPUs,
> for user could choose whiche GPU need to enable this feature, change
> the type of virtual_display from int to char*. The variable will be set=

> like this virtual_display=3D"xx:xx.x;xx:xx.x;".
>=20
> Signed-off-by: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 ++++++++++++++++++++++=
+++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/cik.c           |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vi.c            |  2 +-
>  5 files changed, 37 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> index c309eaf..b6bed4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -93,7 +93,7 @@ extern unsigned amdgpu_pcie_lane_cap;
>  extern unsigned amdgpu_cg_mask;
>  extern unsigned amdgpu_pg_mask;
>  extern int amdgpu_sclk_deep_sleep_en;
> -extern int amdgpu_virtual_display;
> +extern char *amdgpu_virtual_display;
> =20
>  #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
>  #define AMDGPU_MAX_USEC_TIMEOUT			100000	/* 100 ms */
> @@ -2142,6 +2142,7 @@ struct amdgpu_device {
>  	struct kfd_dev          *kfd;
> =20
>  	struct amdgpu_virtualization virtualization;
> +	int enable_virtual_display;
>  };
> =20
>  bool amdgpu_device_is_px(struct drm_device *dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> index 68cce12..62efe14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -47,6 +47,7 @@
>  #endif
>  #include "vi.h"
>  #include "bif/bif_4_1_d.h"
> +#include <linux/pci.h>
> =20
>  static int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
>  static void amdgpu_debugfs_regs_cleanup(struct amdgpu_device *adev);
> @@ -1182,11 +1183,39 @@ int amdgpu_ip_block_version_cmp(struct amdgpu_d=
evice *adev,
>  	return 1;
>  }
> =20
> +static void amdgpu_whether_enable_virtual_display(struct amdgpu_device=
 *adev)
> +{
> +	adev->enable_virtual_display =3D 0;
> +
> +	if (amdgpu_virtual_display) {
> +		char pci_address_name[8];
> +		char *pciaddstr, *pciaddstr_tmp, *pciaddname;
> +		struct drm_device *ddev =3D adev->ddev;
> +
> +		sprintf(pci_address_name, "%02x:%02x.%d", ddev->pdev->bus->number,
> +			PCI_SLOT(ddev->pdev->devfn), PCI_FUNC(ddev->pdev->devfn));
> +
> +		pciaddstr =3D kstrdup(amdgpu_virtual_display, GFP_KERNEL);
> +		pciaddstr_tmp =3D pciaddstr;
> +		while ((pciaddname =3D strsep(&pciaddstr_tmp, ";"))) {
> +			if (!strncmp(pci_address_name, pciaddname, sizeof(pci_address_name)=
)) {
> +				adev->enable_virtual_display =3D 1;
> +				break;
> +			}
> +		}
> +
> +		DRM_INFO("virtual display string:%s, %s:virtual_display:%d\n", amdgp=
u_virtual_display, pci_address_name, adev->enable_virtual_display);
> +
> +		if(pciaddstr)
> +			kfree(pciaddstr);
kfree() should be NULL-safe so no need for the branch.

Kind Regards,
Edward.

> +	}
> +}
> +
>  static int amdgpu_early_init(struct amdgpu_device *adev)
>  {
>  	int i, r;
> =20
> -	DRM_INFO("virtual display enabled:%d\n", amdgpu_virtual_display);
> +	amdgpu_whether_enable_virtual_display(adev);
> =20
>  	switch (adev->asic_type) {
>  	case CHIP_TOPAZ:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> index 7007cf7..4202602 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -90,7 +90,7 @@ unsigned amdgpu_pcie_gen_cap =3D 0;
>  unsigned amdgpu_pcie_lane_cap =3D 0;
>  unsigned amdgpu_cg_mask =3D 0xffffffff;
>  unsigned amdgpu_pg_mask =3D 0xffffffff;
> -int amdgpu_virtual_display =3D 0;
> +char *amdgpu_virtual_display =3D NULL;
> =20
>  MODULE_PARM_DESC(vramlimit, "Restrict VRAM for testing, in megabytes")=
;
>  module_param_named(vramlimit, amdgpu_vram_limit, int, 0600);
> @@ -190,8 +190,8 @@ module_param_named(cg_mask, amdgpu_cg_mask, uint, 0=
444);
>  MODULE_PARM_DESC(pg_mask, "Powergating flags mask (0 =3D disable power=
 gating)");
>  module_param_named(pg_mask, amdgpu_pg_mask, uint, 0444);
> =20
> -MODULE_PARM_DESC(virtual_display, "enable virtual display (0 =3D disab=
le virtual display)");
> -module_param_named(virtual_display, amdgpu_virtual_display, int, 0444)=
;
> +MODULE_PARM_DESC(virtual_display, "Enable virtual display feature (the=
 virtual_display will be set like xx:xx.x;xx:xx.x)");
> +module_param_named(virtual_display, amdgpu_virtual_display, charp, 044=
4);
> =20
>  static const struct pci_device_id pciidlist[] =3D {
>  #ifdef CONFIG_DRM_AMDGPU_CIK
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amd=
gpu/cik.c
> index 4b48bcd..c97d700 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -2464,7 +2464,7 @@ static const struct amdgpu_ip_block_version kaver=
i_ip_blocks_vd[] =3D
> =20
>  int cik_set_ip_blocks(struct amdgpu_device *adev)
>  {
> -	if (amdgpu_virtual_display) {
> +	if (adev->enable_virtual_display) {
>  		amdgpu_dal =3D 0;
>  		adev->mode_info.vsync_timer_enabled =3D AMDGPU_IRQ_STATE_DISABLE;
>  		switch (adev->asic_type) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdg=
pu/vi.c
> index 4afa053..1e973b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -1676,7 +1676,7 @@ static const struct amdgpu_ip_block_version fiji_=
ip_blocks_dal[] =3D
> =20
>  int vi_set_ip_blocks(struct amdgpu_device *adev)
>  {
> -	if (amdgpu_virtual_display) {
> +	if (adev->enable_virtual_display) {
>  		amdgpu_dal =3D 0;
>  		adev->mode_info.vsync_timer_enabled =3D AMDGPU_IRQ_STATE_DISABLE;
>  		switch (adev->asic_type) {
>=20


--TLRxKhbc9QrcinDncbr3Ui42bmd26sBMd--

--XTA4S2HsNalSHihhPvi447l1RiOeVnFrh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXqVPoAAoJEP4bvbfZuWjbuYEQAKxroaLZNxhtkDrGzEJwTeNa
W+hCbrz24RBO9qg0CbFA0umgXa68OMWXk84WcWWhKajHHBdgTfr/otRi2wYtXN+0
KYZzL7kmWIqKFu3zqVs8ZUatL+kFl++Ai2oaTJQq+qyXvkD4twJPKbYnxcLYlFQI
rL3FUsMVxmh/FPRx5c1MFsTJsW/wkm5n2L9iOIcH0tXRZw4QMtoNIMBoSTetD8M0
4ZptFY9+BvIN++72GyZGIzIPAdbzsRC8nI5wVO9wvpQs16zAz6jgEuHnc6+DpOuu
oYvhZKtCJiVMl2inBAuVbCIWsB3/3h1omInBjGBK6+fPt2rEBpsza4MWzkDR+UXL
mNWx5y2pWPpXF+OjSorTT8raL00bbh02MNLd6mM/I3HIm1RMCZR1DrOCtHF3njmr
ii+j5MOvBDL+JIzdKhEyhoKnUwiWlBKl0FspbU2BHXCVH1IE3DYzL2mc6Utb6CUt
X2kKa/Ykb8RMczhUKLPJsSBCuCQOGmLfdkL5nk04vGpKXXbHUWHacVnNSdq48MsN
oACBqvS5Lk6hoPU205yInXAQv/0pPZ87eyeWtpjBiGmCrAHKQGUpHuAEpYMq3BNA
xtlRP6pdSGh8a2aVWy1xY3YOagwOS6TWUbXIXaCKgsF9f64yooMmeTvUMbjgNF0c
kqRkE87lD8JE7Sn9NtNo
=A9bf
-----END PGP SIGNATURE-----

--XTA4S2HsNalSHihhPvi447l1RiOeVnFrh--

--===============0498847565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0498847565==--
