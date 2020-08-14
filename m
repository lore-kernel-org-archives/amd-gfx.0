Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE8EC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 04:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 436E920708
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 04:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PInOILZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436E920708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED11F6E2D1;
	Fri, 14 Aug 2020 04:23:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B7816E2D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 04:23:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7uc5/e6ZEnS0IsCtYUbhhDnxswGq7kPiVdj1PlOMlLZBtkMckMYwg1DheS3H7hCruU9VTyGc57ZeihCYNAETnHOkHVRNM0evZ29LXiOZLvct88Qhh2BFUIKWjlzNXXdWCemZeD5+mDMX5VsgBReqjv1CzwVzT2ESfLDQ+ixOBuLEk2Rux7UoMcGHKzdyEk9SWOaWv0Ii/XIaWVPnGPBmh+wTZIot/arngN1C6ouzEoJrVT6ZZYGSbJQactHO7/qKkdf4Us4DY4JCwTzDX6HDgZ/4vwZ6VQPzgLRRt+JqANGNjvr0DTLohQqioby/P7QMbswE3n6+Ogbq0ud5Z+BJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zgsodjZa98EoENFVjbHw31pSR1eQOzgVJwCqXBZQs0=;
 b=UsTYNuNCztgCCxCJu7ABFJb0blktWIL8hiaUoSdmZgLRB3me/fUl/qij59VSapbt7pYTVmou3nLz/HRId+kL6n6HSfPgTgazvs8GL19ru1xizFEI1MMeaiGJEw2sIBXrQhCoYht5BOeGax8ZxVhBuPEw9rPW2c0qlWAB5ptuI3fjyN00IrqHIXcA4vXaphaIFxKzNbtBklH+Y9Keox+tfn2XTOH4Vns0HX5jQrhqJ1yIE0eQB5zzeKSSYI0TlQxTHlVIJIkiJHifK3Qi1o9IWk27ERHxIEf4/UtgiflYp4m7Q0+JaWyhppnoUuTYxl4gLhbtBUsrcyyCFUP5Pp3Q4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zgsodjZa98EoENFVjbHw31pSR1eQOzgVJwCqXBZQs0=;
 b=PInOILZ6xQwOlDrYtABzc4OXiRTwCzYy/XHAIfDl4Xjy6d9c4qCN7bh5GzRtlxt/pon32KdvfoZT8H3PGxeQvP2vg4oo98azuZzoXyJy2+RRWdBpeBKNyc43gmGdmV2cTKpx1zrCOOY2B/2KYIlyrWLVobt0DMmzZG0iyoQkUzI=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (20.176.117.82) by
 DM5PR12MB1163.namprd12.prod.outlook.com (10.168.240.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16; Fri, 14 Aug 2020 04:23:47 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.015; Fri, 14 Aug 2020
 04:23:47 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: minor cleanups
Thread-Topic: [PATCH] drm/amd/powerplay: minor cleanups
Thread-Index: AQHWb5DkdbtAkObPgUGMeTha3wXNjak3BiWQ
Date: Fri, 14 Aug 2020 04:23:47 +0000
Message-ID: <DM6PR12MB261959BEE5B2846995A888CEE4400@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200811033813.1236-1-evan.quan@amd.com>
In-Reply-To: <20200811033813.1236-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=cf3eec32-d14a-4e4e-8c34-0cb0498c6a69;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-14T04:23:20Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f4244d84-2ecc-4950-fcee-08d84009d6fc
x-ms-traffictypediagnostic: DM5PR12MB1163:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1163D441F50214E6BAC4387AE4400@DM5PR12MB1163.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:82;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O4gPpPouHMZBqzRH1Rzf0lFIsdSVTWYwxwUvsBPeX/ZjpeKW4CwQOY/UbpHz/ouAvUG4uB2xs9ZcZyxz5Y8x1+cy077QcIekGzlSrMlSHtS8b4zPWewrktPdTSP7We5OapVmuCcvU3UWUa+euJuY33q0UFZs0fU3S3lvP8baIQVWfKZDyjTC4lyvNTgRxPoHMr5eeLK3bEHs6Ts3WngJjQZuIIC8m90/25RpTIYULQx4CF8Bte4jvcyXjSiZ29P+yamZ0mQGb75ziCMcnnUl6p9cpnzuHO0SbO5svuu0tJ6XIfAYbPcTNvYLqICyf0dz6iGBYwrU6FQxtP3VwYClWg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(186003)(52536014)(7696005)(26005)(8676002)(6506007)(30864003)(8936002)(2906002)(53546011)(55016002)(9686003)(5660300002)(86362001)(478600001)(66946007)(83380400001)(4326008)(76116006)(316002)(66476007)(71200400001)(33656002)(66446008)(64756008)(66556008)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: b16nvS5myc8mgHCm3Y7mkhDSpoZtX4QqZ0uot6Aqpai3jTiTh60Ev4BGK54VrFCKkNEIuIYOZHXpkyaxX7Lqmx05fLbQqzfcjSvkpeppte9KuV2SEn/rtck31kZ4qRhj/7jNR8qxM3goRYQN9gumuzur17NIm8ixZW74poYjb762fvVmnMh/MkUDIWpB3eJgskMtVBoNA7tKbl9/ObJLQ3lqnDCIRcu2Xz4z6EqOl8IQCw3/cHTU9Fj/2Am/wiGDxWW78U43hvQGAMwVBanXHoKBv5UiANZUoYzBUoNP31L9v1dnd6eDJmcLkYz48Wkmu0auVIFXuCGxa/PI5mrwsxrr8DnQyOPjuRRwcHxXiT79p0cj5CLhZHPoCr4Poh5pQnoe+XiruA1VrLBnPnqiSPtPItCF3ltyLsyVuu+qqYWl+9mW6W3zKzd9xY5voeKD8E6O0x52lpPBnjzrqkEoGQdqboJFB1zpYO/p74Ld7XrKlavxDXObF+cadS+2pDZ8tfqa6LEc4YbHi4c2kwAnJyBdc/q76Qq0pV9JUgVmh3MlgFx5IeldGB2pWpAPT55MDwQqP9PjeS1pxreCSHQYPl3DntUZX/Pw8Mqlc3tfjOT+S2alisTQo9lKpJqA3VCN9GV0w9hRohiyonwtvJZIIQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4244d84-2ecc-4950-fcee-08d84009d6fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 04:23:47.7593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3tQALMU277CsoIzkpEpE/Y1hfurhlnLGksxL6I4L2VnPHPsRj+YKGadhpRpmvhb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping..

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Tuesday, August 11, 2020 11:38 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/powerplay: minor cleanups

Drop unnecessary lock protections during hw setup which was confirmed to have no race condition. Drop also unnecessary null pointer checker.

Change-Id: Ida301ae7bad1abae15285c4e019eda4f7dc6e297
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 20 --------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  2 -
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  2 -
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  2 -
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  1 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 50 ++++---------------
 7 files changed, 11 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 1ffacc712e53..c70f94377644 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -361,20 +361,16 @@ static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
 int ret = 0;
 uint32_t allowed_feature_mask[SMU_FEATURE_MAX/32];

-mutex_lock(&feature->mutex);
 bitmap_zero(feature->allowed, SMU_FEATURE_MAX);
-mutex_unlock(&feature->mutex);

 ret = smu_get_allowed_feature_mask(smu, allowed_feature_mask,
      SMU_FEATURE_MAX/32);
 if (ret)
 return ret;

-mutex_lock(&feature->mutex);
 bitmap_or(feature->allowed, feature->allowed,
       (unsigned long *)allowed_feature_mask,
       feature->feature_num);
-mutex_unlock(&feature->mutex);

 return ret;
 }
@@ -576,9 +572,6 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
 struct smu_table *tables = smu_table->tables;
 struct smu_table *driver_table = &(smu_table->driver_table);

-if (!tables)
-return 0;
-
 if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
 amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
       &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
@@ -2250,19 +2243,6 @@ int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk)
 return ret;
 }

-int smu_set_active_display_count(struct smu_context *smu, uint32_t count) -{
-int ret = 0;
-
-if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-return -EOPNOTSUPP;
-
-if (smu->ppt_funcs->set_active_display_count)
-ret = smu->ppt_funcs->set_active_display_count(smu, count);
-
-return ret;
-}
-
 int smu_get_clock_by_type(struct smu_context *smu,
   enum amd_pp_clock_type type,
   struct amd_pp_clocks *clocks)
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 8b1025dc54fd..25679d60f7b4 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -386,11 +386,9 @@ static int arcturus_check_powerplay_table(struct smu_context *smu)
 table_context->power_play_table;
 struct smu_baco_context *smu_baco = &smu->smu_baco;

-mutex_lock(&smu_baco->mutex);
 if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_BACO ||
     powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_MACO)
 smu_baco->platform_support = true;
-mutex_unlock(&smu_baco->mutex);

 table_context->thermal_controller_type =
 powerplay_table->thermal_controller_type;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 23c2279bd500..8de39b31e7c2 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -698,7 +698,6 @@ int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed);  int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed);

 int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk); -int smu_set_active_display_count(struct smu_context *smu, uint32_t count);

 int smu_get_clock_by_type(struct smu_context *smu,
   enum amd_pp_clock_type type,
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 42a60769c52f..61e2971be9f3 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -346,11 +346,9 @@ static int navi10_check_powerplay_table(struct smu_context *smu)
 if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_HARDWAREDC)
 smu->dc_controlled_by_gpio = true;

-mutex_lock(&smu_baco->mutex);
 if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_BACO ||
     powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_MACO)
 smu_baco->platform_support = true;
-mutex_unlock(&smu_baco->mutex);

 table_context->thermal_controller_type =
 powerplay_table->thermal_controller_type;
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index c5935f0a065b..f55dd0c2f3c8 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -294,11 +294,9 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 table_context->power_play_table;
 struct smu_baco_context *smu_baco = &smu->smu_baco;

-mutex_lock(&smu_baco->mutex);
 if (powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_BACO ||
     powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_MACO)
 smu_baco->platform_support = true;
-mutex_unlock(&smu_baco->mutex);

 table_context->thermal_controller_type =
 powerplay_table->thermal_controller_type;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 264073d4e263..e44d705780b9 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -42,6 +42,7 @@
 #define smu_check_fw_version(smu)smu_ppt_funcs(check_fw_version, 0, smu)
 #define smu_write_pptable(smu)smu_ppt_funcs(write_pptable, 0, smu)
 #define smu_set_min_dcef_deep_sleep(smu, clk)smu_ppt_funcs(set_min_dcef_deep_sleep, 0, smu, clk)
+#define smu_set_active_display_count(smu, count)smu_ppt_funcs(set_active_display_count, 0, smu, count)
 #define smu_set_driver_table_location(smu)smu_ppt_funcs(set_driver_table_location, 0, smu)
 #define smu_set_tool_table_location(smu)smu_ppt_funcs(set_tool_table_location, 0, smu)
 #define smu_notify_memory_pool_location(smu)smu_ppt_funcs(notify_memory_pool_location, 0, smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 580889a02a94..4b6162863ed6 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -453,9 +453,6 @@ int smu_v11_0_init_power(struct smu_context *smu)  {
 struct smu_power_context *smu_power = &smu->smu_power;

-if (smu_power->power_context || smu_power->power_context_size != 0)
-return -EINVAL;
-
 smu_power->power_context = kzalloc(sizeof(struct smu_11_0_dpm_context),
    GFP_KERNEL);
 if (!smu_power->power_context)
@@ -469,9 +466,6 @@ int smu_v11_0_fini_power(struct smu_context *smu)  {
 struct smu_power_context *smu_power = &smu->smu_power;

-if (!smu_power->power_context || smu_power->power_context_size == 0)
-return -EINVAL;
-
 kfree(smu_power->power_context);
 smu_power->power_context = NULL;
 smu_power->power_context_size = 0;
@@ -700,18 +694,16 @@ int smu_v11_0_set_tool_table_location(struct smu_context *smu)

 int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)  {
-int ret = 0;
 struct amdgpu_device *adev = smu->adev;

 /* Navy_Flounder do not support to change display num currently */
 if (adev->asic_type == CHIP_NAVY_FLOUNDER)
 return 0;

-if (!smu->pm_enabled)
-return ret;
-
-ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, count, NULL);
-return ret;
+return smu_cmn_send_smc_msg_with_param(smu,
+       SMU_MSG_NumOfDisplays,
+       count,
+       NULL);
 }


@@ -721,7 +713,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 int ret = 0;
 uint32_t feature_mask[2];

-mutex_lock(&feature->mutex);
 if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64)
 goto failed;

@@ -738,7 +729,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 goto failed;

 failed:
-mutex_unlock(&feature->mutex);
 return ret;
 }

@@ -775,9 +765,6 @@ int smu_v11_0_notify_display_change(struct smu_context *smu)  {
 int ret = 0;

-if (!smu->pm_enabled)
-return ret;
-
 if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
     smu->adev->gmc.vram_type == AMDGPU_VRAM_TYPE_HBM)
 ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL); @@ -1185,12 +1172,10 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,  int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
      uint32_t pstate)
 {
-int ret = 0;
-ret = smu_cmn_send_smc_msg_with_param(smu,
-  SMU_MSG_SetXgmiMode,
-  pstate ? XGMI_MODE_PSTATE_D0 : XGMI_MODE_PSTATE_D3,
+return smu_cmn_send_smc_msg_with_param(smu,
+       SMU_MSG_SetXgmiMode,
+       pstate ? XGMI_MODE_PSTATE_D0 : XGMI_MODE_PSTATE_D3,
   NULL);
-return ret;
 }

 static int smu_v11_0_set_irq_state(struct amdgpu_device *adev, @@ -1421,11 +1406,7 @@ int smu_v11_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,

 int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu)  {
-int ret = 0;
-
-ret = smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
-
-return ret;
+return smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
 }

 static int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu, enum smu_v11_0_baco_seq baco_seq) @@ -1436,13 +1417,8 @@ static int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu, enum smu_v  bool smu_v11_0_baco_is_support(struct smu_context *smu)  {
 struct smu_baco_context *smu_baco = &smu->smu_baco;
-bool baco_support;
-
-mutex_lock(&smu_baco->mutex);
-baco_support = smu_baco->platform_support;
-mutex_unlock(&smu_baco->mutex);

-if (!baco_support)
+if (!smu_baco->platform_support)
 return false;

 /* Arcturus does not support this bit mask */ @@ -1529,13 +1505,7 @@ int smu_v11_0_baco_enter(struct smu_context *smu)

 int smu_v11_0_baco_exit(struct smu_context *smu)  {
-int ret = 0;
-
-ret = smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
-if (ret)
-return ret;
-
-return ret;
+return smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
 }

 int smu_v11_0_mode1_reset(struct smu_context *smu)
--
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
