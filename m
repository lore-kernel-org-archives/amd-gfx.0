Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5DDC5DF81
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 16:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31D6810EE43;
	Wed, 19 Aug 2026 16:11:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="E/oPUnrM";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 711DE10EE5D
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 16:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=nLf2opOruQrz6ybY7HgQk+Kqdz2MzUNxmQUCbFkJP9g=; b=
 E/oPUnrMuO4rpRFjqmWfUDSZjkEIj0keEbQIXWhx4xtVQuRj/cXLWx0ny/R7ze/YDSxM1fCKQK6ov
 JVNv2Xp+sQHk12Cni8WrS/sqzCKdeLi5wy1i9rH5DsCus72jsOfkV0Y45Fo73bW1pI62/9G6HBoMc
 eyEWD75keD0f9FwIP0i5NYg35yU2kcjgF6mUNGk10FIsOToiPel4fskgabb/M9pUR2tDa4XTuW++i
 4hdrBZKgz85LmIrs5zk4aP2Muh5rDZ4EMSJTtgLFv15hXNT8TiqaRHqV97xlaMf9NfU6DJofyhKSM
 AOxJsirB8GcBAj4ZR7VqLQhqvb7JFapzqg==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154]
 helo=killbill.home) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wwisl-006BRc-HO; Wed, 19 Aug 2026 18:11:15 +0200
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
Subject: [PATCH 0/2] drm/amd/display: follow-up fixes for LUT segmentation
Date: Wed, 19 Aug 2026 18:00:15 +0200
Message-ID: <20260819161106.27702-1-mwen@igalia.com>
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

Extend halving distribution for all curves/custom-LUT in a
encode-to-linear operation, not only PQ/SRGB. This fixes failures in IGT
kms_colorop test after [1]. Also use the CM3 degamma helper that
translates curves to hw points for DCN30-based family, not only DCN32,
since the banding issue is present on both.

[1] https://lore.kernel.org/amd-gfx/20260623160112.1636801-1-mwen@igalia.com/

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

