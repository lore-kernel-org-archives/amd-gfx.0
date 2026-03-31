Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68441061B3F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 12:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D12710E9A0;
	Tue, 31 Mar 2026 12:40:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AZihj9R+";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA95F10E9A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 12:40:04 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2c16cdf31cdso272980eec.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 05:40:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774960804; cv=none;
 d=google.com; s=arc-20240605;
 b=CbQZ9FkcbdK2/MZAHqim2loDyGpD9Ej8dbv5c5VCOfQtQDdkXYIyEAG9XYJFK27WjP
 LHw9LM0c7QV2Bt/0p7VNztB2cGZADAF9arLtLznZzOPTr5kcMHnULtB15tQijGT/yYyu
 54RrwqAaurK96sn+Ezxj2Ve7vxjnNovSWnUU05XYUScVww/0OgQPtvD0yVuhmrpHKXYc
 U45veFT0NJiMLPet1TdBzFfgbM1AsGk23JZeNK0mBcayLjmLKzjYDiGEsbIrZ7rmo05v
 WkNxHQXlZmTJunV1t2KZeepRdwPwWsxaYsDusTDXQkyX+FRR/QFg87Asc3NOXK7unq+J
 koVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VNsJQ0GRFHHy1GGhfQvGM8i595DBBTL6sH/+Ub/sdjc=;
 fh=sEMd3FpKKna/lfzTGdLllHN8Y5csUeypNnntGll0Pag=;
 b=i/4EnQ3kJL7kdAw6C/26SW7z9c116X4HF9X+2lzry2RYbqs5rd+ZLh+Emj8msrFnLQ
 hDHFYkKGqCJXI5lqduG8rIhZLonP5eovalm9Y4RsyW4LUpoR/MmyEBDJp5ceuL5uSOIq
 bKg9/CRQ9CctiHkIlXNoOVS4Jf/sphJ/bl3ZlDjkez0y41q03tU8nVYDtScVPUrkdd0p
 ISt31nq9x7jPJi8DDFema1DyoE2l9AX1v0mhJzycpvrv95G4OxdOcoapNsJzevbKECMv
 zewkpo7KtX/g8gF9RffGVVzysTK7Nobc/VlwrLj6cLFKNw0UBA27J7+dTkmubcR9QCRI
 4Pqw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774960804; x=1775565604; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNsJQ0GRFHHy1GGhfQvGM8i595DBBTL6sH/+Ub/sdjc=;
 b=AZihj9R+5RYJUoCRXIuQJK86mycq5pWKd7UE1wWBmtS0H0R4UyKWg1a+oryTrrPGqx
 W4WpRCngqsxyVUdztpPu++XlQJRJWkqkUGAtzkm3Z83579QiNSwDH73TgwzV3zDe6/9/
 pY7ELVaUfl1be+Q+3lAaqPTmNLXdVpxQub/Rx6IXQXXRUa4SFcNBcSPW+JJMgor1ANHz
 Neigjupv/67be1nFUe82nDJJDuMPRKuj0idGE0GmIaqX9G8w8gwUM1psSD1h8xeImQ0V
 /MS9tiJh+Lskbd00mzZ9s0H7vEiJFfAERWxfgRUfaz15bgeHzy0MlQ1Nn+/Y0qNB+xlF
 0XWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774960804; x=1775565604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VNsJQ0GRFHHy1GGhfQvGM8i595DBBTL6sH/+Ub/sdjc=;
 b=EBQKk7rxrM8jaZifbu+WwcAV0mRYJoU3xpAVNtOsJrSmYnpy4Wm2gaO6hkJJoCyotZ
 ybUzZLq0uwbFundsUlbJ93AyxNo86WM4brzuItBHYHJaBJgu1Wrz2IWmADUeAv5JA9Wd
 ew2d7WY9D5uTacHtXJV+ar4Ej3jYQX/5swrKn/Lb+Hdnl3Mjdlp2+/NjMcj+RrjVZIey
 3UO2nkUS8kx1f1ZZ7EM68YD4scGQ/imKomV8RhxPdMTgi/sx/lFU8/B1QNSwiWsmz2xZ
 qbxDBXV1rKiQ1Mgd1VXAiTt7PT3pH+Tap00Ab85veLFptnMA5okvp8zqXjKB/uVWwHx4
 STpg==
X-Gm-Message-State: AOJu0YwNwh8AE5HCYFWLiVWFzvbIjBai5bHwNdjfMN5ZGsCixOA/vyLZ
 9Pejowr/5hd9ZUxMDf8MAGpILdRxPA/KNMS4BR3Lry9SblbNTbUk6QaL7Xkj2MOCvq/doWWNRqL
 UczgYuy9GOUKytME5cWrBpYFgJLGbXaA=
X-Gm-Gg: ATEYQzz6Fm5HXl77Es3TiU44aYr+BkN88ISKyFfG9CVODkmE9RGXw2273XOBpajUCRy
 MAirtFPdnfs91wAJcCRHsoZkx/5JjH7wr4o2djtJ8IrYJezn9WspxowIjhpxX33cq9ezN1ofe24
 eVZZSZuXx9I6sMwBFuGfdOFZo1ZvXrWPztDqS4zXU1hxFoW5QzEiamICYSOTnsnkAxFM1zYTBQ9
 fcXLbJUD+ee+g+XLj5IQwkh28FILh6kQDYt6RTuDNRSNzqn47nJ/KbKn6gzCW0uwMWDGUgdvOA6
 3SNh6JlxOvtwiKOS/D13jUNL/hfJfASkcpqLp8vf7S7WZYyYrZ/V57ZAIo7CGECO5YPcJQ==
X-Received: by 2002:a05:7022:305:b0:119:e56b:c3f1 with SMTP id
 a92af1059eb24-12ab2850cffmr4539106c88.1.1774960804004; Tue, 31 Mar 2026
 05:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260326213751.5741-1-vitaly.prosyak@amd.com>
In-Reply-To: <20260326213751.5741-1-vitaly.prosyak@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Mar 2026 08:39:51 -0400
X-Gm-Features: AQROBzD4ykCYbuGdU9DDPdme5T1lBET4cIHiQ8MXBsOzVv_DK1tw3XFqWtG0yn8
Message-ID: <CADnq5_OKmos-sR=S-52eV_cRh8ECX3NvNVzHTCtryu-TC44ndA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add CONFIG_GCOV_PROFILE_AMDGPU Kconfig option
To: vitaly.prosyak@amd.com
Cc: amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Mar 26, 2026 at 5:44=E2=80=AFPM <vitaly.prosyak@amd.com> wrote:
>
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> Add a Kconfig option to enable GCOV code coverage profiling for the
> amdgpu driver, following the established upstream pattern used by
> CONFIG_GCOV_PROFILE_FTRACE (kernel/trace), CONFIG_GCOV_PROFILE_RDS
> (net/rds), and CONFIG_GCOV_PROFILE_URING (io_uring).
>
> This allows CI systems to enable amdgpu code coverage entirely via
> .config (e.g., scripts/config --enable GCOV_PROFILE_AMDGPU) without
> manually editing the amdgpu Makefile. The option depends on both
> DRM_AMDGPU and GCOV_KERNEL, defaults to n, and is therefore never
> enabled in production or distro builds.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/Kconfig  | 17 +++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/Makefile |  4 ++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amd=
gpu/Kconfig
> index 7f515be5185d..7fb0b93bc1ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -103,6 +103,23 @@ config DRM_AMDGPU_WERROR
>           Add -Werror to the build flags for amdgpu.ko.
>           Only enable this if you are warning code for amdgpu.ko.
>
> +
> +config GCOV_PROFILE_AMDGPU
> +       bool "Enable GCOV profiling on amdgpu"
> +       depends on DRM_AMDGPU
> +       depends on GCOV_KERNEL
> +       default n
> +       help
> +         Enable GCOV profiling on the amdgpu driver for checking which
> +         functions/lines are executed during testing. This adds compiler
> +         instrumentation flags to all amdgpu source files, producing
> +         .gcda/.gcno coverage data accessible via debugfs.
> +
> +         This increases the amdgpu module size by ~50% and adds ~2-5%
> +         runtime overhead on GPU submission paths.
> +
> +         If unsure, say N.
> +
>  source "drivers/gpu/drm/amd/acp/Kconfig"
>  source "drivers/gpu/drm/amd/display/Kconfig"
>  source "drivers/gpu/drm/amd/amdkfd/Kconfig"
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index 6a7e9bfec59e..db66c6372199 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -27,6 +27,10 @@ FULL_AMD_PATH=3D$(src)/..
>  DISPLAY_FOLDER_NAME=3Ddisplay
>  FULL_AMD_DISPLAY_PATH =3D $(FULL_AMD_PATH)/$(DISPLAY_FOLDER_NAME)
>
> +ifdef CONFIG_GCOV_PROFILE_AMDGPU
> +GCOV_PROFILE :=3D y
> +endif
> +
>  ccflags-y :=3D -I$(FULL_AMD_PATH)/include/asic_reg \
>         -I$(FULL_AMD_PATH)/include \
>         -I$(FULL_AMD_PATH)/amdgpu \
> --
> 2.43.0
>
