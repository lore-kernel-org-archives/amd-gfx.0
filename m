Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6C9CAC58D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 17:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7478A10E998;
	Wed, 10 Sep 2025 17:44:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="nNILE3EJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F5E210E998
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 17:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RdxiZJYjpCDQgTR0WJRCwI17w2tw7rc13ReqcNnMDlo=; b=nNILE3EJdGx0iOCwcycEQS5puZ
 Ncc0/Qr5FVbcGpZ3va0DgGpvCLrw59JRZ1GhSY63o02+2fuQioeRGey7XApmhUhlFtHUfqijysC3j
 Ka+CBKtCdhyfKgN+fRHK+GIgnVnl66/bS1xtNaTkw501i67bDWcTcgUSiY+QB6XXpRCvwu01T47XV
 Y0nZtk2VLghRZV7WX859s603VpzAjCazYn0x027IuwUnlkT1IcTXbfjfJlcxDCngtZaskliAL0oaI
 /31GYnw3mppbZTDuHn+lyEAfzOE3mIj3GlCIE0TFicimQfi7FX8A2RMwEByVegZws84biRDtlmXMS
 qLYtNvHw==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uwOrs-009URG-Px; Wed, 10 Sep 2025 19:44:29 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>,
 Robert Beckett <bob.beckett@collabora.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 03/10] drm/amdgpu: Use devm_i2c_add_adapter() in SMU V11
Date: Wed, 10 Sep 2025 11:39:36 -0600
Message-ID: <20250910174350.2729341-4-siqueira@igalia.com>
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

Instead of using i2c_add_adapter() and i2c_del_adapter() in the SMU V11,
use devm_i2c_add_adapter() to simplify the code path.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index dd2d66090d23..68aef47254a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -743,7 +743,7 @@ int smu_v11_0_i2c_control_init(struct amdgpu_device *adev)
 	adev->pm.ras_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
 	adev->pm.fru_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
 
-	res = i2c_add_adapter(control);
+	res = devm_i2c_add_adapter(adev->dev, control);
 	if (res)
 		DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
 
@@ -752,9 +752,6 @@ int smu_v11_0_i2c_control_init(struct amdgpu_device *adev)
 
 void smu_v11_0_i2c_control_fini(struct amdgpu_device *adev)
 {
-	struct i2c_adapter *control = adev->pm.ras_eeprom_i2c_bus;
-
-	i2c_del_adapter(control);
 	adev->pm.ras_eeprom_i2c_bus = NULL;
 	adev->pm.fru_eeprom_i2c_bus = NULL;
 }
-- 
2.50.1

