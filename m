Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067CEC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 09:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F33B10E498;
	Tue, 15 Mar 2022 09:35:55 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 332D810E4C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 09:35:54 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5ae8f9.dynamic.kabel-deutschland.de
 [95.90.232.249])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 528BA61EA1929;
 Tue, 15 Mar 2022 10:35:52 +0100 (CET)
Message-ID: <2fccbf5f-2a9d-c40e-f5dc-24a5ec08a15b@molgen.mpg.de>
Date: Tue, 15 Mar 2022 10:35:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 06/12] drm/amd/display: Add new enum for EDID status
Content-Language: en-US
To: Agustin Gutierrez <agustin.gutierrez@amd.com>,
 Dale Zhao <dale.zhao@amd.com>
References: <20220310222045.664867-1-agustin.gutierrez@amd.com>
 <20220310222045.664867-7-agustin.gutierrez@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220310222045.664867-7-agustin.gutierrez@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, amd-gfx@lists.freedesktop.org,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Agustin, dear Dale,


Am 10.03.22 um 23:20 schrieb Agustin Gutierrez:
> From: Dale Zhao <dale.zhao@amd.com>
> 
> [Why]
> We must support a new type of partial edid return in the future

What changed, that you need to support it now? The exact DisplayCore(?) 
version should be documented returning this.

Anyway, please elaborate, what “partial EDID return” is exactly.

> [How]
> Add interface and case hander for partial edid

hander?

> Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
> Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
> Signed-off-by: Dale Zhao <dale.zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 +++
>   drivers/gpu/drm/amd/display/dc/dc_types.h     | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index b3ca3307d39d..cb87dd643180 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -1183,6 +1183,9 @@ static bool detect_link_and_local_sink(struct dc_link *link,
>   		case EDID_BAD_CHECKSUM:
>   			DC_LOG_ERROR("EDID checksum invalid.\n");
>   			break;
> +		case EDID_PARTIAL_VALID:
> +			DC_LOG_ERROR("Partial EDID valid, abandon invalid blocks.\n");

Is that an error of the monitor/display. Please add a big warning asking 
the user to contact the device manufacturer to fix it.


Kind regards,

Paul


> +			break;
>   		case EDID_NO_RESPONSE:
>   			DC_LOG_ERROR("No EDID read.\n");
>   			/*
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
> index 48859d5fc172..2ba9f528c0fe 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
> @@ -138,6 +138,7 @@ enum dc_edid_status {
>   	EDID_BAD_CHECKSUM,
>   	EDID_THE_SAME,
>   	EDID_FALL_BACK,
> +	EDID_PARTIAL_VALID,
>   };
>   
>   enum act_return_status {
