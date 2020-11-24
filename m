Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF03CC56202
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 09:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 513ED20684
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 09:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a/7EG5Jr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513ED20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1FD16E218;
	Tue, 24 Nov 2020 09:49:11 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750082.outbound.protection.outlook.com [40.107.75.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08B326E218
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 09:49:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P81spi/j1KWDSa8uIDzlZKN/3u32IwTXSNryvM/oc7tGlTrhwWSUtC21RryQW7SCKuxMZnqew8BcBnH4v500SVk2YcXEC221uhawm3UHPSRsH7y25SU+NPp82sLKHl53EI6swZsPRmmYWQmcU8+bn00fYEbvs4uxprSsJWgMoiyRXazBI+gAj9O3l9zakb009Bmuw8/lN0b8y8aDskzjc9fCP7OHUct8cGOv+cV/dOMc7NJpdzYborbWbH3C2zG3ZlnybDOYgiGPOIbXFlMMmGIWc20pfehHNHwmU5O4E+EOLb6MKp/D23ZjqatjF85+k73pUvXxYSjvi01uUqOK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0n8hWfS5cd92Oc/awTrpe6AYM+XWCMq4g7ddzSzcZeY=;
 b=TOSGhc0qyURefg0fIUaUXK55yWXbXh+qm1FHAkCY7aUFalZ3FqtcEYk4vVL8ic6Tl8wXIEYhbbTClQ7cLtwWNuWlGeBT7t9xsnWOm4N3Mz8od0a0K6Z1VH3sM/hpC9hXunzAqQcrgUWz9rivIiR85fm1i/gsMw3vH/KQBppgm9iiFkfnLchDGe7wx3vs/hcdViNc02VwaFIqKfhU+1LrkLqX4dKOc5ojosGJv4g7AMJFbsRtgPCZ24GA7Xcvt1KZ31eSG45RJ/czVzX5vUKDq36jsWNTuWh11GcoBM38dqGLf8Uu8yFFqlHOwmJmp/DEXfZak9UT2GJvSlEOVMjW8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0n8hWfS5cd92Oc/awTrpe6AYM+XWCMq4g7ddzSzcZeY=;
 b=a/7EG5Jrste/vfdKXj33TpzuB06dnsEezSQoYH9AxEu66Whzt38SZKrNOHlCz8nUc42feL6jSudp9QUAzyR5oQuv9nte6+dlyKxf+JUJL5OnDd9y/fSyLOeCuU0c+dB2C5FKfk8NJOwcTnVRBlL5PILbdm9W9jZ3s2OgSisMeXo=
Received: from BN9PR03CA0033.namprd03.prod.outlook.com (2603:10b6:408:fb::8)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Tue, 24 Nov
 2020 09:49:09 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::d5) by BN9PR03CA0033.outlook.office365.com
 (2603:10b6:408:fb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30 via Frontend
 Transport; Tue, 24 Nov 2020 09:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.22 via Frontend Transport; Tue, 24 Nov 2020 09:49:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 24 Nov
 2020 03:49:07 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 24 Nov
 2020 03:49:07 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 24 Nov 2020 03:49:06 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Jingwen.Chen2@amd.com>
Subject: [PATCH V2 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw in
 SRIOV for navi12
Date: Tue, 24 Nov 2020 17:49:05 +0800
Message-ID: <20201124094905.25255-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92079dfa-e1ea-4ef5-683b-08d8905e303c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4308:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4308FC7495BCEF8463DC1C0F9AFB0@BY5PR12MB4308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NzmVeLq3C4lSg778LwSkJyc8fGjkyqGSFrvn26batRguoI4tXIzwM5Fuvwf9A3Uqr1eXmS6Gi5NocA/eQUx+UlHKKqrKY1sMEAba2v6RajE1MCYaeLyJJlNmpz187ZOGNRfpU5mbLWnZQeR4nJlhtfg0SpTftN+sjudnMpfFQtAzDOtbr49nTdGRlnetVHMHz4xvNLJYzeSoqEIFTt0QnB9iexC0G4Y5fDKE0qh1KU5ReH4yyqMkjR+GQuAnymUKKFOBIpEgtfaKAQ//JKCO0hb7Wo5z5H3JGSo8L0vajyiLEPZU9Bn374e97yL34wwGF+cj0ftJobxSjIdWPNfe7aAEBUZ6BD+DJR+NznISIXow/f0CQSvjuAgkYoN8lsEBV/bjuF7wlVwHvhTEMb9mSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966005)(2906002)(6636002)(81166007)(86362001)(70206006)(356005)(82740400003)(70586007)(8676002)(36756003)(47076004)(478600001)(82310400003)(1076003)(110136005)(426003)(83380400001)(2616005)(336012)(5660300002)(8936002)(26005)(186003)(4326008)(7696005)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 09:49:08.3076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92079dfa-e1ea-4ef5-683b-08d8905e303c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The KFDTopologyTest.BasicTest will failed if skip smc, sdma, sos, ta
and asd fw in SRIOV for vega10, so adjust above fw and skip load them
in SRIOV only for navi12.

v2: remove unnecessary asic type check.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c              |  3 ---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c              |  3 ---
 .../gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c | 13 ++++++-------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c           |  2 +-
 5 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 16b551f330a4..8309dd95aa48 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -593,9 +593,6 @@ static int sdma_v4_0_init_microcode(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	DRM_DEBUG("\n");
 
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 9c72b95b7463..fad1cc394219 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -203,7 +203,7 @@ static int sdma_v5_0_init_microcode(struct amdgpu_device *adev)
 	const struct common_firmware_header *header = NULL;
 	const struct sdma_firmware_header_v1_0 *hdr;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_NAVI12))
 		return 0;
 
 	DRM_DEBUG("\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index cb5a6f1437f8..5ea11a0f568f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -153,9 +153,6 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	DRM_DEBUG("\n");
 
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
index daf122f24f23..e2192d8762a4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
@@ -208,14 +208,13 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
 	unsigned long tools_size;
 	int ret;
 	struct cgs_firmware_info info = {0};
+	struct amdgpu_device *adev = hwmgr->adev;
 
-	if (!amdgpu_sriov_vf((struct amdgpu_device *)hwmgr->adev)) {
-		ret = cgs_get_firmware_info(hwmgr->device,
-						CGS_UCODE_ID_SMU,
-						&info);
-		if (ret || !info.kptr)
-			return -EINVAL;
-	}
+	ret = cgs_get_firmware_info(hwmgr->device,
+					CGS_UCODE_ID_SMU,
+					&info);
+	if (ret || !info.kptr)
+		return -EINVAL;
 
 	priv = kzalloc(sizeof(struct vega10_smumgr), GFP_KERNEL);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1904df5a3e20..80c0bfaed097 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -847,7 +847,7 @@ static int smu_sw_init(void *handle)
 	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
 	smu->smu_dpm.requested_dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
 
-	if (!amdgpu_sriov_vf(adev)) {
+	if (!amdgpu_sriov_vf(adev) || (adev->asic_type != CHIP_NAVI12)) {
 		ret = smu_init_microcode(smu);
 		if (ret) {
 			dev_err(adev->dev, "Failed to load smu firmware!\n");
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
