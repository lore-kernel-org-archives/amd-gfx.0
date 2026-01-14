Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A93D38FF0
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE79D10E659;
	Wed, 14 Jan 2026 16:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xEMkaTa+";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17E9E10E64F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5/X1Rt7IVOoMYx4d0D9j54+sNYLAu4fKvvPbyZj3L8haVE6kgOXNyl1j7dYS/GJN6j0u/DMZyJrvRPBGZwAl/KSu9ctbdVW/vE3bM0XdexVLgwu6EPzpUi5j/MLrgIgijm8aQbE1InCbsJvQE8QFKYMqMR5p2EiljqseZR5WoGrb2ndC+GX5+aMXRXJDgZ2XPsSRRSgfPdMbZIFFhYSCNMZdLLd5EYfKiS1db4HAB2LGMdtQQA2dB26aQbA8+4PsPXKQRW/K5O+TidLp4wiWYahsSI6NsYyRWWFpz7qNVQA3aIMPEtB/lPQRVUcp6OA460IqJMJYQtNfDQx2zToZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGxFO94hshBny/eFHgqAEP5/n4lt5DWcNJHEDHfZ4NI=;
 b=iMQvW4a+LdrREocbaTpyjrcVv+jMlwMlZddvV6kNSduw/xE9gz4eGpvndjsWunu6Bdv0nnGWVoaUVT3QMzMcM5JEcnZ2J2l8fhCcz4W4FNXgEK4XzFnztqiVdyV59zmqayRFS0HLuCsK8lYYA1vZ7W74AUdfSWXB/8Yf1WHIu59+VGL7QIZRiUmS8vS1dCB/4GsVaM3kMHfA3Fu5alkw0StHtcVGX9LPDB4fdj2NqjRCbUPq0z2C4MuFxAnmC+CZQe31GtALedw0xr+j9yzLfd4nu0ydkri54+bfHEvzRtz6T6pUF/UJfdE1euQppJADcjjQY/53VK4DCbJVoQKI8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGxFO94hshBny/eFHgqAEP5/n4lt5DWcNJHEDHfZ4NI=;
 b=xEMkaTa+848VIB8ocfLuuPNB7VGuJLe5z1RMSUtqrgDRHlMSV7C16NLrWBFGvWQCHr16AVjgqO536/rtXZsJAvPpk5/ZCjlLVVxjgaNanw+nDhRfKN4xjlmDsZQ3zi5OZX5W5CCecYGJzjHJkTpB6cv2t4MVDieplWuDlbasdVM=
Received: from MN2PR18CA0012.namprd18.prod.outlook.com (2603:10b6:208:23c::17)
 by IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:48:11 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::6b) by MN2PR18CA0012.outlook.office365.com
 (2603:10b6:208:23c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 16:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:48 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 08:47:48 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:48 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 26/42] drm/amdgpu: mark fences with errors before ring reset
Date: Wed, 14 Jan 2026 11:47:11 -0500
Message-ID: <20260114164727.15367-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: e5296f3b-4005-48ad-8b7b-08de538cb403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9H9LHEeoXWwuVBbw9N3eOVCVqgV2CwhAsiaIy2ufgcWoVkpZ++/PGAyBKy7u?=
 =?us-ascii?Q?fNxKShtqYo9rWvzS1lbL7P0Nophz3LMdM4iQrvQP2HspF9jiJllB0QfuTGqO?=
 =?us-ascii?Q?zeJesHqrvhvcZBn5tABCXfj+K+tkhCbYHN5rmfZiy9N/FAOzU1pijR3SB6bj?=
 =?us-ascii?Q?wGP9vKOmX/WkCc43u3JYXxgSqK9QC3n2TmXgsT8T8Lrckq7EUSdmQt/rrwl1?=
 =?us-ascii?Q?vpkRW6+0Pfn9N4BbrVrZhRvuh+3ZOtiREB1CXcLMXG6mM/Vk5D7bjRn+h9cx?=
 =?us-ascii?Q?tOWuv/UdlB4o8IsUcYq0hA3xfNJwDvCeHdfHWZhlo865aSuKFIlKQTpaHO0g?=
 =?us-ascii?Q?cn3x8QEWQcrP1tp2fekKgh3//+JAqTEAwCi8TKCTdzpitJQy/U0BjFGbOBb7?=
 =?us-ascii?Q?BIM6IMAF3cmXjH1QjmBGXF3gpja8oF3YsO1eiH40LL70xFoTmecfKE5PDEOG?=
 =?us-ascii?Q?7D1Bd37+ow9vaOrlgMg0tswCs1aCae0sbPS1c/oqeyeUJt/qITAajjZVrSQE?=
 =?us-ascii?Q?hb2tW6iCkdBafL1M+2gIel7L62KF5k8Y7f5Ekm8nYojvfRB41xfcHyCY9ywC?=
 =?us-ascii?Q?Rm+Y/FZAhuD3/qTjcKvyqE7nvRFlOLQbI+ty9GF2cqZEwjMhLzStCQ6YRCWs?=
 =?us-ascii?Q?Bea0IBWnxH2Kl7mF/+e//DI/VMyQQKkHFgxKCa+q4QoAAKzckaDiDZK31ZqD?=
 =?us-ascii?Q?CDcYPen2w6pIHG5im4a9zBrN2HOlxsD0rL/l55zSomUeEJfwFbTMUTMvHhS5?=
 =?us-ascii?Q?Qe31jQCO0YMwk82asOfxBXrLrZqfA2XX2S1qnY5FETjQ2UaHVzPnAsn9cSoG?=
 =?us-ascii?Q?/pYRcNHAHYjHxmK3YzRj9FtPcYoGIn/8tPB2+WGXM4zuN+Rwz+Llz5F3ctT4?=
 =?us-ascii?Q?BITJavA7Hgmi3d+QTVoa5dhNFl24dhNVDQeUQE46DX0VH/3LR2xmnSogmGap?=
 =?us-ascii?Q?aEZNFJxg5mv/8LRnC1U/ri9O+Ma0J2X2GyOH/MxBscSKLqB1pZleaXg/IJfR?=
 =?us-ascii?Q?+DeW076N2KV6/OhDtGqt1QKwQPwpVFcWXxgrsUb1asnimKDuwtR3lCS7TbRf?=
 =?us-ascii?Q?YEaBcy5FViBEF+V0HmGx9B64kgOpONxMa5jVk2QJUcF4TgGhTAvAh2gFnhxA?=
 =?us-ascii?Q?Xhn5ZADKbGX9k5I88bbvHqRzsVYiuix7Fd1mhho0MHaXD6guPH+ZsMf/B9RF?=
 =?us-ascii?Q?Kr0bG1H9kJIkYDXE66YlN6nf+Azx94po3ZwB7wSNF4vjSSMB4Rc9AS2DOcaC?=
 =?us-ascii?Q?O8r3z27cfBAKzV9gCGe0PT859UUj197JEBTp12/kV8oOJOK6wpzeNaptV/f8?=
 =?us-ascii?Q?3b2xtoUTr2rFETWpdDn8vWnmc5gHl9QLqbTnbzWdv2WxBFe43ht6EYisROOw?=
 =?us-ascii?Q?HpzONVUT4eijPrEAbMqY6jEjn6hXcH3T2fBEJgatzVdSufgSgJEZvgXe/+U4?=
 =?us-ascii?Q?lM6HsWLieORsFvF/STLW3VQ4M6DrpNtuM5JS5Si/tdZ6TAux96ZBI0cSY+nf?=
 =?us-ascii?Q?7EFakf06MlEufGNPIfnywRd6ZEiyEFfGNmtwGCpcrcoA/QAbA2bOU+wzS+/0?=
 =?us-ascii?Q?ilfJVb83v9kTDuxvZ24i4WgF65AugpguCgbX2fHfDEvy6RCDjxDacOOe5bjE?=
 =?us-ascii?Q?CtPQy7wIoWLdS7TOHSRVBtRWnNcx75U/jqW9UGTp3XdfDEddDExoF9joOvMP?=
 =?us-ascii?Q?+EqChQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:11.3407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5296f3b-4005-48ad-8b7b-08de538cb403
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694
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

Mark fences with errors before we reset the rings as
we may end up signalling fences as part of the reset
sequence.  The error needs to be set before the fence
is signalled.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index b82357c657237..720abe280a769 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -872,6 +872,9 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 	drm_sched_wqueue_stop(&ring->sched);
 	/* back up the non-guilty commands */
 	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+	/* set an error on all fences from the context */
+	if (guilty_fence)
+		amdgpu_fence_driver_update_timedout_fence_state(guilty_fence);
 }
 
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
@@ -885,9 +888,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	/* set an error on all fences from the context */
-	if (guilty_fence)
-		amdgpu_fence_driver_update_timedout_fence_state(guilty_fence);
 	/* Re-emit the non-guilty commands */
 	if (ring->ring_backup_entries_to_copy) {
 		amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_to_copy);
-- 
2.52.0

