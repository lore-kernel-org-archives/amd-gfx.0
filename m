Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C28C71136
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7804010EA5A;
	Fri, 13 Jun 2025 21:48:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f8wCkXWg";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4337210EA5A
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4pR9coTDJD2X5LHzPrIGclayFZJUuleW2J4TQMkYtAPYkZp8RD9wM/ky2N3AHDW493fmO04V7T9gqdiwmvjyifYxoktjyAXAWNBzF1aIOupKmJCAsxperWdTO6BNGeObXEVZ2KpWtdd71OUUyCXQWE8vn/UcnWZJMh0bAwuZYhrhxalCmjgXKnnMr/OyV4fW3efTbFGoN4So5PuBTreCVb2OAf8t7rKmbicPiMLzVxNwxkPYqCtVSd2iNvSeIqZH1rJIBUpaZeILbCHqqcY16o2Xdo7IM6XvQPEih3h6iMoUvPjSxrIHsNPCMk681l4HBB6OejJUeC2EMbKCROSQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgwPLujmu+0TlJPwraKXgzIUGwwInSFYHeuGP8VmNVg=;
 b=lVRv8dz3AZcA+TsSV/2cFEx0V8sdMb0eiGTmMqr2Q195lbunxUwyMA8hD2Ti1n8sZOCUOn+FmrxZc7XQazQkTvRRQSMxy25Jy7OXCbTHtrks/ZUP+kEeuTr4Ujkh0SV3iYsb6mLC8qc+8kQYcY4G3jIhfkyOaIfYOtN33I9vExkodxxZaItOJgG5B/UV9YXTvbozRnCC6PCQE6HUp3MwYrq5WR3bnYditWhDgCI8bWHF+EDT2a0L/HxYQKn8XVq17L2/Hsv5EoGTKSqUX1Cz7tQkBJDLJt/WqKSKDLrnVDV8003+YdpGjIcxSLnFqM/e61RpI7O1iAKvhzfMg9lc5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgwPLujmu+0TlJPwraKXgzIUGwwInSFYHeuGP8VmNVg=;
 b=f8wCkXWg7nBCIKd09qQ5fnjHhJLvBAJU+SqoHlYhiiVaEdssQxYrqqMuJUlSS63dWz5dbMyIp6p7UrCZR2GfN2HSd3lP0CgvvulwlxsxiLcdBauT2+yuHaZFNzWb1LzUCl6Lqg8cYJqEimEdferFOfpTVlukLNcDwFkVaMiT45c=
Received: from CH5PR04CA0019.namprd04.prod.outlook.com (2603:10b6:610:1f4::8)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 21:48:04 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::20) by CH5PR04CA0019.outlook.office365.com
 (2603:10b6:610:1f4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V8 00/27] Reset improvements
Date: Fri, 13 Jun 2025 17:47:21 -0400
Message-ID: <20250613214748.5889-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a5e643-3a8c-4f43-25f8-08ddaac3f8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3hVUXF5NTlWV0FYcXJ4R2l4dmlZc3pmZXZYWGNyYVYwTWdXUVdYT1JyS0JM?=
 =?utf-8?B?OXpyMzZTbHo5UW5UYWJrY2JrMjJsWjRYZUtWVk9BeEFBRHNkOEd5ZGd4djds?=
 =?utf-8?B?TFRTbVIyZ1dQQWU4NWZQNkJROTlBSXQ5YlVDWXBkRmxVRmRBUXlVaU4wMWta?=
 =?utf-8?B?NHFudmdkRit2WStRSjRzZDVJeWN4TTVaRHdjbmtJWjlUQ0krRmZNdUl1bTRx?=
 =?utf-8?B?b3NGWmxvOE5tbnVxWFRrQXFscGo5NGNaTHhGZG9JelRodURTaVNhM0FqaFYr?=
 =?utf-8?B?L3ZMbFl6SjdLMUJKc2dVcVBSb1hlRTduaFVEcVRQTSs0LytLczNYc0xxRzZj?=
 =?utf-8?B?Q0E0dkhGZzF6SEVOUWJjQ2JjQzArUVZlQjBBRVM1bFJsZE9EdnJTRGxqRERU?=
 =?utf-8?B?QzhlSkNEUHNxdkR1VXdNdHdKcnNoRHI1dU94TE5ET0dBbjViNXZ2NkVFNkxr?=
 =?utf-8?B?ZGhtTGc2T1hSRldiWUtuRGRlWmFsNUhrVm9hV0doNy9jODl6bkVWYkZXbyt5?=
 =?utf-8?B?N3lmYjRSNXVGQTFvWlFid280ZUNWaittWFhpZUZLM0l5YkJobDN1LzF5K3R6?=
 =?utf-8?B?TC9obUFnK1dTS1NtaWphTEtPSWhvdXNjeEFqWmNzR013L0Q2M0puWHNPNXc1?=
 =?utf-8?B?S0UvNHdGVlc3ay91djFBcmlWQjRiSFN2aW1TNGRhQWZ0M1dWdW03Z1FhdmZS?=
 =?utf-8?B?L3QrVFZSRy9wdWtqdmZnOFJlOWdHdkhNVGM3YlNOMEIzbm1lTEE1bCtNN25o?=
 =?utf-8?B?em1PQWtIeTduUkhBYkxTMVpJSFE3VDY5eW80by9hZDB2UUUwcnBHSGNEVWlF?=
 =?utf-8?B?N2JobkdnYjZtaGZ6WWlJbUU0cisxczhVUk1rb1A2R2paay9qeW5USVVCRUtW?=
 =?utf-8?B?TlZ6YmxyVzJMbFdmTFB1cDFqeU5RbndwNitFZ3IvbnVJMWhSWDExYm9UaUxt?=
 =?utf-8?B?UDAyN2RJK0VtZjBYL0lYQ0xGTjJIZGMvVmREdHIrNmNOZVZsRzBkcUlrR2hl?=
 =?utf-8?B?Q3VsSGwyVFhrcUZEdlFVUEduSU5YVzJpYkJnTWM4V3RJMEViTjhydVZoelo3?=
 =?utf-8?B?dzArOVBrM3VER2h5ZE9ELy82d2VFV1pBY0pDTGFkVXY1WU1uZkhBOTRlNlFM?=
 =?utf-8?B?R3BqYTVhaDJZUE5EempTZUxIdGV1UHpmR2ZiSWxjcjNuWE45TFE0NHlZNVRa?=
 =?utf-8?B?YURFd2didmRGTDNCWnNscUJOVFN6eG53dDkxWVFISE1KRnU3NGhkbWNERUI1?=
 =?utf-8?B?cVRRM2FsVlRnVTR5TW0xY2ZqKzJBSHEwRXZWMWFYZlNjUVFuUFpRcnp4QlVL?=
 =?utf-8?B?dENTYVBlZ2tnb1VxWU5FRkQrdnBQcVFtcG9RU2d1WVdOTVkzV2djM0YrSENa?=
 =?utf-8?B?enpWN01Wdm5Xb3hWMzQvWTZzMGNlYkNsNGF0R0k5bkNVY0p2bFNzbGtvMU5F?=
 =?utf-8?B?RUFhd29WR1ZQaTZBZzM3c3BaVkpLUEV1TEEzcUtMN1pOVkR1UkVkc1NpZkVi?=
 =?utf-8?B?K2R4TklIUzFMZzhOK0U5Ni9LbnB1UW81VnIzL1RoUzRFMEl4MTV2RC9ESVd2?=
 =?utf-8?B?d1FGRTdvcmZOcDBtazNXQUUzY05Dbis0Rm1DeGFCcEptTFpOU21mOFdjQ2p1?=
 =?utf-8?B?b2VCMC9ydTZ3eHMzbkJNOTdnNUM5OXBmMzR3dTZHellXZGVjc2VqKzYyL01j?=
 =?utf-8?B?Rms5cWsvY0krcS9xcUZGRDdLYTJLaFlsdmYyeTFSNHRaQ0lMOGF3LzBhOEYv?=
 =?utf-8?B?NVBURXVSbVROakEreE1Sc2gyQnNBdDRZM1Y1UnNmRUJhMEd6V2FmVXRTQ3VG?=
 =?utf-8?B?ckpOYmpTNkx5b0RHQ1h0K3poWGVUSjEzNU1nbXRpSStKVlVNc0dOSUJVMEpi?=
 =?utf-8?B?ekMzZEg1QWlERzcrKzU2WCtyNVdndFdZcjA1YmI2OWhtczJ6QWJTcDMwK1h0?=
 =?utf-8?B?QjBPL0JrbTFLR3pPVldORjdLbVY0bTN6dmtHNzZQSllZVDloSS9HV0lVMWtt?=
 =?utf-8?B?K0NVSHY2M3V3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:02.3379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a5e643-3a8c-4f43-25f8-08ddaac3f8ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078
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
To that end, in order to make sure we actually restore
unprocessed state, we need to enable legacy enforce isolation
so that we can safely re-emit the unprocessed state.  If
we don't multiple jobs can run in parallel and we may not
end up resetting the correct one.  This is similar to how
windows handles queues.  This also gives us correct guilty
tracking for GC.

Tested on GC 10 and 11 chips with a game running and
then running hang tests.  The game pauses when the
hang happens, then continues after the queue reset.

I tried this same approach and GC8 and 9, but it
was not as reliable as soft recovery.  As such, I've dropped
the KGQ reset code for pre-GC10.

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

Alex Deucher (26):
  drm/amdgpu: switch job hw_fence to amdgpu_fence
  drm/amdgpu/sdma: handle paging queues in amdgpu_sdma_reset_engine()
  drm/amdgpu: enable legacy enforce isolation by default
  drm/amdgpu: update ring reset function signature
  drm/amdgpu: move force completion into ring resets
  drm/amdgpu: move guilty handling into ring resets
  drm/amdgpu: track ring state associated with a job
  drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
  drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq reset
  drm/amdgpu/gfx10: re-emit unprocessed state on ring reset
  drm/amdgpu/gfx11: re-emit unprocessed state on ring reset
  drm/amdgpu/gfx12: re-emit unprocessed state on ring reset
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

Christian König (1):
  drm/amdgpu: rework queue reset scheduler interaction

 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 126 ++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  59 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  27 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  36 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |  10 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  64 +++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  57 +++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  57 +++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       |  21 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  23 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c      |  21 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c      |  21 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c      |  21 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c      |  21 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c    |  21 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c    |  25 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c    |  28 +++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c    |  21 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  60 ++++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  32 ++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  34 +++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  36 +++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  37 +++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       |  19 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |  20 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c     |  20 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c     |  20 +++-
 31 files changed, 748 insertions(+), 207 deletions(-)

-- 
2.49.0

