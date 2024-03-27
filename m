Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FEBC54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 13:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16DD1112424;
	Thu, 28 Mar 2024 13:32:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="hlrmxI9i";
	dkim-atps=neutral
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com
 [209.85.166.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 157B410F1E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 22:08:26 +0000 (UTC)
Received: by mail-io1-f41.google.com with SMTP id
 ca18e2360f4ac-7c7f3f66d17so9788339f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 15:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711577306; x=1712182106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bmkqc/3aYewIsupa3aI44uZjMZk6uVE6sk1O51xM5oE=;
 b=hlrmxI9iEYRCs3Z0fXC0Op4APDVt0ozcK8QeVDT5hXU0k1pWMEkgqMRljWxos8d7+s
 UuxrbO5N5DtkJdhTcxdeUd0RauvPcDp6AVaDCTSoxaA/gbid2eVzOeH6zEDREvUi7CNQ
 kdLDbsyUj7xbRflyeJK+UHHjlwOeSRknDTRcy5fpSDUv2jbQaGtce7i4EyUemGOZLCh2
 Sv5fyRXsZL3n0bOhitXGBzBaEBdYycpGSQ5a0lo+FvyvWjA0p2X6gt362D5NuyolmEwn
 dHMR6gI8XHMeGNvnptynxWoRBtB2fQuq+Xu8vm6zbe0Cz0jiheY6tbnPk6ozrxrvFm9a
 5vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711577306; x=1712182106;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bmkqc/3aYewIsupa3aI44uZjMZk6uVE6sk1O51xM5oE=;
 b=IdON3SsJiRpp7VqnX4dcDFv7vlB+GEqmUiYJyZzBRtoBVTOVa5EkBBwHVm9rF/mEu/
 Df+lIBkU9EbY1v7yKyTsGqtjvvRMUFR4CnE6G0shbpK9i6Ih1mW7j5d/4qhcKHlxNTwH
 AzS+Ndbu86HwjgiKHncfGYe0hhdYWI63S9SD5pSPlCwia2zUrv9Xecac3quvd+/u7m1Z
 GErea2mMGKlZA10zNytnNwbMMC9qB71GdCMNTipcDdkc6j+qLYRKF0G40ZzvngOD5Dpm
 uo1wwbo7zWPoS59C1j+pwkWNLHaQyW6MnjTBpNb+1nD0AVA2LxzeFtaCxLFb+fk+Tzxb
 7eJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDV8WO+TZxiDPa+DUcNF4a0f1Nm3t3WFSqxAOU2WRjRXxgoh/yWii8Eq6aqG8UX3jswBiOykslN7ctcFeP7KmNI1IhkUlctG/7XnCwzQ==
X-Gm-Message-State: AOJu0Yz1lOVLg0fGFNE3kq9f+jsBqJez5BTVsc/HCPzvuGdre96VgsSj
 Ptf/6pQlZdrZbEM/gomnY0xDVcCZLP2ccfYqNKvWSYQZDPA1Pd3j93vsH1KRPn4=
X-Google-Smtp-Source: AGHT+IGUYm3Y8wBDca1kE2cHOU4Wfjx7H338gBLx60QGaDb6jbN+3GFHHCGUs0OMGF33wA7wIsUyRw==
X-Received: by 2002:a6b:f919:0:b0:7cb:ffd8:1546 with SMTP id
 j25-20020a6bf919000000b007cbffd81546mr1424618iog.19.1711577305709; 
 Wed, 27 Mar 2024 15:08:25 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.190]) by smtp.gmail.com with ESMTPSA id
 f12-20020a056638118c00b0047bea529fddsm2373jas.104.2024.03.27.15.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 15:08:25 -0700 (PDT)
Message-ID: <4d9633cd-15c4-4cc1-ac67-2592e9fc7880@sifive.com>
Date: Wed, 27 Mar 2024 17:08:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20240327200157.1097089-1-samuel.holland@sifive.com>
 <20240327200157.1097089-13-samuel.holland@sifive.com>
 <20240327142516.e4b1f9ba6e2ec7bc300e4d58@linux-foundation.org>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240327142516.e4b1f9ba6e2ec7bc300e4d58@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 28 Mar 2024 13:32:06 +0000
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

On 2024-03-27 4:25 PM, Andrew Morton wrote:
> On Wed, 27 Mar 2024 13:00:43 -0700 Samuel Holland <samuel.holland@sifive.com> wrote:
> 
>> Now that all previously-supported architectures select
>> ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol instead
>> of the existing list of architectures. It can also take advantage of the
>> common kernel-mode FPU API and method of adjusting CFLAGS.
>>
>> ...
>>
>> @@ -87,16 +78,9 @@ void dc_fpu_begin(const char *function_name, const int line)
>>  	WARN_ON_ONCE(!in_task());
>>  	preempt_disable();
>>  	depth = __this_cpu_inc_return(fpu_recursion_depth);
>> -
>>  	if (depth == 1) {
>> -#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
>> +		BUG_ON(!kernel_fpu_available());
>>  		kernel_fpu_begin();
> 
> For some reason kernel_fpu_available() was undefined in my x86_64
> allmodconfig build.  I just removed the statement.

This is because the include guard in asm/fpu.h conflicts with the existing one
in asm/fpu/types.h (which doesn't match its filename), so the definition of
kernel_fpu_available() is not seen. I can fix up the include guard in
asm/fpu/types.h in the next version:

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index ace9aa3b78a3..75a3910d867a 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -2,8 +2,8 @@
 /*
  * FPU data structures:
  */
-#ifndef _ASM_X86_FPU_H
-#define _ASM_X86_FPU_H
+#ifndef _ASM_X86_FPU_TYPES_H
+#define _ASM_X86_FPU_TYPES_H

 #include <asm/page_types.h>

@@ -596,4 +596,4 @@ struct fpu_state_config {
 /* FPU state configuration information */
 extern struct fpu_state_config fpu_kernel_cfg, fpu_user_cfg;

-#endif /* _ASM_X86_FPU_H */
+#endif /* _ASM_X86_FPU_TY{ES_H */


Regards,
Samuel

