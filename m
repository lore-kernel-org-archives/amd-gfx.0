Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D508F531C1
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 18:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8856E10E505;
	Mon, 13 Apr 2026 18:34:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rgv34VFz";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011013.outbound.protection.outlook.com
 [40.93.194.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1300E10E503
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 18:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSkVFwIsu3fecNMEAVTVnqJOfK2ZjwoE8mrf4eVlrifY0hcUZMo0TWScTz9cq0U082jCeDS76KXu8+Z3G+Ymu0sLiLboHYgDw/Ea6IWQCoVgvkP09cSDC11Fi87A1r+8BJd8uU8EkNjehPB9SeIwabNf9ej4nIWTtKLYaW7vSzBL0BwMsQ/zPaziyVcY187PQp6JelQRhCO2VzWWJ1X3o5aJGdd/O70Y2m/tk054OU1W+iPBpfY+GjhVlNwnQHwVoSc1F0rAfB1X+7m0U8yJL0DFwJapEjL7xmoiy1tiDgixRU4DxwUwOsN409mH9p4Tvdpo86Raoc7UDpBakypnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlgIkcVaYB2kObhDcMTS8hENz2tukXJVWwWGSkqYvGU=;
 b=aTJLOmnDCKJUaYOg3PpTAdjMrU9UCY0Evcxn6jmF+BwnF77nD/3CwYw7YjKOI32XPhTqRHc1nZ6hRPl0nl9ocrjwEt5Kzp1N8nB7SVDnd+Z8MhKF+w3w5e7oLqoc00pDYaaoCcVXEr10JSwZ3w8wM+b97sy6rCNI6NsUZnkcnTd3ylvqvrAuHjwlLZxHKHnUb4ByFMIHKiBaf9+O/3QamZ2hZYnMGH9Mz3ileqGzd5LCWgG5knqP9gMNaIrcNFaDu6c79x/7rn2LswGJxsbPSE8bi5WT8UlzJD7BRrugu9m3m3brTO3WOM92gpIaPcekuG+ZByVS699QEVUbuCS4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlgIkcVaYB2kObhDcMTS8hENz2tukXJVWwWGSkqYvGU=;
 b=Rgv34VFzL68kftvALjI/M/6y3UfYn0x+ntCFsvRRfsthjmVv+PcVodoTjMdYLco1sreTDxl1ux254bCc9c3X0hkyyALJjhTzMwgob4/Ea2QPB+KWleB6QLJcm24++9cyPhQ94GH9jwuoHt/WQIGDgHz3KSHC5Y/L3Tb4zme0fXE=
Received: from PH7PR17CA0026.namprd17.prod.outlook.com (2603:10b6:510:323::19)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 18:34:45 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::5b) by PH7PR17CA0026.outlook.office365.com
 (2603:10b6:510:323::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 18:34:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 18:34:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 13:34:42 -0500
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 11:34:42 -0700
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexdeucher@gmail.com>
CC: Amber Lin <Amber.Lin@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH v4 04/10] drm/amdgpu: Create hqd info structure
Date: Mon, 13 Apr 2026 14:34:20 -0400
Message-ID: <20260413183421.3191963-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: 55df1728-1b3e-4368-14a7-08de998b553c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: CC2NjjJph5TnZ/pCT5FcFcpE9hpzeBXWTS8nPpqWNOIVxmWjeVzD8y71sr9CcpqRsTms/wVYLzn+EdIe2a4M1BZ5L3rCmXcw88BwTQ5Z/5Ligagpj8+XP0wVv3IVRwm0H7WvzfZ7FzeR7IlJ7Kzcwf3xWDuuz7aMqRuvro6PlcuKtuRiP4C1nQRArL/BBD9//RCbz4grj85twmVzOd/Trl43JU5f8Bobv52g4KlUZdKEzVVJcMDl+P8hWQ5fecSM8cbP/rNvY0Rx1d1lXJko2bCSbbXq2qlUDmaA41TAaYUcBshRhAUDQ6wCVhpnEAoUu2nlIsmunQY/LJ4LiiCCiiM4JTyX8RP7S1f5k3lf2CUkHc25Ww/gjtiSwubp7iaaoauzmVG3z8ZzNl0GIUnNNo1hnPuhtq0dHPqcFCrPUBbd5EQ+nkIO9xGJqhFRnEPWINVjSF4ij/CONjOODpgcYEWFEHHobtg58+9z2aAvuPJtcvm91DIf51+A9lc/DGyQnVdCXdih/u9JemSUgIlGvE+t8/0/dSqovBR+Kb3WjgRU1PVmR59CC+i+zNZcWS5GUBHjUpql1NznLiE6yEAnIKA+0yI2cy10KqYVBjFQTEExWvm9CqBq6w9HjQFz7+Xxa0rRll9+NMRVS6jjiXGQDWYxM3rdf/m1J45uBaMFn501aPKvnSVkACC4iGE9ETocDcolYdxQolA3L9aCIscoCi0yv5rv1CUXrXob6Oy7rS03Okje5H2nX3DyRo1TGBGmyKd1M678Wa4dcRQs3IVSKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pZCtcjumJACEUopVsUV9TLwEHzZt/gQt8EJ2F+ZdUzPv5iOkM4t32u3T70DhWnLuPtuCo/PmMkVWi8veeUQjUZmZMmhRHF6ln8tBm9HvuMfk7Jg6L1xNC72No0JQJM76QrjWX2f9OFZAP5bfRaJ7unX+uguARsCiyLoysYmBlWItRW1PIHpz3fYqHN8fV+Q1chAHplYCiXT4NsZYgQNl00VOtx+/ufnqlU4JP5Y5yqUeWGH/7JApZ00+RfMd+nbIi1GJ1TXXiS1xwEHkC7rAO+oi4uYLwU4s+z9yG5fI63DreZyWKt3AztTK85snmIDWQftwPIeVLZv9arvPSbS6cPX599L9CvrZY6ckJQji2h7FCmoTcYWmj+9fvKTdryfswf/lu7F7Jb7PXQqp08FOa8q0IIR5AOv0GjPMdEp0rGyPuvbz54DPXqNhyKYGTh0X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 18:34:44.1829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55df1728-1b3e-4368-14a7-08de998b553c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
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

Create hung_queue_hqd_info structure and fill in hung queses information
passed by MES, including queue type, pipe id, and queue id.

Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 13 ++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 13 +++++++++++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index f1f8bbfc31e0..ae42fbaba34f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -447,7 +447,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 {
 	struct mes_detect_and_reset_queue_input input;
 	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr[xcc_id];
-	int r, i;
+	int hqd_info_offset = adev->mes.hung_queue_hqd_info_offset, r, i;
 
 	if (!hung_db_num || !hung_db_array)
 		return -EINVAL;
@@ -481,18 +481,13 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 		}
 	}
 
-	if (r && !hung_db_num) {
+	if (r && !(*hung_db_num)) {
 		dev_err(adev->dev, "Failed to detect and reset hung queues\n");
 		return r;
 	}
 
-	/*
-	 * TODO: return HQD info for MES scheduled user compute queue reset cases
-	 * stored in hung_db_array hqd info offset to full array size
-	 */
-
-	if (r)
-		dev_err(adev->dev, "failed to reset\n");
+	for (i = hqd_info_offset; i < hqd_info_offset + *hung_db_num; i++)
+		hung_db_array[i] = db_array[i];
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index f80e3aca9c78..2e6ae9f84db0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -170,6 +170,19 @@ struct amdgpu_mes {
 	uint64_t            shared_cmd_buf_gpu_addr[AMDGPU_MAX_MES_INST_PIPES];
 };
 
+struct amdgpu_mes_hung_queue_hqd_info {
+	union {
+		struct {
+			uint32_t queue_type: 3; // queue type
+			uint32_t pipe_index: 4; // pipe index
+			uint32_t queue_index: 8; // queue index
+			uint32_t reserved: 17;
+		};
+
+		uint32_t bit0_31;
+	};
+};
+
 struct amdgpu_mes_gang {
 	int 				gang_id;
 	int 				priority;
-- 
2.43.0

