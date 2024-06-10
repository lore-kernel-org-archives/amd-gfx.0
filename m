Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE6FC27C55
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jun 2024 18:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5EB810E3AE;
	Mon, 10 Jun 2024 18:04:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FSt1ojcO";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 528D410E2ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 18:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8caFZ+Jd/d1bowFi4NZBYdkQP1ChVtOw0l4kbREj0QjwkXYcrhMwlFi2XzrHpzeHhE3d1VH2TnxT4h9cdsPrAbhrQRWahXFDbEK2iW6U2eUsv8PqhA3ZK2cvMqguPjuEGX1s2GOfuE8ORcWbpzO6uQkZnwM3AmlwI1NhVqByfee7K7lVRWZjZdGRlPjiHaFONT+dRGRy9cZTzDKHuB1OMBznIF5wlBYOdtVxumi992Od+at4h9aepnIXwXJZ/gfZH1vVUQDGn8AxZsMeFvHAAIpFHYK7zdGvbzmGboinENZf066H1WFAIAYW4AuKkLZkH4tKjv57QZUGOvAx7S7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bsd8kRI1vyvmTRn7BT2ufjZHaswQ9tmZe48xpl5PXOk=;
 b=HCoQBWRJzY2Jd0Hz6BKswjJeC1G1jOwFKibwaG6dJ8b1f6Z84/hXmPIkzZz9q1hoJBU+mZRKy0dDDYXyQintNG0JcdBE14bwfYG2i3GiltMPs4vkAZF1exgeh3pvx/nmo2lkTWX5OZxR5RbOJfAob1vWYVHTKxnkGQNOXA10u71bCG62xxKVHAh1ZL02miUhCPj/g4v5/CSDcPdG8SyabtH4ZigQu1tBp1eWMo5IojlE5qVHFfEc0PgLcUNJWieoay9n9hA4Y8+PHmSU8hPId2UojEPZmAGZ/XcZqV9ULQ0XS86AmNy0TANjaAh/KP0pbs7k7gPBfqxQSK/HeC24WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bsd8kRI1vyvmTRn7BT2ufjZHaswQ9tmZe48xpl5PXOk=;
 b=FSt1ojcOtqGQBIKqjmxadiDfXsVJUM2C/TcweBzI6GeZ9UaYp1zuRp7/9sB2DchD3hGlEEhzCuPXENmPBx9ZaNEoluv4Qrtbu828nCPc8VvBMWsQnGur2repBtmZN41HdR4GtXamix4Ql7fx1a2TDPfzOIMsa3P5O3Q8u46O5Tc=
Received: from DM6PR06CA0023.namprd06.prod.outlook.com (2603:10b6:5:120::36)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 18:04:19 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:120:cafe::44) by DM6PR06CA0023.outlook.office365.com
 (2603:10b6:5:120::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Mon, 10 Jun 2024 18:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 18:04:19 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 13:04:16 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <mario.limonciello@amd.com>, <tvrtko.ursulin@igalia.com>, "Arunpravin Paneer
 Selvam" <Arunpravin.PaneerSelvam@amd.com>, Mikhail Gavrilov
 <mikhail.v.gavrilov@gmail.com>, Richard Gong <richard.gong@amd.com>
Subject: [PATCH v3] drm/amdgpu: Fix the BO release clear memory warning
Date: Mon, 10 Jun 2024 23:34:01 +0530
Message-ID: <20240610180401.9540-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: c1dc269f-9c65-48c8-b11f-08dc8977c010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZS91czRYMDRJYzREMWJOcitFR2lqdHlMOWpyaUJQUXFvQUdWNmpCU0VKUytG?=
 =?utf-8?B?c0Q4YTk5M2o1Y1BlemNuQTBvR0JEYkptTEpLbXFOZTBob200emJBb0twREpX?=
 =?utf-8?B?cmY5b0RYS1dBUHJ6UjN1QjZOc2JVUVo0VnpUMnp5OVZIUWJHWGhmck5CQWlw?=
 =?utf-8?B?SytxZFNmQ3pCZSsrTllET3RucGpnZWtuek4xMFZnT2p5bXI0QldOZlJrelRS?=
 =?utf-8?B?OTdHRGRWcVlKZ1F1S2RpQTQvdzNwVmtmeUxhTXVBOHEzRVJNWHlQb3F1bHgy?=
 =?utf-8?B?TUZicHB2Z29CV3dnamdTajhRd3EreVZuM3ZaOWhkby94dDIrKzF2dTk2dnpl?=
 =?utf-8?B?cVhQd1JTcmptU0hZV240NUx0QjFBcTRBOXVmMlp4QjdwdHR6WHA0UzN2YXhD?=
 =?utf-8?B?bkRHMEgxM3VTaGZkaFJpMVFlS213dXlremhzTm0ybkJkTC9ma1Z2MlVOY0JV?=
 =?utf-8?B?Vmt5eTZXQVRSLzRta05RakdFRzliaWJLVFVCVklGM2lEcDJNTnJocldLeE12?=
 =?utf-8?B?WDJZM080eTBMaGNKRjlFZk90ZVBEWVoyMC9HWklPanVqZnpvL3pqY2lsUy9Z?=
 =?utf-8?B?TGFhelhxb0JETXcwaElTazJIU0xlQ2lEYXNkT3Y4anUvS1JSV0RUK2FpaEx2?=
 =?utf-8?B?Q3BtOUI4QnZoODN4MStyQlF4c1U2c2dOdU8yZnR5MkVobzF4ZzMzSm54WThh?=
 =?utf-8?B?dFBpK01uR2dub2NRZ1ZrQUxFTnlnNUZFU1Juc3kvSi9lSWh6dkpVTnBKd3Ja?=
 =?utf-8?B?Z1g4bHdIQVlQOU94S21xb0hNRjhTNHpXL2luakhLVTNSNEd2M1JTSWJTc250?=
 =?utf-8?B?SitqL0p2NzExK3lhT25RWWpuaFN3SHdOMHlneXFxT01rMXZYTmY0NklBRmJv?=
 =?utf-8?B?bWEwNDZQUW4rQldmUEhrTHBKWWxtSmlGaXRyL3VjdSswVWNMUC9IM2tuYUU5?=
 =?utf-8?B?V3JUTlExN1cvd1VwS0x2elVLdzV3VmViN0NjbFJqQTVTeThaU1dubTd6YkZi?=
 =?utf-8?B?YkRsL3pldEplc05TSEoxYjVlMjYraGhWTWtibWxKdlJFTG9aRTl0M1FQNE5q?=
 =?utf-8?B?Q2NKZzNNM3dZYjBCcGlITVFta3dLd1BKQ3Z3QzJrZUliUkhuMysxcm5FZnpp?=
 =?utf-8?B?ZEpiOHRpbFBQVGJrT3RnZFRKOFR1d3U1VEVrc2NsWnVCRjZab1lCWU1XRGt6?=
 =?utf-8?B?dk5KdW12RFd4TWUwbGxZU1FweDdFcTYvR2RkM3U5VXdpVk8zck1EUSs5bXlI?=
 =?utf-8?B?VE8rNUpXbnlMVUVsL2lqQmkwRm90MmduNUQwTllqUzVBNUdoS0tZbllhbDNL?=
 =?utf-8?B?dEs2cEVRU2ZPOXNrdm93cTV2NkMzWVNNK3Y5aDhCVnlqRElBaE92RVl3VzEx?=
 =?utf-8?B?SHNJQjZSYXorYTNENmU2Vm5ncXRzcEN5dVdpenJuV3VmTUR5UXpoYm16aFcr?=
 =?utf-8?B?c0tocm1XTVUzeXFhZS9YUG1YL09yVlZ6V0I3eUV0V3NWa3dCUWx0K0JUekN2?=
 =?utf-8?B?TlRhTEI3TFdNUW1KMXMwU1crTlg5Wkt1SmkzcFpkbTc1K0Zsc1duYVVYTDdr?=
 =?utf-8?B?T0ExdTR6ZzFmMXdaSUYzMnJmRkt1SUxybnF2YkdNZ1JxY1NmS1BsRElxU2pI?=
 =?utf-8?B?UkNGWG9VQ0hqVlZwaXRBeFUwdm5veU9WN3ZaYytSckVWQzhESm9taDZjSHZ4?=
 =?utf-8?B?aURxQXcwRlMrVVhRVDJnUUtqMFVDQWFaa2JLbDJrVVVFU3RKVTFJY0lLSnZC?=
 =?utf-8?B?eVRCWlB1dTFPYndJdFBwN1Zob0NuSXczeUdEMVhvVlhaaWovY0NwZ015K2o0?=
 =?utf-8?B?dkVYT1pHZUt0RHpvNHNXN2dzWCtVUU1nRWpMUHl1TkQwTkVKSUNvdWU3Z3pi?=
 =?utf-8?B?cjk4bUlFYVBHYkd6K0w3dHJKVlVrS085RW80MEcrRlMxWWc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 18:04:19.4950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dc269f-9c65-48c8-b11f-08dc8977c010
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295
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

This happens when the amdgpu_bo_release_notify running
before amdgpu_ttm_set_buffer_funcs_status set the buffer
funcs to enabled.

check the buffer funcs enablement before calling the fill
buffer memory.

v2:(Christian)
  - Apply it only for GEM buffers and since GEM buffers are only
    allocated/freed while the driver is loaded we never run into
    the issue to clear with buffer funcs disabled.

v3:(Mario)
  - drop the stable tag as this will presumably go into a
    -fixes PR for 6.10

Log snip:
*ERROR* Trying to clear memory with ring turned off.
RIP: 0010:amdgpu_bo_release_notify+0x201/0x220 [amdgpu]

Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Tested-by: Richard Gong <richard.gong@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 67c234bcf89f..3adaa4670103 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -108,6 +108,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 
 	memset(&bp, 0, sizeof(bp));
 	*obj = NULL;
+	flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
 
 	bp.size = size;
 	bp.byte_align = alignment;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 8d8c39be6129..c556c8b653fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -604,8 +604,6 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	if (!amdgpu_bo_support_uswc(bo->flags))
 		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 
-	bo->flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
-
 	bo->tbo.bdev = &adev->mman.bdev;
 	if (bp->domain & (AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA |
 			  AMDGPU_GEM_DOMAIN_GDS))
-- 
2.25.1

