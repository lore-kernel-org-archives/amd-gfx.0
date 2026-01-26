Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0A1CF65D5
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 10:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C14310E3F7;
	Mon, 26 Jan 2026 10:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xm2x6K7p";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E76EA10E3F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 10:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTPwVF5LyB43k2Ik54LKxqy7/K0oDk90xo/sS6BQoAVv1oN2mwXldplNZE7Apf4bXl23b+Myf4abUetDabFAHNJaimaw3cQa4IO0r7EhXFMHYBg9lv4lyBSjGxgn7OzGyVaHfmaGosVcbxssPviwKF+jEoEqTL+WAiDrCsr7Ol2Uxlbg0Z0x5D9cK653kOL73NPxI/ADDvqhidoWNoxwJo8DAK/pAEzkPFMFiseakhsPb9X1bTHy1hJ+yL83TCjh65k5R91Gux6+LeVSgb7s/d14PDDKIFm9suN3AXZEQcxg1ZEzLEirO5RleFajnXcF1cZUYhRw5MVONiXYLIhPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOtojWSJ0WQaWi+6q/KCD4ZnEBe8myB6SmSgyMJ8AZs=;
 b=OXRbstak9C6BCw2G5LrJumfWl3Q2Y0Xr2SRGydOA8RXld1Qbi5+ARC4UTLmSR/6YDgFJHs4aVC/70hdlRL2HXQpD4Q8BiwxGLptb/XEKnCOVnVhjRsPQtf0NhsaZTHO0GNfO9jzpa8qIuDkeXT4gu5xJkjXKMwVqYoHAy/mUU+ikUjg9GqPtd6rPZ2rGoJz+CF3TLwEND/zRMUwvQFcn8iFHlZ2vBnH3p+NE36X63Zfd8/I4XwdFducAtN5Sy2AoLoj2NMXp0xvsZXC+LUVkNl9/ruLPsStuA9PrsniNtecB2K0WjiCtt3JlLZSkOs4sEjySwDno9VnrHOsT+RnYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOtojWSJ0WQaWi+6q/KCD4ZnEBe8myB6SmSgyMJ8AZs=;
 b=Xm2x6K7pQUlcYqlhg+eUV8+GZTjepfeLpMHDDMydRTsLVa4Hw2OtL0FqSeu80FfRcZ2ihSf3ZuatxlBvK1pt9qYQCuQCL6mSITxWd/7cPawPP5vY513G/g4uWRK255m0/uaZqFvOjBJPO/eLyw35sH1/nYVhtbdZTm6i5KmnNXs=
Received: from MN2PR08CA0023.namprd08.prod.outlook.com (2603:10b6:208:239::28)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:25:51 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:239:cafe::8e) by MN2PR08CA0023.outlook.office365.com
 (2603:10b6:208:239::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 10:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:25:51 +0000
Received: from lang-cezanne.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 04:25:49 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, "David
 Belanger" <david.belanger@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Use AMDGPU_MQD_SIZE_ALIGN in KGD
Date: Mon, 26 Jan 2026 18:25:12 +0800
Message-ID: <20260126102514.273891-2-lang.yu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126102514.273891-1-lang.yu@amd.com>
References: <20260126102514.273891-1-lang.yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f30eccb-2663-4292-f818-08de5cc547b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5XpqPjZahchYAikhdOhHeZ8Xjy80iVRaFrsBYCRhGj3WwwXbbvO6WSQc3h+O?=
 =?us-ascii?Q?+2DTGLq7krdmEJc4vfbToS1WFMuly9X8+FgLB/pTC4LciQfmrJcELBiJS3L1?=
 =?us-ascii?Q?leQ3uISyPRdeTJt1AZbkYhooJe6IiCiMZNGODszVh2cIFaswXjo42ii5BVzT?=
 =?us-ascii?Q?y4D8UrV339b6lKJj3cNYlBBZmTjTafdda1jyWbX1mxqiWz9oKNjAqI/ZnLb+?=
 =?us-ascii?Q?XLEAfcMB5EvwwthuNuhbyHC3xl1B3zSWPous/qTc5SuZB3iq7aZgbOepi2bv?=
 =?us-ascii?Q?TFr/Ws5/MM6BQ68UsYxQswSXBgnD+BlI07cDp2w3DYuDOA8HPC4Htx3/+Bxb?=
 =?us-ascii?Q?FX44nLm7RJ05BLIKyiW7SCMleNC7JssIZUYCg5IWDzdBAqr3aihNtvK8OSIF?=
 =?us-ascii?Q?cTZQqOAYFPa7kbER0g51cSkqbrzV9wpLJMl4U+Y3mYXKcBQdn1kX4oTA9pb/?=
 =?us-ascii?Q?TaxHQOfTGU9JIcCSVJSwiTDo3WZh3r+MHKvDcxOEgQKJICulgSpDH3ErmEgw?=
 =?us-ascii?Q?xs4UvN/K+p02RZVqoFzW/Ccxz/3qq4bjyO2qLIuG/egDHDTkTJVFZfbVVZfy?=
 =?us-ascii?Q?IIAqL5WuN0f9Z79Di+Q2kYniO8PSG5KPiwa8tJTx7kve7SUTcLho7JD7w5Zi?=
 =?us-ascii?Q?07Di1chEqRKRUiS7L3ZAWvy4/UJvZrSVuhfBF0fjiDdb15ei1LsB2CcFadRj?=
 =?us-ascii?Q?zAGmw3HJrY/RIPbEhEdiO0p7zFlBCCc0rMCmljM03EqASJBq4ncaot2YM17o?=
 =?us-ascii?Q?j08gYquleggGh3fcfYMos9PwqHiH+EeCxtuuihMXXW/anFmw1+UurE5gC0C+?=
 =?us-ascii?Q?/mvPQooPxg1FjLYfkibXMdtLTvRNGb6L239h9q/8NkJeiC/0PsAPaO0EUjn6?=
 =?us-ascii?Q?PwCcCVsov1kIrRoZQpgUHMt8V12z6BJWLKM2QgJFhq61m6yYOxqrA6RHW/qs?=
 =?us-ascii?Q?dm2mHkrTD57E2wC134AAyc08bQO/lKgJ3xfqfWRq2GWtmNzio8EM9kXPKVF2?=
 =?us-ascii?Q?b9sX822Ek+sOhW9zFy+o65LYWHOgV3cj/LIOyRqWDdPVRYURZJEVibz8Y707?=
 =?us-ascii?Q?fQjGrEEhDxjA5vYYo8n2DoSGQ2wzlAqw0RxpzrUwR1Z7egz6qL/qAlkDpYUn?=
 =?us-ascii?Q?HdAWryU2CYX4gAIHeVyPKhIieKswofkrxqN5mcwm8WUecpK54DlwupSboD1x?=
 =?us-ascii?Q?OnPCVr5Xz7KHQ3xFejQT6oBR0FOiTEh2NWWmPtP0QQ4tIAnsqw3PVGe5ncUQ?=
 =?us-ascii?Q?69WXq3GZTPBzd7b8LhwtyhY82moJE+ZoVAqiF6HR8sAljES+kuzAj9dUip80?=
 =?us-ascii?Q?t/qJwa/hcpOPaj08gsxgq5GxFgqO2emXiRRsLQsp/J0KgisOS9i4bYUDdld0?=
 =?us-ascii?Q?bjFmI03vLsw5eOq4cbg1KRlGbMH1fti/R6+rEPWfNMNrP4z/DVSwUHU3tlP8?=
 =?us-ascii?Q?Z7f4qp0eHlU3V8XPYyoe4TkzRFBdkjqsEAhSWuybSTrXjQvkOlavZRXHoaB5?=
 =?us-ascii?Q?SsPgmIiC6NrH3xUeOax+KT5lIAlfH/+CZOZ4AXssl5ePOMAKMugQWy7MrZaU?=
 =?us-ascii?Q?BbxKp6Qkru2iVHAqAzApkWrW84yPbtwP8YKGg5kOHZv9GrjffFWlEbqESID0?=
 =?us-ascii?Q?frTWp334w7n+/pvueFHVnWoBfdi6a6Et14HCWJoZX6P5c6cRtY2gXPSrVpyC?=
 =?us-ascii?Q?BBMsAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:25:51.4376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f30eccb-2663-4292-f818-08de5cc547b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
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

Use AMDGPU_MQD_SIZE_ALIGN for both kernel and user queue.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 18 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  3 ++-
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 6abe5103a78d..4fede701beb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -385,6 +385,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *ring = &kiq->ring;
 	u32 domain = AMDGPU_GEM_DOMAIN_GTT;
+	u32 gfx_mqd_size = max(adev->mqds[AMDGPU_HW_IP_GFX].mqd_size, mqd_size);
+	u32 compute_mqd_size = max(adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size, mqd_size);
 
 #if !defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
 	/* Only enable on gfx10 and 11 for now to avoid changing behavior on older chips */
@@ -424,17 +426,17 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 			ring = &adev->gfx.gfx_ring[i];
 			if (!ring->mqd_obj) {
-				r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
-							    domain, &ring->mqd_obj,
+				r = amdgpu_bo_create_kernel(adev, AMDGPU_MQD_SIZE_ALIGN(gfx_mqd_size),
+								PAGE_SIZE, domain, &ring->mqd_obj,
 							    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 				if (r) {
 					dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
 					return r;
 				}
 
-				ring->mqd_size = mqd_size;
+				ring->mqd_size = gfx_mqd_size;
 				/* prepare MQD backup */
-				adev->gfx.me.mqd_backup[i] = kzalloc(mqd_size, GFP_KERNEL);
+				adev->gfx.me.mqd_backup[i] = kzalloc(gfx_mqd_size, GFP_KERNEL);
 				if (!adev->gfx.me.mqd_backup[i]) {
 					dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
 					return -ENOMEM;
@@ -448,17 +450,17 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		j = i + xcc_id * adev->gfx.num_compute_rings;
 		ring = &adev->gfx.compute_ring[j];
 		if (!ring->mqd_obj) {
-			r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
-						    domain, &ring->mqd_obj,
+			r = amdgpu_bo_create_kernel(adev, AMDGPU_MQD_SIZE_ALIGN(compute_mqd_size),
+							PAGE_SIZE, domain, &ring->mqd_obj,
 						    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 			if (r) {
 				dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
 				return r;
 			}
 
-			ring->mqd_size = mqd_size;
+			ring->mqd_size = compute_mqd_size;
 			/* prepare MQD backup */
-			adev->gfx.mec.mqd_backup[j] = kzalloc(mqd_size, GFP_KERNEL);
+			adev->gfx.mec.mqd_backup[j] = kzalloc(compute_mqd_size, GFP_KERNEL);
 			if (!adev->gfx.mec.mqd_backup[j]) {
 				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
 				return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 86cc90a66296..4dabcd7c9f5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2235,7 +2235,7 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_queue_priority = prop->hqd_queue_priority;
 
 	mqd->cp_mqd_stride_size = prop->mqd_stride_size ? prop->mqd_stride_size :
-		sizeof(struct v12_1_compute_mqd);
+		AMDGPU_MQD_SIZE_ALIGN(adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size);
 
 	mqd->cp_hqd_active = prop->hqd_active;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index f2309d72bbe6..0319c40c7f7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -289,7 +289,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		return -ENOMEM;
 	}
 
-	r = amdgpu_userq_create_object(uq_mgr, &queue->mqd, mqd_hw_default->mqd_size);
+	r = amdgpu_userq_create_object(uq_mgr, &queue->mqd,
+		AMDGPU_MQD_SIZE_ALIGN(mqd_hw_default->mqd_size));
 	if (r) {
 		DRM_ERROR("Failed to create MQD object for userqueue\n");
 		goto free_props;
-- 
2.34.1

