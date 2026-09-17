Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABA9C982D0
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 19:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 057DC10F08A;
	Thu, 17 Sep 2026 19:58:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i4NmoGCQ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013066.outbound.protection.outlook.com
 [40.107.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A7A010F08A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 19:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2IuzYmt3fzNP1EQmJXss+0qgAZ3CtpE2Q/NlgdI293+xbkq6i3nqKJdEANYe9fHiCJxVkd3Pdm6mjzJslKeCE9ffIl0aRr465NoAkE4NiN2S/oIrXKLrbObOXO4cQenZ8VtuOoI5Xqg2uhuAC/8ldsIMoiuT2GIaH0m35eJhegu2AYND6IxB+e2nKX70ViseSNSq2c/unB075UC9OdJgFQYw/bmnPggSxsGj9Ml5NJPaktQVSXTgyYZX4WlFb3swOOG3hsDIpRg9qI5mQzkrjVBr5R+zv+K4Tzz0iGtJSomFGobD2xNCXJIF+h7AvmTUTNjiR9sE7kARt/HJwM61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nx9iksCbBfVHrA68pt3hsbMxsHiBrDNL3w/u4m5ecVo=;
 b=KLIQfJFnGnwoECt/jREYgx9abTFfozU91aY4dEDo9dOu4X7TNrELstF38VBrX+bKOF2xbHeI8X6vESusgmDFyuBGCXSBkq2/69IXCgW/+IFXrIhJVxjPQXPC7pbwgIqUj4AAaGtj6z4KY54YQCO5+k6V+Z30xP9hHjl52rMSAmIcCZii9hFUIeUSzkUkpEFHmXytFoXYYX495bl86Ci4q5hvmg65G1Y7tP+LTgF+qyJUMETYBw2qZfXTdCtY6Wql0lBAtl/gkyl3JfdLSl4hWshvgY8EXU03q/3u0Oe3nrqw3FMYqDydGLXsEkp6X4n4YGHXPLYohu7tWBYBtbvVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nx9iksCbBfVHrA68pt3hsbMxsHiBrDNL3w/u4m5ecVo=;
 b=i4NmoGCQN9uKLaFoUBq6DJ2cXwQKpq1EfYYtGy9jLTPYKyAM20ntjmOKSGi1CAngTSLEvS9xm+78Jvr16kKr0CO1nZkDT1RplQjYpLSzbFAyuIwkaIymvQ/byGaRhw7yU0q9Pz/TJzlNnJy1wa2BOlNFHIhmg3POkbr+AN1FKgI=
Received: from MN0PR04CA0014.namprd04.prod.outlook.com (2603:10b6:208:52d::20)
 by IA4PR12MB957498.namprd12.prod.outlook.com (2603:10b6:207:100::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 19:58:25 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::42) by MN0PR04CA0014.outlook.office365.com
 (2603:10b6:208:52d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 19:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 19:58:25 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 14:58:22 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v2 1/8] drm/amdgpu: use pm_runtime_resume_and_get
 amdgpu_gem_create_ioctl
Date: Thu, 17 Sep 2026 15:58:02 -0400
Message-ID: <20260917195812.72917-2-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917195812.72917-1-shahyan.soltani@amd.com>
References: <20260917195812.72917-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|IA4PR12MB957498:EE_
X-MS-Office365-Filtering-Correlation-Id: 39776525-227b-4f2c-a7a5-08df14f608f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|10067099003|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VBPDd5SUnnaVRCXl1CzKY5P/U+CfFu0Sc/6yqp9swKt95QlK/zOfn4nXDbDrEqPF4lvbzt5M2MKI4lPih334ngrBiCwGN+bjvuH11WqFhmwe5bJiPHltUAX3d1u4twNirbrijcmcZFHGXbu2WT7caESLwcmwAc4Z3PmrHd387iov0PTVSEQOcTZsNtYDD3uQM83AGe0OLgOOVOwKQbpHraLBKi85piMC914rchLU08Oq+15YZT4R3SeUswlkS9j9nvNb9iylMhHlXGp9ODTe9OrexDxOR6RI2CNv9y0+o6/+HbvAzTf3Z/y2dnplUhccWZdI0VZ2IfD6XPKVUhrxfOcE+rHyxu1eKYPKjWy1KGFoLEfB5oR8OAaUOAupf8K8vMcYUGRcRhNTvmfhvYhksmp4B/4zDWtBa+HkblpZOIjlqOFXkkDcs3bnmKJE1nL4kXrc8iN0xeYWn/mL87a7Ag8ZEefN9gg77wgnQ/fQmaUw8/xfLl2qMlKnBbdadL6LJ8sYL3CkjZ6RkdSff2BFtw8kDyykhIBw3eG7Qsl4Hs35Cv+UZBLFhxo+HvWGScR3pSp35aErV42z9B3+n0XZ3LKV0j150KVc6UspPxu/mKkF1ydplOp4r1X2Iai6D7hvoX8IxAwBxikzLTM04IEMB9o2iNG/e7kGxWTy9YiqTXwZ45EHfY+0vIAWxdOyiIeUDVIPX4gYFeb392L1b0125A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: prqYKxvN8hKdvz1GvdaVDu+VxGj7HWX0jt68TClRj9WbhYq6O6xFAGNvVGoEbRiFbB+0x70RbMPv8JlvrKI2/uNokjGk04r8PaQbCmzHV54t00TuopLe8MWmnHCgcMudCOZ8WRbnMJyviGwq8ZEe/XWwLipxKz24mpKnWq6oerN9tQg/PD3cwkGomlRL5j5VwI2zY15/uQuqoE0F6DnLr/k9d125dT55fyMObCV+Jbgs+daiChLoQyRv+5DaHVp8ZHW95N6W6sKasj0w7FxqJNJNKBn3vmQdt5ByDuz5NRFPWK1LSj5HNt2BqqScCTONMzESZivZ4KmkCsn4953uxEF3Jfs/6ZL3wemH15D+ZyvFk495pFJnMYhFh7pNdWTB588/VPBPOtVpCWyVJVR4SzmLU6bYFPZGluJLWREAL8b6E/+Uy3qSSvxcs20wapO0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 19:58:25.3379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39776525-227b-4f2c-a7a5-08df14f608f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB957498
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

