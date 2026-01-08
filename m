Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2EFD1D46B
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94ECE10E77C;
	Thu,  8 Jan 2026 14:49:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1wJMTWJn";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EDF410E770
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uo0xdhq5PldAzKW1sOknDHB1Ijn31U6uaydq8XTkzi5sge/i2evU/J+MpxpiwxIDUOm0A7PBROm9K6F3EdGS27xpk1QDtiq4Gdwhi9AVK3khG41W+2povR1w3P15j99zwu03fhqCLMH4pd81J2ftXqlXD2Mi/lSnCyvazp5LfbK5BqVU+K/F3fpx3nnUgtdqsj6OdzGiQXyUbBLYn85uUyPBPKtiPn5w+lyplumb4YfbTfG3LbNqPKDt9l2x6KwOrW32IG4W3EmvJUu3rK/nXzLSL5Dz3xRlGy/AYvQMO4fmdyYSohFi/0tZrCBnQZ1adEtHJr7KR3eG4adHkbtgqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zo9sruWLJOXjrDRlT09Rfym7UKFz4JyKNZd98gSGFbI=;
 b=rWd7GTZwQk8LBnKVj6AetJbNOxzSZzi6L2d3yX9S8vNSU6srW+jt3tZlPxlZpJsEpVotDSm29j/UmIb7OAsBwP5wf7nx9oTGhKEaamridDJkCRK5vs80DIw4eDuuRsQIqybeVOnqeYMxB775eaEicHduVEpZWGrpbGZQGyVaZIfSIwHnE5jrjehE93byC49VvnXoG/tBPDjc4gHiMg0prVAj2PFHDbIJqI2SOCERpDRamKaw+c4rAuUGmsEHT/oU5FkiXfuXI9/weSytLBO/IDJzUtWQiseJ8hnd2FgZ6qbTo4CA9G/tqH56T0VHUf8PBJmYUDSZCo3gkxMzuRoQCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo9sruWLJOXjrDRlT09Rfym7UKFz4JyKNZd98gSGFbI=;
 b=1wJMTWJnRW/FsGVPimNVQSWRuo4ctvY5yfs1fY0Kz8KZFEXnX1DF15FI11MHkamOOJbwT74dIti10RDvbv1ROWjwSS5lOIi4PaV199DIPDip8E8HN9c/+3RDQB1NK9ORZuFRgOdG95SPntkKnHcqlgx2gHSLXTfWUY2WIzdEwME=
Received: from BL0PR02CA0118.namprd02.prod.outlook.com (2603:10b6:208:35::23)
 by SN7PR12MB7787.namprd12.prod.outlook.com (2603:10b6:806:347::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:49:14 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::26) by BL0PR02CA0118.outlook.office365.com
 (2603:10b6:208:35::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:05 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 06:49:05 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:49:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 34/42] drm/amdgpu: move need_ctx_switch into amdgpu_job
Date: Thu, 8 Jan 2026 09:48:35 -0500
Message-ID: <20260108144843.493816-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SN7PR12MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8e0b5b-4244-400d-3bef-08de4ec517a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KFzz469h0yPWioLPM8f/hCTA7BDqtmakwuJFNO/j7Kd8r4GJmeO3LTpIH3T0?=
 =?us-ascii?Q?eEJ+rH7mGnXljQ+71y2Ie0Q7qo3IcAqIgyegXpqGmGx0CEksZLdCXCluUVga?=
 =?us-ascii?Q?LrXnyQ/LS1NUpxL2G4RJTaaDOL/ORCD9Q9ycS544GG8efJImtXR3yOG1UMTB?=
 =?us-ascii?Q?Cof7Q9uBBwqfD8QIF6iFqxV1A0e0aBirHqz7O379qNzvKq+blN47j4VluTdU?=
 =?us-ascii?Q?EhPyWKvlf6gcemKlhlR/r9yobnjehGJiiMRqGDLcZC3flDdDij7PXsxGSotz?=
 =?us-ascii?Q?wjDza68EZrnz57Uf72ZuLDsomVNLLUDQuTIGTuR7gat7fsFhtNYtybIDm79/?=
 =?us-ascii?Q?Ka6blTihTfp4eYIZ+Kfk5UQgURaI1gz58KFObgECf4JYjfDi5CbTVP80gt8F?=
 =?us-ascii?Q?VKBh4T1xZdU6x5J42ieRgJQQRebAEIN2uTTm/5b1dAEELGLdT4tsnofY0htR?=
 =?us-ascii?Q?w3RNCW8M2vVIyG2f/EXvvWSDWqbwNslgVZSMBW7vyYNg2pJut7wHFKAzwLnT?=
 =?us-ascii?Q?6iMkck6tpsJnJPWE7qbss5FXROTHolcso1lDKXh9JwJR3k3WAw6BB9JkuJ6L?=
 =?us-ascii?Q?ecreVKhTJVJ7gvQ7zLICBFvzy0EERggxerCZN2rC+C3MTZavSmavD0euDOjN?=
 =?us-ascii?Q?Tfa+tx47iW/138XrdwPAjsZ3Pb5fj12IjS2mjLPe8W/lcsRdUlDwiq4hLmLp?=
 =?us-ascii?Q?pZBy7Nqv5cyVAuzyWTmexgKZll/FGGf3vmuRmCxtg1ieNiBdHtj0sqQnX8fl?=
 =?us-ascii?Q?Q3rByQOCIjd9kHDUU2WF09psf0J2ugbTm+YMD5tBZrDqzdVFpspvsAk++TAD?=
 =?us-ascii?Q?36jpaN9k0O0UiYcfwvS7uuciVe2ZcXPy0hBsUF5c3O+R5noPmAjCtwIDolLa?=
 =?us-ascii?Q?1869st1EGGCBM6FQuVo+6MxR3Xe8ii5SpfPxbr8uQo5ArFSLRQGhgt+eQZbn?=
 =?us-ascii?Q?6UKUAQq+sdwBT3ynU89EHl0DA94eHknYMppT42DbqWl+/8eWBBgjX//P/Vpi?=
 =?us-ascii?Q?k9lVGkvoAcJ9Q5yIZd36uPvp9A7L0TrKVI8vzCbhIy5aXoJ1UUvllz6xccJw?=
 =?us-ascii?Q?crGaRlK5Xmdatfjid9cSsFTvuDaP9Zqh0Y2hnqBHkrJnZEnQXOsjPazd/pNz?=
 =?us-ascii?Q?Zo81bkB7tuBVOo+i+nYozUwfeCZX76rK1PBLpzB2JvDgMzICC26tW6XIndpn?=
 =?us-ascii?Q?zhsZ36z28nZ8uctiV2G/j/zbEcHMBuCGQtlz+S6YzoxPWC79r1+OI9sL91SA?=
 =?us-ascii?Q?0Cec5Oh+OLU1/AEzJ1IfyH3ahp/D068ffYBBiWQp8kJ0z+esglPgDx0TiiXu?=
 =?us-ascii?Q?MDXDaAdQIGN5CHwt5ulC+93esmxkQ5pdBZUtzRcZDdxIqIC+cwIMd5creEmu?=
 =?us-ascii?Q?eXvnnTxLHBPIdSvRDSlpfJ9rKRYjibE/f+GAh9aMAmC7RC8OZBFD/N1pQ66n?=
 =?us-ascii?Q?zlqR58FHDDquyeol7jUCFtc5Li0MoqywhIKsNN4Et3PO5St8y80j6gBQfH0z?=
 =?us-ascii?Q?sl1J4qKVuBnMrBZ+Bz849lH1VlfileQS7m8Fnh9fDnT9Xj48jQWdDt/iXJOg?=
 =?us-ascii?Q?KA122EDAbQEciYjMe7Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:14.5105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8e0b5b-4244-400d-3bef-08de4ec517a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7787
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

No intended functional change.  Needed to help separate
the IB scheduling and emit logic.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 7 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h | 1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index d9db39d56fa2d..8c36eaba151e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -126,7 +126,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	struct amdgpu_ib *ib;
 	struct dma_fence *tmp = NULL;
 	struct amdgpu_fence *af;
-	bool need_ctx_switch;
 	struct amdgpu_vm *vm;
 	uint64_t fence_ctx;
 	uint32_t status = 0, alloc_size;
@@ -185,10 +184,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		return r;
 	}
 
-	need_ctx_switch = ring->current_ctx != fence_ctx;
+	job->need_ctx_switch = ring->current_ctx != fence_ctx;
 	if (ring->funcs->emit_pipeline_sync && job &&
 	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
-	     need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
+	     job->need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
 
 		job->need_pipe_sync = true;
 		job->pipe_sync_seq = ring->fence_drv.sync_seq;
@@ -227,7 +226,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 
 	amdgpu_device_flush_hdp(adev, ring);
 
-	if (need_ctx_switch)
+	if (job->need_ctx_switch)
 		status |= AMDGPU_HAVE_CTX_SWITCH;
 
 	if (ring->funcs->emit_cntxcntl) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 908239d45bd3f..21e1941ce356a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -104,6 +104,7 @@ struct amdgpu_job {
 	/* job state */
 	bool			need_pipe_sync;
 	u32			pipe_sync_seq;
+	bool			need_ctx_switch;
 
 	uint32_t		num_ibs;
 	struct amdgpu_ib	ibs[];
-- 
2.52.0

