Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB504C71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 03:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9202910E26E;
	Mon, 16 Jun 2025 03:46:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pckXMfO/";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB55A10E26E
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 03:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKjEU+BfMqduhY+FDm3HOb6WSj08JPLGF6Xf9bXOnFYdowb9XFO1hVCC78Xwj2j8q2h5DJDNUvraapvirDwPj7V8/RY0womX9icSl0vWeTjphJXarHd9Q5q5DNmt52/xvc1VykestrXvlipW9UKHw952012l/8YueoTVP3PIyvudL149mQnw4gXXclv+zKPm4DmgPgeD/tjopECPpTnlWQHnsbzp4MhJFdVCUE8ur8W+x4A/OKIpkn2muxoN4HFfTf6l5qhNU9jaEpPJGbvvX6F3dj/Jv99XePoV3FJcpenGKTCWFF54CI5pImCmAyfNzxVnqfgZHWyTSnr8+Lq87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0kCn7//FYApVZ1C0PgM0oDjZ4b/EKu0+EastcYtE94=;
 b=uFluzaavEn16DEJzfbzFvwsrlKcl1LkB4n9Ync1JTW/gLTeXVdzw+A3v/DumaBimG87bSXmRphg5RsZ8ms7gplNDGoQaEKQs7VjSH14hOTuOwu49coD+qOO7pJZH9ZsozxSkGP0w7wyTw3L1KUQE3r9jYs4oCqHMyotT8lw3VKVmS9R+3ldk3Oxak4r6dZspHZ5i57moZ4VkhmKq+zscH5WO/rGwcPje4ZolbncviySeIua5CkMq6YneNReaSC7wzYQ3gOjmaN6u5Js03UMsku/cMG3zc3pONJBhE/tR7mlKv3CobTvD6VbXmUW5YFpNc0aLQbS4ryyX25NhWpE4RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0kCn7//FYApVZ1C0PgM0oDjZ4b/EKu0+EastcYtE94=;
 b=pckXMfO/5vdzM0tD4J+M8ZGfl7HoqONTDK54aPerEt/txojM1p0dc+UT7nMJ5GO4QomcZoi0VZpXXCaW1hZ3y/z6ZEmhMjFU0zMS3Fu+C3SUHvSay98hydv/PVYSj3YYoE6Z0jbg1bdTcavQ7tMdPVc4CWvfiyNW3GJi9iZYnoY=
Received: from DM6PR13CA0007.namprd13.prod.outlook.com (2603:10b6:5:bc::20) by
 MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 03:46:35 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::1a) by DM6PR13CA0007.outlook.office365.com
 (2603:10b6:5:bc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Mon,
 16 Jun 2025 03:46:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 03:46:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 15 Jun
 2025 22:46:34 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 15 Jun 2025 22:46:28 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v2 5/9] drm/amdgpu/mes12: implement detect and reset callback
Date: Mon, 16 Jun 2025 11:43:38 +0800
Message-ID: <20250616034605.2683434-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616034605.2683434-1-Jesse.Zhang@amd.com>
References: <20250616034605.2683434-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|MN2PR12MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a0e895a-6aa3-4b1f-c77e-08ddac886453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GlkOPDi8U5pRCoBnbfYBOEW+u9y0WslCKf2nyCGL8nDityIV8D1jTBCtob3T?=
 =?us-ascii?Q?WLCIYdyl8ObCdDVOk/CjSy2lJekiBb2RX+XrV4ILUrghk+WDkE/rsTLF25HC?=
 =?us-ascii?Q?6Bk++m4PSwoDyDmZKmiQwomONDMYis7lSHdGxuhxr7bTJH598PNoqLnTMsUr?=
 =?us-ascii?Q?5gbFGCja9r96b2sgENRYJpyhqKu9geNVSqtzWQ/4YbtIe7VjBw8vXEG/9EQV?=
 =?us-ascii?Q?4eaxV00TYVlYowq2AYVv9CQRU+wF2GpwCHT/6XTTv5IDvDrY9CddaygS8KGR?=
 =?us-ascii?Q?3MF5DgeswsTamnrtN8NU5QRaRmASldYfTAqVutM2OGMyZF6CsFAUlkXWghgh?=
 =?us-ascii?Q?2/HS34CVKXNO33Hv/v4/0H2O4/X6jkfbkj0w5j5kEC5D1ZbX1YEAX2hapPtb?=
 =?us-ascii?Q?EMdL/SPZ2rMEa4G5vMDPcw3Y7RQ3QTbYp8TZ3SILvXoTbCv38VqRrRc8YFgg?=
 =?us-ascii?Q?G86uE6Uw5l9rHQitlE9RMUnYBjFlmTCuLYppGPtv2RA+OVUc84Ch52OY0zSr?=
 =?us-ascii?Q?9FvdH7eU18ujnwiaNW+ru66q+yuvPH0CbhNndYLr1GnXue54leZcIg6KSY/J?=
 =?us-ascii?Q?DHKEZVoWyLFcVzEQlPoD7X+yXIMpyagE/WmquYn5eBzRuRCseXcc3QpgWeix?=
 =?us-ascii?Q?DkKZG7rxmTIo5gbsdiGf2y/sT+HCBRtUJTTS6RJ6XEjDc2S8DboycSaePBg6?=
 =?us-ascii?Q?9ZI8NegvCW4vbYJDHgo6UhxW9fUabs8AegalF0UqXQm35KfyKR3T290swJVY?=
 =?us-ascii?Q?vbjbsOJQnHR8FC2Hdyf32YZMpqRAH02+sAqtMOEBJeW+8lhsVm6t6Wydd+4j?=
 =?us-ascii?Q?5L89/6xDB9SbLrhNbKSkIREAfEqR0b8ZcujxnzecuuPlVWmN1186NtLrSA+h?=
 =?us-ascii?Q?U2odpvpTpJz4J5GifFNxmzE1XxgK5LvbBJBNIiMA9Vc+wRhDZEH4WiGzNTjw?=
 =?us-ascii?Q?PdaMLeDbrQvT7MU24msxCTl0z2SofRKAxKIX5svJsfGlOoct3yncXXsKQLOp?=
 =?us-ascii?Q?gDSJDKutJlVAjBtdPxKFSoyIYrOFAk0x1qCrPxBdpCnWVQoTKtknXWChqxL8?=
 =?us-ascii?Q?ZHNvTqoxSi+9XB2LYOFDvNGSfdSpy6l0PS2NEwqoCvJYYzDuyjV7uKG0uV9u?=
 =?us-ascii?Q?9fWw/yaWPGgZh/hoDeKpc9Ds/14xx0GnVnrKRjnIrVhOTNM/wWrc3UmDwZxk?=
 =?us-ascii?Q?kmvXf4dPf77ptObLbHYz7Ykuhly+EecJXHvFtEWU7+ZR01XrnoL40jNxzaTn?=
 =?us-ascii?Q?JPNp15FvnVIdkf8ZQM7fBruA/5hIqpBrtJoKM9/TYyJtHiBAHS00FSeMAdrQ?=
 =?us-ascii?Q?9uXrYuo4S34LQIr+2OlrSIOJp+3aNVjkGlIp9rflCs/xSRhoKcKyO7zdy9xX?=
 =?us-ascii?Q?1/nBNgJ3+7gEFV6bnfx7dUPfCrln6/i+d8WfvffpQ3CYhyk45NqsDJRnXhjS?=
 =?us-ascii?Q?Ze9SuV8rj9PShoccpZ/ohqigLKQObOKpTyZmIhMuwb49q4BCeHVZI20y+Fcq?=
 =?us-ascii?Q?RpDxQ5un1Q9I+oGG/fr/iTOhpLwMD1GfNk/+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 03:46:35.4205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0e895a-6aa3-4b1f-c77e-08ddac886453
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
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
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index b4f17332d466..7d545a24e2f7 100644
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
@@ -1792,6 +1827,8 @@ static int mes_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
+	adev->mes.hung_queue_db_array_size =
+		MES12_HUNG_DB_OFFSET_ARRAY_SIZE;
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		r = amdgpu_mes_init_microcode(adev, pipe);
 		if (r)
-- 
2.49.0

