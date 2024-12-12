Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477DBE77180
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 15:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA7A610EBFB;
	Thu, 12 Dec 2024 15:52:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1mzW0B7g";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7E1610EA62
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 15:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQ0858fQzc/zJlqjspbkUO2EBxPtV2CJl5i9CZqeH7c8gnWU1Bb2dBMlNdjKjJNdztcsdEUM7EOzqmLM7jfAPC4gQsbviUcZjPC77MOKJNI1VLgG1TdfubD5Idh1XMwWujPnNTL4dz6+p7GoSrdAA25Ewt07g+u77kLx9Pil3Zkurb5mJUfhqCZQZBPHIm2iBGcJLSrwbHvaKxu919IDccs1ami97CFvzKFyT3fUKHv3JfQJDpMH4UJIj66kQuYyE2QBJ8elIEMNP0918Kc5iQCSC8/MVVSMIiJBEzaAS3+5TQLTL9qMNUlicPLYEq7LBsT+2ZIgiyRtgfmsRi13Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rrcb/8VsFlK/MicOkqPChj5CP4CFh0JdRO5+Sn5YX/w=;
 b=ezSmeifY1aAPi6Qv32BcJ4CznaNO2Fu8AzC9OiAxedM1cWQbvuQao86RmmKREJaLnq1GLIBIdQThyB0ZTPDlnXVQFJFtPB3aclmfj4SSfhvEjjqmcuMArcaQIM6t/+N5UZQAcG3n3iYmnwvzHF0cRiR5HZbMkV+eIMuTPYEzHD5D3GfVm2i0oxbRjz/LarnHle8OytbBFJx0mHvvDFKVZ7DJxfE28mbzKso8a3I6dVQpo1Xmug+M/pug38/RK2gGEDQiDIe5btBhV5ErNrQF0AVHtJXRdZtNL89+WInShP2WyJemvhCXFmAQe7mZN58oU1Pwg+Xmy+iyffRYoi6Bvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rrcb/8VsFlK/MicOkqPChj5CP4CFh0JdRO5+Sn5YX/w=;
 b=1mzW0B7gpoO4PxSpHbdYEAcRHh7QtsSkvEhtVwoCWACaJu00iLbN0q7Xj7ThF6cJt3nlSsFM5CdPFb1jpwZiyLAKfVL9DHopiNLKzaxBiXi8RK42a7gUgxuU51QlZ76JZ76fAfF3yRjPXI8ANnLNAs76/cULOPFfCsXeotunZX8=
Received: from CH2PR18CA0020.namprd18.prod.outlook.com (2603:10b6:610:4f::30)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 15:52:21 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:4f:cafe::85) by CH2PR18CA0020.outlook.office365.com
 (2603:10b6:610:4f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 15:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Thu, 12 Dec 2024 15:52:21 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 09:52:19 -0600
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v11 0/5] rework bo mem stats tracking
Date: Thu, 12 Dec 2024 10:52:01 -0500
Message-ID: <20241212155206.5030-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 0793553c-7bfd-4351-eef8-08dd1ac4f6dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1V0eFpXZys3U1pnQXFvNThZTzdEZ1N0cDVJYWNUWlQxQkFYVGRTVVEyeHF0?=
 =?utf-8?B?cHhNdDhrRGpEL0hKOWpEWnNZbjlqWTRISkc3VlNkOVJUYlQ0aGZXaEJDYlVX?=
 =?utf-8?B?ekg0Y055bmI5LzF6ZlRPNXBNNVJucSsvTFJ5UkJlME8wbjMyMDMzTWcycmxQ?=
 =?utf-8?B?Q0k4eW50S0UwWGJtUU1KMmpkV09FZkUrSjkraUxqSkFUb043dVZaOFhublVJ?=
 =?utf-8?B?RG9wMFJKMTJnT0JxNXl6ZGdMVXEwdnlhRno4NEFvYk91d3BINlQzcnBNOW4y?=
 =?utf-8?B?VjJHSkZLM0lVcEo2bDRhSiticnAreHBRNzNwMzZUUk82a0ZabUJ1TW1UZ3gz?=
 =?utf-8?B?dHUxS09NMWI5djlrSlA1QUJWcFFsMVhBMytzSDF5bThkUUU2bFZXVUJYTlFH?=
 =?utf-8?B?RXFHYkVIeFJoL1duN2h3Um5oWFE4cTZjRXJsdVJPbTByNm9RM0RYVEV5OE4w?=
 =?utf-8?B?eFlDUmFoYWQvaExjcU1BR25BNVh5b05qQXF0SDNPTnM0U2hodVNXNXBFVVh3?=
 =?utf-8?B?ZzNUYnVMMXVVTnNnMFVFVGRzZ0lJWUNnaURlM0dBQXNmRnJncXBqVkxsL08r?=
 =?utf-8?B?U3VwWElnd1MwTGlZbW1qUFNYVzdzT29TeXJhMExXajE3QWphNW9vbWNUUDI0?=
 =?utf-8?B?WGZqTjc1bmR6UkwxWS9FVkdrTzVVY1lHaGI3WDFXbEZodUVaYkh1SUdrVGQ0?=
 =?utf-8?B?Q3BIdVpNcDBMY1VZTTJqTUdjbDZIdmVqT1ZKTEJqcVM1MDEvdGRpdUtxN2dr?=
 =?utf-8?B?YkwyU0NxZXA5NmkwaWExaTBmSjZlMGdtM3pNaGpPNENPaFhEdm04ZjZKYnJK?=
 =?utf-8?B?UHFhTXlnVjR4V2NscjJrKyt6ZTZvZW9aaGxiZEJIVjBFZDhqNjd4ZGpHbTRT?=
 =?utf-8?B?SkVZRmJUWFRSbzFGVXVEck9uQTFmbFBaM3N4SVRadXF1WTZndEVZUzAzL3A2?=
 =?utf-8?B?SjZxUEQ0L1NPV3hRWjBJMWNFZlNyeU1oS21ZT0x1am13WkZ6RTkxaEVYQUpN?=
 =?utf-8?B?MkJvMEdyQ2VBVy90TGFPYzd4cllNQTNkOG9tU29EMHpucjZZYVUxdTg1NXl0?=
 =?utf-8?B?U2hIaE5acjYwTXVxaXNnNU5YdXgyRVRVbzFISStZSUN4bVNvbjVEaXRGRXdk?=
 =?utf-8?B?clZkZXpDd2NIZy9GdGRZY0pyaWpFM013ZEJGamFNY1FPWkFaQlZ3OENsRWUr?=
 =?utf-8?B?WlpDV3FZV004WUpzYk9GVVVMZVNzeFM5T3pPS1pCdDg2SjAxME9peFI4ZGFX?=
 =?utf-8?B?VnRvSUtvOE96WXJGdVl0YUkva1lLQnl2TFc0SjBBQVA0NTdnWE53V0FQbS9u?=
 =?utf-8?B?VVdObFFZdEYva1pvMWw1VkdiTDVucldHWFgwcU9rckYyKzhidVA2b2hORDlB?=
 =?utf-8?B?dC9xMnN5NEM2VmNxc3Y2bnhubWllYTZJNjNyY0dUbUNtdkN1TzJMRko5a3FJ?=
 =?utf-8?B?dCtOK0N4SXpsR1A3b3IwcVF4NzVhOHZCZWRidkpIVllYMnpxbHhUQkVRQVJk?=
 =?utf-8?B?VlFCVTgzMUdhc3hrbCsvN1d0UGlDOEErZE5Ba05QcjZiWDZWdnFFckNGaXZv?=
 =?utf-8?B?T3R5dFZmMk9pZW1QT21xYWtPeW5ONjVqTkU1YVJLVUh6MFVVNTlBdzVyMmcy?=
 =?utf-8?B?Vk1SdEFkYmtzL1Vja2RKWUgxdVNRWTZodFNJRTh3OENqRzNRVFZGaWhYS0Rr?=
 =?utf-8?B?dkpXV0E5dXFzSCtHdElTQUxFQVhDZkhNRkdrc0RzZEhaNERDMEVCTnAyTE1Y?=
 =?utf-8?B?VEhsTHNWNDgrNitHWW5TMDZEMkoyT2tScGd6TVRBSEVqaWk1K1ZvUGJHT3hp?=
 =?utf-8?B?TU0veHExdHhpY0ZTbnBLclFyUFF1Nm91VlpkMEd4elkrR0IrVE85WUk3UlpE?=
 =?utf-8?B?azFIYXdzOGpLRVBiT0NIdjUyeVk3OHdPNVhmZGZ0RTBoZkR0RXdiS0VJUjVS?=
 =?utf-8?Q?59IPeekRzx5A6o1Q6gLX+9yeZoQGTiS+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 15:52:21.3283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0793553c-7bfd-4351-eef8-08dd1ac4f6dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978
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
v6: split the drm changes into a separate patch for drm-devel review,
fix handling of drm-total- vs drm-resident- and handle drm-purgable-.
v7: make drm-active- optional
v8: clearify documentation, minor tweaks, and some bug fixes found
during testing
v9: documentation fix as suggested, no functional change
v10: change how gem objects shared via flink is counted, and fix a race
between fdinfo read and buffer move
v11: drop the v10 flink changes and instead hook into gem open/close

Yunxiang Li (5):
  drm: add drm_memory_stats_is_zero
  drm: make drm-active- stats optional
  Documentation/gpu: Clarify drm memory stats definition
  drm/amdgpu: remove unused function parameter
  drm/amdgpu: track bo memory stats at runtime

 Documentation/gpu/drm-usage-stats.rst       |  54 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c  |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 111 ++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 208 +++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  26 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   1 +
 drivers/gpu/drm/drm_file.c                  |  23 ++-
 drivers/gpu/drm/i915/i915_drm_client.c      |   1 +
 drivers/gpu/drm/xe/xe_drm_client.c          |   1 +
 include/drm/drm_file.h                      |   1 +
 include/drm/drm_gem.h                       |  14 +-
 16 files changed, 289 insertions(+), 188 deletions(-)

-- 
2.47.0

