Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87C2C0219E
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 07:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2581810E42C;
	Tue, 11 Feb 2025 07:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nPMqZlEW";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6958910E22D
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 00:23:45 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-5de63846e56so4734250a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 16:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739233424; x=1739838224; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sd2FUPh0dF8GgciixwOqtbSkDaCYkxNrRhz90b6befA=;
 b=nPMqZlEWdap6vaXzbZAT3msCAmCVdkx4VMjXWscBrtBGQYORj7lPBb43DLNCVm2ho5
 E1lshcFSTDjaGlmgDX9bEjsztenqbaGox+aDCRJhbvstioBRFT4T/VvXRVwg3hQ/SWOJ
 eOkp0EPxLDbZhIN9phnsE2LxrQSYqlu2W6h+rEV4aueZ2XVq4tvqEwyU/OodpRR0yG1T
 RsuQdPq5vXxJ7o2IXR3HT6RrcobdVwpo5VALjFupQf6lgbUG+eQimRj5TC678I0uBTda
 LfIFtBak9nU6sfKNF5a7/pzvIOMNpAaDKcDuyRdLNwZxh9hg4yfIXvGFWddF3vQu8rh3
 AkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739233424; x=1739838224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sd2FUPh0dF8GgciixwOqtbSkDaCYkxNrRhz90b6befA=;
 b=mMdO0Ll2IT1Talg5hxk92wrw7Edssikhc/y5FWNwguZRbsDJlORlSsphtvaSV32PJ4
 Vr79+wTmucgkl8mcQaWaExtIvhJ0BCH+F8tCd4BpZOozuiL7mFiZSIFj5dypNpd4bAtK
 6ouiOuckljYEnv7eB8vuHm+hdK+GPTukqImZ0Hrm+pmZNyynPqilmYlnmxmKMFjrWs0w
 YJGYQuir9mXHR0uQe0VEL4FTf5ewjWDOJ4NyJrLbhi0dxSkWhIdXnLVaGDWBglvmK0dM
 6etkYl0BsDNIAsSC80qCKQcmF8dF3q8lrK8pH/qaCUZ8RZQVMhsBeZBtEn6T0/POk1HN
 Z/xw==
X-Gm-Message-State: AOJu0YxYLg3S4M+tv7VVl2cOlmJkQ+dWQMdN/i2NFZvj4S4cBJZZ1GTw
 Behg1DDWqiTI2fTUBWKYiMvelUS6rwQg8boqKdo8zpr4c6MG6h4B
X-Gm-Gg: ASbGncsDyHE89+ISETWSkxqa2YwSlSnEF1yscqHgvTD/AlDVc1FemjWlk2+FzDh/Xg/
 iZ2Ti/TzlTgyQtRujgQRy5WWWV82CCN+1UFRVEdDjHvoBc8WYXgGGyMCUaxe2ybuyvG+TYsPg97
 T9t/RlzBvD4ojq1AcaWUKwQ8vqdkwvX1qj0yInpc8fDQGt1OQVJWRbwLNLSdHp00K0esoqgbpbY
 x5vLmkMCSXgm5n4NX42hePrADDhyWyeM6foh+vp4WXxPcP59I7VZ96ICAoPyqrMum47T/zjsuMW
 GCYX6+OHp4ANnkEueyZMwUFU26ZaNl1N
X-Google-Smtp-Source: AGHT+IEAx3UNYfuVlb/plbs5DImdmWiy5DDrylpKFoP3GwL0TOjmR3y/h59/Ds2BcmeOFU3JdDu8bg==
X-Received: by 2002:a05:6402:5111:b0:5dc:7464:2228 with SMTP id
 4fb4d7f45d1cf-5de9a39445bmr1588878a12.2.1739233423683; 
 Mon, 10 Feb 2025 16:23:43 -0800 (PST)
Received: from foxbook (adtq181.neoplus.adsl.tpnet.pl. [79.185.228.181])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5de5e15c76bsm5826074a12.42.2025.02.10.16.23.41
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Mon, 10 Feb 2025 16:23:42 -0800 (PST)
Date: Tue, 11 Feb 2025 01:23:29 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev, Kenneth Feng
 <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Boyuan
 Zhang <boyuan.zhang@amd.com>
Subject: Re: [REGRESSION 6.14][BISECTED] AMD Carrizo shutdown hang since
 amdgpu commit ff69bba05f08
Message-ID: <20250211012329.75c58e60@foxbook>
In-Reply-To: <CADnq5_PaMfk65E2NRwPcsr-+bF6iKc8Le4mRkye9BZ=c4xQ-yQ@mail.gmail.com>
References: <20250210191518.351576aa@foxbook>
 <CADnq5_PaMfk65E2NRwPcsr-+bF6iKc8Le4mRkye9BZ=c4xQ-yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 11 Feb 2025 07:57:09 +0000
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

On Mon, 10 Feb 2025 18:28:16 -0500, Alex Deucher wrote:
> Does the attached patch fix it?

Yep, it prints a few more lines and shuts down now.

Thanks!

[   53.525125] cstate: 1 pstate: 1 nbpstate: 1 sync: 0 dispclk: 0
[   53.525125] sclk: 0 sclk_sleep: 12225 yclk: 2668000 blackout_recovery_time_us: 0
[   53.605942] amdgpu: Setting Deep Sleep Clock: 1222
[   53.613220] amdgpu: enable Low Memory PState.
[   53.707787] amdgpu: Setting Deep Sleep Clock: 1222
[   53.714787] amdgpu: enable Low Memory PState.
[   53.721659] amdgpu 0000:00:01.0: amdgpu: IP block9 already in the target gate state!
[   53.732460] amdgpu 0000:00:01.0: amdgpu: IP block8 already in the target gate state!
[   53.742564] amdgpu: Setting Deep Sleep Clock: 1222
[   53.750680] amdgpu: enable Low Memory PState.
[   53.759500] amdgpu: enable Low Memory PState.
[   53.767937] ACPI: PM: Preparing to enter system sleep state S5
[   53.777664] ACPI Warning: Time parameter 255 us > 100 us violating ACPI spec, please fix the firmware. (20240827/exsystem-142)
[   53.792988] kvm: exiting hardware virtualization
[   53.801592] reboot: Power down
