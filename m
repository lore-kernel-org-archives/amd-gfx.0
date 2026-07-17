Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A257C44507
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 10:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7011210F4E1;
	Fri, 17 Jul 2026 10:27:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lbg2Bs8C";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013066.outbound.protection.outlook.com
 [40.93.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D84F110E432
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 10:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q++khTsfrzLjjSUhYnWmf3SYwrZxPAyx/vInI+SH4PLw4vgoedYZwlHCqRnHf+n/zIMrspKjzfO++CT32EDzZm9IKKW67auAtJsASxOsXjibpTPbMOaRXc7KdHo/ETYl4TYS8hmbJ6kznhdiBHuLoPD7U1EPC/1JJClC2jR8wHosFyACpS5GTM4UZEkloEkqLaqTrLZmojiJ/TU/X4BQmR7HLxkG6AsGz1wOu9P3/VRLufHHqGgZX+8oJD7w49AvB6MsO9cPxYZGma5jO1+AXI76BY3WaPSK7IJiFq6ZLZvN9wDAG3+ePRmn0VafJwlldbAx8P5j4qaj2PGAM82jgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMw7lC2vfU0y7Cz7MsZyicR2NKZGve6a5s4GxNOapgE=;
 b=ewydgc+jEWYxH7LOC7l06TrGF4MWH//4zfgsyF/9EpUWdcZqaN2FDrnt2svncuDJgtQvMgCjpEdk06kVTSpeHO4ryiToHwhEXMikNSubEi+b5PrU6LYooz9Y8dG7KIBB5k1Bg2cY8d0aonulOvYNaj6DyDpFolrDENSQ7hU7h2MxPaDtcXeg8ff+2lBHkAr4Cr/hwOiuTUdqDG1cFNV2T07zTx5SCw/VmUlq1DhIoDW1THWyQ8GSGy//zlBDuYImLJAbyMKeBDySXZxOBOBCqLhY0HWywU9bDGM53qmSCIHraV1MMCQHpqCyaIanH1D8qp+cLiZ0gStsRO6DNND6Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMw7lC2vfU0y7Cz7MsZyicR2NKZGve6a5s4GxNOapgE=;
 b=lbg2Bs8C8garSnoQdDY5m/ZpZryNoXcFL7GoLrAnxplZ6WmP1Uc7pdHh9PbBET0xJqnxEfxFiC8HNqKMmu2JDWwHcqWyw4DEl/B4/sYeYQc6bw3A77EIjnesKiMM5yJuK771wqRNs8pqFltxF0FGEDg/3HO/4WttYnGHlLub3wA=
Received: from CH0PR03CA0310.namprd03.prod.outlook.com (2603:10b6:610:118::33)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 10:27:01 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::4f) by CH0PR03CA0310.outlook.office365.com
 (2603:10b6:610:118::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend
 Transport; Fri, 17 Jul 2026 10:27:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 10:27:00 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 05:27:00 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 17 Jul 2026 05:26:59 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/mes11: set connected queue index in the reset
 packet
Date: Fri, 17 Jul 2026 18:26:01 +0800
Message-ID: <20260717102658.3665597-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9aeb6d-c0f1-4fff-dcc2-08dee3edf018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: FObWi4gQKj2q7xdCYHfmIH3P/tHHLrBXrI9sNPjXrjzHAMxKOOXX8X5CvpWvy+fPzzsp9dEgZoUttwXO8Ob1du/cfA5K0ZHTFBbpBlWJGXjYBRlvJQqFmQwIfG4I9GOLJcM4MWOdQ++X4pv0awk2wqXlzOqJBl9FnqIg6dJ4mIhTC1YQFxcZxmXROdyxyZJ7jK3KCxPjQtYrZnQtNLmFwPUBaVNAT/tqe9jSFtT+FRf+ygi/Fx9NCgJzbjxOL/9wK58SFKuWgpHqeeJlkymz4Kp8tYZb8P/TZ4VGIhd/LWt3v/CQwjxfb5sKrwzbprqOZx7EWH/J+xYJHhvAWv6TmmIAhrdFEfTudZ3WTh72wMU/358GntY93rzbkvJVWM1YxFVmVxPyCCgAvL3bcH0C6sB4/g1PS54Q02oZhYd1vImHRgLZDqc59lG1hmopgWjYhVZL1fb7qOqO1Fn5Yraiq7docLDgrKJANWmVGJiFPbhV3MW4Is+M0+U3B0l4Eit7yvkJJ/cnO34KxrpJDtIb5zXsrQdt8057TuXLpfrqDisKHhAAfiyK7B9r73+P4AOr/Nr75Y1CyW1/Afh1+QPioYihhusTqjJ0Q3FyHIohinU3D7dI9Kqe6m17FXa44b+lDts/CNQQ3CPZ/2xiqWWGMqZrECsh641SRnvzacmd6OnXNz9HwrDWNNEqNDssfc0RkBNmBBZn7yTQMrKtjRg2bA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i/1iXdqPlnl2qWIzKfKTC3LIcitMY/HJYWpcdLA60LrBQzIjSwgxEiX2n35caBvk8TinYGU6WQ8LkZ7HrtqY9l4MJzmsuHvX0G1OoV1k0/dDDRPoNVzZPF4kviepdnSB59dNeLHy/FBsLJj9A12qEwGgEw2HEcgx7f3btDSrX1mNrjwdCVkmtHS3KeBXpWUSfpuQSqObOvd5x++O30IPLnNGeH/KCVxMGNzeVoaU4Q/IvCd27LY7S998LeBVIEUj1+y3oCPtBfTEMz/NQl85FctfZNnnW4XKcUceQ1lsF4NTcJtqXcjrNzp9UrXxXNYvDsTJTAyvQmVPJEb3wq9MqKgXDPW9It2uGHUgdQou9zCMWmj4gjWeZs8IU3YsflZeuPsB7jxCKjtKztLZMtzBYp+b5dWSDQmiZLtKwKfpVgwN6wDILwn5WNiDU1A6J5V6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 10:27:00.7545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9aeb6d-c0f1-4fff-dcc2-08dee3edf018
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120
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

Sync MESAPI__RESET with the firmware definition (the
use_connected_queue_index[_p1] flags and the trailing active_vmids /
connected_queue_index[_p1] fields) and program the connected queue index
from the detect input, so the MES can locate a CP-frozen gfx user queue
via its CP_CNTX_STAT fallback.

An older MES firmware ignores the flags (previously reserved bits) and
falls back to query_status, so no firmware version gate is required.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 11 +++++++++++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 11 ++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index b72da75dd851..3e6d3b5e9af9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1115,6 +1115,17 @@ static int mes_v11_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
 	else
 		mes_reset_queue_pkt.hang_detect_then_reset = 1;
 
+	if (input->use_connected_queue_index) {
+		mes_reset_queue_pkt.use_connected_queue_index = 1;
+		mes_reset_queue_pkt.connected_queue_index =
+			input->connected_queue_index;
+	}
+	if (input->use_connected_queue_index_p1) {
+		mes_reset_queue_pkt.use_connected_queue_index_p1 = 1;
+		mes_reset_queue_pkt.connected_queue_index_p1 =
+			input->connected_queue_index_p1;
+	}
+
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
 			offsetof(union MESAPI__RESET, api_status));
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index a8e6ccc7817c..2762b55f3474 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -468,7 +468,11 @@ union MESAPI__RESET {
 			uint32_t                hang_detect_only : 1;
 			/* Rest HP and LP kernel queues not managed by MES */
 			uint32_t                reset_legacy_gfx : 1;
-			uint32_t                reserved : 28;
+			/* Fallback to connected queue index when CP_CNTX_STAT fails (gfx pipe 0) */
+			uint32_t                use_connected_queue_index : 1;
+			/* For gfx pipe 1 */
+			uint32_t                use_connected_queue_index_p1 : 1;
+			uint32_t                reserved : 26;
 		};
 
 		uint64_t			gang_context_addr;
@@ -496,6 +500,11 @@ union MESAPI__RESET {
 		uint64_t			wptr_addr_hp;
 
 		struct MES_API_STATUS		api_status;
+		uint32_t			active_vmids;
+		uint64_t			timestamp;
+		uint32_t			gang_context_array_index;
+		uint32_t			connected_queue_index;
+		uint32_t			connected_queue_index_p1;
 	};
 
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
-- 
2.49.0

