Return-Path: <SRS0=J303=3J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB16EC2D0DB
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 13:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB45122314
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 13:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mhdi7DqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB45122314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E01B6E955;
	Mon, 20 Jan 2020 13:34:49 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF0046E955
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2020 13:34:47 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id p9so14534536wmc.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2020 05:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vM/BicR5pSQTUAaHUiLNdB/bQR0AiyZILd122e5dN+k=;
 b=Mhdi7DqDvmk2qzDPiMqZZDfwzJIq+NHFtLCs2oTO11QVz/Bfj16PeStMmy+tcbXf2B
 7CgK3YW/u0LFS1+ULY0MpsgnxVsiYP45TBZNBXVW4t+4FZkoWVGqRLgCtZmD1zxdCkwI
 9HA+v3sG4eKspbjY1th1yEjThBUXSG1pLFv5CdwIsya8JoR0JK4wxm3yTaYuilyDk8gp
 dKMj+naSYRdXI36i6wiohFO8BAmwbBOe+wDeilTjnAwAf9EsEoOzDjGF1x4s4r0Y0TGK
 ejTNom/NeYb4Ac6d8D9sFm1QCegF5+jjpNkWUGUkFed9Ej2PavIQnPOgC24+AUvwy5a7
 QJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vM/BicR5pSQTUAaHUiLNdB/bQR0AiyZILd122e5dN+k=;
 b=gStIJfJ1LlAaScQEqPrizdHQJS94NKRpdkGejBqVwo+lfz6qnmyIMtJ6ZweHVZ/ReZ
 r7dOvtpnKhMzBSxePBkJ3VlpKyEk/S+9u6qnOaxOBXZEyEOyD19AO9f/gKlIdtbpx+36
 Iu44pte0u/VHxxU26BH34R2eoUW8z1P3/h22HnKv6aUhIcfbwV3jx9zNcC/rTvEfpjoL
 QoZcAjHoIyyo2WjvRn378WnodbXJFH3gSddfnt7Jzzp3uLD4aN3WI2IyuyZfvkwfOJ6m
 vZUtCL3JHIDqhS+37BSrbTj/h9Tc6pDciHnfB62ICDx6+pQoc1ba4URHY29k8nKGPoCv
 sQfw==
X-Gm-Message-State: APjAAAWxjketAtlFNIPEr9TmWmFuUFx/7K2I0wE9wkDrDaplLWj0bQ5i
 UHqi9vWLK01P3Sbn2Rx4b5uEjlnPvO4+dg==
X-Google-Smtp-Source: APXvYqxbkk9QJkNoss84sz39NVgxZhBmuMR6DXyzoFoxykr1twWxf2n7ZT92GYvrxJtHFz6sCrLKPQ==
X-Received: by 2002:a05:600c:a:: with SMTP id
 g10mr18639409wmc.14.1579527286365; 
 Mon, 20 Jan 2020 05:34:46 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F25000097A4C6C4F4A6FD0B.dip0.t-ipconnect.de.
 [2003:c5:8f25:0:97a4:c6c4:f4a6:fd0b])
 by smtp.gmail.com with ESMTPSA id o4sm45993050wrx.25.2020.01.20.05.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 05:34:45 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org,
	luben.tuikov@amd.com
Subject: [PATCH] drm/amdgpu: fix a typo atleast -> at least
Date: Mon, 20 Jan 2020 14:36:21 +0100
Message-Id: <20200120133621.7911-1-nirmoy.das@amd.com>
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: b8c8b23f58c71 (drm/scheduler: fix documentation by replacing rq_list with
sched_list)

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index ec79e8e5ad3c..63bccd201b97 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -45,7 +45,7 @@
  * @guilty: atomic_t set to 1 when a job on this queue
  *          is found to be guilty causing a timeout
  *
- * Note: the sched_list should have atleast one element to schedule
+ * Note: the sched_list should have at least one element to schedule
  *       the entity
  *
  * Returns 0 on success or a negative error code on failure.
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
