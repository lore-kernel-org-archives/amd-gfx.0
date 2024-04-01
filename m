Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE47CD1292
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 13:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A341E10F185;
	Mon,  1 Apr 2024 13:40:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="eIUio/pl";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC23410F185
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qm5vtlAPIJEkkxho84UyBuaddXJmfwLH1FpD1AboF98=; b=eIUio/pl1BE8TkGy4B17rhIVnd
 5vXfodpAswc94t+e/hK6F7XBANtRCzllaSPAa9zIyB/j1626tgodtJzBIQEHaL9Q7sFpZ39pyF3Gp
 ENTI3vi68vAspBo67VG1BK+ydOiWrCe7brEgJDQemCfkurVrxuWl8t+lwngyFfQT6KhsGrNEic1tp
 lgs1Uw1uhuDBzU7Ly4ijarYdMIPLxxYaX1nhHXqS79TTkIDcTrfDJvP9TbwaINGBr7nVOWzHmdOvG
 0/TX8VJmNren3o9ycz5YOKKCELdVAtYSzhGbIRB4Oy2DOvrSrzBzzd2QpiRRIeKaNl7KJWzLyKdLe
 ouxaJX1A==;
Received: from [189.6.17.125] (helo=[192.168.0.55])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1rrHti-0001py-7m; Mon, 01 Apr 2024 15:40:26 +0200
Message-ID: <e39bd7f4-827a-44cf-8759-f6967ee24f49@igalia.com>
Date: Mon, 1 Apr 2024 10:40:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/43] drm/amd/display: Enable cur_rom_en even if cursor
 degamma is not enabled
Content-Language: en-US
To: Roman.Li@amd.com, amd-gfx@lists.freedesktop.org
Cc: Daniel Wheeler <daniel.wheeler@amd.com>, Harry.Wentland@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, solomon.chiu@amd.com, agustin.gutierrez@amd.com,
 hamza.mahfooz@amd.com
References: <20240328195047.2843715-1-Roman.Li@amd.com>
 <20240328195047.2843715-31-Roman.Li@amd.com>
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20240328195047.2843715-31-Roman.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 28/03/2024 16:50, Roman.Li@amd.com wrote:
> From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
> index f8c0cee34080..ed1e2f65f5b5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
> @@ -395,9 +395,7 @@ void dpp3_set_cursor_attributes(
>   
>   	if (color_format == CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA ||
>   		color_format == CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA) {
> -		if (cursor_attributes->attribute_flags.bits.ENABLE_CURSOR_DEGAMMA) {
> -			cur_rom_en = 1;
> -		}
> +		cur_rom_en = 1;
ugh. At first glance, I think it will cause a regression with legacy gamma.

For references:
- https://gitlab.freedesktop.org/drm/amd/-/issues/1513
- https://lore.kernel.org/amd-gfx/20230731083505.1500965-1-mwen@igalia.com/
- https://lore.kernel.org/amd-gfx/20230824133810.10627-1-mwen@igalia.com/

BR,

Melissa
>   	}
>   
>   	REG_UPDATE_3(CURSOR0_CONTROL,

