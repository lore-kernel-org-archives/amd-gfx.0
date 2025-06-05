Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD58C61CE7
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77F2810E233;
	Thu,  5 Jun 2025 01:46:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hatfn/cK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32ED110E233
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngMq7g8JhhbOgrm7DwI6kPFq9IBNldoFEtACZ0kTZ5i3i5aVqWGuqsEqh0U8k0Mhcx8ia3q7WXDLa2fpGCRxhY/IsYoi2i479fWEf8y3io+gOP7mme7CX6gU05qD+oPT7n3zaEpLc3RTkEDVHEbQGI5oJkp0C3+JFirsCSEQijA+pmkbkN7pj0EqS+ePJ4lcWTjl9EqhIbA71It0euJcf2oYtnlnFoO3zi6m7AfXyTD+9RQglQRkNkdvE9+voUOjKextdUSO5RCA9P81DHjyVpcRF4bj9Xp8Sh6rvR8v7323wrqaoxrdmcbsP1nJqJ5allLYsry2U+HDeI6Qr9m6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rQ+ZDeexYnY/xiW7a8/rYX7kBbzB9mM0ApX4RNLNO0=;
 b=Nt5MvbdFZAqukm3p+POQ6dnU+eqe8v6SXy95FJxBIR+uVEMSNX8KQE5qLqPUex9GeS+ZOvE5KTvVlewYEEM1nSCTO/KzbvkCfPrzYDdvqztr4/HXE11W3rSsvpI58g7FUZ5yKrFZT9Tr8EAyCcMrHKKIDkZbinPMUIoyYuu4rMJa+K1AXMjYfi5nDyNgrKLGZ9ixH4QAq/6ughXAo2dGuEBcT9nClTE6RP4/dJUJGT9/SVfQaFSM6tQyN/6CMQkKvgR74qstJHhqTqixGs/RLrb0Yh8H5dEC8h18H8YoHLakgcFmvqUpbhggBim/XBaRbWoWdFE4v+znkdekKzNbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rQ+ZDeexYnY/xiW7a8/rYX7kBbzB9mM0ApX4RNLNO0=;
 b=Hatfn/cKXuGp/s2vi+T9NdI4wHmiGgt+kl00rz6FXgzOisXunytcGC/lLZT/CS15/HWxHlHizTDoEAjw7VriasYfn5qst7WbfPNjdsisirsKSy9BxSIabj47yJI5IwQemACRvOK/Jqnt9BxJgUn9z+oV6E95ApYQc6AcnVOzKfE=
Received: from SJ0PR03CA0122.namprd03.prod.outlook.com (2603:10b6:a03:33c::7)
 by PH7PR12MB9104.namprd12.prod.outlook.com (2603:10b6:510:2f3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 01:46:18 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::39) by SJ0PR03CA0122.outlook.office365.com
 (2603:10b6:a03:33c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Thu,
 5 Jun 2025 01:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V6 00/31] Reset improvements for GC10+
Date: Wed, 4 Jun 2025 21:45:30 -0400
Message-ID: <20250605014602.5915-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|PH7PR12MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 9932b6e9-2819-4dae-ef17-08dda3d2c3a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHVOUWYxTTZlUlF3UHlpbVFDQ0RlcHIwcnNCUy81OFJBeFdMQkZOZUVKMCsr?=
 =?utf-8?B?NkhwTlhwZ3dabUVDQllmbWNjT01LTlppS2RhUXdTRkVsWVFsbWpuRm5iTTQx?=
 =?utf-8?B?Q0YwbmxMd3FSbWpteU51cjJ6Vkt3bnJUbmdXQTU3dDBrQndBMFhndlIrUW1s?=
 =?utf-8?B?Q1NHa2xJOE1XdkJLZEtMaEVyTDNXcE1VVXlURzd6OXhaZjVRYmowQWhXMmw3?=
 =?utf-8?B?aW90NWc0ckx3dk5IaVpPc0tJS2Jzd1U0amIxekZ2cG0wMDBwVXNFN2loQXRQ?=
 =?utf-8?B?TzdRWUNEMGRtZUdpTDgrOHV2ZGo3R2xmVEJFVndrNGJSZkl0MHVNVHpKeWp1?=
 =?utf-8?B?ZkI3WThUa20vSDNJT0ZWMzBkSnFmakphZDMrZ0l4RUxUNHJCc3pYaEVQNVM0?=
 =?utf-8?B?Q2xpTWg5eDNYZ2wxai9pUkplbjErRjNZaEp3VU9iK0IzeXBPcW1zeU5qTVlD?=
 =?utf-8?B?ZS9RY3l0bWlyenNNTGdGYkExZGR1Q2ZlcFNKeGZmQUhLRUJ1S2ZPZzRJSWZ1?=
 =?utf-8?B?MGtjMGNINk81WjhVaEVpVlJFMVhQc0NPaGdiQS9pSnV5d2FXWWJXT0FlcXZw?=
 =?utf-8?B?V3JqSGNqcGNWaGdueDVxVWd4eTM3dGQxTk9xL25nYU9vWDFFaFphR091Y1hF?=
 =?utf-8?B?NFpXclpMS3Y5cFJ6N2ZMaTFxK2RYYWFDTGY3dGpqVG5vVjJHSGlaa29LSlBi?=
 =?utf-8?B?czU1SEc5by9pNVNwSS9oVmVQRFNCZk9xMnFhcUNxaTBzNnZvK29MZ3UxQ3hs?=
 =?utf-8?B?SDU5ZHhQb2pqNHZDbDJUL3F2Q2xsMzRrWGdGMWc3My9MMFlLRTZSUkNPQlVa?=
 =?utf-8?B?bmdGU29kdUpzSkFLY1dJZnRvRjZTYkRQSWNwekJkeVFuVTlwY2NDeDJ0SjRU?=
 =?utf-8?B?aGsxMjNQLzZaQ0pWTFR4ZzFqTnphOFBNNnIyaWJJZ2ZrWXJhd3BsOHdoOGFP?=
 =?utf-8?B?VVNwOEM0cGFWVjVaK3pBMVE4YnkveEZRWHkzZjliWk1oUEQ4aGhGbm1KODNQ?=
 =?utf-8?B?UGZUVGNoMiswV2x6WjVFWTdySHQySi9JN2dkendySkozNjh4Zk4rUkRndFkv?=
 =?utf-8?B?dkd3aU10a1VISGE0Tks0T1JkNi9RUXlwQm9Vd2l1UlRucURndFczUGRMT3d4?=
 =?utf-8?B?VXQrRkFhZmJ2ODFDWXU1THhmSHpFbjJvV1JnMUJHblFUT0VuR2RDUTJ5U2Zv?=
 =?utf-8?B?YVdTOXF2MEYrN0dwaHN2NEcwdzhSRUJtcTlKMTZWVkoxQnJZUVV2a1JhZy92?=
 =?utf-8?B?QVFSbGpLK2R2ak9QM3RCYXE4TWFyVEZEMVJITTh5SnFqWE5oYko5QVAvTmli?=
 =?utf-8?B?dDRwUnhramRYWlNncFcrTGVFN0RBZHk2Y0pyMlduRWU4SWtpWUhkTzlRakVj?=
 =?utf-8?B?RXVuZDJaNnQ4SytXdHp4eFZvczUvblQ1NXMzVTZXcURLNXQwZ1pjR2VuVUww?=
 =?utf-8?B?aWpWYnVUSXh0NUdhSWlxTzE0M0pRZ2ZuZDNsQkNSanJjWHc1L3ZVMm1lbGFD?=
 =?utf-8?B?bDZxT0RWSWdyWElQTE1vbmVPdFRVT1lvWk43UlNTby9JUThQUTBnNzQ5bDRs?=
 =?utf-8?B?VDVPOFRiV2lnUUE1d0lSaEpySmx6eklVcUxhS1JhcWQ1eWVOYStVVlgxa2Ft?=
 =?utf-8?B?bzZTbXluWldYdHVCRGhsaVpSR3IwWFBJcGlSS0g1Y1lIckRnWXpkZE5jdFRp?=
 =?utf-8?B?NUFmNHZnU0tWZUxxaXl0SkU0eVdGREt1OTExZ0pTdDhDYWtJOGFPdW56NzBT?=
 =?utf-8?B?bDRpUDhPYzV3Q0g1TFFiQ1J6QmVYSDZoTDJ3cTZDSkp1aHE5cnlyekFvajFO?=
 =?utf-8?B?RzlIUi9FcngwQ3hYcTlzbGRuVFBlZktRM1J4MFkyb200bHlnL3ZLdGxaUkpL?=
 =?utf-8?B?VzBJWkFmZnloeEN1bkRqTDhidTkxL2RFNVorRGhvczlZZHZHdWtIaVdmS3Bz?=
 =?utf-8?B?ODVQKzB5cGF3R0c2ZU5abDdNaTIrcFFEcHNJOXVQNHpLa2RqSmg5VEVNVVRn?=
 =?utf-8?B?ZXVyUkZCQkRZdzdTSWxnVTMrZmhMeEtDOGFROWlGRHpoRmdIZ0djQ25KSngr?=
 =?utf-8?Q?HfuTll?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:17.6645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9932b6e9-2819-4dae-ef17-08dda3d2c3a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9104
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

This set improves per queue reset support for GC10+.
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

v4: Drop explicit padding patches
    Drop new timeout macro
    Rework re-emit sequence
v5: Add a helper for reemit
    Convert VCN, JPEG, SDMA to use new helpers
v6: Update SDMA 4.4.2 to use new helpers
    Move ptr tracking to amdgpu_fence
    Skip all jobs from the bad context on the ring

Alex Deucher (30):
  drm/amdgpu: enable legacy enforce isolation by default
  drm/amdgpu/gfx7: drop reset_kgq
  drm/amdgpu/gfx8: drop reset_kgq
  drm/amdgpu/gfx9: drop reset_kgq
  drm/amdgpu: switch job hw_fence to amdgpu_fence
  drm/amdgpu: move force completion into ring resets
  drm/amdgpu: track ring state associated with a job
  drm/amdgpu: optimize amdgpu_ring_reemit_unprocessed_jobs()
  drm/amdgpu/gfx10: re-emit unprocessed state on ring reset
  drm/amdgpu/gfx11: re-emit unprocessed state on ring reset
  drm/amdgpu/gfx12: re-emit unprocessed state on ring reset
  drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
  drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq reset
  drm/amdgpu/sdma4.4.2: re-emit unprocessed state on ring reset
  drm/amdgpu/sdma5: re-emit unprocessed state on ring reset
  drm/amdgpu/sdma5.2: re-emit unprocessed state on ring reset
  drm/amdgpu/sdma6: re-emit unprocessed state on ring reset
  drm/amdgpu/sdma7: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg2: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg2.5: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg3: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg4: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg4.0.3: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg5.0.0: add queue reset
  drm/amdgpu/jpeg5: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg5.0.1: re-emit unprocessed state on ring reset
  drm/amdgpu/vcn4: re-emit unprocessed state on ring reset
  drm/amdgpu/vcn4.0.3: re-emit unprocessed state on ring reset
  drm/amdgpu/vcn4.0.5: re-emit unprocessed state on ring reset
  drm/amdgpu/vcn5: re-emit unprocessed state on ring reset

Christian König (1):
  drm/amdgpu: rework queue reset scheduler interaction

 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 45 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 13 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 60 +++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 97 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    | 31 +++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      | 31 ++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      | 21 +----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      | 21 +----
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       | 71 ---------------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 71 ---------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 51 +----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  6 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c    | 12 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    | 28 +++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c     |  2 +-
 31 files changed, 286 insertions(+), 331 deletions(-)

-- 
2.49.0

