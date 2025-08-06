Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A91C87FCB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 02:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C8E510E709;
	Wed,  6 Aug 2025 02:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i6q7swml";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E7C710E709
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 02:29:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yO3DazB+U0BcPGDJPfQR+MziVVLVLjFfXzJtT40Z3GwBxL+4wQyBqDVgaA/7Un64t+3GEM2Q4Vn7wSsSgnva69IOic0xIdfIKenIzwuCnk+x1sOOwJYtCnunUhAz3fGE0tR4GVV4QY8oMqGdc2gY2FQ4d2FW0WqGdlAypKAw/NMsS0vVCc0JisBue5r7SlVvh/YGtb/6GjnogrwI0CtVOsU2zooqeZ4BWgIIjmc7b0ioFrdRty/1eg4sJrZ1nv6s03KBkIBHXkiD1G7zPEQmEShwby90YxIaSB9y2uLVkZOLJPt+sFMFjlbL0kKSmTJg9Ik6kf2v+mtNJGZzhZYQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS7u0vRL2HiVTwFO9W8/2ObbCSb7pvCpsdKBTv8lRc0=;
 b=GEoy5lygZBgGyZwSD39ua9vkduuVG1qxfLb4NHbjfGfce/SC8tH6t66bLC7C2C8GgRf1c66EAtqPCYyG/JavME6/3TrWB/BsWJYo1hnBQH5Q4x7WkRZi5lFOJoS2aff7t1GtFUzTZHN1Fzv2ibljV9zfeaLEpe3TAWk5Vmfdoi5qZfMjmfWKH/eRMWtgr4LHgHKbeSFpU5uRPHwzStPegOjgcEg70dxM1jKk34KOcEkfx8ZEdDftRhOK2GJMUJ+cFKbsDF8qMqp4On1U407dHh6zd7E38f5MrAe/WXlEORFhISs7V0s8gEVWaA2TFaxK9qYlBb871rRYJOIhJDJYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS7u0vRL2HiVTwFO9W8/2ObbCSb7pvCpsdKBTv8lRc0=;
 b=i6q7swml9oTIhopboW/8ibRCFwH85GYUONZ6SXaAFJ4aCfXrSWCQSBBzCL4K+R022dRPDc0a5SxOlTtYMRF1WV9+K8uNz6Z+CAuma81ym6cjO7C5aMl0N6mAt9JNJiH9sHKxANGC26MbSwVQxEg6qHuFU84o6s3Oznu1pj+stjg=
Received: from BN9P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::18)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 02:29:07 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::20) by BN9P221CA0016.outlook.office365.com
 (2603:10b6:408:10a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.13 via Frontend Transport; Wed,
 6 Aug 2025 02:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 02:29:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 21:29:04 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 5 Aug 2025 21:28:57 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v7 07/11] drm/amdgpu/mes12: implement detect and reset callback
Date: Wed, 6 Aug 2025 10:24:52 +0800
Message-ID: <20250806022816.1050823-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
References: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: c36e0d13-1677-4f06-7ecb-08ddd4910454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DSTlc0TZuuw0B44w/F91Q/OZ0l81LRzTrmgYcLSAHZFFBV1YzsJwWxAR8fC3?=
 =?us-ascii?Q?Yzp2lrKuoeO/ro0lSgkQXsodUZMUn2tTWm9wAibkU/fabNdJmXNt+X7CRpKc?=
 =?us-ascii?Q?dtzQOHrnZDapU+T9jCQGlNTSoSh7dOUTGDFw1y+ZPHPcA6Pn1uunEPElktuG?=
 =?us-ascii?Q?1zUZREV9gUmJjnHVksGnh7l5dYOJSm4fQ1t7ND4WyG8NuZoCHiFNohle/e5K?=
 =?us-ascii?Q?dPgiANAjlwcDhKSPEtMWGiE7D3r5G+plfCW6+kZnv1Ii2lopz+cgprcoShaP?=
 =?us-ascii?Q?/2VkiXliEydGAYD+uzpnjUPEQt2EMHgtxPFxPuR07/HDTRL16x6RGGDpcV93?=
 =?us-ascii?Q?vpngHExopk7Ull59TN4QETYcMQdxBySfBJyK3cBpmXGm/roahiL+6UyBJyCx?=
 =?us-ascii?Q?7P98aqxT7jZM+WNl4ZE3NxsrSdLP7uTA9voxF2kxzGuHnjUEGmLIYSARxw6q?=
 =?us-ascii?Q?kixazLOrS+xfpR3SDM5Q1YKLNiT6akTU8lcR9wstmOjyqVMcchF2NSjYa82J?=
 =?us-ascii?Q?2PCz1df/XF5ar6ZLrQ4y6+7/WS7/uKQBdZ5067h4RRtNxFnjimJCAb6AKKJE?=
 =?us-ascii?Q?QHzjbwj2e4lTLVmkqaAPcg/MIreJ+6tU+PgUiQ8zUYi92CswgcMC0K+SuINF?=
 =?us-ascii?Q?2f/9gIS8EP8p+X5xgsAVCOQLbJf6jfLt6Hy7/z/1TIMsPbKSYkNun41CKl2k?=
 =?us-ascii?Q?GnuBgWVLl5MwJWqIgVCsQyPVkhomKLShAPH+tj6+QDA4eZjn7Wc8fZ9jaYjX?=
 =?us-ascii?Q?icDTQPe62CNcy+E9+/qrJ8gffnzNrH9e/+Vuu9/XJw+QMl0L7kaJPDG1iyyk?=
 =?us-ascii?Q?o7UT1jBqjX31uBG+dzMCTzuG9ftmetuTfWfWtAx5DI2hTMf0TPDRoxuQMjNJ?=
 =?us-ascii?Q?tOhIhkU8X5jN3lbesqnBd6MWuCZ/ywjn+De7ur0iSFkEgpVWxO/0lm1pK4Oe?=
 =?us-ascii?Q?64RWCib0VqRD0MOExWeY3zIGcVMzVqOAHWe1l2f1+hvBlHrZXj6Atg81rQck?=
 =?us-ascii?Q?jk8Tc/JdXoK32jpDiHJeMA0WjdvwQMlKaYOigmDxS2ZacWhzfbKXHs3g5z5q?=
 =?us-ascii?Q?m/ycm69D2i3LfLFF0D30/LX8N5mGmDT9y4BW5LMtWIaq4q4uyBmTc8lMqlCF?=
 =?us-ascii?Q?3Cz7EYsjCPd+bs4ZiSJautGeJ0ZAmLrwlQ3/mAPiO1EK50gRE16jLa77c0T0?=
 =?us-ascii?Q?eGysOd+iuuUVXn84e6yZutlnC4eWA5gEWsry3xGxLp4cFgTFuq1Kr0UfEIdr?=
 =?us-ascii?Q?xHX6dl2N7j9dtMtYP7VUdmxgohOGHxnA+/9oq85m91kpANHbdSek0nf73XQ5?=
 =?us-ascii?Q?/c3TSxXLm0ddr8tcyyucmS9j1ouWsWHtpdJSb92E2OjD6E9UbXeU4iJtd7NZ?=
 =?us-ascii?Q?mDmsG5WSjNo+B8UrjQKvwXNHtRZgYI0REpW7CVbonxczOy8PmMk2ypNbmU8w?=
 =?us-ascii?Q?7TAmHlkqPuUVojUwM3ukulwd1orw+CAhpPtRMBTpkZHITj/rXa94fNpL4D33?=
 =?us-ascii?Q?Je9nbvtinWG66BEO4ScUHQQNlbvY1og6qTZC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 02:29:06.4044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c36e0d13-1677-4f06-7ecb-08ddd4910454
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626
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

v2: Always use AMDGPU_MES_SCHED_PIPE

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 24c61239b25d..ca06046c5d68 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -47,6 +47,8 @@ static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev);
 
 #define MES_EOP_SIZE   2048
 
+#define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 4
+
 static void mes_v12_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -907,6 +909,32 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v12_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
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
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
@@ -916,6 +944,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
 	.reset_hw_queue = mes_v12_0_reset_hw_queue,
+	.detect_and_reset_hung_queues = mes_v12_0_detect_and_reset_hung_queues,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
@@ -1821,6 +1850,8 @@ static int mes_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
+	adev->mes.hung_queue_db_array_size =
+		MES12_HUNG_DB_OFFSET_ARRAY_SIZE;
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		r = amdgpu_mes_init_microcode(adev, pipe);
 		if (r)
-- 
2.49.0

