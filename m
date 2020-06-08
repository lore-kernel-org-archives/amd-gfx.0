Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EE2C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 10:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C63AD2072F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 10:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uhtRA6l3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63AD2072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FDFB896ED;
	Mon,  8 Jun 2020 10:53:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BCED896ED
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 10:53:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBY4mfyUYaOnlaBXVoxYPVGBLSAfk+B/cdjF9pNRdzO/aaxAIVZaVaUB/jNc7CLfGQoIF951m0TL+3+1ryCIjD6bUo3taY9r28Ihq4QuWIqt4Ncu2kkFYEkzgsndoYSE9uL1Vpo9Vhm5rrIik9lmd3cJOtE/2uR1itRv0qW7tMD6VfLPOcp9IaqlSwC69CiQ08C30vRewx3a+lvQ/5dudGMCOppXAd9992KlsumA0WIxslMP/1v+li3NANjeX9QRHQsdxUjG8H1bBMwfYcbiwkKRHfwHDIAU+1h/3e81UEId9JfxSYtV9GO6XUEQzhrPxTquXp9alRz952c1xG4I/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHYjoTJb1G5R+9WhgmmsGp4q7ioMwVG8I7u+Sc5zNQY=;
 b=cWfYOg5SiP1yU9DhofERRNtK2i4Zx/R8dtl8qi/Cq6sX7OiW6+2d2jSJf40f/AWwZWHJXM/AEyqZrwf+APEJ6kXrb/A4wLn4wmtvii24X9kGEUQT9JqN1QwC7Kz+RBe4EVFuZsuD+q4YG/aEqmacbfTWQ6b4T3iHTjFNSMHj/cM2+qAhnKREQkqlyPXwEK46BQSYhHgpcAJH5gTLyznTA877dnFzjjQD6STyUeeXBX7cOzZFVk56cvnsdN6ZpXANcJlHht0UGF3GqK5rAo4c6xip9I1hu5t4fgikaOQvdULAQpFYQbpGG/x2t5/kov3DBZQxmryQcUJKHPjFylQpUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHYjoTJb1G5R+9WhgmmsGp4q7ioMwVG8I7u+Sc5zNQY=;
 b=uhtRA6l3SiryJnDgsx0HNzoe23flen8f6JKSWG+uHwoZj2iVaxQCzY42QvWKBZQB08x4gmJnTPRcdx16I4pLeia6WqcwsdvO7nry2Y12s1ZxHjy3Ij9X3Ux3QsuzdQzjxvrv4OP/6Bhx2vx5Kumj786QRu1TsysaKBUEv/0hqqQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3546.namprd12.prod.outlook.com (2603:10b6:5:18d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Mon, 8 Jun 2020 10:53:25 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 10:53:25 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/7] drm/amd/powerplay: maximize code sharing around power
 limit
Date: Mon,  8 Jun 2020 18:52:29 +0800
Message-Id: <20200608105234.29864-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200608105234.29864-1-evan.quan@amd.com>
References: <20200608105234.29864-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0189.apcprd02.prod.outlook.com
 (2603:1096:201:21::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0189.apcprd02.prod.outlook.com (2603:1096:201:21::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.19 via Frontend Transport; Mon, 8 Jun 2020 10:53:23 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4ea5baa8-c1b8-4588-3d9f-08d80b9a2b1c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB354633A74AB598E19FA85DA3E4850@DM6PR12MB3546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:212;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BL2Rur8A4aNKgW+LN88m862gqXLtJUzgonbm7RWycBBFE9wajT5I5O6x/Vpa2vyAkrpSH7ck3EyMMYeiJD1IQ+HtUE1RMFVuTMxE6iB78+LytKLAhtHZ0OUCBOO8uADz6aWStMXg5DCbB/ZGtB6Cip4uqjMu6VkV0qEozBdlD5gKJn/Cdc7kwzue8wSHCzW+EJutgSpYUg2odfYyf8zqI3gCrC5FdnFzvqBn34zuB8uPMo/Cp/UEiZdHX3BgN8uR9Px8lryXQDWtiXq+S/med5sVOlDP+c0IdxtagXvE6xFFhOV4ook7c38bre/neoj5Xs2Zsst+Lrki8I/0lfIwf/VVpLeHZmzl8Y/jLkQCg77mlgQC/2lsMinzjNOu/+dh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(66556008)(2906002)(66476007)(6916009)(8676002)(956004)(66946007)(2616005)(8936002)(26005)(5660300002)(44832011)(4326008)(86362001)(6486002)(478600001)(83380400001)(316002)(186003)(52116002)(7696005)(36756003)(16526019)(1076003)(14963001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +eAr9EWX53z9yTeca7eE3abC6RWbBRssLVOgGcMDCe3t8vxNupRGFCEMJnvOGbu/RpdjWaGrG1FA/iH38EjxmP8cG98gjte9VwkMbN4W9wfTIRvri+v1kq3FtwnqGYd9wlqhaBIPwGfLdrY0nFOaEL9uYq891fSjEdF2QdSfYXH8unP3vtp9KTGOf+EcDPPmrFVm5TQBE51LyY5Z1hmw/DL5K/HL7T9K6u/pL1lnTN1IhCqnqcarmxQOiANaJkb0IA3m32S8v3z/ss9WDe4xShcpzCoCGx7z6YmwAttUM36SsRvLe8FDIVVgXFoYtgIG+FgZn2idwHRJj6MZ62Nov/OAaesEVYkj0PFlaqf254xP2955FvDExQzdUv9vOBMcwEgGnL5tl91P3PnNJYCLOtMjMjAMq29NzEP+n5r7VhSciSxh+hSbXHuaZhNIF+iOP7XPWxPk/XDIJdPfzt4NAUzcvVDJjMxwd1Vr/GobvxZMQ06QQUTk5MIT3oDPHaSX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea5baa8-c1b8-4588-3d9f-08d80b9a2b1c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 10:53:25.1993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MlaAOGt7jAQ+03fW+JiZNWsp1X6+X19mVbxlaGlF2HnMD+ziMeHyc2/gL8TqjvMQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3546
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

Also cache the current and max power limits.

Change-Id: Ida2ce964736bee2e558522441d3505f84c4e00f4
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 49 ++++++++---------
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  3 ++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 53 ++++++++-----------
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 51 ++++++++----------
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 23 ++++++++
 6 files changed, 94 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 0704a9c1d567..2c78271123f7 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1413,40 +1413,33 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 				     uint32_t *limit,
 				     bool cap)
 {
+	struct smu_11_0_powerplay_table *powerplay_table =
+		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	uint32_t asic_default_power_limit = 0;
-	int ret = 0;
-	int power_src;
-
-	if (!smu->power_limit) {
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
-			power_src = smu_power_get_index(smu, SMU_POWER_SOURCE_AC);
-			if (power_src < 0)
-				return -EINVAL;
+	uint32_t power_limit, od_percent;
 
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetPptLimit,
-				power_src << 16, &asic_default_power_limit);
-			if (ret) {
-				dev_err(smu->adev->dev, "[%s] get PPT limit failed!", __func__);
-				return ret;
-			}
-		} else {
-			/* the last hope to figure out the ppt limit */
-			if (!pptable) {
-				dev_err(smu->adev->dev, "Cannot get PPT limit due to pptable missing!");
-				return -EINVAL;
-			}
-			asic_default_power_limit =
-				pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
+	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
+		/* the last hope to figure out the ppt limit */
+		if (!pptable) {
+			dev_err(smu->adev->dev, "Cannot get PPT limit due to pptable missing!");
+			return -EINVAL;
 		}
+		power_limit =
+			pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
+	}
+	smu->current_power_limit = power_limit;
+
+	if (smu->od_enabled) {
+		od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+
+		dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
 
-		smu->power_limit = asic_default_power_limit;
+		power_limit *= (100 + od_percent);
+		power_limit /= 100;
 	}
+	smu->max_power_limit = power_limit;
 
-	if (cap)
-		*limit = smu_get_max_power_limit(smu);
-	else
-		*limit = smu->power_limit;
+	*limit = (cap ? smu->max_power_limit : smu->current_power_limit);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 9276320c09d0..574a793b5d26 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -382,6 +382,8 @@ struct smu_context
 	bool od_enabled;
 	uint32_t power_limit;
 	uint32_t default_power_limit;
+	uint32_t current_power_limit;
+	uint32_t max_power_limit;
 
 	/* soft pptable */
 	uint32_t ppt_offset_bytes;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 9da2f26b7267..2e9939beb128 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -196,6 +196,9 @@ int smu_v11_0_get_enabled_mask(struct smu_context *smu,
 
 int smu_v11_0_notify_display_change(struct smu_context *smu);
 
+int smu_v11_0_get_current_power_limit(struct smu_context *smu,
+				      uint32_t *power_limit);
+
 int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n);
 
 int smu_v11_0_get_current_clk_freq(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index e63498e747ac..b867f94ba559 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1923,43 +1923,36 @@ static uint32_t navi10_get_pptable_power_limit(struct smu_context *smu)
 }
 
 static int navi10_get_power_limit(struct smu_context *smu,
-				     uint32_t *limit,
-				     bool cap)
+				  uint32_t *limit,
+				  bool cap)
 {
+	struct smu_11_0_powerplay_table *powerplay_table =
+		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	uint32_t asic_default_power_limit = 0;
-	int ret = 0;
-	int power_src;
-
-	if (!smu->power_limit) {
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
-			power_src = smu_power_get_index(smu, SMU_POWER_SOURCE_AC);
-			if (power_src < 0)
-				return -EINVAL;
+	uint32_t power_limit, od_percent;
 
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetPptLimit,
-				power_src << 16, &asic_default_power_limit);
-			if (ret) {
-				dev_err(smu->adev->dev, "[%s] get PPT limit failed!", __func__);
-				return ret;
-			}
-		} else {
-			/* the last hope to figure out the ppt limit */
-			if (!pptable) {
-				dev_err(smu->adev->dev, "Cannot get PPT limit due to pptable missing!");
-				return -EINVAL;
-			}
-			asic_default_power_limit =
-				pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
+	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
+		/* the last hope to figure out the ppt limit */
+		if (!pptable) {
+			dev_err(smu->adev->dev, "Cannot get PPT limit due to pptable missing!");
+			return -EINVAL;
 		}
+		power_limit =
+			pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
+	}
+	smu->current_power_limit = power_limit;
 
-		smu->power_limit = asic_default_power_limit;
+	if (smu->od_enabled) {
+		od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+
+		dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
+
+		power_limit *= (100 + od_percent);
+		power_limit /= 100;
 	}
+	smu->max_power_limit = power_limit;
 
-	if (cap)
-		*limit = smu_get_max_power_limit(smu);
-	else
-		*limit = smu->power_limit;
+	*limit = (cap ? smu->max_power_limit : smu->current_power_limit);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index b83675227a6f..c427e233dfad 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1747,40 +1747,33 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
 				     uint32_t *limit,
 				     bool cap)
 {
+	struct smu_11_0_7_powerplay_table *powerplay_table =
+		(struct smu_11_0_7_powerplay_table *)smu->smu_table.power_play_table;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	uint32_t asic_default_power_limit = 0;
-	int ret = 0;
-	int power_src;
-
-	if (!smu->power_limit) {
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
-			power_src = smu_power_get_index(smu, SMU_POWER_SOURCE_AC);
-			if (power_src < 0)
-				return -EINVAL;
-
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetPptLimit,
-							  power_src << 16, &asic_default_power_limit);
-			if (ret) {
-				dev_err(smu->adev->dev, "[%s] get PPT limit failed!", __func__);
-				return ret;
-			}
-		} else {
-			/* the last hope to figure out the ppt limit */
-			if (!pptable) {
-				dev_err(smu->adev->dev, "Cannot get PPT limit due to pptable missing!");
-				return -EINVAL;
-			}
-			asic_default_power_limit =
-				pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
+	uint32_t power_limit, od_percent;
+
+	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
+		/* the last hope to figure out the ppt limit */
+		if (!pptable) {
+			dev_err(smu->adev->dev, "Cannot get PPT limit due to pptable missing!");
+			return -EINVAL;
 		}
+		power_limit =
+			pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
+	}
+	smu->current_power_limit = power_limit;
+
+	if (smu->od_enabled) {
+		od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+
+		dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
 
-		smu->power_limit = asic_default_power_limit;
+		power_limit *= (100 + od_percent);
+		power_limit /= 100;
 	}
+	smu->max_power_limit = power_limit;
 
-	if (cap)
-		*limit = smu_get_max_power_limit(smu);
-	else
-		*limit = smu->power_limit;
+	*limit = (cap ? smu->max_power_limit : smu->current_power_limit);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index acb9a3cec7ee..358c903c4a86 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1056,6 +1056,29 @@ int smu_v11_0_init_max_sustainable_clocks(struct smu_context *smu)
 	return 0;
 }
 
+int smu_v11_0_get_current_power_limit(struct smu_context *smu,
+				      uint32_t *power_limit)
+{
+	int power_src;
+	int ret = 0;
+
+	if (!smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT))
+		return -EINVAL;
+
+	power_src = smu_power_get_index(smu, SMU_POWER_SOURCE_AC);
+	if (power_src < 0)
+		return -EINVAL;
+
+	ret = smu_send_smc_msg_with_param(smu,
+					  SMU_MSG_GetPptLimit,
+					  power_src << 16,
+					  power_limit);
+	if (ret)
+		dev_err(smu->adev->dev, "[%s] get PPT limit failed!", __func__);
+
+	return ret;
+}
+
 int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 {
 	int ret = 0;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
