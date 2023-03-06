Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5CBC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 02:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CB4E10E085;
	Mon,  6 Mar 2023 02:33:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0003D10E076
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 02:33:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBPjLeJKMisTnCsmY4y72+pUt+iRbsiH2p7GwH593sXg3dv8INvcJFcc9MjsPQoUw226O+JQ3hPjw/UZ+HKycAmTIXBloU9xZYMrL2cBBVYc16eTuGJ8gtLP/8OW4PNmDlBz+xld8vcfiwwfLDf8niSPW8dCBWeHT2oywHOAUUDsuNcqRNR4pRiQ5uAmm4GK4BWmuVccinCyxAqI50C7lUmkBu5owJcO153DYWVLLSRCgEMvj2YQo6vT1V5uq4nYAdWEJQM8/HZjHhI0rwQcoc/mxuKkK3I31QP0zzXf2rFKNImqGIlixfR/zP+hrdlepw7fOZeLpJ2P6YRTBJDngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFuBN4TyhGa+n/weJYknIsUqv946A2jzyDgwtiiazKY=;
 b=d1XOJtanEsNquUrEX6CTYwliOiM51Oh77E+Xtv5g3y7lpY3s6R2OJQNvRhiWUkWX1SnGl49NdDK3L1w6dinPeW3tLXeYVS6VeLDu++/LKztFV0Fie1T8wse2oXXhR1+5FAFsj4TElGkHDwx7pm4Tcz8EiBHJT9VSTo4GP9RfMnJdvhLSw+3cfGav56XUMD79KWE8eUQsbWJSF3Cszdxj0kTdV0TGkWd70Hbqn314M1f8Rq3yKkmZl3yGfiD0YnAugsZf5bAt9Tatbigd5+IqmPMmGYwXXigs3xeV20MiCj5ofJjt8YWE0rR75E/WGnpBU5L4aF/xFLUjUvautMyo6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFuBN4TyhGa+n/weJYknIsUqv946A2jzyDgwtiiazKY=;
 b=Sh3F7p5WiSKrOIas7xBl9lOSA20BPrWpFsji7r7r5d0rqXp+OsbN4UK8wJScaYgLfJXOPyPJcJT9ad7m2+RPpgROKGV7CWW5O69t3o4AMyn47I5NVY/ThTE4g+HtBskmjA2N8QNzHbfCZWYved1C7saWkFwYi+lz+z5e0+Zy+z4=
Received: from BN0PR04CA0018.namprd04.prod.outlook.com (2603:10b6:408:ee::23)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 02:33:00 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::c4) by BN0PR04CA0018.outlook.office365.com
 (2603:10b6:408:ee::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27 via Frontend
 Transport; Mon, 6 Mar 2023 02:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 02:32:59 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 20:32:57 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 05/11] drm/amdgpu: Move umc ras block init to gmc ras sw_init
Date: Mon, 6 Mar 2023 10:31:54 +0800
Message-ID: <20230306023200.29158-6-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306023200.29158-1-Hawking.Zhang@amd.com>
References: <20230306023200.29158-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|CO6PR12MB5443:EE_
X-MS-Office365-Filtering-Correlation-Id: 21066003-30b6-4c0b-6aa0-08db1deb1a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rIargHfozrSl49lGzKnohR9yDX59XYMZlXgrviXUr5GEG/DcmPoFOSoTplwfyEMURozxNRnhFcgF/BMx+/CFvwO31T45zwc0MccUc6CBbSIJeatoUFa8FAKqYk8hGZykdKCQSm2FzlB4Wj6xra04XEGO69VeogrDkCt8bn9ckj2j3a0AGkGSvoexIwrgv5QsXl7WOYw9ZJIW0FmqzmULPwLEmkxx4Ld+/0TCxlP/xUzN5dYA1Vr0aUtzca+vI0+hKNtHHXlQ8KcBXg4hnZQ8zITNzTMNpZzBwjnbBsS817uMZYy/RY9h700VLcM97ZgZyICHjzwI5trVIp78vVKZb8+/Kl1ZpA9uHGxY/sbSyUmar9SlURA/YbXwavWuoBzr0WM0l8BSxBC9rI4755i2q7RX5mgwNbR9YuH1M4W2Utf6oOagiC6ge3NOSRKWbp3TZQpZRmHtnsN568uZlVDtPf/a0OKOlHIahpaLatdDzj9JCNDhsQXXaSwy9g04XPzmcAhKfsX70g93xLR5oeKUlcfkSHgzntNY9n/DeKv0uk7CrpkQTblurhqs4ibWxd5noiQa0QokRnwEruzdb4el4mNWZjh2x+7En88A7vI0XzET12u390l/G/TiS0sz7e8j29fX4pDF90sddVSwNwe+xC0dvDUWSSvvexV8SdQtXHph+ChUl1hY/vdE8bfJ2vOfXMFTqG8tY+x3Suw0YeM+emPJVwaVPuB+0As3lvPs7b8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199018)(36840700001)(40470700004)(46966006)(478600001)(36860700001)(47076005)(83380400001)(426003)(7696005)(36756003)(6666004)(82310400005)(316002)(356005)(110136005)(82740400003)(6636002)(26005)(2616005)(336012)(1076003)(186003)(16526019)(40460700003)(5660300002)(86362001)(81166007)(2906002)(40480700001)(8676002)(4326008)(70206006)(70586007)(41300700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 02:32:59.9922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21066003-30b6-4c0b-6aa0-08db1deb1a62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 16 +++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 30 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 26 ++++-----------------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 21 ++++-------------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 26 ++++-----------------
 7 files changed, 58 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 6830f671cde7..97a12d8d786a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -446,9 +446,21 @@ void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
 	} while (fault->timestamp < tmp);
 }
 
-int amdgpu_gmc_ras_early_init(struct amdgpu_device *adev)
+int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev)
 {
-	if (!adev->gmc.xgmi.connected_to_cpu) {
+	int r;
+
+	/* umc ras block */
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC)) {
+		r = amdgpu_umc_ras_sw_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to initialize umc ras block!\n");
+			return r;
+		}
+	}
+
+	/* xgmi ras block */
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL)) {
 		adev->gmc.xgmi.ras = &xgmi_ras;
 		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
 		adev->gmc.xgmi.ras_if = &adev->gmc.xgmi.ras->ras_block.ras_comm;
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

