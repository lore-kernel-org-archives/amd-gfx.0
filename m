Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05A9C5B543
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 09:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59D6210EA0F;
	Thu,  5 Jun 2025 09:22:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kTEuMPQY";
	dkim-atps=neutral
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9B7610E9F8
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 09:22:00 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-4a3db0666f2so15719941cf.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Jun 2025 02:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749115320; x=1749720120; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uTnTofBFQ3Gs3suN2Rxi/3q7K5/6QP8g5lk6astGv0k=;
 b=kTEuMPQYx4AhS0y82lpCOtwYlUfH6KaoWsCHNW6A9IeHvCEXtmhpi/M0aVFKzib53x
 NNDWc8zOM4XNG3M6/KJzoZOqH4YdxbO9x5s90evCjjb+LuovLX1j75oE9+DdwAGOxon6
 UAQNZxkZFbN9tIWON9IHzX8w5mzmuaTyH589j2R76IKv3EH1+U4pD4ASAQGhFNNwf0Hg
 85gE5GcwKHovYNGh51Uq5L6pJQVGx2XR2rsN0vZNpHb60iadHGDNX1WMJ0KkXjVfVxbI
 5OCg9WuEAs80FmB7vnKzn6/mlrf0ZWiHYkLXtEiR1LqHwq02BhLH5Rg2WgLp6wVSI0PE
 peaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749115320; x=1749720120;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uTnTofBFQ3Gs3suN2Rxi/3q7K5/6QP8g5lk6astGv0k=;
 b=ALyIFdoaqO0LoDLjL8QFqx3TFj3lkz+d4rWtOgv8zdlrEBFurX8Rc/WPBKqPsLcFQv
 A/qXAAEQiD/Pr4Dpstq8nq0lMKH8XjDCUUe3+w/kFFJN6Iiqs2u78ON73dAW+tLSlXRQ
 3NT0gno1fpLLiiiLg0ZdhwNuLqR9uQbLsSVAjFw84utOXMl3IpW4J64KW5Fi4/JOvwXm
 EdpnNSwR/uNTq+HWl6QIA1IoSS9Yrsz+t5+Zwon7t39AP4YlORJj/z82nfgB4atsnd7S
 /0LsrRTxHtlZDdWDPJPrK9IGmHrWdhoqvE90A26FZ4bKsqevPVzxhmziZTCBU89OllQs
 a8Dg==
X-Gm-Message-State: AOJu0YzjhFcg5x6dnGJXvpvvS3K9o7VPvb1atUDQZVaAJ2zaIAx6El5A
 66UWcSyGW77DRXoz1kz5qtPZBMd/fLRPZKMGTLCFnGqbcs2ySz6qb8GCm9iEk5Pu
X-Gm-Gg: ASbGncvTWvFvdjVQmjnzQc/F9F0dBmrymElctfMeV2EBDlbymLyMwDRExUWDtuS3gwh
 NtVxg7f24PWAQ7mnkrHR51yKzjfvUF6rHVVTbbC75d29dYfS1DCHKU+xviuhUE73v9AedKFuWQP
 usm8WKLOEKuI72TUSASICXRY1DwXlB4yC0dxGkE78HGVluXcp73hh18xeQUkys5644CXPtLd8bU
 jgR+iPxXochmNBuGATG0xwUizNTMIoXaEiYgKlr2ebjSN8JDhZQjgt9bFkGTXcfj3kYaNcqdln4
 KskBgjH/MezC5ph/EMS/nGu+v31gNZ1be3b6i/CZl1cQQR1TxcFM3ld49roLSrflFeE5af0=
X-Google-Smtp-Source: AGHT+IGHEph6qvivxJXB9IRjiqMeVABstwlzgSNVwU23NHl8YlBS6t+p7X2pU84B4m141jbr9gBlrw==
X-Received: by 2002:a05:622a:4a0e:b0:476:add4:d2cf with SMTP id
 d75a77b69052e-4a5a5757ce7mr114011451cf.16.1749115308512; 
 Thu, 05 Jun 2025 02:21:48 -0700 (PDT)
Received: from [192.168.1.100] ([32.220.111.111])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-6fafdfee8f6sm20893306d6.91.2025.06.05.02.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 02:21:48 -0700 (PDT)
Message-ID: <450fa7e8-5d91-46e8-8b01-1195fe437a7a@gmail.com>
Date: Thu, 5 Jun 2025 05:21:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] drm/amdgpu/uvd: Ensure vcpu bos are within the
 uvd segment
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-3-john.olender@gmail.com>
 <CADnq5_OBUWJj5uqbB78wLkbBAMtoRUy=Nes1O6garEQceCLB3Q@mail.gmail.com>
 <b09012e2-f361-46b5-afbf-313334fad69a@amd.com>
Content-Language: en-US
From: John Olender <john.olender@gmail.com>
In-Reply-To: <b09012e2-f361-46b5-afbf-313334fad69a@amd.com>
Content-Type: text/plain; charset=UTF-8
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

On 5/2/25 4:36 AM, Christian König wrote:
>> I think we can just make this VRAM only.  Or something like:
>> adev->uvd.address_64_bit ? AMDGPU_GEM_DOMAIN_GTT : AMDGPU_GEM_DOMAIN_VRAM
> Yeah completely agree. It's a good catch, but the solution is incorrect.
> 
> On the older UVD MC interface the FW needs to be in VRAM or the validation fails. If it's inside the window for the message and fence is actually irrelevant.
> 
> So something like AMDGPU_GEM_DOMAIN_VRAM | (adev->uvd.address_64_bit ? AMDGPU_GEM_DOMAIN_GTT : 0) would be correct I think.
> 
>> If that fixes it, this should be tagged with:
>> Fixes: 58ab2c08d708 ("drm/amdgpu: use VRAM|GTT for a bunch of kernel
>> allocations")
> And CC stable I think.
> 
> Regards,
> Christian.
> 
>> Alex

The simplified patch needs this change to the vcpu bo domain.  Would you
prefer this change as a separate patch?

Thanks,
John
