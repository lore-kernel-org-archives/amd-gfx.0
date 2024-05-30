Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A62C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 21:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D788C10F53C;
	Thu, 30 May 2024 21:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oWUbSP2p";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4712910F53C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 21:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpLzdchrKNNbk+2UYV12DE3cYUEA2jzKMOpp6+SuA3Aywcvyw1676ZUxrrzjBWoT9yfLPtIBm5YbIuZhhSk9Pt8b2m+jJuv3xwLKr1v7fuLvFIqtbW853WCJVaxN4sqJYYyndg1UJqk1HurugxFJiJ0XPxoA84KJerbW5xYyhm3rywCSf435F1bEkSV9VCXpfNeiFisBZ552RdYwFiuzcwRLK/2PSaHSeKkcydTUcyr76UNsEyn5JVook2yTznvZqTTX2CvahnQ2OAi8tenP2AOSkUexctKkNzC5UMrl0L6jP6r1RT/Qs1ijdqyN8D+TPYtvmuIxOenqMheKCtmo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBX6y4uOCTNMDGcOt3zNfVm9b+X8/qiJbMg2p/4n38c=;
 b=jX964iTCWpzlutOqq/YILq/W/MnAQyjmuHQDdyeGMnZ8ILOkYAsEg8WJFTVdkmzO9tPLqk2JXiab0eMtIsa6dc0CzmHFOLID2NKFAqB22EgwMUaVGkgNqCU8Q6ysCuLRQO0BZzFnNgs7O1tU4WfP/NbNZoKx413fJjAEoqtJ48vrZZkV6iPi6qTZkuK9nUeFI0xBOtah+KpfBuj8K9d7l2DPfuJeNruN+Z60424/MWoRkvFgPgQa1cif9QNvqOzms+AGq8W3wf7TGTXov1TgyaRboOx/Hn4muiNv7vQUOgY1I3y1Tksd2BVgD2gfkjCXBvzFoo3G49W4oVaDAZFULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBX6y4uOCTNMDGcOt3zNfVm9b+X8/qiJbMg2p/4n38c=;
 b=oWUbSP2pSkxPSkyrV8g91Uw5BmUUqzowLmdit0UuAOs8lIA+ZiDB+9qxtAuTAzML+3ZR9qMp/CAiak9iz6lwuiKdjgdgQ7zLoZApnFoAGdOhM8T6/43vVvOZroGUttSMvvkjkP+hpjav2A2Nw1qcxoSYryW8RdrfF2C3xsL6c2k=
Received: from SA0PR13CA0024.namprd13.prod.outlook.com (2603:10b6:806:130::29)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 21:48:31 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:130:cafe::1d) by SA0PR13CA0024.outlook.office365.com
 (2603:10b6:806:130::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Thu, 30 May 2024 21:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 21:48:30 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 16:48:27 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Likun Gao
 <Likun.Gao@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v3 4/8] drm/amd/amdgpu: remove unnecessary flush when enable
 gart
Date: Thu, 30 May 2024 17:48:01 -0400
Message-ID: <20240530214805.40970-5-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530214805.40970-1-Yunxiang.Li@amd.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240530214805.40970-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 11dd3c33-8b61-413f-6fe6-08dc80f23ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTdxWUxkeVN6NnhMa3FLZHUvT3p6QjBab3ByWm1WRStMK2Vlb2xHNmRSM0Fu?=
 =?utf-8?B?cGtiU2ZucmsvSnNXLy9jSzF6cWZveHZaL2czb3lVcUFLNEUxdVVrNnU4OXhh?=
 =?utf-8?B?dDRIaXhLKzJQZVJIQmlvbUJzWTY1R1ZIdWNmV0J5U3JDQjBIcnd3YW5FWUNH?=
 =?utf-8?B?SWRwMEVwOU5ET1lRNngyRHgyMDJjbzh4dFB0dmJ1WTQxVUhwOEJDR3ZKekNI?=
 =?utf-8?B?dEIvZG9pcW1mQURrTUlLSjZVSHBNNW4wcDlURVRvVXZwcTA5WDJqQkZEakpX?=
 =?utf-8?B?N1NKS0V2bllHOUM3Q2cvVFg3Mkxyc3FCakxCTm94aU5zNFozcERBamRZM09y?=
 =?utf-8?B?d2xiVC92ejBzSlR4M3QrY1huYk1WRk14YnVmd3djWmduVkNMMzcyWENIV1Ry?=
 =?utf-8?B?MFhPbU5NdHdGRGl0WGRYcHpEMTF1dEkzMS9QSElkMWJ3UUNmeGdsTGdvY0I2?=
 =?utf-8?B?c2huRk5SUDdIaWhla2xIdDhlYTVhVTlGZkhDdG1uMlZzK282eStHb1JFR0E1?=
 =?utf-8?B?Q2M1Tk9IWGhlbmw0bzh0bjNCZzI0NGF3L3J1ZUR3Wktrd2xDNjN1Z3B2bG4x?=
 =?utf-8?B?SjBRVnNuVTRTbFgydzRWdFFBWTJxTGRoUTdDdHRjZWprK0J0T2ptQ1V4bFB4?=
 =?utf-8?B?aDN3OUJ6OGdjK00wbG8zTjZ5aXVNU1ZLMXdpeDFZdXNoelFkWnRNZGNkSHNk?=
 =?utf-8?B?Rk0vUUNMRkpwQU5XckhtTTF5WkFyeXVvbjRUazVsaWFxa2ZGeUg3Ni9FeHVr?=
 =?utf-8?B?VHE3bXZWNDFJRFpheXorbWJKaTVzYnpKWllidjRBZUxwYk03N2RjNG5DMUoz?=
 =?utf-8?B?bk9IeDg0c3JZNFhlWVBlTURNeG5FVkRhMXVsUzFXdUszaWRsTzJpeDQrc1FQ?=
 =?utf-8?B?amoyelBZSklWRHBYc05RTHdqQnR3c3NyWERKaVM5SEhlV3ltVzhzbjJvY2RK?=
 =?utf-8?B?QS9lUmVaL0hpa2dDUmZ5THRrLzA2cW4rbDd5UERVVEI5UGxBKyt0ZGttVEdI?=
 =?utf-8?B?UXFvdWhpT3haOFI4b3BOVWcxOCtnTmZmaTI4YTJaYnVSYmZHUmlId0pKbGdJ?=
 =?utf-8?B?TXVtd1JKY0FnWk9ncmk1Tmp1bDFaQ29hbjJ1OUo0dlBJZ0xQRTZ2Wm5PZ1lj?=
 =?utf-8?B?UkFVYXAvaUlVakdKOHVLKzFTWGdzNVJHL25FNlVBTkZaSVRnSnpuVjlhb2RN?=
 =?utf-8?B?ald3eTl6U1VQemp5SFNVYjZCUlJmbHdzODJhK3VqMGczekt5YjI3R3ZuYUo2?=
 =?utf-8?B?Mjh6N0RST29JMGFOa3NyNVZZOHNCVGVZV0xZVzQ1TWNXQkZoS1lKbnBwUTMx?=
 =?utf-8?B?RFlrRTlaRHg3ZU1jdVBFdHJGdTFVbithZWRTQ0FxMjhPS0JSRytseC9sWlVk?=
 =?utf-8?B?bS9iSmVsVUlpdkxwNXFBbjFiTGRRdjRrOTJlRFd6akVxSmZ5dGlicnNMU3Vj?=
 =?utf-8?B?Q3djYWdjcWFtR1kvdTlPMHNaN0J1WVNxMkEzdXJhTTl1a3hlV2dWWXluLzh2?=
 =?utf-8?B?WS96Rk9JQjZNdHJMS2ptK0pObjJMY2ZZNWZQdmhBM1B6ZU5EUmhMZkJCYS9X?=
 =?utf-8?B?TVBBbE9mNjh3aE1JQUluSFRRcGhFL1daSlZkWC9zV1lNSGpGVjg3aVRvTXdZ?=
 =?utf-8?B?Z0ZoazdTWkVhS1k1d3JGUWIvakg1MCtjY3lFbnlDK0FrVlROSkNMSk42Vjh3?=
 =?utf-8?B?czk0Z3NMVjJkdkVja01pc1h3dEVlbmxmSFhvVDdCVzhZSXcrcnYwK1l2UmFC?=
 =?utf-8?B?R2lSOW00KzJDUFB5L01CeTVzMEd1Q3pGazkreXFkdVIxaXRwN0V1YWNLNHRL?=
 =?utf-8?B?bUhaOVZEM29lV1NrUGxZdERuTXJXcFh3R1BFOVVtQ01reS9vYWZDRDFBcFFh?=
 =?utf-8?Q?JXg7vyqhIGEUT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:48:30.5830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dd3c33-8b61-413f-6fe6-08dc80f23ef7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
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
The flush is done for each GART mapping when it is created.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
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

