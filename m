Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971D8C5AD55
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 03:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F8310E5ED;
	Mon, 10 Aug 2026 03:41:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JQ99B67W";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50BC410E5E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 03:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4cq4g3+mz08RFkP+3tAi/smVBiBi+sySRXi38VLEoPEseAiqyZeBBOmoPHIgV+mwEtaWub/90FrrWinFEe9uNLTObVtpk7dddxEm4ugwq2Ftd91Jql+RLPu4YtAT5cDfjDURtAOR9ptuaxS+xED37vg6Tm5edJgFzuoR1iICtUKYRPcrtmjE9QNmsPPti3fMb/rJ2LAT6//yk+zFDsDmONUCYkP3CWVs4SOSo6ZnSKN2mDPrOEh8Z7F4/4/N/Zr55I2c4Zb9psGpycPFuMBhvi93i16HELh2A+AeZiVOP6D3P/E2cPKv4nalPQFJiSKfwdqv0DQQOOdbv2Xjp9f/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e08/AEafD+F5uOw7GOy3xPKEOmULOoEAUZeCmS0FsVE=;
 b=Z6kXt1ZYheXE855uHRPZY+elGneKoH+PiOLJZ6nWraZgDSeZYl+n0fp5vxBO0Cu71jyhhirtq7FflHwe6+bTlSlvtJdc4bu0dghlLFM979JWUfcavWrPhdo16Z6xtdIkauuFzWctWq0C1e3gsFnuFHBYY3c8mBgmlDK6p9p1zaxt277cjmN9wGj8a3OvtfFsKki10op+3zJeRQbqGyyxjzcZrXRCmrOWPEsJAmuSFkANeMrODP5LRkepR0LB/2cGIUQEd1pvQDNIf+0i6Gw4jRdqmSbvodRVXZwoNuEvH6hW1y18y0IfkH7TawZ0TjWK5txE9QtL6WFyWcTV9BSR4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e08/AEafD+F5uOw7GOy3xPKEOmULOoEAUZeCmS0FsVE=;
 b=JQ99B67WHOQHm1z+ACl0W+isPxAcRjhWVHPZRlOkUPAS4y0mOzrYb2GPLdVlfkvkyAYNnLFrqUcI2mIo6gj3ypwgG3p7bw4eQ7cM4UmsRRn6tnh7H/35+Va5YrmBNQgEbBLtIPNuq2JRbkpwlVgRFt+MBCM2BDMRenO6DWqC6/U=
Received: from DM6PR06CA0091.namprd06.prod.outlook.com (2603:10b6:5:336::24)
 by SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 03:41:10 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::78) by DM6PR06CA0091.outlook.office365.com
 (2603:10b6:5:336::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 03:41:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 03:41:10 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 9 Aug
 2026 22:41:06 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <alexander.deucher@amd.com>,
 <Christian.Koenig@amd.com>, <sonjiang@amd.com>, Sonny Jiang
 <sonny.jiang@amd.com>
Subject: [PATCH 08/13] drm/amdgpu: JPEG 5_0_2 Add multi-instance interrupt
 support
Date: Sun, 9 Aug 2026 23:36:39 -0400
Message-ID: <20260810033644.118194-8-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810033644.118194-1-boyuan.zhang@amd.com>
References: <20260810033644.118194-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SA1PR12MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f45eb1-9e9c-4b73-5391-08def6913803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DLhVBzm8d5S4MVEAu/IBrpJWAneS8IYOvqLvKsi9YnQMbhV+vw1iT6eqfgTtHI1H4hYcKTJ3gsk6FT6SGzZv9wjULQeW9prWLOgJ3qhydONCNC/OokvbSXBdqiGbzf2HmKPXs5pNI7uQ/zVx8SYOEKOQ+JCwWUB8heonUP9kLLyQGayTRC6tFnC+znnKJncZASGP3djXFs04deH7nnahr/nLnBo2gbEWHFUgV2P3PqbxJ6fOeFQ19Zanmxnz2mWgvhwjGZEVXcYG1gPqv2lV22VIaUyGkWCgxMU99SflMUH1KkvYzDMoeGvQpoPUu6nkFKejTSTOFJk7861xQMmZ1SNLc4T9lI9CTxE/6F4UEGuguQpJFnFkU/MIjYFCFu4jT3QVbmHPMo0+PGPcKXjUduyjBUpIR2ReS1yqg93M37WXUP506JvmJeTbXi1YWjePDgOTuwNScEp0+5YJcW/RYFgFXCADJDEgkilyC/wovCdS6cJ2m1LgGgj9KDqLw9g9MPou0U0Pz40BFU9gaMM/9dKT1Z21TBjoyqqGoYZvXpCyxL/iyEjqg98p5VZzjmeQ2SQlPWxJ8KcwHlFK8wIgZTAunj4uZ8q5LvpfM1dz4rDHFOdXe9V2cI4wJJHzyyG0sEnQJYQgQ2Q4KDa20dKoG4Cgs/Z9V1QQYGjUUxgMuM9mBR+5HX7HhF8QlsuU3By+1vwx5hgeq9yFa+UMExLX+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vgRMkOlUWPGXIFGCEPVOXgQiAsL07tqyw25udI0d+s2ncYVcSzTC4Epkg/MUdIysoKbHgyMTIt5iBleRWNdEjlCcQWOvwexTvjMhtdLYGkbd3b7c/7Yvi+RPV8yTVWxPunfCmi4Q1o05XjqlK7RyOr9hSUiQ90QWBfhHmUlVt0a3/144OOwnnf73I8AGzwR1+7Z14SqTpmEDLt7z3UCHdn/2kqc+F5zarGdXAfhv7jUxP4BvrJLC4v9jQMsZIWfTM4ThFlhpqG301l25t7kAwx+AYuEXswi9HS4HaxlyDtBhcVKdKa/J6khEGZUT/5mCKaLpPTQhSY6exxttNaWDpzMzSorEeES/MWq7izGGdn04iJ4V0SnuHVx29jBHY9bv2Ii+8Dj9hrdKPueTj+VChWxNoqQhgi+/Ui2KBnqMHK2CMXJBamguz5WA48JAl7GB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 03:41:10.2747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f45eb1-9e9c-4b73-5391-08def6913803
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679
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

From: Sonny Jiang <sonny.jiang@amd.com>

JPEG 5.0.2 has two JPEG instances per MID. Register JPEG interrupt
sources for both VCN IH clients and add a JPEG 5.0.2-specific interrupt
handler.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h |   8 --
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c | 100 ++++++++++++++++++++++-
 3 files changed, 97 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index db3fbe4eabb9..8846cb3ed12b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -772,7 +772,7 @@ static int jpeg_v5_0_1_set_ras_interrupt_state(struct amdgpu_device *adev,
 
 
 
-int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
+static int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
 					 struct amdgpu_irq_src *source,
 					 struct amdgpu_iv_entry *entry)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
index 67346faecb47..a7e58d5fb246 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
@@ -108,12 +108,4 @@ enum amdgpu_jpeg_v5_0_1_sub_block {
 	AMDGPU_JPEG_V5_0_1_MAX_SUB_BLOCK,
 };
 
-struct amdgpu_irq_src;
-struct amdgpu_iv_entry;
-struct amdgpu_device;
-
-int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
-					struct amdgpu_irq_src *source,
-					struct amdgpu_iv_entry *entry);
-
 #endif /* __JPEG_V5_0_1_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index ea54a2b6eddb..0ea341c238f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -34,8 +34,6 @@
 #include "vcn/vcn_5_0_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
 
-#include "jpeg_v5_0_1.h"
-
 static void jpeg_v5_0_2_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v5_0_2_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v5_0_2_set_powergating_state(struct amdgpu_ip_block *ip_block,
@@ -140,7 +138,12 @@ static int jpeg_v5_0_2_sw_init(struct amdgpu_ip_block *ip_block)
 
 	for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 		/* JPEG TRAP */
-		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+		r = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_VCN,
+				      amdgpu_ih_srcid_jpeg[j], &adev->jpeg.inst->irq);
+		if (r)
+			return r;
+
+		r = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_VCN1,
 				      amdgpu_ih_srcid_jpeg[j], &adev->jpeg.inst->irq);
 		if (r)
 			return r;
@@ -585,6 +588,95 @@ static int jpeg_v5_0_2_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v5_0_2_process_interrupt(struct amdgpu_device *adev,
+					 struct amdgpu_irq_src *source,
+					 struct amdgpu_iv_entry *entry)
+{
+	uint32_t mid, cid;
+	int i, jpeg_inst;
+
+	DRM_DEV_DEBUG(adev->dev, "IH: JPEG TRAP\n");
+
+	switch (entry->client_id) {
+	case SOC_V1_0_IH_CLIENTID_VCN:
+		cid = 0;
+		break;
+	case SOC_V1_0_IH_CLIENTID_VCN1:
+		cid = 1;
+		break;
+	default:
+		dev_WARN_ONCE(adev->dev, 1,
+			      "Interrupt received for unknown JPEG client_id %d",
+			      entry->client_id);
+		return 0;
+	}
+
+	switch (entry->node_id) {
+	case 0:
+		mid = 0;
+		break;
+	case 8:
+		mid = 1;
+		break;
+	default:
+		dev_WARN_ONCE(adev->dev, 1,
+			      "Interrupt received for unknown JPEG node_id %d",
+			      entry->node_id);
+		return 0;
+	}
+
+	jpeg_inst = mid * adev->jpeg.num_inst_per_aid + cid;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++)
+		if (GET_INST(JPEG, i) == jpeg_inst)
+			break;
+
+	if (i >= adev->jpeg.num_jpeg_inst) {
+		dev_WARN_ONCE(adev->dev, 1,
+			      "Interrupt received for unknown JPEG inst %d",
+			      jpeg_inst);
+		return 0;
+	}
+
+	switch (entry->src_id) {
+	case VCN_5_0__SRCID__JPEG_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[i].ring_dec[0]);
+		break;
+	case VCN_5_0__SRCID__JPEG1_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[i].ring_dec[1]);
+		break;
+	case VCN_5_0__SRCID__JPEG2_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[i].ring_dec[2]);
+		break;
+	case VCN_5_0__SRCID__JPEG3_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[i].ring_dec[3]);
+		break;
+	case VCN_5_0__SRCID__JPEG4_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[i].ring_dec[4]);
+		break;
+	case VCN_5_0__SRCID__JPEG5_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[i].ring_dec[5]);
+		break;
+	case VCN_5_0__SRCID__JPEG6_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[i].ring_dec[6]);
+		break;
+	case VCN_5_0__SRCID__JPEG7_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[i].ring_dec[7]);
+		break;
+	case VCN_5_0__SRCID__JPEG8_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[i].ring_dec[8]);
+		break;
+	case VCN_5_0__SRCID__JPEG9_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[i].ring_dec[9]);
+		break;
+	default:
+		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
+			      entry->src_id, entry->src_data[0]);
+		break;
+	}
+
+	return 0;
+}
 
 static void jpeg_v5_0_2_core_stall_reset(struct amdgpu_ring *ring)
 {
@@ -690,7 +782,7 @@ static void jpeg_v5_0_2_set_dec_ring_funcs(struct amdgpu_device *adev)
 
 static const struct amdgpu_irq_src_funcs jpeg_v5_0_2_irq_funcs = {
 	.set = jpeg_v5_0_2_set_interrupt_state,
-	.process = jpeg_v5_0_1_process_interrupt,
+	.process = jpeg_v5_0_2_process_interrupt,
 };
 
 static void jpeg_v5_0_2_set_irq_funcs(struct amdgpu_device *adev)
-- 
2.43.0

