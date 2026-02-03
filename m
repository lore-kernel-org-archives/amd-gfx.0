Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93E2E8B37E
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 23:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6043F10E1EA;
	Tue,  3 Feb 2026 23:44:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Uwzb+N+h";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87B2410E1EA
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 23:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Uo1clK24eLtlQbuqsF+EtuR4gdz2+gu5jV4l6O9X5Qo=; b=Uwzb+N+hdultSIKYqwrphoasWP
 KM633LCG5BD5LE016UneuC6zkfOSLUjilzhI+/YYHXr9wAQwyWwJxQOMzryjrZ5aXH7+yr+BbRh6i
 wibkCMxRZ+bKrKxsiX6JFaxaYVS9jhiFgnwZuEQ0ceo0prq8TUYmXJD/sfdXesnidXsLI06CSKzC7
 JQ+ui/M08yCZ1P7p7T/YjVjVzzKKuK+38KpYfq355Bdaim44UjfTYFLCBqmvdiPC3XJ/z5EWcWlo4
 NZ6eAjhCkihmSD10GcxfVzx3ubf5Va6qp3EysOOrTIYQywCuuZIVTe30md3UWiP7l2MXwgCT+hYdj
 MfNoeGdQ==;
Received: from d198-53-218-11.abhsia.telus.net ([198.53.218.11] helo=atmagalia)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vnQ3o-00DSZP-QL; Wed, 04 Feb 2026 00:43:57 +0100
Date: Tue, 3 Feb 2026 16:43:51 -0700
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com, 
 Leo Li <sunpeng.li@amd.com>
Subject: Re: [PATCH 3/5] drm/amd/display: Remove unused dce60_clk_mgr
 register definitions
Message-ID: <aYKH9e6VnIgRIg87@atmagalia>
References: <20260118173150.19790-1-timur.kristof@gmail.com>
 <20260118173150.19790-4-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260118173150.19790-4-timur.kristof@gmail.com>
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

On 01/18, Timur Kristóf wrote:
> It turned out that these were actually not necessary.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 30 ++-----------------
>  .../amd/display/dc/inc/hw/clk_mgr_internal.h  | 11 -------
>  2 files changed, 3 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> index 69dd80d9f738..1fdf344efe1a 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> @@ -43,30 +43,6 @@
>  #include "dce/dce_6_0_d.h"
>  #include "dce/dce_6_0_sh_mask.h"
>  
> -#define REG(reg) \
> -	(clk_mgr->regs->reg)
> -
> -#undef FN
> -#define FN(reg_name, field_name) \
> -	clk_mgr->clk_mgr_shift->field_name, clk_mgr->clk_mgr_mask->field_name
> -
> -/* set register offset */
> -#define SR(reg_name)\
> -	.reg_name = mm ## reg_name
> -
> -static const struct clk_mgr_registers disp_clk_regs = {
> -		CLK_COMMON_REG_LIST_DCE60_BASE()
> -};
> -
> -static const struct clk_mgr_shift disp_clk_shift = {
> -		CLK_COMMON_MASK_SH_LIST_DCE60_COMMON_BASE(__SHIFT)
> -};
> -
> -static const struct clk_mgr_mask disp_clk_mask = {
> -		CLK_COMMON_MASK_SH_LIST_DCE60_COMMON_BASE(_MASK)
> -};
> -
> -
>  /* Max clock values for each state indexed by "enum clocks_state": */
>  static const struct state_dependent_clocks dce60_max_clks_by_state[] = {
>  /* ClocksStateInvalid - should not be used */
> @@ -155,9 +131,9 @@ void dce60_clk_mgr_construct(
>  		dce60_max_clks_by_state,
>  		sizeof(dce60_max_clks_by_state));
>  
> -	clk_mgr->regs = &disp_clk_regs;
> -	clk_mgr->clk_mgr_shift = &disp_clk_shift;
> -	clk_mgr->clk_mgr_mask = &disp_clk_mask;
> +	clk_mgr->regs = NULL;
> +	clk_mgr->clk_mgr_shift = NULL;
> +	clk_mgr->clk_mgr_mask = NULL;

After looking into the next commit, I got why you did this change. Maybe
for future patches, expand the commit message and mention that this is a
transition step. Anyway:

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>

>  	clk_mgr->base.funcs = &dce60_funcs;
>  
>  	base->clks.max_supported_dispclk_khz =
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
> index bac8febad69a..836a28134d41 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
> @@ -89,11 +89,6 @@ enum dentist_divider_range {
>  	.DPREFCLK_CNTL = mmDPREFCLK_CNTL, \
>  	.DENTIST_DISPCLK_CNTL = mmDENTIST_DISPCLK_CNTL
>  
> -#if defined(CONFIG_DRM_AMD_DC_SI)
> -#define CLK_COMMON_REG_LIST_DCE60_BASE() \
> -	SR(DENTIST_DISPCLK_CNTL)
> -#endif
> -
>  #define CLK_COMMON_REG_LIST_DCN_BASE() \
>  	SR(DENTIST_DISPCLK_CNTL)
>  
> @@ -119,12 +114,6 @@ enum dentist_divider_range {
>  	CLK_SF(DPREFCLK_CNTL, DPREFCLK_SRC_SEL, mask_sh), \
>  	CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DPREFCLK_WDIVIDER, mask_sh)
>  
> -#if defined(CONFIG_DRM_AMD_DC_SI)
> -#define CLK_COMMON_MASK_SH_LIST_DCE60_COMMON_BASE(mask_sh) \
> -	CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, mask_sh),\
> -	CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, mask_sh)
> -#endif
> -
>  #define CLK_COMMON_MASK_SH_LIST_DCN_COMMON_BASE(mask_sh) \
>  	CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, mask_sh),\
>  	CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, mask_sh)
> -- 
> 2.52.0
> 

-- 
Rodrigo Siqueira
https://siqueira.tech
