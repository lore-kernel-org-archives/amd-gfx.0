Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A8DC87FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 08:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6607210E414;
	Mon,  4 Aug 2025 08:40:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wTiKNtW8";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5147610E414
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 08:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAH4Ozyx/ELj0QHI/x1eeRReC8g9xU1i+YXfXJIHVKJRgFuRBteVdMDgDGG6AbUt+42vJJsmjsaq4V6rlZRDI6l1tDgbZer98kr9twWd08JAhvdvvom9cPa99Fl5hphkvZoh41uftLgvE3mvab2RWZQfY1Atgg9EgmLKk6TThJcIWDe1etZ9nnZh2YlN2a1ZvV0SM8QFlpkVqxEyDyXe+OTheIAogZlIYZ8PG/cp4vu+0sSdwBoh+ewfEa3YOeuqJob/mI55+gs5feJgcRPhfMSXX2CU0tyhTqKUYCJ0MR3ZOdBKIGS1+DMfcXrDl4U8zSujPZuQ7hEbKvWNw7sTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4chIb6zwB7HW4D2PRxzEjMS1A6GYIfNIXyZKMTYvIUY=;
 b=F8HnQQStqpdmVO645KHQRVqRSbgD+vqucIXThTldvHq4yHJF7H90zx3rdplXljW6rw07NvGXclK/w/Q1c0gKlZQbZJ5k/aoocZ8qDbIQ6GLs4rQarxhBKelUfFwsqBveCy69fXQhz3+rPbNM/ffeHMKnwD0dV/+D2wyOkUJbAMglp6v1SENde0OX60VWcHHQX/YFnWuLvk3zyDqtlPRuql7OK+Ey2msQ8YSgY2VVz80bvWqkq55erKRcHA3rM++te6+RT7bcv8Qh3SfK0IDFN/2gefkcnTLIwe3CX9aJbW+vEa71gY0C5ZoedxSQ9BvhBfQSH5L/9PVx+ohNI8er6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4chIb6zwB7HW4D2PRxzEjMS1A6GYIfNIXyZKMTYvIUY=;
 b=wTiKNtW8xQIeOicqPJcSr9B/s29crC82Ai4L9YdPROhqUfdjwZ5zpbLVyCTr9ZRABrbD3W1RCYjORZOAlN8y148OWwHBYrTUtUduK/odtNGTS7j1IXB3WDU+kf/1UWpk4dK7cAQIpaoNlS7UmGcMx9GJxfTsvVilhmTrGLycCRw=
Received: from BN9PR03CA0870.namprd03.prod.outlook.com (2603:10b6:408:13d::35)
 by CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 08:40:51 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::c2) by BN9PR03CA0870.outlook.office365.com
 (2603:10b6:408:13d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 08:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 08:40:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:40:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:40:50 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 4 Aug 2025 03:40:43 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v6 03/13] drm/amdgpu/mes12: implement detect and reset callback
Date: Mon, 4 Aug 2025 16:38:21 +0800
Message-ID: <20250804084029.863138-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804084029.863138-1-Jesse.Zhang@amd.com>
References: <20250804084029.863138-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|CY1PR12MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3b4a24-2886-4f63-e675-08ddd3329e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9pM14iX51e4TQGF/7XVfxc+nO8eSecwGuTVvUwmGn5CretKAPQtdYukvcLqO?=
 =?us-ascii?Q?DIJYKPxVoKRgpaeXgVs1hgA7UWWA45bP4ADpoSPIAVHMJAMbkXhWbbaTXM3Z?=
 =?us-ascii?Q?ChpGOKBVMUFMAZyu0als1xAaT9dGBLouSpMhNvx07vsCmQj/EOOcQoYZh/xG?=
 =?us-ascii?Q?3Pn3DTr8xQbpj1KFzO/8tbkrcHTE7JPBNW+FhywF8uLo/NG3EoOcB+JrkDb5?=
 =?us-ascii?Q?CwQ9emwM3uMb2ej7jklqijkiyhp0LL0S9hyWpGP9tlCpgKb86+BWdEi5v/oO?=
 =?us-ascii?Q?gCicAYbqyh5dhuMKUFNvATCpofO27VzRKRVw3u6V8x+XWzINFFUeKqZZdQf+?=
 =?us-ascii?Q?Y5St+ZKA105V0J/hKwnbsHESden69hEhcPWUmgTCsASTyAC5r0/oiAMcdmXA?=
 =?us-ascii?Q?rkYnbxIYyZGRUGLR3x7QW3ZEbLXZrRw87yNfv9jSZde6NGn2Zvhe+KeLf3Qh?=
 =?us-ascii?Q?7ihIHWxATw5pT04UZDkTWIQTDEXrjv5q8EEGkRcMtb0HtzdPxe8lRVUh+JN9?=
 =?us-ascii?Q?39aUGoo2LZbw8Wb4RbPSE4TGoiecKyKoQo88eI91wf1sgclK4Y+cUSKuuNWF?=
 =?us-ascii?Q?yRxWXTVXGfUHwrzBO99zcQIuLdn9YbNkDZXxSKMRUAKF+v1bIQyFc7CE44zB?=
 =?us-ascii?Q?5/YU0d1H4RYXv3ksk7ZVmI7mMQKyp8otUBTwgqeicXTG+5v66HhFxg5nvVVy?=
 =?us-ascii?Q?FA1BpOjNMkI/quEv5abPqv35FU48f21Kux45/yv8SGAxrfyeqfxUY/hUvDSA?=
 =?us-ascii?Q?zY/u1/g13Mzfi+cTlAH61OrVYGFs7hE6e1eqJhb5uztg5PlD+voOw4f8bWik?=
 =?us-ascii?Q?F17pP2Vr+xoFo2dsoEpAtgsaaOXh50dc22RsQyDZ9aNnobtzBjGcYAuTx0B8?=
 =?us-ascii?Q?LsG6PanhLaDgFliPZC+zjr3CfwONUM0R+8w41jaa829aDKXmrDNIM/5Lqyo0?=
 =?us-ascii?Q?BcxOeaJ9W2GSkgEc15Ru/uL4gkC47qvc+WKxBp9SJk2cT9x9q6QhNc60ilYZ?=
 =?us-ascii?Q?2TbBwqQuyp4tmdc8FBovrclMmaF5yFaOR/E0qQAHiikBCpxfsKmzI6PNlg3J?=
 =?us-ascii?Q?Hfbe5JzfTryhfkREw8NLNWolZEOc3ehBgcdhvtxP+1Fh10mlvrYEhWRjl+cc?=
 =?us-ascii?Q?A+NwLc64ifwMfD0FShfXQ/TZcmwbgDrWd8r8AELZ2Wg+vGNcJfXpTHcYh7fF?=
 =?us-ascii?Q?Ha0Y4I3q+H2Ari5JdtVHtd2UkbyYBTxF0CNGc+7Daz4rXeBXZ9w3+doU+sZV?=
 =?us-ascii?Q?eyuJ7A4h7cJ25bXVC472qAUiZqC1tOHPXPa35qLd5O1ABGEv60EpitCCfmzC?=
 =?us-ascii?Q?22cU1/ycXKyWtb3NuH7OI6IW4O0E53bUYUr+MpZ4SbnQ7dZG2ozZ36/MMFL0?=
 =?us-ascii?Q?yh9YUOFV45DOh/HDajTZJRHGQ1daQ2C3hAXZHRSAgVUY0kOAJGMgNYcodRVk?=
 =?us-ascii?Q?Aa38sIYezmcxYSO32qjMWFlIEYy6hAr595r2Jsw3RssfyvAbHxjbNTcBFZDh?=
 =?us-ascii?Q?yBRsGtrfJ8pOv0YpiCUTRSLdK8PYtrDdXrOI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 08:40:50.8992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3b4a24-2886-4f63-e675-08ddd3329e04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9601
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

