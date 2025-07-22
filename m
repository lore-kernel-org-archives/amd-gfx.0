Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AEAC83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 03:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D7710E3E1;
	Tue, 22 Jul 2025 03:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oV191dWe";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61D0A10E3DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 03:06:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRiN5dDhO/AUFH1xbZEFJGs+16I1u4FcL1fMl06WHPJ7o/IkKppcEYj8rSMfLO6fNzRtgx68fAvrUKDZh5nfCqONmhRMqW1LAV9shPSBXaGJgv32cflqCm9fJzFCnLqb4VApYPrQuE0yAivx+34Eep4DLAq6eVBYWUJmYsno/ArRDBIoXb8v/oTAjkVEoCyF+A38QX71BAiA4Iyxzhel8cQLGJhz2ARl2dyJZffIWniI2n0gBUAqnDNx3f5Dm4ylBf0hVcVuzo0McTCmatKG7qAi7qU6AT+5iIcYYhx9u1Bhxt8T58/NRkW0IThZxo2pNnQ9PTbOH+9jvdXoHxr/Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vX3rRMtqSlsEbl+23UFyk2tGFWYXcw3JQfnNleq8vSI=;
 b=RBxa2qn9qtY2mpPj/Qca8Cnk43KI9RNKXVKGU+F5LEhjj3twB1vhOwMd9j80xa8z9rzNIlMIN9cf0N/6KHR+KVtBwTwivVeXOs+oMzusP/p7EkY6fqTG+21T7upKm1ShGIOEi+AQwjQWS57xmhs9zgl8ccytuwP8kMz/QyPElHS0iJlzzpVY1HNTwdAs8j++3yfsJPLqZh0rZrCe69EuEeNQpDUFPVZ4B+3WnDCQbzk1grXTmXQ4H+DJi3jIa9qeKL0nEY3BeuGGAYXW+SpMPmCVxOikbVWUyLVE7ZhWvEyXpuZbzz0zSfdUshthhiznBxi00nA73VvZCf4boRTb9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vX3rRMtqSlsEbl+23UFyk2tGFWYXcw3JQfnNleq8vSI=;
 b=oV191dWecihDuOLNlS8AAUIATvs9TrRuRNtuYo+whmi26pTzJsU/rxFmw1pDUsp/Huut6+/TobQs7vSoizvHrcinhuPhnWZgSBxcAcNuUeKTpKDGsesQBefRJun/DO1eKxCyGx1HtWy7es7euLA9CJcO+O5oLB/YMY28Ka6iw24=
Received: from CH2PR18CA0005.namprd18.prod.outlook.com (2603:10b6:610:4f::15)
 by PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 03:06:27 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::70) by CH2PR18CA0005.outlook.office365.com
 (2603:10b6:610:4f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Tue,
 22 Jul 2025 03:06:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 03:06:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 22:06:25 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 21 Jul 2025 22:06:19 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v5 3/9] drm/amdgpu/mes12: implement detect and reset callback
Date: Tue, 22 Jul 2025 11:03:39 +0800
Message-ID: <20250722030605.2741435-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250722030605.2741435-1-Jesse.Zhang@amd.com>
References: <20250722030605.2741435-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 14421b7e-1e58-4bfa-dd4d-08ddc8ccbf4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n4lkgXtV64gFNVSrkIRNeBgSNDQsuOj8V2ieL/Aegj9i1aFcxM5q2MfAIglz?=
 =?us-ascii?Q?T8lShx3xAdLSLRjpp5b7ND8m6Idr4vx5DODlCJmC5hwUotstkYU4eyUq2QMY?=
 =?us-ascii?Q?zIfmkcsbQD9D9DHq5alYAwIFrAV1/7BKjzm0m4PXyBfSqBW9dYkhH36QkOQa?=
 =?us-ascii?Q?STu+3KHCHj5hEu29EH/AY78iuBlPMv86aqvR6J2n103fnyOWqddq3MrsP8jc?=
 =?us-ascii?Q?3WiIdtACUFLihYVLN4ZVrshAdmH6kGGQO3W81YzpGw77FptqmoK0OUCA4oTF?=
 =?us-ascii?Q?8eBn31URRgh0Cp5MzMfH9savwM0eDrbvvDK3TseGkXGIN9B/YT8H8I/uyjG1?=
 =?us-ascii?Q?hwC0P4cu+4EibRCYhmm+hpBkWptrWV9l76A9iN0CB9qKr7QrpAy1mkjEgFMH?=
 =?us-ascii?Q?rJNpvHTNg8hYaPM15SL3aRe9PqOe5lR/zEpdxbUgQnrBXyXgTvVvtAZ5SiYp?=
 =?us-ascii?Q?E3cQewPIV5dl7h/yf0iEU5vDz0ryrBUd/E6qr/AD4DFjayZx/vTeYEc0LovB?=
 =?us-ascii?Q?QO4z5GMzxvfAFkwSAgZB/CaHWCZGx97y5KI7MM8Q/jbniZRWV6F+ztBaULrA?=
 =?us-ascii?Q?6db73n/ICOYjOtKpJGOvcmqp0bBEPFGxgoC3iGMfm0oZKaIcBbZ3349mD421?=
 =?us-ascii?Q?FY023y9HVGJo4OkvJNIYQPg1BC9Ek3mMNBwc2cD3DHpJx+A3WibvZwVdoGZT?=
 =?us-ascii?Q?C6SDajUxOa6+uCi71VDf+OxBmD1IsvLQX8+DnOlzMhpgJnly5acPrjiyY4zS?=
 =?us-ascii?Q?eXBuK6sKDEwNX4mwHpexv/uhc9eHOWeB0XuNRjH2LBdJPpGHYVgOfx3/Eamg?=
 =?us-ascii?Q?Eck3pNr1OoXekOCyxTT3vLXDR3ipbDU7deFQawSNa+sQC23ygEfvBVjnLyLB?=
 =?us-ascii?Q?Ty6aVTj0Pb25MVtnJ5Wd4ZLJyK/j6KK0RTuwjZ+jbK9xhkPXfPENouGr7WZd?=
 =?us-ascii?Q?F6YmTKFsdgN76gR4jDEXYQnoeEqUjynEWdsGXuh1XxXo3p8cIlCc2xbQsMHq?=
 =?us-ascii?Q?yb9PtfrCPIuOQfoOlg+QGvu5CUaj0qrwiTdOG+eCzE35UwxJxJm/hdnDyBUY?=
 =?us-ascii?Q?CgHBcAT+qb0Dsz2etL3IOs+BE1CNEQZbIM6fVXrjY9wJKH+rlAmlgFuOWiFI?=
 =?us-ascii?Q?wtPd5FOGuKrRYXiIufHIhGU144dwvHlmXxQ5ZaReicy31mUEDH5KRzUxcqrX?=
 =?us-ascii?Q?H4M2R+Ylypmvz/NngDC+pNfcYZM7UXtjLQeoY6CCI1BfW+ImiD/08ycSkUM3?=
 =?us-ascii?Q?0wKhB39EPMAjFnq/avfq2/VEM4pXuTpojT4Tf42y2QhXcR/zo7L5O6rn3J9f?=
 =?us-ascii?Q?SSNJouSKxFc8bg/18KXlGWn5AAc94FnH7pUgU7zyJ2eNX+Bi0BxBJhB3Usp/?=
 =?us-ascii?Q?Xnghu0SZIiqHG1MAtpPcJoXvgtEdOIOwVO3CdJb4x2phULWdsgqWBe2Ui50J?=
 =?us-ascii?Q?IcCwJbe5wdrvTmLlyBO7ugJHp0DVZa4O2TJUOJ+SaDto2KPN8R0qalQrbN45?=
 =?us-ascii?Q?fmtDGtShC/bz4w9cIr3TYeGFD2a7PiX5GGTA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 03:06:26.4245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14421b7e-1e58-4bfa-dd4d-08ddc8ccbf4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537
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

From: "Alex Deucher" <alexander.deucher@amd.com>

Implement support for the hung queue detect and reset
functionality.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 6b222630f3fa..29d38aa1897e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -47,6 +47,8 @@ static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev);
 
 #define MES_EOP_SIZE   2048
 
+#define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 4
+
 static void mes_v12_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -879,6 +881,38 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v12_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
+						  struct mes_detect_and_reset_queue_input *input)
+{
+	union MESAPI__RESET mes_reset_queue_pkt;
+	int pipe;
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
+	if (mes->adev->enable_uni_mes)
+		pipe = AMDGPU_MES_KIQ_PIPE;
+	else
+		pipe = AMDGPU_MES_SCHED_PIPE;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
@@ -888,6 +922,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
 	.reset_hw_queue = mes_v12_0_reset_hw_queue,
+	.detect_and_reset_hung_queues = mes_v12_0_detect_and_reset_hung_queues,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
@@ -1793,6 +1828,8 @@ static int mes_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
+	adev->mes.hung_queue_db_array_size =
+		MES12_HUNG_DB_OFFSET_ARRAY_SIZE;
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		r = amdgpu_mes_init_microcode(adev, pipe);
 		if (r)
-- 
2.49.0

