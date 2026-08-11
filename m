Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A70C5B56A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 12:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C56810E6CF;
	Tue, 11 Aug 2026 12:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MciZvOw4";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF1010EAB9
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 07:28:55 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so1983158f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 00:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786433333; x=1787038133; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yDP8FL9MuQ0PXH9ggGxLVTnQzIMzeA/Agxw+EtHBOZU=;
 b=MciZvOw4dfawMEtaXdWx27U2WNjVz2SIqLugpptjGGch+f922TeEElMWeOUXhiJdPJ
 GpZImL1RAxkYLWW+vLWC32o8YJ5VKv9O+l7I1BdAAz2my/5aYyJ2TvyyE6LQP35Bi1nu
 EYsqz7Fxu/A1Bgqm0uzyjWu1XZJffhYHcAYlePpJJhhUAuXV4AbanUoTv/wFvmVE0jiH
 EnbCJn2oVLoX98etvQQOOe6RjQaDG2eplpY/QDOKWL8LJDPemMADxUl0a0kr07xM2u8u
 zxQO1xFgzdeuX7ziHu1R37Jgn4axaB/jSCge4993bMVj9AEklK/W1PkKL+0Hv57InTGQ
 m6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786433333; x=1787038133;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yDP8FL9MuQ0PXH9ggGxLVTnQzIMzeA/Agxw+EtHBOZU=;
 b=Va8KV3GkuHa+udITTPVue0582p+wtnD+fxZtHSoHEAYAbN0W6u9nVmg+TZmtZgyTOU
 6Jl8CRMbdpXJ9ecmXzGr73o7+4gzvmMUOXydqsrSeSpnRw/88JalV8w83pzIsF5Lnzxn
 bq21Orvi5vTTAvG05k5+kCkW3eal5ONvC4dW+it+JOt9lSGC6THlAxDWQEB2Y0TKD1k5
 RH8C6hC3QP78XiUzKwdlrLXCRpE+L2fYSv6x/61ePHv+E3kcLsE/bcFwHY0o4orbU3Uc
 WHrYEjxjeoyDiieTged0aRe3ab46/BztTk4DbU3+rm+CE8Q6NHxudkhAKNrqSmm6GdS9
 i+Ng==
X-Forwarded-Encrypted: i=1;
 AHgh+RprnmcvkkUAzs/shVOoQ4fAQnw1bCe+9HYsVUMe3+LhN+ge7zu1YyZW8FDqHFtNPm4691Z8Uk2G@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyA0pcyZmbKISLP2CuT6Ao90zCpwq4cJiMmUVO7IOeQfbUw8o34
 guftMKmVp+92Hh9mwg5twV+p5LKg6pzioDE4rXvtuX9xtCczN3FrZWVb
X-Gm-Gg: AR+sD12U3LPIc9MfngYDzM9iZCuMV42K4GgsgIrHDaGh09nXEuqoaQeBgSE3blH8MVF
 WvTKjSK2+CHOElOW0K03vDv/fXs9nfcmWLM5iEMwVqV1/WVeVNxsHEHiCe8t9dnJJlCNphgo3pJ
 YN/ZMQ85eGAAC6y5k3TFlOpoRwN7nc8mHh1bYYq73LvNukTQO2fWImuo93ZCnR7t80AEyJHJ+mP
 HjenFV1rCY6OE4mAZTBe3dE+EGsaNBQjCnEGoUCatgdpfHLyLaztZq4LxmcHt4gAfJH3YfuZ+LB
 /cgTb0lCfi+GP5+9mJX+43ZceWDhWWB6jZdFjtfrQEiwy1Jbjjz/pNzAZ1X0U3uYXK+pf8cD972
 UhWbZ8qg0CoQVQMAQln3VC0+MuRvdPRPh0n+fRTNtsqTlkCOVU4W5PKNiZAnwVTUFKLZIVFp1uo
 A0qBRUBIjHAK5ln4uczIoZyzwAvqPC/ydm3b+HFc6N9ev866bUGpDVdhGJsh3YxgEUlfTwfn2XS
 T68
X-Received: by 2002:a05:600c:1381:b0:495:5fdf:2075 with SMTP id
 5b1f17b1804b1-499783a9ef4mr21293835e9.0.1786433333391; 
 Tue, 11 Aug 2026 00:28:53 -0700 (PDT)
Received: from [192.168.10.195] ([188.216.175.96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997415df9asm41374625e9.13.2026.08.11.00.28.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 00:28:52 -0700 (PDT)
Message-ID: <1caea72e-b9c8-452b-a3ff-5690d948b4fc@gmail.com>
Date: Tue, 11 Aug 2026 09:28:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Please revert 1191285ecb42 from 7.1.y
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 George Zhang <george.zhang@amd.com>
References: <9c6acb62-4080-48e6-9ba2-d1c457c4ec88@gmail.com>
 <2026081106-pebbly-cahoots-37a7@gregkh>
 <23db5f95-c2d6-4712-856e-28f647e184f7@leemhuis.info>
Content-Language: en-US, it-IT
From: Sergio Callegari <sergio.callegari@gmail.com>
In-Reply-To: <23db5f95-c2d6-4712-856e-28f647e184f7@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 11 Aug 2026 12:58:16 +0000
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

On 11/08/2026 07:24, Thorsten Leemhuis wrote:
 >
 > And yes, 6.18.y seems affected, too, according to a comment in the
 > ticket linked below.
 >

Yes, my bad I only mentioned 7.1.6 to be quick. My actual concern is 
that the troublesome commit got to the LTS kernels, which I think is the 
biggest issue right now. People may find their display completely black 
or almost black as soon as their DE starts. Getting to the conclusion 
that they need to /reduce/ the brightness to recover is not totally 
obvious and is not applicable at all if you have a system that is 
touchscreen only (since you won't be able to see where to press).

 >> It needs to be reverted in Linus's tree first, otherwise the regression
 >> will be hit when you update to 7.2.

Indeed, but I think the biggest issue is with the LTS kernels right now.

 > Normally I'd agree, but according to one reporter that problem does not
 > happen with 7.2-rc:
 > https://gitlab.freedesktop.org/drm/amd/-/work_items/5562#note_3603131

I'll see if I can try myself the 7.2 RCn series. From my superficial 
analysis of the commits that brought us to the current situation, the 
troublesome commit actually tried to patch on a true issue, namely that 
the user facing brightness data is not mapped symmetrically to the 
hardware data, but that the correct solution involves some more thorough 
rework of the brightness coordinate system. So there may well be some 
larger activity on it on upstream.
 >
 > Given all that I wonder if dropping that commit for now might be the
 > best move.

Personally, I think that dropping on the stable series would be 
beneficial, unless upstream can now offer a correct solution to pick. 
Behavior you get by dropping is not 100% ideal but certainly not as bad 
as what you get with the problematic commit.

Best,
Sergio
