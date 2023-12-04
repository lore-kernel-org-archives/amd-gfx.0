Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81D0C4167B
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Dec 2023 20:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEBBF10E3DF;
	Mon,  4 Dec 2023 20:34:31 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C3210E3D6;
 Mon,  4 Dec 2023 20:34:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 57C3DB81211;
 Mon,  4 Dec 2023 20:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175EEC433CA;
 Mon,  4 Dec 2023 20:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1701722066;
 bh=cq6q6SprEF7TJmOidVjn7rV5ZJdddDKd2dLoRMiSmoA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uDlYXIPH9DbNeq9VNJJD0VyE1rVxcOQ2qb7hrlojgSvYw6RuQdVIyx7+yag1i629i
 5tfkVwFZtFe/iP8n+Panfat4rI5wYcv3M6SRF06IFZq/hBI2H/Be2prtisLUukh2Ji
 XYfBQhV84rWs6qoknLbsuvh2T82K1dWv/xa2+qecdtYbWjL2Y/CvV/fNOGOgVsxzIw
 LB3BvCqHGiN7mqPFuCL+YGzYDbYSqzT+HLpKSOBxSKJky17WuVp6IqDidK9wObwwx+
 323DflnPy6vug4u1yGQXRfiIqvTZiDyUM73YM8UIYmNM6dXtuiZOD7Tq0mDsNbC85/
 Dgn/DUfKCCWxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 23/32] drm/amdgpu: Do not issue gpu reset from
 nbio v7_9 bif interrupt
Date: Mon,  4 Dec 2023 15:32:43 -0500
Message-ID: <20231204203317.2092321-23-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
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
Cc: Sasha Levin <sashal@kernel.org>, lijo.lazar@amd.com,
 dri-devel@lists.freedesktop.org, Felix.Kuehling@amd.com, Xinhui.Pan@amd.com,
 tao.zhou1@amd.com, asad.kamal@amd.com, le.ma@amd.com,
 Stanley Yang <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>, James.Zhu@amd.com,
 airlied@gmail.com, christian.koenig@amd.com,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

[ Upstream commit 884e9b0827e889a8742e203ccd052101fb0b945d ]

In nbio v7_9, host driver should not issu gpu reset

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Stanley Yang <Stanley.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index f85eec05d2181..ae45656eb8779 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -604,11 +604,6 @@ static void nbio_v7_9_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 
 		dev_info(adev->dev, "RAS controller interrupt triggered "
 					"by NBIF error\n");
-
-		/* ras_controller_int is dedicated for nbif ras error,
-		 * not the global interrupt for sync flood
-		 */
-		amdgpu_ras_reset_gpu(adev);
 	}
 }
 
-- 
2.42.0

