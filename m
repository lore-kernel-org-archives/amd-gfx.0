Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DA9C624D4
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 09:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED70C10F4A3;
	Thu,  3 Sep 2026 09:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="10WJsmqC";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010040.outbound.protection.outlook.com
 [40.93.198.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A8E910F4A8
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 09:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o39bTS5YT69yrSOGdHh8lizz+7HiNSM1V9RAikoELOC6Z7XpAoS61OCVWNuA5EGeIuZnvJ45YlO3JzUC9FPH3ckBhzm3eyibW+yJ0SAMpTrs3gp1k498Vye5vIl/HonYTA8DR32E7aY/yJrx+G7g9Ld6oAdvYwPVPBRObMTjvOvj7MATVX2jI/yM8+0zCU0T4ZyG7pCcV85YgoLKVWU7FT4NB9MhvP9mMgJjFvQ744As9jpCPIT9IehHJ4ZbD/gN7F25i+vmTaLw6aZJWJj8PcDfnZfCWe+0I9lU9CUdUF6LlqUjL/pEdSU9FrsDV1YCGaqfDUJcpygfrSpJzYA5Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSt4wtBqtofLGE9fiRC0wdXFY/TRvTtNYYQ+1/CZOSc=;
 b=xLiidDgCgfj6U9I/YUHvlP1y6u5guzjzTyn/Lsxux4RYuUEnkxfEvc9G8/6GADzMxszXkMsTPWyVl3ZtSc+lmRmdVzRvXCin+IZlxnG9BaMP55WMKGBSSC6hn6cC/6dlmi4ec0ZZa69KW60a6tP2E4lnezF9rEQmRTGny/IDDw10vHdCPFn/T3kx52vP8809q0giRSPIJ9iTnJ4yUOeuUPNZvmX/y1br9C0EW/V01i2cW8F+QyU39fTppKSratNoSE7GCg31OQTWf+tFQ5KTsv1/zdXQ5bUTb5+rHwNMlKsE1lDpqcFGRKKRf1FvzKs2nxZnyrPD0GFFr0MYxLEbCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSt4wtBqtofLGE9fiRC0wdXFY/TRvTtNYYQ+1/CZOSc=;
 b=10WJsmqCr+n4LTzWOSWAU/MURAXWctUrCPBpZ5Pcdl90NgtPbnV86FSTfrNiJAtL+0q0UoKpSBYqnSlVPDwI0SdY98HFR07vD4i0x5Yvlt758I+UGKrfb3Ho9pfNWkc5s+ESp9IQxS0TgJXpt8iE1/AGzUYo2WMvVaPMXSfncj0=
Received: from BN9PR03CA0415.namprd03.prod.outlook.com (2603:10b6:408:111::30)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 09:44:45 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::5f) by BN9PR03CA0415.outlook.office365.com
 (2603:10b6:408:111::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 09:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 09:44:44 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 04:44:43 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 3 Sep 2026 04:44:42 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/sdma7: implement detect_hung_queue
Date: Thu, 3 Sep 2026 17:42:05 +0800
Message-ID: <20260903094438.3880682-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260903094438.3880682-1-Jesse.Zhang@amd.com>
References: <20260903094438.3880682-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: e24c67de-892e-4241-93ff-08df099ffc0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ncolM5bJ84HPxBOJetZElLf9lCKIw5AAuGWpITsBymNXt1VDH4SPWvPLP7GBPWvXAvi6umEcTmMCQvc5YPq63nZjMbvUPM9Wf9eW719rloWK00WymzmCNqxWlUwgVAPSz7zmLZzoYjylankSJGeJ/Mo3Ug5jhFoJEaAASGWts0u/CiCEieFmsax73l6N39UIVaZoTvjfCDSPjcjXeVuG4UHAIPb+mTSXmrZn3yudK/ZwK8epPaVspxRA0Qs4wPuZqz2vCf7W1AHTaqrbp1hvfbnno2D8PhGLJiuHB1FlgENVlOo419HUu9YVknrMeuMe1R925/LWo/m6o2q//4xwxmxVXqlsN+PVz/mPVmvfgHgIwDqZqUtapkMGvyzWXAdTtE+pkJiGtM41KkLd6rRjJirWm8pxDXJOCH5XNVLni12YFz/2J/i62WU3/ZTcL4+R7PbzeGvMIDCR9rx9L6+jkIcBmf1mfm25wL/YrYk/vYhckSH3YPS1bBRuImpW0sOyoJPC2WGNZ71zw3loxjzJGhzgzBOTOR8c99PhVTWGvMBO6HgRsgDmyZIeZ6nIvDkkpMaZYQjLeDFs6otnq7X/S9i3SSSlb9EPl2S+ezBd1NXzyIjZqkUc6lxbi6/p4NdrVm2KAmptzPmJAjbR2rii96XfUOiUrw4dT04+VgzwcHaELHGw1TVKEG4DYcR9F1Hexr6EZH4afG9UU9slq3ZOSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KiQIEeTbTkZBZgAq01eIcZAdyAHZPKQSLnB4gErGm3vznMyQ7yG5uMDhWWL4v42UccrJUd8TJx0uEING+Lq118bSec5vil4zv8oVNK/kDHDY2wc9GP4DYU4EcACJARhrylICbb8i+pB+Qg5miPlmhmFMUpkhEQBWIHcZMqBbn3lRa60Mg+yVfrHK7EIvC4pU97JfvIyju23cjYPuvAYhDxma2lgSCJWNrTKQF4KLBiW7VznBLNzM8VojupEdfO2RE/J3DEq5S1su2fR2hD/C//GJ9jAD6j5c02v8LsGltYxNEfc9cKu6M9/JvzLg+Nj+Cllv4qW5L1Nkf0WctfYeoix3bfbiwDPEaAnIGrJe8TelZDYGQBESs+mQbOFA/W7/LC238Bom6sDtHv75thpYB5K1Mz5CYgViHncVMyLUfWC4cTNFABqv9VSSKb6DMq+r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 09:44:44.2798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e24c67de-892e-4241-93ff-08df099ffc0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232
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

Match each SDMA queue's DOORBELL_OFFSET register against the given
doorbell to recover its (instance, queue_id) HW slot. The per-queue
register stride is derived from the named QUEUE0/QUEUE1 registers.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index d5552f206e4d..c55c941b82cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -784,6 +784,34 @@ static int sdma_v7_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return sdma_v7_0_start(adev);
 }
 
+/* dword stride between adjacent per-queue register banks */
+#define SDMA_V7_0_QUEUE_REG_STRIDE \
+	(regSDMA0_QUEUE1_RB_CNTL - regSDMA0_QUEUE0_RB_CNTL)
+
+/* find the HW slot (instance, queue_id) whose doorbell matches doorbell_index */
+static bool sdma_v7_0_detect_hung_queue(struct amdgpu_device *adev,
+					u32 doorbell_index,
+					u32 *instance_id, u32 *queue_id)
+{
+	u32 i, q, reg, dboff;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		for (q = 0; q < 8; q++) {
+			reg = sdma_v7_0_get_reg_offset(adev, i,
+				regSDMA0_QUEUE0_DOORBELL_OFFSET +
+				q * SDMA_V7_0_QUEUE_REG_STRIDE);
+			dboff = (RREG32(reg) &
+				 SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET_MASK) >> 2;
+			if (dboff == doorbell_index) {
+				*instance_id = i;
+				*queue_id = q;
+				return true;
+			}
+		}
+	}
+	return false;
+}
+
 static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 				 unsigned int vmid,
 				 struct amdgpu_fence *timedout_fence)
@@ -1694,6 +1722,10 @@ static const struct amdgpu_ring_funcs sdma_v7_0_ring_funcs = {
 	.reset = sdma_v7_0_reset_queue,
 };
 
+static const struct amdgpu_sdma_funcs sdma_v7_0_sdma_funcs = {
+	.detect_hung_queue = sdma_v7_0_detect_hung_queue,
+};
+
 static void sdma_v7_0_set_ring_funcs(struct amdgpu_device *adev)
 {
 	int i;
@@ -1701,6 +1733,7 @@ static void sdma_v7_0_set_ring_funcs(struct amdgpu_device *adev)
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		adev->sdma.instance[i].ring.funcs = &sdma_v7_0_ring_funcs;
 		adev->sdma.instance[i].ring.me = i;
+		adev->sdma.instance[i].funcs = &sdma_v7_0_sdma_funcs;
 	}
 }
 
-- 
2.49.0

