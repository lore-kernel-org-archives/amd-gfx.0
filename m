Return-Path: <SRS0=8/fv=G4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3327CC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 12:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E567322EBF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 12:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E567322EBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 871F189C88;
	Mon, 25 Jan 2021 12:07:18 +0000 (UTC)
X-Greylist: delayed 398 seconds by postgrey-1.36 at gabe;
 Mon, 25 Jan 2021 12:07:15 UTC
Received: from lechuck.jsg.id.au (jsg.id.au [193.114.144.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A3A89C84;
 Mon, 25 Jan 2021 12:07:15 +0000 (UTC)
Received: from largo.jsg.id.au (largo.jsg.id.au [192.168.1.43])
 by lechuck.jsg.id.au (OpenSMTPD) with ESMTPS id df734e03
 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO); 
 Mon, 25 Jan 2021 23:00:33 +1100 (AEDT)
Received: from localhost (largo.jsg.id.au [local])
 by largo.jsg.id.au (OpenSMTPD) with ESMTPA id 201b1270;
 Mon, 25 Jan 2021 23:00:33 +1100 (AEDT)
Date: Mon, 25 Jan 2021 23:00:32 +1100
From: Jonathan Gray <jsg@jsg.id.au>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com
Subject: Re: [PATCH] drm/amd/display: change license of color_table.c
Message-ID: <20210125120032.GA18504@largo.jsg.id.au>
References: <20201119023041.77269-1-jsg@jsg.id.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201119023041.77269-1-jsg@jsg.id.au>
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
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This still needs to be corrected.

On Thu, Nov 19, 2020 at 01:30:41PM +1100, Jonathan Gray wrote:
> Change the license of color_table.c to match color_table.h granting
> permission to modify and distribute.
> 
> Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
> ---
>  .../amd/display/modules/color/color_table.c   | 26 +++++++++++++++----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/color/color_table.c b/drivers/gpu/drm/amd/display/modules/color/color_table.c
> index 692e536e7d05..410f2a82b9a2 100644
> --- a/drivers/gpu/drm/amd/display/modules/color/color_table.c
> +++ b/drivers/gpu/drm/amd/display/modules/color/color_table.c
> @@ -1,10 +1,26 @@
>  /*
> - * Copyright (c) 2019 Advanced Micro Devices, Inc. (unpublished)
> + * Copyright 2019 Advanced Micro Devices, Inc.
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
>   *
> - * All rights reserved.  This notice is intended as a precaution against
> - * inadvertent publication and does not imply publication or any waiver
> - * of confidentiality.  The year included in the foregoing notice is the
> - * year of creation of the work.
>   */
>  
>  #include "color_table.h"
> -- 
> 2.29.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
