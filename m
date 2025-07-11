Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66527C83F21
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05F8B10EADC;
	Fri, 11 Jul 2025 22:40:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IRunn3gi";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A568910EAD5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6LUpgzJ04M7CZzJQSFWkPBd/wap4qTa2Jxmyu7enbd/zdOGMUNm866utY03u9FWxIuS4EB+fhpMitorI8j6WIYjtWcQuw2Fan+k5GlnofB0VmTAhe0XdcOH5IJ/dwqixqa3VKy7KmLUZJQtIZp9SWBk+nXQk82WpuflgVSYr5Th37QySIwNDCqMuN1x9Y+gq4/xWsocn+IBG/IcjuP85lRGGpncJWN0dpxFD583UFVYk2mIpPWrMlCpmV8lC0Gbc/THdPZWnbjvs4qvjWV63yYMkk8SeWYRY3feDTLrMnFyghOqPWh8d+v40QVl/a1TLcg1J+hvjJ/2Sw/TWQ+JMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRHl4mCn8oEXa6QMhic1GNT3f+CvxRQe3lEwWFl/NTQ=;
 b=M6V3nJsqAWUvrbvxEHvqJ/s3mUZPcMLAF9U+1eT7ICzlTxq5xFaCXivCDEtL8bZW4c+s5qp1tih9gxp7P4c2DISUwAhSpmiwXF4tz+i2EBNpSX1G8sj0HaNn8eSPFb+mRCa+dfPMbJsqaONCJKDq8pCarg+pa9JWpa2jwj2rB1ivNG5WhTIaWYQoAvdAo+zg+jeq2MVJJwr8rqTFRIrNw6DTcAxbLF7sNkw5WJKAYXUONFkoooyFuLM4o+H/ebbOpxZTfO5Ec9MZkw6wbZDqsCQgyFF7fH81lXqwaaj8FDPomU03YufrUguQ4oFgmdXx8L2ZdOlbSeYGaXVfL1TdTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRHl4mCn8oEXa6QMhic1GNT3f+CvxRQe3lEwWFl/NTQ=;
 b=IRunn3giIy7AaMji0SE6Tt7n7SL8z5R3MMWLFvkTEoyjcN6nTZf6sITk9YZROjSOgtRibhWj6B8AclCLgoU/BD1aqBEvuY/pSgVYSPQQQ4phTQNH0DeXL2xIqriorKHodByjA8lFlCm8z8LBy9/DmF5oQV+4Sy1wntu8DdU8IOw=
Received: from BYAPR01CA0064.prod.exchangelabs.com (2603:10b6:a03:94::41) by
 MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 22:40:40 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::69) by BYAPR01CA0064.outlook.office365.com
 (2603:10b6:a03:94::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.27 via Frontend Transport; Fri,
 11 Jul 2025 22:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V15 00/33] Reset improvements
Date: Fri, 11 Jul 2025 18:39:51 -0400
Message-ID: <20250711224024.410506-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: f350bfd5-cefe-47e2-337a-08ddc0cbf5e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?968dyhMXGJCJAbUoGYa576CBKcaAKOr3qfnVXyaPtQRZ+da03dV2bTHdejDQ?=
 =?us-ascii?Q?n4i3lYM/ixFfduMWkVtWjDbimfrZx56BcAeHHBnNC4C4r8BSDL12bI+WAiWy?=
 =?us-ascii?Q?Lr5h6Hik3lZal2DyHFDLu68tTH+QaLvD+hmsIvFUiOfZc9ZPGjZyB/kYL2fL?=
 =?us-ascii?Q?AvJVdCQUJbuH4A922qY0/kjgEnAOrFtUKu3BfosIOGvnXo2kAHhG1Ai/mCVJ?=
 =?us-ascii?Q?TLni1YvgCoMwUxNdYPVz/svTJQ6jc6twMaK50rgNxvWV4vnt9INEK4mdICoe?=
 =?us-ascii?Q?HnjJ2oCowbeRyzxI4nvyKYMU/610T9zn97ZC5Oxs5hM9En68Zj1rolyhBWhL?=
 =?us-ascii?Q?VBWsLRqVV9S8C8PsrDI2nUBi3NgJWfyVReij8O/4urxkBny21kRr/LYgX/DZ?=
 =?us-ascii?Q?4PTAY+chgEGc3zLDUlO7fenTI6HLWLqg/Zo29IovjA9HLa9yK5wviR5kPF09?=
 =?us-ascii?Q?Iq2sPdZmvhKnyJKlZ1g0bnYrA1nrX/YDt/0DdXYSkvQb5eWLSKch9MuYqxp6?=
 =?us-ascii?Q?pxjhCQ00vchyeAjD2Ew8AyJnw74KZSm5ozd0dtxP/TYKYQn/dzvLwRmEDQVP?=
 =?us-ascii?Q?Yp8SRFJVAJ/IwxM4/j68qxY10pTwCAYvTB4y+dNSVR6shrDOUZztjinP4zd3?=
 =?us-ascii?Q?S/xcpDM97TzFgrZYKHdHOzVbQDAGPlTJinFs1mkwhTQQ1dTb+hI8LcadfEG/?=
 =?us-ascii?Q?UVe15Q0WVBWlngwHuqo7XrvUbfSpRpDaby/fUHqRSS46o96zXiRlTJuVPQLP?=
 =?us-ascii?Q?+VxqaIkuAosJTPqOB+AbCOyx7iNlicv/E78V4ELK6U8lMFhuf4bHQ5uHJJb9?=
 =?us-ascii?Q?kBQHx6dpgijruNwQfecyOogNugDZtmgPmQOb7I0Z20yAk/X0hxsRDFn4ck7E?=
 =?us-ascii?Q?vmkePAxjALqKhTLSELT2+8/fbNlfrQXkVUb9rQw0LiBNZv8p8UvtUpNt9/Ch?=
 =?us-ascii?Q?kmopx1i9s7vsm1JNeApl3eyEU4C7hBHf0DR+TfKLRKfgvUSlh7hfQvHpHx9i?=
 =?us-ascii?Q?V+LBWlGSyDJdDSTkzL2UiORCDLuQkoKgwi2cibMFNhlE7RB6vLTaixr2Y/ol?=
 =?us-ascii?Q?4rTIEFV/uIfBVT+M6uSXUy8gC/wAr1XF/CT4MydzOY3LHkYW4rPkjpID1vwV?=
 =?us-ascii?Q?GITO/KZoncaXmOFl49cTXfL0XLzPZyZWAbF8y4sCdI2hSb2UYFD2Pa4OKujT?=
 =?us-ascii?Q?2IR0Ne3HavJktjDTV64UrOD+5JPE6T3Kx8byryjld/tG4KIuM/ozveFXXB8o?=
 =?us-ascii?Q?OdPh1KeepFZ8RtAezpXJKY5EBX5BgZKVqvSWHn+rOv6lJWUbsd5FZGNIjimp?=
 =?us-ascii?Q?fqfxN1z1XbChwaxX6QFY3mHoPegvLl8GO4L2K9lVpucEMm9u9MNk2BsElOQE?=
 =?us-ascii?Q?BhfqZutmW0YdR0hF4mAFT/tbOVirKQ2FX76qt9IvrZ3Mwq+LiaY6hAVew7zV?=
 =?us-ascii?Q?XlO5w9XUQ4UeiJya+eTWsvkJ0j7iP/bMgwdz4nGqhz3cNWUDDv7Rxg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:39.1781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f350bfd5-cefe-47e2-337a-08ddc0cbf5e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213
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

Tested with HangTestSuite and IGT reset/deadlock tests.

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
v14: Split out reset fixes as separate patches
     Add additional error handling for VCN and JPEG
     Update commit messages per feedback
v15: clean up and unify SDMA, GC, JPEG, VCN reset handling using
     reset flags.

Alex Deucher (33):
  drm/amdgpu: clean up sdma reset functions
  drm/amdgpu/jpeg2: add additional ring reset error checking
  drm/amdgpu/jpeg3: add additional ring reset error checking
  drm/amdgpu/jpeg4: add additional ring reset error checking
  drm/amdgpu/vcn: don't enable per queue resets on SR-IOV
  drm/amdgpu: clean up jpeg reset functions
  drm/amdgpu: clean up GC reset functions
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 90 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 15 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 67 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 18 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   | 79 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    | 49 ++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 54 ++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c    | 53 ++++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     | 16 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c   | 23 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c    | 19 +++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c    | 15 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c    | 19 +++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c    | 20 ++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c  | 11 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c  | 23 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c  | 23 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c  | 11 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c    | 20 ++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c    | 23 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c    | 27 +++----
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c    | 27 +++----
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     | 26 +++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 25 +++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     | 27 +++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     | 13 +---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   | 10 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   | 13 +---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   | 13 +---
 32 files changed, 575 insertions(+), 268 deletions(-)

-- 
2.50.0

