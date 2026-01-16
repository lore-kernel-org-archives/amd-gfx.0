Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02742C982D7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 16:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A29010E8D3;
	Fri, 16 Jan 2026 16:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VWcH5M8x";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8958610E8D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 16:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2JCb3lpjdd11OtuCFGHHKpWhUJhA8oMxrF2pRKV1Dz9Q3dRZVqrYPx3ZicdWX/IZ8JaIG6/XTFkYINnoPczQYnh6BiVtG+8M/mz4WGJDE/fRmsOxBYOF5NlvRDLoQ0SQNxUC7dC7sjrPF9EDgiv7EAGGG167AiuxbeVbs6rR0Hg4w2zKwbIJ+bjgs4ka8yNOF5fyGOGuFxxeH8d4wI0xW+n3RQvUjAbw4UErfhNg6O+QJPCA5kAHxTNhtxquu1c0f6M6cbJr/nVCauXRyJebp+sgEGDV1yQ59wVJcRMg1+wGI/LJLLUgNHpOnr+oSlgnVwnRjEl7jU0IdbAECYlmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/6WNyNOYEo3sPZQIl0lMAUgN0epRtowVejsDNCpXT8=;
 b=R2s4sCfmZzL3SN7Gp/H8EfWWfox42SAAQ1iFtDcdg36pG8kploEM7Cq9jO6zJWR4tnFoJDVPfQ5ppZbZpkrlUf6UVlwcicYvKvTXzkrxfLQbxDg/UFlyvAUcHvOS3pdVSY0t3epy3qVq4hHMwGXQATCAN2xJyW6AwoHxd1R17pmyJV49LFFF7KIfx0Le2tb4Z3oBciDiQ+0eNcTVijdD7mnkAJFXgJpv64ZG7nrlnISTOLhWcepMil8TcAeb4e0gJcAYaq5NV+GEuaRSpvIh2JZw94lCISNp2ClfTnCHiZop8Ry9eG5guvQLOrYVHEPJUAczZRXy1xe0S1FxlXFp2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/6WNyNOYEo3sPZQIl0lMAUgN0epRtowVejsDNCpXT8=;
 b=VWcH5M8xROzRY7z5e+o9hgIKV6CuLtB1mrE7gRqL0tTxzF492haC8s6V15g0tqbKAvpk1Lisqm4Tsthq7hlFNXqSTkX9tiFFnyeWW/IGicv6cZCs+Tla6eJ5JMz/vKhGpa+waFwKc/XYFYvdfBszr+3UhtRY7Clb8N6frwMAqzM=
Received: from CH0PR08CA0025.namprd08.prod.outlook.com (2603:10b6:610:33::30)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 16:20:43 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:33:cafe::69) by CH0PR08CA0025.outlook.office365.com
 (2603:10b6:610:33::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 16:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Fri, 16 Jan 2026 16:20:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 16 Jan
 2026 10:20:40 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Jan
 2026 10:20:40 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 16 Jan 2026 10:20:40 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/10] Improvements for IB handling V3
Date: Fri, 16 Jan 2026 11:20:17 -0500
Message-ID: <20260116162027.21550-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f1057f-94ca-423a-d723-08de551b326c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Uis5a0VMbFRHUUtpc2JVVzdaK1B4VGlwbjY5MWI2MHNzc0dCcGpQeDhGc0Jl?=
 =?utf-8?B?ejVwTEI4YkhPREFkZDhOZitXRzBGRHgwd3NPNWJOTnpOWHVYV0RaeXZ2clZF?=
 =?utf-8?B?ajdtZGxjYklZczFZTkFXOFdzQjhZMEMwNVFPR3BuaTBUL3lSV1lpUHlNa3Nj?=
 =?utf-8?B?bGFiTkRLZ0NRVWE5ZVQ1RUdtQ0toMWd0UnluZnNBbUdDRGVHYnkvcjFnaHZU?=
 =?utf-8?B?SVd0STlWa3RISmJMSU5TRnlwK0ZlZ05naGE4VnlwZGd4R1JSdVZvZXFDU1NX?=
 =?utf-8?B?TW50UzRKZTJFVSticG9tekJSNFUzZ1lvUENoa0pFOFpCWU8wVjhoaUY2NmJZ?=
 =?utf-8?B?L1gwU2xIdFZaL1pkQ2orOStKbHR6Vnc0YnJNR2kvR25UcW9MV2dmVmpTTmFK?=
 =?utf-8?B?cnJHbER0aUJvcW5RZFZibGZhNzdUSlovTmYyTGltQnhyNDlnNHY3RVgxY3VX?=
 =?utf-8?B?Szc4RGU0Q1dxbUE2bEJqQkpSd0JHcWpYbWhTYnJWVi90a3hDR3FNSDJoU2Mx?=
 =?utf-8?B?cGZ6cDRMVDFrdWp0V3d4cTlqbnVUU2krR0czb3NGRVN5QkozRVU1bTFFK3RE?=
 =?utf-8?B?SnkxS2lva1E3RVl5SUwxYnZrcm56L3RWbVNjeXErMTh3ZnZ1THlvTXEyY2o3?=
 =?utf-8?B?T3p1SDBVTTE0MXh3UXh6cUZnbW9yVjBRWXNEcGtVeEg1dWNTZEJtSnc4NEJ6?=
 =?utf-8?B?NHdNcFBHTER0R21USWU3RWR0clUyWEVZSVVjYlRzS1pyWlQ2eVhmS1JFSlVF?=
 =?utf-8?B?T1RUTE96MU9VRFE5cGlqYTNSWVVaRlhGSnVGZjhhb21Sc0Y4SFRaY1FvMTNV?=
 =?utf-8?B?K3pGdjJ2TG5QNzU2bjRlUTZpYU1lOVA1K1J4VEwvUis1cncrZ0dzOFVqWUlX?=
 =?utf-8?B?RmtMWlM1bisyS2lkMm1jYmRMeHBOUFBMZk4zNUlCQzA1RUc0SHcrTmFKSkJk?=
 =?utf-8?B?Q3BtRFNmcklGSW04MXQrTnVieW1IRnpoSzFEQTRSNW80NzU1cnRTaS9HQ1l2?=
 =?utf-8?B?NnhoODdWMXNVZEwrL01DdlhzSDErSzFUelRNc2s0R1Uvcm5PY1VzOEpYNzY5?=
 =?utf-8?B?L2U4bFp0dmlpQWh5YlZmemIxY2VsS0lqSkR0amxJNzgwTllSWU0zQ2hLQ29v?=
 =?utf-8?B?Z0poaWJKMHZmbXl3UVZicWVMY2dXeG9STWdZSVZIbVZqYTZSQXBPQ2t1WWM5?=
 =?utf-8?B?LzFDL0R0UEgxZWYwbmdtK0xUVGI0ZS9NYnNnN09xZWJJeGd1YUdodU1XYUNC?=
 =?utf-8?B?cVB3cmJJSkVLM3pBeDA3Z29KcUovTnJCZ1pGQU9yZXNDNURiWW80alR6STUy?=
 =?utf-8?B?UVcwUFZ1SGExNjlSUHhhOWMvNTlvdkZCM1FINGlOK1d5dWhwWmxmOTNXVTBJ?=
 =?utf-8?B?Y3J0S2laclRSSEpGYUNqOUlVbzc2UjU4MVgrbW9IZWU5WXBJZ0FHTzRMNVIv?=
 =?utf-8?B?MThkdDBXVHhoT0ZVbkpVdzJ1NlhrL2prb3FIT2tEZ3FsUkVVcVZycVFFRDUx?=
 =?utf-8?B?VWw0RXFKQWswOXAva3BMZ0JyeVM3dnFQM2ZLWXd4UG5sQlNKcVVtV1pWT3d2?=
 =?utf-8?B?ZnA4TVZkUDBmaU9jL2d4WWJ3Z2t4U3A3YmNXMWkrcW40cjIxT0ZPcGtZQTdB?=
 =?utf-8?B?dGxiOWg1eG9OTzNHRVpMYzNKNHpPZlBEa0NpSHE4UURpclFNcTJsTFFkb0Nl?=
 =?utf-8?B?MXQrdXhFcjVuaWJzUjRPMXRlck5XUFp6NnBpZFRrTHRxUld5N2tvcFBjNlhD?=
 =?utf-8?B?T1dDM2NGVkFZa1ZFbC9qcGFiWEUzQzhBaUpWQ0ZFek8xRm12OGhodUV3ei8z?=
 =?utf-8?B?dHc4NDY5WnF4bG9BaDRSNlcvUHJscFFZc0VjNDhGVE05RCtUd1BjckkxNWxj?=
 =?utf-8?B?TEdxMDlrSGJScG16SHdzN1YvV0lqQVNvYkZQTVpLakpWWTloZjk0VTJFY3Ba?=
 =?utf-8?B?aUhyOVIweElWUzhFY3V0c2dnd2pKNEg4MTgyV084eVhaVmwxZ2p2ckZjVGJN?=
 =?utf-8?B?eFREUXV1OGZWL0NpVDBLaENBRFJSVzlNWVU5QUN5VDRZcEh4ZXdWc3pOUk9p?=
 =?utf-8?B?YjJzLzgzcEZGOVJCN3ZtSGtkbjM2ZmF4Vk1XQXVpamlmZWZSTjBDOHVqQjhY?=
 =?utf-8?B?NVNlaEZ3Q0x1amxRUXJ3VFNzTnpobjlGS2FDTjVsK1JWVCtGWnFiWlFHMGVz?=
 =?utf-8?B?OGNsMG1zSURtOXVkdE1XN2wyMGhZbnA4VlYyNUgwYUhOUEwvOHdZUSthazJV?=
 =?utf-8?B?TWMrWDNzdlNpcWxVNk9ibldna0hRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 16:20:43.1097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f1057f-94ca-423a-d723-08de551b326c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859
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

This set contains a number of bug fixes and cleanups for
IB handling that I worked on over the holidays.  The first
the three patches from V1 are already reviewed, so I didn't
include them in V2 or V3.

Patches 1-2:
Standalone fix and cleanup

Patches 3-5:
Removes the direct submit path for IBs and requires
that all IB submissions use a job structure.  This
greatly simplifies the IB submission code. V2 uses
GFP_ATOMIC when in reset.  V3 sqaushes all of the
IP changes into one patch.  Not sure there is much
value breaking this out per IP.

Patches 6-9:
Improvements for adapter resets.  Stop calling
drm_sched_stop/start().  Just stop/start the workqueues.
I can see why we need this at all.  Per queue reset
doesn't use this.  Stop calling drm_sched_increase_karma()
this seems to result in the jobs always getting marked
as innocent and prevents the subsequent fix for marking
the job as timedout from working.  Per queue resets don't
call this and they work correctly.  Properly set the
error on the the timedout fence so user space see it
as guilty.  These changes also resulted in a small clean
up the the VCN reset helper.

Patch 10:
Rework the backup and reemit code for per ring reset
so that we can safely reemit repeatedly.  This removes
the current single reemit limit currently in place.
This drops the new proposed reemit framework from V1
and V2 and sticks with saving and restoring the ring
content.

Git tree available as well:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/ib_improvements2?ref_type=heads

Alex Deucher (10):
  drm/amdgpu: fix type for wptr in ring backup
  drm/amdgpu: rename amdgpu_fence_driver_guilty_force_completion()
  drm/amdgpu/job: use GFP_ATOMIC while in gpu reset
  drm/amdgpu: switch all IPs to using job for IBs
  drm/amdgpu: require a job to schedule an IB
  drm/amdgpu: don't call drm_sched_stop/start() in asic reset
  drm/amdgpu: drop drm_sched_increase_karma()
  drm/amdgpu: plumb timedout fence through to force completion
  drm/amdgpu: simplify VCN reset helper
  drm/amdgpu: rework ring reset backup and reemit

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 124 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 117 +++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  37 +-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  26 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c      |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  52 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c     |  37 +++---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  31 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  24 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  25 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 139 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 138 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c     |  26 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  29 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  38 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  38 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  38 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  38 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  37 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  36 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  36 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  36 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      |  36 ++---
 drivers/gpu/drm/amd/amdgpu/si_dma.c         |  29 ++--
 36 files changed, 668 insertions(+), 662 deletions(-)

-- 
2.52.0

