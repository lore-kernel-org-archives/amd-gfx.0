Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E5DC3DA59
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Jul 2024 16:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 028A810E20B;
	Sat, 20 Jul 2024 16:00:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.b="WsMUXMmd";
	dkim-atps=neutral
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EDCF10E083;
 Sat, 20 Jul 2024 07:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
 s=mail; t=1721460981;
 bh=Iajeus+DqtkupJ67l+9/EkLBFj7w2Zh6ndvBxvBYunQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WsMUXMmdSoC4wyGSpnq06KNhFskidgN8O6Qfj9mnjhBx69eP3eNxwV0R10pZq3/cN
 mFNKIr/85pezm4Da995+wfP4be/+Ms3v2/u2cj2QY3rquNCpI1QSTb13VxHgQiSxYw
 iQVFIUdy4sX+fri+x/tpiBHJmHWMLqeTx4ALDIKM=
Date: Sat, 20 Jul 2024 09:35:59 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: convert bios_hardcoded_edid to drm_edid
Message-ID: <7da301de-c8f8-4782-8617-ed315ad05abf@t-8ch.de>
References: <20240616-amdgpu-edid-bios-v1-1-2874f212b365@weissschuh.net>
 <ad78ada4-4e31-4994-845b-fe756b52a1ae@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad78ada4-4e31-4994-845b-fe756b52a1ae@t-8ch.de>
X-Mailman-Approved-At: Sat, 20 Jul 2024 16:00:50 +0000
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

Hi amdgpu maintainers,

did you get a chance to look at the patch and the suspected bug?

Thanks,
Thomas

On 2024-06-16 20:14:45+0000, Thomas Weißschuh wrote:
> On 2024-06-16 11:12:03+0000, Thomas Weißschuh wrote:
> > Instead of manually passing around 'struct edid *' and its size,
> > use 'struct drm_edid', which encapsulates a validated combination of
> > both.
> > 
> > As the drm_edid_ can handle NULL gracefully, the explicit checks can be
> > dropped.
> > 
> > Also save a few characters by transforming '&array[0]' to the equivalent
> > 'array' and using 'max_t(int, ...)' instead of manual casts.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > While this patch introduces a new user for drm_edid_raw(),
> > if amdgpu proper gets migrated to 'struct drm_edid', that usage will go
> > away.
> > 
> > This is only compile-tested.
> > 
> > I have some more patches for the rest of amdgpu,
> > to move to 'struct drm_edid'.
> > This patch is a test-balloon for the general idea.
> > 
> > The same can also be done for drm/radeon.
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c |  6 +-----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h       |  4 ++--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c       |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 21 +++++++--------------
> >  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c         |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c         |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c          |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c          |  2 +-
> >  8 files changed, 15 insertions(+), 26 deletions(-)
> 
> <snip>
>  
> > diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> > index 25feab188dfe..90383094ed1e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> > @@ -2064,20 +2064,13 @@ amdgpu_atombios_encoder_get_lcd_info(struct amdgpu_encoder *encoder)
> >  				case LCD_FAKE_EDID_PATCH_RECORD_TYPE:
> >  					fake_edid_record = (ATOM_FAKE_EDID_PATCH_RECORD *)record;
> >  					if (fake_edid_record->ucFakeEDIDLength) {
> > -						struct edid *edid;
> > -						int edid_size =
> > -							max((int)EDID_LENGTH, (int)fake_edid_record->ucFakeEDIDLength);
> > -						edid = kmalloc(edid_size, GFP_KERNEL);
> > -						if (edid) {
> > -							memcpy((u8 *)edid, (u8 *)&fake_edid_record->ucFakeEDIDString[0],
> > -							       fake_edid_record->ucFakeEDIDLength);
> > -
> > -							if (drm_edid_is_valid(edid)) {
> > -								adev->mode_info.bios_hardcoded_edid = edid;
> > -								adev->mode_info.bios_hardcoded_edid_size = edid_size;
> > -							} else
> > -								kfree(edid);
> > -						}
> > +						const struct drm_edid *edid;
> > +						edid = drm_edid_alloc(fake_edid_record->ucFakeEDIDString,
> > +								      max_t(int, EDID_LENGTH, fake_edid_record->ucFakeEDIDLength));
> > +						if (drm_edid_valid(edid))
> > +							adev->mode_info.bios_hardcoded_edid = edid;
> > +						else
> > +							drm_edid_free(edid);
> 
> The old code here seems broken in general.
> In drivers/gpu/drm/amd/include/atombios.h the comment for ucFakeEDIDLength says:
> (I expect the same field in the same struct for amdgpu to have the same semantics)
> 
>     UCHAR ucFakeEDIDLength;       // = 128 means EDID length is 128 bytes, otherwise the EDID length = ucFakeEDIDLength*128
> 
> So as soon as the EDID from the BIOS has extensions, only the first few
> bytes will be copied into the allocated memory. drm_edid_is_valid() will
> then read the uninitialized memory and if the "extensions" field ends up
> non-zero it will happily "validate" past the allocated buffer.
> 
> The new code won't work either but at least it won't read uninitialized
> memory nor will it read past the buffer bounds.
> 
> >  					}
> >  					record += fake_edid_record->ucFakeEDIDLength ?
> >  						  struct_size(fake_edid_record,
> 
> <snip>
