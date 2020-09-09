Return-Path: <SRS0=5+Vp=CS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831DEC433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 14:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E33121556
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 14:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xoTiqhO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E33121556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7992D6E45F;
	Wed,  9 Sep 2020 14:59:06 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760055.outbound.protection.outlook.com [40.107.76.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D5AB6E45F
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2020 14:59:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVQdL1StFyNCvhg4p1pOP7YIVZ3iP6Vr9agNkjgOB07OUJJj4tQsv8lvUwO7oNA8VH9N53uiupW77XGMJl4Do/uiBktchSLdsyA19pndhcJzqAdLlJudPMT0Jzm5op21Sfs/TAvyFuxA+1XCPKSTmIXq+N+b7JveeMajpVYjzgvU9/JPxKC0du8TLwrC9TBmJoG9qPWdV+B0qKZP7VWZyruUbc3eXKB3tadGexFAd81ff6A8Wt6vNGJWf5yZh3Nc8f6SNurz7rqDqtvCxsAOYjhUyOqs3sPV0PAlKP4ecVYb0PQStULekikVyAefQWhUbWFsKZmM00zaQHamx0mt7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6JL7bOoUjUJqUXHpymCxPf3hV7FMGlCeIAOO2z65dI=;
 b=L9Ynrw0s9G/+TDWcDbhoc1rAABXW9HiqRCNB9b0SFzgQWYvQPRee3TJj61G4mWRab6nmkE5/IQblYwKlr0/BoLJrSIOctlBVNTleGJ3/lFmMw2uhavLZXlaHyWyKrRVsVMRVfuU8uZ7Zx5f3hnSurBtBy3XgWhXXOAmTYAEzgL8/+NM//IPsDe+ii6BDI2HazmOm15X5IsHdjcmP7P1XdVnkS2AfxIPYqSB6sotFNUZ0JbwOPElvzXPsZr5C/6px0js1599KR3eOX0LsN1d2sGmJD2Z3cTW3Uop8tc6qB4nA0qLm67mL8h6gcvM8k1+4uYe6FjkmtER3PDUCbnzbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6JL7bOoUjUJqUXHpymCxPf3hV7FMGlCeIAOO2z65dI=;
 b=xoTiqhO1rTDCV0rIciH1lTSX3/4o2GlsDJvVY4GujCFYkdrxey8ePZ0iZPSdyRYMRmaBHf36cJ8gKfJ4SPnQwLvhm5AZJluiNOo1zojMDNKHFlTkENXPBwSiiIx13ldyOmrzQCD09k9Wa8jfddtCAyQdEiFlAFNMb5fejPkucSw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2984.namprd12.prod.outlook.com (2603:10b6:a03:da::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 14:59:03 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::754e:8f27:157a:9101]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::754e:8f27:157a:9101%6]) with mapi id 15.20.3326.030; Wed, 9 Sep 2020
 14:59:03 +0000
Subject: Re: [PATCH 1/3] drm/amdgpu: Move existing pflip fields into separate
 struct
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200909142854.105032-1-aurabindo.pillai@amd.com>
 <20200909142854.105032-2-aurabindo.pillai@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <96c5f393-cb3c-8f5b-48e5-aef53597e792@amd.com>
Date: Wed, 9 Sep 2020 10:58:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200909142854.105032-2-aurabindo.pillai@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQXPR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::25) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.61] (24.212.165.133) by
 YQXPR01CA0096.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:41::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 14:59:02 +0000
X-Originating-IP: [24.212.165.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a295586-3ea3-4252-7138-08d854d0e3d9
X-MS-TrafficTypeDiagnostic: BYAPR12MB2984:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2984C71582FBEEBA2B5B5BD3EC260@BYAPR12MB2984.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: um9U27sxzekakfgi3kQpifm0uqjOV+CUPFpVFse7ydmNBh9jz1OEQ3cV7cCgy6403z+Bi0vlF+Cqj5zSERObTbLpXjcrKWCmlADqJRuD9pYpXMvNsPZ7TWMA6kJp9fX46z+RAagDrL05l0Jz1efMnb1phJjrCmrpRyk0IXzv7COsI0bVn2Hvp3jZUX9bDA2SpoodjCrwpidjS/VqgEwZdXo5Ioly2vaUZ1WAE/gD86U6LzXuH2LmeA/yOVtMCCSWUjd/8NSou2FYW7tKQ+0TvnGt26cX26s6A+A5gb2mtBl3KT4Di+K7cvc4SKWJ9nVaPJAAs8zgjq9t2ms8GyxwdH9DzjLq/xHdsj2dGN5iHstjXyEDD2OCoORKt4Vl+N+a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(26005)(6666004)(2906002)(186003)(16526019)(53546011)(6486002)(31696002)(478600001)(86362001)(31686004)(8676002)(83380400001)(956004)(36756003)(66556008)(66946007)(2616005)(8936002)(66476007)(52116002)(316002)(16576012)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BrbyA8CierzKTMhVt64necK6SWxFhwGMJXqXzA+ezg+T9z6o7Dex7c5hap6OlapV0JfEWt2gJ0plXCH41CriymD3/A9cHcWDdNRDlOyU7qrSo6Ug46mM9cHtDgBmqKHb46UdT48yoJfxT1z06Q3pmjlLC/hNAUzI+I+rr+OqGaRa2ImbDxcqkNO6npX4IfDuiOY88ZJyXcIjkpBAXL51RyclODE85AJ4osh7+Vp9CGsqyzOwKW3+NO3aEQmhZtz0k1F3iEl775YoguvrGhh4jcs24fQp6rdcPhKVoWp4VO4JU48xIad/2ro78QgQf+rqWvHUpgM5B60lVlOyRgg0AGzaCIxIh98jOIXlrkYboh6qIu2+1vkypxmi+lkNwOxCCadBVhdkFuNkOTRhBsjLVGd19YfyVvw919Hx+yzVjKk03d/wg5owK2EASsZDmpVWNZdZod0h6PpiQC+/kGGfnz4927JmB09spb5ar0tGJdzkH0nbn9GsZhafX+LhaqvkITwPXCKiLxKAGHbV4SAqutyoqCidySzLwTH7NNJ5S2B0TGGq+h+d/WLzR8a2f9B5Dw6Q7pRkL65zV+WpT1sGBPaO+01eW8rVA1q2V2mS/APTOSuMF7l2u1Aa7RAqeIHxCzfx6txZY/gl1v4JN/uS2g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a295586-3ea3-4252-7138-08d854d0e3d9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 14:59:03.6777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N49eusn2i7nnzBNWgiptDN/NtS/x9ht+4pumOlPV9d4UxE4+oxklZRKT/P3M6uVxO9Nn+V0YyvL6esfBIdhy7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2984
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-09-09 10:28 a.m., Aurabindo Pillai wrote:
> [Why&How]
> To refactor DM IRQ management, all fields used by IRQ is best moved
> to a separate struct so that main amdgpu_crtc struct need not be changed
> Location of the new struct shall be in DM
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  4 ++-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +--
>   .../display/amdgpu_dm/amdgpu_dm_irq_params.h  | 33 +++++++++++++++++++
>   3 files changed, 38 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> index aa3e22be4f2d..345cb0464370 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -46,6 +46,7 @@
>   
>   #include <drm/drm_dp_mst_helper.h>
>   #include "modules/inc/mod_freesync.h"
> +#include "amdgpu_dm_irq_params.h"
>   
>   struct amdgpu_bo;
>   struct amdgpu_device;
> @@ -410,7 +411,8 @@ struct amdgpu_crtc {
>   	struct amdgpu_flip_work *pflip_works;
>   	enum amdgpu_flip_status pflip_status;
>   	int deferred_flip_completion;
> -	u32 last_flip_vblank;
> +	/* parameters access from DM IRQ handler */
> +	struct dm_irq_params dm_irq_params;
>   	/* pll sharing */
>   	struct amdgpu_atom_ss ss;
>   	bool ss_enabled;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index cb624ee70545..40814cdd8c92 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -389,7 +389,7 @@ static void dm_pflip_high_irq(void *interrupt_params)
>   	 * of pageflip completion, so last_flip_vblank is the forbidden count
>   	 * for queueing new pageflips if vsync + VRR is enabled.
>   	 */
> -	amdgpu_crtc->last_flip_vblank =
> +	amdgpu_crtc->dm_irq_params.last_flip_vblank =
>   		amdgpu_get_vblank_counter_kms(&amdgpu_crtc->base);
>   
>   	amdgpu_crtc->pflip_status = AMDGPU_FLIP_NONE;
> @@ -7248,7 +7248,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   			 * on late submission of flips.
>   			 */
>   			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
> -			last_flip_vblank = acrtc_attach->last_flip_vblank;
> +			last_flip_vblank = acrtc_attach->dm_irq_params.last_flip_vblank;
>   			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
>   		}
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
> new file mode 100644
> index 000000000000..55ef237eed8b
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
> @@ -0,0 +1,33 @@
> +/*
> + * Copyright 2020 Advanced Micro Devices, Inc.
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
> +
> +#ifndef __AMDGPU_DM_IRQ_PARAMS_H__
> +#define __AMDGPU_DM_IRQ_PARAMS_H__
> +
> +struct dm_irq_params {
> +	u32 last_flip_vblank;
> +};
> +
> +#endif /* __AMDGPU_DM_IRQ_PARAMS_H__ */
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
