Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4541099B37
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 20:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0B2510EC13;
	Fri, 20 Mar 2026 20:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZnjVAIfm";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82C1F10EBEE
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 20:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVHkTcYIEIkq9vadq0ZOSLqPWAWtNiLzdwOySzgf2/yI3fNAzsn3yJ7Y/C4NffOXjKI/u1pq0rEdLggKZkDvYVtKW0u9upRJD1Zno0J8Ya3b5et2LlpSBzM1RFRY79DNUFJculF3AU7JCCza8aT9gQUXKBrFfi2VXZcQP9Pw8oteXQfNhamFMQZR6Hv2nWgzTdTkV/3tDzDFsqgA7A8PrpnDKcvC1PZLykjsE9gWi91Qy00EX38v4a0dmQQJM2gsV66e393lwfNCoiBWslbqqzg4YFAh6SWlPWCPuCPTvjY0E1EyD+feEkF31o/JJbS4v2uR1nXpMXjyaUn3OYIZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H01KsWHL3Zwf5vL0l/UDCCVSQzAqvUPRtDL60xkXNLM=;
 b=BtCcPIKvQ5yVG34uDVUBvChOMDgyX0Wl6MTfB4E/kVMFMujnVlOIn1bxEY4CFW/V1pZDqO3YPDE6IukrTLFN3C9apiMVWUr8H+W2suep5y85iUgxJWOGV6DDlW5qyKbX2CcTafHAUsGjGGfc75jYBUGDdQ41KWJZoOgJ8JD6E2/9ETUNtu/1Vhf9HZDMv1EjZR4zPk8kGnmR3Q6LSueINyFNwvvkBDvbFC7Pc6i6zSUuLyJhBBKi5v61wYJeJA2l+favCB8Rw0RFUtExJbNYrWrfFzLmvgdSdncTJTfdiVBdsHTJFG/Y4UyC2y73T5nFvFBkTRw5gMW9D5r7osI7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H01KsWHL3Zwf5vL0l/UDCCVSQzAqvUPRtDL60xkXNLM=;
 b=ZnjVAIfmFYw4Rmg4k7MYhrUHjV4BbmP8VDjx0mV7BtUQ1RgwDgzZ3JonsfkpS1BNSzjlhyvelns7TkREJaUn6YLW9veMYMQWm0DcLSpswuIqNuBi52JMv1xA66JoM8y1NDEViXO5Ivc8TUR4lGa5FeqMlr/U+tm9XrRhyWoEImo=
Received: from CH2PR02CA0022.namprd02.prod.outlook.com (2603:10b6:610:4e::32)
 by CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 20:02:38 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::b0) by CH2PR02CA0022.outlook.office365.com
 (2603:10b6:610:4e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend Transport; Fri,
 20 Mar 2026 20:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 20:02:38 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 15:02:36 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, <Jesse.Zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH 4/8] drm/amdgpu: Create hqd info structure
Date: Fri, 20 Mar 2026 16:02:04 -0400
Message-ID: <20260320200208.1188307-5-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320200208.1188307-1-Amber.Lin@amd.com>
References: <20260320200208.1188307-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|CH2PR12MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 2295f0de-c055-45e9-d072-08de86bba2e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: bCBFHyhSXDKX4H+T9Gj+882HWpxcV8cFxsjJ5w5/2OYmyWVMaLtCUc/x7Z6bGfltDkJUW9IijzGNukifAc5iN7RRM3xaxHvn5q+joI13MSayZhEgXt8p3s2syNTbPL30Ka5w7eIADbSOWni7J+forSEWFGC2R1Jm3JAU/rJ91IOtUseAAlsjIFV+NvI6onH9mGGc2qAbQ9O8ZV6R6mpZFBQnZ9YulVs1DpiGhaDuMIV4VHrLF+Dv8/jvEb7KHK/lBJwbkMKujNZ2WV8Ra7qz6newjhQLsTecxwK7x1c1cVB2UIsB6y5lPEoMw78BXVn5NQrpYwOcoIqOvleElGSi1Gn/PXgOp/dSoR9K9lhVcyWzf0gRLhmGBjMlvUqam6b78DYREqmZmnnOdkQJnHvCNqCsKlOD8jjEK/Q9tvIJNVKu/EwY+X3F+YMNtOhTsXUnoeh9pPKlkV71B5/bObfok/b+zEATrNwT6aUNSFjenapuTPUoIPXcWcROL+WDLrfahOjBQ5pKnjLLIV9hd7AR43M4mCXS/n281R4bqy3NiP07sxdLyQRyeDdSP3toDLDPUkhBJSOJeq9Yrk6i1ExAK0EvCxgxz14e2AuAZeshXb4LKkbPAihleYGprlSlViWAhZxWMpT5mbNLu9lTmbzbO5+aJWybOavE3UNVmBwFJIXraHL7oSr1trR9ggfWxDWtbEa7woxNumyUiMn8YzLVkCGzGd+XCgIEYPBiVBWzKUX7x+Zdx2OWkSkVt3NCM2sV0Xpc8WmZ1gqRSjEZp0wTcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ViJ4czQJUjb0sZaGU7DVtfKS86XH9ysU0vhJaI752x/pTL5hgL8QABtM8g0rnXDFFWMbOjj7VWtro8RQ/sHf8+veU1H4X+v1vyEDWW02x7kolKYm2nN47/7U0C/ZPwsm0VqRwbadHyfiiluf9uAtBaU5VrVj7ZxSu5OanIL/0VhtB1Er7rjPhBxw0FsWhZYam+6fjn1w3hnpT+we/zAyWF9ngfMqiqbtmxDlwNTZnLDShSAxalBziQatiLsI/HxS6mF+PVC6Ek6YsumwaMtPEYFAgW0JV9ozdto0WEu4KJVARGrILbANUuZhnp8LVd65c+3HEz8T444VlTfQ0gBY1CgxZq4BYBYeObg1CmXEqHw8HWwEyQncSyJ+IfspD90FyFWzo0TtIaXduDk9m3PPvH8fkY6MXrNXQakBh4fhN4+G4KREPhcdAFPTptI7xMfE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:02:38.2826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2295f0de-c055-45e9-d072-08de86bba2e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9517
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 13 ++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 13 +++++++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index bea509f6b3ff..710bca87c32b 100644
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
@@ -486,10 +486,13 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 		return r;
 	}
 
-	/*
-	 * TODO: return HQD info for MES scheduled user compute queue reset cases
-	 * stored in hung_db_array hqd info offset to full array size
-	 */
+	if (queue_type != AMDGPU_RING_TYPE_COMPUTE) {
+		dev_warn(adev->dev, "Unsupported queue type: %d\n", queue_type);
+		return r;
+	}
+
+	for (i = hqd_info_offset; i < hqd_info_offset + *hung_db_num; i++)
+		hung_db_array[i] = db_array[i];
 
 	if (r)
 		dev_err(adev->dev, "failed to reset\n");
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

