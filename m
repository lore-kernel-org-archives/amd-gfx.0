Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3988FD875D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 12:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E72E10E353;
	Tue, 17 Mar 2026 12:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fAZcRhPm";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9333C10E351
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 12:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LN1Hfw6Ghj9AzuENGcd087ZPfwlEJBNfqgpsV8LmP8EXAo4eMVu+9EFo+F0nxFCqRFQekoKm6cwXejyUfjsA2DaAkUb3MUTURPEvgh3w4nXPktFIF0xKwVJS7K0DHGF/eNdg+sucf+k/ZxDijGGpaaNXEattCRhr1T2INSBLhxSRirkcKiwzTZhdf8+zw9bBJd+fXcP24K0Ox9RtYqym/OhgwYIDvaWIR/dREexEwEPMe1dYRagY9qlwP7OwSr5e3i/5VMyAuBtGx5v7aWGry+PDs15RWkSIuNT4iwqBHIWQqVLRk66T1OlzUdfwBbrTOaCeIrGEbLiL90FGzoBaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfFs8Vqka9iZO17iZ0uTL75GtGrdRzEW1FCEtO+GT9o=;
 b=FSQozR37zc6rJPDav6DXg4rl0ktNScPPjpQfQTZbahXo7iJMgwnhDq5+SSh54J87i84phi4FV7r44aKBxRz/JXm5igf0RESGNK5EfRarVnVaxf2XOndIgI4KFlQtzAUsHiadss+UkPEk4o2ZZxUllolP6QSS+6tZ4VNWG1oRHvQTIEYjY1Mzwhpk/EHbEpII24J5t7RLpnuZ8ayztLr5Mo32TPIrHVnP3GnuqMmKO5K3yPijR49+pcdffnskVWYd9TWKmzH+REnYmcPOu07hIVx/7bcmJppgLhk+qzhJM/S5GeiziddWAy2HUnAay4Y0mM7oY+b6Low1hQKyBzTrDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfFs8Vqka9iZO17iZ0uTL75GtGrdRzEW1FCEtO+GT9o=;
 b=fAZcRhPmCxTmWvbQgvhGNhyk3iSNV4yJPRu/mqhw0y3eioBBDNhxGRnqY95T6/qSMHyXv002iqTPJphPRuClfKTeJLc/BEdxY6fb8voQTrLmC4OJZ0PBz/VZdNIe1Zc6ju2Xfzzq1s7I1P/wt2ui7LtgqFMFUydPl+AYSIh2AcQ=
Received: from PH8P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::20)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 12:25:54 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::2a) by PH8P223CA0010.outlook.office365.com
 (2603:10b6:510:2db::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 12:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 12:25:53 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 07:25:51 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: Add client ids for mmhub v4.x
Date: Tue, 17 Mar 2026 17:55:26 +0530
Message-ID: <20260317122529.361748-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260317122529.361748-1-lijo.lazar@amd.com>
References: <20260317122529.361748-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d76f061-eea6-44fe-82a3-08de8420553b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: P6jt0o44f80n7dUnP53RDeWPvWqqB9a3CzFC6ZbCQhCPhFDRyDOSYeYtw9mdKH0LzA4V2UyCcSDPJvt+Kt7HfhGh4N62sOOeCLNB7HTbVnpMybJxee/cafkj2QFer9ZcLsbRoSTCiZL4bxet1pYZ/J0i5kETr6XVxxDmrnntV/04DVX/wYp8s7hOiHMod9fttLdBpKVRxNTLihaRQIAfbz8EKvvrnr3npqT0SkY0TfrwfXeFTYeuXAI8nFkh4+81l7fAizfjBZtGKOeI/VgW48PgJATF893UbAKuHNGRJUI4q/zFPOpJ/sqawhjYqWAUzV3yY6Px2GX3Ul3dJGg0G94VUpEoKGzFnGe6Dvp0eCSLmf1Op0PYGdaX1Pb4q3MVImYCnlr+JL3YC6/HjMgsueW8Syz4OScpGALYg+nyPPio07APlDns18EUJQNcYUknG/42pijMCxzY7p3o7TSAxygeoI945hktwkSz37MhWxrZ40mY2Ojp5cV/mI12uvORrq+LLXTuXsrr308lkDTosicExczlzg3bShfxrolh/i2tJDyg/8UFCLwR2ER15iTUoKf7iG/yd9zhT5iyamThXa5Zq7LRWUMwStWpEKxfc3CYjYfbK+a/RHr8V2EnXYPnnl1PNzwssXXpZWdmlEZr0bfQ3PEk9gddo08jD+dkcWFRO75PziOOw0rfUofuR5hW14AbVzQ5aecC8IYNPaBw5CVv3AwTEqJNGZg9qM7F8xVUlYtfIyGupSYV9isVlgdcnX/sRroCkeCHJ8vG7pXMJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xbZCEBBdGT6k3+nBUbNaMF2Uvj1VrDG6pgnvY+pN92f8UhGdiVWOTay8zNQd54OHhNx4Nfw55RI4AOBVuHWBRO+VyIn+GrcRziQRW9LG91NWhZUI4RJpmq6/2ExlZba5Q+2stMsw9ocUjOe19us2sSI/7bwrBQ1lbbc93Ji6yewnj9ttztm0KA9VUWp4bfGEdJ4snbcM7mWWpx5rsSGbK9OntY+dXjpoXtCetGC3cjAmFFQuSeTlfwifBkrKATN+MA9nX41IkTXA65RdxyTUrRiWM3RWXw1PxzNFsffP6qyg5pJciXttDdS31BOH5z/T9iWfYpSkCoerZtlOpVtkyUr4qyQumNnBbiJ3CLmKcPHmeJ3qcB7lZO8B5CF+cr+Fj06ovZk7HkxvzktUOBkqh+rzGI7ncwjcHRlIiiofMY/tO0DVl3eJBaHsArFLhEc2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 12:25:53.6066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d76f061-eea6-44fe-82a3-08de8420553b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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

Initialize client ids for mmhub v4.x

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c | 15 ++++++---------
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 15 ++++++---------
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
index 951998454b25..bef75c4c48d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
@@ -90,7 +90,7 @@ mmhub_v4_1_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 					      uint32_t status)
 {
 	uint32_t cid, rw;
-	const char *mmhub_cid = NULL;
+	const char *mmhub_cid;
 
 	cid = REG_GET_FIELD(status,
 			    MMVM_L2_PROTECTION_FAULT_STATUS_LO32, CID);
@@ -100,14 +100,7 @@ mmhub_v4_1_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	dev_err(adev->dev,
 		"MMVM_L2_PROTECTION_FAULT_STATUS_LO32:0x%08X\n",
 		status);
-	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
-	case IP_VERSION(4, 1, 0):
-		mmhub_cid = mmhub_client_ids_v4_1_0[cid][rw];
-		break;
-	default:
-		mmhub_cid = NULL;
-		break;
-	}
+	mmhub_cid = amdgpu_mmhub_client_name(&adev->mmhub, cid, rw);
 	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
 	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
@@ -514,6 +507,10 @@ static void mmhub_v4_1_0_init(struct amdgpu_device *adev)
 		SOC15_REG_OFFSET(MMHUB, 0, regMMVM_CONTEXTS_DISABLE);
 
 	hub->vmhub_funcs = &mmhub_v4_1_0_vmhub_funcs;
+
+	amdgpu_mmhub_init_client_info(&adev->mmhub,
+				     mmhub_client_ids_v4_1_0,
+				     ARRAY_SIZE(mmhub_client_ids_v4_1_0));
 }
 
 static u64 mmhub_v4_1_0_get_fb_location(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index 97a00075aa7a..29f7ed466858 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -716,7 +716,7 @@ mmhub_v4_2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 					      uint32_t status)
 {
 	uint32_t cid, rw;
-	const char *mmhub_cid = NULL;
+	const char *mmhub_cid;
 
 	cid = REG_GET_FIELD(status,
 			    MMVM_L2_PROTECTION_FAULT_STATUS_LO32, CID);
@@ -726,14 +726,7 @@ mmhub_v4_2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	dev_err(adev->dev,
 		"MMVM_L2_PROTECTION_FAULT_STATUS_LO32:0x%08X\n",
 		status);
-	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
-	case IP_VERSION(4, 2, 0):
-		mmhub_cid = mmhub_client_ids_v4_2_0[cid][rw];
-		break;
-	default:
-		mmhub_cid = NULL;
-		break;
-	}
+	mmhub_cid = amdgpu_mmhub_client_name(&adev->mmhub, cid, rw);
 	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
 	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
@@ -824,6 +817,10 @@ static void mmhub_v4_2_0_init(struct amdgpu_device *adev)
 
 	mid_mask = adev->aid_mask;
 	mmhub_v4_2_0_mid_init(adev, mid_mask);
+
+	amdgpu_mmhub_init_client_info(&adev->mmhub,
+				     mmhub_client_ids_v4_2_0,
+				     ARRAY_SIZE(mmhub_client_ids_v4_2_0));
 }
 
 static void
-- 
2.49.0

