Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6958C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 21:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A8D20709
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 21:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzeRdG4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A8D20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570896E10C;
	Tue, 21 Jul 2020 21:40:22 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09EA76E10C
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 21:40:21 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id f2so22527268wrp.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 14:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lABGWbSk0V84esykTBH9h4bx+N33Bg//ct34CMnkKn4=;
 b=bzeRdG4XA3IL0rwgybc2it+a49MT9OLgHaEwewKK700jTtvKKxXpeJW0VVBVugTJ2+
 PH4Sn+IpAnBT4C69ZaRQdrT5BaY5KvHpi1QFlQ4RDUiSUlUS/XF1q5VT+KoN3CxkQF/R
 ymGBMv+BHsX2VfUTaH7fIY59qDwPIk149F/ylHJDN+Y9KV5qjeeWPk2xn9cuPUyqq9V7
 ALRL+sjhoFOF4UnnQLgR/lhnGJfyoD9n4aXZZ0I3IiBBuVseZizQvgrLJOMV1r6P6aES
 mVG/ExJjVvCYTg5HnARwBHTB7riLJ8zMdKAZ8HgT66zXmjCUIaaZQeQ/r4J1lzA4EJqt
 DAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lABGWbSk0V84esykTBH9h4bx+N33Bg//ct34CMnkKn4=;
 b=GJQyupInEdUr18YloXKTc1acVYpVcpV4oxYzKjhVSelyPXzYxL+LM0AOsgXRxunJnC
 CyMK05m3r4VN19Ovnb4MnNssrqEelamVN/DXRpH6pXr2tmpxwqhs5tRmjAMUJ9gwg4st
 2mCJdMEA1USKuJu5KlGJoPGhHzRRuD0yWwo51qLYMDt7U1b6Y9F0Yni1vS5Q8LZBR8tu
 S+OO+bJexy9HCoDnfH3Ua/0nGeiuwtghrXpnAWjOycP6hC7yc+zGhYVBdDXpN37DjRio
 WfOQdFKx+pZycXkkzZckXDSUC3R+NEnb44ApPQ3y8J1sDJdsrXItUXD7DyeJFRMdpVvX
 uy6w==
X-Gm-Message-State: AOAM531qhwf2kJVqsTPCNtjzg/XaHnZRIEveVTxG2OFUv45wfZwBuyV9
 dOw5UAcN/l5Je92W93rSWONwdNEjjfcM9hf6MeE=
X-Google-Smtp-Source: ABdhPJwykt6IZciwNxmzzejs976u9qOvH2k5H3dCcj9jykAjcM86bufEVgqtz2iQCH1De1OjKynng5ukIEXlJiWOBMw=
X-Received: by 2002:a5d:6348:: with SMTP id b8mr10805585wrw.362.1595367619610; 
 Tue, 21 Jul 2020 14:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200721211321.10303-1-pgriffais@valvesoftware.com>
In-Reply-To: <20200721211321.10303-1-pgriffais@valvesoftware.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Jul 2020 17:40:08 -0400
Message-ID: <CADnq5_NGc==grswRcNv7Ob+3YMfmeQC_wDfh2H0-NRyinJ4VUg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Create plane rotation property
To: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 21, 2020 at 5:19 PM Pierre-Loup A. Griffais
<pgriffais@valvesoftware.com> wrote:
>
> It's otherwise properly supported, just needs exposing to userspace.
>
> Signed-off-by: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>

Already applied:
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=drm-next-5.9&id=ecc874a6e7cb398b363b4e078fca4c097cb286ab

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a52f0b13a2c8..b7bef398057e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4713,6 +4713,7 @@ static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>         uint32_t formats[32];
>         int num_formats;
>         int res = -EPERM;
> +       unsigned int supported_rotations;
>
>         num_formats = get_plane_formats(plane, plane_cap, formats,
>                                         ARRAY_SIZE(formats));
> @@ -4744,6 +4745,13 @@ static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>                         DRM_COLOR_YCBCR_BT709, DRM_COLOR_YCBCR_LIMITED_RANGE);
>         }
>
> +       supported_rotations =
> +               DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 |
> +               DRM_MODE_ROTATE_180 | DRM_MODE_ROTATE_270;
> +
> +       drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
> +                                          supported_rotations);
> +
>         drm_plane_helper_add(plane, &dm_plane_helper_funcs);
>
>         /* Create (reset) the plane state */
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
