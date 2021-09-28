Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3399FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E706101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 01E706101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8324B6E8E4;
	Tue, 28 Sep 2021 16:45:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54A216E8E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:45:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mv74u3qFwz+enritBL4cjyyNKCjLB16inFRyx/go92c6ptKVeL5N8/2CY5BfjqYjb7JoSJ5861HgcNUeR4FL+9UJwMx8CcXvAwLjn1Gcuh+K3aWNYDZE0VSIh1VtqA1f5YjiD9+jE7FHzG7iBndEB8IyGDJ2ExjasJDJo+2kJIVBa5Wglz9XJsOqgZVHJruUFbXGRWmFADG4W0KLDzCj0hwUFJo9U1UJJeFtSWlfG+trY0s85bEUB5srbsqC+kZrF1gxqdlG8oMjW8mr7C7va2JxZ51FoOKSXv/22iEVm/lM3GCNCP22FjG0ymh88CkXICQ5rtoR+V54dGIDdeDT/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=mer8xUU3ypGJVgRByRsfJgEbEnvJpWbR0kQj26t4X3U=;
 b=EGWGY+5UFm2KoJWosYQgH/HqzoRI6Yb96c/fpwe98UWG2q5sqWjQUrbk1rJJ/lO2LxZAhuJRcfIOmcJ661a2f4C0ddzbns0/ry4tay9eYzHC2fjKacr5Gbf3S3709M/1N8rDkErf5/3EvvJmBEVBGTlRMk7iTb/v2z+uUdjeZsv/NDkqXLklzv50p9FylSWql6VneGkwUn7dcn6PYJq/3LnQZFZlsSqgxlfNFvRXl846vYfnygVFoRIEhiDVL0A29nWlFNP1REvyp8fIQubQIFe+sC5Mr971EaOXrmv342AzERM9yEu8jQM5z1KBLfBlRHSD8moeFVnd4TOZxXByww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mer8xUU3ypGJVgRByRsfJgEbEnvJpWbR0kQj26t4X3U=;
 b=J9GUQIlVlCAnQ7HXz8SD74QLqsdhHA2pGanzGGNurni2AKt4Lt9d62IXGSk0HtOHeCTp+XUhrAHLBWC60Qb5F/LkDD13yXkNSVomL4k2d5I7tOYVIp45nHLc+XQtz1VzYoD36DjIVU2+VXg9255x2werswsp9kixVJaDW/avG0E=
Received: from DM6PR11CA0045.namprd11.prod.outlook.com (2603:10b6:5:14c::22)
 by DM8PR12MB5432.namprd12.prod.outlook.com (2603:10b6:8:32::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 16:45:53 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::50) by DM6PR11CA0045.outlook.office365.com
 (2603:10b6:5:14c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend
 Transport; Tue, 28 Sep 2021 16:45:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:45:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:45:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 48/64] drm/amdgpu/soc15: convert to IP version checking
Date: Tue, 28 Sep 2021 12:42:21 -0400
Message-ID: <20210928164237.833132-49-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32f163a7-cfa8-42ab-a976-08d9829f6f35
X-MS-TrafficTypeDiagnostic: DM8PR12MB5432:
X-Microsoft-Antispam-PRVS: <DM8PR12MB543295836DE75FF7A38D031BF7A89@DM8PR12MB5432.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8f7Bq6mG0KgeqeWc/BRUI3SNd44P94OENmF7ziNPHLtoa3M2HnfMcqQM8kAh/GujFNsuR5SiGAni8Hfwg61BGfOuJeJ1IO+8e5DJM1Yr9K0E53nI8gf44huqS1XgplxtnFC+cSYViDmDy9XaVpeadPoTHI0WoSpVEPox02I8CIcxl5pw34Z7btr+08ZTzQtbegDPbmz98pfMa0GwzVsMCEz1C0IrGMehmkD5VFbJ8ueK4mN1RoyXKIWfWo/2w7CovBdUdPsFkT6z6/WTYxJlBXUCZBH1BovAohZYROnSI9/uTIoLdjkP6a9Ysb7cwgndRqUtaJ20auCVDMh9TvyfUZKHqhXah3u1y6hPyuGGhrwmhWYCtgK1EnZcDANpucUfc5fupyUiRG4eR9AaAov2/yVK+8Rr4uqW/gXJ1ug8i7i2qbsW16LTfU98Ccawfz8ddaAF+jwqpJxVleCHsjXLRoswFJjfMvAJntdU8nhQ0mvq5lcxhjZJP0b/JkNvlvf5NwZniEVex1HHGtwM6lqKSDUPRPIMcqN/F9onwZTEvRlPpZ66WTHwKd7hVtpXVlmfi2eH5C4ssAbApRnufBiJioJoLPuI1Bhd9vsC+G4FA8LnN6FaFu3aKl07t3J4Pr5zgEsuAxwgFuhOIkyw0VXJyo0e3doXYlxpW8UlMswk/1guCAUWq6JOtEoy9SaWXiDvZeK7uc+liZcQpdoLc956NbAMBq1rvIRc/S8bhzlA0g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6916009)(83380400001)(336012)(7696005)(1076003)(70206006)(26005)(16526019)(186003)(8676002)(8936002)(81166007)(426003)(356005)(508600001)(70586007)(2906002)(6666004)(2616005)(66574015)(4326008)(82310400003)(316002)(54906003)(47076005)(86362001)(36860700001)(5660300002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:45:52.5975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f163a7-cfa8-42ab-a976-08d9829f6f35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5432
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

Use IP versions rather than asic_type to differentiate
IP version specific features.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 159 ++++++++++++++++-------------
 1 file changed, 88 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index f26d33faa0cb..7f4cd1a4f6cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -156,31 +156,38 @@ static const struct amdgpu_video_codecs rn_video_codecs_decode =
 static int soc15_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				    const struct amdgpu_video_codecs **codecs)
 {
-	switch (adev->asic_type) {
-	case CHIP_VEGA20:
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-		if (encode)
-			*codecs = &vega_video_codecs_encode;
-		else
-			*codecs = &vega_video_codecs_decode;
-		return 0;
-	case CHIP_RAVEN:
-		if (encode)
-			*codecs = &vega_video_codecs_encode;
-		else
-			*codecs = &rv_video_codecs_decode;
-		return 0;
-	case CHIP_ARCTURUS:
-	case CHIP_ALDEBARAN:
-	case CHIP_RENOIR:
-		if (encode)
-			*codecs = &vega_video_codecs_encode;
-		else
-			*codecs = &rn_video_codecs_decode;
-		return 0;
-	default:
-		return -EINVAL;
+	if (adev->ip_versions[VCE_HWIP]) {
+		switch (adev->ip_versions[VCE_HWIP]) {
+		case IP_VERSION(4, 0, 0):
+		case IP_VERSION(4, 1, 0):
+			if (encode)
+				*codecs = &vega_video_codecs_encode;
+			else
+				*codecs = &vega_video_codecs_decode;
+			return 0;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		switch (adev->ip_versions[UVD_HWIP]) {
+		case IP_VERSION(1, 0, 0):
+		case IP_VERSION(1, 0, 1):
+			if (encode)
+				*codecs = &vega_video_codecs_encode;
+			else
+				*codecs = &rv_video_codecs_decode;
+			return 0;
+		case IP_VERSION(2, 5, 0):
+		case IP_VERSION(2, 6, 0):
+		case IP_VERSION(2, 2, 0):
+			if (encode)
+				*codecs = &vega_video_codecs_encode;
+			else
+				*codecs = &rn_video_codecs_decode;
+			return 0;
+		default:
+			return -EINVAL;
+		}
 	}
 }
 
@@ -334,9 +341,11 @@ static u32 soc15_get_xclk(struct amdgpu_device *adev)
 {
 	u32 reference_clock = adev->clock.spll.reference_freq;
 
-	if (adev->asic_type == CHIP_RENOIR)
+	if (adev->ip_versions[MP1_HWIP] == IP_VERSION(12, 0, 0) ||
+	    adev->ip_versions[MP1_HWIP] == IP_VERSION(12, 0, 1))
 		return 10000;
-	if (adev->asic_type == CHIP_RAVEN)
+	if (adev->ip_versions[MP1_HWIP] == IP_VERSION(10, 0, 0) ||
+	    adev->ip_versions[MP1_HWIP] == IP_VERSION(10, 0, 1))
 		return reference_clock / 4;
 
 	return reference_clock;
@@ -567,28 +576,29 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
 				  amdgpu_reset_method);
 
-	switch (adev->asic_type) {
-	case CHIP_RAVEN:
-	case CHIP_RENOIR:
+	switch (adev->ip_versions[MP1_HWIP]) {
+	case IP_VERSION(10, 0, 0):
+	case IP_VERSION(10, 0, 1):
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
 		return AMD_RESET_METHOD_MODE2;
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_ARCTURUS:
-		baco_reset = amdgpu_dpm_is_baco_supported(adev);
-		break;
-	case CHIP_VEGA20:
-		if (adev->psp.sos.fw_version >= 0x80067)
+	case IP_VERSION(9, 0, 0):
+	case IP_VERSION(11, 0, 2):
+		if (adev->asic_type == CHIP_VEGA20) {
+			if (adev->psp.sos.fw_version >= 0x80067)
+				baco_reset = amdgpu_dpm_is_baco_supported(adev);
+			/*
+			 * 1. PMFW version > 0x284300: all cases use baco
+			 * 2. PMFW version <= 0x284300: only sGPU w/o RAS use baco
+			 */
+			if (ras && adev->ras_enabled &&
+			    adev->pm.fw_version <= 0x283400)
+				baco_reset = false;
+		} else {
 			baco_reset = amdgpu_dpm_is_baco_supported(adev);
-
-		/*
-		 * 1. PMFW version > 0x284300: all cases use baco
-		 * 2. PMFW version <= 0x284300: only sGPU w/o RAS use baco
-		 */
-		if (ras && adev->ras_enabled &&
-		    adev->pm.fw_version <= 0x283400)
-			baco_reset = false;
+		}
 		break;
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(13, 0, 2):
 		 /*
 		 * 1.connected to cpu: driver issue mode2 reset
 		 * 2.discret gpu: driver issue mode1 reset
@@ -631,15 +641,17 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
 
 static bool soc15_supports_baco(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_ARCTURUS:
-		return amdgpu_dpm_is_baco_supported(adev);
-	case CHIP_VEGA20:
-		if (adev->psp.sos.fw_version >= 0x80067)
+	switch (adev->ip_versions[MP1_HWIP]) {
+	case IP_VERSION(9, 0, 0):
+	case IP_VERSION(11, 0, 2):
+		if (adev->asic_type == CHIP_VEGA20) {
+			if (adev->psp.sos.fw_version >= 0x80067)
+				return amdgpu_dpm_is_baco_supported(adev);
+			return false;
+		} else {
 			return amdgpu_dpm_is_baco_supported(adev);
-		return false;
+		}
+		break;
 	default:
 		return false;
 	}
@@ -1157,8 +1169,11 @@ static int soc15_common_early_init(void *handle)
 
 	adev->rev_id = soc15_get_rev_id(adev);
 	adev->external_rev_id = 0xFF;
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
+	/* TODO: split the GC and PG flags based on the relevant IP version for which
+	 * they are relevant.
+	 */
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(9, 0, 1):
 		adev->asic_funcs = &soc15_asic_funcs;
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_MGLS |
@@ -1182,7 +1197,7 @@ static int soc15_common_early_init(void *handle)
 		adev->pg_flags = 0;
 		adev->external_rev_id = 0x1;
 		break;
-	case CHIP_VEGA12:
+	case IP_VERSION(9, 2, 1):
 		adev->asic_funcs = &soc15_asic_funcs;
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_MGLS |
@@ -1205,7 +1220,7 @@ static int soc15_common_early_init(void *handle)
 		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x14;
 		break;
-	case CHIP_VEGA20:
+	case IP_VERSION(9, 4, 0):
 		adev->asic_funcs = &vega20_asic_funcs;
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_MGLS |
@@ -1228,7 +1243,8 @@ static int soc15_common_early_init(void *handle)
 		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x28;
 		break;
-	case CHIP_RAVEN:
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 2, 2):
 		adev->asic_funcs = &soc15_asic_funcs;
 
 		if (adev->rev_id >= 0x8)
@@ -1302,7 +1318,7 @@ static int soc15_common_early_init(void *handle)
 			adev->pg_flags = AMD_PG_SUPPORT_SDMA | AMD_PG_SUPPORT_VCN;
 		}
 		break;
-	case CHIP_ARCTURUS:
+	case IP_VERSION(9, 4, 1):
 		adev->asic_funcs = &vega20_asic_funcs;
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_MGLS |
@@ -1321,7 +1337,7 @@ static int soc15_common_early_init(void *handle)
 		adev->pg_flags = AMD_PG_SUPPORT_VCN | AMD_PG_SUPPORT_VCN_DPG;
 		adev->external_rev_id = adev->rev_id + 0x32;
 		break;
-	case CHIP_RENOIR:
+	case IP_VERSION(9, 3, 0):
 		adev->asic_funcs = &soc15_asic_funcs;
 
 		if (adev->apu_flags & AMD_APU_IS_RENOIR)
@@ -1352,7 +1368,7 @@ static int soc15_common_early_init(void *handle)
 				 AMD_PG_SUPPORT_JPEG |
 				 AMD_PG_SUPPORT_VCN_DPG;
 		break;
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(9, 4, 2):
 		adev->asic_funcs = &vega20_asic_funcs;
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_MGLS |
@@ -1567,10 +1583,10 @@ static int soc15_common_set_clockgating_state(void *handle,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
+	switch (adev->ip_versions[NBIO_HWIP]) {
+	case IP_VERSION(6, 1, 0):
+	case IP_VERSION(6, 2, 0):
+	case IP_VERSION(7, 4, 0):
 		adev->nbio.funcs->update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
@@ -1586,8 +1602,9 @@ static int soc15_common_set_clockgating_state(void *handle,
 		adev->df.funcs->update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		break;
-	case CHIP_RAVEN:
-	case CHIP_RENOIR:
+	case IP_VERSION(7, 0, 0):
+	case IP_VERSION(7, 0, 1):
+	case IP_VERSION(2, 5, 0):
 		adev->nbio.funcs->update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
@@ -1599,8 +1616,8 @@ static int soc15_common_set_clockgating_state(void *handle,
 		soc15_update_drm_light_sleep(adev,
 				state == AMD_CG_STATE_GATE);
 		break;
-	case CHIP_ARCTURUS:
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(7, 4, 1):
+	case IP_VERSION(7, 4, 4):
 		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		break;
@@ -1622,7 +1639,7 @@ static void soc15_common_get_clockgating_state(void *handle, u32 *flags)
 
 	adev->hdp.funcs->get_clock_gating_state(adev, flags);
 
-	if (adev->asic_type != CHIP_ALDEBARAN) {
+	if (adev->ip_versions[MP0_HWIP] != IP_VERSION(13, 0, 2)) {
 
 		/* AMD_CG_SUPPORT_DRM_MGCG */
 		data = RREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_CGTT_CTRL0));
-- 
2.31.1

