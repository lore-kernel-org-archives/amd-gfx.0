Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB7ECFC271
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 07:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E22C10E52B;
	Tue, 15 Oct 2024 07:43:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D46Y3W/T";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C8BE10E52B
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 07:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKyIw+EKLwD2B7OY0mBrNfmkVifcauSheQB9joQ5pB637bigwSnw4IEYS/iunJOKFWftofSEWELVF5lPawJlsW9J2sFv7S80/xNAguYs2UmtJkNnwyO+Bce3JARlwCjPlV1Zounlwu8ciUeTnJi2UWAhaUQmk7LFtEYHv4gaoEytgWguIdnV/2BjunsUccogAQpzPT/fq3tiJ+wzSvKhgXCklKfisKFfysf3asNbEUlczEwkkdksyCXjGEEHDRXfOMETrlS9etEWo+1QSYjZRlD4RwiwjcDw3b6D42+OCxfkViYwIy0nf8dtFzEAcPvy19q9SPGRohqzeL5/TNSkJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jF9F2d1NbXGGGpuFQhDJ3mCF/CxL2B8mZ1bgoU5QBQ=;
 b=n6A52ftQ2NPzVJB71Cxqp+3zddrtn/JNRF8SEkSWdoUiX98SUbe7mrlX8e1KE9O+yDywnXFABeDkkuT16m+Ck3/gwYmLRd98ixXlRZ5CCpILAIjiYQp0sEkfRhS17IUfhxab9t0CWWTQaJjwgboFy4lwxzb53+Lku8CjMOnnZ5cXt4EQyHBiXbYTQvlpxtz0vr7vvBXOZImZKFt7OuIOwKrR+5GNjGeWZhn3qEXXWr5ENENr9HUwllQpK+WmjXkiS3P3oKFAYROaaFlgaLcuM4UE93uQMj0wAgayXWHs9kLZsa2jGhh5DjqUD4pKMveS1BJAm+UL5Q8cunwWNK2XLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jF9F2d1NbXGGGpuFQhDJ3mCF/CxL2B8mZ1bgoU5QBQ=;
 b=D46Y3W/Tf+n72bGjc4RZS/K4OHpn4ImsEN3g9vX1mpoMHfw9xkD53uu8me4C98baMdjKiDyjbWYJ5kFq1v3oPYR4s0CpIBEryo19LI1jvvQqwwT/J/QG8Ft0QP/xIKIKRZlxsVnQEJ5vtV2FttldXXz4/BFdU23aoJbDsyz+SR0=
Received: from BN9PR03CA0670.namprd03.prod.outlook.com (2603:10b6:408:10e::15)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 07:43:48 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::b4) by BN9PR03CA0670.outlook.office365.com
 (2603:10b6:408:10e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 07:43:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 07:43:47 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 02:43:45 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>, =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=
 <marek.olsak@amd.com>
Subject: [PATCH v4 09/09] drm/amdgpu: Add separate array of read and write for
 BO handles
Date: Tue, 15 Oct 2024 13:13:09 +0530
Message-ID: <20241015074309.2484264-9-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 481b3bf7-9bff-4078-9b01-08dceced1ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVRTT29kMEgydDRIekpqM1VJYThNTG1qMklZQlJaNjVlUUYwTWxKQkg0Zmhv?=
 =?utf-8?B?a3JmdTZvblJYakl2TEpoeXhuVjh6RXRIVGF1Q2tGVmEvT3Q2VmNJZnRhcnJ0?=
 =?utf-8?B?ckhQYWpIeVJ4N0w1bGtmMGNKM25vbDR1bXhjRXErVjg0UE5IMHNDNG5UdGdT?=
 =?utf-8?B?S1ZncEZDbEtiQ1RIb21xRTYxRmlKaGRlZU9USVJjTFh2N1ZsdU5aTksxOFBy?=
 =?utf-8?B?MmlRTExGY1RVWWFsN3BNbE5LMXNDWEYvODdaS3dBUVBZcG9nQkVVT1B6NE14?=
 =?utf-8?B?djBVblNrYkN1bkVTbjVHTVQzYmpWK3NIcGk3ZHB2Ri8rK09Mc2RhZm5aSVMv?=
 =?utf-8?B?bGRnSzRCL0RESktFVUtwcXNEYjh5REtya2NxbVRXQ3dpRGlCMU5MSk9JMGxL?=
 =?utf-8?B?b2ZhOFdTU3ZjZFlsRXNiQkdpVjU3UkhDK2J6NnFwOVdybEhkaVZsK001MGtt?=
 =?utf-8?B?ZlkrazdFWGhERDR4ako3NVUxUEkrT3ZIQ25qK2NIQ2xVYURpYkR5YTVLLzNp?=
 =?utf-8?B?Y1hLSEdybzgyV1A0YWhtYkVpRzJ3Z0FjRERtcEd2bm5GN3JzcHU4YjNVTk1z?=
 =?utf-8?B?b1BoY21LUlFRYWg4SnhWYTVDdm5HVnVSSFFranA1MzhzQVVQSHNIdFNEU2JZ?=
 =?utf-8?B?eW4rQVIxUDl0bUtRZDhXMW9YUXdPVlZyaHhIOG1oNFJIU2hjb05aUjU5SG1H?=
 =?utf-8?B?Mnd5YmRITmIvQUF3aXNqbmhLbTZkN0xrQzdhcGNZMnhvYTBCVlpwZEtqL3Rx?=
 =?utf-8?B?bE1KS3NhVGduZVVrSXRNbk5oNCtXYzFEVjU4V1c5RkJ5WWxUTmp6OGJMUGFV?=
 =?utf-8?B?TzA1S1dGaVJFMjdHanJBZ241U2JSekxKSGtlaGNJTjlobTBBUXBaTTNHNlNX?=
 =?utf-8?B?WGpDd2F3ek5KSWV1M1kycDM3WGJvVUFnSHV0ZnhaYVdlblNvejB0blhVdmhN?=
 =?utf-8?B?aFVPUHN4cWx0Q0hQWEVEWk5KdzI3QkFjK2EwR09NMndyNHgxcjNtZHE0TDZ4?=
 =?utf-8?B?Z2d0SXFsczRQL3N3aURyUWlVZi9TWkVTaXNSL2J3bXdVNXF4NGNCYWx2WXU5?=
 =?utf-8?B?K3owM3U3VmRJbmNuSEYwbHJrNDgzaDZ2b3ZWNXgyYVo2b2wrT3Q2b1N3cEZv?=
 =?utf-8?B?Q3VtSXVTVlJ3UkVyUk8vOUR5ak4yYy9UVU8reEp0OTZQdTBiZUNqUm4xYThF?=
 =?utf-8?B?Sm5GRGg5MUpGL1NNTE9xaGNrR2ZuUDNleSt1NUUrYmJPaUJJeWJZdDFvY1VO?=
 =?utf-8?B?ZzR4cTdOSjFoZEgreEM4aDZlMkR2U29pdW9wK05RejlDMHVTT1BrQzVPU29l?=
 =?utf-8?B?bzROWDVMcDNESlVlcUNmT1ZtNXBaMDZCUFVPVWd6VzBreUtCeE16QkxPdXp6?=
 =?utf-8?B?bjRjUHpnS0J4V0pHbHN0VXljdmZ2M3hhZmJmSVNGVU5hSHJWd2ZvM2pYdVl4?=
 =?utf-8?B?SC85dDZzb0tyczdORmtxMlM3OFVET1V4MEpLL0VwV3I0TXZsR2I3czh1NGJV?=
 =?utf-8?B?U1hxeDM1NlpaRmxvdTBPbXFLa3F0eldYdlJ1NElTQnpxTTk0TFhRbm1rQmYv?=
 =?utf-8?B?SzBXVnVKVExVeWVDenkwTmNON1ZqMVI2bzdUS2FsNWVhQ3RXUUM5blpmV2N1?=
 =?utf-8?B?NEVaVmM0cEZZUFJ3STRzV1FiUlVpanlpdHpEUHh5bHpyNExCS055SmwwVDRm?=
 =?utf-8?B?aEw0UWU2eVEzVHN3RWIrRjRCcXFRYWltVGFkUmhHaHhwdU15U2RqbUIxUmpS?=
 =?utf-8?B?RlBJSktkbGhMYlMyVTV2RGVibk9WQWVQZS9ZNDEzdDFtUnYvY0dNb3ZxeWIr?=
 =?utf-8?B?YU91S0dPY1ovUjJwUGlrWEhCREZmelFFQ01wK1JHU0cwNDI1dEtkSHI3VkRw?=
 =?utf-8?Q?5D9UnZHn5AABr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 07:43:47.8570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 481b3bf7-9bff-4078-9b01-08dceced1ac2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234
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

Drop AMDGPU_USERQ_BO_WRITE as this should not be a global option
of the IOCTL, It should be option per buffer. Hence adding separate
array for read and write BO handles.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Suggested-by: Marek Olšák <marek.olsak@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 238 +++++++++++++-----
 include/uapi/drm/amdgpu_drm.h                 |  48 ++--
 2 files changed, 206 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 279dece6f6d7..96091a3e9372 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -386,12 +386,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
 	struct drm_amdgpu_userq_signal *args = data;
+	struct drm_gem_object **gobj_write = NULL;
+	struct drm_gem_object **gobj_read = NULL;
 	struct amdgpu_usermode_queue *queue;
-	struct drm_gem_object **gobj = NULL;
 	struct drm_syncobj **syncobj = NULL;
+	u32 *bo_handles_write, num_write_bo_handles;
 	u32 *syncobj_handles, num_syncobj_handles;
-	u32 *bo_handles, num_bo_handles;
-	int r, i, entry, boentry;
+	u32 *bo_handles_read, num_read_bo_handles;
+	int r, i, entry, rentry, wentry;
 	struct dma_fence *fence;
 	struct drm_exec exec;
 	u64 wptr;
@@ -417,32 +419,59 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	num_bo_handles = args->num_bo_handles;
-	bo_handles = memdup_user(u64_to_user_ptr(args->bo_handles_array),
-				 sizeof(u32) * num_bo_handles);
-	if (IS_ERR(bo_handles))
+	num_read_bo_handles = args->num_read_bo_handles;
+	bo_handles_read = memdup_user(u64_to_user_ptr(args->bo_handles_read_array),
+				      sizeof(u32) * num_read_bo_handles);
+	if (IS_ERR(bo_handles_read))
 		goto free_syncobj;
 
-	/* Array of pointers to the GEM objects */
-	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
-	if (!gobj) {
+	/* Array of pointers to the GEM read objects */
+	gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read), GFP_KERNEL);
+	if (!gobj_read) {
 		r = -ENOMEM;
-		goto free_bo_handles;
+		goto free_bo_handles_read;
 	}
 
-	for (boentry = 0; boentry < num_bo_handles; boentry++) {
-		gobj[boentry] = drm_gem_object_lookup(filp, bo_handles[boentry]);
-		if (!gobj[boentry]) {
+	for (rentry = 0; rentry < num_read_bo_handles; rentry++) {
+		gobj_read[rentry] = drm_gem_object_lookup(filp, bo_handles_read[rentry]);
+		if (!gobj_read[rentry]) {
 			r = -ENOENT;
-			goto put_gobj;
+			goto put_gobj_read;
 		}
 	}
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, num_bo_handles);
+	num_write_bo_handles = args->num_write_bo_handles;
+	bo_handles_write = memdup_user(u64_to_user_ptr(args->bo_handles_write_array),
+				       sizeof(u32) * num_write_bo_handles);
+	if (IS_ERR(bo_handles_write))
+		goto put_gobj_read;
+
+	/* Array of pointers to the GEM write objects */
+	gobj_write = kmalloc_array(num_write_bo_handles, sizeof(*gobj_write), GFP_KERNEL);
+	if (!gobj_write) {
+		r = -ENOMEM;
+		goto free_bo_handles_write;
+	}
+
+	for (wentry = 0; wentry < num_write_bo_handles; wentry++) {
+		gobj_write[wentry] = drm_gem_object_lookup(filp, bo_handles_write[wentry]);
+		if (!gobj_write[wentry]) {
+			r = -ENOENT;
+			goto put_gobj_write;
+		}
+	}
+
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+		      (num_read_bo_handles + num_write_bo_handles));
 
 	/* Lock all BOs with retry handling */
 	drm_exec_until_all_locked(&exec) {
-		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 1);
+		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (r)
+			goto exec_fini;
+
+		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
 		drm_exec_retry_on_contention(&exec);
 		if (r)
 			goto exec_fini;
@@ -468,13 +497,20 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	dma_fence_put(queue->last_fence);
 	queue->last_fence = dma_fence_get(fence);
 
-	for (i = 0; i < num_bo_handles; i++) {
-		if (!gobj || !gobj[i]->resv)
+	for (i = 0; i < num_read_bo_handles; i++) {
+		if (!gobj_read || !gobj_read[i]->resv)
 			continue;
 
-		dma_resv_add_fence(gobj[i]->resv, fence,
-				   dma_resv_usage_rw(args->bo_flags &
-				   AMDGPU_USERQ_BO_WRITE));
+		dma_resv_add_fence(gobj_read[i]->resv, fence,
+				   DMA_RESV_USAGE_READ);
+	}
+
+	for (i = 0; i < num_write_bo_handles; i++) {
+		if (!gobj_write || !gobj_write[i]->resv)
+			continue;
+
+		dma_resv_add_fence(gobj_read[i]->resv, fence,
+				   DMA_RESV_USAGE_WRITE);
 	}
 
 	/* Add the created fence to syncobj/BO's */
@@ -486,12 +522,18 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 
 exec_fini:
 	drm_exec_fini(&exec);
-put_gobj:
-	while (boentry-- > 0)
-		drm_gem_object_put(gobj[boentry]);
-	kfree(gobj);
-free_bo_handles:
-	kfree(bo_handles);
+put_gobj_write:
+	while (wentry-- > 0)
+		drm_gem_object_put(gobj_write[wentry]);
+	kfree(gobj_write);
+free_bo_handles_write:
+	kfree(bo_handles_write);
+put_gobj_read:
+	while (rentry-- > 0)
+		drm_gem_object_put(gobj_read[rentry]);
+	kfree(gobj_read);
+free_bo_handles_read:
+	kfree(bo_handles_read);
 free_syncobj:
 	while (entry-- > 0)
 		if (syncobj[entry])
@@ -506,28 +548,35 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp)
 {
-	u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles;
-	u32 num_syncobj, num_bo_handles, num_points;
+	u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles_read, *bo_handles_write;
+	u32 num_syncobj, num_read_bo_handles, num_write_bo_handles, num_points;
 	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
 	struct drm_amdgpu_userq_wait *wait_info = data;
+	struct drm_gem_object **gobj_write;
+	struct drm_gem_object **gobj_read;
 	struct dma_fence **fences = NULL;
-	struct drm_gem_object **gobj;
+	int r, i, rentry, wentry, cnt;
 	struct drm_exec exec;
-	int r, i, entry, cnt;
 	u64 num_fences = 0;
 
-	num_bo_handles = wait_info->num_bo_handles;
-	bo_handles = memdup_user(u64_to_user_ptr(wait_info->bo_handles_array),
-				 sizeof(u32) * num_bo_handles);
-	if (IS_ERR(bo_handles))
-		return PTR_ERR(bo_handles);
+	num_read_bo_handles = wait_info->num_read_bo_handles;
+	bo_handles_read = memdup_user(u64_to_user_ptr(wait_info->bo_handles_read_array),
+				      sizeof(u32) * num_read_bo_handles);
+	if (IS_ERR(bo_handles_read))
+		return PTR_ERR(bo_handles_read);
+
+	num_write_bo_handles = wait_info->num_write_bo_handles;
+	bo_handles_write = memdup_user(u64_to_user_ptr(wait_info->bo_handles_write_array),
+				       sizeof(u32) * num_write_bo_handles);
+	if (IS_ERR(bo_handles_write))
+		goto free_bo_handles_read;
 
 	num_syncobj = wait_info->num_syncobj_handles;
 	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles_array),
 				      sizeof(u32) * num_syncobj);
 	if (IS_ERR(syncobj_handles)) {
 		r = PTR_ERR(syncobj_handles);
-		goto free_bo_handles;
+		goto free_bo_handles_write;
 	}
 
 	num_points = wait_info->num_points;
@@ -545,29 +594,51 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		goto free_timeline_handles;
 	}
 
-	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
-	if (!gobj) {
+	gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read), GFP_KERNEL);
+	if (!gobj_read) {
 		r = -ENOMEM;
 		goto free_timeline_points;
 	}
 
-	for (entry = 0; entry < num_bo_handles; entry++) {
-		gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
-		if (!gobj[entry]) {
+	for (rentry = 0; rentry < num_read_bo_handles; rentry++) {
+		gobj_read[rentry] = drm_gem_object_lookup(filp, bo_handles_read[rentry]);
+		if (!gobj_read[rentry]) {
+			r = -ENOENT;
+			goto put_gobj_read;
+		}
+	}
+
+	gobj_write = kmalloc_array(num_write_bo_handles, sizeof(*gobj_write), GFP_KERNEL);
+	if (!gobj_write) {
+		r = -ENOMEM;
+		goto put_gobj_read;
+	}
+
+	for (wentry = 0; wentry < num_write_bo_handles; wentry++) {
+		gobj_write[wentry] = drm_gem_object_lookup(filp, bo_handles_write[wentry]);
+		if (!gobj_write[wentry]) {
 			r = -ENOENT;
-			goto put_gobj;
+			goto put_gobj_write;
 		}
 	}
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, num_bo_handles);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+		      (num_read_bo_handles + num_write_bo_handles));
 
 	/* Lock all BOs with retry handling */
 	drm_exec_until_all_locked(&exec) {
-		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 0);
+		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 0);
+		drm_exec_retry_on_contention(&exec);
+		if (r) {
+			drm_exec_fini(&exec);
+			goto put_gobj_write;
+		}
+
+		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 0);
 		drm_exec_retry_on_contention(&exec);
 		if (r) {
 			drm_exec_fini(&exec);
-			goto put_gobj;
+			goto put_gobj_write;
 		}
 	}
 
@@ -608,13 +679,21 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		}
 
 		/* Count GEM objects fence */
-		for (i = 0; i < num_bo_handles; i++) {
+		for (i = 0; i < num_read_bo_handles; i++) {
 			struct dma_resv_iter resv_cursor;
 			struct dma_fence *fence;
 
-			dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
-						dma_resv_usage_rw(wait_info->bo_wait_flags &
-						AMDGPU_USERQ_BO_WRITE), fence)
+			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
+						DMA_RESV_USAGE_READ, fence)
+				num_fences++;
+		}
+
+		for (i = 0; i < num_write_bo_handles; i++) {
+			struct dma_resv_iter resv_cursor;
+			struct dma_fence *fence;
+
+			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
+						DMA_RESV_USAGE_WRITE, fence)
 				num_fences++;
 		}
 
@@ -640,14 +719,30 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			goto free_fence_info;
 		}
 
-		/* Retrieve GEM objects fence */
-		for (i = 0; i < num_bo_handles; i++) {
+		/* Retrieve GEM read objects fence */
+		for (i = 0; i < num_read_bo_handles; i++) {
 			struct dma_resv_iter resv_cursor;
 			struct dma_fence *fence;
 
-			dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
-						dma_resv_usage_rw(wait_info->bo_wait_flags &
-						AMDGPU_USERQ_BO_WRITE), fence) {
+			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
+						DMA_RESV_USAGE_READ, fence) {
+				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
+					r = -EINVAL;
+					goto free_fences;
+				}
+
+				fences[num_fences++] = fence;
+				dma_fence_get(fence);
+			}
+		}
+
+		/* Retrieve GEM write objects fence */
+		for (i = 0; i < num_write_bo_handles; i++) {
+			struct dma_resv_iter resv_cursor;
+			struct dma_fence *fence;
+
+			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
+						DMA_RESV_USAGE_WRITE, fence) {
 				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
 					r = -EINVAL;
 					goto free_fences;
@@ -763,14 +858,19 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	}
 
 	drm_exec_fini(&exec);
-	for (i = 0; i < num_bo_handles; i++)
-		drm_gem_object_put(gobj[i]);
-	kfree(gobj);
+	for (i = 0; i < num_read_bo_handles; i++)
+		drm_gem_object_put(gobj_read[i]);
+	kfree(gobj_read);
+
+	for (i = 0; i < num_write_bo_handles; i++)
+		drm_gem_object_put(gobj_write[i]);
+	kfree(gobj_write);
 
 	kfree(timeline_points);
 	kfree(timeline_handles);
 	kfree(syncobj_handles);
-	kfree(bo_handles);
+	kfree(bo_handles_write);
+	kfree(bo_handles_read);
 
 	return 0;
 
@@ -782,18 +882,24 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	kfree(fence_info);
 exec_fini:
 	drm_exec_fini(&exec);
-put_gobj:
-	while (entry-- > 0)
-		drm_gem_object_put(gobj[entry]);
-	kfree(gobj);
+put_gobj_write:
+	while (wentry-- > 0)
+		drm_gem_object_put(gobj_write[wentry]);
+	kfree(gobj_write);
+put_gobj_read:
+	while (rentry-- > 0)
+		drm_gem_object_put(gobj_read[rentry]);
+	kfree(gobj_read);
 free_timeline_points:
 	kfree(timeline_points);
 free_timeline_handles:
 	kfree(timeline_handles);
 free_syncobj_handles:
 	kfree(syncobj_handles);
-free_bo_handles:
-	kfree(bo_handles);
+free_bo_handles_write:
+	kfree(bo_handles_write);
+free_bo_handles_read:
+	kfree(bo_handles_read);
 
 	return r;
 }
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index eeb345ddbf57..8d21e765094b 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -443,9 +443,6 @@ struct drm_amdgpu_userq_mqd_compute_gfx_v11 {
 	__u64   eop_va;
 };
 
-/* dma_resv usage flag */
-#define AMDGPU_USERQ_BO_WRITE	1
-
 /* userq signal/wait ioctl */
 struct drm_amdgpu_userq_signal {
 	/**
@@ -475,20 +472,32 @@ struct drm_amdgpu_userq_signal {
 	 */
 	__u64	syncobj_point;
 	/**
-	 * @bo_handles_array: An array of GEM BO handles used by the userq fence creation
-	 * IOCTL to install the created dma_fence object which can be utilized by
+	 * @bo_handles_read_array: An array of GEM read BO handles used by the userq fence
+	 * creation IOCTL to install the created dma_fence object which can be utilized by
+	 * userspace to synchronize the BO usage between user processes.
+	 */
+	__u64	bo_handles_read_array;
+	/**
+	 * @bo_handles_write_array: An array of GEM write BO handles used by the userq fence
+	 * creation IOCTL to install the created dma_fence object which can be utilized by
 	 * userspace to synchronize the BO usage between user processes.
 	 */
-	__u64	bo_handles_array;
+	__u64	bo_handles_write_array;
+	/**
+	 * @num_read_bo_handles: A count that represents the number of GEM read BO handles in
+	 * @bo_handles_read_array.
+	 */
+	__u32	num_read_bo_handles;
 	/**
-	 * @num_bo_handles: A count that represents the number of GEM BO handles in
-	 * @bo_handles_array.
+	 * @num_write_bo_handles: A count that represents the number of GEM write BO handles in
+	 * @bo_handles_write_array.
 	 */
-	__u32	num_bo_handles;
+	__u32	num_write_bo_handles;
 	/**
 	 * @bo_flags: flags to indicate BOs synchronize for READ or WRITE
 	 */
 	__u32	bo_flags;
+	__u32	pad;
 };
 
 struct drm_amdgpu_userq_fence_info {
@@ -542,20 +551,31 @@ struct drm_amdgpu_userq_wait {
 	 */
 	__u64	syncobj_timeline_points;
 	/**
-	 * @bo_handles_array: An array of GEM BO handles defined to fetch the fence
+	 * @bo_handles_read_array: An array of GEM read BO handles defined to fetch the fence
 	 * wait information of every BO handles in the array.
 	 */
-	__u64	bo_handles_array;
+	__u64	bo_handles_read_array;
+	/**
+	 * @bo_handles_write_array: An array of GEM write BO handles defined to fetch the fence
+	 * wait information of every BO handles in the array.
+	 */
+	__u64	bo_handles_write_array;
 	/**
 	 * @num_syncobj_handles: A count that represents the number of syncobj handles in
 	 * @syncobj_handles_array.
 	 */
 	__u32	num_syncobj_handles;
 	/**
-	 * @num_bo_handles: A count that represents the number of GEM BO handles in
-	 * @bo_handles_array.
+	 * @num_read_bo_handles: A count that represents the number of GEM BO handles in
+	 * @bo_handles_read_array.
+	 */
+	__u32	num_read_bo_handles;
+	/**
+	 * @num_write_bo_handles: A count that represents the number of GEM BO handles in
+	 * @bo_handles_write_array.
 	 */
-	__u32	num_bo_handles;
+	__u32	num_write_bo_handles;
+	__u32	pad;
 	/**
 	 * @userq_fence_info: An array of fence information (va and value) pair of each
 	 * objects stored in @syncobj_handles_array and @bo_handles_array.
-- 
2.34.1

