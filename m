Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B95C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 12:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B0593C15;
	Tue, 12 Jul 2022 12:20:38 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 237F793C1B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 12:20:37 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id eq6so9877267edb.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 05:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=1Q9Bfry6JLChmL8AgB3Ham5O21Kab4lOyoyfxN/Ls5U=;
 b=SEOFLVXC0Hlz30zEVQObpR72fuYI6dcmtguB/YJHdcsyVkYY9uugN/TuNBbVauP65M
 H+pwnd0VrMW7JI//HwjoYeucdMvFoi+km5Pzt0ZZOJExCgJ6PEaddNurjTbkqe3O0kI6
 Ix/23vWjQAitSsPw8nJu2uOGvwYGG1MVIsZRtuCj8QCUrM/VRcAArKkSHHEGsKGkYTsW
 Z1aG7hfF0loIC0Vahu8Bd73YmEVocZdicRFMQC2VirwL6W/2Y3jVZHDAEJBMaP7hrqxQ
 Fap1upftt4YMPZOh8MycYfEu2bjdRJ1kttnUWIRUKRsw94yFkfcOlxGEPZEIJfKcfUNc
 0NOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=1Q9Bfry6JLChmL8AgB3Ham5O21Kab4lOyoyfxN/Ls5U=;
 b=nqWqJo1BZO0Kq7WN5JO/OGL6Ywhe+IFdjdJUG3au1rKBmOJQzWg6YouXxffmsixRVW
 sBMQfT1uvNWkxULWG4EeOnvnDEUlgKeRUoK52QQhOZ/iRWv01RY+k6gSAjluQqB+wNGZ
 nNa9YnvPbRHy6EMqsPHIk1xZTk9zOcmU8xYBIz6Hj00FVcBQbdKe3R+zBhZ8p7kRToT2
 qvsuqGVS3ZBVvmFX25XgGiVUikgcLzMrIVus5De1cY0fLCd+04Jjy9HjqHDxPpJsExaB
 4g/qEwshiDKk3yLLhcN3dF5x9TJs467rqJJ9dL2m6+0CSWeX/upe1zU0rZLN0GBQeKaD
 tYhw==
X-Gm-Message-State: AJIora+Ees5fC+Q9FVyPeJdFNIW1zJt+fkrIEDW/KhIwSkIE4yecYOnm
 6R924ypBfaPkPG5l7xeGudg=
X-Google-Smtp-Source: AGRyM1uZb/qcZe783slXUqF+wvPPO7ONiviotWWy+OmSgv3GS2//7W2QuL0zbcjFQclzFZMlMfYDGQ==
X-Received: by 2002:a05:6402:26d5:b0:43a:bf2a:c27b with SMTP id
 x21-20020a05640226d500b0043abf2ac27bmr24263082edd.61.1657628435533; 
 Tue, 12 Jul 2022 05:20:35 -0700 (PDT)
Received: from [192.168.178.21] (p57b0bd9f.dip0.t-ipconnect.de.
 [87.176.189.159]) by smtp.gmail.com with ESMTPSA id
 x18-20020a170906711200b00722e5b234basm3775162ejj.179.2022.07.12.05.20.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Jul 2022 05:20:35 -0700 (PDT)
Message-ID: <396bb4d6-4162-5b4b-7814-2061e15e0de8@gmail.com>
Date: Tue, 12 Jul 2022 14:20:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: Fix acronym typo in glossary
Content-Language: en-US
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220712121233.187868-1-kent.russell@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220712121233.187868-1-kent.russell@amd.com>
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

Am 12.07.22 um 14:12 schrieb Kent Russell:
> The initialism of RunList Controller is RLC, not RCL
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   Documentation/gpu/amdgpu/amdgpu-glossary.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> index db924d37f93e..326896e9800d 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -75,7 +75,7 @@ we have a dedicated glossary for Display Core at
>       PSP
>           Platform Security Processor
>   
> -    RCL
> +    RLC
>         RunList Controller
>   
>       SDMA

