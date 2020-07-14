Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCCBC433E7
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29DA21582
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S2XoQObT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29DA21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F5A989872;
	Tue, 14 Jul 2020 08:06:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B022895F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0+byPdIKaFzolrSIxlwICtBS1CnCfHp2PnWrDv82ybsavA1jOLTzA66MA924884vriTVQzxeTATIz2Bxa+lY7BTcWJxazdwKx9mU4ts0pOcNDRAEsgZxWRCUTtivwiBw5y4Cjd/HckQOuOqyD8EkROh9ixAwgmlBD9p4uomaEwfQjJGpzRk4mbCPf6Qsyq0pV4HQiaG0S3UmpdBQNlRgDyLhpm3n3FN4Ye6vGEEVHrd5Jft2HOqAmS5XMzNX87e3OBFl74f7M8zxlCmoYnbhFCmBYUwgaqX2Xwq9b6+gRqX8pyfP1T/QApdX5h/y1kpwUeOcAfR/Hm+nayoP5v8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h//Lu6uSkEc+mD9OUXYKWSj9q+pKaKTgVgPEAIS7lTc=;
 b=lKCo0meu/O7AI9Ps1d3/cYBU4G5zUcReGULR4n51etonP7rb0UI0k1JSMPi7C+S1ZjXqZfrAGbxOJoXQvbENKxYh2+enQeaNZD1f9/Ngos6r8eUeKdqG9P/Iv3ScC9a0P4zms6y3zNSy8MVR4qzS3H8ew3TXP+DOxopcCJHOmPbRv0oKDGLjaejnb9xjYsxlxl8Hjj+i0IZrAihgE/pV6sbpZrq9+NyG0/ezp4gf9UlNDNh1hIFTjIrQ9LP/SP+UGhcpFPPKrEvW08BHgh4NVPMIqWH5clfQ6G9G/0Wi+6O/WZg+8dZqg/Fj33Xs/XxsuJezEXbxC1k0GcfIEdAoPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h//Lu6uSkEc+mD9OUXYKWSj9q+pKaKTgVgPEAIS7lTc=;
 b=S2XoQObTu57s2RA8hPSAkpMEXkLQB/3SEU0MicOmsPJq4zXDrh62kDu4ZMw0Dp6bC/RN27ZybOINj4wok7HLu+APH4BXbLJllUNQPIpKXMtXfMHmBsdtG7MXhAAKJiRVbJrdeNMwyDrQc1/HZ14IGqlaTdhR3E1yVXB05NhyS08=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 08:06:50 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 08:06:50 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/17] drm/amd/powerplay: implement smu_cmn_get_enabled_mask()
 for all ASICs
Date: Tue, 14 Jul 2020 16:04:06 +0800
Message-Id: <20200714080416.6506-7-evan.quan@amd.com>
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
 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 08:06:49 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7bc7377c-8ed4-48e2-63ab-08d827ccdca7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4355E0D21274D3F8154C39AAE4610@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:163;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbdRBC6Iz58k1PkjGJNT446Rfhb/GfIl16LkL3z/LdFF6s/CH2RaD/FvBvGz8Br+ARjG1zfKHlaRKKBEA9Xd7d8ZlnGFLR8Z7uD8KTdsQLtSNyz1XxmCj68CBp4uNAUPW1Bx55GwYxZ8IgNrEGU7Jyy7p7lBiLYo1LbLgSEI1Pcnajcs+hSMpedQWnFWcX6NscPcpYgsffN0V6N0bEKmeldwzIIsc/QloI5eYi2cTCTuVOS/j8DuI83gMuVA9E8w9cq8Mpb/XJC/K/aI+llgNjb5Rew4A56VLZmV7xZcCz4ZZXRR7JSM+J/lEpl9Mx565kF6LIXOE8l6/WhfqD6RLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(478600001)(83380400001)(316002)(4326008)(2616005)(8936002)(8676002)(36756003)(66946007)(66556008)(1076003)(44832011)(2906002)(956004)(66476007)(6486002)(5660300002)(52116002)(6666004)(186003)(30864003)(86362001)(7696005)(16526019)(26005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2uMCuzSCq7BDy0hE3afteWjvcSDGBWIfa1gelhZrPgIULza+sOqVGKQhCZVK9dHwbJxG7gbNg2hxhSW2Wc+Nt+oXWGaXSIsll1wne7fRs8IUrn3m/NbltpQRwlPC2yRtNHWyIFsXH5pvmlzK1U5b9p2F/z1SOmVPnEebEKgFqvEeUPXtZfLWGDYRSmop0w7gUmbEhXkSrMkfk+rAI/QC/XzlZCjTH3ppHv1xsvqjAgFQgyteCZY9gJ/bFWNvViX1xWWSTLE0uITenbYJ0xlrXRTcJEXz3MKWAoy/fo0uzRWc74aDz5l7rux2HrB3rhWjsYkXpCSbQYpYGiNw2slp6oBpTKPJ36QtIBA1+x2Jf9snyQ7pL29TLY7Xu110r7QUNo+HdntIpOAr6cxsuA+qOYPHUSXp6t3jLXd50CmuQRfRU4C6dfBA6Vx1EaG2hgfYCDd5waDjyVFkl8WToS2r0lBDKEG/ssxZT9+wINZtpVFlUpattwn6rBC25wy3BXmt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc7377c-8ed4-48e2-63ab-08d827ccdca7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 08:06:50.3553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6PYp1ssoHcPAGZxgAm0JJvQ4Dv7pUz9FZmqUs/szRy9l5UtZuSTeRlXFXe6YVh9
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

Instead of having each for smu v11 and v12.

Change-Id: Ic459c5ea4e047dd13a0e6873c83e1e87ca456d10
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  4 +--
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  3 --
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |  3 --
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  4 +--
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  2 +-
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  4 +--
 drivers/gpu/drm/amd/powerplay/smu_cmn.c       | 30 ++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/smu_cmn.h       |  4 +++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 31 +------------------
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 23 --------------
 10 files changed, 42 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index baf02a74efb6..1fb221c0cce7 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1823,7 +1823,7 @@ static bool arcturus_is_dpm_running(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 	unsigned long feature_enabled;
-	ret = smu_feature_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
 	feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
 			   ((uint64_t)feature_mask[1] << 32));
 	return !!(feature_enabled & SMC_DPM_FEATURE);
@@ -2273,7 +2273,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.send_smc_msg_with_param = smu_v11_0_send_msg_with_param,
 	.init_display_count = NULL,
 	.set_allowed_mask = smu_v11_0_set_allowed_mask,
-	.get_enabled_mask = smu_v11_0_get_enabled_mask,
+	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.notify_display_change = NULL,
 	.set_power_limit = smu_v11_0_set_power_limit,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index df4d7633b04b..70274552e3af 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -180,9 +180,6 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count);
 
 int smu_v11_0_set_allowed_mask(struct smu_context *smu);
 
-int smu_v11_0_get_enabled_mask(struct smu_context *smu,
-				      uint32_t *feature_mask, uint32_t num);
-
 int smu_v11_0_notify_display_change(struct smu_context *smu);
 
 int smu_v11_0_get_current_power_limit(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
index 20652b38f96d..dd3904e8aef0 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
@@ -64,9 +64,6 @@ int smu_v12_0_fini_smc_tables(struct smu_context *smu);
 
 int smu_v12_0_set_default_dpm_tables(struct smu_context *smu);
 
-int smu_v12_0_get_enabled_mask(struct smu_context *smu,
-				      uint32_t *feature_mask, uint32_t num);
-
 int smu_v12_0_mode2_reset(struct smu_context *smu);
 
 int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_type clk_type,
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 6d3ddb6203f8..3cf8eebd8247 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1320,7 +1320,7 @@ static bool navi10_is_dpm_running(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 	unsigned long feature_enabled;
-	ret = smu_feature_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
 	feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
 			   ((uint64_t)feature_mask[1] << 32));
 	return !!(feature_enabled & SMC_DPM_FEATURE);
@@ -2298,7 +2298,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.send_smc_msg_with_param = smu_v11_0_send_msg_with_param,
 	.init_display_count = smu_v11_0_init_display_count,
 	.set_allowed_mask = smu_v11_0_set_allowed_mask,
-	.get_enabled_mask = smu_v11_0_get_enabled_mask,
+	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.notify_display_change = smu_v11_0_notify_display_change,
 	.set_power_limit = smu_v11_0_set_power_limit,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 1d40795b27e6..521ab71d1ee8 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -989,7 +989,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.init_smc_tables = smu_v12_0_init_smc_tables,
 	.fini_smc_tables = smu_v12_0_fini_smc_tables,
 	.set_default_dpm_table = smu_v12_0_set_default_dpm_tables,
-	.get_enabled_mask = smu_v12_0_get_enabled_mask,
+	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.get_dpm_ultimate_freq = renoir_get_dpm_ultimate_freq,
 	.mode2_reset = smu_v12_0_mode2_reset,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index c91aec90ce32..8431b6ac3e3d 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1113,7 +1113,7 @@ static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 	unsigned long feature_enabled;
-	ret = smu_feature_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
 	feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
 			   ((uint64_t)feature_mask[1] << 32));
 	return !!(feature_enabled & SMC_DPM_FEATURE);
@@ -2417,7 +2417,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.send_smc_msg_with_param = smu_v11_0_send_msg_with_param,
 	.init_display_count = NULL,
 	.set_allowed_mask = smu_v11_0_set_allowed_mask,
-	.get_enabled_mask = smu_v11_0_get_enabled_mask,
+	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.notify_display_change = NULL,
 	.set_power_limit = smu_v11_0_set_power_limit,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.c b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
index 24aabca5739e..4a8511c1051f 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
@@ -162,3 +162,33 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
 
 	return ret;
 }
+
+int smu_cmn_get_enabled_mask(struct smu_context *smu,
+			     uint32_t *feature_mask,
+			     uint32_t num)
+{
+	uint32_t feature_mask_high = 0, feature_mask_low = 0;
+	struct smu_feature *feature = &smu->smu_feature;
+	int ret = 0;
+
+	if (!feature_mask || num < 2)
+		return -EINVAL;
+
+	if (bitmap_empty(feature->enabled, feature->feature_num)) {
+		ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesHigh, &feature_mask_high);
+		if (ret)
+			return ret;
+
+		ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesLow, &feature_mask_low);
+		if (ret)
+			return ret;
+
+		feature_mask[0] = feature_mask_low;
+		feature_mask[1] = feature_mask_high;
+	} else {
+		bitmap_copy((unsigned long *)feature_mask, feature->enabled,
+			     feature->feature_num);
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.h b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
index c28ea4df4b32..fc271aa7d39c 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
@@ -35,4 +35,8 @@ int smu_cmn_feature_is_supported(struct smu_context *smu,
 int smu_cmn_feature_is_enabled(struct smu_context *smu,
 			       enum smu_feature_mask mask);
 
+int smu_cmn_get_enabled_mask(struct smu_context *smu,
+			     uint32_t *feature_mask,
+			     uint32_t num);
+
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index f1880f257237..efe77c87dad0 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -871,35 +871,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 	return ret;
 }
 
-int smu_v11_0_get_enabled_mask(struct smu_context *smu,
-				      uint32_t *feature_mask, uint32_t num)
-{
-	uint32_t feature_mask_high = 0, feature_mask_low = 0;
-	struct smu_feature *feature = &smu->smu_feature;
-	int ret = 0;
-
-	if (!feature_mask || num < 2)
-		return -EINVAL;
-
-	if (bitmap_empty(feature->enabled, feature->feature_num)) {
-		ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesHigh, &feature_mask_high);
-		if (ret)
-			return ret;
-
-		ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesLow, &feature_mask_low);
-		if (ret)
-			return ret;
-
-		feature_mask[0] = feature_mask_low;
-		feature_mask[1] = feature_mask_high;
-	} else {
-		bitmap_copy((unsigned long *)feature_mask, feature->enabled,
-			     feature->feature_num);
-	}
-
-	return ret;
-}
-
 int smu_v11_0_system_features_control(struct smu_context *smu,
 					     bool en)
 {
@@ -916,7 +887,7 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
 	bitmap_zero(feature->supported, feature->feature_num);
 
 	if (en) {
-		ret = smu_feature_get_enabled_mask(smu, feature_mask, 2);
+		ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
 		if (ret)
 			return ret;
 
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 7286edec2789..33ec9fc44f4c 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -296,29 +296,6 @@ int smu_v12_0_set_default_dpm_tables(struct smu_context *smu)
 	return smu_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, smu_table->clocks_table, false);
 }
 
-int smu_v12_0_get_enabled_mask(struct smu_context *smu,
-				      uint32_t *feature_mask, uint32_t num)
-{
-	uint32_t feature_mask_high = 0, feature_mask_low = 0;
-	int ret = 0;
-
-	if (!feature_mask || num < 2)
-		return -EINVAL;
-
-	ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesHigh, &feature_mask_high);
-	if (ret)
-		return ret;
-
-	ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesLow, &feature_mask_low);
-	if (ret)
-		return ret;
-
-	feature_mask[0] = feature_mask_low;
-	feature_mask[1] = feature_mask_high;
-
-	return ret;
-}
-
 int smu_v12_0_mode2_reset(struct smu_context *smu){
 	return smu_v12_0_send_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_2, NULL);
 }
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
