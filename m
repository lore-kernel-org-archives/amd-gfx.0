Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EFCC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 14:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF066206B5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 14:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u4nFtsVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF066206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C21766E286;
	Mon, 24 Aug 2020 14:55:12 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE4976E045;
 Mon, 24 Aug 2020 14:55:11 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id 83so8623910wme.4;
 Mon, 24 Aug 2020 07:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nhgjcGDiszmemLXRD4pV8iiEXCU7SaZcnWn1+uyj7dA=;
 b=u4nFtsVYYLdNR+pErZEZECWTnFSvE3O3DCzrqMuh8reuj9NQ/nCMZAkjiFnFFpRr/o
 7FvO+w2VmWyHOAxj5aNO+F34jF7R+zheD7iHJu+zUHnl6rYJdIqyDePWlgXUNmFr3UWs
 xqNY3r9yO1as69MM2n9kWCCp1OCVoxZBnqiBShqcVYTkpTt2iakcOH2ennn0fyMU4tsc
 Pvfx1qO4ZRMMKMdSWQRJ1Y4xyr7rLFmGO60h5j6UA7XA2X62enGHooY2rCHXPI413AFA
 WtnSpK0waO1zvPf5swCYTTDL94erIKmbKTuEhGduVrrDXiKasgtqKUR+OC08HqX4mH6G
 i43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nhgjcGDiszmemLXRD4pV8iiEXCU7SaZcnWn1+uyj7dA=;
 b=kbH1mXqCqBPEhRyUpBXzab8xKD7DK4jwVK9WKP1ZWLeHpoLlYZvXsNy1OgzJvpjXPp
 u+IVR91wRtkwRIVNqTyaVa6iXmWOBV7Vll5l8QKLBoeHg0OJ+m53kyqCkUAjHaiqD3ew
 ys+XKRhLyKrLuxYLwqMtxeRwmGs/wVeBnOEheHwBb90zY+zFyvlZee2HtaJz+y6r2azu
 P5/AKGLx3KQQQ0k7yNXezMD9eredK/UqvX/5usFUOK7Pw5xfdQQt/+yWZEwzeUvFX+vp
 kDOz98fT3jQ2+81MYzQ+NHVPgZivn/b+gsQwH8ZBiFQmYtLBtbamX2i9H3+UFMBYsEK/
 3Bew==
X-Gm-Message-State: AOAM531Xqvc6clMJ+DwYUEH+/x5Pb4th6XuvWfTcqEBrDjh1z7HS6/ry
 VnKb8IWaq3ZysvgD8k5J2xTi/5smQ7U/X92Cpcw=
X-Google-Smtp-Source: ABdhPJy+o0pSEX67YJFDALr/uKsAz7GjoWM/46FnxnObEN6n0CVfQB0jnjTYCfcivpI2EUL4og7c2zcHY7f127ZJddQ=
X-Received: by 2002:a1c:bc85:: with SMTP id m127mr5905233wmf.70.1598280909545; 
 Mon, 24 Aug 2020 07:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <1598084843-32270-1-git-send-email-tangyouling@loongson.cn>
In-Reply-To: <1598084843-32270-1-git-send-email-tangyouling@loongson.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Aug 2020 10:54:58 -0400
Message-ID: <CADnq5_MUkcTk1Mzh+22MRBoYEZnHDzhNkWNBD1XHZaPhYyXOHQ@mail.gmail.com>
Subject: Re: [PATCH] gpu: amd: Remove duplicate semicolons at the end of line
To: Youling Tang <tangyouling@loongson.cn>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Leo Li <sunpeng.li@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Aug 22, 2020 at 5:02 AM Youling Tang <tangyouling@loongson.cn> wrote:
>
> Remove duplicate semicolons at the end of line.
>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c                 | 2 +-
>  drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index e99bef6..8603a26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1108,7 +1108,7 @@ static int vcn_v2_5_mmsch_start(struct amdgpu_device *adev,
>  {
>         uint32_t data = 0, loop = 0, size = 0;
>         uint64_t addr = table->gpu_addr;
> -       struct mmsch_v1_1_init_header *header = NULL;;
> +       struct mmsch_v1_1_init_header *header = NULL;
>
>         header = (struct mmsch_v1_1_init_header *)table->cpu_addr;
>         size = header->total_size;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> index afdd4f0..b320931 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> @@ -467,7 +467,7 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
>                 mode_lib->vba.AudioSampleLayout[mode_lib->vba.NumberOfActivePlanes] =
>                         1;
>                 mode_lib->vba.DRAMClockChangeLatencyOverride = 0.0;
> -               mode_lib->vba.DSCEnabled[mode_lib->vba.NumberOfActivePlanes] = dout->dsc_enable;;
> +               mode_lib->vba.DSCEnabled[mode_lib->vba.NumberOfActivePlanes] = dout->dsc_enable;
>                 mode_lib->vba.DSCEnable[mode_lib->vba.NumberOfActivePlanes] = dout->dsc_enable;
>                 mode_lib->vba.NumberOfDSCSlices[mode_lib->vba.NumberOfActivePlanes] =
>                                 dout->dsc_slices;
> --
> 2.1.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
