Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E595BC5B555
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5592410E3BE;
	Fri,  6 Jun 2025 06:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cLjjxyyR";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B6B10E2DA
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jz+5wYg5ZDYWpvFWZEd53kKJAEOYwlP0DfU3zCCZ5+aZGf5+rpKKIJAC12xMdBCDE9Id7StsOw981GzRyGCcFL8o9LzN9sqn2i2gcqQ4o/DRnWm9OXjTeCzWfDv9upfjjLFGf9joYHAdJrWnDQlA2oXRseg8Hjhf7UHEGC9ijbtoBc8wdjL3Iqs+HpgoWr7fGLAetg7Mg9tx7NWQ8R/cXoNsFfRgtcV8KfXQ/7qd3dm7NHtkvObdcfRDfGWzNXiYqRMAoICXUtuC8sHMCYOThuJHvyyzD9g6LVfuCeXPJYgbj4TGwuK5nSTvg88XzIuC20c4d2FjDbzb6LE24eJAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugtkDDJc8JEn3RnNPT4cq3xu/HQs4PDUJCX8k6nGbWs=;
 b=wyu4pM3x6kd0R2eSFjqbbLf5O9x6+3teTYwd8E6Xji8VZqrcEWmsjRiJARER/+T7pGWC7FHiNGNkLC10HuA8rZFl4F1XePgd+JWAZbnGns9w6gONDalFIPcM8sPluvMLO559rVjO4cpLCgKRodLmjRZ5hRMrECK9JMRuGVtUu9NEjXvNM1UtKYy1Ckut2QrbkrJYjj7ZKwdeexHMXbO7eaHAbmpxKrdjHU1hC484Xh8S3u7sbstLLI44FCO+Xh7uzhpPKqAMagvRLWBVE2sbq+1SplpqepRMog37tNHFJ2tPG+T+GPK6CwPklxooYhKarvNbYMN0gwb8xGGLdLMiPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugtkDDJc8JEn3RnNPT4cq3xu/HQs4PDUJCX8k6nGbWs=;
 b=cLjjxyyRHtCkTxu7kRckkfRU+gwvyiJdq+x/yqxMcnNA0VbHsTJzdCd40ohpyQQPBfQsRSR6WWozQfGBMc5IyAQfhl/wVxCtI5kLp6NOItpGX4iUYfDA5xcpXum9Vtd5RKC/yXdfjwOv942srwsW7FeSsNcHCQ13wPAAKaKgZGQ=
Received: from SJ0PR05CA0089.namprd05.prod.outlook.com (2603:10b6:a03:332::34)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Fri, 6 Jun
 2025 06:44:10 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::c9) by SJ0PR05CA0089.outlook.office365.com
 (2603:10b6:a03:332::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.10 via Frontend Transport; Fri,
 6 Jun 2025 06:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V7 00/29] Reset improvements
Date: Fri, 6 Jun 2025 02:43:25 -0400
Message-ID: <20250606064354.5858-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 815b8419-1f8c-4516-cdd4-08dda4c58a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkpSL212bVU3Z1hWMHN2ZURSNk5KZnZ2YVd6cmdOK09PRmtsRGpmOVZXQWpS?=
 =?utf-8?B?a0xYQkRtOW8zK3kwVlNKd3hiWHFlcDJtUVlsQk1LSU9CUWFsU1poUVdOaFc0?=
 =?utf-8?B?N01nVmx1YWQxQkNNb0oyQXVuR2JIWlBGREJZSFlNSWF2dlJGRENBcHIyZHNM?=
 =?utf-8?B?VzBuV2lwTUZQcnREbEtVOERMcFBqVGRlNWNFQ2NPRmM5bkJzUHJtWmxBemxL?=
 =?utf-8?B?MU4wWjlkQjNlYUpQRHRodDY0a293N3FKL1lUNXVpa0tLQ3ZheDh0OCtwUmNa?=
 =?utf-8?B?ZTZGdnFUNlpwQ3B2bGFRd1hFLzI0QzN3SWpUYy9OL21SR3ArNmx1WTN4SUZu?=
 =?utf-8?B?M3FDVlFkNDVGdWRQSFdXa0o0YU1TVVlLWjhyZnUvZ3JjaEdJbkVWOHFJQlNt?=
 =?utf-8?B?Sk1vdllLam5PUW1tSElXdC9LeWluSEFONjJ2cjVrbjAwTFpaNXVpVDRMRitH?=
 =?utf-8?B?RDU5ajZHOExYR2ZSNW1nbmdJTGhRbWRRTnJDdS9IM2xsTWZ1QllqczVZamty?=
 =?utf-8?B?VVNFQmdhTitwOUJGTk1nZUlDV0paYXU2dHREbEFlcGxHVXc5Mi9EZ0xWVTZX?=
 =?utf-8?B?UWRRMHVmbzJ4YitLRE92YUFRcVlDVG5KL1VPaFl6YmV2dGd4a1NqVncxN3hv?=
 =?utf-8?B?clNTOUdKNkdFSlZtYkRLTHVmWWZnc3Rja2VEdXBSQzM3K3FEbmFjYlNXcmVW?=
 =?utf-8?B?K3k4dkxiQjUxSkU0MnRRREhjd2VJVXQ2bzA1NXBZQWZ4Ny9WMEpFRmFwL1J0?=
 =?utf-8?B?L2J1M1kzOGZMeEFJZEw2UmRuZERBbGdJYk9XdEdNVTJCTFVJYXRxUXdPc2tL?=
 =?utf-8?B?L1BqOWpFbXFCTmxGTGp2R2ZVTFRVOWVSNEdjR29oVjU0eFYxeFljUWt6Z2xk?=
 =?utf-8?B?WjVSaHROYzZaN2RKaDZkaE5vSHpITWwvT21kcC9rc3RrSUdPd2xvMkd1MzdE?=
 =?utf-8?B?b05NTWpkLzl6Z3VMSGdpeGlxV2I5ZjhybUc4TXluUnpoSU9CSDJSbGNPQnVo?=
 =?utf-8?B?LzczM0lTc3JqQm1Gb2pIaFQwZFJFNDdLVXNOemthQ292U3B2d3RraDc4azU2?=
 =?utf-8?B?ZXZreEhwN3p1QVNSL3JFbkYvL2tJVEMxVElJaWRsS3hNVnRrT25qWmZ0S0do?=
 =?utf-8?B?bWVqWVRxSE1KS0wwaVNMb0lITFgzOGNwR2tXOHVSRGh4aWl6NlJaSE5PMSs5?=
 =?utf-8?B?TDYxUktsUHowVHVNYUZaTWloNTlGOCtGQWFJa05samJlQml3dytBM3V2Tzc3?=
 =?utf-8?B?eWlKOXF5R0lHNERicXRSRVViT2xTMlpncjYxcG9rRkJDK2JOZkxlaFhiRnM0?=
 =?utf-8?B?UE1Eb3Q2endxWDVYbHBudVR0K0JWTWpETHhoNDkxZUdJcDZ0QndRSUtyYzdS?=
 =?utf-8?B?aUx1anI2NERXaUtlQ1hKazF2VVFBdERjYVB1WVd1U3FxRTN1T1UwNTkwNXNZ?=
 =?utf-8?B?VWVlMy9qTTVLY3ovT3k1Tk9yTmd1dkhZVnBQVlhQUVEwQVlyb3luSm04Rzhr?=
 =?utf-8?B?UG5RV2oweWMvK3RwZVNSL1dCUGJGeTBFTVRhVWVrZWZRMEtBcUFzc3BHdG5R?=
 =?utf-8?B?dFlRSkxpdzA5SEZ6Qmt1MDJ0ajh6UStmcHV0OU1RUlhRRjRYKzdkNjRTM0xk?=
 =?utf-8?B?alpBZmpCeFlLSndFLyt0TGpwc3RxQTRvbk1DQzdqbnJuQVMxSWJqYnU1YTlW?=
 =?utf-8?B?ekpSTDcvUU54eVR4QlduSlRyZzZ3bHNLTHZObTZqOG1INDdiRlBKS2ZLeHB3?=
 =?utf-8?B?eDZmZUpFSE5oKzNKMVkyZXVOV1J5UWVmK1p5eW12cEFpVEZGMUlRTmViSmZy?=
 =?utf-8?B?RURLVUFoZ1o1ZDRYTGxBZ1VLeklONWV4aE42ZjIxY1lzT0poaVhsTDVXaE05?=
 =?utf-8?B?ZXYzTUdBLzBYTGhGc1UxbkZtVHArS1kyYkJmRFoydWJSZVJBUGpJanFqUHlL?=
 =?utf-8?B?WDZoejVXbWNoa083aUtqTHBFeGhEek9PakJZR2dCcUFZOHNGa01UdStHZTNk?=
 =?utf-8?B?ZXNTc2duTFNRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:09.0947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 815b8419-1f8c-4516-cdd4-08dda4c58a4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402
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

Alex Deucher (28):
  drm/amdgpu: enable legacy enforce isolation by default
  drm/amdgpu/gfx7: drop reset_kgq
  drm/amdgpu/gfx8: drop reset_kgq
  drm/amdgpu/gfx9: drop reset_kgq
  drm/amdgpu: switch job hw_fence to amdgpu_fence
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 120 ++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  59 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  27 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  35 +++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  66 ++++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  61 ++++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  61 ++++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  71 ------------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       |  71 ------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       |  67 +++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  23 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c      |  21 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c      |  21 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c      |  21 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c      |  21 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c    |  21 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c    |  25 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c    |  28 +++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c    |  21 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  61 +++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  33 +++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  35 +++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  22 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  22 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       |  19 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |  20 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c     |  20 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c     |  20 +++-
 32 files changed, 710 insertions(+), 400 deletions(-)

-- 
2.49.0

