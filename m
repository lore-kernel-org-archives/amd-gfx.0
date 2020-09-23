Return-Path: <SRS0=BIvg=DA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E32C2D0A8
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 10:07:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D651E2076E
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 10:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="g44sbvpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D651E2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50FFE6E90F;
	Wed, 23 Sep 2020 10:07:04 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 079EA6E90F
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 10:07:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b25fE/2XUHlDq5gsZz3j0QMYjnkwCmx8VBMim+5cOpkElSbCZaqHb33dU8twjT9WEcxXVrvM9U6MaFIDgiEf4+07CpC8LOjt4e4VxlaWbjEPv2m+Jtmxz1Fu72nRijjj5qR1a9l/7z7hwH8Kzi3fz/vcjSoM5GHo2oHGGnLH4io+Ax8MsWrHXVprKevIwzh85JHG20TQ0gtXbTqRzbK5JAZCypHrSsSotA3gYJhwzDeoMhYc89nriJy5ak2e+e8PbGBsM01mnjYtGxw6P49wVw2l3FKXVIsENWn3a1bur0bx0XwtjUpDhX8gUPoLSwSJbkRXHbDBtyaYNcTij+zogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLedi0eSae0h8uP7bYvsIX+9pRQ6h+twK2YGXy6+9pY=;
 b=Yo+OYxs/D6aPMuiR1bxg1h4Kef2PpRinDYmFaOcClgiyf6a3nyCsrm2VvUV3qwEu7B1jfcxkKP9j13w/gHQrDAgY44LBmgM6SEyJxwcLuhd796WY+M88mDXMxk1GhECeZUBWxlJryeZOkoFQZROHFetgf0QpEkkQ0/2WDxhrELlkaA4v6eYj1df+6pa6vQnr290/69eVQ9xMcl7z3xUL3tr2MgDr0kE1g1seTY4Nx/8c8dEOYtzk0pHHloG3Fv5oEmbQ7tjs+hARQ7F1sxuZ/NFF+t0pqATnoO78PxyhDL2MBofgDcVvYjSvdXUHcpEgKuiO0dSv6HZG59KdwUQfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLedi0eSae0h8uP7bYvsIX+9pRQ6h+twK2YGXy6+9pY=;
 b=g44sbvpxmTFkC8rHk19nqf7QAYdQJVNj2zQYU4eA5wYviGQgGYfOt1BpdXFowLO2PqeqyzBD8DBkSNVMNVKcmEh1NQjc05u3s2wZj5IksKJleDKX8F/F/MI4RJpXRVRRs+IVQR7BcAcmrjGYhcbZIJxMN35NB4xGrcSvBJIz1Bs=
Received: from DM3PR12CA0120.namprd12.prod.outlook.com (2603:10b6:0:51::16) by
 MN2PR12MB3725.namprd12.prod.outlook.com (2603:10b6:208:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Wed, 23 Sep
 2020 10:07:01 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::d0) by DM3PR12CA0120.outlook.office365.com
 (2603:10b6:0:51::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Wed, 23 Sep 2020 10:07:00 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3391.15 via Frontend Transport; Wed, 23 Sep 2020 10:07:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 23 Sep
 2020 05:07:00 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 23 Sep
 2020 05:06:59 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 23 Sep 2020 05:06:59 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV
Date: Wed, 23 Sep 2020 18:06:53 +0800
Message-ID: <20200923100653.740198-2-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200923100653.740198-1-Jingwen.Chen2@amd.com>
References: <20200923100653.740198-1-Jingwen.Chen2@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e17d2c25-7c78-4098-7d26-08d85fa869de
X-MS-TrafficTypeDiagnostic: MN2PR12MB3725:
X-Microsoft-Antispam-PRVS: <MN2PR12MB372502C41AD6D1E7D00C84DCB7380@MN2PR12MB3725.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MfbLadeS9Yy7gh9/fJ/3PYcog9VWuPq4FOfo351h3RuGy7/jJKHzYcpFMi6BQV2a1SkvxaZ1RIe1ao2Z7nFoRn3shPZEl4tUzi/vin+8/AOfXj+PWmyXGTfDgnAz+u0VfZSSBtowBjeXEVON4ez0NM2XLvd9hxKqotuWd8KetxfXR1oofTHkhKCQrVapWe7I6AB58Beg1NBJgmavrsMHrBBbpi2DGg3dtyqiwjCdLF9wrfb8Gm+LhLrWsyiD5/CU4nDGfmZBHv63OOP6oP6OWLqN5WNwGF1M+mEzRJ7MY6DO3AR/zooT8/BRadmewqtPSCvuOyWp9r02v3IeuCZQechyjNG7eOetziQEKKpHJwR5Ukk8Q3jI7VBhnBljBSICKhCfW9r7TqB2+NuZOYoEI9X/k8+a2D5lnMDgruIUuyNHdwSukVh37GQP+2N0wRhK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966005)(83380400001)(36756003)(8676002)(186003)(336012)(5660300002)(6916009)(81166007)(356005)(8936002)(86362001)(426003)(1076003)(4326008)(82310400003)(6666004)(7696005)(82740400003)(478600001)(2906002)(26005)(316002)(47076004)(2616005)(70586007)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 10:07:00.7408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e17d2c25-7c78-4098-7d26-08d85fa869de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3725
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
v3: directly skip psp fw loading in SRIOV
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c              | 10 ++++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c               |  3 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c               |  3 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c               |  3 +++
 .../gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c  | 12 +++++++-----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 11 +++++++----
 6 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 2c66e20b2ed9..18be544d8c1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -161,10 +161,12 @@ static int psp_sw_init(void *handle)
 	struct psp_context *psp = &adev->psp;
 	int ret;
 
-	ret = psp_init_microcode(psp);
-	if (ret) {
-		DRM_ERROR("Failed to load psp firmware!\n");
-		return ret;
+	if (!amdgpu_sriov_vf(adev)) {
+		ret = psp_init_microcode(psp);
+		if (ret) {
+			DRM_ERROR("Failed to load psp firmware!\n");
+			return ret;
+		}
 	}
 
 	ret = psp_memory_training_init(psp);
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
