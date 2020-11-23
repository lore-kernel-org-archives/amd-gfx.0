Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA834C2D0E4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52FE52075A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kt2Es2V0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FE52075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A79A289998;
	Mon, 23 Nov 2020 13:19:36 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700087.outbound.protection.outlook.com [40.107.70.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D3DB89998
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 13:19:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXC46TNEcxBHof5duFMet8N5gwhp0x1Gxpa5CjRVMq0YsLah/hkl4d3ZwE77ILp+eG+4mksSbmnQ4KCFNaNWitNmdGluh/7c+hny8j17UL2kcQgxt3gSrK8soMUxm4cr/AqYNLatdszy08aTFPAMsxKo6Fh8XKvXxvYdI8XmEjBeV1TOztqFUVv4Hb9q2tLrhgZ+cCPYmQSHG4fHMTBx+3MwcKDBKpED9bf15TzOh1oZ3oSRRPkENt54FgLPB4t8Gk8kDYnKLvSXOG+L7jACMe82pag+9Wiaji/XLoS3/h0HWwT7gX5k+HaI01mRVz4x/1qSqopzjWT1/nWpNpUYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxSMsjsazh9uOAb4RTD+C8owJwnPBSCbfYLqSrEKa1w=;
 b=O+8DkaIeQiVwzkzDD88WZsqtn36+DwQqiVqLCIEmkuZV7IdFK5f2rSNQ2oWBIhPYOaeiVUskmhN47iHVbDv2EWU2mmBSEYQrz8t07u+Cs1TfM3cuwd5OdAS8+0fn/46ldSzfN4KMO2n3XBdlt1viQ1JuXuL1dTl2+8K7Pk/4J4S44f1KCylRpjVM9/F3/ijxOBmcmc5S0uftuDshLcwUJXNzDYFfD+7mjXdyw+nlpA2SeAy2PyoUUw3q6zS3pw6Y7ttOSsnP85U1wv8LNsmIg3XD3viQ3m5olO7yRicohUe+lwILn5VC82/arY/E1ls4JNzFOG4XPWBeUm5WwkFBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxSMsjsazh9uOAb4RTD+C8owJwnPBSCbfYLqSrEKa1w=;
 b=kt2Es2V0Zb6H197pngS18rNKdJgxftOlrKGBwt2na1LsWr/VXTltGC1bKEdGidRYU5uNNlGjGP3LolihpSZ8Bt741R1ccD5UfrHNwpvI2X+HkbT7bM8s/bt6KlTpVPdPuJj06pXjtXmlN9cZNSIdFDYip8LBWUD/33I/MkeOuEA=
Received: from MWHPR14CA0051.namprd14.prod.outlook.com (2603:10b6:300:81::13)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Mon, 23 Nov
 2020 13:19:33 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::ca) by MWHPR14CA0051.outlook.office365.com
 (2603:10b6:300:81::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21 via Frontend
 Transport; Mon, 23 Nov 2020 13:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.22 via Frontend Transport; Mon, 23 Nov 2020 13:19:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 23 Nov
 2020 07:19:32 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 23 Nov
 2020 07:19:32 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 23 Nov 2020 07:19:31 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Jingwen.Chen2@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw in SRIOV
 for navi12
Date: Mon, 23 Nov 2020 21:19:29 +0800
Message-ID: <20201123131929.21838-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32680519-7b30-4861-2c0c-08d88fb26ade
X-MS-TrafficTypeDiagnostic: CH2PR12MB4293:
X-Microsoft-Antispam-PRVS: <CH2PR12MB429365357CF8BBA5C4FDF8649AFC0@CH2PR12MB4293.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYa1HvWTiAT466M4g4rQNPg/+pFowX5icFdkrZm0Af/u46kZBf0cGl4l5el/k4UJ2EeA9IU+tk9RMcxKJC7+n1FDRIIXA5BFcvy9n9nCMXN+uHG16Xsc/suIr55DrhDntvEL5CHQENuG1lmGp6fQhsR7MZdMoL+vi1WbsXEZIbenW3ChohU53dHag95eyN2PlTeBQrmNgXUXjkrjqRKGcy8VnnqXKSB6Sy1mEN+d29BImO4tOVMUaKuWs5YYHpV8G++WAs67/q5RLqU1kbmC464aHBb0O5DkGpIMiHIeeLV7ncva/aXQo/QlcOzAak+SLvWKsWO20PuCqO5dXMTi41WJlxsV+JfxVdeMdpljh2uBHXcyNSJC6PrkVRIUxwhu6rO82uTCus/REjryTR6nmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966005)(336012)(186003)(356005)(82310400003)(26005)(81166007)(478600001)(6636002)(7696005)(5660300002)(36756003)(1076003)(86362001)(2616005)(70206006)(47076004)(2906002)(82740400003)(4326008)(70586007)(83380400001)(8936002)(426003)(8676002)(316002)(110136005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 13:19:33.1132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32680519-7b30-4861-2c0c-08d88fb26ade
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
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

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: Id354be93723d7b5d769d73dc67c596af300305af
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                  | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c                  | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                  | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c               | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 16b551f330a4..7e2f063120d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -593,7 +593,7 @@ static int sdma_v4_0_init_microcode(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_NAVI12))
 		return 0;
 
 	DRM_DEBUG("\n");
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
index cb5a6f1437f8..674bc88c3ec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -153,7 +153,7 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_NAVI12))
 		return 0;
 
 	DRM_DEBUG("\n");
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
index daf122f24f23..192149e94f6c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
@@ -208,8 +208,9 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
 	unsigned long tools_size;
 	int ret;
 	struct cgs_firmware_info info = {0};
+	struct amdgpu_device *adev = hwmgr->adev;
 
-	if (!amdgpu_sriov_vf((struct amdgpu_device *)hwmgr->adev)) {
+	if (!amdgpu_sriov_vf(adev) || (adev->asic_type != CHIP_NAVI12)) {
 		ret = cgs_get_firmware_info(hwmgr->device,
 						CGS_UCODE_ID_SMU,
 						&info);
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
