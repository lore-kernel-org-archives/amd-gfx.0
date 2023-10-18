Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA983CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 06:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B5010E380;
	Wed, 18 Oct 2023 06:00:16 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C8410E380
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 06:00:14 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40572aeb673so60433225e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 23:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697608812; x=1698213612; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0nXxpNC+hidsNPRgxFWG8u7vCk0zPnT+0lOswQPOBNA=;
 b=ly7aADbdcr7liX/+FbWR/b037ML7fLyMMfB+KlPj10yo6RFalnr2kL5eVAke93XvGX
 7o7lpvtG7I3niDp8m4VI221Y2YofHHYnf18gBAGqgZFVkWsWNCQ4gN9ISqm+jTFjsdpw
 w8h9o+zTCG+3/UsuqGtmrrFF6GLt0jyFAwIgvlz9nQlsE6anXRHhVHdx55uDHbPwFZyQ
 QEt3wiDoGdHo8cmceO3hsPGAmKcOqj6sgkfwQ51OG6kzDY9ogZWkcn02docntycxPtAt
 n1wujBhg/pT1LhrTfxY3LIxM7YEnuBPXURFcV/o2A+edHg+enjD2j8AgWJpogY9dGuS9
 lg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697608812; x=1698213612;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0nXxpNC+hidsNPRgxFWG8u7vCk0zPnT+0lOswQPOBNA=;
 b=sQ17zynopuL/cQ+PbCgzFzK/eLD8a0Z/7eZ+U16fJUpK+DUHFbV2Xq7VNdtckiZqou
 2eO+T/ow0deC8d0+Dw8LzuJvCW7puIred04jhFnzufnQ+a6Z8Q+rw4AQyfG8Zgtfoz+9
 rQbTqbaHguLqhq99bdz9Wg6P3I6o9fo7qMloGjodjYn7dQqAuOKm1dXrxL7ajrfFEz7J
 AU8Kq8G0L0BWeuNKP7eAznwNpucueQfh3k+5sMIEf2k6kIQX5NpZ6FjW+KPST6JWsJic
 /L4SpI71sau+oGBDelPP/FbD1Jt9/aJZpQTdJ+5aRY3sU8xOBY5w19q4XaU8D8DfT7Ar
 c+/Q==
X-Gm-Message-State: AOJu0YxOQOm0vwHbXoI8ve9a0BWf8nl1s7S11AAdqo9WfoEBef/66Si2
 s+hFYPwls35cw63n4LLWFhw=
X-Google-Smtp-Source: AGHT+IFePBMQ9NFKLOS14nW4BF9BZ0dAeKbupEZ2Auu4Ciy4rTlf8dDkq8M4JGqiArU5E3kzhyTHsA==
X-Received: by 2002:a5d:6047:0:b0:316:f24b:597a with SMTP id
 j7-20020a5d6047000000b00316f24b597amr3698539wrt.46.1697608812192; 
 Tue, 17 Oct 2023 23:00:12 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 j6-20020adff006000000b003198a9d758dsm1267925wro.78.2023.10.17.23.00.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 23:00:11 -0700 (PDT)
Message-ID: <f0189dfe-4275-4e5d-ad57-67e9facbdc5c@gmail.com>
Date: Wed, 18 Oct 2023 08:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu remove restriction of sriov max_pfn on Vega10
Content-Language: en-US
To: "Lin.Cao" <lincao12@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231018023927.56093-1-lincao12@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231018023927.56093-1-lincao12@amd.com>
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
Cc: zhenguo.yin@amd.com, horace.chen@amd.com, haijun.chang@amd.com,
 jingwen.chen2@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.10.23 um 04:39 schrieb Lin.Cao:
> Remove restriction of sriov max_pfn so that TBA and TMA can move to high
> 47 bits address.
>
> Regression test: change range alloc flag of libdrm as
> AMDGPU_VA_RANGE_HIGH and there is no flr occur when testing amdgpu_test
> of drm.
>
> Signed-off-by: Lin.Cao <lincao12@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 3a1050344b59..b1eb81ca64bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2023,11 +2023,8 @@ static int gmc_v9_0_sw_init(void *handle)
>   		 * vm size is 256TB (48bit), maximum size of Vega10,
>   		 * block size 512 (9bit)
>   		 */
> -		/* sriov restrict max_pfn below AMDGPU_GMC_HOLE */
> -		if (amdgpu_sriov_vf(adev))
> -			amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 47);
> -		else
> -			amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
> +
> +		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
>   		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
>   			adev->gmc.translate_further = adev->vm_manager.num_level > 1;
>   		break;

