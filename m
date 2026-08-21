Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6299C5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F4B10F389;
	Fri, 21 Aug 2026 16:15:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0wR3mY70";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B28810F388
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSM5lNHbcjtFabJZUTn8FX92x7ASBDTh7C864XfrqU+quPwMJ+/Wz8rgLBdcC86KzqlBoru1dRxmBapYOktiWKCIItmysogXOYgtDzFXkA+bFwudX6hjGMV11qgd0s1wdnyyPSNqL9/mVhYs6ofodjArSOMUGuNU3oQr3x/6yzit5hGR27Q4FAATYdYO1y99BW2KEv3siDm+kMLPjOBUB1zz+F6JzO/aXuyG01UeRYqH2bp07QSAdRVEfl3nwXl7wyp7OOuNckfMF1u+EzHvi7CugFMeC7enj+KPIya7HeHKrE3Nd5rVAAXy8ey7o0COy8DxUr8tWGGWGnYDABD5Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLXODJc594Qyhqh5LvRVQzGGnwMy89wyCeMbAiluaeQ=;
 b=HpgkQyl+at/XrU+560lBo/8LL2EzDSbgQAwXcQ5h5rS+GMz2v9TcaFzIJDoG3ow3dgvD0WvouTEoU7f4U3BzzFTkkLnQINMdbj656viWFTHD2VDT5IMRzzw97MJ9zXNAK7RfqZlspTnVZV6Qy2qYyUyhAduIlrAkgIskZiDfd9Q72fWwLiHXe3inQ09aA60CZvUBT6wGbe+yfZ1BHtkFZlu0lARUJU3WfFAAgHhtTg+zkbO5sw78lGe0IReqdJwXOmOlgeIYnj0JXX1lISZpOHyhfd7Q84sLwZ5fJ9ZMyEhTBobEoo8ZcWOFB4A2Qn8eIuxL2RRomNizogBlws18nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLXODJc594Qyhqh5LvRVQzGGnwMy89wyCeMbAiluaeQ=;
 b=0wR3mY70WELyAZToJZ4400Inb6VKT8b586wbsw3tAt3iAqpvtrXoOOYccMY/sFDnKcSSwPr9j+o/ILZxv48CyOEZBry8PhzGr+ITzEF4UYWlA19d17wRScmseW2Zz6HLLqFxAFE2i4bMJ7bSH4fr+4uLwXvvTy7QuPoKCarg+js=
Received: from BN0PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:e8::20)
 by IA1PR12MB8518.namprd12.prod.outlook.com (2603:10b6:208:447::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:15:14 +0000
Received: from BN5PEPF0004698D.namprd02.prod.outlook.com
 (2603:10b6:408:e8:cafe::60) by BN0PR04CA0045.outlook.office365.com
 (2603:10b6:408:e8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN5PEPF0004698D.mail.protection.outlook.com (10.167.245.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:15:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:15 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:14:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 13/14] drm/amdgpu: handle LSDMA instance and harvest
 information from ip discovery
Date: Fri, 21 Aug 2026 12:14:00 -0400
Message-ID: <20260821161401.754042-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161401.754042-1-alexander.deucher@amd.com>
References: <20260821161401.754042-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698D:EE_|IA1PR12MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: 928f3293-cc28-44bc-ed2e-08deff9f61de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: MMoaxMfbe1u8WUT0uULqn1UICBRwmMM5MOaNXAmSy8Tsg7sF64CDnatILdFICC4f5W/3S09WPvUsbXD1rUEFKFUZIikaqfstfJQlHDkoTVYYYhc2UGmejpkJay27ZXfxkXgelav9TjAPAULqViR13o4GfBgjNWCG8+ml4QOHB0UNUZKcLGC730KRlQVBMwcpqkdshFOrxX5J7I4vN3fz99366mJLYpGlxJsQYZ5M+QPaufimaRyyZTTKh8hCgQGoPeQmJRs/ylEpKWv2jGrMoLMLGYynWG10TtrPYNSWUdNLBZ4ZqOS968+Yc/v+ibin1NhKIgh8Xwwj+WAfxkogKn8LWGBAgPLmZDh7LCfHLVdUklPA53QGku6Pc8eHE2WDgUBRFkhBy8GXT37Tf8/7VsRCjfqLg/0Hj452Zyf0k1IsS3CRTbCpuZZPrEmnPs+n0LVyuLN17n5VhxAzh5CQSLWTQ7PrR/1JOW1izIrJhyscfqVYcUvywVt46RViijNZqfA8DxvTEH671IyaAtWT/4WqkaQgWPmaXnv0yrIMHK4GN4cXRFaGGRT83u84IL1Cj1jXGsShWkQLaTn/1tZiKy814YrQaGryc/EMlydYEmRqdqPhI9AQMnIOqkgQcyPiZoOhi3KrPyFQXDg9mEkfHLBmjjaJcTqBAK/NQdS2zu6hltlAcjsK6/1wZhOTIwyRp76wRoYo+W3jDUfqVeepYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r7v0uDAyPnndo+LFt9fFbmVQtYSl1Tl6hQL7AEHodNrNKDg8XBa1WTeSpDwFlV5U0RtEgAQxnoaAwCnoxvIf99JBK/MoyCKIkikeqwJJAlR9rJ8UVMFSFTRYjn+Key9/71+uiOwLVthw6tMZGLhuK5IyfCsHmwONmRjYLutS4dMyEM0IligGhvUw7seDjeBMqlgvdmo2flHhTw7W2ktOPJvq6cpoVR83iTVLBiQNZ0teXR24GC+zq2QCD+Lj9LypIt5N4oWLrDcd/WebGQ3i10sklOV2MYXzleN3UYdZcd9LPrJPB86FkQFgfKIY3t6Ny/22gBgq/OBglG08An3yji8scBnXqooEdt2aaEhhWzEHEOBS74FehSz5z0Vshh2giAydP+JQWFyzDmJY8tAdh69+uo1UpL9XCiXFfJ4SSwnuEy3ZV+FFeGSrk2V7Mo2S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:15:13.4846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 928f3293-cc28-44bc-ed2e-08deff9f61de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF0004698D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8518
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

From: Le Ma <le.ma@amd.com>

Track discovered LSDMA instances in inst_mask and clear harvested
instances when processing the harvest table. Report the harvest state
through IP discovery sysfs for LSDMA v7.1.0.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h     |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4de9af1af0e4e..92033b67771c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -964,6 +964,9 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 		case MMHUB_HWID:
 			adev->mmhub.inst_mask &= ~BIT(inst);
 			break;
+		case LSDMA_HWID:
+			adev->lsdma.inst_mask &= ~BIT(inst);
+			break;
 #if defined(CONFIG_DRM_AMD_ISP)
 		case ISP_HWID:
 			adev->isp.harvest_config |= ~BIT(inst);
@@ -1257,6 +1260,9 @@ static uint8_t amdgpu_discovery_get_harvest_info(struct amdgpu_device *adev,
 	case MMHUB_HWID:
 		harvest = (BIT(inst) & adev->mmhub.inst_mask) == 0;
 		break;
+	case LSDMA_HWID:
+		harvest = (BIT(inst) & adev->lsdma.inst_mask) == 0;
+		break;
 	default:
 		break;
 	}
@@ -1802,6 +1808,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	adev->vcn.inst_mask = 0;
 	adev->jpeg.inst_mask = 0;
 	adev->mmhub.inst_mask = 0;
+	adev->lsdma.inst_mask = 0;
 	r = amdgpu_discovery_get_table_info(adev, &info, IP_DISCOVERY);
 	if (r)
 		return r;
@@ -1877,6 +1884,15 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 						AMDGPU_MAX_MMHUB_INSTANCES);
 			}
 
+			if (le16_to_cpu(ip->hw_id) == LSDMA_HWID) {
+				if (inst < AMDGPU_MAX_LSDMA_INSTANCES)
+					adev->lsdma.inst_mask |= BIT(inst);
+				else
+					dev_err(adev->dev, "Too many LSDMA instances: %d vs %d\n",
+						inst + 1,
+						AMDGPU_MAX_LSDMA_INSTANCES);
+			}
+
 			if (le16_to_cpu(ip->hw_id) == SDMA0_HWID ||
 			    le16_to_cpu(ip->hw_id) == SDMA1_HWID ||
 			    le16_to_cpu(ip->hw_id) == SDMA2_HWID ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
index e9a0237efd80b..34e92aaa4617c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
@@ -24,9 +24,12 @@
 #ifndef __AMDGPU_LSDMA_H__
 #define __AMDGPU_LSDMA_H__
 
+#define AMDGPU_MAX_LSDMA_INSTANCES 2
+
 struct amdgpu_lsdma {
 	struct mutex lock;
 	const struct amdgpu_lsdma_funcs      *funcs;
+	uint32_t inst_mask;
 };
 
 struct amdgpu_lsdma_funcs {
-- 
2.55.0

