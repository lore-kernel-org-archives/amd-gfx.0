Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA19C02181
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 05:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9015C10E8D3;
	Fri, 24 Jan 2025 05:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ba/n8h70";
	dkim-atps=neutral
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0536810E8CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 05:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1737695963; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=DJx3/FJ+keihAUFJDWXmUNZ2psnoYscakLVTbCGVpfg=;
 b=ba/n8h70C5EDZwhyQPF3k2V5XeVYmfnJK0NgRcZXAIGmY6GQVLjf+o6Zuyqaq9ikj90k0Cp5GkRYeiiZQGCTotVXcJCpwqNaBCfkc1QNqAxX/CWdHWXEjf0gayEsGdCo+/9yRc0V4s6OQFG+h4ekc4E+vNUYbk4o5gyyvaaFk00=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WODTwjc_1737695962 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 24 Jan 2025 13:19:22 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [v6 4/5] drm/amdgpu: enhance error handling in function
 amdgpu_pci_probe()
Date: Fri, 24 Jan 2025 13:19:17 +0800
Message-ID: <22658fe6b0741fce0d2f2112a91baa2625a82137.1737695869.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1737695869.git.gerry@linux.alibaba.com>
References: <cover.1737695869.git.gerry@linux.alibaba.com>
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
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3f26e850120c..f1378b867923 100644
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

