Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C53CAC587
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 14:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC55510EB57;
	Thu, 11 Sep 2025 14:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TaQ3KbOh";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 770CE10EB57
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 14:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+ryNlewer93HYreQ2zKg9fFZruOW69TXtcSyCOjHy9+Ulzuc90XN8gYvsmT3K24PJOn4f+eu3hlfKlkPJKsPQuecgs+/qpnMqLBGtkkaMVS+4DBEXKslPKareDzH0kvQray/EpWOdtzT3EQHzMAKA6NeKZZTmwTPm7e50jaQqiRuSdkjLJUR+OPQZ6nPqSN3DbRNYtBTJ/PfKIhJ4tyMUjQctOFWap4t8g3PFaGuE5D3S4VlPm3ofESI1/YsCGr0sy7xqWVZBXjkE9WbyWYCigebo+T0Da7dvb1AWPUF/HxUzBzGWhGmwIFVVHjEmRiO+wcMBfYLVcFHJws80Tr3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Fna7ghUNg+3h9N3iB4VF21FEdOyzkFvqm55g9rL3+g=;
 b=Bc3Q/zIqRAFWF6nFcN1czcetOzN91TXHvdRsffPjZvsCHRrJEaV/Ef0n6jk9xzHffdjWYC7hynXMKy40DDGh+JOtZ1c2TzwSLUWZ0TrGhstCeiDWqp/cHPpbMXUQXqOqwdUpU8nR5QMiAXJvBLsYNYOmBbLTROHjJXZGTZTOc5PM1ZB7wH3pud5YsfUkxQ8MCE+b7UGg8pSTiPiOnBgHyKQqmkeB34xFu7OE0rbOqtUWHT9QmgsACl1GjbIZhiiibCDeAa3Qb8C4v4X/niA5P4yKQVvCcCgCWRVGQgy8DYBBJkQFizsMRgSfXXtlRBT9wztMBakzxQMZSKcSHmx9sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Fna7ghUNg+3h9N3iB4VF21FEdOyzkFvqm55g9rL3+g=;
 b=TaQ3KbOh68E/CO+9lPAipQGd8YmJ8SSUK0tvn3zS/bmcHoKl+6BYRAfJP1IUhGLS5ZHIqcwjRgsZaP6+6WF1z2EbAg2BEnAWxWui5zXYi8POzHi9VAOT7iAZXGrOivdcDP432iJOJat9LZMD+n4KmuBrMcVE9h639GamazQB7as=
Received: from SA0PR11CA0194.namprd11.prod.outlook.com (2603:10b6:806:1bc::19)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:38:32 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::53) by SA0PR11CA0194.outlook.office365.com
 (2603:10b6:806:1bc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 14:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 14:38:32 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 07:38:30 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 0/4] drm/amdgpu: Handle MMIO_REMAP as fixed I/O via dma-buf
Date: Thu, 11 Sep 2025 20:08:11 +0530
Message-ID: <20250911143815.825607-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc535d6-6708-47d8-2c26-08ddf140e1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V21kbitSb21aQk5SaHVVOFVDZDZTSEM1MEJTTVVacHJQSEk3ZGdHUmF1QjNo?=
 =?utf-8?B?Q3UrTzEyNGhaQjBFc3ZGR2xXSHZ3bzZBSEdzVHhOeStuTTB0ZjJmOVNBV1pp?=
 =?utf-8?B?SjVzaFVMYTg1YWkxaVg5blpDUkU5WWJrZ3lUWU50bVRwVHFQNjZ4WWRUUXlY?=
 =?utf-8?B?SytaZmZDQnI3ZE95em0yVE1WbGZWUUxTeDNGR0UydDNUMWZJSEZob1RLVHRO?=
 =?utf-8?B?L1JmUU55Y3N3S2NrY1ZnN3gxNXRHREt0WlFmRFdYeDRURitjVnpqT3lTcmc5?=
 =?utf-8?B?azRDSlJEaVNwdTlmei9GSkNyS2Q5QXFWVjJHV3pPQ1o5bWhoL0tlalpmVHdo?=
 =?utf-8?B?VGh1UEJUS2RWRFhaYlY2MkpsSVo3Q1huL2MxSVcxY3RtNk9McUZrY1prbCs0?=
 =?utf-8?B?ZGdnYU5hcm9rMTIvSzFhRXIvZkEvTW5yVVYyNGtoaXFCQkxDT1BCTVRQRXZr?=
 =?utf-8?B?TlhrUFVEQ2haMGFRNlMvcVFBQnRyV3hRTTJkei9yRldxZXhKaUp6cFQ4M2l1?=
 =?utf-8?B?cndnS3hQWHE0TXgxcXNldWlnM0NrS2x4dUpIR1Y4Tmt3L0E4NFk5NndNeWk1?=
 =?utf-8?B?M0IybVJ4UHlIT2k3eTdHNkQyZ1FxYXFKZ0ZzOTlPSjlINHg1R2I3V0d3N1NU?=
 =?utf-8?B?UVFtaVdtaUxYbW1DV1p3WTNxZ3EwZGVFaVU1eXdzb2VnaXJFbVBDUSt3Ry91?=
 =?utf-8?B?dXB4cEdNRkhxbzhJZWZQR3pTUE9tTjRDeTNOZjF0RGxHRkYzZVBFM3haRE91?=
 =?utf-8?B?WURXZlpkeTRmRGREanR2OCs3SW5leSsvbnpQbDhkSnc0RHdrS3phQWtZa0hm?=
 =?utf-8?B?bHhSVFBYVlliMzF3ejRKakRQVm9QYmNUL2pRNVNIcWdjOUdQNitOSm10MGxZ?=
 =?utf-8?B?TGp4eDFMaFVGbE1CZ3lIeHN6QnVVQ2Q2UFUwVnQxUjA2NytFaWo4NEt5dWUv?=
 =?utf-8?B?R1NwZW1hckFpL0szSDdHRjhlTVZ1REpiS1kxNkd0emJtb1VMMVVMSzZ2YXps?=
 =?utf-8?B?MnBDWVNYUm1NUjhZYUJXNS9nS1NFdWgvdUlWMDd6TWR3YkZ1YU8zbHk4eUcw?=
 =?utf-8?B?TUtUWU0vM200RnZVZVdiQ2NRNXl1a0JvOXhyQ1NhN1NQb3hqQld0cjFrdVFN?=
 =?utf-8?B?eU5lK3JtS3ptei82YlN0QVhNd1N3a0taVitGbVdQNlpRaUFLQ1Y4NFNnZTZj?=
 =?utf-8?B?eEdPVnlkcEFaTktWdG1PWHBYUFlaejc4enY2WjhadkIyQlJHV0Q4WW1ZYzNl?=
 =?utf-8?B?c0h0NTR3YXJCbDdPL3YxN1EvRkJkTjl2K3BqWnVhb0VHdzNiKzFzdkhobG53?=
 =?utf-8?B?Zlp1RTRISkJIK0NiU1FLNFhSMDM2WTVzWW5MakUwN3FtZ3NrSXViVkxzRm82?=
 =?utf-8?B?N3ZudVdESCtGUmJUZ3FBeFB2Y1pIOEZVQnBKd0hiTzdOb2JYbmhvcy9oK3h1?=
 =?utf-8?B?V0RIMVE3ZHh4ZFd6MGI3aVJvR0pqa3d2MWVhTlFOVExrQW9kR3kxQ21rdDhB?=
 =?utf-8?B?akUzemdPbFdCbnB0bzhwNHpVMXVLMFRra1ExUUxWSmx2bno2SE0vbHduWlov?=
 =?utf-8?B?MUxiMVFIYnRocm5SZm90dWRwYlZIdG9wVE1xQ0NER3RIVmlQL0xTREExZnh6?=
 =?utf-8?B?RDNpNXZUY3R4ZkZtRGdpb1B4U0VKZEdKb3h4ZXhDb1ZjbXZHN1RoVnZuQnBK?=
 =?utf-8?B?ZnJJS2REL0lKZ2lnaG1xZ0w4Z1dHaWZkUEdsNnlLM3QxVmFDRGZxcnZRcCtP?=
 =?utf-8?B?QWNFNHpGNXhINE9saHFaM2lLUDV6UC9oaXJjN2w5akxDV291VHNNMHFEeGRh?=
 =?utf-8?B?UWMxdm5SRmdHTDFxNi9hZ09zVnBFMlNxY0V3K1hhYmIxd2pEU3VXSXFRaDJ5?=
 =?utf-8?B?b0t1dnFPcTA2YjZYSEZhN1FWRU83b0lNMGFxQmtpci9tOHY5WnNRV0gvL3dR?=
 =?utf-8?B?UzU3cS9BczZmRzBIOHNlUFNyeWRpMEcrY2JwdktLblhWNFMzU3N2c0FSekJF?=
 =?utf-8?B?SXF2dmJuU3E4OWk4a1hKK05mNWJhRXpvdlFWckh4ZHMzVW1sSkxGRjNkQ0Yx?=
 =?utf-8?Q?yxFeC1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:38:32.3080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc535d6-6708-47d8-2c26-08ddf140e1bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282
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

* Only compilation tested so far (x86_64, defconfig + amdgpu enabled).

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>

Srinivasan Shanmugam (4):
  drm/amdgpu/dma-buf: Add helpers to map/unmap BAR I/O with
    dma_map_resource()
  drm/amdgpu/dma-buf: Map/Unmap MMIO_REMAP as BAR register window
    (dma_map_resource)
  drm/amdgpu/dma-buf: Pin MMIO_REMAP at export; unpin on release
  drm/amdgpu/dma-buf: Treat MMIO_REMAP as fixed I/O; don't move it

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 136 +++++++++++++++++++-
 1 file changed, 133 insertions(+), 3 deletions(-)

-- 
2.34.1

