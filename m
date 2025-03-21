Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7F9C36001
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 13:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BEF710E7C7;
	Fri, 21 Mar 2025 13:02:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=swemel.ru header.i=@swemel.ru header.b="qYsti1BO";
	dkim-atps=neutral
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2906410E789;
 Fri, 21 Mar 2025 10:52:42 +0000 (UTC)
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1742554360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UU/JcHwDnP3QhY6ZpYqh86qRIlavKskpUsk2dt6mvLU=;
 b=qYsti1BOpbwSEu3jnaF8AotVFXZL95h0urNJC1Spu2nCDYOiGw/g68JvbiQM0VovQQUm4s
 TEOCpsLpokE27ffGL7j7X37pzpCqfuzh9t/e1F49xlX8qdjoxKmxnSQ145TtxMNdofRkTm
 Qu+Vrv4V4E1tJr9tEYoXdzggvFRDlr0=
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 Kun Liu <Kun.Liu2@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>,
 Tim Huang <Tim.Huang@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: [PATCH 2/5] drm/amd/pm: Prevent division by zero
Date: Fri, 21 Mar 2025 13:52:32 +0300
Message-ID: <20250321105239.10096-3-arefev@swemel.ru>
In-Reply-To: <20250321105239.10096-1-arefev@swemel.ru>
References: <20250321105239.10096-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Mar 2025 13:02:22 +0000
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

The user can set any speed value.
If speed is greater than UINT_MAX/8, division by zero is possible.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b64625a303de ("drm/amd/pm: correct the address of Arcturus fan related registers")
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 8aa61a9f7778..453952cdc353 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1267,6 +1267,9 @@ static int arcturus_set_fan_speed_rpm(struct smu_context *smu,
 	uint32_t crystal_clock_freq = 2500;
 	uint32_t tach_period;
 
+	if (!speed || speed > UINT_MAX/8)
+		return -EINVAL;
+
 	tach_period = 60 * crystal_clock_freq * 10000 / (8 * speed);
 	WREG32_SOC15(THM, 0, mmCG_TACH_CTRL_ARCT,
 		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL_ARCT),
-- 
2.43.0

