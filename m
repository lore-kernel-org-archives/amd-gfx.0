Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358B2CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 17:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4946F10E997;
	Wed, 10 Sep 2025 17:44:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="EqUaExAv";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05A7910E997
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 17:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PAnVQWJDB6+WQGL9HyYfRj0W4HTfl2fOOBt8/BWxhK0=; b=EqUaExAv8Q6Fwn9KefLQ7x4Mn5
 gELa/uZSw/InKfk378BJe0kgUqPMOk/CuGMKjlHeziJPQE/NEW5mRIUWbwgJ0C0JVrWr3h9MFFJcz
 hZEq5HRnVIpQu8i60vtDs8xTUhrfFtwBtuKMsrPCgom2SDQ+6vvFg8kC1qtFjYP35xYDMtDQPRs+Y
 Kg2PnrQ2D4FXKRw8Xuja2107sa4WP7OjvQAjJyRB3DhxDbsZVn+zo1qhFnl+IZ3T7VVnrMe8m/pkg
 5VpAn6QUDblZBMIjgA/aAvtrtto1kAI/Qz6vVO4FUBuDDRKCAJ6RX9N3SZWjA4/PH5xc/v4AfUnJy
 aYpm5Xyg==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uwOrn-009URG-QL; Wed, 10 Sep 2025 19:44:24 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>,
 Robert Beckett <bob.beckett@collabora.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 01/10] drm/amd/display: Use devm_i2c_add_adapter to simplify
 i2c cleanup logic
Date: Wed, 10 Sep 2025 11:39:34 -0600
Message-ID: <20250910174350.2729341-2-siqueira@igalia.com>
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

This commit replaces the utilization of i2c_add/del_adapter() with
devm_i2c_add_adapter() to reduce the amount of boilerplate. Using
devm_i2c_add_adapter() has the advantage of removing the manual
manipulation of the I2C adapter.

Suggested-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 ++-----------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fadc6098eaee..5a06a82de6d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2945,7 +2945,7 @@ static int dm_oem_i2c_hw_init(struct amdgpu_device *adev)
 			return -ENOMEM;
 		}
 
-		r = i2c_add_adapter(&oem_i2c->base);
+		r = devm_i2c_add_adapter(adev->dev, &oem_i2c->base);
 		if (r) {
 			drm_info(adev_to_drm(adev), "Failed to register oem i2c\n");
 			kfree(oem_i2c);
@@ -2957,17 +2957,6 @@ static int dm_oem_i2c_hw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void dm_oem_i2c_hw_fini(struct amdgpu_device *adev)
-{
-	struct amdgpu_display_manager *dm = &adev->dm;
-
-	if (dm->oem_i2c) {
-		i2c_del_adapter(&dm->oem_i2c->base);
-		kfree(dm->oem_i2c);
-		dm->oem_i2c = NULL;
-	}
-}
-
 /**
  * dm_hw_init() - Initialize DC device
  * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
@@ -3018,8 +3007,6 @@ static int dm_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	dm_oem_i2c_hw_fini(adev);
-
 	amdgpu_dm_hpd_fini(adev);
 
 	amdgpu_dm_irq_fini(adev);
@@ -7363,10 +7350,6 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 	drm_dp_cec_unregister_connector(&aconnector->dm_dp_aux.aux);
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
-	if (aconnector->i2c) {
-		i2c_del_adapter(&aconnector->i2c->base);
-		kfree(aconnector->i2c);
-	}
 	kfree(aconnector->dm_dp_aux.aux.name);
 
 	kfree(connector);
@@ -8698,7 +8681,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 	}
 
 	aconnector->i2c = i2c;
-	res = i2c_add_adapter(&i2c->base);
+	res = devm_i2c_add_adapter(dm->adev->dev, &i2c->base);
 
 	if (res) {
 		drm_err(adev_to_drm(dm->adev), "Failed to register hw i2c %d\n", link->link_index);
-- 
2.50.1

