Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F26C5AC7A
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 18:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 333A610F573;
	Fri,  7 Aug 2026 18:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="agBcCM89";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 268A410F573
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 18:00:17 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-38f57e312ecso381586a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Aug 2026 11:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786125616; cv=none;
 d=google.com; s=arc-20260327;
 b=LKCebFLiVTgX3FUZ2mgNpTjytSXj3HX6eszao2JM3OsYBVlmESpnTFm9UvtjzBY/vT
 BdqxXG1sxBMFQhxItAyZNtil90CnvZTwEeuMBW5hGjQcrpw1FzLrskB+CPkeqbTMgDvW
 DAde8ofauN34ghnwvKnvDVmw/3uf7kUWStwWQCrn/nrBVOCEOjFj7S9dmAoEi9Z9VPZR
 2mXVbfWVss5pGcFMwLiQ9u6hep9/m0pyETM3tVz//bR1dE+lIjF8kWXlEmemxOyS3GMh
 mDMp5HPSomjKnFX39OHQOMQS13ns3hSAWwox/0yE2+4aWIk7+r3cFbKN8drLH4RFt4eL
 PWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c0Wfka9/KIPBq/ssH/NDLPL459qo1ui1yxSLFuyKvYk=;
 fh=97gBcM6rQ6v9mk7E4Krqau6FpihTfxruK7x/jHG4+SY=;
 b=T0rR3UvTn5qkq9EiQlUf/d3p7LJcIJxfEkPY4aIrhd4Sk7FZjFoL6WEvF4F6j2iFqc
 YruMhXQWwAaoe45rxEXvjkUEf8BADZ/wPC2lNgsA111+oO6vtnfC/OJUo0/cogU+yl6Z
 G+PyAKnnMC9lAItcDM0yaLIG6+tvVJilNBdJDDAphXrKqyR7MEbMy7DGtYxENEIUeJAT
 R1QgQ3DLFI+zxq+CvoYJKD9L/t7FoTFhT3tH7Z9a2CQllK9LPa0K/raXdq/LoNO8X8jq
 i+5pTUrtVbvQVWKo4jaYHV09ZGVDGXQ0dPro0D133aomuONnulKcsZIiW7mmYmOIxNsy
 1Ejg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786125616; x=1786730416; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c0Wfka9/KIPBq/ssH/NDLPL459qo1ui1yxSLFuyKvYk=;
 b=agBcCM897KQt7na8r8A+PwhAFPihIEb1iXbPxHCoFGEBYY/2qvWwhdRf+3esfyoZUd
 ISPNYt+z0aXdl+eo9+u97RAi6hVoYniVh3wu4YoURiLO0VWhbRmbqnHgoG8jic360z+C
 VNQ8jSdfjEYac/v4bUQNUcJatZaQIErMTi6TirsY1RZ846gnPIVDiNoqCzOpabeZPMyN
 D0Srxwi97LP6BTg8b5ZMpGTc4AzGqihPtZNxUT+u7fpZO8u41e5sGcJ5ay37kZCBEnU4
 s/IKKFDCUiHu+3j4K+5wjyuvmxxpsykAojByknFrhlLxb/+EgN8eRct6qMXq4+EOkHf1
 U2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786125616; x=1786730416;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c0Wfka9/KIPBq/ssH/NDLPL459qo1ui1yxSLFuyKvYk=;
 b=hWBySSjwluNOaBZkRRkHCBHpx30N/jaJxLygdDGr86eJVuFTKOXQdC7ow33F9Vi9/b
 wP5JWIc5b+hWYY7zZUl13EnTEE1b/S2asoUXwhcz/oRnhkAfBgSOrhv6y0rPgqzykvSN
 eXEvHjV5HtXNBTgfhQVTK8o5I+D/8c8wMSBXh3yGNrPZpkTDKiZzp6JetEl1TSgwVqTj
 tXk9nat9GQzeqrKKMVZOLw0ZcuVHu0NliN5tvxLwjqUJzbmFDmB8+ApACD/0MaOCieH/
 bMR/JIWrJZpqby0MYrEAvy0aXnzkOGUD0inRqt5aB+gdNKBVZ7nDVnxMSKpX8pYFyDDj
 ZWsA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr4NCQxDuF7FESzdG2qtVKO6piIwZH5xbX/Fyts4JFtqJMYcBxesu9NOrqaDuBKp8V2zmh7M6tW@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3GiUcMIpfL8HfD82/cRT9u9TfLjy9sx/B4ekAbLCLenaQBIMO
 vCG+6dCun70g64F+ZUOK0eTOlgUcGeJ49ft6bH2/Ez6AAWQO1AscyX0Or0Misn+Mzm9oRvvZgVs
 QLNaYtGqpEFYpwsVuqn0pt3gshmmu/fo=
X-Gm-Gg: AR+sD12NrRL+FGpQx8QTx0dIqE1KTGq80nN4I987kiAzARF0MX3OJJVtExFBRq0DWc9
 8eGIbUjVQuRLgU5mERAjXEVfxf8CisSzunKsjPRPxTqG/sOYykN6y/UT1w8NURkDPsHNF7+mlgc
 8lxyhilefLI1vHQm2Zj8E3FjKHODQh41dYMqwx48AdDyswMKLFXZWInTHmniNfod3kWuQbhV+91
 qq/mmRlAD5OpJ3tmloNMh0I3n8PvVGG98QqQifU1/qtWJITTxirDx7FUHNFlRac6D87R+q0NZxt
 d+8GLduVQf+B3UFX8B2YuomWB56YvZw42jYiER+mtni45EcYgl8TCOmv99D6YH2SBCn4Q6EeWBd
 g56/9ezcOrce7pPmGK98N/t35yVeIXew=
X-Received: by 2002:a17:90b:3a81:b0:36d:b30b:14ed with SMTP id
 98e67ed59e1d1-3903c6e93e6mr17347802a91.2.1786125616561; Fri, 07 Aug 2026
 11:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260807145855.83479-1-samuel.pitoiset@gmail.com>
 <833bafaf-0167-4515-93cd-0828776741d2@igalia.com>
In-Reply-To: <833bafaf-0167-4515-93cd-0828776741d2@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Aug 2026 14:00:05 -0400
X-Gm-Features: AUfX_mzxIXXmzkMgICxD6dw0ZAqFqvVs53r2e1rHpS5oqJZtmayLF777l1T9PvA
Message-ID: <CADnq5_OnpUB1xVOc52g_-DJuKRTWSOJGrL9QHNUeWyC-mytumg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix NULL pointer dereference in
 amdgpu_dm_crtc_set_vblank()
To: Melissa Wen <mwen@igalia.com>
Cc: Samuel Pitoiset <samuel.pitoiset@gmail.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Hung <alex.hung@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Applied.  Thanks!

On Fri, Aug 7, 2026 at 12:35=E2=80=AFPM Melissa Wen <mwen@igalia.com> wrote=
:
>
>
>
> On 07/08/2026 16:58, Samuel Pitoiset wrote:
> > amdgpu_dm_crtc_set_vblank() dereferences acrtc_state->stream when
> > vblank is enabled/queried from DRM_IOCTL_MODE_CRTC_GET_SEQUENCE before
> > a stream is attached to it.
> >
> > BUG: kernel NULL pointer dereference, address: 0000000000000008
> > RIP: amdgpu_dm_crtc_set_vblank+0x6b/0x4d0 [amdgpu]
> > Call Trace:
> >   drm_vblank_enable
> >   drm_vblank_get
> >   drm_crtc_get_sequence_ioctl
> >   drm_ioctl_kernel
> >   drm_ioctl
> >
> > Reproduced by running VKCTS with WSI tests enabled on RADV.
> >
> > Guard the enable path on acrtc_state->stream being non-NULL, matching
> > the existing checks in this function.
> >
> > Fixes: 34d66bc7ff10 ("drm/amd/display: Fix Xorg desktop unresponsive on=
 Replay panel")
> > Signed-off-by: Samuel Pitoiset <samuel.pitoiset@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > index 46d85457c77b..62eac6e65334 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > @@ -268,7 +268,7 @@ static inline int amdgpu_dm_crtc_set_vblank(struct =
drm_crtc *crtc, bool enable)
> >
> >       irq_type =3D amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crt=
c_id);
> >
> > -     if (enable) {
> > +     if (enable && acrtc_state->stream) {
>
> LGTM.
>
> Reviewed-by: Melissa Wen <mwen@igalia.com>
>
> +AMD display folks for visibility
>
> >               struct dc *dc =3D adev->dm.dc;
> >               struct drm_vblank_crtc *vblank =3D drm_crtc_vblank_crtc(c=
rtc);
> >               struct psr_settings *psr =3D &acrtc_state->stream->link->=
psr_settings;
>
