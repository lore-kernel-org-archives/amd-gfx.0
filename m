Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A916C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 07:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D59BA206EB
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 07:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BDs55113"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59BA206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2CEB6E88A;
	Tue, 25 Aug 2020 07:49:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407606E88A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 07:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9zSMRmUagnuDkWnoVG7b6+olp22zFdjC0/7EI4X7Ymbri8NwFLvh3t0Tf5S6TlwMXxmmm8y/hjJLwUPD8+2iyhe27UgfFUDCpNJMzsMxIEmFIjKDJdPdNMu7vxs/kEK4dDYmw68VxZqevhVYSLGXLG4ftxsZotah8m9ZzbK0Y/javCP8JPFlbNiU3XNqFVKZhhS3+Aoe9Tp/QgiswXJ8b9eDxHoCyBTk/ad/ApmkAGkSKa2wNFh+VgRSraiwQzTwLwlDqGq0FvJrQk1+GCzZiesZMd0Pn/quvkS3d3LC6NH99T3ch2zJYiS2D8+xDBi744dT0Lf2XijObkHmFaoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QD4SXq3Z7M+rihK8ucIlS1ryafHcGm0jFuki4mOgZxg=;
 b=AqG16sstLDSfJ9U5vJwh+uvEDdM/haCYgQaQ8sHbFaFvPXsZsHOTo/7ZIKNy7JPiavDHKJ8TYivhBmD3v/0AmxKQ67kfxJ+QOFkqAyt4fPE9c2x+nQRtGx+yx9fAlmFn56cI5Jr4K5JGlhd6Ycvrv5T0H7uIXHPLh8e8FBmxodPDPFOuVvFC75jvDO1loVsjWCavLWg7i+2z3+Dsh6KKNzEe3SrX/oxTzF6aoyn/WmYSKBcvzmfH5uLo003nW2VKe7kKdJTGSEc0GIvvmcXLlIV2h3b2vW8QLB63+m08sthyP6sGFbmOaqJPRCGAN21NLaL0Z0lApaELUrJri2fsWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QD4SXq3Z7M+rihK8ucIlS1ryafHcGm0jFuki4mOgZxg=;
 b=BDs55113sA/kCDwjrkjYHNOz+B089+Rrftl1O1pnVkmH+mDtVR14opEoQdye9fr+TxAK5zmTBOqc4+AMuv5YfNMJGw5K4spSBymv6Y4ktss/iN9mF1Ojwm+Mr2vamYrzIdS3IunoreZSdB3f9OR4gSfght75pOQUa1p36E4TI0w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3083.namprd12.prod.outlook.com (2603:10b6:5:11d::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Tue, 25 Aug 2020 07:49:53 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 07:49:53 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amd/pm: drop unnecessary table existence and dpm
 enablement check
Date: Tue, 25 Aug 2020 15:49:22 +0800
Message-Id: <20200825074923.32345-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825074923.32345-1-evan.quan@amd.com>
References: <20200825074923.32345-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK2PR02CA0200.apcprd02.prod.outlook.com (2603:1096:201:20::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Tue, 25 Aug 2020 07:49:51 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ea602c39-90c6-40fd-8541-08d848cb73b5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3083:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3083ABC1ADE20C1201251BE3E4570@DM6PR12MB3083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: im57P32JrczB5kViIDVrVNK2Ank9t1suMWfdQHSK4TK91mMUgYPy2vwdgdP1jJ7Y2/br62v4b4IXUtfMLu/SaY5Z7dh7A8Pwz1bp1awx4he3pFUjj8itrk9SbKOWK8yTr3sCddM5EbWcnzVT7h2fTADZXZYYTXy5WmWOleaoKWgYU0fSGrr5CFX0X8X2RqDMR4ty6X+1QlyApGrLkeq/7wKpB2nETRrHuz2lc6Ny+jVURdeGOR0CCiVqXdkvtYJg2f5JPkHJ35vnWhYsgQPa3P+I2oQrMpoyUwHY6aWeW9cpLzvWXIHrUvauIK6pgRgWLZeH52A+8rgof2fyVapdZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(6916009)(2616005)(956004)(66556008)(66476007)(66946007)(52116002)(186003)(8676002)(316002)(16576012)(26005)(8936002)(5660300002)(1076003)(83380400001)(86362001)(2906002)(6666004)(44832011)(4326008)(6486002)(36756003)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Q1eTTjOeE+FF3D7dTbaK4Yu6wHUGmNw42QRS2kWwmh7gw3+7MX1FYdxU3fF6lL+BqaF9L71f3/R3kruNz8MCN9FjKOF5qsq76BsMcXJue0GBOdASyCcypEd01/uuaJiSHK6HHPiqQ9kD/Op7fhWHo3STAlr9Nix25dIxGvFyFnZnZql9C0AWintAd4nmuZHKBi2KPQiNJXOtS0MNlC7O+uzXdIjV/fZPJLN9HamHiao16P7pJmt2jy+eW4Q3D2246b+wf94+gdJJ3B1i1ed3t/rs2NtVQCrydXN2Scx+BWxAYrovY0JrtpS+i4HvN26MYPI2pUTu/A73JPfOY1luwPWIElx6qm/xyHHVULfG2DFrFmQtes0Tx3x0XfdqOVcte0/LmgyGjZ3ZuEafkL57x3V/cXBY2tZTyGi0Rfh6AP0occHAJ5Yti7vB9cn+pf7e6QcMl21E3KIcWnI/GSG2sVzeEhYYm0FCDe5CtSlqu1Kk27UoaMBrVTkgcabOAZCsy7GJpeE3GtCBnVPSMP05Et6n6oa1Ar5vOkJfIv3FXobHctcQmjMG8mXKm030yosanU/zP2e26mNdRy34yX7tRvg7dkfpKYB7LjoBoJX8wqWaWAI/wa3mg+PmQFUglyyKyETuLFvScL/RceVZUia/6Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea602c39-90c6-40fd-8541-08d848cb73b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 07:49:53.2940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SG/oI4Sir2ivErRj5hTW3nmbuLL1SKwdMl5HWrhCnRxVI7LA7iKR46p7yXctkPFy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3083
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

Either this was already performed in parent API. Or the table is
confirmed to exist.

Change-Id: Ie6778a5035749221e0f9d5ad977a0e56392771dd
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  1 -
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 16 ----------------
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 19 ++++---------------
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 +
 4 files changed, 5 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 4c5c041af4ee..1888776deccb 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -701,7 +701,6 @@ int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed);
 int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed);
 
 int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk);
-int smu_set_active_display_count(struct smu_context *smu, uint32_t count);
 
 int smu_get_clock_by_type(struct smu_context *smu,
 			  enum amd_pp_clock_type type,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b7cad8ef6153..8a42d976a930 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -572,9 +572,6 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
 	struct smu_table *tables = smu_table->tables;
 	struct smu_table *driver_table = &(smu_table->driver_table);
 
-	if (!tables)
-		return 0;
-
 	if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
 		amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
 				      &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
@@ -2252,19 +2249,6 @@ int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk)
 	return ret;
 }
 
-int smu_set_active_display_count(struct smu_context *smu, uint32_t count)
-{
-	int ret = 0;
-
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
-	if (smu->ppt_funcs->set_active_display_count)
-		ret = smu->ppt_funcs->set_active_display_count(smu, count);
-
-	return ret;
-}
-
 int smu_get_clock_by_type(struct smu_context *smu,
 			  enum amd_pp_clock_type type,
 			  struct amd_pp_clocks *clocks)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 005673bedc2f..a83b3635df40 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -453,9 +453,6 @@ int smu_v11_0_init_power(struct smu_context *smu)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 
-	if (smu_power->power_context || smu_power->power_context_size != 0)
-		return -EINVAL;
-
 	smu_power->power_context = kzalloc(sizeof(struct smu_11_0_dpm_context),
 					   GFP_KERNEL);
 	if (!smu_power->power_context)
@@ -469,9 +466,6 @@ int smu_v11_0_fini_power(struct smu_context *smu)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 
-	if (!smu_power->power_context || smu_power->power_context_size == 0)
-		return -EINVAL;
-
 	kfree(smu_power->power_context);
 	smu_power->power_context = NULL;
 	smu_power->power_context_size = 0;
@@ -700,18 +694,16 @@ int smu_v11_0_set_tool_table_location(struct smu_context *smu)
 
 int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
 {
-	int ret = 0;
 	struct amdgpu_device *adev = smu->adev;
 
 	/* Navy_Flounder do not support to change display num currently */
 	if (adev->asic_type == CHIP_NAVY_FLOUNDER)
 		return 0;
 
-	if (!smu->pm_enabled)
-		return ret;
-
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, count, NULL);
-	return ret;
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_NumOfDisplays,
+					       count,
+					       NULL);
 }
 
 
@@ -773,9 +765,6 @@ int smu_v11_0_notify_display_change(struct smu_context *smu)
 {
 	int ret = 0;
 
-	if (!smu->pm_enabled)
-		return ret;
-
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
 	    smu->adev->gmc.vram_type == AMDGPU_VRAM_TYPE_HBM)
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index c88f8fab1bae..5c8bb7314675 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -42,6 +42,7 @@
 #define smu_check_fw_version(smu)					smu_ppt_funcs(check_fw_version, 0, smu)
 #define smu_write_pptable(smu)						smu_ppt_funcs(write_pptable, 0, smu)
 #define smu_set_min_dcef_deep_sleep(smu, clk)				smu_ppt_funcs(set_min_dcef_deep_sleep, 0, smu, clk)
+#define smu_set_active_display_count(smu, count)			smu_ppt_funcs(set_active_display_count, 0, smu, count)
 #define smu_set_driver_table_location(smu)				smu_ppt_funcs(set_driver_table_location, 0, smu)
 #define smu_set_tool_table_location(smu)				smu_ppt_funcs(set_tool_table_location, 0, smu)
 #define smu_notify_memory_pool_location(smu)				smu_ppt_funcs(notify_memory_pool_location, 0, smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
