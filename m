Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0757FD875E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 12:26:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81D5710E4DE;
	Tue, 17 Mar 2026 12:26:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uSrZRiJF";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013054.outbound.protection.outlook.com
 [40.93.196.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE9410E581
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 12:26:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ao9LG7Ojb2qcEKswkDekByhM4iq36+xklBrTdIyX9Xd6zigekuuebYA/xDuNdBFilPmnWACb79VG+5zfF/TdrnI37VUQJt8/l9dPqFdTK7+mVeFbVkBdtWzGreDWEwLBpOpdv04BF41PjYjbwsOO2Iclgvr9i/WQcP5LuOLH8TgQMX/FJc8g5FCyjDXvNBQCLgdDSSO0ttf0BdPsvr0eLocH/Qe3NdCGrrvzuM4JcVfq0mS4tIUfPYBJtTxl/cnkmDwbzxJe4rWC2Udsfk8qK5kSrznScw/7OhY4kDlzVLgjHB0nRgj3OQC34YSbLxHZNngrxov1VZg4V4bNlV+IGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hvot0kMzbtlAVY6943UzE3l6NKloqMKFHEbiCZ+ThGQ=;
 b=bX/d3k2D3Gl0AZmRT8QzXUOZRjPXOQWIms0lDGc7HzmCc5knxPMN8Ue/mcDZ5mOENigOZHK7ZfvSbWwWbMTeMqKBQ6n8lYT+G5zw/AKLXkvbpaE7A/jnLd5RyEtuPKz1UMXPuK9a+UVptGInRB1BvXsYDev+lXIwyCzWZGM/qkhnCGpOvaOr0hPPtgK7Ka98N653bCcwPkE6JP8Xky7kqvCqelgaX9PYHWd4BYI1X1dfvkc86akFFM7lHf3cXevoAFlTtOerJfrkGFdNsbej01V+6njdThhmWZo37RdyUlAt9y3v9ga/r85JJoKQU3/f9XJ91gJxmniGcB/VbhPZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hvot0kMzbtlAVY6943UzE3l6NKloqMKFHEbiCZ+ThGQ=;
 b=uSrZRiJFDfgo/g4uKZ/75/ie5ABnGxmC+Nyjc0wHPpoU9oRarejyMyNIacc+Eq2/6kw7m7dD4FMpZaTTZYrPA0dDFHJ+Jgs871MGYy1zo3klRiqn4gp8W+XW9Yyan4SbNaWbuAv+J69Vy7jh3jHHVDBl7416AJGUahY9psQlTQ0=
Received: from DS7P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::14) by
 DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Tue, 17 Mar 2026 12:25:55 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::7d) by DS7P220CA0007.outlook.office365.com
 (2603:10b6:8:1ca::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 12:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 12:25:54 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 07:25:53 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: Add client ids for mmhub v3.x
Date: Tue, 17 Mar 2026 17:55:27 +0530
Message-ID: <20260317122529.361748-3-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 769d1748-f9e0-4505-4154-08de842055f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: t/OjuqODM/Aia22qEUG9dQH4lXUavABtSbTVpAfpIdvNppmOId6QEyjIPB5YmtABVhs/8uRcmnqFUFj0a/AuqEY/GY2GwKMAMcJS5KOaHQ0+RjzX/8U66+Sy6PIsEWEJP+sPOYdMO4MZP6IojeFaRAdjdQomizyACPL0VRs3RAhP9wxnS5c/Y0Khk52eBckpI3Y6wD83ma2Htht/xDeeRSA4+/vPKUMuSG7zqEn0DTdSThWtxTff/zU2vJy4KX1ch5MLRGdAzdWIH9X6JYJ84RMYQRFqkqd6tk9syXf2wyG+BjQ4yujLA8Xpu9qyEG03w6w6yRbwGOKcREIih1whQ059FSs8obQ0n5jbHt5xr/VNFtMr+ZqZ0KimWWRRwDMUrhXCkp7J1aCw6oM8HDLyUUv4pr2WUu0zmQUvhzNOEwmUaIMTY4ypUszaDX9Q3hn+7A8cxbm6AvG0fAXceFzm9VKg5sqTWu3EYWRY67c3uffUvVT7v27jG6dzJDteN6CTZTpy03EXNEMPUWJdFE0BUFV+zA74a/aHOB4/6coTiqzofQ1k+iGjX7G/LAhZk7EfPEukIzl6BXgWDrXR1UDaGvE3ddX2edoBks79SK0XZySjLcaggEHVTWqbXUb+k0kZckiV/H4AOXitMdZJMTuR+CrZTyKgWuJ6ZdsrcLMqtspVP2WlLM2NAd+Ld8iNtduufCt+8lgb6cHggEezOIrNJOOIa6sJe/e0GV/t2nTuw1pW1HiQ/hwVrbRKyN0r7ig6+3kCqAC73LiguExpuqOfZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gSGwze3OOC5B80WJuya2vMo7DHASsIB73pVGJgNoD0hlOisDh3VfT8D9/6MuArVwme8WVB87hC7RL7mhb3u967PqCmpqjqzNIv7e26d66hfbLZ4FoP2huIK1g3PvxW6Hohlb5Z98zrG02vAm/z3EG31ri0yQKzT8TiF4T9qEHtQou1CIxwxmrcQtgcWbXws4cVST0yyuMhjV9SxdP/nVwFcvlvFuhsnZrmxQAhkNOWSGq0gZGDe6UnTGKxkpOIduVrnykzFfRNWFHl5Dizh0i8BiqB62xolMyfBCTDTE90yL2Pw6kAaRQUOpIvatfnsZyk9dcw8HFRD2130puLE/nRhNwShd4YEjVWE+5n3RzYJpDUHDl/dAQeXl0ysZbEQsdWkPHQ00SL/aixVF5H7NS0nZlqfzAS32rht03rY4TdMcSh/yVLPEJe+sX2AXFNPe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 12:25:54.8367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 769d1748-f9e0-4505-4154-08de842055f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780
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

Initialize client ids for mmhub v3.x

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c   | 16 +++----
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c | 17 +++----
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c |  9 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c   | 55 +++++++++++++----------
 4 files changed, 49 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index 7d5242df58a5..3d82cfa0f1b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -97,7 +97,7 @@ mmhub_v3_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 					     uint32_t status)
 {
 	uint32_t cid, rw;
-	const char *mmhub_cid = NULL;
+	const char *mmhub_cid;
 
 	cid = REG_GET_FIELD(status,
 			    MMVM_L2_PROTECTION_FAULT_STATUS, CID);
@@ -107,15 +107,7 @@ mmhub_v3_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	dev_err(adev->dev,
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
-	case IP_VERSION(3, 0, 0):
-	case IP_VERSION(3, 0, 1):
-		mmhub_cid = mmhub_client_ids_v3_0_0[cid][rw];
-		break;
-	default:
-		mmhub_cid = NULL;
-		break;
-	}
+	mmhub_cid = amdgpu_mmhub_client_name(&adev->mmhub, cid, rw);
 	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
 	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
@@ -520,6 +512,10 @@ static void mmhub_v3_0_init(struct amdgpu_device *adev)
 		SOC15_REG_OFFSET(MMHUB, 0, regMMVM_CONTEXTS_DISABLE);
 
 	hub->vmhub_funcs = &mmhub_v3_0_vmhub_funcs;
+
+	amdgpu_mmhub_init_client_info(&adev->mmhub,
+				     mmhub_client_ids_v3_0_0,
+				     ARRAY_SIZE(mmhub_client_ids_v3_0_0));
 }
 
 static u64 mmhub_v3_0_get_fb_location(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index 910337dc28d1..a1b0b7b39a42 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -104,7 +104,7 @@ mmhub_v3_0_1_print_l2_protection_fault_status(struct amdgpu_device *adev,
 					      uint32_t status)
 {
 	uint32_t cid, rw;
-	const char *mmhub_cid = NULL;
+	const char *mmhub_cid;
 
 	cid = REG_GET_FIELD(status,
 			    MMVM_L2_PROTECTION_FAULT_STATUS, CID);
@@ -114,16 +114,7 @@ mmhub_v3_0_1_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	dev_err(adev->dev,
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-
-	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
-	case IP_VERSION(3, 0, 1):
-		mmhub_cid = mmhub_client_ids_v3_0_1[cid][rw];
-		break;
-	default:
-		mmhub_cid = NULL;
-		break;
-	}
-
+	mmhub_cid = amdgpu_mmhub_client_name(&adev->mmhub, cid, rw);
 	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
 	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
@@ -503,6 +494,10 @@ static void mmhub_v3_0_1_init(struct amdgpu_device *adev)
 		MMVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
 
 	hub->vmhub_funcs = &mmhub_v3_0_1_vmhub_funcs;
+
+	amdgpu_mmhub_init_client_info(&adev->mmhub,
+				     mmhub_client_ids_v3_0_1,
+				     ARRAY_SIZE(mmhub_client_ids_v3_0_1));
 }
 
 static u64 mmhub_v3_0_1_get_fb_location(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
index f0f182f033b9..34e8dbd47c0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -97,7 +97,7 @@ mmhub_v3_0_2_print_l2_protection_fault_status(struct amdgpu_device *adev,
 					     uint32_t status)
 {
 	uint32_t cid, rw;
-	const char *mmhub_cid = NULL;
+	const char *mmhub_cid;
 
 	cid = REG_GET_FIELD(status,
 			    MMVM_L2_PROTECTION_FAULT_STATUS, CID);
@@ -107,8 +107,7 @@ mmhub_v3_0_2_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	dev_err(adev->dev,
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-
-	mmhub_cid = mmhub_client_ids_v3_0_2[cid][rw];
+	mmhub_cid = amdgpu_mmhub_client_name(&adev->mmhub, cid, rw);
 	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
 	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
@@ -509,6 +508,10 @@ static void mmhub_v3_0_2_init(struct amdgpu_device *adev)
 		SOC15_REG_OFFSET(MMHUB, 0, regMMVM_L2_BANK_SELECT_RESERVED_CID2);
 
 	hub->vmhub_funcs = &mmhub_v3_0_2_vmhub_funcs;
+
+	amdgpu_mmhub_init_client_info(&adev->mmhub,
+				     mmhub_client_ids_v3_0_2,
+				     ARRAY_SIZE(mmhub_client_ids_v3_0_2));
 }
 
 static u64 mmhub_v3_0_2_get_fb_location(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index daf1f8ad4cca..cfce7e1297d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -217,7 +217,7 @@ mmhub_v3_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 					      uint32_t status)
 {
 	uint32_t cid, rw;
-	const char *mmhub_cid = NULL;
+	const char *mmhub_cid;
 
 	cid = REG_GET_FIELD(status,
 			    MMVM_L2_PROTECTION_FAULT_STATUS, CID);
@@ -227,29 +227,10 @@ mmhub_v3_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	dev_err(adev->dev,
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-
-	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
-	case IP_VERSION(3, 3, 0):
-	case IP_VERSION(3, 3, 2):
-		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v3_3) ?
-			    mmhub_client_ids_v3_3[cid][rw] :
-			    cid == 0x140 ? "UMSCH" : NULL;
-		break;
-	case IP_VERSION(3, 3, 1):
-		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v3_3_1) ?
-			    mmhub_client_ids_v3_3_1[cid][rw] :
-			    cid == 0x140 ? "UMSCH" : NULL;
-		break;
-	case IP_VERSION(3, 4, 0):
-		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v3_4) ?
-			mmhub_client_ids_v3_4[cid][rw] :
-		cid == 0x140 ? "UMSCH" : NULL;
-		break;
-	default:
-		mmhub_cid = NULL;
-		break;
-	}
-
+	if (cid == 0x140)
+		mmhub_cid = "UMSCH";
+	else
+		mmhub_cid = amdgpu_mmhub_client_name(&adev->mmhub, cid, rw);
 	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
 	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
@@ -640,6 +621,30 @@ static const struct amdgpu_vmhub_funcs mmhub_v3_3_vmhub_funcs = {
 	.get_invalidate_req = mmhub_v3_3_get_invalidate_req,
 };
 
+static void mmhub_v3_3_init_client_info(struct amdgpu_device *adev)
+{
+	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
+	case IP_VERSION(3, 3, 0):
+	case IP_VERSION(3, 3, 2):
+		amdgpu_mmhub_init_client_info(&adev->mmhub,
+					     mmhub_client_ids_v3_3,
+					     ARRAY_SIZE(mmhub_client_ids_v3_3));
+		break;
+	case IP_VERSION(3, 3, 1):
+		amdgpu_mmhub_init_client_info(&adev->mmhub,
+					     mmhub_client_ids_v3_3_1,
+					     ARRAY_SIZE(mmhub_client_ids_v3_3_1));
+		break;
+	case IP_VERSION(3, 4, 0):
+		amdgpu_mmhub_init_client_info(&adev->mmhub,
+					     mmhub_client_ids_v3_4,
+					     ARRAY_SIZE(mmhub_client_ids_v3_4));
+		break;
+	default:
+		break;
+	}
+}
+
 static void mmhub_v3_3_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
@@ -680,6 +685,8 @@ static void mmhub_v3_3_init(struct amdgpu_device *adev)
 		MMVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
 
 	hub->vmhub_funcs = &mmhub_v3_3_vmhub_funcs;
+
+	mmhub_v3_3_init_client_info(adev);
 }
 
 static u64 mmhub_v3_3_get_fb_location(struct amdgpu_device *adev)
-- 
2.49.0

