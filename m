Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8375CF2564
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 00:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BD2210E208;
	Wed, 19 Nov 2025 00:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="PsogDZZg";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BC6010E208
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 00:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LJIn7lqLz38pPgDMaLGwIH/yT2NeR0IuRbCItyuQKWg=; b=PsogDZZgTse/QSYQEbx2T7Au2i
 W0QG12YAUikv3yte3sQDY3PGCyRBze4BtJ8hKqDN8eHYimPeES1hInliK7BMVn+rlDA8GvHt0qbCT
 rF/THhLQbdC8pSEU7lsC5ynLx47racOrRcdCQld4KdXk9IsGPNuQ69FtcOF0iYBM65XdV2riPoGHy
 tvDm+XM1EWyzi8O4CsjfvgT/8vDH+4glkcvh15UInd3xBDer3tw4xng6iK9pBa8Ftib239G5QeEyO
 pAeEECS7PlGp7+tKejuTwqGy1+m2y77HoTG0Pzzo5EwGVZ26OkX6LUsepRxVIydot6rGvUsauRdPT
 kRFcnULw==;
Received: from [104.193.135.201] (helo=debian.home.app)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vLVzV-002MdZ-Hi; Wed, 19 Nov 2025 01:24:09 +0100
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: Robert Beckett <bob.beckett@collabora.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v4 0/2] Address amdgpu reload issues in APUs
Date: Tue, 18 Nov 2025 17:22:36 -0700
Message-ID: <20251119002348.4118647-1-siqueira@igalia.com>
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

Thanks
Siqueira

Rodrigo Siqueira (2):
  drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu is reloaded
  Revert "drm/amd: fix gfx hang on renoir in IGT reload test"

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/soc15.c         | 4 ----
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.51.0

