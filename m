Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FF3C624D6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7493B10EA79;
	Mon, 31 Aug 2026 18:29:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y1iajead";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013006.outbound.protection.outlook.com
 [40.93.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C4D10EA66
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUQm9cixAGt0EjH8G+V7easjn+kZ1wCLnM0DhMZjM2F5bkzPEIfcWcquwIKpb0aE4wSw9IImnd66JJNhBe1eMWxlxfSBxJ246mzgdMuUW26MktMlVPTZvzmCxYFDetXNuTkk9My6nm7dZns2NADJh/paXz7D43bmzZolNPdcWxvRUswBFXIyhBUKxxv36YHPINy2h1pr6S2c8YsfXu6O6ybmVEMWCmCRk1OHB6KpHzTqXZYHiJzfyqT4/FGUrEP5wmeE17SKIpYCKNYR2Tvfqyhy1kOWX/kcFkC7OqgAvlzx/yW+kulSaCzhshmkpFf0/juzhT5bYTwTxVDmEFPp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nY0c2dnWF9XecgG/YhB9q6e1cYwmbMYZN0/9jmaxB1U=;
 b=JF5nLaWgP85ByLrxHNAK1Nt4E2CdbEUTzlp80fmI1t9IylQ14oL29XZK9eAv1jc7pamPCbAvXYES+wIJQPzaIkKQAsEld4StI3Qfq+JHHBxgYKmCeZ4Cqe+RED2XAf+50oEHTusZfrHGDDD5Or/6vbuwqjGvt91RhygAQUmoc5CGLljYD72rn3ND7U3+HmqxVxUIPr0dWG9UQpRX6kD8NT4p5R68mVV/hcj8KJXopLjbtq5mjuMpgS4jiPlDkZ6hL8nu77tJQ86MNebJ7qmwBNveDTOGS564HxZ1I7axmoAoPtj9G3XT6DypMPNEertiiZ2mzWdTP5giGbdBRf9aWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nY0c2dnWF9XecgG/YhB9q6e1cYwmbMYZN0/9jmaxB1U=;
 b=Y1iajeadPdW/c93NcJkboohh6+ddqT//YrpCofMch3b+QcJQ2j2sVZf1Zwm48jfvQPO65gnqGMEgF2QccDTNZDuaf7an0evCCtjyFGRh/ITHCoMs1f548B/ZXds/+issopWl8tc9o9piTClGweryX3XMqPrkMpxGCM6Dy986oFM=
Received: from CH0PR04CA0111.namprd04.prod.outlook.com (2603:10b6:610:75::26)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:58 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::af) by CH0PR04CA0111.outlook.office365.com
 (2603:10b6:610:75::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:42 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 57/95] drm/amdgpu: Send TLB shootdown on exported memory unmap
Date: Mon, 31 Aug 2026 14:27:16 -0400
Message-ID: <20260831182754.1089811-58-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b4720ea-c541-41a6-cb9b-08df078db822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Dm+87CXwrQPQjnqnPwlsHL00AX+sazTTtUaN7jp7IJku0Ytx6sjSHx6De1GZPCBfeRqA/1bNBArl++qZoL02pWNMNk9xVHGz/kRzPKMQVUhFc31qrNM67MX3+6AnVIfh0IMLcZf8qCkD3pGI8lIysHHoN+lKO/9A6HstWD/aGEkmWoKlxO7FRbVBWyA7+kW4xvE2RzoSAIOR6ALYAyvNZZoOwJNKuIJhjly4Rlo3M/NbtNHYnpaCUEInWMDg6I/wuq2haluFr1PGCl/zoQzU8z/sQKlCeajDSflnH3+sDHDAXVD4vIAt4JRJFCM4ocEKCQhw/R5ee1bDGZq3LDJxB1yI4JowBViGt8rLd9whQpOMK+ijBLK/CbScMSFKEiK+Hx2WXFEs+TgRx51N39lz94lPhUmaySWsoAwQqTZMiHJKD4CjBQfEw/K24tKvX1pmhHOTzcTGEb2lv3Aw4nUIV4r37OrYIhlNgTwaa08CeMyUk9/qtwoQaz4JoY8ZPcjqnEJTc/xk12zXcJWgRw+RPtXJYePUtB8hHn0sE8K8U6KD26WkU0bDxxCZuiBiOJ2CngbwxYQMqFgyfbguPkKDC9Ivbzvzvo/oLHYutZvxGCpwJ0m9HqiCt5O2fQZoj7yEnLm+7ysuGKXfG3tm6md6aPCJhaF73bxXCzqxrV0dXIYqEOA0mqyESmxByjgrOXSsTU+Mor3+bNA2OcF6KJJSzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CEB5oNfNpa/HlP28AVYsgTjL0vl2EvGae1T86digYZitBrwFnJ/2nBYd/B0bW9pCEbDPx1ANwcqAqm6/UVemmKRdB0DB6lR5F/EZeyD50y5JaKvv04H+90CcUWwOHbcuJyaDfnLFNmOhYKpbhg/fBDD3OAkxWcPETCnqElg9LQ2u3TmYu3HxS5UJslTrwA1T6XT6mEJQ3mpk3wlmKw33+eAHOzpRoDiaf4Fmp0p403Lg9KuHnuna5uZrEhQL1rMbzwnRiz4OtrUtQ6ikd8Y4+JJjwpzcmmwNP+/d/o2DtZjEcjyByQwmoNdIKN5/un7VCxU7zDS92457ciTOhAkl/V+bebWjD+FjxctAq1mt3A2LWeLraoxaMo83OS/dxOHnTSHlxYhG0mfDo5964VW2lRwA4sZQQIYucifevmqG3QG9OAtSuijgK2qnPXEpTYm/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:57.0521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4720ea-c541-41a6-cb9b-08df078db822
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327
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

From: Mukul Joshi <mukul.joshi@amd.com>

Replace the stub implementation of TLB shootdown message with
the actual implementation.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 66 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  3 +
 2 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 762713194bb6d..4e312eb3441d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -47,6 +47,9 @@ static void amdgpu_ualink_handle_connection_reset(struct amdgpu_device *adev,
 						  u32 remote_accel_id, u32 state,
 						  u32 generation_count);
 static void amdgpu_ualink_invalidate_import_mappings(struct amdgpu_bo *bo);
+static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
+					  u32 remote_accel_id, u64 addr,
+					  u32 size_in_pages, u32 flush_type);
 
 #define STRIP_NPA(addr)						\
 	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
@@ -1448,12 +1451,6 @@ static int amdgpu_ualink_send_npa_req_msg(struct amdgpu_device *adev,
 					      dw2, dw3);
 }
 
-static int amdgpu_ualink_send_tlb_shootdown(struct amdgpu_device *adev,
-					    u32 remote_acc_id)
-{
-	return 0;
-}
-
 static u64 amdgpu_ualink_get_export_pte_flags(struct amdgpu_device *adev,
 				       struct amdgpu_bo *bo,
 				       u64 mapping_flags)
@@ -2052,6 +2049,51 @@ static void amdgpu_ualink_force_retry_rpcs(struct amdgpu_device *adev,
 	amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
 }
 
+static void amdgpu_ualink_send_tlb_shootdown(struct amdgpu_device *adev,
+				struct amdgpu_ualink_exp_xa_node *exp_xa_node)
+{
+	u32 addr_mode = adev->ualink.info->vpod.addr_mode;
+	u32 accel_id = adev->ualink.info->ppod.accel_id;
+	struct amdgpu_ualink_importer_entry *imp_entry;
+	u64 npa_addr, size;
+	u32 remote_acc_id;
+	int r;
+
+	size = amdgpu_bo_ngpu_pages(exp_xa_node->bo);
+
+	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
+			 AMDGPU_UALINK_ACCEL_MAX) {
+		/*
+		 * Replace the GPU-id bits with local accel_id
+		 */
+		if (addr_mode == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
+			imp_entry = &exp_xa_node->importer_entries[0];
+		else
+			imp_entry = &exp_xa_node->importer_entries[remote_acc_id];
+
+		npa_addr = STRIP_NPA(imp_entry->npa_addr);
+		npa_addr = GENERATE_NPA(npa_addr, accel_id);
+
+		if (!amdgpu_ualink_check_conn_ready(adev, remote_acc_id,
+					imp_entry->generation_count)) {
+			clear_bit(remote_acc_id,
+				  exp_xa_node->importers_bitmap);
+			continue;
+		}
+
+		dev_dbg(adev->dev,
+			"EXP-CLEANUP: Sending TLB-shootdown to remote:%u\n",
+			remote_acc_id);
+		r = amdgpu_ualink_remote_shootdown(adev, remote_acc_id,
+					npa_addr, size,
+					AMDGPU_UALINK_HEAVYWEIGHT_TLB_SHOOTDOWN);
+		if (r)
+			dev_err(adev->dev,
+				"EXP-CLEANUP: TLB shootdown send failed to remote:%u\n",
+				remote_acc_id);
+	}
+}
+
 /* Unmap all NPA addresses associated with a BO (UALink handle). This function is used
  * only in Source Identification mode.
  */
@@ -2210,17 +2252,7 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 	amdgpu_ualink_force_retry_rpcs(adev, exp_xa_node);
 
 	/* Send TLB-shootdown to all importer GPUs */
-	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
-			 AMDGPU_UALINK_ACCEL_MAX) {
-		dev_dbg(adev->dev,
-			"EXP-CLEANUP: Sending TLB-shootdown to remote:%u\n",
-			remote_acc_id);
-		r = amdgpu_ualink_send_tlb_shootdown(adev, remote_acc_id);
-		if (r)
-			dev_err(adev->dev,
-				"EXP-CLEANUP: TLB shootdown send failed to remote:%u\n",
-				remote_acc_id);
-	}
+	amdgpu_ualink_send_tlb_shootdown(adev, exp_xa_node);
 
 	/* Unmap all NPA addresses for this BO from NPA VM */
 	amdgpu_ualink_unmap_all_npa_addr(adev, exp_xa_node);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index b143a496b4dd9..fa116ef44cb50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -82,6 +82,9 @@ enum AMDGPU_UALINK_PROTOCOL_MESSAGES {
 	AMDGPU_UALINK_MAX_PROTOCOL_MSG
 };
 
+#define AMDGPU_UALINK_LIGHTWEIGHT_TLB_SHOOTDOWN		0x1
+#define AMDGPU_UALINK_HEAVYWEIGHT_TLB_SHOOTDOWN		0x2
+
 enum amdgpu_ualink_conn_state {
 	AMDGPU_UALINK_CONN_NOT_READY			= 0,
 	AMDGPU_UALINK_CONN_IN_PROGRESS			= 1,
-- 
2.55.0

