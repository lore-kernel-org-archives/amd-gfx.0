Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D131BC83F3D
	for <amd-gfx@archiver.kernel.org>; Sun, 20 Jul 2025 15:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D74010E37B;
	Sun, 20 Jul 2025 15:32:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Pcq9LXoH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A25E410E9EC;
 Fri, 18 Jul 2025 15:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752853027; x=1784389027;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ltIuRJBzfoP4LzI8kUoo54zZCELzuoWYyP9nbjNM8uI=;
 b=Pcq9LXoHNtjhLDqIkxz+JBseQQfdx0lFeMy0XsNAfHRnL7stDC4vfNQ7
 8tkw3JqpixczEb1FARNQyv8aSm+xEAPCk63TrdN+3BhgYQIp8CQ906eNY
 26B5Ctg4SkAE5MQUlvVCCmLPMlbfHbP3zDnX8cHyENL8/PF8Oh52QJ0Do
 Ijt076nDdfA3nfP2K3YVjXH6csmTWZImhZUtzflg3iPVnE9uQVIiymVDu
 hirCZ6R23wIVx2CxTKrvFAKUceZozohpet+4ynFFt+8N67UwohQrDfN03
 +jBPQppPVjc/TZ08rsNheB24paq7uXUsfrX1Lwf0+76IaaLudr8qX8fol g==;
X-CSE-ConnectionGUID: fVpooUiBTLyGPRlgq3jzKg==
X-CSE-MsgGUID: yDNlHWVuRlqPZhstDipd9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="42774450"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="42774450"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 08:37:06 -0700
X-CSE-ConnectionGUID: mlbnjXt0Qsua6n7jnctHCw==
X-CSE-MsgGUID: GpXjDRgpRPyg98Fb/ijsdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="163713156"
Received: from kamilkon-desk.igk.intel.com (HELO localhost) ([10.211.136.201])
 by orviesa005-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 08:37:04 -0700
Date: Fri, 18 Jul 2025 17:37:01 +0200
From: Kamil Konieczny <kamil.konieczny@linux.intel.com>
To: IVAN.LIPSKI@amd.com
Cc: igt-dev@lists.freedesktop.org, sunpeng.li@amd.com,
 harry.wentland@amd.com, amd-gfx@lists.freedesktop.org,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: Re: [PATCH i-g-t] tests/amdgpu: Add test for native cursor fallback
 to overlay
Message-ID: <20250718153701.xi24dlco7a7bdtq2@kamilkon-DESK.igk.intel.com>
Mail-Followup-To: Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 IVAN.LIPSKI@amd.com, igt-dev@lists.freedesktop.org,
 sunpeng.li@amd.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20250717204155.17468-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250717204155.17468-1-IVAN.LIPSKI@amd.com>
X-Mailman-Approved-At: Sun, 20 Jul 2025 15:32:54 +0000
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

Hi IVAN.LIPSKI,
On 2025-07-17 at 16:41:46 -0400, IVAN.LIPSKI@amd.com wrote:
> From: Ivan Lipski <ivan.lipski@amd.com>
> 
> [Why & How]
> The AMD display hardware does not use dedicated cursor planes.
> Instead, the cursor is rendered either using the primary plane
> or an available overlay plane. This test verifies that the
> cursor correctly falls back from native to overlay mode
> when the underneath primary plane is incompatible. It also tests
> 
> It has 4 subtests:
> 
> rgb-to-yuv
> Switches the primary plane to a NV12 format FB and verifies that
> the cursor falls back from native to overlay.
> 
> non-full
> Switches the primary planeto a FB that does not fill the entire CRTC
> (currently sized at a quarter of the CRTC).
> 
> scaling-[50,75,125,150,175,200]
> Switches the primary plane to a FB with a chosen scaling (50%-200%), which
> is then filled in the CRTC.
> 
> no-available-planes
> Enables all available overlay planes, a primary plane and a cursor. Then
> switches the primary plane to YUV to cause the cursor to fall back to
> overlay. Verifies that the atomic commit fails due to no available overlay
> planes.
> 
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
> ---
>  tests/amdgpu/amd_cursor_overlay.c | 433 ++++++++++++++++++++++++++++++
>  tests/amdgpu/meson.build          |   1 +
>  2 files changed, 434 insertions(+)
>  create mode 100644 tests/amdgpu/amd_cursor_overlay.c
> 
> diff --git a/tests/amdgpu/amd_cursor_overlay.c b/tests/amdgpu/amd_cursor_overlay.c
> new file mode 100644
> index 000000000..52cae8454
> --- /dev/null
> +++ b/tests/amdgpu/amd_cursor_overlay.c
> @@ -0,0 +1,433 @@
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a

Please remove it and use SPDX instead.

+cc Vitaly

Regards,
Kamil

> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include "igt.h"
> +
[cut]
