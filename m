Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8B2C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Mar 2022 07:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E20F10EDFC;
	Sat, 19 Mar 2022 07:17:00 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F23E10EDFC
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Mar 2022 07:16:59 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5ae905.dynamic.kabel-deutschland.de
 [95.90.233.5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3E1F661EA1923;
 Sat, 19 Mar 2022 08:16:57 +0100 (CET)
Message-ID: <7efe6fd0-9dd2-fa80-54f7-2186b4d64721@molgen.mpg.de>
Date: Sat, 19 Mar 2022 08:16:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 01/13] drm/amd/display: HDCP SEND AKI INIT error
Content-Language: en-US
To: Alex Hung <alex.hung@amd.com>, Ahmad Othman <ahmad.othman@amd.com>
References: <20220318214800.3565679-1-alex.hung@amd.com>
 <20220318214800.3565679-2-alex.hung@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220318214800.3565679-2-alex.hung@amd.com>
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, Bhawanpreet.Lakha@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Alex, dear Ahmad,


Thank you for the patch.

Am 18.03.22 um 22:47 schrieb Alex Hung:
> From: Ahmad Othman <ahmad.othman@amd.com>

Could you please make the commit message summary/title a statement by 
adding a verb (imperative mood) [1]. Maybe:

drm/amd/display: Fix HDCP SEND AKI INIT error

> [why]
> HDCP sends AKI INIT error in case of multiple display on dock

What is the test setup exactly, and how can the error be reproduced? 
Does Linux log something?

> [how]
> Added new checks and method to handfle display adjustment

s/Added/Add/
s/handfle/handle/

> for multiple display cases

Why are these checks and methods correct, and what do they try to 
achieve? Is it the HDCP(?) specification?

> Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
> Acked-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Ahmad Othman <ahmad.othman@amd.com>

Could the order be reversed, so it’s clear that the Signed-off-by line 
came first and not after the review? Or is it actually signed off after 
the review again?

> ---
>   .../gpu/drm/amd/display/modules/hdcp/hdcp.c   | 38 ++++++++++++++++++-
>   .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |  8 ++++
>   .../drm/amd/display/modules/inc/mod_hdcp.h    |  2 +-
>   3 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
> index 3e81850a7ffe..5e01c6e24cbc 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
> @@ -251,6 +251,33 @@ static enum mod_hdcp_status reset_connection(struct mod_hdcp *hdcp,
>   	return status;
>   }
>   
> +static enum mod_hdcp_status update_display_adjustments(struct mod_hdcp *hdcp,
> +		struct mod_hdcp_display *display,
> +		struct mod_hdcp_display_adjustment *adj)
> +{
> +	enum mod_hdcp_status status = MOD_HDCP_STATUS_NOT_IMPLEMENTED;
> +
> +	if (is_in_authenticated_states(hdcp) &&
> +			is_dp_mst_hdcp(hdcp) &&
> +			display->adjust.disable == true &&
> +			adj->disable == false) {
> +		display->adjust.disable = false;
> +		if (is_hdcp1(hdcp))
> +			status = mod_hdcp_hdcp1_enable_dp_stream_encryption(hdcp);
> +		else if (is_hdcp2(hdcp))
> +			status = mod_hdcp_hdcp2_enable_dp_stream_encryption(hdcp);
> +
> +		if (status != MOD_HDCP_STATUS_SUCCESS)
> +			display->adjust.disable = true;
> +	}
> +
> +	if (status == MOD_HDCP_STATUS_SUCCESS &&
> +		memcmp(adj, &display->adjust,
> +		sizeof(struct mod_hdcp_display_adjustment)) != 0)
> +		status = MOD_HDCP_STATUS_NOT_IMPLEMENTED;
> +
> +	return status;
> +}
>   /*
>    * Implementation of functions in mod_hdcp.h
>    */
> @@ -391,7 +418,7 @@ enum mod_hdcp_status mod_hdcp_remove_display(struct mod_hdcp *hdcp,
>   	return status;
>   }
>   
> -enum mod_hdcp_status mod_hdcp_update_authentication(struct mod_hdcp *hdcp,
> +enum mod_hdcp_status mod_hdcp_update_display(struct mod_hdcp *hdcp,
>   		uint8_t index,
>   		struct mod_hdcp_link_adjustment *link_adjust,
>   		struct mod_hdcp_display_adjustment *display_adjust,
> @@ -419,6 +446,15 @@ enum mod_hdcp_status mod_hdcp_update_authentication(struct mod_hdcp *hdcp,
>   		goto out;
>   	}
>   
> +	if (memcmp(link_adjust, &hdcp->connection.link.adjust,
> +			sizeof(struct mod_hdcp_link_adjustment)) == 0 &&
> +			memcmp(display_adjust, &display->adjust,
> +					sizeof(struct mod_hdcp_display_adjustment)) != 0) {
> +		status = update_display_adjustments(hdcp, display, display_adjust);
> +		if (status != MOD_HDCP_STATUS_NOT_IMPLEMENTED)
> +			goto out;
> +	}
> +
>   	/* stop current authentication */
>   	status = reset_authentication(hdcp, output);
>   	if (status != MOD_HDCP_STATUS_SUCCESS)
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
> index 399fbca8947b..6b195207de90 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
> @@ -445,6 +445,14 @@ static inline uint8_t is_in_hdcp2_dp_states(struct mod_hdcp *hdcp)
>   			current_state(hdcp) <= HDCP2_DP_STATE_END);
>   }
>   
> +static inline uint8_t is_in_authenticated_states(struct mod_hdcp *hdcp)
> +{
> +	return (current_state(hdcp) == D1_A4_AUTHENTICATED ||
> +	current_state(hdcp) == H1_A45_AUTHENTICATED ||
> +	current_state(hdcp) == D2_A5_AUTHENTICATED ||
> +	current_state(hdcp) == H2_A5_AUTHENTICATED);
> +}
> +

The compiler is probably going to optimize the four `current_state` 
calls away, but maybe use a helper variable, so it’s clear for the 
reader the same function is each time. Also, why not put the helper into
`drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h`?

>   static inline uint8_t is_hdcp1(struct mod_hdcp *hdcp)
>   {
>   	return (is_in_hdcp1_states(hdcp) || is_in_hdcp1_dp_states(hdcp));
> diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
> index f7420c3f5672..3348bb97ef81 100644
> --- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
> +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
> @@ -294,7 +294,7 @@ enum mod_hdcp_status mod_hdcp_remove_display(struct mod_hdcp *hdcp,
>   		uint8_t index, struct mod_hdcp_output *output);
>   
>   /* called per display to apply new authentication adjustment */
> -enum mod_hdcp_status mod_hdcp_update_authentication(struct mod_hdcp *hdcp,
> +enum mod_hdcp_status mod_hdcp_update_display(struct mod_hdcp *hdcp,
>   		uint8_t index,
>   		struct mod_hdcp_link_adjustment *link_adjust,
>   		struct mod_hdcp_display_adjustment *display_adjust,


Kind regards,

Paul


[1]: https://chris.beams.io/posts/git-commit/
