Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F0DC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 09:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE0C2088E
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 09:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CJccsRpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE0C2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 076FC6E46C;
	Thu, 28 May 2020 09:03:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C3F36E46C
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 09:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkBODssVZj3yd7KT7/180MSYlBpRAKsSa+VVEb1Uimi5XKLc/TK+aPaZoJ2ChO8cvGtkDud5J4dnm5PK2Mq2pcqNDKwueWiiJ+EzZIoACjMXWa2cqOh0qZR42ucxC3wV87a6Mx9xNT6tQ3b2JbI+6M/aW2q/49yPK2Dr+qtuUR7kL2uM+0pwLhNVVUfSwCM0FepgeMXXQdtEJc8ENYrEcSH3BRL672+LILjhP4yYx5asCouNOKmIrngGrx+6u2nP3lPb/1oVrPdfhLfOSkjVfsRnMuQ935sfo6gJ3pltWbWq6KeGRQeSP/O9a68GI5dTdoeqocDP/aCZ0Qmh2u4Kyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdB3GuVrKIYYC0A64RdhIlMcI+bZNx1C1JVoRvh3kXw=;
 b=fbEKuuNEozWLIn/dkrN+xZETudM8GNAerrXjLnPGoHiHIYblaDupBuhc2NLyOHgk4SDFv9aZQkC5B4BNgligcfkhSR4cx0ScSFOf6tRawVqBdhXdkZDn3IPz6kAAgWqrjZDth9iw7e7MTGnQCA8JRbipS55Ct6hQ7MQIhXLGzW/BDr9GriiEoZGNFQMgrQJkNK7dlud2j3BNgfcHAwhQb3xo0j9h2BAO2KzcPATj17TC5M71DxNLOv44tgCzAxtPOHoPTgyh9Bbt9G4Gaj2xF4NtPu2TduQIxm96oo7/IA0XtPfzbUU7RV4svwxBdRjh9dDVANYgg08Ck3vX4YXr7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdB3GuVrKIYYC0A64RdhIlMcI+bZNx1C1JVoRvh3kXw=;
 b=CJccsRpNr5ynyWd+tpR1mhegEqjB41132OXR41Vj+0/Vbn+8SOU2kOasAvK4r5ffmRXJD1x6PPkY+EIcTWsyinz2w4ObAXF8JFZij6h/u9brePFsehwv4K9Sfgd/nCeqLrlX5T3SKE8yKYMzx9A0vlxblzZ4T/2HLCP1X/NiGZI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17; Thu, 28 May 2020 09:03:08 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3021.029; Thu, 28 May 2020
 09:03:08 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amd/powerplay: give better names for the thermal IRQ
 related APIs
Date: Thu, 28 May 2020 17:02:41 +0800
Message-Id: <20200528090241.25291-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528090241.25291-1-evan.quan@amd.com>
References: <20200528090241.25291-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0067.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::31) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0067.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend
 Transport; Thu, 28 May 2020 09:03:07 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97b1aebc-5e41-4e4b-6fc7-08d802e5f0cb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4353ADF3C91DF828C6D8A6CAE48E0@DM6PR12MB4353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:13;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpegh8e1TKXM6LGBs2b6j07dhpSn+6XvsoGppvpTMNfGhit3H0EaOw5/eZVTOwd0e4H/5ZEOvGp/6aa0OW01qUbHbHCAzsLiUf2hpQ9k7m4/nMKWn+RdwEv1QmNSX54FpRR80asCjB8hkP3EXbOZC1APWlmvQuV16+B+AJp1V9KBzn856zkgAPIjgKcd8Yo/V1q4eiAJaC3isv7MQ8XaBzdUQp/vvoZmeN44FDzt7YU+z7l+NBJeV2/AFQq4BnAnIwNIdOM6Ik+jEm3aqTeoG1iSLChW5sw0xcyOJ9bIKFSuaMdEZYqI4xqXLZOlIu/8rPXZzW89f/14zAE5iNtRRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(6486002)(2616005)(44832011)(66556008)(66476007)(66946007)(4326008)(5660300002)(2906002)(186003)(83380400001)(1076003)(316002)(52116002)(956004)(36756003)(7696005)(16526019)(478600001)(8676002)(8936002)(26005)(86362001)(6666004)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: YhrN6fiTsK61gmZLmwebOP93TQhPYvaJtFEpy9ciaQnkz0QWEWjyek9MRM9GlQKYJOq1thR30sl19eNLEmSQ/+SUqPVopLudNvOTHJWXvgB6YZDUB2NturPdBshHIujenln9QWI8T9OBcRM31J+RDTQzDkD2Fx7BsNJzIZfrk7MRoraqRkFmvK3vX0bxevYO1Hl5rMyLBzKmnT5ZHG7BI8fXtB5tkSPO4owNwUZSksi77uiV1fjYXlJvGBNCwfhSIErUyperkoUVooCpMAvtEotComG6SV1yID7ppCKQFJw08v+gwI7JFg7jr2UbrRGfsBa8j2xmTUkUx/FfGF/dcykm62ls2dUeUiuVDRQmzAyG/JJShmTCYB0NZktH944Ff9d9IyVtIbHd8c/CHFra6eWFHCrZqEfEQH4BWs9HfsG1aRXgwmQWuE+1koMOVvA/F30vHFoiTYla0BimLVqKlxwMRvkEvx2PGI8x+yXUrC30KoEbOFSvc4k2QTITG1tb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b1aebc-5e41-4e4b-6fc7-08d802e5f0cb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 09:03:08.5994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0hvu0qXv3XcaQ1Hm3XitsAu+d2eIozGJ/YLfr0qwThfhwRTkueEonoEFUwi1sa+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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

Thermal control is performed by PMFW. What handled in driver is
just whether or not to enable the alert(to driver).

Change-Id: Icf857054b74f021e7fee2bf3aa9b314aa0d5ef09
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 8 ++++----
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c   | 4 ++--
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 4 ++--
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h  | 4 ++--
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c     | 4 ++--
 drivers/gpu/drm/amd/powerplay/smu_internal.h   | 8 ++++----
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c      | 4 ++--
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 12511407683d..5294aa7cdde1 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1350,7 +1350,7 @@ static int smu_hw_init(void *handle)
 	if (ret)
 		goto failed;
 
-	ret = smu_start_thermal_control(smu);
+	ret = smu_enable_thermal_alert(smu);
 	if (ret)
 		goto failed;
 
@@ -1396,7 +1396,7 @@ static int smu_hw_fini(void *handle)
 
 	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
 
-	ret = smu_stop_thermal_control(smu);
+	ret = smu_disable_thermal_alert(smu);
 	if (ret) {
 		pr_warn("Fail to stop thermal control!\n");
 		return ret;
@@ -1537,7 +1537,7 @@ static int smu_suspend(void *handle)
 
 	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
 
-	ret = smu_stop_thermal_control(smu);
+	ret = smu_disable_thermal_alert(smu);
 	if (ret) {
 		pr_warn("Fail to stop thermal control!\n");
 		return ret;
@@ -1582,7 +1582,7 @@ static int smu_resume(void *handle)
 	if (ret)
 		goto failed;
 
-	ret = smu_start_thermal_control(smu);
+	ret = smu_enable_thermal_alert(smu);
 	if (ret)
 		goto failed;
 
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 5c1b2d7abcaa..302b7e9cb5ba 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2442,8 +2442,8 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.set_power_limit = smu_v11_0_set_power_limit,
 	.get_current_clk_freq = smu_v11_0_get_current_clk_freq,
 	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
-	.start_thermal_control = smu_v11_0_start_thermal_control,
-	.stop_thermal_control = smu_v11_0_stop_thermal_control,
+	.enable_thermal_alert = smu_v11_0_enable_thermal_alert,
+	.disable_thermal_alert = smu_v11_0_disable_thermal_alert,
 	.set_deep_sleep_dcefclk = smu_v11_0_set_deep_sleep_dcefclk,
 	.display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 1223d298c03f..5bb1ac821aeb 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -530,8 +530,8 @@ struct pptable_funcs {
 	int (*set_power_limit)(struct smu_context *smu, uint32_t n);
 	int (*get_current_clk_freq)(struct smu_context *smu, enum smu_clk_type clk_id, uint32_t *value);
 	int (*init_max_sustainable_clocks)(struct smu_context *smu);
-	int (*start_thermal_control)(struct smu_context *smu);
-	int (*stop_thermal_control)(struct smu_context *smu);
+	int (*enable_thermal_alert)(struct smu_context *smu);
+	int (*disable_thermal_alert)(struct smu_context *smu);
 	int (*set_deep_sleep_dcefclk)(struct smu_context *smu, uint32_t clk);
 	int (*set_active_display_count)(struct smu_context *smu, uint32_t count);
 	int (*store_cc6_data)(struct smu_context *smu, uint32_t separation_time,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index f3f34a0f5602..71f829ab306e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -207,9 +207,9 @@ int smu_v11_0_get_current_clk_freq(struct smu_context *smu,
 
 int smu_v11_0_init_max_sustainable_clocks(struct smu_context *smu);
 
-int smu_v11_0_start_thermal_control(struct smu_context *smu);
+int smu_v11_0_enable_thermal_alert(struct smu_context *smu);
 
-int smu_v11_0_stop_thermal_control(struct smu_context *smu);
+int smu_v11_0_disable_thermal_alert(struct smu_context *smu);
 
 int smu_v11_0_read_sensor(struct smu_context *smu,
 				 enum amd_pp_sensors sensor,
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index ef4952afb365..68142f6798c6 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2320,8 +2320,8 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.set_power_limit = smu_v11_0_set_power_limit,
 	.get_current_clk_freq = smu_v11_0_get_current_clk_freq,
 	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
-	.start_thermal_control = smu_v11_0_start_thermal_control,
-	.stop_thermal_control = smu_v11_0_stop_thermal_control,
+	.enable_thermal_alert = smu_v11_0_enable_thermal_alert,
+	.disable_thermal_alert = smu_v11_0_disable_thermal_alert,
 	.set_deep_sleep_dcefclk = smu_v11_0_set_deep_sleep_dcefclk,
 	.display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 6b627d6e80b1..6c59eeef2590 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -118,10 +118,10 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
 	((smu)->ppt_funcs->tables_init ? (smu)->ppt_funcs->tables_init((smu), (tab)) : 0)
 #define smu_set_thermal_fan_table(smu) \
 	((smu)->ppt_funcs->set_thermal_fan_table ? (smu)->ppt_funcs->set_thermal_fan_table((smu)) : 0)
-#define smu_start_thermal_control(smu) \
-	((smu)->ppt_funcs->start_thermal_control? (smu)->ppt_funcs->start_thermal_control((smu)) : 0)
-#define smu_stop_thermal_control(smu) \
-	((smu)->ppt_funcs->stop_thermal_control? (smu)->ppt_funcs->stop_thermal_control((smu)) : 0)
+#define smu_enable_thermal_alert(smu) \
+	((smu)->ppt_funcs->enable_thermal_alert? (smu)->ppt_funcs->enable_thermal_alert((smu)) : 0)
+#define smu_disable_thermal_alert(smu) \
+	((smu)->ppt_funcs->disable_thermal_alert? (smu)->ppt_funcs->disable_thermal_alert((smu)) : 0)
 
 #define smu_smc_read_sensor(smu, sensor, data, size) \
 	((smu)->ppt_funcs->read_sensor? (smu)->ppt_funcs->read_sensor((smu), (sensor), (data), (size)) : -EINVAL)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 728965ab6d83..d6bdd2126f72 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1176,7 +1176,7 @@ static int smu_v11_0_set_thermal_range(struct smu_context *smu,
 	return 0;
 }
 
-int smu_v11_0_start_thermal_control(struct smu_context *smu)
+int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
 {
 	int ret = 0;
 	struct smu_temperature_range range;
@@ -1215,7 +1215,7 @@ int smu_v11_0_start_thermal_control(struct smu_context *smu)
 	return ret;
 }
 
-int smu_v11_0_stop_thermal_control(struct smu_context *smu)
+int smu_v11_0_disable_thermal_alert(struct smu_context *smu)
 {
 	return amdgpu_irq_put(smu->adev, smu->irq_source, 0);
 }
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
