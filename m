Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBFEC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCD021582
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q5APidS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCD021582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF9A889930;
	Tue, 14 Jul 2020 08:07:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF05889930
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:07:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QODmJ672OR6YWpuzuKKMZZHn0lXHpDGSUMGJIXtbsJxQzvId2Z0mqjJ27fbGNGnpMN9nFFBjGL6OmUi1uoI0cFw1YD8JlsMA066QHmc8t2CftBMp8hfW/zsYKL9unp5mUfskvbIZ9r7O0u3uZ1DCMKAt6IS+oB76FUeZGuCzD5w4tlHV7xDkloN/khmeID8d3NOi5tiqVhxl6ICYDXgZNFK10/TWVADCWfjMjCZfHFCr4IGK0YRwzOEhrX5GbgrxmIzKvNYURswnECNl6sHv9qk32moDuT6QBz2mupeXwhZOKXXOdYnTV29srL4fcZ2yW3gNkcogbAb4UTLrHJfLIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e55P8QzKAyFQqWMg+FqWymGTziPoZC69EnQhBZfuLT8=;
 b=oFpogQw7Gdp6BlKLozzWsnJp//jXP2RUOZG9aTbXlzU0XEFwt/wWBdcGGnFVS89M9+6uVgMeiLE/a3DG+tRwRWvdUmLvf3Z+sOwpxHfsavfOIbBGA6i7/HziF2ourgkBowlhX8QaC1Y7G2k7LBT4Arw6fQ816erkFTRDtgBAtBPWToWzfEtBBo8ZcaY8kNQBsXRMdRcDvA0waMT/6pKLo2SlerLaE2LKySzVGopIhF05irJfS5SAetMQZ1iqApP5w6sIJGvKSUQwLVK5XPkNs5Q7M6sSYO9sS4Ug14qPyLfQKeQjPzqS5mdChS+kdHRn7vjcli7Jg0NFVQzCBEfMgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e55P8QzKAyFQqWMg+FqWymGTziPoZC69EnQhBZfuLT8=;
 b=Q5APidS1ub79oDdZy6z5wLuSDR/AklQfFcCougP0neYkyBbYFieQyweP+joHINu3hZ5S31zmnieZOhQ4Ak+3+AkI0rdEwYSD+dwZmqyla3BjhLFKv69DS1HVrB20G/mtvSUkijJ6F64mOjc1YRncUze2+wM5eQjq4xhN3g+Uwrg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 08:07:00 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 08:07:00 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/17] drm/amd/powerplay: maximum code sharing around
 watermarks setting
Date: Tue, 14 Jul 2020 16:04:10 +0800
Message-Id: <20200714080416.6506-11-evan.quan@amd.com>
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
 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 08:06:59 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 774eb4cb-7262-422d-25ba-08d827cce2d3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4355856A65E478D08B923853E4610@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:171;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygaIDaIJTiEPN3vvkdQbWSsGXDUr/1NVitY2ZJx7uIAW8mq+EA6J/3buW9cfRJCeD56G+AOCIxX5X4OMDs23zPQQy6hGwEdrLYvjZBxYKhwjVDjd8219Tty2el98q4mpHzPauUjutg7fVGCn2Wx+h3R6Iw7RbVkqjfteXgVFF9Ljka+rI25kkGEpKOiEXfqx9RDxu/CHV34yymm7hNxnr0ptQNviuZJ+ldsJQEBgP/Jinwg+8Ojl7oBuPRET1gI8N1B2gSVl9WeQpmtNvqgIufz4E6LoscVXwPE1ZrgjuZzFX3cMMxEEkdFfPeCNSUQyNmOqqHypzeEO3zXjahGkvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(478600001)(83380400001)(316002)(4326008)(2616005)(8936002)(8676002)(36756003)(66946007)(66556008)(1076003)(44832011)(2906002)(956004)(66476007)(6486002)(5660300002)(52116002)(6666004)(186003)(30864003)(86362001)(7696005)(16526019)(26005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Qu80KTp6xm/WRCM6ZweHifuxVr5d0nkpx3eEaqcWn325B1zuT7Hj1D3sP32FMhn7rc984/d/evKsMqBDNOu1cA2SERWsClI+OKj1+iSGi8aKRfjkdVLHbrIkRzeXoMoH26IDqgpC79ezJr1DLpJWDpzaMamGenAcwE1HxQAy3JlEerCgpcOJvNV3sJKREXOnG1S9OEnGxIRSpuJZQA6ZRDLLonmjF+rQgGUmqxCLCoqhJIs7Odr+DC+qU6InUfpb7C/9G+XaOxM93aBJhU5iZF7lmHHKeaDTbC8T5I5xuAu/s/LMMb3Oi9s3XreWhs/7Kea8wkx2CRZWycrAhV/bZPUXsU02Fg1dmtvg3RfEQLtyPiw2kGN7bTNAjVk9rPzTQp0SYbuWauyoHslrpd15rdt2Bv3EJDCVYir/irneVwqDOIGdteGom/VyrlmiUmWvN+hFh6dwIWFQKCr1Mtus/fLhpiXstKmuFjYoh+jRbF7AaFpqS57zorue8JKbdkLk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 774eb4cb-7262-422d-25ba-08d827cce2d3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 08:07:00.7684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJa0cBaTrGnI8utw9whBiDeefEW1nApg1ICwtDCQUUrVz0iLOgePj7ILWvXr5ybr
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

Maximum code sharing.

Change-Id: If20fe786024506659bcc31697fa0d00b3d4aa89f
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  19 +--
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  27 ++---
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |   2 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 102 ++++++++--------
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  85 +++++++-------
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 111 +++++++++---------
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |   2 +-
 7 files changed, 166 insertions(+), 182 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d9f8e9c26390..d8510a5c4c60 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1484,23 +1484,12 @@ static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	mutex_lock(&smu->mutex);
-
-	/* pass data to smu controller */
-	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
-			!(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
-		ret = smu_write_watermarks_table(smu);
-
-		if (ret) {
-			mutex_unlock(&smu->mutex);
-			DRM_ERROR("Failed to update WMTABLE!\n");
-			return ret;
-		}
-		smu->watermarks_bitmap |= WATERMARKS_LOADED;
+	ret = smu_write_watermarks_table(smu);
+	if (ret) {
+		DRM_ERROR("Failed to update WMTABLE!\n");
+		return ret;
 	}
 
-	mutex_unlock(&smu->mutex);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index d68de02a0c90..5f13b97d0229 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1692,35 +1692,34 @@ int smu_allow_xgmi_power_down(struct smu_context *smu, bool en)
 
 int smu_write_watermarks_table(struct smu_context *smu)
 {
-	void *watermarks_table = smu->smu_table.watermarks_table;
+	int ret = 0;
 
-	if (!watermarks_table)
-		return -EINVAL;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
 
-	return smu_update_table(smu,
-				SMU_TABLE_WATERMARKS,
-				0,
-				watermarks_table,
-				true);
+	mutex_lock(&smu->mutex);
+
+	ret = smu_set_watermarks_table(smu, NULL);
+
+	mutex_unlock(&smu->mutex);
+
+	return ret;
 }
 
 int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
 		struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges)
 {
-	void *table = smu->smu_table.watermarks_table;
+	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	if (!table)
-		return -EINVAL;
-
 	mutex_lock(&smu->mutex);
 
 	if (!smu->disable_watermark &&
 			smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
 			smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
-		smu_set_watermarks_table(smu, table, clock_ranges);
+		ret = smu_set_watermarks_table(smu, clock_ranges);
 
 		if (!(smu->watermarks_bitmap & WATERMARKS_EXIST)) {
 			smu->watermarks_bitmap |= WATERMARKS_EXIST;
@@ -1730,7 +1729,7 @@ int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
 
 	mutex_unlock(&smu->mutex);
 
-	return 0;
+	return ret;
 }
 
 int smu_set_ac_dc(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index ca097f91e963..366ab73ee83a 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -493,7 +493,7 @@ struct pptable_funcs {
 	int (*tables_init)(struct smu_context *smu, struct smu_table *tables);
 	int (*get_fan_speed_percent)(struct smu_context *smu, uint32_t *speed);
 	int (*get_fan_speed_rpm)(struct smu_context *smu, uint32_t *speed);
-	int (*set_watermarks_table)(struct smu_context *smu, void *watermarks,
+	int (*set_watermarks_table)(struct smu_context *smu,
 				    struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges);
 	int (*get_thermal_temperature_range)(struct smu_context *smu, struct smu_temperature_range *range);
 	int (*get_uclk_dpm_states)(struct smu_context *smu, uint32_t *clocks_in_khz, uint32_t *num_states);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 3e91f9cc732c..9f036971e4cd 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1576,67 +1576,65 @@ static int navi10_notify_smc_display_config(struct smu_context *smu)
 }
 
 static int navi10_set_watermarks_table(struct smu_context *smu,
-				       void *watermarks, struct
-				       dm_pp_wm_sets_with_clock_ranges_soc15
-				       *clock_ranges)
+				       struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges)
 {
-	int i;
+	Watermarks_t *table = smu->smu_table.watermarks_table;
 	int ret = 0;
-	Watermarks_t *table = watermarks;
+	int i;
 
-	if (!table || !clock_ranges)
-		return -EINVAL;
+	if (clock_ranges) {
+		if (clock_ranges->num_wm_dmif_sets > 4 ||
+		    clock_ranges->num_wm_mcif_sets > 4)
+			return -EINVAL;
 
-	if (clock_ranges->num_wm_dmif_sets > 4 ||
-	    clock_ranges->num_wm_mcif_sets > 4)
-		return -EINVAL;
+		for (i = 0; i < clock_ranges->num_wm_dmif_sets; i++) {
+			table->WatermarkRow[1][i].MinClock =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_dmif_clocks_ranges[i].wm_min_dcfclk_clk_in_khz /
+				1000));
+			table->WatermarkRow[1][i].MaxClock =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_dmif_clocks_ranges[i].wm_max_dcfclk_clk_in_khz /
+				1000));
+			table->WatermarkRow[1][i].MinUclk =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_dmif_clocks_ranges[i].wm_min_mem_clk_in_khz /
+				1000));
+			table->WatermarkRow[1][i].MaxUclk =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_dmif_clocks_ranges[i].wm_max_mem_clk_in_khz /
+				1000));
+			table->WatermarkRow[1][i].WmSetting = (uint8_t)
+					clock_ranges->wm_dmif_clocks_ranges[i].wm_set_id;
+		}
 
-	for (i = 0; i < clock_ranges->num_wm_dmif_sets; i++) {
-		table->WatermarkRow[1][i].MinClock =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_dmif_clocks_ranges[i].wm_min_dcfclk_clk_in_khz /
-			1000));
-		table->WatermarkRow[1][i].MaxClock =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_dmif_clocks_ranges[i].wm_max_dcfclk_clk_in_khz /
-			1000));
-		table->WatermarkRow[1][i].MinUclk =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_dmif_clocks_ranges[i].wm_min_mem_clk_in_khz /
-			1000));
-		table->WatermarkRow[1][i].MaxUclk =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_dmif_clocks_ranges[i].wm_max_mem_clk_in_khz /
-			1000));
-		table->WatermarkRow[1][i].WmSetting = (uint8_t)
-				clock_ranges->wm_dmif_clocks_ranges[i].wm_set_id;
-	}
+		for (i = 0; i < clock_ranges->num_wm_mcif_sets; i++) {
+			table->WatermarkRow[0][i].MinClock =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_mcif_clocks_ranges[i].wm_min_socclk_clk_in_khz /
+				1000));
+			table->WatermarkRow[0][i].MaxClock =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_mcif_clocks_ranges[i].wm_max_socclk_clk_in_khz /
+				1000));
+			table->WatermarkRow[0][i].MinUclk =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_mcif_clocks_ranges[i].wm_min_mem_clk_in_khz /
+				1000));
+			table->WatermarkRow[0][i].MaxUclk =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_mcif_clocks_ranges[i].wm_max_mem_clk_in_khz /
+				1000));
+			table->WatermarkRow[0][i].WmSetting = (uint8_t)
+					clock_ranges->wm_mcif_clocks_ranges[i].wm_set_id;
+		}
 
-	for (i = 0; i < clock_ranges->num_wm_mcif_sets; i++) {
-		table->WatermarkRow[0][i].MinClock =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_mcif_clocks_ranges[i].wm_min_socclk_clk_in_khz /
-			1000));
-		table->WatermarkRow[0][i].MaxClock =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_mcif_clocks_ranges[i].wm_max_socclk_clk_in_khz /
-			1000));
-		table->WatermarkRow[0][i].MinUclk =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_mcif_clocks_ranges[i].wm_min_mem_clk_in_khz /
-			1000));
-		table->WatermarkRow[0][i].MaxUclk =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_mcif_clocks_ranges[i].wm_max_mem_clk_in_khz /
-			1000));
-		table->WatermarkRow[0][i].WmSetting = (uint8_t)
-				clock_ranges->wm_mcif_clocks_ranges[i].wm_set_id;
+		smu->watermarks_bitmap |= WATERMARKS_EXIST;
 	}
 
-	smu->watermarks_bitmap |= WATERMARKS_EXIST;
-
 	/* pass data to smu controller */
-	if (!(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
+	     !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
 		ret = smu_write_watermarks_table(smu);
 		if (ret) {
 			dev_err(smu->adev->dev, "Failed to update WMTABLE!");
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index e6789b28dd23..33990a107117 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -813,59 +813,58 @@ static int renoir_set_performance_level(struct smu_context *smu,
  */
 static int renoir_set_watermarks_table(
 		struct smu_context *smu,
-		void *watermarks,
 		struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges)
 {
-	int i;
+	Watermarks_t *table = smu->smu_table.watermarks_table;
 	int ret = 0;
-	Watermarks_t *table = watermarks;
+	int i;
 
-	if (!table || !clock_ranges)
-		return -EINVAL;
+	if (clock_ranges) {
+		if (clock_ranges->num_wm_dmif_sets > 4 ||
+				clock_ranges->num_wm_mcif_sets > 4)
+			return -EINVAL;
 
-	if (clock_ranges->num_wm_dmif_sets > 4 ||
-			clock_ranges->num_wm_mcif_sets > 4)
-		return -EINVAL;
+		/* save into smu->smu_table.tables[SMU_TABLE_WATERMARKS]->cpu_addr*/
+		for (i = 0; i < clock_ranges->num_wm_dmif_sets; i++) {
+			table->WatermarkRow[WM_DCFCLK][i].MinClock =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_dmif_clocks_ranges[i].wm_min_dcfclk_clk_in_khz));
+			table->WatermarkRow[WM_DCFCLK][i].MaxClock =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_dmif_clocks_ranges[i].wm_max_dcfclk_clk_in_khz));
+			table->WatermarkRow[WM_DCFCLK][i].MinMclk =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_dmif_clocks_ranges[i].wm_min_mem_clk_in_khz));
+			table->WatermarkRow[WM_DCFCLK][i].MaxMclk =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_dmif_clocks_ranges[i].wm_max_mem_clk_in_khz));
+			table->WatermarkRow[WM_DCFCLK][i].WmSetting = (uint8_t)
+					clock_ranges->wm_dmif_clocks_ranges[i].wm_set_id;
+		}
 
-	/* save into smu->smu_table.tables[SMU_TABLE_WATERMARKS]->cpu_addr*/
-	for (i = 0; i < clock_ranges->num_wm_dmif_sets; i++) {
-		table->WatermarkRow[WM_DCFCLK][i].MinClock =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_dmif_clocks_ranges[i].wm_min_dcfclk_clk_in_khz));
-		table->WatermarkRow[WM_DCFCLK][i].MaxClock =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_dmif_clocks_ranges[i].wm_max_dcfclk_clk_in_khz));
-		table->WatermarkRow[WM_DCFCLK][i].MinMclk =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_dmif_clocks_ranges[i].wm_min_mem_clk_in_khz));
-		table->WatermarkRow[WM_DCFCLK][i].MaxMclk =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_dmif_clocks_ranges[i].wm_max_mem_clk_in_khz));
-		table->WatermarkRow[WM_DCFCLK][i].WmSetting = (uint8_t)
-				clock_ranges->wm_dmif_clocks_ranges[i].wm_set_id;
-	}
+		for (i = 0; i < clock_ranges->num_wm_mcif_sets; i++) {
+			table->WatermarkRow[WM_SOCCLK][i].MinClock =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_mcif_clocks_ranges[i].wm_min_socclk_clk_in_khz));
+			table->WatermarkRow[WM_SOCCLK][i].MaxClock =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_mcif_clocks_ranges[i].wm_max_socclk_clk_in_khz));
+			table->WatermarkRow[WM_SOCCLK][i].MinMclk =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_mcif_clocks_ranges[i].wm_min_mem_clk_in_khz));
+			table->WatermarkRow[WM_SOCCLK][i].MaxMclk =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_mcif_clocks_ranges[i].wm_max_mem_clk_in_khz));
+			table->WatermarkRow[WM_SOCCLK][i].WmSetting = (uint8_t)
+					clock_ranges->wm_mcif_clocks_ranges[i].wm_set_id;
+		}
 
-	for (i = 0; i < clock_ranges->num_wm_mcif_sets; i++) {
-		table->WatermarkRow[WM_SOCCLK][i].MinClock =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_mcif_clocks_ranges[i].wm_min_socclk_clk_in_khz));
-		table->WatermarkRow[WM_SOCCLK][i].MaxClock =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_mcif_clocks_ranges[i].wm_max_socclk_clk_in_khz));
-		table->WatermarkRow[WM_SOCCLK][i].MinMclk =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_mcif_clocks_ranges[i].wm_min_mem_clk_in_khz));
-		table->WatermarkRow[WM_SOCCLK][i].MaxMclk =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_mcif_clocks_ranges[i].wm_max_mem_clk_in_khz));
-		table->WatermarkRow[WM_SOCCLK][i].WmSetting = (uint8_t)
-				clock_ranges->wm_mcif_clocks_ranges[i].wm_set_id;
+		smu->watermarks_bitmap |= WATERMARKS_EXIST;
 	}
 
-	smu->watermarks_bitmap |= WATERMARKS_EXIST;
-
 	/* pass data to smu controller */
-	if (!(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
+	     !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
 		ret = smu_write_watermarks_table(smu);
 		if (ret) {
 			dev_err(smu->adev->dev, "Failed to update WMTABLE!");
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 5c524a57341a..fc9ed1c50cf7 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1369,66 +1369,65 @@ static int sienna_cichlid_notify_smc_display_config(struct smu_context *smu)
 }
 
 static int sienna_cichlid_set_watermarks_table(struct smu_context *smu,
-				       void *watermarks, struct
-				       dm_pp_wm_sets_with_clock_ranges_soc15
-				       *clock_ranges)
+					       struct dm_pp_wm_sets_with_clock_ranges_soc15
+					       *clock_ranges)
 {
-	int i;
+	Watermarks_t *table = smu->smu_table.watermarks_table;
 	int ret = 0;
-	Watermarks_t *table = watermarks;
+	int i;
 
-	if (!table || !clock_ranges)
-		return -EINVAL;
+	if (clock_ranges) {
+		if (clock_ranges->num_wm_dmif_sets > 4 ||
+		    clock_ranges->num_wm_mcif_sets > 4)
+			return -EINVAL;
+
+		for (i = 0; i < clock_ranges->num_wm_dmif_sets; i++) {
+			table->WatermarkRow[1][i].MinClock =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_dmif_clocks_ranges[i].wm_min_dcfclk_clk_in_khz /
+				1000));
+			table->WatermarkRow[1][i].MaxClock =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_dmif_clocks_ranges[i].wm_max_dcfclk_clk_in_khz /
+				1000));
+			table->WatermarkRow[1][i].MinUclk =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_dmif_clocks_ranges[i].wm_min_mem_clk_in_khz /
+				1000));
+			table->WatermarkRow[1][i].MaxUclk =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_dmif_clocks_ranges[i].wm_max_mem_clk_in_khz /
+				1000));
+			table->WatermarkRow[1][i].WmSetting = (uint8_t)
+					clock_ranges->wm_dmif_clocks_ranges[i].wm_set_id;
+		}
 
-	if (clock_ranges->num_wm_dmif_sets > 4 ||
-	    clock_ranges->num_wm_mcif_sets > 4)
-                return -EINVAL;
-
-        for (i = 0; i < clock_ranges->num_wm_dmif_sets; i++) {
-		table->WatermarkRow[1][i].MinClock =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_dmif_clocks_ranges[i].wm_min_dcfclk_clk_in_khz /
-			1000));
-		table->WatermarkRow[1][i].MaxClock =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_dmif_clocks_ranges[i].wm_max_dcfclk_clk_in_khz /
-			1000));
-		table->WatermarkRow[1][i].MinUclk =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_dmif_clocks_ranges[i].wm_min_mem_clk_in_khz /
-			1000));
-		table->WatermarkRow[1][i].MaxUclk =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_dmif_clocks_ranges[i].wm_max_mem_clk_in_khz /
-			1000));
-		table->WatermarkRow[1][i].WmSetting = (uint8_t)
-				clock_ranges->wm_dmif_clocks_ranges[i].wm_set_id;
-        }
-
-	for (i = 0; i < clock_ranges->num_wm_mcif_sets; i++) {
-		table->WatermarkRow[0][i].MinClock =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_mcif_clocks_ranges[i].wm_min_socclk_clk_in_khz /
-			1000));
-		table->WatermarkRow[0][i].MaxClock =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_mcif_clocks_ranges[i].wm_max_socclk_clk_in_khz /
-			1000));
-		table->WatermarkRow[0][i].MinUclk =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_mcif_clocks_ranges[i].wm_min_mem_clk_in_khz /
-			1000));
-		table->WatermarkRow[0][i].MaxUclk =
-			cpu_to_le16((uint16_t)
-			(clock_ranges->wm_mcif_clocks_ranges[i].wm_max_mem_clk_in_khz /
-			1000));
-		table->WatermarkRow[0][i].WmSetting = (uint8_t)
-				clock_ranges->wm_mcif_clocks_ranges[i].wm_set_id;
-        }
-
-	smu->watermarks_bitmap |= WATERMARKS_EXIST;
-
-	if (!(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+		for (i = 0; i < clock_ranges->num_wm_mcif_sets; i++) {
+			table->WatermarkRow[0][i].MinClock =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_mcif_clocks_ranges[i].wm_min_socclk_clk_in_khz /
+				1000));
+			table->WatermarkRow[0][i].MaxClock =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_mcif_clocks_ranges[i].wm_max_socclk_clk_in_khz /
+				1000));
+			table->WatermarkRow[0][i].MinUclk =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_mcif_clocks_ranges[i].wm_min_mem_clk_in_khz /
+				1000));
+			table->WatermarkRow[0][i].MaxUclk =
+				cpu_to_le16((uint16_t)
+				(clock_ranges->wm_mcif_clocks_ranges[i].wm_max_mem_clk_in_khz /
+				1000));
+			table->WatermarkRow[0][i].WmSetting = (uint8_t)
+					clock_ranges->wm_mcif_clocks_ranges[i].wm_set_id;
+		}
+
+		smu->watermarks_bitmap |= WATERMARKS_EXIST;
+	}
+
+	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
+	     !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
 		ret = smu_write_watermarks_table(smu);
 		if (ret) {
 			dev_err(smu->adev->dev, "Failed to update WMTABLE!");
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 5ff37b550cae..dd187e0020d5 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -78,7 +78,7 @@
 #define smu_get_current_shallow_sleep_clocks(smu, clocks)		smu_ppt_funcs(get_current_shallow_sleep_clocks, 0, smu, clocks)
 #define smu_dpm_set_vcn_enable(smu, enable)				smu_ppt_funcs(dpm_set_vcn_enable, 0, smu, enable)
 #define smu_dpm_set_jpeg_enable(smu, enable)				smu_ppt_funcs(dpm_set_jpeg_enable, 0, smu, enable)
-#define smu_set_watermarks_table(smu, tab, clock_ranges)		smu_ppt_funcs(set_watermarks_table, 0, smu, tab, clock_ranges)
+#define smu_set_watermarks_table(smu, clock_ranges)			smu_ppt_funcs(set_watermarks_table, 0, smu, clock_ranges)
 #define smu_thermal_temperature_range_update(smu, range, rw)		smu_ppt_funcs(thermal_temperature_range_update, 0, smu, range, rw)
 #define smu_register_irq_handler(smu)					smu_ppt_funcs(register_irq_handler, 0, smu)
 #define smu_get_dpm_ultimate_freq(smu, param, min, max)			smu_ppt_funcs(get_dpm_ultimate_freq, 0, smu, param, min, max)
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
