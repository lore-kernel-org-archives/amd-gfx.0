Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90507CF58E0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 20:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 116A810E261;
	Wed, 19 Nov 2025 20:30:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MrT1G6Wg";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010027.outbound.protection.outlook.com
 [52.101.193.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF20910E0ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 20:30:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pg8Qbuy3vqSG8samCcdzTIksDQeoda7L/b/iPEM9+5zJI+++bkZpViz45jJUqrYN9dCRebJMIlS92Lc0XmxkxRVd8I3m7ROxggZBUaAofD6k0sAt2r7broo0ZObkSg4rZOHEcFRuuiJcwOwp2MnCcF2M5ms9j95paF/yDqTErDBqhHUFYjSPfqvSnmeVb+g3cGDoed9XoHioWYDZiQRPPozx5McuGmT/1HGcXXJQwJ4yFPW5mcFzYkSxGY9Z1h4+BSgokveEywlOiV5e6rKgwl4nQOzt5BXrJwrW8uY8jdPIMrYcqosS3E1cSdrasKcuHpaXEjgPLe1MuCpWn/SZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJ9buTumH/Te6+T//OTzv0mlers0vfAFIeNZgUP7Mcw=;
 b=c4HAiL926iDpuAZYgav2PaNT46GQ428ZRIJbpz5QDUjaNQppI7EIoZDXWSYstIccXi6FHHtjZOiu+OQqfxZOJ0fcr2BJszRwboTu2BPgC7XbbOqkdkDHFgGMAHLstIO/kIWz0qMvkBnUvN8SeYQYEls2tOXDlW3ykM58+cWULDzd3kxMSHCUrPi5m7KRvAjqIR4iGMJgA30+CqmPvAF31R0tybJpoxuGv5ZT7yUwGWfWvo1eRIRmzYta+i8grOHewH3ObNI4um4vxfqC/w6BqBLdDeLC1itCb7qtr+9uM2cSdQbNGQz9pmcYDTdmr9oraq5p9tFOqv0Gi2ZaY7U5IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJ9buTumH/Te6+T//OTzv0mlers0vfAFIeNZgUP7Mcw=;
 b=MrT1G6WgoFM/gzS1TfIz9aSnulsu5E6wvxCHmFwIjztwTqUVqYwzqgnrxotxQ4DFSKdVU0A4ukEQn8aauby3bZFRzV1EF9ZfoTWK+ZCh983YwunS8//cwpPZyhiRLMt4mdsuJ0aYJ2f3HkXYAInIssENiIDH3dXASCRqOvvCfdQ=
Received: from CY5PR15CA0101.namprd15.prod.outlook.com (2603:10b6:930:7::22)
 by CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 20:30:25 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::9c) by CY5PR15CA0101.outlook.office365.com
 (2603:10b6:930:7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 20:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 20:30:25 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 12:30:24 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: always backup and reemit fences
Date: Wed, 19 Nov 2025 15:30:04 -0500
Message-ID: <20251119203004.22742-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119203004.22742-1-alexander.deucher@amd.com>
References: <20251119203004.22742-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|CYXPR12MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: 58948f7c-f2da-4abd-e54c-08de27aa78cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iJb0/j/xYVkjGa4d3ciwrwbK7u2vY4iU0W32FtS5l/OSY2vUpXe2mF/7Z3Hg?=
 =?us-ascii?Q?zXVZdPV9Zvsj64OBx/6cXkV1taV8lKh8QVsmXbdyMQuSE3LhetW0Vo1VF+CW?=
 =?us-ascii?Q?xK+hD1Rpa9J95o8W1RzmMZqXV60olnJJEyx7NZaJKCsVBRxcbxtKetM+tdH7?=
 =?us-ascii?Q?Ow/kRFRK/khelcXshzvpTKYhscKwUeUr38tDq4ggdA2+8GTm6R0xsKnLm2om?=
 =?us-ascii?Q?g1FFhfYCCBiT8SeKZ/qpCpsBePx/5ASEgTcqsx6L1YgHEpbbNpv9K8CXIViC?=
 =?us-ascii?Q?HmLVIDXkCd1dYr9wqx9hVT/ppPm2O9JKGDW2xqJRjW+5UCjmk0RLCLAAV4cM?=
 =?us-ascii?Q?2E1PUfD4pIvNGTgZA/DD8KW3n4nZIoCYN1yiTmDzZUQzL5TGV7m/wcly1DQU?=
 =?us-ascii?Q?NmcgMD0YEQuu3fqlAdj9YqFz0hBDn9CIO3uW7MxHKh5l4qbPWiMvu4YdJXFG?=
 =?us-ascii?Q?6CWRTIpSnnUzEz3sJ2w05JNQ/eYS9WPH7bDc6Z7VavoAzrydnmIDB7SbFf0i?=
 =?us-ascii?Q?O+riKKWoLnGNquBGFmt7YhpkJ7aU0QA/knZSIbhp6fyKcgPWqOzmuV7ySW1Y?=
 =?us-ascii?Q?nCtZKizHGwoEQ0nKXHcDLVYTbGx/SvdTFKHnxTolEhGA4xhXMvlQnGiK2xNz?=
 =?us-ascii?Q?oxk9elI8EYZEyL+yuADeoVb6S4QB/JASxoippR1FZc/1vbTJKIm+qzAS+UO/?=
 =?us-ascii?Q?nr+9558kkmjSA/4M1xkx3deMzPoyoxjJa4aAnlK6Oez5tsKf7cIVUd6aRflv?=
 =?us-ascii?Q?cg2qXWZvw1c/2ypOkvXSBNlF7/QNUrbVLRWEGKKpUjZBnZqkZ74JJXvs1Rme?=
 =?us-ascii?Q?TyDhetR44xTKDVtRaEAR6BuCEmrIDY8yFW7afW4CVrJe9LFGCSP0IfYWJEi5?=
 =?us-ascii?Q?eDgtYaSE+RJz3IlC8/Ym62OBbu/gkDMBdFL8dQGKspZfHbW5cFB0k3HjwjIJ?=
 =?us-ascii?Q?qARu7nIliSFGjJJzQHxsgC6EsveZEf7x2VVjBUHUZ6MxFsUnVeAnbbz8t0sz?=
 =?us-ascii?Q?tKBBtkFstnxR3QFmDLD15FsvT2w1ztu6HXAJjCzRiukYJZTQgzMs4ji0VAPE?=
 =?us-ascii?Q?wNvqwKFvP0gSWd6dbuPebm48NAcm9vtNATGnZ6k6lGU6p9gMYR/HJJ7Y//Ad?=
 =?us-ascii?Q?zeMFmpI7wpvFuzRRHKAm3F3LUoMYh3SWWcZQ0pyWoBx+R/KvY69mwj2aIfiL?=
 =?us-ascii?Q?1C0a9B7V+P7zq3anLa1T51NYHBsHGbiuSUaANvavWWTBAcDeaBASrDBXxsS/?=
 =?us-ascii?Q?aX0IZpjbDZKb/RHb8Dc72CrpvgcgZ7dgRe/qbR5NW3QD+5OAA69nFF2ME3gU?=
 =?us-ascii?Q?fp5jcHWri5i6MG6Wf/t+KYR49hL1bUtWOa+tONNvGquZMGDng6Dg1NnJLgh7?=
 =?us-ascii?Q?26avCBoC/viaTP+3jR+eq0NJhjJoRFRzMPSRlCqUcmOrJ4znJs8aFpUL9PNn?=
 =?us-ascii?Q?X23oiexVDA+/Q8mssvd75yIfGS7YA5G0wa7rjYRlwpXvZeWfxjesB72rPrHP?=
 =?us-ascii?Q?MJ1WDuqJL8HhphcpOmVePGmE/RiuCvvVABa3jVDVERVh/kLe+vylu0MZsn5A?=
 =?us-ascii?Q?U0FsIoQwbvQ0GSUZINM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 20:30:25.7136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58948f7c-f2da-4abd-e54c-08de27aa78cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318
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

If when we backup the ring contents for reemit before a
ring reset, we skip jobs associated with the bad
context, however, we need to make sure the fences
are reemited as unprocessed submissions may depend on
them.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 29 +++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  8 ++++++-
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 334ddd6e48c06..9dfae9532c70e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -116,8 +116,10 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
 		       &ring->fence_drv.lock,
 		       adev->fence_context + ring->idx, seq);
 
+	amdgpu_fence_save_fence_wptr_start(af);
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
+	amdgpu_fence_save_fence_wptr_end(af);
 	amdgpu_fence_save_wptr(af);
 	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
 	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
@@ -743,10 +745,6 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 		/* if we've already reemitted once then just cancel everything */
 		amdgpu_fence_driver_force_completion(af->ring);
 		af->ring->ring_backup_entries_to_copy = 0;
-	} else {
-		/* signal the guilty fence */
-		amdgpu_fence_write(ring, (u32)af->base.seqno);
-		amdgpu_fence_process(ring);
 	}
 }
 
@@ -755,6 +753,18 @@ void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
 	af->wptr = af->ring->wptr;
 }
 
+void amdgpu_fence_save_fence_wptr_start(struct amdgpu_fence *af)
+{
+	af->fence_wptr_start[af->fence_count] = af->ring->wptr;
+}
+
+void amdgpu_fence_save_fence_wptr_end(struct amdgpu_fence *af)
+{
+	af->fence_wptr_end[af->fence_count] = af->ring->wptr;
+	if (af->fence_count < 2)
+		af->fence_count++;
+}
+
 static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
 						   u64 start_wptr, u32 end_wptr)
 {
@@ -775,6 +785,7 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 	struct amdgpu_fence *fence;
 	u64 wptr;
 	u32 seq, last_seq;
+	int i;
 
 	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
@@ -796,9 +807,17 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 			 * just save the content from other contexts.
 			 */
 			if (!fence->reemitted &&
-			    (!guilty_fence || (fence->context != guilty_fence->context)))
+			    (!guilty_fence || (fence->context != guilty_fence->context))) {
 				amdgpu_ring_backup_unprocessed_command(ring, wptr,
 								       fence->wptr);
+			} else if (!fence->reemitted) {
+				/* always save the fences */
+				for (i = 0; i < fence->fence_count; i++) {
+					amdgpu_ring_backup_unprocessed_command(ring,
+									       fence->fence_wptr_start[i],
+									       fence->fence_wptr_end[i]);
+				}
+			}
 			wptr = fence->wptr;
 			fence->reemitted++;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index f93bf83f7f5e4..51b80c18ded9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -151,12 +151,16 @@ struct amdgpu_fence {
 	struct amdgpu_ring		*ring;
 	ktime_t				start_timestamp;
 
-	/* wptr for the fence for resets */
+	/* wptr for the total submission for resets */
 	u64				wptr;
 	/* fence context for resets */
 	u64				context;
 	/* has this fence been reemitted */
 	unsigned int			reemitted;
+	/* wptrs for the fences for the submission */
+	u64				fence_wptr_start[2];
+	u64				fence_wptr_end[2];
+	unsigned int			fence_count;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
@@ -165,6 +169,8 @@ void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
 void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
+void amdgpu_fence_save_fence_wptr_start(struct amdgpu_fence *af);
+void amdgpu_fence_save_fence_wptr_end(struct amdgpu_fence *af);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
-- 
2.51.1

