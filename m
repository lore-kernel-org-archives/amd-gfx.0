Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE436C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF4B161168
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF4B161168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB2E6EA33;
	Tue, 21 Sep 2021 18:07:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BE9F6EA33
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJ8dCtGdf6Z9CL1BQ2rB2h/xsWYs2UirdmwkLibDax3aAz9sqBTyMxVYvLxHzW5S4Gw0/M3a5TiP8bPcS1DlQVG0MPcKT9GroejmFcTNiW6EAWSTijwg0eYj9WS9FczHD9ULkg5izv37IkVQufVI1fmGIWJUqfn1RWyhbKqIz2U9/wbjIIMlgbhdloZoW+JRX75m83ja5TFS2VRSzeM0ohTuGkByQqMwjpgAIC1lcKZGznjCsR0/N9CO76TwuUeMtBoQmvFa8fYRIUfkHA5AZzu98sfsJqz01D+9Qbn7gsr/GNGNLX+luEeabdt6q52U5H8V6g1r1s9yOctey8CPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=bnI0US46hZOimblq/zBD2MLQu/6O4h368vTugH+DSL0=;
 b=DTiMpyMZ01BUMJakHUTzU6RzyvN0XVt06JF7vwwI3u5qaatCfuLo/EwnrHC6Jh5lJLjft5UwUdka+E33uDFxsPz0de3mYown9EIGzM7XMtHKni+npEx6wXsdaIZ438vgiiyLM9WHIcf4AWhGiOVniyMouAEd1JFo3qG2cVrn7x6AKgLig2z3lRYWhr2oXtKmvXbIyQTqA+Iia4qECEdMcP/YvqIOkoJn+RES1a1cK7RvoUtiwNOGYx6mK1tqu0I4fYaADbMMbO9lt/bssijPFg7KsyYs+RbE5SuEiCcF5UV+kV2oglKHvXbAEe6YKCuG3lVOT2ZwSYaeusGCKOKb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnI0US46hZOimblq/zBD2MLQu/6O4h368vTugH+DSL0=;
 b=Ip1QcvbSHjK+96qSn5u0uubtLk2MXl0BuufDhuy/p6AkBm6SYJ6ttBM5mK+UKmdVljzBgdSgEdlZDIYcqaeP9deVk4rOYsoga4SqJZ4D2hBcj3z/nn3V85jqyYBIRYdCe0nA5yFuCCoLW66i4gFwOCHlY7Kpj8fDUnBCGEI8y9A=
Received: from DM5PR11CA0023.namprd11.prod.outlook.com (2603:10b6:3:115::33)
 by CY4PR12MB1638.namprd12.prod.outlook.com (2603:10b6:910:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Tue, 21 Sep
 2021 18:07:44 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::a9) by DM5PR11CA0023.outlook.office365.com
 (2603:10b6:3:115::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/66] drm/amdgpu/sdma5.0: convert to IP version checking
Date: Tue, 21 Sep 2021 14:06:27 -0400
Message-ID: <20210921180725.1985552-9-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: cde60ac4-d4e8-4d43-a5ed-08d97d2ab615
X-MS-TrafficTypeDiagnostic: CY4PR12MB1638:
X-Microsoft-Antispam-PRVS: <CY4PR12MB163872C993DB30B27997C775F7A19@CY4PR12MB1638.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:279;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ik1087uZ+KbySoYrcWDK9VyklvkTMY5JpSFEEVkV4bh7l64FIXnYSRgpB/yidfOeB6092Q8IMwHO3OJ1LSVQXHqMqck61SDVho0b03ue8fVkrfUngRSPZGzUdR0d/WfimdJP4kwqRPR9rdC3zjmk718s6g3shUhzbgWvRZslAUK7MaGOYdxcOE1KFoULFsz1RoEYNH8xFcOmsVjuAb8/9GsWozM1QYacYgHNkT3OBmE6TJdXGPrFc7RDKm+xiDmnKGiKD3Bga1oBb6KWFxzlwLHwXsZlYCsASEbpfXA0c20RR+69FzZhLGljF15FnMZUfL1pHmW67F47mJaaNC14On3/iNUFGygtfdCjrC9PESrsT8FtYvNRjJ4ytlLylVx0SRBsQJbD+iBeT+anOvcIHDIA9dpykV94v4EPsv1doPGRVZngNVm2nvRT2A0Kzg0gUuSKUT+ii/irAP6ebG5C02Z5Mv7dabHPd0uwT+QqVdYPA9d/N7RqwNynRkjTpdq7kP/ZIx8mKj4TrRN4hARtf+rRQ+i5PtYwEQ7r1RrAmT+I6tGuDpq4uoReBUnrjq9tNyXeG9btg0mmIbr0p7NDfRf6/yzqo2rsGoj+bwA/cz2EcmXf/l0qIr78a647TmYOzFPtK8fDQTv/DjIkJI+tLoQDfCKlrPHf2FubGLPczbx4nBiymMMhhyglmKUenO+fmDRbjKX3yphy0DJXOwgT8X3gPOpLdzsw+VgqZlVPhXc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(2906002)(70206006)(2616005)(70586007)(508600001)(8936002)(83380400001)(1076003)(86362001)(47076005)(7696005)(36860700001)(6666004)(8676002)(4326008)(81166007)(82310400003)(26005)(336012)(36756003)(6916009)(186003)(16526019)(426003)(316002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:44.5796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cde60ac4-d4e8-4d43-a5ed-08d97d2ab615
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1638
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

v2: rebase

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 30 +++++++++++++-------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 50bf3b71bc93..2ab670c58520 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -187,8 +187,8 @@ static u32 sdma_v5_0_get_reg_offset(struct amdgpu_device *adev, u32 instance, u3
 
 static void sdma_v5_0_init_golden_registers(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
+	switch (adev->ip_versions[SDMA0_HWIP]) {
+	case IP_VERSION(5, 0, 0):
 		soc15_program_register_sequence(adev,
 						golden_settings_sdma_5,
 						(const u32)ARRAY_SIZE(golden_settings_sdma_5));
@@ -196,7 +196,7 @@ static void sdma_v5_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_sdma_nv10,
 						(const u32)ARRAY_SIZE(golden_settings_sdma_nv10));
 		break;
-	case CHIP_NAVI14:
+	case IP_VERSION(5, 0, 2):
 		soc15_program_register_sequence(adev,
 						golden_settings_sdma_5,
 						(const u32)ARRAY_SIZE(golden_settings_sdma_5));
@@ -204,7 +204,7 @@ static void sdma_v5_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_sdma_nv14,
 						(const u32)ARRAY_SIZE(golden_settings_sdma_nv14));
 		break;
-	case CHIP_NAVI12:
+	case IP_VERSION(5, 0, 5):
 		if (amdgpu_sriov_vf(adev))
 			soc15_program_register_sequence(adev,
 							golden_settings_sdma_5_sriov,
@@ -217,7 +217,7 @@ static void sdma_v5_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_sdma_nv12,
 						(const u32)ARRAY_SIZE(golden_settings_sdma_nv12));
 		break;
-	case CHIP_CYAN_SKILLFISH:
+	case IP_VERSION(5, 0, 1):
 		soc15_program_register_sequence(adev,
 						golden_settings_sdma_cyan_skillfish,
 						(const u32)ARRAY_SIZE(golden_settings_sdma_cyan_skillfish));
@@ -248,22 +248,22 @@ static int sdma_v5_0_init_microcode(struct amdgpu_device *adev)
 	const struct common_firmware_header *header = NULL;
 	const struct sdma_firmware_header_v1_0 *hdr;
 
-	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_NAVI12))
+	if (amdgpu_sriov_vf(adev) && (adev->ip_versions[SDMA0_HWIP] == IP_VERSION(5, 0, 5)))
 		return 0;
 
 	DRM_DEBUG("\n");
 
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
+	switch (adev->ip_versions[SDMA0_HWIP]) {
+	case IP_VERSION(5, 0, 0):
 		chip_name = "navi10";
 		break;
-	case CHIP_NAVI14:
+	case IP_VERSION(5, 0, 2):
 		chip_name = "navi14";
 		break;
-	case CHIP_NAVI12:
+	case IP_VERSION(5, 0, 5):
 		chip_name = "navi12";
 		break;
-	case CHIP_CYAN_SKILLFISH:
+	case IP_VERSION(5, 0, 1):
 		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
 			chip_name = "cyan_skillfish2";
 		else
@@ -1636,10 +1636,10 @@ static int sdma_v5_0_set_clockgating_state(void *handle,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_NAVI12:
+	switch (adev->ip_versions[SDMA0_HWIP]) {
+	case IP_VERSION(5, 0, 0):
+	case IP_VERSION(5, 0, 2):
+	case IP_VERSION(5, 0, 5):
 		sdma_v5_0_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		sdma_v5_0_update_medium_grain_light_sleep(adev,
-- 
2.31.1

