Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6E1C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 21:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EDD16EC77;
	Wed, 24 Nov 2021 21:21:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D59978951E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 21:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=Xgo+4TE4h8KCeCovwX9CUyPPqQFju/ywCkMLLVNBvX4=; b=m5bS8kGJDxhZUHpW613edA5Pll
 cwC2BNDi4U/iJCgh7ecXd3gTivFB3ZVUNPeWpoAuL8ZWjdnYOLE4vwsZRzPS/y5Cr23ra7CKbKcrB
 ZFZXvSBWaKmJK588LlNogHVhfHoYazHnc0x0R7zzNsxrtRZCcvB9cgrV/6N/1KXXMLQjZPTd0aNV7
 zF4Z/xWJlhSsYXpMQQXs8t0wVeIsUJJ2Ub2aTG3x4G2Vi1nkMbJ1SRuDca0c9+/FTLE9t5Y623d/o
 gPCJJTUV+LeQlrd+l4TeQ+AEFTL9M9O6Lhd6bzzmw/lv+SpvY7pUHLuJRwJ/DQDq6zyOohc8TswKH
 DgGNDN1w==;
Received: from [2601:1c0:6280:3f0::aa0b]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpzUi-005r3s-7K; Wed, 24 Nov 2021 21:07:56 +0000
Subject: Re: [PATCH] drm/amd/display: fix 64 bit divide
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211124163612.2728640-1-alexander.deucher@amd.com>
 <20211124163612.2728640-2-alexander.deucher@amd.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9ab493e8-4993-e90d-8d2d-b65dd0737f02@infradead.org>
Date: Wed, 24 Nov 2021 13:07:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211124163612.2728640-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 24 Nov 2021 21:21:25 +0000
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
Cc: Bing Guo <Bing.Guo@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/24/21 8:36 AM, Alex Deucher wrote:
> Use do_div.
> 
> Fixes: c34f1652a18c4b ("drm/amd/display: fixed an error related to 4:2:0/4:2:2 DSC")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Bing Guo <Bing.Guo@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>   drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
> index 381561ee0026..7e306aa3e2b9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
> @@ -100,6 +100,7 @@ int dscc_compute_dsc_parameters(const struct drm_dsc_config *pps, struct dsc_par
>   	int              ret;
>   	struct rc_params rc;
>   	struct drm_dsc_config   dsc_cfg;
> +	unsigned long long tmp;
>   
>   	calc_rc_params(&rc, pps);
>   	dsc_params->pps = *pps;
> @@ -111,9 +112,9 @@ int dscc_compute_dsc_parameters(const struct drm_dsc_config *pps, struct dsc_par
>   	dsc_cfg.mux_word_size = dsc_params->pps.bits_per_component <= 10 ? 48 : 64;
>   
>   	ret = drm_dsc_compute_rc_parameters(&dsc_cfg);
> -	dsc_params->bytes_per_pixel =
> -			(uint32_t)(((unsigned long long)dsc_cfg.slice_chunk_size * 0x10000000 + (dsc_cfg.slice_width - 1))
> -							/ (uint32_t)dsc_cfg.slice_width);  //ROUND-UP
> +	tmp = (unsigned long long)dsc_cfg.slice_chunk_size * 0x10000000 + (dsc_cfg.slice_width - 1);
> +	do_div(tmp, (uint32_t)dsc_cfg.slice_width);  //ROUND-UP
> +	dsc_params->bytes_per_pixel = (uint32_t)tmp;
>   
>   	copy_pps_fields(&dsc_params->pps, &dsc_cfg);
>   	dsc_params->rc_buffer_model_size = dsc_cfg.rc_bits;
> 


-- 
~Randy
