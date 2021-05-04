Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A77C433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 07:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 893A261182
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 07:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893A261182
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14D846E428;
	Wed,  5 May 2021 07:19:19 +0000 (UTC)
X-Greylist: delayed 1296 seconds by postgrey-1.36 at gabe;
 Tue, 04 May 2021 23:04:20 UTC
Received: from gateway21.websitewelcome.com (gateway21.websitewelcome.com
 [192.185.45.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F36726E314
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 23:04:20 +0000 (UTC)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
 by gateway21.websitewelcome.com (Postfix) with ESMTP id 58C31400C865D
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 17:42:43 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id e3kZlUmGl1cHee3kZlSVj4; Tue, 04 May 2021 17:42:43 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NHD2xoQTwzYmJWBbKubtikwhWwOa5DlUVLlAco8SGhs=; b=Stx2M4E6RGBegu5L4KcuVzkEX4
 Dwn6ZLdt2fhE2ckFOhaNLGYIxri/k6sJwTFCg8yNJa5DTc3sYNt6qr6uTzoTGiN7qd+Y1qEXxlobE
 fADhcQdz6WVuX3weD78Fb8eEXsmAuxeCzi/KW9/YDnuYIFNRjmKxaqQhXh9nTRszWKmVil7LMqXe0
 rIdfB4bRoWLaYe80cRksYI2QpFzvU2cxR2qDFzwyGnCAVY4B3llrG2eV3Xp9LooX6EcaO34QHajhv
 pI7zCY0IG4ZdA/ZL+GipZrfv/h+yhMKQyeh75XU0NEvXWCiloFAI3efWUR0jWjdSoQyo5Ns96R/D/
 VA5ljvMw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:51076
 helo=[192.168.15.8])
 by gator4166.hostgator.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <gustavo@embeddedor.com>)
 id 1le3kX-002Zcb-B3; Tue, 04 May 2021 17:42:41 -0500
Subject: Re: [PATCH] Revert "drm/radeon/si_dpm: Replace one-element array with
 flexible-array in struct SISLANDS_SMC_SWSTATE"
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210504184233.2350976-1-alexander.deucher@amd.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <15cc0988-0446-5423-62d7-051ccaf2936e@embeddedor.com>
Date: Tue, 4 May 2021 17:42:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210504184233.2350976-1-alexander.deucher@amd.com>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1le3kX-002Zcb-B3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8])
 [187.162.31.110]:51076
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-Mailman-Approved-At: Wed, 05 May 2021 07:19:18 +0000
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
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

I thought it was this[1] the one causing problems[2].

--
Gustavo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=434fb1e7444a2efc3a4ebd950c7f771ebfcffa31
[2] https://lore.kernel.org/dri-devel/3eedbe78-1fbd-4763-a7f3-ac5665e76a4a@xenosoft.de/

On 5/4/21 13:42, Alex Deucher wrote:
> This reverts commit 96e27e8d919e52f30ea6b717e3cb70faa0b102cd.
> 
> This causes the SMU to fail to load the power state.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1583
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpu/drm/radeon/si_dpm.c       |  5 +++--
>  drivers/gpu/drm/radeon/sislands_smc.h | 10 +++++-----
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
> index 918609551804..91bfc4762767 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -5250,9 +5250,10 @@ static int si_upload_sw_state(struct radeon_device *rdev,
>  	int ret;
>  	u32 address = si_pi->state_table_start +
>  		offsetof(SISLANDS_SMC_STATETABLE, driverState);
> +	u32 state_size = sizeof(SISLANDS_SMC_SWSTATE) +
> +		((new_state->performance_level_count - 1) *
> +		 sizeof(SISLANDS_SMC_HW_PERFORMANCE_LEVEL));
>  	SISLANDS_SMC_SWSTATE *smc_state = &si_pi->smc_statetable.driverState;
> -	size_t state_size = struct_size(smc_state, levels,
> -					new_state->performance_level_count);
>  
>  	memset(smc_state, 0, state_size);
>  
> diff --git a/drivers/gpu/drm/radeon/sislands_smc.h b/drivers/gpu/drm/radeon/sislands_smc.h
> index fbd6589bdab9..966e3a556011 100644
> --- a/drivers/gpu/drm/radeon/sislands_smc.h
> +++ b/drivers/gpu/drm/radeon/sislands_smc.h
> @@ -182,11 +182,11 @@ typedef struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL SISLANDS_SMC_HW_PERFORMANCE_LEV
>  
>  struct SISLANDS_SMC_SWSTATE
>  {
> -	uint8_t                             flags;
> -	uint8_t                             levelCount;
> -	uint8_t                             padding2;
> -	uint8_t                             padding3;
> -	SISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[];
> +    uint8_t                             flags;
> +    uint8_t                             levelCount;
> +    uint8_t                             padding2;
> +    uint8_t                             padding3;
> +    SISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[1];
>  };
>  
>  typedef struct SISLANDS_SMC_SWSTATE SISLANDS_SMC_SWSTATE;
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
