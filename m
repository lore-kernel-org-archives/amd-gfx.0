Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50629C433EA
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21CEB21582
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jZgnfgyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CEB21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF31C898B7;
	Tue, 14 Jul 2020 08:07:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64D1D898B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDfNYH86sf+bCDSasvcEcrpmyO8ZqqyDn3uHKBWiNWCX9LBvr6QKOV+Y06MQo2pms6/j5wH73UDdiMvCENchIMZWmes+nDTE8bopTdMdBh2sMViEM5IOMwdbwYa/I+riTFP/HcnGcO3T5Z+MND1Ka9LRGMzLknlg+zA42YbnrWQgjTEL6yobel/TtaMd+rqLavhnkxML9vKT+k4Tah5YAf2HVhbuBAJMmwDUcVJQQPgus38LQ3QGuoGKhKcd5NGT4M+8HspD3k3DhfOGI+81qe9sHy++UsL+32p8M9xi8TNQ+hBZg6PzlOVng0lta/7BALyS0DQ7cy/ordXPJTQnvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3E6QJ0j8/6LQQ53YfAIVqkW2wov8HWBqW2QY8T0SrlU=;
 b=Dib+L42G03Qno8N+/Akbh1azqvcCgRkCL8qUfnT4PzPJ05yQ5/72gSLe0a4U+EEezuznwyxPO9ZVUMH1Nzw2+l/cXd4c1eiOvNXdm9w/uGZgouw1O9negQPOF19YN29FwNLrC63gYtuVGOtVnDHh69sgp36Au/GqC+ljYwC1/FF8OWUnQXh1x5g60V2lL3KyaATJYKuqUwqR6zDAQ0fZEDT8+yF3GGfWeAG5i+NkrRvVpsh/XkgMyFe+85kTpx9y6fiVEMXKFIMYI2/MdWZmP7bjOeIzKZUP8nMq+mK9NQa5MIr3A4BHhcQeTE3vJmuTZmAG0uqZzZaJwnOs6YCuVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3E6QJ0j8/6LQQ53YfAIVqkW2wov8HWBqW2QY8T0SrlU=;
 b=jZgnfgyB8VB6wt8DCbwKBc9djd/9Ue4ga9tZnmV8ZjaxzZxb241tMkYw72orjWR2ClpZcWjGr2OD3kEAx+gngK8VT5Q+VoZvcG1qnTSIPxCnfzAM5nC/n4jmKU1YRjEHEAG/HPpK4lF6OjW1kqmXs47eN3olvVKkos34aUus8Kc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 08:06:58 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 08:06:58 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/17] drm/amd/powerplay: move more APIs to smu_cmn.c
Date: Tue, 14 Jul 2020 16:04:09 +0800
Message-Id: <20200714080416.6506-10-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714080416.6506-1-evan.quan@amd.com>
References: <20200714080416.6506-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0078.apcprd04.prod.outlook.com
 (2603:1096:202:15::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0078.apcprd04.prod.outlook.com (2603:1096:202:15::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 08:06:56 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a21fc95f-8ddf-471c-2654-08d827cce153
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4355F99A37E8E34792276CF5E4610@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K637qF0qNqeryBSlAZxc1imnQHAo+PLGirU+zTNjVMBEaai5mGF3cL7E0LrDknB62RecHk58mr0ci75rOLVWdhq//zrirFz+eEgpUrDxo3NE0qu7VSKlI2VBHAe5KsIGLnw1YFxgrXMIvve4OVuJutKl7nh9TkktLD0+CM8pnldeCogWO/buEBFEr7SDaCLzAppJUqosnSwUwFMzNe+BomU4/cAbMPXwufWbSPw4JOJkTYjncf+GiQnnpk0SAPcWhXx/3l9vDTLCnkQMn3C7GQLhmAmDIPHElc0H2u2WRwsUran07xQ2OJkcuFJoyyu8/Uf8UvA+WY0Co15/Jfhv0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(478600001)(83380400001)(316002)(4326008)(2616005)(8936002)(8676002)(36756003)(66946007)(66556008)(1076003)(44832011)(2906002)(956004)(66476007)(6486002)(5660300002)(52116002)(6666004)(186003)(30864003)(86362001)(7696005)(16526019)(26005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: q9ZZV3zXwZ5tqYfRC1N3D5kWVK7en/IcMq8oCTZZJBYAEJ4qAlggJ2jURXnseTLZig+rGcnsR3fvzaqiUUc7isc58VxxLoV/UuJLBrU5eQ80qiqwTY+WZ8zAmXhjD/XjSaVeoqM+b/P5uivVZwbC3vi63Hj4DSI5I8AXf7iQspLAJ52onZVq/opSEHBhjTea/yuCDIgtSpeoHzScmZaK4J/qE1QC/cgpn5EUluuas63Mh6S+8+PuwqUvn3ULg8DD0qbIwqLuMUGc800hObrhM9JNGmruORXWo5buW0uaHA8e4pcQerPQnCmJ/AukbiCWSsa8OcgCdpGhaRd3cFkZlWNNZzVGV78NlnB5p0s3UTWSwHtLcgUdRSiG/oDMBO3F92hyuyqyxaLvZyQzFPbdIDWcMTaVD4r7ov2a/GzBBDMPgTl2HpOdyIu3XHk6ugAva95V8t4FfoGNJQrC0tZ5+dWxYV0LsRuBe59gDhe8m8+nvpqr6H9tm10dvR/YkJ1Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21fc95f-8ddf-471c-2654-08d827cce153
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 08:06:58.2238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dy5oBDP0iHEniZ7QP8JXgEwmiZOeYZwaO1AGDtwh/lZH3nbkPZEdvJGqH2iN7fIT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Considering they are shared by all ASICs.

Change-Id: I5d59144199d4c9eee5c06f24a4602c39729125d9
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 64 ------------------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 14 ++--
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  2 +-
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  2 +-
 drivers/gpu/drm/amd/powerplay/smu_cmn.c       | 66 +++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/smu_cmn.h       |  7 ++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 10 +--
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     |  4 +-
 9 files changed, 89 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 97a9cc31dbf7..d68de02a0c90 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -91,43 +91,6 @@ int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask)
 	return ret;
 }
 
-int smu_get_smc_version(struct smu_context *smu, uint32_t *if_version, uint32_t *smu_version)
-{
-	int ret = 0;
-
-	if (!if_version && !smu_version)
-		return -EINVAL;
-
-	if (smu->smc_fw_if_version && smu->smc_fw_version)
-	{
-		if (if_version)
-			*if_version = smu->smc_fw_if_version;
-
-		if (smu_version)
-			*smu_version = smu->smc_fw_version;
-
-		return 0;
-	}
-
-	if (if_version) {
-		ret = smu_send_smc_msg(smu, SMU_MSG_GetDriverIfVersion, if_version);
-		if (ret)
-			return ret;
-
-		smu->smc_fw_if_version = *if_version;
-	}
-
-	if (smu_version) {
-		ret = smu_send_smc_msg(smu, SMU_MSG_GetSmuVersion, smu_version);
-		if (ret)
-			return ret;
-
-		smu->smc_fw_version = *smu_version;
-	}
-
-	return ret;
-}
-
 int smu_set_soft_freq_range(struct smu_context *smu,
 			    enum smu_clk_type clk_type,
 			    uint32_t min,
@@ -171,33 +134,6 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 	return ret;
 }
 
-bool smu_clk_dpm_is_enabled(struct smu_context *smu, enum smu_clk_type clk_type)
-{
-	enum smu_feature_mask feature_id = 0;
-
-	switch (clk_type) {
-	case SMU_MCLK:
-	case SMU_UCLK:
-		feature_id = SMU_FEATURE_DPM_UCLK_BIT;
-		break;
-	case SMU_GFXCLK:
-	case SMU_SCLK:
-		feature_id = SMU_FEATURE_DPM_GFXCLK_BIT;
-		break;
-	case SMU_SOCCLK:
-		feature_id = SMU_FEATURE_DPM_SOCCLK_BIT;
-		break;
-	default:
-		return true;
-	}
-
-	if(!smu_feature_is_enabled(smu, feature_id)) {
-		return false;
-	}
-
-	return true;
-}
-
 /**
  * smu_dpm_set_power_gate - power gate/ungate the specific IP block
  *
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index d126905e6597..9b1b9bcf42fc 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -873,7 +873,7 @@ static int arcturus_force_clk_levels(struct smu_context *smu,
 	uint32_t smu_version;
 	int ret = 0;
 
-	ret = smu_get_smc_version(smu, NULL, &smu_version);
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to get smu version!\n");
 		return ret;
@@ -1190,7 +1190,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 	if (!buf)
 		return -EINVAL;
 
-	result = smu_get_smc_version(smu, NULL, &smu_version);
+	result = smu_cmn_get_smc_version(smu, NULL, &smu_version);
 	if (result)
 		return result;
 
@@ -1277,7 +1277,7 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	ret = smu_get_smc_version(smu, NULL, &smu_version);
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
 	if (ret)
 		return ret;
 
@@ -1361,7 +1361,7 @@ static int arcturus_set_performance_level(struct smu_context *smu,
 	uint32_t smu_version;
 	int ret;
 
-	ret = smu_get_smc_version(smu, NULL, &smu_version);
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to get smu version!\n");
 		return ret;
@@ -2095,7 +2095,7 @@ static void arcturus_get_unique_id(struct smu_context *smu)
 	uint32_t top32 = 0, bottom32 = 0, smu_version;
 	uint64_t id;
 
-	if (smu_get_smc_version(smu, NULL, &smu_version)) {
+	if (smu_cmn_get_smc_version(smu, NULL, &smu_version)) {
 		dev_warn(adev->dev, "Failed to get smu version, cannot get unique_id or serial_number\n");
 		return;
 	}
@@ -2136,7 +2136,7 @@ static int arcturus_set_df_cstate(struct smu_context *smu,
 	uint32_t smu_version;
 	int ret;
 
-	ret = smu_get_smc_version(smu, NULL, &smu_version);
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to get smu version!\n");
 		return ret;
@@ -2156,7 +2156,7 @@ static int arcturus_allow_xgmi_power_down(struct smu_context *smu, bool en)
 	uint32_t smu_version;
 	int ret;
 
-	ret = smu_get_smc_version(smu, NULL, &smu_version);
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to get smu version!\n");
 		return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index cb922f4136c9..ca097f91e963 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -755,7 +755,6 @@ extern int smu_handle_task(struct smu_context *smu,
 int smu_switch_power_profile(struct smu_context *smu,
 			     enum PP_SMC_POWER_PROFILE type,
 			     bool en);
-int smu_get_smc_version(struct smu_context *smu, uint32_t *if_version, uint32_t *smu_version);
 int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			   uint32_t *min, uint32_t *max);
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
@@ -764,7 +763,6 @@ enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *smu);
 int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level);
 int smu_set_display_count(struct smu_context *smu, uint32_t count);
 int smu_set_ac_dc(struct smu_context *smu);
-bool smu_clk_dpm_is_enabled(struct smu_context *smu, enum smu_clk_type clk_type);
 const char *smu_get_message_name(struct smu_context *smu, enum smu_message_type type);
 size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf);
 int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 4f66eb9011fc..3e91f9cc732c 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2215,7 +2215,7 @@ static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
 	if (!navi10_need_umc_cdr_12gbps_workaround(smu->adev))
 		return 0;
 
-	ret = smu_get_smc_version(smu, NULL, &smu_version);
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index e6a4dff61aee..e6789b28dd23 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -232,7 +232,7 @@ static int renoir_get_dpm_ultimate_freq(struct smu_context *smu,
 	uint32_t mclk_mask, soc_mask;
 	uint32_t clock_limit;
 
-	if (!smu_clk_dpm_is_enabled(smu, clk_type)) {
+	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type)) {
 		switch (clk_type) {
 		case SMU_MCLK:
 		case SMU_UCLK:
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.c b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
index 85c106966f9a..814c21ca2edc 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
@@ -164,6 +164,33 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
 	return ret;
 }
 
+bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
+				enum smu_clk_type clk_type)
+{
+	enum smu_feature_mask feature_id = 0;
+
+	switch (clk_type) {
+	case SMU_MCLK:
+	case SMU_UCLK:
+		feature_id = SMU_FEATURE_DPM_UCLK_BIT;
+		break;
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		feature_id = SMU_FEATURE_DPM_GFXCLK_BIT;
+		break;
+	case SMU_SOCCLK:
+		feature_id = SMU_FEATURE_DPM_SOCCLK_BIT;
+		break;
+	default:
+		return true;
+	}
+
+	if (!smu_cmn_feature_is_enabled(smu, feature_id))
+		return false;
+
+	return true;
+}
+
 int smu_cmn_get_enabled_mask(struct smu_context *smu,
 			     uint32_t *feature_mask,
 			     uint32_t num)
@@ -374,3 +401,42 @@ int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
 						   features_to_disable,
 						   0);
 }
+
+int smu_cmn_get_smc_version(struct smu_context *smu,
+			    uint32_t *if_version,
+			    uint32_t *smu_version)
+{
+	int ret = 0;
+
+	if (!if_version && !smu_version)
+		return -EINVAL;
+
+	if (smu->smc_fw_if_version && smu->smc_fw_version)
+	{
+		if (if_version)
+			*if_version = smu->smc_fw_if_version;
+
+		if (smu_version)
+			*smu_version = smu->smc_fw_version;
+
+		return 0;
+	}
+
+	if (if_version) {
+		ret = smu_send_smc_msg(smu, SMU_MSG_GetDriverIfVersion, if_version);
+		if (ret)
+			return ret;
+
+		smu->smc_fw_if_version = *if_version;
+	}
+
+	if (smu_version) {
+		ret = smu_send_smc_msg(smu, SMU_MSG_GetSmuVersion, smu_version);
+		if (ret)
+			return ret;
+
+		smu->smc_fw_version = *smu_version;
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.h b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
index 08968ad24d10..9b1d2e9c1799 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
@@ -35,6 +35,9 @@ int smu_cmn_feature_is_supported(struct smu_context *smu,
 int smu_cmn_feature_is_enabled(struct smu_context *smu,
 			       enum smu_feature_mask mask);
 
+bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
+				enum smu_clk_type clk_type);
+
 int smu_cmn_get_enabled_mask(struct smu_context *smu,
 			     uint32_t *feature_mask,
 			     uint32_t num);
@@ -52,4 +55,8 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
 int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
 						enum smu_feature_mask mask);
 
+int smu_cmn_get_smc_version(struct smu_context *smu,
+			    uint32_t *if_version,
+			    uint32_t *smu_version);
+
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 50735f67c16d..323eb8a09c1f 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -282,7 +282,7 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 	uint8_t smu_minor, smu_debug;
 	int ret = 0;
 
-	ret = smu_get_smc_version(smu, &if_version, &smu_version);
+	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
 	if (ret)
 		return ret;
 
@@ -1668,7 +1668,7 @@ int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 	uint32_t param = 0;
 	uint32_t clock_limit;
 
-	if (!smu_clk_dpm_is_enabled(smu, clk_type)) {
+	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type)) {
 		switch (clk_type) {
 		case SMU_MCLK:
 		case SMU_UCLK:
@@ -1729,7 +1729,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 	int ret = 0, clk_id = 0;
 	uint32_t param;
 
-	if (!smu_clk_dpm_is_enabled(smu, clk_type))
+	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type))
 		return 0;
 
 	clk_id = smu_cmn_to_asic_specific_index(smu,
@@ -1775,7 +1775,7 @@ int smu_v11_0_set_hard_freq_limited_range(struct smu_context *smu,
 	if (min <= 0 && max <= 0)
 		return -EINVAL;
 
-	if (!smu_clk_dpm_is_enabled(smu, clk_type))
+	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type))
 		return 0;
 
 	clk_id = smu_cmn_to_asic_specific_index(smu,
@@ -1932,7 +1932,7 @@ int smu_v11_0_get_dpm_freq_by_index(struct smu_context *smu,
 	if (!value)
 		return -EINVAL;
 
-	if (!smu_clk_dpm_is_enabled(smu, clk_type))
+	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type))
 		return 0;
 
 	clk_id = smu_cmn_to_asic_specific_index(smu,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 33ec9fc44f4c..7964f14536bd 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -157,7 +157,7 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
 	uint8_t smu_minor, smu_debug;
 	int ret = 0;
 
-	ret = smu_get_smc_version(smu, &if_version, &smu_version);
+	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
 	if (ret)
 		return ret;
 
@@ -305,7 +305,7 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 {
 	int ret = 0;
 
-	if (!smu_clk_dpm_is_enabled(smu, clk_type))
+	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type))
 		return 0;
 
 	switch (clk_type) {
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
