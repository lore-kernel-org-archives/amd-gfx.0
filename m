Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBFCC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D5760527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F1D5760527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC7796EA9E;
	Tue, 21 Sep 2021 18:08:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81AFF6EA7B
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J55TOkzy/kMQrXzZG83dyjWh3GBkoMl5IuKL5QyMhJ9zeMOldhUEKqGS2B8YhJdIMTb2HEuG6GqxgWSIcm0aql8ARWej3aZzqDZVYEcEmkQNh6zUmIZLnyz/ioKcdhInyZP+KWApBnGyfR9BWN6DKAnkMpsPeYoe82RTFVOX9IUAsgY8uuqHRV1EmdOuFw9hgKssjSA1mqWhgCppjvk8fYl851F1B93r7nU+qTg4zfS2N4AgfAkGYiFzC2lBJzl6bluDe7PPz6X9RziSndFFDuugK0Hu5BsOQnJ/OE6/7O//XVXDI5UgiSBJIXkf5CafDPSpOituRKYvl2z/M6RjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=yl5TLQgXtqxKnNYtaRy6jBY1u3hPozXPXTm6n98BXrg=;
 b=A5D133zb1pqaNoiqA6HghSEqlo7SJ/WZY6qNqrIV5pgRvKX/C1SrBSTMBcik73CuGBRNnR3ejHhcz69n7FmpSSCMUIQqItMr0rERKrU8WEkqYCLLsdBCWshfU5BBaeqGJKgdiWraMuoqQ4FPGTxvm3+4JOt8SreWWVwoXlgVV/FraFKqp0Jox36NigeCFw5SfOPCtZLrAipKtqSX+tiIh/cxu4YxYcg/JVkpFx/iZghH9h2Dh2MplIv2tm457Ht7jbDE1DqmQVtv7acB+uNurAMi/B0/j2s89hrVHXmUNKlg5eGVy8uaki40T75XHnzBrIglTyZIDqyvSXildlIA9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yl5TLQgXtqxKnNYtaRy6jBY1u3hPozXPXTm6n98BXrg=;
 b=5IXzqaNU/0TrB7IIjcB5XEY+S5o6zPMaRPHOlMw3oEVWCqXH+jgXuhWBuK8mYof7g/3xiDmVD8qKf5/C2xnpM8j9U6ijx3QVGAPeV0wMCWr6EwEjLsZQe7JaMZkdAJaLabCgKj5W/hHPBtpupkyPP04M1oVYq+UNtW9hH13sW8U=
Received: from DM5PR11CA0017.namprd11.prod.outlook.com (2603:10b6:3:115::27)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 18:07:53 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::8a) by DM5PR11CA0017.outlook.office365.com
 (2603:10b6:3:115::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:53 +0000
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
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 24/66] drm/amdgpu/smu11.0: convert to IP version checking
Date: Tue, 21 Sep 2021 14:06:43 -0400
Message-ID: <20210921180725.1985552-25-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1a4239ea-ac08-461f-a1c4-08d97d2abb4c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4317:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4317A0708F3781C5B27CC18FF7A19@MN2PR12MB4317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNuAaFrbDvii0+hja9lMg+bnnNnCXRQ0uhg/mnezOiZkToHT8WY0c2v7ccgMoOJcRZv2byVYb9wBtvlPKGBIyZ7vc9lkMqJKtejFw+PCMu9YLN4C/Es2+xTXEQg2KTLhviAuUDOmtQESz4n1KMmX9JThlhMN7Vbn2vYgABi31dDJE5xBeTDWt1YgA1yw3WkqWTvbBTpNRiWN2BTKcvxKLs2lBF66iQbcpDCnuK9GM+yd7R7c49ksY4YIHgzGo0eIq+Cv03c3KdMhDf4k5K6RHryQmR5ump99cCsy7rgQ77Uw01izqYo6oMpM64XEulcc3U7InkOPsdvyD7GlDg/jprwFstrEaGY2fnTspwSiwcA3XHgdL3bUCu5YNixidlkDlco5uq+jO3svFpihGmyCV+1fPvQezSDuTPhBcU8lC652zI/MpB4sZDxPNiXBHT3YqCg9bSl7hV5KglbrdWbo8Xt3+0xbRPHhy/5RtNUQsk6/8OYry0fHLhvjvulGC/Hs7dvWskWSoZQGtZCddyD/bmTUWJO3oPmWL0zr33WkjvmUtM/9DYDduD704lauZIxi0juGLwyNl+pG4TcKktUM2AA4PyD3++ghLTLnEBsHqtW1SL5eJSM5PYpJ9HLYFLtBceD6TEwk+V37bKtE9rjiE4ZephjN2JJ5DtRXy0dcUVoMccy6ScxBBB3J1Thm3GxAC7Mq1PW5vz0RP0eU9NDVkHghlf4M39RXYBVJwG2RyBY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70586007)(70206006)(8676002)(508600001)(47076005)(82310400003)(426003)(356005)(316002)(83380400001)(6916009)(1076003)(4326008)(6666004)(2906002)(81166007)(86362001)(26005)(8936002)(36756003)(16526019)(336012)(36860700001)(5660300002)(7696005)(2616005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:53.3306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4239ea-ac08-461f-a1c4-08d97d2abb4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
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

