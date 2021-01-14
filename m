Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C6DC433E6
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 09:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED17423A22
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 09:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED17423A22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 243566E161;
	Thu, 14 Jan 2021 09:42:42 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DD536E156;
 Thu, 14 Jan 2021 09:42:40 +0000 (UTC)
IronPort-SDR: lpBmttdj9djf6jDvo9GbgiMc+PporoMrVJajJBkPv7q6cSg1x7EuYmYhLNMzZysaKvCa3XDjSt
 Gebf//CqBNUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="178489308"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; d="scan'208";a="178489308"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2021 01:42:39 -0800
IronPort-SDR: 7RuN2PziES+xPYKfQmNQ7mBycANnqj+LxNRtE5BfOTGKefHp2Goz48KfttoDydmWpEHp6d3Pt9
 shhhUKwfYSgg==
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; d="scan'208";a="382210357"
Received: from dforourk-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.213.254.146])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2021 01:42:35 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Yang Li <abaci-bugfix@linux.alibaba.com>, airlied@linux.ie
Subject: Re: [PATCH] drm/amd/display: Simplify bool comparison
In-Reply-To: <1610530365-46152-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1610530365-46152-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Date: Thu, 14 Jan 2021 11:42:32 +0200
Message-ID: <871renrh13.fsf@intel.com>
MIME-Version: 1.0
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
Cc: sunpeng.li@amd.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yang Li <abaci-bugfix@linux.alibaba.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 13 Jan 2021, Yang Li <abaci-bugfix@linux.alibaba.com> wrote:
> Fix the following coccicheck warning:
> ./drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c:580:23-31:
> WARNING: Comparison to bool
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c
> index 4d3f7d5..904c2d2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c
> @@ -577,7 +577,7 @@ void dpp1_power_on_degamma_lut(
>  	struct dcn10_dpp *dpp = TO_DCN10_DPP(dpp_base);
>  
>  	REG_SET(CM_MEM_PWR_CTRL, 0,
> -			SHARED_MEM_PWR_DIS, power_on == true ? 0:1);
> +			SHARED_MEM_PWR_DIS, power_on ? 0:1);

Not my driver, but this is as simple as it gets:

+			SHARED_MEM_PWR_DIS, !power_on);


>  
>  }

-- 
Jani Nikula, Intel Open Source Graphics Center
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
