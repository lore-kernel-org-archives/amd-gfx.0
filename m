Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30251C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 03:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD42D10E41D;
	Wed, 19 Jan 2022 03:05:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E889210E41D
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 03:05:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLWbFGFer/5o6Xsuk/1gApsRrTRDkc7KP01A+IEfED/03hBj8Jy0OQLg/74EH2+WITLEH86lH7V/twA+8oMC/V0jL5ntGLGdTvBfDv58x24qXnsUiGimbKQn+oX8gG47MKR+tNMwNq5KYYtj5P+jrGtaVSeHhpuzLh3HCw9nEuZpY+ulTL6md/Og5m69K0hXhreFcPQtggnMS+anOh1R4W1DtbzwGYTi0UwxvuRXh4z7QXXjEaNSbnIY5FNRFEwVXwEktwVVbl29BEeA9bNSacYlVjT6HitXkAd2mPOVlFEK4VqT/dkEjjsjGjcY4y37Yq7gFji+PSFxj9wbszCbhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcOfySR/Dy22z844O5Mt4VcFe2KQ0DpsVYaJMuIPPTU=;
 b=O/P6my+gL/JIb3lPUmpiTQMnXWZqZ22bQ32gamA4NwKB0wCzmYMhQ+gXoJQzcYe2uI6PvGpFM9J6ms0vnPhSc6UcCQD9Z+7IuUtYuJeIYKYSL2GbMgUsQY+dxTQ/4q3iAoIruHkaQxgDqI/b6FnyuFE80Fn1q8m0oYv9U49aaKfC+FuSKRMNdVbqvEsPoJvjc/uIuxAXKDLrNO29TVmZKsr9PkjQIvy9ls8kI2b5mHdrX5oxaK4/qZ5VSLsdRzrBiqZuwTehtUu0W+yHMAVLsdt8W2D+Wiv9Rp875QHrkACtSW+iau5KwCIYXu6/MXDTaHOwEgp2mn3CPJRm2p+PBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcOfySR/Dy22z844O5Mt4VcFe2KQ0DpsVYaJMuIPPTU=;
 b=RrRXb89ATQyz0lWcYqdDIso0ZPY7ymzhrbPNTe+5t8JOr66YCN7GKp0ZOp2XZZRVgh3b6aKH2CVaB7u5DLXzv58PJ9Iovw3kvZrvk1+hlFSaw3nBJtS1kaOqLKrg2mjegj6jHDiyc5xrdeoZt0VmBevAtOBDoCjSGBhZi5rOpkU=
Received: from DS7PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:3bb::16)
 by DM6PR12MB4564.namprd12.prod.outlook.com (2603:10b6:5:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 03:05:04 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::3e) by DS7PR03CA0071.outlook.office365.com
 (2603:10b6:5:3bb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Wed, 19 Jan 2022 03:05:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 03:05:03 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 21:05:02 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Fix MSB of SMU version printing
Date: Tue, 18 Jan 2022 21:04:56 -0600
Message-ID: <20220119030456.12493-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8f0ffc6-c737-4d5c-9041-08d9daf87d5a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4564:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB45642D778C2B74D1B093C66AE2599@DM6PR12MB4564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pw4cVOOKptcBK5UNS850CJdxKSbGvQQhmly7T/REZdzM/KaT6Y2n+vzDTRuE/lWeKHGm1c/d/PLk/vY8F8D88Rzid5kMxHUaCf7o/seyzCgUwQo4kbBBjBevMd/5n3v0fILyvsgrLkegyJggWnt/Xz3+bXfm1GRfF+dCFY/QqxsfLqZ7JW54oYFEs0YrCqB8a48ODYrylvk7tkayDyJTE0+rn0OO4Ub41UhxyxIuLdlFzzOGWLL2gvpxSF1UJDBdaizolgr0S4Ka8csgNPSrItpOOAXtuWpnssa+uJSZWKQStzUiKO4DVGK6ZMdDPxg195hWJSiPprtb3lIQ5XSN1mt2TUSiuKqhBMqIt4z8gX5kBtJYzPJgo6jau97Ig7SCuN2pymazNWBD8qQ0kep6herGnppXoPGtuGULjWPcjVGoHIrD/DrCBI8rvIIqXx9o/5vXMyCoDFyrMO/w6bAMTIxIg+T3fk+zlkxyayjPeeFb50N8zFUOGrZm9bSPFxv/ZHpb985CWvP1vQJPIc6DHmpaKFeFD1DrO7iCwZtN8EO7I0sO7P0jOi5Th/FUeKoLttZLz82S3ngr68tB7agegHyeBeUULU8ukTrCzWqM1/QiDzHiRNuKAIBARF/znjab/tQMXPRt61o9EovQv3sIyXc2920FZ/y8j93n1cOKrQoQgpbG5iUe6SQBrP/S8va2rT2XTZZiduioGphuWqFMybupvcl+tubODLEBchw0VutWzqg1UNTXFvQm5V6txOG55U5+ouulzjZLo5MKPxq/Ztv6R+kO4cU36g5JpsJvFX8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(6916009)(7696005)(44832011)(36756003)(4326008)(2616005)(47076005)(36860700001)(316002)(70586007)(356005)(8936002)(426003)(2906002)(508600001)(83380400001)(336012)(81166007)(70206006)(5660300002)(40460700001)(86362001)(6666004)(26005)(1076003)(186003)(16526019)(82310400004)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 03:05:03.8373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f0ffc6-c737-4d5c-9041-08d9daf87d5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4564
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yellow carp has been outputting versions like `1093.24.0`, but this
is supposed to be 69.24.0. That is the MSB is being interpreted
incorrectly.

The MSB is not part of the major version, but has generally been
treated that way thus far.  It's actually the program, and used to
distinguish between two programs from a similar family but different
codebase.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c        | 10 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 10 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c | 10 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 14 +++++++-------
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f3c864223033..ae793c648f5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1431,8 +1431,7 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 	struct drm_amdgpu_info_firmware fw_info;
 	struct drm_amdgpu_query_fw query_fw;
 	struct atom_context *ctx = adev->mode_info.atom_context;
-	uint8_t smu_minor, smu_debug;
-	uint16_t smu_major;
+	uint8_t smu_program, smu_major, smu_minor, smu_debug;
 	int ret, i;
 
 	static const char *ta_fw_name[TA_FW_TYPE_MAX_INDEX] = {
@@ -1578,11 +1577,12 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 	ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
 	if (ret)
 		return ret;
-	smu_major = (fw_info.ver >> 16) & 0xffff;
+	smu_program = (fw_info.ver >> 24) & 0xff;
+	smu_major = (fw_info.ver >> 16) & 0xff;
 	smu_minor = (fw_info.ver >> 8) & 0xff;
 	smu_debug = (fw_info.ver >> 0) & 0xff;
-	seq_printf(m, "SMC feature version: %u, firmware version: 0x%08x (%d.%d.%d)\n",
-		   fw_info.feature, fw_info.ver, smu_major, smu_minor, smu_debug);
+	seq_printf(m, "SMC feature version: %u, program: %d, firmware version: 0x%08x (%d.%d.%d)\n",
+		   fw_info.feature, smu_program, fw_info.ver, smu_major, smu_minor, smu_debug);
 
 	/* SDMA */
 	query_fw.fw_type = AMDGPU_INFO_FW_SDMA;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 7029e5deb6b3..e94a400db669 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -225,15 +225,15 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t if_version = 0xff, smu_version = 0xff;
-	uint16_t smu_major;
-	uint8_t smu_minor, smu_debug;
+	uint8_t smu_program, smu_major, smu_minor, smu_debug;
 	int ret = 0;
 
 	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
 	if (ret)
 		return ret;
 
-	smu_major = (smu_version >> 16) & 0xffff;
+	smu_program = (smu_version >> 24) & 0xff;
+	smu_major = (smu_version >> 16) & 0xff;
 	smu_minor = (smu_version >> 8) & 0xff;
 	smu_debug = (smu_version >> 0) & 0xff;
 	if (smu->is_apu)
@@ -287,9 +287,9 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 	 */
 	if (if_version != smu->smc_driver_if_version) {
 		dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
-			"smu fw version = 0x%08x (%d.%d.%d)\n",
+			"smu fw program = %d, version = 0x%08x (%d.%d.%d)\n",
 			smu->smc_driver_if_version, if_version,
-			smu_version, smu_major, smu_minor, smu_debug);
+			smu_program, smu_version, smu_major, smu_minor, smu_debug);
 		dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index 9c91e79c955f..56a02bc60cee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -74,15 +74,15 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t if_version = 0xff, smu_version = 0xff;
-	uint16_t smu_major;
-	uint8_t smu_minor, smu_debug;
+	uint8_t smu_program, smu_major, smu_minor, smu_debug;
 	int ret = 0;
 
 	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
 	if (ret)
 		return ret;
 
-	smu_major = (smu_version >> 16) & 0xffff;
+	smu_program = (smu_version >> 24) & 0xff;
+	smu_major = (smu_version >> 16) & 0xff;
 	smu_minor = (smu_version >> 8) & 0xff;
 	smu_debug = (smu_version >> 0) & 0xff;
 	if (smu->is_apu)
@@ -98,9 +98,9 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
 	 */
 	if (if_version != smu->smc_driver_if_version) {
 		dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
-			"smu fw version = 0x%08x (%d.%d.%d)\n",
+			"smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
 			smu->smc_driver_if_version, if_version,
-			smu_version, smu_major, smu_minor, smu_debug);
+			smu_program, smu_version, smu_major, smu_minor, smu_debug);
 		dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index f66d8b9135ca..d9e3ebfeee73 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -198,15 +198,15 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t if_version = 0xff, smu_version = 0xff;
-	uint16_t smu_major;
-	uint8_t smu_minor, smu_debug;
+	uint8_t smu_program, smu_major, smu_minor, smu_debug;
 	int ret = 0;
 
 	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
 	if (ret)
 		return ret;
 
-	smu_major = (smu_version >> 16) & 0xffff;
+	smu_program = (smu_version >> 24) & 0xff;
+	smu_major = (smu_version >> 16) & 0xff;
 	smu_minor = (smu_version >> 8) & 0xff;
 	smu_debug = (smu_version >> 0) & 0xff;
 	if (smu->is_apu)
@@ -229,8 +229,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 
 	/* only for dGPU w/ SMU13*/
 	if (adev->pm.fw)
-		dev_dbg(adev->dev, "smu fw reported version = 0x%08x (%d.%d.%d)\n",
-			 smu_version, smu_major, smu_minor, smu_debug);
+		dev_dbg(smu->adev->dev, "smu fw reported program %d, version = 0x%08x (%d.%d.%d)\n",
+			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
 
 	/*
 	 * 1. if_version mismatch is not critical as our fw is designed
@@ -242,9 +242,9 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	 */
 	if (if_version != smu->smc_driver_if_version) {
 		dev_info(adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
-			 "smu fw version = 0x%08x (%d.%d.%d)\n",
+			 "smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
 			 smu->smc_driver_if_version, if_version,
-			 smu_version, smu_major, smu_minor, smu_debug);
+			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
 		dev_warn(adev->dev, "SMU driver if version not matched\n");
 	}
 
-- 
2.25.1

