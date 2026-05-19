Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFF0CD5BAA
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 07:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8694D10EF26;
	Wed, 20 May 2026 07:18:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="qs3N6rwQ";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D85210ED62
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 15:12:01 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2b2e8b95bdbso325ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779203520; x=1779808320;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JFaonW5sjqONYy9HxLylYW8qsfh6N/igZfarUXzh5kA=;
 b=qs3N6rwQaK/DOLtYvW9OOht1DvUTSGVMiso/NgDPsbPkpjqZAvrPUc/i4q15nJ/PuT
 N4WwNTWBI8bmgP60IC9O3GB/kJEzRhlcIC7eWAsr72JKl7znPCQkZBWay1Qp7lj8jN8F
 PWC91/X17kMK/spt1LKrgQrnDii7AJp88fB71LtGRzRyNWVSocGXRfDy0tvEOhPG+pva
 qVPC/fKLN28NsVz1e/zCxOXrHc8rfS+OQycqobcKYjcfkQL68YK5lMZxiKwhrQPeGzTL
 p9E2inKLuiepi9iv31voztI9zby5nJWLq3tkN80TSAMbXQD/1Cbwcx4zWH08H/IP0SA6
 oMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779203520; x=1779808320;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JFaonW5sjqONYy9HxLylYW8qsfh6N/igZfarUXzh5kA=;
 b=K+WkAYhJCBAlVtZ5ChgzPqB2Cq5z7V+upMK96zzEE0K/TfsvvOY7P45ZskJRumtMfB
 hTRQ8ZarlxxgZnuLfDzbRU8h39KiG8cFQH5PHl1QljHB/oveP4MwiI+2azRpd11BweWp
 a7CwlG8ZvjKQe/ZLVXvi+EF8rwahTKr3kNRs/zD5vDR4HhTOu7jMVto8RG1U0xa0nluJ
 nq4HSDRUBVEJiYHIrqgn9rsc1nC8PQOQHPeRITHIQ+dzRqNPxc0zU7Jg+Bp9wDhYir0R
 a0qYo+IaRhrev25dNQHoZr85k/DrAk2uC9jaxxhV4aTY+HdSVHkJQtWuB48T3oMFseer
 EgeA==
X-Gm-Message-State: AOJu0YyKHrMCQdRv6MYohhG2BeSAfg30iLoWX0D5FXI+rjU0JUUVZMu9
 lHp7Y8uzXLrG8g8Z/UiKX9fiVA9LgAm83MmYJRlGD7B2h2KIVhZZMOUz1cGQPhQ5og==
X-Gm-Gg: Acq92OEIeJ2eYTwRje7DNshSpmTT+Wa9C3inT/lzaVKUatYocDjXG9J4FNNgxe5ei+O
 5bH9fRhojHPRMLSEJUE/J88Numj0IXAHbFwPmrwctjJFdCaoZqhny7kdvRRtsTWDTDOrW7CuFY2
 GHZI14TQh0/X+b6AlNeVtAboS7t+CPTmehAq2NCZqjbHoGM9D0CpYJokByTvlmpD0v36O7/E8dE
 HN4+A4zT/EfxAThVZQphBhd9KfHeoyoZN4ip154GYhVBy+3gViHpQ3tCLZauMvR2Otjm5PtBunM
 Uvjd1tp2gPXJ8VUcVYLE7HtGxAJb48+SDDyfxLszJ+NaI9aG7LfETL0voJx0xaOGcyVwsa4ybRP
 BMAEIJBgKfJ6sdRAGC7m8aoBBD953KlJ52i/qaXgUETyExgG2Vla2RGbDPrMHO+1TrrPk+vvlgh
 HolAMYAZJqSVhvDOHgxvRhitWfaPeSv1kZEBK0h+w01A/XMN8UT0boqutkRbQv2ZuUO8qZBD6t4
 gD+x0Jy2V/HJpUtYaOsxnPM52hiublaEua6thuE7FKI4Q6s5+vwkFY0
X-Received: by 2002:a17:902:cf0d:b0:2b4:6529:7bae with SMTP id
 d9443c01a7336-2bdb329b56bmr6422215ad.17.1779203519932; 
 Tue, 19 May 2026 08:11:59 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com.
 [34.16.174.112]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19f7cd19sm18390100b3a.54.2026.05.19.08.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 08:11:59 -0700 (PDT)
Date: Tue, 19 May 2026 15:11:55 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH] drm/amd/display: use GNU make rwildcard instead of find
Message-ID: <agx9uxrYxzXgcGuO@google.com>
References: <20260416125412.29552-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416125412.29552-1-Hawking.Zhang@amd.com>
X-Mailman-Approved-At: Wed, 20 May 2026 07:18:22 +0000
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

On Thu, Apr 16, 2026 at 08:54:12PM +0800, Hawking Zhang wrote:
> Replace external find calls with GNU Make’s $(rwildcard …)
> to collect files. Depending on ‘find’ can fail if it’s
> unavailable or returns no matches, which left CFLAGS_*
> unset. In that case, floating-point code was built
> with -mno-sse, leading to build failures.
> 
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml2_0/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
> index 8a451c36fdb3..10c547e63657 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
> @@ -55,8 +55,9 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2_0/dml21/
>  
>  # Add FPU flags to all dml2 files by default, remove NO_FPU flags.
>  # FPU flags step 1: Find all .c files in dal/dc/dml2_0 and it's subfolders
> +rwildcard = $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$(2)) $(filter $(subst *,%,$(2)),$d))
>  DML2_ABS_PATH := $(FULL_AMD_DISPLAY_PATH)/dc/dml2_0
> -DML2_C_FILES := $(shell find $(DML2_ABS_PATH) -name '*.c' -type f)
> +DML2_C_FILES := $(call rwildcard,$(DML2_ABS_PATH)/,*.c)
>  
>  # FPU flags step 2: Convert to .o and make paths relative to $(AMDDALPATH)/dc/dml2_0/
>  DML2_RELATIVE_O_FILES := $(patsubst $(DML2_ABS_PATH)/%,dc/dml2_0/%,$(patsubst %.c,%.o,$(DML2_C_FILES)))
> -- 
> 2.17.1
> 

Following commit 4bb2f0721ed8 ("drm/amd/display: Move FPU Guards From
DML To DC - Part 2"), I started having the following build issues:

  ERROR: modpost: "__eqdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
  ERROR: modpost: "__truncdfsf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
  ERROR: modpost: "__nesf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
  ERROR: modpost: "__divsf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
  ERROR: modpost: "__extendsfdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
  ERROR: modpost: "__adddf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
  ERROR: modpost: "__fixdfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
  ERROR: modpost: "__floatsisf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
  ERROR: modpost: "__mulsf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
  ERROR: modpost: "__fixsfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
  WARNING: modpost: suppressed 20 unresolved symbol warnings because there were too man


This patch fixes them. Thanks!

Tested-by: Carlos Llamas <cmllamas@google.com>
