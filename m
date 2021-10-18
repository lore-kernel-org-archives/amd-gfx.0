Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364C9C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 22:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3378C611C6
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 22:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3378C611C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B821C6EA7C;
	Mon, 18 Oct 2021 22:56:14 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C7E16EA7C
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 22:56:13 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae8cf.dynamic.kabel-deutschland.de
 [95.90.232.207])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id E92DB61E5FE33;
 Tue, 19 Oct 2021 00:56:11 +0200 (CEST)
Subject: Re: [PATCH 17/27] drm/amd/display: Increase watermark latencies for
 DCN3.1
To: Agustin Gutierrez <agustin.gutierrez@amd.com>
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, qingqing.zhuo@amd.com,
 mikita.lipski@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 wayne.lin@amd.com, stylon.wang@amd.com, solomon.chiu@amd.com,
 pavle.kotarac@amd.com, Nikola Cornij <nikola.cornij@amd.com>,
 Ahmad Othman <ahmad.othman@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
 <20211015184332.221091-18-agustin.gutierrez@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <5029adc4-8b6c-8635-4b96-eddc87ccc7f5@molgen.mpg.de>
Date: Tue, 19 Oct 2021 00:56:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211015184332.221091-18-agustin.gutierrez@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Dear Nikola, dear Augustin,


Am 15.10.21 um 20:43 schrieb Agustin Gutierrez:
> From: Nikola Cornij <nikola.cornij@amd.com>
> 
> [why]
> The original latencies were causing underflow in some modes

Which modes exactly? On what hardware? How can it be reproduced?

> [how]
> Replace with the up-to-date watermark values based on new measurments

measurements

How can these measurements be done?


Kind regards,

Paul


> Reviewed-by: Ahmad Othman <ahmad.othman@amd.com>
> Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
> Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
> ---
>   .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
> index 3fae1f1f028d..0088dff441da 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
> @@ -371,32 +371,32 @@ static struct wm_table lpddr5_wm_table = {
>   			.wm_inst = WM_A,
>   			.wm_type = WM_TYPE_PSTATE_CHG,
>   			.pstate_latency_us = 11.65333,
> -			.sr_exit_time_us = 5.32,
> -			.sr_enter_plus_exit_time_us = 6.38,
> +			.sr_exit_time_us = 11.5,
> +			.sr_enter_plus_exit_time_us = 14.5,
>   			.valid = true,
>   		},
>   		{
>   			.wm_inst = WM_B,
>   			.wm_type = WM_TYPE_PSTATE_CHG,
>   			.pstate_latency_us = 11.65333,
> -			.sr_exit_time_us = 9.82,
> -			.sr_enter_plus_exit_time_us = 11.196,
> +			.sr_exit_time_us = 11.5,
> +			.sr_enter_plus_exit_time_us = 14.5,
>   			.valid = true,
>   		},
>   		{
>   			.wm_inst = WM_C,
>   			.wm_type = WM_TYPE_PSTATE_CHG,
>   			.pstate_latency_us = 11.65333,
> -			.sr_exit_time_us = 9.89,
> -			.sr_enter_plus_exit_time_us = 11.24,
> +			.sr_exit_time_us = 11.5,
> +			.sr_enter_plus_exit_time_us = 14.5,
>   			.valid = true,
>   		},
>   		{
>   			.wm_inst = WM_D,
>   			.wm_type = WM_TYPE_PSTATE_CHG,
>   			.pstate_latency_us = 11.65333,
> -			.sr_exit_time_us = 9.748,
> -			.sr_enter_plus_exit_time_us = 11.102,
> +			.sr_exit_time_us = 11.5,
> +			.sr_enter_plus_exit_time_us = 14.5,
>   			.valid = true,
>   		},
>   	}
> 
