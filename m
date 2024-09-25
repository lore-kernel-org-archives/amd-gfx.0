Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FD1CCF9E6
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 15:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85FD310E263;
	Wed, 25 Sep 2024 15:46:51 +0000 (UTC)
X-Greylist: delayed 401 seconds by postgrey-1.36 at gabe;
 Wed, 25 Sep 2024 15:46:50 UTC
Received: from mail.bix.bg (mail.bix.bg [193.105.196.21])
 by gabe.freedesktop.org (Postfix) with SMTP id 6069810E263
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 15:46:50 +0000 (UTC)
Received: (qmail 14488 invoked from network); 25 Sep 2024 15:40:08 -0000
Received: from d2.declera.com (212.116.131.122)
 by indigo.declera.com with SMTP; 25 Sep 2024 15:40:08 -0000
Message-ID: <9c91d15357e30fb41af9f54fe85da5bb7d0d79a3.camel@declera.com>
Subject: 6.12-rc0/regression/bisected  - 9c081c11c621 drm/amdgpu: Reorder to
 read EFI exported ROM first - breaks connector enumeration and discovery
From: Yanko Kaneti <yaneti@declera.com>
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, 
 amd-gfx@lists.freedesktop.org
Date: Wed, 25 Sep 2024 18:40:08 +0300
In-Reply-To: <20240812044942.1670218-1-lijo.lazar@amd.com>
References: <20240812044942.1670218-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 (3.54.0-1.fc42) 
MIME-Version: 1.0
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello,

This commit in mainline (9c081c11c621) breaks connector enumeration and
discovery for me here so my  PC->HDMI-to-DP->monitor stops showing
anything after amdgpu starts.   Fedora rawhide 6.12 pre rc0 kernels.

There is some
  ...
  amdgpu 0000:0e:00.0: amdgpu: Fetched VBIOS from platform
  amdgpu: ATOM BIOS: 13-CEZANNE-019
  ...
  ... UBSAN splat ....
  kernel: UBSAN: array-index-out-of-bounds in drivers/gpu/drm/amd/amdgpu/..=
/display/dc/resource/dcn21/dcn21_resource.c:1312:29
  ....
  kernel: [drm:amdgpu_dm_init [amdgpu]] *ERROR* KMS: Failed to detect conne=
ctor
 =20

Reverting the commit on top of mainline restores the video situation to
normal. Without the UBSAN splat showing up.

  amdgpu 0000:0e:00.0: amdgpu: Fetched VBIOS from ROM BAR
  amdgpu: ATOM BIOS: 13-CEZANNE-019
  ...=20
 =20

  Ryzen 7 5700G  IGP
  Advanced Micro Devices, Inc. [AMD/ATI] Cezanne [Radeon Vega Series / Rade=
on Vega Mobile Series] [1002:1638] (rev c8) (prog-if 00 [VGA controller])
  Fairly old Gigabyte MB , but with BIOS from March this year.

Regards
- Yanko

On Mon, 2024-08-12 at 10:19 +0530, Lijo Lazar wrote:
> On EFI BIOSes, PCI ROM may be exported through EFI_PCI_IO_PROTOCOL and
> expansion ROM BARs may not be enabled. Choose to read from EFI exported
> ROM data before reading PCI Expansion ROM BAR.
>=20
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index 618e469e3622..42e64bce661e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -431,6 +431,11 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
>  		goto success;
>  	}
> =20
> +	if (amdgpu_read_platform_bios(adev)) {
> +		dev_info(adev->dev, "Fetched VBIOS from platform\n");
> +		goto success;
> +	}
> +
>  	if (amdgpu_read_bios(adev)) {
>  		dev_info(adev->dev, "Fetched VBIOS from ROM BAR\n");
>  		goto success;
> @@ -446,11 +451,6 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
>  		goto success;
>  	}
> =20
> -	if (amdgpu_read_platform_bios(adev)) {
> -		dev_info(adev->dev, "Fetched VBIOS from platform\n");
> -		goto success;
> -	}
> -
>  	dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
>  	return false;
> =20

