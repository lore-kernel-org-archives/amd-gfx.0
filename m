Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A1FC433F7
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E5321582
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yPwIg89l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E5321582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8302B89A62;
	Tue, 14 Jul 2020 08:07:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D4B2899D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZ7dF0zKhKwsWzqncXbm++K/iWJ7xZN2aAHNXE972jjFVNkPOrzjkICl8HGf1Yj9cc8yOb8Qj31FJaeCalE78vpH5ZlfjRDs2nbhNzOq44mnY5+jW6+vREB0a4yoR9sgj5jGwHlEQVNhWakNFuthN/1/27WhDxJX/xZ1pTHkL2iKLHNiBgut0HX6tt/UP9Ps8yvVyreO+mkHnC7u69J1mE7yvkY98W1OWXmKJY8bEHTGAPCAuWauNTEP16HJZ7qAwmqHG8jFRpX6+yRc3ijjU0+Ul4KGSVQPxS66rn8u5/HpwDvE0SCe9LYY2+mhlu3bc5mCS3nfoqVgnyL58XA2+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+j2wTTA03+MoYhNhxFdHKu/fOL6xV0ZA4Ht0hmRXf4=;
 b=CsJPCf5UdGwvq6pqJvnn7AiMo1dstwFwH6nTIjwZ/wOcJEQMZCpq1vUy/z05eWxAi2A1/nDMYswPCqZj3eaI22a1f6KaQgBch/JKp8lhDZ7kgO2AklnSjCwe+QK9aIS3A5EsZiIWhQzU5tgUD+Pic5HByYlOF7Aw6sTIUIeXD7HXwasvj1kHB9M8c+PeZyaFLylirP8m0GkYCyQszgCNgx0aP1eVMTzQcmrnSuiUQHVrnUr0g/jNNiD8RUQGRg+HxnstEHu2u1z1LM51DcIAhDyYCDvs8n1Ke6G3dOR1lkQHWWBOwWeVIOzuekGpiwpGIj3z9TB1PXhB1u8qO0A61A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+j2wTTA03+MoYhNhxFdHKu/fOL6xV0ZA4Ht0hmRXf4=;
 b=yPwIg89lZ+s0/DmEyJs5I7s65HDLYZBnclisdFAmHxMvVHSKU1Kf4wLiI10ZBlhB1Gc1L1s92vovfF4HJgLp8SotSVeOB5BRUJ6muby24WiCrfV7fX8g592kcALuBZZqMzXk9RnORhN1j8+7QtfC+PN7K0Q/qd/hnqX4os3uYoE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 08:07:09 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 08:07:09 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/17] drm/amd/powerplay: move SMC message issuing APIs to
 smu_cmn.c
Date: Tue, 14 Jul 2020 16:04:13 +0800
Message-Id: <20200714080416.6506-14-evan.quan@amd.com>
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
 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 08:07:07 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1c83f2fa-eb12-4e90-ba66-08d827cce7a4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43554E512DBA96C1577EB6C2E4610@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/uKOfCsGov3mLbZmaFVco4w0lcE3piWbXQgEX8Tnif9FkS6RkE6VdBoJgKiz5XVHwKOgDfrMnk01kF46AVwZvQ7MgLipSK+NRRCV2JcP+pq82iCez5G/8tcIJaiai+GmdZmOdjYaw1cNQJRf25wdMmf5M+hnXwAx2WNogjWQ0ZhaUbDLlJ77eqnwx7r/ORw1AFYLxIM4E2qiG6pPYMsCsM1/BNt9y7w2G6uk9Fd72X0VAvE3X4jiCpbT3xMeCOK8aTRxypnEH20CizvMPjHTrbx0bD0jCMcZ5+smwD6R1/EPGkmSLKrLOwbziMixCy6X4+yB7liuQ9mWJas0hYMiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(478600001)(83380400001)(316002)(4326008)(2616005)(8936002)(8676002)(66574015)(36756003)(66946007)(66556008)(1076003)(44832011)(2906002)(956004)(66476007)(6486002)(5660300002)(52116002)(6666004)(186003)(30864003)(86362001)(7696005)(15650500001)(16526019)(26005)(6916009)(19627235002)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: M8gOmXnazAGCkhr47sHvdXO6zyN3ZFDMll1JDAvleN5SJVFqk/h/NQPyPtQZkF4ItvCZsnJq4Rlo8T3X4uP59tQgUhDQ9f/h1vHHi1kcBis1c4Xi7w487ZC2mCW7kg2OhavGAVuAiNXUv1qcfgcPc0GS6NmQrQAjD751AldBNGRAnmy9XrebMdsUmqaRidKuWvf+EE5WOPcPMKl6ZjeYfZzwiswisT4bu8X551TnoCvGdWUKmGn7dcKLrss2LMVEbglAaPq0SxImxWM7MxxgKjQfQxczg6eqkSfc0YNkXc/FLwBVk5zE+wBghTpSFfFuw4Bm1W2euhXmwwVY2ERzm9C2dZYktUpKbGLQ2wxr8n4xqqgLWIyDUJ4IVMSVmGipON/WJ8dQsayz8jBRA+u52FIpRbmpZQCJVu1bhsDmAoroBdwKQsCD7u6YBMtv6XAcgjAwHrkNwNCJFWxllIWfXjpimoGFv5GRkO+vkoTjwaP3F2IL/hyuWWKc67r+QH6Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c83f2fa-eb12-4e90-ba66-08d827cce7a4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 08:07:08.8947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTO0uOtrDN1H4+8887LzQpU16Re4KmaQ0QfyBiY/vY8PyZYo2a0trJOJbpNe0ETR
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

Considering they can be shared by all ASICs.

Change-Id: I203bbb2e045dd7d936c927f52c4f809ffd5f91db
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  13 --
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  25 +--
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |   4 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |   6 -
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |  11 --
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  29 ++--
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  29 ++--
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  25 +--
 drivers/gpu/drm/amd/powerplay/smu_cmn.c       | 139 +++++++++++++++-
 drivers/gpu/drm/amd/powerplay/smu_cmn.h       |   9 +
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |   2 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 157 ++++--------------
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 114 ++-----------
 13 files changed, 251 insertions(+), 312 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index bc085e2302d4..849adc946505 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -46,19 +46,6 @@
 #undef pr_info
 #undef pr_debug
 
-#undef __SMU_DUMMY_MAP
-#define __SMU_DUMMY_MAP(type)	#type
-static const char* __smu_message_names[] = {
-	SMU_MESSAGE_TYPES
-};
-
-const char *smu_get_message_name(struct smu_context *smu, enum smu_message_type type)
-{
-	if (type < 0 || type >= SMU_MSG_MAX_COUNT)
-		return "unknown smu message";
-	return __smu_message_names[type];
-}
-
 size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
 {
 	size_t size = 0;
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 78e0917f7840..59859eb4796f 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -454,13 +454,13 @@ static int arcturus_run_btc(struct smu_context *smu)
 {
 	int ret = 0;
 
-	ret = smu_send_smc_msg(smu, SMU_MSG_RunAfllBtc, NULL);
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_RunAfllBtc, NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "RunAfllBtc failed!\n");
 		return ret;
 	}
 
-	return smu_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
+	return smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
 }
 
 static int arcturus_populate_umd_state_clk(struct smu_context *smu)
@@ -838,7 +838,7 @@ static int arcturus_upload_dpm_level(struct smu_context *smu,
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
 	    (feature_mask & FEATURE_DPM_GFXCLK_MASK)) {
 		freq = dpm_context->dpm_tables.gfx_table.dpm_levels[level].value;
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_smc_msg_with_param(smu,
 			(max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
 			(PPCLK_GFXCLK << 16) | (freq & 0xffff),
 			NULL);
@@ -852,7 +852,7 @@ static int arcturus_upload_dpm_level(struct smu_context *smu,
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
 	    (feature_mask & FEATURE_DPM_UCLK_MASK)) {
 		freq = dpm_context->dpm_tables.uclk_table.dpm_levels[level].value;
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_smc_msg_with_param(smu,
 			(max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
 			(PPCLK_UCLK << 16) | (freq & 0xffff),
 			NULL);
@@ -866,7 +866,7 @@ static int arcturus_upload_dpm_level(struct smu_context *smu,
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT) &&
 	    (feature_mask & FEATURE_DPM_SOCCLK_MASK)) {
 		freq = dpm_context->dpm_tables.soc_table.dpm_levels[level].value;
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_smc_msg_with_param(smu,
 			(max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
 			(PPCLK_SOCCLK << 16) | (freq & 0xffff),
 			NULL);
@@ -1357,7 +1357,7 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	ret = smu_send_smc_msg_with_param(smu,
+	ret = smu_cmn_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetWorkloadMask,
 					  1 << workload_type,
 					  NULL);
@@ -2123,8 +2123,8 @@ static void arcturus_get_unique_id(struct smu_context *smu)
 	}
 
 	/* Get the SN to turn into a Unique ID */
-	smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumTop32, &top32);
-	smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumBottom32, &bottom32);
+	smu_cmn_send_smc_msg(smu, SMU_MSG_ReadSerialNumTop32, &top32);
+	smu_cmn_send_smc_msg(smu, SMU_MSG_ReadSerialNumBottom32, &bottom32);
 
 	id = ((uint64_t)bottom32 << 32) | top32;
 	adev->unique_id = id;
@@ -2164,7 +2164,7 @@ static int arcturus_set_df_cstate(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	return smu_send_smc_msg_with_param(smu, SMU_MSG_DFCstateControl, state, NULL);
+	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DFCstateControl, state, NULL);
 }
 
 static int arcturus_allow_xgmi_power_down(struct smu_context *smu, bool en)
@@ -2185,12 +2185,12 @@ static int arcturus_allow_xgmi_power_down(struct smu_context *smu, bool en)
 	}
 
 	if (en)
-		return smu_send_smc_msg_with_param(smu,
+		return smu_cmn_send_smc_msg_with_param(smu,
 						   SMU_MSG_GmiPwrDnControl,
 						   1,
 						   NULL);
 
-	return smu_send_smc_msg_with_param(smu,
+	return smu_cmn_send_smc_msg_with_param(smu,
 					   SMU_MSG_GmiPwrDnControl,
 					   0,
 					   NULL);
@@ -2283,7 +2283,8 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.system_features_control = smu_v11_0_system_features_control,
-	.send_smc_msg_with_param = smu_v11_0_send_msg_with_param,
+	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
+	.send_smc_msg = smu_cmn_send_smc_msg,
 	.init_display_count = NULL,
 	.set_allowed_mask = smu_v11_0_set_allowed_mask,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index e2fa68fa862e..05bd6c0d6d7c 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -528,6 +528,9 @@ struct pptable_funcs {
 	int (*system_features_control)(struct smu_context *smu, bool en);
 	int (*send_smc_msg_with_param)(struct smu_context *smu,
 				       enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
+	int (*send_smc_msg)(struct smu_context *smu,
+			    enum smu_message_type msg,
+			    uint32_t *read_arg);
 	int (*init_display_count)(struct smu_context *smu, uint32_t count);
 	int (*set_allowed_mask)(struct smu_context *smu);
 	int (*get_enabled_mask)(struct smu_context *smu, uint32_t *feature_mask, uint32_t num);
@@ -758,7 +761,6 @@ enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *smu);
 int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level);
 int smu_set_display_count(struct smu_context *smu, uint32_t count);
 int smu_set_ac_dc(struct smu_context *smu);
-const char *smu_get_message_name(struct smu_context *smu, enum smu_message_type type);
 size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf);
 int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask);
 int smu_force_clk_levels(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 6f1377282ce3..e9a3bd294876 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -168,12 +168,6 @@ int smu_v11_0_notify_memory_pool_location(struct smu_context *smu);
 int smu_v11_0_system_features_control(struct smu_context *smu,
 					     bool en);
 
-int
-smu_v11_0_send_msg_with_param(struct smu_context *smu,
-			      enum smu_message_type msg,
-			      uint32_t param,
-			      uint32_t *read_arg);
-
 int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count);
 
 int smu_v11_0_set_allowed_mask(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
index e3db0fe1f2c3..52cdd6a0f99a 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
@@ -31,17 +31,6 @@
 #define MP1_Public			0x03b00000
 #define MP1_SRAM			0x03c00004
 
-int smu_v12_0_send_msg_without_waiting(struct smu_context *smu,
-					      uint16_t msg);
-
-int smu_v12_0_wait_for_response(struct smu_context *smu);
-
-int
-smu_v12_0_send_msg_with_param(struct smu_context *smu,
-			      enum smu_message_type msg,
-			      uint32_t param,
-			      uint32_t *read_arg);
-
 int smu_v12_0_check_fw_status(struct smu_context *smu);
 
 int smu_v12_0_check_fw_version(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index d6edd2a4eb2d..32719ca93b46 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -785,14 +785,14 @@ static int navi10_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 	if (enable) {
 		/* vcn dpm on is a prerequisite for vcn power gate messages */
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 1, NULL);
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 1, NULL);
 			if (ret)
 				return ret;
 		}
 		power_gate->vcn_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_send_smc_msg(smu, SMU_MSG_PowerDownVcn, NULL);
+			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PowerDownVcn, NULL);
 			if (ret)
 				return ret;
 		}
@@ -810,14 +810,14 @@ static int navi10_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 
 	if (enable) {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
-			ret = smu_send_smc_msg(smu, SMU_MSG_PowerUpJpeg, NULL);
+			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PowerUpJpeg, NULL);
 			if (ret)
 				return ret;
 		}
 		power_gate->jpeg_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
-			ret = smu_send_smc_msg(smu, SMU_MSG_PowerDownJpeg, NULL);
+			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PowerDownJpeg, NULL);
 			if (ret)
 				return ret;
 		}
@@ -1257,7 +1257,7 @@ static int navi10_pre_display_config_changed(struct smu_context *smu)
 	int ret = 0;
 	uint32_t max_freq = 0;
 
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, 0, NULL);
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, 0, NULL);
 	if (ret)
 		return ret;
 
@@ -1280,7 +1280,7 @@ static int navi10_display_config_changed(struct smu_context *smu)
 	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
 	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
 	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays,
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays,
 						  smu->display_config->num_display,
 						  NULL);
 		if (ret)
@@ -1540,7 +1540,7 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
-	smu_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+	smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
 				    1 << workload_type, NULL);
 
 	return ret;
@@ -1563,7 +1563,7 @@ static int navi10_notify_smc_display_config(struct smu_context *smu)
 		ret = smu_v11_0_display_clock_voltage_request(smu, &clock_req);
 		if (!ret) {
 			if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
-				ret = smu_send_smc_msg_with_param(smu,
+				ret = smu_cmn_send_smc_msg_with_param(smu,
 								  SMU_MSG_SetMinDeepSleepDcefclk,
 								  min_clocks.dcef_clock_in_sr/100,
 								  NULL);
@@ -1883,7 +1883,7 @@ static int navi10_update_pcie_parameters(struct smu_context *smu,
 			((pptable->PcieGenSpeed[i] <= pcie_gen_cap) ? (pptable->PcieGenSpeed[i] << 8) :
 				(pcie_gen_cap << 8)) | ((pptable->PcieLaneCount[i] <= pcie_width_cap) ?
 					pptable->PcieLaneCount[i] : pcie_width_cap);
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_smc_msg_with_param(smu,
 					  SMU_MSG_OverridePcieParameters,
 					  smu_pcie_arg,
 					  NULL);
@@ -1935,7 +1935,7 @@ static int navi10_overdrive_get_gfx_clk_base_voltage(struct smu_context *smu,
 	uint32_t value = 0;
 	int ret;
 
-	ret = smu_send_smc_msg_with_param(smu,
+	ret = smu_cmn_send_smc_msg_with_param(smu,
 					  SMU_MSG_GetVoltageByDpm,
 					  param,
 					  &value);
@@ -2183,7 +2183,7 @@ static int navi10_run_btc(struct smu_context *smu)
 {
 	int ret = 0;
 
-	ret = smu_send_smc_msg(smu, SMU_MSG_RunBtc, NULL);
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_RunBtc, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "RunBtc failed!\n");
 
@@ -2195,9 +2195,9 @@ static int navi10_dummy_pstate_control(struct smu_context *smu, bool enable)
 	int result = 0;
 
 	if (!enable)
-		result = smu_send_smc_msg(smu, SMU_MSG_DAL_DISABLE_DUMMY_PSTATE_CHANGE, NULL);
+		result = smu_cmn_send_smc_msg(smu, SMU_MSG_DAL_DISABLE_DUMMY_PSTATE_CHANGE, NULL);
 	else
-		result = smu_send_smc_msg(smu, SMU_MSG_DAL_ENABLE_DUMMY_PSTATE_CHANGE, NULL);
+		result = smu_cmn_send_smc_msg(smu, SMU_MSG_DAL_ENABLE_DUMMY_PSTATE_CHANGE, NULL);
 
 	return result;
 }
@@ -2304,7 +2304,8 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.system_features_control = smu_v11_0_system_features_control,
-	.send_smc_msg_with_param = smu_v11_0_send_msg_with_param,
+	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
+	.send_smc_msg = smu_cmn_send_smc_msg,
 	.init_display_count = smu_v11_0_init_display_count,
 	.set_allowed_mask = smu_v11_0_set_allowed_mask,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 83915adcec76..fdf27bb90777 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -272,7 +272,7 @@ static int renoir_get_dpm_ultimate_freq(struct smu_context *smu,
 		switch (clk_type) {
 		case SMU_GFXCLK:
 		case SMU_SCLK:
-			ret = smu_send_smc_msg(smu, SMU_MSG_GetMaxGfxclkFrequency, max);
+			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetMaxGfxclkFrequency, max);
 			if (ret) {
 				dev_err(smu->adev->dev, "Attempt to get max GX frequency from SMC Failed !\n");
 				goto failed;
@@ -300,7 +300,7 @@ static int renoir_get_dpm_ultimate_freq(struct smu_context *smu,
 		switch (clk_type) {
 		case SMU_GFXCLK:
 		case SMU_SCLK:
-			ret = smu_send_smc_msg(smu, SMU_MSG_GetMinGfxclkFrequency, min);
+			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetMinGfxclkFrequency, min);
 			if (ret) {
 				dev_err(smu->adev->dev, "Attempt to get min GX frequency from SMC Failed !\n");
 				goto failed;
@@ -444,14 +444,14 @@ static int renoir_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 	if (enable) {
 		/* vcn dpm on is a prerequisite for vcn power gate messages */
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0, NULL);
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0, NULL);
 			if (ret)
 				return ret;
 		}
 		power_gate->vcn_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_send_smc_msg(smu, SMU_MSG_PowerDownVcn, NULL);
+			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PowerDownVcn, NULL);
 			if (ret)
 				return ret;
 		}
@@ -469,14 +469,14 @@ static int renoir_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 
 	if (enable) {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
 			if (ret)
 				return ret;
 		}
 		power_gate->jpeg_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
 			if (ret)
 				return ret;
 		}
@@ -668,13 +668,13 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 		ret = renoir_get_dpm_ultimate_freq(smu, SMU_GFXCLK, &min_freq, &max_freq);
 		if (ret)
 			return ret;
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
 					soft_max_level == 0 ? min_freq :
 					soft_max_level == 1 ? RENOIR_UMD_PSTATE_GFXCLK : max_freq,
 					NULL);
 		if (ret)
 			return ret;
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
 					soft_min_level == 2 ? max_freq :
 					soft_min_level == 1 ? RENOIR_UMD_PSTATE_GFXCLK : min_freq,
 					NULL);
@@ -684,10 +684,10 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 	case SMU_SOCCLK:
 		GET_DPM_CUR_FREQ(clk_table, clk_type, soft_min_level, min_freq);
 		GET_DPM_CUR_FREQ(clk_table, clk_type, soft_max_level, max_freq);
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxSocclkByFreq, max_freq, NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxSocclkByFreq, max_freq, NULL);
 		if (ret)
 			return ret;
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinSocclkByFreq, min_freq, NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinSocclkByFreq, min_freq, NULL);
 		if (ret)
 			return ret;
 		break;
@@ -695,10 +695,10 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 	case SMU_FCLK:
 		GET_DPM_CUR_FREQ(clk_table, clk_type, soft_min_level, min_freq);
 		GET_DPM_CUR_FREQ(clk_table, clk_type, soft_max_level, max_freq);
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxFclkByFreq, max_freq, NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxFclkByFreq, max_freq, NULL);
 		if (ret)
 			return ret;
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinFclkByFreq, min_freq, NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinFclkByFreq, min_freq, NULL);
 		if (ret)
 			return ret;
 		break;
@@ -732,7 +732,7 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 		return -EINVAL;
 	}
 
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
 				    1 << workload_type,
 				    NULL);
 	if (ret) {
@@ -982,7 +982,8 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.check_fw_status = smu_v12_0_check_fw_status,
 	.check_fw_version = smu_v12_0_check_fw_version,
 	.powergate_sdma = smu_v12_0_powergate_sdma,
-	.send_smc_msg_with_param = smu_v12_0_send_msg_with_param,
+	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
+	.send_smc_msg = smu_cmn_send_smc_msg,
 	.set_gfx_cgpg = smu_v12_0_set_gfx_cgpg,
 	.gfx_off_control = smu_v12_0_gfx_off_control,
 	.init_smc_tables = renoir_init_smc_tables,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index bd9594891d5f..ace46022cf0d 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -751,20 +751,20 @@ static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enabl
 	if (enable) {
 		/* vcn dpm on is a prerequisite for vcn power gate messages */
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0, NULL);
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0, NULL);
 			if (ret)
 				return ret;
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0x10000, NULL);
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0x10000, NULL);
 			if (ret)
 				return ret;
 		}
 		power_gate->vcn_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn, 0, NULL);
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn, 0, NULL);
 			if (ret)
 				return ret;
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn, 0x10000, NULL);
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn, 0x10000, NULL);
 			if (ret)
 				return ret;
 		}
@@ -782,14 +782,14 @@ static int sienna_cichlid_dpm_set_jpeg_enable(struct smu_context *smu, bool enab
 
 	if (enable) {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
 			if (ret)
 				return ret;
 		}
 		power_gate->jpeg_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
 			if (ret)
 				return ret;
 		}
@@ -1047,7 +1047,7 @@ static int sienna_cichlid_pre_display_config_changed(struct smu_context *smu)
 	/* Sienna_Cichlid do not support to change display num currently */
 	return 0;
 #if 0
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, 0, NULL);
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, 0, NULL);
 	if (ret)
 		return ret;
 #endif
@@ -1072,7 +1072,7 @@ static int sienna_cichlid_display_config_changed(struct smu_context *smu)
 	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
 	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 #if 0
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays,
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays,
 						  smu->display_config->num_display,
 						  NULL);
 #endif
@@ -1333,7 +1333,7 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
-	smu_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+	smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
 				    1 << workload_type, NULL);
 
 	return ret;
@@ -1356,7 +1356,7 @@ static int sienna_cichlid_notify_smc_display_config(struct smu_context *smu)
 		ret = smu_v11_0_display_clock_voltage_request(smu, &clock_req);
 		if (!ret) {
 			if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
-				ret = smu_send_smc_msg_with_param(smu,
+				ret = smu_cmn_send_smc_msg_with_param(smu,
 								  SMU_MSG_SetMinDeepSleepDcefclk,
 								  min_clocks.dcef_clock_in_sr/100,
 								  NULL);
@@ -1678,7 +1678,7 @@ static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 					pptable->PcieLaneCount[i] :
 					pcie_width_cap);
 
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_smc_msg_with_param(smu,
 					  SMU_MSG_OverridePcieParameters,
 					  smu_pcie_arg,
 					  NULL);
@@ -2424,7 +2424,8 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.system_features_control = smu_v11_0_system_features_control,
-	.send_smc_msg_with_param = smu_v11_0_send_msg_with_param,
+	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
+	.send_smc_msg = smu_cmn_send_smc_msg,
 	.init_display_count = NULL,
 	.set_allowed_mask = smu_v11_0_set_allowed_mask,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.c b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
index 7f5439c649bc..4084c707c04a 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
@@ -24,6 +24,7 @@
 #include "amdgpu_smu.h"
 #include "smu_cmn.h"
 #include "smu_internal.h"
+#include "soc15_common.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -35,6 +36,126 @@
 #undef pr_info
 #undef pr_debug
 
+/*
+ * Although these are defined in each ASIC's specific header file.
+ * They share the same definitions and values. That makes common
+ * APIs for SMC messages issuing for all ASICs possible.
+ */
+#define mmMP1_SMN_C2PMSG_66                                                                            0x0282
+#define mmMP1_SMN_C2PMSG_66_BASE_IDX                                                                   0
+
+#define mmMP1_SMN_C2PMSG_82                                                                            0x0292
+#define mmMP1_SMN_C2PMSG_82_BASE_IDX                                                                   0
+
+#define mmMP1_SMN_C2PMSG_90                                                                            0x029a
+#define mmMP1_SMN_C2PMSG_90_BASE_IDX                                                                   0
+
+#define MP1_C2PMSG_90__CONTENT_MASK                                                                    0xFFFFFFFFL
+
+#undef __SMU_DUMMY_MAP
+#define __SMU_DUMMY_MAP(type)	#type
+static const char* __smu_message_names[] = {
+	SMU_MESSAGE_TYPES
+};
+
+static const char *smu_get_message_name(struct smu_context *smu,
+					enum smu_message_type type)
+{
+	if (type < 0 || type >= SMU_MSG_MAX_COUNT)
+		return "unknown smu message";
+
+	return __smu_message_names[type];
+}
+
+static void smu_cmn_send_msg_without_waiting(struct smu_context *smu,
+					     uint16_t msg)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
+}
+
+static void smu_cmn_read_arg(struct smu_context *smu,
+			     uint32_t *arg)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	*arg = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82);
+}
+
+static int smu_cmn_wait_for_response(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t cur_value, i, timeout = adev->usec_timeout * 10;
+
+	for (i = 0; i < timeout; i++) {
+		cur_value = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
+		if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
+			return cur_value == 0x1 ? 0 : -EIO;
+
+		udelay(1);
+	}
+
+	/* timeout means wrong logic */
+	if (i == timeout)
+		return -ETIME;
+
+	return RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90) == 0x1 ? 0 : -EIO;
+}
+
+int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
+				    enum smu_message_type msg,
+				    uint32_t param,
+				    uint32_t *read_arg)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0, index = 0;
+
+	index = smu_cmn_to_asic_specific_index(smu,
+					       CMN2ASIC_MAPPING_MSG,
+					       msg);
+	if (index < 0)
+		return index == -EACCES ? 0 : index;
+
+	mutex_lock(&smu->message_lock);
+	ret = smu_cmn_wait_for_response(smu);
+	if (ret) {
+		dev_err(adev->dev, "Msg issuing pre-check failed and "
+		       "SMU may be not in the right state!\n");
+		goto out;
+	}
+
+	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
+
+	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
+
+	smu_cmn_send_msg_without_waiting(smu, (uint16_t)index);
+
+	ret = smu_cmn_wait_for_response(smu);
+	if (ret) {
+		dev_err(adev->dev, "failed send message: %10s (%d) \tparam: 0x%08x response %#x\n",
+		       smu_get_message_name(smu, msg), index, param, ret);
+		goto out;
+	}
+
+	if (read_arg)
+		smu_cmn_read_arg(smu, read_arg);
+
+out:
+	mutex_unlock(&smu->message_lock);
+	return ret;
+}
+
+int smu_cmn_send_smc_msg(struct smu_context *smu,
+			 enum smu_message_type msg,
+			 uint32_t *read_arg)
+{
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       msg,
+					       0,
+					       read_arg);
+}
+
 int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 				   enum smu_cmn2asic_mapping_type type,
 				   uint32_t index)
@@ -203,11 +324,11 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 		return -EINVAL;
 
 	if (bitmap_empty(feature->enabled, feature->feature_num)) {
-		ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesHigh, &feature_mask_high);
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesHigh, &feature_mask_high);
 		if (ret)
 			return ret;
 
-		ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesLow, &feature_mask_low);
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesLow, &feature_mask_low);
 		if (ret)
 			return ret;
 
@@ -229,26 +350,26 @@ static int smu_cmn_feature_update_enable_state(struct smu_context *smu,
 	int ret = 0;
 
 	if (enabled) {
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_smc_msg_with_param(smu,
 						  SMU_MSG_EnableSmuFeaturesLow,
 						  lower_32_bits(feature_mask),
 						  NULL);
 		if (ret)
 			return ret;
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_smc_msg_with_param(smu,
 						  SMU_MSG_EnableSmuFeaturesHigh,
 						  upper_32_bits(feature_mask),
 						  NULL);
 		if (ret)
 			return ret;
 	} else {
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_smc_msg_with_param(smu,
 						  SMU_MSG_DisableSmuFeaturesLow,
 						  lower_32_bits(feature_mask),
 						  NULL);
 		if (ret)
 			return ret;
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_smc_msg_with_param(smu,
 						  SMU_MSG_DisableSmuFeaturesHigh,
 						  upper_32_bits(feature_mask),
 						  NULL);
@@ -423,7 +544,7 @@ int smu_cmn_get_smc_version(struct smu_context *smu,
 	}
 
 	if (if_version) {
-		ret = smu_send_smc_msg(smu, SMU_MSG_GetDriverIfVersion, if_version);
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetDriverIfVersion, if_version);
 		if (ret)
 			return ret;
 
@@ -431,7 +552,7 @@ int smu_cmn_get_smc_version(struct smu_context *smu,
 	}
 
 	if (smu_version) {
-		ret = smu_send_smc_msg(smu, SMU_MSG_GetSmuVersion, smu_version);
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSmuVersion, smu_version);
 		if (ret)
 			return ret;
 
@@ -469,7 +590,7 @@ int smu_cmn_update_table(struct smu_context *smu,
 		amdgpu_asic_flush_hdp(adev, NULL);
 	}
 
-	ret = smu_send_smc_msg_with_param(smu, drv2smu ?
+	ret = smu_cmn_send_smc_msg_with_param(smu, drv2smu ?
 					  SMU_MSG_TransferTableDram2Smu :
 					  SMU_MSG_TransferTableSmu2Dram,
 					  table_id | ((argument & 0xFFFF) << 16),
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.h b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
index 214e7787559a..e07ff6330c54 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
@@ -25,6 +25,15 @@
 
 #include "amdgpu_smu.h"
 
+int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
+				    enum smu_message_type msg,
+				    uint32_t param,
+				    uint32_t *read_arg);
+
+int smu_cmn_send_smc_msg(struct smu_context *smu,
+			 enum smu_message_type msg,
+			 uint32_t *read_arg);
+
 int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 				   enum smu_cmn2asic_mapping_type type,
 				   uint32_t index);
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index b38ff35f3625..e221bd2c466a 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -49,7 +49,7 @@
 #define smu_init_max_sustainable_clocks(smu)				smu_ppt_funcs(init_max_sustainable_clocks, 0, smu)
 #define smu_set_default_od_settings(smu)				smu_ppt_funcs(set_default_od_settings, 0, smu)
 #define smu_send_smc_msg_with_param(smu, msg, param, read_arg)		smu_ppt_funcs(send_smc_msg_with_param, 0, smu, msg, param, read_arg)
-#define smu_send_smc_msg(smu, msg, read_arg)				smu_ppt_funcs(send_smc_msg_with_param, 0, smu, msg, 0, read_arg)
+#define smu_send_smc_msg(smu, msg, read_arg)				smu_ppt_funcs(send_smc_msg, 0, smu, msg, read_arg)
 #define smu_init_display_count(smu, count)				smu_ppt_funcs(init_display_count, 0, smu, count)
 #define smu_feature_set_allowed_mask(smu)				smu_ppt_funcs(set_allowed_mask, 0, smu)
 #define smu_feature_get_enabled_mask(smu, mask, num)			smu_ppt_funcs(get_enabled_mask, 0, smu, mask, num)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index ee8a6ddef8e7..dd45f271d2be 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -63,91 +63,6 @@ MODULE_FIRMWARE("amdgpu/sienna_cichlid_smc.bin");
 
 #define SMU11_VOLTAGE_SCALE 4
 
-static int smu_v11_0_send_msg_without_waiting(struct smu_context *smu,
-					      uint16_t msg)
-{
-	struct amdgpu_device *adev = smu->adev;
-	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
-	return 0;
-}
-
-static int smu_v11_0_read_arg(struct smu_context *smu, uint32_t *arg)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	*arg = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82);
-	return 0;
-}
-
-static int smu_v11_0_wait_for_response(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t cur_value, i, timeout = adev->usec_timeout * 10;
-
-	for (i = 0; i < timeout; i++) {
-		cur_value = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
-		if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
-			return cur_value == 0x1 ? 0 : -EIO;
-
-		udelay(1);
-	}
-
-	/* timeout means wrong logic */
-	if (i == timeout)
-		return -ETIME;
-
-	return RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90) == 0x1 ? 0 : -EIO;
-}
-
-int
-smu_v11_0_send_msg_with_param(struct smu_context *smu,
-			      enum smu_message_type msg,
-			      uint32_t param,
-			      uint32_t *read_arg)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret = 0, index = 0;
-
-	index = smu_cmn_to_asic_specific_index(smu,
-					       CMN2ASIC_MAPPING_MSG,
-					       msg);
-	if (index < 0)
-		return index == -EACCES ? 0 : index;
-
-	mutex_lock(&smu->message_lock);
-	ret = smu_v11_0_wait_for_response(smu);
-	if (ret) {
-		dev_err(adev->dev, "Msg issuing pre-check failed and "
-		       "SMU may be not in the right state!\n");
-		goto out;
-	}
-
-	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
-
-	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
-
-	smu_v11_0_send_msg_without_waiting(smu, (uint16_t)index);
-
-	ret = smu_v11_0_wait_for_response(smu);
-	if (ret) {
-		dev_err(adev->dev, "failed send message: %10s (%d) \tparam: 0x%08x response %#x\n",
-		       smu_get_message_name(smu, msg), index, param, ret);
-		goto out;
-	}
-
-	if (read_arg) {
-		ret = smu_v11_0_read_arg(smu, read_arg);
-		if (ret) {
-			dev_err(adev->dev, "failed to read message arg: %10s (%d) \tparam: 0x%08x response %#x\n",
-			       smu_get_message_name(smu, msg), index, param, ret);
-			goto out;
-		}
-	}
-out:
-	mutex_unlock(&smu->message_lock);
-	return ret;
-}
-
 int smu_v11_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -688,13 +603,13 @@ int smu_v11_0_notify_memory_pool_location(struct smu_context *smu)
 	address_high = (uint32_t)upper_32_bits(address);
 	address_low  = (uint32_t)lower_32_bits(address);
 
-	ret = smu_send_smc_msg_with_param(smu,
+	ret = smu_cmn_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetSystemVirtualDramAddrHigh,
 					  address_high,
 					  NULL);
 	if (ret)
 		return ret;
-	ret = smu_send_smc_msg_with_param(smu,
+	ret = smu_cmn_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetSystemVirtualDramAddrLow,
 					  address_low,
 					  NULL);
@@ -705,15 +620,15 @@ int smu_v11_0_notify_memory_pool_location(struct smu_context *smu)
 	address_high = (uint32_t)upper_32_bits(address);
 	address_low  = (uint32_t)lower_32_bits(address);
 
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramAddrHigh,
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramAddrHigh,
 					  address_high, NULL);
 	if (ret)
 		return ret;
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramAddrLow,
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramAddrLow,
 					  address_low, NULL);
 	if (ret)
 		return ret;
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramSize,
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramSize,
 					  (uint32_t)memory_pool->size, NULL);
 	if (ret)
 		return ret;
@@ -725,7 +640,7 @@ int smu_v11_0_set_min_deep_sleep_dcefclk(struct smu_context *smu, uint32_t clk)
 {
 	int ret;
 
-	ret = smu_send_smc_msg_with_param(smu,
+	ret = smu_cmn_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetMinDeepSleepDcefclk, clk, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "SMU11 attempt to set divider for DCEFCLK Failed!");
@@ -739,12 +654,12 @@ int smu_v11_0_set_driver_table_location(struct smu_context *smu)
 	int ret = 0;
 
 	if (driver_table->mc_address) {
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_smc_msg_with_param(smu,
 				SMU_MSG_SetDriverDramAddrHigh,
 				upper_32_bits(driver_table->mc_address),
 				NULL);
 		if (!ret)
-			ret = smu_send_smc_msg_with_param(smu,
+			ret = smu_cmn_send_smc_msg_with_param(smu,
 				SMU_MSG_SetDriverDramAddrLow,
 				lower_32_bits(driver_table->mc_address),
 				NULL);
@@ -759,12 +674,12 @@ int smu_v11_0_set_tool_table_location(struct smu_context *smu)
 	struct smu_table *tool_table = &smu->smu_table.tables[SMU_TABLE_PMSTATUSLOG];
 
 	if (tool_table->mc_address) {
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_smc_msg_with_param(smu,
 				SMU_MSG_SetToolsDramAddrHigh,
 				upper_32_bits(tool_table->mc_address),
 				NULL);
 		if (!ret)
-			ret = smu_send_smc_msg_with_param(smu,
+			ret = smu_cmn_send_smc_msg_with_param(smu,
 				SMU_MSG_SetToolsDramAddrLow,
 				lower_32_bits(tool_table->mc_address),
 				NULL);
@@ -780,7 +695,7 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
 	if (!smu->pm_enabled)
 		return ret;
 
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, count, NULL);
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, count, NULL);
 	return ret;
 }
 
@@ -797,12 +712,12 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 
 	bitmap_copy((unsigned long *)feature_mask, feature->allowed, 64);
 
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
 					  feature_mask[1], NULL);
 	if (ret)
 		goto failed;
 
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskLow,
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskLow,
 					  feature_mask[0], NULL);
 	if (ret)
 		goto failed;
@@ -819,7 +734,7 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
 	uint32_t feature_mask[2];
 	int ret = 0;
 
-	ret = smu_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
+	ret = smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
 				     SMU_MSG_DisableAllSmuFeatures), NULL);
 	if (ret)
 		return ret;
@@ -850,7 +765,7 @@ int smu_v11_0_notify_display_change(struct smu_context *smu)
 
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
 	    smu->adev->gmc.vram_type == AMDGPU_VRAM_TYPE_HBM)
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL);
 
 	return ret;
 }
@@ -872,7 +787,7 @@ smu_v11_0_get_max_sustainable_clock(struct smu_context *smu, uint32_t *clock,
 	if (clk_id < 0)
 		return -EINVAL;
 
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetDcModeMaxDpmFreq,
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetDcModeMaxDpmFreq,
 					  clk_id << 16, clock);
 	if (ret) {
 		dev_err(smu->adev->dev, "[GetMaxSustainableClock] Failed to get max DC clock from SMC!");
@@ -883,7 +798,7 @@ smu_v11_0_get_max_sustainable_clock(struct smu_context *smu, uint32_t *clock,
 		return 0;
 
 	/* if DC limit is zero, return AC limit */
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetMaxDpmFreq,
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetMaxDpmFreq,
 					  clk_id << 16, clock);
 	if (ret) {
 		dev_err(smu->adev->dev, "[GetMaxSustainableClock] failed to get max AC clock from SMC!");
@@ -987,7 +902,7 @@ int smu_v11_0_get_current_power_limit(struct smu_context *smu,
 	if (power_src < 0)
 		return -EINVAL;
 
-	ret = smu_send_smc_msg_with_param(smu,
+	ret = smu_cmn_send_smc_msg_with_param(smu,
 					  SMU_MSG_GetPptLimit,
 					  power_src << 16,
 					  power_limit);
@@ -1006,7 +921,7 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 		return -EOPNOTSUPP;
 	}
 
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, n, NULL);
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, n, NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "[%s] Set power limit Failed!\n", __func__);
 		return ret;
@@ -1117,9 +1032,9 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-			ret = smu_send_smc_msg(smu, SMU_MSG_AllowGfxOff, NULL);
+			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_AllowGfxOff, NULL);
 		else
-			ret = smu_send_smc_msg(smu, SMU_MSG_DisallowGfxOff, NULL);
+			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_DisallowGfxOff, NULL);
 		break;
 	default:
 		break;
@@ -1255,7 +1170,7 @@ int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
 				     uint32_t pstate)
 {
 	int ret = 0;
-	ret = smu_send_smc_msg_with_param(smu,
+	ret = smu_cmn_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetXgmiMode,
 					  pstate ? XGMI_MODE_PSTATE_D0 : XGMI_MODE_PSTATE_D3,
 					  NULL);
@@ -1329,7 +1244,7 @@ static int smu_v11_0_set_irq_state(struct amdgpu_device *adev,
 
 static int smu_v11_0_ack_ac_dc_interrupt(struct smu_context *smu)
 {
-	return smu_send_smc_msg(smu,
+	return smu_cmn_send_smc_msg(smu,
 				SMU_MSG_ReenableAcDcInterrupt,
 				NULL);
 }
@@ -1487,14 +1402,14 @@ int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu)
 {
 	int ret = 0;
 
-	ret = smu_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
 
 	return ret;
 }
 
 static int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu, enum smu_v11_0_baco_seq baco_seq)
 {
-	return smu_send_smc_msg_with_param(smu, SMU_MSG_ArmD3, baco_seq, NULL);
+	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ArmD3, baco_seq, NULL);
 }
 
 bool smu_v11_0_baco_is_support(struct smu_context *smu)
@@ -1548,12 +1463,12 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 			data |= 0x80000000;
 			WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
 
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 0, NULL);
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 0, NULL);
 		} else {
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 1, NULL);
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 1, NULL);
 		}
 	} else {
-		ret = smu_send_smc_msg(smu, SMU_MSG_ExitBaco, NULL);
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_ExitBaco, NULL);
 		if (ret)
 			goto out;
 
@@ -1646,13 +1561,13 @@ int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 	param = (clk_id & 0xffff) << 16;
 
 	if (max) {
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetMaxDpmFreq, param, max);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetMaxDpmFreq, param, max);
 		if (ret)
 			goto failed;
 	}
 
 	if (min) {
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetMinDpmFreq, param, min);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetMinDpmFreq, param, min);
 		if (ret)
 			goto failed;
 	}
@@ -1684,7 +1599,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 
 	if (max > 0) {
 		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
 						  param, NULL);
 		if (ret)
 			goto out;
@@ -1692,7 +1607,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 
 	if (min > 0) {
 		param = (uint32_t)((clk_id << 16) | (min & 0xffff));
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinByFreq,
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinByFreq,
 						  param, NULL);
 		if (ret)
 			goto out;
@@ -1727,7 +1642,7 @@ int smu_v11_0_set_hard_freq_limited_range(struct smu_context *smu,
 
 	if (max > 0) {
 		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMaxByFreq,
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMaxByFreq,
 						  param, NULL);
 		if (ret)
 			return ret;
@@ -1735,7 +1650,7 @@ int smu_v11_0_set_hard_freq_limited_range(struct smu_context *smu,
 
 	if (min > 0) {
 		param = (uint32_t)((clk_id << 16) | (min & 0xffff));
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinByFreq,
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinByFreq,
 						  param, NULL);
 		if (ret)
 			return ret;
@@ -1856,7 +1771,7 @@ int smu_v11_0_set_power_source(struct smu_context *smu,
 	if (pwr_source < 0)
 		return -EINVAL;
 
-	return smu_send_smc_msg_with_param(smu,
+	return smu_cmn_send_smc_msg_with_param(smu,
 					SMU_MSG_NotifyPowerSource,
 					pwr_source,
 					NULL);
@@ -1884,7 +1799,7 @@ int smu_v11_0_get_dpm_freq_by_index(struct smu_context *smu,
 
 	param = (uint32_t)(((clk_id & 0xffff) << 16) | (level & 0xffff));
 
-	ret = smu_send_smc_msg_with_param(smu,
+	ret = smu_cmn_send_smc_msg_with_param(smu,
 					  SMU_MSG_GetDpmFreqByIndex,
 					  param,
 					  value);
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 60dc35933376..7855e8d88af7 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -53,88 +53,6 @@
 
 #define smnMP1_FIRMWARE_FLAGS                                0x3010024
 
-int smu_v12_0_send_msg_without_waiting(struct smu_context *smu,
-					      uint16_t msg)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
-	return 0;
-}
-
-static int smu_v12_0_read_arg(struct smu_context *smu, uint32_t *arg)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
-	return 0;
-}
-
-int smu_v12_0_wait_for_response(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t cur_value, i;
-
-	for (i = 0; i < adev->usec_timeout; i++) {
-		cur_value = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
-		if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
-			return cur_value == 0x1 ? 0 : -EIO;
-
-		udelay(1);
-	}
-
-	/* timeout means wrong logic */
-	return -ETIME;
-}
-
-int
-smu_v12_0_send_msg_with_param(struct smu_context *smu,
-			      enum smu_message_type msg,
-			      uint32_t param,
-			      uint32_t *read_arg)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret = 0, index = 0;
-
-	index = smu_cmn_to_asic_specific_index(smu,
-					       CMN2ASIC_MAPPING_MSG,
-					       msg);
-	if (index < 0)
-		return index;
-
-	mutex_lock(&smu->message_lock);
-	ret = smu_v12_0_wait_for_response(smu);
-	if (ret) {
-		dev_err(adev->dev, "Msg issuing pre-check failed and "
-		       "SMU may be not in the right state!\n");
-		goto out;
-	}
-
-	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
-
-	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
-
-	smu_v12_0_send_msg_without_waiting(smu, (uint16_t)index);
-
-	ret = smu_v12_0_wait_for_response(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to send message 0x%x, response 0x%x param 0x%x\n",
-		       index, ret, param);
-		goto out;
-	}
-	if (read_arg) {
-		ret = smu_v12_0_read_arg(smu, read_arg);
-		if (ret) {
-			dev_err(adev->dev, "Failed to read message arg 0x%x, response 0x%x param 0x%x\n",
-			       index, ret, param);
-			goto out;
-		}
-	}
-out:
-	mutex_unlock(&smu->message_lock);
-	return ret;
-}
-
 int smu_v12_0_check_fw_status(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -190,9 +108,9 @@ int smu_v12_0_powergate_sdma(struct smu_context *smu, bool gate)
 		return 0;
 
 	if (gate)
-		return smu_send_smc_msg(smu, SMU_MSG_PowerDownSdma, NULL);
+		return smu_cmn_send_smc_msg(smu, SMU_MSG_PowerDownSdma, NULL);
 	else
-		return smu_send_smc_msg(smu, SMU_MSG_PowerUpSdma, NULL);
+		return smu_cmn_send_smc_msg(smu, SMU_MSG_PowerUpSdma, NULL);
 }
 
 int smu_v12_0_set_gfx_cgpg(struct smu_context *smu, bool enable)
@@ -200,7 +118,7 @@ int smu_v12_0_set_gfx_cgpg(struct smu_context *smu, bool enable)
 	if (!(smu->adev->pg_flags & AMD_PG_SUPPORT_GFX_PG))
 		return 0;
 
-	return smu_v12_0_send_msg_with_param(smu,
+	return smu_cmn_send_smc_msg_with_param(smu,
 		SMU_MSG_SetGfxCGPG,
 		enable ? 1 : 0,
 		NULL);
@@ -236,10 +154,10 @@ int smu_v12_0_gfx_off_control(struct smu_context *smu, bool enable)
 	int ret = 0, timeout = 500;
 
 	if (enable) {
-		ret = smu_send_smc_msg(smu, SMU_MSG_AllowGfxOff, NULL);
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_AllowGfxOff, NULL);
 
 	} else {
-		ret = smu_send_smc_msg(smu, SMU_MSG_DisallowGfxOff, NULL);
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_DisallowGfxOff, NULL);
 
 		/* confirm gfx is back to "on" state, timeout is 0.5 second */
 		while (!(smu_v12_0_get_gfxoff_status(smu) == 2)) {
@@ -279,7 +197,7 @@ int smu_v12_0_set_default_dpm_tables(struct smu_context *smu)
 }
 
 int smu_v12_0_mode2_reset(struct smu_context *smu){
-	return smu_v12_0_send_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_2, NULL);
+	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_2, NULL);
 }
 
 int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_type clk_type,
@@ -293,39 +211,39 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk, min, NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk, min, NULL);
 		if (ret)
 			return ret;
 
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk, max, NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk, max, NULL);
 		if (ret)
 			return ret;
 	break;
 	case SMU_FCLK:
 	case SMU_MCLK:
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinFclkByFreq, min, NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinFclkByFreq, min, NULL);
 		if (ret)
 			return ret;
 
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxFclkByFreq, max, NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxFclkByFreq, max, NULL);
 		if (ret)
 			return ret;
 	break;
 	case SMU_SOCCLK:
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinSocclkByFreq, min, NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinSocclkByFreq, min, NULL);
 		if (ret)
 			return ret;
 
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxSocclkByFreq, max, NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxSocclkByFreq, max, NULL);
 		if (ret)
 			return ret;
 	break;
 	case SMU_VCLK:
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinVcn, min, NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinVcn, min, NULL);
 		if (ret)
 			return ret;
 
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxVcn, max, NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxVcn, max, NULL);
 		if (ret)
 			return ret;
 	break;
@@ -342,12 +260,12 @@ int smu_v12_0_set_driver_table_location(struct smu_context *smu)
 	int ret = 0;
 
 	if (driver_table->mc_address) {
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_smc_msg_with_param(smu,
 				SMU_MSG_SetDriverDramAddrHigh,
 				upper_32_bits(driver_table->mc_address),
 				NULL);
 		if (!ret)
-			ret = smu_send_smc_msg_with_param(smu,
+			ret = smu_cmn_send_smc_msg_with_param(smu,
 				SMU_MSG_SetDriverDramAddrLow,
 				lower_32_bits(driver_table->mc_address),
 				NULL);
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
