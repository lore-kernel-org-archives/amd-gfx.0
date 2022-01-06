Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553D2C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 18:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2D3E10E9E3;
	Fri,  7 Jan 2022 18:28:05 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:8234::])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AEF510E9CD
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 11:38:56 +0000 (UTC)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2]
 helo=[192.168.66.200]); authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1n5R6c-0002Ih-10; Thu, 06 Jan 2022 12:38:54 +0100
Message-ID: <96531626-b1d0-70cd-7d87-3a282667e39e@leemhuis.info>
Date: Thu, 6 Jan 2022 12:38:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] drm/amd/display: explicitly update clocks when DC is
 set to D3 in s0i3
Content-Language: en-BW
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220105170656.2121-1-mario.limonciello@amd.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20220105170656.2121-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1641469136;
 7dff8ecd; 
X-HE-SMSGID: 1n5R6c-0002Ih-10
X-Mailman-Approved-At: Fri, 07 Jan 2022 18:28:01 +0000
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
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>, Scott Bruce <smbruce@gmail.com>,
 spasswolf@web.de, Chris Hixon <linux-kernel-bugs@hixontech.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi, this is your Linux kernel regression tracker speaking.

On 05.01.22 18:06, Mario Limonciello wrote:
> The WA from commit 5965280abd30 ("drm/amd/display: Apply w/a for
> hard hang on HPD") causes a regression in s0ix where the system will
> fail to resume properly.  This may be because an HPD was active the last
> time clocks were updated but clocks didn't get updated again during s0ix.
> 
> So add an extra call to update clocks as part of the suspend routine:
> dm_suspend->dc_set_power_state->clk_mgr_optimize_pwr_state
> 
> In case HPD is set during this time, also check if the call happened during
> suspend to allow overriding the WA.

Thx for this. Our of interest: is that something that should still go
into v5.16?

> Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
> Reported-by: Scott Bruce <smbruce@gmail.com>
> Reported-by: Chris Hixon <linux-kernel-bugs@hixontech.com>
> Reported-by: spasswolf@web.de
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215436
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1821
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1852

What is "BugLink"? It's not mention in the kernel's documentation, which
tells people to use "Link:" for linking to bug reports:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

That is not new, bug recently was made more explicit.

Hence, please consider changing them to "Link:", there are tools out
there that repy on them (I'm running such a tool, but there might be
others out there we are not aware of).

FWIW, in principe I agree that we need a seperate tag for this. But then
we should get this discussed and blessed through the usual channels.
That's why I recently proposed "Reported:", without much success so far:
https://lore.kernel.org/lkml/c6724c7fb534a46e095e6aef13d996ed9589e578.1639042966.git.linux@leemhuis.info/

Ciao, Thorsten

> Fixes: 5965280abd30 ("drm/amd/display: Apply w/a for hard hang on HPD")
> Fixes: 1bd3bc745e7f ("drm/amd/display: Extend w/a for hard hang on HPD to dcn20")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> changes from v1->v2:
>  * Add fallthrough statement
>  * Extend case to check if call was explicitly in s0ix since #1852 showed hpd_state
>    can be set at this time too
>  * Adjust commit message and title
>  * Add extra commit and bug fixed to metadata
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 5 ++++-
>  drivers/gpu/drm/amd/display/dc/core/dc.c                  | 3 +++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> index fbda42313bfe..fa5efe10b779 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> @@ -23,6 +23,8 @@
>   *
>   */
>  
> +#include "amdgpu.h"
> +
>  #include "dccg.h"
>  #include "clk_mgr_internal.h"
>  
> @@ -126,6 +128,7 @@ static void rn_update_clocks(struct clk_mgr *clk_mgr_base,
>  			bool safe_to_lower)
>  {
>  	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
> +	struct amdgpu_device *adev = clk_mgr_base->ctx->driver_context;
>  	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
>  	struct dc *dc = clk_mgr_base->ctx->dc;
>  	int display_count;
> @@ -157,7 +160,7 @@ static void rn_update_clocks(struct clk_mgr *clk_mgr_base,
>  			}
>  
>  			/* if we can go lower, go lower */
> -			if (display_count == 0 && !hpd_state) {
> +			if (display_count == 0 && (adev->in_s0ix || !hpd_state)) {
>  				rn_vbios_smu_set_dcn_low_power_state(clk_mgr, DCN_PWR_STATE_LOW_POWER);
>  				/* update power state */
>  				clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 91c4874473d6..8e0c820f6892 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3299,6 +3299,9 @@ void dc_set_power_state(
>  		}
>  
>  		break;
> +	case DC_ACPI_CM_POWER_STATE_D3:
> +		clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
> +		fallthrough;
>  	default:
>  		ASSERT(dc->current_state->stream_count == 0);
>  		/* Zero out the current context so that on resume we start with

