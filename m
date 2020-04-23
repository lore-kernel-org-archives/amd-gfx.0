Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959C0C54FCB
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 12:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676BC2077D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 12:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSJ9AEWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676BC2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FD986E52A;
	Thu, 23 Apr 2020 12:31:12 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 033D16E52A
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 12:31:11 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id k13so6632156wrw.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 05:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Dfzn1nY9lJ0Wbo2FCtiRnGfrEYcGHF8RDaOyfeLo12A=;
 b=eSJ9AEWOS0cgf3/XUy00+Okmtn9G3I+ZkMrVpDvOWYsLU2xzDXHlznr89KZPk3PsS7
 e+qRQNs8l4ejAiIF3afzQw2/uxp8ANa/aCdkpTviN/28Nq2LnEht3Z7TF9zxQZfR412s
 GeUCMaiDNf6fR96ymqPAamirUSjii2Ey1AM4Z+CJd7CDf0yxpPuxPywQxS3OGM1gLScB
 bx/B4HqMCd2edEZD9i6gH/Wi3b6/rlOM+rSUEm2x1ulZOjIC4HbaOWriODEhjVQDQv7B
 bLYV4ZonD60OXaAL1ifolNJFMUH4CECHsnWvB1c/7hZqZrjgyw2e32hjI5vcqSjooWnJ
 yuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Dfzn1nY9lJ0Wbo2FCtiRnGfrEYcGHF8RDaOyfeLo12A=;
 b=aA+MdnpiqCdnbp7K1hNcclS83PzhQBQq2XxTIlon3PY25ZYf+bcj6l7UgsD648KkNO
 u1GYdrbIfpBT+28wgEUz27oUErC3YZbq2nMVfpxl8euld2XXCwfDumBdH08NeWf2GXwu
 ryx3A9TOW85q/t4Bqp2NKk8HwOmQI5sffPxiLM1V835MRiJfNIOgmEBMWrk1pU44iSKM
 Eip6um8rKv9qu3EV0JBBW/tsQqh+zyr8fFNd4LK83sot8SME7yb/YT2F/KxQwtN2uhRz
 4saQnZX1iJ3SZht8cuWyI7XahRoKSXz+jSV09AYVXAmbWtHut5eG/Qtfx1/hIeHzulf2
 s8wQ==
X-Gm-Message-State: AGi0PubyvDT903XKLmHCY2yy0cXSnV5q9zG7k4P23Qp0bHsOzQ4VAEym
 5xJT4FibkWD69l019sJowo7a/KLw
X-Google-Smtp-Source: APiQypIm23Kes4a84PStFd44BxeFNSeRFT2Bgy51MOf+u/eDK6V8enlHNgW1h4bydcFHjgbfNdu/ew==
X-Received: by 2002:adf:bb94:: with SMTP id q20mr5052054wrg.105.1587645069397; 
 Thu, 23 Apr 2020 05:31:09 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id c25sm3316345wmb.44.2020.04.23.05.31.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Apr 2020 05:31:08 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: stop cp resume when compute ring test
 failed
To: Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1587632511-12504-1-git-send-email-Hawking.Zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fe584171-c45f-4b97-f141-5f2a516a88c2@gmail.com>
Date: Thu, 23 Apr 2020 14:31:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1587632511-12504-1-git-send-email-Hawking.Zhang@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.04.20 um 11:01 schrieb Hawking Zhang:
> driver should stop cp resume once compute
> ring test failed

Mhm intentionally ignored those errors because the compute rings 
sometimes doesn't come up again after a GPU reset.

We even have the necessary logic in the SW scheduler to redirect the 
jobs to another compute ring when one fails to come up again.

Christian.

>
> Change-Id: I4cd3328f38e0755d0c877484936132d204c9fe50
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 +++-
>   3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index b2f10e3..fcee758 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -3132,7 +3132,9 @@ static int gfx_v7_0_cp_compute_resume(struct amdgpu_device *adev)
>   
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
>   		ring = &adev->gfx.compute_ring[i];
> -		amdgpu_ring_test_helper(ring);
> +		r = amdgpu_ring_test_helper(ring);
> +		if (r)
> +			return r;
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 6c56ced..8dc8e90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4781,7 +4781,9 @@ static int gfx_v8_0_cp_test_all_rings(struct amdgpu_device *adev)
>   
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
>   		ring = &adev->gfx.compute_ring[i];
> -		amdgpu_ring_test_helper(ring);
> +		r = amdgpu_ring_test_helper(ring);
> +		if (r)
> +			return r;
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 09aa5f5..20937059 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3846,7 +3846,9 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
>   
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
>   		ring = &adev->gfx.compute_ring[i];
> -		amdgpu_ring_test_helper(ring);
> +		r = amdgpu_ring_test_helper(ring);
> +		if (r)
> +			return r;
>   	}
>   
>   	gfx_v9_0_enable_gui_idle_interrupt(adev, true);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
