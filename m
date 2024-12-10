Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A532AE7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 03:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CEE510E5B9;
	Tue, 10 Dec 2024 03:53:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LFmDLGSp";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D1F10E5B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 03:53:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eszq5yznEI/XTOEYiNqejmvGDzzjYqkCdd3JFDdyFZWKA14oRl2CcPcnx+RHCQJi34SIo9q/fsPifP2hEnIa+dlZU+FevB50JV2I3IP9n/oYGJWg6xuAHek+pYDOEP4HlP8Bmm4fIE9g172gQYC0ZRKXiTo4R5MUDCs2/jNmpl5csSItd0BFWO/0sDeGVx+WN9TvQV9E5fkLfWUKjJzNPHE/jn6e2rb2h/5Tlx1b9KzsKmlMWwt86J21Byd+8bmTMxvTIsyRN1F9zjnzOU80wdY3gODshMz82IQHgahve3e568WalkADrR0+YDgX32H1RFXpsJLsF8PHKoo8C4GxKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkIavlwKuLoHbgIYavC0MEWDGza+eB1O1rje6epX1gk=;
 b=DXGAUCjEFIh704e30xEJ+WsulmcWqk4vZKivCXsLwzcEUnZYqaCNnYKxydOZXyI8Tzc6HN3/XbyD4paaQan1vXKxGAnvEuh3YGOQvN2N5m2L3LfVU87yiehpF5sPf8RLUOfJgXP3FjyNxcvkUBZmZag7E6X9qwpS59AKkHJYavvgVPBEkX2NVrNESmeNcIvhBQWviZ87ya+LCYVdADeMaAdyumTa9abzjJIWsrrPcRpT2uSfglQdgBSgGdu7LMhH6BE7tj3xMFfpH4MmXTX+h2uTXVS+pKTR09I8SIG11LVBA9C7nR7zRbg1K3qD5aMP06ikCP3DdfyGP6MwvDk7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkIavlwKuLoHbgIYavC0MEWDGza+eB1O1rje6epX1gk=;
 b=LFmDLGSpS4reGaDG5ZiX2MfefibenjMy21ctwEwYKicVwblD0Sv+2Fs6/TRhCWwwVxAZ2s845w5HPsp+VSR5Bp1Jd2ZDvcaynFgSDCc6H8QHEOhI+sRPAKRyUojMtV5zTm7QGfIuEdaiFOREGoXBJRNzfYmuxPbn3st74rgc5ng=
Received: from MN2PR12CA0009.namprd12.prod.outlook.com (2603:10b6:208:a8::22)
 by CH3PR12MB9217.namprd12.prod.outlook.com (2603:10b6:610:195::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 03:53:16 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:a8:cafe::b8) by MN2PR12CA0009.outlook.office365.com
 (2603:10b6:208:a8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Tue,
 10 Dec 2024 03:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 03:53:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 21:53:14 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 21:52:36 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 9 Dec 2024 21:52:34 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/mes12: Implement reset gfx/compute queue
 function by mmio
Date: Tue, 10 Dec 2024 11:52:34 +0800
Message-ID: <20241210035234.2158943-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|CH3PR12MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: c31e0ced-3ce3-4fd9-f9b9-08dd18ce2d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tKAJqiKtWNAhz0milYsWTWG9j9UNCV3NwMaYe4jzj3nNKvSqytXkZkxlBsgh?=
 =?us-ascii?Q?HTHexpGAHqxa5ARMmLEJHsQ3K0d+huCAIvQodxRHc/siiuBgi8q8oHpFtf0W?=
 =?us-ascii?Q?B+SECyisynuGGrCvRfq7NvRpPtcFSDdzjgl5hoXdFauxtm3G4eq/gJct6vfI?=
 =?us-ascii?Q?gjBKrEneM9+d+AVL42mJUV3COdLmNJmWGmf5mbKSaN3BTiklyE2cMm9hC/Zf?=
 =?us-ascii?Q?7PChj+1fOtjJ5Gdvbu4zx+HsYU/IVKrJyxnydXyNCMBsQOLeSgVyekVVpK5G?=
 =?us-ascii?Q?O/wI9eWVUqLDsgzSA3imphvVtr4WacHYpsZY7ISQnXAMM0m25LnZ7Q88uGLg?=
 =?us-ascii?Q?7KfCohLVsr3nn6XKNKbUkZUsYd1Wdc8f+E9jzKXtBvEnQMGw2lY6iqBZ9RaF?=
 =?us-ascii?Q?/j+5yEKMwKpNTWqmTtKkya5043TAo81VxaARDafGwgaX76FKXziAaKX+Jy9f?=
 =?us-ascii?Q?2tvG0UjH5hapOgzhdTyLG/tpFEdWjbdr0fyyVREc3w3shzVjgw7ubbOd9Nzc?=
 =?us-ascii?Q?FPxVxPglbIEw75s28TJbIaYUQVOdSCcHRGcu2wPvsUReX0ItHokWfwfFULXp?=
 =?us-ascii?Q?AFdzzUPGT2MBJi/H2N3MW1JRr6J6PIJ164y+/N5lmRRjpfW3lDmAgDCMAT0Y?=
 =?us-ascii?Q?YXXDFBEbYbRwyev6QihVinQexvZ0MlL5WVpbmecqz0PWu+7NffX1IJffbI4o?=
 =?us-ascii?Q?OXOFxxuVzHut9rEFExClyJbFd39r2rIjvrVCXNs15d0a77MX3VlT3tNRiy8Q?=
 =?us-ascii?Q?vJqmCCaIGpE3B8G0xP/VYcEBNASo+3pZdr1EaTmi6qkqz5eoUgfcMiR9Z8fP?=
 =?us-ascii?Q?+pw3/uDNAv7n2y7I16rjnsdvf4D4WE3ldvwT8u+uabPMq4c0eqponpt3cau/?=
 =?us-ascii?Q?G3e9T01NyGqU3Pn9diyAjBs81+tpcKjEeWX0Vl/25gyBd1uj+LwDUvFJZegg?=
 =?us-ascii?Q?esTuqn5kFjnvqWQOLfBXxCY5Q6qYD+s0GNcIsFl9evIGTt2NJC+sMrdQscVn?=
 =?us-ascii?Q?6B63UhDKtNhQgaesOpB+qDE5If2p6hNo1LbLr8Rt8EKmpCfQT6Hi8gdQlmxG?=
 =?us-ascii?Q?Vgu0DSKj6r7IIpoZp4HPPHy5M1YKzYUk32uC5gahqa0XWPplAsWeOnhWayNE?=
 =?us-ascii?Q?4biGLJXOuTKYjPfG4eyTBtWnx8VyUSANyVs099EwxG6snpyLnoXghg3qZpgG?=
 =?us-ascii?Q?1TtUPiBzT+O0PCfvJmAYsz9jePAXfC5K87fbLvdiHm02T8RaPeFI/zkinI8O?=
 =?us-ascii?Q?P0ZYNVuG1Imu0MmKbL/odZhMgWbgzyafkBXNmnHwqOqQyB9lRZwjTU5jEHir?=
 =?us-ascii?Q?xqbKK3ojNwLm5w9mUAza3aS+mKMCfan8vODNEO2mzVT9QR5lInxBRVmYa2tV?=
 =?us-ascii?Q?9adhoH4XkehjqNr3tIO6rQc0K/l34+7llwXyuOXcTufwbbxIjjKME9/GA3Ta?=
 =?us-ascii?Q?lb1m8AzCk8TngrUUCpRFBBlcN/sZ6LVs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 03:53:16.2568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c31e0ced-3ce3-4fd9-f9b9-08dd18ce2d91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9217
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

Reset gfx/compute queue through mmio based on me_id and queue_id.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.h |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 88 +++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.h
index bcc9c72ccbde..f7184b2dc4e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.h
@@ -26,4 +26,6 @@
 
 extern const struct amdgpu_ip_block_version gfx_v12_0_ip_block;
 
+int gfx_v12_0_request_gfx_index_mutex(struct amdgpu_device *adev,
+				      bool req);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 0f6635ee84a5..d24a0e7fff15 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -24,6 +24,7 @@
 #include <linux/firmware.h>
 #include <linux/module.h>
 #include "amdgpu.h"
+#include "gfx_v12_0.h"
 #include "soc15_common.h"
 #include "soc21.h"
 #include "gc/gc_12_0_0_offset.h"
@@ -350,6 +351,38 @@ static int mes_v12_0_remove_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
+int gfx_v12_0_request_gfx_index_mutex(struct amdgpu_device *adev,
+				      bool req)
+{
+	u32 i, tmp, val;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		/* Request with MeId=2, PipeId=0 */
+		tmp = REG_SET_FIELD(0, CP_GFX_INDEX_MUTEX, REQUEST, req);
+		tmp = REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX, CLIENTID, 4);
+		WREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX, tmp);
+
+		val = RREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX);
+		if (req) {
+			if (val == tmp)
+				break;
+		} else {
+			tmp = REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX,
+					    REQUEST, 1);
+
+			/* unlocked or locked by firmware */
+			if (val != tmp)
+				break;
+		}
+		udelay(1);
+	}
+
+	if (i >= adev->usec_timeout)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
 				      uint32_t me_id, uint32_t pipe_id,
 				      uint32_t queue_id, uint32_t vmid)
@@ -360,7 +393,60 @@ static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
-	if (queue_type == AMDGPU_RING_TYPE_SDMA) {
+	if (queue_type == AMDGPU_RING_TYPE_GFX) {
+		dev_info(adev->dev, "reset gfx queue (%d:%d:%d: vmid:%d)\n",
+			 me_id, pipe_id, queue_id, vmid);
+
+		mutex_lock(&adev->gfx.reset_sem_mutex);
+		gfx_v12_0_request_gfx_index_mutex(adev, true);
+		/* all se allow writes */
+		WREG32_SOC15(GC, 0, regGRBM_GFX_INDEX,
+			     (uint32_t)(0x1 << GRBM_GFX_INDEX__SE_BROADCAST_WRITES__SHIFT));
+		value = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
+		if (pipe_id == 0)
+			value = REG_SET_FIELD(value, CP_VMID_RESET, PIPE0_QUEUES, 1 << queue_id);
+		else
+			value = REG_SET_FIELD(value, CP_VMID_RESET, PIPE1_QUEUES, 1 << queue_id);
+		WREG32_SOC15(GC, 0, regCP_VMID_RESET, value);
+		gfx_v12_0_request_gfx_index_mutex(adev, false);
+		mutex_unlock(&adev->gfx.reset_sem_mutex);
+
+		mutex_lock(&adev->srbm_mutex);
+		soc21_grbm_select(adev, me_id, pipe_id, queue_id, 0);
+		/* wait till dequeue take effects */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout) {
+			dev_err(adev->dev, "failed to wait on gfx hqd deactivate\n");
+			r = -ETIMEDOUT;
+		}
+
+		soc21_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	} else if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+		dev_info(adev->dev, "reset compute queue (%d:%d:%d)\n",
+			 me_id, pipe_id, queue_id);
+		mutex_lock(&adev->srbm_mutex);
+		soc21_grbm_select(adev, me_id, pipe_id, queue_id, 0);
+		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0x2);
+		WREG32_SOC15(GC, 0, regSPI_COMPUTE_QUEUE_RESET, 0x1);
+
+		/* wait till dequeue take effects */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout) {
+			dev_err(adev->dev, "failed to wait on hqd deactivate\n");
+			r = -ETIMEDOUT;
+		}
+		soc21_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	} else if (queue_type == AMDGPU_RING_TYPE_SDMA) {
 		dev_info(adev->dev, "reset sdma queue (%d:%d:%d)\n",
 			 me_id, pipe_id, queue_id);
 		switch (me_id) {
-- 
2.25.1

