Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EC1C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C2061266
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 25C2061266
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D83436E8B5;
	Tue, 28 Sep 2021 16:43:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88F4B6E8B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dACcAFIA7mvuB+8dxQdgJEDuND1Xv/5ANrHVnvWZEm8sFKM1LTkwzrTsxb+e9c5Z1N5Tp34F44wO4pN8GCbDj1g6L83+PFu7sI5lCSaXQUa5O3a3yO1M5fRmG9J6rp2pf69BIyjAu0ZPkbQB6yyimIyY/SrQ9K1U8K7VqrOYjVWkhUPXpKqPQCaoH64iBekJ5EZeuwdPTv6BjP1iMqNpPvBKcVq1pNoiFRODBFMSSwRjD/mgiR3YL3QJG84LY28PiYQgpB1QOuwn6IazFqZOwwN9ByQoNW1kXpsD5cuMf3wtpyBnX8goFGIt9RvnQxiG82RoNuLlG76XfQ4dOspAew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=wVRCcdaRGY7Cantwh8ZRwk9OZ6WVlzI3HUF2GjNAtS8=;
 b=kN+UWRRFKmjcmY78KvfTxLlXhE7C/Hdm9hT67cKlI4REaamh2DlpHE6w05J5EcbbbXPwKU1hUpU38n0vdwGwC6qeXGcCbQWBN04ccRtDforLIPi1KYrVBtMFh4dzkB890NvPzFD4m7cBDc6dXGjfZKj+FhP4rW49oe49TB9crZ3mV15OUA5L6HqnoD/SuSOJ10MdRyoQfbUoTcJqxu5T03V2qsOhJBB6tTC6+oYfbJ256M1bRnDK/ohJNTwJ2tI9nWdZn1b98ZBpBWOcNyWRaTqjAki19yrcQ9MaItIO1dT9Hd5XNVC7CrMH0VSS7+sk9lbYKsVuf4f4Uz+Gb9Isxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVRCcdaRGY7Cantwh8ZRwk9OZ6WVlzI3HUF2GjNAtS8=;
 b=lw2myHU7vkg2YGg5aEgqZY8wDHj4r9p2Xn+KDt66PgE9vqbujI4ctAGWemuwbY/M7U8ZrMmdKJ6NzIV26lj6dhtBKQJaZNWLIG+Z9mzjtMAyoSS7J+32Asj1R6qOjMqcTrMimangheaUV1YvLVXQ/8c5ulG4QuFVdJzKLG6LmiM=
Received: from DS7PR03CA0272.namprd03.prod.outlook.com (2603:10b6:5:3ad::7) by
 DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.14; Tue, 28 Sep 2021 16:43:30 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::e8) by DS7PR03CA0272.outlook.office365.com
 (2603:10b6:5:3ad::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:43:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:43:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:43:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 08/64] drm/amdgpu/sdma5.0: convert to IP version checking
Date: Tue, 28 Sep 2021 12:41:41 -0400
Message-ID: <20210928164237.833132-9-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: bb5417fd-743e-4ce2-42b2-08d9829f1a57
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2810CD7DD2BACD913FF72705F7A89@DM6PR12MB2810.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:279;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MWjGLXbep5/Lc+qQJFOCFE5OrDLKN0H3PvungiShK8P9dd6U64XyKjqVVC9SMJxFlIL8Or00vwcvyPrNBFq2yzk1EuWPnPgn4S0EpB31EB4e4HHLuxJnlzOVYEPr1msBcIkQwYdK9Kcgy5BcSF5C5LEJP15kfo0xknRhhphUTLH8dPsI49fET4we/IelMXjnFTnEBCV4GxHxU1wjvB/pVKvQyyJskKPYk8mEou/AdPmq/vQ9SrJPLbu14dtoP4qVv5VQm7SpTg4SWLLSBSY6etywiQ/Uo/5FMhB3jotQ9LFP5PjlW6/ld3/3xdEHcl3Eb+dZYobtmgnia9FKz8A1BFtxVMylm5OaCDtsSkLxnuCRu8Cz9gxkW/zwTJieTpeKH2zIauBoPZIuUTlNO7Xf9hqpuKCT9H+v8fO3IPib6mnU4M+1pjSENuq5FMLQaygK4w9TQckTST5mbd9QcCBVkM16I5tk/YYVIoOaMBndtEAl82eU1CdkJownHWG42lZoCL31spx3x6uN50neX90gRi8FrYULhcg5oNIL68fqdQreXvvGTGyejfHuJPf9DtLuuoMEq10+NOY1JvztzSKCgxJ9kEv92+fNOEmOXLGNAMeu7AwaRoqy6CKqum0Hw6F9PSAlp7mdwCGCBA5lN2ZWRgQLpWueaKgg2zpT2zkCLN+zfPdiontcEGQC5tcJN/PDvzD62abud2gb4XuDgvlR1yO08cFdDICk0in8SkriqQE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(54906003)(316002)(36860700001)(6666004)(1076003)(66574015)(4326008)(47076005)(82310400003)(8676002)(426003)(186003)(86362001)(2616005)(7696005)(356005)(336012)(508600001)(5660300002)(6916009)(70206006)(8936002)(26005)(2906002)(16526019)(70586007)(81166007)(83380400001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:43:30.2183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5417fd-743e-4ce2-42b2-08d9829f1a57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2810
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

Acked-by: Christian König <christian.koenig@amd.com>
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

