Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B16C83F26
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jul 2025 23:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F2E710E052;
	Thu, 24 Jul 2025 23:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="eJPyw1h5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 818C810E052
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jul 2025 23:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iAcl2fCcESZr1y4Olj4gNMjYktkkxQCv/yCbW9Y1P40=; b=eJPyw1h5LQr/plP4GjcEQNunQ8
 LCcCf9SvrbZqeKRrtT2ClWg2QPTJZTP5jDoIierCM1siBxkvJOqNwAdHY+VntUCBqPtjWLULTwKMD
 K+0A3iD/TvrTH0FImvM8eukYZV9Q7mhrqxntAeBJ2TGbF19gC4WmQ4/qFmpX1agbJBXpIxMWRBU1w
 h+n9/I1ILBQWkb+00RPt/CNNvgpQhjYBQ2KPKGGEXLJ5r5DHIxLfxF+FH3nNO7yzXpat+OwvWL0Pt
 A8tBYQK1yxG/VJnK35atA5t3LBfR8oUUFYE9HYjobDkpv7S+/zKPvE7blDEUR/yqETDwRBKki0S5G
 18+yntJw==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uf50l-003Q69-9r; Fri, 25 Jul 2025 01:06:03 +0200
Date: Thu, 24 Jul 2025 17:05:59 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Daniel Wheeler <daniel.wheeler@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Alex Hung <alex.hung@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: Re: [PATCH 0/3] Fix some DC regressions on DCE 6-8
Message-ID: <s2mjfxh2re2rx76kuu5rh4kye3fbve2lapu4bmoe4gahgbgcha@f6k7klywlpwp>
References: <20250722155830.67401-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250722155830.67401-1-timur.kristof@gmail.com>
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

On 07/22, Timur Kristóf wrote:
> This series fixes some regressions in DC, mainly on DCE6-8.
> 
> There is a fix for a recent regression caused by refactoring
> the DSC cap calculation that affects DCE8-10,  as well as
> some fixes related to clock sources in DCE 6.
> 
> Timur Kristóf (3):
>   drm/amd/display: Fix refactored DSC cap calculation
>   drm/amd/display: Don't overwrite dce60_clk_mgr
>   drm/amd/display: Fix DCE 6.0 and 6.4 PLL programming.
> 
>  .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  1 -
>  .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  5 +++
>  drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 17 +++++-----
>  .../dc/resource/dce60/dce60_resource.c        | 34 +++++++++++--------
>  4 files changed, 34 insertions(+), 23 deletions(-)
> 
> -- 
> 2.50.1
>

Hi Dan,

I think this is a good candidate for next week's promotion. Tbh, I doubt
you will see any issues in the ASICs that you are currently using for
test. Perhaps it would be nice to have some old DCE devices for the next
round of testing that includes this series?

Timur also has the following series that could be put together with this
one in next week's promotion to save time. All of his patches are
focused on DCE devices (but the series below could have some impact on
new devices), and the last one addresses analog connector.

https://patchwork.freedesktop.org/series/152016/

Thanks

-- 
Rodrigo Siqueira
