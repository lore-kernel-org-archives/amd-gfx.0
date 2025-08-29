Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9062CA0FF0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 14:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2FE10EBC7;
	Fri, 29 Aug 2025 14:00:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WY6eQ2Si";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2E4B10EBC7
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 14:00:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSDp4vXpGYev+CkcHICf/p4rJgvpI6L5HDwB6kneXyFAcbkJjfzMB6+m5VIyUIWGvRxu0lLNV1ol/+iM8s9ox0NLNoBj7BMaiWd/bToFqxIpluieqgvnu9FesUaii6WtZDG/DBBDbIdGODq+3pJV4PHzumcXetBaiok9KYgUAcXVBwK49sVpgALvFgyroipFRbAYBzMz3AIU98oFRgZDWFkUfeZaFFRWewyaOmGKdtmCaWsSWYNjP7xEWPo936KBtmKU3Q1Togke5Zby3JoWNm7LkGPuPctUOoJ3D/pdqc5PZEXsdbKRyeWs0ftJCjXX1aHp/20oTEIdku5sBNpm0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkzmcPHuJJW5AZyz9O7oD2AOh4G56C43qC7FtLWQTlw=;
 b=PSl0zgJcO6bzn+OBB42WisZ4LZN4lFlBTXZDeS7iNsBo/iumpbPCYRXYuMz9JpSDCo0cYqeGJrL9FcovlA6paq8TGjvUwcVA41GTinXjgwpj+i6nkfcedczwaKQGLJvlrsY21rfygQ6ZM7yHBTU8nGCBj/4qFIZshkgEDVoWBCLYmDAlbZbQ8mjLU27jngyYMlMRvZyNwAgNeCmmqrEL6QYvDfBCXrazsTI2sppV02uOM030KRKrObWugH35QwnvdbhlvG/VDl535b9JoEVHFRmE9AeqLpAzuu6NaFej8QFp9gEPyWaEqIg9iZBStlH1ChVt+S2dq7UOhOOHcfv91g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkzmcPHuJJW5AZyz9O7oD2AOh4G56C43qC7FtLWQTlw=;
 b=WY6eQ2Sij8R/7mO3ShytBaqxE8zOfY+WYBvRREWk/midfEHwMLTDwbebjTEV2W7rARfGh9U0aoOW6gMxNjU1tN9zUTkLzbKX2BsE4d1mi+9eaB3o6sEeon6XJaXi0lXuP3q9XvRZS56dzdXIrtPBwHValsMTZwtS7SA3WZwMYs4=
Received: from CH0PR03CA0424.namprd03.prod.outlook.com (2603:10b6:610:10e::21)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Fri, 29 Aug
 2025 14:00:20 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::68) by CH0PR03CA0424.outlook.office365.com
 (2603:10b6:610:10e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.19 via Frontend Transport; Fri,
 29 Aug 2025 14:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 14:00:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 09:00:16 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Fri, 29 Aug 2025 07:00:15 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 4/9] drm/amdgpu: Wire up MMIO_REMAP placement and
 User-visible strings
Date: Fri, 29 Aug 2025 19:25:18 +0530
Message-ID: <20250829135523.4032168-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
References: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 2676e335-5337-4f52-b704-08dde70463f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTU0LzhDUUFnaGZ3NWtmUjZOb3BBeFhLUit1RzZaUjVIMDU3d1F6dHFMUHBx?=
 =?utf-8?B?TFVXd0x4bmkwWEdmdlNrc2FONnBtUnVieWlZb1hlRlF0ZDkxd1NoYWJicnR5?=
 =?utf-8?B?a3ZtVDZjYmc3NEVnQ1IwK2FZR1N6SnhzTno3bUVjdTdWMGx4Q1RvL004aElt?=
 =?utf-8?B?b2VHWU5YRnByeis1ZHZnR09wWGo4ZkZwakd5ZHdOUWkyaW1KdzU5K0JGL2do?=
 =?utf-8?B?YW04N0NPMGQ4Q2dOKzhCYkduVnJ1Rk9BQ0UzM1dwdy9IamlWVW5VeUh6NHlU?=
 =?utf-8?B?Q1BlUmVLMDU1djF1dGhINTBEbzdnOE9yREd0YkV2YmVlT1hXaTRQM0l6bVlW?=
 =?utf-8?B?TDVNMVRhaHF1QTR2M2crWmVKbFJZeU5BV0hEUFViL2lKZmdNNlJSaDBrcnlM?=
 =?utf-8?B?Q1RkUUlaMDZQVVNwK3FvRjF4eDhsTUdjajd2UjR2UTlja2RtLzc4T3ZzQ3dJ?=
 =?utf-8?B?Nk5sckt0L2FndW9ReUJicVBNQ0FpVENyeC9ZN2dkcVEvNEVVYm1yZGR0QndY?=
 =?utf-8?B?NlUrRHpWUmU3NU1reHRBbVdidEJZbmg1SWpyZXYzUTVPeU5aTUZzWWh3cDlL?=
 =?utf-8?B?Y0UwdHpEclFCeEtxbmtMdDFpUzNBTThvRUU3VWhUUXlhQ2ZOdTdzZCt0bnFU?=
 =?utf-8?B?aXZocTRFTVVrY3V4Q0dELzNxUWd5NFRxTFpvblFHelNwUmNpVmQ1TUZmK0lY?=
 =?utf-8?B?alU0WU95MWpWbmMrbmlTSWwyRURKc2RGWmh2R3g5NGZRMUc2OFNNeFdKSm5w?=
 =?utf-8?B?dGtqV1JBNjFZTzJqT3FPZnVhc2QwUENnK3l0N2k3NjF4SHlYMWpjcUZWMG1M?=
 =?utf-8?B?UFZ6K3BNeVkyV0RrdWJPTnNRWlMrREsvY05yaEVFRTVaVFJCU01McW1Lbk5V?=
 =?utf-8?B?bzk3K2FNeDB3cG1CYWZoR1FvSTl2TlJ1MDNIOHlSaUt1emgrenlpSVM5SmVV?=
 =?utf-8?B?UHBlK3FsUlRmbks0eDltS2M1OS93bVZZMGRMRVVydDZUSGs3Q0xtMW9DUG9Z?=
 =?utf-8?B?WnJObHNiUUJITlZOeWNlbVlOdS9iUXlQRTdVYVFxN21ac1JNbGNBY1RPa20r?=
 =?utf-8?B?Q2ZXbGJIUVV4SjRhZW9XNWNhM1VUczM5Y1B1QktuRGZxRzBzMHl0dm1oaG45?=
 =?utf-8?B?cTNsTlBDY1NlRVpQc2Z6d0JFWGwzQTlMUTFZN0JqZmhpMzMxOVY0QXk5Wnpk?=
 =?utf-8?B?bzJFVXl5V2hpbUJMUURYRmFRbjgvS1lRTUZMN1pjTVR5OXRETWN4UFpmMzNa?=
 =?utf-8?B?OVdSOTY4MnVDdURJdi9kNWJLeDRkbHE1cCs4SFI4QlZKb01VSDc2WWk3R3JM?=
 =?utf-8?B?L28zLzhxd3R1NlcwbGJOdDN5OWtsQzdhWC9HMkxhWHY2REdBU0I1WlVSSGJs?=
 =?utf-8?B?OERwTm5LQWpjcDFQalBpazVkNW92QU9KTWVBZkZ6ejdwbUtISGdYeWZWN0I2?=
 =?utf-8?B?Zis2K0p3STluRXdzakdjeERpT3JqVVhtcmlPTlI1RHloZTFuUktJNG9KdWJF?=
 =?utf-8?B?c1Fjd3M0UHMyNytQNjhtOE1BNTExelQxbXlsT2MveERxOEZpeFJKYXoxeUg5?=
 =?utf-8?B?RnIyM2dnbXlNYTFpNHN0V05rOHRHNWptZkgwaGNpTTlTY3hRNE0yY1ZCU3Nr?=
 =?utf-8?B?S1dEQUx2RDlucGJ1SkVpVzhhYUJuZThBQ3hjWGZhN3JSV21FVzRJaUEvZmZt?=
 =?utf-8?B?OXpVTHVFckZGOVhtYVNON1g4eUhQS25rZjcrTkFIMzExNVJTZ1pjZjlNSFZC?=
 =?utf-8?B?S3VWWDBuMm0wUk4yVGZrd1NBQjlHdkpvVm5rYWtZYXpUS0tUYWF6aVJIaTdE?=
 =?utf-8?B?eksrY0ErSDJqRFgyeXF6VVZNbE5VejNhejlOWWtDTHdobVJ3N3VNektJb2h4?=
 =?utf-8?B?UHRHSVFPMWNJM0I4elczekZ1VzEwc3dvTm81eG1iemRGNG5nditkZXlKMW8v?=
 =?utf-8?B?VkMrMitCTkFtSTR6M0Z4ZGIxVE9OVmtDdkxGVFNSY1did2RNWHZvRFdjL0hX?=
 =?utf-8?B?bTJOUW01Zk9rczBoaFkxb3BVeTYxZEIxK2tER05XanhWY1RuWHA1em12Rk1q?=
 =?utf-8?Q?4l5juf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 14:00:19.8574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2676e335-5337-4f52-b704-08dde70463f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069
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

