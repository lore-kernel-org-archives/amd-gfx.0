Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83615CA0FE1
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Aug 2025 23:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8024610E21F;
	Sun, 24 Aug 2025 23:32:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="iFcpxM3R";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B210F10E21F
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Aug 2025 23:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qrQQ2KaPXlkvS+uT4xNs+vYFDcEyg5m2+aFoiTxN77g=; b=iFcpxM3Rg1kXLcAcxPTWHfpA9y
 1tbwYE9Np4/IIOG3cHtBLj6/sW1dOW6tBZE7Ro6B0vJ2Gh21ECROSztOddrEPvDyWCeD3JmI68bru
 M3c4399SGBiu3wcvfos6n3CV81q1Cj56dtUHxgm1a2eiU1r5mm9kFiI1hJRfflZnBkIgFe78Bm/PY
 7x4eCbm+OGGWAyipdkI7SdgYAH+jqVf60Tijj17I+MG6RYfkVRLdKWn76vgLF7f6VXidmHs8wHWaN
 gVQoGboVni8CnmQsNREMX2fmlhWBNJXg2/T73uR9CyRMRvWRltK2wG0HjgayzdFja+D1vbYCM5OF1
 LCrQkt0A==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uqKCa-00198j-M8; Mon, 25 Aug 2025 01:32:45 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v2 0/5] Expand kernel-doc with more generic details and info
 about ring buffers
Date: Sun, 24 Aug 2025 17:29:40 -0600
Message-ID: <20250824233149.3780127-1-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Lately, I have been part of multiple discussions around GPU recovery and
other concepts associated with GFX/Compute. Most of the debate is spread
around GitLab issues, emails, and some meeting conversations. This
patchset aims to consolidate all that information into a single
kernel-doc, which can be collaboratively improved and shared with other
people. 

In this series, you will find new amdgpu glossary entries, more details
about the IPs' interconnections, and a description of the ring buffer.
This series includes multiple SVG diagrams; for this reason, it might be
good to apply this series locally.

Finally, keep in mind that I tried to fill in some gaps between
information, and hopefully, my description matches the reality.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>

Changes since V1:
 - Patch 1: Shorten the function description.
 - Patch 4: Add more details about CPF, CPC, CPG, MEC, PFP, and ME.

Thanks

Rodrigo Siqueira (5):
  drm/amdgpu: Expand kernel-doc in amdgpu_ring
  Documentation/gpu: Add new glossary entries from UMR
  Documentation/gpu: Expand generic block information
  Documentation/gpu: Add more information about GC
  Documentation/gpu: Add documentation about ring buffer

 .../gpu/amdgpu/amd_overview_block.svg         |  674 +++++++
 Documentation/gpu/amdgpu/amdgpu-glossary.rst  |   24 +
 Documentation/gpu/amdgpu/driver-core.rst      |   25 +
 .../gpu/amdgpu/enforce_isolation.svg          |  707 +++++++
 Documentation/gpu/amdgpu/gc/cu.svg            |  437 +++++
 Documentation/gpu/amdgpu/gc/index.rst         |   32 +-
 Documentation/gpu/amdgpu/gfx_pipeline_seq.svg |  413 +++++
 Documentation/gpu/amdgpu/index.rst            |    1 +
 .../gpu/amdgpu/no_enforce_isolation.svg       |  673 +++++++
 Documentation/gpu/amdgpu/ring-buffer.rst      |   94 +
 Documentation/gpu/amdgpu/ring_buffers.svg     | 1633 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |   14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |    2 +
 13 files changed, 4720 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/gpu/amdgpu/amd_overview_block.svg
 create mode 100644 Documentation/gpu/amdgpu/enforce_isolation.svg
 create mode 100644 Documentation/gpu/amdgpu/gc/cu.svg
 create mode 100644 Documentation/gpu/amdgpu/gfx_pipeline_seq.svg
 create mode 100644 Documentation/gpu/amdgpu/no_enforce_isolation.svg
 create mode 100644 Documentation/gpu/amdgpu/ring-buffer.rst
 create mode 100644 Documentation/gpu/amdgpu/ring_buffers.svg

-- 
2.47.2

