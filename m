Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CC3C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B456D10E840;
	Thu, 25 Jul 2024 15:01:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="end2Y7Wi";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E3EE10E29F
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/a7XTm2VO1EpslXNT4ZRvCGpBx03YLLCkar4cEmOqp+AlXlfvGuOkFHPpZF0w+qshpIFdqbgvFbvGxXqOv6RXdrDf04nMTEQeHEfbXQKTud9bq4oTO5vl8lYfUUHnrk+pumtMvIsVg1i2TPQaiB+dXhrtqPloRLuGspFCq0pbBDDh8hosx3VlVmE1+Uuf+MIDPOUxCG2qGjeirFbp/xenTT6zYeUtifEO7VqWrfvZ5m1RC1GedDPEa13VOeKmmR92iQ/CjfxksjTDvs+P5xF2RL8BZ2VJHrog/9GVmK4yJC+LACC+XkJgmn53YVktL9NtqgoT0UT2dWiU/YFBMOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJJ1lwGg1Dekyu/QJZmosPg6DvQ4Wy9TFgeoDFjWJMk=;
 b=Dv1ymF8vCxrCEFeoqaDEBmu+og+yGNthPUkKeqSNsxJ+cN6RnsifYAiXyL3y8Z7bcYfQXfsPDxIKaYrOqZjUITH7p5ZjjaJIFoU7NRGlQ2KTB/hPwAC9H2ARR4DgRNPvAdl1lCnIgoJxNo/uK505KTgDa45UPs4FE87sR1g1dRVVU4bQTjpPgCw2yR4t6I6jSrongOB8eLKQ5Oucdf5tLFxG9PxglY1B88kULjhKGf7xFw6UIS2Fa/6mygzK+LseB+ymNZFYCQxoVDFZ5HJUWkCNHVU7wjC5cnAVl6msbf+hGHjgO0uSWY9SqtObFeg+EK1NxbWHIZLBW7wUSdSMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJJ1lwGg1Dekyu/QJZmosPg6DvQ4Wy9TFgeoDFjWJMk=;
 b=end2Y7Wi+Vu8scDz2Yue+FHUYPzZ5ZIWs0ZGdJyHVOYzbkpRjByjs182xwqodY6+oWGCLJw6LuAI8lB/TgyNIfdXUZL2HeYFFt/lfHQPnxoyXFOm5665Li2rGL3mTYXJpZadCQ0t7CIeyMPxUnt11Uiyfw5+dNq5KyYGHgcoMro=
Received: from SJ0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:33b::30)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 25 Jul
 2024 15:01:15 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::af) by SJ0PR05CA0025.outlook.office365.com
 (2603:10b6:a03:33b::30) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/53] drm/amdgpu/mes11: add API for legacy queue reset
Date: Thu, 25 Jul 2024 11:00:06 -0400
Message-ID: <20240725150055.1991893-5-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0e4a4f-efdb-4902-d91e-08dcacbaa144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cTMASR9AjG1dFp8NiL9mdB24xDppaiDhu+LSVli/2ljlGy2Hj7/5hlXPZaTQ?=
 =?us-ascii?Q?3z1gx/deqDaUjh6ssvsReF1o+lA6XUvgKRCYAERzO6C2eQyWa2XTvolN6QBW?=
 =?us-ascii?Q?+NaXl+T3Mm7m2ygcrzlzYFQKND9AxtJFEiY92wdEXZDhTbTkKvgx5XHLk+oR?=
 =?us-ascii?Q?V9j+sufQJHs0vrw6+gqKLKHDYO7XUU7GCD92n25W4O6HPMIeea5vFzLjabZj?=
 =?us-ascii?Q?F9koHGjnIIMX1spXwJvPJXgpRvL/ngbvgDYStA10ywKJIoDZguIGA9Ixy5h8?=
 =?us-ascii?Q?tYhbib0B0KZf0l1465zxoYxysdg8QXgW4pyD0Kju3by4I1bSQr2LMCmB+lJh?=
 =?us-ascii?Q?Ykiw9CHOpTh9BNvvclO2ebKNMsUbmmskrs9XmOcHZoWs2Tb2HBwvZLodvQcq?=
 =?us-ascii?Q?at54F0P2FObq3FT2UkfZ+KOkQ+Y2UbVI+4P6HrD6TTdJeUD7xJ5TqnJMnhYF?=
 =?us-ascii?Q?xSJK91zk+1nRkZIcBYUPoGzeUMBksuqS/bUmbuE+R40H6RDe2iAedPeBWHSE?=
 =?us-ascii?Q?E+BPPc0lhR4Ykd8eGcMWm24OjcHlt/M6Ni76HjvCPB2WJZPEQMkMTy5gs/Hh?=
 =?us-ascii?Q?y5nX6jTQeMYOmFir3JEPDgxzDQDaaXYmX2BV7e7HC4Tu+q1324W7VU18EpIO?=
 =?us-ascii?Q?Wu51rzZqxXyV7t/G4xr4T5dw43LwsEX6kXZNHR6Z6NJ6J+hdogfiYjmMaCWG?=
 =?us-ascii?Q?BFCgWJZOAeRZY5sM1+A4JUz8EmANc0IcaEN1XqtgrJDDg0xcv9ZHZqZtbM1/?=
 =?us-ascii?Q?WWvhgeNMj0Vr64rpFZoO5bGk4C+Lb5WQ2kRQq53rIYINd+zuJSJa2cuBNBtK?=
 =?us-ascii?Q?Pd6NpuxSzD44GF3kdEZCwFVo3DDVkDybBdsoXTKaNCpxwwRHUvNublXQ9p7P?=
 =?us-ascii?Q?MJ/6Tc68+0eocVUVWmvPh+h6NRD1qR4xnxaA6zKRwupHLB091l2mP8DgxyeZ?=
 =?us-ascii?Q?s63oym09QT2Gpf45EoLcrs1rcv61dFdF0Cle+C9sqVF85M5kGg6PX0HNRSZO?=
 =?us-ascii?Q?uuBcWzi3ygXkJrLWKoGOioWi18bMXhOcHAcYY37OE7GeU+uyk6GKTXw0FtK9?=
 =?us-ascii?Q?5z/6yIPhHj43swz5EWozCswBIe3vPBWE36NZTKol3N9YDmAMzgV2EGiU7cxj?=
 =?us-ascii?Q?uodnfPdLqFv3eiUb47DgeIEaorH/DyfCUdwj2XHzAU1BWsKgqSDf2b+BZLNL?=
 =?us-ascii?Q?banMiC51kZSZRUji9Qh0qPsRUbR25DK/OuIqLQ5eQduqLW0zIqvcspulZSHh?=
 =?us-ascii?Q?4WYUxmpUKmpmHmOo/tqkcIyTk+F9c5Y/LL22VU9+ZZ2ECCdWCwi7NMUDZPU/?=
 =?us-ascii?Q?MhPR8rS/PkNAzEGvQe587E9aet6shcds3FPLPghUTNhrS5LN/9BbCvyhrbAJ?=
 =?us-ascii?Q?FD1dIrKwlGk5rP66zWxRl3SGMQRxxppTWwNzL5llNP9AdRGuY4HimIXvUfU0?=
 =?us-ascii?Q?0+XQxtcnewNDlCr6x5JUIPw4dMKtu+QP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:14.8212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0e4a4f-efdb-4902-d91e-08dcacbaa144
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677
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
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 218323e59f55..afcc10e21f6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -597,6 +597,38 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
 }
 
+static int mes_v11_0_reset_legacy_queue(struct amdgpu_mes *mes,
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
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.add_hw_queue = mes_v11_0_add_hw_queue,
 	.remove_hw_queue = mes_v11_0_remove_hw_queue,
@@ -605,6 +637,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.suspend_gang = mes_v11_0_suspend_gang,
 	.resume_gang = mes_v11_0_resume_gang,
 	.misc_op = mes_v11_0_misc_op,
+	.reset_legacy_queue = mes_v11_0_reset_legacy_queue,
 };
 
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.45.2

