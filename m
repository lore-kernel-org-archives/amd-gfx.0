Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C34E81BD3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 15:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA7A10E422;
	Mon,  9 Feb 2026 15:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="G4uRwDdX";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEBF610E422
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 15:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=P/zBpDH6fvKZD2z3Gh2l+UmTWQzCbItY4EkrK3IIzvU=; b=G4uRwDdXHGPkSwhoAwJRjERz5V
 3O2t9q5N7OKVPvNWtyiLxMF2jbx7sm5nMx6vT1ikJynjydJsL3s7PSKCc5FNMRCyL0D9n1bTgCtSv
 3ZNW9/SIzZ/PPUSOOjJi1+N5ImEJ3t19EKNhH3rDKG9ymG6T041ac+MBedR8GgPXHrlTq2UwJz++8
 O2tLfNd4X15Q6pRcuLwCCByMUqo3JbPO6fnu0mUOI2XFP4jtW5Yc/Yb3CforWSuKB20mkOf+DpFuE
 m+aVPg34fkeX1EJqITx5ZsJuV9j5wz1x2dF0/AYKZhzZiUtwXsE5NFgcJDYPa7Ax3FnXftHr/VPsI
 5p9gHAZg==;
Received: from d198-53-218-11.abhsia.telus.net ([198.53.218.11] helo=atmagalia)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vpTV1-00G2ky-29; Mon, 09 Feb 2026 16:48:31 +0100
Date: Mon, 9 Feb 2026 08:48:25 -0700
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Hung <alex.hung@amd.com>, 
 "ChiaHsuan Chung (Tom)" <ChiaHsuan.Chung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Mario Limonciello <mario.limonciello@amda.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com, 
 Leo Li <sunpeng.li@amd.com>,
 Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: Re: [PATCH 0/5] drm/amd/display: Clean up some DCE 6 code
Message-ID: <aYoA2Z4svnQ-Md_x@atmagalia>
References: <20260118173150.19790-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260118173150.19790-1-timur.kristof@gmail.com>
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
> Reduce code duplication and ease maintenance burden for old
> DCE versions. Clean up some code that was duplicated between
> DCE 6 and the rest of DCE.
> 
> Timur Kristóf (5):
>   drm/amd/display: Use dce_audio_create for DCE 6
>   drm/amd/display: Delete unused dce_clk_mgr.c
>   drm/amd/display: Remove unused dce60_clk_mgr register definitions
>   drm/amd/display: Handle DCE 6 in dce_clk_mgr.c
>   drm/amd/display: Handle DCE 6 in dce110_register_irq_handlers
> 
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 165 +--
>  .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  12 +-
>  .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  64 +-
>  .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 166 ---
>  .../display/dc/clk_mgr/dce60/dce60_clk_mgr.h  |  36 -
>  .../gpu/drm/amd/display/dc/dce/dce_audio.c    | 131 ---
>  .../gpu/drm/amd/display/dc/dce/dce_audio.h    |   9 -
>  .../gpu/drm/amd/display/dc/dce/dce_clk_mgr.c  | 967 ------------------
>  .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  11 -
>  .../dc/resource/dce60/dce60_resource.c        |   2 +-
>  10 files changed, 88 insertions(+), 1475 deletions(-)
>  delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
>  delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h
>  delete mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
> 
> -- 
> 2.52.0
> 

I Alex, Dan, Tom,

Could you also include this series in this weekly promotion? Overall, it
looks good, but I believe the last patch needs thorough testing via
promotion since it can affect multiple GPUs.

Thanks

-- 
Rodrigo Siqueira
