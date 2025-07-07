Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D334EC83F0D
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F77110E526;
	Mon,  7 Jul 2025 19:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uIKMifWt";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F0B710E514
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iv4zSyYVSjZ8ca6wgQ2hiMRnkcwApJP8C82tdp9S3zBsGu7BTpw8i0mHDWHl6bbhRYnKwSEQU3RRQvg33jj7F94VPU65S4UFbQWFU+IWiZlOo5Ahr9Zn9GPyLx0kNAT9akWciZvVIFUrmkhmeQUVUelMNBqxuw1wQCFJHxS3xgTrIYjUAb6ix1klA22kKPOzU2HOKGZ7Ids6oi6b6ddjNVHDea6/+te08Sg3zYAXsWvsfLpawW9H+ZlunffruFgJX7m7423VhHL10E3dlLsBxxclfoY0YZa8d27TODOJKoK1t19nhLrFHBSYSPgiVYSwo8iFYVKOwtyYJXbzR0D7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NH10KrkT/EMfRmKYuZ3IEtbTh2yD6jsQrLaBKFzwZvg=;
 b=aeLBdxjgGq0fv+SAIzN9vuY32Y+RKO5ZIn+Ze11tC5reYGw6n18a6K0XYjhVcTndLDo8AvWXZzpzFgNOgqeqPUa8zCuDHXom5IkMPZS0wGw7sswQUsPvUoGwsEmuWsQktVqrx9fkPYsSm7AWqGKbSnAcMHyBLF1o6C7osIeO55OW0J2r8vXH7hiafQyeP0WnODodCdyH1+c0adP3u1Y2nSWy7VLSxJkhxnYDkLNxKJxKK8rxwyT6J0EkK972cVkHr1PJIg0dl6VTVlR9Pd+AsCNHD5jB7wSkOpcn2VnZ3C+YhB5PpPggqcW2kXmus103e6LXsYosKuj0BeTZj9pJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NH10KrkT/EMfRmKYuZ3IEtbTh2yD6jsQrLaBKFzwZvg=;
 b=uIKMifWtNNqFl8kU/Ayj61tyb1CxkG6DHahG6NoxvuB6DMCteT7QfxYOr8cXDAbG4dkEGyHReCXTVcLE2yHsbGjGqIoYhMkyqHJI+YovovH+Q0+pkvf7xz9qal1q0HeWsQ6uGs0xTkUyw6C4XxFoD+MQYGfLID8GFKl9IZZxMFg=
Received: from DM6PR11CA0025.namprd11.prod.outlook.com (2603:10b6:5:190::38)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 19:04:10 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::4) by DM6PR11CA0025.outlook.office365.com
 (2603:10b6:5:190::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V14 00/36] Reset improvements
Date: Mon, 7 Jul 2025 15:03:19 -0400
Message-ID: <20250707190355.837891-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|DM4PR12MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f7e42c-568a-4bb5-dc4f-08ddbd890dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OVHnEuLpvXIg8oU3g+Bt+uQ+uzsyjTY2nQAZiEYuLzSHrxKVQSArEzQu7A8Z?=
 =?us-ascii?Q?BzO7BzcQYOkDDUjX6Cfdc33N3HsJei3QycUI+6i5YzzqBtUonUBKEkSAaABq?=
 =?us-ascii?Q?NJasRSOWYDboVhw3ZI/yp/ZS6z3N0YG8DkZZa45uDRCk6jNyyop6Mu3+qABh?=
 =?us-ascii?Q?3TOSsasZl+o+4B1YQDPHcws1611mHYub5rvIgLtDSXg8QHWXauYuTDZPZvyd?=
 =?us-ascii?Q?rBNNh0/UzpC5PhAdry6+51V5gMI4lSYhse33E+ZR4Lmznu+1jwAEdFYxO7yc?=
 =?us-ascii?Q?TFU9VuyfT53v7A+WiM8jYjCuM2nNjXD0brWownIKYhVl0U49lKGUlfPOkR1L?=
 =?us-ascii?Q?4mJI/T2Rhv/+sIfvau6ypnoXOsRmBzvpeIePCRXOY6NtLhuYuPpE6hEp3Oip?=
 =?us-ascii?Q?DJ2cVGL4KdtcAjue3iqHBc8dK901xA4V3JB4RpgrNwIi2BkM+XAb5OXUjSRI?=
 =?us-ascii?Q?r+5LoGN2/CLN2YvxCxMJq4ycyPwRHmuj3MTB4tI3TRBPpA0cLDOGnSvDe/ZI?=
 =?us-ascii?Q?XuoMP6l7+tLMAofkNDC8HrbEalk80zzRVO8v8CLVnXtcp3Dv30aYk5CDojaV?=
 =?us-ascii?Q?dur2ImaFJDmHO7w8uD7WNuNH4QlEXWbMB3giLUyVD3ErQpxmfJ+tCDrR42sz?=
 =?us-ascii?Q?4pUa58Dl70NAKAH7gymeVJByg2NJLpCUvNx/JEzhHpitBAzHbi7Yk3egTzlQ?=
 =?us-ascii?Q?jjkyqACzoGH3pgzuuud6iEAbSzUYnR91BqXTNMdyaAjSwFAMlOygjVf3gWbs?=
 =?us-ascii?Q?UgAmkeg8I4BVNzuDQ/T+U3CMhCCyl+WhjTuR5ASfWV5ijVfGZ/FMoOALSeRu?=
 =?us-ascii?Q?s+eLJU6G0QWKDgQiqMYTyvGU7D7QdbvZ4H6gLeVw08ErLvXApyC2T+L4swRz?=
 =?us-ascii?Q?c4/w5hnoxxGrW/peKGJ1l0TsX81nMMtCqEqZ7D+n47l5k5QiJMiDC0nk1K+S?=
 =?us-ascii?Q?zYHAGjgbqVUeLdooRWMZXFSRWY4PQBS0UtxnuA7lYp5hEZvXlSFZ9XAgEFFD?=
 =?us-ascii?Q?zddE+RmFu4xSJHERATq4xUNbaFkSE7wGv4ewKfkEWA2D+KmBUDgJQL3LDVlC?=
 =?us-ascii?Q?wM0g0xWsy77AtCxlppqK0rdB8nAN+I+c9oup50Mtsbq5MangxlEeH9w3jqdi?=
 =?us-ascii?Q?KyMePmTaVnx7926R4yUR6lQUGwmm3GLksz7HjqGbLkLfiyT6EdzST26vD4WX?=
 =?us-ascii?Q?HWXKGE2zEnpcyK9ZMiLD6IESxMIuJdd0dB9Cc4oEKD5KGXIEckNf4ajURBhD?=
 =?us-ascii?Q?XahjdVJHsQLvUVWqQuXxkkVgb09fbaIDZ/ruxYKqHBUs6/wtc3XCBW3TL4YE?=
 =?us-ascii?Q?251SJgwP349U5u0+UaxXsdQf8rNQjW9BadoczpkQRepj4d+jw11RXhF8xMSt?=
 =?us-ascii?Q?73swm0btcAsPSI1cFcGrNBHdj3w1LEaWDv5nQYC134ceSR+UAjdvSop8d6HT?=
 =?us-ascii?Q?6cKGfhXOM9t3lDoExp7JK5D9Qy8A9HcJVA6mzVN7iDOGcOMc6jtBYg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:09.6053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f7e42c-568a-4bb5-dc4f-08ddbd890dd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424
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

Alex Deucher (36):
  drm/amdgpu/gfx9: fix kiq locking in KCQ reset
  drm/amdgpu/gfx9.4.3: fix kiq locking in KCQ reset
  drm/amdgpu/gfx10: fix kiq locking in KCQ reset
  drm/amdgpu: clean up sdma reset functions
  drm/amdgpu/jpeg2: add additional ring reset error checking
  drm/amdgpu/jpeg3: add additional ring reset error checking
  drm/amdgpu/jpeg4: add additional ring reset error checking
  drm/amdgpu/vcn4: add additional ring reset error checking
  drm/amdgpu/vcn4.0.5: add additional ring reset error checking
  drm/amdgpu/vcn5: add additional ring reset error checking
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   | 76 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    | 41 ++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 35 +--------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c    | 35 +--------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     | 12 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c   | 12 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c    | 13 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c    | 11 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c    | 13 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c    | 13 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c  | 11 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c  | 17 +++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c  | 20 +++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c  | 11 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c    | 17 ++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c    | 17 ++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c    | 20 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c    | 20 ++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     | 15 ++++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 14 ++++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     | 16 ++++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     | 14 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   | 10 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   | 14 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   | 14 ++--
 32 files changed, 465 insertions(+), 230 deletions(-)

-- 
2.50.0

