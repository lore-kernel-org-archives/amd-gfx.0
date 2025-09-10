Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB81ACA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 17:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EDF610E99A;
	Wed, 10 Sep 2025 17:44:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="aBVKz5dC";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89BB910E998
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 17:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zPouyGZMbvFhU8mbBmW8zUgeGfANPblTGcQmN+e/QbU=; b=aBVKz5dC1xOCmiJIvR17u52FC+
 yBfqvpXp1mK5ouN50fQ3XsJGW80nFSig0Dt9K/qF5KJoVk9g7Tm/8ZajzoVCXmhxaIGV/p8+9JMvw
 tsXc+B638P0zU0dwlxTuAdPn6e1GRvyOZanqvIKQWZRW7kmE2EzxYL96Rh7U2P86/OxtfjiNmOYgW
 ybSgUOmPQICL9hn8rcgkzVdBYOJEWzOMbSn9AkxHnYOxXfOgn19T9e0WTj5nDnIt8h/u1EPazwGbF
 QnKAqBuBWtS99EG6YcJ17r1qMZChCi7KLvplMx5vUmhvalvIQFHEEuRdVaymqDlbySzWYLvrMbcJt
 KhaTPEfg==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uwOrq-009URG-9X; Wed, 10 Sep 2025 19:44:26 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>,
 Robert Beckett <bob.beckett@collabora.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 02/10] drm/amdgpu/amdgpu_i2c: Use devm_i2c_add_adapter instead
 of i2c_add_adapter
Date: Wed, 10 Sep 2025 11:39:35 -0600
Message-ID: <20250910174350.2729341-3-siqueira@igalia.com>
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

This commit replaces i2c_add_adapter() with devm_i2c_add_adapter() and
removes part of the cleanup logic since the new function handles the i2c
removal.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
index 57101d24422f..9cb72f0c5277 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
@@ -184,7 +184,7 @@ struct amdgpu_i2c_chan *amdgpu_i2c_create(struct drm_device *dev,
 		snprintf(i2c->adapter.name, sizeof(i2c->adapter.name),
 			 "AMDGPU i2c hw bus %s", name);
 		i2c->adapter.algo = &amdgpu_atombios_i2c_algo;
-		ret = i2c_add_adapter(&i2c->adapter);
+		ret = devm_i2c_add_adapter(dev->dev, &i2c->adapter);
 		if (ret)
 			goto out_free;
 	} else {
@@ -215,15 +215,6 @@ struct amdgpu_i2c_chan *amdgpu_i2c_create(struct drm_device *dev,
 
 }
 
-void amdgpu_i2c_destroy(struct amdgpu_i2c_chan *i2c)
-{
-	if (!i2c)
-		return;
-	WARN_ON(i2c->has_aux);
-	i2c_del_adapter(&i2c->adapter);
-	kfree(i2c);
-}
-
 void amdgpu_i2c_init(struct amdgpu_device *adev)
 {
 	if (!adev->is_atom_fw) {
@@ -248,12 +239,9 @@ void amdgpu_i2c_fini(struct amdgpu_device *adev)
 {
 	int i;
 
-	for (i = 0; i < AMDGPU_MAX_I2C_BUS; i++) {
-		if (adev->i2c_bus[i]) {
-			amdgpu_i2c_destroy(adev->i2c_bus[i]);
+	for (i = 0; i < AMDGPU_MAX_I2C_BUS; i++)
+		if (adev->i2c_bus[i])
 			adev->i2c_bus[i] = NULL;
-		}
-	}
 }
 
 /* looks up bus based on id */
-- 
2.50.1

