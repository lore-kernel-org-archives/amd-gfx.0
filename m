Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76676E7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 18:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDD2E10E054;
	Tue, 10 Dec 2024 18:00:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4t2RoGBV";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20BF010E054
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 18:00:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4sCFRNXePybOCNS5fAFJG+F2FODnWrbb7Vi3YfVS8sN2xn6bcliB4wEEqbsbIuml7L1I6lSn5/jSuV3voa8wKPn7NrnpVOJNFGJU0R2PgBVym8puH4GrurVgJ8ttoYQGBu4clsIkRLnUCcikIXnn0ytq9heX44NUlNe+V1FPoZ4/MLo6lJa5oRG6m4xtO7pCNbMbI56BhkBoeiLvBsuItDqLrxl/hXbDoiw9rMRlN1zkzr8TaEcC16aVpZonGfT0r6V4G76lXzYbDzK/xLlr7YgNFkGUQ7KsBCKT0jaLsSpWHvAhoOGuFs7f7LrT4PaurgkijnTNibMamfCCmzbUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhWdkgfIGiBEh3jtV+TR4ZIDLigZBS7Lohv5nzy5EEc=;
 b=nyuR3ZnQSQXq/jZX27jokip0cVPQGNgcgt27xi2MM1DBa2jKg7vIw6TZV7QxPcvZ6lxFDxen9CFAxSEduok+GRjYQO7ksKdKGqyY//8Bw0XD28dvYk7ZHr9KiSHiWs67uP36Yhfso1M4Q4r4955nNZxJfrGxMDfhHE50Ih2uXn6saFAABiCQ3L48xDp3PbCdE/MOQsDVKwKEL5Tqj1rWGic/0Ypo54gH71h4tIyWmuyjRG703YZWutsusdG9RSBBRew/RZa4qZlspTDnDaX1UnXACV7NBkHWykAytCXZxRUUqKpqf191U7O3XAcMiMKbRx5+pMY6PWnqxIO8yZfelA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhWdkgfIGiBEh3jtV+TR4ZIDLigZBS7Lohv5nzy5EEc=;
 b=4t2RoGBVKWL6LOvuTLOXqjF94WJc/mUZ7g9aSgo/DkZ+zdjWAbCYm6LZ/bvWyZwMPG7IstnUCUIKRXmAe29rYfHc6K7eSOLkaP01CbNnz53AoZYyjgZCz80I5fBzkP9EgJK/MS6j8RY+WjdNNDLptGI+PbvHwELcIF0ivviR6Og=
Received: from SJ0PR05CA0031.namprd05.prod.outlook.com (2603:10b6:a03:33f::6)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.23; Tue, 10 Dec
 2024 18:00:04 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::2a) by SJ0PR05CA0031.outlook.office365.com
 (2603:10b6:a03:33f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.9 via Frontend Transport; Tue,
 10 Dec 2024 18:00:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Tue, 10 Dec 2024 18:00:03 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 12:00:02 -0600
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v10 0/6] rework bo mem stats tracking
Date: Tue, 10 Dec 2024 12:59:33 -0500
Message-ID: <20241210175939.2498-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc601dd-cb57-481c-3b98-08dd19447924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEFSWUtMenlGalpVdXhLUisrVlFRdWI5VGZoRXBibU1kdVFTZmRGNlZZM0R4?=
 =?utf-8?B?bTIyVjBoUEhmNDErTCtJY2xQK1lPdWZ4Rkc5THJWZTJjYTN0RG56YllRemd0?=
 =?utf-8?B?d1k1Q0UwMHowZ2dyOGwvK3UvcmlIRCsyM3VqNzZ2UGo2ZWM2dUJ6bGh2Sld2?=
 =?utf-8?B?OXBzQW9JRjRLUkpXSVNHYzdvZW1CYXY0VTN3b3V0T1laN0Y0VG9JRjdLT0FB?=
 =?utf-8?B?cHdCd0RGekdjRlV6NmdmVnFqOXI1d0RnYlViZzFsSlVEbU1IR3VVaStxbGk3?=
 =?utf-8?B?Z0EwWlVXNit3Ri9HQWxjOXpqRHNVKzc0QUxsWWM3OWpwRmNzZzR4M1ZaeDV3?=
 =?utf-8?B?bHRJa2xDdjZGdVcwTkhJcW0xMkJoS3pKUHJXNm1sY2pGM0xjZTh6a0ljNnFQ?=
 =?utf-8?B?QTkxcVpSVFk4aXp3Nm0vTUpMZVZxWG1uOUYvLzFEYisyTkcwR1dvQjlTL1gx?=
 =?utf-8?B?cGpIbmZ0aDZxQWJQeEhJZ1VFYVFYTnl5ZVhEU213dkhUV0NpbnJNeXpGT3dp?=
 =?utf-8?B?TUp1aTM0RFpmc1lCcTRRbzdzKzhhQndsLzkwZm0velAyM3JmbllzMUxzSWpw?=
 =?utf-8?B?Z2prUk1TUlBlTHk4SVBJSGIwSzZONUVFOEo3TWVaWjFTc3NucURudHVwSVZQ?=
 =?utf-8?B?WVRuS3ZuTDhmS2FCMmRpVUVYbjF2ZVQ0RGRuVXZEVXNuUEVBekxuSTkxYVZV?=
 =?utf-8?B?NWpkczNNbTRJN2Ezb1hYRm1CNkJQVTdndWRKbXRydGY0em81OGZNYXZuNEw5?=
 =?utf-8?B?ek9LNkxDRlEyWmxvM0ZkYlZmUW9uekNwZEJUdEZHZUhNTWQ3NU5YdVRpck1O?=
 =?utf-8?B?VE9sZm94L0dBbWxaYWx0OE1xYjZWWGgxbnBNbWhxMXZGSSt4a1dQMVVKZDN6?=
 =?utf-8?B?ZkZjTGVFcnV2VzRMZHVZSEpVZFV6SDF0T2RKUURET1hYUlFyOU5lOGtxaE9o?=
 =?utf-8?B?SFBKLy9RVUN3UklKa00vbGx0Nlc1cE1FVTd1VlhIdjdaV1UyekF4L2ZtbDdD?=
 =?utf-8?B?MUV0Tm5qanB2eFZ5ejEvUmZKaDZUSkJsTm9halVRRkVKeVJTb1FEYy9OTGpZ?=
 =?utf-8?B?OGsrUkEyNy9xZmlwNDkvZHJ2a1A1b3RmR2I5US9SdDRySUZTRUZESzMyYnY2?=
 =?utf-8?B?ZHVOZVBRSG1xZC9MMVdpQzlmYUhKWnJYVHk2ZHpzU2xMTzY3NTFyOE1DMDZN?=
 =?utf-8?B?Z3NEZzhrZTJLK3hWeXk3blFjclV5NzFuSGI2Sk9NM0lrM2tKTXZFVno2U0VQ?=
 =?utf-8?B?SzdMRDJEcUtUd0N4WVJWNU1wZmJVeDZyaXpHV2IvWk1CUEozWkRKRUFSUnBw?=
 =?utf-8?B?NSthWE8wc0c3RkJMUlRyUWpQWFl1eGpYUjhLaThseFRxYmZvcUpHekc3Q2x4?=
 =?utf-8?B?TlRsaUlQb0dBZmtnVHdUYVBhS2x6cmFaazFQTzJkUVZYNUhnTU05dGxPSHFn?=
 =?utf-8?B?Rzkvb2RRNmpiVkI0UXRZKy9JU3hRSXd5QWd2c1NwcURodEhQSWRaMm5yYlVK?=
 =?utf-8?B?dVl0WXF0ejFubXA5N083S0JkeXcwTmgyZU1LdGxqT2JHWTd4RnFHYWxxbkNx?=
 =?utf-8?B?UEtjaXdOZ1YySXg4RmdLYUNwOHJIdXhhMm91ZlA2VHdEUEt1VFBuZksrMEx6?=
 =?utf-8?B?cE5DMGNxVlBvZzJiV08wRnlxS05NdUE0eTc0RGl1YVpTbURkSHh4MCtmaGpO?=
 =?utf-8?B?NXp2ZmJJU2NQb0hZSzcwTWI0aU13Qjd5c1VwaEwyM2ljS3Rhd3grVGV0U0ww?=
 =?utf-8?B?SHgwSXB1enRDcHNTRFRhaUF0VGVXV2x5VkVQbVRpOU4zZ2prbHl4N002dmxa?=
 =?utf-8?B?MlBldzRtSTZGRURyWUQyd3hRUlBpRXlFM2lIVGN5U05jeHJvSWxDV2Y5YUpM?=
 =?utf-8?B?WnlsejlUUmhnYkEwRFN3UXgrcS9yZlZLNDJ0VkJJODNKM0QzY2FyekxKVGxh?=
 =?utf-8?Q?1JAUgsw58eR9BFwC5SFEn/kRv9z24str?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 18:00:03.5647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc601dd-cb57-481c-3b98-08dd19447924
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987
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
v10: change how gem objects shared via flink is counted, and fix a race
between fdinfo read and buffer move

Yunxiang Li (6):
  drm: add drm_memory_stats_is_zero
  drm: make drm-active- stats optional
  Documentation/gpu: Clarify drm memory stats definition
  drm: consider GEM object shared when it is exported
  drm/amdgpu: remove unused function parameter
  drm/amdgpu: track bo memory stats at runtime

 Documentation/gpu/drm-usage-stats.rst       |  54 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c  |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 111 ++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 196 +++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  26 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   1 +
 drivers/gpu/drm/drm_file.c                  |  23 ++-
 drivers/gpu/drm/drm_gem.c                   |   3 +
 drivers/gpu/drm/drm_prime.c                 |   3 +
 drivers/gpu/drm/i915/i915_drm_client.c      |   1 +
 drivers/gpu/drm/xe/xe_drm_client.c          |   1 +
 include/drm/drm_file.h                      |   1 +
 include/drm/drm_gem.h                       |  26 ++-
 18 files changed, 298 insertions(+), 189 deletions(-)

-- 
2.34.1

