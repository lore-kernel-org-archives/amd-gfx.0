Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DE1C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F319B2076E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdlkS5yy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F319B2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B77506E0F3;
	Wed, 24 Jun 2020 14:19:50 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E51D6E0F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 14:19:49 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id o11so2453609wrv.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oJRNfBA7FCJHr8tap2WQpzQGXPDSv7pc1hQvmVBmWPU=;
 b=tdlkS5yyD03p4AXLFluz2zIuRD/pnRqvojHY86V8XzlACpMyWt2kO7ws/4UMX0HGCD
 Chs3qKHlq5Ac0qG4r+GQWVrh47Pq+lva2HA+1gsqH/wE5EdRvnyE329fRSyP25G4zD+t
 ZPaCEU0V9lX8FbbIpU54SxG23/zaoS/kNXtE0D/hXJWzWhYV74+E+PWpJ9Qzz32GWun0
 ac9iyGubDGVkaRI7olrNohSsQfDc2bdkeGc55Z89sGCfIHYK6eiOQS5x3IRM79I9b/Iv
 wAhfkP05JD93ZBw5fgGWlo5lIB7+KNX9pRVQz18ptuk6bQDyZBJOX/1Raqzpsbdrzpr0
 Jx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oJRNfBA7FCJHr8tap2WQpzQGXPDSv7pc1hQvmVBmWPU=;
 b=lnYp4eLyFzu+wyj2ZkOijfbi0Z2N16abGx+L/XBTBu9vt+G78v5jqRCzF9t3gpeIt+
 rvgOYjc/BUlDE2YQoLjPnVaXhPc1qIFWw9nl1p1mo4+YgnQgNDgUzJtDp709hzDABKfn
 EB8Ki53aTvzda6/I/u8NqA1mtcRQlu9IzhKtRS22HKupiadM0QHWlUXFGGSqb7nyNI+N
 e/szjy2HS1JqctM6orARnmtu76SkjTQZPcNg9azkFmBGCKgTeYCefzPL6krpJSeLRB47
 /ALC39gfZGjrwuWeeFkXycu37Yx43XOvS4/mlcONwZVnH6aj52zo/Pg/6ioDvu3OlM/Q
 aqzg==
X-Gm-Message-State: AOAM533hIUx1mcW2mWLjklLWhVBcPxMHe1El4blI7AJCzj2Xaq42Zws5
 qUt3WBCwqaOF8/SWGRmP8X+hmoqgBKG5ncJvmjtQyg==
X-Google-Smtp-Source: ABdhPJwyk4Qx7i3Va3kfa4NNGD5rSIbER2GlG2tOdV8PTw91iNDFX3BxVVyVeS9vXWRo1LESPP76fnxbjUNJZJ21A7w=
X-Received: by 2002:a5d:5549:: with SMTP id g9mr28657017wrw.419.1593008388004; 
 Wed, 24 Jun 2020 07:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200622221219.1046290-1-alexander.deucher@amd.com>
In-Reply-To: <20200622221219.1046290-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Jun 2020 10:19:36 -0400
Message-ID: <CADnq5_McBUGrx9jrEJcfKX_FSRKMeq8o=0Y7jHkQzjm6VtY1qQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/uvd3.x: fix register definition warnings
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Mon, Jun 22, 2020 at 6:12 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> drop the duplicate register macros from sid.h and use the
> standard ones in the oss register headers.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/si.c    |  1 +
>  drivers/gpu/drm/amd/amdgpu/si_ih.c |  2 ++
>  drivers/gpu/drm/amd/amdgpu/sid.h   | 19 -------------------
>  3 files changed, 3 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index cda9aa5e4b9e..9b12285177e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -45,6 +45,7 @@
>  #include "dce_virtual.h"
>  #include "gca/gfx_6_0_d.h"
>  #include "oss/oss_1_0_d.h"
> +#include "oss/oss_1_0_sh_mask.h"
>  #include "gmc/gmc_6_0_d.h"
>  #include "dce/dce_6_0_d.h"
>  #include "uvd/uvd_4_0_d.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> index 88ae27a5a03d..621727d7fd18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> @@ -27,6 +27,8 @@
>  #include "amdgpu_ih.h"
>  #include "sid.h"
>  #include "si_ih.h"
> +#include "oss/oss_1_0_d.h"
> +#include "oss/oss_1_0_sh_mask.h"
>
>  static void si_ih_set_interrupt_funcs(struct amdgpu_device *adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
> index 75b5d441b628..5f660f0c819f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sid.h
> +++ b/drivers/gpu/drm/amd/amdgpu/sid.h
> @@ -2341,11 +2341,6 @@
>  #       define NI_INPUT_GAMMA_XVYCC_222                3
>  #       define NI_OVL_INPUT_GAMMA_MODE(x)              (((x) & 0x3) << 4)
>
> -#define IH_RB_WPTR__RB_OVERFLOW_MASK   0x1
> -#define IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK 0x80000000
> -#define SRBM_STATUS__IH_BUSY_MASK      0x20000
> -#define SRBM_SOFT_RESET__SOFT_RESET_IH_MASK    0x400
> -
>  #define        BLACKOUT_MODE_MASK                      0x00000007
>  #define        VGA_RENDER_CONTROL                      0xC0
>  #define R_000300_VGA_RENDER_CONTROL             0xC0
> @@ -2432,18 +2427,6 @@
>  #define MC_SEQ_MISC0__MT__HBM    0x60000000
>  #define MC_SEQ_MISC0__MT__DDR3   0xB0000000
>
> -#define SRBM_STATUS__MCB_BUSY_MASK 0x200
> -#define SRBM_STATUS__MCB_BUSY__SHIFT 0x9
> -#define SRBM_STATUS__MCB_NON_DISPLAY_BUSY_MASK 0x400
> -#define SRBM_STATUS__MCB_NON_DISPLAY_BUSY__SHIFT 0xa
> -#define SRBM_STATUS__MCC_BUSY_MASK 0x800
> -#define SRBM_STATUS__MCC_BUSY__SHIFT 0xb
> -#define SRBM_STATUS__MCD_BUSY_MASK 0x1000
> -#define SRBM_STATUS__MCD_BUSY__SHIFT 0xc
> -#define SRBM_STATUS__VMC_BUSY_MASK 0x100
> -#define SRBM_STATUS__VMC_BUSY__SHIFT 0x8
> -
> -
>  #define GRBM_STATUS__GUI_ACTIVE_MASK 0x80000000
>  #define CP_INT_CNTL_RING__TIME_STAMP_INT_ENABLE_MASK 0x4000000
>  #define CP_INT_CNTL_RING0__PRIV_REG_INT_ENABLE_MASK 0x800000
> @@ -2468,8 +2451,6 @@
>
>  #define PCIE_BUS_CLK    10000
>  #define TCLK            (PCIE_BUS_CLK / 10)
> -#define CC_DRM_ID_STRAPS__ATI_REV_ID_MASK              0xf0000000
> -#define CC_DRM_ID_STRAPS__ATI_REV_ID__SHIFT 0x1c
>  #define        PCIE_PORT_INDEX                                 0xe
>  #define        PCIE_PORT_DATA                                  0xf
>  #define EVERGREEN_PIF_PHY0_INDEX                        0x8
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
