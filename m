Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A85C021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8423210E37E;
	Mon, 24 Feb 2025 13:35:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e9IgMNPr";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 608CF10E0D5
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Feb 2025 21:18:20 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-5dedd4782c6so6078616a12.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Feb 2025 13:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740259098; x=1740863898; darn=lists.freedesktop.org;
 h=content-transfer-encoding:subject:from:content-language:to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wl//xXq/3oQzyubtwetpCXZ61uSz2VW3BDC46+HYJKE=;
 b=e9IgMNPr9sCtKQnOPwUTwmmnFRtWIZW2o+68kaEv4r7Y1Pw9KMRHRBiHPPvAD9VmNb
 6bFTSGfSpB5zGVqFO8fulqMI1M3Cz498cF0xkppCNgMVlLwJQRgLYeabsaSLIHmCJiGK
 nN/P/yGU4bcN1ssiJhLUpE4FXPXywKo4CFZQkbS0m/ljh+MoTX6kFWmzpQMIASgXvojg
 Ahka7Z79lGCLVJJeiah0pL2j5po4pivZ9cH41rAoicNQKtjc1rNh5I7lyMUItu9JS0SF
 nkXxXD5TqWiiB3FMP7tMV+Lw5zsGX8zduAp/+w6YR2DYiVA9l5KH9tuKD6MA3lfxaHr0
 WTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740259098; x=1740863898;
 h=content-transfer-encoding:subject:from:content-language:to
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wl//xXq/3oQzyubtwetpCXZ61uSz2VW3BDC46+HYJKE=;
 b=hItJdVR5565GfFsf6cotHu2fDxnFyde4+HRM+GChYlVFyUVPGqPFZy5gSMbIynmtYR
 kCztZXy1eX/4DrXt9AbVj8eUgFyhqgYZBI1gEIGX/HxBPK1wPUbVu8mo21rdvXobMW6D
 0XsyjEPLq0NEM3dmRe/dfAq1iqHHmD4RBLPUZEx5IWLPbQJOOW1tjaOJwMiQwf2WA8Vf
 WiwE9ZMAP/Z80Fa8wirzCWCUGPh8U8AdRt29NZeLj4VMIKDheTjnk5wMSNG3FIR1J1Rd
 SykTKqt1ZTZX/1CqpCffUGmBzPkCshYiWu8Qitv5OtH1E/Px7FnTF3i/LuGL43/vMlOP
 IVCA==
X-Gm-Message-State: AOJu0Yxdu22dnFzf8wTsx8rNo3TlszA7Y1qWv1LwRVk8qnUD9lmHWPGR
 I00eIWrmTfO2tutZ1p48eU2TPYPrRZz0aHu7eC2T9IF/e5TlsUIxSZ344g==
X-Gm-Gg: ASbGnctjlVA6WadYvwtZW4Uy+7Je/KdDF96XA/yegQzqce/whVr6s++RWeowtD91viK
 6GK7b2Txan4fLbsS+NINMo15umqzzTXE5rilh9Q5eqo6+HqfPQfosn21T8Ry+3TpD96sskcT2X5
 VE2nYetb7Ev5ZpW5UvGLcwHXst+J6aSc/roR4p2OWDFY4bO9hOw3iKCsT7PkeSjziPH/8uTHeKc
 Iu7Xhhh5jFH4rZl5Svg0Xm+aR+Mq/IzqctSdUw3zj1UCcB08i1xWkhk4o7G3J34acaY/6Q6jXGf
 bbbfDaYVmLtaMZMpnvIXT5mf9yixBISfEQ==
X-Google-Smtp-Source: AGHT+IEDkjU57HWitrIeUTKu3Ua7oKrYbzMrBgToo/Yj0cqICg1A0XlHlogYlqNc3rCdoE1JK4ApQg==
X-Received: by 2002:a05:6402:43c8:b0:5e0:8b68:ffae with SMTP id
 4fb4d7f45d1cf-5e0b70f9ac6mr7177992a12.17.1740259098366; 
 Sat, 22 Feb 2025 13:18:18 -0800 (PST)
Received: from [192.168.2.222] ([185.95.176.207])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece288e2dsm15855907a12.80.2025.02.22.13.18.16
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Feb 2025 13:18:17 -0800 (PST)
Message-ID: <9b208693-0836-4818-b2f9-6d6eceaaa357@gmail.com>
Date: Sat, 22 Feb 2025 22:18:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: amd-gfx@lists.freedesktop.org
Content-Language: en-US
From: Jaap Aart <jaap.aarts1@gmail.com>
Subject: [amdgpu] Kernel OOPS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 24 Feb 2025 13:35:11 +0000
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

Hello all!

Before I spam this list with an unrelated bug report, would this be the 
best place to report linux amdgpu kernel bugs/page faults?
I found this list on a very old reddit thread, don't want to end up 
mailing the wrong place.

- Jaap

