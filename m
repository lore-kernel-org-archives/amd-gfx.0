Return-Path: <SRS0=uuOW=AN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF95DC433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 09:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4FF720760
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 09:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E0Yt94X3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FF720760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 794246EAB6;
	Thu,  2 Jul 2020 09:45:27 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760081.outbound.protection.outlook.com [40.107.76.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 979CD6EAB5
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2020 09:45:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1nxyITSACqt7ii7SSONkI9U2Y6HT+awb+Qd0gHnI0hJZ02Fp6Fvd0lesVd+Zh171330h5KMQmVZmTo5xksmwWDMhTQi0fDreZ1H7IzVXwPKSPZ5E4cgfHBAVV/KWvosKenHNMYUH3lHPT1xCYaNN0NeaSPCG2J6TMMow5ui1cfZLNlDaqFUUP4GolZLr4jLWysv8TynY2H4MU7A85nGbNhg+xrlW5HBTHszAKqzyx0YhgfQfzLv53Dp2S/dL2Goi+PdvCI0+xBdWEDvYBNXkx9eaGNTeiPM16R2KRQWywea90TgvuMaMRJCGxUZ2VGKQzTHXdJnjvjG6szd9k4i0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7OkJFxyyyyPhGNa9Q2Tkv24O2d24g9N/x66AdBtSxI=;
 b=bs9M6c6B7MLqbnkvlMZ/+oOEO4nuduLDZf4Fer7bMQRRNIBUzJpdn5nrF8buzHToe8qBtpS8rGDuEq97JyvKOifaRg3aP8cO+MHIU5KwWi3LA5p1J0K+n82c37STH4vwhCwM6ihizZ2akw37p205DuzOZYvQKhSo87B8hbQOxIQHQ1Wd2QfmLoZJrsDP+YdwKFzKV3wq2R5UxMB97ZI3Tbu8vdZgYilwRK6nuel3sVWerkSS7G0EVd+vdeEpCU3y6w/w0r69NfEbcsugXkiKoJqy9x3iIpazCKugpu7aHM7Ov7inNb278CjOiT9lEGjdjiKR7Nsrj8TeLErbdd5Rmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7OkJFxyyyyPhGNa9Q2Tkv24O2d24g9N/x66AdBtSxI=;
 b=E0Yt94X36THBn+AQ677/2ixH/hD2wqgQQHBeis/3X+673mPpk9gU7N3JYIWIDec0wZpvpy3WlVFPxMvDNWWRp6gvE4QfboDge/lhdyF5eDEOuy1wtTaiEirWnG44eNeSTZFE7tdeub9PPjVJi2QOWimDAE6Og/uv6gfbCV1GiWU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Thu, 2 Jul 2020 09:45:24 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Thu, 2 Jul 2020
 09:45:24 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amd/powerplay: drop unused code and wrapper around
 clock retrieving
Date: Thu,  2 Jul 2020 17:44:47 +0800
Message-Id: <20200702094447.8158-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702094447.8158-1-evan.quan@amd.com>
References: <20200702094447.8158-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0186.apcprd02.prod.outlook.com
 (2603:1096:201:21::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0186.apcprd02.prod.outlook.com (2603:1096:201:21::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.21 via Frontend Transport; Thu, 2 Jul 2020 09:45:22 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4fec9825-a22a-403f-c64d-08d81e6ca436
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0219A4BDD86552D82490D672E46D0@DM5PR1201MB0219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fIr2kXM02hrAfxd4Fy5YIk5Pd9Zyusl3M7mAwdJbh+ynPdp+PTWe7qIwC10QJwrkElRCAHJM+hq/tTNEiPTHmRl+vDC5fn1gNON/VbxVfjIJ7L4lJzfzSIlk7eDgMQdGN6vwIJ1Yvjqs0qbKy18+lGQj/hh/PeYIfSB4yJELM68W9J2CtVTYiPGKlsuI1iN1ylpL/PVJtfP3sU3ZekVLB2uHxRmGrMTuaqzyUO+inC6Of4SfdJ3k4FD1xVA9wzyqB746q6LSosv45pvLyUEE1pP2gg/ZKKt+TPNpQDExcusO41dfbDqSuiefw1cTRyui5PRsq4nQO/coWO6fv/0wkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(7696005)(52116002)(5660300002)(83380400001)(26005)(8676002)(186003)(16526019)(86362001)(6916009)(2616005)(316002)(6486002)(36756003)(956004)(8936002)(66556008)(66476007)(2906002)(66946007)(1076003)(44832011)(30864003)(6666004)(478600001)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: F2NT1nhbMCdAJEx8UAaCBSRICXTw6FkijoXmLEBJPcErxtPhwBy5htzlndW+oD54a4tswdp5T1mrF97/ekVwT/qza8z14RmpozYu7wHPlmsmoYD3a5VRttpiomvSCIN3nIBOy8vaHzu4Jrf+lRGnihf4b6+bPYcT8lC3CVJmFHnhsK5qwpEMrbiJ02cZXfUAVEZoRvJODizOXyBidMsbzbMmxTHKZLwEIRPHgcesS1I4SOAPm9EqX1rubhn4Kd46C0lSEjdJ5Il3cr411SZLgjB+qK9kp8I4GNkZSNEDkUqYJjPJETrkFjO7hTcvQOI6Fz501PFfw2lGd7HOUz6wmxTANAc3AWLjKfZiFCMrrHVIMjQB+I8QmwDDyZvEpufCsG+fmqXHK1WwqpdeEiVnbs6YdvfkqtKkFnkgI6XiAMusbeGUF9c7fn4vAYE85d0ZF1U5js6AYxoaYnJ+inblik7o2E2ndf/bH5cZ7WSLGtWERereCyBMzt1AkAtsaNFw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fec9825-a22a-403f-c64d-08d81e6ca436
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 09:45:23.9076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/sKddVId+NsY9IrPxpzKZ/CTIIVrseT7IfLHeKkhAcbKbHUodi8wMEVstnmcXn3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0219
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

Clean code by dropping unnecessary ones.

Change-Id: Idf89ef6fa787b61cd8baf8ded7e3f323bdcef189
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  8 +++-
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  3 --
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  8 +---
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |  8 ----
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  8 +++-
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  4 +-
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  8 +++-
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  1 -
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 47 +------------------
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 41 ----------------
 10 files changed, 22 insertions(+), 114 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 2e04ac1d8ff9..5b793e354704 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1212,8 +1212,13 @@ static int arcturus_read_sensor(struct smu_context *smu,
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_VDDGFX:
+		ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
+		*size = 4;
+		break;
 	default:
-		ret = smu_v11_0_read_sensor(smu, sensor, data, size);
+		ret = -EOPNOTSUPP;
+		break;
 	}
 	mutex_unlock(&smu->sensor_lock);
 
@@ -2566,7 +2571,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.set_default_dpm_table = arcturus_set_default_dpm_table,
 	.populate_umd_state_clk = arcturus_populate_umd_state_clk,
 	.get_thermal_temperature_range = arcturus_get_thermal_temperature_range,
-	.get_current_clk_freq_by_table = arcturus_get_current_clk_freq_by_table,
 	.print_clk_levels = arcturus_print_clk_levels,
 	.force_clk_levels = arcturus_force_clk_levels,
 	.read_sensor = arcturus_read_sensor,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index f3bc1f16b0a4..43b4a31b0ffd 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -476,9 +476,6 @@ struct pptable_funcs {
 	int (*get_fan_speed_rpm)(struct smu_context *smu, uint32_t *speed);
 	int (*set_watermarks_table)(struct smu_context *smu, void *watermarks,
 				    struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges);
-	int (*get_current_clk_freq_by_table)(struct smu_context *smu,
-					     enum smu_clk_type clk_type,
-					     uint32_t *value);
 	int (*get_thermal_temperature_range)(struct smu_context *smu, struct smu_temperature_range *range);
 	int (*get_uclk_dpm_states)(struct smu_context *smu, uint32_t *clocks_in_khz, uint32_t *num_states);
 	int (*set_default_od_settings)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index d07bf4fe6e4a..f2f0b738fb4c 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -197,19 +197,13 @@ int smu_v11_0_get_current_power_limit(struct smu_context *smu,
 
 int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n);
 
-int smu_v11_0_get_current_clk_freq(struct smu_context *smu,
-					  enum smu_clk_type clk_id,
-					  uint32_t *value);
-
 int smu_v11_0_init_max_sustainable_clocks(struct smu_context *smu);
 
 int smu_v11_0_enable_thermal_alert(struct smu_context *smu);
 
 int smu_v11_0_disable_thermal_alert(struct smu_context *smu);
 
-int smu_v11_0_read_sensor(struct smu_context *smu,
-				 enum amd_pp_sensors sensor,
-				 void *data, uint32_t *size);
+int smu_v11_0_get_gfx_vdd(struct smu_context *smu, uint32_t *value);
 
 int smu_v11_0_set_min_deep_sleep_dcefclk(struct smu_context *smu, uint32_t clk);
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
index d29f75223987..0c1e1455c68f 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
@@ -60,10 +60,6 @@ int smu_v12_0_powergate_jpeg(struct smu_context *smu, bool gate);
 
 int smu_v12_0_set_gfx_cgpg(struct smu_context *smu, bool enable);
 
-int smu_v12_0_read_sensor(struct smu_context *smu,
-			  enum amd_pp_sensors sensor,
-			  void *data, uint32_t *size);
-
 uint32_t smu_v12_0_get_gfxoff_status(struct smu_context *smu);
 
 int smu_v12_0_gfx_off_control(struct smu_context *smu, bool enable);
@@ -77,10 +73,6 @@ int smu_v12_0_set_default_dpm_tables(struct smu_context *smu);
 int smu_v12_0_get_enabled_mask(struct smu_context *smu,
 				      uint32_t *feature_mask, uint32_t num);
 
-int smu_v12_0_get_current_clk_freq(struct smu_context *smu,
-					  enum smu_clk_type clk_id,
-					  uint32_t *value);
-
 int smu_v12_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
 						 uint32_t *min, uint32_t *max);
 
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 3dab6f0e9578..1f96a8ac3fa8 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1707,8 +1707,13 @@ static int navi10_read_sensor(struct smu_context *smu,
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_VDDGFX:
+		ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
+		*size = 4;
+		break;
 	default:
-		ret = smu_v11_0_read_sensor(smu, sensor, data, size);
+		ret = -EOPNOTSUPP;
+		break;
 	}
 	mutex_unlock(&smu->sensor_lock);
 
@@ -2399,7 +2404,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.set_default_dpm_table = navi10_set_default_dpm_table,
 	.dpm_set_vcn_enable = navi10_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = navi10_dpm_set_jpeg_enable,
-	.get_current_clk_freq_by_table = navi10_get_current_clk_freq_by_table,
 	.print_clk_levels = navi10_print_clk_levels,
 	.force_clk_levels = navi10_force_clk_levels,
 	.populate_umd_state_clk = navi10_populate_umd_state_clk,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index d77e6de95b18..00fac13f06d6 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -907,7 +907,8 @@ static int renoir_read_sensor(struct smu_context *smu,
 		*size = 4;
 		break;
 	default:
-		ret = smu_v12_0_read_sensor(smu, sensor, data, size);
+		ret = -EOPNOTSUPP;
+		break;
 	}
 	mutex_unlock(&smu->sensor_lock);
 
@@ -941,7 +942,6 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.get_current_power_state = renoir_get_current_power_state,
 	.dpm_set_vcn_enable = renoir_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = renoir_dpm_set_jpeg_enable,
-	.get_current_clk_freq_by_table = renoir_get_current_clk_freq_by_table,
 	.force_dpm_limit_value = renoir_force_dpm_limit_value,
 	.unforce_dpm_levels = renoir_unforce_dpm_levels,
 	.get_workload_type = renoir_get_workload_type,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index e6e9583b1180..7078afbd9a6b 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1510,8 +1510,13 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_VDDGFX:
+		ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
+		*size = 4;
+		break;
 	default:
-		ret = smu_v11_0_read_sensor(smu, sensor, data, size);
+		ret = -EOPNOTSUPP;
+		break;
 	}
 	mutex_unlock(&smu->sensor_lock);
 
@@ -2480,7 +2485,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
 	.dpm_set_vcn_enable = sienna_cichlid_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = sienna_cichlid_dpm_set_jpeg_enable,
-	.get_current_clk_freq_by_table = sienna_cichlid_get_current_clk_freq_by_table,
 	.print_clk_levels = sienna_cichlid_print_clk_levels,
 	.force_clk_levels = sienna_cichlid_force_clk_levels,
 	.populate_umd_state_clk = sienna_cichlid_populate_umd_state_clk,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index f0fb74a05f80..8fbfa0562007 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -86,7 +86,6 @@
 #define smu_dpm_set_vcn_enable(smu, enable)				smu_ppt_funcs(dpm_set_vcn_enable, 0, smu, enable)
 #define smu_dpm_set_jpeg_enable(smu, enable)				smu_ppt_funcs(dpm_set_jpeg_enable, 0, smu, enable)
 #define smu_set_watermarks_table(smu, tab, clock_ranges)		smu_ppt_funcs(set_watermarks_table, 0, smu, tab, clock_ranges)
-#define smu_get_current_clk_freq_by_table(smu, clk_type, value)		smu_ppt_funcs(get_current_clk_freq_by_table, 0, smu, clk_type, value)
 #define smu_thermal_temperature_range_update(smu, range, rw)		smu_ppt_funcs(thermal_temperature_range_update, 0, smu, range, rw)
 #define smu_get_thermal_temperature_range(smu, range)			smu_ppt_funcs(get_thermal_temperature_range, 0, smu, range)
 #define smu_register_irq_handler(smu)					smu_ppt_funcs(register_irq_handler, 0, smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 952e21234929..560ddf382e4f 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1084,26 +1084,6 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 	return 0;
 }
 
-int smu_v11_0_get_current_clk_freq(struct smu_context *smu,
-					  enum smu_clk_type clk_id,
-					  uint32_t *value)
-{
-	int ret = 0;
-	uint32_t freq = 0;
-
-	if (clk_id >= SMU_CLK_COUNT || !value)
-		return -EINVAL;
-
-	ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
-	if (ret)
-		return ret;
-
-	freq *= 100;
-	*value = freq;
-
-	return ret;
-}
-
 int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
 {
 	int ret = 0;
@@ -1153,7 +1133,7 @@ static uint16_t convert_to_vddc(uint8_t vid)
 	return (uint16_t) ((6200 - (vid * 25)) / SMU11_VOLTAGE_SCALE);
 }
 
-static int smu_v11_0_get_gfx_vdd(struct smu_context *smu, uint32_t *value)
+int smu_v11_0_get_gfx_vdd(struct smu_context *smu, uint32_t *value)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t vdd = 0, val_vid = 0;
@@ -1172,31 +1152,6 @@ static int smu_v11_0_get_gfx_vdd(struct smu_context *smu, uint32_t *value)
 
 }
 
-int smu_v11_0_read_sensor(struct smu_context *smu,
-				 enum amd_pp_sensors sensor,
-				 void *data, uint32_t *size)
-{
-	int ret = 0;
-
-	if(!data || !size)
-		return -EINVAL;
-
-	switch (sensor) {
-	case AMDGPU_PP_SENSOR_VDDGFX:
-		ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
-		*size = 4;
-		break;
-	default:
-		ret = -EOPNOTSUPP;
-		break;
-	}
-
-	if (ret)
-		*size = 0;
-
-	return ret;
-}
-
 int
 smu_v11_0_display_clock_voltage_request(struct smu_context *smu,
 					struct pp_display_clock_request
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 4fb3f4984206..e46fc6178235 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -203,27 +203,6 @@ int smu_v12_0_set_gfx_cgpg(struct smu_context *smu, bool enable)
 		NULL);
 }
 
-int smu_v12_0_read_sensor(struct smu_context *smu,
-				 enum amd_pp_sensors sensor,
-				 void *data, uint32_t *size)
-{
-	int ret = 0;
-
-	if(!data || !size)
-		return -EINVAL;
-
-	switch (sensor) {
-	default:
-		ret = -EOPNOTSUPP;
-		break;
-	}
-
-	if (ret)
-		*size = 0;
-
-	return ret;
-}
-
 /**
  * smu_v12_0_get_gfxoff_status - get gfxoff status
  *
@@ -337,26 +316,6 @@ int smu_v12_0_get_enabled_mask(struct smu_context *smu,
 	return ret;
 }
 
-int smu_v12_0_get_current_clk_freq(struct smu_context *smu,
-					  enum smu_clk_type clk_id,
-					  uint32_t *value)
-{
-	int ret = 0;
-	uint32_t freq = 0;
-
-	if (clk_id >= SMU_CLK_COUNT || !value)
-		return -EINVAL;
-
-	ret = smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
-	if (ret)
-		return ret;
-
-	freq *= 100;
-	*value = freq;
-
-	return ret;
-}
-
 int smu_v12_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
 						 uint32_t *min, uint32_t *max)
 {
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
