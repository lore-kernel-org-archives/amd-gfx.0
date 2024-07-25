Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A9AC3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D0E910E85A;
	Thu, 25 Jul 2024 15:01:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uojJ2aS8";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58AD910E844
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmkygY2RPJZ9BPFFq3Dg8km3RoQQdcTwQdjPDJWHGfJaN5y33z2iboDEFtdWkMJdMjJ6a7J1vrAW14qZ2XODAN0h3ikSaHAVXwsE2nP9CTGVieLm/088VYR/G9jBsXo73HJFySKd5Wmm0is9Ade0PST+rfqETEyjk2kVEkeZGPf12R2ITUbPa4orZCw1LjY5uL9FH1ePFCOe9jE5vXoNQYUV00IoVXoz4Rz7kKo4zNjr5ji5mvf+l27A+b/0IRTVfcMcCgxlYmZyxxijmvIKqU2tLIZ/wBgdLH0GK0i3pCzRbQQaL1ed8gZYhUcjGrxH0/NFDAmqWocPvTpBKvoLag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4VVCjYMgzq258w44ZVAm/rt3siGxTeDnPl16w/hL98=;
 b=otDOFSUZygMQJBXdd0yGjZAgsS2Ly6BGXm7TJSEF+K4K46ZXuQwNPhyiGEI/C/koY+gBTddQ3wVSHbq9N5/Fl/h2H7TTvUEF05tJFg/Nx2o+mWAZeH5m1UVtESGZnr8KyDxVht+FC+GNAScATvFtY1hdRsLF+tMlRdhyf4IhZqcff4HuaeMrVgiQSn6/KGSF7TwSH4J/+3l1cGhUnY/wEf1yFpQfFcf6OynB+WBjcTRCThsWPcHOTM/rLaHWgcvR0ll05YVZvHArrc5Wg18AFS05IzdQLNQTmx81gWAlb4kMy+jbnjeAOMEhUvn7xf+kzkzQ2V/6XlG29i7YKba5/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4VVCjYMgzq258w44ZVAm/rt3siGxTeDnPl16w/hL98=;
 b=uojJ2aS8kuacqGI8dSXhw7VeDCf8Wr3ZNH10AXKg9LuyBtQifpF9bn83vDfPRWys09n96fEXHVhLKmc3KkuOnOAt4L2KXLoAJq9j0dYyZqSCtlo0XRO5rPGQSyHAMGlqs9bqWzRj4HkZDgoqtC/LIGIITyfzo8424CIZ+P3U/8k=
Received: from SJ0PR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:33b::9)
 by SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 25 Jul
 2024 15:01:16 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::77) by SJ0PR05CA0004.outlook.office365.com
 (2603:10b6:a03:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/53] drm/amdgpu/mes12: add API for legacy queue reset
Date: Thu, 25 Jul 2024 11:00:07 -0400
Message-ID: <20240725150055.1991893-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|SA1PR12MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: c09b9c32-ad87-4e66-5e3e-08dcacbaa1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1FIgYiacDIRRpY41mc1pbd91V2qgB2YLw3/DUKgfkmnpGcWjYbNWZM/7zMdQ?=
 =?us-ascii?Q?AgFBeCtf69W7MB//aDgEUV6xFmTltNBAfnZ3z84qX7ydTg0vmzMlYhOGFipP?=
 =?us-ascii?Q?bi67ddrpebYGVq0jO3rs909iMgnQE7FHc7PPa0DhwSgmFjjP4f6upWH5+c+Z?=
 =?us-ascii?Q?zpSd60fmDHFx/O6nWmnaRKs9YnNYXmbaGyJCPe21K7GagceKRfHF2Ylr9nAK?=
 =?us-ascii?Q?8dMYUYR5znkw3F9fFdg88kV/xONaXVHOI7ADv97tImIqhD98iYcuRRZcvugZ?=
 =?us-ascii?Q?NBVP8vOQtrkgAfwetbwCFDeRBAKbICfCirq05ve7v5FdAPMPNoNsYaCO6hFp?=
 =?us-ascii?Q?cBSa3AxtZeCFW01qOuGxNy0ndn8H+NP/V76UNN2kW4TMgTSXDdUp4Eu6P5xb?=
 =?us-ascii?Q?gj8kPHCj0U+5t8GSTK/nI6YULJaxJEe1o5TZb9tq9oVHBQdAOjHIGqcUutnh?=
 =?us-ascii?Q?UHXST7kdQp6W1UQGXhzwy7aJ1QWgLHIrfYxJd1LPVbZYYXglVb7IlCc5l4qL?=
 =?us-ascii?Q?obfEucijffWuALbFu6GS7WSeXPcVYD2+4/Bp0414E0H00EogKHfk6TAeZLnX?=
 =?us-ascii?Q?P/UobNFRsOHvbfYu7VBtjnrM9mKVTjE5WkhTkLNdMQToMZSGRr6hYBS4IDsH?=
 =?us-ascii?Q?Rh5MVEqyjoiqCurtnatnJBPChq54dhAYNgWyIq1dl8ULBMcrRNSfz61Y/tTy?=
 =?us-ascii?Q?cMX7E6WF2kBNaUiaQrfjUQk30isExkcviZsTavU6m9H0BKQnWqv0FfcCSr4a?=
 =?us-ascii?Q?qL0dLRzwMKzGrChfRW4dmCFLp0cFJ0nMevtoRaEQ8yhKFPPlLquM88DJpY+j?=
 =?us-ascii?Q?k0ph+I/Bj6cEZYU2fqNt0jdjguh0D4X6aaxQAvO1iZPC4xL/AqK0Yn6eE/rp?=
 =?us-ascii?Q?KsqlRVr9rlvUdtVNwCGyFHwOQR6rITBb0WqUj9rCFh1UJY2HlNI8jF2XEtPk?=
 =?us-ascii?Q?5Wk0ntsF5QHUxTts82kTIZ0xHU5qFIwwNzSPn51pZC5naLAXusXXyY7TB++a?=
 =?us-ascii?Q?zPFGXSnR3Bx12ucGhJqYqNdTAWdftAgLSJ3RmgWGCSJg44kKqusayEHyLn1s?=
 =?us-ascii?Q?m4UnsM5LuuvWRruuKlZLE4NdeDm4CcsRuPt0pBnZ1CoB2ITZoudTKskSxAnh?=
 =?us-ascii?Q?W9zP4vhmSrMO6CimbEE3hqfWXCoamchFPPDsIeVZ3vk6BwhRGBVrKiiZ9i6k?=
 =?us-ascii?Q?rQeId7WXMaDBVnYfz77NDez9Yt/5EYP97l9REBNS4Xwx/Fq+lE/oJ23Npoil?=
 =?us-ascii?Q?muV2fM2g5bb1oddsTBmmxCvFzzlQSBgfUcf0pZyxIewiwJb464X+GY0a8wVu?=
 =?us-ascii?Q?ZxPuDtEGJ4xXhsykbF2buc+Vq9ehfvwl+RseaSSynrJuYX1x0bHY/pIHNQS3?=
 =?us-ascii?Q?f0GkXhDZKsbMLHLo1P/OC5aUTnJ+5jE78VNHD9w4exXEtCAugVKz4knkG/C6?=
 =?us-ascii?Q?f+JNKocmhcFpAQ9BLWLa8SaZYTttk8YP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:15.4774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c09b9c32-ad87-4e66-5e3e-08dcacbaa1ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037
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

Add API for resetting kernel queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 48e01206bcc4..37539092f59a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -644,6 +644,38 @@ static void mes_v12_0_enable_unmapped_doorbell_handling(
 	WREG32_SOC15(GC, 0, regCP_UNMAPPED_DOORBELL, data);
 }
 
+static int mes_v12_0_reset_legacy_queue(struct amdgpu_mes *mes,
+					struct mes_reset_legacy_queue_input *input)
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
+
+	if (mes_reset_queue_pkt.queue_type == MES_QUEUE_TYPE_GFX) {
+		mes_reset_queue_pkt.reset_legacy_gfx = 1;
+		mes_reset_queue_pkt.pipe_id_lp = input->pipe_id;
+		mes_reset_queue_pkt.queue_id_lp = input->queue_id;
+		mes_reset_queue_pkt.mqd_mc_addr_lp = input->mqd_addr;
+		mes_reset_queue_pkt.doorbell_offset_lp = input->doorbell_offset;
+		mes_reset_queue_pkt.wptr_addr_lp = input->wptr_addr;
+		mes_reset_queue_pkt.vmid_id_lp = input->vmid;
+	} else {
+		mes_reset_queue_pkt.reset_queue_only = 1;
+		mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
+	}
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
@@ -652,6 +684,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.suspend_gang = mes_v12_0_suspend_gang,
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
+	.reset_legacy_queue = mes_v12_0_reset_legacy_queue,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.45.2

