Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBCBFD875A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 12:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CDE210E581;
	Tue, 17 Mar 2026 12:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SismgTPO";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E826610E581
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 12:26:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vU/qB09xUzDp1pxelKKMtxT0g5hUnX+lkmkOTVU324JPfbKPVILKE26ZbkwHR5EHUVtXPZDZ471XLMRwy52Mw+RXjoNq84tndIBSv63ygT7f5Fvwgt4PTFOVLqw32Ho0pKE49eh0qu9xZe/8RZghW63/uezDTr9VOks4I6V59br0ir8h5cyrlWg+D7WaEloOHDQGAk5rVaHKhwGm6amMxNI93+hOiBfFI1Okl/Ukv0oz66AS+plE0TVpddYr94/4mLV+P+nFFNOyW+XZgaq9GlE9diiXSfcSOrs4veJGjFMlzXERPbK1dT6b2jDD/4HbYhjs2A+Rv5yUH3Oc/gUpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1vdFDunE1W/z/Lhu7QzUoWe/JG3q7WPWyLbbIPH1WM=;
 b=giRUQ+TCow3vQ8fq2IMGXyXvqtqsV90sm8JwDmrYAkebi2uHstAb+N2j5tkKDdMWZBsqerrMS6A+3GWt8IfOSyWFpOFt1XXMmddEltp8leo+r8eW9nSaOsd1myYa7nyiFI3mGOI74iXJG/qZxKoHmjUo34O8bn8KrxBy+k3lMIP1h7nZYv/fzJEHiJO1ehyRhyXsFZots3JzB9VOjryZlxz6gfBsUdPLOLQOygzgjMe/vVWKGBpsXHEPRwtGJ5q8rOcTCr9seD+Eiq9Sxb+820xSo3bqzCYjKtmoc18O7IVrdDdhXTeFzh5BCLhX+unLebHQT1PI1mUtCwcQzpN2pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1vdFDunE1W/z/Lhu7QzUoWe/JG3q7WPWyLbbIPH1WM=;
 b=SismgTPOmjrv8hI9alv5AjYhiMhjgLjemY4OH7aVIofWttJE4BUNE1+NQZNMjPKBT+OP9HwJUBPaRsKpbYQ2YpmMUrvUTXkUmJuRE9SOVBszwXLERpQSlvKWc4qxhROdnWrs66NEsfdwQB6MQu45rOc2l6ixtw4aM6BjqUIm+dU=
Received: from DS7P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::15) by
 CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.17; Tue, 17 Mar 2026 12:25:57 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::a2) by DS7P220CA0008.outlook.office365.com
 (2603:10b6:8:1ca::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 12:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 12:25:57 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 07:25:54 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: Add client ids for mmhub v2.x
Date: Tue, 17 Mar 2026 17:55:28 +0530
Message-ID: <20260317122529.361748-4-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: acb86d5e-02d0-434b-d07a-08de84205791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: +iKJXAQjcKW1tdDpHPcThID7cB9E6MiDsV7I5n4UiHs5ulGlc0/riTyqVqiboyuMKgc5arzx/gOm5zHIzMJCZJjED3YOdvCD+xFqTFcE4mAt32ZLlbEuSbKVlF39Gr/sDceIyH4mhsXsKuCkzQ11zmxF/TCMJYWrhBO+6YlnrAy2BLoR2TYnjTqn7oVFTbp7WYY9aTCVkPcd0mtPIiXUDkYCxTYKvcLFn8P4R+8tSQ684UDQ352Fdh6RF6Oaxkxy2Ow+f/5RcmWOHtCdQCuSR3dgBzTj7JhY59fpQBOjqLz/Sb6XWdox6Ks9WA+cMMSu4jlIDGKYr5l06ZOfU71IK/Xm0vkj1VODZinySVTVuvdRsmcWvrZgAutSx+SdgCJC0uVr8MKqrQF7SFRFm+7qmuE6CToCX/OJ8kCp4DqmSim7/DSoaF3DOyoRf7eISDS2LOJLBTzqd2zunvhGFNA/eAy7Mbmqhkf1hhy6/FYgsWQNfFOJTXWGlGatfcCI8m5EKLoP5wn8APFuuCPtXDBhem+eNfAMRPmyhVoDX/ucXZFh5nJndvc+eyTO8oPhv3eJ0w6bLHonrPgrK7XzUK2zJ+9BKFeAuyfgEqa07DJ1G1x/YfXNJpaHIrazEndZafzOw8s1VAqeoFAs49+jegt9s7E2kXvFPkD97615vdj+o/i+kWe+V7C9A59f1aq1OvZs6sqg+ihOWe8Da6+Z222QLrnpLLZSlWvZG1N9ql+wePPmejGvKAbvL+H7I0SqchkA1ramBdySIBD30rK4KFfemQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zWdj4QOFh3hJDCu5X1slbHHJIoZjzCgzRhH72ESyhOpJaca8SW7+4r/2N7VLKwrk4VlvabULaSdLZgqNvr92wZXz7GU3NQvoMKGrU0rKPAo3Y9/cRuhgxokJ0va+FQH7a3WSKbZCur/TcI7FhAz+5OAkglCQ8AXig8NIUW48EN5TfXhLYhepASaRsLZATYg3XXqrbhdrgMazBWos+D0cDOv1xG0wlx9RUf862Fwm6TTrOwn00nGlRTV/+vQSC8GW9L61PHXP0uWrx7UZybWtIDrXIzxigx6kOmeVwLxj+fePfkUwdvS6QUVci2xCtH7fAa8qiZzLhRphgdnQjw7A/Q6PJjZgBEWidb86in0UJvrGbN1UUfFo9PxpabLJIKegz+Ku4FN+On1qGNWF1WjdcTZphC06boZrSqOrMcL9lqPMqBaBRs/1VZLCqCj2Ogh+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 12:25:57.5242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acb86d5e-02d0-434b-d07a-08de84205791
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278
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

Initialize client ids for mmhub v2.x

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 46 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 17 ++++-----
 2 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index a0cc8e218ca1..42a09a277ec3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -141,7 +141,7 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 					     uint32_t status)
 {
 	uint32_t cid, rw;
-	const char *mmhub_cid = NULL;
+	const char *mmhub_cid;
 
 	cid = REG_GET_FIELD(status,
 			    MMVM_L2_PROTECTION_FAULT_STATUS, CID);
@@ -151,22 +151,7 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	dev_err(adev->dev,
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
-	case IP_VERSION(2, 0, 0):
-	case IP_VERSION(2, 0, 2):
-		mmhub_cid = mmhub_client_ids_navi1x[cid][rw];
-		break;
-	case IP_VERSION(2, 1, 0):
-	case IP_VERSION(2, 1, 1):
-		mmhub_cid = mmhub_client_ids_sienna_cichlid[cid][rw];
-		break;
-	case IP_VERSION(2, 1, 2):
-		mmhub_cid = mmhub_client_ids_beige_goby[cid][rw];
-		break;
-	default:
-		mmhub_cid = NULL;
-		break;
-	}
+	mmhub_cid = amdgpu_mmhub_client_name(&adev->mmhub, cid, rw);
 	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
 	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
@@ -518,6 +503,31 @@ static const struct amdgpu_vmhub_funcs mmhub_v2_0_vmhub_funcs = {
 	.get_invalidate_req = mmhub_v2_0_get_invalidate_req,
 };
 
+static void mmhub_v2_0_init_client_info(struct amdgpu_device *adev)
+{
+	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
+	case IP_VERSION(2, 0, 0):
+	case IP_VERSION(2, 0, 2):
+		amdgpu_mmhub_init_client_info(&adev->mmhub,
+					     mmhub_client_ids_navi1x,
+					     ARRAY_SIZE(mmhub_client_ids_navi1x));
+		break;
+	case IP_VERSION(2, 1, 0):
+	case IP_VERSION(2, 1, 1):
+		amdgpu_mmhub_init_client_info(&adev->mmhub,
+					     mmhub_client_ids_sienna_cichlid,
+					     ARRAY_SIZE(mmhub_client_ids_sienna_cichlid));
+		break;
+	case IP_VERSION(2, 1, 2):
+		amdgpu_mmhub_init_client_info(&adev->mmhub,
+					     mmhub_client_ids_beige_goby,
+					     ARRAY_SIZE(mmhub_client_ids_beige_goby));
+		break;
+	default:
+		break;
+	}
+}
+
 static void mmhub_v2_0_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
@@ -558,6 +568,8 @@ static void mmhub_v2_0_init(struct amdgpu_device *adev)
 		MMVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
 
 	hub->vmhub_funcs = &mmhub_v2_0_vmhub_funcs;
+
+	mmhub_v2_0_init_client_info(adev);
 }
 
 static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 5eb8122e2746..31c479d76c42 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -80,7 +80,7 @@ mmhub_v2_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 					     uint32_t status)
 {
 	uint32_t cid, rw;
-	const char *mmhub_cid = NULL;
+	const char *mmhub_cid;
 
 	cid = REG_GET_FIELD(status,
 			    MMVM_L2_PROTECTION_FAULT_STATUS, CID);
@@ -90,16 +90,7 @@ mmhub_v2_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	dev_err(adev->dev,
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
-	case IP_VERSION(2, 3, 0):
-	case IP_VERSION(2, 4, 0):
-	case IP_VERSION(2, 4, 1):
-		mmhub_cid = mmhub_client_ids_vangogh[cid][rw];
-		break;
-	default:
-		mmhub_cid = NULL;
-		break;
-	}
+	mmhub_cid = amdgpu_mmhub_client_name(&adev->mmhub, cid, rw);
 	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
 	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
@@ -486,6 +477,10 @@ static void mmhub_v2_3_init(struct amdgpu_device *adev)
 		MMVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
 
 	hub->vmhub_funcs = &mmhub_v2_3_vmhub_funcs;
+
+	amdgpu_mmhub_init_client_info(&adev->mmhub,
+				     mmhub_client_ids_vangogh,
+				     ARRAY_SIZE(mmhub_client_ids_vangogh));
 }
 
 static void
-- 
2.49.0

