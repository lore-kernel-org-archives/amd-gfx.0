Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D39C5DF82
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 09:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B58710EF89;
	Thu, 20 Aug 2026 09:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FUt91UTN";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF3B10EF8E
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 09:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=IfITr1cv/Wn05CCKMGP8wH+G0eWm/2PWJ1sVhPZF5E0=; b=
 FUt91UTNjSf6R8tnJWCIgh2y+DGYfwF8PAGEed5xP2ROY7+QtyGwuJ4hV5z/OcjLPUnlf/bZ77JNR
 RqjIJP/7HycIr714J/hi0V/vEbad9ebvBGxPgGFiOrM/+6iKCzZWie2iVbAN0SVqMSY+Fds0IFfMh
 4TEKqDQyLsw00wcOMvlxjDm0HCTj8nW8UF32vP44YR0Xbc/9vglJMWR1Nprv1UwdrzHuXFndO/j1/
 dWTHc0Me4Dh1Iz51xqsckXZ4jSOpDkKNJFIZ7QcfgXf9x/7woqYDhWoiUNtFkWbO2LhUOXixWuz61
 JrQnCEvQRDZ+g/98HYXtG9DKQN/Ei7ntQg==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wwz9J-006WKe-Oi; Thu, 20 Aug 2026 11:33:25 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, mwen@igalia.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "'Dr . David Alan Gilbert'" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 pekka.paalanen@collabora.com, robert.mader@posteo.de,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] drm/amd/display: follow-up bug fixes for LUT
 segmentation
Date: Thu, 20 Aug 2026 11:26:36 +0200
Message-ID: <20260820093324.10201-1-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Extend halving distribution to all curves/custom-LUT in a
encode-to-linear operation, not just PQ/SRGB. This fixes IGT kms_colorop
test failures after [1]. Also use the CM3 degamma helper which
translates curves into hw points for DCN30, DCN301, DCN31, and DCN314
not just DCN32+, as the banding issue is present all of them.

[1] https://lore.kernel.org/amd-gfx/20260623160112.1636801-1-mwen@igalia.com/

v1: https://lore.kernel.org/amd-gfx/20260819161106.27702-1-mwen@igalia.com/
Changes:
- Clearly state which DCN versions are affected and the reference commit
  (Alex H.)

Melissa


Melissa Wen (2):
  drm/amd/display: use halving distribution for all encode-to-linear
    curves
  drm/amd/display: use translate_curve_to_degamma_hw_format on DCN30

 .../amd/display/dc/dcn30/dcn30_cm_common.c    | 34 ++++++-------------
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 10 +++---
 2 files changed, 14 insertions(+), 30 deletions(-)

-- 
2.53.0

