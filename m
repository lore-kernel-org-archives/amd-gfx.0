Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F52C34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 14:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 352B1208C4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 14:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct+Sbc01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352B1208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE02D6E2ED;
	Tue, 18 Feb 2020 14:32:54 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 890CE6EA19
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 14:32:53 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id p7so19648093qkh.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 06:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lU9BQza05SAHzt7rYIFV8/IOsiLSzx+0FaKRMYIbZGY=;
 b=Ct+Sbc01hi9Utdh4Id/kPi8AjPP0m/VHIuwBeahtKe9Yn6+/t6LW+d0UNKpQVPqIYJ
 lvnUuKgbNHZFnR0ReH7hIlkK1etNCkyMFlpdRKrSjXpkX40cirBmSx5g+OoiJR8/BnqQ
 no5rmINXBEkGxreoP702UQd1yGUwwoE844mrqUj+Z1p1T8TZPhgkbflDAP7o21B9VIo9
 WFn6aXWKFoeDqebejlK+AYbqpehS5vfYWXrHeSVqo/VAXutrH2sW2TBlBJwmTIplXx8F
 0YIPVsjb1e0/XrmrWDWao36VHpdVlPjRO15WXj0R9Y2CoHzROfDpbwBHMxllBIthtGA7
 KLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lU9BQza05SAHzt7rYIFV8/IOsiLSzx+0FaKRMYIbZGY=;
 b=gxzfsDgwR+fuIl01cpT6ptLKJWaMS6H4Lyw5UyAQXRMgLeC3AEc8w715cM5WrTuOlx
 BjvMPcZjaqOyklHeJUfOMaU8xsJhixnz2p88fndH6guMb41aM0sh25/lGr04Q+B/V9wu
 7qzIFsQ0Nm7PBRVqxjYpWNoRzlxVADAN1HokAstqbwQZBHO7C+wj9ghdOesX5ISvor6z
 pGvGLmlePvTP+hI9G9tz6nDjNb80HlhIN13RAEARBdwfahfGyG2eMvpcFbGDuAT/K+5o
 DbEb8aoFVU+l9FFU67JlmlpKsQZIhUhHtL2Y5vAOTcVYEIgyAU9fw7KAQtG81tZl5Te1
 flsA==
X-Gm-Message-State: APjAAAVynfFJLv/jewsNUyGIYocLLfP5MwDx4rdyN+cWk1GtCIYAe2DZ
 WmHX0UF10kYqAb8wkRrQHjM4aWKg
X-Google-Smtp-Source: APXvYqzmKEFBmd//WlcQ8Yb5k5ICV58PX9tI0Ss7OdBYGHSeRyEEcZHSrwTY2kRRAGk55/cMTgES1Q==
X-Received: by 2002:a05:620a:8d6:: with SMTP id
 z22mr17525317qkz.420.1582036371202; 
 Tue, 18 Feb 2020 06:32:51 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id g18sm1962138qki.13.2020.02.18.06.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 06:32:50 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/smu: add a send message lock
Date: Tue, 18 Feb 2020 09:31:56 -0500
Message-Id: <20200218143156.1640434-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The driver uses a scratch register to communicate with the SMU.
Add a lock to make sure we don't try and do this concurrently
by accident.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 1 +
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c      | 7 ++++++-
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c      | 7 ++++++-
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 437a3e7b36b4..694017740186 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -905,6 +905,7 @@ static int smu_sw_init(void *handle)
 	mutex_init(&smu->sensor_lock);
 	mutex_init(&smu->metrics_lock);
 	mutex_init(&smu->update_table_lock);
+	mutex_init(&smu->send_msg_lock);
 
 	smu->watermarks_bitmap = 0;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 506288072e8e..25fa5c5ed09b 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -363,6 +363,7 @@ struct smu_context
 	struct mutex			sensor_lock;
 	struct mutex			metrics_lock;
 	struct mutex			update_table_lock;
+	struct mutex			send_msg_lock;
 	uint64_t pool_size;
 
 	struct smu_table_context	smu_table;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index b06c057a9002..ed5b3afcab66 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -97,12 +97,16 @@ smu_v11_0_send_msg_with_param(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, index = 0;
 
+	mutex_lock(&smu->send_msg_lock);
 	index = smu_msg_get_index(smu, msg);
-	if (index < 0)
+	if (index < 0) {
+		mutex_unlock(&smu->send_msg_lock);
 		return index;
+	}
 
 	ret = smu_v11_0_wait_for_response(smu);
 	if (ret) {
+		mutex_unlock(&smu->send_msg_lock);
 		pr_err("Msg issuing pre-check failed and "
 		       "SMU may be not in the right state!\n");
 		return ret;
@@ -118,6 +122,7 @@ smu_v11_0_send_msg_with_param(struct smu_context *smu,
 	if (ret)
 		pr_err("failed send message: %10s (%d) \tparam: 0x%08x response %#x\n",
 		       smu_get_message_name(smu, msg), index, param, ret);
+	mutex_unlock(&smu->send_msg_lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 870e6db2907e..1ca8a8c959b1 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -83,12 +83,16 @@ smu_v12_0_send_msg_with_param(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, index = 0;
 
+	mutex_lock(&smu->send_msg_lock);
 	index = smu_msg_get_index(smu, msg);
-	if (index < 0)
+	if (index < 0) {
+		mutex_unlock(&smu->send_msg_lock);
 		return index;
+	}
 
 	ret = smu_v12_0_wait_for_response(smu);
 	if (ret) {
+		mutex_unlock(&smu->send_msg_lock);
 		pr_err("Msg issuing pre-check failed and "
 		       "SMU may be not in the right state!\n");
 		return ret;
@@ -104,6 +108,7 @@ smu_v12_0_send_msg_with_param(struct smu_context *smu,
 	if (ret)
 		pr_err("Failed to send message 0x%x, response 0x%x param 0x%x\n",
 		       index, ret, param);
+	mutex_unlock(&smu->send_msg_lock);
 
 	return ret;
 }
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
