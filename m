Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17097CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 08:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA57010E5CC;
	Tue,  2 Sep 2025 08:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zIcBWyYI";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E27F10E5CC
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 08:07:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zM3w3NwoWrAjkgjB42NZhRRLkLMnuynZ7ie9zjBMLlrYxJeQL8GQ22zYh+12wD9Zgkzkn/yqNO0GFX2nEExBEVBagYhCubS5nq2P3Y9IGUUhThUFhGVQZYxSK0mwZ1MAae0x2eajMw7NjzY7XVNml3IFQV9uSYW1f0GSyJKwyYx20VqxXTd3wXjlp3ITQJzghkrMhlLBHUMj6iuBZ8U3K2OnLcWgvoZhoQJ82LwQcKsNPToxNHYf4pzVfXCFkCfAVC3PzMhJ9/4W9zfAfHNUu7239wY8uN+rTD/sF2KVX0cW8oUpBAwmUp9f3e3WRuJK6cUbiRFnM/xeFE4m065q1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=pf5lymQiF2CgdIX6qfu//zg00VLysZEF8LyF3Aq2uMqKAiAVWr4UJErMYz2xyix/ZOC3Qymw7uXRcbc/2U/y6e2eAZPnuVvSdP4lC+jjfIr0NFOPUdPk+ocVx9BYzjWRwpHkcrKqJnCQdeoGi/jNKWrVsm+I06fPCMcgRLKpN4dykUkKHFY7vhtPdFFrSP38OcWMqNiNKd5le/7Jsi/7vo28cJ9f1Z6zYqCEN+W21SlRbo03nVn9Hs5RAlxjjWVyKARrNGbHRRjVTFv8l2Rz+/udbJW0ei6Umk0FeVfv7T2K00Nr9KVyqEkHB9v+xcxbmizTnrjfCxaDdN8inOaiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=zIcBWyYIMmR18Y4dNDzRYeKt/rOZp83vudvx+YpQb4mJzs8B3UrsBGBt3k5xJ009E7cA9vMW9itEKjTjOhECo2ge6ZQlWaezUw7QdXVI/bUlNFpGNrkwaHnOKRl1ZDjEbwZh5lWf0lshcL+gNzzT5bM/wPzxAxBCStgYSgbP14w=
Received: from BN8PR03CA0036.namprd03.prod.outlook.com (2603:10b6:408:94::49)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 2 Sep
 2025 08:07:47 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:94:cafe::75) by BN8PR03CA0036.outlook.office365.com
 (2603:10b6:408:94::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 08:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:07:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:07:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 01:07:46 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 2 Sep 2025 03:07:40 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v13 05/11] drm/amdgpu/mes11: implement detect and reset callback
Date: Tue, 2 Sep 2025 16:04:06 +0800
Message-ID: <20250902080712.2515811-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
References: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b1212a-3965-4d2d-206f-08dde9f7cdc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8cs8fshk/ZI1di+cS5IuYIPNyARKdDugOfn9VenH2t4s7xtnD1KmokeNZzPy?=
 =?us-ascii?Q?0ruKK1mavUfdTouNogxWgfBFlJFPHuaYlalEEukC1PNHzbRyHAldiquVG079?=
 =?us-ascii?Q?rhD9wD8JC6HYuTtBB9M+DnhMcWgGNs3Wje3K+jMsJlu5EQp4CUhzAaW+aOHQ?=
 =?us-ascii?Q?2KKhNkkeqE07E+j5C+Z0LnOnmOpp2IDLHEOPb5Z2N1Byqod4ZOBVoC5jY0lQ?=
 =?us-ascii?Q?u5QnmC9I58NYbwIT6uBon61TTbdwJPEjpYX8vHEo+kPA2IvgS9QS8O/0YPS/?=
 =?us-ascii?Q?G2fHtIHiYNG7QZ9Svnmj7g+I7RGKt5Q7vq527pzsYp4v3VinsFNCCwxP8ZgG?=
 =?us-ascii?Q?GKR9XEckjNN3v9wijslF/OFAf8GI2h+EbdZOAnpKUuJcjVszEnIGKyaPsMiq?=
 =?us-ascii?Q?DR3QdXlwIkRcFYgonCoViZ71vyjehf75z2h2x7mXXbvUcefDhSKUNZwrDOzz?=
 =?us-ascii?Q?RKJVSv+UmDpDL6EhJhnCY7tJneFtGYICeyrJXWgqp8IhfSgyOmhFrH1UhtUm?=
 =?us-ascii?Q?2tIXU+m45e9t/jQUSJT4zomzCQVdsAInWlBQIinUzoA90nMcPh5ZmvZSShGQ?=
 =?us-ascii?Q?jajxM3Bp97Xiyl45AcN1oB6LjRlhL6xz1FfpaRD/UeJ923uEqKB+bLspb7OJ?=
 =?us-ascii?Q?fI3K1X+pXhvZGcZ8SdB5FNThSCrLSB3t7eGJwAVo+C1dQZLGdksLVC0VG02Q?=
 =?us-ascii?Q?m6Roews6xV+jy1N5LJckDCHgg7wTeaj/uRDjF06sXytBZ4osNhx3PXgRCKr+?=
 =?us-ascii?Q?trtgZMBtF9FVPuTMmEWugPDtdfnJ8NWMWsgTmVyWrhnuU2GrSyZDHS1/jJhI?=
 =?us-ascii?Q?8ryFEBz8olLt8ysU/4ogTmIqfLUoGtdgIqZKjJBtM26xkaZ+G0B8cKuSP9p3?=
 =?us-ascii?Q?XJ60VEbzVWHz1k5G+nWKE1zInVYzBFCl/I/WF5tnHHJl8BX4GNgNNH70pSu8?=
 =?us-ascii?Q?3gF8zS1m8+oXpmOmRN20lhDOIwL+6dHPKd9rE95fLeAZyal0PGB83WWMiOJf?=
 =?us-ascii?Q?y3IW5YEUTGnPFYsbI7U8NQqe1NcZzM00Su3UQmDkXDD6goWFgQDkqdrtrTVs?=
 =?us-ascii?Q?iZA67j+gENlyFG+FbeZRMCWbzs6hcNV7ZItkV2zGiNYOPmBKqwhnhayirOwC?=
 =?us-ascii?Q?P4fMx6if+BfNUebDX+LtIPjAtHVWwKJCiPVzUCs6dpybK7tZj2xplyjuZEW5?=
 =?us-ascii?Q?1Nw6hFqaCc29llGi9EHQX055iQ1lhyQKvL95Oq2nkzX4h6XmTOqy8UwBGP3C?=
 =?us-ascii?Q?YUQbcQUKXC7uQ8qplP1G71+YZliL9Ak6rOg83TQ+YXMuSkbHYKEzVqhO9nrL?=
 =?us-ascii?Q?MBlhvPHnX4qHEB0o3xUfH2HStnPCQ+F1+g27R6flmR/iViR0kcewX4qIKLyH?=
 =?us-ascii?Q?kn2UDehcbWXVL5GG7JqOMtu/cGt+8sPsfmdkvYo7Kc45HZjO/CXbDeGL8F61?=
 =?us-ascii?Q?hAJvmNoqaRg04JZcVaNoIJd6FR+GkRjt/mvwd2FAvXWEduf2p7t44rkaY2CZ?=
 =?us-ascii?Q?i9xKxPyYUYkJ+PvaK6IERhRDh//8MbfeFQpr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:07:47.4208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b1212a-3965-4d2d-206f-08dde9f7cdc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049
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

