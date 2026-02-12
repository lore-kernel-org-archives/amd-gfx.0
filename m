Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFE4EEA868
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 22:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2E6510E299;
	Thu, 12 Feb 2026 22:21:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ubuntu.com header.i=@ubuntu.com header.b="bTAA0rxt";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 595EB10E2B2
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 22:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-953a8a3ca9; t=1770934861;
 bh=8LtyKwPG/bc6wio3zDAJHqbTFoe1AI885LVCRiG/Biw=;
 b=bTAA0rxt6IXhSM0dCrLYtisuZcVih2WNZPCkdRccxDq3KeiyLyFQ2k3h++RkyhrrgEZ+uuv1g
 3Hc995nwoTQ4/hiBG14ofHugr+wA0x+LdpPhjNbX1H1wy6hupro4b4iHtmhsLU9ka/Ee5Wti7Zr
 SXh2/DQ69PhQUw8+w+WCuLeafxknJzQ6zkeo4K/6sjJo2ojsShJq+1J5b1BNXagHiLa9R5O/zZC
 sRuRj55di6cbS5H7egGQU4a1X6+3diqSQJKYI0osplQFnf1rU3tyrRRCbsrCW83FEb7Z1amKRtH
 0REOc7kfiA0ztySW663JEpTJKPEdRL4dFtXUB6eT5Tlw==
X-Forward-Email-ID: 698e524a1cff1f790f796ad8
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.6.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Joshua Peisach <jpeisach@ubuntu.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Joshua Peisach <jpeisach@ubuntu.com>
Subject: [PATCH 0/2] drm/amdgpu/amdgpu_connectors: Use struct drm_edid
Date: Thu, 12 Feb 2026 17:20:27 -0500
Message-ID: <20260212222029.15777-1-jpeisach@ubuntu.com>
X-Mailer: git-send-email 2.51.0
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

These patches replace uses of struct edid with struct drm_edid, and
updates function calls appropriately.

Additionally, amdgpu_connector_free_edid is no longer needed, and can be
removed.

Joshua Peisach (2):
  drm/amdgpu/amdgpu_connectors: use struct drm_edid instead of struct
    edid
  drm/amdgpu/amdgpu_connectors: remove amdgpu_connector_free_edid

 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 54 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  4 +-
 5 files changed, 30 insertions(+), 38 deletions(-)

-- 
2.51.0

