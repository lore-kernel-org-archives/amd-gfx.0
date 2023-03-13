Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BC6C7618A
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 01:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 372D910E468;
	Mon, 13 Mar 2023 01:45:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5739510E465
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 01:44:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T78+fQpFAZr8113LKnMpDYT8uvkwKG+kVgZIThT0cichWSlQJkR7F+2jO9/+M4+HI+HonXU4bgNmkQnBIT1QXrDVYzT7/MmaFhZEZi+L/iUDA2sX8Wi1ICFHwHTPK/Pyx1MStvAAo9WdBZzybQ2ZIOJa0cqcQpj3jwI9F2vo0mM03Lm2zwggAwhGczOcS5Lh6P7kIBu1GzO0rgsCubM8mFArPXgMVOKg+Acjzd/P7P/sUO2wb0Ps3CbgJ48Zq102sKz/T+OGhOtpZzlWdRAm54vFp5hj6A7RLCjRnVQ7FUGxWKYLBxFgja34jAGd85wsdd4zSEMQ+uPxYBL53U7uyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0LcEIT06jaAV0sVpauKWCkLnJeqcDpDeP36dxL3qdg=;
 b=Wh8/+0vBHkQ0bpMg/tCd+mlJpFWKnuRtGT/1aUj/MwuUvvBhQB3bOi+2kCEDOWuKA/LVOBhPWkNKs+pSBDbDeqERFhRslCAygY5GaNuGft2bHfYXPXMTKsn6dPKs5hWd20NSsoXHh8dvjymai4eaJj5Xc6JIUjgWysYYU0pWB2NoMf8GEcNq56NrDY+DG2qDuU4qj9od8nAw7tOMMFwJkDWfmtebTmSLsKElxmnhVPf30/tIVDaCazmaZrrKxLw8cOKExbUnf1Q2NQmNqamp0So4t2lWf9GwY7rC7RZs55PHYrdUtEPCPP7xYqhsZG1C6ZBiO0XzTwRdkWJ22gYtng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0LcEIT06jaAV0sVpauKWCkLnJeqcDpDeP36dxL3qdg=;
 b=ZVK1fF16OFaCp3l0tgjyshwICiLxZR0m8SUzScHI+wmBxZcP7et0aoPRHeoJ7bivddM5xYwXXg/Z1mtSZndSfpeEmcr7pNFdVFcdWOcfvSaSxPc/P5P7mpjqBJKwgbEadcAxGOWc8EUHaoNm3HBGntNvb6kwuVkbEeZWbY/Rpv8=
Received: from BN0PR04CA0198.namprd04.prod.outlook.com (2603:10b6:408:e9::23)
 by BY5PR12MB4936.namprd12.prod.outlook.com (2603:10b6:a03:1d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23; Mon, 13 Mar
 2023 01:44:52 +0000
Received: from BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::3f) by BN0PR04CA0198.outlook.office365.com
 (2603:10b6:408:e9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 01:44:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT098.mail.protection.outlook.com (10.13.177.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.24 via Frontend Transport; Mon, 13 Mar 2023 01:44:51 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 12 Mar 2023 20:44:47 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 07/10] drm/amdgpu: Rework mca ras sw_init
Date: Mon, 13 Mar 2023 09:44:00 +0800
Message-ID: <20230313014403.21903-8-Hawking.Zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT098:EE_|BY5PR12MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2e5f41-0c7b-49c0-ee94-08db23648987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UwK8dFG4HSWApY/j6VKR4RvBDqQVJQN7FEHRc/yNTtVj28N79CYZyLr0mKz95n6+cbk+/KzYIfWpVQ0TPnE2Ru9aGzgmbqNL2T4RofrJWaIcSvZxWJeJDsONe9oVMjGzcv615I4t3VmbdOpay0pa4ouy/H3CGqWf8RwK0EzuhaDEpIult8AzfTLbRLV2K++fD04FnBm3Ys3+svsoD1QCQFy3jnClGpBXk/jMlMeRFTklxZeCiHfSvfw/p1+se19r5WLyTWHH1IckTSAtymfTW/rOoJDPDbLtaT0J1TFAWl5h/BhvdKSZmowjKwlS9qGXW74/5bBHnxkRjKnevaZZnrLn7P+DIOnFcFyXzSUKKIyS0exnU1xzypx9UtZ5p/z+deeH8+P7nVChBhCv2pjmieJbJblmdL9ZJWvFy8inA4tJc10B4927IskOngDPBBBjOX47zcPEcBLigT4W2BxzIcCOQornT+6FkGz1jQ8seTzvLi7VoS+WVWiQVkOl9dFnuXzx8LGDWzOl9ZXLO5bPg/nDqcrgmFbvM8peO2Z5aDeNHBToDLjniTe3ayWL84KFtcSlcTCnTbGk4FSWQcM5o7FS3wjUxfRQYcSLFqVgofM74PKpEI3vzXDG8r16WOjriky/J0tbLXZs4KMpolUj9igENmUYzCrJl7dNf8R+h63QvKaSEaDZzrQbvxmI2smXbC8UStHWQrO9DJwDuH8GJD7Wk9KQsWXGl9UpaYdefss=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39850400004)(396003)(376002)(346002)(136003)(451199018)(36840700001)(46966006)(40470700004)(82740400003)(36860700001)(82310400005)(356005)(70586007)(70206006)(41300700001)(8676002)(40480700001)(4326008)(7696005)(2906002)(40460700003)(316002)(86362001)(110136005)(6636002)(478600001)(36756003)(81166007)(426003)(47076005)(5660300002)(26005)(1076003)(2616005)(336012)(186003)(16526019)(6666004)(8936002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 01:44:51.3677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2e5f41-0c7b-49c0-ee94-08db23648987
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4936
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

To align with other IP blocks

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 13 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 72 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h |  9 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 15 +++---
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c   | 44 ++-------------
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.h   |  4 +-
 6 files changed, 103 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 551884dc5245..ab85b85496f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -465,6 +465,19 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	/* mca.x ras block */
+	r = amdgpu_mca_mp0_ras_sw_init(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_mca_mp1_ras_sw_init(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_mca_mpio_ras_sw_init(adev);
+	if (r)
+		return r;
+
 	if (!adev->gmc.xgmi.connected_to_cpu) {
 		adev->gmc.xgmi.ras = &xgmi_ras;
 		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 51c2a82e2fa4..0b545bdcd636 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -70,3 +70,75 @@ void amdgpu_mca_query_ras_error_count(struct amdgpu_device *adev,
 
 	amdgpu_mca_reset_error_count(adev, mc_status_addr);
 }
+
+int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device *adev)
+{
+	int err;
+	struct amdgpu_mca_ras_block *ras;
+
+	if (!adev->mca.mp0.ras)
+		return 0;
+
+	ras = adev->mca.mp0.ras;
+
+	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
+	if (err) {
+		dev_err(adev->dev, "Failed to register mca.mp0 ras block!\n");
+		return err;
+	}
+
+	strcpy(ras->ras_block.ras_comm.name, "mca.mp0");
+	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
+	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+	adev->mca.mp0.ras_if = &ras->ras_block.ras_comm;
+
+	return 0;
+}
+
+int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device *adev)
+{
+        int err;
+        struct amdgpu_mca_ras_block *ras;
+
+        if (!adev->mca.mp1.ras)
+                return 0;
+
+        ras = adev->mca.mp1.ras;
+
+        err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
+        if (err) {
+                dev_err(adev->dev, "Failed to register mca.mp1 ras block!\n");
+                return err;
+        }
+
+        strcpy(ras->ras_block.ras_comm.name, "mca.mp1");
+        ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
+        ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+        adev->mca.mp1.ras_if = &ras->ras_block.ras_comm;
+
+        return 0;
+}
+
+int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev)
+{
+        int err;
+        struct amdgpu_mca_ras_block *ras;
+
+        if (!adev->mca.mpio.ras)
+                return 0;
+
+        ras = adev->mca.mpio.ras;
+
+        err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
+        if (err) {
+                dev_err(adev->dev, "Failed to register mca.mpio ras block!\n");
+                return err;
+        }
+
+        strcpy(ras->ras_block.ras_comm.name, "mca.mpio");
+        ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
+        ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+        adev->mca.mpio.ras_if = &ras->ras_block.ras_comm;
+
+        return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index 7ce16d16e34b..997a073e2409 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -30,12 +30,7 @@ struct amdgpu_mca_ras {
 	struct amdgpu_mca_ras_block *ras;
 };
 
-struct amdgpu_mca_funcs {
-	void (*init)(struct amdgpu_device *adev);
-};
-
 struct amdgpu_mca {
-	const struct amdgpu_mca_funcs *funcs;
 	struct amdgpu_mca_ras mp0;
 	struct amdgpu_mca_ras mp1;
 	struct amdgpu_mca_ras mpio;
@@ -55,5 +50,7 @@ void amdgpu_mca_reset_error_count(struct amdgpu_device *adev,
 void amdgpu_mca_query_ras_error_count(struct amdgpu_device *adev,
 				      uint64_t mc_status_addr,
 				      void *ras_error_status);
-
+int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device *adev);
+int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device *adev);
+int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 9a333f9744bf..67c2a5186b8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1363,13 +1363,18 @@ static void gmc_v9_0_set_hdp_ras_funcs(struct amdgpu_device *adev)
 	adev->hdp.ras = &hdp_v4_0_ras;
 }
 
-static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev)
+static void gmc_v9_0_set_mca_ras_funcs(struct amdgpu_device *adev)
 {
+	struct amdgpu_mca *mca = &adev->mca;
+
 	/* is UMC the right IP to check for MCA?  Maybe DF? */
 	switch (adev->ip_versions[UMC_HWIP][0]) {
 	case IP_VERSION(6, 7, 0):
-		if (!adev->gmc.xgmi.connected_to_cpu)
-			adev->mca.funcs = &mca_v3_0_funcs;
+		if (!adev->gmc.xgmi.connected_to_cpu) {
+			mca->mp0.ras = &mca_v3_0_mp0_ras;
+			mca->mp1.ras = &mca_v3_0_mp1_ras;
+			mca->mpio.ras = &mca_v3_0_mpio_ras;
+		}
 		break;
 	default:
 		break;
@@ -1398,7 +1403,7 @@ static int gmc_v9_0_early_init(void *handle)
 	gmc_v9_0_set_mmhub_ras_funcs(adev);
 	gmc_v9_0_set_gfxhub_funcs(adev);
 	gmc_v9_0_set_hdp_ras_funcs(adev);
-	gmc_v9_0_set_mca_funcs(adev);
+	gmc_v9_0_set_mca_ras_funcs(adev);
 
 	adev->gmc.shared_aperture_start = 0x2000000000000000ULL;
 	adev->gmc.shared_aperture_end =
@@ -1611,8 +1616,6 @@ static int gmc_v9_0_sw_init(void *handle)
 	adev->gfxhub.funcs->init(adev);
 
 	adev->mmhub.funcs->init(adev);
-	if (adev->mca.funcs)
-		adev->mca.funcs->init(adev);
 
 	spin_lock_init(&adev->gmc.invalidate_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
index d4bd7d1d2649..6dae4a2e2767 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
@@ -51,19 +51,13 @@ static int mca_v3_0_ras_block_match(struct amdgpu_ras_block_object *block_obj,
 	return -EINVAL;
 }
 
-const struct amdgpu_ras_block_hw_ops mca_v3_0_mp0_hw_ops = {
+static const struct amdgpu_ras_block_hw_ops mca_v3_0_mp0_hw_ops = {
 	.query_ras_error_count = mca_v3_0_mp0_query_ras_error_count,
 	.query_ras_error_address = NULL,
 };
 
 struct amdgpu_mca_ras_block mca_v3_0_mp0_ras = {
 	.ras_block = {
-		.ras_comm = {
-			.block = AMDGPU_RAS_BLOCK__MCA,
-			.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP0,
-			.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
-			.name = "mp0",
-		},
 		.hw_ops = &mca_v3_0_mp0_hw_ops,
 		.ras_block_match = mca_v3_0_ras_block_match,
 	},
@@ -77,19 +71,13 @@ static void mca_v3_0_mp1_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-const struct amdgpu_ras_block_hw_ops mca_v3_0_mp1_hw_ops = {
+static const struct amdgpu_ras_block_hw_ops mca_v3_0_mp1_hw_ops = {
 	.query_ras_error_count = mca_v3_0_mp1_query_ras_error_count,
 	.query_ras_error_address = NULL,
 };
 
 struct amdgpu_mca_ras_block mca_v3_0_mp1_ras = {
 	.ras_block = {
-		.ras_comm = {
-			.block = AMDGPU_RAS_BLOCK__MCA,
-			.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP1,
-			.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
-			.name = "mp1",
-		},
 		.hw_ops = &mca_v3_0_mp1_hw_ops,
 		.ras_block_match = mca_v3_0_ras_block_match,
 	},
@@ -103,40 +91,14 @@ static void mca_v3_0_mpio_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-const struct amdgpu_ras_block_hw_ops mca_v3_0_mpio_hw_ops = {
+static const struct amdgpu_ras_block_hw_ops mca_v3_0_mpio_hw_ops = {
 	.query_ras_error_count = mca_v3_0_mpio_query_ras_error_count,
 	.query_ras_error_address = NULL,
 };
 
 struct amdgpu_mca_ras_block mca_v3_0_mpio_ras = {
 	.ras_block = {
-		.ras_comm = {
-			.block = AMDGPU_RAS_BLOCK__MCA,
-			.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MPIO,
-			.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
-			.name = "mpio",
-		},
 		.hw_ops = &mca_v3_0_mpio_hw_ops,
 		.ras_block_match = mca_v3_0_ras_block_match,
 	},
 };
-
-
-static void mca_v3_0_init(struct amdgpu_device *adev)
-{
-	struct amdgpu_mca *mca = &adev->mca;
-
-	mca->mp0.ras = &mca_v3_0_mp0_ras;
-	mca->mp1.ras = &mca_v3_0_mp1_ras;
-	mca->mpio.ras = &mca_v3_0_mpio_ras;
-	amdgpu_ras_register_ras_block(adev, &mca->mp0.ras->ras_block);
-	amdgpu_ras_register_ras_block(adev, &mca->mp1.ras->ras_block);
-	amdgpu_ras_register_ras_block(adev, &mca->mpio.ras->ras_block);
-	mca->mp0.ras_if = &mca->mp0.ras->ras_block.ras_comm;
-	mca->mp1.ras_if = &mca->mp1.ras->ras_block.ras_comm;
-	mca->mpio.ras_if = &mca->mpio.ras->ras_block.ras_comm;
-}
-
-const struct amdgpu_mca_funcs mca_v3_0_funcs = {
-	.init = mca_v3_0_init,
-};
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.h b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.h
index b899b86194c2..d3eaef0d7f2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.h
@@ -21,6 +21,8 @@
 #ifndef __MCA_V3_0_H__
 #define __MCA_V3_0_H__
 
-extern const struct amdgpu_mca_funcs mca_v3_0_funcs;
+extern struct amdgpu_mca_ras_block mca_v3_0_mp0_ras;
+extern struct amdgpu_mca_ras_block mca_v3_0_mp1_ras;
+extern struct amdgpu_mca_ras_block mca_v3_0_mpio_ras;
 
 #endif
-- 
2.17.1

