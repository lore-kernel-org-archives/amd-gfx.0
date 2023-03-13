Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D612C6FD19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 01:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7985510E45E;
	Mon, 13 Mar 2023 01:44:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E2810E45E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 01:44:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xy7Qufsey0BoDra5qG3mvy8gSpsXTjqHPsSXOBIlyaNeBtlhn6BAfCpdL9iQVnI2JFbwjoi/qYx+A4/HJ+A0mRKe74f9kvobRN7zQelg566TunHSnXxo3i+ZpRcpmnERliYfM9Wzkv7yqaFMoMWimET7/4a8vvCP5/vAXiooFZd6ZBx28wyL4qKDCGZM92AGo+EfGVNEvE80JEyzoUB+rCsi2hOV6cZhLXrnaF11b/7qtHcqhjOfRYDUpt2nBqAjRc6wpBSrZ+795wFNpriibEOIshcjCLwb1SQcyre7EIzOr/PwE5+8QVU9MKP89buZSILuszXblu7FEvCGBd5wsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlR9iEzObAMxn339BmjD0WmAvX72aq/Va0DQi22AmRI=;
 b=e0tif6srRPFtTjJEtc8pD8FXQl9z9S+lQwxGtlofYPeIuMPXsBKUf7J9UsAFfcVeRn7gAMNFhuFek0/eCLC3hY2Box7v2E3gMlEi9VmN8Vg50mPZbDu0SWZ5DCofIzQ606Dq6WpsTpXB9AIUwKsygU4ry4/mB8FnPoTSVb0V6KgktJT97qR3afm8X1WRNINwkXHxlgYdXPuEdfNclgs8Ik2FYJQjlM0tFwDQ4Btzx/jMbPYnYNMtKnQIhB2Bj1I6v0SN4wpGfoOl7U+JEZZ/Y9go5rPS8p6Zk/RlypWKQqOVY8gAgDq1NrTtBBAgN2uqWGbnZnKH+Q6zVta/b5FQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlR9iEzObAMxn339BmjD0WmAvX72aq/Va0DQi22AmRI=;
 b=rnoX+2v9vJCW2/CFLN23yRFmTIM6WK0qVk1fgYrQrwXs60EeHhkCS9YGnU7PZE0379Rz9slTg5aE/nzAt8NnyWqZIP01b+1wtskZVzXiESM9ftXu8/GOg9bSMQaZ+DJVtCsyRH7fvJ58wIZae5moy4zgudjCeN/cEoNbp6xptvA=
Received: from BN9PR03CA0653.namprd03.prod.outlook.com (2603:10b6:408:13b::28)
 by BY5PR12MB5509.namprd12.prod.outlook.com (2603:10b6:a03:1d7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25; Mon, 13 Mar
 2023 01:44:38 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::eb) by BN9PR03CA0653.outlook.office365.com
 (2603:10b6:408:13b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 01:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.24 via Frontend Transport; Mon, 13 Mar 2023 01:44:37 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 12 Mar 2023 20:44:34 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 03/10] drm/amdgpu: Move umc ras block init to gmc ras sw_init
Date: Mon, 13 Mar 2023 09:43:56 +0800
Message-ID: <20230313014403.21903-4-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230313014403.21903-1-Hawking.Zhang@amd.com>
References: <20230313014403.21903-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT049:EE_|BY5PR12MB5509:EE_
X-MS-Office365-Filtering-Correlation-Id: f83c6583-fc9b-4927-e41b-08db23648168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZpjE3pp13k/lNthBSEDt1AdujIBOCGc/28V5K64k2Dnv9M4LR8PNCZytq1lDMfZd+1Xcfr6AGweNuUknXC7/6W0mjuB7JpjC7OkyYILVdh9pqsP7DkveDB/HyWpqVy+zYcdVhQiqft/S4flZ/VWLWxdNkvcNqQcD86dLNiffh1fayTaLMQzQd4+yTNFzhbdbRX1vlB8ryFi/VowC66tigelQ+Xcr/RrelxtC2FgPKWhGAgvEJhiPBPK5KFrZIg5qlF7RzVJp4eDHNJcYZqUBsMZjfxKrWTcHH9YgbT46eP51IhiN471ZH09vevqcBB5iSLAUbjfgPyXFyHckryWqK+e+O51pAIndiGoAkPHEY53rhFccHM24EwoSmmxX8W75Mx4OLA9fb24xRXmVGzPcViYL51P2tuiExKm1znawnNIeWLCeQwlj7RekY2kANMv8MPb4dJZiwiVi/LCHE4htL6VgZFlbR+nVf7GLiIUS2/SPouLPyq/cenPOekl6dEf29FrhaHCyPcdm59/NNgZk+9IcbctREin1NJyAyjw8U16gc6GZ/eMadiWg0ccvqa5M/TUkTHgozbKpALboHanGG+NvCiJb5R5pvG6ZXMLyu4P2N+iSzVGEz0Hgp3xFYvib5KXczRE8VekHEwuATW9d9BPb27bWElpVDNBkDpnG7wq9g8PewkbsHG15JlBzY9eryEdHjKa8b4/RJDwKkJwJ3JzUAwdMybXYekrE3BH7WQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39850400004)(346002)(396003)(136003)(451199018)(46966006)(40470700004)(36840700001)(2906002)(81166007)(82740400003)(83380400001)(36756003)(40460700003)(5660300002)(40480700001)(70586007)(8676002)(70206006)(186003)(41300700001)(8936002)(356005)(4326008)(316002)(36860700001)(6636002)(86362001)(110136005)(82310400005)(478600001)(7696005)(16526019)(47076005)(426003)(336012)(2616005)(1076003)(6666004)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 01:44:37.7425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f83c6583-fc9b-4927-e41b-08db23648168
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5509
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initialize umc ras block only when umc ip block
supports ras. Driver queries ras capabilities after
early_init, ras block init needs to be moved to
sw_init.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  9 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 30 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 26 ++++-----------------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 21 ++++-------------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 26 ++++-----------------
 7 files changed, 52 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 6830f671cde7..c764b57957e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -446,8 +446,15 @@ void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
 	} while (fault->timestamp < tmp);
 }
 
-int amdgpu_gmc_ras_early_init(struct amdgpu_device *adev)
+int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev)
 {
+	int r;
+
+	/* umc ras block */
+	r = amdgpu_umc_ras_sw_init(adev);
+	if (r)
+		return r;
+
 	if (!adev->gmc.xgmi.connected_to_cpu) {
 		adev->gmc.xgmi.ras = &xgmi_ras;
 		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 0305b660cd17..f1773abd5e1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -351,7 +351,7 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
 			      uint16_t pasid, uint64_t timestamp);
 void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
 				     uint16_t pasid);
-int amdgpu_gmc_ras_early_init(struct amdgpu_device *adev);
+int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
 void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
 int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 1b8574bc4463..da68ceaa024c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -208,6 +208,36 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 	return amdgpu_umc_do_page_retirement(adev, ras_error_status, entry, true);
 }
 
+int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev)
+{
+	int err;
+	struct amdgpu_umc_ras *ras;
+
+	if (!adev->umc.ras)
+		return 0;
+
+	ras = adev->umc.ras;
+
+	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
+	if (err) {
+		dev_err(adev->dev, "Failed to register umc ras block!\n");
+		return err;
+	}
+
+	strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
+	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__UMC;
+	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+	adev->umc.ras_if = &ras->ras_block.ras_comm;
+
+	if (!ras->ras_block.ras_late_init)
+		ras->ras_block.ras_late_init = amdgpu_umc_ras_late_init;
+
+	if (ras->ras_block.ras_cb)
+		ras->ras_block.ras_cb = amdgpu_umc_process_ras_data_cb;
+
+	return 0;
+}
+
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 36e19336f3b3..d7f1229ff11f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -87,6 +87,7 @@ struct amdgpu_umc {
 	unsigned long active_mask;
 };
 
+int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset);
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index c59c2332d191..924f6f38fae6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -703,25 +703,8 @@ static void gmc_v10_0_set_umc_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-	if (adev->umc.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
-
-		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
-		adev->umc.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__UMC;
-		adev->umc.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
-		adev->umc.ras_if = &adev->umc.ras->ras_block.ras_comm;
-
-		/* If don't define special ras_late_init function, use default ras_late_init */
-		if (!adev->umc.ras->ras_block.ras_late_init)
-				adev->umc.ras->ras_block.ras_late_init = amdgpu_umc_ras_late_init;
-
-		/* If not defined special ras_cb function, use default ras_cb */
-		if (!adev->umc.ras->ras_block.ras_cb)
-			adev->umc.ras->ras_block.ras_cb = amdgpu_umc_process_ras_data_cb;
-	}
 }
 
-
 static void gmc_v10_0_set_mmhub_funcs(struct amdgpu_device *adev)
 {
 	switch (adev->ip_versions[MMHUB_HWIP][0]) {
@@ -758,7 +741,6 @@ static void gmc_v10_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 
 static int gmc_v10_0_early_init(void *handle)
 {
-	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	gmc_v10_0_set_mmhub_funcs(adev);
@@ -774,10 +756,6 @@ static int gmc_v10_0_early_init(void *handle)
 	adev->gmc.private_aperture_end =
 		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
 
-	r = amdgpu_gmc_ras_early_init(adev);
-	if (r)
-		return r;
-
 	return 0;
 }
 
@@ -1028,6 +1006,10 @@ static int gmc_v10_0_sw_init(void *handle)
 
 	amdgpu_vm_manager_init(adev);
 
+	r = amdgpu_gmc_ras_sw_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index af7b3ba1ca00..1c585cc24857 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -581,23 +581,6 @@ static void gmc_v11_0_set_umc_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-
-	if (adev->umc.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
-
-		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
-		adev->umc.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__UMC;
-		adev->umc.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
-		adev->umc.ras_if = &adev->umc.ras->ras_block.ras_comm;
-
-		/* If don't define special ras_late_init function, use default ras_late_init */
-		if (!adev->umc.ras->ras_block.ras_late_init)
-			adev->umc.ras->ras_block.ras_late_init = amdgpu_umc_ras_late_init;
-
-		/* If not define special ras_cb function, use default ras_cb */
-		if (!adev->umc.ras->ras_block.ras_cb)
-			adev->umc.ras->ras_block.ras_cb = amdgpu_umc_process_ras_data_cb;
-	}
 }
 
 
@@ -846,6 +829,10 @@ static int gmc_v11_0_sw_init(void *handle)
 
 	amdgpu_vm_manager_init(adev);
 
+	r = amdgpu_gmc_ras_sw_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b06170c00dfc..e9b6599e790c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1318,23 +1318,6 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-
-	if (adev->umc.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
-
-		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
-		adev->umc.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__UMC;
-		adev->umc.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
-		adev->umc.ras_if = &adev->umc.ras->ras_block.ras_comm;
-
-		/* If don't define special ras_late_init function, use default ras_late_init */
-		if (!adev->umc.ras->ras_block.ras_late_init)
-				adev->umc.ras->ras_block.ras_late_init = amdgpu_umc_ras_late_init;
-
-		/* If not defined special ras_cb function, use default ras_cb */
-		if (!adev->umc.ras->ras_block.ras_cb)
-			adev->umc.ras->ras_block.ras_cb = amdgpu_umc_process_ras_data_cb;
-	}
 }
 
 static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)
@@ -1406,7 +1389,6 @@ static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev)
 
 static int gmc_v9_0_early_init(void *handle)
 {
-	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	/* ARCT and VEGA20 don't have XGMI defined in their IP discovery tables */
@@ -1436,10 +1418,6 @@ static int gmc_v9_0_early_init(void *handle)
 	adev->gmc.private_aperture_end =
 		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
 
-	r = amdgpu_gmc_ras_early_init(adev);
-	if (r)
-		return r;
-
 	return 0;
 }
 
@@ -1798,6 +1776,10 @@ static int gmc_v9_0_sw_init(void *handle)
 
 	gmc_v9_0_save_registers(adev);
 
+	r = amdgpu_gmc_ras_sw_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
-- 
2.17.1

