Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502EED70DEB
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 18:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D479B10E2D1;
	Thu, 28 Nov 2024 18:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EXWzvlqW";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD55D10E262
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 18:54:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfAFShcxzCoMGVEaT1KTKF9ek8TpRGgBR6zylH0gEPavU7TRlu2ig2YJI9Jy+h8m7XOvcC7LjLVEMjaUGQyJ3al9naj0w8b/cYxLBb3rSrebYYnoeKg2zdJlwH22LYmdk8XTQrbsoWyhnb72PW5AcMxiGsKNOcPgQ9vu0MiT0DAqcX5MNzpgOeWOijBM5HlQ9DCdV9ilpRSvRmGlRNrgoMtOYAyLzib1pSqs+NgakyQ3dnVnJwwrTTffYKyYc9jSfbctcDhaKIT9jRJvuUvEC+akaRN721z441z280mzo1KcLyGjXxzFdkZLYiJPx1wgIk4PIUr18xUk+2UCmks9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQD39B7IufnCVDH9+9eOXLkUyaRxT6OoOdEksd27UKc=;
 b=xviNvN0tS6H/M0771OEe3ITgbFqjkSN1UXIqqRgczwDR9myDBwtvFFPqS2GYWb+UFx4vWUtS2XSI7ax2MCOVLA8hlXuif5PVw/q1eAfALQVda4mS/4upUdZPBByV5sNZuBdwiPnPWZXE+HaveTJ9j4u1WZ7azc41N6WnFAn/RlUNp2nKlZuu/1ythKdQSZBXrvjmSsZkWEbbZxHyJeIomMx5ZlLT89VhqwsYvtuVwkhrhHt1+fXnft0Pmg+tfK7oziKsieNK1XUYKWMVwC4UBrc74T/uA4mFecCt7HNus6Yv4zNvdT9Q1hX14Okk+29vVKNlamk1fPjUxJ4mHB+QRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQD39B7IufnCVDH9+9eOXLkUyaRxT6OoOdEksd27UKc=;
 b=EXWzvlqWOTViZL/huTGyYKGGJjlPnvWwAtqjBYmsCGaPiWsvM6OY6MydteLxjScldsZgyLo6NosKIWofVIqrUWGolEvrjY/ELqXpr9OuZwhx3O8yRjzJRT1aXYhXLjZPODYQVRPUgG9izmdTmtzxkBfeJ/6TSelHN2mgmT3paWY=
Received: from MN2PR02CA0036.namprd02.prod.outlook.com (2603:10b6:208:fc::49)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Thu, 28 Nov
 2024 18:54:25 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:fc:cafe::3b) by MN2PR02CA0036.outlook.office365.com
 (2603:10b6:208:fc::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.19 via Frontend Transport; Thu,
 28 Nov 2024 18:54:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 18:54:25 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 12:54:24 -0600
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v9 0/5] rework bo mem stats tracking
Date: Thu, 28 Nov 2024 13:53:59 -0500
Message-ID: <20241128185404.2672-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: c6db675f-7e65-4f59-41c9-08dd0fde143b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0R2MUdGTFQwS2VjdHIrcHJkZGlSRGMwVEVQTlV2aTRlSU1zZFRBVFB5c3Ro?=
 =?utf-8?B?UjQ1Y3E2bjA0Sks1S0RPaExFOE5PL1VLK0FmRFUxVVdOaG1kWE5LTWdjdVYx?=
 =?utf-8?B?NVE0NUpYTkJwc095OWRvMU1KUjVBV210WVJBSmloUUswZTNJSnE1bnRlZWEx?=
 =?utf-8?B?SzZCMTRzSk9vYUFERytkSWJZK2hRYURXUFVhUnpWNm83ZVhuUFNtcGxPN1lD?=
 =?utf-8?B?Q2t6RkJ6RWxYbFJWMHByWStIYWkvKy9mVi9DWEo5THVtTmtTcGVQcDA5UGlY?=
 =?utf-8?B?b2dhV1p6eks5OXVGcUF6OWwyTDNNaVRFcGpnNkpBcFNRMmpwTmswSFFOZG9W?=
 =?utf-8?B?VXRSM3N1L24raitMTE1OQlUzdU5Yb1JQQzVSdGZkWXVmb2swd3pwMExvVElh?=
 =?utf-8?B?TE51cWs2b2NPckdvSHM5bXppOE9jWXBaOVhSSVYzMXNhdXJwakM2Ynk3WWh0?=
 =?utf-8?B?SnoxZUZPbXI2R1FXWFFuTXZnbUcwRmJZd0R0YjBlNkRsZE5YWnBFVjRZMk8v?=
 =?utf-8?B?ZVdLb29tb0JBOGZYWmVDZ0N3bEpYbmhMeFFxNHBvbVVMOUJyWTEwM05aaW9D?=
 =?utf-8?B?VjV2cEhMdkxRM2FBbzZiOWM1TS9keHpENTlWMkNwTnBIcXI3eE5YeTdXUWx1?=
 =?utf-8?B?U1RhS3ZBT3VVSmNQS3dWWUVHMWt4ZENNWnhpc0d4dGhwYzM4bG9pcW9jUDcy?=
 =?utf-8?B?dFdwU2dqTzJFMEZIOW5wOEFIK25VeVBvMC9tZjdtTDBYOUFyTERsaUx0S1dM?=
 =?utf-8?B?alFPZDdVVS9LcW9maEVvZk05UjZxV1lJbk1Ea1V4bmxBZFNISWt1SzRTdlp6?=
 =?utf-8?B?WmV6OGtmbmxBL2pjQ3lRTWQ2YTBuNWUwTUZRT2RvSktuL0dWM2pQY2ozRmZV?=
 =?utf-8?B?RHZ4ZnE2R04wWUlDdFI1YVZ5K2ZYcnU0NE8wc1JQQVRnUVY4WFByZnhqbldY?=
 =?utf-8?B?elZMWGpJV2Q5cjI5YW5YUnoxNTN1VCtWaHZ3L09yalcwNVN6WEd6RGdWRWU0?=
 =?utf-8?B?ZHMzY0RrWjA1dWNlRDFMMEVObm5wWGVnTFBrUjJYcDRCa2lNakpqUXFac2U3?=
 =?utf-8?B?bjNwYkdZeUFhZGY4VnI0d2FoUjU2RzlUQkdBb2xnUkd4MUk0eExrQUsvdVFy?=
 =?utf-8?B?a2t6Ym1mU21PWkZ6cHF1UUlhZTRlemlsbXhyWDlZeHVrM05UOU8yN3B3Q0R6?=
 =?utf-8?B?Y0Nja1ZxcXVNRTdheU5yKzhiUVZhU3c3bUV5TERocnM2T1JHbFpodWkxNndx?=
 =?utf-8?B?dzRxaWdERkJLMHFweHdwMmFCSzU3dU1iQVQyN3FhOGxVTTFmc1BmUStJTWZp?=
 =?utf-8?B?RDdYR3A2YVpVNW0wV281K0w2OENTUHQ5YlpqeWdHcVZGNlZLZ09GL2NOM251?=
 =?utf-8?B?Y3F2cG94cWdwbmh6U0V1M3FveHZXL0JTWDRUVS9oOWRuelk0dmxwR2FaTkZI?=
 =?utf-8?B?dU5Ma0VOdUtoMmJtM3FlZGpFWmgwcmNIVUVrYUdEWEZhTE1HMWE3cGpXWWFn?=
 =?utf-8?B?THdhMHFlSFNHZEYrenNGSnhhenVKT2pNaFVwUDVCTUVLVk9OeWp1dkw4ck95?=
 =?utf-8?B?cmE0Mm9DS1ltN0xDVXk2ZVc5Tjk1Y1FxRGhIZ1ZxSVIyTU5jcVVNNmdQNEs5?=
 =?utf-8?B?bk5lYkY5K0FsWlUwTDlHKzgxVVZRVFlYcEMzY0tIMTRLaWVvbXkwblpicllj?=
 =?utf-8?B?UGhqbHRPdXRZcTJzdjA4dDdSbmhxbzZaNDcrdlQrVkZyZXlzMWZqcE91RmUw?=
 =?utf-8?B?d1l5Nm1VWC9yTmprTithYkZrT0pJSnNhRDVab0t3THNsYnlBc2xLL0xuQ2N6?=
 =?utf-8?B?RDVybGZwVUZYaWtUY0tWdzFxVFEvV0RhTHgwZkp0QzB4Zy9iYWJ1VHZsdFFh?=
 =?utf-8?B?QUsrNGFlS0NQM0V3Y3dXU2thUnJUeXVmbmo2UndDVHJEQkY2MWJhZGZEQ3hW?=
 =?utf-8?Q?3rYA4ufqBD2SkJpma/42lRdOHaxdNLNS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 18:54:25.2281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6db675f-7e65-4f59-41c9-08dd0fde143b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366
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

Right now every time the fdinfo is read, we go through the vm lists and
lock all the BOs to calcuate the statistics. This causes a lot of lock
contention when the VM is actively used. It gets worse if there is a lot
of shared BOs or if there's a lot of submissions. We have seen
submissions lock-up for seconds due to fdinfo for some workload.
Therefore, rework the implementation to track the BOs as they get moved
around.

The amd-only visible memory stat is removed to simplify implementation,
it's unclear how useful this stat is since kernel map/unmap BOs whenever
it wants to and on a modern system all of VRAM can be mapped if needed.

v5: rebase on top of the drm_print_memory_stats refactor
v6: split the drm changes into a seperate patch for drm-devel review,
fix handling of drm-total- vs drm-resident- and handle drm-purgable-.
v7: make drm-active- optional
v8: clearify documentation, minor tweaks, and some bug fixes found
during testing
v9: documentation fix as suggested, no functional change

Yunxiang Li (5):
  drm: add drm_memory_stats_is_zero
  drm: make drm-active- stats optional
  Documentation/gpu: Clarify drm memory stats definition
  drm/amdgpu: remove unused function parameter
  drm/amdgpu: track bo memory stats at runtime

 Documentation/gpu/drm-usage-stats.rst       |  54 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c  |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 111 +++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 179 ++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  20 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   1 +
 drivers/gpu/drm/drm_file.c                  |  23 ++-
 drivers/gpu/drm/i915/i915_drm_client.c      |   1 +
 drivers/gpu/drm/xe/xe_drm_client.c          |   1 +
 include/drm/drm_file.h                      |   1 +
 include/drm/drm_gem.h                       |  14 +-
 16 files changed, 265 insertions(+), 189 deletions(-)

-- 
2.34.1

