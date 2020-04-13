Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C42C2BA2B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 15:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF1A2072D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 15:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7eqRinw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF1A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7842D89DA7;
	Mon, 13 Apr 2020 15:12:38 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9380189D84;
 Mon, 13 Apr 2020 15:12:36 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id k11so9883749wrp.5;
 Mon, 13 Apr 2020 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=miTpPmRVhDhvijKW/x5oMYTRNn8wvs0mLO5J0nr2084=;
 b=U7eqRinwsYrq6IXBxzyvvKAcVM+VYOkoiiIpkOLjJI/+uGkiQ2ae19esSWNmX7/55x
 HLE1SQmDAHBajHl1h3Zvpge1o1RT3GQVhMVRodlQW3VO5iGEcuqlvLsRnqh6mH1AdUYj
 vagO0XSwWvclpM/77+sVeGD6j9xh08Wsz+91K3i9dj20TbwbY4DX0Qn994aJVc5XwUVK
 M0o3YAn9eyqIVMFO923iGZfMpmTUdxTDGhleGVq4wnNC+1pZDSMSTPfdFATABJHIQwPx
 dthoumPisb59N7MwkZXcwAHOOnNbLsLCO1EA7iiaSQ4Wto8XAePzLitKlTn3lj43zuDR
 rKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=miTpPmRVhDhvijKW/x5oMYTRNn8wvs0mLO5J0nr2084=;
 b=RS/58Z2upzE99tuomm16OPnlLFEt7dgBlmGc9O7mFNak/VL8dXTlmGICXFHWLl/JWl
 RsFVmaZ0PFXbJbapkzItXPxmu+QcnswhPFTCw/ti0jz00H8Gdr7md21ESX4K4fbTse8k
 uWkpLlkYkn+3exGfoX1HxESVcUoowdaIEQ4/BH+1VEk8iYmoeVis1Yc/0Ka5d4RObq8l
 nUN2GQoxe980lO7LphcfE25wPv5tn/gXw3z54tZJsMlaqmnawQm8mOvs9/MSuhIwcMRm
 2LIPWG8WNDEQcjKAkmiTHzhvAtbzz8Ufv9HFYato+jpkqnSi9L3nBU0GkZDfICLZr5nJ
 poyA==
X-Gm-Message-State: AGi0PuZHiZESJWPDmQsta9m2VA90lMifvt+t48y74RhX4mouIRsIXcji
 0J5yKTfKv+vTZX5L2bEdLXG4Ea37h8rpbBAonRk=
X-Google-Smtp-Source: APiQypIlLep4ObkUpbnYLb9374cQ+lM33eeD4kNIbr7Zh/DtnITfyepbEUmDzUasVC3tnJvdqsT5XjWr66ibsXXlM/s=
X-Received: by 2002:a5d:498d:: with SMTP id r13mr14736737wrq.374.1586790755179; 
 Mon, 13 Apr 2020 08:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200409012815.22309-1-mail@aurabindo.in>
In-Reply-To: <20200409012815.22309-1-mail@aurabindo.in>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Apr 2020 11:12:23 -0400
Message-ID: <CADnq5_O+xg1Lro4UP3+_4GdkDQk-HzJaXMWzWWSn0ZiYG9Xt7A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/amd/amdgpu: Add print format prefix
To: Aurabindo Pillai <mail@aurabindo.in>
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
Cc: Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 8, 2020 at 9:42 PM Aurabindo Pillai <mail@aurabindo.in> wrote:
>
> Changes in v2
>
> * Add dev_fmt format prefix
> * Removed hardcoded module names in pr_* and dev_* prints
>
> Aurabindo Pillai (3):
>   drm/amd/amdgpu: add prefix for pr_* prints
>   drm/amd/amdgpu: add print prefix for dev_* variants
>   drm/amd/amdgpu: remove hardcoded module name in prints

Applied.  thanks!

Alex

>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h              | 12 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c          |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c            |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c            |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c            |  2 +-
>  7 files changed, 21 insertions(+), 9 deletions(-)
>
> --
> 2.26.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
