Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B13C25B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 17:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49AD810F66B;
	Tue, 28 May 2024 17:24:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s4VKasYA";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9460210F476
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 17:24:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTiaXMPABANbIwEhdctLOKcnoxbaSIbiHVzWSKqCstNMQkZZMBflxzbMpGY/4nhANfkPKFPsUQkX+lg3jLWZDBQiELH1cuq5sXu++3sWKgEBPHmRJGfK8w5kftWwvxDRWrIbB4N30WC/OfLm4BPfGSLBpJLb7MdbGsdCyvb7yqafcA/KmykBN0s4qyi7u9cMw2grqj7ym4vGKS6k6x5Hj/xAAJaPqMubpkLqh8Vp2yzIKcjBhFAX6gY5K4PSVFwxkpzdN1I1lZ06Hp8vOqNYWcS+IjYb6xjOa26yB4bzowf94oWJNfPU+SQhYLAJRGnqbFw+fBL+7qx1CEG5lrregw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tT9H/LmUp/2o1NfX2OOciBrp4KPho6jDG9dA6ySGZkE=;
 b=JD0MLdZ776W2PxMXYhj7mK7pDKn6lZNCaK9WwovjGYrpvpMi5I+ioopRLRiYl+EosAr/Lvk6hJvnRIztDMEc77y11kg9FB52VpRQ2gHa57WLs51Cglnqn+GkctxcQw4lcWt1J0GtT0AUCN7X7GuCBbi2ING6cEQMjdP5059ldtcuoU4FBore0kdvVcRmWoZ1mb/bitCB6GJYvrSLb9j4nl+CV17M+FC7BpfZHEKsDez9Ww/8T4FrKJkae0jap3l/zCzuM/IZQ/z4zpEZWEjyL3scgPYFzvT63CkYUGFv+MIfMJutXeW/WHdkyhqOUoyM8yRe6qcLrkghZ9cix5iXKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tT9H/LmUp/2o1NfX2OOciBrp4KPho6jDG9dA6ySGZkE=;
 b=s4VKasYAbj/YPfy1MNE6wBkchHV1ezJy2kvz+Y8oXkwHNzo2w0PzuRrqK7dI2r9mqLL1kho+QTby7b2a7jS1S7zcTbZTbkcMK9NhPKE6d/J3vqReySVf5XgxyZam79lVYFrEmFhm0nyUKOhSvcc6E+b1//jb0BD4Dr+aoBGS1To=
Received: from PH1PEPF000132E9.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::30)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 17:24:16 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH1PEPF000132E9.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Tue, 28 May 2024 17:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 17:24:16 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 12:24:11 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Likun.Gao@amd.com>, <Hawking.Zhang@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v2 05/10] drm/amd/amdgpu: remove unnecessary flush when enable
 gart
Date: Tue, 28 May 2024 13:23:35 -0400
Message-ID: <20240528172340.34517-6-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528172340.34517-1-Yunxiang.Li@amd.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 220e39ff-1a61-4f95-e02a-08dc7f3b0054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hWsanYU1mTWomdbl5Kc1CCV2DGLDGlkWRMphsmzAFH1j0BXMhEAJRA9nBjb6?=
 =?us-ascii?Q?31x8UXVylkcnFDYNbUOn/LP324vyByJALVuIRkR7bSzYTsD0YoLg05R1OVNk?=
 =?us-ascii?Q?r4BUTK6CDAPq/BFBmMGXbckXxNDBd8EhxavwMrjgGBThgqMGH5jLSC9YCrwn?=
 =?us-ascii?Q?F9lQNpRZjC6crhcyFvSi6ry9mjEP9uOBzJ/CCQHqMPcv3QoF0+Y4nlFuEQOH?=
 =?us-ascii?Q?Rd5Y4b+mITHrzxyqO58JmJ2Q7iWK8nlP+RsdAs7kEvRempqK+A5tLh33zAXV?=
 =?us-ascii?Q?nmnoulc0ql6jYqT4Ituz7oTMp29e9g4DqlKziCNfG4vzJbrEofpYyAVEIxIZ?=
 =?us-ascii?Q?OP54CQ1kIVniZV38Xev4nyx3MV7y7BY72h1HheaiQ/4fZ6jmSwo/e/3q5Eor?=
 =?us-ascii?Q?SK9Jyq/aT+4hCm5jG4+ZcIHS3NI6/QVJwlDG3e+dR+AFi1y5vecfNGHuEI9L?=
 =?us-ascii?Q?Rv8fvdsyFmtYPuQaJt3yyFvh0klXxKe2AeGY573eH11GC7bdJxq7ZOMX+vJV?=
 =?us-ascii?Q?W7tbNVR4mJC/3zYU/7vPS7CU4XlXMqPg1nkNebsKhjhfCMyXcgyRRNHu7KCr?=
 =?us-ascii?Q?1f7kM94EjGIunbfsqQEc0pqAzumiXyUQkFv78u6iwpMIR/bTiPe2fLxvnQhe?=
 =?us-ascii?Q?wpuiN6IBmS4YNb3Y6Lmdkhj0XuKgFty1+Jsof8Da7HLiKTqfwAS3+6YylJpv?=
 =?us-ascii?Q?d5+LC8rYaIeqyplBmqqV+do6ddLAeArccTwRe8xbeeJp/78SCmDaU8SQ9zpO?=
 =?us-ascii?Q?/7NJpcu9kBQZXFj1mXbsv24/B5ca0aPpqybyvXYyz/zWtboA5R5FpYkzPj5B?=
 =?us-ascii?Q?wqUvUuYLY8K/zl03Z3ETuJTqpoMkR/Xtjs5NRHEBlLcL6HmH8E0U1PXhzrSM?=
 =?us-ascii?Q?r7WXEyBlqCHYuQ5Ng2rZppW9I3FnXR1qohICyEaw6K67j6C4+8oAm4aTfK0G?=
 =?us-ascii?Q?EHEybDBTcrU4dgIt0YNtX6b/ipihDgPQRecPEK4nnQFdCuY5osvD8qAuXXgB?=
 =?us-ascii?Q?OMUIWN/eoj6HKzvIh2MHomU+EgE6y5XNgbQC4niP0lOHwrfJm0Va40L6vmEE?=
 =?us-ascii?Q?jHtAS3WRqAP+tmFBp+4qjcNt+71A6VKrnPap90iZ2T8lx81Iqj7UHkFcjh41?=
 =?us-ascii?Q?emfa3q8mhpW62YOsNpfKRWda3cv7uxdhmI+sK397KDipDABYSyDkoRU5GrH5?=
 =?us-ascii?Q?73TiE30O8ZjEEP1VfjERX1QH9pA9csAQ33UUK2uyML//HF7VCipjqhVMiT+o?=
 =?us-ascii?Q?douobgm44CGmkNwKyMBz7jGRz0k2Fehry9k26FkmFR862Uus4syoxuuwqyEZ?=
 =?us-ascii?Q?2Emtvjp1KGw+0mUhbsm8LXFCunvkiNb8QBFUqKaDSYBEyXUXmJA3YWQSJqh1?=
 =?us-ascii?Q?lNYRCHPehZqgUNF1ePLPrQkgXV0V?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 17:24:16.4190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 220e39ff-1a61-4f95-e02a-08dc7f3b0054
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710
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

From: Likun Gao <Likun.Gao@amd.com>

Remove hdp flush for gc v11/12 when enable gart.
Remove flush tlb for gc v10/11/12 when enable gart.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 4 ----
 5 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index aba0a51be960..5740f94e3e44 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4395,13 +4395,10 @@ static int gfx_v11_0_gfxhub_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	adev->hdp.funcs->flush_hdp(adev, NULL);
-
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
 
 	adev->gfxhub.funcs->set_fault_enable_default(adev, value);
-	amdgpu_gmc_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 1ef9de41d193..5048b6eef9da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3207,13 +3207,10 @@ static int gfx_v12_0_gfxhub_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	adev->hdp.funcs->flush_hdp(adev, NULL);
-
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
 
 	adev->gfxhub.funcs->set_fault_enable_default(adev, value);
-	amdgpu_gmc_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d933e19e0cf5..3e0ebe25a80f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -974,9 +974,6 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	if (!adev->in_s0ix)
 		adev->gfxhub.funcs->set_fault_enable_default(adev, value);
 	adev->mmhub.funcs->set_fault_enable_default(adev, value);
-	gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
-	if (!adev->in_s0ix)
-		gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
 
 	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned int)(adev->gmc.gart_size >> 20),
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 527dc917e049..cadbe55f0c8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -891,9 +891,6 @@ static int gmc_v11_0_gart_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	/* Flush HDP after it is initialized */
-	adev->hdp.funcs->flush_hdp(adev, NULL);
-
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index e2c6ec3cc4f3..a677aca69a06 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -861,14 +861,10 @@ static int gmc_v12_0_gart_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	/* Flush HDP after it is initialized */
-	adev->hdp.funcs->flush_hdp(adev, NULL);
-
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
 
 	adev->mmhub.funcs->set_fault_enable_default(adev, value);
-	gmc_v12_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
 
 	dev_info(adev->dev, "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned)(adev->gmc.gart_size >> 20),
-- 
2.34.1

