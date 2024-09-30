Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE95CF64A1
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 12:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B86B610E408;
	Mon, 30 Sep 2024 12:00:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UGW4UdUH";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F65910E3FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 12:00:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVKX6j6Og+q3/pfyh8A13YsajppZfrCJOv73YZ7plPxTDqNeWvyzy2U7zhVGgwqR+g5gx6lTxcKawJImG91MMeKSLr88ZA+KNf2jsfchmIweuIOAVw80T9pzGkjSIyZKjZMnAROCEaCxLAvRlVmpnxIXHO9UQGnB6SpnGK31FMzGTX4b5tVajzA6h+cN9/MSmHbKXD+bs1AIdRqTPB64SemphUYay4Yi3WQUSZ/NaG80xzZdyHFyw2FVzu5F3+vBTKercCkilZ6ZeYkYkvpQJlk8V4BXlPpYLG6lkDk5twjJPeFg7xM8VOBHWXCKjvhFq3kmi7bWXfijT7U3iKuY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jV08yZTl9oF63e5A/s8LWhyuJjaYr5spoPPiNhrJMjA=;
 b=uG/JxA4XQ6xp3TJDy5S2V9LGMK1DPcBZCu298WerrY76YPbw6whjvN/oql7uQNHAmG6HPpqvKCJBo//ZmMd+/CzIkQTNWRkxeC2QjnXUXsAVcmLgHcacxwAMqDMFaPYPiXnwhPqWhLYq6AlYtC/x8bf7zGCvlabtVNZdT0io42QmHFMyG91drpco4JkPlpCXkJD06HKQumd7gcRNg2q1gmN+E3sjsbLnb0+/IIS8WvLkx0wlcFJ6VuwxYFOTA9hzBvuSszBuO17uN9Xe3g1fGrrjU2uHIhhk57fY+zlcAzRuh19ThuKq/zG5Lst6HxIwnvZePJpHfmJRLn1KXdkWXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jV08yZTl9oF63e5A/s8LWhyuJjaYr5spoPPiNhrJMjA=;
 b=UGW4UdUH6LByTfYnDaBCWPn+tDPmZRQQBHnGaT4Nw/trtewnT8hQITeLtMRUhEHpSuL1q/OcEVgV/cKy8NeB115GlIOMgwln4aq8Hb0c0oRI4f1ERO/4G7xr9yKQvhnYho5lzXA6TeFRCXJnjZ7A0x9V+g5hLWOAdBDyKlJBTME=
Received: from SN1PR12CA0069.namprd12.prod.outlook.com (2603:10b6:802:20::40)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 12:00:30 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:802:20:cafe::cc) by SN1PR12CA0069.outlook.office365.com
 (2603:10b6:802:20::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Mon, 30 Sep 2024 12:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 12:00:30 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 07:00:28 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v3 08/09] drm/amdgpu: add vm root BO lock before accessing the
 vm
Date: Mon, 30 Sep 2024 17:29:05 +0530
Message-ID: <20240930115906.191060-8-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: 01794178-93e8-476d-0ec5-08dce1477b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AIu1hADhFkQrWGsmZcaOFs0EKMSDV3cDsoHs3z5uNTTahr33q+5gVRjq4+Qi?=
 =?us-ascii?Q?jJ2jwlEJUaDTCICCBU+uvlcQC+fXFROjmG2iZUdjRP5cCC3VoOV03fF4vSpJ?=
 =?us-ascii?Q?z+VpSag+R2AYNlU4+fzijB51g+ewgyp2c8ztU2fPADyGy1AHsy+h3jI3ocDL?=
 =?us-ascii?Q?VgCQoSiKvOOtb5myXBsrfcvyi8wl5A4c0A0y5AnSDE1tbAgrvZJxFL1mFR8H?=
 =?us-ascii?Q?GEeug0w9QxcpeG4e8DW01fgCYz+z+3IKB+xbRzcc1Thojz0uX1+qnPHyt+Pc?=
 =?us-ascii?Q?nqpMWMb5xXHRIAL9lInfjoCacGBIt75OOiP7lXL+0vb8ngjQJZ7Ob7jiKEet?=
 =?us-ascii?Q?3iXLJiJfTGcRS1WSfflrItgipkG4UnVGvmyYBxnNExq2t62AfRcd7xRIujYg?=
 =?us-ascii?Q?dWz9p1D7T4fEzTi9gIlSVHvXyO3cX/UdNuy5er5YSxGxtQSHjy068HQgwuYR?=
 =?us-ascii?Q?1Wz1d6Soqfl0SadF5X587/5DBbp14MG8UGaEmYPd6EblGcrgP0PQD+8yJnw1?=
 =?us-ascii?Q?a+scxNhE0W+7QpYVTWXM6DKCLMCZ9rXqzHw92GDQRX6R1ugXSnH0N502BlLl?=
 =?us-ascii?Q?OZHZeWVsjl6a0LdPIwzbGHd9M1/NUmYf3b9IMbeJ4MXAsQCL3WUN1iGG26RY?=
 =?us-ascii?Q?WVSUdWD7dIoXa7GQoZiw8Kpcz80kNbBFdHuyg0joS0yWX8y3Az4naxVdOKYU?=
 =?us-ascii?Q?/NGpzeUVP2omRk0SUWeU/pWNruXBEVRWGNMSqOcaUJs2qI7QLfdYLZ+A4NjD?=
 =?us-ascii?Q?TNk/dn7UCvCyFtF4XAI6evg5dCTh+tPRBZv0AmRx1XLhomNisXggqiAcQXon?=
 =?us-ascii?Q?+HZdZhMmNOtshDhAIx7anCrOclosL3EGMi/v9vXxRCtHNZRXVR6G2Ky/0+gK?=
 =?us-ascii?Q?P1SflrP8/G0x8cQNtCqW/sH2ZRW4O0jiRlwekIFab3R/hf8wIEB+L2/kx6uH?=
 =?us-ascii?Q?eKo6ELVkLOC06JiqIKDMbz7jU8lqmtIwrp9eLul3gXp4kvgc/z96rpyrsfME?=
 =?us-ascii?Q?oJ/nxFi3QcygAAgCAdDrssKq9J6JiskGyoBKBIOcmSelIsxgnO1VQu9KcxHV?=
 =?us-ascii?Q?2PlhX6Nqmi8gErfu72ev6ETVmA20nICiciYKaCdDXEzMx9i4Ip35uGVmOteP?=
 =?us-ascii?Q?YvDFUEyyMGG6RwDSA0l9Uyqt7CCg/ebBCrCPBsns/91cOWplU8jeTxdKw7Vd?=
 =?us-ascii?Q?BzbhmVeaF8PbuUgrQ5woM749RFW9eczWkBtZxsVhFKjavCx/o2EBbLhVko3v?=
 =?us-ascii?Q?9uiGS3RnxexJKJu2iP+xK5mxLvvls+sbZr46Ixq5yhIUDOksHVzAj/NH+NDL?=
 =?us-ascii?Q?p/5TRWqSFZnHOVOywdQ6jlY+9n1r1+1ojbJuJaYpVIsw7txY69P7w2vwhakG?=
 =?us-ascii?Q?PY7ivbFq/TYqdQHY3FQ9YUBMCmBTQULPtPPIq8s3MiB6r3VCmRVVjc/2J30f?=
 =?us-ascii?Q?lKp2HfMBIa4rQmcv4v0skaOZuoJr9LQI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:00:30.4242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01794178-93e8-476d-0ec5-08dce1477b2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
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

Add a vm root BO lock before accessing the userqueue VM.

v1:(Christian)
   - Keep the VM locked until you are done with the mapping.
   - Grab a temporary BO reference, drop the VM lock and acquire the BO.
     When you are done with everything just drop the BO lock and
     then the temporary BO reference.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 9ca1910d7a62..0725f28f3484 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -321,7 +321,6 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
 /**
  * amdgpu_userq_fence_read_wptr - Read the userq wptr value
  *
- * @filp: drm file private data structure
  * @queue: user mode queue structure pointer
  * @wptr: write pointer value
  *
@@ -331,25 +330,29 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
  *
  * Returns wptr value on success, error on failure.
  */
-static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
-					struct amdgpu_usermode_queue *queue,
+static int amdgpu_userq_fence_read_wptr(struct amdgpu_usermode_queue *queue,
 					u64 *wptr)
 {
-	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_bo_va_mapping *mapping;
-	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo *bo;
 	u64 addr, *ptr;
 	int r;
 
+	r = amdgpu_bo_reserve(queue->vm->root.bo, false);
+	if (r)
+		return r;
+
 	addr = queue->userq_prop->wptr_gpu_addr;
 	addr &= AMDGPU_GMC_HOLE_MASK;
 
-	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr >> PAGE_SHIFT);
-	if (!mapping)
+	mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr >> PAGE_SHIFT);
+	if (!mapping) {
+		DRM_ERROR("Failed to lookup amdgpu_bo_va_mapping\n");
 		return -EINVAL;
+	}
 
-	bo = mapping->bo_va->base.bo;
+	bo = amdgpu_bo_ref(mapping->bo_va->base.bo);
+	amdgpu_bo_unreserve(queue->vm->root.bo);
 	r = amdgpu_bo_reserve(bo, true);
 	if (r) {
 		DRM_ERROR("Failed to reserve userqueue wptr bo");
@@ -366,11 +369,14 @@ static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
 
 	amdgpu_bo_kunmap(bo);
 	amdgpu_bo_unreserve(bo);
+	amdgpu_bo_unref(&bo);
 
 	return 0;
 
 map_error:
 	amdgpu_bo_unreserve(bo);
+	amdgpu_bo_unref(&bo);
+
 	return r;
 }
 
@@ -449,7 +455,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		goto exec_fini;
 	}
 
-	r = amdgpu_userq_fence_read_wptr(filp, queue, &wptr);
+	r = amdgpu_userq_fence_read_wptr(queue, &wptr);
 	if (r)
 		goto exec_fini;
 
-- 
2.34.1

