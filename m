Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFA4C3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 04:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E1F10E080;
	Thu, 10 Apr 2025 04:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U7MBwtak";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB2B10E080
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 04:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3lpkDG2SVsGkxqeQO0ERbvNR6WiYFZOKkhPT3KJ/Ec/Dnc/J726fagBhEd9ewJdzXpIyTjJRk2To1YjYfvtLL9Shl656UxjPhqGpnRYynshs5jK8HLBVHgOyhMSAVYgwftQ1I5uHKIyRVOocR+hNd7Bow+P/WXR9taE6lsgZjUnDKLeM5vqSPq0BaKd6488F30zGD3dDmunT54RRTBFoX3YbncGyTu+7wwtPFYBR9mSIs74mXgCs5x6JKMbrNDYv6jMDg/Pxpsitn/RlKivkDRqDfHcvTACag54JAbHWb6lykQUayzikCDR3SCVUb+lzAOyhlbjTf+WQL1UrJjFyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfLQDUOpGpDBbdxmpNRxtHk1qQ+SqBc+fElIM+85uz4=;
 b=s/uXrXaYnoZe0drsgq8R3HKNpyVlNCXe8xDpvIcZqcXSa2oGDHYXL6xfdIc5ALaJU3UM/szqF6Ck0oAPVYHgllF3mjaeZAXVd01oW8x9Fm9i9iubOmeOf02ShHdHGHVTH4iH0jJKkxXSe3rTRq9W0w5naXxjYKnAwt25Yl69oYKzWh0gjLxj9KaeXFg6u3f9hIgS/pb5ZgOVXnZNsS0qhe58FfLs+BM3O/XiZ6vqv4vr6HCr8sw6Cw+gROVaq+tutjnYS9DnGDQo9xioDht5oHPnz0BQO/tOS/YjwweZfovbmhDTet6veqczRPp0yzVLknCqfPgH//fsfRPHQosipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfLQDUOpGpDBbdxmpNRxtHk1qQ+SqBc+fElIM+85uz4=;
 b=U7MBwtak7WPmDa50KasRH3jjAfDevh9/mcIwyX0h5rNGTp/1kZYYV0KW9QvD6kOBqC/xeC5BiqthbwaXF22DPTxxtNkN4xc1drUyv+t3Xcn4hRqhgE3D/RSBowqxd9wS/HnBGU9VGQBUD7kQMK733Uw0zpfsGMFOXWjK0xiZvO8=
Received: from SJ0PR13CA0138.namprd13.prod.outlook.com (2603:10b6:a03:2c6::23)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 04:40:24 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::c4) by SJ0PR13CA0138.outlook.office365.com
 (2603:10b6:a03:2c6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Thu,
 10 Apr 2025 04:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 04:40:23 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 23:40:21 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Jonathan Kim <jonathan.kim@amd.com>
CC: Shane Xiao <shane.xiao@amd.com>
Subject: [PATCH] drm/amdkfd: Add rec SDMA engines support with limited XGMI
Date: Thu, 10 Apr 2025 12:39:56 +0800
Message-ID: <20250410043956.559468-1-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: 427f57ad-eec1-4615-007c-08dd77e9ceeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9nHTsfbjP0q/uNXU2zUzHq51WOUMk4JI8T+GbJRHhAWV9nlJyhn+v5kV3ZVb?=
 =?us-ascii?Q?ARukU3z4L7MO2I1wl5UW1RkNvleNjfmanC2F/IDqrk1Z1UM9S4fFjM40ShxE?=
 =?us-ascii?Q?DMfNzfPzqCeiHz1wu3ogysw16jVOtMEEdGOTMrtHxj12y7hl8sZUkj9Hcb9a?=
 =?us-ascii?Q?6JHb7r8Y+ezq0okRANUIkBBJgTGdlUNeXE6QbPhnQt9oTnsQmXQfDgNfqwzE?=
 =?us-ascii?Q?8xlIDty6M4wY4sAN0aL2xc1tXLozAt7uD2LRkXDwDkKsFwIrIGonq2FpAQAp?=
 =?us-ascii?Q?prI6ZSKf7MUn1w+i4xpCT1puPgNn3x+HIIedbSiZu/PvezWKvXXkwN/2nlHN?=
 =?us-ascii?Q?RRikFCoGF48uHZnkLPcMgfNIQH4DIkO7n/R8YSjJOy//FCjEUjKmLC6c5H50?=
 =?us-ascii?Q?YULAPInIWnyd0ZNUUl2W4PSHO5cW6m29Sb0ditSe8q9eXOqlaGSLKXXecT8G?=
 =?us-ascii?Q?rSFa03llUU0aeAqHM/h3o0ruf/R9IKucbycf0aviVLo2QcNN2bfWGJwjd3eB?=
 =?us-ascii?Q?l/DIwm7Kbo/x9dmP+eQSeqI3CSuloHgtuL/d0qX8UQDLb5JYE3szbdOhsDlQ?=
 =?us-ascii?Q?AW7VaOJSCkHpDRasgi7mg2re2O0kDiVzj7gIvf6+k59nxwzPZXAt54ydoktf?=
 =?us-ascii?Q?CDP1DV5L54LRY12ZSmvUNo83fUfbMWw4C+YaImA9KHFXcy0qcMcEH6gen5M0?=
 =?us-ascii?Q?vFAozwMKKVxvB1dO2gMabC1i5JbqIi7UKx+0dw0t5FQXVxyv4AE82CN4YpV6?=
 =?us-ascii?Q?4FRCPdwise06LCDDVqPsdPQvynLqARGc/w8xprAe9gCeohuFludJWUjfGSg3?=
 =?us-ascii?Q?rE8GpHcC1mQSQLhVJZQwX+1BmYwBZjZLdasjfHYXL2hxRPX7dDJniIOZirTE?=
 =?us-ascii?Q?G0TM1DhqRBWrJPHxuBLfH3MgcB7KFSroImxqMmYdk5IDijPaJFFZ5nGGzUMw?=
 =?us-ascii?Q?lZCwHkrotK2WYn/6FZMu5d5XsQtO1Blqmyv++8CeFFUGjFeuxh0URj+JiJVR?=
 =?us-ascii?Q?FB+KNEsGOq8ZhHGKJ4+va40rU4Crj7QPITtVc/cRQQo6fYyyhxYzhw6pZdBk?=
 =?us-ascii?Q?m87R+ZNsSYSNE7N+GN7pcjEgqdDrUYqCX8jzMwCvP6e8bkyAmEcbuzBieOgx?=
 =?us-ascii?Q?ZYgRoYsOVzMCfJhhIYGL7bk3EY8HE3CGgkQQGlynMVSeuxHjiqAG2G/C1g+T?=
 =?us-ascii?Q?b7jc/zj1C0MKGYEg4srPzv9AvKR6aDBPOS1RQjWuF4hy6fwjapMLcmGr91Cg?=
 =?us-ascii?Q?z1ODt0qOdHjZL0iWGfxECe9YSHXTAB2Wl8AQ7Ugk/quv9oZb5A5pnrWBc3GN?=
 =?us-ascii?Q?gF8ECE4oZIRssVB6DonKkYGcmk7WEnWJJSnpMXDYnmKXDTs8ssPtp6VJsp0E?=
 =?us-ascii?Q?Y14MnMTWJbjLa+uUngShiVC4SWMiKozvJI9nsWIESvq0GrGtrotdkGJGFM7y?=
 =?us-ascii?Q?AHjFDIe7EJso5kXbVPpnhNQsC8NgiZRMsZCh02AkBC0O9FKegema0fBrI0hm?=
 =?us-ascii?Q?LllyJFGRq46VyQCOn7t/gTZnOVyWaEmw/y5j?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 04:40:23.7665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 427f57ad-eec1-4615-007c-08dd77e9ceeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
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

This patch adds recommended SDMA engines with limited XGMI SDMA engines.
It will help improve overall performance for device to device copies
with this optimization.

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 42 ++++++++++++++---------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 9bbee484d57c..3835b5d96355 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1267,33 +1267,43 @@ static void kfd_set_recommended_sdma_engines(struct kfd_topology_device *to_dev,
 {
 	struct kfd_node *gpu = outbound_link->gpu;
 	struct amdgpu_device *adev = gpu->adev;
-	int num_xgmi_nodes = adev->gmc.xgmi.num_physical_nodes;
+	unsigned int num_xgmi_nodes = adev->gmc.xgmi.num_physical_nodes;
+	unsigned int num_xgmi_sdma_engines = kfd_get_num_xgmi_sdma_engines(gpu);
+	unsigned int num_sdma_engines = kfd_get_num_sdma_engines(gpu);
+	unsigned int sdma_eng_id_mask = (1 << num_sdma_engines) - 1;
+	unsigned int xgmi_sdma_eng_id_mask =
+			((1 << num_xgmi_sdma_engines) - 1) << num_sdma_engines;
+
 	bool support_rec_eng = !amdgpu_sriov_vf(adev) && to_dev->gpu &&
 		adev->aid_mask && num_xgmi_nodes && gpu->kfd->num_nodes == 1 &&
-		kfd_get_num_xgmi_sdma_engines(gpu) >= 14 &&
-		(!(adev->flags & AMD_IS_APU) && num_xgmi_nodes == 8);
+		num_xgmi_sdma_engines >= 6 && (!(adev->flags & AMD_IS_APU) &&
+		num_xgmi_nodes == 8);
 
 	if (support_rec_eng) {
 		int src_socket_id = adev->gmc.xgmi.physical_node_id;
 		int dst_socket_id = to_dev->gpu->adev->gmc.xgmi.physical_node_id;
+		unsigned int reshift = num_xgmi_sdma_engines == 6 ? 1 : 0;
 
 		outbound_link->rec_sdma_eng_id_mask =
-			1 << rec_sdma_eng_map[src_socket_id][dst_socket_id];
+				1 << (rec_sdma_eng_map[src_socket_id][dst_socket_id] >> reshift);
 		inbound_link->rec_sdma_eng_id_mask =
-			1 << rec_sdma_eng_map[dst_socket_id][src_socket_id];
-	} else {
-		int num_sdma_eng = kfd_get_num_sdma_engines(gpu);
-		int i, eng_offset = 0;
+				1 << (rec_sdma_eng_map[dst_socket_id][src_socket_id] >> reshift);
 
-		if (outbound_link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
-		    kfd_get_num_xgmi_sdma_engines(gpu) && to_dev->gpu) {
-			eng_offset = num_sdma_eng;
-			num_sdma_eng = kfd_get_num_xgmi_sdma_engines(gpu);
+		/* If recommended engine is out of range, need to reset the mask */
+		if (outbound_link->rec_sdma_eng_id_mask & sdma_eng_id_mask) {
+			outbound_link->rec_sdma_eng_id_mask = xgmi_sdma_eng_id_mask;
 		}
-
-		for (i = 0; i < num_sdma_eng; i++) {
-			outbound_link->rec_sdma_eng_id_mask |= (1 << (i + eng_offset));
-			inbound_link->rec_sdma_eng_id_mask |= (1 << (i + eng_offset));
+		if (inbound_link->rec_sdma_eng_id_mask & sdma_eng_id_mask) {
+			inbound_link->rec_sdma_eng_id_mask = xgmi_sdma_eng_id_mask;
+		}
+	} else {
+		if (outbound_link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
+		    num_xgmi_sdma_engines && to_dev->gpu) {
+			outbound_link->rec_sdma_eng_id_mask = xgmi_sdma_eng_id_mask;
+			inbound_link->rec_sdma_eng_id_mask = xgmi_sdma_eng_id_mask;
+		} else {
+			outbound_link->rec_sdma_eng_id_mask = sdma_eng_id_mask;
+			inbound_link->rec_sdma_eng_id_mask = sdma_eng_id_mask;
 		}
 	}
 }
-- 
2.25.1

