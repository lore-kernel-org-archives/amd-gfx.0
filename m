Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED71D5B857
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 16:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78AC910E3CE;
	Mon, 15 Dec 2025 16:57:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kyitg51e";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013067.outbound.protection.outlook.com
 [40.93.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5709B10E3CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 16:57:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcox3OtIoGifxEZgGKF492FeHoPRZaKg3cQFkFZGOH5rmZGlM9GzucmMJHVhyp6lKE2QvVOZix1dv+kJe9VD/+y6QkhrpSFRC7SsSsHaUHc6UGyLxw0SctbgqzJeGyPWbcBN+zlyhD0h+xjJXmVNGlaz7/CDK6N5X/Z/IJyg0tS2fGPSPJgCHxzAhOSVykhfGSpyaNmbjzZYV4OVzBP7TjxmaFNW108eO6xRy70vz7h975cO3jwGdE6iD59n0ijb0XDgGFQYXNFdSXVRwyYnODATL7NoUAAC9rh9Ex9Ra1C1al0kD3SyH7sb7GuEQJ+PX/bngPEzn0YXoebovGH+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OttiX8dkr5GOmxnfRGIe2b2LN0yPpoU1mphxvrMo4Ew=;
 b=ALr0f3Xz4Nz4HR6kjBb0F9o0iZC3YVzI9T42Iy4EjKmS9NFzLsKhiI7Jcm7cxRaNwePUta0o48EJ1Hn448Tq4qyDDkjlYoM5FmRAv8zvrcXm9zdldem6XGRJmvrWAMh7b35iagxpGEXGgY1/4BfIjQyCiF0MHfbLYbDBlx2ENtAFmmoRDnjTBXXKveYNf5+/rtMKDP71ZOXiv8kh7PW3aTNmEmKl7YSUm4a711mpQYawWV04h8jw/kS/plO47eyGEMVjL/pJVxDitdMHOAjJjfhYjsEDKfMJT0SuBFCRCLUq4JA/hGqw1CDFoDlvMtzF+38oPJAg+F8kq/BEoKtEaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OttiX8dkr5GOmxnfRGIe2b2LN0yPpoU1mphxvrMo4Ew=;
 b=kyitg51eYkqJ8QTd4F5lN1yEV/uq34Y9XT0p5pDvApCATv32ztEWGlhuZDUHcfNH0MZgYvC0wQASrQySBhGCI6+EuyMItm3LRdwMGDJJs9hJvctshe1hGzrJCidZPNKJNlmi31ObBWxF52QM0Asnywov8EjxUPk4Z6BIFXudeyY=
Received: from SJ0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:a03:33e::10)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:57:02 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::b3) by SJ0PR03CA0035.outlook.office365.com
 (2603:10b6:a03:33e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 16:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 16:57:00 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 10:56:45 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>,
 <kent.russell@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v6 0/6] drm/amdkfd: Move gfx9 MQD to HBM
Date: Mon, 15 Dec 2025 11:56:24 -0500
Message-ID: <20251215165630.1172383-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: b4871634-2f1e-4df4-ad53-08de3bfaf75e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmpvaWpObWU4bFBFRStJSmNkODVYL3llRW45UVh6TS9ieFhIcGc0L3Q3Z3Z3?=
 =?utf-8?B?dUlFS3pQTkZ0cGhwVG1iWXZORHNKT0R0eEtKZFp2NlZ6cDV6MW8yb0hxaEVx?=
 =?utf-8?B?MzhOcmt0ZGFjbk85c2pQTzhpMkgrb3lYdUdaZlZlVlV4MG9xZkJiVWVRTitj?=
 =?utf-8?B?ZFhUbWhSajg1a2JvcEdzcmF0Z3B0Uk5mVXcrSnZFZkxrV0NtRnVxL0c3aVBK?=
 =?utf-8?B?NWo5M1dSQjBDTkZLTzI5NVRXdnBZbXZmeS83Z09ENU85eC9Telg2S01TdVBQ?=
 =?utf-8?B?VnE5azZQU1NiNXZVckFlS2ZvZEZpWXRwMk42bzgzK21zdU8yTzQwV1RzUnU5?=
 =?utf-8?B?SUFXL2o0M3Jrc2RpTnhVWjJTMTBDV2trNGN0bTlsdDFtaUVodXRUWWUraXdj?=
 =?utf-8?B?ZWw5RmE3RC9QZW9LL2N5blNjeUxmbndyeXFHRDc4SEdBSlVvRjJ2cTdyVzEw?=
 =?utf-8?B?NGJmeHN2U0ttMmVQSEpNSmZJejU4UktDM3RQeENrOUNmVWlWa05QUkNVMXBR?=
 =?utf-8?B?dE8wemVJR1d5eDlzKzF2bml6YXVzUnRSeXNSL25ZVU9VbXZoMnprYitTcVMv?=
 =?utf-8?B?aGJlZjJ5dUUwWmV3Q0JTeHl0bVVnZzBKK3Y0V3hFeXVVcHREUmdqSEc0a3pa?=
 =?utf-8?B?bVZzQW13UmVleXdVRFNXMUFOa2htSVBIZitIdEpDcUIvOUtvclJSWThnMFI2?=
 =?utf-8?B?VTNCay82bG95NWJCcm9YK0g2bjJmSEN0QTJnbzBka1VoQ1hVL0ZTZnBqSkQ4?=
 =?utf-8?B?SDBtTHBvM1M4SlVCSmluZ1A4dHIxZnNIMmppTnlGQ1V5NzVwODUwdFRES3gz?=
 =?utf-8?B?ZUY4MUJYZWp3MmxtTnFEWjd5ekxyVEJwN0pMaU1OZGhWY3o3cHNaVWVUdmdE?=
 =?utf-8?B?NitEdmdXdmRrZGxkM0FMamhuOGFnbnVrZ1p1ejA3L2RJRndRTzJZeDNBMTl0?=
 =?utf-8?B?VVhNZ0w5N0tQakpzRTNhVmVZNmszVHl4YURVODNheFJsUFVvYXZIbFVXU1F0?=
 =?utf-8?B?YkVSRGxHa2FHd1RGTTBhWmdtT2k3VUtFdzlVVFRhKzhkTndrUm1iRFhWU3Uv?=
 =?utf-8?B?TTZyNlZuRHRCdE5ld1dVU0gyaWVzOExMc2JOb0RKRGVjYThiK0UzRzhGcm1E?=
 =?utf-8?B?TFFFeE5Ga1c3OS9aQnlIanM4UlZKa2szb0o2bmlVK2ZLbSsxWVg0bjZ6VUJK?=
 =?utf-8?B?eFFYbGU3VnVxU1JjNUFzV0hxYWE0MiszaXlYd3dkR04rMjZHMGlQRk5WNjhT?=
 =?utf-8?B?eVZIT1JTWG04cmp2aHF5ZWg1ZW41cXNFVXF5VUtncVU5aEVxMVdZdi9ZL2xi?=
 =?utf-8?B?T2lQK1lBWEJPUUhhZFEwdEhNd0NMaUdTS09hRGJhRklBTU5NT2xnKy9ra1pl?=
 =?utf-8?B?QmNOdUFWSzQ2QlJaMFNOa2N5ZUxrRnVXOFhyVk1vRjRhZUhQaVE5YzN1ZGdU?=
 =?utf-8?B?S3NpWWRRWnRRS3dJR1lyQzV5UGNIbWQ3WndwOWprWkt6cDRTT2FjOFoxRUdt?=
 =?utf-8?B?aXVWSGdFQXpXZ1l1a1Q2VUxFbFNYRTJveFJsbkpnaFBlQWZGYXRkTGN4NitI?=
 =?utf-8?B?aXBpV2ZpYmhzVnN6N3dUNi83SXRGUmZaOHpDSjNXaW0vK1R6aW5reVRuOW92?=
 =?utf-8?B?VkQwelZjSHJxSzFLOEM3Y3QvdmdTbDJkaUU1YmRaWmRxNVNETHYzc3B1N2Zv?=
 =?utf-8?B?OEk5Ny9oRXpMbVJSczI0aUhhRSthRUNjdFNFM2U0SnM0amZaWGxTV3JvQjA0?=
 =?utf-8?B?TEVoT1d0NUxjNGw5U3ZkVVE4MUIyb0xwN0grd3d0UExKZTRna3hYZVQ1eFo0?=
 =?utf-8?B?NlRwY1hDb1hjK2d2blpJSWxnbGdPMndxSzlKUGs1SFNyNUNHVnI2UEQ3UWY1?=
 =?utf-8?B?RkFEYkZwYU9pMzc2bjh6ZU5qRThBMUhOeWJoeW9tODFLQ1RXeDA3TjFmTGN5?=
 =?utf-8?B?amZ3TjZsUXZwejl1ditCVi9uRzMzQ28xdy93Q2xtWXpnd3F3NytBZkVOMlJm?=
 =?utf-8?B?MTlIcHJzTlc1NFJHRFljblRpZnJ5VlJqajE0S2tzN3lCdDNBV01UMmdUUTNs?=
 =?utf-8?B?bTNFM250V2VubTVFYXRTWkNIdVdheVpWenoyT1IxY1pEalM3azE5MVhXRmRx?=
 =?utf-8?Q?zYeo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:57:00.9894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4871634-2f1e-4df4-ad53-08de3bfaf75e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630
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

v6:
 - patch 5 remove color parameter from the helper
 - patch 6 changes suggested by Christian
 - add comment at the head of the functions
 
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  13 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   6 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   |  48 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 101 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   3 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  13 +--
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  16 +--
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    |   4 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  18 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   2 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  12 ++-
 17 files changed, 220 insertions(+), 49 deletions(-)

-- 
2.50.1

