Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29FB1099B30
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 20:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 317DC10EC1D;
	Fri, 20 Mar 2026 20:02:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1RSFOmBU";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 115B910EC14
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 20:02:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDDQIj3dYFv5R1N7JFU3gPSrrlNQ8E7UA8+QCkbOSGr3ocsF7G4rZqWrCgxHTyuKdhaQVHUK34sqIBnj0BK59M8xD/Ya80M26aKPoS+y/6D/s3HJeGgJpXVF6gpmEyZY+1epkiFC7xgiq6N10mHMYTogC30ctBlsTduV8EL6I3eAvax9TmC3mGDYV8/1hS7FqxIVnBHGeY0uMej9KOtMrnrp5o/ACfhRTA3T/qRPdMBlVucHa8QO21GyBibvXtlyV5e5evGgukHetEjDnGphEh+007hDeQEHFq1fgBnLy5z6ThPVdA+KVa7q7WzwCRx7VwIfhghjYXOTKRZaEOQfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KFYAAhiIPhDZoGxMVKfK0R3mXAYKlG2zHOVsg0EX2g=;
 b=m0HZTsQuach6XCOJXzKHQZ1AIRu4eZwU/q58Hu3qTq2iG7cq1lrEifhoPlsUfElvkoZQT30WQC4gqpmGwP2djGHCLhJ8kJM4aTt/6e/pL+wHXvuFLwjgD1OC8m1VJvEOZFntZjtmAxz+KWcpa92yswN/6/KG7qlIVHDE8MVQV0obrywn/tbJkx+d/EWvo2wpSlVW7Lz1K8jEfsWp2eUNkVkWlI1e4C101lLXc+pja9jvefGr/XZxbZlbCoBAbzP923g6sbMIxMYfX26a8Jf65jAblIe97eWH6sqNmcsAeNpzrc1gamQP6bSFCrJBw0vLIoUDWHDVAmTS2kTE0r6lQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KFYAAhiIPhDZoGxMVKfK0R3mXAYKlG2zHOVsg0EX2g=;
 b=1RSFOmBU5Bdm5eciONGtcJFOSxbRnDPo+PfvC+PRxYuGORo9ELDcacohEAUTDKRgeF8SWmtLDaItqGbN8lwARHknUKOYD6bVca7fkQrEE/2p8wH/76YtLacaHrdI0IqBTvtlspvK3pu6TKZAAk2I+hoLSk886Wb4DDT9hH1pX+U=
Received: from CH2PR02CA0030.namprd02.prod.outlook.com (2603:10b6:610:4e::40)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.14; Fri, 20 Mar
 2026 20:02:40 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::4d) by CH2PR02CA0030.outlook.office365.com
 (2603:10b6:610:4e::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
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
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 20:02:39 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 15:02:37 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, <Jesse.Zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH 7/8] drm/amdkfd: Add detect+reset hangs to GC 12.1
Date: Fri, 20 Mar 2026 16:02:07 -0400
Message-ID: <20260320200208.1188307-8-Amber.Lin@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: 80223172-9a96-46fe-632e-08de86bba3c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: hrYiXpJX7EU9UKwH9x7rCI7YL259M0Rm3/JEoQ1HBDZoIay/7TE4VE6/KKyc+U8nn3n27w1PnNHD7+zPR7f6SaA+FvpeZbUldEAU6RfFAdxMUtejsIDbwVQmQDKPXZu6+QU4WciPBb+cF5L/CznvmezbqVRfm/wRmtuX1I9KtiEA8tJ8nVlZu3azUfU80YXzCe0y+Qe2LTgog1lIGJ76WLdNBc26eFLR949ThsMj0aJutUvN/vXJHszsoR8VvsTD55DP5pdnvSyItsFKixQoItOkiawZqbaooVSJ03O0lFWvhOn3Ezn4oBAT1954mZlFocNQG4oRSy4bk1YFUYjK+18SDWGsygcjyWLK/QtT+MihnKO43iUYnY94sfjLE3SO0E2h6KLCWRzqurKnZaVZkjhyEx4QM2J7ep6VBcwjlMlVg6M+aUPqw72kSyNPBQUaLnIlDOzgsXNWtNqxXJdSTLpKxALhGdLSGgGYfQPFbmUlyJgFfGrBT7ZR5UcLz8GQBbS5iTEw4pA3csTD8wq8c0/Vgek74kQfSdRnC5ahSdq37/8agLsvgWmXppIhWdb34OZOqxoRYtM5uvDboNpe+0TXCkGmI0wvo0vJmoB4Gi0G8flTXbF132b6Jj5lle7Ln51NCF2p45MN9wV/cxwCoNpN+xuYhEwVejv5w/X7ZmXXHJkpvhgcxTlCpVEqYuKJ5Z3JcqCpn9udMfDCegKztsOdulylAw093ZOfy8/sgvbB7jd2JpPAU/J8WMaFDTQlRo4Wzy9WarTusGTMndFwww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jvDpbUWw/7XmxIXgBdARG1kJNgwxsyMlVccP6PTGV9Jn2ZJY9jMGGtCbzMWcm0BPGvHmZxrXCxFtJCtN3vOX9YYEpJybjoYlw9pSfLAzUBjXgyy9Xggg/rxjNVns5rJMZpBnWTamgWdCbzDCAOakQh6Px3OMSgIl/pF1xgaDoOsRPyjtax2lkBqFxsNo/3E8gG5fVURPZixKHv+snmRjzE7ndti/IYisBq2R3Vu58zC2KdAGxFPu9dzg00G1VILfSezm9l1PtQPuFm/r+JXLvHaoOxsqvQ989u++5pBnB9L/7u4splNaNpJ4R+0yps8RyNbPmBdX+AQZLdroSMf4mSdnXPmGUqkGUwcW+PMdqdi1kGH9EPhqS3JtHAI9gQEFZXSoX4YCU402ctE59XegsgFXAjOl6+R20lV3uw+nmzcCqACV+YtPtZ+OZPHcN8jc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:02:39.7200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80223172-9a96-46fe-632e-08de86bba3c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
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

Add detect_and_reset_hung_queues to user mode compute queues on GC 12.1.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 35 +++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 7aea3a50e712..ac9e26b8bb52 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -46,6 +46,8 @@ static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id);
 static int mes_v12_1_self_test(struct amdgpu_device *adev, int xcc_id);
 
 #define MES_EOP_SIZE   2048
+#define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 8 /* [0:3] = db offset [4:7] hqd info */
+#define MES12_HUNG_HQD_INFO_OFFSET      4
 
 #define regCP_HQD_IB_CONTROL_MES_12_1_DEFAULT 0x100000
 #define XCC_MID_MASK 0x41000000
@@ -229,7 +231,7 @@ static int mes_v12_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 			xcc_id, pipe, x_pkt->header.opcode);
 
 	r = amdgpu_fence_wait_polling(ring, seq, timeout);
-	if (r < 1 || !*status_ptr) {
+	if (r < 1 || !lower_32_bits(*status_ptr)) {
 		if (misc_op_str)
 			dev_err(adev->dev,
 				"MES(%d, %d) failed to respond to msg=%s (%s)\n",
@@ -858,6 +860,33 @@ static int mes_v12_1_reset_legacy_queue(struct amdgpu_mes *mes,
 }
 #endif
 
+static int mes_v12_1_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
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
+		mes->hung_queue_db_array_gpu_addr[0];
+
+	if (input->detect_only)
+		mes_reset_queue_pkt.hang_detect_only = 1;
+	else
+		mes_reset_queue_pkt.hang_detect_then_reset = 1;
+
+	return mes_v12_1_submit_pkt_and_poll_completion(mes,
+			input->xcc_id, AMDGPU_MES_SCHED_PIPE,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static int mes_v12_inv_tlb_convert_hub_id(uint8_t id)
 {
 	/*
@@ -915,6 +944,7 @@ static const struct amdgpu_mes_funcs mes_v12_1_funcs = {
 	.resume_gang = mes_v12_1_resume_gang,
 	.misc_op = mes_v12_1_misc_op,
 	.reset_hw_queue = mes_v12_1_reset_hw_queue,
+	.detect_and_reset_hung_queues = mes_v12_1_detect_and_reset_hung_queues,
 	.invalidate_tlbs_pasid = mes_v12_1_inv_tlbs_pasid,
 };
 
@@ -1931,6 +1961,9 @@ static int mes_v12_1_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
+	adev->mes.hung_queue_db_array_size = MES12_HUNG_DB_OFFSET_ARRAY_SIZE;
+	adev->mes.hung_queue_hqd_info_offset = MES12_HUNG_HQD_INFO_OFFSET;
+
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		r = amdgpu_mes_init_microcode(adev, pipe);
 		if (r)
-- 
2.43.0

