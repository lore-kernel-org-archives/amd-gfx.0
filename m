Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B89C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A170461262
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A170461262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67A596E8D9;
	Tue, 28 Sep 2021 16:45:18 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB0326E8D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTbCwGmc1ivpqMzVOtI2Ykl8RL88OUjT04QiWM24c71hbA4xbIDknKXoC2lSaO8DU97MjtfGWke4zbj2HPJSUsU6LNX7ZTTG4DBP6MRDWq4ImtfF5bGnDOtw0gf4EMXHd1+gdbcW0jzdIk2AZ3//wS1GyIHGkxOvRqzOW9eW9QsvNch0nHYQe/hSoMi2V6hCyRLHD9O/POH4/nU05yYXZccj6grJHZXMRU7nyWwMyPNMP7Y3wGpWtn1vev7HNWcar03MXV0g3ZqQAIyz5dMbNPFs/CSRe9spq5sQr1YSPkw8qo5m+ozSMUvqKk1cp1xQlHX4yBkP8d+JCg+cEBtcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=1gMuuarbzK6Ad0ZWnR4L57brPJ1F4y4RkcwzpEChVjc=;
 b=WmzFBiDTyolHaXF9fcGnLXS0pvCgeXDu6Ez92QcmkefZYDvge07fIa/e4+lDxtXQLI4xhupoRqGfA+eFxECISJDOkrj5ODrMuzZHIt6DpoXCV33s/yw/dicChUG4J/oP7FHtJqRU5o8mXYa/Nn51F00yDJJfgEWAizH063EOvDvMN4t3LpkNTNDt9T2qOrjPv7JrJug03O1o7xcnZugzc6xAW3NONkZIPs7hxwc5sN81xqpj5Ec7d8uzSjwAhnMWhYre2goXw4NUurAxgL54/4o9c2Ycc5ggFeaXw2J3hx3tmIPRAoi9NotWsVSebOwIR9WNJizeUlwkXqw22WBftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gMuuarbzK6Ad0ZWnR4L57brPJ1F4y4RkcwzpEChVjc=;
 b=b9hH9dJPleCzuHr8u7gR+XCdB2LAqWoUm0Ye1c2xA+AT184ztG0Ygq1svhZqPhB9qGGc0Rvy0SntTzW4aJRWuzE5vCruIjfZ4J20QMx9VTPLc5/5DeuLwc1qsboKSmPczk7ebbtagrVOieaJvHRcWTW8BHjViHXFeJWhmR4n4wY=
Received: from DM5PR07CA0142.namprd07.prod.outlook.com (2603:10b6:3:13e::32)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Tue, 28 Sep
 2021 16:45:14 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::bb) by DM5PR07CA0142.outlook.office365.com
 (2603:10b6:3:13e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Tue, 28 Sep 2021 16:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:45:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:45:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 37/64] drm/amdgpu/sdma4.0: convert to IP version checking
Date: Tue, 28 Sep 2021 12:42:10 -0400
Message-ID: <20210928164237.833132-38-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 389fd5c2-ed6c-4e7c-3385-08d9829f5832
X-MS-TrafficTypeDiagnostic: BY5PR12MB4242:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4242187FAE27EBEC2C2E4724F7A89@BY5PR12MB4242.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46q4CaiUQBkfyqhijsd+e3pxVU29scateMG+IqN7ah6KV+yY8GTXW4NJcrYiTFZd37f9B82CI0mv1RPCOgUWaj9MAciSXfys+1ndFRzzu1jGpnca4Km83xMKYeinYewmuUk5w64+O1jqXX779i9F3+WPFSMVWXVinS9eixR+VB3kRGRt3NcsL08AoBoeXiQq+ovwfgCqPMEmqvH4KmsZG4rZuwwUAQCKGMdcCbIJIYHkeTqUlhBKa3UNu6nCoY4eJXg6YaJ6l72wpvLGDA0VvwEDcsGWZB6DogYYYP6182x5HN98kMu2yjMfEoBP/cWO0yW6dJDgsjDcVQsXLpzMNBIS+HAIVSeuGD2FCy6cxebB+7EiPCpnx3pg5lm1y4U2cfpNr6I1DvRlxPPwGML9uZOot58zRqvpxpNWas/OTYdMmpJMcqISqIHYI/Gwg4eNpAVTw0t96yEZ1R6X9vmnPbP5//WaKuGQ2nwK1bymcIXaQoCSU7w7B6CMFamf4fmnvt4hJddQsPc3ItXzp6FbbR2eDKG2RavcYEdNWEMx1u1wLSxmBZFr79Hqt7MzRI6xbFVJT/GMEXy1yNyHwu/17u+OMRWUH0Pmr667gDFBk9yifpOQJ9AlNS69hFFB64U6Ozcf6xW3uqM4tA7hDHbLjeH0EGGfRSm511AmPOZyZ0Xzy/DfzE5PfcfPkpnzDymboUsDEKzsb20v1AlhBphCsHdoTtf0brJXnfZSTzDxEAadty/MwugKU2MEIPiPlFMdsGAndSNLaPeiDJKF6+PkJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36756003)(70206006)(316002)(8936002)(36860700001)(6916009)(86362001)(70586007)(83380400001)(16526019)(186003)(54906003)(66574015)(82310400003)(26005)(2616005)(7696005)(47076005)(1076003)(8676002)(81166007)(2906002)(336012)(5660300002)(356005)(508600001)(426003)(4326008)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:45:13.9992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 389fd5c2-ed6c-4e7c-3385-08d9829f5832
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
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

