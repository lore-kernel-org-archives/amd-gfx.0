Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ACEC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765DB21582
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rxaaE2ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765DB21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3931C89805;
	Tue, 14 Jul 2020 08:06:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9DAB895F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:06:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmL1peTsFXhmGFCqwer+h+eCVWQV9cNI1H+i3nmykNp72J7c/9hQcrklAdWeMdss5gGAK5AhL8pIXX5rmguDBzlD2H/I03SmN3KlqwdTyO13+6b9kJcmbxzaDB1F06wT3slXy+xb2ZlR5bOXQuUZCt0tmBlLyV6liz7Eq0bQWRdyfEs2ic2953OSJNzH0DizHITzPkHYLypQtI/2bkuFqTWKsoz9Olk8CAOLoHhAetCIY2dVbeOF0lYu3pQYooCFbbOXomNzAxDlls4XVA90jMSARXPfurzXjTadv2P32NeRSDP/4fs7qA3AYUjibNu0aX9KwTSMlgnA5Ipce6QuNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZ25sUksOeHqN8bokCxp01Y1IQoiD1DwBVzexzFfJSM=;
 b=bWGZJQ5FmMXGPBMaI3kRCSLst/CAA0ADSAYuuweDPSzwPnmN/0r+6T2ntXDf4OZuFueyxHwHq/5D2d+iPyv0hT6QCFHFJcVVSrKehTsfaooi1R64ijzHp2mBQzM3xSGG0+ng7he7D+112OO8KWtu0jsESXkCZNelCh9J4P94wYq/YeITlPlqIu4tdPclvlEoAuxZHr/Izc+sLeUOLAgT598tZ2R4AxhiCCI3scNQUyggYZFWiiHcQPiYqFI2ZHz/pxZdc14MUOYW0MkAHayOOnpKsFMtecvGoFFQDcCyqm9JXnxxWrclF4ovdZ1ffU+Y/nW+xLvvXEgdPFL1H+Upxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZ25sUksOeHqN8bokCxp01Y1IQoiD1DwBVzexzFfJSM=;
 b=rxaaE2axOMvbpKpPsH8iuoiD/NcOLtA0dDn1fzWgEcvSNZRR9FMt9VakuR48pNASMO8TLwEFI70gja0MhZ59TenCtxSQnN9aFlNK6qXlEoBaZIdRZXp5RqcnpZSMeWmPFT21ri1lL1cDNE7nyDafE8u6BglQ+TyytjSDIvWgxzc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 08:06:55 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 08:06:55 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/17] drm/amd/powerplay: common API for disabling all
 features with exception
Date: Tue, 14 Jul 2020 16:04:08 +0800
Message-Id: <20200714080416.6506-9-evan.quan@amd.com>
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
 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 08:06:54 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57156994-136e-4123-ae00-08d827ccdfcb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4355A47506A7AD5D0BBD16BCE4610@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkgLcdPUVuwGMRwg0r7E0KX0I6QML78s0+QYgPYYuUvsUvY+WSm6Glk8FvoUWFk1Tx01RXamEVXxsYENgXS5wilHNyO0HoIqut7x6nywNZlLuWZK0Fo6hgoIRxvfyDuseFTikkQjlfR36KDTV+diGNxBd3gEAkcfxWMIjKXZlPSk13ITrWDxKiNhr2I+RKxAeuxkeTiEkg5YdBp2YHMn3Uoa7ZSJAzGJbmESgH4l9xCbcMz3q8yuevLRxtgiOPU+CKoQ2Ye3IEBrtWk5P+EQWA15xgQIFfRbdEFaf9gO/v6Kaxi95xwaX1rjIwbNdYYP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(478600001)(83380400001)(316002)(4326008)(2616005)(8936002)(8676002)(36756003)(66946007)(66556008)(1076003)(44832011)(2906002)(956004)(66476007)(6486002)(5660300002)(52116002)(6666004)(186003)(86362001)(7696005)(16526019)(26005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: z9oDJjqh/ObrUjySLB2maYXhQi5u4N5qp4jHZb8Q2Y7V5Vrck9XvvYvrwbqVIhDMS8+q493Ncc4JMKeAI7eJa4IIWEgxRHQDuPPXHOzRNnOPt4Akp5bZhzN8d0d2fnlEf+oQapruifOHgBnJPC13KuW2KdN/d3fIim+SxZkhFxsJpSCLTZ9hhFKMjv/vXb4bvV4SI3TMBfT35q/s4wwfmRH2fC1fxH+2+uMUEEUQQ7V+xVTaqjKrGTgO6yiywcQJ1Ai+7OAdD/fFTUwsqMjsFvqdeUIQev0N14k/mjM4K8zw3XaUa8iqZWBF675zsz4pCNoY80qhBLHMrfN5Hx1Vgw1VFFVSHFhVbdZTDkXEExeQrX8Hg08J9dBN1OHufYIbZGn7AnWlQVt7ePTSIM+hWcu7HzGf0sCBPBtNCaAVC0ZMVD0d2/crunc0Vdc5HnRH3w8BnYuk+dIyJqhiuEbdOxcS8q9RKQnap5wF0w8uPI3u3ar/f0VF2FbLBigcD/H2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57156994-136e-4123-ae00-08d827ccdfcb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 08:06:55.6523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZXCUEwvwWsBJwWspm6pSwZjhvTNJYnASwKAKUOfeWvNCazn9FIIath4FEetua0p
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

We are moving to centralize all feature enablement/support checking and
setting APIs in smu_cmn.c.

Change-Id: I5b2328cd5a7e34ed9f607505545fd399277126c5
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 10 ++--------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  1 +
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  1 +
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  1 +
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  1 +
 drivers/gpu/drm/amd/powerplay/smu_cmn.c       | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/smu_cmn.h       |  3 +++
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  1 +
 9 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index d9879cf6255f..97a9cc31dbf7 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1094,7 +1094,6 @@ static int smu_hw_init(void *handle)
 static int smu_disable_dpms(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	uint64_t features_to_disable;
 	int ret = 0;
 	bool use_baco = !smu->is_apu &&
 		((adev->in_gpu_reset &&
@@ -1130,13 +1129,8 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 * BACO feature has to be kept enabled.
 	 */
 	if (use_baco && smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)) {
-		features_to_disable = U64_MAX &
-			~(1ULL << smu_cmn_to_asic_specific_index(smu,
-							CMN2ASIC_MAPPING_FEATURE,
-							SMU_FEATURE_BACO_BIT));
-		ret = smu_feature_update_enable_state(smu,
-						      features_to_disable,
-						      0);
+		ret = smu_disable_all_features_with_exception(smu,
+							      SMU_FEATURE_BACO_BIT);
 		if (ret)
 			dev_err(adev->dev, "Failed to disable smu features except BACO.\n");
 	} else {
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 568eeebcc0e0..d126905e6597 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2275,6 +2275,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.set_allowed_mask = smu_v11_0_set_allowed_mask,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
+	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
 	.notify_display_change = NULL,
 	.set_power_limit = smu_v11_0_set_power_limit,
 	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 42cee69b3163..cb922f4136c9 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -534,6 +534,7 @@ struct pptable_funcs {
 	int (*set_allowed_mask)(struct smu_context *smu);
 	int (*get_enabled_mask)(struct smu_context *smu, uint32_t *feature_mask, uint32_t num);
 	int (*feature_is_enabled)(struct smu_context *smu, enum smu_feature_mask mask);
+	int (*disable_all_features_with_exception)(struct smu_context *smu, enum smu_feature_mask mask);
 	int (*notify_display_change)(struct smu_context *smu);
 	int (*set_power_limit)(struct smu_context *smu, uint32_t n);
 	int (*init_max_sustainable_clocks)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index f8dc08bed908..4f66eb9011fc 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2300,6 +2300,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.set_allowed_mask = smu_v11_0_set_allowed_mask,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
+	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
 	.notify_display_change = smu_v11_0_notify_display_change,
 	.set_power_limit = smu_v11_0_set_power_limit,
 	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 57756288d0de..e6a4dff61aee 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -991,6 +991,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.set_default_dpm_table = smu_v12_0_set_default_dpm_tables,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
+	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
 	.get_dpm_ultimate_freq = renoir_get_dpm_ultimate_freq,
 	.mode2_reset = smu_v12_0_mode2_reset,
 	.set_soft_freq_limited_range = smu_v12_0_set_soft_freq_limited_range,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 2eabb1f3924b..5c524a57341a 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -2419,6 +2419,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_allowed_mask = smu_v11_0_set_allowed_mask,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
+	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
 	.notify_display_change = NULL,
 	.set_power_limit = smu_v11_0_set_power_limit,
 	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.c b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
index d0293b3dc9ab..85c106966f9a 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
@@ -355,3 +355,22 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
 
 	return ret;
 }
+
+int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
+						enum smu_feature_mask mask)
+{
+	uint64_t features_to_disable = U64_MAX;
+	int skipped_feature_id;
+
+	skipped_feature_id = smu_cmn_to_asic_specific_index(smu,
+							    CMN2ASIC_MAPPING_FEATURE,
+							    mask);
+	if (skipped_feature_id < 0)
+		return -EINVAL;
+
+	features_to_disable &= ~(1ULL << skipped_feature_id);
+
+	return smu_cmn_feature_update_enable_state(smu,
+						   features_to_disable,
+						   0);
+}
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.h b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
index 36a2931a4ab3..08968ad24d10 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
@@ -49,4 +49,7 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
 				uint64_t new_mask);
 
+int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
+						enum smu_feature_mask mask);
+
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 94f3ba092637..5ff37b550cae 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -55,6 +55,7 @@
 #define smu_feature_set_allowed_mask(smu)				smu_ppt_funcs(set_allowed_mask, 0, smu)
 #define smu_feature_get_enabled_mask(smu, mask, num)			smu_ppt_funcs(get_enabled_mask, 0, smu, mask, num)
 #define smu_feature_is_enabled(smu, mask)				smu_ppt_funcs(feature_is_enabled, 0, smu, mask)
+#define smu_disable_all_features_with_exception(smu, mask)		smu_ppt_funcs(disable_all_features_with_exception, 0, smu, mask)
 #define smu_is_dpm_running(smu)						smu_ppt_funcs(is_dpm_running, 0 , smu)
 #define smu_notify_display_change(smu)					smu_ppt_funcs(notify_display_change, 0, smu)
 #define smu_set_default_dpm_table(smu)					smu_ppt_funcs(set_default_dpm_table, 0, smu)
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
