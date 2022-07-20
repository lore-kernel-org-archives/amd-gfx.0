Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F6FC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jul 2022 17:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A6871138C8;
	Wed, 20 Jul 2022 17:37:19 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB3611A1D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jul 2022 17:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uI7KJX5vmqB8TD54LJi/+vjOjkA3IQ413zKBYvjUwKo=; b=qnsZJfxMOXjCtDsB44WwaqZbHp
 VPtfma6MRiWl7T2+WjsXS2LUTzEQlD/7cN1K/4zBoTfQuHexLWP7Bnk+mwyIqRZ/Aj7FRFvpkh0+g
 Y1The9T5DTaV5toIDAJyL5qXOD5NEcxD94c+/yaHP3zdu5FZwyafHI3D97t8/fjfwgyxgHXBwNsXc
 EhkKsyvI/kNTq8gBYR7olfqW4M61XaGSuHFxjS2Tl9VSzDkn0sb+EzrUVqr94vwmRH80AQtX5G0SV
 rSpZkChMouWikpLgbDesM546gtJfBRSHMgI9WSEELvXTPmDxO5iq/2y8x6PQaMZxIhe0FS7/mbIH0
 QJCV52xg==;
Received: from 201-13-50-220.dsl.telesp.net.br ([201.13.50.220]
 helo=[192.168.15.109]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1oEDdL-000ZcB-Ni; Wed, 20 Jul 2022 19:37:15 +0200
Message-ID: <c591edf1-766e-34f2-a870-db7ae131f82d@igalia.com>
Date: Wed, 20 Jul 2022 14:36:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 09/31] drm/amd/display: Create a file dedicated for CRTC
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
 <20220715181705.1030401-10-Rodrigo.Siqueira@amd.com>
From: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220715181705.1030401-10-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Siqueira :)

Às 15:16 de 15/07/22, Rodrigo Siqueira escreveu:
> [Why]
> The amdgpu_dm file contains most of the code that works as an interface
> between DRM API and DC. As a result, this file becomes very large since
> it comprises multiple abstractions such as CRTC manipulation.
> 
> [How]
> This commit extracts the CRTC code to its specific file named
> amdgpu_dm_crtc. This change does not change anything inside the
> functions; the only exception is converting some static functions to a
> global function.
> 
> Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
> Acked-by: Alan Liu <HaoPing.Liu@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---

[...]

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> new file mode 100644
> index 000000000000..a9413acfe4dc
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -0,0 +1,463 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
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
> + *
> + * Authors: AMD
> + *
> + */
> +#include <drm/drm_vblank.h>
> +#include <drm/drm_atomic_helper.h>
> +
> +#include "dc.h"
> +#include "amdgpu.h"
> +#include "amdgpu_dm_psr.h"
> +#include "amdgpu_dm_crtc.h"
> +#include "amdgpu_dm_plane.h"
> +#include "amdgpu_dm_trace.h"
> +#include "amdgpu_dm_debugfs.h"
> +

It's a good idea do keep includes ordered like

+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_vblank.h>
+
+#include "amdgpu.h"
+#include "amdgpu_dm_crtc.h"
+#include "amdgpu_dm_debugfs.h"
+#include "amdgpu_dm_plane.h"
+#include "amdgpu_dm_psr.h"
+#include "amdgpu_dm_trace.h"
+#include "dc.h"

because it's easier to check for duplicates and prevents the need for
fixes like this in the future:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/b7be3ae759160aa3355ebeb0583f67fb9bda4dae


