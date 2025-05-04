Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BBFC3ABB0
	for <amd-gfx@archiver.kernel.org>; Sun,  4 May 2025 21:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B8310E040;
	Sun,  4 May 2025 21:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Otc/p1OF";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C709710E034
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 May 2025 21:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H7po4hHgH/acBcIPv+khc6tyBNRHNhYIBEG2veFiZ84=; b=Otc/p1OF7B/mqIzmwbyYRj8wDj
 DwZ3Mc0Nw450Tsi7OjMnhs/OUY0/aMS2rxZW2wYt0Kv/EtzZW0eos/9D4L1HxvRHVceW89XsMfHCD
 6+61975j6PlIgvkB0H9MnRYP5cPltQyIs1bTytc5jacOHoevg4zcA0DzCxkN+61Ih1tQVpn23G6po
 IhXDLyw2s8sn+dq3RevJDhR0OJkXimPsIOAuNOA4ccrgZkX98VeUwcWjZhNbbUfAA2kVB6nw2P+45
 rai8KVs3q1l4ZggKRz+/psu24aMlc6ucHVQQ/jCChQJzz3HwjW0SEA/fArBIRzLCtWjepKhpqyP6/
 lHA6bBnQ==;
Received: from [193.32.248.132] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uBh9B-003PPH-RK; Sun, 04 May 2025 23:48:13 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 0/6] Avoid re-parser CSB in gfx_vX_0_cp_gfx_start()
Date: Sun,  4 May 2025 15:47:33 -0600
Message-ID: <20250504214801.406245-1-siqueira@igalia.com>
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

In the functions gfx_vX_0_cp_gfx_start(), where X ranges from 7 to 11,
parts of the code parser CSB. However, CSB was already parsed in the
get_csb_buffer() called before gfx_vX_0_cp_gfx_start(). This commit
introduces a helper to read directly from the CSB buffer available in
adev->gfx.rlc.cs_ptr, and avoid re-parse CSB.

Note: This series idea came from a discussion available in the below
link:

https://lore.kernel.org/amd-gfx/CADnq5_NAGvaJ1-7+_NZQszLspHcCudRSKKHkezJBEQg0GmEq9Q@mail.gmail.com/T/#m8fd6d9ce10b9644299f2f306f2a7d00a9aa1e5ee

Thanks

Rodrigo Siqueira (6):
  drm/amd/amdgpu: Add a helper to copy the CSB buffer into the ring
    buffer
  drm/amd/amdgpu: Avoid re-parser CSB in gfx_v7_0_cp_gfx_start
  drm/amd/amdgpu: Avoid re-parser CSB in gfx_v8_0_cp_gfx_start
  drm/amd/amdgpu: Avoid re-parser CSB in gfx_v9_0_cp_gfx_start
  drm/amd/amdgpu: Avoid re-parser CSB in gfx_v10_0_cp_gfx_start
  drm/amd/amdgpu: Avoid re-parser CSB in gfx_v11_0_cp_gfx_start

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 23 +++++------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 23 +++++------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 20 +++++---------------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 22 +++++-----------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 23 ++++++-----------------
 7 files changed, 51 insertions(+), 85 deletions(-)

-- 
2.47.2

