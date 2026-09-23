Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CB2C98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 21:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7E310E17B;
	Wed, 23 Sep 2026 21:25:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zz6l+Phq";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 132EE10E17B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 21:25:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nd1HT550JLVfxdwWqSwLq8wRZQzoeo58tL1vHLHepn58aZVcyfvZCmWGtZH2/HLwlyJZMyU5Vjnnx1gHJHwKxUy0CD1y284BxJqII3uDrzCH+U8NoYieLNqB8J36HuL4xCkUhefGGYttfREqOjqB/IursfEA8vxL4oG1achG/l74B3GS8Rx0+7yM4IELIF+4s9t8aph+YJ9/aW6dx0jkb2NHi1xRXoUtvk17wN9oNt0s/krzIxC104U0BML/e1jTdzu21skzArJMIaJVaSjglywcrlLX2V6fifJQf7oDzrV7RACPNEdC0NdK1zJbpXdH61GPcZd24DY6LvS/R9sYUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VpQ6isJPG+jV+/jW65YIR3bLaRe2pQPDyQSZD/O7oo=;
 b=bR7ABmbT/MlJzSUMf/Bj0iMZQjNqfxpDQf1PN51myAu+I1LzKkID0JlKxbzwa9FPmjMPcHQpj3bVpcQ6Ulh0x8lMVrdFwB5Vu2EoL3TWPiWVfDy2X3fw7bw43VSkkkWDXoXNLgrq5ZHB3qrVBqpITppNEIHNQNLgGgE5hwwRasnU01DNSMmfI38Mep8UAOzq5F5I6GTG53eixqCvAwCPorTjypoMjiawz0OIfZzUJVtzr8QaO94YpFWBlm19Assdhb6DomsTwoN+U6un/Uk8jVZUbY+Ik15gk/KShkz0/g8Aj+YmS5EdFvVnm5MEIO+rsTVLepFz+BcFLFOkuoDodA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VpQ6isJPG+jV+/jW65YIR3bLaRe2pQPDyQSZD/O7oo=;
 b=zz6l+PhqLhVZlVvDFzGxhzO5PjCbFq386XA1gQvgv7z7wZLLyJ9Dm+HLSbRcVAyFJ5mPm6GxYeVfgYm8S1ZP27cgjQfBWVhFRyhimKDNmh9BKI6PcomhHnxWAONL82NwAd+GuxvEuTGqZK8YuAJLyVetyiEGvYNingdnwi4nHMI=
Received: from BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::15)
 by SJ0PR12MB6784.namprd12.prod.outlook.com (2603:10b6:a03:44f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 21:25:46 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::85) by BY1P220CA0004.outlook.office365.com
 (2603:10b6:a03:59d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 21:25:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 21:25:46 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 16:25:43 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Sashiko-bot
 <sashiko-bot@kernel.org>
Subject: [PATCHv2 3/5] drm/amdgpu: Fix race on ualink_handle_lo in UALink
 handle export
Date: Wed, 23 Sep 2026 17:20:01 -0400
Message-ID: <20260923212515.1420047-3-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923212515.1420047-1-mukul.joshi@amd.com>
References: <20260923212515.1420047-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|SJ0PR12MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c983ccd-c91a-4902-4cbf-08df19b93b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: e4RBOZzTfEKwHEel2SD3ArBT0SQdIM4tspAdXxbFGDOi5YuJe+yraFiZ/M6hbOZ1r/AJXdD5TVq1MCQjTiSPEa2ysnEVtyYH/ueMPzoXNXliSeVOiNOuBYLphx/UBiuCUiZD2e3WbIjQJ1pPNlD99p+GrFVYT5eXj25LyfKSB+Y7+S9BtW2LtVnJ48wtkpXLgdQgttvmKbnaccDRwtUHxSmUNXWcERZX0OOZZp/w3LU1sHFyqBlmm2qMNpFGQKEG4+8d2CPoaVS/Fo74T/w/9bapTWA3YvXIMm7JitnxOBrgM6Ls7VIHFD2h+HwFWM/L2qc1XF2ExF6xW4Xt0zyhVeduWAoMS+GOnstN0pt9TSbmbdve9N73MSZF33Rcs9cM+ZlaWH39iexytj5E1aqr9SnkVfJdAzk2jlPIR0/VScLZLKLpijF9rO2nmKbvnHc4368DvsTGrs3rGP6dCgUacmDuGGgrIC0+UL83qKttM1cUW1H9AP6GmCvXdBF2vjc9RJUC1morPAF6ygUGvA9oXz6DkQG3j9kF9RVkQbSHjMBig1K9dv93XEcs2jphCMKz3dEjv6s0W79EqsIeK7gLH6HgLOxHv1JsFAu96KI1SLPAGWW5lpq6ej4fGzo/L20Grm3/nsH6XkSXkvPulS2nI+hX3OvdQIUpezwcLzQYfZb4MdApDL52nDfvm7WPVr58KryY01H4A+0KEU5b2WyPNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rqTr4/b5saULZ3RZHrXmUeNL05d6cF5obsRWpL3dXnPxt0ZjXJzUeYmNfC8KD8YYm9h24RaDffSwqOMixvLlatJBWscEAT+mgS/LPDnRh1N79xysOmhHpSwWSvMIpgeKAtw+ISEWiGh04KDajgJElc7Btl0z1prZGZIqbuHNMswuv09B8XTmutBTukBr6OTglrBGkaLLMcfgOaVeqcji9yjH6CszCvW6EjoGlPushMVzi0XqWA4oYUjluEAmeh9fihKMM5vCZGv5CYblZD9ItDOAr3MhFqgwQxYCJC6TmrBn7gUCAIbbX64NfWn8xE85r+9+wzpDgIOOYviKe53zS0K3ya9rAuJgP3wKIQUJUWO5EjDDKgWRykEBHtbLvS0ysii6juunJuxLeN7BWfM/UmkTl4yJsEme2ILOVkgb1tWzBF8lltMrTZ8Q75SON1NA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:25:46.0701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c983ccd-c91a-4902-4cbf-08df19b93b28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6784
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

amdgpu_ualink_export_handle() tests robj->ualink_handle_lo and stores
the generated handle into it without any lock; xa_lock only covers
handle generation and the xarray insert.

Two threads can therefore both observe a zero handle for the same BO and
both allocate an exporter node, take an amdgpu_bo_ref() and insert into
exp_xa, with the last store to ualink_handle_lo winning. Teardown only
erases the handle recorded in the BO, so the losing node keeps its BO
reference and pinned VRAM until device teardown.

Each racing thread still generates its own handle and inserts its own
node, but the handle is published to the BO under the BO reservation
lock after re-checking that ualink_handle_lo is still zero. Exactly one
thread makes that transition; the others find a non-zero value, roll
back their node (erase from exp_xa, drop the DMABuf and BO references,
free it) and return -EAGAIN so the caller retries and picks up the
winning handle. This keeps a single exporter node per BO.

Fixes: 6b1a5ad90778 ("drm/amdgpu: Implement UALink handle export")
Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Use amdgpu_bo_reserve() to update the ualink_handle_lo in the BO.
  If it is not zero, then roll back the changes.

 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 31 +++++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 6e937f31a5b1..39b7cc8bc1c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -4023,9 +4023,7 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 		if (IS_ERR(exp_xa_node->dmabuf)) {
 			r = PTR_ERR(exp_xa_node->dmabuf);
 			dev_err(adev->dev, "Failed to generate DMABuf for the BO\n");
-			amdgpu_bo_unref(&exp_xa_node->bo);
-			kfree(exp_xa_node);
-			goto out;
+			goto err_unref_bo;
 		}
 
 		xa_lock(&adev->ualink.exp_xa);
@@ -4036,13 +4034,22 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 		xa_unlock(&adev->ualink.exp_xa);
 		if (r) {
 			dev_err(adev->dev, "Failed to insert exp_xa_node into XA: %d\n", r);
-			dma_buf_put(exp_xa_node->dmabuf);
-			amdgpu_bo_unref(&exp_xa_node->bo);
-			kfree(exp_xa_node);
-			goto out;
+			goto err_put_dmabuf;
+		}
+
+		r = amdgpu_bo_reserve(robj, false);
+		if (r)
+			goto err_erase_xa;
+
+		if (robj->ualink_handle_lo) {
+			amdgpu_bo_unreserve(robj);
+			r = -EAGAIN;
+			goto err_erase_xa;
 		}
 
 		robj->ualink_handle_lo = handle.handle_lo;
+		amdgpu_bo_unreserve(robj);
+
 		/* Return the generated handle back to the caller */
 		*handle_out = handle;
 	} else {
@@ -4059,6 +4066,16 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 			handle_out->handle_hi = exp_xa_node->handle.handle_hi;
 	}
 
+	drm_gem_object_put(gobj);
+	return 0;
+
+err_erase_xa:
+	xa_erase(&adev->ualink.exp_xa, handle.handle_lo);
+err_put_dmabuf:
+	dma_buf_put(exp_xa_node->dmabuf);
+err_unref_bo:
+	amdgpu_bo_unref(&exp_xa_node->bo);
+	kfree(exp_xa_node);
 out:
 	drm_gem_object_put(gobj);
 	return r;
-- 
2.55.0

