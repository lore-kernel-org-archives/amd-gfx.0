Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6195AC3ABB6
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 23:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0265010E5D1;
	Mon,  5 May 2025 23:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DAyRMsj8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ECAE10E5D3;
 Mon,  5 May 2025 23:04:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A67C1629C3;
 Mon,  5 May 2025 23:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C25DC4CEE4;
 Mon,  5 May 2025 23:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746486267;
 bh=CeU6s5BbPhsa/BxUt2Sys/rxJHd55eFqxtKzORCPOkc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DAyRMsj8Fpg62uTdcG1B2Oiy8WEhxgTQfFQu+vZJWxVUIoTckiM2kVDBbHNu7kIve
 wIWH4jCyC8NE6Cir4FUphC77+up15yIUjeSca7PYrZd9wSRUEiffHTtbqUk9/Nc0qE
 9AfqAolcPmMlAQtdQSVLudQMUDzzn89a6ySGtaymmH3IOopQrDUAx1KpTZd1BHi4Pa
 jcgjSUYBO0DT4QF9Ggw3ddkHzV4GMY6LdHaEQtuQuoHZErfPulTu4aoG0ZdcuVFTzR
 iacTk7nMb4snLkkDNhgW6pAdeZfveCwRjrgX862GgU7YzMMcXnq8MmzXqhaI64Z1qU
 E3sqxlx8MaYlw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Sasha Levin <sashal@kernel.org>,
 sunpeng.li@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, mario.limonciello@amd.com, alex.hung@amd.com,
 chiahsuan.chung@amd.com, sunil.khatri@amd.com, aurabindo.pillai@amd.com,
 Yilin.Chen@amd.com, mwen@igalia.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 230/294] drm/amd/display/dm: drop hw_support check
 in amdgpu_dm_i2c_xfer()
Date: Mon,  5 May 2025 18:55:30 -0400
Message-Id: <20250505225634.2688578-230-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 33da70bd1e115d7d73f45fb1c09f5ecc448f3f13 ]

DC supports SW i2c as well.  Drop the check.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e6bc590533194..877cc70ae1e79 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7468,7 +7468,7 @@ static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int i;
 	int result = -EIO;
 
-	if (!ddc_service->ddc_pin || !ddc_service->ddc_pin->hw_info.hw_supported)
+	if (!ddc_service->ddc_pin)
 		return result;
 
 	cmd.payloads = kcalloc(num, sizeof(struct i2c_payload), GFP_KERNEL);
-- 
2.39.5

