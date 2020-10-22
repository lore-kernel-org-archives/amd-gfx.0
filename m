Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01461C55179
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 15:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7A72463D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 15:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwZycMuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7A72463D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA78F6F5B5;
	Thu, 22 Oct 2020 15:36:26 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F42236F5B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 15:36:24 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id c16so2777725wmd.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BrreVJl3/iBumAL6z8lLKkGOkw/StiamIps+ryVt3+4=;
 b=HwZycMuBV77o/VutGHIL0MRWfGFoCVQmIC2zJDD+E46Trj4tdbLbMcH3JsVtmEJ3Kc
 SGUBd5jG18O41F4wyw80dD3JBnnVgDOaXEmtci+EtpwJC0foln1RZNT4TqUPPbnMXTSw
 HI5kIhMtA5O3jE6dxSdVeINcm6kKlw1TbnxADClmSeeqB8/ImIMNSa8vjfmYijA1nYpJ
 /TixVoTcxOiUa7sUueAJ/0ENK6EU7GSnpzKIkCzqPXiSiTQbV/MjyKasOPjsXwBKV2tQ
 Bt6sA5MVg3H65aYDlK4RZBPNJoQeHRW3Wjd52pPPoJMf4jmjEE7z1cNlI6nl1lcXl7F6
 sOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BrreVJl3/iBumAL6z8lLKkGOkw/StiamIps+ryVt3+4=;
 b=rtLSc79OXA0AR+pbAbHEFVuh9FGi+84iBgRDyYwTIOAh/tbXjDEONTXXP4evXqC9wC
 o5HDSiGydsNRsYyARzN8RB0mOvSGlMQGGoJGvE7ndCqBLuLKiok97m+R+d7XQ8yqQtxS
 TbKCK2sIEb1Bn+JoHZeacAJ764w3pFcmBE7WGOan6MlER40ZxPToqNr9xwaSaW17tZ+G
 /vpY92xvS5gfEwXFAvhq8m+4DJl32t0gKSoeAJY9t4lexs+lNQ0GMSXGSQlu5myYHUhz
 Fhv16wAcQwmA5H29aq7f1P9tidwMJHIZ5rqmK+x5eQ1RMco3rEDQI/ZXeIgKAgtsOSNg
 HzyA==
X-Gm-Message-State: AOAM5338KzpaWJd1bx+e0TMilZS/nS+W+zpKpdiMOeRGqi6Y3GNC9FcW
 foYDkGAOxHcYuVm3su6it5wE/jVcV7H+hfLD5J0=
X-Google-Smtp-Source: ABdhPJwZOOriV4DCDPfkQUcTs/26ae61TdmKmffKBOk4l2Z/XuPB8k706JMyDHQ/s9HMnB9UFr1Z5EYaxtsn+xd7zW8=
X-Received: by 2002:a1c:c915:: with SMTP id f21mr3091644wmb.73.1603380983697; 
 Thu, 22 Oct 2020 08:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
 <20201021233130.874615-4-bas@basnieuwenhuizen.nl>
In-Reply-To: <20201021233130.874615-4-bas@basnieuwenhuizen.nl>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Oct 2020 11:36:12 -0400
Message-ID: <CADnq5_OuXhN-2Raie9V452KrG4ChaguY1q6+Gk19mR86A=Fkog@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] drm/amd/display: Honor the offset for plane 0.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
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
Cc: Marek Olsak <maraeo@gmail.com>, "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "for 3.8" <stable@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, "Wentland,
 Harry" <harry.wentland@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 21, 2020 at 7:31 PM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> With modifiers I'd like to support non-dedicated buffers for
> images.
>
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Cc: stable@vger.kernel.org # 5.1.0

I think you need # 5.1.x- for it to be applied to all stable kernels
since 5.1 otherwise it will just apply to 5.1.x

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 73987fdb6a09..833887b9b0ad 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3894,6 +3894,7 @@ fill_plane_dcc_attributes(struct amdgpu_device *adev,
>         struct dc *dc = adev->dm.dc;
>         struct dc_dcc_surface_param input;
>         struct dc_surface_dcc_cap output;
> +       uint64_t plane_address = afb->address + afb->base.offsets[0];
>         uint32_t offset = AMDGPU_TILING_GET(info, DCC_OFFSET_256B);
>         uint32_t i64b = AMDGPU_TILING_GET(info, DCC_INDEPENDENT_64B) != 0;
>         uint64_t dcc_address;
> @@ -3937,7 +3938,7 @@ fill_plane_dcc_attributes(struct amdgpu_device *adev,
>                 AMDGPU_TILING_GET(info, DCC_PITCH_MAX) + 1;
>         dcc->independent_64b_blks = i64b;
>
> -       dcc_address = get_dcc_address(afb->address, info);
> +       dcc_address = get_dcc_address(plane_address, info);
>         address->grph.meta_addr.low_part = lower_32_bits(dcc_address);
>         address->grph.meta_addr.high_part = upper_32_bits(dcc_address);
>
> @@ -3968,6 +3969,8 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
>         address->tmz_surface = tmz_surface;
>
>         if (format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN) {
> +               uint64_t addr = afb->address + fb->offsets[0];
> +
>                 plane_size->surface_size.x = 0;
>                 plane_size->surface_size.y = 0;
>                 plane_size->surface_size.width = fb->width;
> @@ -3976,9 +3979,10 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
>                         fb->pitches[0] / fb->format->cpp[0];
>
>                 address->type = PLN_ADDR_TYPE_GRAPHICS;
> -               address->grph.addr.low_part = lower_32_bits(afb->address);
> -               address->grph.addr.high_part = upper_32_bits(afb->address);
> +               address->grph.addr.low_part = lower_32_bits(addr);
> +               address->grph.addr.high_part = upper_32_bits(addr);
>         } else if (format < SURFACE_PIXEL_FORMAT_INVALID) {
> +               uint64_t luma_addr = afb->address + fb->offsets[0];
>                 uint64_t chroma_addr = afb->address + fb->offsets[1];
>
>                 plane_size->surface_size.x = 0;
> @@ -3999,9 +4003,9 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
>
>                 address->type = PLN_ADDR_TYPE_VIDEO_PROGRESSIVE;
>                 address->video_progressive.luma_addr.low_part =
> -                       lower_32_bits(afb->address);
> +                       lower_32_bits(luma_addr);
>                 address->video_progressive.luma_addr.high_part =
> -                       upper_32_bits(afb->address);
> +                       upper_32_bits(luma_addr);
>                 address->video_progressive.chroma_addr.low_part =
>                         lower_32_bits(chroma_addr);
>                 address->video_progressive.chroma_addr.high_part =
> --
> 2.28.0
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
