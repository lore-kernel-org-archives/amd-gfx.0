Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279CDC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 14:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8929D112068;
	Thu, 25 Apr 2024 14:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TN8QvL8j";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 916AF112066
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 14:10:58 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-41b5dd5aefaso2829155e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 07:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714054256; x=1714659056; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GySDFDwhS+AiX/KcIKiCOa1MbLbVpTLUU+bTw3qj4jc=;
 b=TN8QvL8jkiOXusAIfsC2NDv5Uv2dfWr+Lt/UiO5hVEdFFBwHDAj3vFi7Z0QF3nAWEm
 lOAzGUAUffy/p7vDYBvXB+PTgk0JVQ1X5jZQygAPBRn9vX2IBxz6sxcqKWQVXiUkAKaX
 2ju/KE/DuVmi2bI6CEIBiVQqCqNj6gbbHpxw+utLWwV0fvcP/BkR8CvxiUlFChUCpRCF
 4QJow3+ZhEMeoboYTNQ+meOGA/VxX2+ikpcNdQDQYVrZ3DvfSDTs5MuzjKmYGipk/SXY
 Ueot69uYMIgofJFaiBvu0X0HlnY2Q5RymyGWdOg1fe1eTcr0vl1fEP96zfsphUpv1e2c
 0ANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714054257; x=1714659057;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GySDFDwhS+AiX/KcIKiCOa1MbLbVpTLUU+bTw3qj4jc=;
 b=wYnv7OEbF6QPisxidhG0ycXQoYuEwJSeWW2TZLvJxcuu0ADiKdo/tWS3PaG0PP+4UT
 RNJ0claXj2IUvd3oJnohHn5Lwu0g34OCzACsznV1GHNQzPMcxqecRungqLGuDZ6RdGTd
 HoL0w7W7pI3VM1mC7UFidxyk/ScNgATaKex3UcriJGkp5Qrr9RNZDGCL3D8rLXwRm9Vp
 9ZuHRQZVHVK1jVP/9z1NF56sw3js26c9TfmjAR1wlem+SXcbldKXCAzyZ1C75wVfieVB
 aa8HeChNLAF2Bb/Hca3k3lyhdcxHrtiuecZ4OadWNEmRVBd+ZIeiB4Y141v4kWxrSeCV
 WfyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5Y51VoF/8vf2gn2KFmUzUPMP9gkyeiZbh30izWNG2pSeFK+kPuyxL1y4SpppF1R0yDxcdVDdME9bO2dyG+i18R84nf/2w1QiFAmzPlA==
X-Gm-Message-State: AOJu0YwZpGQrNlxMnHVCMAOZMbre0wBlKIuqk+dDDJTV3jsk0L1SFggl
 zJI1wx6yrF4v44PUNbpDYbXydqU/vX2S/nYfSGCxum+G/swmvLlL
X-Google-Smtp-Source: AGHT+IFHzkTL8O4RQtGlwe7N+GgG+Kf6AqoAaOwplssepVX2BBG7BV/dyXkHPYjoXYYsuME9QnYA1A==
X-Received: by 2002:a05:600c:4e92:b0:41a:4a8c:8a3d with SMTP id
 f18-20020a05600c4e9200b0041a4a8c8a3dmr5431070wmq.28.1714054256358; 
 Thu, 25 Apr 2024 07:10:56 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a05600c138b00b004187450e4cesm31322447wmf.29.2024.04.25.07.10.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 07:10:56 -0700 (PDT)
Message-ID: <ee7b9ab7-bbe8-4254-bf90-df6775a2e31d@gmail.com>
Date: Thu, 25 Apr 2024 16:10:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix two reset triggered in a row
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240422194550.26148-1-Yunxiang.Li@amd.com>
 <572623ed-f353-46f2-809e-4678b152fa5e@amd.com>
 <eab5193a-7613-4733-a006-9eaf5598647a@amd.com>
 <a9797ada-63b8-4d3b-827e-f8173ae03abb@gmail.com>
 <SA1PR12MB85997F18F0D3FCBF528AAFA5ED102@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <SA1PR12MB85997F18F0D3FCBF528AAFA5ED102@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 24.04.24 um 15:13 schrieb Li, Yunxiang (Teddy):
> [Public]
>
>> We have the KFD, FLR, the per engine one in the scheduler and IIRC one more for the CP (illegal operation and register write).
>>
>> I'm not sure about the CP one, but all others should be handled correctly with the V2 patch as far as I can see.
> Where can I find the CP one? Nothing came up when I search for amdgpu_device_gpu_recover

I had to dig that up as well in the code since I haven't looked into it 
in years.

Looks like that is handled by the scheduler work item now as well. See 
function gfx_v9_0_fault() for an example.

Regards,
Christian.
