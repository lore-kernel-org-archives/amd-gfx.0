Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82277C63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08FB82076C
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbNbsPzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FB82076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A8CA89956;
	Mon, 30 Nov 2020 23:08:21 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D558B89956
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 23:08:19 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id q22so12633218qkq.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 15:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mcuSYokzXyoBfF/TRgK7OobDekOiYbor+0fTH3XFeCI=;
 b=nbNbsPzCYtgg6Da1c4bZZ4BJaSqgCWmlS3iAKJLRqRlky5NzEchZVubq4T4KGdNMre
 ZhtIaL6r0sRYkInZWQjnhCk0WQjxYoBAD8ITxb+OyAfI5Tbnn0IozEB1UVwIFb2ygzbh
 dqECTbvpK0FQhVmj+sIcLyPDs/76Xj3SJbL9NxY3NqeWibBs2Ec/uYJww4rHsr8u3XvJ
 srpggg+G36k/oBwa0Vuuas4WAnLdDJaF14hlPifOGJZTf8GcUO3UO2Slo/8mTT7tCqTb
 YneacCjzS+xOzDm0StNfXMLngh9Dic9txDWK8+v0nK9+XxFGOSjQYrN/e9h3HJEF5JBr
 EVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mcuSYokzXyoBfF/TRgK7OobDekOiYbor+0fTH3XFeCI=;
 b=hZENh5+rmzuyBZla7fwlvXzAStYspSIDetOejX7yhLOKvz+snJO7nR0MbknSVnRUr+
 5YJ5YKGtSLGNLBI3Z6i3hIlWTXCMrvFQQSJ9EOVYFSh9/UkulhA3lndDGyZiaP0yH16X
 6te8sPushdwUi5YzYPQapfSMuo5XH5KtWUNjuwDkiBRJCLFLlhtZ3Hse+2zRW7kEaVcw
 crdT/ljA95nKK3DxfFuC2Eaf/q8atw1wgtBXaFmm/WfgOeW7f5ihBaqZ5KTR3hPQkuBD
 3VKe+g3f1ynwn5jtNmlWoMqSLToqBzQ/+VRuEl2s+iFKZWIaoUwPb7jeyReeZZX8cNQO
 gp8A==
X-Gm-Message-State: AOAM533r9QH84CMzn0suevuUW5SaluStZiilCvBZ9kd+1t2/7lk2RoJU
 1aQ/fGsimQmDG+f28qcWrXNQq/+Ny+8=
X-Google-Smtp-Source: ABdhPJwS3UnW5F9tWBDWEQg4ZOKE17DTdI1aUCSCMDz2o5ButUUaXI+zdK3zlIQq3GDYZ1XVS/yK8g==
X-Received: by 2002:a05:620a:15ce:: with SMTP id
 o14mr25798289qkm.408.1606777698963; 
 Mon, 30 Nov 2020 15:08:18 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id c10sm16625894qkm.71.2020.11.30.15.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 15:08:18 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/powerplay: return an error of copying to smc fails
Date: Mon, 30 Nov 2020 18:08:11 -0500
Message-Id: <20201130230811.209647-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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

Rather than just silently dropping it.  Also fixes a set but
unused variable warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
index 4bfadb49521b..04b561f5d932 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
@@ -2545,7 +2545,7 @@ static int tonga_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
 					(uint32_t)sizeof(fan_table),
 					SMC_RAM_END);
 
-	return 0;
+	return res;
 }
 
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
