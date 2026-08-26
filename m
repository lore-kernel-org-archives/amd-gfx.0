Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59728C61DC6
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 12:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF7FF10EFF8;
	Thu, 27 Aug 2026 12:47:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imm0nv1nhtv.is-a.dev header.i=@imm0nv1nhtv.is-a.dev header.b="wv2AFbYM";
	dkim-atps=neutral
Received: from sg-2-5.ptr.blmpb.com (sg-2-5.ptr.blmpb.com [71.18.227.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB19510EDBC
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 19:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=lark2602131731; d=imm0nv1nhtv.is-a.dev; t=1787772970;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=bQkE0sp1250wEmpHG0fFU1uyDKyKi32y1d4HaaoYnpE=;
 b=wv2AFbYMoMoJVqSW+KbsBXLg7NgcwZbN3sZ8TN5/KjTSgqNE6Y1dzGFq3CjGRfwx5CkV3d
 pbOowrrQX0kgQkQL4QDaNozK5NSKmBF/IwTgCeZq1gRPADmPGPt2xf2wqwODkz3RThdyps
 5G4XM8BYowlE1i0vFCyYYcdT3Wq+18ZcYhOWu7GdxLR7hmdIaE2XkT609YxA7HrS3e0USl
 Txl3m2Jng0E68FJsW4qDqNSv5hmJyNI05avapthT6c4Vz0OGD71vgGcGJJma8Mr36ic8vu
 KPCO7MDrFGdHJdMm8DPQN2CiLTwWSiVjAZ1FiFFJdSCp7IXEtSpZUS1XdX8N1Q==
Received: from Neptune-PC.kiko-royal.ts.net ([58.186.164.158]) by
 smtp.larksuite.com with ESMTPS; Wed, 26 Aug 2026 19:36:09 +0000
In-Reply-To: <20260826193602.6441-1-neptune@imm0nv1nhtv.is-a.dev>
Content-Type: text/plain; charset=UTF-8
To: "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>, 
 "Alex Deucher" <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Date: Thu, 27 Aug 2026 02:36:02 +0700
Message-Id: <20260826193602.6441-2-neptune@imm0nv1nhtv.is-a.dev>
References: <20260826170549.21985-1-neptune@imm0nv1nhtv.is-a.dev>
 <20260826193602.6441-1-neptune@imm0nv1nhtv.is-a.dev>
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2/2] drm/amd/display: close DDC on I2C engine setup failure
X-Lms-Return-Path: <lba+26a8f4029+f4ceba+lists.freedesktop.org+neptune@imm0nv1nhtv.is-a.dev>
X-Mailer: git-send-email 2.47.3
Cc: "Rodrigo Siqueira" <siqueira@igalia.com>, 
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, 
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, 
 <linux-kernel@vger.kernel.org>, 
 "NepNep7601" <neptune@imm0nv1nhtv.is-a.dev>
Mime-Version: 1.0
X-Original-From: NepNep7601 <neptune@imm0nv1nhtv.is-a.dev>
From: "NepNep7601" <neptune@imm0nv1nhtv.is-a.dev>
X-Mailman-Approved-At: Thu, 27 Aug 2026 12:47:25 +0000
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

acquire_i2c_hw_engine() opens the DDC pins before setting up the
hardware engine. If setup_engine() fails, the error path releases the
engine but leaves the DDC pins open and the engine's DDC pointer set.

Subsequent attempts to open the pins then return
GPIO_RESULT_ALREADY_OPENED, preventing further I2C transfers, EDID
reads and hotplug detection on that port until reboot.

Mirror the normal teardown path by closing the DDC pins and clearing
the pointer after releasing the engine.

Assisted-by: Codex:gpt-5
Signed-off-by: NepNep7601 <neptune@imm0nv1nhtv.is-a.dev>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
index 05892ab4529f..e7a05494abab 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
@@ -485,6 +485,8 @@ struct dce_i2c_hw *acquire_i2c_hw_engine(
 
 	if (!setup_engine(dce_i2c_hw)) {
 		release_engine(dce_i2c_hw);
+		dal_ddc_close(dce_i2c_hw->ddc);
+		dce_i2c_hw->ddc = NULL;
 		return NULL;
 	}
 
-- 
2.47.3
