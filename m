Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9474BC83038
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EADB10E2E4;
	Tue,  1 Jul 2025 18:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qIIWMZpP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F27D10E2DB
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=julxI+jtVcbeREwnGZ/H5PddYyBcT4JVyPReqnbCBvA+nXOBNnT+G5iX7B4ncVPOw0ndYOFgpVAVoxNTjlAKAjq8eiqChc3CmgbvKBvjvleOqaGUM/EIKf1a9p8Pag0g+jdTm1zzD/XXeuzUwUpGHFiYx2FuJU2aHgIrVVK1WGux1ns9oDWaLzs5Jl0I5gEOIfi/FWsas5HjEWlmhgfROcLxpTiaM2Zs8lwoI8Ei3IeYlOdPX6LexBJOaFmcyTYxu45HZQM/0x6pO753Vvwnzc/T8zhNStQfNUzIDNa1HJvSRJbDpBxHIT5PcYQFYDqGCxfYo8elF9tldYsNu7+2/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFFNMmjoCNPsz9WT5KqMLhv2eIAdxOTjgjCpvUoU/Uo=;
 b=luoea4uPS2I6eAjFDAoKY2IHT1uEpW+FGAECT/8VsZSJPdMS9uuqzVAY1WmwKue3cHyEgwBRz5wwdU8vE95vFaSSvPW45z7Besn2LR3qmi5hBYjXxnxTyQlrJUAcJd/T+rSpg4c9MVkBP0qWRLk4VPH0MzjP99/XghgHwmZ93ZiJSNNySD2LjZOTLQvaqdOtWnWwPT121chKKPSPGyKgPMZ5eu3ausHCdq6JdP7aL/nf626XwXolHrktQVqN9cpPbPOw9FMcr7HtMcIJo3iOtBi8XGl58xBF5biNjAT+b73TGj6YrjoG3Z2BfC8xfKWNJ299+mTd18s0dWyI68dM/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFFNMmjoCNPsz9WT5KqMLhv2eIAdxOTjgjCpvUoU/Uo=;
 b=qIIWMZpPoBb1L9adj1Ll5GL8GDVsqTmRFtSU63DE29zqp7WPQqAkvvO2wFDZftDdwhEa+OXLAD2kjuDQ1QmCbXCFDj/EYxwNkCAtjULj1KttHfzPqGZBE9Fra9iVSpZGApRUOI0mgg61d2kgRC6s9ouR5+hyDru4OweGAX8LFpM=
Received: from BL1PR13CA0407.namprd13.prod.outlook.com (2603:10b6:208:2c2::22)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 1 Jul
 2025 18:45:07 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::9b) by BL1PR13CA0407.outlook.office365.com
 (2603:10b6:208:2c2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.17 via Frontend Transport; Tue,
 1 Jul 2025 18:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V13 00/28] Reset improvements
Date: Tue, 1 Jul 2025 14:44:23 -0400
Message-ID: <20250701184451.11868-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec2e1bc-3f94-479d-9c96-08ddb8cf6674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MILmAJ35crRKaKKI+QP5Aw+PGdRxBwAhOCCb6jD2t/B4b2pYBVTKz/sC/Aj+?=
 =?us-ascii?Q?BDCxldLTtfL7I26r6Uxa/RKbt0LrPU9UjsgJnL5cgq7v612BZIEi+w8Fji4f?=
 =?us-ascii?Q?dTxKX+8DLJi3k/+BtTos/M+Z2Jrss/zWt0elZ1A++/b59lY+ZW08qbV7+1OS?=
 =?us-ascii?Q?ZqwapUuEGz3UAo+zFZ279Z6qX/jVsAANcrT4VR7yYwLYbqO0iDVy4KdB4EQR?=
 =?us-ascii?Q?mskUyd8OQeFm/bBfhiFYN5bEG5ATrN/2jEe6rdeU2dd9l+nyRTUg3JeSNN9s?=
 =?us-ascii?Q?cpdC+75gsK15Q2pj6it8lqMpuD/HYXSwUEv6FX4vGHxsdpxupPcSIG4okbhC?=
 =?us-ascii?Q?PdSGTYpjc/lfVHxIwEQzx0phq7/vlt8urpMAGycgMV0vEbUnfN6b1DlHppPV?=
 =?us-ascii?Q?35hPescVc047WIaBRkjNz/65i9l3OZVByhwp+/0flMPdFDcG5aeMziJEw5J+?=
 =?us-ascii?Q?pKs8OlNodXKwwjGP6mIJJzEISMvUlZeeF6+S66Rg84uPF9KbxoWcHZiyrJgt?=
 =?us-ascii?Q?2D4gHqoR9a9u3o4Lh8vMIJN9fAq/XlQSZDWfkdwh2oqzw8kOqud1f7KUX0/Y?=
 =?us-ascii?Q?ucmhuZe3GvRWupZxgIXZ/4ycWCRsp//ZjiGbFZ6ezPjIxqTM7IxrmqJAvF7u?=
 =?us-ascii?Q?xguf5nWJ9YsvZnCqM/9TjBQUl6um9zczumjmcEn+rd67AfRQ0VSzml1NvlrE?=
 =?us-ascii?Q?X6Kd+MzVF5pjHL8cbIcn7yxAu1CSpTtShqX6Tvw6jFiitdNaitRwo+TlYyg4?=
 =?us-ascii?Q?7DnJimQQn0BGGXpLyou+J21ffhxfVS13ClUFXTaDz+VySDaw24m/aTJK7QU6?=
 =?us-ascii?Q?B7aY7VTWFe1aOrSFHb+XciDo4bsMB2+IJe9iy70N8JeBsXV5mX1INTwcoEWf?=
 =?us-ascii?Q?FStozd/jzpIoyd2en8phx6zjA3gNN8vFXRQDwcIMgCrLvdQtoWbuX1k84ett?=
 =?us-ascii?Q?oKP5MunWqpYmofVevwBuk3DDrZuBj1ydFuyWfsER9aaZg5wTtHgY7nWaDDPd?=
 =?us-ascii?Q?yZ/TkD86mb83EmWJQZa/caOW9w6CBEAJsYCNGwD2o3+Ax6JAu78wiVC0IEwE?=
 =?us-ascii?Q?sHHQwzGaytZL0dfR00Cp7xDWL8TDr3DzkqPmOjuK2NYQuZ+n71QHA3v2f5cd?=
 =?us-ascii?Q?8GFtAoRIrjtkDYHTAlm3Y52OHkbELtQ5U2b1bdadHhlQ0lgPPKO9WwfbpVu+?=
 =?us-ascii?Q?nleRZCCjocDMPKHa4Z0JpMhCihSG1fWa0UJmoJ+wuVa+W+OzwYNU9cRKCZcB?=
 =?us-ascii?Q?GMtCEmJA79zXdTEeywz1eME20ckhoh2BKb2BS6yUNH58EsVZxXtxDNWNtvhL?=
 =?us-ascii?Q?i5oavSLavXxfvKgj7kP/T18OGk7pTxzo+d5noK0XT2MvlQAA3LttNvvKKtCM?=
 =?us-ascii?Q?asuURGDmttrPcGTgInDwPbmVkIbM6quRuIoBe9OnzOjijtgLkZsBxaV0uAzR?=
 =?us-ascii?Q?pB84ZJqOfVqv04X4NLAjIoBzdFUxr9OhQn2DOIVEBpHqxMqnr1EHmg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:07.2706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec2e1bc-3f94-479d-9c96-08ddb8cf6674
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151
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

Patches apply to the amd-staging-drm-next or drm-next branches in my
git tree.

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
v13: drop SDMA cleaups, they caused regressions in some IGT tests

Alex Deucher (28):
  drm/amdgpu/sdma: consolidate engine reset handling
  drm/amdgpu/sdma: allow caller to handle kernel rings in engine reset
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
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 41 ++-------
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
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        | 23 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        | 23 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 18 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        | 18 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         | 12 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 11 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 13 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         | 11 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       | 10 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       | 11 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       | 11 +--
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
 36 files changed, 454 insertions(+), 280 deletions(-)

-- 
2.50.0

