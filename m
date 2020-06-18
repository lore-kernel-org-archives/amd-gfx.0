Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F977C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 14:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15FD4207E8
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 14:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsbKPQbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FD4207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFCC26EA6C;
	Thu, 18 Jun 2020 14:24:36 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 092B76EA6C
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 14:24:34 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id p15so2815067qvr.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XE3VKROtaQhox7vjjdhEyTukKz0gUjh2XzBxPeK5ffQ=;
 b=tsbKPQbt7x2yse9xlhAraZuYo1pX7KMiUXzCVCPEImlVOvzcWxIKenh+2NnprgQ9Hk
 dUdcacv57ewLA62qhbj1vk7yFyDU8OoYN89FkNXlMihXzkGSmliiHmW6vgzbuTdx1Y7Z
 Dtjwo23d4nrtOnxIk5xtEFym6bLFHAHQCbUy2vl4lZXQtOjGh2mUVvGrWx4hBTcOYwfz
 CXpSBhM7gkCeGjBbpySOamZZN/WkuE6sWTJ27951E4aviiX2UaVErmrdryPWwHe+ZjOv
 Ji3eCNDX9fDIyr7zIPdmmwIQoR67sWbItchh/iCFvvUOoI2Dw4aMNFo0qeawxTFDDS9i
 ngbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XE3VKROtaQhox7vjjdhEyTukKz0gUjh2XzBxPeK5ffQ=;
 b=gOdx9tWBPPQF2nijoz++x4rAxlSUnTw6G0cuMhqKt1hpxhtTh1qkB3tp6VtOINfV4C
 vuHvZPrG/4In0O9+rMR/a3q82X1USFj/+yum/2d2uJAwL40f89XM2YYPiRk0eLiprRO8
 EVBpJEFxu+Wp8IqnZQ32lRjh36FIi8KnMjNkQ1I5kztYKABfNmaR78sFwfN/P3fgEE4b
 xJ1Glo3K1OM3IWKDY6ZsFOuAr3zgOEaYDdZfQC1TI+NJImz9ErVXB7yaGVTXHvyifkOs
 GHCQPlqFJDiORg3+dbEM46wuBR3EkIAC3A0ZAcMxjFb0v+GMpFoO88NhyNsN4weOPdbH
 rKRQ==
X-Gm-Message-State: AOAM530vZ5EiicmObuY+fmYEfd/Jyx8IlZzRarbUAEHqW6haObgxCX0I
 8j/HNvqrJFnnO35xB0LsPLVTMx07eTy5sg==
X-Google-Smtp-Source: ABdhPJzbhb3EbsL6jedGNYp3cYcpz+SOdXnNi83x+PXF2RWrVo/u5eFOALyImc7ue3L8WFqhhBux2w==
X-Received: by 2002:ad4:4309:: with SMTP id c9mr3978272qvs.50.1592490272788;
 Thu, 18 Jun 2020 07:24:32 -0700 (PDT)
Received: from brihaspati.amd.com
 (p200300c58f2304001ed633024609edb3.dip0.t-ipconnect.de.
 [2003:c5:8f23:400:1ed6:3302:4609:edb3])
 by smtp.gmail.com with ESMTPSA id g4sm3028529qka.97.2020.06.18.07.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 07:24:31 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4 v2] drm/amdkfd: label internally used symbols as static
Date: Thu, 18 Jun 2020 16:25:40 +0200
Message-Id: <20200618142542.77714-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618142542.77714-1-nirmoy.das@amd.com>
References: <20200618142542.77714-1-nirmoy.das@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, nirmoy.das@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Used sparse(make C=1) to find these loose ends.

v2:
removed unwanted extra line

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c              | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index fcc927c2f887..21eb0998c4ae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -137,7 +137,7 @@ void program_sh_mem_settings(struct device_queue_manager *dqm,
 						qpd->sh_mem_bases);
 }

-void increment_queue_count(struct device_queue_manager *dqm,
+static void increment_queue_count(struct device_queue_manager *dqm,
 			enum kfd_queue_type type)
 {
 	dqm->active_queue_count++;
@@ -145,7 +145,7 @@ void increment_queue_count(struct device_queue_manager *dqm,
 		dqm->active_cp_queue_count++;
 }

-void decrement_queue_count(struct device_queue_manager *dqm,
+static void decrement_queue_count(struct device_queue_manager *dqm,
 			enum kfd_queue_type type)
 {
 	dqm->active_queue_count--;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0b4f40905f55..8616a204e4c3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -313,7 +313,7 @@ static int kfd_sysfs_create_file(struct kfd_process *p, struct attribute *attr,
 	return ret;
 }

-int kfd_procfs_add_sysfs_files(struct kfd_process *p)
+static int kfd_procfs_add_sysfs_files(struct kfd_process *p)
 {
 	int ret = 0;
 	struct kfd_process_device *pdd;
--
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
