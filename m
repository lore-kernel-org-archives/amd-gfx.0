Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A85FC4363D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 07:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD82923A1E
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 07:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ggw9mrCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD82923A1E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 530AD6E0BC;
	Tue, 22 Sep 2020 07:09:29 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7F476E0BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 07:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOCTU+fIJrCHS48be8D+jzk6n2y2c0POJxBAH71FGg4hb4fXKDruX7wMa5Ek08ybM0JjgttG5lSLWKj5yS/lzM89+hoK8aw5jTuUe0oKMtmWcjtih6JwkwrXjfZa/yMLzvvy6AbdqYHhOLFHpgK13i3/ASi2QfQd4IgPLzOH04Am4eWOzymG1Hr50+vaCrHO1gn5Wt8wAIiOikCmb/m6Icbc87Qlmkz949mOM9xoSr/4DRWAM9tZWANyq8ohED9pdED8bFqXMJGDNPp1HoiV5PYRQagHuCu3it3nGMGUUBPJPQASxK93uoSSbjX5xGG7xn+TXTFZ38Dm51TPdA5adg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxL3AjgwygwoIgY00CO55aOW5MvOoJOJEtiRXGSZS9c=;
 b=V0+8/NW/R4zJW88MMIgRQpXYB12txQrULOLv2sSaFF+0t0s3Jmu7C5YSQzeN+/Rz6uANqIQ79zXTUYkW7259fmOd1SPKsm1eajWlopkIOURV47vNFYCTPOFfU9JqRyrKkGTFAXxI1WR1b1bAR+RrHJvXUIQmqT5gslw05Uyw9ykgEx/ua/C8I3U6cqnLgAYXITM2bW30Qf1/HsB8JtWany6YH43IkYR+94qbXCGCP5flKtRmMnJQ5MTma1ARmRw6tL8j1bGdZSofCTkf4OXRa72a0xjmbua9uJ0WLcf0BzCqsHjaXN+WmhN2rOKgR/1a4X0EoOT6ulL2y3uRTradFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxL3AjgwygwoIgY00CO55aOW5MvOoJOJEtiRXGSZS9c=;
 b=Ggw9mrCu13NxWv+fW/NvlqY/AYGit4VnIOwfonfPqtSIZqOlluMV7gPfsuUbe9FvuzaGPIFtnKWcm8lE2KGyQ4O5GcV7dYQfO+vzI3LMrOPVAy7eOSwzwsjnDmjzSL70wRHACQh76rMQPI7NLQrBdi6tqEyR8WdhRAzPDBqq2dQ=
Received: from BN6PR06CA0020.namprd06.prod.outlook.com (2603:10b6:404:10b::30)
 by MN2PR12MB3101.namprd12.prod.outlook.com (2603:10b6:208:c4::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 22 Sep
 2020 07:09:23 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10b:cafe::be) by BN6PR06CA0020.outlook.office365.com
 (2603:10b6:404:10b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Tue, 22 Sep 2020 07:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3391.15 via Frontend Transport; Tue, 22 Sep 2020 07:09:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 22 Sep
 2020 02:09:21 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 22 Sep
 2020 02:09:21 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 22 Sep 2020 02:09:20 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV
Date: Tue, 22 Sep 2020 15:08:44 +0800
Message-ID: <20200922070842.366545-2-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922070842.366545-1-Jingwen.Chen2@amd.com>
References: <20200922070842.366545-1-Jingwen.Chen2@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a45df259-a332-4285-5111-08d85ec66ee9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3101:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3101DB4DD68746D8D758C8B1B73B0@MN2PR12MB3101.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kd/w4enuvjLqSxiNUeKdUdXzjNVeNW0JsX2no4GG//sbTV1ubKAw5zysXnJ62rfN6e9NT39j7GqTB4Uuf+G4JyX5JRhAZLSto7YlrUn7xNHsLC7iNBLHlO5BdEp8piyyLPXlEbRj+7dWDwEMhCXx1Vd8QK9IY9D5eqGrEMGv3FE3GK8vuN4QrCvbxZaYhD8Y2j0lPWGmE1XBYnzSvuquLyRZrOzAROiVv2o7kIM0JkTVBsCJBttEMRzktQRbKcfnOZzmozWGL75VFZE19RFwptvOxJFmDRo4MYHtrQOwHFpO2jmhRMKhB95fFt3Xsgr6QhDjswlDmAg7cr49LdcYveiS2hENHIo5mLG7bFRk9beYkO1oYefA00qhng31FB3jSMogYG5japDwlCQ5NfN7+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966005)(47076004)(36756003)(5660300002)(4326008)(356005)(316002)(81166007)(426003)(186003)(83380400001)(86362001)(2906002)(70206006)(82310400003)(70586007)(478600001)(8936002)(82740400003)(1076003)(7696005)(336012)(8676002)(6666004)(26005)(2616005)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 07:09:22.9815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a45df259-a332-4285-5111-08d85ec66ee9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3101
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

smc, sdma, sos, ta and asd fw is not used in SRIOV. Skip them to
accelerate sw_init for navi12.

v2: skip above fw in SRIOV for vega10 and sienna_cichlid
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c              |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c               |  3 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c               |  3 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c               |  3 +++
 .../gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c  | 12 +++++++-----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 11 +++++++----
 6 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 2c66e20b2ed9..9e2038de6ea7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2385,6 +2385,9 @@ int psp_init_asd_microcode(struct psp_context *psp,
 	const struct psp_firmware_header_v1_0 *asd_hdr;
 	int err = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	if (!chip_name) {
 		dev_err(adev->dev, "invalid chip name for asd microcode\n");
 		return -EINVAL;
@@ -2424,6 +2427,9 @@ int psp_init_sos_microcode(struct psp_context *psp,
 	const struct psp_firmware_header_v1_3 *sos_hdr_v1_3;
 	int err = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	if (!chip_name) {
 		dev_err(adev->dev, "invalid chip name for sos microcode\n");
 		return -EINVAL;
@@ -2558,6 +2564,9 @@ int psp_init_ta_microcode(struct psp_context *psp,
 	int err = 0;
 	int ta_index = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	if (!chip_name) {
 		dev_err(adev->dev, "invalid chip name for ta microcode\n");
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 810635cbf4c1..86fb1eddf5a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -592,6 +592,9 @@ static int sdma_v4_0_init_microcode(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	DRM_DEBUG("\n");
 
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 48c95a78a173..9c72b95b7463 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -203,6 +203,9 @@ static int sdma_v5_0_init_microcode(struct amdgpu_device *adev)
 	const struct common_firmware_header *header = NULL;
 	const struct sdma_firmware_header_v1_0 *hdr;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	DRM_DEBUG("\n");
 
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 34ccf376ee45..9f3952723c63 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -148,6 +148,9 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	DRM_DEBUG("\n");
 
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
index 1e222c5d91a4..daf122f24f23 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
@@ -209,11 +209,13 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
 	int ret;
 	struct cgs_firmware_info info = {0};
 
-	ret = cgs_get_firmware_info(hwmgr->device,
-				    CGS_UCODE_ID_SMU,
-				    &info);
-	if (ret || !info.kptr)
-		return -EINVAL;
+	if (!amdgpu_sriov_vf((struct amdgpu_device *)hwmgr->adev)) {
+		ret = cgs_get_firmware_info(hwmgr->device,
+						CGS_UCODE_ID_SMU,
+						&info);
+		if (ret || !info.kptr)
+			return -EINVAL;
+	}
 
 	priv = kzalloc(sizeof(struct vega10_smumgr), GFP_KERNEL);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 538e6f5e19eb..3010cb31324a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -832,10 +832,13 @@ static int smu_sw_init(void *handle)
 
 	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
 	smu->smu_dpm.requested_dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
-	ret = smu_init_microcode(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to load smu firmware!\n");
-		return ret;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		ret = smu_init_microcode(smu);
+		if (ret) {
+			dev_err(adev->dev, "Failed to load smu firmware!\n");
+			return ret;
+		}
 	}
 
 	ret = smu_smc_table_sw_init(smu);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
