Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52059C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DF760F9D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A2DF760F9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52F446EAAC;
	Mon, 18 Oct 2021 23:23:05 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 273586EAAC
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 23:23:04 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae8cf.dynamic.kabel-deutschland.de
 [95.90.232.207])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0FACC61E5FE33;
 Tue, 19 Oct 2021 01:23:02 +0200 (CEST)
Subject: Re: [PATCH 26/27] Revert "drm/amd/display: Fix error in dmesg at boot"
To: Agustin Gutierrez <agustin.gutierrez@amd.com>
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, qingqing.zhuo@amd.com,
 mikita.lipski@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 wayne.lin@amd.com, stylon.wang@amd.com, solomon.chiu@amd.com,
 pavle.kotarac@amd.com, amd-gfx@lists.freedesktop.org
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
 <20211015184332.221091-27-agustin.gutierrez@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <d1b75ce6-7aef-2d5c-4391-e69a61a310d2@molgen.mpg.de>
Date: Tue, 19 Oct 2021 01:23:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211015184332.221091-27-agustin.gutierrez@amd.com>
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

Dear Augustin,


Am 15.10.21 um 20:43 schrieb Agustin Gutierrez:
> This reverts commit 4e605d4b6a510f751b22df4d13829aefb8a0ccec.

Why?

(Do revert commits need a Signed-off-by line?)


Kind regards,

Paul


> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 6db611f9f554..c01309a1cbf2 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -1999,7 +1999,7 @@ void blank_all_dp_displays(struct dc *dc, bool hw_init)
>   
>   		if ((signal == SIGNAL_TYPE_EDP) ||
>   			(signal == SIGNAL_TYPE_DISPLAY_PORT)) {
> -			if (hw_init && signal != SIGNAL_TYPE_EDP && dc->links[i]->priv != NULL) {
> +			if (hw_init && signal != SIGNAL_TYPE_EDP) {
>   				/* DP 2.0 spec requires that we read LTTPR caps first */
>   				dp_retrieve_lttpr_cap(dc->links[i]);
>   				/* if any of the displays are lit up turn them off */
> @@ -2025,7 +2025,7 @@ void blank_all_dp_displays(struct dc *dc, bool hw_init)
>   				}
>   
>   				if (!dc->links[i]->wa_flags.dp_keep_receiver_powered ||
> -					(hw_init && signal != SIGNAL_TYPE_EDP && dc->links[i]->priv != NULL))
> +					(hw_init && signal != SIGNAL_TYPE_EDP))
>   					dp_receiver_power_ctrl(dc->links[i], false);
>   			}
>   		}
> 
