Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31C9C433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  9 Apr 2022 20:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BB18892EE;
	Sat,  9 Apr 2022 20:19:32 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DDAD10E61A
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Apr 2022 20:19:25 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae90c.dynamic.kabel-deutschland.de
 [95.90.233.12])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7D91561EA1928;
 Sat,  9 Apr 2022 22:19:23 +0200 (CEST)
Message-ID: <c9d909ce-c1f2-8d8d-4c06-57c2cea01733@molgen.mpg.de>
Date: Sat, 9 Apr 2022 22:19:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 04/20] drm/amd/display: Disallow entering PSR when panel
 is disconnected
Content-Language: en-US
To: Pavle Kotarac <Pavle.Kotarac@amd.com>, Max Erenberg <merenber@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
 <20220408171911.601615-5-Pavle.Kotarac@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220408171911.601615-5-Pavle.Kotarac@amd.com>
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
Cc: stylon.wang@amd.com, Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>,
 Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, amd-gfx@lists.freedesktop.org,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nicholas Choi <Nicholas.Choi@amd.com>,
 Harry Vanzylldejong <harry.vanzylldejong@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Pavle, dear Max,


Am 08.04.22 um 19:18 schrieb Pavle Kotarac:
> From: Max Erenberg <merenber@amd.com>
> 
> [WHY]
> The dGPU cannot enter PSR when it is not connected to a panel.

Maybe spell out Panel Self Refresh once.

> [HOW]
> Added a check to dc_link_set_psr_allow_active

s/Added/Add/

> which returns early if panel is disconnected.

Please reflow for 57 characters per line.

> 
> Reviewed-by: Harry Vanzylldejong <harry.vanzylldejong@amd.com>
> Reviewed-by: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>
> Reviewed-by: Nicholas Choi <Nicholas.Choi@amd.com>
> Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
> Signed-off-by: Max Erenberg <merenber@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_link.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 47b67fd1e84c..22f2d88fab99 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -3079,6 +3079,11 @@ bool dc_link_set_psr_allow_active(struct dc_link *link, const bool *allow_active
>   	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
>   		return false;
>   
> +	if (allow_active && link->type == dc_connection_none) {

Why does `allow_active` need to be checked?

> +		// Don't enter PSR if panel is not connected
> +		return false;
> +	}
> +
>   	/* Set power optimization flag */
>   	if (power_opts && link->psr_settings.psr_power_opt != *power_opts) {
>   		link->psr_settings.psr_power_opt = *power_opts;


Kind regards,

Paul
