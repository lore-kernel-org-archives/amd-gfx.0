Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBAFC7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C69CE10E403;
	Mon, 23 Jun 2025 16:14:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yP1uL8qg";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EABD10E40B
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApQmxnSVg3ze7TyMXYEKASbitZXNpyxH04AuMp4Sunvuu1rPWKEQgt5bgLbAy5zOQXg19Si4sNoWgTROfz0ddQYhegGiKFBgz+rQPBC4Eeb0A3edr4KYy9WPNHsRRMQwW89evBRtcKYoeeii5Sr0w5cbHl5nWDH+AvfzjWZq2Rl/1oM/3CG/U9MrkZbLMdAoJujhcBEK62KX2hYd2GRoisI9tq1Xl2vNfsjd7l4tYUrkAs/uZwfp/MuZgYrCUi96et8Ah0XK7BpEgJvv99DJxo8INILiyOoXJMajJN1/a5+tz0YSZI+LJBiLD69mxTDfwKRP2bxrHDqvrQYmMZTh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUktYshbD4y4n/iN19+ldgf7JAKrgxvgWVFpMZGfpNU=;
 b=JZI/sfNZVS10Re+jSTbeDgC/noz8AjDtcNzT84M6NeWSRL90urRztruEI3pnTS+spPUeOrgbedL1qoR3MMeY6FdI0SrPeO4yGhJYIAk3quwcJADgGQTCAeDYdPcoFOTP/M9AtnqsP17aKXsdh++0BDtzgzvm4wId2GWtZPlsp9PUoDd8iGRiTV0+Hd9963aJWJkyWhVP88xuoHg+YJqzaC2Bz3VZ00HgATJZFn981R+HkZpn2J7ZKfaw7vZFhoSAuNq9aO1i7BK56KSGZYBs+nTji/ka3ZVjlzY+cNgFIJ9QB0uB5fXpcTW1H6K9I2I9EIALodViLXYTfv7kIpiVwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUktYshbD4y4n/iN19+ldgf7JAKrgxvgWVFpMZGfpNU=;
 b=yP1uL8qgBlP/Ccdoh9C86tWjVhMw7Z7ST364l+hfrRzK7iS+QokvbZQAEgopacFxYmQFJ41lyg0lr2sOdvuvE9kq1Vg05D+EJ820tyQdbgaWgEg2OoXhQZ+uER9PEA6sT+wI6JWbWLBbT/tmeJSw/VpXMd7RGM7ve09MN7lTa4c=
Received: from BL1PR13CA0214.namprd13.prod.outlook.com (2603:10b6:208:2bf::9)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 16:14:54 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::32) by BL1PR13CA0214.outlook.office365.com
 (2603:10b6:208:2bf::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.15 via Frontend Transport; Mon,
 23 Jun 2025 16:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:14:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:14:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V10 00/31] Reset improvements
Date: Mon, 23 Jun 2025 12:14:06 -0400
Message-ID: <20250623161438.124020-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: cb099626-3550-4287-b27e-08ddb271168e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVNzSWpZNThuTEwvMk9BS3QwenRqM0t4S0JaSE4rMEhvU1Mvc2pNNUp2Q3lI?=
 =?utf-8?B?cEhWYVBGbGRqMEh3UjlNM256TnBscVQ4UjNQTlJuWmcyZGQzWGhtQzIreDNm?=
 =?utf-8?B?dFpRVTFxRElDRmdGOU9lVmt4b24wU2d1U3F0ZWdrQ0NYNC9TZnR5L1dGazd1?=
 =?utf-8?B?M2pOME51MWI3N2h4M0VUOWVsT2RmRHRJMys2UVVIb29JdS9aNlJrNG1xOHNu?=
 =?utf-8?B?b0ZFYTJXQktFazR4RVV3eEE4TDlnNFpiWUFFc2V5V05xMmJpU1VtQ3EzZEl4?=
 =?utf-8?B?aWJVOHdGSy9UMyszVmdhRENuTWFDWGhLTWdCMG5kU1dvQk9ocHNNU0wwaTF4?=
 =?utf-8?B?MEhpbXErY2l6M3NHYjBHMmtFUm84VW5iM2ZiSmZwcVVVRUpBN2Z0dVR1d1du?=
 =?utf-8?B?b2c2a0llbG1uWDFqUTQya0JzNXVVOVl1MW5qR21MYnF6NVIvcmhiRENWb3ZT?=
 =?utf-8?B?T01SVm9PNWVPOURYNVVGWTVBRitXSGp0MloyWVFTaUZEWVZ3cDd0bkw4Mmwx?=
 =?utf-8?B?THMwWUF2ZDdSNHJDM2pXUDBwOWZzOUhkeWhta2MybnF0bkxma3N6dURPVENk?=
 =?utf-8?B?MTlGdWgyZ1JpNG1XaTNkblM5T1NQT2tFam9QMUgwb0JvR2xQT09jTmtvRkk2?=
 =?utf-8?B?Wm45a3drR3Z2Yk9JNWpwdjNDclFITGlvbVpXSUtobmxqTEJxS3dlQ3haSFJU?=
 =?utf-8?B?Z3RFeDRIQ0ZCN2ZVcERheHFYTEM4YVkrdEQ2R3krcWMwU2ZYS2Z4Y3lXbUE0?=
 =?utf-8?B?Nnl4V3JiMi9CQkZYYUZMNUpLdTZvYklreEFFK2ZuSXhRekQrRXJXaFR5Zkt3?=
 =?utf-8?B?aXZnaGFFQUo2U2tJd1hYa2VtNlhWcDZuVHVVVm1mcVI4K25OWHVETzZ0M0pz?=
 =?utf-8?B?SDJ3SXNjQnJlU3ZtTEZUOHo2NHFXcXJPSXlDRlB1eWt1V2pxOVRaNEUrSTUw?=
 =?utf-8?B?NHVrdURaVHFJRXVkUlZJeENWcjZ0VkYxaStVeWVJbERIcnlGaDg4WHhrcW9C?=
 =?utf-8?B?NG5aNVBUb0pIWnRyajg1SUp0OHR3WmFOZDJjYUtaZzl5dTJ0QXlqWUNOaUto?=
 =?utf-8?B?VVlJbkYyOVh4U01kSjA0aGF0anIva0Q0cU44aWlzL0d1WDB0bzh6Vk1ibkw4?=
 =?utf-8?B?d2xBUWJJbzJ5MjNBOTNRRy9wR0gycW9PWGhscC80TnJ1UzRhK25rU0d5TEp4?=
 =?utf-8?B?QmJsRkg3Z0ZEdUFmN3hxNnRLN3VWRGNxaEhRbk5lblBBMzVnRlBrR2J3SDgz?=
 =?utf-8?B?NXgxTDIwUjE3cGlVdVBWaWJjUTdiZzFrSlNsaUc3NXdLZVExYkhaakFzcFdt?=
 =?utf-8?B?QjA4M1ByTVhrRjdaQnNBbEtWRWdqYmhwM3BQZnBPcFU4eTFybTJwTW5EcWNX?=
 =?utf-8?B?aGowT0lBVFFHUWVma1Q4d3RiZHA3MDNnaVQvbkk5Q01hQ21tSHBQT2d1SFRM?=
 =?utf-8?B?blRRZ2RONUY3Smt0TjJ3UHN6Z3YvcDd0SFEydmVwQnVHOW9wVmNESU5DdmhG?=
 =?utf-8?B?MlBDL00zc3ZSSmQ3c2tCRnZBYVRucmNDM2E1TW5jTzROSkcybTBueENrL1Nx?=
 =?utf-8?B?UCtRaTJ6RlJkK1F2dGNSRVd3MW5oQVQ0SFZLN0hpRHA4QmtHZFYxeXdWYWpo?=
 =?utf-8?B?YzhCWVZaSDFHczZIUDNXL3NreE9PZEV2bFBuMjN6T0JUVjk5UEJyczlhdVFh?=
 =?utf-8?B?ZHFwaE14SzBKa09vWXlBZDJ0MnhWTEVYcW8wSGt4dSs3UnRJWXcxSjVDMDlD?=
 =?utf-8?B?dzVDdWVHSTZjQTBKMyt5b3cxUnAxMWJCd0h1N1d3NE1UdkpSQzQ2WnQzWi85?=
 =?utf-8?B?QmV0UUEzVnVRZ3JQYW5iL0lPMjhwbnNib3ZqdjBYelNjczQxYzZtVjR2dWQ2?=
 =?utf-8?B?ekRBNXptWmxuY2taTVVMZjVKaTZyUWxPMmV6MEYvR2o1dFkzanRuSGVTMDBk?=
 =?utf-8?B?azZ6V21GWmtja0JHcjVXaTBaV20wQVdEckdPbGo4aVpTUTYzVVc1SThDdW1l?=
 =?utf-8?B?OGxOVnFxU093PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:14:53.5553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb099626-3550-4287-b27e-08ddb271168e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094
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

Alex Deucher (30):
  drm/amdgpu: remove job parameter from amdgpu_fence_emit()
  drm/amdgpu/sdma5.x: suspend KFD queues in ring reset
  drm/amdgpu: update ring reset function signature
  drm/amdgpu: move force completion into ring resets
  drm/amdgpu: move guilty handling into ring resets
  drm/amdgpu: move scheduler wqueue handling into callbacks
  drm/amdgpu: track ring state associated with a fence
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
  drm/amdgpu/vcn: add a helper framework for engine resets
  drm/amdgpu/vcn2: implement ring reset
  drm/amdgpu/vcn2.5: implement ring reset
  drm/amdgpu/vcn3: implement ring reset

Christian König (1):
  drm/amdgpu: rework queue reset scheduler interaction

 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 133 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  20 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  48 ++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  59 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  27 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  |  17 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   |  76 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    |  42 +++----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    |  33 ++----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c    |  33 ++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     |   9 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c   |  11 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c  |   7 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c  |  11 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c  |  14 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c  |   7 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c  |  49 ++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c    |  16 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c    |  16 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c    |  25 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c    |  25 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  12 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     |  11 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     |  13 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     |   8 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   |   9 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   |   8 +-
 33 files changed, 566 insertions(+), 215 deletions(-)

-- 
2.49.0

