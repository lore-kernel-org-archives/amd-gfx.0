Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07492C33CB1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 14:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2942467D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 14:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg6H2LGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2942467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 893006E3F3;
	Tue, 14 Jan 2020 14:39:19 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFAA56E3F3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 14:39:18 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id b6so12434071wrq.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 06:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZmQVGOe3G9tZdH3RA0Gh879ap9aKaVEGnnoIOB9YQV0=;
 b=Cg6H2LGk0Lc1McvrS/8lrYTGzcEjnAFL1ozAfB3PTo62qC4/wMMKH2Lei2CGDzOX5k
 SMR9IjTlxwvVrJnRLjtbzh2gk2DwZYn0gGWGZqYrJs1e71AVw5rgWpeggeTMM42MQdf+
 ihUk0UoFs8GZR7u8Hjp+TCi815bzsP2Di2a14HLIv51U44Hq5iNHxj0sSugW3tNn4Clp
 rJiixYAL//WADIDR2INY8Hnf7rVf25FYKqPAGGfXF8JHeKBIS193SETc8BfgmiUGXHEo
 r2GVEFNUKQ7d7UWqL5pHLCWAdwjKLAQuuXKPX2jJU35K0yRIKyKhOTerm3GYp57W5+Ta
 lhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZmQVGOe3G9tZdH3RA0Gh879ap9aKaVEGnnoIOB9YQV0=;
 b=hF/4yEejKiDQIqXlLRuKpBGiyZ+4Xf25vVhMIwbSjkFtmS3xdmfACixlXyck7HMIKg
 rq91KOHf7IGIJNEEafydPQPcUW7qhDp9ojxai+o3WjJD8H7flmjq6cQDg8iECABwMMp0
 bZpFu/40C7qb4P5KwwZgxwXh5HSaCBzZKIPsPXQaE1K8RInpUntmVwBNaXISoArjA4uH
 8NzL0GYTvrAo9NBz3B3fdfXOJVjLDrM3MJuYcuyt0nHb9Ufo7zjk/Deu9rFhqYgfcMVN
 CEmwmXz7wT9+8JT7C8O/F5GAE+XMFVnCHYWmv7UrOmskO+Fbsy5oO1otMv5FgIvblsLa
 nBYw==
X-Gm-Message-State: APjAAAUwimCLY85MCIXOGlS2IS3holFxiuFFMhw8OZL2u4MRv+qWnvve
 /55/oUmqpFaK1GPpVmEKWuO4MkvOYdnr/0DSfAw=
X-Google-Smtp-Source: APXvYqwqOHtCpmQCtSnnpZddxAa59NqjesYw5Tmrg0xE0U7NflYXUcp9wy5FqmFoUVhXvTQnd5qOdePvoIkOmDV/NSQ=
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr25426129wru.40.1579012757163; 
 Tue, 14 Jan 2020 06:39:17 -0800 (PST)
MIME-Version: 1.0
References: <1579001495-20729-1-git-send-email-curry.gong@amd.com>
 <1579001495-20729-2-git-send-email-curry.gong@amd.com>
In-Reply-To: <1579001495-20729-2-git-send-email-curry.gong@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jan 2020 09:39:05 -0500
Message-ID: <CADnq5_Pe2RXm9dTDjFqgvMond3W3zd0OMPB3mH9exW6Y1_MZdg@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: add kiq version interface for RREG32
To: chen gong <curry.gong@amd.com>
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

On Tue, Jan 14, 2020 at 6:43 AM chen gong <curry.gong@amd.com> wrote:
>
> Reading some registers by mmio will result in hang when GPU is in
> "gfxoff" state.
>
> This problem can be solved by GPU in "ring command packages" way.
>
> Signed-off-by: chen gong <curry.gong@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 32bb883..90f148a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1016,10 +1016,13 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
>
>  #define AMDGPU_REGS_IDX       (1<<0)
>  #define AMDGPU_REGS_NO_KIQ    (1<<1)
> +#define AMDGPU_REGS_KIQ       (1<<2)
>
>  #define RREG32_NO_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
>  #define WREG32_NO_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
>
> +#define RREG32_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_KIQ)

Please add a WREG32_KIQ helper as well.

Alex

> +
>  #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
>  #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1d076c0..1fceeb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -264,7 +264,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>  {
>         uint32_t ret;
>
> -       if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
> +       if ((acc_flags & AMDGPU_REGS_KIQ) || (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev)))
>                 return amdgpu_kiq_rreg(adev, reg);
>
>         if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
