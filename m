Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F126C33C99
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 02:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7B72081E
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 02:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L6VkV2RJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7B72081E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8FA76E15F;
	Wed,  8 Jan 2020 02:04:04 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770078.outbound.protection.outlook.com [40.107.77.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ADEF6E15F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 02:04:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yl7xQIQR9fRunMKs6T9YhbEdPUpgER4xQHLi1wTDQNSfRsb++++hpGoRK3m2Y4bObE1Fqpyb9kZpGbUpj0QYt9o+xvx7lBJGMkM5dDdWfqEjJSWjn3zxgPrsRD79/QBpYvu1pgXudw1FMelF2I0WDNPiIz5BYySjoVHJpTKfJUmCrWYi+sj+DoFqpI5/lLRqGl69jeKSZfDTsM2q1ItPyNrw6mtlCbMeEe/tTgiU8PGbliDfbkkFh+QLP6SzSkEbAs+4Z5JKBg61f85n68fOiYUMVtL8aEMGdlMvPYjffiA1j8b29513b/oC0oM+SGTUI61XAAfFeRmeV2L/i7uklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCg2lmqz/gHiNH78yuwAACRXLp0kPSPnMGKi9uGrtj4=;
 b=M/nMo5NQSOcyiMs8MRvs0dzT82qOz9rlMsbhpS5hxRRL1ThngLGju/+gvkyxTEohiPTuBBkvRMPUj8Kw6z9DWIdZp6h/KhDYZuOKFR9oCYECyq2PZuOQJCV5YJva2sN9upCaI+Sy6LI1LFrBwd8DjhyIbjbG2Q6DOvw6D8cQEJ+niV88w37tN120jr5TOVJHOJBGJNuACprS2GRWBCbzQJJoE2/5SbJfrlegRyELuFhCkl189FmF0XAWapPgn0DECqQN3ypYOgQJA/tXaO6vYtu2+co35CpUWbWTJSkoCaf4AmhYnAFKx5sqj/VV2rU1BsEMwGML62UMenv1Ke03yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCg2lmqz/gHiNH78yuwAACRXLp0kPSPnMGKi9uGrtj4=;
 b=L6VkV2RJ/5yNjP3lyohCxFgzdyJfNxRtYrKxpaoP/zJz5Q+nU3nTBg0b2U1IfAIpfTOXaBdg/tW4f1VbXy7u5mHQL9fPFr5YYaYIK323Z/BkfERq3sUKb4CycSH1nYjUNVRmli2e3v3t7n2oUYQK0i1U07rSbyq916iFIun+Rxc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3150.namprd12.prod.outlook.com (20.178.241.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Wed, 8 Jan 2020 02:04:00 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2602.016; Wed, 8 Jan 2020
 02:04:00 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: cover the powerplay implementation details
 V2
Date: Wed,  8 Jan 2020 10:03:39 +0800
Message-Id: <20200108020339.12934-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.1
X-ClientProxiedBy: HK2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:202:2e::31) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR06CA0019.apcprd06.prod.outlook.com (2603:1096:202:2e::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 02:03:58 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d7d1c47d-84c3-4549-f4f6-08d793df06e9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3150:|MN2PR12MB3150:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3150B45BEA55ECA32888B3EBE43E0@MN2PR12MB3150.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 02760F0D1C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(199004)(189003)(478600001)(7696005)(8936002)(26005)(66946007)(2906002)(66476007)(52116002)(81156014)(54906003)(81166006)(8676002)(186003)(4326008)(16526019)(30864003)(66556008)(2616005)(6486002)(316002)(956004)(6916009)(6666004)(5660300002)(1076003)(86362001)(36756003)(44832011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3150;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gLkoY3+9T9Ny86WXC7axnxyjeYWqtaIU1LYqGIVplYXBLbLGjOknQ90we85tMUYvvvPjJMruyLweBZikoRuzKig5arSyjIwr+vv07qz1Y2RxqEcsPlfILLgV4QLO/KQX1fZE9JT6M4eZiQey6y3RFm4+ko+vZOzG2wQnYzXMgBE3xULq8StblWZ++3iIw1USazkoe5MeEonFOhutg20jb/7q6LwJ77UpQM3MFa4LiDuTBOBvp5q2zRH1N6IErWKmOav1iZqH0HEQS7awpHsKmYXSNQ1DZc8LHZA7lES1JIt2ieUAAgNeK66C8WXEeZSLYJz2vWOsSrazkaNK2N2gVMfLEUhVmiiETI0q/UcW21tgAbOtBtRXZah/3w5je2l2vBSObHyYoymjd0Ucrsxu9D+wQXAmrzWk/iFRUsyDtJEh6n/rcc68np2dJ4+lWTCm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d1c47d-84c3-4549-f4f6-08d793df06e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 02:04:00.8285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NW8nBjpWC4Gi0qN9Q3agmRtbe9GAqpTq81h9v4hfJe/hORLLh5LTByyKA//FIend
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3150
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This can save users much troubles. As they do not
actually need to care whether swSMU or traditional
powerplay routine should be used.

V2: apply the fixes to vi.c and cik.c also

Change-Id: I827fe4cac0d4fd487782168a7fe73e15756a7109
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  53 +------
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c    | 159 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h    |  24 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |   6 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/cik.c           |  12 +-
 drivers/gpu/drm/amd/amdgpu/cik.h           |   2 -
 drivers/gpu/drm/amd/amdgpu/nv.c            |   8 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  85 ++---------
 drivers/gpu/drm/amd/amdgpu/vi.c            |  48 +------
 drivers/gpu/drm/amd/amdgpu/vi.h            |   2 -
 12 files changed, 211 insertions(+), 208 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index d3da9dde4ee1..88e10b956413 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -613,15 +613,9 @@ void amdgpu_amdkfd_set_compute_idle(struct kgd_dev *kgd, bool idle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 
-	if (is_support_sw_smu(adev))
-		smu_switch_power_profile(&adev->smu,
-					 PP_SMC_POWER_PROFILE_COMPUTE,
-					 !idle);
-	else if (adev->powerplay.pp_funcs &&
-		 adev->powerplay.pp_funcs->switch_power_profile)
-		amdgpu_dpm_switch_power_profile(adev,
-						PP_SMC_POWER_PROFILE_COMPUTE,
-						!idle);
+	amdgpu_dpm_switch_power_profile(adev,
+					PP_SMC_POWER_PROFILE_COMPUTE,
+					!idle);
 }
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 09271127dfe1..bf892143e1d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2351,14 +2351,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.hw = false;
 		/* handle putting the SMC in the appropriate state */
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
-			if (is_support_sw_smu(adev)) {
-				r = smu_set_mp1_state(&adev->smu, adev->mp1_state);
-			} else if (adev->powerplay.pp_funcs &&
-					   adev->powerplay.pp_funcs->set_mp1_state) {
-				r = adev->powerplay.pp_funcs->set_mp1_state(
-					adev->powerplay.pp_handle,
-					adev->mp1_state);
-			}
+			r = amdgpu_dpm_set_mp1_state(adev, adev->mp1_state);
 			if (r) {
 				DRM_ERROR("SMC failed to set mp1 state %d, %d\n",
 					  adev->mp1_state, r);
@@ -4365,55 +4358,21 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
 	if (ras && ras->supported)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, false);
 
-	if (is_support_sw_smu(adev)) {
-		struct smu_context *smu = &adev->smu;
-		int ret;
-
-		ret = smu_baco_enter(smu);
-		if (ret)
-			return ret;
-	} else {
-		void *pp_handle = adev->powerplay.pp_handle;
-		const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-
-		if (!pp_funcs ||!pp_funcs->get_asic_baco_state ||!pp_funcs->set_asic_baco_state)
-			return -ENOENT;
-
-		/* enter BACO state */
-		if (pp_funcs->set_asic_baco_state(pp_handle, 1))
-			return -EIO;
-	}
-
-	return 0;
+	return amdgpu_dpm_baco_enter(adev);
 }
 
 int amdgpu_device_baco_exit(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	int ret = 0;
 
 	if (!amdgpu_device_supports_baco(adev->ddev))
 		return -ENOTSUPP;
 
-	if (is_support_sw_smu(adev)) {
-		struct smu_context *smu = &adev->smu;
-		int ret;
-
-		ret = smu_baco_exit(smu);
-		if (ret)
-			return ret;
-
-	} else {
-		void *pp_handle = adev->powerplay.pp_handle;
-		const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-
-		if (!pp_funcs ||!pp_funcs->get_asic_baco_state ||!pp_funcs->set_asic_baco_state)
-			return -ENOENT;
-
-		/* exit BACO state */
-		if (pp_funcs->set_asic_baco_state(pp_handle, 0))
-			return -EIO;
-	}
+	ret = amdgpu_dpm_baco_exit(adev);
+	if (ret)
+		return ret;
 
 	if (ras && ras->supported)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
index cd76fbf4385d..f7c0ae6e0f8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
@@ -983,3 +983,162 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 
 	return ret;
 }
+
+int amdgpu_dpm_baco_enter(struct amdgpu_device *adev)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	void *pp_handle = adev->powerplay.pp_handle;
+	struct smu_context *smu = &adev->smu;
+	int ret = 0;
+
+	if (is_support_sw_smu(adev)) {
+		ret = smu_baco_enter(smu);
+	} else {
+		if (!pp_funcs || !pp_funcs->set_asic_baco_state)
+			return -ENOENT;
+
+		/* enter BACO state */
+		ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
+	}
+
+	return ret;
+}
+
+int amdgpu_dpm_baco_exit(struct amdgpu_device *adev)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	void *pp_handle = adev->powerplay.pp_handle;
+	struct smu_context *smu = &adev->smu;
+	int ret = 0;
+
+	if (is_support_sw_smu(adev)) {
+		ret = smu_baco_exit(smu);
+	} else {
+		if (!pp_funcs || !pp_funcs->set_asic_baco_state)
+			return -ENOENT;
+
+		/* exit BACO state */
+		ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
+	}
+
+	return ret;
+}
+
+int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
+			     enum pp_mp1_state mp1_state)
+{
+	int ret = 0;
+
+	if (is_support_sw_smu(adev)) {
+		ret = smu_set_mp1_state(&adev->smu, mp1_state);
+	} else if (adev->powerplay.pp_funcs &&
+		   adev->powerplay.pp_funcs->set_mp1_state) {
+		ret = adev->powerplay.pp_funcs->set_mp1_state(
+				adev->powerplay.pp_handle,
+				mp1_state);
+	}
+
+	return ret;
+}
+
+bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	void *pp_handle = adev->powerplay.pp_handle;
+	struct smu_context *smu = &adev->smu;
+	bool baco_cap;
+
+	if (is_support_sw_smu(adev)) {
+		return smu_baco_is_support(smu);
+	} else {
+		if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
+			return false;
+
+		if (pp_funcs->get_asic_baco_capability(pp_handle, &baco_cap))
+			return false;
+
+		return baco_cap ? true : false;
+	}
+}
+
+int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	void *pp_handle = adev->powerplay.pp_handle;
+	struct smu_context *smu = &adev->smu;
+
+	if (is_support_sw_smu(adev)) {
+		return smu_mode2_reset(smu);
+	} else {
+		if (!pp_funcs || !pp_funcs->asic_reset_mode_2)
+			return -ENOENT;
+
+		return pp_funcs->asic_reset_mode_2(pp_handle);
+	}
+}
+
+int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	void *pp_handle = adev->powerplay.pp_handle;
+	struct smu_context *smu = &adev->smu;
+	int ret = 0;
+
+	dev_info(adev->dev, "GPU BACO reset\n");
+
+	if (is_support_sw_smu(adev)) {
+		ret = smu_baco_enter(smu);
+		if (ret)
+			return ret;
+
+		ret = smu_baco_exit(smu);
+		if (ret)
+			return ret;
+	} else {
+		if (!pp_funcs
+		    || !pp_funcs->set_asic_baco_state)
+			return -ENOENT;
+
+		/* enter BACO state */
+		ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
+		if (ret)
+			return ret;
+
+		/* exit BACO state */
+		ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
+				    enum PP_SMC_POWER_PROFILE type,
+				    bool en)
+{
+	int ret = 0;
+
+	if (is_support_sw_smu(adev))
+		ret = smu_switch_power_profile(&adev->smu, type, en);
+	else if (adev->powerplay.pp_funcs &&
+		 adev->powerplay.pp_funcs->switch_power_profile)
+		ret = adev->powerplay.pp_funcs->switch_power_profile(adev, type, en);
+
+	return ret;
+}
+
+int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
+			       uint32_t pstate)
+{
+	int ret = 0;
+
+	if (is_support_sw_smu_xgmi(adev))
+		ret = smu_set_xgmi_pstate(&adev->smu, pstate);
+	else if (adev->powerplay.pp_funcs &&
+		 adev->powerplay.pp_funcs->set_xgmi_pstate)
+		ret = adev->powerplay.pp_funcs->set_xgmi_pstate(adev->powerplay.pp_handle,
+								pstate);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
index 2cfb677272af..902ca6c00cca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
@@ -341,10 +341,6 @@ enum amdgpu_pcie_gen {
 		((adev)->powerplay.pp_funcs->reset_power_profile_state(\
 			(adev)->powerplay.pp_handle, request))
 
-#define amdgpu_dpm_switch_power_profile(adev, type, en) \
-		((adev)->powerplay.pp_funcs->switch_power_profile(\
-			(adev)->powerplay.pp_handle, type, en))
-
 #define amdgpu_dpm_set_clockgating_by_smu(adev, msg_id) \
 		((adev)->powerplay.pp_funcs->set_clockgating_by_smu(\
 			(adev)->powerplay.pp_handle, msg_id))
@@ -517,4 +513,24 @@ extern int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low);
 
 extern int amdgpu_dpm_get_mclk(struct amdgpu_device *adev, bool low);
 
+int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
+			       uint32_t pstate);
+
+int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
+				    enum PP_SMC_POWER_PROFILE type,
+				    bool en);
+
+int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
+
+int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);
+
+bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev);
+
+int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
+			     enum pp_mp1_state mp1_state);
+
+int amdgpu_dpm_baco_exit(struct amdgpu_device *adev);
+
+int amdgpu_dpm_baco_enter(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index db7b2b3f9966..b88b8b82bb64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -543,12 +543,6 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 	if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 		return;
 
-	if (!is_support_sw_smu(adev) &&
-	    (!adev->powerplay.pp_funcs ||
-	     !adev->powerplay.pp_funcs->set_powergating_by_smu))
-		return;
-
-
 	mutex_lock(&adev->gfx.gfx_off_mutex);
 
 	if (!enable)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 5cf920d9358b..c626f3e59ff9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -291,13 +291,7 @@ int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate)
 
 	dev_dbg(adev->dev, "Set xgmi pstate %d.\n", pstate);
 
-	if (is_support_sw_smu_xgmi(adev))
-		ret = smu_set_xgmi_pstate(&adev->smu, pstate);
-	else if (adev->powerplay.pp_funcs &&
-		 adev->powerplay.pp_funcs->set_xgmi_pstate)
-		ret = adev->powerplay.pp_funcs->set_xgmi_pstate(adev->powerplay.pp_handle,
-								pstate);
-
+	ret = amdgpu_dpm_set_xgmi_pstate(adev, pstate);
 	if (ret) {
 		dev_err(adev->dev,
 			"XGMI: Set pstate failure on device %llx, hive %llx, ret %d",
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 1dfe4a1337cf..fa7756e77777 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1312,19 +1312,13 @@ static int cik_asic_pci_config_reset(struct amdgpu_device *adev)
 
 static bool cik_asic_supports_baco(struct amdgpu_device *adev)
 {
-	bool baco_support;
-
 	switch (adev->asic_type) {
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
-		smu7_asic_get_baco_capability(adev, &baco_support);
-		break;
+		return amdgpu_dpm_is_baco_supported(adev);
 	default:
-		baco_support = false;
-		break;
+		return false;
 	}
-
-	return baco_support;
 }
 
 static enum amd_reset_method
@@ -1366,7 +1360,7 @@ static int cik_asic_reset(struct amdgpu_device *adev)
 	if (cik_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
 		if (!adev->in_suspend)
 			amdgpu_inc_vram_lost(adev);
-		r = smu7_asic_baco_reset(adev);
+		r = amdgpu_dpm_baco_reset(adev);
 	} else {
 		r = cik_asic_pci_config_reset(adev);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.h b/drivers/gpu/drm/amd/amdgpu/cik.h
index 9870bf27870e..f91ab4c246b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.h
+++ b/drivers/gpu/drm/amd/amdgpu/cik.h
@@ -31,7 +31,5 @@ void cik_srbm_select(struct amdgpu_device *adev,
 int cik_set_ip_blocks(struct amdgpu_device *adev);
 
 void legacy_doorbell_index_init(struct amdgpu_device *adev);
-int smu7_asic_get_baco_capability(struct amdgpu_device *adev, bool *cap);
-int smu7_asic_baco_reset(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index b0229543e887..42ede3aa6dbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -478,7 +478,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
-		    is_support_sw_smu(adev) && !amdgpu_sriov_vf(adev))
+		    !amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
@@ -489,7 +489,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
-		    is_support_sw_smu(adev) && !amdgpu_sriov_vf(adev))
+		    !amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
@@ -502,7 +502,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
-		    is_support_sw_smu(adev) && !amdgpu_sriov_vf(adev))
+		    !amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
@@ -513,7 +513,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
-		    is_support_sw_smu(adev) && !amdgpu_sriov_vf(adev))
+		    !amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 714cf4dfd0a7..25cfc636c732 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -479,62 +479,18 @@ static int soc15_asic_mode1_reset(struct amdgpu_device *adev)
 	return ret;
 }
 
-static int soc15_asic_get_baco_capability(struct amdgpu_device *adev, bool *cap)
-{
-	if (is_support_sw_smu(adev)) {
-		struct smu_context *smu = &adev->smu;
-
-		*cap = smu_baco_is_support(smu);
-		return 0;
-	} else {
-		void *pp_handle = adev->powerplay.pp_handle;
-		const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-
-		if (!pp_funcs || !pp_funcs->get_asic_baco_capability) {
-			*cap = false;
-			return -ENOENT;
-		}
-
-		return pp_funcs->get_asic_baco_capability(pp_handle, cap);
-	}
-}
-
 static int soc15_asic_baco_reset(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	int ret = 0;
 
 	/* avoid NBIF got stuck when do RAS recovery in BACO reset */
 	if (ras && ras->supported)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, false);
 
-	dev_info(adev->dev, "GPU BACO reset\n");
-
-	if (is_support_sw_smu(adev)) {
-		struct smu_context *smu = &adev->smu;
-		int ret;
-
-		ret = smu_baco_enter(smu);
-		if (ret)
-			return ret;
-
-		ret = smu_baco_exit(smu);
-		if (ret)
-			return ret;
-	} else {
-		void *pp_handle = adev->powerplay.pp_handle;
-		const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-
-		if (!pp_funcs ||!pp_funcs->get_asic_baco_state ||!pp_funcs->set_asic_baco_state)
-			return -ENOENT;
-
-		/* enter BACO state */
-		if (pp_funcs->set_asic_baco_state(pp_handle, 1))
-			return -EIO;
-
-		/* exit BACO state */
-		if (pp_funcs->set_asic_baco_state(pp_handle, 0))
-			return -EIO;
-	}
+	ret = amdgpu_dpm_baco_reset(adev);
+	if (ret)
+		return ret;
 
 	/* re-enable doorbell interrupt after BACO exit */
 	if (ras && ras->supported)
@@ -543,17 +499,6 @@ static int soc15_asic_baco_reset(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int soc15_mode2_reset(struct amdgpu_device *adev)
-{
-	if (is_support_sw_smu(adev))
-		return smu_mode2_reset(&adev->smu);
-	if (!adev->powerplay.pp_funcs ||
-	    !adev->powerplay.pp_funcs->asic_reset_mode_2)
-		return -ENOENT;
-
-	return adev->powerplay.pp_funcs->asic_reset_mode_2(adev->powerplay.pp_handle);
-}
-
 static enum amd_reset_method
 soc15_asic_reset_method(struct amdgpu_device *adev)
 {
@@ -567,11 +512,11 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 	case CHIP_VEGA10:
 	case CHIP_VEGA12:
 	case CHIP_ARCTURUS:
-		soc15_asic_get_baco_capability(adev, &baco_reset);
+		baco_reset = amdgpu_dpm_is_baco_supported(adev);
 		break;
 	case CHIP_VEGA20:
 		if (adev->psp.sos_fw_version >= 0x80067)
-			soc15_asic_get_baco_capability(adev, &baco_reset);
+			baco_reset = amdgpu_dpm_is_baco_supported(adev);
 
 		/*
 		 * 1. PMFW version > 0x284300: all cases use baco
@@ -598,7 +543,7 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
 				amdgpu_inc_vram_lost(adev);
 			return soc15_asic_baco_reset(adev);
 		case AMD_RESET_METHOD_MODE2:
-			return soc15_mode2_reset(adev);
+			return amdgpu_dpm_mode2_reset(adev);
 		default:
 			if (!adev->in_suspend)
 				amdgpu_inc_vram_lost(adev);
@@ -608,25 +553,18 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
 
 static bool soc15_supports_baco(struct amdgpu_device *adev)
 {
-	bool baco_support;
-
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
 	case CHIP_VEGA12:
 	case CHIP_ARCTURUS:
-		soc15_asic_get_baco_capability(adev, &baco_support);
-		break;
+		return amdgpu_dpm_is_baco_supported(adev);
 	case CHIP_VEGA20:
 		if (adev->psp.sos_fw_version >= 0x80067)
-			soc15_asic_get_baco_capability(adev, &baco_support);
-		else
-			baco_support = false;
-		break;
+			return amdgpu_dpm_is_baco_supported(adev);
+		return false;
 	default:
 		return false;
 	}
-
-	return baco_support;
 }
 
 /*static int soc15_set_uvd_clock(struct amdgpu_device *adev, u32 clock,
@@ -846,8 +784,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
 		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
 			amdgpu_device_ip_block_add(adev, &psp_v12_0_ip_block);
-		if (is_support_sw_smu(adev))
-			amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index e4f4201b3c34..78b35901643b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -689,40 +689,6 @@ static int vi_gpu_pci_config_reset(struct amdgpu_device *adev)
 	return -EINVAL;
 }
 
-int smu7_asic_get_baco_capability(struct amdgpu_device *adev, bool *cap)
-{
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-
-	if (!pp_funcs || !pp_funcs->get_asic_baco_capability) {
-		*cap = false;
-		return -ENOENT;
-	}
-
-	return pp_funcs->get_asic_baco_capability(pp_handle, cap);
-}
-
-int smu7_asic_baco_reset(struct amdgpu_device *adev)
-{
-	void *pp_handle = adev->powerplay.pp_handle;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-
-	if (!pp_funcs ||!pp_funcs->get_asic_baco_state ||!pp_funcs->set_asic_baco_state)
-		return -ENOENT;
-
-	/* enter BACO state */
-	if (pp_funcs->set_asic_baco_state(pp_handle, 1))
-		return -EIO;
-
-	/* exit BACO state */
-	if (pp_funcs->set_asic_baco_state(pp_handle, 0))
-		return -EIO;
-
-	dev_info(adev->dev, "GPU BACO reset\n");
-
-	return 0;
-}
-
 /**
  * vi_asic_pci_config_reset - soft reset GPU
  *
@@ -747,8 +713,6 @@ static int vi_asic_pci_config_reset(struct amdgpu_device *adev)
 
 static bool vi_asic_supports_baco(struct amdgpu_device *adev)
 {
-	bool baco_support;
-
 	switch (adev->asic_type) {
 	case CHIP_FIJI:
 	case CHIP_TONGA:
@@ -756,14 +720,10 @@ static bool vi_asic_supports_baco(struct amdgpu_device *adev)
 	case CHIP_POLARIS11:
 	case CHIP_POLARIS12:
 	case CHIP_TOPAZ:
-		smu7_asic_get_baco_capability(adev, &baco_support);
-		break;
+		return amdgpu_dpm_is_baco_supported(adev);
 	default:
-		baco_support = false;
-		break;
+		return false;
 	}
-
-	return baco_support;
 }
 
 static enum amd_reset_method
@@ -778,7 +738,7 @@ vi_asic_reset_method(struct amdgpu_device *adev)
 	case CHIP_POLARIS11:
 	case CHIP_POLARIS12:
 	case CHIP_TOPAZ:
-		smu7_asic_get_baco_capability(adev, &baco_reset);
+		baco_reset = amdgpu_dpm_is_baco_supported(adev);
 		break;
 	default:
 		baco_reset = false;
@@ -807,7 +767,7 @@ static int vi_asic_reset(struct amdgpu_device *adev)
 	if (vi_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
 		if (!adev->in_suspend)
 			amdgpu_inc_vram_lost(adev);
-		r = smu7_asic_baco_reset(adev);
+		r = amdgpu_dpm_baco_reset(adev);
 	} else {
 		r = vi_asic_pci_config_reset(adev);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.h b/drivers/gpu/drm/amd/amdgpu/vi.h
index 40d4174913a4..defb4aaf929a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.h
+++ b/drivers/gpu/drm/amd/amdgpu/vi.h
@@ -31,7 +31,5 @@ void vi_srbm_select(struct amdgpu_device *adev,
 int vi_set_ip_blocks(struct amdgpu_device *adev);
 
 void legacy_doorbell_index_init(struct amdgpu_device *adev);
-int smu7_asic_get_baco_capability(struct amdgpu_device *adev, bool *cap);
-int smu7_asic_baco_reset(struct amdgpu_device *adev);
 
 #endif
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
