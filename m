Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE6DCA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 21:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F39410E494;
	Tue, 12 Aug 2025 21:29:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="p2CyLkbx";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5A2410E494
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 21:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zWGbmhnnxdfSjCiaSbTBJNNpuFgVDvhe4wSZDmdhunE=; b=p2CyLkbxFvODNIKK/OxdggzB4+
 swpJ8lRXIblMIP0X9Q+e+xbljfRp/WfaAxyryeLBGuxiYS0VYdoT8AVLFa7NWcYFPotmcQBRWUS/Z
 V32UTC61/ZsUgBon7gO+i1Nnek11opVTfflCR9G6lEFl7jCWqYNSeJvNkB0NdzqWL55Q2W9bEW6xD
 7ii5SadmiHfgsNO2RQwDuk1CIidKHBEnj+SERRh6QJbTBNT+I0jUTRrt+8iqWt2l9EO4RftlI3Rvz
 XUZUHlAodLG+dUSmMObUKbShIzIBUNm0LM1ozLKHBWDe5K2clYiLS/jAaaFZCei3XoSssa2zomYmX
 Sabn6oRQ==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ulwYi-00DPPX-5y; Tue, 12 Aug 2025 23:29:28 +0200
Date: Tue, 12 Aug 2025 15:29:25 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: Re: [PATCH 3/3] drm/amd/display: Don't use non-registered VUPDATE on
 DCE 6
Message-ID: <bz5wbngg4aub2cuhh2upoiiwwl2kpagn3ar5pamftuhrr5auho@356jpekmh34k>
References: <20250802160602.12698-1-timur.kristof@gmail.com>
 <20250802160602.12698-4-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250802160602.12698-4-timur.kristof@gmail.com>
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

On 08/02, Timur Krist=F3f wrote:
> The VUPDATE interrupt isn't registered on DCE 6, so don't try
> to use that.
>=20
> This fixes a page flip timeout after sleep/resume on DCE 6.
>=20
> Signed-off-by: Timur Krist=F3f <timur.kristof@gmail.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++++++++++-------
>  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 16 ++++++++------
>  2 files changed, 23 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 470f831a17f7..e8d2ba58cbfa 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2981,14 +2981,20 @@ static void dm_gpureset_toggle_interrupts(struct =
amdgpu_device *adev,
>  				drm_warn(adev_to_drm(adev), "Failed to %s pflip interrupts\n",
>  					 enable ? "enable" : "disable");
> =20
> -			if (enable) {
> -				if (amdgpu_dm_crtc_vrr_active(to_dm_crtc_state(acrtc->base.state)))
> -					rc =3D amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, true);
> -			} else
> -				rc =3D amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, false);
> -
> -			if (rc)
> -				drm_warn(adev_to_drm(adev), "Failed to %sable vupdate interrupt\n", =
enable ? "en" : "dis");
> +			if (dc_supports_vrr(adev->dm.dc->ctx->dce_version)) {
> +				if (enable) {
> +					if (amdgpu_dm_crtc_vrr_active(
> +							to_dm_crtc_state(acrtc->base.state)))
> +						rc =3D amdgpu_dm_crtc_set_vupdate_irq(
> +							&acrtc->base, true);
> +				} else
> +					rc =3D amdgpu_dm_crtc_set_vupdate_irq(
> +							&acrtc->base, false);
> +
> +				if (rc)
> +					drm_warn(adev_to_drm(adev), "Failed to %sable vupdate interrupt\n",
> +						enable ? "en" : "dis");
> +			}
> =20
>  			irq_source =3D IRQ_TYPE_VBLANK + acrtc->otg_inst;
>  			/* During gpu-reset we disable and then enable vblank irq, so
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 2551823382f8..f2208e4224f9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -298,13 +298,15 @@ static inline int amdgpu_dm_crtc_set_vblank(struct =
drm_crtc *crtc, bool enable)
> =20
>  	irq_type =3D amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
> =20
> -	if (enable) {
> -		/* vblank irq on -> Only need vupdate irq in vrr mode */
> -		if (amdgpu_dm_crtc_vrr_active(acrtc_state))
> -			rc =3D amdgpu_dm_crtc_set_vupdate_irq(crtc, true);
> -	} else {
> -		/* vblank irq off -> vupdate irq off */
> -		rc =3D amdgpu_dm_crtc_set_vupdate_irq(crtc, false);
> +	if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
> +		if (enable) {
> +			/* vblank irq on -> Only need vupdate irq in vrr mode */
> +			if (amdgpu_dm_crtc_vrr_active(acrtc_state))
> +				rc =3D amdgpu_dm_crtc_set_vupdate_irq(crtc, true);
> +		} else {
> +			/* vblank irq off -> vupdate irq off */
> +			rc =3D amdgpu_dm_crtc_set_vupdate_irq(crtc, false);
> +		}
>  	}
> =20
>  	if (rc)
> --=20
> 2.50.1
>

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>=20

--=20
Rodrigo Siqueira
