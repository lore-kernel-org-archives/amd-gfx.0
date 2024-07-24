Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0524C3DA7E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 12:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C749F10E6B7;
	Wed, 24 Jul 2024 12:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.b="eQLcikd+";
	dkim-atps=neutral
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 473A610E00A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 05:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
 s=mail; t=1721800579;
 bh=LwvjsL6ik/ORapD53n5eIjOhKG7iQAHh4Rj2y1jM9pI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eQLcikd+ohLgpu3/ZDiZWKRm1UfHN8sDcI7rSkBWjZ9v6dv0d7VWNyUoqAyJYsCB6
 HsVJsE50mh0rFxDXRa84xfktOQYFlY4V6GnHsrTAPGj88SYnIW1o4jMk5tQOy3T8sQ
 uRkgmzN9kIOkeZBtVAf4clz0Zp+V62AXqVAhUYLk=
Date: Wed, 24 Jul 2024 07:56:19 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/2 V2] drm/amdgpu: properly handle vbios fake edid sizing
Message-ID: <33dc68e7-42d8-461f-a845-f2fae95f9037@t-8ch.de>
References: <20240723205121.2412168-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240723205121.2412168-1-alexander.deucher@amd.com>
X-Mailman-Approved-At: Wed, 24 Jul 2024 12:56:51 +0000
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

On 2024-07-23 16:51:20+0000, Alex Deucher wrote:
> The comment in the vbios structure says:
> // = 128 means EDID length is 128 bytes, otherwise the EDID length = ucFakeEDIDLength*128
> 
> This fake edid struct has not been used in a long time, so I'm
> not sure if there were actually any boards out there with a non-128 byte
> EDID, but align the code with the comment.
> 
> Reported-by: Thomas Weißschuh <linux@weissschuh.net>
> Link: https://lists.freedesktop.org/archives/amd-gfx/2024-June/109964.html
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
> 
> V2: Incorporate comments.
> 
>  .../gpu/drm/amd/amdgpu/atombios_encoders.c    | 29 ++++++++++---------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> index 25feab188dfe..ebf83fee43bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> @@ -2065,26 +2065,29 @@ amdgpu_atombios_encoder_get_lcd_info(struct amdgpu_encoder *encoder)
>  					fake_edid_record = (ATOM_FAKE_EDID_PATCH_RECORD *)record;
>  					if (fake_edid_record->ucFakeEDIDLength) {
>  						struct edid *edid;
> -						int edid_size =
> -							max((int)EDID_LENGTH, (int)fake_edid_record->ucFakeEDIDLength);
> -						edid = kmalloc(edid_size, GFP_KERNEL);
> +						int edid_size;
> +
> +						if (fake_edid_record->ucFakeEDIDLength == 128)
> +							edid_size = fake_edid_record->ucFakeEDIDLength;
> +						else
> +							edid_size = fake_edid_record->ucFakeEDIDLength * 128;
> +						edid = kmemdup(&fake_edid_record->ucFakeEDIDString[0],
> +							       edid_size, GFP_KERNEL);
>  						if (edid) {
> -							memcpy((u8 *)edid, (u8 *)&fake_edid_record->ucFakeEDIDString[0],
> -							       fake_edid_record->ucFakeEDIDLength);
> -
>  							if (drm_edid_is_valid(edid)) {
>  								adev->mode_info.bios_hardcoded_edid = edid;
>  								adev->mode_info.bios_hardcoded_edid_size = edid_size;
> -							} else
> +							} else {
>  								kfree(edid);
> +							}
>  						}
> +						record += struct_size(fake_edid_record,
> +								      ucFakeEDIDString,
> +								      edid_size);
> +					} else {
> +						/* empty fake edid record must be 3 bytes long */
> +						record += sizeof(ATOM_FAKE_EDID_PATCH_RECORD) + 1;
>  					}
> -					record += fake_edid_record->ucFakeEDIDLength ?
> -						  struct_size(fake_edid_record,
> -							      ucFakeEDIDString,
> -							      fake_edid_record->ucFakeEDIDLength) :
> -						  /* empty fake edid record must be 3 bytes long */
> -						  sizeof(ATOM_FAKE_EDID_PATCH_RECORD) + 1;
>  					break;
>  				case LCD_PANEL_RESOLUTION_RECORD_TYPE:
>  					panel_res_record = (ATOM_PANEL_RESOLUTION_PATCH_RECORD *)record;
> -- 
> 2.45.2
> 
