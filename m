Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320BFCA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 17:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6D9C10E9A1;
	Wed, 10 Sep 2025 17:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OR8jZ2ep";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD1010E9A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 17:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cooJXokWHJx+2quSiJT7pDNAqBkyHQUAbAUUs+JAd5E=; b=OR8jZ2epmA+XzvOGvWR9L5dIYa
 dTGXldhI/o5/aEjt6iXf27fy1gDoGlTwpLcLxD2wSa3OfFP7mQdmSMpa4F70FVAa/8NVaA6HsB/S6
 7gRaKZffbGWAtY55fFgBTqVZLCD2OtboFQiSnv8AwRpMvuA5ttuupbPdjgN+lTKZSUvyruRVqJ6Pq
 ojYb9jKOGGSFKsGWSN6aWdWHJ11vTc2B06rRourEPigTqPdJBvhItGQbbVrp8IP0yNApWgRQ33hrE
 EFJgwuIk2KucVrBBqedkPhf1VEVlk3BRM7N7xFSr69eZuOlDuum4nMa1sax62AYihbu5stbKlXo3O
 gpbTFVMg==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uwOs6-009URG-KB; Wed, 10 Sep 2025 19:44:43 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>,
 Robert Beckett <bob.beckett@collabora.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 08/10] drm/amd/pm: Use devm_i2c_add_adapter() in the V13 smu
Date: Wed, 10 Sep 2025 11:39:41 -0600
Message-ID: <20250910174350.2729341-9-siqueira@igalia.com>
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

The I2C init for SMU_V13 uses i2c_add_adapter() and i2c_del_adapter(),
this commit replaces the use of these two functions with
devm_i2c_add_adapter(). Notice that SMU_V13 init initializes multiple
I2C buses in a loop; if something goes wrong, the previous adapters are
removed, and the amdgpu load is interrupted. Since I2C init is required
for the correct load of amdgpu, it is safe to rely on
devm_i2c_add_adapter() to handle any previously initialized I2C adapter.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index e084ed99ec0e..c1062e5f0393 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2825,10 +2825,10 @@ static int smu_v13_0_0_i2c_control_init(struct smu_context *smu)
 		control->quirks = &smu_v13_0_0_i2c_control_quirks;
 		i2c_set_adapdata(control, smu_i2c);
 
-		res = i2c_add_adapter(control);
+		res = devm_i2c_add_adapter(adev->dev, control);
 		if (res) {
 			DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
-			goto Out_err;
+			return res;
 		}
 	}
 
@@ -2838,27 +2838,12 @@ static int smu_v13_0_0_i2c_control_init(struct smu_context *smu)
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
 
 static void smu_v13_0_0_i2c_control_fini(struct smu_context *smu)
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

