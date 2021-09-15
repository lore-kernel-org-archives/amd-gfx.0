Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DDCC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 19:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F8161108
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 19:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1F8161108
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C6F76EA0B;
	Wed, 15 Sep 2021 19:42:12 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2055.outbound.protection.outlook.com [40.107.96.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 542946EA0B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 19:42:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIoMju4DdQzxWrmosozUCjH+c57p5uW53wCecxAXkBLb34fgrv2e+6hoj0adduRVoBfriJqErQpIiLgVFmCkGU5TZFvAKwwpB6Jm+eakCnFOyeaD/fhZWiogsJI6omwPUKVJhYygIdfhznB1IwDBISHbOi8DOpExfwYl35X+e9vqNLVS5NKHI7Qefh812o09fx20kWIG6P5sygOb9Z4MLcEGvtwc9++r+ACjzWZoIdpGozk0q8STMEkz+Dm1aNW5UmhDLAHkb6vCzJZEMCrW0K5dV3mfRjRWSPZLLSslJqOuDS4FSAq6vaaNR5Bsrg0xSVZhMjAyBI7AFMuKZeEwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=laPGjFA6pJUjr14NDqLdfguG+yEOFl4HDzGIu/zM5QU=;
 b=Msa7NU+UKellEJ44lutEK9AwfVkk1QO6Nw6BouatbyYoQh0J23B/mEM8LxyLP6QgdhHX78a1CuxZmTZRl7QnAALcPEphcOCL8plBRuOV3o5teSNVv4WxPW49RmXpyUgm6jMfvdA3NLUqtu/qzxugl0FyeqEOfh+2fgxZZy2pTETKI239oluWQCd+AItPFGYrjxsB1s7/z4Gp1UleflBdECS5JTkMuTweKWfSkjxWPjIbuB4m7b5OnnVRIVMLubHUl4DC5EXqq9rU9ZZwEqThImsKPzPhHn9aemQMRpGYJoyHFTX0t9Db/Fa5qcYvKAaNjfpDCr+1yvEn7ZhO/UqitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laPGjFA6pJUjr14NDqLdfguG+yEOFl4HDzGIu/zM5QU=;
 b=IPTqWdVU6XCXIXswNepUR9xh0cTvMVSpGwxK2RG/nbPTdWteK3nv2Da3Wu3Uf9VOEtefbB8lcrJEZdBl8r98Cv9YZa2ZcUiiGzuPPSNk+GDeoa9Ju6RwJS/jannPeBC6MNNsCho6TljQzc4yyYTB450qmA5ASUxzkJOE+xoitWM=
Received: from MWHPR21CA0065.namprd21.prod.outlook.com (2603:10b6:300:db::27)
 by PH0PR12MB5449.namprd12.prod.outlook.com (2603:10b6:510:e7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Wed, 15 Sep
 2021 19:42:09 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::bf) by MWHPR21CA0065.outlook.office365.com
 (2603:10b6:300:db::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.0 via Frontend
 Transport; Wed, 15 Sep 2021 19:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 19:42:08 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 14:42:06 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <evan.quan@amd.com>, <xinhui.pan@amd.com>, <alexander.deucher@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH] drm/amdgpu: Fix crash on device remove/driver unload
Date: Wed, 15 Sep 2021 15:41:53 -0400
Message-ID: <20210915194153.455140-1-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b16da04-d885-4c60-467e-08d97880e7b1
X-MS-TrafficTypeDiagnostic: PH0PR12MB5449:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5449B2EBC479D3AD2C678A7FEADB9@PH0PR12MB5449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VlpmKOwhG8xbJeWO+1FlfiHx4Vpakuy5uWuqRvB4riYcIj8cr+PWCp/cn2eE2b6y7GmEzON3gT3mP8gVGxz/Jbnn5qVtbsjirg76X/Uusb99jYJMmQeM0kzW9uI+hFZLWZ32Jor13DUTDO6Mjvy/AIBjKqbaSl7fnJNVHtB3C+WIBKn3xcEFJZVvCS1UBlwibDYnHMNOQrwZAs8ZiUTIUV7mgT3Myq03CEdbuXCCNpuWeAr/f0ZH1O1VVBOyj6lsFNrS5TTUtyTrasRRqp057ngo94sSezGMeuIRnox95UKi7c6f9PPMjdtbeA/ZQKoI6dy2TYz6E6VGFgJRss17JyPtIL8R67adtKFMuZc2JUBYP9saspdeET6kqwBzhO6fnG0R3xm5U8OCPYAUb5Ax2lNo/AUZUrFaJfPQjXsA0zhwVncekicIupiXrYTv0hHolkwvAjMtFaYglKX18laUGy1IKgYHE0z6s0JwBpxmD7zOXnk6TJvx0pVh11RMc2x1epmKbabwT8oGgaOPRFB2rH6eLSfl8ZFvCffB7bVKP/R87Wuwk4DbbmvOE74+qU3VjMx49wgHoF/pvpM4djmF86/7nnaW0F1PUWJDcKPfgr87LZFQHzzWkXdlRxZt6Eh53wuwz6XbF64ws14hYpskP09KBWMQBi+w2+G513aMB6+HvhCgMLahuaFw4DH3O6LfMqLd6RLJpIOe2cQYr58uysO2c43YXzlmNeoA5VFIz/Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(8936002)(2906002)(5660300002)(336012)(426003)(26005)(30864003)(2616005)(186003)(82310400003)(16526019)(36756003)(82740400003)(6666004)(4326008)(47076005)(44832011)(8676002)(6916009)(54906003)(316002)(36860700001)(356005)(83380400001)(86362001)(81166007)(70206006)(70586007)(1076003)(7696005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 19:42:08.6028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b16da04-d885-4c60-467e-08d97880e7b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5449
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

Crash:
BUG: unable to handle page fault for address: 00000000000010e1
RIP: 0010:vega10_power_gate_vce+0x26/0x50 [amdgpu]
Call Trace:
pp_set_powergating_by_smu+0x16a/0x2b0 [amdgpu]
amdgpu_dpm_set_powergating_by_smu+0x92/0xf0 [amdgpu]
amdgpu_dpm_enable_vce+0x2e/0xc0 [amdgpu]
vce_v4_0_hw_fini+0x95/0xa0 [amdgpu]
amdgpu_device_fini_hw+0x232/0x30d [amdgpu]
amdgpu_driver_unload_kms+0x5c/0x80 [amdgpu]
amdgpu_pci_remove+0x27/0x40 [amdgpu]
pci_device_remove+0x3e/0xb0
device_release_driver_internal+0x103/0x1d0
device_release_driver+0x12/0x20
pci_stop_bus_device+0x79/0xa0
pci_stop_and_remove_bus_device_locked+0x1b/0x30
remove_store+0x7b/0x90
dev_attr_store+0x17/0x30
sysfs_kf_write+0x4b/0x60
kernfs_fop_write_iter+0x151/0x1e0

Why:
VCE/UVD had dependency on SMC block for their suspend but
SMC block is the first to do HW fini due to some constraints

How:
Since the original patch was dealing with suspend issues
move the SMC block dependency back into suspend hooks as
was done in V1 of the original patches.
Keep flushing idle work both in suspend and HW fini seuqnces
since it's essential in both cases.

Fixes:
2178d3c189b9 drm/amdgpu: add missing cleanups for more ASICs on UVD/VCE suspend
ee6679aaa61c drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on suspend
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 24 ++++++++-------
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 24 ++++++++-------
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c | 24 ++++++++-------
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 32 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 19 +++++++-----
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 28 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c | 44 ++++++++++++++-------------
 7 files changed, 105 insertions(+), 90 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 7232241e3bfb..0fef925b6602 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -698,6 +698,19 @@ static int uvd_v3_1_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+	if (RREG32(mmUVD_STATUS) != 0)
+		uvd_v3_1_stop(adev);
+
+	return 0;
+}
+
+static int uvd_v3_1_suspend(void *handle)
+{
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
 	/*
 	 * Proper cleanups before halting the HW engine:
 	 *   - cancel the delayed idle work
@@ -722,17 +735,6 @@ static int uvd_v3_1_hw_fini(void *handle)
 						       AMD_CG_STATE_GATE);
 	}
 
-	if (RREG32(mmUVD_STATUS) != 0)
-		uvd_v3_1_stop(adev);
-
-	return 0;
-}
-
-static int uvd_v3_1_suspend(void *handle)
-{
-	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
 	r = uvd_v3_1_hw_fini(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 52d6de969f46..c108b8381795 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -212,6 +212,19 @@ static int uvd_v4_2_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+	if (RREG32(mmUVD_STATUS) != 0)
+		uvd_v4_2_stop(adev);
+
+	return 0;
+}
+
+static int uvd_v4_2_suspend(void *handle)
+{
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
 	/*
 	 * Proper cleanups before halting the HW engine:
 	 *   - cancel the delayed idle work
@@ -236,17 +249,6 @@ static int uvd_v4_2_hw_fini(void *handle)
 						       AMD_CG_STATE_GATE);
 	}
 
-	if (RREG32(mmUVD_STATUS) != 0)
-		uvd_v4_2_stop(adev);
-
-	return 0;
-}
-
-static int uvd_v4_2_suspend(void *handle)
-{
-	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
 	r = uvd_v4_2_hw_fini(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index db6d06758e4d..563493d1f830 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -210,6 +210,19 @@ static int uvd_v5_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+	if (RREG32(mmUVD_STATUS) != 0)
+		uvd_v5_0_stop(adev);
+
+	return 0;
+}
+
+static int uvd_v5_0_suspend(void *handle)
+{
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
 	/*
 	 * Proper cleanups before halting the HW engine:
 	 *   - cancel the delayed idle work
@@ -234,17 +247,6 @@ static int uvd_v5_0_hw_fini(void *handle)
 						       AMD_CG_STATE_GATE);
 	}
 
-	if (RREG32(mmUVD_STATUS) != 0)
-		uvd_v5_0_stop(adev);
-
-	return 0;
-}
-
-static int uvd_v5_0_suspend(void *handle)
-{
-	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
 	r = uvd_v5_0_hw_fini(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index b6e82d75561f..1fd9ca21a091 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -606,6 +606,23 @@ static int uvd_v7_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+	if (!amdgpu_sriov_vf(adev))
+		uvd_v7_0_stop(adev);
+	else {
+		/* full access mode, so don't touch any UVD register */
+		DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
+	}
+
+	return 0;
+}
+
+static int uvd_v7_0_suspend(void *handle)
+{
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
 	/*
 	 * Proper cleanups before halting the HW engine:
 	 *   - cancel the delayed idle work
@@ -630,21 +647,6 @@ static int uvd_v7_0_hw_fini(void *handle)
 						       AMD_CG_STATE_GATE);
 	}
 
-	if (!amdgpu_sriov_vf(adev))
-		uvd_v7_0_stop(adev);
-	else {
-		/* full access mode, so don't touch any UVD register */
-		DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
-	}
-
-	return 0;
-}
-
-static int uvd_v7_0_suspend(void *handle)
-{
-	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
 	r = uvd_v7_0_hw_fini(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index 84e488f189f5..67eb01fef789 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -481,6 +481,17 @@ static int vce_v2_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+
+	return 0;
+}
+
+static int vce_v2_0_suspend(void *handle)
+{
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+
 	/*
 	 * Proper cleanups before halting the HW engine:
 	 *   - cancel the delayed idle work
@@ -504,14 +515,6 @@ static int vce_v2_0_hw_fini(void *handle)
 						       AMD_CG_STATE_GATE);
 	}
 
-	return 0;
-}
-
-static int vce_v2_0_suspend(void *handle)
-{
-	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
 	r = vce_v2_0_hw_fini(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 2a18c1e089fd..142e291983b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -492,6 +492,21 @@ static int vce_v3_0_hw_fini(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+
+	r = vce_v3_0_wait_for_idle(handle);
+	if (r)
+		return r;
+
+	vce_v3_0_stop(adev);
+	return vce_v3_0_set_clockgating_state(adev, AMD_CG_STATE_GATE);
+}
+
+static int vce_v3_0_suspend(void *handle)
+{
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
 	/*
 	 * Proper cleanups before halting the HW engine:
 	 *   - cancel the delayed idle work
@@ -515,19 +530,6 @@ static int vce_v3_0_hw_fini(void *handle)
 						       AMD_CG_STATE_GATE);
 	}
 
-	r = vce_v3_0_wait_for_idle(handle);
-	if (r)
-		return r;
-
-	vce_v3_0_stop(adev);
-	return vce_v3_0_set_clockgating_state(adev, AMD_CG_STATE_GATE);
-}
-
-static int vce_v3_0_suspend(void *handle)
-{
-	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
 	r = vce_v3_0_hw_fini(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 044cf9d74b85..226b79254db8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -544,29 +544,8 @@ static int vce_v4_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	/*
-	 * Proper cleanups before halting the HW engine:
-	 *   - cancel the delayed idle work
-	 *   - enable powergating
-	 *   - enable clockgating
-	 *   - disable dpm
-	 *
-	 * TODO: to align with the VCN implementation, move the
-	 * jobs for clockgating/powergating/dpm setting to
-	 * ->set_powergating_state().
-	 */
 	cancel_delayed_work_sync(&adev->vce.idle_work);
 
-	if (adev->pm.dpm_enabled) {
-		amdgpu_dpm_enable_vce(adev, false);
-	} else {
-		amdgpu_asic_set_vce_clocks(adev, 0, 0);
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
-		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_CG_STATE_GATE);
-	}
-
 	if (!amdgpu_sriov_vf(adev)) {
 		/* vce_v4_0_wait_for_idle(handle); */
 		vce_v4_0_stop(adev);
@@ -596,6 +575,29 @@ static int vce_v4_0_suspend(void *handle)
 		drm_dev_exit(idx);
 	}
 
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_vce(adev, false);
+	} else {
+		amdgpu_asic_set_vce_clocks(adev, 0, 0);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_CG_STATE_GATE);
+	}
+
 	r = vce_v4_0_hw_fini(adev);
 	if (r)
 		return r;
-- 
2.25.1

