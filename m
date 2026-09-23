Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA034C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B87E10F141;
	Wed, 23 Sep 2026 19:34:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SOpE7tsR";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9625F10F12B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMukoKP5WSKIAai4W2hxIji6CooyghLhiMoh0A6IT6s4zxt2eWd2Aifii1lBHbsAGiBJz9TEICstq5FQMJMg7B5maofyQ5GLvOQbTU5Ujf3L7wcu6scsAopR9tfncYE+sYacSQ9TrHqjuSPmJps5FDj8Xfp8d2TbBwfCJ+8AqjMmIp7qiNMv0JOz7zkUUlKb5RfVIqnceuVwVBrh3Qa23pt4icLe1MTXMzg/PId8Ce8uiNs5ZB1h86LHWSC+nlS5OSp3zoUOw8mBVSSels7ddNrVRkil5X7tW90ze32lZQTFV/BX3QPVzG/fLc+uAQAhQW4v3OkIP17VYb6Vss0TIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6ybfXKdinoLBaAw4TwXbNQCGc0KKZt6twqIf8OVO2g=;
 b=oVzSgLM8P3LmOq1ps+im8Y5t34FRTm3/+uhYeNqhPHkiaX5iF+E7BMB5Byeu6IgWgrqOQMbtdw38Q2KCgLLhpHxmUsgXPbpc5hQLasJFPzFJ0zFS6cygjYzUsz45nIUU2bV0enBOtQWJLNsnoNewPyETjTC96GKl1Ft4/T9RxIDNum4UdBlwXxsiMHwX/OyW4LjoK5BRzfR+XRr0dKHc9lBsywIUoCYF4HlD4AD1ARaT6msERf9nACRQGt7YEiKgSglsnac9OM9jYE7NAqXFKwEFnFXrXUfpDS565pL1BmyY9VQvzzfseCNvTWZROniiVJcitf8fg7x1p3VrhamTpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6ybfXKdinoLBaAw4TwXbNQCGc0KKZt6twqIf8OVO2g=;
 b=SOpE7tsRiCUU/OEJHLPCORrRtOiegwhO1IWMNWot3tBuE6d6eV/mjHoLMxelkMwjbeuLHwKwMcDhHNGsCOx3Hk29q9asWKtyzRRDKCrUH45r5jomXB/qI6ag39CmZzqW37cOey7TXg7Ka//byUY3wGlxbCLsLGU3edvo4RPFOUQ=
Received: from SA9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::34)
 by IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 19:34:22 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::45) by SA9P223CA0029.outlook.office365.com
 (2603:10b6:806:26::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Wed,
 23 Sep 2026 19:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 19:34:22 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 14:34:19 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v3 01/10] drm/amdgpu: use pm_runtime_resume_and_get
 amdgpu_gem_create_ioctl
Date: Wed, 23 Sep 2026 15:33:37 -0400
Message-ID: <20260923193346.2292597-2-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923193346.2292597-1-shahyan.soltani@amd.com>
References: <20260923193346.2292597-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: e94735ca-3154-4dee-c6ac-08df19a9ab42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wXnoZcV0ad36Rl5OIGOjveG4r3ueP/tUzLtyrMWsFrT/Alls49bov+9ZTU1hW4Z/jxgqu13gG8dw9nAU9d3buOqEH9batqUMxzsWd9L9CVY1uOeSK6dQBLoDNU700p1dJ+UjtaEbxq5mZ2DaybmHB24ojvqB4FB66A+rvFAdAKnx426qqEqw6X31aHMD0NP6oFMN/tdQsjFHC9Wu+QlpvLL0Kzo8VRqZC3v4ry1mvsLLVMiV+IJP6FkWTDdTYPEexxW4pN4mVlA5orCY3IdDUN5YtuA1ozNUxMFyrmVv1l61RHSi4/WRD8CUXMla1hPqtB5sS8z8rbHeeCUBUtwU6mJ5szq34ckhIYveDwgrwpO4DmjABHwHBTMunKpDeSO4MRcfwZodJGEoNFq7AdK39t7s5Ji6l7JAr8H/02JinSqstjtVrPZl3NIqCc/IeKqagma+ErtLSFVw48WLjcYXai/rmFss1A2Q54WQ3qPtd8s8KhWbU48e8IOurrsaxjpGjN3+MEwUlnPFh5mfEYF7QxmO9W1k+G/sDbliriYEjF3MMqihxaF4klO96TZWJl3reXfiwLTKK2BioobZSBDAzO6N+sXkyxovyU7y9kjwlt54VQeiWVU94mLF2BSTOkEbM3uKPPQkz7wbtwl0hKY9QUC6ASYvvVQPf/KNICPHCCiD/edAddnT8KFLtVHeE1FZ8ljEGvzfvMar+iRX+AWJ3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H0Gc3Av7BadxVpbmQLF6UNzMx+V7WDoUMbE26AFSAhdQkqjwsSE9w2bRCq4ZksYlMEUzEyJTdXwVHzLwl93cy+dHvjmKYdLidjWlkJY3TYRdYiVPPKq0lEyfxPcqzpnJ26VdRaKve/xyaGZ1gaKos7dxDMZhs92ECkMArOFlMYQHBNAFe2l1OWSwFuFwCPxF/di9PbEoEsGh/Di8/LnXRpoJmsi0SpCCRfkNb3a61NmLrimW8t2JJlllQYQ8FM9TATpPbtKNkKbUVNaBTgQGJ0/Moust6GhPQcJTd49oW0oHYRflNQEDQmq1jcZyt6XhMQPEjVIBovTr45SwF7Xg3KnwWCssmz5+WWFFc41l1kaBa7HzFQt5UjayQKSF481plrp0JykgYlnMvt9m8TK/q822FjjhEfrKHmi3+5fxDIXthlJ7asaYKYfz3fLna+AS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:34:22.2689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e94735ca-3154-4dee-c6ac-08df19a9ab42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698
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

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

This ioctl might trigger GPU work through ttm so make sure the GPU
is awake.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Co-developed-by: Shahyan Soltani <shahyan.soltani@amd.com>
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 0d579517c03c..4e4814caf61a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -33,6 +33,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-unwrap.h>
 #include <linux/uaccess.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_drv.h>
@@ -442,6 +443,12 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	uint32_t handle, initial_domain;
 	int r;
 
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
+
+	r = PM_RUNTIME_ACQUIRE_ERR(&lock);
+	if (r)
+		return r;
+
 	/* reject invalid gem flags */
 	if (flags & ~AMDGPU_GEM_CREATE_SETTABLE_MASK)
 		return -EINVAL;
-- 
2.55.0

