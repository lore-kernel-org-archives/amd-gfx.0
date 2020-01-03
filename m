Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45686C2D0C2
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C160621734
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kbtg5OqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C160621734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BBEA89B18;
	Fri,  3 Jan 2020 09:47:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 379BD89B18
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 09:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BknkNawDsON0k2A301L+/BYnmazN7lT9c2tYgdFxuqAgLxCkZtqZokwydTa4ZqgXnNVke3wqMgXIWT69BwpeBx6IzssWiP2uCr3WdG/pXv7fYn6FaFfdv4fUrMpbCdXz+/UhG5eW8AQinos8t0zoy8HHUztTbuJy/pSFNsGOIrVMtHjubfq1xDahEolUZbnZjjR+1ou1vQs7wvlbilTBwuO6Qg2H+y3H4zJ/vUrwpgNPX/8gTu2gTTjYCyOySUNC2TYhujAHpN6MEm0ffmK5Rp1XaiV4uXGVX7+105wbNkUjRfl0uEFUWmFesUxfFPKedbW4EvYtDfwFZfrl8qatpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUoA8v4l1ooTJFG0/jXwYiM8lxj31ub7A3xfzCgkC9k=;
 b=n/mXhpWsrwxK1rpGJ5WHeoF1ZKjbztb/juo2YZPjQt00Bjq/hDkG7FQ8mEzNOWGSx+ld609zD0i9QTawgO9YKOaWIvKoTRZTqoaT6WNP4i7+QxIeFRmar6uMH7p9Umhdv/ZSUvVGaks8PL/a0IkncekSMDv3aHuVv8dlInY5ccfh5wB5w3ch0pycX/yfdGnDOgAxmxa6PU0kndAUhJsb4hQ/dDZMsn6SjfR9XdfYOd3Jwa7+rTWNRLjw7HB05yl0Y0ON2vpYAHNA8NkT3GxtOx5x1U6NYPJBIp9kfdV3cUW4ZIK3LQyi9j/0a+QQssTOy7oCZYLHL3bYVbgqpsRlVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUoA8v4l1ooTJFG0/jXwYiM8lxj31ub7A3xfzCgkC9k=;
 b=kbtg5OqP1DsOgffLw6WdAlftj9KPj8GV/vYO1VtDQEce0rDhpBdWczY+aNbXKR3QNNGYO0pzM+dOgHiDf/sDcTW70Xuj71RvTjvGcc95fXOCnIU3+S0xoeaMu3X6q1Huf+eSd4cMffmHmdL8ndVoRSI/T7jjqpHBk2jOCbE1Aks=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3182.namprd12.prod.outlook.com (20.179.83.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Fri, 3 Jan 2020 09:47:00 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2602.012; Fri, 3 Jan 2020
 09:47:00 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: cleanup the interfaces for powergate
 setting through SMU
Date: Fri,  3 Jan 2020 17:46:39 +0800
Message-Id: <20200103094639.32372-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.1
X-ClientProxiedBy: HK2PR02CA0168.apcprd02.prod.outlook.com
 (2603:1096:201:1f::28) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR02CA0168.apcprd02.prod.outlook.com (2603:1096:201:1f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12 via Frontend Transport; Fri, 3 Jan 2020 09:46:58 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6fa0a7d6-e330-4a59-891e-08d79031e0db
X-MS-TrafficTypeDiagnostic: MN2PR12MB3182:|MN2PR12MB3182:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB318230488893DE8ECFE0163EE4230@MN2PR12MB3182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:309;
X-Forefront-PRVS: 0271483E06
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(199004)(189003)(478600001)(6486002)(956004)(8936002)(36756003)(6916009)(26005)(186003)(16526019)(52116002)(7696005)(2906002)(2616005)(4326008)(5660300002)(44832011)(66946007)(86362001)(1076003)(6666004)(66476007)(66556008)(81156014)(316002)(8676002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3182;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iNECGsXhPu2kY6AFcSCwr1r6TW5DaV69G6yU8votpwBRgkdNi+y8JjbCpveBaSD9C9LlGqTjjGA4hh88UhS376KIiK912FMlHWVC8bXDV3jDjNAydLi8eWB11wa7vfbg6tNHGdL0wH0vOtRW6wYZuAo0NaK5nRI2glEdJlIE1M6MAfzRlK8Cv7hgkQFOAp2RcZnfSDpgkh3ucBOzZLf8eLsPLoDMf7bQHX5D886woYyKKtA1eDcp8BfU1aVJtpMJWqvjHWkxmfBqcLdCQoBHIDocHXH10N4qW+6rWD3MVCXoaHG/LNykG2zbZ4iiLknjmMvJR+gMX9mAsgt6JRwctV2XnWtEnmGNefyrXHs+XGXz4NAbtu8pQMTuUg+elIX4NxSlXL9igc0XDYOkNm8zE8GYOwnB8ehHzNgLNc5WEVda4XnRsM0bxESzmma5w3Dq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa0a7d6-e330-4a59-891e-08d79031e0db
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2020 09:47:00.1552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcUlR0XGwM6QFMYDRS5gerLFe/ehJQ8YQ6fdYpMQFXm6z/+andVTPRKOoBzGY7K2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3182
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

Provided an unified entry point. And fixed the confusing that the API
usage is conflict with what the naming implies.

Change-Id: If068980ca6a7b223d0b4d087cd99cdeb729b0e77
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c    | 23 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c     | 43 ++++++++--------------
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c |  6 +--
 3 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
index 9cc270efee7c..cd76fbf4385d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
@@ -951,16 +951,31 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	case AMD_IP_BLOCK_TYPE_VCN:
 	case AMD_IP_BLOCK_TYPE_VCE:
 	case AMD_IP_BLOCK_TYPE_SDMA:
+		if (swsmu) {
+			ret = smu_dpm_set_power_gate(&adev->smu, block_type, gate);
+		} else {
+			if (adev->powerplay.pp_funcs &&
+			    adev->powerplay.pp_funcs->set_powergating_by_smu) {
+				mutex_lock(&adev->pm.mutex);
+				ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
+					(adev)->powerplay.pp_handle, block_type, gate));
+				mutex_unlock(&adev->pm.mutex);
+			}
+		}
+		break;
+	case AMD_IP_BLOCK_TYPE_JPEG:
 		if (swsmu)
 			ret = smu_dpm_set_power_gate(&adev->smu, block_type, gate);
-		else
-			ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
-				(adev)->powerplay.pp_handle, block_type, gate));
 		break;
 	case AMD_IP_BLOCK_TYPE_GMC:
 	case AMD_IP_BLOCK_TYPE_ACP:
-		ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
+		if (adev->powerplay.pp_funcs &&
+		    adev->powerplay.pp_funcs->set_powergating_by_smu) {
+			mutex_lock(&adev->pm.mutex);
+			ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
 				(adev)->powerplay.pp_handle, block_type, gate));
+			mutex_unlock(&adev->pm.mutex);
+		}
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index b32adda70bbc..285d460624c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -2762,17 +2762,12 @@ static void amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
 void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
 {
 	int ret = 0;
-	if (is_support_sw_smu(adev)) {
-	    ret = smu_dpm_set_power_gate(&adev->smu, AMD_IP_BLOCK_TYPE_UVD, enable);
-	    if (ret)
-		DRM_ERROR("[SW SMU]: dpm enable uvd failed, state = %s, ret = %d. \n",
-			  enable ? "true" : "false", ret);
-	} else if (adev->powerplay.pp_funcs->set_powergating_by_smu) {
-		/* enable/disable UVD */
-		mutex_lock(&adev->pm.mutex);
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
-		mutex_unlock(&adev->pm.mutex);
-	}
+
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
+	if (ret)
+		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
+			  enable ? "enable" : "disable", ret);
+
 	/* enable/disable Low Memory PState for UVD (4k videos) */
 	if (adev->asic_type == CHIP_STONEY &&
 		adev->uvd.decode_image_width >= WIDTH_4K) {
@@ -2789,17 +2784,11 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
 {
 	int ret = 0;
-	if (is_support_sw_smu(adev)) {
-	    ret = smu_dpm_set_power_gate(&adev->smu, AMD_IP_BLOCK_TYPE_VCE, enable);
-	    if (ret)
-		DRM_ERROR("[SW SMU]: dpm enable vce failed, state = %s, ret = %d. \n",
-			  enable ? "true" : "false", ret);
-	} else if (adev->powerplay.pp_funcs->set_powergating_by_smu) {
-		/* enable/disable VCE */
-		mutex_lock(&adev->pm.mutex);
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
-		mutex_unlock(&adev->pm.mutex);
-	}
+
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
+	if (ret)
+		DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
+			  enable ? "enable" : "disable", ret);
 }
 
 void amdgpu_pm_print_power_states(struct amdgpu_device *adev)
@@ -2818,12 +2807,10 @@ void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable)
 {
 	int ret = 0;
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_dpm_set_power_gate(&adev->smu, AMD_IP_BLOCK_TYPE_JPEG, enable);
-		if (ret)
-			DRM_ERROR("[SW SMU]: dpm enable jpeg failed, state = %s, ret = %d. \n",
-				  enable ? "true" : "false", ret);
-	}
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_JPEG, !enable);
+	if (ret)
+		DRM_ERROR("Dpm %s jpeg failed, ret = %d. \n",
+			  enable ? "enable" : "disable", ret);
 }
 
 int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_version)
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index e1b64134bbd8..fabc46dfb933 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -433,10 +433,10 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
 
 	switch (block_type) {
 	case AMD_IP_BLOCK_TYPE_UVD:
-		ret = smu_dpm_set_uvd_enable(smu, gate);
+		ret = smu_dpm_set_uvd_enable(smu, !gate);
 		break;
 	case AMD_IP_BLOCK_TYPE_VCE:
-		ret = smu_dpm_set_vce_enable(smu, gate);
+		ret = smu_dpm_set_vce_enable(smu, !gate);
 		break;
 	case AMD_IP_BLOCK_TYPE_GFX:
 		ret = smu_gfx_off_control(smu, gate);
@@ -445,7 +445,7 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
 		ret = smu_powergate_sdma(smu, gate);
 		break;
 	case AMD_IP_BLOCK_TYPE_JPEG:
-		ret = smu_dpm_set_jpeg_enable(smu, gate);
+		ret = smu_dpm_set_jpeg_enable(smu, !gate);
 		break;
 	default:
 		break;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
