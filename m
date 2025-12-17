Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90752D6409D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 09:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E83010E34C;
	Wed, 17 Dec 2025 09:22:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bpxH08yN";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012000.outbound.protection.outlook.com
 [40.93.195.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8DCB10E34C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 09:22:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZ/j5lKl/jzfN/HAnFkS0932kDBqc2Z/WRsZqQJhheQ4B7K46vhXJSrdcUy00Vjs2kuZ3dt6115z7AVfI34J51R/Vv2+K0x8gTCIBrdKy0xCQwkuq7W95unr6b6g4KBmySDCJNF8os6cDS6PhzfvL4x4FDlM8ZifKJxjRvzNzE61BLCSoRxsCACcCV0uY8Pj5+9cXmLSUgKuu/8KAdA4iXdXkiO81iLgFwAT2u7oacoMYXVebgw9dmceyRj7p1hs8hi20K+jo4C7ThF5oeMLoxYzP+EJ1NgQz7kNjRTnDEpbFVCzniyKR986wry6gmYXztV7MBQhxAQQs/+SGcdgcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=We9BflaVXAfErckdC7K18Pcca9sngsYdPH5w6poVtjw=;
 b=Qsf0OOjj4RlC96/f0N44T5pJlFVT2txeWLSFHEG7Is/mRKNrXFgZU0F2zbcOwPoi/Wcr4WORRR4WWbY+2sYRFIwcmCh6O5FaTK8TzTfbEdLnN5Cc/FH3AHJeksZMXq6qGNIGVrZiiJp1TewAcemxaH96a9V9otGbCxgqR9HmQOC9lZ+WMHdJxMhkr6GzaCFVzJQ91dfSaLw2X0s4HeLAL4bFNuYKe3RGpOAG+FOo/6mshg3MWpRYsfKl5WLQYN092QGxf+RTxIuLuoeecly55j+6Jw/bVquiiBzkWZFI6otS5wLhUrAHwq4QKxo2xi5Ca6YiOo9a1wMBkIBGqGUZsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We9BflaVXAfErckdC7K18Pcca9sngsYdPH5w6poVtjw=;
 b=bpxH08yNmXqLDhyAdiEYnn9gPgYFg1Jrhlu0lfEZZ4V0X+wRoCeExH7GmHDolyMbLc6bwKvKr/DJ46RDY6D2PFRQakAyzbFH+t5OVgbumKdCo5Zkz55pI4nhEe+4NJ5b9rDP92KmPuMDSE/BdK8Jhyo4DlG4D8DP1TOcUANv7ug=
Received: from BYAPR04CA0012.namprd04.prod.outlook.com (2603:10b6:a03:40::25)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 09:22:36 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::c7) by BYAPR04CA0012.outlook.office365.com
 (2603:10b6:a03:40::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 09:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 09:22:35 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Dec 2025 03:22:32 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Leo Liu <leo.liu@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, David Wu <David.Wu3@amd.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 3/3] drm/amdgpu: Drop MMIO_REMAP domain bit and keep it
 internal
Date: Wed, 17 Dec 2025 14:52:00 +0530
Message-ID: <20251217092200.703080-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217092200.703080-1-srinivasan.shanmugam@amd.com>
References: <20251217092200.703080-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: d33e5bd8-d653-4472-d13a-08de3d4dd0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUVXZ1NVa2xha0lzRHZnMGlidTh4U3d0Uzh4d2hMMW1sb0gveXRJbnp1SllB?=
 =?utf-8?B?OTVRVUl1aEtyY3RveXRJRGpQV0xKK25USVQrZ3l3UzR4cEhPZnBMSGdmV1RF?=
 =?utf-8?B?bkhvbzZwOWo0SkpyeDZvWEhzSVBHR3NPYmZhNHIzdGpUSU8wV1ZuZG5uQll5?=
 =?utf-8?B?UEFhK3VnYWdZTVZLR212SzdwT01FM1FyWVRnSUJnTCs1U3FrUnlTKzJ2MUor?=
 =?utf-8?B?enhUa2xjSjZ0V250bkJOOUl4MTFJbDJMNTFubVFoY0w5bHIxL2l4VTVHRmFk?=
 =?utf-8?B?U2RMNG1qcllLTGlJQTR2UUtWYm1OUm1BRTJFdlJCWUdSWENxU09oSFNzaEpt?=
 =?utf-8?B?WlA4OU5jeU9LMkd1ci95ZDRCNENidDlKclZOenBHdkhTcGZoVTNHMmdueGMz?=
 =?utf-8?B?QkNPZ0s2bFRDVG83clVaaGZZY01SUFBweXptaDE0SENQQ0FDemZTV3RkNGZh?=
 =?utf-8?B?aFV5bFNIZU54TW5rQ0djN1UrS0tVUlNpc09Cb0lCM1UwNHpiV0FYYVJjUVJN?=
 =?utf-8?B?VzJkTWhIa3N2cjJBRi9pekJHM1JNenkzaFc3bDd5eWJrQVBXaUY5Uit4UzZ3?=
 =?utf-8?B?cnpqSTZ5Q2RWNjEvclBpLzFRMUhvaHJmYmdtdk01MlBHTXh4Q2JFSE5RRFRO?=
 =?utf-8?B?NXBZLzVEUlJ1TXAwcmxKTHhZS2VKUDVOZ2JYK1ZkRFo0UHVxK0V6dVFSSU9Z?=
 =?utf-8?B?ZE96dk45d3RXay8xMHhsV2ZBazA3dFhxTTZpU2pBQkZUN3hSK2greEdMQXAz?=
 =?utf-8?B?b05YUTdpMTcxTDRmOXFmbGFOSTRaSWNHdFl4SUZpMThOVkRscGdUL05LeEpQ?=
 =?utf-8?B?emtKMG5wMkYvVVRlYUpIYW14ZFRKcWc5VktadHJqM2YvTk9RU2RWRURmMUk5?=
 =?utf-8?B?TnF6MU1wTFkwV09QMmt4VEpBUUhmdEs2QTd2U2NRM1JHM2hnZGVPRjRHaTEx?=
 =?utf-8?B?aVVXekE2c3owVFVmamlpVVFYeFpndXgrYmNGdjlBUDE3dCtjcGxMNFlZTGx0?=
 =?utf-8?B?czBHeGVHblREQjJXUUkzc1hwQ1hSZThFa3dMU1dWY2pobFg4ZkxnSGJPRjcz?=
 =?utf-8?B?aWR4U25rTjlsckZtV0todjZKZzY5V1dMRzAxbEVFNXlSSENqRm1yMXZBaXhX?=
 =?utf-8?B?U3BwMTMrQ2gyR3g3Vm9ncEpiTHcrdFpMYW1Ea0xNZTNYVGFHNG13VEFSeDAx?=
 =?utf-8?B?dEliMkZQS2RvTmNnaENXZE9LR1BMN3AyaEtUVXNDeFlsMnB1SEFaL0JJWGg2?=
 =?utf-8?B?Wm1MNnliMFVPTGtOM2hWWHRrYm9QSVFnVUdMV3U5MGpqTTBCeFpWUXNjNTM0?=
 =?utf-8?B?WmNtV2FYQW85MXVzVWZaZUVkN0QwZE9Rc3V3c2xCMmtVenEvaWRhRHRERlBG?=
 =?utf-8?B?KzdhUS9BTlRqeldIcVdQS2krMEZ3YlhuVWowUUF5b1NvL25xdjhqTUhIZVZ4?=
 =?utf-8?B?QWY4cnIwU0FKdzNyN3N5b3huSVB4SGptRDhmV2MycHk4ajQ1M0hlVk9ZQXpv?=
 =?utf-8?B?VGNZUVduYlh6K1V5SGhLQ1NxeEtySUxlVjUyeXdzaHNhaDk2SkhOSWh2eGpv?=
 =?utf-8?B?UU1SbGw1VGRCcU9EeHkyVUpqSnZlVVZaS0tJdUZaL0lMTFk3QTJLTU8xa1pv?=
 =?utf-8?B?aVJKalpIMm5iaTNDaU9OeDg2NkZSY2RxSTlRZ1F0OWhRRzhKTk5TODNJTk93?=
 =?utf-8?B?SmJkcHdUdWVCL3V5VUh3TVZhL0gxVCtYZ3Y3TmdrdEYyc2l6K0pUN3JZL2JH?=
 =?utf-8?B?T1d3bWlCUUhRR2xKK1RDcjNvQVVlZ2puZDg1ZzNRaWpyeno2VUxzd2h6UDJO?=
 =?utf-8?B?WHk1S0txMzBXbGVJRlNuSW5BZkdkeDIxdVRHU2w2anBGL3BiN3V3aFJKOXUx?=
 =?utf-8?B?Nm9DQTZ0ZXlJMFl0M2lZQzE0UmxJQUVKSFlEeURCWk5wUVIxTEpZNDBpc1pq?=
 =?utf-8?B?ZSt6V1lVc04xUGhDS0oxN1p5RmF6cXhkTXg4SlZrd0pvbGFFK1ZaTjFrTjZt?=
 =?utf-8?B?YStsdmdqdGJBTnpMUTNGdkNlOHd1VWRCcUJNN0dzZWRJeTJNU3IzenAvckFk?=
 =?utf-8?B?RG01V1FyL1VUWm5XQWJ3bjFJK3Z0ZUhCN0V4SHl1amRNbFJsU3FXQmQ2Zmh5?=
 =?utf-8?Q?vt6c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 09:22:35.8491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d33e5bd8-d653-4472-d13a-08de3d4dd0e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

Never activated as UAPI and it turned out that this was to inflexible.

v2 (Srini):
- Updated patch title.
- Drop use of AMDGPU_GEM_DOMAIN_MMIO_REMAP in amdgpu_ttm.c. The
  MMIO_REMAP domain bit is removed from UAPI, so keep the MMIO_REMAP BO
  allocation domain-less (bp.domain = 0) and rely on the TTM placement
  (AMDGPU_PL_MMIO_REMAP) for backing/pinning.
- Keep fdinfo/mem-stats visibility for MMIO_REMAP by classifying BOs
  based on bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP, since the
  domain bit is removed.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Leo Liu <leo.liu@amd.com>
Cc: Ruijing Dong <ruijing.dong@amd.com>
Cc: David (Ming Qiang) Wu <David.Wu3@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 21 ++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  2 +-
 include/uapi/drm/amdgpu_drm.h              |  6 +-----
 5 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index a381b8ad9d29..950e3f1e83cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -458,9 +458,6 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	/* always clear VRAM */
 	flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
 
-	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP)
-		return -EINVAL;
-
 	/* create a gem object to contain this object in */
 	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
 	    AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 415d8d88bbb6..d736779ae9c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -153,14 +153,6 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 		c++;
 	}
 
-	if (domain & AMDGPU_GEM_DOMAIN_MMIO_REMAP) {
-		places[c].fpfn = 0;
-		places[c].lpfn = 0;
-		places[c].mem_type = AMDGPU_PL_MMIO_REMAP;
-		places[c].flags = 0;
-		c++;
-	}
-
 	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
 		places[c].fpfn = 0;
 		places[c].lpfn = 0;
@@ -1546,8 +1538,17 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
  */
 uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo)
 {
-	uint32_t domain = bo->preferred_domains & AMDGPU_GEM_DOMAIN_MASK;
+	u32 domain;
 
+	/*
+	 * MMIO_REMAP is internal now, so it no longer maps from a userspace
+	 * domain bit. Keep fdinfo/mem-stats visibility by checking the actual
+	 * TTM placement.
+	 */
+	if (bo->tbo.resource && bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP)
+		return AMDGPU_PL_MMIO_REMAP;
+
+	domain = bo->preferred_domains & AMDGPU_GEM_DOMAIN_MASK;
 	if (!domain)
 		return TTM_PL_SYSTEM;
 
@@ -1566,8 +1567,6 @@ uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo)
 		return AMDGPU_PL_OA;
 	case AMDGPU_GEM_DOMAIN_DOORBELL:
 		return AMDGPU_PL_DOORBELL;
-	case AMDGPU_GEM_DOMAIN_MMIO_REMAP:
-		return AMDGPU_PL_MMIO_REMAP;
 	default:
 		return TTM_PL_SYSTEM;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 52c2d1731aab..912c9afaf9e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -168,8 +168,6 @@ static inline unsigned amdgpu_mem_type_to_domain(u32 mem_type)
 		return AMDGPU_GEM_DOMAIN_OA;
 	case AMDGPU_PL_DOORBELL:
 		return AMDGPU_GEM_DOMAIN_DOORBELL;
-	case AMDGPU_PL_MMIO_REMAP:
-		return AMDGPU_GEM_DOMAIN_MMIO_REMAP;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 10211648d498..fc679c8e59aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1938,7 +1938,7 @@ static int amdgpu_ttm_alloc_mmio_remap_bo(struct amdgpu_device *adev)
 	bp.type        = ttm_bo_type_device;
 	bp.size        = AMDGPU_GPU_PAGE_SIZE;
 	bp.byte_align  = AMDGPU_GPU_PAGE_SIZE;
-	bp.domain      = AMDGPU_GEM_DOMAIN_MMIO_REMAP;
+	bp.domain      = 0;
 	bp.flags       = 0;
 	bp.resv        = NULL;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 283410a19dbd..9e4692c270fe 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -105,8 +105,6 @@ extern "C" {
  *
  * %AMDGPU_GEM_DOMAIN_DOORBELL	Doorbell. It is an MMIO region for
  * signalling user mode queues.
- *
- * %AMDGPU_GEM_DOMAIN_MMIO_REMAP	MMIO remap page (special mapping for HDP flushing).
  */
 #define AMDGPU_GEM_DOMAIN_CPU		0x1
 #define AMDGPU_GEM_DOMAIN_GTT		0x2
@@ -115,15 +113,13 @@ extern "C" {
 #define AMDGPU_GEM_DOMAIN_GWS		0x10
 #define AMDGPU_GEM_DOMAIN_OA		0x20
 #define AMDGPU_GEM_DOMAIN_DOORBELL	0x40
-#define AMDGPU_GEM_DOMAIN_MMIO_REMAP	0x80
 #define AMDGPU_GEM_DOMAIN_MASK		(AMDGPU_GEM_DOMAIN_CPU | \
 					 AMDGPU_GEM_DOMAIN_GTT | \
 					 AMDGPU_GEM_DOMAIN_VRAM | \
 					 AMDGPU_GEM_DOMAIN_GDS | \
 					 AMDGPU_GEM_DOMAIN_GWS | \
 					 AMDGPU_GEM_DOMAIN_OA |	\
-					 AMDGPU_GEM_DOMAIN_DOORBELL | \
-					 AMDGPU_GEM_DOMAIN_MMIO_REMAP)
+					 AMDGPU_GEM_DOMAIN_DOORBELL)
 
 /* Flag that CPU access will be required for the case of VRAM domain */
 #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED	(1 << 0)
-- 
2.34.1

