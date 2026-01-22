Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DF4D3EE92
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 17:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C5C10EA0F;
	Thu, 22 Jan 2026 17:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MaI0jyZf";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 141DC10E0D8;
 Thu, 22 Jan 2026 17:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utCEyBYsbrf7kfv9kp/irASDY4vGnNcmT7HdR+U05FfQ0h89K4hMqTCZ28OWPigN/x8K67hdXpj/xhKZV6WOC5ut+u51ilFkah+X+vUocwAh/vAhBbLiS6Mc1oEfVoHZMj8duuRvvcTaszgwVm+rZ94PMJxnLspjP9E/2rh6v4gMuyaM71BYtj3lFH1yGKNyDlNEj3uSVMdqKoKPjVVPfjC/uRjPa75uotIccsRZgTU++U2iNz3wQePNdmivENUgZl/yco8bFzTLNAAz+elWpdnPS4IAGyRCdIbw0TIwMcKog7BOrKB2AjVR8KQw40HwN8B7laTuQMGqqBxuI4wkJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAzFCQhXyamwyuAIS6MUOB1KMinoCEb0o+7WJlI6zpQ=;
 b=q/fXag1eZrE+yOpan5/yDV9LgDOaKmeldPoqtGBkvxNEOs+2powUiicGh9FTXZPFP7F+z+v0T19pUID6W0HQ4MjjjjzSscI/q/ajwgVqO6j6cbnWVgaX7ibXremaGwgNTOl5ZMvBCQN2xSao1ts0tYQH08WEBO1w6UpzgpmMjabzLJ2l6TAE/4KGHVqwTrZt5A8hzY3tjeZE4owI5QGbQa2mu5jb5go1Pnd2knxmTRU75NsHz/z0CGOD6gwD+wZQI4jNND+G6tFdoR7YSwgoFabxvMA+epHQGfUthz4eGykoyRY4RWiwTN0FUeMZXQoQqJtKQDLyF7QlhL7FTnImGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAzFCQhXyamwyuAIS6MUOB1KMinoCEb0o+7WJlI6zpQ=;
 b=MaI0jyZfPrzpRapPUmASDyLEQryPxkXWsom5NJ14p7N3Oo9BcioxwH+0g+Nb0sEmpb717Rl9Dg1Cgz4ts2QgJCWOSZuMJMeOiA0P+tiBXI77YxGcH8CXlJCcummfF0FSPojxgKhyG0LCVhALV28eDA01L32yq56QcPT3G3Jg1bc=
Received: from BN9PR03CA0292.namprd03.prod.outlook.com (2603:10b6:408:f5::27)
 by PH7PR12MB8015.namprd12.prod.outlook.com (2603:10b6:510:26a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 17:03:01 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::21) by BN9PR03CA0292.outlook.office365.com
 (2603:10b6:408:f5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 17:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 17:03:01 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 22 Jan 2026 11:02:59 -0600
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: 
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 00/10] drm/amdgpu: preparation patchs for the use all SDMA
 instances series
Date: Thu, 22 Jan 2026 18:01:57 +0100
Message-ID: <20260122170218.3077-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|PH7PR12MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a7e707-7668-45f6-f394-08de59d819a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEM0T2RBc3FvYU1lTWVxTklIRVlTUWJrdFFXcjNac1JrZUQ1MDhKTkRZb1NQ?=
 =?utf-8?B?V2h6azB0Vmc5VERkVFl6VGVoZlNIZ20zdjBkcGpISEsyeFNZT0RMZGw3VzF2?=
 =?utf-8?B?d051TC84WnRKUkY2TEh6bXRQRzFQamViTkZJdGYyMlNKdFdPRnRySEpxaytI?=
 =?utf-8?B?K0U3eUdZZTBNVG54TE9wM1FVOXZwQjdqQVJFTXd5RjhtM2tqVUtmZnk1eUhr?=
 =?utf-8?B?dmltenk2RFgzRElndmNhUXkycE5qQmNJODBrTXpLc25MUDdzS2FrT0h5K1Jm?=
 =?utf-8?B?VjNhcmttYSt1ZllXYVV0RkQ2anJKZFZ1cHdqKzhHemFKU1lzeTRkcURROEtL?=
 =?utf-8?B?MG8zc2QvYmxMb1ExdzErWjVpRTROQno5ZE9VSEFlVEJOTlhETHExZmJLTER5?=
 =?utf-8?B?dGxVVWpwZnNMbzNTS2wvYXBGRGxsdktFdlYyM2gzMkxzcSs3OFVlOU5YU0JL?=
 =?utf-8?B?NGplNFZhVUFOQk1XYmxSOExIMWhqQ1N3Yml1SmlIZmFlUm5JZ0tEMENQL1J6?=
 =?utf-8?B?TitkVUtqTkF1Q2liQlhZOEhhR0ZvVE0rRFQ3L3dBV3oxTzBDZ2tDQnZPRXQr?=
 =?utf-8?B?UStVYkJjb24wSTJpUmtwMVVqemdtZ1A1RURnc1FSdER6cGwzWmg2ZnF0anhs?=
 =?utf-8?B?UzVRR0xjeVRtdGlWcHZhWnp6SW81TDJ1QXFWaEtYejJWVmIrVE00MFlHbHJV?=
 =?utf-8?B?S29hQzRqNTVTaG80cjc0LzBVSS9vekpSVFVWRVRQM0VsRGhYRnJRVld4aVQ1?=
 =?utf-8?B?KzNrTzcrZ0lkQ1FoUkxLamdnaHFOclo5RkhuTGlWVjQvZjA5d05JN3YvSkQv?=
 =?utf-8?B?cjh4OXl1NnBmY3J2RVAxOUpHY29UMjJQQmtmYlkvSldPaG43c2VuYlhDWHJT?=
 =?utf-8?B?THcrYllBaTdDaGlzenVYVWZjMzQwYXdaSlBnT1h2WENzWE5NWC81SjkwZHZL?=
 =?utf-8?B?RU16NWQxd25XVTROcWhrT0ZWWHI4b0FxNXdBSDhYaTFsUkxwek5XamQrK2hC?=
 =?utf-8?B?aG03VkMyYTlsYVJQNktQakxrcHp3eGF2YVJyQUkzNUpWV0RROWxJaFNDZWF2?=
 =?utf-8?B?S2xydXk1M0RVU25jb0ZpMVdFVUdRZlFPcFhXVDgrNTRNTHZRenRCTTV3V0VO?=
 =?utf-8?B?VnNVa0VydWNBaDFCMVEwb3Jxb3hvQVNZd3Y4SlFmSndMSFZheHZsY2tjbFg2?=
 =?utf-8?B?VFVLRU1USGQveXR1YTRoQTNiOHFhZUxYQWsvaHpwMW1FcnBGNjUySmk0eE8v?=
 =?utf-8?B?eURhWGNnMzJDMXAvZk5aMjFxRzU3ak1sS29sQ1JkMUZqRnV5emlrRlYvVzNT?=
 =?utf-8?B?enl2aVVKKzVqOVoxRFFmbUVGTmw0T0xhZmZqQ2FnSS9Dd3pUdHJJSWNWNFVM?=
 =?utf-8?B?YmhCNU9OR1FSODZNYkZZSHhWd2gzcHA3Q3d5cm9tRHVyTnYxWnZndk9nazR5?=
 =?utf-8?B?YXFiS0U2cXNacjFPdWtYSFlWOC9ZOEg4VzlCR3ZGd2VYTWJzN2tSUjg4NVJE?=
 =?utf-8?B?bVEzVUVwdlVWSVVUYzNnS1hpVzR0djhhbUJOSnFkckFkbDc4a28wSGV0RUpi?=
 =?utf-8?B?d2t0NkQ5RUNSZkZHdi9UYmpiRHE4cFh4a3FtQWNxYWYyOXlWVGxJcDE0Nkxu?=
 =?utf-8?B?V0xHdXpBK3lSdmRNRUxQck5rcmN1L3FSVHBpWnRSQXpnUW1lckJ3ajFzZDdv?=
 =?utf-8?B?RUQ0SkgzdmxhcGcrYVcyeGtBSFB1bmczMmFqb0NYck5zdERVd29tMGRmYzFB?=
 =?utf-8?B?K2NJbytnWERSMm90N0pOUTEyR29hVER4Y3pQSDk1d3BwR09URU93UGxZUUhU?=
 =?utf-8?B?SXdsQi9YQmR1OGV5QXhJYi9BWDU4YmFsQzh2M2hBTlpoWHVSSlJZMkhOdW0w?=
 =?utf-8?B?UnpWS002eHhxNlRJb25FM2VSY3RzTlhtSDdtVkZ1WFNMRU1odmR0Z2VHNSs0?=
 =?utf-8?B?dFBhZ09zZTNnTnptandwUkRDNGN6UXBXZ01wNEtPU2M1L3B4WGJzenQrWFhy?=
 =?utf-8?B?dlJxdUJueUVJOUF1TldlSm9Pbk9KMlNXNHJXZEdpT3FMWnUwVHpIVUdXM0I2?=
 =?utf-8?B?Q01ib1hXOGRSbE9FeTZWa2cwMlJES3prbXpkR0IrS21QR1NMbmMzQVNDUUFT?=
 =?utf-8?B?eDRtczlPTTl6N2hVT2wrQk1GRGM4MUtSQytFUEhCU0RGMkVhOTJXWXc2TjhC?=
 =?utf-8?Q?2P0jd7TF5Hk3ZvaM8gqLXmI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 17:03:01.1149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a7e707-7668-45f6-f394-08de59d819a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8015
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

This series is a subset of the "use all SDMA instances" series.
It starts at the first modified patch and ends at the last patch
before the drm/ttm patch that got merged through drm-misc-next.

The main changes from v4 are:
* rebased on top of amd-staging-drm-next which allows to use
  amdgpu_gtt_mgr_alloc_entries
* fixed a bug in kfd_migrate.c (patch 2)

v4:
  https://lists.freedesktop.org/archives/amd-gfx/2025-December/134877.html
v3 of the full series:
  https://lists.freedesktop.org/archives/dri-devel/2025-November/537830.html

Pierre-Eric Pelloux-Prayer (10):
  drm/amdgpu: remove gart_window_lock usage from gmc v12_1
  drm/amdgpu: statically assign gart windows to ttm entities
  drm/amdgpu: add amdgpu_ttm_buffer_entity_fini func
  drm/amdgpu: remove AMDGPU_GTT_NUM_TRANSFER_WINDOWS
  drm/amdgpu: add missing lock in amdgpu_benchmark_do_move
  drm/amdgpu: check entity lock is held in amdgpu_ttm_job_submit
  drm/amdgpu: double AMDGPU_GTT_MAX_TRANSFER_SIZE
  drm/amdgpu: use larger gart window when possible
  drm/amdgpu: introduce amdgpu_sdma_set_vm_pte_scheds
  drm/amdgpu: move sched status check inside
    amdgpu_ttm_set_buffer_funcs_status

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 238 ++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  23 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |  18 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  17 ++
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |  31 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c        |   2 -
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |  31 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |  31 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |  35 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  35 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  31 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  31 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  29 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |  29 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c        |  29 +--
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |  31 +--
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c         |  27 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  12 +-
 24 files changed, 329 insertions(+), 382 deletions(-)

-- 
2.43.0

