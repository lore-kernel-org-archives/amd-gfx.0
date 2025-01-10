Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC296E7719A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 02:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC13010EF65;
	Fri, 10 Jan 2025 02:08:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xBPhfyBt";
	dkim-atps=neutral
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1ABD10EF6D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 02:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736474933; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=MXbDW9MAa3uhDjx5zx5HxEPL34V26LxJQj8V2w43Tho=;
 b=xBPhfyBt8P3OboZyOoKKuqbCoA9aP/TK1Oww7jSt7rnQO230lWO6Y3McpLZclRMZBJFpGvO9YscST53HUTgubNutHzyX3zWbkUiF+rorwkPISdChGQ3PjcETCQvsagWtc10LWZ7RuR9vlbb0EIG59VU9i8FPBnjK8t399GFvDus=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNJ5WAq_1736474931 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 10 Jan 2025 10:08:52 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [v4 4/5] drm/amdgpu: enhance error handling in function
 amdgpu_pci_probe()
Date: Fri, 10 Jan 2025 10:08:46 +0800
Message-ID: <ae5fe482d1310c5006384a6ec55438f6d31acadc.1736474822.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736474822.git.gerry@linux.alibaba.com>
References: <cover.1736474822.git.gerry@linux.alibaba.com>
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

Enhance error handling in function amdgpu_pci_probe() to avoid
possible resource leakage.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 41d1b06be600..f8deca2f2696 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2346,16 +2346,16 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		msleep(5000);
 		goto retry_init;
 	} else if (ret) {
-		goto err_pci;
+		goto unload_kms;
 	}
 
 	ret = amdgpu_xcp_dev_register(adev, ent);
 	if (ret)
-		goto err_pci;
+		goto unplug_drm;
 
 	ret = amdgpu_amdkfd_drm_client_create(adev);
 	if (ret)
-		goto err_pci;
+		goto deregister_xcp;
 
 	/*
 	 * 1. don't init fbdev on hw without DCE
@@ -2424,6 +2424,12 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 
 	return 0;
 
+deregister_xcp:
+	amdgpu_xcp_dev_deregister(adev);
+unplug_drm:
+	drm_dev_unplug(ddev);
+unload_kms:
+	amdgpu_driver_unload_kms(ddev);
 err_pci:
 	pci_disable_device(pdev);
 	return ret;
-- 
2.43.5

