Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF489CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 05:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9318710EB35;
	Fri, 29 Aug 2025 05:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DByNBSm9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4757E10EB35
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 05:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K38462a88Unx+pbePE5EH7tUCQ1hiZF+ZAmY1IAjH6mlBAFwLhIK01seSrTyNr9CAz1k1myEfRmKhAmOUTBh3sImzz0d9g9kQ7cqni/OwIARSkg9LWwweUdho32cyVcwjKnIx1gsEqwZa65mhEdrVAH2sUYtKID6SD6C6kRG8Z3tMHuzXQwMKoCAd22WUCGWrtZRCoDoO+z+mrdl14C1mZV56xqqCBKA23fsGz0ELd3RE8WGCQZJen6rm4gHVcdrxpU/fg1ZPys25mzz0rowiYUGn5Eu+yggHH0x640Zz3euIec3Vo+4p6UQyKkV6riMR1MxfH1vXghjre50VCXpvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkzmcPHuJJW5AZyz9O7oD2AOh4G56C43qC7FtLWQTlw=;
 b=UG9qBoIy5sP88gruN7dCQqvOmS6OmknCLaoayElbKrm+GRzcKdAHgcE/R7FXyuXIo7EidY5bOUaHBRqvxUOv5M9IVZP/ccTzDoEzD8CdixSyYWKOqPBF9tpVWXpe1P8MzxP+n6/o8ZJHrRNAhyImHRo9FeGzuyycB1YAA5q65UimC/54FYqy3Xz/XsgINEtgIOnBGjwTo9XkWONaTsU618868cWd7h66dg68lGWXGTgVfgDnNOtEBv5FcppZi8NckrR8PcyaN+2D8+BvXoI0jnSp/3+8VElfsAMYG2ZGPUBPOCLexXRYsmGw++aCI2JzRWoQs4k8sJJxUHz/gQ0uOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkzmcPHuJJW5AZyz9O7oD2AOh4G56C43qC7FtLWQTlw=;
 b=DByNBSm9eUoLaKje2P3q/rkR3i6URxthuKbeycYaWyIIp5347Mxsu85X5DvJv17Rerj0Nr67U4xzQdp0Ti0EEdoIw9fvcKx9TP/K6qZpELPkO6mUQI+MCdIfXOGYB/OQR/MavZSa1qJP186B4APrpJkRwWxJHb74IXjOujdhkCU=
Received: from MW4PR04CA0196.namprd04.prod.outlook.com (2603:10b6:303:86::21)
 by CH1PR12MB9575.namprd12.prod.outlook.com (2603:10b6:610:2ad::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Fri, 29 Aug
 2025 05:54:17 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::d5) by MW4PR04CA0196.outlook.office365.com
 (2603:10b6:303:86::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.19 via Frontend Transport; Fri,
 29 Aug 2025 05:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 05:54:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 00:54:15 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 22:54:14 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 4/9] drm/amdgpu: Wire up MMIO_REMAP placement and
 User-visible strings
Date: Fri, 29 Aug 2025 11:24:05 +0530
Message-ID: <20250829055405.3983456-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|CH1PR12MB9575:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e1aef9-7b7b-4c82-87c8-08dde6c07d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3dhSDZzWVBwKy85Ykl5ZVB0cllvVXdjRWE2VWwrVTNvVng4WXd1cVYrUnJD?=
 =?utf-8?B?QUhtSncyV2lEcEZZWEFSTnlBdkdTQXc2bGIvSGR4WFBLVHBBbm4vWFB2MGJK?=
 =?utf-8?B?MDhrRnIyTTZ1cStjQm1CVTNhOEJrcWo3dTVEZWN5NTJMTXprS3MxcDZMK0xq?=
 =?utf-8?B?cjBFTktha1JKclBXbkFJcjRtbzA3RDAxTWRReHBpbS9YTk9Qcmo3ODJUbWda?=
 =?utf-8?B?aGZ0Z2toQVEyRVFvTHNEYVFXckl1eDBVelJJa202Z1krSG5MK3JvalZDTEVZ?=
 =?utf-8?B?MEUzL1k1OWM2Smo2c0FaMXNhVUV5RDZrRmVNblFqeHZFU3pMM2pxZERTdUZ6?=
 =?utf-8?B?SURUazl4MUttdGZBZ2NmZFdNaXBrQndja1JSUCtnUklQbktpNnFvWFBXTFFV?=
 =?utf-8?B?TDBtQ1p0SzJBb0hEK2lvdlJoVFlMMmZDYjdhR3FIYUZzUzZ2WHc1U244d0l6?=
 =?utf-8?B?SDVXaWZEVjZ0RjVleHl5dTdFSjFxZVR1ZGJwODlIRS93M0tqcHBXeGN5TExs?=
 =?utf-8?B?LzJES2NYK2NPZ2hHaWk1ZTVrZ0N2Y1VVdUdVajIxdzZQcnJNeWJleWJNZEtQ?=
 =?utf-8?B?L21LaVZtc0Z0ZFo3REV3bUc2NVhFNU53MHpRYjlTbGZDbVFsRGFZSmNYa2da?=
 =?utf-8?B?TW9SeURRZ2dldHVQVGdiRDlJUERvaHNqcmh1MlBuWGcyZUc0WFhUcHVTWE1L?=
 =?utf-8?B?VFBWNk9vQXdCbm1SSFhpeXJmOEN6NUZsc3ozdUJLSXN4bE9KWUl5Z2VFM3A5?=
 =?utf-8?B?VWI4Mm5POWw4QzdmOVFDaFQwMHE2OWpXR3hYcThhMVlZalNDbk9qUzVtUGdp?=
 =?utf-8?B?aEN5bzVzWFd1QVQ1aEFjREZ4bC82M1BBSDM0dEV2RGljUzRvQ1VSTmtHa0Jo?=
 =?utf-8?B?RDM2WHBuY2pwSTVnUjZPOGlKWTJpdkZidzA5ZmEzT0hoM091UDZkTVpJdFI5?=
 =?utf-8?B?cHkxZVRuZmRWYUFTcFkyTjlSRTVUNDVmZ1owVzUzUVp3bnAzQzcyZVJydDYy?=
 =?utf-8?B?empxNnd0NHp5dm5xeGpLcEtEM2Q4WWtCeUR6UlE1Z0tBdG1PRjdYN1pUOG91?=
 =?utf-8?B?aFcyWnJlMGFacTBKbENsRERObll6Z2NvNllXS2NTYWZxNzE5L0RQNFUwOGJB?=
 =?utf-8?B?ZTM0TGJDMHRlQzMwZ0ZQSS8vS0ozdFBZZi9SRmpyNSsyaGYzSU5rdEVUM2pN?=
 =?utf-8?B?cWxkZU95SmpBV0Y5SjI0anlGRm0rekQrcnZXWU9uOW4renpwUHZXTjZlUS9E?=
 =?utf-8?B?TVhyWnlQbTI3dkZ0Rk5LYlJGNENyc1V3b3NiV3JTMUQyOHRUM0ZuYWUrYU43?=
 =?utf-8?B?NVc4WGZXcXlDZE13NXhkbHRkT0twRzFXMnphZjB2QnI4YlpuWlRoeVJpMWI3?=
 =?utf-8?B?MlpRUC9OWmhKVDRUTnBSNnVSY2d1WVFaeW52eklzQmx6NDJIWWE1RXduUDZX?=
 =?utf-8?B?Ump5Q004NWovNFY5akQrQUVjd0JsMTNtM2ZhcW5FNUNmMGRIRUFGNzFtUkdw?=
 =?utf-8?B?VUJ6eHRueTd0cGp5OGdCcXZ4K3ZyQ3lrcEVHQVJYTVN4VE4zM2FBeEQzd29T?=
 =?utf-8?B?S2hEdHlOQnlMbmhYZzdDUkZlYVI5WmJHbW5EUzk1OWVEdk5YNlJQKzk4aTM3?=
 =?utf-8?B?TWMrSE9YVVpFKzVlbTJIRzI2c1dWU3BXM0U0ZTlaYzhqejZETmhTS3FhZE9Z?=
 =?utf-8?B?Z1ZXTHNlbWhZaXVITjVLL1d5Q1YrT3Z1cThMTXdrWnlJRjErQmJ4S0RpNWxM?=
 =?utf-8?B?d0ZGd1pSTmc3UGdCTFNjY2UvWVplRGpvK0JHZDZTV0hBTnhhNUpDblY4TGVu?=
 =?utf-8?B?ZjFVYXNZWkVwMzBYRytGYWNFRmFmc0RSYW5TTnVYWWVaYXpHOTRGaTdYdGsr?=
 =?utf-8?B?L3gvRXFBaW9OOGxvQWMrRVRnUVhtdDQvckxTWmpnUC9UR1RJYlFpSklnQW90?=
 =?utf-8?B?bGtqYkE1WEJTaXh2ZnNmYXRsMFI5ZUVaSFJJam9hbGFJMnNzSTM4dGJNeWND?=
 =?utf-8?B?R1dRc1lmcTlKNVVlNWE4dHFwQzBURVNGQ0JncEltK1NRVlgyNEs2Z1FOWFls?=
 =?utf-8?Q?DA4ZbW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:54:16.1233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e1aef9-7b7b-4c82-87c8-08dde6c07d05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9575
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
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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

