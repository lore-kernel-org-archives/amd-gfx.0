Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE6ACFC27F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Nov 2025 13:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3CAC10E8D8;
	Fri, 21 Nov 2025 13:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="DlPPDMRB";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BEFB10E8D7
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 13:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TY1PR2PlD2wG4smhe1zQMFR68n6KnIzrmLtC03bJP0o=; b=DlPPDMRBD91Uc0QQghmBuxgGRd
 qa1aNYhB3AIJh5hxrGrKcbSS4s+aY2hE2PhAuFk+LzWELaQysJDnKrwaKB9gzY8rno9Kk08uR/VMS
 WNP3djNeXAmJUWgqAiqqCM5ucVBgunSx2Cky73NCtL91xXkqzI0WEQNwvdRN9i5Z8tWmAOLbmmQnY
 vG5hZMv3qBiCiBmNxJiMCJ6L2X4UBHDCm7n+8qe9gJu+LHgXGcZwdO87/fRjjYG9/oZc+T5kSvaac
 wdCflg2rUt00fdJLYG+zLR2bi20TAHwPdOKb0YwHEynX99w3a2xhO2A9jLwf7JgxHb9MMcDdXEXM0
 Y7Rsj0zw==;
Received: from [104.193.135.201] (helo=debian.home.app)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vMRdP-003gP2-Fa; Fri, 21 Nov 2025 14:57:11 +0100
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: Robert Beckett <bob.beckett@collabora.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v5 0/2] Address amdgpu reload issues in APUs
Date: Fri, 21 Nov 2025 06:55:27 -0700
Message-ID: <20251121135658.459620-1-siqueira@igalia.com>
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

This series addresses the issue of amdgpu reload failures in APUs. The
first commit adds a GPU reset during unload time, and the second commit
removes a specific fix for the Renoir device that becomes outdated with
the first patch.

Changes since V4:
- Add a code comment about PSP behavior.

Thanks
Siqueira

Rodrigo Siqueira (2):
  drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu is reloaded
  Revert "drm/amd: fix gfx hang on renoir in IGT reload test"

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 ----
 2 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.51.0

