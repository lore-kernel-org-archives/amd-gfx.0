Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C83CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3E4110E8BA;
	Thu, 28 Aug 2025 09:15:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KCQqIJIe";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2AFC10E93B
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ef24LjJwjlPhpoFFI3Wmz2cDzjh6VK6VX/91nvIGsIxGYqzCFc7ar/0wAGCGOV39Am7vi5ucEgTd6lQkzA1tZliFMno4LK1o2KklPPWcPmQLTf0Ew+I1pKgwAQDSJrvaXsnnSMSKWsx2rzRUcTlkMfQ4GVsY/J5kLm4tywOmhAH0uy9Dkxr/RYe6vcMhpBkfLLl6LkxHW1SrDgmv5C/ks4RVNU8gu6e/Evr9+tr6gIBB5rPL8MjPUSTWZDMPALRU2sxFlvT5ZuzV1E5XabIyX1A0jm7aVLjNaW07nLXVMdwSNHV6huM5MzXXzPvXEMOGLmX1E6egSMvIJWMzAFW5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taaDMP9FhT4Bdh3JK7LFBH/INobN0hj2kB7Da8MP5Dg=;
 b=SMD0C6V4Oc0mFnNGaPgtTpZ9PRrHOP0JY7zjbrPDxcbeMsIrGqwCND4gWAE+UCyKiJJJE3vcSfujkCX4JS045BviJoJ53Y2E1lAdHIk/mQk/YYrs5+2ON0Ef7u9Akqo57wBkfkk5EVKcxYl6kse7/v8PBwosEMYqJxRRh2KXNUW3jdl+qevZ4QuH+KohUB0WJ6jPQSvKEhVD338BYmuOCHMKAozdmiVQAjcfD91I2+zrUU0Oqdgn8kANycgulUSPZ6J2biT4PKT6HwlZYMTEY4IMoRlg/lcQW2C4E6dmiyMdJM0Z1VpyLNQ5oV5ktdmCKmFXhTxvnnFHoiedVehM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taaDMP9FhT4Bdh3JK7LFBH/INobN0hj2kB7Da8MP5Dg=;
 b=KCQqIJIeZ6y8ECH/vx0ePkzccAp1qTIhduGCrbpZeNcYb4ai0ymoXRETQi2YjOOr62mE4C48ctJcWeORZtZz35w6gt9+78dRMUPX7UT5z8lwOpmFS7xaASXLqo7QX625ddGMudN8C1eCUnQNoDX6BKrA6m9RVTHw3BVIj6UMT9M=
Received: from CH5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:1f1::11)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 28 Aug
 2025 09:15:36 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::5c) by CH5PR03CA0013.outlook.office365.com
 (2603:10b6:610:1f1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 09:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:15:35 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Aug 2025 01:45:58 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 4/9] drm/amdgpu: Wire up MMIO_REMAP placement and
 User-visible strings
Date: Thu, 28 Aug 2025 12:15:25 +0530
Message-ID: <20250828064530.3948378-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828064530.3948378-1-srinivasan.shanmugam@amd.com>
References: <20250828064530.3948378-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: f972e0c8-69cc-4224-9a34-08dde61372b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnczWXpSckZVUkc5RFd3YlVOZE54Szg2SG15NzhRQ2JqR2d2czNTL3FYWEF1?=
 =?utf-8?B?Vkhub1hNQXFRNndDbGxpTHlObzZHdWpjRmQzaDRsdXFFREdNQ3FmNTN1Rnpo?=
 =?utf-8?B?TU8zT2p3VE44WkVFYkV5UUFaWW16c1NMZnJiTzAra0ROWUltdkl0a1JYNW1B?=
 =?utf-8?B?SXlyc1haUUo5QjdUQ2dRdStaaVp5SEdxU1BiWitWaEtKNktnM2JibnhnZlNq?=
 =?utf-8?B?K2sydHBUdnNEVnViUlZLRVpRemJXNEEwVWVOcEFZaGFaaTZ5d0dWU3piSEo4?=
 =?utf-8?B?Nk9NeHNoM2lxUlkzV2JuNHNDaFlWWlY4OW9Vd21ZL1huK1JRZm1YcTBNM3RT?=
 =?utf-8?B?eEg3ZHcxc2Y2OUdUUDNRMzl5TVhYV0ZTQXk4WGlDc1NQeHo2VG96UmRwYkRS?=
 =?utf-8?B?aytPNmlLSWh3Y0l6QTh0L3UzVGVselVpempCV3F1dVFaK1Z3TVIyQWU2M2U5?=
 =?utf-8?B?RGxLcy9UY1lUbSsvbHoxaThja2k5UElERFFQYytmVmRSb1NXam1TRWRvbS9Q?=
 =?utf-8?B?ZFVvUWEzNEZCa1picytyZ3ZaeU1WNWV3anVZSERVdWZOa3UzTGgxTEp2K1BS?=
 =?utf-8?B?QnNlRm5pa3pFNkMxSzEwUVpwcG1RWVUwN3ZpU1Q4L2VPaW5rR3lkT0puNDhB?=
 =?utf-8?B?QnR6ZjVnTkJDbUlzN3FpTlJGeXhwWVFhT3JuRUkydUFUbjEvK2p4T2doL0ww?=
 =?utf-8?B?Z21ENm1EdDdneEljR3d3czBCMVVOendrSzk4SzlyM3FFZTY1MThYUFMyZk95?=
 =?utf-8?B?YUJHcEtLSFJyNXI0dTI5b2Ezd1hpZXlWbTdtc01iekRWdDB0eVBqRHJqTlpx?=
 =?utf-8?B?UXJIY1Q2TnB3TVdiL0pBa0R6a2pNRHI3K05qbnVrWStlMGNMUk9pVDBqcm45?=
 =?utf-8?B?YUNJQ204R3FkM3pHTjY1anVTVEpYdS8rdC9ja3dmYmVkdHRnbUx5WnhVTDJO?=
 =?utf-8?B?S3JEdTZQZCtTMVpweGd2N3RrZC83QnBYUUxHMWZ5ay9yN0JONmduTjFwMjYy?=
 =?utf-8?B?VmE0QXYzZGNKVHc5QzFJdVNYREJDbGRWYUJ2UnFsWWNRU0w1RlV0VGFlVGZ0?=
 =?utf-8?B?Z21PSUt4Ry9kQkgyckpOSVgyMWdteWE3N2RFZUhDNlF0aVRlQXRPOHBYOGhE?=
 =?utf-8?B?bldONWJFUmJnaXdBZ0NkSnhCdW15a3lhWWpJU0h4V1lWMDE0Rk82bWhaNVBI?=
 =?utf-8?B?QkhJWU8yQjRSNllvN3RPbWYzUlg1OHBHNVNGRElTdVVYVUNPUVFTU01DSm5n?=
 =?utf-8?B?cE9NMzRYUmJCVlg4ZXdyQnVIQThrN3VNalFJZDlzbFp2ZDhwMFhndElPMit3?=
 =?utf-8?B?VGNHQTltZGdzQS9hWE5TYlZiSjF4OFJ1cHg2c0lLanBRdWRwcnJQdlp2WTlx?=
 =?utf-8?B?d1FRRzFYY2IweUZkMjY3WDNncmdXcGt4VEV3VzMyTm0wMjMzRlBLSCtacjMw?=
 =?utf-8?B?ZDVRY3czM3JBMGIzRWlkeTN2NmJiUllJeVNRUFpPL0NyQnBDVkdoRm1oYStM?=
 =?utf-8?B?NEJFUEVRb3JueGN4TDE0R3l4UmZwbklTMzdRcEorWkdFOTdhRFBUUVZUWkpX?=
 =?utf-8?B?elB0bXJkUUpZSFlMNzlWUnFKaDRyWkhIL29BVE03VTFvdHZVM2FmZ3M5OWNI?=
 =?utf-8?B?aHM3R0lQODBwaUM0eEJEak0yUCtwd0lrejAya3FSMnVoTkM4Rk9Ic3Q2a0pz?=
 =?utf-8?B?UkFIMGpnbTcxeGI4NnpoQWlMdXljM29DbXFhWjlpczEwcGxOTE1BYi9xQk1H?=
 =?utf-8?B?Y2JXQUM5RFRPeXp5Zmgya1RjMGJuVXZFWitSZDBSL3hhcGgvKzdRSlJFamM0?=
 =?utf-8?B?T0RXMFZsMjFxejZzOHhRRzN3VWJHanZWaU5LaUtVRW5kUEQrTVErZnltazQ0?=
 =?utf-8?B?UGIrNXRHSWZ4SU9iU3pLeS9ubzBWYUlrSE5FTXdjL3NtTHNreUJjWnQ5K05V?=
 =?utf-8?B?S3FNUHBFdEdWZXRoSlBGV3dnT1BUS0U5VVVMWFV6M3FqQzFhWWVtVGJUUkti?=
 =?utf-8?B?cUI5QzZZbkNYMnpOTXpuSGo0QWlBajd3VE42bU1SYlNIemVmVWNicTRIWit2?=
 =?utf-8?Q?Lg6L8b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:15:35.9001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f972e0c8-69cc-4224-9a34-08dde61372b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833
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

Wire up the conversions and strings for the new MMIO_REMAP placement:

* amdgpu_mem_type_to_domain() maps AMDGPU_PL_MMIO_REMAP -> domain
* amdgpu_bo_placement_from_domain() accepts the new domain
* amdgpu_bo_mem_stats_placement() and amdgpu_bo_print_info() report it
* res cursor supports the new placement
* fdinfo prints "mmioremap" for the new placement

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c     | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h     |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h |  2 ++
 4 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index 91d638098889..b349bb3676d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -70,6 +70,7 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 		[AMDGPU_PL_GWS] = "gws",
 		[AMDGPU_PL_OA] = "oa",
 		[AMDGPU_PL_DOORBELL] = "doorbell",
+		[AMDGPU_PL_MMIO_REMAP] = "mmioremap",
 	};
 	unsigned int hw_ip, i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 122a88294883..fe486988a738 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -153,6 +153,14 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 		c++;
 	}
 
+	if (domain & AMDGPU_GEM_DOMAIN_MMIO_REMAP) {
+		places[c].fpfn = 0;
+		places[c].lpfn = 0;
+		places[c].mem_type = AMDGPU_PL_MMIO_REMAP;
+		places[c].flags = 0;
+		c++;
+	}
+
 	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
 		places[c].fpfn = 0;
 		places[c].lpfn = 0;
@@ -1545,6 +1553,8 @@ uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo)
 		return AMDGPU_PL_OA;
 	case AMDGPU_GEM_DOMAIN_DOORBELL:
 		return AMDGPU_PL_DOORBELL;
+	case AMDGPU_GEM_DOMAIN_MMIO_REMAP:
+		return AMDGPU_PL_MMIO_REMAP;
 	default:
 		return TTM_PL_SYSTEM;
 	}
@@ -1628,6 +1638,9 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 			case AMDGPU_PL_DOORBELL:
 				placement = "DOORBELL";
 				break;
+			case AMDGPU_PL_MMIO_REMAP:
+				placement = "MMIO REMAP";
+				break;
 			case TTM_PL_SYSTEM:
 			default:
 				placement = "CPU";
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 87523fcd4386..656b8a931dae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -167,6 +167,8 @@ static inline unsigned amdgpu_mem_type_to_domain(u32 mem_type)
 		return AMDGPU_GEM_DOMAIN_OA;
 	case AMDGPU_PL_DOORBELL:
 		return AMDGPU_GEM_DOMAIN_DOORBELL;
+	case AMDGPU_PL_MMIO_REMAP:
+		return AMDGPU_GEM_DOMAIN_MMIO_REMAP;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
index 50fcd86e1033..be2e56ce1355 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
@@ -91,6 +91,7 @@ static inline void amdgpu_res_first(struct ttm_resource *res,
 		break;
 	case TTM_PL_TT:
 	case AMDGPU_PL_DOORBELL:
+	case AMDGPU_PL_MMIO_REMAP:
 		node = to_ttm_range_mgr_node(res)->mm_nodes;
 		while (start >= node->size << PAGE_SHIFT)
 			start -= node++->size << PAGE_SHIFT;
@@ -153,6 +154,7 @@ static inline void amdgpu_res_next(struct amdgpu_res_cursor *cur, uint64_t size)
 		break;
 	case TTM_PL_TT:
 	case AMDGPU_PL_DOORBELL:
+	case AMDGPU_PL_MMIO_REMAP:
 		node = cur->node;
 
 		cur->node = ++node;
-- 
2.34.1

