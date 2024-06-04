Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256E5C27C65
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 12:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF77410E7D2;
	Wed,  5 Jun 2024 12:57:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rmxp2iOL";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA61D10E1CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 16:04:24 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-1f44b594deeso41733495ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Jun 2024 09:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717517064; x=1718121864;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to; bh=R2gKQIHSX9mPWT/OX1hOPZ0VNPVmzrzMvvwZ15iSblg=;
 b=rmxp2iOLFWRwyZwczNZvYtkoKT1dcKb00BzHVg3tS0VBflGLj+lTbZ+MUcukrugKIG
 wnwji3hPMVtEe5aXNfdV/lRKdIQixyQgZfqyAwrmk92hMEYtfKegl0dWpwKpAjUe8KwR
 FEg3TEySysgU5G+0b3S6QLOkmtGVIWQ1PWAJemBenz2oqgrsUhozRW2wF+bTlmfvOzG0
 xVapea8Zo5R+uEuWwotbteiDvh94quEuY5DTZGZD9Oi+5SZu5S4SCQkqOy7pT/McVzzk
 79cZcz9oXqzgVfiJEgmfD/DWory3ZaEke+NeIabrHGCwE32c06J8zbBvy5l+K67FF3xM
 i3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717517064; x=1718121864;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2gKQIHSX9mPWT/OX1hOPZ0VNPVmzrzMvvwZ15iSblg=;
 b=apciy3m0ZDw15Lea/dnM9a8MS7LSNSHOvWgchOFy4mm99TqrpLh3E9sUWYbWXFabXJ
 hr81xf3ghPADp+Sog6u0sExDm4e7MBDqs21x7peKjXCp/CrJtu9yLVYNzlyDLlAwHxKB
 nsE0utMqkP0F0UQAb3HNjexwEbrMlSN3dSyYDEJeTJYvtveagvgLGkaP6QvdPwN8zQWk
 lBJyiAvmQODIImPp4QYrxkKxwHS1Tr+3HSEWDBYcntRXL2qZylC09PfMGC5I7DomIpid
 OdrrihI9vInYS2yiDbGt8bKjoFiBZOX/QXbyXBlkezhKop5n7Mo7lFfdluLGLUV/ntvH
 ywcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdooIINRk8SUMuNjFw7ekVZ2bGPdW/X7LscPK8iJGnW0vn1Kd4RG0ploNPKL4EP3C0mZpVYgPhkc+l5qN/JMqwpuPVMP1WCOW/iEZzTg==
X-Gm-Message-State: AOJu0YzgsClCRTD4cczUnImOsyqNwcg6BdUCwHAsCl2mw/YMzUhq2oE9
 kLo3sW4pPteH7CGhMmBIyhHEH11W8G8BWLQqBLyzDYNnlCZVNhwnFds3Egwj6MY=
X-Google-Smtp-Source: AGHT+IFk2/CHkCYOgoIKNRsQIUaLysshP8KYOXeegGgQt9s1XMcyvOM8xjJ+kaYxNqLDHalCVqGY9A==
X-Received: by 2002:a17:902:d507:b0:1f4:7713:8f6 with SMTP id
 d9443c01a7336-1f6370a0cd6mr163627915ad.52.1717517063799; 
 Tue, 04 Jun 2024 09:04:23 -0700 (PDT)
Received: from localhost ([50.145.13.30]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f63232dcc5sm85466225ad.26.2024.06.04.09.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 09:04:23 -0700 (PDT)
Date: Tue, 04 Jun 2024 09:04:23 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Jun 2024 09:04:21 PDT (-0700)
Subject: Re: [PATCH] drm/amd/display: Increase frame-larger-than warning limit
In-Reply-To: <20240603222948.GB1802995@thelio-3990X>
CC: alexander.deucher@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 Rodrigo.Siqueira@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, 
 daniel@ffwll.ch, Qingqing.Zhuo@amd.com, hamza.mahfooz@amd.com,
 chenhuacai@kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: nathan@kernel.org
Message-ID: <mhng-f1fc5ef0-9e72-4b12-9a28-145bbc8938d8@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 12:57:07 +0000
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

On Mon, 03 Jun 2024 15:29:48 PDT (-0700), nathan@kernel.org wrote:
> Hi Palmer,
>
> On Thu, May 30, 2024 at 07:57:42AM -0700, Palmer Dabbelt wrote:
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> I get a handful of build errors along the lines of
>>
>>     linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:58:13: error: stack frame size (2352) exceeds limit (2048) in 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Werror,-Wframe-larger-than]
>>     static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
>>                 ^
>>     linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1724:6: error: stack frame size (2096) exceeds limit (2048) in 'dml32_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
>>     void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
>>          ^
>
> Judging from the message, this is clang/LLVM? What version?

Yes, LLVM.  Looks like I'm on 16.0.6.  Probably time for an update, so 
I'll give it a shot.

> I assume
> this showed up in 6.10-rc1 because of commit 77acc6b55ae4 ("riscv: add
> support for kernel-mode FPU"), which allows this driver to be built for
> RISC-V.

Seems reasonable.  This didn't show up until post-merge, not 100% sure 
why.  I didn't really dig any farther.

> Is this allmodconfig or some other configuration?

IIRC both "allmodconfig" and "allyesconfig" show it, but I don't have a 
build tree sitting around to be 100% sure.

>> as of 6.10-rc1.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>>  drivers/gpu/drm/amd/display/dc/dml/Makefile | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> index c4a5efd2dda5..b2bd72e63734 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> @@ -62,9 +62,9 @@ endif
>>
>>  ifneq ($(CONFIG_FRAME_WARN),0)
>>  ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
>> -frame_warn_flag := -Wframe-larger-than=3072
>> +frame_warn_flag := -Wframe-larger-than=4096
>>  else
>> -frame_warn_flag := -Wframe-larger-than=2048
>> +frame_warn_flag := -Wframe-larger-than=3072
>>  endif
>>  endif
>>
>> --
>> 2.45.1
>>
