Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA20DCA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 14:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3607710E782;
	Tue,  2 Sep 2025 14:57:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ei+m0AzJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D65FF10E782
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 14:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsgpcMTvsPylkJiQqnP4LtOCTtux+S3MM4fw8pAFR2EnepI0CHD6SKJTEQoW4orxUuCabosBUUdo5NvlnLjWWls+apcaUE1gidVRqTgqKtdsBlF1bvzKT/uMu+7adtLP9/Xn+DcTzX+vmOqT1KhvcQsyWTzH0VCSGqqLq2C+816olA4Q+V8Af9PrLKzcizrHVvhLVRZhvVgfdduYPoLnVIq/WJLfD/jYEXe/HB1w/Zu8uzSds0ITEFd3nZYY2sqgNM0z/U4oiRcLae7YQZmqBrYF8yj6qrD6jgQRnhpWzbsFRwkOZa6L7fSlBx66yTDkM380IMSsYci6/i3/jT3TPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkzmcPHuJJW5AZyz9O7oD2AOh4G56C43qC7FtLWQTlw=;
 b=hqR97g0lr+WoA9rpIIlVvJQouBg2CKSjaMbmQ1oVsM2lNg2XaVKNqV+TEsWNZzUsiDoII82qPLp35+xYPvafiBNN3U084aS9trxJw5iu2KbQov/OmrXlyCHv3ornt1WeiQzrxuPJiR3AbWcGMU+Ffvz66CkkTliD2EBhuqSsFygHoq5VL2JiQvCSwbL8AoC1FFMQmO9ibS7IZTZ3TLiEu9J3JBIC4TGEdfiyX2+obaDp/031OSiKPvE7NOnp+2m4w2MchvQ/qBVV2wqWPXxPbzCwORnN5NS4ucJl2kz74Cgyw5rbEkTTSoJIWvhmeIz7n8SHUc3C3PmM+XzhMTZIVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkzmcPHuJJW5AZyz9O7oD2AOh4G56C43qC7FtLWQTlw=;
 b=Ei+m0AzJDHhFUi0srTZ3N8NgpogaMvoaMj6RZCMYWFurx2h2yeyMBYf7YA0UKZnDH6ubU30zTLrn2lVFCnjGO33U53l4nGHWloI0UcQ67Rb0/gGyCKrVP07jjmIKsqC9v6xposk9kkBP3EFzJmwiNRKlttJEzho/JQB+jJqWFCw=
Received: from SJ0PR03CA0062.namprd03.prod.outlook.com (2603:10b6:a03:331::7)
 by BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 14:57:13 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::c4) by SJ0PR03CA0062.outlook.office365.com
 (2603:10b6:a03:331::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 14:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 14:57:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 09:57:12 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Tue, 2 Sep 2025 07:57:10 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 4/8] drm/amdgpu: Wire up MMIO_REMAP placement and
 User-visible strings
Date: Tue, 2 Sep 2025 20:22:09 +0530
Message-ID: <20250902145213.486199-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902145213.486199-1-srinivasan.shanmugam@amd.com>
References: <20250902145213.486199-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|BY5PR12MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: c1cc3f3a-5112-4201-b3fa-08ddea310030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZG9nVEwzN2tiYzgyWFc3R1NGZUNQbXRBRTdJUnpOV1NyUFBXL0h2M1hxVlRk?=
 =?utf-8?B?MHl2em91TDduL3JyUUJMZU1rS2prLzQwZVVneG5IS3JWMm00N2tGNDA1Y1Rh?=
 =?utf-8?B?RTF6b0ZRc09OK1Vqdm1UY2d3WEFSU3k2VFF5bHdOVDBWdEkxWjVXeWZ0d2ha?=
 =?utf-8?B?R2ZKMERWa2pUNjZwT3RYRlc0Q0tONk13NWxFSHdLU3dmYlU3UUJQOEtETGNZ?=
 =?utf-8?B?R1RKTGxUTlc5a3cyZWE0bjBrRlVYVHh6Q3h1N2w3OXhQOUFQVEtVZFRmZGhL?=
 =?utf-8?B?dlo3VFZKcldmSXlaK004d1V0NkFFYzhqWCt1cVE3aUh4ZHg2NmFDNE03ZnZt?=
 =?utf-8?B?TnhjMlgzWFo5ZWR1OU9NbTNJcFZsR1hPUUdhK2VJSGxYK3V4ZWJyOTRzd0Zt?=
 =?utf-8?B?VzdpTk0vYmhpdU44cXVPT2N2ZWhmditkMHFVLzZSakRUdjR2SDRyejJybWpa?=
 =?utf-8?B?bGcrWE4wcDVBa2xWUmY0UlJRWnkwaE5Sd29kbWZmZHVDQTdjRGt3SHVCd2tu?=
 =?utf-8?B?K241ZlI4TC8zTVhHYzcwNjZkeEhVZXEwUHpFSnBodGxJZm5mb1UyZ2dqWTZq?=
 =?utf-8?B?Nit5L01GNGs5RDQxT3hnbStDY1NaNUxLUkJxU2VzbVhpTGRpeGNMY3oxdzU2?=
 =?utf-8?B?SmlGMHZ2NmZtNldTdTFOQ2hscVRkMHVidUFadG51VzNPVS9iUVcvVkU3ck1k?=
 =?utf-8?B?ZEM3ZU9LVGJDUjNSRXRxVU9LMmNjWEpsL0JOTElEOGozcHFkM0ZYZXZkN0JJ?=
 =?utf-8?B?RTh4eTI2MWdYMzVVWmRjTmN6cHBjSVNWWC9PU2JsNkpydkpJWnpFczFkMnBT?=
 =?utf-8?B?RW9hbXoxQnVCbjZWSmJFdm53K21yOUE2WXJBSFJCMU1kKzBHQndvTXVxU0Iw?=
 =?utf-8?B?MjJ0cThFRDFlTnRMYTExWUxGMTRHc00xbXNvWTRPZDRwdDh2WVNQL01pdHNU?=
 =?utf-8?B?WFg4TVRTNytvczY3Tmk0bDZiR2YwNUlrdnhoMW1wM0NHVmZSSCtadWlYNmhv?=
 =?utf-8?B?cFNQTjhCQU5NMXF3ZWdLS3luQVhjK2x2ajloazdCSlFOTlN6bGdNVStWWnVk?=
 =?utf-8?B?Zk5Ebm56ano4eVpkYUFpNnZmOHBVRjFLL1U1T3JoeHFrL2VkQjdsWFJKenFz?=
 =?utf-8?B?c2ZJSHZMYjJOeXZyc0orSXhpdkNjVlMrc3l5NitWNFNZT2JlSXpIa3ZUNmti?=
 =?utf-8?B?ODk3V1JIQkd6VnZLdHQxSkJoRTk1cm1na3R5Yk03Y0VwTVJndldGTlIzTGwx?=
 =?utf-8?B?VWI4VUdwNDRSb01uRGVIbEtwU1BmWnQrQTY2dVRvNzFSeTRpbDRnaXdZOXlT?=
 =?utf-8?B?dkNuOG13WFp2cVczZHlJKzFQSG94cVp4MWlJRSs3TVZRbFhjbXc4SURLSlhL?=
 =?utf-8?B?WnJwdGw4bmgxMjNjZ3RqQmQxdUR1RlNpelpwUU1jMis5QzE0ekg1RnY5dVky?=
 =?utf-8?B?a2k4ZjdNWTJSNGhOT2hpazJpSllFak5sZ1JPNHprT3NpalIwNHgyeTYyOGE0?=
 =?utf-8?B?bVdLOCtaNW05MzJjbkJMOHVkdmpZMmYvbkFwbG5zczZJYVREckFnbHJ4bUps?=
 =?utf-8?B?QmZWM1h5YWlXU3QvU0djOWxsM2k5UFNxTGJxU2FXaGIya0UvTkZFdWlzY1hY?=
 =?utf-8?B?WldaVDgxVnNyQkJkVExjRmpuS1UyblBzTm0xSGtheHBuOTE1YXZmQ1c4TFds?=
 =?utf-8?B?VS9vaGNvalVSUnpFR0c4VnF3Z1pyei9WSyswTmZORGlCeU1yNlg1eXNiVWlX?=
 =?utf-8?B?YU5zeE5KdnBxZ3Z4NTZsWVE1N24zVXZSNFVPeXAvdUpQYkprR1dzTGZ3Q0J1?=
 =?utf-8?B?TFEwR1l3S1ZKV3RSelI5d2liaExUZXpSYXdobWJTem5LcWs5cFEyMXNyU3Q2?=
 =?utf-8?B?VGJhMW5DVm8xRDdHUDFDalJOSFRFNXIraTdhZFVKa3NVTmppMXFBc1FFTS9P?=
 =?utf-8?B?Sk9oR0tWSWxTV1ErcTdLSnlRRnRmY3FtT2x3cXlPQXBsM29EWTZjQjJybTJI?=
 =?utf-8?B?S0ZDeDRabzNWMmNaTWRla3hDQUdrSjVQcDFiZTI4dXRnSm9nZEpaZDBUcytt?=
 =?utf-8?Q?4G6Eyz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 14:57:13.2587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cc3f3a-5112-4201-b3fa-08ddea310030
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
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

