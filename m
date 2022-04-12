Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E10C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 18:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC3F10E29A;
	Tue, 12 Apr 2022 18:53:38 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3A4010E29A
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 18:53:37 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae911.dynamic.kabel-deutschland.de
 [95.90.233.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 846CF61EA1923;
 Tue, 12 Apr 2022 20:53:35 +0200 (CEST)
Message-ID: <c5b97413-ea28-8dbc-90af-7226776d1a9a@molgen.mpg.de>
Date: Tue, 12 Apr 2022 20:53:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] Revert "drm/amd/display: Pass HostVM enable flag into
 DCN3.1 DML"
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20220412184421.573344-1-Rodrigo.Siqueira@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220412184421.573344-1-Rodrigo.Siqueira@amd.com>
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 Mark Broadworth <Mark.Broadworth@amd.com>,
 Michael Strauss <michael.strauss@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Rodrigo,


Thank you for the patch.


Am 12.04.22 um 20:44 schrieb Rodrigo Siqueira:
> This reverts commit 367b3e934f578f6c0d5d8ca5987dc6ac4cd6831d.
> 
> While we were testing DCN3.1 with a hub, we noticed that only one of 2
> connected displays lights up when using some specific display
> resolution. After bisecting this issue, we figured out the commit
> mentioned above introduced this issue. We are investigating why this
> patch introduced this regression, but we need to revert it for now.

Thank you for bisecting this. It’d be great if you added the information 
about the test setup: graphics card, displays (model and connected how), 
model of the hub, and the resolution causing issues.


Kind regards,

Paul


> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Mark Broadworth <Mark.Broadworth@amd.com>
> Cc: Michael Strauss <michael.strauss@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> index 6cc580be7c79..5b3f0c2dfb55 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> @@ -1668,7 +1668,6 @@ int dcn31_populate_dml_pipes_from_context(
>   		pipes[pipe_cnt].pipe.src.immediate_flip = true;
>   
>   		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
> -		pipes[pipe_cnt].pipe.src.hostvm = dc->res_pool->hubbub->riommu_active;
>   		pipes[pipe_cnt].pipe.src.gpuvm = true;
>   		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
>   		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
