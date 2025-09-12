Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FC6CA101F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 05:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8022B10E441;
	Fri, 12 Sep 2025 05:55:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rCTDeRem";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF57A10E441
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 05:55:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uor+KMiwMc+OSiGrVq0VMuqYR9PNG3Myfd+WXV9rik4M/c+ztjUfmWhpL7Do0RDFbY7Y0R6a+yewxGMYTtTnAxcnNxsNCQs0cKTsM0Qv9JduRZ+ZuhHMQHjIlTVbfmAlRZlxCZTXdFS5n/SvYpqY4rwLQfbh8A0ObN4zUUxDQNLnnv5rTwT1I2y2q2VCHv191tm+igCIYWMvm9UFCtVNlzjcjwxLxHTRHNkpclKAt5htF/igxXhH+5+TwyNTeiIg6mgTB8SZcI0JaezONGXZFjVyN/H182gRvHObD3cs7VMjHvfaappceMDoNmDCFv6kwGSS3fupmSKp/EZV5Bfj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvfXng0bmf2BfxtxsHErRF4HYJAxwzQbwb/I9Sz0hVI=;
 b=lkdqV95lZ6KpzthwRBfc0plmSwYqp0zq692az9FoSsfgofr3RnQzZ53NGvE2ezawIjQmaOpHe4R6OTN7Y9cqWPHk0lnUfQygHERAqkF+4ICBoiMRj6F7CKDu8ZTuP40f3JGCbMky9ybuxpZRDJ09m6KoDvX6flls2BXitny6nFEjshFOUrqiNK2ftE/XH/meaZVPRmHyTKdKEv6qCG5q3pmlLbWcEMot5fNuxK8hw6ATX3ek2APscLo0IjRsKbdoQ3jKoXs+mHt8rdS0ahG7sGoMQXlRb1+ZwGhPOKaiVsv9278XijOd89T4QTq1u4K0emqA7nbL9fVFmaRHYT/lEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvfXng0bmf2BfxtxsHErRF4HYJAxwzQbwb/I9Sz0hVI=;
 b=rCTDeRem90RTlaFsnPuybjxlyxl3N0dguTDop8tqcQvRATiUN1KDJ+g6SgQ1B7x/KzESrTv3SXAUxr3UDBW5uG32oi2mDYxUAPyD4tm30zVIxiKDWlo6aJraJuXP9d0JWoelkd+WwCx68pQ/OZMWKXWZoXoC5C0UCJKgl3oti24=
Received: from BLAPR03CA0116.namprd03.prod.outlook.com (2603:10b6:208:32a::31)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 05:55:39 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:208:32a:cafe::da) by BLAPR03CA0116.outlook.office365.com
 (2603:10b6:208:32a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Fri,
 12 Sep 2025 05:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Fri, 12 Sep 2025 05:55:38 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 22:55:36 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 6/9] drm/amdgpu: track the userq bo va for its obj
 management
Date: Fri, 12 Sep 2025 13:55:15 +0800
Message-ID: <20250912055518.2719533-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912055518.2719533-1-Prike.Liang@amd.com>
References: <20250912055518.2719533-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: d3cceb48-1b37-4db8-37f9-08ddf1c0fffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?viOn2DNpoUiO7ZAZzuvPY56uB0kse2KVJFDPnhXB8kCbuJxEcaeRtgMA1t/S?=
 =?us-ascii?Q?9xBAepW7llNdal1Mv7F7EOc/EMmGZ/aFk8J47yHETbsbl7bSLntATI4G7H92?=
 =?us-ascii?Q?PWUsqM/ECxfrZT+Kcb85Oz+UNjdAvxdwBueMYbASAYrwk5I1C7r7j7Ipq9KN?=
 =?us-ascii?Q?lWLJ98SGUHDmNprMvzIpTDc2kForZCmAa0XbwcQf/hUiYNTHA4Ddf14y370W?=
 =?us-ascii?Q?LIQlV1LEfL2ercUQO7Cez6BJy0nII58gNPtOiz6S8cmVaXREOWrQtSwXQK3M?=
 =?us-ascii?Q?qYWJ/p1AqpDoGYI6+a5zPVl8Cl4OLCppY4vzj8CLUpxyEdYENDIT2k7Sp+E1?=
 =?us-ascii?Q?xtakMiQQ3c9bElPHMDmf21hCSDuLzYXXXdLLwB5NJd/I7lU4aouCDWbwJKUr?=
 =?us-ascii?Q?MvDNb2aJXtdvOJe6Un4+vXAwC0+uBmgX4aHZkh14isEX58H32xVUJOcZ6QRf?=
 =?us-ascii?Q?oHryPNAZz8RC4NNwH+d009DfeO8s9sXKCcqflEdhLs6Q16ryPYs69+1s1fA3?=
 =?us-ascii?Q?adaatGtQYraSeN1IEDIXnrXhW3SYpXNBFxs9BnqZPOZHzhe7ECYvAyMdqKu3?=
 =?us-ascii?Q?Gga4K/Lb7s3XAtBupq4330e0T34W5OQKJ1DjIEIGm+A8Bzgz78nUz4mecMjr?=
 =?us-ascii?Q?k1ylLgw6ymz+7juc2sm9NIcgbtol2ehvtZB9TMcE13+3phVN994O6Y/M4u/m?=
 =?us-ascii?Q?7ohGsPIzFkxLP+sze6U1Zn76SBNPDEYc+mRYpxrUS6jARI1Y5QTdhTM2Vq65?=
 =?us-ascii?Q?K+E35553ULKQnzjmrj0zcBhnXfDfJ6mF+0qM2FZNonOMoM1x+MU0Stw/tEsW?=
 =?us-ascii?Q?ousBSkhCnQGMCC+4+OMIpJ+lcDY27YZDfs8Fek+KiZKyLHMtqdlqXhVVxzHH?=
 =?us-ascii?Q?eWnTp6h9X0WvKahBBizZgQ7rEKKLQboYoYWpKMbdG26ytQbQ60Hh51YS/YND?=
 =?us-ascii?Q?Idc547ayfDzra84YrQ9B3p1U/dMbOz5xs7TFyOepn/TJvx0qWgvbpCPc8oHH?=
 =?us-ascii?Q?0nQ3KGgi+vcWVXkejTrGCHb9nB0JznFhrnj6r+LJSh8uvrAEOBH+EEyViiIK?=
 =?us-ascii?Q?yQclM9UDmJrLO3bufcCJ6A+f8O2fjLtukZOST5pKG47tIXQMUR+wJf2NJcw3?=
 =?us-ascii?Q?P7e2NsqVEOcQv8N0iIyC623jzH1SMH1bnKDBVXWdQXcsQ2bC5ZGtValZrJ4R?=
 =?us-ascii?Q?YVvY2hVOXo227ap0gxwT+BaqimhwJPfMHb93XxlqcbHjpMNl/mnS0z1YYnSv?=
 =?us-ascii?Q?cy9QfaBex9WjRyhbYV5/5bCmwqFReNQLyyvqfj/bKKr1GY6Y4uCpDG12MF5E?=
 =?us-ascii?Q?L0fWpYMPdKrisl/NkkMod/OBIRnMkYa33o0jeaTdSu+cVEkDbAlilYh8VP4K?=
 =?us-ascii?Q?wsdsyM0fJYmA1uQwXMONUdTCHdxeAY+8EGvV8Jt1/jAIJ5ECzli0O47IXV2V?=
 =?us-ascii?Q?M4w26KhaBwI/qwHIufTnJS1Ei1BNdI0hZF/dQJc3w7pHqD8GPTdYsaqvREHv?=
 =?us-ascii?Q?h8gl1hzIvGDRuS1zcdLDsZ6pAhQw1nv/NYnw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 05:55:38.6850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cceb48-1b37-4db8-37f9-08ddf1c0fffd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948
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

Track the userq obj for its life time, and reference and
dereference the buffer flag at its creating and destroying
period.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 19a400bd4be1..cdcab71248d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -138,6 +138,22 @@ int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm,
 	return -EINVAL;
 }
 
+int amdgpu_userq_buffer_vas_put(struct amdgpu_device *adev,
+			        struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
+	int r;
+
+	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
+		r += amdgpu_userq_buffer_va_put(queue->vm, va_cursor->gpu_addr);
+		dev_dbg(adev->dev, "put the userq:%p va:%llx r:%d\n",
+			queue, va_cursor->gpu_addr, r);
+		list_del(&va_cursor->list);
+		kfree(va_cursor);
+	}
+	return r;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -200,6 +216,8 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
+	/* Drop the userq reference. */
+	amdgpu_userq_buffer_vas_put(adev, queue);
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_userq_fence_driver_free(queue);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index e4c2d7cabd15..b71fff65a896 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -154,4 +154,6 @@ int amdgpu_userq_buffer_va_get(struct amdgpu_usermode_queue *queue,
 			       struct amdgpu_bo_va_mapping *va_map, u64 addr);
 bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr);
 int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
+int amdgpu_userq_buffer_vas_put(struct amdgpu_device *adev,
+				struct amdgpu_usermode_queue *queue);
 #endif
-- 
2.34.1

