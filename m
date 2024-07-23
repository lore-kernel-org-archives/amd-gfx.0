Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47783C3DA63
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 20:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C635610E636;
	Tue, 23 Jul 2024 20:11:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.b="aDELxW2U";
	dkim-atps=neutral
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE48B10E087
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 17:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
 s=mail; t=1721757489;
 bh=6Xz0tD4WDmXI3dKRcxmi6zN3SmrZiHbf25wLnLc3ns0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aDELxW2UZOJOqM1HQBW5BA6TBPvR38zWOi/iAu7QP3Ahn3oRbVtGSr9zd0VcJHOK4
 ba4XKfUD/HU3oNuSZzcUJu6qEhNzBZFJWli9Y1Q4aWkEDGa/sey9gHe/z0FQ3kDYn5
 FYdFQyWF4diZYQCxzEBpGsN/XTiDqrIm0xyZwPls=
Date: Tue, 23 Jul 2024 19:58:08 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/amdgpu: properly handle vbios fake edid sizing
Message-ID: <86877483-365e-4c11-bf7d-4f66adabf954@t-8ch.de>
References: <20240723173357.2314927-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240723173357.2314927-1-alexander.deucher@amd.com>
X-Mailman-Approved-At: Tue, 23 Jul 2024 20:11:16 +0000
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

On 2024-07-23 13:33:56+0000, Alex Deucher wrote:
> The comment in the vbios structure says:
> // = 128 means EDID length is 128 bytes, otherwise the EDID length = ucFakeEDIDLength*128
> 
> This fake edid struct has not been used in a long time, so I'm
> not sure if there were actually any boards out there with a non-128 byte
> EDID, but align the code with the comment.
> 
> Reported-by: Thomas Weißschuh <linux@weissschuh.net>

Afaik Reported-by: should also have a Link:.

And IMO a Fixes: would also be fitting.

> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/atombios_encoders.c    | 24 +++++++++++--------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> index 25feab188dfe..a8751a5901c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> @@ -2065,12 +2065,16 @@ amdgpu_atombios_encoder_get_lcd_info(struct amdgpu_encoder *encoder)
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
> +						edid = kmalloc(max(EDID_LENGTH, edid_size), GFP_KERNEL);

This looks wrong, but it was similar before.
If the EDID contains extensions and the code tries to access those,
it will be an out of bounds memory access, because the extensions were not
actually copied.
(And this seems to already happen in drm_edid_is_valid())

This code will go away soon with my patch, but at least we can now
figure out what to do on EDIDs with extensions instead of
changing the behaviour just as a side-effect.

Is there any issue with just dropping the max() and keeping the full
EDID?

Also if this is touched anyways, it could become kmemdup().

>  						if (edid) {
>  							memcpy((u8 *)edid, (u8 *)&fake_edid_record->ucFakeEDIDString[0],
> -							       fake_edid_record->ucFakeEDIDLength);
> +							       edid_size);
>  
>  							if (drm_edid_is_valid(edid)) {
>  								adev->mode_info.bios_hardcoded_edid = edid;
> @@ -2078,13 +2082,13 @@ amdgpu_atombios_encoder_get_lcd_info(struct amdgpu_encoder *encoder)
>  							} else
>  								kfree(edid);
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
