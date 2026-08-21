Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959EFC5DF87
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 09:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D22E10F2BB;
	Fri, 21 Aug 2026 09:54:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZA/MqBD9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012047.outbound.protection.outlook.com
 [40.93.195.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F0B410F2BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 09:54:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPoySJSg/D2l74aKcfOlFLBfWqTe6B1I/sIEkpF3pYyqUmt0y6hizRY/YbU7xZfvR8riORcLLn8ozl2XWfOqN/IvlKXZTmL/rHCBek+DpPp7SOsNa8/AzVYd1cDXil4UvmK39exxXU0gYRIB/GqGWH5RHjZGKx7H+5PewV/U+tRJB3zWUpwEcw7AbooOF8lom2Lev+X3pXTR0iTsIUahDATrfEshQCrZO//TEUrdSmuzpAEWU1+CBYBufc/XBZ85rS11mkg7YcXO3l8WQ84vxBDBXnW1/LNnAKa39VxiOjNtHaAPUHc87RQ8+uiO1LpAHB0vXp3Vxm2tOT9z0CSy0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3aHg9A4uJqZZ+OnhtZv/JEFMEve887O3PSEgLLSD3c=;
 b=ExXzVHBUffpe9DRLqZlyeuNNEeWnLvygOhvCCqdeA4rX1PKmPSOX9sJLug/aRVyhT1ss75m86X8a5Q6t6HA83uYhbVKXskvSHZwwNBGKWCODlPUEZpJIUePnNXKNB8hGe0PTa2pCsYQKwxhOMFJV32IB7Jd7TV+5vFPMTiwcmYPKaJOqMNcOdyPX3PljdMLYj7bl1ss5H9PJeo39unM1l3a+iqcY0bvZAr120uslbnJqrHkscbTLj8M79T8/q7cX+OhNOiZ3+1XvI8p7jrJZO046W655065JyqFSyOmE7VeCrhmlHNnx3sGNKn0hUzAuiWURhG4M/o8Qo2+30EpHHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3aHg9A4uJqZZ+OnhtZv/JEFMEve887O3PSEgLLSD3c=;
 b=ZA/MqBD92Lsfs3tNn25SytD4+gfp97iwRXhR3e7jDbfykz082avgvCCqHAxmDANZhgGUonrIQPqsNKaYmeXsFf1K9syN5ZepRO0iwtJree5L3rsoBqdGwBRaihOHUZEWPXz+1ktnoIi86Fujor1WGlLykBGDxbmlK71hvXfMggU=
Received: from BY5PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:1e0::25)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 09:54:34 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::78) by BY5PR03CA0015.outlook.office365.com
 (2603:10b6:a03:1e0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 09:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 09:54:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 04:54:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 04:54:33 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 04:54:32 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 04/10] drm/amdgpu/gfx12: implement compute and GFX update_mqd
Date: Fri, 21 Aug 2026 17:52:13 +0800
Message-ID: <20260821095427.2361126-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
References: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e94227-8675-46a2-eee6-08deff6a3478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cWWJfazE+GfuvpftHVrY6lSx7sH4aIw4pCDotJjtKKJLbisS/PqPa+cuCia5venUq2asZhCJbC3fhFj3p7MHqDasmNZ0A/S6vdFXoVHiM61AjwBy726ml8V/tsKelR4cNgyqQHSzvcOFDtBhAogis0CLXnNpsTGB6GDSfng0U2iR/NP9rNP9I8tmpAEjWb09zt1iua9OuXW1aVZ1pIUQlvlOcJFYHQjOjPeA80LqM26QGKQlYnFtt/ANyuh+vdzkcPCOm8/RnBWqVdpXDUk77Sgu5PpMz6Dy0bFTPVVy32dbxljEKJ6e6XTznpKa+H4jcjosXGptja4vDD5C7OlpYi6I55Ylukz2bGFvT3GbNMQ45PuraE2EMNr71/tSxhLmUEI8yPrpuR/2SSBA4YbiwT31p0hr7CJyYI3SdcYMwAl32LbwXb6p+soccmbaLxTdanJYl9yIXbSQ0BdoLrfS5GQEoEqnRybExWMsYIgUGf8mifPo56XV9jE+LzmOoOV2cHhvoOrSyspPKXDM5kRzTiM2Uzwz17Em9JcN1jgkVitapCIc3CADb3H37bWBN5SchFIvogrEH8uj0b9bvoZKs+1Jwpj0Jcz4VxjkL63LerqL8gvJ/o34z4WhqBGISAdlzrEh7VG+ngLHDJ1DwCLWzrcDhOLP2U2CQN9AvWCZHPxBwY0Z0AENbIagUDNN7dgY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vjoo496G6YFrXqsbl8jTZIy515du4u65aV4bs6vFdulU82hV92GVt88uea0rZzv71gjvnYuRcxRD43MG+DXMw+GkDdL+T1tiVuXKxfNVYz6eTVlm+rBZPvktiSyEjO52d0Cts0+Hm8DnFTOE1r16cKCdsbDhgF1+xv3SE6RUTbFOnrsK3CbQGy6YeGCDQYlpjV9CkLqhO/zcvw7lszRP2CTn/qMfIbpB5/a5Mhi7gdBtyLzvz9GnraWR0a2OQTR7V/qkMkrLLfuGKDpACkrZo14vHDEZayKBmVG9It2lJO812aS2PPb7GoeCDACQN1ElA8vkukT0tPbOY3EWR9WfguZeu8CC5s63Pb3TzVkJh16S1/1+gLQ6FLXIjWVpGqxHVGj413k03eq+gCs6iaeouQZWLCRSSugECK0YuLMKVin1uZMYurKGeOnjnDHosLmW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 09:54:34.3876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e94227-8675-46a2-eee6-08deff6a3478
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250
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

Implement the update_mqd callback for gfx12 compute and GFX user queues.
It patches only the fields a MODIFY can change (compute: queue_size, CU
mask, priority; GFX: queue_size, priority, shadow/CSA) and forwards the
write pointer to the user wptr while keeping the firmware-saved read
pointer.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 74 ++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a434b665d913..5e4d323a790e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3096,6 +3096,44 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
+/*
+ * GFX update_mqd: patch queue_size, ring base, priority and shadow/CSA in place
+ * and forward the write pointer, keeping the firmware-saved rptr.
+ */
+static int gfx_v12_0_gfx_mqd_update(struct amdgpu_device *adev, void *m,
+				    struct amdgpu_mqd_prop *prop,
+				    u64 user_wptr)
+{
+	struct v12_gfx_mqd *mqd = m;
+	uint32_t rb_bufsz, tmp;
+	bool priority = 0;
+
+	rb_bufsz = order_base_2(prop->queue_size / 4) - 1;
+	tmp = mqd->cp_gfx_hqd_cntl;
+	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
+	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
+	mqd->cp_gfx_hqd_cntl = tmp;
+
+	mqd->cp_gfx_hqd_base = prop->hqd_base_gpu_addr >> 8;
+	mqd->cp_gfx_hqd_base_hi = upper_32_bits(prop->hqd_base_gpu_addr >> 8);
+
+	if (prop->hqd_queue_priority == AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM)
+		priority = 1;
+	tmp = regCP_GFX_HQD_QUEUE_PRIORITY_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUEUE_PRIORITY, PRIORITY_LEVEL, priority);
+	mqd->cp_gfx_hqd_queue_priority = tmp;
+
+	mqd->shadow_base_lo = lower_32_bits(prop->shadow_addr);
+	mqd->shadow_base_hi = upper_32_bits(prop->shadow_addr);
+	mqd->fw_work_area_base_lo = lower_32_bits(prop->csa_addr);
+	mqd->fw_work_area_base_hi = upper_32_bits(prop->csa_addr);
+
+	mqd->cp_gfx_hqd_wptr = lower_32_bits(user_wptr);
+	mqd->cp_gfx_hqd_wptr_hi = upper_32_bits(user_wptr);
+
+	return 0;
+}
+
 static int gfx_v12_0_kgq_init_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -3334,6 +3372,38 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
+/*
+ * Compute update_mqd: patch queue_size, ring/EOP base, CU mask and priority in
+ * place and forward the write pointer, keeping the firmware-saved rptr.
+ */
+static int gfx_v12_0_compute_mqd_update(struct amdgpu_device *adev, void *m,
+					struct amdgpu_mqd_prop *prop,
+					u64 user_wptr)
+{
+	struct v12_compute_mqd *mqd = m;
+
+	mqd->cp_hqd_pq_control &= ~CP_HQD_PQ_CONTROL__QUEUE_SIZE_MASK;
+	mqd->cp_hqd_pq_control |=
+		(order_base_2(prop->queue_size / 4) - 1)
+		<< CP_HQD_PQ_CONTROL__QUEUE_SIZE__SHIFT;
+
+	mqd->cp_hqd_pq_base_lo = prop->hqd_base_gpu_addr >> 8;
+	mqd->cp_hqd_pq_base_hi = upper_32_bits(prop->hqd_base_gpu_addr >> 8);
+
+	mqd->cp_hqd_eop_base_addr_lo = prop->eop_gpu_addr >> 8;
+	mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(prop->eop_gpu_addr >> 8);
+
+	mqd->cp_hqd_pipe_priority = prop->hqd_pipe_priority;
+	mqd->cp_hqd_queue_priority = prop->hqd_queue_priority;
+
+	gfx_v12_0_compute_mqd_set_cu_mask(adev, mqd, prop);
+
+	mqd->cp_hqd_pq_wptr_lo = lower_32_bits(user_wptr);
+	mqd->cp_hqd_pq_wptr_hi = upper_32_bits(user_wptr);
+
+	return 0;
+}
+
 static int gfx_v12_0_kiq_init_register(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -5543,11 +5613,15 @@ static void gfx_v12_0_set_mqd_funcs(struct amdgpu_device *adev)
 		sizeof(struct v12_gfx_mqd);
 	adev->mqds[AMDGPU_HW_IP_GFX].init_mqd =
 		gfx_v12_0_gfx_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_GFX].update_mqd =
+		gfx_v12_0_gfx_mqd_update;
 	/* set compute eng mqd */
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size =
 		sizeof(struct v12_compute_mqd);
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
 		gfx_v12_0_compute_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].update_mqd =
+		gfx_v12_0_compute_mqd_update;
 }
 
 static void gfx_v12_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *adev,
-- 
2.49.0

