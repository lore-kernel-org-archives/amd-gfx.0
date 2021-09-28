Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B66C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E83F46101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E83F46101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C62D6E8CB;
	Tue, 28 Sep 2021 16:44:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA17E6E8CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:44:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBlEXbAtp5AaDp97dy0Uflfq7bD08AjL2SJzYpybO0Nzt5t8kUZTKlYrzYZ2KmrOKazcAYIczppq/JxdU1ihlLLeFMsMQzjPGjyBjbg1MZzlfHLO3C8jd9rPOO78jt+8ex6NQIgHePPxthVKoL3hbdnd7xr9Wh4xzrxa4bdfv8NRsJ8uHsVEbtdAvMr/nZmHNzQGciqWyCj/ryQIw9U1kTk4rTw7pvLZCPDcuy27ylTdyoiTcrrJ5J7ngeUIJfhhVesBHWdgYKdnwva6LBTRwtkp9E14bfhr0D4lQuLFoFSVMmPrKU+ufdMuN9oRKM5xMfEjc/N6Vq/YW6BgXpkisw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=0jrysIhTyUEPNcMsi0cFziW7rGCLwNoQUc20vqWHTYA=;
 b=g9AvTiKnMgMnIjl6MZHVodmkAEDYRYgBmLjCV1tx4Wm4Ja5qB3sNrEGApk6AF/qT2zVSazyH2symywNd81MZmOycs+siGl+98vLCfoJ7w1TveJs1hr6+9KN2KPwXoMtrLXW9A3jC6mtDxm41bMFaQoUH+tTB0cnAXmpOJylgpiKHbfRcT1QV40r1M99KA4kgI70ZYZ399qkrJ6COIG+m4kV8rAZPbL5Z2U1NFP/WqH3tQpTMlZeR3pUqauZfhe4ywgLvC33l6cvcRiInhNBUJ7X02ta8vPbHcRlrdtGI0dPvgeyHXx9jnl0A1wTbIvp4e9J9NjHEkdY3j7M0FKu3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jrysIhTyUEPNcMsi0cFziW7rGCLwNoQUc20vqWHTYA=;
 b=1gopTAG4B3Hplh6Xv0H/4RrDNPot3sso0BEXbjg8+SMj3pWbXqwDJ1Mx4EEqavnHxY8XWRINJZlgHp4eoSsBn1f59UWSQXe17kOcsDZhbftDYoH3on6CzdTW0pZxeSYtI0c7C/g3XqXYmNQwzlTZD/OIS2XE7OJC5ADcJJxbDWM=
Received: from DM6PR08CA0032.namprd08.prod.outlook.com (2603:10b6:5:80::45) by
 DM6PR12MB4651.namprd12.prod.outlook.com (2603:10b6:5:1f6::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.14; Tue, 28 Sep 2021 16:44:28 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::e4) by DM6PR08CA0032.outlook.office365.com
 (2603:10b6:5:80::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:44:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:44:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 24/64] drm/amdgpu/smu11.0: convert to IP version checking
Date: Tue, 28 Sep 2021 12:41:57 -0400
Message-ID: <20210928164237.833132-25-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: cbefadad-f0e9-4be7-096a-08d9829f3cb6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4651:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4651EE723C0F6E3F0B02D859F7A89@DM6PR12MB4651.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PJ7eLpZG0yPLywoVLeetyC6xD4dK/4y3UuukkDeApKMFEdBqtqXl64DEs7jsu5rdt+xnL2qWN6bhhtLU8jxqJy19LD4EpqolFw84k1vnGv9ESM9xQnCb80r7rKbp1EPMc7QaMyqagT4Y3OyerjAoqJMlxtLZmSspwlLxKqWYIpX4/NzpRCGWHDxJutk94XNXd6EY5u36/rX48XMLjSfKXNHwOqQTpL1T62G0c7VyaiQTBMSMja2uAnoyqxbUCOEDVlY9ChQfvaTTjybI0q6tYxjBpbMQzvWzjunpaKtyJBbOTnW+5GQhZpGiq/0EcmDp/ubcRrD4PzLb+3qyzbYL8XpU4vEImTPQzeBK6+hvSYs26n1ciKZ7d2XfjYjZgd/7kIL5u5pNNTNxd5IfXLuciB1qdUwIK7g9R6kGhBzKCnbydoK/yoYmPJbxWo53OTpv0cRJv+EfgJQIUCBbUFp1Gbpj8rfxlrUZEv6IaZF3BSrUhZcb85OT0ZRQ/C56+foZZYwVFzJCneSlJbaCMBdqTCYX6Sxx9uepDzD/FLkIEECha6FYlRKbHC2L/9MsaHW1bKDRp4lEOI50c2wITSyKZ15l6iXE7QwWDNoNND3PfdneneJi6xO4Es2VmtkHnzcPKE6OwEpyblJL85I1oXmgGL+t2nMeaXZk9KmprIR+c3ylW5e5oVQUEBFyyPaGr/yYnqsaSM4+I7QYEGxjVsgy1+Q+bP3XiwYvSr8YNwH3yFQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(26005)(426003)(336012)(70586007)(2906002)(7696005)(36756003)(86362001)(2616005)(70206006)(6916009)(4326008)(54906003)(16526019)(508600001)(83380400001)(36860700001)(82310400003)(5660300002)(1076003)(316002)(8936002)(8676002)(6666004)(81166007)(47076005)(66574015)(186003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:44:27.8740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbefadad-f0e9-4be7-096a-08d9829f3cb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4651
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
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 88 ++++++++++---------
 1 file changed, 46 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 87b055466a33..5af7c8b7806f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -90,36 +90,37 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
 	struct amdgpu_firmware_info *ucode = NULL;
 
 	if (amdgpu_sriov_vf(adev) &&
-			((adev->asic_type == CHIP_NAVI12) ||
-			 (adev->asic_type == CHIP_SIENNA_CICHLID)))
+	    ((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 9)) ||
+	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7))))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_ARCTURUS:
-		chip_name = "arcturus";
-		break;
-	case CHIP_NAVI10:
+	switch (adev->ip_versions[MP1_HWIP]) {
+	case IP_VERSION(11, 0, 0):
 		chip_name = "navi10";
 		break;
-	case CHIP_NAVI14:
+	case IP_VERSION(11, 0, 5):
 		chip_name = "navi14";
 		break;
-	case CHIP_NAVI12:
+	case IP_VERSION(11, 0, 9):
 		chip_name = "navi12";
 		break;
-	case CHIP_SIENNA_CICHLID:
+	case IP_VERSION(11, 0, 7):
 		chip_name = "sienna_cichlid";
 		break;
-	case CHIP_NAVY_FLOUNDER:
+	case IP_VERSION(11, 0, 11):
 		chip_name = "navy_flounder";
 		break;
-	case CHIP_DIMGREY_CAVEFISH:
+	case IP_VERSION(11, 0, 12):
 		chip_name = "dimgrey_cavefish";
 		break;
-	case CHIP_BEIGE_GOBY:
+	case IP_VERSION(11, 0, 13):
 		chip_name = "beige_goby";
 		break;
 	default:
+		if (adev->asic_type == CHIP_ARCTURUS) {
+			chip_name = "arcturus";
+			break;
+		}
 		dev_err(adev->dev, "Unsupported ASIC type %d\n", adev->asic_type);
 		return -EINVAL;
 	}
@@ -238,38 +239,39 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 	if (smu->is_apu)
 		adev->pm.fw_version = smu_version;
 
-	switch (smu->adev->asic_type) {
-	case CHIP_ARCTURUS:
-		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_ARCT;
-		break;
-	case CHIP_NAVI10:
+	switch (adev->ip_versions[MP1_HWIP]) {
+	case IP_VERSION(11, 0, 0):
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV10;
 		break;
-	case CHIP_NAVI12:
+	case IP_VERSION(11, 0, 9):
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV12;
 		break;
-	case CHIP_NAVI14:
+	case IP_VERSION(11, 0, 5):
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV14;
 		break;
-	case CHIP_SIENNA_CICHLID:
+	case IP_VERSION(11, 0, 7):
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Sienna_Cichlid;
 		break;
-	case CHIP_NAVY_FLOUNDER:
+	case IP_VERSION(11, 0, 11):
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Navy_Flounder;
 		break;
 	case CHIP_VANGOGH:
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_VANGOGH;
 		break;
-	case CHIP_DIMGREY_CAVEFISH:
+	case IP_VERSION(11, 0, 12):
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish;
 		break;
-	case CHIP_BEIGE_GOBY:
+	case IP_VERSION(11, 0, 13):
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Beige_Goby;
 		break;
-	case CHIP_CYAN_SKILLFISH:
+	case IP_VERSION(11, 0, 8):
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Cyan_Skillfish;
 		break;
 	default:
+		if (adev->asic_type == CHIP_ARCTURUS) {
+			smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_ARCT;
+			break;
+		}
 		dev_err(smu->adev->dev, "smu unsupported asic type:%d.\n", smu->adev->asic_type);
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_INV;
 		break;
@@ -492,8 +494,9 @@ int smu_v11_0_fini_smc_tables(struct smu_context *smu)
 
 int smu_v11_0_init_power(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
 	struct smu_power_context *smu_power = &smu->smu_power;
-	size_t size = smu->adev->asic_type == CHIP_VANGOGH ?
+	size_t size = adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 5, 0) ?
 			sizeof(struct smu_11_5_power_context) :
 			sizeof(struct smu_11_0_power_context);
 
@@ -750,8 +753,9 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
 	/* Navy_Flounder/Dimgrey_Cavefish do not support to change
 	 * display num currently
 	 */
-	if (adev->asic_type >= CHIP_NAVY_FLOUNDER &&
-	    adev->asic_type <= CHIP_BEIGE_GOBY)
+	if (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 11) ||
+	    adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 5, 0) ||
+	    adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 13))
 		return 0;
 
 	return smu_cmn_send_smc_msg_with_param(smu,
@@ -1136,15 +1140,15 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
 	int ret = 0;
 	struct amdgpu_device *adev = smu->adev;
 
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_NAVI12:
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
-	case CHIP_VANGOGH:
+	switch (adev->ip_versions[MP1_HWIP]) {
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 5):
+	case IP_VERSION(11, 0, 9):
+	case IP_VERSION(11, 0, 7):
+	case IP_VERSION(11, 0, 11):
+	case IP_VERSION(11, 0, 12):
+	case IP_VERSION(11, 0, 13):
+	case IP_VERSION(11, 5, 0):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
@@ -1630,11 +1634,11 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 	mutex_lock(&smu_baco->mutex);
 
 	if (state == SMU_BACO_STATE_ENTER) {
-		switch (adev->asic_type) {
-		case CHIP_SIENNA_CICHLID:
-		case CHIP_NAVY_FLOUNDER:
-		case CHIP_DIMGREY_CAVEFISH:
-		case CHIP_BEIGE_GOBY:
+		switch (adev->ip_versions[MP1_HWIP]) {
+		case IP_VERSION(11, 0, 7):
+		case IP_VERSION(11, 0, 11):
+		case IP_VERSION(11, 0, 12):
+		case IP_VERSION(11, 0, 13):
 			if (amdgpu_runtime_pm == 2)
 				ret = smu_cmn_send_smc_msg_with_param(smu,
 								      SMU_MSG_EnterBaco,
-- 
2.31.1

