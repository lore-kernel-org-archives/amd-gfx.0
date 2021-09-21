Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281A1C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED53560527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED53560527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AFF86EA7F;
	Tue, 21 Sep 2021 18:08:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11FE36EA7A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=covBwiXK91w6PXIEW/AnL06XdemtvpMD2KPGgbmwnjAh8ENm4K+C5LGpTnFEAWHAlm/KSa4gnZs5UanfGTbWlwJG/NiLYNetPt1bxaoZO+q2ZcIORwRRz3DNgI8KDVCuF/RheloKREJrqGdnC/8Q4AMMhTRP7DSS+g2rqiIRdV30AuN3mgfVKz5lEu5PBJWYidP+JhZSAoGKQxA6siaKcK7L/HteHvMJp5cE5azXYxMkDBSaMWe+LSKoGphmDJNZC3U9kIRQvGdyfvThtc5PqbBalD5tukp72JhvDIWB+qSka62WbaVGagVydI+6TBHk51xTpsxEGVi0cHQuro8pqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=rfrxhJcWVVKv2AjKRVYPhEWnLAuayrbnzB+EfSjY7T0=;
 b=eHwOnKFJz6NROiUZWB9t9aVx3tRoC9y+E1JcbRknEDjdp9YYiOFftbuzFT/3QTl7QaGiCwNN8UIVtc4YHqLcG0ll5iMq2AK19DGPV1/uY4B8zC/5S5utfWbR7z8apTcvKds21ziE3aEzITcH9g7D8Ha3HI8cJMXetyd/cKFBLYnEo2qhhA1TwLxJG8qLoSlf0fzvT+OfksvluFC6chWjFNDEQ1MRi+CIWn94lTQr2KQ+WTThX94KD3iDkQuZM3jIObrHSJtMPgBGKJkG1Fl/TR7bYjGATAGb/TR71wf8HukZm60RlmrrAh4mYw0m6Q9BnqBQiewuAMvdlVigevIJhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfrxhJcWVVKv2AjKRVYPhEWnLAuayrbnzB+EfSjY7T0=;
 b=y5zEUpdyUpL0EjdX0LIHne6WyDORDFSTcZLvrqcfkSkg93hJFwUXHrhbjXQfB5qQ0bdJ12JtC4Lc2tCruKC0wAyoo6Fb0vVM8kGBvSesG69j5evgbfG8fm/gRN6UBpVbXRAhkAvYdXncrVMkrFAuDLH2wJ+BVC21bocCfdhQp6g=
Received: from DM3PR12CA0043.namprd12.prod.outlook.com (2603:10b6:0:56::11) by
 BN8PR12MB2884.namprd12.prod.outlook.com (2603:10b6:408:97::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 18:08:01 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::6a) by DM3PR12CA0043.outlook.office365.com
 (2603:10b6:0:56::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 18:08:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 44/66] drm/amdgpu/pm/smu_v11.0: update IP version checking
Date: Tue, 21 Sep 2021 14:07:03 -0400
Message-ID: <20210921180725.1985552-45-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d1c4c87-6c2a-438e-6d35-08d97d2ac010
X-MS-TrafficTypeDiagnostic: BN8PR12MB2884:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2884AFCFB16F3B15E1BF96B4F7A19@BN8PR12MB2884.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qv9dXHsbN+dZHu8PdO/jDL94nj3JFvlUgXkLrvqjhiJQ4iu33Z2QbwAGDBpZCXwlnlFYlpgjVw+wrf8Jy4Pn+URaYV6QKQElzQxzQ1jWIfNZQpcZMPnLi288qdXYF6zKiw8y5YeIrptyrH2ZuXTY27ePWLAe2lHisINPOOOS/SjapT9yGIOz5M8K7QxG7FkPwZ4e8VuabsuQNxdZGydt7TAFooUgkaLOcAghK/pM66EyKKrH1XY6lB1CeXMMPNyyvPr7c3OODI53SAnP4NKDVjJSHs26f0bgtnyfg0Sw1t9uEsTepanXuu8XMIbdSYyHh3eV3ZEkLyezeZEedCS5U8OFnmz0KIqiCtnhbsSmNK1lxv3pi6mhVRgIXrxwROSUXilnnurCABes7QadsRQ0noRpYqzJJshKcZ8sRN1d3Pjo6W6oSaLrUmW8s5UH2C3HLb2kN3e6mAQrMK6FlzZWFnwduSKAZUTVc1fC3FBTvbeB5wPtG20GfMG+rVFNs7X2pNAmkJWVIOg1v1q+IT3GtwXOvsO/LOy6c5tbn4kDDZa+6w7dXzkWyPHSMPFMAzfiYEo7vUd9R6NHlPA23tfC2Jkb1LSLQ0Gdj+R8x5b2gMG+PVh1oHTANA/QGYpw9h8kRe4TCfIWlyXTCNcwdzHZhvNWxcSF4FqBuxEQLBtJah+vKTH3IUvL3Bj8qprlysThsLybId9pr7q5lNY7Q0wB/tCeZ0dK0PFJS5lThRn1DeM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(86362001)(8936002)(81166007)(16526019)(186003)(4326008)(70586007)(2906002)(36860700001)(6916009)(508600001)(336012)(83380400001)(426003)(36756003)(47076005)(356005)(2616005)(6666004)(7696005)(1076003)(70206006)(8676002)(5660300002)(316002)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:01.2876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1c4c87-6c2a-438e-6d35-08d97d2ac010
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2884
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 5af7c8b7806f..1ae8b8dc3bd3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -116,12 +116,12 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
 	case IP_VERSION(11, 0, 13):
 		chip_name = "beige_goby";
 		break;
+	case IP_VERSION(11, 0, 2):
+		chip_name = "arcturus";
+		break;
 	default:
-		if (adev->asic_type == CHIP_ARCTURUS) {
-			chip_name = "arcturus";
-			break;
-		}
-		dev_err(adev->dev, "Unsupported ASIC type %d\n", adev->asic_type);
+		dev_err(adev->dev, "Unsupported IP version 0x%x\n",
+			adev->ip_versions[MP1_HWIP]);
 		return -EINVAL;
 	}
 
@@ -267,12 +267,12 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 	case IP_VERSION(11, 0, 8):
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Cyan_Skillfish;
 		break;
+	case IP_VERSION(11, 0, 2):
+		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_ARCT;
+		break;
 	default:
-		if (adev->asic_type == CHIP_ARCTURUS) {
-			smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_ARCT;
-			break;
-		}
-		dev_err(smu->adev->dev, "smu unsupported asic type:%d.\n", smu->adev->asic_type);
+		dev_err(smu->adev->dev, "smu unsupported IP version: 0x%x.\n",
+			adev->ip_versions[MP1_HWIP]);
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_INV;
 		break;
 	}
@@ -1653,7 +1653,7 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 		default:
 			if (!ras || !adev->ras_enabled ||
 			    adev->gmc.xgmi.pending_reset) {
-				if (adev->asic_type == CHIP_ARCTURUS) {
+				if (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 2)) {
 					data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL_ARCT);
 					data |= 0x80000000;
 					WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL_ARCT, data);
@@ -1935,7 +1935,7 @@ int smu_v11_0_set_performance_level(struct smu_context *smu,
 	 * Separate MCLK and SOCCLK soft min/max settings are not allowed
 	 * on Arcturus.
 	 */
-	if (adev->asic_type == CHIP_ARCTURUS) {
+	if (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 2)) {
 		mclk_min = mclk_max = 0;
 		socclk_min = socclk_max = 0;
 	}
-- 
2.31.1

