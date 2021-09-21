Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EC9C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E908860527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E908860527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 101006EA8F;
	Tue, 21 Sep 2021 18:08:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 015E86EA87
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSVMpynih7qt61YbDkWXmM7yeqkn5krC11qqA345mlPB9kp3/oJ4xakdzyMHxlWRKA22qoGcRie9m+gC97RzLQNpEp5SpmHBAJXm2pLheU7uCGtswyPKh9vTHwCKDmLpVkVomU6JG+c0EJpaTs8T9jGyU2HI4yArYztyN+EM+fZ51ztk5lssB1g3pRPlcTJSPa/hoHKnHnkyLy2LKcWfGOhYhx3oglo90LefyrU1tSF4maYieq4WfHhCXARsMNC7DVKxBwxNwePFxvm/nuFDkYEDht2tAa9epxe2SzfB9Sk67O3aAv9e/aEOn35O3hoYHqcMtxwMm4W3O7TPU4EwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=fPxKMsLK1BwzUYa+87nXwuGTu2WfW9O/2nZrsKfxY9Q=;
 b=lGXT5gcUySG7Y1oqbGa3NZ0Zc+bGQFcLwL1J1ZKSyaF2e1bUsUX/DP+qzIj/O4gqaB2iIXTy/KgyK7Ha6cyT7fjb4299B8BaGAy0rCFWCiU/9Lzcym3fs89YLl28sXTiUnKACBMf9ylGu2Iza8enF8WiKzP8AlsRXll8YBjtNYKkInPRuX6ecAyIZFCxNNpRyQYPA1x3scuk8FC/UrBz+MyCSj3jYg4P1t1VQp8c1fMCecsQ4d6rCI4J4CAEJHyyGeWvoF3GX2nXggTvCrLPxlWn7PiSiFw6U9dPD9Xv30A6vD6sGJ+8vE2tu6Ibe8AGvDibGu7HwTsEdtSbaP5XCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPxKMsLK1BwzUYa+87nXwuGTu2WfW9O/2nZrsKfxY9Q=;
 b=Tz5OZDJhofeL6F19LYHmV5QtSlF0T1939Qhwmk1t/tAqbeUBR9WBSrdnhbuEb5tUjvTLw1kZKC+VpPbvz08+/nza5CGQ1BhR+f0wlsKkQy8nXtaSj3SWb0r5nHsnXeTaDTwEWw/P9EKhJNE2zxCEJ5kDHS2pBbX+E6lxDU194aU=
Received: from DM3PR12CA0050.namprd12.prod.outlook.com (2603:10b6:0:56::18) by
 DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 18:07:58 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::d4) by DM3PR12CA0050.outlook.office365.com
 (2603:10b6:0:56::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:58 +0000
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
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 18:07:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 38/66] drm/amdgpu/sdma4.0: convert to IP version checking
Date: Tue, 21 Sep 2021 14:06:57 -0400
Message-ID: <20210921180725.1985552-39-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8c4b7d00-56cd-4d9c-609a-08d97d2abe96
X-MS-TrafficTypeDiagnostic: DM6PR12MB4155:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4155163593B2E3B5A47BD58DF7A19@DM6PR12MB4155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MwjYkKyx6NgiNrHyBa6qT/YmWpyHIJcN2KcDIWpM5J65tmBQ40GpPznhPF1Ty+SEKbeG2H9OJ2d4Y+TyDJgaVQXwWzd1G4T1aZCV0fXX+9C8ldabkD6t2bq2JItfb9dOU+n795O6y+oP4byBllt42SW0DIym0UA7RoNwU/BNBkvUDvQmFF/0HDewGcEBx4+g5/Dr2F++0bXVHX0C+X3Q/gHiygXnmxUnk5ayj1B4srbzLQ36bJ1wVZYu4ICdV5YYSp0x/XCDgyAHwDpb/cQvMiqhYvSSOG94y+ofj561cxNnvaU5FzYPZMPD5JTQICe93Pri32kAmyGAaBnoE30waB0mpB5r5V1Is3JYEGU0LzP4ZgvsrcHIFNwWPBuDVIOF7PzV+TJ5PiFafQ6VZdC6P9FwGgtGN5C9ym7maJqVevCE+4Y26kSMi+7fZ+FQelpRfxJu/Ter5bm8gvRzGmx9nNTTTWZlmlGnHLwM3eH4mp2AoKZ4k8WlcGrXJ0w1p7PV44hdB4D/JVtv4uQ0TCKFzZr2mdOeK4WlYwvIdT4rMSlnpHUsFQ3QNykEwOLLApotwWUldNlzWDoCSCpJ1I/5HLh639sM9Dy2iaJ1B9CgFsKehi+xnHx9Uts2Tqjn8nRbEBVGQ2KSUnAddIwHjoAPEh3oDEgkHdpkIEQLub9Ygf5bgrsoc9pLm2qiidKIlOHwSN1ECY+xzavdUhRSowRj1ijMzcpCiVIFLpR3PkSYbzXM5qGdjrH4dKNayTKvTQ3XHDzH068wDRZloDAOoCaUug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(5660300002)(4326008)(2906002)(86362001)(8936002)(6916009)(81166007)(356005)(82310400003)(47076005)(36756003)(508600001)(36860700001)(83380400001)(2616005)(426003)(316002)(336012)(8676002)(186003)(70586007)(16526019)(7696005)(70206006)(1076003)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:58.8400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4b7d00-56cd-4d9c-609a-08d97d2abe96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 107 ++++++++++++++-----------
 1 file changed, 60 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 8931000dcd41..3219dca3e44f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -469,8 +469,8 @@ static int sdma_v4_0_irq_id_to_seq(unsigned client_id)
 
 static void sdma_v4_0_init_golden_registers(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
+	switch (adev->ip_versions[SDMA0_HWIP]) {
+	case IP_VERSION(4, 0, 0):
 		soc15_program_register_sequence(adev,
 						golden_settings_sdma_4,
 						ARRAY_SIZE(golden_settings_sdma_4));
@@ -478,7 +478,7 @@ static void sdma_v4_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_sdma_vg10,
 						ARRAY_SIZE(golden_settings_sdma_vg10));
 		break;
-	case CHIP_VEGA12:
+	case IP_VERSION(4, 0, 1):
 		soc15_program_register_sequence(adev,
 						golden_settings_sdma_4,
 						ARRAY_SIZE(golden_settings_sdma_4));
@@ -486,7 +486,7 @@ static void sdma_v4_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_sdma_vg12,
 						ARRAY_SIZE(golden_settings_sdma_vg12));
 		break;
-	case CHIP_VEGA20:
+	case IP_VERSION(4, 2, 0):
 		soc15_program_register_sequence(adev,
 						golden_settings_sdma0_4_2_init,
 						ARRAY_SIZE(golden_settings_sdma0_4_2_init));
@@ -497,17 +497,18 @@ static void sdma_v4_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_sdma1_4_2,
 						ARRAY_SIZE(golden_settings_sdma1_4_2));
 		break;
-	case CHIP_ARCTURUS:
+	case IP_VERSION(4, 2, 2):
 		soc15_program_register_sequence(adev,
 						golden_settings_sdma_arct,
 						ARRAY_SIZE(golden_settings_sdma_arct));
 		break;
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(4, 4, 0):
 		soc15_program_register_sequence(adev,
 						golden_settings_sdma_aldebaran,
 						ARRAY_SIZE(golden_settings_sdma_aldebaran));
 		break;
-	case CHIP_RAVEN:
+	case IP_VERSION(4, 1, 0):
+	case IP_VERSION(4, 1, 1):
 		soc15_program_register_sequence(adev,
 						golden_settings_sdma_4_1,
 						ARRAY_SIZE(golden_settings_sdma_4_1));
@@ -520,7 +521,7 @@ static void sdma_v4_0_init_golden_registers(struct amdgpu_device *adev)
 							golden_settings_sdma_rv1,
 							ARRAY_SIZE(golden_settings_sdma_rv1));
 		break;
-	case CHIP_RENOIR:
+	case IP_VERSION(4, 1, 2):
 		soc15_program_register_sequence(adev,
 						golden_settings_sdma_4_3,
 						ARRAY_SIZE(golden_settings_sdma_4_3));
@@ -538,12 +539,12 @@ static void sdma_v4_0_setup_ulv(struct amdgpu_device *adev)
 	 * The only chips with SDMAv4 and ULV are VG10 and VG20.
 	 * Server SKUs take a different hysteresis setting from other SKUs.
 	 */
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
+	switch (adev->ip_versions[SDMA0_HWIP]) {
+	case IP_VERSION(4, 0, 0):
 		if (adev->pdev->device == 0x6860)
 			break;
 		return;
-	case CHIP_VEGA20:
+	case IP_VERSION(4, 2, 0):
 		if (adev->pdev->device == 0x66a1)
 			break;
 		return;
@@ -589,8 +590,8 @@ static void sdma_v4_0_destroy_inst_ctx(struct amdgpu_device *adev)
 
 		/* arcturus shares the same FW memory across
 		   all SDMA isntances */
-		if (adev->asic_type == CHIP_ARCTURUS ||
-		    adev->asic_type == CHIP_ALDEBARAN)
+		if (adev->ip_versions[SDMA0_HWIP] == IP_VERSION(4, 2, 2) ||
+		    adev->ip_versions[SDMA0_HWIP] == IP_VERSION(4, 4, 0))
 			break;
 	}
 
@@ -620,17 +621,18 @@ static int sdma_v4_0_init_microcode(struct amdgpu_device *adev)
 
 	DRM_DEBUG("\n");
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
+	switch (adev->ip_versions[SDMA0_HWIP]) {
+	case IP_VERSION(4, 0, 0):
 		chip_name = "vega10";
 		break;
-	case CHIP_VEGA12:
+	case IP_VERSION(4, 0, 1):
 		chip_name = "vega12";
 		break;
-	case CHIP_VEGA20:
+	case IP_VERSION(4, 2, 0):
 		chip_name = "vega20";
 		break;
-	case CHIP_RAVEN:
+	case IP_VERSION(4, 1, 0):
+	case IP_VERSION(4, 1, 1):
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
 			chip_name = "raven2";
 		else if (adev->apu_flags & AMD_APU_IS_PICASSO)
@@ -638,16 +640,16 @@ static int sdma_v4_0_init_microcode(struct amdgpu_device *adev)
 		else
 			chip_name = "raven";
 		break;
-	case CHIP_ARCTURUS:
+	case IP_VERSION(4, 2, 2):
 		chip_name = "arcturus";
 		break;
-	case CHIP_RENOIR:
+	case IP_VERSION(4, 1, 2):
 		if (adev->apu_flags & AMD_APU_IS_RENOIR)
 			chip_name = "renoir";
 		else
 			chip_name = "green_sardine";
 		break;
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(4, 4, 0):
 		chip_name = "aldebaran";
 		break;
 	default:
@@ -665,8 +667,8 @@ static int sdma_v4_0_init_microcode(struct amdgpu_device *adev)
 		goto out;
 
 	for (i = 1; i < adev->sdma.num_instances; i++) {
-		if (adev->asic_type == CHIP_ARCTURUS ||
-		    adev->asic_type == CHIP_ALDEBARAN) {
+		if (adev->ip_versions[SDMA0_HWIP] == IP_VERSION(4, 2, 2) ||
+                    adev->ip_versions[SDMA0_HWIP] == IP_VERSION(4, 4, 0)) {
 			/* Acturus & Aldebaran will leverage the same FW memory
 			   for every SDMA instance */
 			memcpy((void *)&adev->sdma.instance[i],
@@ -1106,7 +1108,7 @@ static void sdma_v4_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 		 * Arcturus for the moment and firmware version 14
 		 * and above.
 		 */
-		if (adev->asic_type == CHIP_ARCTURUS &&
+		if (adev->ip_versions[SDMA0_HWIP] == IP_VERSION(4, 2, 2) &&
 		    adev->sdma.instance[i].fw_version >= 14)
 			WREG32_SDMA(i, mmSDMA0_PUB_DUMMY_REG2, enable);
 		/* Extend page fault timeout to avoid interrupt storm */
@@ -1393,9 +1395,10 @@ static void sdma_v4_0_init_pg(struct amdgpu_device *adev)
 	if (!(adev->pg_flags & AMD_PG_SUPPORT_SDMA))
 		return;
 
-	switch (adev->asic_type) {
-	case CHIP_RAVEN:
-	case CHIP_RENOIR:
+	switch (adev->ip_versions[SDMA0_HWIP]) {
+	case IP_VERSION(4, 1, 0):
+        case IP_VERSION(4, 1, 1):
+	case IP_VERSION(4, 1, 2):
 		sdma_v4_1_init_power_gating(adev);
 		sdma_v4_1_update_power_gating(adev, true);
 		break;
@@ -1835,13 +1838,13 @@ static bool sdma_v4_0_fw_support_paging_queue(struct amdgpu_device *adev)
 {
 	uint fw_version = adev->sdma.instance[0].fw_version;
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
+	switch (adev->ip_versions[SDMA0_HWIP]) {
+	case IP_VERSION(4, 0, 0):
 		return fw_version >= 430;
-	case CHIP_VEGA12:
+	case IP_VERSION(4, 0, 1):
 		/*return fw_version >= 31;*/
 		return false;
-	case CHIP_VEGA20:
+	case IP_VERSION(4, 2, 0):
 		return fw_version >= 123;
 	default:
 		return false;
@@ -1853,14 +1856,22 @@ static int sdma_v4_0_early_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
-	if (adev->flags & AMD_IS_APU)
+	switch (adev->ip_versions[SDMA0_HWIP]) {
+	case IP_VERSION(4, 1, 0):
+	case IP_VERSION(4, 1, 1):
+	case IP_VERSION(4, 1, 2):
 		adev->sdma.num_instances = 1;
-	else if (adev->asic_type == CHIP_ARCTURUS)
+		break;
+	case IP_VERSION(4, 2, 2):
 		adev->sdma.num_instances = 8;
-	else if (adev->asic_type == CHIP_ALDEBARAN)
+		break;
+	case IP_VERSION(4, 4, 0):
 		adev->sdma.num_instances = 5;
-	else
+		break;
+	default:
 		adev->sdma.num_instances = 2;
+		break;
+	}
 
 	r = sdma_v4_0_init_microcode(adev);
 	if (r) {
@@ -1869,7 +1880,8 @@ static int sdma_v4_0_early_init(void *handle)
 	}
 
 	/* TODO: Page queue breaks driver reload under SRIOV */
-	if ((adev->asic_type == CHIP_VEGA10) && amdgpu_sriov_vf((adev)))
+	if ((adev->ip_versions[SDMA0_HWIP] == IP_VERSION(4, 0, 0)) &&
+	    amdgpu_sriov_vf((adev)))
 		adev->sdma.has_page_queue = false;
 	else if (sdma_v4_0_fw_support_paging_queue(adev))
 		adev->sdma.has_page_queue = true;
@@ -2141,14 +2153,14 @@ static int sdma_v4_0_process_trap_irq(struct amdgpu_device *adev,
 		amdgpu_fence_process(&adev->sdma.instance[instance].ring);
 		break;
 	case 1:
-		if (adev->asic_type == CHIP_VEGA20)
+		if (adev->ip_versions[SDMA0_HWIP] == IP_VERSION(4, 2, 0))
 			amdgpu_fence_process(&adev->sdma.instance[instance].page);
 		break;
 	case 2:
 		/* XXX compute */
 		break;
 	case 3:
-		if (adev->asic_type != CHIP_VEGA20)
+		if (adev->ip_versions[SDMA0_HWIP] != IP_VERSION(4, 2, 0))
 			amdgpu_fence_process(&adev->sdma.instance[instance].page);
 		break;
 	}
@@ -2364,9 +2376,10 @@ static int sdma_v4_0_set_powergating_state(void *handle,
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	switch (adev->asic_type) {
-	case CHIP_RAVEN:
-	case CHIP_RENOIR:
+	switch (adev->ip_versions[SDMA0_HWIP]) {
+	case IP_VERSION(4, 1, 0):
+	case IP_VERSION(4, 1, 1):
+	case IP_VERSION(4, 1, 2):
 		sdma_v4_1_update_power_gating(adev,
 				state == AMD_PG_STATE_GATE);
 		break;
@@ -2551,7 +2564,7 @@ static void sdma_v4_0_set_ring_funcs(struct amdgpu_device *adev)
 	int i;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (adev->asic_type == CHIP_ARCTURUS && i >= 5)
+		if (adev->ip_versions[SDMA0_HWIP] == IP_VERSION(4, 2, 2) && i >= 5)
 			adev->sdma.instance[i].ring.funcs =
 					&sdma_v4_0_ring_funcs_2nd_mmhub;
 		else
@@ -2559,7 +2572,7 @@ static void sdma_v4_0_set_ring_funcs(struct amdgpu_device *adev)
 					&sdma_v4_0_ring_funcs;
 		adev->sdma.instance[i].ring.me = i;
 		if (adev->sdma.has_page_queue) {
-			if (adev->asic_type == CHIP_ARCTURUS && i >= 5)
+			if (adev->ip_versions[SDMA0_HWIP] == IP_VERSION(4, 2, 2) && i >= 5)
 				adev->sdma.instance[i].page.funcs =
 					&sdma_v4_0_page_ring_funcs_2nd_mmhub;
 			else
@@ -2786,12 +2799,12 @@ static const struct amdgpu_sdma_ras_funcs sdma_v4_0_ras_funcs = {
 
 static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_VEGA20:
-	case CHIP_ARCTURUS:
+	switch (adev->ip_versions[SDMA0_HWIP]) {
+	case IP_VERSION(4, 2, 0):
+	case IP_VERSION(4, 2, 2):
 		adev->sdma.funcs = &sdma_v4_0_ras_funcs;
 		break;
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(4, 4, 0):
 		adev->sdma.funcs = &sdma_v4_4_ras_funcs;
 		break;
 	default:
-- 
2.31.1

