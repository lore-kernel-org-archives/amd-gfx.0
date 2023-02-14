Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE9FC05027
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 12:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 308AF10E89C;
	Tue, 14 Feb 2023 12:14:13 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F4F910E1E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/8WpW9qqUNe5Bx9eTqe2HtzMtFblgZfFKhTN4vhbqAA=; b=We5uX76S3cb0KlaQfkmTmB+KB5
 tAFVM1D8YfJqvQDFszRIFzX0HV4/EzRuLAk27YXhm2IxAUo/e75Eiwox7CHKCs3QQjoa6XtGV4Xpu
 3MItvEOfGpF/vAHtB08FYcAV+YMMb8/bb9Juh99O+ztHRRHUUC3XC1FQt31+uBNdhii681s/sNEUy
 vzbrvGXQGNQddWNdcLSKC+hAaMmyUar2grzWPsVzL6IKDzI2h++PdN3lwSm3el3O6bBr1R6UbnbNu
 qre63vijEiB5iyxqAor6wC9QhZkujuWkURQfo2z4UAmv9XgWFsT6q1BYMl6KtgRQzq8POuxClhFA8
 DBZPAiTw==;
Received: from [38.44.66.31] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1pRuCG-0022pF-5N; Tue, 14 Feb 2023 13:14:08 +0100
From: Melissa Wen <mwen@igalia.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/6] Trivial code cleanup around color resources
Date: Tue, 14 Feb 2023 11:14:00 -0100
Message-Id: <20230214121406.97750-1-mwen@igalia.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
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
Cc: sunpeng.li@amd.com, Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com,
 kernel-dev@igalia.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

Sorry for the noise, but while I've been working on wiring 3D LUT
support to AMD display driver [1] I found some annoying code style
issues in the shared-code part. So I'm just sending what I've been
cleaning to better examine the code.

Most seem trivial, except the last one "remove unused
_calculate_degamma_curve" since this could just be a matter of missing
parts. If so, happy to remove the patch and include a comment describing
the situation (or the potential usage of it).

Thanks,

Melissa

[1] https://lore.kernel.org/dri-devel/20230109143846.1966301-1-mwen@igalia.com/

Melissa Wen (6):
  drm/amd/display: ident braces in dcn30_acquire_post_bldn_3dlut
    correctly
  drm/amd/display: clean code-style issues in dcn30_set_mpc_shaper_3dlut
  drm/amd/display: camel case cleanup in color_gamma file
  drm/amd/display: unset initial value for tf since it's never used
  drm/amd/display: remove unused func declaration from resource headers
  drm/amd/display: remove unused _calculate_degamma_curve function

 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  37 ++---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   4 -
 .../amd/display/modules/color/color_gamma.c   | 140 ++++--------------
 .../amd/display/modules/color/color_gamma.h   |   3 -
 5 files changed, 48 insertions(+), 138 deletions(-)

-- 
2.39.0

