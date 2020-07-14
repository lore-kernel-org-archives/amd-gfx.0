Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7ACC433E8
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3630921582
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2ztBom+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3630921582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 020C68949C;
	Tue, 14 Jul 2020 08:06:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A753895F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:06:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsCGl2C99XGyP1QfIwoZlcfcUXM8xXe1nLKdJSwDvBZ0Xa9IJliUugefZmra1+9oDU70++wGMM36GrTYWjJxQGd85q7I+gALFW3JNGqw9/powYs2+l1zgiSF9EutqA441iCuvWSb6PVSsEzMHQygMHdV1dkqAHp3visGkwX5NBUmqGAWmG091wuSlaF/Y9QzWmFvuEzI/0AJo9s9oRB4f4ceGwVJztmj7KD4cwB2m4aBUtdLu6V1d1j46T7QcvkNThhDu6i9B9FvCida4gu+RdA3W0QPlL+E4xni+s0jTO9XRQj2iT2sQCeAzrTG/L4xerj0tF6nQK60Vo4F0uKDaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDz2k+eg8nI89Xt+Yni5wmfv4VOF4wGXu+P0bp1Rarw=;
 b=na1bySCTTmuqvDTWjZnTZX4lftpxaxoAQI0uLkzBcXDcyaTD0ANzLhFllHK/sYQRGSbaVDeGIGarAUv2wrIinIUk9ZT2/aWUDs++7UZ49JkQXQ3u6KYodnD4VHMv1/JeGUSU6qKemEyQWvOY2NSzMVxH+r6iP8vHTBSxPz+UksBDMed8bZU4NGp5m/9q1jkC8vRn0TpM+o/Mx8mDC803TrWQdepKu3CdfJkfHVcwaVg7OpvzyyMQFNIXaMxOn8PPHQgV9BiKBLdSfZ4JozNJuRTsVSuquMDcDoPqg+MDkgxaZ6fJ5CfQCtto+7gLARohAleDgB8qJ27bnqbs/6vhkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDz2k+eg8nI89Xt+Yni5wmfv4VOF4wGXu+P0bp1Rarw=;
 b=2ztBom+CGfHqHl6fw6cWHSVEnIl+XKyySNOsNAIy4lYGGz0Q7Hm80PZCZEirtwGkBYmYK7U7mTWf0/x2/ROfV29MqLnxQHJzV6ZCBfJ/0KC6UoSgfkAdCE2lN9+zKtlHY2x1hZlXhywdzBKKwmf4SHu+NkaFLXNpp/Hj1WjalpY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 08:06:53 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 08:06:53 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/17] drm/amd/powerplay: move ppfeature mask setting to
 smu_cmn.c
Date: Tue, 14 Jul 2020 16:04:07 +0800
Message-Id: <20200714080416.6506-8-evan.quan@amd.com>
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
 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 08:06:51 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe7b31fe-df58-4e2b-9464-08d827ccde4e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB435505E80234708E9C48A29AE4610@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:109;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qL4NpfyvdTM9K4O6a0xOWmdXDmdK00id5dQ5/eLNxRqykxN/GpgE2ktD8UVol3Ja8+aM8aECVt69ZlXqm2nXqx6eTM+rBYqFNKTp+IliJN/DMkXRawjraT1huLxEWaBMI99Y7855MAFcxPA29fYKEh7qKD1M9LuQB9xjudLLqqutCagume3eYohuvvBIhvWprMQHzjD1NQoiwK0iGOl+inRJyHc3eAsLDzZf6X+SNjclVwob9FpEPT3UwXL0k06MhKUni10aXgpNm8+u0Vz81zSWgNSfo3J5GS/Zj0i0aGmvuztGwQCYl6XrBsUzTgvr3InOzt+vPuud/+iRgv82m5YIpOLSxGTuk7tHlEjrvKzAgAQ+KdSyzH4TZ+0Ff46i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(478600001)(83380400001)(316002)(4326008)(2616005)(8936002)(8676002)(66574015)(36756003)(66946007)(66556008)(1076003)(44832011)(2906002)(956004)(66476007)(6486002)(5660300002)(52116002)(6666004)(186003)(30864003)(86362001)(7696005)(16526019)(26005)(6916009)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /dXdLf8hOt4Bj0wglclMQqlTCkxiZgUSpIa5cW5Bw9U5qScq8JzJsXMdSIEKDw6tbTjGc/VHwqapJq53lEo76nVjHwHp8SQ2fus2ILC9uaQ7wFFl/KJ+mXX86F4a9raDSUbdv/TNAb6b5Mb53jERIB6w3TGK/MLxv5/SlHyBUC0maVKcD1zQYPZVhPcvDj8sgWvuEWVAfqWiP11jN+1Lzl94lPEFBRK4fwaiMHNdNFCEG34y1Ey0VzWP5TwvUWaR5WnSfrBShAup1VUbf2aLrayjTWjcfjReIamdqJVB4xrR66Iyo+Nx5pFz4Arf7OYHSt7XV0ZoXleUT0JVq7sgjCNEbGPCO177gFtdVOJfRKBNq4hXe1ZDK8j/X5fLrVP3+/d4CcAO2Rzy4QV0URIl9z8UgJEXUFl2dd5cZW7PFLJo/DdXSJ3WeKNaFJGxForq+u2/vgiRtcflaC2NXhuw4Ga2+4OqaYExUIsAVEyQDsvRzRj40OtS2vjZshuRUS4D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7b31fe-df58-4e2b-9464-08d827ccde4e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 08:06:53.1447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKiTb+jJl+I9056/6xuGwjRChkWAoIp4baE730zDUPP26UOyq5utObW6vPtuZIyk
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

Considering they are shared by all ASICs. And we are moving
to centralize all feature enablement/support checking and
setting APIs in smu_cmn.c.

Change-Id: I17c5e05237362bdbb41561558ff01deecb6b32a7
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 137 +--------------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |   6 +-
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |   6 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |   2 +
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |   2 +
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |   2 +
 drivers/gpu/drm/amd/powerplay/smu_cmn.c       | 163 ++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/smu_cmn.h       |  10 ++
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |   2 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |   2 +-
 10 files changed, 190 insertions(+), 142 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 820af154734d..d9879cf6255f 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -59,147 +59,33 @@ const char *smu_get_message_name(struct smu_context *smu, enum smu_message_type
 	return __smu_message_names[type];
 }
 
-#undef __SMU_DUMMY_MAP
-#define __SMU_DUMMY_MAP(fea)	#fea
-static const char* __smu_feature_names[] = {
-	SMU_FEATURE_MASKS
-};
-
-const char *smu_get_feature_name(struct smu_context *smu, enum smu_feature_mask feature)
-{
-	if (feature < 0 || feature >= SMU_FEATURE_COUNT)
-		return "unknown smu feature";
-	return __smu_feature_names[feature];
-}
-
 size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
 {
 	size_t size = 0;
-	int ret = 0, i = 0;
-	uint32_t feature_mask[2] = { 0 };
-	int32_t feature_index = 0;
-	uint32_t count = 0;
-	uint32_t sort_feature[SMU_FEATURE_COUNT];
-	uint64_t hw_feature_count = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	ret = smu_feature_get_enabled_mask(smu, feature_mask, 2);
-	if (ret)
-		goto failed;
+	size = smu_get_pp_feature_mask(smu, buf);
 
-	size =  sprintf(buf + size, "features high: 0x%08x low: 0x%08x\n",
-			feature_mask[1], feature_mask[0]);
-
-	for (i = 0; i < SMU_FEATURE_COUNT; i++) {
-		feature_index = smu_cmn_to_asic_specific_index(smu,
-							       CMN2ASIC_MAPPING_FEATURE,
-							       i);
-		if (feature_index < 0)
-			continue;
-		sort_feature[feature_index] = i;
-		hw_feature_count++;
-	}
-
-	for (i = 0; i < hw_feature_count; i++) {
-		size += sprintf(buf + size, "%02d. %-20s (%2d) : %s\n",
-			       count++,
-			       smu_get_feature_name(smu, sort_feature[i]),
-			       i,
-			       !!smu_feature_is_enabled(smu, sort_feature[i]) ?
-			       "enabled" : "disabled");
-	}
-
-failed:
 	mutex_unlock(&smu->mutex);
 
 	return size;
 }
 
-static int smu_feature_update_enable_state(struct smu_context *smu,
-					   uint64_t feature_mask,
-					   bool enabled)
-{
-	struct smu_feature *feature = &smu->smu_feature;
-	int ret = 0;
-
-	if (enabled) {
-		ret = smu_send_smc_msg_with_param(smu,
-						  SMU_MSG_EnableSmuFeaturesLow,
-						  lower_32_bits(feature_mask),
-						  NULL);
-		if (ret)
-			return ret;
-		ret = smu_send_smc_msg_with_param(smu,
-						  SMU_MSG_EnableSmuFeaturesHigh,
-						  upper_32_bits(feature_mask),
-						  NULL);
-		if (ret)
-			return ret;
-	} else {
-		ret = smu_send_smc_msg_with_param(smu,
-						  SMU_MSG_DisableSmuFeaturesLow,
-						  lower_32_bits(feature_mask),
-						  NULL);
-		if (ret)
-			return ret;
-		ret = smu_send_smc_msg_with_param(smu,
-						  SMU_MSG_DisableSmuFeaturesHigh,
-						  upper_32_bits(feature_mask),
-						  NULL);
-		if (ret)
-			return ret;
-	}
-
-	mutex_lock(&feature->mutex);
-	if (enabled)
-		bitmap_or(feature->enabled, feature->enabled,
-				(unsigned long *)(&feature_mask), SMU_FEATURE_MAX);
-	else
-		bitmap_andnot(feature->enabled, feature->enabled,
-				(unsigned long *)(&feature_mask), SMU_FEATURE_MAX);
-	mutex_unlock(&feature->mutex);
-
-	return ret;
-}
-
 int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask)
 {
 	int ret = 0;
-	uint32_t feature_mask[2] = { 0 };
-	uint64_t feature_2_enabled = 0;
-	uint64_t feature_2_disabled = 0;
-	uint64_t feature_enables = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	ret = smu_feature_get_enabled_mask(smu, feature_mask, 2);
-	if (ret)
-		goto out;
-
-	feature_enables = ((uint64_t)feature_mask[1] << 32 | (uint64_t)feature_mask[0]);
-
-	feature_2_enabled  = ~feature_enables & new_mask;
-	feature_2_disabled = feature_enables & ~new_mask;
-
-	if (feature_2_enabled) {
-		ret = smu_feature_update_enable_state(smu, feature_2_enabled, true);
-		if (ret)
-			goto out;
-	}
-	if (feature_2_disabled) {
-		ret = smu_feature_update_enable_state(smu, feature_2_disabled, false);
-		if (ret)
-			goto out;
-	}
+	ret = smu_set_pp_feature_mask(smu, new_mask);
 
-out:
 	mutex_unlock(&smu->mutex);
 
 	return ret;
@@ -527,25 +413,6 @@ static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
 	return ret;
 }
 
-int smu_feature_set_enabled(struct smu_context *smu, enum smu_feature_mask mask,
-			    bool enable)
-{
-	struct smu_feature *feature = &smu->smu_feature;
-	int feature_id;
-
-	feature_id = smu_cmn_to_asic_specific_index(smu,
-						    CMN2ASIC_MAPPING_FEATURE,
-						    mask);
-	if (feature_id < 0)
-		return -EINVAL;
-
-	WARN_ON(feature_id > feature->feature_num);
-
-	return smu_feature_update_enable_state(smu,
-					       1ULL << feature_id,
-					       enable);
-}
-
 static int smu_set_funcs(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = &adev->smu;
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 1fb221c0cce7..568eeebcc0e0 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1837,7 +1837,7 @@ static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 
 	if (enable) {
 		if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_feature_set_enabled(smu, SMU_FEATURE_VCN_PG_BIT, 1);
+			ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_VCN_PG_BIT, 1);
 			if (ret) {
 				dev_err(smu->adev->dev, "[EnableVCNDPM] failed!\n");
 				return ret;
@@ -1846,7 +1846,7 @@ static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 		power_gate->vcn_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_feature_set_enabled(smu, SMU_FEATURE_VCN_PG_BIT, 0);
+			ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_VCN_PG_BIT, 0);
 			if (ret) {
 				dev_err(smu->adev->dev, "[DisableVCNDPM] failed!\n");
 				return ret;
@@ -2301,6 +2301,8 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.set_df_cstate = arcturus_set_df_cstate,
 	.allow_xgmi_power_down = arcturus_allow_xgmi_power_down,
 	.log_thermal_throttling_event = arcturus_log_thermal_throttling_event,
+	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
+	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index cc9822aaf535..42cee69b3163 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -581,6 +581,8 @@ struct pptable_funcs {
 	int (*disable_umc_cdr_12gbps_workaround)(struct smu_context *smu);
 	int (*set_power_source)(struct smu_context *smu, enum smu_power_src_type power_src);
 	void (*log_thermal_throttling_event)(struct smu_context *smu);
+	size_t (*get_pp_feature_mask)(struct smu_context *smu, char *buf);
+	int (*set_pp_feature_mask)(struct smu_context *smu, uint64_t new_mask);
 };
 
 typedef enum {
@@ -724,9 +726,6 @@ extern const struct amd_ip_funcs smu_ip_funcs;
 extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
 extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
 
-extern int smu_feature_set_enabled(struct smu_context *smu,
-				   enum smu_feature_mask mask, bool enable);
-
 int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int argument,
 		     void *table_data, bool drv2smu);
 
@@ -766,7 +765,6 @@ int smu_set_display_count(struct smu_context *smu, uint32_t count);
 int smu_set_ac_dc(struct smu_context *smu);
 bool smu_clk_dpm_is_enabled(struct smu_context *smu, enum smu_clk_type clk_type);
 const char *smu_get_message_name(struct smu_context *smu, enum smu_message_type type);
-const char *smu_get_feature_name(struct smu_context *smu, enum smu_feature_mask feature);
 size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf);
 int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask);
 int smu_force_clk_levels(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 3cf8eebd8247..f8dc08bed908 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2328,6 +2328,8 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.run_btc = navi10_run_btc,
 	.disable_umc_cdr_12gbps_workaround = navi10_disable_umc_cdr_12gbps_workaround,
 	.set_power_source = smu_v11_0_set_power_source,
+	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
+	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 521ab71d1ee8..57756288d0de 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -996,6 +996,8 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.set_soft_freq_limited_range = smu_v12_0_set_soft_freq_limited_range,
 	.set_driver_table_location = smu_v12_0_set_driver_table_location,
 	.is_dpm_running = renoir_is_dpm_running,
+	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
+	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 };
 
 void renoir_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 8431b6ac3e3d..2eabb1f3924b 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -2442,6 +2442,8 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.baco_exit = smu_v11_0_baco_exit,
 	.get_dpm_ultimate_freq = sienna_cichlid_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
+	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
+	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.c b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
index 4a8511c1051f..d0293b3dc9ab 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
@@ -23,6 +23,7 @@
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
 #include "smu_cmn.h"
+#include "smu_internal.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -192,3 +193,165 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 
 	return ret;
 }
+
+static int smu_cmn_feature_update_enable_state(struct smu_context *smu,
+					       uint64_t feature_mask,
+					       bool enabled)
+{
+	struct smu_feature *feature = &smu->smu_feature;
+	int ret = 0;
+
+	if (enabled) {
+		ret = smu_send_smc_msg_with_param(smu,
+						  SMU_MSG_EnableSmuFeaturesLow,
+						  lower_32_bits(feature_mask),
+						  NULL);
+		if (ret)
+			return ret;
+		ret = smu_send_smc_msg_with_param(smu,
+						  SMU_MSG_EnableSmuFeaturesHigh,
+						  upper_32_bits(feature_mask),
+						  NULL);
+		if (ret)
+			return ret;
+	} else {
+		ret = smu_send_smc_msg_with_param(smu,
+						  SMU_MSG_DisableSmuFeaturesLow,
+						  lower_32_bits(feature_mask),
+						  NULL);
+		if (ret)
+			return ret;
+		ret = smu_send_smc_msg_with_param(smu,
+						  SMU_MSG_DisableSmuFeaturesHigh,
+						  upper_32_bits(feature_mask),
+						  NULL);
+		if (ret)
+			return ret;
+	}
+
+	mutex_lock(&feature->mutex);
+	if (enabled)
+		bitmap_or(feature->enabled, feature->enabled,
+				(unsigned long *)(&feature_mask), SMU_FEATURE_MAX);
+	else
+		bitmap_andnot(feature->enabled, feature->enabled,
+				(unsigned long *)(&feature_mask), SMU_FEATURE_MAX);
+	mutex_unlock(&feature->mutex);
+
+	return ret;
+}
+
+int smu_cmn_feature_set_enabled(struct smu_context *smu,
+				enum smu_feature_mask mask,
+				bool enable)
+{
+	struct smu_feature *feature = &smu->smu_feature;
+	int feature_id;
+
+	feature_id = smu_cmn_to_asic_specific_index(smu,
+						    CMN2ASIC_MAPPING_FEATURE,
+						    mask);
+	if (feature_id < 0)
+		return -EINVAL;
+
+	WARN_ON(feature_id > feature->feature_num);
+
+	return smu_cmn_feature_update_enable_state(smu,
+					       1ULL << feature_id,
+					       enable);
+}
+
+#undef __SMU_DUMMY_MAP
+#define __SMU_DUMMY_MAP(fea)	#fea
+static const char* __smu_feature_names[] = {
+	SMU_FEATURE_MASKS
+};
+
+static const char *smu_get_feature_name(struct smu_context *smu,
+					enum smu_feature_mask feature)
+{
+	if (feature < 0 || feature >= SMU_FEATURE_COUNT)
+		return "unknown smu feature";
+	return __smu_feature_names[feature];
+}
+
+size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
+				   char *buf)
+{
+	uint32_t feature_mask[2] = { 0 };
+	int32_t feature_index = 0;
+	uint32_t count = 0;
+	uint32_t sort_feature[SMU_FEATURE_COUNT];
+	uint64_t hw_feature_count = 0;
+	size_t size = 0;
+	int ret = 0, i;
+
+	ret = smu_cmn_get_enabled_mask(smu,
+				       feature_mask,
+				       2);
+	if (ret)
+		return 0;
+
+	size =  sprintf(buf + size, "features high: 0x%08x low: 0x%08x\n",
+			feature_mask[1], feature_mask[0]);
+
+	for (i = 0; i < SMU_FEATURE_COUNT; i++) {
+		feature_index = smu_cmn_to_asic_specific_index(smu,
+							       CMN2ASIC_MAPPING_FEATURE,
+							       i);
+		if (feature_index < 0)
+			continue;
+		sort_feature[feature_index] = i;
+		hw_feature_count++;
+	}
+
+	for (i = 0; i < hw_feature_count; i++) {
+		size += sprintf(buf + size, "%02d. %-20s (%2d) : %s\n",
+			       count++,
+			       smu_get_feature_name(smu, sort_feature[i]),
+			       i,
+			       !!smu_cmn_feature_is_enabled(smu, sort_feature[i]) ?
+			       "enabled" : "disabled");
+	}
+
+	return size;
+}
+
+int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
+				uint64_t new_mask)
+{
+	int ret = 0;
+	uint32_t feature_mask[2] = { 0 };
+	uint64_t feature_2_enabled = 0;
+	uint64_t feature_2_disabled = 0;
+	uint64_t feature_enables = 0;
+
+	ret = smu_cmn_get_enabled_mask(smu,
+				       feature_mask,
+				       2);
+	if (ret)
+		return ret;
+
+	feature_enables = ((uint64_t)feature_mask[1] << 32 |
+			   (uint64_t)feature_mask[0]);
+
+	feature_2_enabled  = ~feature_enables & new_mask;
+	feature_2_disabled = feature_enables & ~new_mask;
+
+	if (feature_2_enabled) {
+		ret = smu_cmn_feature_update_enable_state(smu,
+							  feature_2_enabled,
+							  true);
+		if (ret)
+			return ret;
+	}
+	if (feature_2_disabled) {
+		ret = smu_cmn_feature_update_enable_state(smu,
+							  feature_2_disabled,
+							  false);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.h b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
index fc271aa7d39c..36a2931a4ab3 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
@@ -39,4 +39,14 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 			     uint32_t *feature_mask,
 			     uint32_t num);
 
+int smu_cmn_feature_set_enabled(struct smu_context *smu,
+				enum smu_feature_mask mask,
+				bool enable);
+
+size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
+				   char *buf);
+
+int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
+				uint64_t new_mask);
+
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index ee904811d31d..94f3ba092637 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -91,5 +91,7 @@
 #define smu_get_unique_id(smu)						smu_ppt_funcs(get_unique_id, 0, smu)
 #define smu_log_thermal_throttling(smu)					smu_ppt_funcs(log_thermal_throttling_event, 0, smu)
 #define smu_get_asic_power_limits(smu)					smu_ppt_funcs(get_power_limit, 0, smu)
+#define smu_get_pp_feature_mask(smu, buf)				smu_ppt_funcs(get_pp_feature_mask, 0, smu, buf)
+#define smu_set_pp_feature_mask(smu, new_mask)				smu_ppt_funcs(set_pp_feature_mask, 0, smu, new_mask)
 
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index efe77c87dad0..50735f67c16d 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1204,7 +1204,7 @@ smu_v11_0_auto_fan_control(struct smu_context *smu, bool auto_fan_control)
 	if (!smu_cmn_feature_is_supported(smu, SMU_FEATURE_FAN_CONTROL_BIT))
 		return 0;
 
-	ret = smu_feature_set_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT, auto_fan_control);
+	ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT, auto_fan_control);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s]%s smc FAN CONTROL feature failed!",
 		       __func__, (auto_fan_control ? "Start" : "Stop"));
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
