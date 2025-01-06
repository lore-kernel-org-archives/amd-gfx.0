Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EF5E77188
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 16:47:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 366BC10E1E5;
	Mon,  6 Jan 2025 16:47:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jCgD2qXJ";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C9010E990
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 16:47:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVE7P5RJAt8x37Cqa4iS8pGC9JW9HG3NZQcDgcG1Cwc2bG25UyaEdZSSQfXSGN9lIdOAAiBqnyiQEGwT4zMqakIbuHjTnp1um6VwqDRrGQnED95UZfynk/MxqRM8LAaPaNNRHuMj4tMtxRFTQ3ybQgkbmuq0RR4P+R6Qv2Whe7P2wZGK+TMi/AY1qfofIO3hEDxsjTvKOCrFevVBk9L4Y4SWTzCYf7BAXevPrnRK42TJcoG6TxcicSxRkJ/oTP27b+5E3ATjQh93AwBtSCyP0Q+h1mhNgKFNyxEwpPxRmvD3Pf6lWXP5vzejahYgRrSZBkIBhU0HHODvnqX0uWw3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWUADiQdXlg3Ok5lO4iCfcVBjASi+00euBE+6ocBB7g=;
 b=TrIaa2wVwB1gANDUDxJXJAffIY+oqMNQL5u0Dg86TY7ui1KcIJhuox17fE2WMFWjWIdxzLIukkmrhKtGosvzmcqKcmO28P1H2P1bB+4KWVEgxX2DElWkzHgkWxVlt93txtM+wVkoxht8MKP0RbpJG51i7V7yHsaj6D/yU7NjxrD7k/lqPzhhtxm0jD/jnTCviTtG45qMGPInUjfbNxxCwii6yrLS52MWElkLmA6qVLg9bFVMkepb2VIbkBBnxZP5DSfHuVMqYXCdb5Zjskh2X2GRDsEQEiwWoKVMtciJqJ6clMeEsJ0rnvfUGelNyxRO+iDP/YBNq1N1QDjcGW8apw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWUADiQdXlg3Ok5lO4iCfcVBjASi+00euBE+6ocBB7g=;
 b=jCgD2qXJdo1tIbENPaUwmfwQ5LZTQ5zTMROvUnGce0hOW17fKhnwqd1B4DhgzXhs8nP2wLND/Dnll4dqtZp1BCPE2EK+LV3pqPbgFVYpEkPKhuM4ejnCF3vDKCJT3DXUH+eh51JUM831ibJj/8PGDefHV8MgAQcdqpckZugIMZg=
Received: from CH2PR07CA0064.namprd07.prod.outlook.com (2603:10b6:610:5b::38)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 16:47:03 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::4) by CH2PR07CA0064.outlook.office365.com
 (2603:10b6:610:5b::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 16:47:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 16:47:02 +0000
Received: from saleem-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 10:46:59 -0600
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <saleemkhan.jamadar@amd.com>,
 <shashank.sharma@amd.com>, <veerabadhran.gopalakrishnan@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: add db size and offset range for VCN and VPE
Date: Mon, 6 Jan 2025 22:15:30 +0530
Message-ID: <20250106164530.763188-4-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106164530.763188-1-saleemkhan.jamadar@amd.com>
References: <20250106164530.763188-1-saleemkhan.jamadar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: 67731caa-c88d-4235-a5f1-08dd2e71bede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kD34X78jEE4ZSR51aCoL9gPuzFor4vhTkwxcvBQanrWgy56RO502OVQUcAgi?=
 =?us-ascii?Q?Yv7aiQ/DM3ui4txmj5uQvXPebwwp197gsJr99Te0ufuXSCwdY9MoB0rmBW+p?=
 =?us-ascii?Q?ki3Y3URF9HX9hPR7cqGxfssLqpAFyeGtSK8A1Rv4L9MnIOC/wC2TdlVH7ZjS?=
 =?us-ascii?Q?vHdgEGPa0cf8H9pQ083KTX1cMrEvppAWXSWo9cP+ik0VRjUIgesOPSkTZvrW?=
 =?us-ascii?Q?1U410cr/D8AGaOhBKimMssSCuLReWLH2a4BMOzKudevy5pmHeh+JoM9d06NH?=
 =?us-ascii?Q?3mSua6ozTYVU4gB+pokkmgETz5umYdNdSVEv4c4jGp0o1q7F0yHa645bT5Qp?=
 =?us-ascii?Q?qnQqNktuJgMF91llYUvi8HW5C8QzrV+3veVz2f101Khk4tvsxIoo55Zv1AfI?=
 =?us-ascii?Q?vQzpaFbzFtDaiQ7DiSGDzPA10ENhQAZajbFK0i38oFoVG7unRgkChUgYesqK?=
 =?us-ascii?Q?Od3PkOypA05J/6WXDplnBO26XR4xYgZjCh/GqamJpjJ6uuSQtON4qDXwXwzk?=
 =?us-ascii?Q?xxF3M2wuZF+99fFh+oD2BcT0QRWeY4FL78glDrLE4wYgGzR+yvaMttGXcogH?=
 =?us-ascii?Q?dmpRSajn4eYXKVNyvoBWRc7kGvvf2cwErYZz0tCo5Gdl6OpK7IsPUfQZNJvC?=
 =?us-ascii?Q?To3C1mQKt4ewd2x1dSM1OsWSmCwcdYgrJTqEIlarZKhrndCJYOKOIb6AtR4s?=
 =?us-ascii?Q?R3av95/gHbwoU+LtXOsDLMKx2CDNIDoSPMPPQI6jqy6BN70xNdOu6xj2tOXe?=
 =?us-ascii?Q?UA4/abYvOpHwUx4k9fZJF0NuQE7v5jWocNIqoaHwOY7JdUWR/JCSXCBXvRVX?=
 =?us-ascii?Q?yRgB162naiBZGrcDDQMFSltYDUV0jPs4D55l9nYNFQboZ3F+eDNFt2vH/7j1?=
 =?us-ascii?Q?FbYVOiy6G1ty68hyvHB0yI5XYiDbEOaVxAXOw0T86l21aZIeW+RAKHvSnT8E?=
 =?us-ascii?Q?pgTw5e7ggJfAsiyFVn7kqeJFG3MJUaC0huistUbKHC5aop8+voG1NTfjgfVu?=
 =?us-ascii?Q?VvMUm0+W6w1A/J7JYcmS4DdRhDCkFi+wg0bWcyxvFIPyjOkoKhNZPnXA5ape?=
 =?us-ascii?Q?AXwsGOgS7LOjb6ZMWGp49w5b5ktz/VXOLz80k97Wvym4aWG6EFR7uj4TM7Wm?=
 =?us-ascii?Q?l6nMLknMpdCOJd3oANU191u0KcaeRZB1BYMtNjjqeh8Y9DE/NXh8OxhlULTU?=
 =?us-ascii?Q?WNAhYD8jiQjoRNwJvIdExUEJQrm3us32yp8b99mtpbRHVGGzhq4vJK+3Sk21?=
 =?us-ascii?Q?QcMNuvosQ0NU5Hv7LlgpHNdouLZNLqPkASpauk9obzFSv+fGERlsM8Z/44RN?=
 =?us-ascii?Q?EVr5ElmxEDFYPhJXihEDQJm3whOAxsVUgZxOxst+bReboRtbiklwTNKxZyyi?=
 =?us-ascii?Q?9r7g7PeofDOJK9Hdp25AlHGD1NA5kCV2YnTehzeCxfDPPSR8s/JFWcfBX2iW?=
 =?us-ascii?Q?2J/51fyDwKSvuxo//Y8e86FhtK4ICIMQVlrqPq8bp+ZDgbID2BQHfMlZh69Z?=
 =?us-ascii?Q?n4FerZrFRrx0nR0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 16:47:02.4141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67731caa-c88d-4235-a5f1-08dd2e71bede
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
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

VCN and VPE have different offset range, update the doorbell
offset range repsectively.
Doorbell size for VCN and VPE is 32bit.

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 769154223e2d..8c9a2f42116c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -222,6 +222,21 @@ amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 	}
 
 	db_size = sizeof(u64);
+	switch (db_info->queue_type) {
+		case AMDGPU_HW_IP_VCN_ENC:
+			db_size = sizeof(u32);
+			db_info->doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VCN0_1 << 1;
+		break;
+
+		case AMDGPU_HW_IP_VPE:
+			db_size = sizeof(u32);
+			db_info->doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VPE << 1;
+		break;
+
+		default:
+			/* FixMe : handle this after userqs are enabled for suported IPs */
+	}
+
 	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
 					     db_info->doorbell_offset, db_size);
 	DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", index);
-- 
2.34.1

