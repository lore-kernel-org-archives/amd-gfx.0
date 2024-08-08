Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B10C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 22:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A800E10E822;
	Thu,  8 Aug 2024 22:06:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="O+XzCVyJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA04710E822
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 22:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I/2PEdc7CHTMGBbIBTClV7gz3ZgRK4vf7audyH/ULUI=; b=O+XzCVyJ24vs5NERlXe0UfoMNH
 Qtk02b9Zz8+htTwaG7DaU21s7iwPrPtha804kbGuTpRKVYOLtFblEb0CQ20F7taqLhAHTYW/8zTDo
 enX70fVLCgB3AcXTiXuLMs+9ljDiFpURb69/4niww1ZnxCSMiRJS4+qLiDmldPjNzwK8zb20+wCEE
 5dZxU5hfh7yLiFbrv/Qqgdc8sd7Ej1CzrjkbV9b2bX2uYIBE77YkNi4kJYnAd7dYHi1bA3pHVhVB9
 bP0wpjjLZR5Rvq7+GrEkpYtXixinxUKIPHqnmskx0n19KeiqD4UuBuEarSZrQ4NUzi2Ty+8+J4iOQ
 oaQDwW7Q==;
Received: from [189.6.17.125] (helo=[192.168.0.55])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1scBH5-009WT0-1B; Fri, 09 Aug 2024 00:06:23 +0200
Message-ID: <24bdf1f8-4661-46d1-9f5b-3cf835e39c22@igalia.com>
Date: Thu, 8 Aug 2024 19:06:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/24] drm/amd/display: Adjust cursor position
To: Tom Chung <chiahsuan.chung@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, roman.li@amd.com, wayne.lin@amd.com,
 agustin.gutierrez@amd.com, jerry.zuo@amd.com, zaeem.mohamed@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
 <20240807075546.831208-23-chiahsuan.chung@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20240807075546.831208-23-chiahsuan.chung@amd.com>
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



On 07/08/2024 04:55, Tom Chung wrote:
> From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>
> [why & how]
> When the commit 9d84c7ef8a87 ("drm/amd/display: Correct cursor position
> on horizontal mirror") was introduced, it used the wrong calculation for
> the position copy for X. This commit uses the correct calculation for that
> based on the original patch.
>
> Fixes: 9d84c7ef8a87 ("drm/amd/display: Correct cursor position on horizontal mirror")
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Acked-by: Wayne Lin <wayne.lin@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> index 802902f54d09..01dffed4d30b 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> @@ -3687,7 +3687,7 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
>   						(int)hubp->curs_attr.width || pos_cpy.x
>   						<= (int)hubp->curs_attr.width +
>   						pipe_ctx->plane_state->src_rect.x) {
> -						pos_cpy.x = 2 * viewport_width - temp_x;
> +						pos_cpy.x = temp_x + viewport_width;
Hey,

AFAIU, this patch reverts the change in the previous patch.
Or this should be discarded, or both.

Melissa
>   					}
>   				}
>   			} else {

