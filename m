Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2229FD3B7EA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 01:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A34EA10E162;
	Tue,  9 Dec 2025 01:26:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kppYtJL5";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 269AC10E162
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 01:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gik4nzg6qJR1WJyp1oVMAFfeXC639zB89VGotoQwiW5KZRs5wsXQrURYU2F3tsw0NKmYyO7mvXCn9azoCq1l3NW/R/EJZow9OrpYEnKhI5Gk33H8kDTliYhHzRpZAstDRBbVOG7bWzGeCqKtyvQciriBk0zNluS6urmepDiDV8+CMC6awgPbomQmmRAXLY5mBhbEHOECsF969EQJv3N2B1/K0z3pF0ELn8ZtYKn9TojcPAFtXM6sQV/VkasxhXmP8XdzR0fm9uNdk5tq43RAdDJVIn6/xueiGTpSpoX4jtGNqgYRJ3BexJmXy0LL4Gq97tFYQAkcULlVWiCz869wpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=346nR01AjBEFNoPJWd3caOpY2ciKP47sxgbYiS8UAhA=;
 b=ccX8MwrfbBKqVh+QrQslIl9BeRlx/QHulCrXUfH3BM7RY4zz/Al7wXpZBCc4oSa9vdVIsgfOV0/qe4x4Vjn/vEMRjpeaBfsLQ13k9Te6VVjn0t6WvkVFjrdSNW9mwRmhxnsFx0/hg4afPJwS3DidEaQT/4D/tR1fSK7gVf2vSv+xI1M+92YMzDPT8U+i7ftBAl0CYX+KnT0R7dKdbUy1T/tlyCcmwKSUOL0rPMR33xBL3k1j8Q6vINfrwX8pT2JoZohSacqt+xG7cyLr34pvlkNmF0ErVA9Shjv1ItRDbRQE2ioEfNyVxLOYHRCuY1DtzSeLvOYAmt3VQxmetykcUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=346nR01AjBEFNoPJWd3caOpY2ciKP47sxgbYiS8UAhA=;
 b=kppYtJL5eu+dOHURNxZg+6YXfR6Gl0drZUA1EQAYEzdiwzOD0unL2DPvHxsDnBLmOUMI0K8epw/S1YF14FjiuXK9nKmuzFvW5olI0wrkMdaHLvEyYnoYVUcat8LL/1P4gGucy6gMMEUWjDJX4l0djJmEtnW2a3mSQ+PheCN5eYU=
Received: from DM6PR04CA0016.namprd04.prod.outlook.com (2603:10b6:5:334::21)
 by CY1PR12MB9673.namprd12.prod.outlook.com (2603:10b6:930:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Tue, 9 Dec
 2025 01:26:06 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::2e) by DM6PR04CA0016.outlook.office365.com
 (2603:10b6:5:334::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 01:25:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 01:26:06 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 19:26:04 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH v4 0/6] drm/amdkfd: Move gfx9 MQD to HBM
Date: Mon, 8 Dec 2025 20:25:31 -0500
Message-ID: <20251209012538.3882774-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CY1PR12MB9673:EE_
X-MS-Office365-Filtering-Correlation-Id: 9354c535-1aa5-41a3-6e51-08de36c1ecd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2cvT2syMTJVd0IzRHlzMFFWYkZ4K05ZTlE4bjVQWEVqbEhHMlMrSG40eVU5?=
 =?utf-8?B?VkNVMUR1YzRDOFE5LzRCc1NkdlNKd1R5bTFENTZlalRqV3Q4Zno1VGo1emdF?=
 =?utf-8?B?VG1CMnhCbXVnTHVGK2VpUVF1TjVXVm0zSTRzVFRtZDJIcFZZUjIwWjZCYVFi?=
 =?utf-8?B?aVpLUkFZaXpLdFh1ak1zVkZmUWRRWi9ZSytQVjZLYXF1cjhFYUNqRVRMdHRr?=
 =?utf-8?B?OUJUS2FRYjM5WCtpa2lFZTVuaFljL05sWXNCOWNOU0Z1UTFvSmMxbDNBM29u?=
 =?utf-8?B?aUwycjJ4NjEzMHBrNmxETHNVSVRSV3pZR2IwMVdVNGcveWt1cEorMEJEd21M?=
 =?utf-8?B?b2ROR3ZEOVp0YU5PK2Z2RHVxQktSajlPRXBoT0UvOXBhbDhNUFNrV2NlSXVs?=
 =?utf-8?B?MWM1Q0dpM2ZtR0NEQ2pKeXZhZU9YeTduS2oxY0lqd2pwaWYzVVRESXVSUDNr?=
 =?utf-8?B?WUZyQlZjT1VVbXdiakVjY2hCYW50R25pbEd2ZE9IT3lDeVlzeVQxbEVydy9K?=
 =?utf-8?B?Rzk5L2ZZdlR6QU1HVWRpWXY0M20yNEpXaHlNZlBZVW9vY1BRc0NCQzYyZ3BO?=
 =?utf-8?B?UUw2ek5xS0ZrbmVPY0p0TFNPaDc5Z0RGZzU3WjBmNlQ2QkVBc2lPYVNwTVg5?=
 =?utf-8?B?ZmV5ejBaSkhwcHM0VXRWT3hIZ1JYblFFTHlDMDdYeWVSWEx0VEw2T1cvRkVv?=
 =?utf-8?B?ck9Vdi9PUU54VzdCbnd1MXFFQ21RTDBPck53OWhvbjZ3UWpaUENDZytJd0dF?=
 =?utf-8?B?U3FtT2pDYjZ4ekg1a3lUUzFlRThUdE0zRlJWeUhVZmJUSkNHWXdEK2VGMUdX?=
 =?utf-8?B?WUU1amNLV29zcnRPeUdwWXlKOEJPMXNZWnFjNUlDa1k1K0toQzdORWtwbFpl?=
 =?utf-8?B?OE85VURKUWgwTWxDK1BaYXdleUk3WDdzeEZOcHpxTGhNeEZOeko1c094TVNG?=
 =?utf-8?B?Tlk5amN5ZExaOHJmRzBUSkJYT0lrRlBFQjhhcERJWlQ2Q29WTW9oTHY2RmRY?=
 =?utf-8?B?M1pDdU5jZFZNQ0JpRzZnQ3Aya2Y1SFVSZlRJYVBoeWlRZUZMdTJ1REFlWGVq?=
 =?utf-8?B?dzVOVnBUV014SXljY0VndXBHNUgzRUtuWDRSL1VhR0RuSU9KQi9SRS8xSEdI?=
 =?utf-8?B?aFIvQW1CakpNMEJ1aWM5MFdNdjdhK2w2SlNWekdDMngwVjZHZW1zL29TNEtW?=
 =?utf-8?B?Y1NqcHE5UlN6WHRaalpSb1YvbjBRYy9sNjdieUZiZFJ5RFF4UzAxYzlEUXlx?=
 =?utf-8?B?MWtYVXdralVYYzdxMzZFeHkxRHFLa1dPMHBWd2xvQkR5L3NnV3FOck5PL0VH?=
 =?utf-8?B?eS9vS2UyRS9uT1p3cHRmY1lBYlVTb2RtY3oxVVNQd21JZHoxY3lOTldEZG5Y?=
 =?utf-8?B?ci94RG5JNS9oakcrVTdWVUZ0RWlYTzFhZS9PUlJBWDd1M0QyV3hiM3h3VHZR?=
 =?utf-8?B?eHNRbDkzTU1xMDA0YkVBajBrWnNBUHM1bU1sLzMwTEttY2hDS3F1c1lzZCto?=
 =?utf-8?B?VXRNL2lhSjVjdXZlZFlCVnFidEdSTVFLQUdOTDg4WTBiS1ZzZTluendDaGJH?=
 =?utf-8?B?Z2ZadWNadzl3OGZSU09TMllwdFZxc3lTcTVycGtaRjFhaW5zcExkMFJMNWl1?=
 =?utf-8?B?ZE8xeEh2czAvUTdRZnMweldvcXBPZzhtWWJSM3VTV2RtTnJQaTdYSldCaUhU?=
 =?utf-8?B?TW5vNU5WRGgzVnRSWTFhWVBLL2dLaWJaTFU2cHZNY29sT090N1pqdUxXUWtT?=
 =?utf-8?B?L1F3b2I2dHBQRlBNa3E2aUUxMVIyM1NOQjdzRzliNEIvR1Vxd2RrSHZYZWRB?=
 =?utf-8?B?L1ZJaHJBdE1XMjM3L0tlK0pCallkLzdYdnRpdWg5VmdZZ3U3MmlZZ1ZqM0xy?=
 =?utf-8?B?eXBZQUZUZk9QSW1Gck1PMnllS3N6WVZRbFlweWt2ZmV6ajR3ZVg5V0ltSmd4?=
 =?utf-8?B?QlErbTl0V3ZGMVN2UDRROVBYN1pPZzNPbTk4dWZ5ZktHMWRaTDdURVhSckk1?=
 =?utf-8?B?a2tYS3p1bDhZT2I1T3k5ZTN2MEdHekt0R25EbVNOQ3pWbmMrMUhBSHdXTnVx?=
 =?utf-8?B?VitncmN6QU1lbEVjK283SWFIQnhIY0tCSzVUaGhQR3FxTmR1MS90ZFI2REhq?=
 =?utf-8?Q?Io7U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 01:26:06.2403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9354c535-1aa5-41a3-6e51-08de36c1ecd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9673
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

v4:
 - patch 1, remove the executable bit change, cc stable
 - patch 5, move GART helper functions to amdgpu_gtt_mgr.c
 - add patch 6, to update MQD GART mapping using resource cursor

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
  drm/amdkfd: Map VRAM MQD on GART
  drm/amdgpu: Use resource iterators update MQD mapping

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 13 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  6 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   | 37 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 93 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       | 10 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  3 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 13 +--
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  | 15 +--
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    |  4 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 18 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  2 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    | 12 ++-
 17 files changed, 201 insertions(+), 48 deletions(-)

-- 
2.50.1

