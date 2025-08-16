Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B7ACA0EE9
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Aug 2025 16:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10DCE10E1DB;
	Sat, 16 Aug 2025 16:28:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="oLwfjB/7";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9686B10E3A5
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 16:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KDC6qnc1I3t014fdrUlpL6I4hevQOJ22YZnyNsOZydo=; b=oLwfjB/71GEnbs/ql/lpwslFZ3
 fEDFKne+oTMcmcxibhG2vAgX52NkdFZYVdx9Mio1E9DE7hLSwY9ERavXhxadFrLHjE24mdM2sFF8p
 /Ym4joFYAV5uYDo2q2Z5PUjI6v+OM1PSGomVT+EeFEla937qgGcTa/4DTAEUDpSjtaMYyEgNX/LQd
 /co2g0AHGwNFJzMZd3HMVtMOUVz+NP1nf7ddwn2Q4YIDg4YvTu6GdIjMJMbIit1qz7dpY2B9p3oQt
 BXZMpcYtDnSz3SszVnz0b8PzJYm664sDeA3KxbMbV1pne05uF4vB+RSuakJerJpoKwqCIctSIPnK5
 9J60SMpQ==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1unJlV-00FASr-Cr; Sat, 16 Aug 2025 18:28:21 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 0/3] Add some adjustment for VCN 4.0.3 and 5.0.1
Date: Sat, 16 Aug 2025 10:27:25 -0600
Message-ID: <20250816162806.1301791-1-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
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

While I was looking into the ring buffer interface, I noticed some minor
issues in the VCN 4.0.3 and 5.0.1. This series has some code
improvements in those two components.

Thanks

Rodrigo Siqueira (3):
  drm/amdgpu/vcn: Use the correct irq for the ring initialization
  drm/amdgpu/vcn: Remove unnecessary check
  drm/amdgpu/vcn: Ensure that sysfs reset run in the fini

 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 8 ++------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 4 ++--
 2 files changed, 4 insertions(+), 8 deletions(-)

-- 
2.47.2

