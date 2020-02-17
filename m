Return-Path: <SRS0=Eo1a=4F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CD3C34022
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 21:38:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D3922070B
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 21:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K75v/jCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3922070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A03556E0EA;
	Mon, 17 Feb 2020 21:38:02 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C55986E0EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2020 21:38:00 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id a2so17563604qko.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2020 13:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+QmXoSz58wYQftBbsKizYsXDWHBj5ii6Y7MbHDo1FO8=;
 b=K75v/jCNHRpYjFUvSGLDMRlHp3rwREAhwcpXeaa9osU1nKfofE6ZrUMPHkOi3BATUp
 h8AIVWwazENHxA/RhtLq86x/+8CeX5eDr9+IDYMolDs9ZQh0PFtGtRuVNPnvaZeJwtEI
 hVFPVbxeyr8js6lzZ+b4s3CtmsYFbOKr9gNERi19kUsz1BKfAsF/P4ggSa9DAYyeXnNC
 C/NBNKAw0vkJwKli6LAkYC/2b3a0tMyjFBGW2qA2EGWgYcSRAlWwArg87jydC0wR5A8E
 JzaNW5zHNTg4YKCxzc+BBY2wY4LxV4HUKz5oqt8dZGwzcjdN0qASYUpdqIkXrkwerzWo
 1HZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+QmXoSz58wYQftBbsKizYsXDWHBj5ii6Y7MbHDo1FO8=;
 b=Yg154cPb+ZbpG1pDvkevQWbIjgM2Q3fh0af0dEDFCsd/jGxwgS+0RYkR+Ih0VMi8K0
 2lMlzeHnclBcSxfCeTVocHmdSk27m/4o9oZYCWNF3EVgYVrOSLa7Mq5liHktF6wabtAM
 U+j0bk6U9tIUvFBpqozk3J5tyw9Rpvvr8HL1VHWIVjw9Xbde0FJXFkmr/lA5fsiupgWW
 ODxuPoIiI+xVwaqKpmXjH9rV9PnSkW/x7TrRKBLwDhqbxLXEel4wZN4dSbhpAm8Sw1N8
 YXptKWUcqL/4GszodscK4IobBGf4xV4seAizbtpefsmYoBZLJmrZnaXSdrZmz2IKkU+p
 lUyg==
X-Gm-Message-State: APjAAAXAtvmJSeN2nLzfbAtKDTps/07R3UWsMA9HfJgdJL3Mno3bdS8h
 Nonsq6bBrZte4RjR8HjCqDGpwAgu
X-Google-Smtp-Source: APXvYqyP+t7X26bRfTtJyIPEHuMJfGYDbmg5Ur+AOXM/5Rk6PVQSAfT7eMxYApLCDDlc+ASw6Pv2ZQ==
X-Received: by 2002:a37:9245:: with SMTP id u66mr16683392qkd.102.1581975479721; 
 Mon, 17 Feb 2020 13:37:59 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id e130sm866590qkb.72.2020.02.17.13.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 13:37:59 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/smu: add an update table lock
Date: Mon, 17 Feb 2020 16:37:30 -0500
Message-Id: <20200217213730.1413533-1-alexander.deucher@amd.com>
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

The driver uses a staging buffer to update tables in the SMU.
Add a lock to make sure we don't try and do this concurrently
by accident.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 7 ++++++-
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 9f2428fd98f6..437a3e7b36b4 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -530,6 +530,7 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
 
 	table_size = smu_table->tables[table_index].size;
 
+	mutex_lock(&smu->update_table_lock);
 	if (drv2smu) {
 		memcpy(table->cpu_addr, table_data, table_size);
 		/*
@@ -544,13 +545,16 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
 					  SMU_MSG_TransferTableSmu2Dram,
 					  table_id | ((argument & 0xFFFF) << 16));
 	if (ret)
-		return ret;
+		goto unlock;
 
 	if (!drv2smu) {
 		amdgpu_asic_flush_hdp(adev, NULL);
 		memcpy(table_data, table->cpu_addr, table_size);
 	}
 
+unlock:
+	mutex_unlock(&smu->update_table_lock);
+
 	return ret;
 }
 
@@ -900,6 +904,7 @@ static int smu_sw_init(void *handle)
 
 	mutex_init(&smu->sensor_lock);
 	mutex_init(&smu->metrics_lock);
+	mutex_init(&smu->update_table_lock);
 
 	smu->watermarks_bitmap = 0;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 97b6714e83e6..506288072e8e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -362,6 +362,7 @@ struct smu_context
 	struct mutex			mutex;
 	struct mutex			sensor_lock;
 	struct mutex			metrics_lock;
+	struct mutex			update_table_lock;
 	uint64_t pool_size;
 
 	struct smu_table_context	smu_table;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
