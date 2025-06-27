Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32FCC7EE32
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFBBD10E93D;
	Fri, 27 Jun 2025 03:40:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="chopoQYn";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0980410E936
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0tw/pSExopa/p+lZa+zxR2uMZ8l/io5uERL7CubinpyS/rfcJptest+JGDVOxY28nhcsEeiAXJB4kCtqHFRGpaH23Gwly+I0T/qest+CuQ8XYJuluUuAcinHWttbWkAXgiz2a8JV64MoVr2svIlHHfTK2t+hQVbOKCH7hKOTn7sMVCrw/PasKmsqioLyNE/wuMzhp95zv6zOw2zOCooFbW3ozqyUrYuL/cIx2I23jEMeTy0R33AhhGpJgWzkVqgRwGWhXua8M9Y6HUIk0SXiljMWghbGX99X6jLrukCQiHazxg7ghB018KzJtb5tjr04avfpWnPxUs1hdfocqL2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c14aIsWf8/RISI3QAi6HSg1fdISsQWr2k8rCEyVAXTA=;
 b=kMDWPafHnnXYXh40qybClcFj4n0BB4+4IvGAIwh1py+lj6GUSz2L13lnBmHd/3YS2dWALmKzVpsIyqOIvmOryXhIkgqGThzfl31+fM+tNOZfgvXGs/X7+z7kSgAJHUTI9wvH56Od4G5sqFrP1jm6SSZlvSYJIMIfIY8GvSEBsP6hsH4fwMYwU541R8a9M1fmo7lwbick0lBT7Hfh/HhQdzkMJCXkCnlxAD7Ch3I+pmdqJer2fszvWOK3Lj2ymBuBbkGVLzG42YmgXLk/ANI76TYn0ZCXp7N0+YFlhHMyjVi8mIW7m+MmrEzFpz4CU+cltdYgFlbQp9JHN9sECRGb/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c14aIsWf8/RISI3QAi6HSg1fdISsQWr2k8rCEyVAXTA=;
 b=chopoQYnLlnaXKkFIxExnDx0DMGGlJJGiuEFQG+8aYnDqdAJB4feZiMFXgVk7O/HBE5QcJB8VjPAh7w7EiRm9JhdEe7CB6/dcj2f4hFtjpwB99l7MlSIpOm4YnXnLGV/Wah22Y0o08MEBaGbtK4/3BQOnSGMwsRpZ1GGKHdQkVE=
Received: from MN2PR15CA0042.namprd15.prod.outlook.com (2603:10b6:208:237::11)
 by DM4PR12MB6616.namprd12.prod.outlook.com (2603:10b6:8:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Fri, 27 Jun
 2025 03:40:21 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::63) by MN2PR15CA0042.outlook.office365.com
 (2603:10b6:208:237::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Fri,
 27 Jun 2025 03:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V12 00/33] Reset improvements
Date: Thu, 26 Jun 2025 23:39:29 -0400
Message-ID: <20250627034002.5590-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|DM4PR12MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: d650305a-0151-4ab1-3507-08ddb52c57ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Gt5Z5Cb/KjPqSLr7qk1YiS50SMZZcxL+UtsEH+7pyLAkY21/ntfDU3KcxHU?=
 =?us-ascii?Q?sOwaK5kBJB8IxBNXrt5f4oQLqrfZvdzOSynEhxVWu+pndAdCwdqLGp37jCbZ?=
 =?us-ascii?Q?sDA0Zkb/tb+fQtg8OXxXciDZRVGShvTVkhX9NiHwT608LEHaz68gIJeh3FkR?=
 =?us-ascii?Q?IGQPYyuLN3PUmB3oD35vTF3FdeNvF0pRPnu82GxVLJKwKxbc28L9HOLv4FqB?=
 =?us-ascii?Q?4f3H7i87naPYL/Irwd/K2agcgzcvIzaBKXV2Bo5GQdHR8bXib7E7+OOCEtwU?=
 =?us-ascii?Q?S8m9NC0QVox8BpOpqfHo4LQoZK6emjSzFjLnMqISYjtTRxIc0FnA3kou5lxU?=
 =?us-ascii?Q?FJM6KaL3TA6306D4sqp9A85pdparC4Ukzz28AmZbSkcQI5x/ekxDmQidqPD4?=
 =?us-ascii?Q?0LeQreGCDQKuCygjW/cNMWFGjoJb0vhDSrPla0Sr00/b/b0XhCkeZGyT00G5?=
 =?us-ascii?Q?I2TdAA8qRRw5Q+L2e0+cgDrnwXcfnqX2kat0CfhP+i2QanM+gk0tAn1IDQ8n?=
 =?us-ascii?Q?e+g0SMuMovicKM3NKg6jYCk3NrEpKUda1qdu1PLv5dOZPUGpEQnAIauUj850?=
 =?us-ascii?Q?4ASmeshnlluiVsZ9yV/jqbeEmWNOcN6Mif76N8wBuvGjmKns/k7yi7SrHDsT?=
 =?us-ascii?Q?CoGYtb4ZJ7IHnB8DAEjnuznOWxbIWasbEJNQeWIimx9Kw6KmWfhr1tqCbKGN?=
 =?us-ascii?Q?rcuvkmwRBUQddD+QriL6L12irH6hn3HQM+zNEoGcFXOxf4V9jwaXJXY0Rm2H?=
 =?us-ascii?Q?lnKUHwfEC5fv8ehJOB0JL8v4oiSXVNXjUsccjxIUJpur4T4xIgdYQiRcf6CL?=
 =?us-ascii?Q?Ibc3n642dU4tHl1nzyPLI+XsIHgRPq3CqYptL6GO1HtSSRLBZ3qhV7lXkGdq?=
 =?us-ascii?Q?N689T/zi+PXtav9xBUbJab9pR9vN/Fm2r5vhcUs7WQFoaLE4fy6muPnOAwE/?=
 =?us-ascii?Q?aBPf6183GW/pbwbSf+3ZzMx2RXe11alegb4eJgI/NlgnUvbn0ZiX7V5brxUa?=
 =?us-ascii?Q?aP528LqKqCbpw7g0yFPCy4fkNWSDfLj5pgiqEK02fZzJhCbihHoi+fcKAdKd?=
 =?us-ascii?Q?8T4YAx3d8KtHadYDHlx7DoacKYvrDN7JBquDT3rWO1xtneFpX2vI3BsH+uME?=
 =?us-ascii?Q?WNXQ4BWm5yxDMe4PG3jygBllD9vmqktl44++UM3/Jq0YFiHkDt6EooyG6iPy?=
 =?us-ascii?Q?YYxcidGFYCCJ9a5K+bDYTxIIDKmgw3JUtwo/fz/A7LL+pIDK2MXuXSxEmutq?=
 =?us-ascii?Q?TuU7dPyXBBtrQQFRpaSvgKGfn+BYeXdHX4JCnltyjiuFrtc4y71ulfEpyAvw?=
 =?us-ascii?Q?i296YnFR2A3msz3OihLXu9bGfxqQdjZsjutLsLuHMyocXKxyIj5dJ66Ren4D?=
 =?us-ascii?Q?6TTCTvF+HMpKkdG4oYfE+wYCXsD6+hmEIeU1KZcWWBc2oDQjVUtFq/dCW4eS?=
 =?us-ascii?Q?1hRmSScvtZPIZhiZreJCIf3kzOkt5KS5Wuy5eRG9zcf/iCuYAJ31SA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:21.2086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d650305a-0151-4ab1-3507-08ddb52c57ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6616
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

This set improves per queue reset support for a number of IPs.
When we reset the queue, the queue is lost so we need
to re-emit the unprocessed state from subsequent submissions.
This is handled in gfx/compute queues via switch buffer and
pipeline sync packets.  However, you can still end up with
parallel execution across queues.  For correctness in that
cause, enforce isolation needs to be enabled.  That can
impact certain use cases however and in most cases, the
guilty job is correctly identified even without enforce isolation.

Tested on GC 10 and 11 chips with a game running and
then running hang tests.  The game pauses when the
hang happens, then continues after the queue reset.

The same approach is extended to SDMA and VCN.
They don't need enforce isolation because those engines
are single threaded so they always operate serially.

Rework re-emit to signal the seq number of the bad job and
verify that to verify that the reset worked, then re-emit the
rest of the non-guilty state.  This way we are not waiting on
the rest of the state to complete, and if the subsequent state
also contains a bad job, we'll end up in queue reset again rather
than adapter reset.

Git tree:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/kq_resets?ref_type=heads

The IGT deadlock tests need the following fixes to properly handle -ETIME fences:
https://patchwork.freedesktop.org/series/150724/

v4: Drop explicit padding patches
    Drop new timeout macro
    Rework re-emit sequence
v5: Add a helper for reemit
    Convert VCN, JPEG, SDMA to use new helpers
v6: Update SDMA 4.4.2 to use new helpers
    Move ptr tracking to amdgpu_fence
    Skip all jobs from the bad context on the ring
v7: Rework the backup logic
    Move and clean up the guilty logic for engine resets
    Integrate suggestions from Christian
    Add JPEG 4.0.5 support
v8: Add non-guilty ring backup handling
    Clean up new function signatures
    Reorder some bug fixes to the start of the series
v9: Clean up fence_emit
    SDMA 5.x fixes
    Add new reset helpers
    sched wqueue stop/start cleanup
    Add support for VCNs without unified queues
v10: Drop enforce isolation default change
     Add more documentation
     Clean up ring backup logic
v11: SDMA6/7 fixes
v12: Ring backup and reemit fixes
     SDMA cleanups
     SDMA5.x reemit support
     GFX10 KGQ reset fix

Alex Deucher (33):
  drm/amdgpu/gfx10: fix KGQ reset sequence
  drm/amdgpu/sdma: consolidate engine reset handling
  drm/amdgpu/sdma: allow caller to handle kernel rings in engine reset
  drm/amdgpu/sdma5: clean up resume code
  drm/amdgpu/sdma5.2: clean up resume code
  drm/amdgpu/sdma6: clean up resume code
  drm/amdgpu/sdma7: clean up resume code
  drm/amdgpu: track ring state associated with a fence
  drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
  drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq reset
  drm/amdgpu/gfx10: re-emit unprocessed state on ring reset
  drm/amdgpu/gfx11: re-emit unprocessed state on ring reset
  drm/amdgpu/gfx12: re-emit unprocessed state on ring reset
  drm/amdgpu/sdma5: re-emit unprocessed state on ring reset
  drm/amdgpu/sdma5.2: re-emit unprocessed state on ring reset
  drm/amdgpu/sdma6: re-emit unprocessed state on ring reset
  drm/amdgpu/sdma7: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg2: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg2.5: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg3: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg4: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg4.0.3: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg4.0.5: add queue reset
  drm/amdgpu/jpeg5: add queue reset
  drm/amdgpu/jpeg5.0.1: re-emit unprocessed state on ring reset
  drm/amdgpu/vcn4: re-emit unprocessed state on ring reset
  drm/amdgpu/vcn4.0.3: re-emit unprocessed state on ring reset
  drm/amdgpu/vcn4.0.5: re-emit unprocessed state on ring reset
  drm/amdgpu/vcn5: re-emit unprocessed state on ring reset
  drm/amdgpu/vcn: add a helper framework for engine resets
  drm/amdgpu/vcn2: implement ring reset
  drm/amdgpu/vcn2.5: implement ring reset
  drm/amdgpu/vcn3: implement ring reset

 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     | 90 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c        | 15 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      | 67 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      | 18 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 43 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 76 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  4 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 57 ++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 35 +-------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        | 35 +-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 12 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 12 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        | 11 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        | 11 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        | 11 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        | 11 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      | 11 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      | 11 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      | 14 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c      | 11 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 19 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        | 50 +++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        | 50 +++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 43 +++------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        | 44 ++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         | 12 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 11 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 13 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         | 11 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       | 10 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       | 11 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       | 11 +--
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
 36 files changed, 502 insertions(+), 353 deletions(-)

-- 
2.50.0

