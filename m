Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2E1CA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 03:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE55410E55D;
	Tue,  2 Sep 2025 03:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jRpSjV3x";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5645A10E55D
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 03:34:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgAIgcyF0yUCp2qN3ZU58+Zw/aHOvBBDh0k/TN+jcwDmi/phJVN083x2xC52OgNlGYTuYQsDgcdloyAMscSZCjTLnKwhG4KDoniZwjvWk2lbWSqu4A8vLOBdHBvf6p3Bo1Lw6egdpw7Mhk0y22PwgyhQDKN9XSFiq0seUpFMyUc6R0kXzR0R7V8H9N88K/wHy5Q+Ne989qMt7KNzzxebQ/0WZ7uunmBk7asIGAo9LoWqZGB9Mjk7xgfIbzzamiOsJsdIcT+Ekm6KJR7Urc12mfV1Dzx3HSHk+iHxDxrmaXTSAJ9j7rzTThZrcbmrtCQP6sfDK/3bRRnIcveGXUaaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkzmcPHuJJW5AZyz9O7oD2AOh4G56C43qC7FtLWQTlw=;
 b=L0FmqiQBCJDeQeM+3oVWmUf6lMuALo5Jop6Lg2n+s4MaeD7bULQnP3I77UMHhkTwI0X1/Id8+Q8Ez7sitqg94mFdM34sLg5fwn5sM1wTgcokGDRa9XlM6Evajt49sh0YzXP1fBwFR5sO3eOQ45anWmWowUyWT7JIUzYT+doa5UD5RGtAlKN48TMlpZWRhe9IZqcE8aJIApcqYhaYJJ4nMTpCmyPq3uLqfMBBDmt+Adm/RbKxwoKoP89wVYcw5h0LJbOqhXIYhwRva5XdcEv+IkpISwSW2+UeUHb3igbBViODqvB+/uZYz0GNKClvSWc/pbK9p8+/hK5rKDVhp8AjFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkzmcPHuJJW5AZyz9O7oD2AOh4G56C43qC7FtLWQTlw=;
 b=jRpSjV3xT1NdAufXGsalnuDAET8Qvfz0qW0lNXJqhtdQ/Z8NgQ8PqIQJMuVOdibayMNp5eeNFA1Pad1zAVzrxcD7eo6SYo2mYlLFXrFctQb6A/Yjn2UeKZ9jRSR6CCsCapMDhQOCx+Emv83WvAqsnRevfVgDGKJTCkp6IcdSjLk=
Received: from BL0PR05CA0019.namprd05.prod.outlook.com (2603:10b6:208:91::29)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 03:34:32 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:91:cafe::e7) by BL0PR05CA0019.outlook.office365.com
 (2603:10b6:208:91::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 03:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 03:34:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 22:34:31 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Mon, 1 Sep 2025 20:34:29 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 4/8] drm/amdgpu: Wire up MMIO_REMAP placement and
 User-visible strings
Date: Tue, 2 Sep 2025 08:59:34 +0530
Message-ID: <20250902032938.468332-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
References: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: b3067cfc-39b0-4177-78ad-08dde9d1a12b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGt2aXFNbXN5VEdJZGtad2hEdlBoYllBKzZYQTZaVWpZZzRBbzUvcEI5VE5p?=
 =?utf-8?B?c1hHMFRDcU5YU3g1ZlJ6N3krTENXTlBmeHJacjlNVCtpZVV4eUU1cElwaHd2?=
 =?utf-8?B?WmNDeXJBc1U1Q21aL3VVU2RKL3J0TUFlWStLRXp1S0REbVBLSE0yTWJlL1Np?=
 =?utf-8?B?SVI0SWhub0RaNEhSNEUyeVJ5b0hYSldjZXdkbUdlZmhjNHFtNU1qYTNZcSsr?=
 =?utf-8?B?dVFkTy9HdkxIQ1IxSHFuNFE0ZzFTRlhkbEVLU1BIakNJS1NROW1FOXBHeDJl?=
 =?utf-8?B?VEpLUnQ5cFZTV25SUFZYVkZQTkxIUkM2ZFlRcUhpV1pYSkxkRE9mcmZtdm1n?=
 =?utf-8?B?QXFQcnBKcVlic3U2TXJxVFZJZ1hCQ1B4NE1WYjFmY3hyUXpSbnRmUU1zaFly?=
 =?utf-8?B?aDlETmo0NFUyOVNVb3lkYXQyc0hTdFAvQjhCMWVGRklUcnFMTTJsYlN2eHVm?=
 =?utf-8?B?M0VwWnpPYzVjRDhJLzJxYllpZEN6SUNDOUQ0dHFHNG1ILytHTkZkVjdTMnY2?=
 =?utf-8?B?c2U1WTc0U0JaM0plamZ0Y3lxa2t4RTU4U1M2R3RLcHQ3V0lCQ1hKSGRNc2pY?=
 =?utf-8?B?WXpCQVBTVXRuZ2NqS29McnZQN2t2Vk41S3hHK2ZXSlJLY0RVdHp4STdPb1ls?=
 =?utf-8?B?bk1UWDAvKzZCeE9VZDNrUWtIYnJEby8vcFM3eGRHNEZYYVZ1U0w0cHA2K1Z3?=
 =?utf-8?B?cm5SRVJsOTZub2lzQUZQTjlENDB0TDR6U3pEcGFwT1Z3SGJWOWZNMVArRFNU?=
 =?utf-8?B?U3EvZFMyYUJjQXVnRW5DdGc4Y2laS3BpWUJrWlRCNVJ6VFdFZkFrODBRQWdK?=
 =?utf-8?B?QUhMK1NiSEE2MlJEYXlpVzBhRW9yc0VYclFlL09qcC9YMkpXZENNNWtkYjQ5?=
 =?utf-8?B?UnZueGxiUVZhTlFQOVl0WmludGQ4S3c3RDBkbnFRK2tPNklIaS9NSlpidlR0?=
 =?utf-8?B?WkVNVTBwR3BkQnluSG5EbVdTVTFCdHp2eXZqNENOL09NMitwK1lpVlE2SkNT?=
 =?utf-8?B?KzR4MXFwSittc1NUSzJIbWorL004b2phYjlhc3ZvWDN2R1FtdGd5SThKYVZN?=
 =?utf-8?B?TlNHOUtIY1pXTWp2ZnN0MlBkNXJDc0VHNXZLcmVwOVQybERBOTFINlJPT2lk?=
 =?utf-8?B?cWNyU1h2ODE0MjVyckFodEluNE1vNS9DVTNXMVJ0NGhHT2pBb3NLRzd1TWF2?=
 =?utf-8?B?RXNLMHFnZUt3R1huNlJqdFlLWE8reS9kT0pLendkMjROb0l6OTM5aU91Ukli?=
 =?utf-8?B?cFNzR3RiYzVCeUZDWVEyTlBSa2NvVXdwL2xVMFNCT1h0T25lZHBDdlVMdkhF?=
 =?utf-8?B?REVicm50ODhuUUFEYU01QzA1TGpzd0dLY0IrenEzdmdEVzdHTDEvTlpUVVBw?=
 =?utf-8?B?QkIzNkFjQ2xhaUlqL2Q5SWZuN1IwTU1JMk1kZy95dkdRbFZKWDN0Rlk4YU1K?=
 =?utf-8?B?Z04yZG54VHo1ayt2Yyt2UE85ZXRtaHc1cGFhdndtYlUyOVdpZFJKTHBPMmtB?=
 =?utf-8?B?VlJvdC9GV09MYjY2ZzFRZFoxUGkwR3picTljaTFTeVU4bTRIMVM2SThieURK?=
 =?utf-8?B?L0t4SkM3d1RIRkhPM1p1SEs3YTEzWDBEdzlPZ0Q1aGxNdlowcC80aXJZNVFq?=
 =?utf-8?B?K20xNXVDUkVaVTZRWXhwRjR5Y0tnTzd4SDh5R0g5ZjR5SXYyOXY4bjJibE5Z?=
 =?utf-8?B?cmVzckZjVERwQWJENVdGUVJzcDB3UDUvSDYxU3dUb1pxTWRCRUpzelhvMDJ4?=
 =?utf-8?B?eDBmSjR5K2I5bktSQmVkQmZkRXRyS1pmRmY2YUdUMnR2U0pnSDZIV2o5a3Fz?=
 =?utf-8?B?eFl1ektpd1BZZDF1eW81eXJEZEJJYUpwTXRDUUZGYUxhK08yd0lLOGtKWWdG?=
 =?utf-8?B?NlhndUNSNU81Q0dsMXR4aUlzQ0pmcHp1QjNoa2c4NThjMDJJeWszUjYyR3Vl?=
 =?utf-8?B?dDJpWWltb0ttVnpIZi9iNTFHcDE3Q1BBUXNPWDZkTFNnVHdwRXF0eFp1UlJT?=
 =?utf-8?B?TlN5QUpuY003VVloNmU2UnZpeXhrS2FUQ1E5ZE10VWxoUHlqbTNIemRpcGRk?=
 =?utf-8?Q?9FNQxL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 03:34:31.7446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3067cfc-39b0-4177-78ad-08dde9d1a12b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718
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

