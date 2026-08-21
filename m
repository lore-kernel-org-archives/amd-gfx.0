Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65F7C5DF9C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 20:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4228210F453;
	Fri, 21 Aug 2026 19:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4gLMYm98";
	dkim-atps=neutral
X-Greylist: delayed 301 seconds by postgrey-1.36 at gabe;
 Fri, 21 Aug 2026 19:41:47 UTC
Received: from BL0PR03CU003.outbound.protection.outlook.com (unknown
 [52.101.53.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B6C710F453
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:41:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OO/9oz5QoR+lSFqD8ucQMX9oU/3Op00O0ZUv2p9z/3M6lOmrgSzIjwPtAIJ5P6R0YxU2d58hI0IA3I9GVIl8hWLLUcpFJ0lsbdk5m1IVQM/VON/EX5QadXX9Oqe7t8ey9M8Vh5szndR7wBZb86b6QxF4ysF94OJLizcGf2BvR8GsfbWm5NDuX8wXmtXRlMiF9U7TD3JfYt+zYoQS+4yngQX31HRsNSpy1ZLOhhzrn8nRtP4od+56X3AepGpGoPjwcuv9Lycc1tu0vs/CoDlxrKYLW9RSlC767bV8JucD8v02j8NOJ0u8riFSS8MxMtKu7uDki2bkxKOUozhfyb4a1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6soGj/c9fpvaBUF0S9SB1AUvxm+pyznitD99gbMoWso=;
 b=GY06wctL4y6Rx4ZcmWEBgtSzqzURs9F8HQYC3kYawjbt16DzOb489yC9yA2w3GMojqZffRkhCWWiDxWFLiiKZtXWu7ACTeZZVW8q1T6AJLF/BENtJdy09CW/C2M/W7Yt9lsVxdBzT78It05BmeUf7KX1Piul6SBFT5wmjXyzSgXRS8vZLIpVorfY4E6NLww1qFZGcIhuCL8/5wteCRZJeI/YMlIOHM26oHPE5C3IwJmT7xtqcq2Cj3rKMMOf++l2zVDmgQZ9u70i8+E/nlyB80y6Ck5DSWVnjqjq4GuQAa5N346h/Tz5Kjpj0R+EuMd5eOIDOMq/8jYk0xUmbIxcaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6soGj/c9fpvaBUF0S9SB1AUvxm+pyznitD99gbMoWso=;
 b=4gLMYm98WNtram/78JwjoU81fyzOFG0OS5tDMOIosylY7lTTytAd60M/Be49TxRns1w7LXITaJnENwe4wXvTAdTMWpK1tdJCjbwbhnjXXe8g28X9P4CxaKNNFLsVrVcWO1duhdawyE49dUPpGBZUzNZPYJNTLG/NfLihWEbO49I=
Received: from CH0PR04CA0015.namprd04.prod.outlook.com (2603:10b6:610:76::20)
 by PH8PR12MB6698.namprd12.prod.outlook.com (2603:10b6:510:1cd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 19:35:55 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::45) by CH0PR04CA0015.outlook.office365.com
 (2603:10b6:610:76::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:46 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:46 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 57/95] drm/amdgpu: Send TLB shootdown on exported memory unmap
Date: Fri, 21 Aug 2026 15:34:20 -0400
Message-ID: <20260821193458.808626-58-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|PH8PR12MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e8a48a-9961-47e5-b1bb-08deffbb6ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|11063799006|18002099003|22082099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: +nYI1Na2Bcw5BgW8aIIkO6wtX/jqusdYhXUoh4gZaWYzj9pqPREbK1O+S5X3pRyvq11Zx2mqSUO4z4kALbhy01auw/XF87tzYkklrMrUUGuELphr9A0wQ7NG8zPKSH39ZvwvCQWiIRpe2hJfmShic8BWpWO8OZar4VQ9XGgE5erW80ahYkkfaSdta/IbD5WFcuDMbvoSkIRLTQFJ/RUDa9HwmDbN6vF7qvJi2zCuPrZ4nootFv+SWtHQ8Vsy9jx02FipgmL8yhaFxsSfsw3XJWacJt7FSnY9REUrTTJ4xjJx8FCKqlxRngeNvVKNChRVBcr5wVM22mgsqNYYTpKV5sDDGwroFs9PzzwG4vC5VhWb9h+4se+xOXxDgD2Es2JoP3pp5WG+ULbr48PsVzHK2IYxqy0KOXNtzZBMJvQOResdENx8NnaYZbKBQHvT5BTuQp/D0pCKltVO0xB/JPAZmiDJ6Crzl7YkJaD1hrRWjDMjelY4r4taI5Io705dAsHSX5eydMV8KKeFeGZrcVRLDe0b0cebaN8pBjMP/TACdq9XaFpG5NAb3O/mzqdiOq0/Ty9ZGbtqXUxMWgL6pcJTICGDQsUGpvoD2qzaVu0ghMEjoIZ40yx5H2bW5vCWRTjDIzWwRjt95sk7lW7C5ruq9Ctixc0mbYB2QYIZH/TBjn5brRBD33azL/D+ioy/qkLG2NLBe7EdhrFXvl6Kj5AAgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6wLMRCcyzXv7SQnR6QNsp6LQJ6vM4iUL6tYM0OhEu4lzx3vSaACRy1gKon2CWZ4CGbSXwYL7E2s35HoHKSVgn8u16hJZiv4uFMx2EZhhH63YS4FVtxnx2khAPQhpIeYOsecgwlWkAr8MGiQa7XOMmFMNqdRH277/dMCpBBRiqbBrPIMtKILfUArXpKbE0F3oX7HhtqU9YLEUfcqKkDwV6Q2cqWrgghBqUYwHk3/jkYD1IeQZwK8zhBQTHoqlChMT6Lm/lzAzb2aILrSshLOkGs4VPsFsfh7dDJnTd3kd+h+gYysWHWBgk2M9DoiODINDUwVkERX+qIcGDG2Ejsw/ISqufOEV5ogaSWQ9sNi4zJ5E5eRovbK5P8r03QQkRQzbQ/7NrIDBTEPH2ac8uB/oSyoONnVcVETs7keX+FapPA4ufyfPORdKWmgxe1f4DaRJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:54.9145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e8a48a-9961-47e5-b1bb-08deffbb6ad4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698
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
index 2f7df10f39423..57332243ea027 100644
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
@@ -1401,12 +1404,6 @@ static int amdgpu_ualink_send_npa_req_msg(struct amdgpu_device *adev,
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
@@ -2005,6 +2002,51 @@ static void amdgpu_ualink_force_retry_rpcs(struct amdgpu_device *adev,
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
@@ -2163,17 +2205,7 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
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
index bd8af7596a6ef..a1fd5fe953115 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -78,6 +78,9 @@ enum AMDGPU_UALINK_PROTOCOL_MESSAGES {
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

