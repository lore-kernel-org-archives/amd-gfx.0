Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A766AC433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 05:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DBB220707
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 05:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBB220707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64BF36E53C;
	Wed, 27 Jan 2021 05:32:47 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D0B96E53C
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 05:32:46 +0000 (UTC)
Received: by mail-qk1-x730.google.com with SMTP id n7so735538qkc.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jan 2021 21:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vziV6m0GkyWwFfeIx1mhj7yPZ49BoHJezcVGXCjAhIU=;
 b=AMXjG4cOWy2Pd/N44TwADFDaBCgT/ZsTWBtedWWMGRUXI9n37ILyA4P578JHE+i9+S
 vo5+4j1uLZ29/UKr03/PMBuVyg/VtKKMHZKqBQLKQQvfzhkzev0Noc7ivHj8Xj6BkmUO
 KS8SieY9LdnJEfYYnLzN6SUYmYl+08ZJQwVrVCTabd5JxfgG1zTLwns+RWJ2kAEcZ/10
 2BeYNu6aH4WMmpbwRkpS1u36M8SKEG9DLguSRZJPGa9I7jHGIHWIuWgE9/Ok55BQ1NB+
 yeaUmrdlKE/gsl531Tqo3jzXdnDaaQzpqQcdGUyNUqzUDknrWERhOZRUxKBSmFqIqhox
 3WJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vziV6m0GkyWwFfeIx1mhj7yPZ49BoHJezcVGXCjAhIU=;
 b=uTF3/W0gh5WFdlCAO4berXZefzyiv8UYHLPg/2cX9YkbC/PjmILZCzGBxvqI2F3TTs
 da+C/ggQdNJRSkYn/73QZYf8HTSLDZViTSHemTCT0slcWsuIrO2T5KR41+6ojlanz4tG
 Bc9ezx61oMLO4n27lEe9bZU4VQ8Nt3tEREgOtrCeaTNSvcW7q9DlJZwH0p477yZFqLDG
 Msl/7UifgVY8PJHdeYcK5fkw1CxYFEdyGtWelmCuF6idXsewCs9qZqd3PLtdcS3texzX
 VhUDHP0IbuV+B1sAhVR37lHM6xqF07S8H8J6CDlnI4s6Q9WIUBPxOmOix/cM325puwpb
 Rl0g==
X-Gm-Message-State: AOAM533fCKcLZ8RJJ/oVVCWAH4rCz0QNwW/MJMQ9B+a9d0nQk9vi5Wso
 u6eJFHF45yx727Criyo9CdPOKNUAKbc=
X-Google-Smtp-Source: ABdhPJy0+KLkDbfDwUWqjIFASNLaz6QX2xyC/Y2zdHspP5Fea0IIwJLKGfaZImzJkUmGBXF4X7geUg==
X-Received: by 2002:a05:620a:12e8:: with SMTP id
 f8mr8921969qkl.337.1611725565312; 
 Tue, 26 Jan 2021 21:32:45 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id t184sm555982qkd.100.2021.01.26.21.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jan 2021 21:32:44 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: bump driver version for new video codec INFO
 ioctl query
Date: Wed, 27 Jan 2021 00:32:31 -0500
Message-Id: <20210127053231.202843-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127053231.202843-1-alexander.deucher@amd.com>
References: <20210127053231.202843-1-alexander.deucher@amd.com>
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

So mesa can check when to query the kernel vs use hardcoded
codec bandwidth data.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index effa9062f541..021c2386778e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -90,9 +90,10 @@
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
