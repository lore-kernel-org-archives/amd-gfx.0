Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613E6C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3171F60527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3171F60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA40D6EAA8;
	Tue, 21 Sep 2021 18:08:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A1A66EA82
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGvKirKdAJqTH3DDirfLBSEGga9LJty8vBWIKu2PpO6aDsPIkVszt9r51kEtV87wfJ/khkphOEI/w6YlqIe/8nu+pMCj+pQaQnpI7wEgTvSfXW2AiGjgPe72USRfNffrhM2IYkL546BSlBARHZj7+XxvquhZokGC7TAc5is8ZBLiXwo+avzbJhti20MYzBzy98BoqkrDvXWjVvQaltUUbbcf+210ZwVCZr3eTaFAuCHDR0u8FlJeDIXw387olvN7B8eH5seroT9ZUM+qHh59xIoEQoj3AbV7gxDJB2XQ6l105w4sKz1fWPQy+oDnxmUqn0fk66U+vL3agKvMp7l+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=g4w/t31IGTOPDhhPAwu9vGsV1hBBZI/vrrYLTl7rxvs=;
 b=hKmnmmLG2dUIxkgcFhX+GW90zjZqGekBvul8QZMpVmRsZQU+0ysVLAsxIUyCkZqF6yBGa4ly68p1GR5AuHoq+CgSjCLSyB0n9uBLIbgGaCzvBRY04lfnFrf5x9hPuNJFEpcd/moeUSI8Srj8pfl/vCc4H5ld12bii9OVq6qf98voHWvxlbECOJMeD29OnadiP+ADDDE2s2rqBB+lnl2XX/kkSt9qkgSR8nJ4o8nFoNVU9JIAx6hUdsoVHyfMh9CBXOuAJh4KwizsbTE3jhb+SGEPMw4Pq/0neT6tlzAOMcR8gVFV3PiVntuGEXIXxb+0h70g9hkraMcErLRVdCUHhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4w/t31IGTOPDhhPAwu9vGsV1hBBZI/vrrYLTl7rxvs=;
 b=m6NHA+niV7QyeTNE9bmh9ycxHNuyimJn+ebeKX0klNgW6bU8uPbES8UzjuE0wZPuISX1qbIbSkPPFtcse7F6XiHFWazzdeiUJ0EH4dV8LRRSz3+hDZ2Fc1IE7b2muIXzoRjEMa15XiNvsrsq/9bSUKU4pR1CpCYzKwLqOwbzK5U=
Received: from DM3PR12CA0053.namprd12.prod.outlook.com (2603:10b6:0:56::21) by
 BYAPR12MB2949.namprd12.prod.outlook.com (2603:10b6:a03:12f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 18:07:59 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::64) by DM3PR12CA0053.outlook.office365.com
 (2603:10b6:0:56::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:59 +0000
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
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 18:07:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 40/66] drm/amdgpu/gfx9.0: convert to IP version checking
Date: Tue, 21 Sep 2021 14:06:59 -0400
Message-ID: <20210921180725.1985552-41-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7621bedc-ad26-4d1c-c0c1-08d97d2abf08
X-MS-TrafficTypeDiagnostic: BYAPR12MB2949:
X-Microsoft-Antispam-PRVS: <BYAPR12MB29490F975356C713DAB575F2F7A19@BYAPR12MB2949.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omGCBA6OxRISkigT4/l9ZjP9bJLMziTWJRtlC1iyvhnnEDxEdc54Mg0sxotLPFgf6cq7ha1C9LSNiRnSMLiusY9Uo6ZByL9OsKrwh2X3zVx2BxmPSY+hPCXFre1UTJy5z8NXaRytuIfn9pJFUx5+e9n2XCo6CZBm6c96ZhvWMEmvEuz4g0ehRZ82IF9sTcp/BYqmXKGyhsiRd0P0xAiYna0K4QJrf40QhZLFPHoDzmHhXXS+UpiRKIe0bMohF80sEWJI+hg9GOAgbnqk2tSo1GrAxu1hntELpGKw5ocpzO78CTsU7JZfOh1NCLIG/Ym4Q8F6r5faHAAFxa+FhFjIuloDKGVJs7kSrkdXBJvIgNVl0ycD2gZ0fdq8VYM3XsOnHPspWle9hgbQIwF7ruSVgSKuvJiQIeNMQ9atpRuyUOqMKaIMgUpq1z5C6ba8B0HNlAK9bA79Rn19dJXR7C0+q/3P9dExdQBR1FxlyNFfKZVMwtNK9LMSr6QYsdqetvmFnLZgN6y63F03YvnjfhyKblbDABp03W3zEkbxMoGrL+UVyvOgCnyJUTW8nlhTnQsGK6OX1/V2lfYEyr/TUgRT9l5wDABpUWI9SiOE+FocDga4jDrECio4MI2LdcE9gqvBLbpiuD5EnaCZefmTvWLX+hvPtKxtQiy3XaG+QV+Q/t2x3Nfxe3eiDj1HaVjIFCBWOjB0i3asmceM/ADQrsjoWA9F2udCkM8VOpOkSPkwhT4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(47076005)(81166007)(1076003)(2906002)(6916009)(2616005)(7696005)(26005)(336012)(508600001)(83380400001)(86362001)(82310400003)(4326008)(356005)(36860700001)(316002)(30864003)(426003)(8936002)(5660300002)(8676002)(36756003)(70586007)(16526019)(70206006)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:59.5536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7621bedc-ad26-4d1c-c0c1-08d97d2abf08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2949
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 227 ++++++++++++++------------
 1 file changed, 120 insertions(+), 107 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d9be1b773085..3a160d78c98f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -953,8 +953,8 @@ static void gfx_v9_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
 
 static void gfx_v9_0_init_golden_registers(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(9, 0, 1):
 		soc15_program_register_sequence(adev,
 						golden_settings_gc_9_0,
 						ARRAY_SIZE(golden_settings_gc_9_0));
@@ -962,7 +962,7 @@ static void gfx_v9_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_gc_9_0_vg10,
 						ARRAY_SIZE(golden_settings_gc_9_0_vg10));
 		break;
-	case CHIP_VEGA12:
+	case IP_VERSION(9, 2, 1):
 		soc15_program_register_sequence(adev,
 						golden_settings_gc_9_2_1,
 						ARRAY_SIZE(golden_settings_gc_9_2_1));
@@ -970,7 +970,7 @@ static void gfx_v9_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_gc_9_2_1_vg12,
 						ARRAY_SIZE(golden_settings_gc_9_2_1_vg12));
 		break;
-	case CHIP_VEGA20:
+	case IP_VERSION(9, 4, 0):
 		soc15_program_register_sequence(adev,
 						golden_settings_gc_9_0,
 						ARRAY_SIZE(golden_settings_gc_9_0));
@@ -978,12 +978,13 @@ static void gfx_v9_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_gc_9_0_vg20,
 						ARRAY_SIZE(golden_settings_gc_9_0_vg20));
 		break;
-	case CHIP_ARCTURUS:
+	case IP_VERSION(9, 4, 1):
 		soc15_program_register_sequence(adev,
 						golden_settings_gc_9_4_1_arct,
 						ARRAY_SIZE(golden_settings_gc_9_4_1_arct));
 		break;
-	case CHIP_RAVEN:
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 1, 0):
 		soc15_program_register_sequence(adev, golden_settings_gc_9_1,
 						ARRAY_SIZE(golden_settings_gc_9_1));
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
@@ -995,12 +996,12 @@ static void gfx_v9_0_init_golden_registers(struct amdgpu_device *adev)
 							golden_settings_gc_9_1_rv1,
 							ARRAY_SIZE(golden_settings_gc_9_1_rv1));
 		break;
-	 case CHIP_RENOIR:
+	 case IP_VERSION(9, 3, 0):
 		soc15_program_register_sequence(adev,
 						golden_settings_gc_9_1_rn,
 						ARRAY_SIZE(golden_settings_gc_9_1_rn));
 		return; /* for renoir, don't need common goldensetting */
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(9, 4, 2):
 		gfx_v9_4_2_init_golden_registers(adev,
 						 adev->smuio.funcs->get_die_id(adev));
 		break;
@@ -1008,8 +1009,8 @@ static void gfx_v9_0_init_golden_registers(struct amdgpu_device *adev)
 		break;
 	}
 
-	if ((adev->asic_type != CHIP_ARCTURUS) &&
-	    (adev->asic_type != CHIP_ALDEBARAN))
+	if ((adev->ip_versions[GC_HWIP] != IP_VERSION(9, 4, 1)) &&
+	    (adev->ip_versions[GC_HWIP] != IP_VERSION(9, 4, 2)))
 		soc15_program_register_sequence(adev, golden_settings_gc_9_x_common,
 						(const u32)ARRAY_SIZE(golden_settings_gc_9_x_common));
 }
@@ -1193,15 +1194,15 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgpu_device *adev)
 	adev->gfx.me_fw_write_wait = false;
 	adev->gfx.mec_fw_write_wait = false;
 
-	if ((adev->asic_type != CHIP_ARCTURUS) &&
+	if ((adev->ip_versions[GC_HWIP] != IP_VERSION(9, 4, 1)) &&
 	    ((adev->gfx.mec_fw_version < 0x000001a5) ||
 	    (adev->gfx.mec_feature_version < 46) ||
 	    (adev->gfx.pfp_fw_version < 0x000000b7) ||
 	    (adev->gfx.pfp_feature_version < 46)))
 		DRM_WARN_ONCE("CP firmware version too old, please update!");
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(9, 0, 1):
 		if ((adev->gfx.me_fw_version >= 0x0000009c) &&
 		    (adev->gfx.me_feature_version >= 42) &&
 		    (adev->gfx.pfp_fw_version >=  0x000000b1) &&
@@ -1212,7 +1213,7 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgpu_device *adev)
 		    (adev->gfx.mec_feature_version >= 42))
 			adev->gfx.mec_fw_write_wait = true;
 		break;
-	case CHIP_VEGA12:
+	case IP_VERSION(9, 2, 1):
 		if ((adev->gfx.me_fw_version >= 0x0000009c) &&
 		    (adev->gfx.me_feature_version >= 44) &&
 		    (adev->gfx.pfp_fw_version >=  0x000000b2) &&
@@ -1223,7 +1224,7 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgpu_device *adev)
 		    (adev->gfx.mec_feature_version >= 44))
 			adev->gfx.mec_fw_write_wait = true;
 		break;
-	case CHIP_VEGA20:
+	case IP_VERSION(9, 4, 0):
 		if ((adev->gfx.me_fw_version >= 0x0000009c) &&
 		    (adev->gfx.me_feature_version >= 44) &&
 		    (adev->gfx.pfp_fw_version >=  0x000000b2) &&
@@ -1234,7 +1235,8 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgpu_device *adev)
 		    (adev->gfx.mec_feature_version >= 44))
 			adev->gfx.mec_fw_write_wait = true;
 		break;
-	case CHIP_RAVEN:
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 2, 2):
 		if ((adev->gfx.me_fw_version >= 0x0000009c) &&
 		    (adev->gfx.me_feature_version >= 42) &&
 		    (adev->gfx.pfp_fw_version >=  0x000000b1) &&
@@ -1299,7 +1301,7 @@ static bool is_raven_kicker(struct amdgpu_device *adev)
 
 static bool check_if_enlarge_doorbell_range(struct amdgpu_device *adev)
 {
-	if ((adev->asic_type == CHIP_RENOIR) &&
+	if ((adev->ip_versions[GC_HWIP] == IP_VERSION(9, 3, 0)) &&
 	    (adev->gfx.me_fw_version >= 0x000000a5) &&
 	    (adev->gfx.me_feature_version >= 52))
 		return true;
@@ -1312,12 +1314,13 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
 	if (gfx_v9_0_should_disable_gfxoff(adev->pdev))
 		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(9, 2, 1):
+	case IP_VERSION(9, 4, 0):
 		break;
-	case CHIP_RAVEN:
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 1, 0):
 		if (!((adev->apu_flags & AMD_APU_IS_RAVEN2) ||
 		      (adev->apu_flags & AMD_APU_IS_PICASSO)) &&
 		    ((!is_raven_kicker(adev) &&
@@ -1331,7 +1334,7 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
 				AMD_PG_SUPPORT_CP |
 				AMD_PG_SUPPORT_RLC_SMU_HS;
 		break;
-	case CHIP_RENOIR:
+	case IP_VERSION(9, 3, 0):
 		if (adev->pm.pp_feature & PP_GFXOFF_MASK)
 			adev->pg_flags |= AMD_PG_SUPPORT_GFX_PG |
 				AMD_PG_SUPPORT_CP |
@@ -1555,9 +1558,9 @@ static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
 
 static bool gfx_v9_0_load_mec2_fw_bin_support(struct amdgpu_device *adev)
 {
-	if (adev->asic_type == CHIP_ALDEBARAN ||
-	    adev->asic_type == CHIP_ARCTURUS ||
-	    adev->asic_type == CHIP_RENOIR)
+	if (adev->ip_versions[GC_HWIP] == IP_VERSION(9, 4, 2) ||
+	    adev->ip_versions[GC_HWIP] == IP_VERSION(9, 4, 1) ||
+	    adev->ip_versions[GC_HWIP] == IP_VERSION(9, 3, 0))
 		return false;
 
 	return true;
@@ -1665,17 +1668,18 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
 
 	DRM_DEBUG("\n");
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(9, 0, 1):
 		chip_name = "vega10";
 		break;
-	case CHIP_VEGA12:
+	case IP_VERSION(9, 2, 1):
 		chip_name = "vega12";
 		break;
-	case CHIP_VEGA20:
+	case IP_VERSION(9, 4, 0):
 		chip_name = "vega20";
 		break;
-	case CHIP_RAVEN:
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 1, 0):
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
 			chip_name = "raven2";
 		else if (adev->apu_flags & AMD_APU_IS_PICASSO)
@@ -1683,16 +1687,16 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
 		else
 			chip_name = "raven";
 		break;
-	case CHIP_ARCTURUS:
+	case IP_VERSION(9, 4, 1):
 		chip_name = "arcturus";
 		break;
-	case CHIP_RENOIR:
+	case IP_VERSION(9, 3, 0):
 		if (adev->apu_flags & AMD_APU_IS_RENOIR)
 			chip_name = "renoir";
 		else
 			chip_name = "green_sardine";
 		break;
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(9, 4, 2):
 		chip_name = "aldebaran";
 		break;
 	default:
@@ -1796,7 +1800,7 @@ static void gfx_v9_0_init_always_on_cu_mask(struct amdgpu_device *adev)
 
 	if (adev->flags & AMD_IS_APU)
 		always_on_cu_num = 4;
-	else if (adev->asic_type == CHIP_VEGA12)
+	else if (adev->ip_versions[GC_HWIP] == IP_VERSION(9, 2, 1))
 		always_on_cu_num = 8;
 	else
 		always_on_cu_num = 12;
@@ -1965,11 +1969,12 @@ static int gfx_v9_0_rlc_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	switch (adev->asic_type) {
-	case CHIP_RAVEN:
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 1, 0):
 		gfx_v9_0_init_lbpw(adev);
 		break;
-	case CHIP_VEGA20:
+	case IP_VERSION(9, 4, 0):
 		gfx_v9_4_init_lbpw(adev);
 		break;
 	default:
@@ -2144,8 +2149,8 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 
 	adev->gfx.funcs = &gfx_v9_0_gfx_funcs;
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(9, 0, 1):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -2153,7 +2158,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
 		gb_addr_config = VEGA10_GB_ADDR_CONFIG_GOLDEN;
 		break;
-	case CHIP_VEGA12:
+	case IP_VERSION(9, 2, 1):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -2162,7 +2167,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		gb_addr_config = VEGA12_GB_ADDR_CONFIG_GOLDEN;
 		DRM_INFO("fix gfx.config for vega12\n");
 		break;
-	case CHIP_VEGA20:
+	case IP_VERSION(9, 4, 0):
 		adev->gfx.ras_funcs = &gfx_v9_0_ras_funcs;
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
@@ -2177,7 +2182,8 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		if (err)
 			return err;
 		break;
-	case CHIP_RAVEN:
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 1, 0):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -2188,7 +2194,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		else
 			gb_addr_config = RAVEN_GB_ADDR_CONFIG_GOLDEN;
 		break;
-	case CHIP_ARCTURUS:
+	case IP_VERSION(9, 4, 1):
 		adev->gfx.ras_funcs = &gfx_v9_4_ras_funcs;
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
@@ -2199,7 +2205,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		gb_addr_config &= ~0xf3e777ff;
 		gb_addr_config |= 0x22014042;
 		break;
-	case CHIP_RENOIR:
+	case IP_VERSION(9, 3, 0):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -2209,7 +2215,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		gb_addr_config &= ~0xf3e777ff;
 		gb_addr_config |= 0x22010042;
 		break;
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(9, 4, 2):
 		adev->gfx.ras_funcs = &gfx_v9_4_2_ras_funcs;
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
@@ -2307,14 +2313,15 @@ static int gfx_v9_0_sw_init(void *handle)
 	struct amdgpu_kiq *kiq;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-	case CHIP_RAVEN:
-	case CHIP_ARCTURUS:
-	case CHIP_RENOIR:
-	case CHIP_ALDEBARAN:
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(9, 2, 1):
+	case IP_VERSION(9, 4, 0):
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 3, 0):
+	case IP_VERSION(9, 4, 2):
 		adev->gfx.mec.num_mec = 2;
 		break;
 	default:
@@ -2598,8 +2605,8 @@ static void gfx_v9_0_init_sq_config(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
 
-	switch (adev->asic_type) {
-	case CHIP_ARCTURUS:
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(9, 4, 1):
 		tmp = RREG32_SOC15(GC, 0, mmSQ_CONFIG);
 		tmp = REG_SET_FIELD(tmp, SQ_CONFIG,
 					DISABLE_BARRIER_WAITCNT, 1);
@@ -2934,7 +2941,7 @@ static void gfx_v9_0_init_gfx_power_gating(struct amdgpu_device *adev)
 		/* program GRBM_REG_SAVE_GFX_IDLE_THRESHOLD to 0x55f0 */
 		data |= (0x55f0 << RLC_AUTO_PG_CTRL__GRBM_REG_SAVE_GFX_IDLE_THRESHOLD__SHIFT);
 		WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_AUTO_PG_CTRL), data);
-		if (adev->asic_type != CHIP_RENOIR)
+		if (adev->ip_versions[GC_HWIP] != IP_VERSION(9, 3, 0))
 			pwr_10_0_gfxip_control_over_cgpg(adev, true);
 	}
 }
@@ -3046,7 +3053,7 @@ static void gfx_v9_0_init_pg(struct amdgpu_device *adev)
 	 * And it's needed by gfxoff feature.
 	 */
 	if (adev->gfx.rlc.is_rlc_v2_1) {
-		if (adev->asic_type == CHIP_VEGA12 ||
+		if (adev->ip_versions[GC_HWIP] == IP_VERSION(9, 2, 1) ||
 		    (adev->apu_flags & AMD_APU_IS_RAVEN2))
 			gfx_v9_1_init_rlc_save_restore_list(adev);
 		gfx_v9_0_enable_save_restore_machine(adev);
@@ -3159,14 +3166,15 @@ static int gfx_v9_0_rlc_resume(struct amdgpu_device *adev)
 			return r;
 	}
 
-	switch (adev->asic_type) {
-	case CHIP_RAVEN:
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 1, 0):
 		if (amdgpu_lbpw == 0)
 			gfx_v9_0_enable_lbpw(adev, false);
 		else
 			gfx_v9_0_enable_lbpw(adev, true);
 		break;
-	case CHIP_VEGA20:
+	case IP_VERSION(9, 4, 0):
 		if (amdgpu_lbpw > 0)
 			gfx_v9_0_enable_lbpw(adev, true);
 		else
@@ -3961,8 +3969,8 @@ static void gfx_v9_0_init_tcp_config(struct amdgpu_device *adev)
 {
 	u32 tmp;
 
-	if (adev->asic_type != CHIP_ARCTURUS &&
-	    adev->asic_type != CHIP_ALDEBARAN)
+	if (adev->ip_versions[GC_HWIP] != IP_VERSION(9, 4, 1) &&
+	    adev->ip_versions[GC_HWIP] != IP_VERSION(9, 4, 2))
 		return;
 
 	tmp = RREG32_SOC15(GC, 0, mmTCP_ADDR_CONFIG);
@@ -4002,7 +4010,7 @@ static int gfx_v9_0_hw_init(void *handle)
 	if (r)
 		return r;
 
-	if (adev->asic_type == CHIP_ALDEBARAN)
+	if (adev->ip_versions[GC_HWIP] == IP_VERSION(9, 4, 2))
 		gfx_v9_4_2_set_power_brake_sequence(adev);
 
 	return r;
@@ -4234,7 +4242,7 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 
 	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
-	if (adev->asic_type == CHIP_VEGA10 && amdgpu_sriov_runtime(adev)) {
+	if (adev->ip_versions[GC_HWIP] == IP_VERSION(9, 0, 1) && amdgpu_sriov_runtime(adev)) {
 		clock = gfx_v9_0_kiq_read_clock(adev);
 	} else {
 		WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
@@ -4584,7 +4592,7 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	if (!ring->sched.ready)
 		return 0;
 
-	if (adev->asic_type == CHIP_ARCTURUS) {
+	if (adev->ip_versions[GC_HWIP] == IP_VERSION(9, 4, 1)) {
 		vgpr_init_shader_ptr = vgpr_init_compute_shader_arcturus;
 		vgpr_init_shader_size = sizeof(vgpr_init_compute_shader_arcturus);
 		vgpr_init_regs_ptr = vgpr_init_regs_arcturus;
@@ -4734,8 +4742,8 @@ static int gfx_v9_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->asic_type == CHIP_ARCTURUS ||
-	    adev->asic_type == CHIP_ALDEBARAN)
+	if (adev->ip_versions[GC_HWIP] == IP_VERSION(9, 4, 1) ||
+	    adev->ip_versions[GC_HWIP] == IP_VERSION(9, 4, 2))
 		adev->gfx.num_gfx_rings = 0;
 	else
 		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
@@ -4769,7 +4777,7 @@ static int gfx_v9_0_ecc_late_init(void *handle)
 	}
 
 	/* requires IBs so do in late init after IB pool is initialized */
-	if (adev->asic_type == CHIP_ALDEBARAN)
+	if (adev->ip_versions[GC_HWIP] == IP_VERSION(9, 4, 2))
 		r = gfx_v9_4_2_do_edc_gpr_workarounds(adev);
 	else
 		r = gfx_v9_0_do_edc_gpr_workarounds(adev);
@@ -4897,7 +4905,7 @@ static void gfx_v9_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
 		/* 1 - RLC_CGTT_MGCG_OVERRIDE */
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 
-		if (adev->asic_type != CHIP_VEGA12)
+		if (adev->ip_versions[GC_HWIP] != IP_VERSION(9, 2, 1))
 			data &= ~RLC_CGTT_MGCG_OVERRIDE__CPF_CGTT_SCLK_OVERRIDE_MASK;
 
 		data &= ~(RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
@@ -4931,7 +4939,7 @@ static void gfx_v9_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
 		/* 1 - MGCG_OVERRIDE */
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 
-		if (adev->asic_type != CHIP_VEGA12)
+		if (adev->ip_versions[GC_HWIP] != IP_VERSION(9, 2, 1))
 			data |= RLC_CGTT_MGCG_OVERRIDE__CPF_CGTT_SCLK_OVERRIDE_MASK;
 
 		data |= (RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK |
@@ -5037,7 +5045,7 @@ static void gfx_v9_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
 		/* enable cgcg FSM(0x0000363F) */
 		def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL);
 
-		if (adev->asic_type == CHIP_ARCTURUS)
+		if (adev->ip_versions[GC_HWIP] == IP_VERSION(9, 4, 1))
 			data = (0x2000 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
 				RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
 		else
@@ -5163,9 +5171,10 @@ static int gfx_v9_0_set_powergating_state(void *handle,
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
-	switch (adev->asic_type) {
-	case CHIP_RAVEN:
-	case CHIP_RENOIR:
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 3, 0):
 		if (!enable)
 			amdgpu_gfx_off_ctrl(adev, false);
 
@@ -5191,7 +5200,7 @@ static int gfx_v9_0_set_powergating_state(void *handle,
 		if (enable)
 			amdgpu_gfx_off_ctrl(adev, true);
 		break;
-	case CHIP_VEGA12:
+	case IP_VERSION(9, 2, 1):
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	default:
@@ -5209,14 +5218,15 @@ static int gfx_v9_0_set_clockgating_state(void *handle,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-	case CHIP_RAVEN:
-	case CHIP_ARCTURUS:
-	case CHIP_RENOIR:
-	case CHIP_ALDEBARAN:
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(9, 2, 1):
+	case IP_VERSION(9, 4, 0):
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 3, 0):
+	case IP_VERSION(9, 4, 2):
 		gfx_v9_0_update_gfx_clock_gating(adev,
 						 state == AMD_CG_STATE_GATE);
 		break;
@@ -5258,7 +5268,7 @@ static void gfx_v9_0_get_clockgating_state(void *handle, u32 *flags)
 	if (data & CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_CP_LS | AMD_CG_SUPPORT_GFX_MGLS;
 
-	if (adev->asic_type != CHIP_ARCTURUS) {
+	if (adev->ip_versions[GC_HWIP] != IP_VERSION(9, 4, 1)) {
 		/* AMD_CG_SUPPORT_GFX_3D_CGCG */
 		data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D));
 		if (data & RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK)
@@ -7029,14 +7039,15 @@ static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev)
 
 static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-	case CHIP_RAVEN:
-	case CHIP_ARCTURUS:
-	case CHIP_RENOIR:
-	case CHIP_ALDEBARAN:
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(9, 2, 1):
+	case IP_VERSION(9, 4, 0):
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 3, 0):
+	case IP_VERSION(9, 4, 2):
 		adev->gfx.rlc.funcs = &gfx_v9_0_rlc_funcs;
 		break;
 	default:
@@ -7047,17 +7058,18 @@ static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)
 static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev)
 {
 	/* init asci gds info */
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(9, 2, 1):
+	case IP_VERSION(9, 4, 0):
 		adev->gds.gds_size = 0x10000;
 		break;
-	case CHIP_RAVEN:
-	case CHIP_ARCTURUS:
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 4, 1):
 		adev->gds.gds_size = 0x1000;
 		break;
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(9, 4, 2):
 		/* aldebaran removed all the GDS internal memory,
 		 * only support GWS opcode in kernel, like barrier
 		 * semaphore.etc */
@@ -7068,24 +7080,25 @@ static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev)
 		break;
 	}
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
-	case CHIP_VEGA20:
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(9, 4, 0):
 		adev->gds.gds_compute_max_wave_id = 0x7ff;
 		break;
-	case CHIP_VEGA12:
+	case IP_VERSION(9, 2, 1):
 		adev->gds.gds_compute_max_wave_id = 0x27f;
 		break;
-	case CHIP_RAVEN:
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 1, 0):
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
 			adev->gds.gds_compute_max_wave_id = 0x77; /* raven2 */
 		else
 			adev->gds.gds_compute_max_wave_id = 0x15f; /* raven1 */
 		break;
-	case CHIP_ARCTURUS:
+	case IP_VERSION(9, 4, 1):
 		adev->gds.gds_compute_max_wave_id = 0xfff;
 		break;
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(9, 4, 2):
 		/* deprecated for Aldebaran, no usage at all */
 		adev->gds.gds_compute_max_wave_id = 0;
 		break;
-- 
2.31.1

