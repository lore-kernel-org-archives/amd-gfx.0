Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D51CA0EFF
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Aug 2025 07:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEE1A10E1B7;
	Sat, 23 Aug 2025 07:20:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gDYxMl5i";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2767410E1B7
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Aug 2025 07:20:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWQM3CaOv7oxeLu8OrPl/kK223hTeRwXe9aaGXQJi/nyKA7zhiWsuT4kpdJutU32JdrJDEBhDL0VTicrM9zkFxTm4vtWlcWoH10kk7TLvvXesLL3kopTv1dPvFB+fd6MDAfDeJqSFrNPoeQJp04GjL9O7jupjMc0b4XoWRDLw6OSckTgrcpVZZmr5KYpVX9LWUDLEvHlzj04yx14Ap9J5ERrKv60lpH9QYQ+qNCY6D/zqZ3rluBNdAolIucp08MX2y+6sxRwMPbA4fZ6sMroaukK9omkf5SVBPC+okpvuVsCPtqL3fb6Jm8/jHUi7yd7qa7PIsmQPLtX826hnCnOHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VR09ENATYBf1UDKqYVtLTVkp+dM8ZkQVQIKYZFOzvY=;
 b=PYMPQO4aYwGJ3hsg5JXDKzcSGQbKipAg5PLp1ZWKHRc0er/1oF3zxgacdWR0nB83CouBQ9Z2MFbFZjNGvFYjpyv+5UeCXgBUzM/rAK3KfmjzMTHYp1Qojq3YeLy2mlbF3esEJnbCEM5T1VtPoh1/wlDFAnZHZnwOP6cre3ruw6u446o+74p6DCchcgMwFqwmO33z33RY9M28YCr+BZMqNoaJhv3v2HEmYWtDJ/Zp9ZgJWVtvQRLBmexDawbYdpvt/lVLJuJ8YftxTXeT2BA1YZUr60CkU0djBQrRFKcWJQ5V20/R1YE6YAYflDru9RfoRnASwgvwk/kVrq2heFGOig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VR09ENATYBf1UDKqYVtLTVkp+dM8ZkQVQIKYZFOzvY=;
 b=gDYxMl5iKx8wKILTZqZI/LcDP8R2CCctiVrRhMxmeI9eNILjtUj7GB8bXR7sxIJs3huy/6At/BYc6MnWajINVejt0OWnTY+5YkqrFEkDwLxbLZqbPym60f3H/5nSHzXu9cz5pRLHvjtDOjWgpJsO4bBEZhH6hm5QEqs1jvspa/A=
Received: from SA1PR04CA0002.namprd04.prod.outlook.com (2603:10b6:806:2ce::10)
 by LV8PR12MB9618.namprd12.prod.outlook.com (2603:10b6:408:2a0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Sat, 23 Aug
 2025 07:20:39 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::18) by SA1PR04CA0002.outlook.office365.com
 (2603:10b6:806:2ce::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sat,
 23 Aug 2025 07:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Sat, 23 Aug 2025 07:20:39 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 23 Aug 2025 02:20:37 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v2 3/8] drm/amdgpu: Wire up MMIO_REMAP placement and
 User-visible strings
Date: Sat, 23 Aug 2025 12:50:11 +0530
Message-ID: <20250823072016.1272328-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|LV8PR12MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b6ef09-0d9e-4610-21d1-08dde215902e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFlTaWdSWEVraE9memNXVWo3Vy9FQ1loRFp4NXo5VTBvM1Z1TDJRMVJTN3Nl?=
 =?utf-8?B?WXU1UEdQQkVEbnIzZXJhR05FMDFXWEZZelFBVktFU2YwTDBVSzliQko5NitU?=
 =?utf-8?B?K1ZNSnZzV2NuaUlndUg0enFtTUdOYWJUL3dRQ09KQzBXK1ZPaFd4ZEsxN0Z4?=
 =?utf-8?B?KzJuRFBBWVZ0NnhiMzhPdVk2VmVWTEVDSll1dDdIU2VaSmc4WCtCeUo0QTRt?=
 =?utf-8?B?YVlYSVNlTVdydHM4eVRkYkVzck5NK2MzWnJhMEN6OHNQR0NkZi9JdUhsclBR?=
 =?utf-8?B?Qy93K1ZROWNIRFBDREVCaWlJUVNVNk1MemRxMzJHbzZkSWxlSVQ4Tm1GL1lQ?=
 =?utf-8?B?R1Vnd0FIckE5cC9iZGEwVnZ4SWhLazVvK3JlY2grVER4UzE5ZW5pMENTcmkz?=
 =?utf-8?B?dkMwR3NXZlVZbVpKNXZiR3hGdzZYcUVRVkRSd2Nra3g3cjE3NTRMRVloOHZV?=
 =?utf-8?B?NFFhcFc1T1J5czZ1UzhoamNPVVlqWGN2SXpFTTZ4SWJmdkNSZ211UjJUVkZu?=
 =?utf-8?B?anp3Q01LSEp6ZXMxOFpnYWhYUHo5Z0VPWEZNankrTUxZTmxGTjZXV2IxOXBi?=
 =?utf-8?B?WEwwZ1Ntc2QxRmpaNGhROE1iOCtuVGJtUmxFa0w2NlhVVUFRVTVydEVyYXYy?=
 =?utf-8?B?MEdyNEZTdHd0OGZ3T1hYSS83RWVnL3dpak54alY0d2w2aDlRQzlyWU5uMnZW?=
 =?utf-8?B?MDZ2bkFwR29Rb1B1M0pucndNTlZYbFpCb3gwTjRaWWYzekV3SE84WUx5NGFa?=
 =?utf-8?B?c0lmeWJORFpMMmw0OXRERjFEL1pNU3lOZFowVXhFT2lPcUozL3lES2ZJejN1?=
 =?utf-8?B?Y0NPMjRxSS9HaGpCNFpHU2svT3gwelhCeSs4TVhJdUNMMVZPbWFhd2FZNTE0?=
 =?utf-8?B?bUNRVElYc3pNNGNoOThHNFdoK3hNMEExcjlmN0d0Z3J4RWl4T1VGYTRpZWJi?=
 =?utf-8?B?S21oSnAwd2lPMERtb0RWelRtaUJ2QkpDNWRNZkpSaG44MmZ0a3hlUk9yU1Zt?=
 =?utf-8?B?TWlVYUhPTjlOZlNIVG5aS1NaNXZKOUNCdnB2WVJ6V3JsWlJ2blBraXpuMERS?=
 =?utf-8?B?ZStjMXpnQ3MrU0lRN3JUeTNuZWh0SzJSZ1F1UWxzKzFhNFkvQlVPUmd5eXFI?=
 =?utf-8?B?UzNrc1EzbGpYZEpXaHVxbWwrQ1VDSEY2a1FmRnR2bDgzVjBCcVFwQTRLeS91?=
 =?utf-8?B?bmRHQmo4cW5KMG1pL0tQZTdXSTVOV2pGRllJVWdyQ0pOQkh4WGpJcmxadGs3?=
 =?utf-8?B?TUFoNG44VXpXZ3p6Q3AwMnc3UGhjMEFnMGNyVFdOenBnVHlqT092cGNLYnor?=
 =?utf-8?B?aG5XR04zdjNXVWFsK2QzQWIrZXpGNjlObzZsWU1vcWpXOEcrYU9DazRKbFh1?=
 =?utf-8?B?Y2xGQklUMXJrdzRrUGd0V1FiU0duU0Q3L2FBNjgzbmVOSnV3UTNhUkZlbkQ2?=
 =?utf-8?B?QVB4TkFkNFpsRnJLNXVqcWkxSkNZZkQ5TjlzNlFrQmYwckQ3REN6cUdYRWJM?=
 =?utf-8?B?Tm4xclM5bTZiU1h6Q0VVOUtiSXhhUTB0MVZqN05zZzRzQ0tzcGhpTUlJb0Fv?=
 =?utf-8?B?aDJMUHE5TVpVRDJtemRqaEhWZ2pvQUJQM0lrb2d4MTFKNWhXL09BQk1KMEZ5?=
 =?utf-8?B?dnU1Mmc1L2xHT3gyaHFGeVRqdVhWVHhKaVMrdU9zS1MwNzdqMVRSVnJTVnNj?=
 =?utf-8?B?STdmSVlkSi9pbDhTeFdYeVJqeFk2Zk1SZjNVaURSWE5BUGY5bm1FbHMvWk9J?=
 =?utf-8?B?Um5saWkxOGdycXJJK1A4YmJvSFJuSkNkNnJlNit4R290VjZmb2hmc0dRWTI3?=
 =?utf-8?B?T24waEFjNGZscnRJMGZOMis3QUU1R3JZUS9McnZmbEUxcDdTTWNZaFBRc1J3?=
 =?utf-8?B?ZnROQ2N4dDQ0TFJMZVM1RTd1dk1NeDMzZ3ZtRzZhWHFUVjhPNUxBZjI1UGIw?=
 =?utf-8?B?VUVhOXFaUFV5QW42TWNEaC9vOFIwYzRzVkM3Z3FMb21TL3RLTnF4bTg5UHZa?=
 =?utf-8?B?ZUxJOVdmakJaZXk3RnNyZFlyK1JwaDJjeXc1L0J1TFJ0S1YwVlJDQU05N3NC?=
 =?utf-8?Q?wZ/c9U?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 07:20:39.6960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b6ef09-0d9e-4610-21d1-08dde215902e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9618
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

