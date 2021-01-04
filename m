Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E282EC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 17:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0923224D4
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 17:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0923224D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACEBD6E037;
	Mon,  4 Jan 2021 17:21:58 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 077778979E;
 Mon,  4 Jan 2021 17:21:57 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id w3so26703893otp.13;
 Mon, 04 Jan 2021 09:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OHkwo95cf4KutEaWyT4gAn6XzpYTSZLdpJFt9bn4zyY=;
 b=vOG82DYj4Jk2GQEep/efWaD7lM6x8IemKMz18A6W0v3CUTowhdhIiGN/GSuw6deff7
 mpPMeJOxXolsNSbRYBXZvrtFVGlkks2MtUuEH0CSpGe6/1c1GDvZS99LW9qcxa4Ywf1C
 zJr+BOds+aLaRc94WcHbzja5XSkoOYZYyKH3IFmV5mlsQN6/zTTUnnelBrBSrj1m4MT8
 OPX4k4WYPZss2kSQfXkLPgVWLmCBJ1LWwDWFSY2O8vQURP6F+GcBXALj2kW8qx869wet
 xYYoCHgtWTSB8im4eHL49GwDqgqrY13q1gv1MvVwMhYvWBFt7oZX8eg33JWqFHmpvjaC
 ei3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OHkwo95cf4KutEaWyT4gAn6XzpYTSZLdpJFt9bn4zyY=;
 b=gr2OLAI5sOmmY1VcUUP65N9GCeMmFqe8LXseMRfpXTHFP1Ekc0FyftuKdRwD9e5I46
 wzTkn5TuRdHxrQkxhrFuZJHgKqY06jtaprcu2LzlB4Fcz0vZVddDFJvyl1cGUNwau/f4
 v5BGqSrWW2mOQ713q7+QLqkaNs+0XkdK3zJv0zi73+hSzJgQzV/Dh4+J9t7iiqCDIo/v
 7Ebd08MeG1HMljbT4q+KBR37ov7DBR4A59ledZ3P2EqMYyomDYQ/8/X3cbFLf1GCKtTM
 sJuVlgAlq0AtLZy4XF47wuMzRBrrbNyyX5Usw4FA11eYROsVT4GL0Ksk83I7elp5SroE
 REcQ==
X-Gm-Message-State: AOAM53317uGu0DS3+Gg6ZOcUHH2XsZqgkedtSYkIGengi7zenVPzs0fo
 FFraDTWucTDj972kEG0OiE0EGCDM2buZgmMgoWs=
X-Google-Smtp-Source: ABdhPJxj5d5/6UOHNpBETcFvPEbS3qx3lwPq/FDuHPmO6D3xgg1lUBolISGB8+dMAszkYGuqc5vlmosWrpPK+z1DFmg=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr38895316otl.311.1609780916392; 
 Mon, 04 Jan 2021 09:21:56 -0800 (PST)
MIME-Version: 1.0
References: <20210102140235.514039-1-bas@basnieuwenhuizen.nl>
In-Reply-To: <20210102140235.514039-1-bas@basnieuwenhuizen.nl>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Jan 2021 12:21:45 -0500
Message-ID: <CADnq5_PYBEgtnCWk1EkYju8Qnwsr-BgcRL5x09SxFBi1ptTDEg@mail.gmail.com>
Subject: Re: [PATCH] drm: Check actual format for legacy pageflip.
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
Cc: Mario Kleiner <mario.kleiner.de@gmail.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Zhan Liu <zhan.liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Jan 2, 2021 at 9:02 AM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> With modifiers one can actually have different format_info structs
> for the same format, which now matters for AMDGPU since we convert
> implicit modifiers to explicit modifiers with multiple planes.
>
> I checked other drivers and it doesn't look like they end up triggering
> this case so I think this is safe to relax.
>
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Fixes: 816853f9dc40 ("drm/amd/display: Set new format info for converted metadata.")

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/drm_plane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index e6231947f987..f5085990cfac 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -1163,7 +1163,7 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
>         if (ret)
>                 goto out;
>
> -       if (old_fb->format != fb->format) {
> +       if (old_fb->format->format != fb->format->format) {
>                 DRM_DEBUG_KMS("Page flip is not allowed to change frame buffer format.\n");
>                 ret = -EINVAL;
>                 goto out;
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
