Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F42BC4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 16:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA7D2071E
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 16:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA7D2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 548E06E171;
	Fri, 18 Dec 2020 16:20:39 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 633066E171
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 16:20:38 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id n142so2494259qkn.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 08:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=J8nodnndaMV2Z5AVMzAUyeAybGh6WOcpMPME7Ae+1nc=;
 b=XjxjcdFmDV/e16CXrHGrcMDfenkpu4rP+fCOz5zuhnHW0VGd3t7rN4pEeEr4XoxaDf
 IrZd+O20mJNiPnIt6DzUqa97WrMkcOogKjP+hb0ptkfB3Fg1LrGZhHuiTfzj48Hppz6g
 bhAZP1gxdG45cFtobJ+cxKjxQ1G87veuynbDZDi85Tor7x2Ltz6noZk8ZCKe1AE2FCan
 T8pKCkLeL5Cm29M+ktGZRh1+heTLTr4c3x8cSm7sGeafZp0qcTjXl/Q1kRnZTqmcb46G
 eO+1YOYoMI347BwbnhbCw5dNxF7+ApLAEV8gKenFR5ItqlfvyEeRIaRR+DyQe68UzHIb
 gxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=J8nodnndaMV2Z5AVMzAUyeAybGh6WOcpMPME7Ae+1nc=;
 b=lz0HjalutA8NAMcpDcLUIiD9nwm1s2uBmqIek5lKtTcZPYxCrSexrgU4+4OgYk3Yjs
 bkgGbFrPUB1gHwof8f6W9hyNzVbMYKDdnkaVbthSxOW5UnjNAgQAV+Cfh/lcRQTUA96v
 B8vHMYsAuEcs1YOSsihCou5LmytlLRNj+1hLWhIG7V/jHke6FErdiomLTsSWoBnYvO5r
 rX++OYtffFnawGc7VXOC+jrV/JzHl766UIjjPJJwCV86C9sj5DL590frgmYVh4uNxh1G
 AfhnZjsHjwej1qIjHa7roT1hm4GtAtwTloY5uq+iLZyXj+SOi1kZsDK9kdgOILN1I1tk
 kWJQ==
X-Gm-Message-State: AOAM533w110JHWq4fN1k1JvOaMKvSvC9yYOhzMt/GF2VyGvvuut2KY4N
 /07GVGOE18RVaduMj5+ba6vEaV3pq5M=
X-Google-Smtp-Source: ABdhPJxzoU7mas3M6zQlj8FKRSPyWR/gA2y+/MhDM7XZOxGZqeBClRlvBDfoU3UF4HKBqeLOVm/CPQ==
X-Received: by 2002:a37:b82:: with SMTP id 124mr5563225qkl.294.1608308437364; 
 Fri, 18 Dec 2020 08:20:37 -0800 (PST)
Received: from localhost.localdomain ([204.111.139.145])
 by smtp.gmail.com with ESMTPSA id u26sm5831042qkm.69.2020.12.18.08.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Dec 2020 08:20:36 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix a copy-pasta comment
Date: Fri, 18 Dec 2020 11:20:30 -0500
Message-Id: <20201218162030.20662-1-alexander.deucher@amd.com>
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

This is not a scsi driver.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f194fafa619d..e46646679281 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5070,8 +5070,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
  * @pdev: pointer to PCI device
  *
  * Called when the error recovery driver tells us that its
- * OK to resume normal operation. Use completion to allow
- * halted scsi ops to resume.
+ * OK to resume normal operation.
  */
 void amdgpu_pci_resume(struct pci_dev *pdev)
 {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
