Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B4ACD1292
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 13:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6601210EC08;
	Mon,  1 Apr 2024 13:30:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="AQnDpqls";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 076B210EC08
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 13:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QZv1amQOp8f7KnFdpMcke/x/WRK2zxctpzEg29hlUR0=; b=AQnDpqlsKdMcFRDfT7eMq1S+PH
 9CRSZ1KvM4ogEGfErptvmy+zRANE2HslFVrCMXxTUOK1mNbdTa4eNHpNrj6+t5SVAcessiIs61Rij
 H8ctozi+5C9iJ1Qq1LKZsbMtithOFtDdb+wk5K26wE3o0sYuCNE7/4DKlUH6r0zO3etBdLdrmuA22
 YzGNzL/MheBYUHLd8QkNKJTXbuBCWiMNuczh92yIihb4EHuH/H4KFvn8agkkg3kc8eg8Rp8kcdffh
 ljDNCigsS7ZX8VibAs8A5OOkqQydXpgQpmyy5Mqz8bo+XKepnW08Eh9gXz4WoCyusEFu8td24VvKL
 FvjPZimQ==;
Received: from [189.6.17.125] (helo=[192.168.0.55])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1rrHkU-0001hG-FN; Mon, 01 Apr 2024 15:30:54 +0200
Message-ID: <33db3d69-df86-463a-b72d-1c1a50a03906@igalia.com>
Date: Mon, 1 Apr 2024 10:30:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 38/43] drm/amd/display: Fix MPCC DTN logging
To: Roman.Li@amd.com, amd-gfx@lists.freedesktop.org
Cc: Daniel Wheeler <daniel.wheeler@amd.com>, Harry.Wentland@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, solomon.chiu@amd.com, agustin.gutierrez@amd.com,
 hamza.mahfooz@amd.com, Eric Bernstein <eric.bernstein@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
 <20240328195047.2843715-39-Roman.Li@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20240328195047.2843715-39-Roman.Li@amd.com>
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
> From: Eric Bernstein <eric.bernstein@amd.com>
>
> [Why]
> DTN only logs 'pipe_count' instances of MPCC.
> However in some cases there are different number of
> MPCC than DPP (pipe_count).
>
> [How]
> Add mpcc_count parameter to resource_pool and set it
> during pool construction and use it for DTN logging of
> MPCC state.
Should we do the same in dcn*_log_color_state() for the loop of 
`pool->mpx->funcs->read_mpcc_state()` there?

It affects the following files:
drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c

BR,

Melissa
>
> Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
> index 9033b39e0e0c..c51b717e5622 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
> @@ -392,7 +392,7 @@ static unsigned int dcn10_get_mpcc_states(struct dc *dc, char *pBuf, unsigned in
>   	remaining_buffer -= chars_printed;
>   	pBuf += chars_printed;
>   
> -	for (i = 0; i < pool->pipe_count; i++) {
> +	for (i = 0; i < pool->mpcc_count; i++) {
>   		struct mpcc_state s = {0};
>   
>   		pool->mpc->funcs->read_mpcc_state(pool->mpc, i, &s);

