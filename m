Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCFFC8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8A0B10E945;
	Thu, 28 Aug 2025 09:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b6NF9oFk";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D70310E945
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfmKuP5Vs03pIGH150xfP/MHjQPN3R7nFH/V1K3sAJkfIuZ+sziB1IsWYCpng/hFQae02OGrFsFJLsyav9a+iKUjulN5gQQtYUYUXqO2Z9rTxYbuRIQ+nrrH8kAId/t+l5mFOB5TID12oGPHJa3HSFuBoBa1x+c1RvaqY0lPjAZePOM4rkKwK07IOxgZLHUXhJdCGgVydG3TOWImHugjAuw5lsLztfRzjQpRgY9jV+C4lmD83/FIRhivyUJGfvw/4jz784CVPnUEqwdW8CZlXdPPMcAlDw5Sohx9OYR0My7y4+509RT96mJUW4EIefNwdhC8+zmNXh2BQCQVVpqaXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taaDMP9FhT4Bdh3JK7LFBH/INobN0hj2kB7Da8MP5Dg=;
 b=P9FJLltFPdUBVH3S6x6EEJvDC1h6WZM7PvQkfq4gzSzrmnDh0STXDveVFI1ttOQCsWCcsszHs6mNgXl37GQdkAMnhFalwFR80fWS8e1Xp6C2TQWMf4BSI8S/dxAyMKowY3R8TNUin3r2UlpfubcEFkHTbGRAKixiDqA6OmhSn/aElNe7lfC6fWERnKrHTTo3tz0wz0QLikLL8WzoqJ5trS6f4V3KGqMLXKrYQXRwK8C5K2JDh979rVU4xap1nuNXWf6q0sCD4s9N+YBxNb0LSf7nHh3/GcKy/umX3i8hQukzjTF7mspRbhRezENW95fySTzVNKqj5IQD9PlNptAWPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taaDMP9FhT4Bdh3JK7LFBH/INobN0hj2kB7Da8MP5Dg=;
 b=b6NF9oFkqtP0p1pv8SP87YVg+HQe3Cs0jEOaEbl5hTKsc/gqKRIbHao2ckk/Emi4E7sbpOVCtghYPVhSm1F+dR+uL5GGQLQojNYUFwKuxpeP7bM00i1vLrlcASaQU9KRxFQ5Q6ZZ1O/PBWZenEEJM0C5w8+ZtboYGdEfd2aPGvY=
Received: from CH0PR03CA0252.namprd03.prod.outlook.com (2603:10b6:610:e5::17)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 09:16:23 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::71) by CH0PR03CA0252.outlook.office365.com
 (2603:10b6:610:e5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 09:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:16:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 02:18:34 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 00:18:32 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 4/9] drm/amdgpu: Wire up MMIO_REMAP placement and
 User-visible strings
Date: Thu, 28 Aug 2025 12:43:30 +0530
Message-ID: <20250828071335.3948819-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
References: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2cab88-b988-4928-4b1e-08dde6138eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlY4S09WdFlhYlNuZzJaV0YvWk9xcjNTOUk4UUEvMWk3RlBmS0lNdjc2TnZy?=
 =?utf-8?B?L09vRW5vMnZQamNINGd6c1RoRTNYK1dZTW9IQk4rbzAzUlovbjJ2STQwbVBM?=
 =?utf-8?B?L3JrM0FFTU9GWFk1SnczMll5ODd3Sno2L0hhR2Y2WEVaM2Jtb08wYjdiQzBN?=
 =?utf-8?B?VVZzWnFkdVljelpHdVljVWN1TG1GRlArTVh4bTBVUzAyMmxtdm1MeXR1TDc3?=
 =?utf-8?B?dzNBMitjd2paNzJ1Z296S2hCQlVKUnh2L0R1RGxUWEtCcTM5ZWpPN2lZbTRB?=
 =?utf-8?B?K0ZYZkZaa0p6RVFSNXNTUFR2MDBRNWtwYk9qT01rSSswZlhaV0lhcmVKMjdz?=
 =?utf-8?B?eWRVR1NEbDhjaC9oSTd2aGswM3dJcjlGbklBRmplUFBLZFdPRzUyR0JxN0I0?=
 =?utf-8?B?VGZ0NmRoV3RGRFVLRWI0YzMvT0FIZ25KM3ZpM1VxditvZXAwUnlnSDlMZFZy?=
 =?utf-8?B?dUc3UEY5VEJNQ0dqczNWUFpleVBabExuNEJYbG5Hc0lzbTJRdWEyTlYrU1RX?=
 =?utf-8?B?Q1ExVXFpR3l1VWxLbG03QWtUT1V2VW9GTjRnY21mNU0ranZPdlpQTmRZdkNE?=
 =?utf-8?B?WE9OTVF1TW5CZllwNm5GSHJ6NlcwNG9hU2Z6STVrWXhTcGFHT25CcGRCNXJr?=
 =?utf-8?B?cW5HUWZxcXIybHRQY3I3eDh1U0svR2NIVlcrMzV5a2RDSnRKMkwxMERjYTFT?=
 =?utf-8?B?SmcvTVZmd3pQWXdBY0d3NHRNNzdtY09xaDFmM0M4UjI4WDB4ZndkQi9vMkJH?=
 =?utf-8?B?c3NWVlZUaFlFTDJaR2ZHSU5jNjBxUU5jWTlGL0tDTUxTVVRheWNCN2F0d3Fw?=
 =?utf-8?B?amJRalM2OEZmZWdQWlR4RjJ2Tm55V2srTVhmaU16UWRqMnc5ck5nY0xPNmV3?=
 =?utf-8?B?eTJaVk5DZDJJZEFuN2NxZXUvcXIyV20wcjFuZWlhd3o4YTBBOGlqMi9VU2hY?=
 =?utf-8?B?SHp6aTI2QXpRUmlmelNxay9KR1NyRkhBQXU5aFM2UGhseDVDQTVLOXRhcGRS?=
 =?utf-8?B?bHhiRlVsbXlwamlNN3M2YkUrZzJIUlBHK0xHb3l5TDJCaDgyNFZaNHBsbjlG?=
 =?utf-8?B?V1ZYQ2t1anRLZHc2Rzc2NHRkQ1JoemwrdVVZOTZySWhIUXRZM3ZvRVUxYkNT?=
 =?utf-8?B?VzNjVmJlNGtUYU1UVkxZU1hDeWE1dnFObHZvRXhPYVovN2llbUloMlZLVTds?=
 =?utf-8?B?QmZMWXEyeFB2dTNFbTRoWXNnZ3BURzFyQ1EzTktoaHVtd2paY1F6c1lsaDRj?=
 =?utf-8?B?NlQxZUl6djhCTXhwaTF1bGZNSVBCYkxad2JGS3JhSmNOd0htRFQyUGVsSXp3?=
 =?utf-8?B?N3h2aDNDaDk3SXV5bTM3SUxHQ1RTYlRnVHdzNXAxdjd2OU9QZWhRdkdXT2FW?=
 =?utf-8?B?K01pTlRoUXRmRHBmeTJIQUQ3c1hic2M2WlROL3A5a2RsK1lzb0xqY0VUOEFB?=
 =?utf-8?B?QnpDclgwTTI4dmttQzlJTmNBblRwbVNrZE5QSzR1Q1pCOXQvTUdSbmYySnlS?=
 =?utf-8?B?MG9Na1hndTVTb0lDR1o1WWowYngycDgva05UT3Z4UUxQUTBLbGVVY29TSm5p?=
 =?utf-8?B?dG9oSENNWFRDdWF4VzZuQzk2SXAvN3NRZXNNL25seG9ZbzNJQmpmeDAzWlZO?=
 =?utf-8?B?VzhMazd1YTVod3ErQlNYbFRkZ2J0bzJmRWZ1bVg1Nm10OFYxUFA0UjdwY2Rh?=
 =?utf-8?B?QXBVSytuOTRNTkFybSs0dkk1KzM1bncvcktLZXlRc2RwdTFMWWFIYXFnS0dW?=
 =?utf-8?B?Mld3dTM0V25DQlpKdnpQNEs0RkdkVWpKTWN6KzBxK0RyVFZlS3F4dTY4UENQ?=
 =?utf-8?B?QkFJdHhkUk5QbWRqUjFlODA5Zlc0VWZMT2p5MVl2MUtWNEtkKzkzMXlQTXAw?=
 =?utf-8?B?UFN3ZVJyOGdFVndRKy85WGhVTHFoMmNuZW9TTU9GK0F2aEZ3ZHYrOTlkOU1T?=
 =?utf-8?B?ejdOUXROajFWR1FmRXBSZzB4UHpkVjJ6YVB5UjBqc281YnNEMVg0NGlhblJB?=
 =?utf-8?B?akVKa3FuRjlqMzlYd2M3RytyeitINDRuNWpGRGhWMU1YZlpYMG52MklaUmNX?=
 =?utf-8?Q?bj3CbV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:16:23.2743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2cab88-b988-4928-4b1e-08dde6138eef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
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

