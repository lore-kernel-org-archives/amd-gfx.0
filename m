Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CC5C5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 22:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB86710F3CA;
	Fri, 21 Aug 2026 22:03:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dhr/05GM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B45F110F3CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 22:03:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 271E961126;
 Fri, 21 Aug 2026 22:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98931F000E9;
 Fri, 21 Aug 2026 22:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787349800;
 bh=lFzPN75H8c5cMbkUyImWjWzU/3A8poAocV/q2H7B7/Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=dhr/05GMzGpwTEDMC3Q+NVGkKuH4estonwqBmcblg0UY2iwPhPKnQcAwggoWuT59t
 tHckh9fZQRG4y9XaAmo70mvv5LX56Jqvk+rVhZwX5Q6nm5GXIeKWzo5gFhqrD23ol4
 sdNgapR14kxre+u07pHLNzYt1tHJtLPqhmPqnW8mGEZddLiHdw9S0W3h1lkx0Na5oI
 WUvfPH7QO5Od5Bun4OvLaNYzJXri8aW1ArQPvq2K8mUdGHdDwj41QMT7Lw4kAki5x8
 H+odBXO73OoUzjjcHEAnq9TjAcSxhV54P9c23SADgzTo4h/jlCAu9JK7NNP+hmQiLm
 9RUFrEuTfNqeQ==
Message-ID: <4882a9d3-3a39-4bb1-a907-2b933bc431b2@kernel.org>
Date: Fri, 21 Aug 2026 17:03:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/display: Fix HPD consideration for VGA/LVDS
 connectors on DCE
Content-Language: en-US
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Melissa Wen <mwen@igalia.com>, harry.wentland@amd.com,
 Leo Li <sunpeng.li@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>
Cc: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Roman Li <roman.li@amd.com>
References: <20260821215059.312868-1-timur.kristof@gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260821215059.312868-1-timur.kristof@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/21/26 16:50, Timur Kristóf wrote:
> After a refactor that landed in Linux 7.0,
> DC now crashes when it is initialized on GPUs
> that have a VGA or LVDS connector. This is because
> these connectors have no HPD so the hpd_gpio is NULL
> and therefore DC takes the code path meant for
> DCN 4.2+ which sets irq_source_hpd = 255 that
> causes the subsequent code to try to register
> the HPD interrupt, which fails, and causes
> a crash.
> 
> This commit should be backported to Linux 7.0 and newer.
Unfortunately 7.0.y is EoL.  But we'll get it in 7.1.y and later.

> 
> Cc: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5490
> Fixes: def3488eb0fd ("drm/amd/display: refactor HPD to increase flexibility")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

I'll get this committed to amd-staging-drm-next.
> ---
>   drivers/gpu/drm/amd/display/dc/link/link_factory.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> index 8560ee727bfa..a83693ea43c0 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> @@ -643,7 +643,7 @@ static bool construct_phy(struct dc_link *link,
>   
>   		DC_LOG_DC("BIOS object table - hpd_gpio id: %d", enc_init_data.hpd_gpio->id);
>   		DC_LOG_DC("BIOS object table - hpd_gpio en: %d", enc_init_data.hpd_gpio->en);
> -	} else {
> +	} else if (link->ctx->dce_version > DCN_VERSION_4_01) {
>   		struct graphics_object_hpd_info hpd_info;
>   
>   		if (link->ctx->dc_bios->funcs->get_hpd_info(link->ctx->dc_bios, link->link_id, &hpd_info) == BP_RESULT_OK) {

