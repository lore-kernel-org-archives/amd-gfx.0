Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2014C4BA24
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 23:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4801222C2
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 23:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vFUYF5+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4801222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827FC6EBDF;
	Wed, 26 Feb 2020 23:16:33 +0000 (UTC)
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD8A6EBDE
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 23:16:30 +0000 (UTC)
Received: by mail-il1-x141.google.com with SMTP id b15so710971iln.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 15:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CzEas/WFvliJnkJBOTvDRCAl7iRmJvBhgNguUnnING4=;
 b=vFUYF5+mn+2i0clvBXU2Y1Gyj0hyd3FEap2eVNPOUyBXH3uAfTNjc0B8KGBddyPtpX
 J+zQy4cevlK+K9z1AjU4FYCvByEsqn24mRod8I9cegZWFAucXyHmeW15RY+qbJB1MiJL
 qdKrIcge8pM1zO4yGDLZIvDh9fuw66PayNtJ3QbSvH8ixsDdLiN6bUS4BFwNqveJoy5c
 L+NEB902KoF6AEwoVx5vJQSm9MuH3+CG9VAxZEy3jss8AjkSbexvK5qziYEQKhUUb5DK
 pEK5WtQVoWk2hPv1QXlckKAaCpA46EnS+u+T/3HlRXXYg9d29x8oS+PDuKYd9qgcNS4/
 XnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CzEas/WFvliJnkJBOTvDRCAl7iRmJvBhgNguUnnING4=;
 b=bXXRZK6rPDJRk4/MJbtcfiEYrJNd2Xr59KJOboO862IiOFs8YnyJyL7T+sHhtNW5hJ
 yMPHDy8X9yYaTYPWWWG+8n/PZp49FI9R3VhhiEyayoJOZajOteCm9gHh+Qi1bEDvyauR
 +3olt+n9Ss39f85h9K3kENjzEs8vg2mU5NMz1RyLHW9lc2BDOxpJtleoeCtPFGw/M7p9
 LTq+ZgtJk5GmIMSTnuB33//qQKgaMRbWEhGoChNSxjZY0Mmx2kXNTjJ0QUw7Au+FPb3y
 LrZ29UZWwCgJ75qhjsayJHbwEBLvLn4Go08Dtkk94B7ptS+RSf149x+WZhkGnwR/wzTo
 2SUA==
X-Gm-Message-State: APjAAAVzainNxAxHpSimL5mbr+R9ssEvXhN5e+BJuiYNnWvYdy4THVEw
 C2LUVoYRhlOlJfm8Rhs/9qg=
X-Google-Smtp-Source: APXvYqwxtG2fCjEvk1qx3B1nDuUJt2pSopUPv7xcZYyJHmbCJksWtsXTDDY8HATsd9hH2PqQUJlDfA==
X-Received: by 2002:a92:8851:: with SMTP id h78mr1299672ild.308.1582758989373; 
 Wed, 26 Feb 2020 15:16:29 -0800 (PST)
Received: from mcoffin-dev-tower.ec2.internal
 ([2602:ae:10d1:b00:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id u80sm1119912ili.77.2020.02.26.15.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 15:16:29 -0800 (PST)
From: Matt Coffin <mcoffin13@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 3/3] drm/amdgpu/smu: Add message sending lock
Date: Wed, 26 Feb 2020 16:16:14 -0700
Message-Id: <1a9d0a373c504bb04538ea77e515d18e8cc1ee21.1582758922.git.mcoffin13@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1582758921.git.mcoffin13@gmail.com>
References: <CADnq5_NTd_dZAtN4yVyeM+Fp2w0Toy=tkvz00OwiYyC908W1Xg@mail.gmail.com>
 <cover.1582758921.git.mcoffin13@gmail.com>
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
Cc: Matt Coffin <mcoffin13@gmail.com>, Nirmoy Das <nirmoy.das@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This adds a message lock to the smu_send_smc_msg* implementations to
protect against concurrent access to the mmu registers used to
communicate with the SMU

v2: Implement for smu_v12_0 as well

v3: Add mutex_init for message_lock

Signed-off-by: Matt Coffin <mcoffin13@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     |  1 +
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  1 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c      | 12 +++++++-----
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c      | 10 ++++++----
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index ef2b173eae28..46c2462bd8c2 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -889,6 +889,7 @@ static int smu_sw_init(void *handle)
 
 	mutex_init(&smu->sensor_lock);
 	mutex_init(&smu->metrics_lock);
+	mutex_init(&smu->message_lock);
 
 	smu->watermarks_bitmap = 0;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 573929114617..d652f920a65a 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -362,6 +362,7 @@ struct smu_context
 	struct mutex			mutex;
 	struct mutex			sensor_lock;
 	struct mutex			metrics_lock;
+	struct mutex			message_lock;
 	uint64_t pool_size;
 
 	struct smu_table_context	smu_table;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 805735242273..3a9d11706490 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -102,11 +102,12 @@ smu_v11_0_send_msg_with_param(struct smu_context *smu,
 	if (index < 0)
 		return index;
 
+	mutex_lock(&smu->message_lock);
 	ret = smu_v11_0_wait_for_response(smu);
 	if (ret) {
 		pr_err("Msg issuing pre-check failed and "
 		       "SMU may be not in the right state!\n");
-		return ret;
+		goto out;
 	}
 
 	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
@@ -119,18 +120,19 @@ smu_v11_0_send_msg_with_param(struct smu_context *smu,
 	if (ret) {
 		pr_err("failed send message: %10s (%d) \tparam: 0x%08x response %#x\n",
 		       smu_get_message_name(smu, msg), index, param, ret);
-		return ret;
+		goto out;
 	}
 	if (read_arg) {
 		ret = smu_v11_0_read_arg(smu, read_arg);
 		if (ret) {
 			pr_err("failed to read message arg: %10s (%d) \tparam: 0x%08x response %#x\n",
 			       smu_get_message_name(smu, msg), index, param, ret);
-			return ret;
+			goto out;
 		}
 	}
-
-	return 0;
+out:
+	mutex_unlock(&smu->message_lock);
+	return ret;
 }
 
 int smu_v11_0_init_microcode(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index c18b08c8cb9a..93b85585fd26 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -88,11 +88,12 @@ smu_v12_0_send_msg_with_param(struct smu_context *smu,
 	if (index < 0)
 		return index;
 
+	mutex_lock(&smu->message_lock);
 	ret = smu_v12_0_wait_for_response(smu);
 	if (ret) {
 		pr_err("Msg issuing pre-check failed and "
 		       "SMU may be not in the right state!\n");
-		return ret;
+		goto out;
 	}
 
 	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
@@ -105,17 +106,18 @@ smu_v12_0_send_msg_with_param(struct smu_context *smu,
 	if (ret) {
 		pr_err("Failed to send message 0x%x, response 0x%x param 0x%x\n",
 		       index, ret, param);
-		return ret;
+		goto out;
 	}
 	if (read_arg) {
 		ret = smu_v12_0_read_arg(smu, read_arg);
 		if (ret) {
 			pr_err("Failed to read message arg 0x%x, response 0x%x param 0x%x\n",
 			       index, ret, param);
-			return ret;
+			goto out;
 		}
 	}
-
+out:
+	mutex_unlock(&smu->message_lock);
 	return ret;
 }
 
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
