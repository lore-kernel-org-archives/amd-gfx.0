Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B432D3B9AD
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 23:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8155E10E632;
	Tue,  9 Dec 2025 23:44:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PIM6OpD/";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0542210E62D
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 23:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUsJC/pBysjf00NM/VaXLXvThjYsjE4RN9mIBUIMsDgpRMCJQ6Z7oHliM9UTEaizJ4P5nZXl7inGatzXlQ9W1fmyeCUPlOwyHqPO+3ryy31KCfONcDI5XFbtwaUqKy/sfSEG+zFFhXJxgujerRPxEp+aNScHigoqnwMHbou+y2yhMzFgZiFHEKEnq842423vLHcO+yxNd05pJjCb7NYVF29P0VkNeHs+LeBSvg/e70ch/Bj1jyoaGDkcqlPP0y/Qb/5/LZGeBCuijESG86zi/OFUj9U1+zzBF0QI9SCxVK48vfHnhnninKv/ydNpooPNM10hsHAmd1kuzYLsBD3F2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vg+N0sbVDiUpr/nLMcncGpUxMa1cBUWV6730loQdOVA=;
 b=IVhzOe+r8vKeB4kUdbacTEBVuSjlzJlEYvhMXteDKcrPKfCZNDor6h/D8X/VHLec3OqQHtuHj+eWixxqeGWDMjr0EBEZGT1/tDxcSa8Rv2+rR2p7vmfEsOSYF4LTIC0FzPbPB4c5BW7s0maOTjQSLP8066PN5J8LF4N/DxY+f49WArEW6Q0bLuden+Rh3BWGVHfd5WuVdQqt+aJw2AJ5IE9relFbOmYckAG76N2LMP3YHWwU8f1mhMjDURlnU5fm6/vTfBcxn2gXlTbAPs0RgcKgr6jfy5h/J6uav1pydIulTt+MY/2Uk4ReERbdqdtJt1S6oA23uaLojySK7s5/sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vg+N0sbVDiUpr/nLMcncGpUxMa1cBUWV6730loQdOVA=;
 b=PIM6OpD/AiEvIzeftoxh+wNWt2RnDaLcAuvMNQJcGxxGYvJm5PfyhimcebU2rNmfKqb1l/KCkzXdBO7AYbQ/RIqKvERyM2rTzqvr6qkU0eKsmnTjApyfLlgjLlsFjw4kNZ/+nI868HEnmAf+lPjQR1wvHqgYB7pKMj2PffLUAxY=
Received: from DS7PR03CA0186.namprd03.prod.outlook.com (2603:10b6:5:3b6::11)
 by DS0PR12MB9447.namprd12.prod.outlook.com (2603:10b6:8:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 23:44:03 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::da) by DS7PR03CA0186.outlook.office365.com
 (2603:10b6:5:3b6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 23:43:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 23:44:02 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 17:44:01 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>,
 <kent.russell@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v5 0/6] drm/amdkfd: Move gfx9 MQD to HBM
Date: Tue, 9 Dec 2025 18:43:22 -0500
Message-ID: <20251209234328.625670-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DS0PR12MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3188f1-3d61-40ea-f378-08de377cd559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVlHOTExTXdvTHVNNmd0ekxoYU9KbnBiNHYyT003Y2tKRTFFZkVQa3pxZUNO?=
 =?utf-8?B?WjRHLzUxRys5MC9UZlF0WnczUjBsV1UzR3FRU09YeXVERk5tRzk1VDdNWjNo?=
 =?utf-8?B?U1ovaVIvN21FNjArVXNwbERQMVNrMFJ1bkxzL2hTWmFjZy82cFQxRVNQaGkx?=
 =?utf-8?B?VTdMMW9YbmtlMjMzT0hRNURWa2grUkI4Zy9tSjRWVnVhcmxHZ2ZhOCtscmcx?=
 =?utf-8?B?dkc0MDRidGNWSGEwTitzWktCSkpSaXZHdHFFeUlKbXdvek9EcDBLMHRSc3o2?=
 =?utf-8?B?blU2OXBHbGs2NGszZmFpWHRjaml5MTR0RzNCNTFKUkU1ZWVWS2xVbUVTajRp?=
 =?utf-8?B?WVJ1RDVIUHdFNmQ2aVN3TDVQTWZYZkxVYlpHNTlFNFdrdlVCcWtUcFo5NDdH?=
 =?utf-8?B?eFJIUDlsMGVMc2dXamVXZjduQ2I2RUlhUFplZnhQWmh3WHdMYVhJWVRxa3NI?=
 =?utf-8?B?RGtzL3MwWEtucWFLMnNBOGI4K3hqcDN4WHVuQUFzbWpMTU9uQ0FaVTdOTmRo?=
 =?utf-8?B?SGhjdVdNdW5nMk41TVNZUTRaaGVrL3p6L0M0TGFUbTBLeXBqYjgya3o4VGtV?=
 =?utf-8?B?cXBWdVE0ZlJYL0NZWEZHWkRDYW16Q2x2a04rMlNzMzI0Y2sxV3E2VkZHWXlu?=
 =?utf-8?B?b3BOcldNOXMrNERVTTIzY2JhTVAvb1piNnhrdkRtYWFCbys0bXhZOFF5STNq?=
 =?utf-8?B?VTZCb0lYM3Y2VkdiRHBuWlZrZlNTei9SNGREZFVrdDExSllCSDg0VWwxT09k?=
 =?utf-8?B?eFJ6Z05BMVBGY1BpZ0g1R1B1dEIxdDdTdGE3b2FMQi9vejNYNDJWUU15NEp0?=
 =?utf-8?B?UFl1TnVQM3pHd3MrSWYzenpOQTM2SjVNVHlQaDlYRUJxOVFudlRralFWaTA4?=
 =?utf-8?B?cFpIUDdISnpvenZ2NmJZRGE4c25jUU01RkVodzBkRFgvUTNaOURxMUpMbGRz?=
 =?utf-8?B?RWxIUVZ3MU02TG9XSDF1R3ZtampzK3FlM2M1bzZiNXdWcTN1VzN6b0l0TGxI?=
 =?utf-8?B?bFU3SjJ0TUVIN2s2cUhQTng2VWRISTRKVlB5bG8ycHhZd0NXbTFzSWNBcVZJ?=
 =?utf-8?B?dFJ0WlBKdlR3S0FVZUpGMFpKell2VXFHNHp4SThkM2cxczZGTmFZcDI5UVRs?=
 =?utf-8?B?ODRQbGFoNnMvellpYXJvWFFyYWI3ck16Qi9rOHVKWjJrN3V5ZSttZG1TempM?=
 =?utf-8?B?Zk1CR3R1VVA5QUo2eHQ3RzZnYnFuYjQrRlB1S0YyYkN6MUFRQXdqelJiTEdQ?=
 =?utf-8?B?UXg0MjAyT0RpUU56dVRsUEFWdmJ3V3MxZFFIUUc4UDRpbXY2eERTU0FBcVJj?=
 =?utf-8?B?TlFabjUvaDdIb1JqbC9uMEx5YmsraFQ3RkZ2TDhLSGI4b1g5MVJyVlZURVFw?=
 =?utf-8?B?VCtwTW5jRGY3ZlBQOElIeFJiUG5YaFRweUZJc1A2NEM3MVlhZklodk0xeDRl?=
 =?utf-8?B?eGxOSU9BbVV1Z1hiWGZzR3VIRTBadm8vaC9ScktaL2tTQTVKb3pPL3lHMWJK?=
 =?utf-8?B?MVUrWWQyK1J4R0Z3eGMzV3ZEZnNlQWw2VlJzVmwwMjUvSGdVZWdoREovbmRm?=
 =?utf-8?B?ZllkaDZUWmlPM09zMnY1NVY5QWp6ZWFqSFFPdlE2STZuVFd2ZjZ6SEJGL05C?=
 =?utf-8?B?aFVQdW4rSTNvdE56aE9oM0RBNkN2QWJXUXdXYVhidXBCOEZWa1B5UjRxaDlZ?=
 =?utf-8?B?My80ZkVKZmNheFFCNStiVllGbUlCRW44TjV4L3JySFVNYi9ZMytsQVg4UDBv?=
 =?utf-8?B?bWN0OHoxTjBMclMvVERvMUg2Q0tZMUUxYVFZeWxoeUtybnZwVEpoMWpxbFQ3?=
 =?utf-8?B?UFZ6dmlvcVppSDJVL1lUN2l2dHJqQnZWaG9wZEUySmtaUVU5K00waHNvNXdI?=
 =?utf-8?B?azVxRDlnY0dGZmViVks1VS9HUE41TlRDWC9qRk1tbnhMM0lWQmtlYXIxNnlH?=
 =?utf-8?B?dTNUZDNQcTNkVy8xWTlLOVNpMXpwNEFqUmZhU0Z0akNITzYxNHArZmpWdm13?=
 =?utf-8?B?bW5rNVlzbnJ2Q2pQbVNJekJlVVhKQjErUFJJYTlvMmNVVW1LM3JCTEtPOXhp?=
 =?utf-8?B?NUR5dWo4UHllc2YwTmFGRkI2ZFdGUGpzdC9xSk9TZmw5Rk9NaWVQUkROd2tv?=
 =?utf-8?Q?UEbg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 23:44:02.7377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3188f1-3d61-40ea-f378-08de377cd559
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9447
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

To reduce multiple queues switch latency, move user queues MQD to HBM,
and map on GART with mtype RW.

v5:
 - patch 1 update commit message
 - patch 5 separate GART alloc helpers
 - patch 6 use resource cursor to handle GART entries

v4:
 - patch 1 remove the executable bit change, cc stable
 - patch 5 move GART helper functions to amdgpu_gtt_mgr.c
 - add patch 6 to update MQD GART mapping using resource cursor

v3:
 - add patch 1 to fix gfx9 mtype update bug
 - patch 2 use ASIC specific mtype
 - patch 5 use drm mm to alloc GART entries and store in mqd obj

v2:
 - patch 4 GART mapping use MC address, vram_base_offset + physical address

Philip Yang (6):
  drm/amdgpu: Fix gfx9 update PTE mtype flag
  drm/amdkfd: Bind MQD in GART with mtype RW
  drm/amdkfd: Add domain parameter to alloc kernel BO
  drm/amdkfd: Move gfx9 MQD to VRAM domain
  drm/amdgpu: Add helper to alloc GART entries
  drm/amdkfd: Map VRAM MQD on GART

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 13 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  6 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   | 27 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 96 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       | 11 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  3 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 13 +--
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  | 16 ++--
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    |  4 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 18 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  2 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    | 12 ++-
 17 files changed, 195 insertions(+), 49 deletions(-)

-- 
2.50.1

