Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B876CD68E4
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 04:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E6BA10E12D;
	Tue, 10 Oct 2023 04:48:54 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A560110E12D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 04:48:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmraLTm1/zz3rOfrgpm2jCgwFbHTITlUvcu6phb2SESs7Ay62NTWO9ulGI2dlrgdTz9wamLeKwYxfyNzN4pk8/kKXLLUo2t3TfLjnvfmEs8w33rT3GgMSbK1v3jxacFR2Oa7imxE2zAPT4PcK7XUwOQ8ZW6Ov5OkXaAez32kkgcjrsq7IGeszwgNM48QLRLrnVjNES9Yn4SIAMU+aPM1G9Py29gdbV4mJEhm2MIZ7t12LeeT5sk3+bCxEWvhTASP30T4IvKPzZ3AMCV4TE26Szn9wsKd9siFW9g+JQO0OnXolCUWfqtvswhXqMXUdXCgnqDwAHKvEGE23G7TWJ9Irw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvmrGbKCLmxdT0q3XeajFP6EsuemdauPlchfjwM5YOQ=;
 b=aAOehGwHGNKfSXdt4CPgrReJ+yocwxloRW+MilO5G0s5ipwI/Mz63QSg+Z2JuT41Qn8jaHSDVkU0ryjPnXFXaRQTZNLthuGM3AVCU2mMUmm+UxmhAnMeVyGehaelXgFYVg5pBiEOE+wSY3gVH6+dFY7ArvK9u5EsxtaP0MLNyX9gz/qdKQbRGYcSX20nFIGL746ycS8rstK91k+KcoqCGyv0vW+Pkldmshqn3TnMGvxGDIZvK29Y5hMY4jTrOKFujE7KPWFWRb6jxJS5s+07zJLrXUjG8kcX8EpA5UFZTGMgoUU2beb1f7iHyOJynyI2XkmPBj4Lj0MUqt7Xy/L9wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvmrGbKCLmxdT0q3XeajFP6EsuemdauPlchfjwM5YOQ=;
 b=fAutcVoMv6eP8tshCfsF9qOdGMsFsbyldV+uNd77vnTN2aAl7kh1wdZIgrczLVChEUVofeOrSu6tFeXRPiRoySZ14gDDL96htSpguPjbnU2sdCWHYkvKJn7pTgfdzMlJgDRMhYmg44OmntQnVTk7akzqA/718BfQE/Yf9qNCOSg=
Received: from CY5PR18CA0048.namprd18.prod.outlook.com (2603:10b6:930:13::33)
 by PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 04:48:49 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::1e) by CY5PR18CA0048.outlook.office365.com
 (2603:10b6:930:13::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Tue, 10 Oct 2023 04:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 04:48:48 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 23:48:47 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: wait for completion of the EnableGfxImu command
Date: Tue, 10 Oct 2023 12:46:37 +0800
Message-ID: <20231010044637.3211216-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|PH7PR12MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 69452bb6-06e0-4c72-cac4-08dbc94c31a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LSWn8dWzN46YePi74u8q1Nu5i4BVvrJxctlNAmAUmE6SwSB7e1YSxA9Y/7vLqHFw0xlUGX4dm5Ntce3RQSti9EctI+SllYdmP+ZfmEPasAonds2prVncW+UbFt/QJV6S4gNJdPUBDZKSfsITENzG9kwe29KFNUh/X6OJvM1g47PAU178zlLJnshNuxhbCD71LglrYH7UBA9tr/fmmngrnX4Lz/K1Ve1uoFzDJt7dWtp0gP+izYNb7ix3HsIZcNuyWS24URkd+52K45JDRtpuLetBi+BEWdAB6xbdvaFKhftVWzOeos6GgFpaXnkvSKervh//zQap2PTZWn+F3TOMzdZp29YWiAvvXEUj+5YZjpfAa2eeWguY99+gnkgVwB2W3qPjdgjVaY8OUSyeiKT44nImURs5Hz6F3plJoDbnQ2tnrKhfxznApud8yvJ7nMBbcUtrvB333ss6ojqSmf2CPUNoH3Lhrn0tMoecT/f8qr903D8J63tMg51c1QZpRqF3sgzGzy4Dw8Zc8tAJH8uTKHFqR12XHaqxE4oCmXuLOxmcAfBOZlsHgK6YiDmRVy8PH9CY+JJ/4KJMBTfcSo3Tmyuy6jnzofoyWUzjz3Y13MNabpNvsyvixYxXlHJS5aoxEMrkNfZasER9UIHeDUuRALBOSqmASbiX/WBrll+Xu0h8JacjhU6K+JTxc/UWVylLTfaLw0LmgF4584LEX4A7DIEzJDyKftDlNXb6jz+FmPiWrfDtJtIZK02jFqpxIcanWMXHLguBtc/mTHv6Mbytkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(356005)(86362001)(36756003)(81166007)(82740400003)(40480700001)(2906002)(478600001)(41300700001)(7696005)(8936002)(4326008)(5660300002)(8676002)(6666004)(1076003)(2616005)(336012)(83380400001)(426003)(40460700003)(6916009)(70206006)(54906003)(70586007)(16526019)(316002)(36860700001)(47076005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 04:48:48.9806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69452bb6-06e0-4c72-cac4-08dbc94c31a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com,
 Tim Huang <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Wait for completion of sending the EnableGfxImu message
when using the PSP FW loading.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 8dc683c02a7d..bcb7ab9d2221 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -82,6 +82,8 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_10.bin");
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xC000
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0xE
 
+#define ENABLE_IMU_ARG_GFXOFF_ENABLE		1
+
 static const int link_width[] = {0, 1, 2, 4, 8, 12, 16};
 
 const int pmfw_decoded_link_speed[5] = {1, 2, 3, 4, 5};
@@ -2301,11 +2303,17 @@ int smu_v13_0_baco_exit(struct smu_context *smu)
 int smu_v13_0_set_gfx_power_up_by_imu(struct smu_context *smu)
 {
 	uint16_t index;
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableGfxImu,
+						       ENABLE_IMU_ARG_GFXOFF_ENABLE, NULL);
+	}
 
 	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
 					       SMU_MSG_EnableGfxImu);
-	/* Param 1 to tell PMFW to enable GFXOFF feature */
-	return smu_cmn_send_msg_without_waiting(smu, index, 1);
+	return smu_cmn_send_msg_without_waiting(smu, index,
+						ENABLE_IMU_ARG_GFXOFF_ENABLE);
 }
 
 int smu_v13_0_od_edit_dpm_table(struct smu_context *smu,
-- 
2.39.2

