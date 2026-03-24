Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791E5FEC0EC
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 17:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18FB010E610;
	Tue, 24 Mar 2026 17:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CuWgV9RR";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012028.outbound.protection.outlook.com
 [40.93.195.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8930010E60A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 17:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0fa4DiEAA7FpwfnkNqqgCxqTmLP8u/+vH7baZXAIr68yPit8FCrxkwct+KiKvODgZHluzPwJx23hT6DpDuKT8OkAjZltbn3WHU68E3bbldNFM8cJobnKTDcHLzRRvz4htgYDY374cSTtV0YC0JRU3wojDDj6+oFYZWjBHfs22WpJAA9x5wI6zVy9JK4MonvMvjJIqninP+W3ONz1oyfs2td6dXgCPikifeM+wpm0wD1vAbJNgmELgQT2I5BzvdGGmD1UJNtslPVuSv19mgUTnpfkfCCMZCt/7ZYTQztZphzCRz6NhkdLdWN08aWVaNvImmghY+tKkmPN3xPmDeSgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4Nn+Bqg1SzCv1UWprPzE7Z/YKHpaRHy/GDn4GhBKIc=;
 b=OUHVyViqS7HzrFs1iBgQaA3LPS5rbdGXmVUNGTSLtROU6VCqyd/3BrP6Awu7OaYu829nxNxtxCN/cl+3cYgiwnnKQ6UBtYL8Blr3yK4wV0P3P/tWeQEe3l44XiZWDSMGVo31+sx9iGKbEKZaJtxGMsXDSeOm8mRTeWxXftsYDg43eZ3dEnkzxKX1qBFipBpUauLXkfmNmO4n03im06OeOp65eEeLeBTWBIK8poWLeTCfKKiKMDDaDtKGetLhwNiC0O0bVTqE4sWpjfjOyQfYeL1EU9OpLt2Djo4+tbfHj1QMr+aJJYAZZN+0Atsm54QBkCG1c4zB0MM/ioXTuL+svg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4Nn+Bqg1SzCv1UWprPzE7Z/YKHpaRHy/GDn4GhBKIc=;
 b=CuWgV9RRMd7A8gf3mqCZsfnzPt+suLz4QgCsm7av8LV1DiyykMEC6jzAm8puzr1acsQyfdzBUoUMB39yKXiCX123oQe7FWntWaEy09zpyB626XvsqVJhQHb3A+vjfR5acO6RuRBen0biz4hS/k94wQFonASU4xakV/i3juCa+ic=
Received: from BY3PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:39a::21)
 by MN6PR12MB8592.namprd12.prod.outlook.com (2603:10b6:208:478::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 17:57:48 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::12) by BY3PR03CA0016.outlook.office365.com
 (2603:10b6:a03:39a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 17:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 17:57:48 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 12:57:42 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexdeucher@gmail.com>
CC: <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, <Jesse.Zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 08/10] drm/amdkfd: Add detect+reset hangs to GC 12.1
Date: Tue, 24 Mar 2026 13:56:50 -0400
Message-ID: <20260324175653.1325754-9-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324175653.1325754-1-Amber.Lin@amd.com>
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|MN6PR12MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d7437b-ac38-45dc-45c1-08de89cedc2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zCazfDm2v8pNqVixCAxOc/NqRoG9vSQXfaz4vEuGmsXtYfLv7KgYOzYTRy0igwADBe+D0FTkikKz2CTWu/yo3RF7cC3Z2sLoQciOkZDk4MjFxH0O06nAm1kr3xgTuPGV/Llf3QLwB/vTIBHcnuL59uxj6tUUfGUf2LUCdQCqZ/N7m3HdIPasz5HVpFSjSySml+9Ax32hyQMOXDtRn+6h8skPJg3VT909s1gNp5P1BqtOjgyZ+2wjNHX8Q9qNTdCy1jixKdh/VLMtPQbO87yGJHEFGnTtf8ttf3Drdu1h4QnzMk6LGLeeLPVP9WNIkUZ4Ybzabo5e16B333YYbhE2swQAM0zDQt+3ENbZD/vsQEw5PqdAqv+SZ2EjLv+hma2KeNmru1DNXKtU2/PQSJ0RNb+bDI/TMQ1TE2c3Bv6M6krGDgki5i8pqVkz1w0Sf3QUWlEuWnO1AYEHai52d3r2sxKEkFGHP9F4nnhPWt4DCUgN+RFkZhxKfPhZfePDhnx7MOfdhRTCgDB8WvsVytJBvVjWzwX6PX0Wd5Wi+WXTAWk3/+DTYkhQSTIOwlrgFrzpovqkhp5QiABp992tcc85NA8qSWIegpAZTc8EAPeD2vRA24ChEPryRV/Ff7VXZQOPSe2ilkwAL4DktYVxwuSy5xcDuddmuAyaYaa00SQB6fIMAIqEFT13uJISmQbquBUbzgWH87dmieYPgVKm+qaVpeZyLGprVSoA1yCEPaSe5SbPpkXo1X5Yu2zEq6gk/jiESYPao5y09He4kSsOHQjBGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i3TCE7iYzSQCGAA3DsPK9yJOlFtuAXTZfDw/dg280sscod6ASJiGMllkyiXH2xvtJGOOtDr4pySwKLZKaoPGELo00/AUENmMxGDjg+fCYVwJNaipuSk9HY4UBLg+kNTpgNFJLPX7scz9viMX0NPf68bsPJnq3Z19XIrbzGbDiiKi/2x4sNMaTKcrJYRn+APdHzQ3nELHA6GnUu3MxvHhnYY1WcyV7VjPHN7bco59ipQCIwFFTMpm/WqJwoOnQW011YVZgtpHUUX8tl96rq8w5L6KFG5Cd+OppfXUFNUg9fxT8sunMzSaHVrbyH+fB6UbmZDoR16zV87QbAPiy/WzCEfsvYbqo74csTpxf/lgaUt+/6HoeplwcMT45rmSXU4PgKyuvdtW1wPlH3znZMUnEou0x0EOVMbyMG5VimhqRf+IfLpThNvqlafSDhPS56nB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:57:48.2202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d7437b-ac38-45dc-45c1-08de89cedc2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8592
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
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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

