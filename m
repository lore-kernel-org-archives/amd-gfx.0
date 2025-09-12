Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2319BCAC582
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 11:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB46210EC0C;
	Fri, 12 Sep 2025 11:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kY75uj0h";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA98010EC0C
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 11:12:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSQ0Jl0/ZX1Zk/AKAJyZBoDBENeFLa5NbibIJrhCZDpvb4dAN2WrJjj7trRXdfxz+0v+szz3f8EvupV6ndKGl+X/0mGXaCa5+Auf57mwulha5iiQjTRz8lGJEo6eCFh9htzlOC8QirJ5ym5IgohEOOskIC82uicqm4ur2apqIwH9W3wPTw+5h9pJpHpPOGeAF6jznnmASR5sGTJnHaa2aaCDT32eDGzdQU6cihdRkIV7BFd6lAWEkQo+Nq3nl+dAha6elYYF27iLU1jWFZ/z9OABY2mZ7EX7QzvRnXI3d+vWJuXyiQCy2KdF4LU5muv7x9DZjEbUmWoOF0pm0DF+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIiCRbPOmB9of6e2+Uj9nFQxMDkHZqulOTMK+ejtfmo=;
 b=Wdc1WH2IugmD0iQlyF7DmfmH1+5QUGuMiM3ulF0HzEdQ2qwUmyUnVuA9bKeNIipAMxwcf6lG5LmvkFZKqrSlJr+MoaM3XR0Yh7IRkwImLJXS9hQNE54GngdPF0A4OKydXn38rILHOill6VuHeaYBjDQtXICoiPYOkQvpU81Ua/O9XxVWu6XF9VjNNcWa9M5E3YZcfjXe07pmeXH4ghDRNjK0nVjQ6iFdPl51H6d0RWA1DEBSt1jqxCAXBLygcYczFTcW6WwhDi0I2OIQJdiwr0ZGE0MN7YpqhMJjM8bjBjHlFe0DQcLjm5aaXRW0SF9TLSRkpUMDjFlMH3lcE3Bl2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIiCRbPOmB9of6e2+Uj9nFQxMDkHZqulOTMK+ejtfmo=;
 b=kY75uj0hEw2nbjL3OBWFmZGpsTucR/pOahvUbpmMPxJa0FynK5GgLeOgdXuWPuQHC7W6Ya3Y2D9a+HyflIFkzxocD40q+5iANBDiXNWVHon1GYl34QJOW5aGRA5uqgerd3Ie0tNIj0Anx3A5I81nCXDzu7M16lumumzhNjNblTs=
Received: from SJ0PR13CA0078.namprd13.prod.outlook.com (2603:10b6:a03:2c4::23)
 by CH1PPFE5ACC0FD2.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::629) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 11:12:11 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::4b) by SJ0PR13CA0078.outlook.office365.com
 (2603:10b6:a03:2c4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.8 via Frontend Transport; Fri,
 12 Sep 2025 11:12:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 11:12:10 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 04:12:08 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 0/3] drm/amdgpu: Handle MMIO_REMAP as fixed I/O via dma-buf
Date: Fri, 12 Sep 2025 16:41:45 +0530
Message-ID: <20250912111148.833465-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|CH1PPFE5ACC0FD2:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ae0e6d-b7a4-4967-40d0-08ddf1ed384e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmNpYy8wbTJyTGczV01zYUV1dkxuWXpSOUtBY0lWTDI5U201dUpQVTlVall1?=
 =?utf-8?B?aGl6clhqdVNVa21JKy9wb005SWRySCswM241U0RjQUwyQStvN3dPZnVxYURF?=
 =?utf-8?B?TDUzd2xDNjkrSFZySnVrSUdJMVV1MnJDUVpEcHFvenJDVUV3RlBvV1NmVGxn?=
 =?utf-8?B?TjZJbkRkZFFFRVZxTGFKNDFaaC91UUd3L3hoOExsc2x2VGZ1YWZNN0lkc2JP?=
 =?utf-8?B?dDJLbnhuTmpVb1NSQmtmd2w3cTI3MWJWNS9Ba093d21tZEMxdUZDaSt2M0tj?=
 =?utf-8?B?YVVHM2NyRG5xQU1BMzhlNjdTV3F5SmZkYlpyOVJtT2xPcEFzTzUvT3VadEti?=
 =?utf-8?B?WFprMTQxMzRXdGY4bEwvVFBXNHdLbzUwRXhOVnBWb09JcDNLSkdQWmFoUXBo?=
 =?utf-8?B?WFMrSDFNR0dJSkM2UlNpaWt6TENFVE5nc01xang0VXRtbWg0WWFlbnFySTln?=
 =?utf-8?B?elVhT2lzZHBkVUVYMkNUMmxVeEs1M3BrVDh4YytHVHRacUY5WkxTTDRtcjlw?=
 =?utf-8?B?M0hESi9TQndKZ29wK2pUTWxqSHpqS2ErMHgzMXk2bnVCRG9ucGRlQk1seUlW?=
 =?utf-8?B?R0JGcTVzMDJZaEVyUmdNV1RGWG9iRVBVUzdweDd3WTJkcjBVdEd6ZHpDcmdX?=
 =?utf-8?B?cDVEY3NaV2p2THNHcndHMkJKT0RDWnJyb1A2Z0U1Wldheks5SXRIVVhjSXNj?=
 =?utf-8?B?UW05L1VmVXdVTHN5N0tKVUo0eGdKbXdGK2FIVnl5QVlZd0NHOGFReFRpOXV1?=
 =?utf-8?B?VS9vT2l4NHhjRG1lMGJmTzdMRURiNFA1Vm8wbEQ0V253cGxwellLSkhjWEZi?=
 =?utf-8?B?aHJxVTd4RHJKYktFbFZkdG5BZWMxY2RsczNNakNRTWJvbXF0eURDYmZwRzlU?=
 =?utf-8?B?N1U5VDN1NTlBYk9zaHExeCtiaW1VZVBQMW5aY3hRR3d1MFhxaklwMWRyWEZD?=
 =?utf-8?B?VkJkZTN1Z2xyTUVRbDZhcTF0T1BXYmxFNU5tRUdqZWx5ZlppQXlvV2QvMzdD?=
 =?utf-8?B?UjFyMURFdUFjdjcvRjFWdDZDSDlNTEwwSHE4S2grMFNDK29FYlFLbXFGVk55?=
 =?utf-8?B?dEdtSk42UjQxb2s5T2Y1ZW4yRjJkSFp1RHVVUmQvTzd0U1RwbWZjakNaWFVT?=
 =?utf-8?B?QlFNbHhzZk9NMVZQTFk1MzBaRDZ4czJOc2tQMEtCZVU0ekhFY2U1bXQ3OEVD?=
 =?utf-8?B?T2xHTlUvaUFMVGlEbVRWenBYam03bzU0dnFLZlpOYmhqUmw0bFhTOVFCdUpP?=
 =?utf-8?B?NWM2Nit4R1MwSjUzZzZ1aVJxWUdTMmNCSTZhUlk0YlZkM2FQaDZrTythcWhy?=
 =?utf-8?B?U3MvbHVJb29PMytNQS9BQlhHdU1CRFBsV1hlWjMrSFhYVkQyQXBabFdHdWx6?=
 =?utf-8?B?TC9Qd0FoZXVzblRVSXZBOHdBUDhnQmx6NktvSzZuRHRnT2Q1MVQybThWQkFT?=
 =?utf-8?B?bnc5cTJwck44UVR3RFEvWXNIWTBtYkQ4WkpXNVlPdkR6UjkwN2dMV1Zja2tD?=
 =?utf-8?B?S0U4T0Zzd3owazQwVXJMQnEwRWZBaVJMNWxVbXFQcGlRNGZPTnZYRkFtaDJI?=
 =?utf-8?B?eFE1SnhvNDhlbm9Id3RsaTNRajJaRU1pZ1plZjkybEI5U01rR1hOWElwd2pp?=
 =?utf-8?B?dkFaVys2cnB5ZnRJdkR1VVNVQlhIcWxXbTA3bWQybWNxUm1hUXl3UGh1c2Ir?=
 =?utf-8?B?TmVVVzU0aTFobHN4ZHFFazdEWFdsWnU5eUJUUndhT2lQamFzSmRveVBSVkJL?=
 =?utf-8?B?eVdjZVVDMUk0YU5GRjRqMnVadGNLb3JLbHdvWldmTmg1eDdzUnNzYVMxUGVw?=
 =?utf-8?B?dEZ5aWtyRG5yUlNuWjJ0eGhtdkZTWjJwdkZ5VUQyTUdqRDFVZVZaQ0p4bnc3?=
 =?utf-8?B?V1RBZ0phWTBVM3NaYy82dzdhdkVHNTcrM3JYYlNkVi85V29ESTdyaWZZTnJD?=
 =?utf-8?B?TG45OTh0NHZiTFRLcVJXT28xSk4rUmZTRmIxUUlDKzB5a2I3UWJMVW9ZbC9B?=
 =?utf-8?B?UGd5bzdMTzNGVkZGVGlIa3o3M2IrOHNsZTN2RE05VUw0THF2VnlBYXgwSUZY?=
 =?utf-8?Q?3f6Qut?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 11:12:10.9332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ae0e6d-b7a4-4967-40d0-08ddf1ed384e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFE5ACC0FD2
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

This series makes the amdgpu dma-buf exporter handle
AMDGPU_PL_MMIO_REMAP (the HDP flush page) as a BAR-mapped register
window (MMIO)

The HDP flush “MMIO_REMAP” page is a BAR-backed I/O window (not RAM).
When another PCIe device (GPU)  needs to poke that window (e.g.,
device-to-device HDP flush), we must share it as a stable I/O span that
never migrates, and we must map it for importers using the correct API
for I/O resources (not page-backed memory).

This series makes MMIO_REMAP sharable through dma-buf by:
representing it as a singleton, pinned 4 KB BO for the device lifetime,
and mapping/unmapping it for importers via
dma_map_resource()/dma_unmap_resource() using a 1-entry sg_table

v2:
Design-level adjustments (Christian’s feedback):
 - Pin at creation, not at export. We now pin the MMIO_REMAP BO in TTM
   during init using ttm_bo_pin(). This enforces “never migrate/evict”
   from birth and removes the need for export-time pinning and release-time
   unpinning.
 - No begin_cpu_access hacks. Since the object is pinned and treated as
   fixed I/O, we removed the special-casing in begin_cpu_access();
   migration heuristics are irrelevant.
 - No pin/unpin no-ops in dma-buf paths. Those were a workaround for
   export-time pinning. With creation-time pinning, they’re unnecessary
   and are dropped.

* Only compilation tested so far (x86_64, defconfig + amdgpu enabled).

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>

Srinivasan Shanmugam (3):
  drm/amdgpu/ttm: Pin 4K MMIO_REMAP Singleton BO at Init
  drm/amdgpu/dma-buf: Add helpers to map/unmap BAR I/O with
    dma_map_resource()
  drm/amdgpu/dma-buf: Map/Unmap MMIO_REMAP as BAR register window
    (dma_map_resource)

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 86 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 26 +++++++
 2 files changed, 112 insertions(+)


base-commit: bc52ed7845660e03827131505f95fcb4dd2fcf4f
-- 
2.34.1

