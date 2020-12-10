Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56629C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 18:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2AD823C44
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 18:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2AD823C44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 685D26EAB4;
	Thu, 10 Dec 2020 18:18:03 +0000 (UTC)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBF8A6EAB4
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 18:18:01 +0000 (UTC)
Received: by mail-oi1-x241.google.com with SMTP id x16so6758567oic.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 10:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Lixa5WLrm3Aq3UftdwCfA2jOQIG1ybpxDXhPxRe7IqE=;
 b=WbbsH46+WiTHUyaFUIPwHBUCNQW/ulkcaFN7epzuHJykrnQitXHy0VuRi5JUpZJWm2
 yqwER+ow3UEiRi0MjHRPtetnRjQWQpH//Npd6JkSe7rUt0PzBsacxRfw9Ei0DuQWUNFL
 QbLoJ9MI8o5XUBTI3jgTrJz4V9ehHsdp50ed+Cv76ZAB6xe98l2dmMcw0d3rgQKMZ2Cq
 oJoKnHQkMmq6HUYz2Af1/hUkynh0mNFa8YjohV2ESJORbTulc7NrC9ushruaiAA0bjz/
 bhkrqM8LGPSpDqR+66lAzQW9fGRPEE7MvfY5H2iJNAaA5uTv/kynBtwPYXDWdB7lqIv8
 Vkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Lixa5WLrm3Aq3UftdwCfA2jOQIG1ybpxDXhPxRe7IqE=;
 b=EmkZCdEw1YvnS4xqGbW5drWM99cYvSId6yOVONYL/BJNL/Wnvtnf9sHcqrDHMXsEo6
 cTnUDvTx7WJkWGn3BP/2aoPpueEBYYdPvR6bX1wzheaoLtldnU6LqAQZYwMTJb7u33Wv
 KaADLukjR/oFrInoWLYmLcBpBN08eG86OXGh7Hl7XscKBuB4CsVD0s/wOf2Zl8c61Ywj
 Cb6a4qX+XSxSIdcuGiVTsaAxywCeP/n0CXY1bMaxrKHl31+34pQ4pI/qqyQTl7Is7FcM
 u2wJTBG0JW/5VfnroMsBCxLHdAmInkCV7A5sJk+tsYyl6bDTDU+BagcFz/KxYwzo2VvW
 NDew==
X-Gm-Message-State: AOAM5333jDhF1NIKSYz65GdtzEOO15ehfktGUei2CNlUnJ89fn2zeCAR
 42xpe0KX1Wmu+pnH9Ncqh0E+oaVLNZxWiqCbIZQ=
X-Google-Smtp-Source: ABdhPJyncR16DxJk0dNH7lgzYR9qMQyPuUBbwFlXZ40h2w7nT7OKU0YrqMlvyC8vLZk9HLhf0Psq6We9HnAw4cU4wH0=
X-Received: by 2002:a54:4083:: with SMTP id i3mr6308210oii.120.1607624281115; 
 Thu, 10 Dec 2020 10:18:01 -0800 (PST)
MIME-Version: 1.0
References: <20201209152812.3215-1-Hawking.Zhang@amd.com>
 <20201209152812.3215-3-Hawking.Zhang@amd.com>
In-Reply-To: <20201209152812.3215-3-Hawking.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Dec 2020 13:17:49 -0500
Message-ID: <CADnq5_N4udDwVdTH3cfDtb7U3aYVwiFcyeHXxkiKOhC73UcLrg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: check gfx pipe availability before
 toggling its interrupts
To: Hawking Zhang <Hawking.Zhang@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Dec 9, 2020 at 10:29 AM Hawking Zhang <Hawking.Zhang@amd.com> wrote:
>
> GUI_IDLE interrupts controlled by CP_INT_CNTL_RING0
> are only applicable to me0 pipe0.
>
> For ASICs that have gfx pipe removed, don't toggle
> those bits.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index ef430f285472..5f4805e4d04a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2633,7 +2633,14 @@ static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
>  static void gfx_v9_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
>                                                bool enable)
>  {
> -       u32 tmp = RREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0);
> +       u32 tmp;
> +
> +       /* don't toggle interrupts that are only applicable
> +        * to me0 pipe0 on AISCs that have me0 removed */
> +       if (!adev->gfx.num_gfx_rings)
> +               return;
> +
> +       tmp= RREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0);
>
>         tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE, enable ? 1 : 0);
>         tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE, enable ? 1 : 0);
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
