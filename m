Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE5ACA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 01:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A22910E55D;
	Tue, 26 Aug 2025 01:47:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3YbcPUIX";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39F9610E55D
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 01:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rI+mOVEtEbVJh3MZ39oAa3pD/QuQZ1BzevfJf4WFjQVmvw/9eJdcUy8DRtzXfz9nZBtypfnCuw5n6K5/VRSj/sP4qodh5TqscD9xW0zdPv+1gnDCqTDiPvoJ89NHlUoszwqRQFi2By9bf+waO0Wa1irFY2PetS9y4e4H1Jx0rztkLiX2ZlpKIIwBSb39DLl9hiEiUV9wvP8hVrufcijf4L8KLbOT9/jZ9EVR78dvqhrujJ8G/TIu2WWieQemPMlJcDlcJGqaW7kr2I8BA+V7HfRBHlBJ60QqdPw3OUsBaUhpq7Ml6tlGyI4cBU9KEKCpdCVeL5phzABjdXuy3KGzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=VakXX6kjAuXStAYv/tE0buDTaMg82zjIAjUKNnmVKbw4Hha+2uvMo1LrUvQq0tZffKrb0WQdD2NptXIIt0cLvO2Lr5pWbnAL6m1KtXxD0cZMJtkiTeuhT8P2LjOR2aFgTrXa4REDR3sSbL35+ma1dKAmBtqnUsdX9+WydV5eCTuudLBS+d9yrwlRCJliw1GIRQsdvdV10Umi3480P0UznK81DMu68SYfhQXhFN4pNMvNtASH+DevHhyqRJBi9/tSFYdkgKVVWPgXXiJSXqtiJrQA2R1e/TXX7HZXLnyZDPUm2vzsVTn0/zVrsJtr+/DbgLyk5x23OSl3qRl0wcseIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=3YbcPUIXNJRe6e4XIxAfLyv8DOvoU8dqlNghktbLlDSmQnxVj24bMDqRbmxZ2EekGv4TDxvqhgb/MqtZIrD9CoRvYZXnC+ZHcisAdWxs2cC+nXPFCtV+r4D5/JFgqKdAliBLzQBn4hLUq7SQMUcelofyUsNXU3MZJ2mLb2elru8=
Received: from CH0PR03CA0326.namprd03.prod.outlook.com (2603:10b6:610:118::9)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Tue, 26 Aug
 2025 01:47:28 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::be) by CH0PR03CA0326.outlook.office365.com
 (2603:10b6:610:118::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Tue,
 26 Aug 2025 01:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 01:47:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 20:47:27 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 25 Aug 2025 20:47:21 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v12 05/11] drm/amdgpu/mes11: implement detect and reset callback
Date: Tue, 26 Aug 2025 09:42:15 +0800
Message-ID: <20250826014648.1711926-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
References: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: 9752bf4e-bbac-4ef3-d50f-08dde4428382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0+DMJyGQCaXoDasCJX2VQsqlmlnepn7mAMxvWxTRBfCIUqoNMOswyx+BAvd/?=
 =?us-ascii?Q?apuLnPDQkb5doaeLHZxKOtFdQiTQtKMItwLIEoIjQVACcmVp7evk7gwCVE1Q?=
 =?us-ascii?Q?jsBkrCT/JBoeARjoWch91yXBXSLomz64/y5f/v51Q1v6lxtR7OSxPNtQI6ul?=
 =?us-ascii?Q?qUCq8XqHNwGWvzTE0g5JbsqjDaAwhDK4QS/ocJw815z6fwioSkQiLd03KmJu?=
 =?us-ascii?Q?qDPKUc+85RiimBy/dNDcRham4wxz6OjZCsGHzIjk5mREWpeZlUjkxxl9tNig?=
 =?us-ascii?Q?tTZ9hM2rPTZXSLUAYK/7mgkkKue+yx2vngr7SfTjkhXCa0iNROQEwSqMoZjS?=
 =?us-ascii?Q?VSUKuDIoODSlAhdf9Hia327uANYkctJ+cyd5rozoTBdAFNubXT6WWOYSWN2u?=
 =?us-ascii?Q?wSdzqMH2WaGXAT1Z7RmtOY02clOhfdFvpvEs6J0uOzJAn32z/nDSjk36Pnvu?=
 =?us-ascii?Q?ZBuGSPZuQaa26mX1HSDRLvdKPhLvXjFWyMotnl14nK8CiZt5T1CxZzscwegV?=
 =?us-ascii?Q?oNUDANcIKm1bs7kVkRtbjDpW3zpM6tJ+zNkpSmHjLm+S3QZPZWd25Uw400DO?=
 =?us-ascii?Q?7gIycynNLFhT0ixLVnupRteqsYnwcGEDCA4CQpv3cZ7kG9GE4n9r+9pQ9RqS?=
 =?us-ascii?Q?53Ov81nkmuaQz+netXng5t5uGcWImaVgzUqdRGzSLNL+RWzy3lxSCUws2na5?=
 =?us-ascii?Q?j7nd5reHgOn/cNnanlRvcx3YU3aOMHQVrRAYAVd9nLrvtuWTvWtxf4O1eIN6?=
 =?us-ascii?Q?DOINg0DqiiAMhbKxvuYEf4cMjauD46i5GUx5n7fUZHDr1nuPvJ9GlxT2qB/Q?=
 =?us-ascii?Q?lnW4sxvShanV6Ick+iM8mFV+q4JnEk6uKjvhLZDVXKVD1/lARNP5oq+ok/82?=
 =?us-ascii?Q?DkxKuQzqDdtN9fAypRQXQ45wksFqgAbiyzlTDoibJutXyBjzyf9uejV3XHmc?=
 =?us-ascii?Q?l1kG17vl6qNHxpWK8sT6Qq+j14XKf2OFd0WsSmZNt0mxZlYditc8Kou2bjcc?=
 =?us-ascii?Q?mLAunNYituS8/RWz7cDsqjdU8rGjHnTcdlocavMsk3xHXX0TwNpEBcsgsl9o?=
 =?us-ascii?Q?eib0uYmJLAqOeppPWOoOVe1RecFb/oL0WcJf7Pzr0O4x0BauxdEpkm53wQ9r?=
 =?us-ascii?Q?LvSmZ+oMS4Yr05rXkwmFM5H6J516ZN8HBIFA/V7HO/qwCBAvLjHjTfQgmpm7?=
 =?us-ascii?Q?MFqRXsLju4yUVDuBWjkQToD1LMvRE/W4b/lyqUsO7beAjJOI/MYpkB5LLcm6?=
 =?us-ascii?Q?zUJ6t7Bm0zZB6OoudhCvTpGnCkXW1nyySIFlFiQSsvKOmQRzY0zFfaEuSAQt?=
 =?us-ascii?Q?ht23YdqVYEr8CU87prgkJqVX79bkgBzKJQusF4VPZW+olLV1You2lq2KfaDn?=
 =?us-ascii?Q?hBmL3JcgYwY9BT4Xqa782xHadpiqXioQcPX58OpnDINoZf6VvL+KjWJpf3wN?=
 =?us-ascii?Q?D39QWw6xcQoj6IJS1vBioJ2Dnb+TPnyABfuE7d3jqsQrH1DF8O85hM0FulWU?=
 =?us-ascii?Q?oNPr/e96SHfgRh/DaPjq5Mxep3de7d4AcFhU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 01:47:28.1284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9752bf4e-bbac-4ef3-d50f-08dde4428382
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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

From: Alex Deucher <alexander.deucher@amd.com>

Implement support for the hung queue detect and reset
functionality.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 28eb846280dd..ed6a7f8af544 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -66,6 +66,8 @@ static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev);
 #define GFX_MES_DRAM_SIZE	0x80000
 #define MES11_HW_RESOURCE_1_SIZE (128 * AMDGPU_GPU_PAGE_SIZE)
 
+#define MES11_HUNG_DB_OFFSET_ARRAY_SIZE 4
+
 static void mes_v11_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -783,6 +785,32 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v11_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
+						  struct mes_detect_and_reset_queue_input *input)
+{
+	union MESAPI__RESET mes_reset_queue_pkt;
+
+	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
+
+	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
+	mes_reset_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_reset_queue_pkt.queue_type =
+		convert_to_mes_queue_type(input->queue_type);
+	mes_reset_queue_pkt.doorbell_offset_addr =
+		mes->hung_queue_db_array_gpu_addr;
+
+	if (input->detect_only)
+		mes_reset_queue_pkt.hang_detect_only = 1;
+	else
+		mes_reset_queue_pkt.hang_detect_then_reset = 1;
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.add_hw_queue = mes_v11_0_add_hw_queue,
 	.remove_hw_queue = mes_v11_0_remove_hw_queue,
@@ -792,6 +820,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.resume_gang = mes_v11_0_resume_gang,
 	.misc_op = mes_v11_0_misc_op,
 	.reset_hw_queue = mes_v11_0_reset_hw_queue,
+	.detect_and_reset_hung_queues = mes_v11_0_detect_and_reset_hung_queues,
 };
 
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
@@ -1684,6 +1713,8 @@ static int mes_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
+	adev->mes.hung_queue_db_array_size =
+		MES11_HUNG_DB_OFFSET_ARRAY_SIZE;
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
 			continue;
-- 
2.49.0

