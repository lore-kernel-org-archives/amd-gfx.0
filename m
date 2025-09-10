Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4C2CAC58D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 17:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B7010E9A0;
	Wed, 10 Sep 2025 17:44:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WrFt4t0g";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E56610E9A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SRAoa8oC5/rY6R/k0HCCN75MLNvVJ6tsJf3etWkHSV8=; b=WrFt4t0gtWqEsHz9Ly1XqLnoMX
 aJEX8uULUlTwTyn/JlSjNJIM/uOwcQq/yoWr8tjtisQKvBd19iv4XPP3u1y2Ff7A8BfVgseu1//ws
 OckbmywHAYgc/5Iutk1SAgbPIOLpeY/UzRvqXRmJvL6pdJ1z8kc8sB1DqK4qImNij8utBSvzZ2hbU
 XWoG6WTB+pcWXoRAOSTd9XGIh7KUGO5XyO9cj3AaNQfoc3xsA2LpQVtTpmhNwT77138nFKUvNUntB
 E+KcMKRSAxREA5iVW1G+PY78BoIjaCos2yljdWFuYgvwTiH5rxw2QNfDjeXrHzML7lD3LvWiMJ+9I
 ogojPkaQ==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uwOs9-009URG-3S; Wed, 10 Sep 2025 19:44:45 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>,
 Robert Beckett <bob.beckett@collabora.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 09/10] drm/amd/pm: Use devm_i2c_add_adapter() in the V13_0_6
 smu
Date: Wed, 10 Sep 2025 11:39:42 -0600
Message-ID: <20250910174350.2729341-10-siqueira@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250910174350.2729341-1-siqueira@igalia.com>
References: <20250910174350.2729341-1-siqueira@igalia.com>
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

The I2C init for V13_0_6 uses i2c_add_adapter() and i2c_del_adapter(),
this commit replaces the use of these two functions with
devm_i2c_add_adapter(). Notice that V13_0_6 init initializes multiple
I2C buses in a loop; if something goes wrong, the previous adapters are
removed, and the amdgpu load is interrupted. Since I2C init is required
for the correct load of amdgpu, it is safe to rely on
devm_i2c_add_adapter() to handle any previously initialized I2C adapter.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ebee659f8a1c..7bc18b3350dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2490,10 +2490,10 @@ static int smu_v13_0_6_i2c_control_init(struct smu_context *smu)
 		control->quirks = &smu_v13_0_6_i2c_control_quirks;
 		i2c_set_adapdata(control, smu_i2c);
 
-		res = i2c_add_adapter(control);
+		res = devm_i2c_add_adapter(adev->dev, control);
 		if (res) {
 			DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
-			goto Out_err;
+			return res;
 		}
 	}
 
@@ -2501,27 +2501,12 @@ static int smu_v13_0_6_i2c_control_init(struct smu_context *smu)
 	adev->pm.fru_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
 
 	return 0;
-Out_err:
-	for ( ; i >= 0; i--) {
-		struct amdgpu_smu_i2c_bus *smu_i2c = &adev->pm.smu_i2c[i];
-		struct i2c_adapter *control = &smu_i2c->adapter;
-
-		i2c_del_adapter(control);
-	}
-	return res;
 }
 
 static void smu_v13_0_6_i2c_control_fini(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int i;
 
-	for (i = 0; i < MAX_SMU_I2C_BUSES; i++) {
-		struct amdgpu_smu_i2c_bus *smu_i2c = &adev->pm.smu_i2c[i];
-		struct i2c_adapter *control = &smu_i2c->adapter;
-
-		i2c_del_adapter(control);
-	}
 	adev->pm.ras_eeprom_i2c_bus = NULL;
 	adev->pm.fru_eeprom_i2c_bus = NULL;
 }
-- 
2.50.1

