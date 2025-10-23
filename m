Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59487CCF9E0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 22:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C90F510E973;
	Thu, 23 Oct 2025 22:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="huN8hKsy";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A7310E96B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 22:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=t+IeegxqwkxcCj+lDMYbDXquUV5HwvmLA7fSVJDvO6c=; b=huN8hKsydg+Fy69lCoFGhNV1Nx
 p2w0nBzDDykD9iNAR/Ee990TXNuc2w//a0V3fPLmS4iQxSybm+44PQDHpkjRTl8t5rQLbKYHOINuY
 pSegORSx4yUqqS7EbUa0/z4Lghq2Ii3R3AlLuCcHRx5oSZU+hh7JJcYFPWVXlw5glLc1xrkx/4usm
 PA3Yf8AoxyXkkAKLQ/rF/ElWao6H/ZTpMsabxamcKEn27B0jfkqbeiu/I3Yw6eiUEPRLs0+sLytoS
 c80RtM0RQrRT+64ZqQAqxwKZ/nCkDuFvVyCc2zMq7G7oioH7kUk3sQoxQYsgFj+Yv/IBSbMd+jMhG
 0BDktuQA==;
Received: from [104.193.135.201] (helo=debian.home.app)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vC3y0-00DpJV-JJ; Fri, 24 Oct 2025 00:39:32 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v4 0/5] Expand kernel-doc with more generic details and info
 about ring buffers
Date: Thu, 23 Oct 2025 16:38:43 -0600
Message-ID: <20251023223918.601594-1-siqueira@igalia.com>
X-Mailer: git-send-email 2.51.0
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
good to apply this series locally. However, if you want to check all the
images quickly, check the links below:

- https://people.igalia.com/siqueira/kernel-doc-imgs/v4/amd_overview_block.svg
- https://people.igalia.com/siqueira/kernel-doc-imgs/v4/gfx_pipeline_seq.svg
- https://people.igalia.com/siqueira/kernel-doc-imgs/v4/no_enforce_isolation.svg
- https://people.igalia.com/siqueira/kernel-doc-imgs/v4/enforce_isolation.svg
- https://people.igalia.com/siqueira/kernel-doc-imgs/v4/ring_buffers.svg

Finally, keep in mind that I tried to fill in some gaps between
information, and hopefully, my description matches the reality.

Changes since V3:
- Add more details in the glossary.
- Move TMZ from the display glossary to the AMDGPU glossary.
- Update the amd_overview_block.svg to describe PSP and hub connection with blocks better.
- Improve amdgpu_ring documentation.
- Improve block description overview.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>

Thanks

Rodrigo Siqueira (5):
  drm/amdgpu: Expand kernel-doc in amdgpu_ring
  Documentation/gpu: Add new glossary entries from UMR
  Documentation/gpu: Expand generic block information
  Documentation/gpu: Add more information about GC
  Documentation/gpu: Add documentation about ring buffer

 .../gpu/amdgpu/amd_overview_block.svg         |  687 +++++++
 Documentation/gpu/amdgpu/amdgpu-glossary.rst  |   36 +
 .../gpu/amdgpu/display/dc-glossary.rst        |    3 -
 Documentation/gpu/amdgpu/driver-core.rst      |   31 +
 .../gpu/amdgpu/enforce_isolation.svg          |  654 +++++++
 Documentation/gpu/amdgpu/gc/index.rst         |   24 +-
 Documentation/gpu/amdgpu/gfx_pipeline_seq.svg |  413 +++++
 Documentation/gpu/amdgpu/index.rst            |    1 +
 .../gpu/amdgpu/no_enforce_isolation.svg       |  707 +++++++
 .../gpu/amdgpu/process-isolation.rst          |    1 +
 Documentation/gpu/amdgpu/ring-buffer.rst      |   95 +
 Documentation/gpu/amdgpu/ring_buffers.svg     | 1633 +++++++++++++++++
 Documentation/gpu/amdgpu/userq.rst            |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |   14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |    2 +
 15 files changed, 4286 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/gpu/amdgpu/amd_overview_block.svg
 create mode 100644 Documentation/gpu/amdgpu/enforce_isolation.svg
 create mode 100644 Documentation/gpu/amdgpu/gfx_pipeline_seq.svg
 create mode 100644 Documentation/gpu/amdgpu/no_enforce_isolation.svg
 create mode 100644 Documentation/gpu/amdgpu/ring-buffer.rst
 create mode 100644 Documentation/gpu/amdgpu/ring_buffers.svg

-- 
2.51.0

