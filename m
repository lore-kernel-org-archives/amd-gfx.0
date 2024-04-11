Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CA1CD128A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 07:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E6210F23A;
	Thu, 11 Apr 2024 07:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="hwK+xfHh";
	dkim-atps=neutral
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com
 [209.85.161.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7779310EBD9
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 01:11:07 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id
 006d021491bc7-5aa1bf6cb40so2410745eaf.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 18:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1712797866; x=1713402666; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K7z1/Srv4eZ2vooDSDvwwBej5oDKDz5itKY0SDj8VoQ=;
 b=hwK+xfHhhHlcxfr4VCLveLGcqKS7aWzZyf0pV0RRPkb4OU13FQn8tA6qgM+zWwdyRC
 FvPb26HfIsmN9sdzoc23PDk6rfTHDvPo0GoniCgWq2AiGxqnOAZFBHufCQDuT3G9fy9K
 32FI78XIC9uIGC644fLAJM1PlvA9YTU/RLORFRTmKbh40PGzqaWS/UsmU3rq1GbJAbrU
 JbXIr2CTyHxb3snvb54As8RC4ZwkkXqHaNyx5tiiJiIWijGIJGPsk00/Jc7l36OEnHrB
 xIETgRoEQehHMpPYp4BaTYBR3ASzgCLz/+l0DezteRZLpyfoGR0BY11ZLe09QoiATd+z
 Sq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712797866; x=1713402666;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K7z1/Srv4eZ2vooDSDvwwBej5oDKDz5itKY0SDj8VoQ=;
 b=DCTxfw1QKvAeFbxPi7u1Iwm6V3H13ey9LeX5satQOak65wjc5i/BjEpZoS6jpGrMfS
 OHRIFYHUH6FW1zEvmVggA9HhxEMgZi08DbJKvMzErfCeUgHby3PyZBDjW982UXxi5iHI
 BO3+GWBpL0PBgPry+wbN0ntf+UWF2jfW5k6xkLYj4wqvPW/i1g9DQpn7znAgIkr6to8Y
 VKHWMlqMstFkwgMQCgJOEA4N/BARxg2BLqQ//fYdLWOCkcR8DqpnssPxbSH1zLMoNz6L
 RjF/5tU0kpt0sTB+efkZ6ywp3ZEOG55B/UngR9PeHrTLy1wvNGetUWtimFmMUEGEuT+g
 9Snw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjts9n1LeU3Z53928YgFSUauUSX7voFndwu0g75fF5AM6wHbJXF5opH2B2+PzjRYzITwi8QlEOJvQHJCgqoyWY6JlBwVjAqqL8BgpU4A==
X-Gm-Message-State: AOJu0YwOmdV/8pv/SWXtsLedUvLAeRuplMch9BtgruhsTAAJ8Ut4Ra8c
 vic9woXI8R2sXftllv/Zo+1SmBLB+RG6Ns1pMJSoHI2/eaB8JRUHfpqG3US0690=
X-Google-Smtp-Source: AGHT+IFvdAWGolMk2tEZ8bM2BAlC1TsYZtb/fNUYXyTQY+hWEfuiEC430lr0paNhGs3so4u/3MehIA==
X-Received: by 2002:a4a:e9f3:0:b0:5aa:6a28:27ea with SMTP id
 w19-20020a4ae9f3000000b005aa6a2827eamr3725829ooc.6.1712797866523; 
 Wed, 10 Apr 2024 18:11:06 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.8.167]) by smtp.gmail.com with ESMTPSA id
 db1-20020a056820270100b005a4bc907f0asm113158oob.15.2024.04.10.18.11.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 18:11:06 -0700 (PDT)
Message-ID: <4c8e63d6-ba33-47fe-8150-59eba8babf2d@sifive.com>
Date: Wed, 10 Apr 2024 20:11:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
To: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com>
 <87wmp4oo3y.fsf@linaro.org> <75a37a4b-f516-40a3-b6b5-4aa1636f9b60@sifive.com>
 <87wmp4ogoe.fsf@linaro.org>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <87wmp4ogoe.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 11 Apr 2024 07:41:32 +0000
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

Hi Thiago,

On 2024-04-10 8:02 PM, Thiago Jung Bauermann wrote:
> Samuel Holland <samuel.holland@sifive.com> writes:
>> On 2024-04-10 5:21 PM, Thiago Jung Bauermann wrote:
>>>
>>> Unfortunately this patch causes build failures on arm with allyesconfig
>>> and allmodconfig. Tested with next-20240410.
> 
> <snip>
> 
>> In both cases, the issue is that the toolchain requires runtime support to
>> convert between `unsigned long long` and `double`, even when hardware FP is
>> enabled. There was some past discussion about GCC inlining some of these
>> conversions[1], but that did not get implemented.
> 
> Thank you for the explanation and the bugzilla reference. I added a
> comment there mentioning that the problem came up again with this patch
> series.
> 
>> The short-term fix would be to drop the `select ARCH_HAS_KERNEL_FPU_SUPPORT` for
>> 32-bit arm until we can provide these runtime library functions.
> 
> Does this mean that patch 2 in this series:
> 
> [PATCH v4 02/15] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
> 
> will be dropped?

No, because later patches in the series (3, 6) depend on the definition of
CC_FLAGS_FPU from that patch. I will need to send a fixup patch unless I can
find a GPL-2 compatible implementation of the runtime library functions.

Regards,
Samuel

