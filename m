Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08179CF2561
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 00:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F6B210E212;
	Wed, 19 Nov 2025 00:48:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rtUezePA";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3B0110E212
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 00:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NtwBpFWpzew0kkL/tWCVCEvEgL31VyJr5uNdmveabus=; b=rtUezePAJ6te4li9eozDBtryec
 t5eJ/86c7ZGBgZACB0ys79GHT+qzEdXXfqUyWggb7D10uRMqOOlVH1TOYo7ue5OYj2KsyZIxxb40D
 YfJeybNXKRPcipuXIYLfWjG8xPN+ii6uN4ZhGfnX3l/9Sa+ikOvwME5IHg67U+ELm4V0hD5UC8vcd
 Nzu4TGL/Y7JntU7Ip2qSzIma2XV9HjxbGGEYxjgRLOmPMK1wkPNvnYyPuQhGaNbdTrEiCgeGLkUjQ
 A5szL7mssGXoPR9/jaHqnw1XG/ckxcLRbrsB4iZ2Ppks8NXkODupJF0uRFZJhsNftkGo8DVTNSgpw
 oKk88IYQ==;
Received: from [104.193.135.201] (helo=debian.home.app)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vLWNG-002Mxr-Oy; Wed, 19 Nov 2025 01:48:42 +0100
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v5 0/5] Expand kernel-doc with more generic details and info
 about ring buffers
Date: Tue, 18 Nov 2025 17:45:49 -0700
Message-ID: <20251119004818.4126460-1-siqueira@igalia.com>
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

Changes since V4:
- Simplify amdgpu_ring_alloc() doc.
- Add IV to the glossary.
- Rebase

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>

Thanks
Siqueira

Rodrigo Siqueira (5):
  drm/amdgpu: Expand kernel-doc in amdgpu_ring
  Documentation/gpu: Add new glossary entries from UMR
  Documentation/gpu: Expand generic block information
  Documentation/gpu: Add more information about GC
  Documentation/gpu: Add documentation about ring buffer

 .../gpu/amdgpu/amd_overview_block.svg         |  687 +++++++
 Documentation/gpu/amdgpu/amdgpu-glossary.rst  |   39 +
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |   11 +-
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

