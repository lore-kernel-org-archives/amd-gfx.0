Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A15C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 18:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 226E414BF25;
	Wed, 13 Jul 2022 18:01:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D71018A4DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 18:01:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJQ4QLVL9X+rLV/ExBYYR9Kek6E5gkQQzBZLh5OHpQ5EMddYP6+5oDmOLLLJviyQWFtx8j9lBF1QJ5rixX86gHkxhV38faMNLTwbCHSvO3Uv+MD9mTsltGmk+oIQEdBI7TeBmsLIbwYqg2DHjQ6RCd8v5NyXzFtrbGjbzojuD5f28FrazNc4ibHS0nNHlQXcDUuSh6XZqVIgqtlR6Gvg0wEZk8+aypEs8ZUDpKsGePvkBj+9wSvfz2JoGjWJJMsd5fdKAdwL8K6y42CvykzDKzAl/w5fTGc1tmVTx0qboAUDzgh83G8sJqO6EeGyvSXMAES3D2zJAvwuw0be9C4sUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ao3I/GGmyAIrENZ3GpmbG/IUN6lbrefFJ2eG1M4OLSw=;
 b=n2l+h2ir5ztv54KyCczBTKCGWKYeCrm+/WlT7uoq3Rfb/oELJnCeTFiFXcdyi8HTPKT5VgS31NuEmCuVn5Itc6nOo9Htmgl1cnbXsAFu7KI7rRUzZIMmntVbSRysQZ5LcWz5E67t5huVfxIn7Gojvh+8Z3eUBKdNWGuq09WtRd563D8GNqQFJhOPsbBEFLT2nZXcX6veWoom4N97D/pzbcZvCmJNupXCLktRHVvtmJO9Ev0QvizWkapA1Kp7qQSYyd69Mf10/1ymBaSefDic4U8XnZA27aH6EY2E+VK4e8CGAnaHzjGerYUNYhRmV1qfe0LS2cIhUIPYKvgbvr1MSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ao3I/GGmyAIrENZ3GpmbG/IUN6lbrefFJ2eG1M4OLSw=;
 b=OG/US6qqq8D0LWAspIH3zWcZkDEU+wNzU3IYvEQbxR3A/SPqnky2eXVGsOpKRF+1GKQfJPzxJqrhbCP6g+AMIoArg0W/7pNMbnDbb7ded4GPv9wgbPcRsUhQUscCEKcEYnMJSdPHBvtO2UMrti3R0Ru/HPnZ9oXGidGhtBFEXEs=
Received: from DS7PR03CA0318.namprd03.prod.outlook.com (2603:10b6:8:2b::32) by
 BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 18:01:24 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::9e) by DS7PR03CA0318.outlook.office365.com
 (2603:10b6:8:2b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Wed, 13 Jul 2022 18:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 18:01:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 13:01:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: use the same HDP flush registers for all nbio
 2.3.x
Date: Wed, 13 Jul 2022 14:00:56 -0400
Message-ID: <20220713180056.529423-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220713180056.529423-1-alexander.deucher@amd.com>
References: <20220713180056.529423-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27fd714c-ff28-4877-1baf-08da64f9b2d8
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y9BVRSSxou86LRgZNp7BRniZBM5md0C9r/AyV+ACy1p7SHt0iAjf2KCIo07PGQ0lXzSwq0+yrCIJlIYCBorPUezLRG1xJIHETGxc8vT/6hH9Ur9U3husPcM58aw/B5JElPY8/rcyAlc0uCq1D4AdpSb5R1mm0irrqUa0QJ+akUVtbASmvC0rgmMAcM2erR/SnPVJMH8Wp6Ht/8TjGfK1rX+5irbyKWNutS+0tt62tUmiHUTGY5PZIDJUPJIOggowr158M0cq3sl7aabs/jFyxa5VsmXDLEOLYUcMexLSB4kJleSe9vA3QJ9PM/3XwnYgMqj6CXZrlwEFoxxFM2Xd3mxhLKNoxcB/+8rLBHn34MYoXKmmTQbk1pxYDf5JjBgtYkaWsL28siLahCkQbZn2WvUN6mASIKG4j6c08ZE040wq+D6BXkovabSex5H9L6zJatvLa1701aV55zdkpcuCJYtr48l3IpOgcRUcCsKM/D5iKzY76puhgt2eDVvKcPYYG5qh0gpRk9QF/Bp4++W5dkSReKgUu7TR/ZuUXt540mqYjqeXVJ5u0rzV03AD2VviVhYL3C1IL1YHY0IDgRqSq5ETsidRffdWKHI9NnJVnFBkU2qkWKJm/K8IXyUY7H0ieP67OUx6wyMiMEFgwuCy5K/v59N8AQFLvcgohjq1yO14POqdFN7zhPSxtHDTMq2K2RZx0rN/qJ/KNh/snXbIJkgc5CeH5PrMzP7xUZ+Sg3kjvnAYBYBllowzC6PrO1fwrJCFQ91FHfHas6taNXhz0QgDpND6zQq45GSr/dK4I/z0kSyWAxS8UWwGt1s7JdrP9YSasKAUVsV5rSugsMRpIPVlthFX6Ada/9mwulD2nSs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(40470700004)(46966006)(36840700001)(82740400003)(82310400005)(426003)(336012)(478600001)(83380400001)(86362001)(2906002)(6666004)(40460700003)(316002)(356005)(47076005)(41300700001)(7696005)(2616005)(81166007)(70206006)(26005)(70586007)(40480700001)(36860700001)(1076003)(5660300002)(36756003)(8936002)(6916009)(186003)(4326008)(8676002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 18:01:23.5394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fd714c-ff28-4877-1baf-08da64f9b2d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3876
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Align RDNA2.x with other asics.  One HDP bit per SDMA instance,
aligned with firmware.  This is effectively a revert of
commit 369b7d04baf3 ("drm/amdgpu/nbio2.3: don't use GPU_HDP_FLUSH bit 12").
On further discussions with the relevant hardware teams,
re-align the bits for SDMA.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  5 +----
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c        | 21 -------------------
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h        |  1 -
 3 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4f83897a54a8..22144ba6c7ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2229,15 +2229,12 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(2, 3, 0):
 	case IP_VERSION(2, 3, 1):
 	case IP_VERSION(2, 3, 2):
-		adev->nbio.funcs = &nbio_v2_3_funcs;
-		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
-		break;
 	case IP_VERSION(3, 3, 0):
 	case IP_VERSION(3, 3, 1):
 	case IP_VERSION(3, 3, 2):
 	case IP_VERSION(3, 3, 3):
 		adev->nbio.funcs = &nbio_v2_3_funcs;
-		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg_sc;
+		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
 		break;
 	case IP_VERSION(4, 3, 0):
 	case IP_VERSION(4, 3, 1):
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 34c610b9157d..b465baa26762 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -328,27 +328,6 @@ const struct nbio_hdp_flush_reg nbio_v2_3_hdp_flush_reg = {
 	.ref_and_mask_sdma1 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__SDMA1_MASK,
 };
 
-const struct nbio_hdp_flush_reg nbio_v2_3_hdp_flush_reg_sc = {
-	.ref_and_mask_cp0 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP0_MASK,
-	.ref_and_mask_cp1 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP1_MASK,
-	.ref_and_mask_cp2 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP2_MASK,
-	.ref_and_mask_cp3 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP3_MASK,
-	.ref_and_mask_cp4 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP4_MASK,
-	.ref_and_mask_cp5 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP5_MASK,
-	.ref_and_mask_cp6 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP6_MASK,
-	.ref_and_mask_cp7 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP7_MASK,
-	.ref_and_mask_cp8 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP8_MASK,
-	.ref_and_mask_cp9 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP9_MASK,
-	.ref_and_mask_sdma0 = GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK,
-	.ref_and_mask_sdma1 = GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK,
-	.ref_and_mask_sdma2 = GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK,
-	.ref_and_mask_sdma3 = GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK,
-	.ref_and_mask_sdma4 = GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK,
-	.ref_and_mask_sdma5 = GPU_HDP_FLUSH_DONE__RSVD_ENG6_MASK,
-	.ref_and_mask_sdma6 = GPU_HDP_FLUSH_DONE__RSVD_ENG7_MASK,
-	.ref_and_mask_sdma7 = GPU_HDP_FLUSH_DONE__RSVD_ENG8_MASK,
-};
-
 static void nbio_v2_3_init_registers(struct amdgpu_device *adev)
 {
 	uint32_t def, data;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h
index 6074dd3a1ed8..a43b60acf7f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h
@@ -27,7 +27,6 @@
 #include "soc15_common.h"
 
 extern const struct nbio_hdp_flush_reg nbio_v2_3_hdp_flush_reg;
-extern const struct nbio_hdp_flush_reg nbio_v2_3_hdp_flush_reg_sc;
 extern const struct amdgpu_nbio_funcs nbio_v2_3_funcs;
 
 #endif
-- 
2.35.3

