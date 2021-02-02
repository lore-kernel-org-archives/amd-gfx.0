Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9295C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7321264DBA
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7321264DBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F2B6E954;
	Tue,  2 Feb 2021 16:13:17 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E67116E94E
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 16:13:16 +0000 (UTC)
Received: by mail-qk1-x731.google.com with SMTP id r77so20259516qka.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Feb 2021 08:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3fv/JN/sOPk9V9t9Sz0RlacA/Qg11mObrn166eOSDWI=;
 b=C59FVkCwwGLyU91I3u471JnZqIJZLR0KbFO+s6ASouhpuXYY/N1CBrSjZlFN4Q5sOe
 xEa2EZ1/En/6hr6bjVGoZQBhJmfZAsmEHLBYM9YcNT7vmzVxdR6viY96xZxvpu/B0Hfu
 yRWhAT+uGQcBqrM+1+ghd0p5F1bxrfz+FBm+ymY/SRpOigIq/Xqgf+3FeEHDBHQofAFa
 2dUMIPQEGo3WdyQL8U3iannRkPx19V9pDnx2rln/IBHp6vP2J/xeiaUe56vtAuHYbgt2
 rJPvn8upj2foE5NNVzjOksq+t2/HNHyIJ5FiwmVD4i4I4QGxqHWtyBhM34aCoEIlwPmW
 4f7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3fv/JN/sOPk9V9t9Sz0RlacA/Qg11mObrn166eOSDWI=;
 b=f8hGKDxvKUKydu+ZuKoa2J8D9HFHZUg43kWlbG5k8qzhIRCFpcVXVcKgBXphDstY74
 3AxyudVznPYF7yn5L61QPRmA0/QGH6jcFpzYpn96qyJE9FwlJAZWL28wj1cknJ2lPH9n
 Ku+7fRAEHtExs44iesHRzCjjrsVogJSJc+EhXE4fioy84xk6npOssvC7FBPZcVcANxOS
 maAgx1QyRQN5z4/fD7pXstW+NZF6iBB0jTA4a1A//PQnt2lUFRDxefR2Q/T4RLC8NEQ0
 zVvIo73CRWqMU8HVyvBtOWLFPEqXb5/g5zhd/cKfe6WRwS3niLBPg4IV41798oN0Cr68
 bjwQ==
X-Gm-Message-State: AOAM5311Gok4cDKottaCc3Dnh2rd3WVX6559MZ94daKhpx66fBOn51S1
 246LmPt2Dt/1X09jS6jpygr9YPpoEk4=
X-Google-Smtp-Source: ABdhPJw4/900qyU5SQfekNTXoo+ONGEuCOgt43zCHBWmHFgfzdnOfNjPwIio16vx53L0hYq+zLNjUQ==
X-Received: by 2002:a05:620a:124d:: with SMTP id
 a13mr22202935qkl.14.1612282396011; 
 Tue, 02 Feb 2021 08:13:16 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id z128sm14539078qke.70.2021.02.02.08.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 08:13:15 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu: bump driver version for new video codec INFO
 ioctl query
Date: Tue,  2 Feb 2021 11:13:02 -0500
Message-Id: <20210202161303.538281-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210202161303.538281-1-alexander.deucher@amd.com>
References: <20210202161303.538281-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So mesa can check when to query the kernel vs use hardcoded
codec bandwidth data.

Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e855da764275..05ed82e4d805 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -91,9 +91,10 @@
  * - 3.38.0 - Add AMDGPU_IB_FLAG_EMIT_MEM_SYNC
  * - 3.39.0 - DMABUF implicit sync does a full pipeline sync
  * - 3.40.0 - Add AMDGPU_IDS_FLAGS_TMZ
+ * - 3.41.0 - Add video codec query
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	40
+#define KMS_DRIVER_MINOR	41
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int amdgpu_vram_limit;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
