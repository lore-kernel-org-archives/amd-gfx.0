Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06C4C4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 06:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D0C410F379;
	Fri,  3 May 2024 06:32:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H2FfqaGY";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D55F910F379
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 06:32:32 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-41ba1ba55e8so52159135e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 May 2024 23:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714717951; x=1715322751; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/cy2tNQlUL3iGyYOAmCnCq9CpKp6YM/DbXKvPPx5Gtw=;
 b=H2FfqaGYWi1q3a3QOENQ7g5oJitwiqB4gumsBtNi8mNPBnkokUH7WharnbjPqm8re0
 SN2iA2T4py/HhzvypbQRmCpcBZZaMLG3bYvF9BqY6Lm2ZkiBbaMACpd694gMA31v0Xh0
 s3TeaTNOpKtBWJleEp12Gd8xCXJPFY0zfO7XLHvExZpm1yFOl4Dt0Wf1/ScRahru5nHi
 cMcyRi3u1ZmiO39JmcoBL+DwuyCAAGne8hQgf1xhkVyMGrgvjLGfsdCT1/6i3YK8P9cf
 rPFM8aiPb1r1c/ACoampvyYOXpj1ugrZV/MCeBRkDewS30uZ7zWNDBYZpY9uhxcSK+FV
 jiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714717951; x=1715322751;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/cy2tNQlUL3iGyYOAmCnCq9CpKp6YM/DbXKvPPx5Gtw=;
 b=cR1PAxAgpTYEK/zpDMrZv5vRZ3j8H9TOFNgBxyUgJFBM5thrTB/iV10mReSDzKhdld
 49m11SzH/r7e6cC0Xyj0XFTz3YbMuLDCSPMvynG9OnqvhdzCa1oTB4ANFNhhR1i/154F
 CTlEIcjDfAvcU3zS8OCtsZVOcXjFYLrvlrStw9ty08MFGW/CCBECHZClQGK3y2AAGqHV
 vfCTrMnV1SWBPjCtZzHFh2XGB/jeMQSbDOG/grPiHnRSK5X06BU2pCRQKXbjk+8+aMia
 zgTp1RJw268TDA6sM7uqiNTs34GixNCyzKfCkxBcKXLnFeNQNo8YZGH0XOidk0YDTNXq
 IdCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL2z5duKjaDepfRP/rfuGsdUVIDNBk2k8z67q7Gd6p/0bPanDz/YmqMOr221uqwg3ZPU3kE0CO3wV+19G3/uB4B7zMiEJJHphWaPkxig==
X-Gm-Message-State: AOJu0Yw2Iwr7SH1fw3Hb+6f6W9/k6xgUu7VlyEuairUaYDB6SJWIQVb0
 pLsj8LPM6FD1RvG+zFnp3s3z1FrbuydneNrz0WOAcdi5cMQhEYGU
X-Google-Smtp-Source: AGHT+IFwTMDWvCrgXTyvCiZSl1Shc0w6apP1ZwYgef/yPcuCVGPcwv9rPMrdxEL7VMhwoxNEsvWzKA==
X-Received: by 2002:a05:600c:500f:b0:41a:446b:10df with SMTP id
 n15-20020a05600c500f00b0041a446b10dfmr1479888wmr.12.1714717951020; 
 Thu, 02 May 2024 23:32:31 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a05600c469100b0041b083e16e2sm8265425wmo.2.2024.05.02.23.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 23:32:30 -0700 (PDT)
Message-ID: <f46d19a6-d2cf-459d-a68b-95790a0778eb@gmail.com>
Date: Fri, 3 May 2024 08:32:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Describe preemptible objects in debugfs
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Felix Kuehling <felix.kuehling@amd.com>
References: <20240429164707.49196-1-tursulin@igalia.com>
 <20240429164707.49196-3-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240429164707.49196-3-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



Am 29.04.24 um 18:47 schrieb Tvrtko Ursulin:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Instead of mixing them together with regular system memory objects mark
> them explicitly as 'PREEMPTIBLE'.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> ---
> No idea on the name to use.. :)
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index eb5bd6962560..be6c2f5b9fcb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1599,6 +1599,9 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
>   		case TTM_PL_TT:
>   			placement = "GTT";
>   			break;
> +		case AMDGPU_PL_PREEMPT:
> +			placement = "PREEMPTIBLE";
> +			break;

While at it please ass cases for OA, GWS and GDS as well.

With that done the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Thanks,
Christian.

>   		case TTM_PL_SYSTEM:
>   		default:
>   			placement = "CPU";

