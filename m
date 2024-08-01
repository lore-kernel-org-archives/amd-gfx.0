Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981CEC52D6F
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 00:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D16C10E746;
	Thu,  1 Aug 2024 00:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QHf3qrqS";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9F1310E744;
 Thu,  1 Aug 2024 00:15:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E57BCCE1870;
 Thu,  1 Aug 2024 00:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8160C32786;
 Thu,  1 Aug 2024 00:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722471333;
 bh=0TpNNrACWqa3bM5QaUsBF25tZ8stxMvvMpx22jGLU38=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QHf3qrqSn7hz+UxO/Isqw8Fb5hKhyXCHQ3TFlR917bk6qdTtOQJECBggWq4T+/Xvl
 3XWauJS1Mx3Ff23lfT5H8o+hpyhFAhTvaWt+/1rr4PXvigurMxQOza+FpU4/OAVDgT
 pmQdr9ofwr8OA9Nc2/cTIP520NkwDlRMf+4Xlwhg5XU/W5f0ZZw1BSWS1OqMLdZIQf
 ePWFyVIfTXqP/YaNclW9bGiBYIhhOHfjomzf01z4ZfD/2b5L+dpEuYU2gBkSvfJW3k
 4xP5gViySxh5UXVN9H+uS6ijgf8bI/Qr9NRi0catKPquaY+2SBRXGb2l78fzyzNvdi
 ontIc1HKp9Fuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wayne Lin <wayne.lin@amd.com>, Jerry Zuo <jerry.zuo@amd.com>,
 Zaeem Mohamed <zaeem.mohamed@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, alex.hung@amd.com, mwen@igalia.com, joshua@froggi.es,
 Roman.Li@amd.com, mario.limonciello@amd.com, Bhawanpreet.Lakha@amd.com,
 rdunlap@infradead.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 075/121] drm/amd/display: Correct the defined
 value for AMDGPU_DMUB_NOTIFICATION_MAX
Date: Wed, 31 Jul 2024 20:00:13 -0400
Message-ID: <20240801000834.3930818-75-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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

From: Wayne Lin <wayne.lin@amd.com>

[ Upstream commit ad28d7c3d989fc5689581664653879d664da76f0 ]

[Why & How]
It actually exposes '6' types in enum dmub_notification_type. Not 5. Using smaller
number to create array dmub_callback & dmub_thread_offload has potential to access
item out of array bound. Fix it.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 09519b7abf67b..5c9d32dff8538 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -50,7 +50,7 @@
 
 #define AMDGPU_DM_MAX_NUM_EDP 2
 
-#define AMDGPU_DMUB_NOTIFICATION_MAX 5
+#define AMDGPU_DMUB_NOTIFICATION_MAX 6
 
 #define HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_IEEE_REGISTRATION_ID 0x00001A
 #define AMD_VSDB_VERSION_3_FEATURECAP_REPLAYMODE 0x40
-- 
2.43.0

