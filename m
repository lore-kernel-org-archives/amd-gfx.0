Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B116C369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Apr 2025 22:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8E4E10E059;
	Mon, 21 Apr 2025 22:18:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="F+7PXI2u";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 415F210E059
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 22:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=f7kQpe9CbShWYa1jOuVn6Z3gjTBbmW95iHPAcQLRS0Q=; b=F+7PXI2uarmH1YVBaCfAnktaxo
 +HwObFsZXvfBS9ug83ad0FNLPxayM6bAC6vBCpcpdHScdvrhaNz3cgcD7IA9HNfJz3AIM9Zs4ItPA
 QZZquABN0N3gl8w7JodkJkicKZnQ1h5yTaXJIMPNLWVR/3xkpN3niJPx18t4aib9P8z+OXxvGA1WQ
 CoNyl6p/I+fLYbS0RUIsJ3rw5WVsZkIu7dNe2rCDD3b/AyD+3HFOhstKuNMiiTFQj/RQA/i2OrKpc
 7HWfwDE/jVbckiLu9stOayf1DgAbiMk3vPNb+93tC0mGaNdbHHIw+FR5DlFhjm/LfB9yTG+enITvW
 TnzxZFwA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u6zTD-006CMY-Tp; Tue, 22 Apr 2025 00:18:32 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v3 0/9] Introduce a helper functions to get the CSB buffer
Date: Mon, 21 Apr 2025 16:12:17 -0600
Message-ID: <20250421221616.387927-1-siqueira@igalia.com>
X-Mailer: git-send-email 2.49.0
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

This patchset was inspired from the below series:

  https://lore.kernel.org/amd-gfx/20250319162225.3775315-1-alexander.deucher@amd.com/

In the above series, there is a bug fix in many functions named
gfx_vX_0_get_csb_buffer (where X ranges from 6 to 11). After closely
looking at those functions, it became clear that most of the code could
be shared from gfx6 to gfx11. Aside from the code duplication removal,
this also improves maintainability since a bug fix in a shared function
can be propagated to all ASICs.

Alex provided some feedback, and from that, I modified this new version
to:

1. Create a dedicated function for the preamble start.
2. Create a function to parse the cs data.
3. Create a helper for finishing the preamble.
4. Replace the duplicated part from gfx6 to 11.

For the GFX update, I created one commit for each to ensure this series
is bisectable.

Changes since v2:
- Alex:
 - Update GFX7 CSB to use rb_config struct.
- Expand documentation based on Alex's explanations in the previous
  series.

Thanks

Rodrigo Siqueira (9):
  drm/amdgpu/gfx: Introduce helpers handling CSB manipulation
  drm/amdgpu/gfx: Use CSB helpers in gfx_v11_0_get_csb_buffer
  drm/amdgpu/gfx: Use CSB helpers in gfx_v10_0_get_csb_buffer
  drm/amdgpu/gfx: Use CSB helpers in gfx_v9_0_get_csb_buffer
  drm/amdgpu/gfx: Use CSB helpers in gfx_v8_0_get_csb_buffer
  drm/amdgpu/gfx: Use CSB helpers in gfx_v7_0_get_csb_buffer
  drm/amdgpu/gfx: Fix gfx_v7_0_get_csb_buffer to use rb_config
  drm/amdgpu/gfx: Use CSB helpers in gfx_v6_0_get_csb_buffer
  drm/amdgpu: Add documentation associated with CSB

 Documentation/gpu/amdgpu/amdgpu-glossary.rst |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c      | 69 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      | 46 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h      | 14 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c       | 34 ++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c       | 34 ++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c        | 29 ++------
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c        | 55 ++--------------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c        | 34 ++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        | 32 ++-------
 10 files changed, 164 insertions(+), 189 deletions(-)

-- 
2.49.0

