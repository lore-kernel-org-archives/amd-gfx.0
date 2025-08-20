Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD17CCA0EE4
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 11:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BD3C10E6F9;
	Wed, 20 Aug 2025 11:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XGfOaM4O";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B0A10E6F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 11:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+hLNQ9Z8m9JEm2CtknHjLg/ZRwP6y7zNoatzWF9F4h+db2Dfj4NVYfmfZD5yrl01fOFlzR7DGX6sVD9S8dfhKD0UdcwTIkvaygdaHuvRrmxPwJzwk3bUWt19VofX8sJ2LNhwcmEhWgjj3ShvObTfnPxnseH6+CQU9g+ZjSQHt4x7EiUXBESa9fIjNfQHB+vnD97tCNddCpOkYY3KbXOniaHFD3UAWdRgKs/NfD3P0dM0oRhCa/qL3aodeH0klv5bo9fuNu2Cc/qLxIcK1LxIKJzfqaftNmpwkrrhqXSplbEJqG4p3vipQlRJ2RcrPAplCyfMikbxkDphUnGRZUvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VR09ENATYBf1UDKqYVtLTVkp+dM8ZkQVQIKYZFOzvY=;
 b=AG/uqPXbtPXf6AeV9zbc8eUMGFErxXN2jP1QLiUjrsxuB5x2psXU/euYq9CCTJWEhmyEIzhttEjoMs+EyrYDugSo56+6O6QuyazUvH92256wB71p+WUpE1xpuO83QcSVh92xCxsTd6iAjRlu4LvNJ9EMVZJuo74gETuRx7BXvSpkX9lC+yo+lQh7xohqr5GIdCiC+xgsDg6QYIG4BK3wry2eGKJRfvu2LiR9Ui0JQeCJ675drRxOhOUqHoyUzDDnBg0PPtYKOhK1bxMMfK5+5FRUsu1zRqO4aM77EipCRhPWHat2oA3kqJhNmzfth9hiZ6hpgRdMauX9EwwYjS2/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VR09ENATYBf1UDKqYVtLTVkp+dM8ZkQVQIKYZFOzvY=;
 b=XGfOaM4OgzGSn4BX+C1zAhOS6RasS0IsNebFJh/LRrndCK1GamNzQFLqdUIR9TW5sOh8/y0e4JS7iPe/KRNDaeO5T/scEFXRrZhiJcv4dktqoubLhmvNf9thZu0qiMON4qx8ROfY0lCl7VpkXAQy/F4j0rx8dYJw8IGSJtBCbYw=
Received: from DSZP220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::12) by
 BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.25; Wed, 20 Aug 2025 11:33:27 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::59) by DSZP220CA0005.outlook.office365.com
 (2603:10b6:5:280::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 11:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 11:33:27 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Aug 2025 06:33:25 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 3/7] drm/amdgpu: Plumbing for MMIO_REMAP memtype and
 user-visible strings
Date: Wed, 20 Aug 2025 17:02:50 +0530
Message-ID: <20250820113254.3864753-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|BY5PR12MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d3c999-0c0b-4c53-2d97-08dddfdd61d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXV6c25CUzlGeHBvaFJLendRK25WUjUrUnBkMWdqUU9qREhkQVRKUTNmdzhy?=
 =?utf-8?B?WGdHOEROYlVFTXFvcWhTUnBPR01wWUl2b0tTSG1hc2hZRkdnWVhuZXg5b1Q2?=
 =?utf-8?B?VHlzSHRkcE55cGJHM2ova1BTUzhlWDRiWnRPVnhZbkgwcFQzelVEWmp2QjZ3?=
 =?utf-8?B?aStXQnJjOGtXbXgwZFFJK0ZDZHBmM0VEajY4TXRYVWVUM3JYam1rOE9SLzlB?=
 =?utf-8?B?RVhkbDBqNlhtSjh1UlVWaTducy9kZ3FGbXc2R3NEdmFEMG1rbFN2UVBYbDVM?=
 =?utf-8?B?SWwrMzNTOEdGdXJoMEplTjVNZyt6dThVSGNGOVQ3N1ZvVk9keEQyaGo5aGNF?=
 =?utf-8?B?Vk1IbTF4MGFwaENTOG96a01laDlMMnY1cHNhMm8ramxXUmFmTTF6aENnRmZG?=
 =?utf-8?B?WWo1djF1OFYvdzQ2cjh0bnhFeUluR2Nxc2xPZzNaMUxNR2tPNzFCYzBpTXgw?=
 =?utf-8?B?aTU1aktFd2wwZFdrdkVGUy8xUTJYYkx6MWRiekZ1NGtvcDZ0SkFEbEdxOXBJ?=
 =?utf-8?B?Uk84NUoxbUcyRHJHbTZYUEZyUi9zSFVKYlU0aG0wbDZIRExLMWZJYmtsd2ZW?=
 =?utf-8?B?VUVaTUpqM1RUWDRCTWlDUkdNZTJLT2pTZUpzVjBETHArV25hNEhzS0pWQjBi?=
 =?utf-8?B?ejJ4a2JjanZkREJOT04vWHl2SlVzYTQ1WmhHSVZid0lJYnpUSGM1SXRyYlpY?=
 =?utf-8?B?WXFaVUF2c3ZPcEkxRU8rb1hjYW5VVnBabFBBTG5vYjd2MEk5Tm02UWtFR3dI?=
 =?utf-8?B?RVJYNTdQbzVpck1udFl4elJGZm1mazNHc2c0anhEdzcyR2ZkZ0lET1RkN2t4?=
 =?utf-8?B?YzVCWGRyY0xyTkJRdzIrcnBxSVVKbmRNVEVmZnBVZUpYZWtqTk8xS0JCNHBp?=
 =?utf-8?B?Zm00anh6bkdscVBQNHA3UFFsOURvdU9BMXVvakswMk5sS0QvbWtiUEo1R2FS?=
 =?utf-8?B?QXZQd0ZYN3ZJSVlqZFJqcHV2K3NkQnZ3N0NEVFRta2Fxdy9pYmQ5WVNXQ2JB?=
 =?utf-8?B?VTF3QmNldk5LdSsxVXo5YkJ5V3Q1bFZ5UnUzS0NmRVZnSHZPTGhZZEdFcWxX?=
 =?utf-8?B?dFE2VUNJV3FneHhYNkphb3R2VUVzSXd2dGJLZk5FUndvb215WjVsQzBPa25r?=
 =?utf-8?B?Z1VnVmQzSVFzN3FDWExFTE9hK3cxbGFCK1REMXFKaGkyVmt4Rm1keGl2bGRa?=
 =?utf-8?B?TE4vN0Q4MzBiVE93dEJrVjgxcVZvYnJKcGhpWnR5RHp1dGR5QlczaTJ3MTht?=
 =?utf-8?B?b3BpRERxR05zR2M5ZDdrY1Q0RHNPZGJJMWE3WXVwSkdsb3Z2VFVGemVudTFq?=
 =?utf-8?B?UEEzVHl4TDVtWlhMOUY2dWppTEJJbU9kb0dmamNBS0J5ck1kNVpYUTJSSWFR?=
 =?utf-8?B?QXpNNzMwRkFIZ1VwU1lOMzZlWithaldtRWx1elp4U3BoZitLRDUrTTZCK0Vh?=
 =?utf-8?B?TWh4ZkhZZW9UZkk2ZWNBbWh1bzNMcEc5aExva3A3UTlQVktDTlhYTGV3d1ZT?=
 =?utf-8?B?dkYyeTJZU09aTThLNUxIbzB1ZS9oa2s1V3ZnYnhBSUNSc09LZENNYmJ1dWMz?=
 =?utf-8?B?V0ZLY2lHUE9rSFNSenlsU0Q2MjlVUnRxQ2cxT2NBTm9xcVhHN3VyMitJaUVV?=
 =?utf-8?B?enVuTFdBV2hmM2ZHOUpBcXhKWDhpbDBRQkpxS244V05yMlRsVXBTTHUyQnFH?=
 =?utf-8?B?RWxseiswN2JMYlBGVlo3eGxHOHVMUDVFZ2VacWIyN1ZCTlNRWXRRaEdwdjdC?=
 =?utf-8?B?M2FaYklhWW45M2tWRjNhelYrbUQ3MUdwTkxkVjZMRU51bkVXUVA4dzlkclJO?=
 =?utf-8?B?SW1DNHAvQ3F6R29teTJ1cnpKd1Jqa1J1SE1hYWU3OVZOT2dncHY2OTEyNWtU?=
 =?utf-8?B?bEx3THhmb1EvL1paZDdPWlBlU0RIRFVhWndWK3BQR3dRK3dmKzFKNFdhN0Ex?=
 =?utf-8?B?QkZvV3RtMXcrRWJHN0VZQUlBeEcwSDhuZDVrdmY3NFZ4VUJaSlMrQVcxdlV2?=
 =?utf-8?B?cVFqV2R1STREc2Jzc2Y2UC92bmx2aWV2U1EyQ2llRzVzWlJ6elBZV0VpbHBG?=
 =?utf-8?Q?0IzXft?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:33:27.7669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d3c999-0c0b-4c53-2d97-08dddfdd61d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244
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

