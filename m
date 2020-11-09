Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C96C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18C6206CB
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eyj0wf9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18C6206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C1B89568;
	Mon,  9 Nov 2020 21:21:30 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A8389568;
 Mon,  9 Nov 2020 21:21:29 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id w24so935689wmi.0;
 Mon, 09 Nov 2020 13:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GDp8yb+Sw0EolRsci9v+WvLZ9nSbjiU3CL4VUAU4p3U=;
 b=Eyj0wf9PKyzvgsvHQsyfgZxgGn5vIq16Y8gMdbnhJB78VNyMq8Mwjq0OGH9NFWYzqP
 Jp6UuxRGSSt/WnTSuor53OoHOFjky9QEJ6mPUsUGscEyfMjbWSca3qO2SBpywYqVQzxx
 BM493YCgTJ/d53de+QhRi2qbmgbsOr0/olWozoAeGnkl8EBuG7iZwkq5Qbvhl3u7+IL9
 8YezRO3SLYsejT1YmFbagEQmv40oewW9JRsdViPZ6rQDcyvsRr3o+AVNMa3JTg2QMwHO
 T6vopTIYAcQCly1h+WlGfDjczNUBTzqzsE5GrfocbjClUg5sdUd0PtV9pCrNHcQaE2+W
 2HWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GDp8yb+Sw0EolRsci9v+WvLZ9nSbjiU3CL4VUAU4p3U=;
 b=hNV2NPiRbmAk6PPZOXxUeqNb3SFMjHU63Z0H7HTWAioeZru1O+R9K5PZhIf3xJJGWZ
 kYGp9qTNTR5h5Uqd0ZcoroNdFjkpRdc63qPBsFtoNG77pE8s/51k/x95K7LMSDrQyz9T
 2lvzeUdGKZzI5rqhjPX43hZcIPFzQMt6o7XS0CXGNVA0YEIwPGOmMhQZ9qD/NeURBExN
 LgjmDNnFGUWtCf7KxuL7E+C/aWXq2NEyFPTc7jfPk81UN3PD22AxaKR7leyZwe5T8jq7
 yLc7StR4TT1p/9extKSwHFL9UtjygandtUVQH+WpLa28J8nELMfhZ7VRgIniMMkVlZQi
 y+KA==
X-Gm-Message-State: AOAM533itZK6Am0nWInkv/rcTqHjSeN5RZyhzpscbUWP48iKNPyJEbAu
 mN77lWTuFYVrdhRRyTj6NXZICy+WGo+Zrtp786o=
X-Google-Smtp-Source: ABdhPJyIn9jY/EM3NsfRCWQKiTNIKSQPUd00zlTTnc7nT1mAHIfsQMOpQ0BCDXxFJdSy6q+gIIZeHW6pK4msqPWqZAo=
X-Received: by 2002:a1c:46c6:: with SMTP id t189mr1159422wma.79.1604956887879; 
 Mon, 09 Nov 2020 13:21:27 -0800 (PST)
MIME-Version: 1.0
References: <20201109210725.24668-1-unixbhaskar@gmail.com>
In-Reply-To: <20201109210725.24668-1-unixbhaskar@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Nov 2020 16:21:16 -0500
Message-ID: <CADnq5_NOmgYM0_0fTQaYr+qn7M_Vrbo1E=mPmuoATQNjRRHTqg@mail.gmail.com>
Subject: Re: [PATCH] drivers: amdgpu: amdgpu_display: Fixed the spelling of
 falg to flag
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
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
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, Jean Delvare <jdelvare@suse.de>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 9, 2020 at 4:16 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
> s/falg/flag/p
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 2e8a8b57639f..9223502c1e5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -509,7 +509,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
>          * to avoid hang caused by placement of scanout BO in GTT on certain
>          * APUs. So force the BO placement to VRAM in case this architecture
>          * will not allow USWC mappings.
> -        * Also, don't allow GTT domain if the BO doens't have USWC falg set.
> +        * Also, don't allow GTT domain if the BO doens't have USWC flag set.
>          */
>         if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
>             amdgpu_bo_support_uswc(bo_flags) &&
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
