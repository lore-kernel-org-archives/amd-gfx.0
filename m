Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970BDC33C9E
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 09:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8642080A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 09:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Og3CsgmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8642080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B5B389AB7;
	Tue,  7 Jan 2020 09:48:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8378889AB7
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 09:48:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=an48ysT0ykIC+K4wErAPC0GBBKlU5qIUfv4l4WWKxe4cUCn85uoob1NHiq6SXqNp+YhMJmNfsar3YXSIPu4zRYeDzDQinmGnve//7UppCMlAEz+PF83E+fJb0+kGLo24evJTNfoGLupirCR6/G8/0B8tbbyjrv7AHGVx1Rg+J0gkekj8QF/HVZqSunjn+7YeKF5B5TmV8HNrSvVBUswjX07Jl4CpNL0RKhH4mOvxSrATsExUS957aSPq2q45MQsEVzF4J2cW1LUFRwhrNdBcv+twKKiT8xjzQWjB7nEWElBdvUIbjx4H+apub0pWAF8oHaRw94v23ewxXOjICLZLaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SgLqnrv/riJHa0zPP3uGISDSDDUzCA690/UU8LqTgA=;
 b=OZP3zlZ9R+GSwF/pRaLaoQdu07cIykEHNO29DRHsFsgnD24WnTf05p03WpfamO6VcIEyvJoNNIapHodtZAyfDPVoGCUXjgamKJRQR/ManW27l8KP3wtRVhEDBKO75M5dNX8/Wwdhhw4cE0xXjZpkG2JH5dF7evvDWFsNccpyFsa77oKu0c6/8RsBG7yFR4jtWgZZyn+3k+S5Aoic02Um1B0ZRYF5uNGAXtLTod1zrrp4MZFFDjwsYYuIyZNMEs8bpR7Qm9ggNNaDzhw12F2Yxne2llf8T8KI5STSUwDKFzB/oiGUsg7X9l0uuXGBfU6SohtnM0PRKvgKgghSN31u7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SgLqnrv/riJHa0zPP3uGISDSDDUzCA690/UU8LqTgA=;
 b=Og3CsgmYJUVk2uc8s9o4aVfWJltuDOsCwQp+jO3lxB1iU99yMpacwp/TgzmnjvFrFl5kPbwGZ6+FDDOAwiIrrdgpelaWEKOv/18URnaiNTFNKYhAdEZOCKp9YJcQ/KO2RDl8NxGy7N6WXxKLyPP3iwkDesAZQB2kLhaPa/1vfF8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4029.namprd12.prod.outlook.com (10.255.237.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.13; Tue, 7 Jan 2020 09:48:37 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2602.015; Tue, 7 Jan 2020
 09:48:37 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: cover the powerplay implementation details
Date: Tue,  7 Jan 2020 17:48:12 +0800
Message-Id: <20200107094812.29886-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.1
X-ClientProxiedBy: HK2PR0302CA0017.apcprd03.prod.outlook.com
 (2603:1096:202::27) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0302CA0017.apcprd03.prod.outlook.com (2603:1096:202::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.5 via Frontend Transport; Tue, 7 Jan 2020 09:48:35 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 931b014f-9cbd-4813-19f6-08d79356c47b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4029:|MN2PR12MB4029:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40295B59538D96AC8B9058A0E43F0@MN2PR12MB4029.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 027578BB13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(189003)(199004)(81156014)(81166006)(8676002)(66556008)(6486002)(66476007)(66946007)(6916009)(478600001)(44832011)(316002)(30864003)(26005)(5660300002)(6666004)(186003)(8936002)(86362001)(4326008)(36756003)(16526019)(1076003)(2906002)(2616005)(956004)(52116002)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4029;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+Nq5K/kq9NKFwWOIiPAvbyCl7T9pdz/kGQ6y1MGmI7u1wISmvTBkMGMiM32MH/2U6UjJKbtH4fX01t3stYtfEXwdTwrbfyd5F125D1gjklZjvxrZNYCMGsoAd2YSwpDxfhEPyEi9/y3WpM6kkM6Zma6B0ippA4UaQN6xxSD2gbr1WZuNUbxroDQc1pE0gjpmJZlOyRCIOlxHb073RK3bSM1LNt6edGZXrN2s2NYnnSNE7hHuE1hGJLwwvWmfZrdXLXS9IDLKkeY6m2fSJwak7cs7mdEQ3gQoR5HGZkRtsD7cZbFbPHr2zuAVyUHQVvOQyTHEzVYCe4N0cTVbGNGp0aCBwasMRzglVYBOX8QnLoN+TE83KNqsVqtB791X8Nrht3T2LetDJmFMjhTr2U8N+uSNrEmyYmkhzrH2S+sEvqLFjnhn9vevac9Ratkqma5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931b014f-9cbd-4813-19f6-08d79356c47b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2020 09:48:37.0835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8hV6xYC7VUWNaCV8yl43foQUsz89dd/M1KqQUmDVbuJGkg2gJxNMpTfZBzlsV8q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4029
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This can save users much troubles. As they do not
actually need to care whether swSMU or traditional
powerplay routine should be used.

Change-Id: I827fe4cac0d4fd487782168a7fe73e15756a7109
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  53 +------
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c    | 158 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h    |  24 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |   6 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/nv.c            |   8 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  83 ++---------
 8 files changed, 203 insertions(+), 149 deletions(-)

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
index cd76fbf4385d..39fc39531cef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
@@ -983,3 +983,161 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 
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
+		    || !pp_funcs->get_asic_baco_state
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
index 714cf4dfd0a7..decfcce1a267 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -479,29 +479,10 @@ static int soc15_asic_mode1_reset(struct amdgpu_device *adev)
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
@@ -509,32 +490,9 @@ static int soc15_asic_baco_reset(struct amdgpu_device *adev)
 
 	dev_info(adev->dev, "GPU BACO reset\n");
 
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
@@ -543,17 +501,6 @@ static int soc15_asic_baco_reset(struct amdgpu_device *adev)
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
@@ -567,11 +514,11 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
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
@@ -598,7 +545,7 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
 				amdgpu_inc_vram_lost(adev);
 			return soc15_asic_baco_reset(adev);
 		case AMD_RESET_METHOD_MODE2:
-			return soc15_mode2_reset(adev);
+			return amdgpu_dpm_mode2_reset(adev);
 		default:
 			if (!adev->in_suspend)
 				amdgpu_inc_vram_lost(adev);
@@ -608,25 +555,18 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
 
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
@@ -846,8 +786,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
 		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
 			amdgpu_device_ip_block_add(adev, &psp_v12_0_ip_block);
-		if (is_support_sw_smu(adev))
-			amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
