Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D514C88E75
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 06:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC9F010E823;
	Fri, 18 Sep 2026 06:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HHj7ySAF";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011040.outbound.protection.outlook.com
 [40.93.194.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D296F10E823
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 06:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HO/EJ/xSaXqwwwax0ugmOa7V4vbQlyCN+G6LaBKMJTweXwl2Sl2sSoMhrj4LzSwxxKR3tZXcwITwo51D4H/YZjPeOylZzFO8/Ry8cX5/OgkVzkQepinYc+dZHzdZVyM/9/ogDM5R6tUhB2XWcEiIqkAWzAsASFTwV/V4A8qOTNi9Ib6kP+AurPxFIq3LsYYo32EqIyPtPv/5X8cybuUSP98SdKDpfhp4BETwyU+t9eWDU1RPjWNM8qszdRSm6k4xBM8dGnewWESdSBiOFZxr/tidkQ7G5HuUv6CB8gUMGiH8wpt8+tospAHPj/iawv3ihOtPXjtVioki81b/uh/JRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tjd/AyMgkHqcJlnK3Zse4pqcWqmsEHlSE0F2K9uETCU=;
 b=BHdbKkFSHUqJSzaLq4SRFutCsvL8XhBTsCfw3ApqGu50VIcGqeLoyl86GIU+dcT8tYin9h4exiffjO7TOWNzjcalvW+Ee8ro1VLJU3P9+cveYwyyCG8D87Rvp26NZFK/AM6581y9v3ZMK89L75Mys4ha7fp2a76wsovOGFUUIk/F0UGLEArlJee1IY+pSC7nyWAhKiIEhQTWvccT1HmAj0PJa8GstSYZoe5X6IziAQHHnuVTA259uFLJCSjDIR5aNeikXjskocGRfwfXcwQH1aQQtmIE9gdpAxvQtEKthpvhtubL9kFlLNPq0f+9PcJCoDJMJHgFwzUUgTswwu3HlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tjd/AyMgkHqcJlnK3Zse4pqcWqmsEHlSE0F2K9uETCU=;
 b=HHj7ySAFsL04LXziIEG0YpVRFGt29KeIDBOT53oX//TfdD75OlLr/K3RDd4WHjMsV7a2FEJagD85V9x18qCuZiktD96l4tgYuWfgCrGsobTFLqFNPFohYdgyctgCxw1r91UAGtYgef/+bbRQ6ljJFZjp+ze5XUrp6Rj2m4SiNLg=
Received: from DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) by
 CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.9; Fri, 18 Sep 2026 06:46:30 +0000
Received: from DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729]) by DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 06:46:29 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Create NPM sysfs files from capability
Thread-Topic: [PATCH] drm/amd/pm: Create NPM sysfs files from capability
Thread-Index: AQHdRyH5bXogHwxcXk2AcSBAsK5JcLbT5JQg
Date: Fri, 18 Sep 2026 06:46:29 +0000
Message-ID: <DM4PR12MB57480BC838E715FF0F1C8DD58E872@DM4PR12MB5748.namprd12.prod.outlook.com>
References: <20260918035805.1786646-1-lijo.lazar@amd.com>
In-Reply-To: <20260918035805.1786646-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-18T06:46:24.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5748:EE_|CY5PR12MB6479:EE_
x-ms-office365-filtering-correlation-id: 10c915d2-15bf-483b-36dc-08df15509195
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: tjgnsVCRpuyROlBq1ZFkEyHcSitesbbQEv1IVPkU6Y65upXqGaurOqYKiBkvGHg5qvTTikQXPEwgOhi7dhbzjCjO3O1eZ/2xRROMtzvKCXqLlZjkkovC55GyveAMl2iDpBCYoKhOBM2BueNuh+gVyFVyoRyr74zz2DvEhmtx/bZxZH+Pyd6lnaOWCEomzYq94fF945DK+hwdNwbx381VLu75sF2QzxWeQ95cHiv5iz9gGBGBSAGd1MvFyoXoPBFVxP5vjgaiBB02gfuNtw9EmyjPbDQ+f1MiIdej0iWT/gzI3rC6wp6acb9iYv4Ckqrr+TUHcHqopP0j1A73BAgCrKxPzpAlDDkmx1VY//coJOyot/KNpOqXRkZr98qT6tnUmns4uBun9gh5jyaypWuubyCPmEsiHLoD8wJ1c1KVV9Ah0FwM7SFxSdw7fBbkl47fDrU+PAyU6ZbLONi2XOlNPv74NEYMJfRCuc2ueUpu/V7X88Byttm00ghVjnzwhguFfiod54kflog3YKDlSBlVWbUopRXKnAtbnkwIk3Of++iu1fa46b9QWb5/sWffm/kWA+vXWXla3Xm4YjqyW0hfVVfrQ8Xi9TmNbMhA+gsz5ngfOdcFOoSSvYYRRMo80AYK2cN78u4qmCOEJKw6OqD+qQmjH6HQBAMkUmxtwr/y72bdZtmOJo44dJwtYnoszY17B8KbHIn6U8XDEj8nN3bZVti7MaXKRXhB6G44Injr1rs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5748.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pyYYMTKTdCXjhOsYMSQsduQVNrBnNES2UdyxcEpjteXbw/d8XByQkf5ItvYN?=
 =?us-ascii?Q?NX1/VwozC1zEAKw4cdDgmln327JWhd85ymffaofb0/Q67BQZ+zhQXuPdLE8N?=
 =?us-ascii?Q?rYafHCAwl+EbakI+QQsnPxQLOkGHBj2fQJsBkaWgqvxItbaXYssLni1LJhdd?=
 =?us-ascii?Q?9TWinwjoRu6yP5eeb9NvBSQebXtilVX69Bsz+HYC8kw/ZdnfYWCh9VTJoXBu?=
 =?us-ascii?Q?8Ow8+E8g5KhacatloM46YYGvYfOHDa1hfjSSGaQPOjI0w5YpykvnffoUzDaW?=
 =?us-ascii?Q?7ekVkWEg6C0Z9ZyEQhC5uvWT5kmZMu8+JPtstXXsK1viCi2zIshZK9E7beng?=
 =?us-ascii?Q?ImTMjoiLFOOzYtUzcHobyGmXftSs6EBhMGuwr/V03VNI0pGF+alW4731Ld+m?=
 =?us-ascii?Q?u1Z7SuvhVJQAZYw2DASZDMNiGefZ9fMlOQAIF7xjSb5lUtORyUp8y9gXdkuS?=
 =?us-ascii?Q?BcnbUqzlIvljqYM6SIiA78vMiUk15gC2kP6jsOOmwVEwqovFsq0Kq/PS3mbW?=
 =?us-ascii?Q?A0Fj8wUiShvHXP/8ThYQx9OXVh2bAF4fAx1KUcLu2sy8iQXudMrZ4nSKRXUZ?=
 =?us-ascii?Q?4xbdfzXHoXU7oIV15wYnA9BEnpaC1p8094nf2j81eRN0l234Grw6F9Waunwu?=
 =?us-ascii?Q?DZCTkKyYWnZqEsYksmEnvvQHemonTlkfDj+CqRyNDMz6jXtmsYCFv/voHXie?=
 =?us-ascii?Q?3YbnDM6Za/7dlgPZA4KObnljcWex5bcsxscNNqvOozCPuU2IXEiuI7v71OPP?=
 =?us-ascii?Q?ufxJkvVSm+eiQuY32tixS7ntBvInHD0wTxDx5ve4L1jyXvtPi/HlX5rpxjMH?=
 =?us-ascii?Q?ydXUeCkQOGDUtp3Z0dJ18WX8/FLHP5aiohzszIYEh8sp/+uaoFjmCFGl83Ab?=
 =?us-ascii?Q?JkRmBEdmaurvE+p/KnJGUUeCAGdE9KpHBA0j59L3tR9UD2JXw3pIaz1uwFuE?=
 =?us-ascii?Q?OVhMCHbXs4K68kxpWK/qtSR0y+HzzRHl9aRqkHsdRi/eCvVXAVJy9quehaC+?=
 =?us-ascii?Q?nNmiBrMtrNrWeBA92689kJ9RTIiBI3RVLdf0PjPRJlzHChjVJsyLID2X01Y4?=
 =?us-ascii?Q?CmnIGDG7FI6KOCM7vvE1E2FpQmh2n4KIis1Jthkh7rsDVbEUlqyp1ZTumsqG?=
 =?us-ascii?Q?DL0ObNWbMU/+9so+Rlm84HaDdGL57edpTZ/nuQG6M0ISLSzPspiNtA6qxQdq?=
 =?us-ascii?Q?KXyAS/hddxkLBiuHQI5HKfJZlFMG/iGomeKaqV+68HrTrhQEie5IvK/0s6is?=
 =?us-ascii?Q?veOOD7b5xwNv1rWQXzKVlLG4SQh1oZnH5CvgEVYxWBANqtblbJFh27kSMp0o?=
 =?us-ascii?Q?cW4PW+7Y5/gsAX5Ino3k816JtSa20C2c8PUtgkDltME/noS9RsSsG5x09oFF?=
 =?us-ascii?Q?lVnOtUdBwfriURnK7vwx5+gZtoBea1ufl5fdZh0UfKcINbtMwTzbilxN6NLa?=
 =?us-ascii?Q?l2+P0r9ZSbLVvqK+gt4M13tjfjvORwDjrAa1SNWnBHvdnHOrf51iH/EYGCCF?=
 =?us-ascii?Q?CyYtvKZ5jQJpUaVe5EBNWDSajAb8R1zs5W2uJbOghTXxyYo1q/3PQCsZEKVp?=
 =?us-ascii?Q?b0OiwqkT3VoH9AMlzHpcgO/ODZM+v2WnAFfO9W1hKOdT3i8xZOo4PWA8e2n3?=
 =?us-ascii?Q?1aovVyaPc0c6+0QZAA7VDio+DgYZYznMVWD7yoKKMa1m2PmpzlEEFmg2Gf9o?=
 =?us-ascii?Q?wyxaBdr2kLk4WiwRLFqgAS9bY3lNLoETczqrghF3GIlRWFPz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5748.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c915d2-15bf-483b-36dc-08df15509195
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 06:46:29.3318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RH4F8366wUv0u5RU7TclWV6+W8mXgeuC0RsMAG0hmw8lvVDBy9SFVlqEfyaNil6nWtBqaNhZIAV2ft/75BPLsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AMD General

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 18, 2026 9:28 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Create NPM sysfs files from capability

Advertise each NPM board attribute from a per-field R/W bitmap instead of p=
robing a single sensor. SMU 13.0.6/13.0.12 reports the cap only when NPM me=
trics and MaxNodePowerLimit are present.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Assisted-by: Cursor Grok 4.6
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 16 +++++++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 23 +++++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 47 +++++++++++++------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 11 +++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 +++  .../drm/amd/pm/sws=
mu/smu13/smu_v13_0_12_ppt.c | 19 ++++++++  .../drm/amd/pm/swsmu/smu13/smu_v=
13_0_6_ppt.c  |  1 +  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |  1 +
 9 files changed, 111 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 606d48115301..5e8476c4b808 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -174,6 +174,21 @@ enum amd_pp_sensors {
        AMDGPU_PP_SENSOR_UBB_POWER_LIMIT,
 };

+/*
+ * NPM sysfs capability bitmap: two bits per field, R then W.
+ * 00 =3D unsupported, 01 =3D read-only, 1x =3D writable (or RW).
+ */
+enum amdgpu_npm_cap_field {
+       AMDGPU_NPM_CAP_CUR_NODE_POWER_LIMIT,
+       AMDGPU_NPM_CAP_NODE_POWER,
+       AMDGPU_NPM_CAP_GLOBAL_PPT_RESID,
+       AMDGPU_NPM_CAP_MAX_NODE_POWER_LIMIT,
+       AMDGPU_NPM_CAP_NPM_STATUS,
+};
+
+#define AMDGPU_NPM_CAP_R(field)        BIT_ULL((field) * 2)
+#define AMDGPU_NPM_CAP_W(field)        BIT_ULL((field) * 2 + 1)
+
 enum amd_pp_task {
        AMD_PP_TASK_DISPLAY_CONFIG_CHANGE,
        AMD_PP_TASK_ENABLE_USER_STATE,
@@ -513,6 +528,7 @@ struct amd_pm_funcs {
        ssize_t (*get_gpu_metrics)(void *handle, void **table);
        ssize_t (*get_temp_metrics)(void *handle, enum smu_temp_metric_type=
 type, void *table);
        bool (*temp_metrics_is_supported)(void *handle, enum smu_temp_metri=
c_type type);
+       u64 (*get_npm_cap)(void *handle);
        ssize_t (*get_xcp_metrics)(void *handle, int xcp_id, void *table);
        ssize_t (*get_pm_metrics)(void *handle, void *pmmetrics, size_t siz=
e);
        int (*set_watermarks_for_clock_ranges)(void *handle, diff --git a/d=
rivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index c70fd6691461..df5bbdab1ea3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -2101,6 +2101,29 @@ bool amdgpu_dpm_is_temp_metrics_supported(struct amd=
gpu_device *adev,
        return support_temp_metrics;
 }

+/**
+ * amdgpu_dpm_get_npm_cap - Return NPM sysfs capability bitmap
+ * @adev: Pointer to the device.
+ *
+ * Two bits per field (R then W). Both 0 means the field is unsupported.
+ *
+ * Return: Capability bitmap, or 0 if NPM is not supported.
+ */
+u64 amdgpu_dpm_get_npm_cap(struct amdgpu_device *adev) {
+       const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
+       u64 cap =3D 0;
+
+       if (!pp_funcs || !pp_funcs->get_npm_cap)
+               return 0;
+
+       mutex_lock(&adev->pm.mutex);
+       cap =3D pp_funcs->get_npm_cap(adev->powerplay.pp_handle);
+       mutex_unlock(&adev->pm.mutex);
+
+       return cap;
+}
+
 /**
  * amdgpu_dpm_get_xcp_metrics - Retrieve metrics for a specific compute
  * partition
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index c0e677328af5..6f8252376127 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -4726,6 +4726,37 @@ static int amdgpu_od_set_init(struct amdgpu_device *=
adev)
        return ret;
 }

+static void amdgpu_pm_npm_sysfs_init(struct amdgpu_device *adev) {
+       static const struct {
+               struct device_attribute *attr;
+               unsigned int field;
+       } files[] =3D {
+               { &dev_attr_cur_node_power_limit, AMDGPU_NPM_CAP_CUR_NODE_P=
OWER_LIMIT },
+               { &dev_attr_node_power, AMDGPU_NPM_CAP_NODE_POWER },
+               { &dev_attr_global_ppt_resid, AMDGPU_NPM_CAP_GLOBAL_PPT_RES=
ID },
+               { &dev_attr_max_node_power_limit, AMDGPU_NPM_CAP_MAX_NODE_P=
OWER_LIMIT },
+               { &dev_attr_npm_status, AMDGPU_NPM_CAP_NPM_STATUS },
+       };
+       u64 cap =3D amdgpu_dpm_get_npm_cap(adev);
+       int i;
+
+       if (!cap)
+               return;
+
+       for (i =3D 0; i < ARRAY_SIZE(files); i++) {
+               unsigned int bits =3D (cap >> (files[i].field * 2)) & 0x3;
+               struct device_attribute *attr =3D files[i].attr;
+
+               if (!bits)
+                       continue;
+
+               attr->attr.mode =3D ((bits & BIT(1)) && attr->store) ? 0644=
 : 0444;
+               sysfs_add_file_to_group(&adev->dev->kobj, &attr->attr,
+                                       amdgpu_board_attr_group.name);
+       }
+}
+
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)  {
        enum amdgpu_sriov_vf_mode mode;
@@ -4797,21 +4828,7 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
                                            &amdgpu_board_attr_group);
                if (ret)
                        goto err_out1;
-               if (amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_MAX=
NODEPOWERLIMIT,
-                                                (void *)&tmp) !=3D -EOPNOT=
SUPP) {
-                       sysfs_add_file_to_group(&adev->dev->kobj,
-                                               &dev_attr_cur_node_power_li=
mit.attr,
-                                               amdgpu_board_attr_group.nam=
e);
-                       sysfs_add_file_to_group(&adev->dev->kobj, &dev_attr=
_node_power.attr,
-                                               amdgpu_board_attr_group.nam=
e);
-                       sysfs_add_file_to_group(&adev->dev->kobj, &dev_attr=
_global_ppt_resid.attr,
-                                               amdgpu_board_attr_group.nam=
e);
-                       sysfs_add_file_to_group(&adev->dev->kobj,
-                                               &dev_attr_max_node_power_li=
mit.attr,
-                                               amdgpu_board_attr_group.nam=
e);
-                       sysfs_add_file_to_group(&adev->dev->kobj, &dev_attr=
_npm_status.attr,
-                                               amdgpu_board_attr_group.nam=
e);
-               }
+               amdgpu_pm_npm_sysfs_init(adev);
                if (amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_UBB=
_POWER_LIMIT,
                                                 (void *)&tmp) !=3D -EOPNOT=
SUPP) {
                        sysfs_add_file_to_group(&adev->dev->kobj,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_dpm.h
index 8e8a052e1d53..ed1e7385243d 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -614,5 +614,6 @@ int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, ui=
nt32_t inst_mask);  bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_de=
vice *adev);  bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_devic=
e *adev,
                                          enum smu_temp_metric_type type);
+u64 amdgpu_dpm_get_npm_cap(struct amdgpu_device *adev);

 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 4290a4872f3b..0a6daff8766f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -4002,6 +4002,16 @@ static bool smu_temp_metrics_is_supported(void *hand=
le, enum smu_temp_metric_typ
        return ret;
 }

+static u64 smu_get_npm_cap(void *handle) {
+       struct smu_context *smu =3D handle;
+
+       if (!smu->pm_enabled || !smu->ppt_funcs || !smu->ppt_funcs->get_npm=
_cap)
+               return 0;
+
+       return smu->ppt_funcs->get_npm_cap(smu); }
+
 static ssize_t smu_sys_get_xcp_metrics(void *handle, int xcp_id, void *tab=
le)  {
        struct smu_context *smu =3D handle;
@@ -4076,6 +4086,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs =3D {
        .get_xcp_metrics                  =3D smu_sys_get_xcp_metrics,
        .get_temp_metrics             =3D smu_sys_get_temp_metrics,
        .temp_metrics_is_supported      =3D smu_temp_metrics_is_supported,
+       .get_npm_cap                  =3D smu_get_npm_cap,
 };

 int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,=
 diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/pm/swsmu/inc/amdgpu_smu.h
index ab43a5cd0dcd..76625cac74cb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1620,6 +1620,13 @@ struct pptable_funcs {
         */
        ssize_t (*get_xcp_metrics)(struct smu_context *smu, int xcp_id,
                                   void *table);
+       /**
+        * @get_npm_cap: Return NPM sysfs capability bitmap.
+        *
+        * Two bits per field (R then W). Both 0 means the field is
+        * unsupported.
+        */
+       u64 (*get_npm_cap)(struct smu_context *smu);
        /**
         * @ras_send_msg: Send a message with a parameter from Ras
         * &msg: Type of message.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index d8ddad531d26..0ca5973391e8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -695,6 +695,25 @@ int smu_v13_0_12_get_npm_data(struct smu_context *smu,
        return ret;
 }

+u64 smu_v13_0_12_get_npm_cap(struct smu_context *smu) {
+       struct PPTable_t *pptable =3D
+               (struct PPTable_t *)smu->smu_table.driver_pptable;
+       u64 cap =3D 0;
+
+       if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(NPM_METRICS)) ||
+           !pptable->MaxNodePowerLimit)
+               return 0;
+
+       cap |=3D AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_CUR_NODE_POWER_LIMIT);
+       cap |=3D AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_NODE_POWER);
+       cap |=3D AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_GLOBAL_PPT_RESID);
+       cap |=3D AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_MAX_NODE_POWER_LIMIT);
+       cap |=3D AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_NPM_STATUS);
+
+       return cap;
+}
+
 static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
                                             enum smu_temp_metric_type type=
, void *table)  { diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0=
_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ee380488d212..83a5a4614a4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3312,6 +3312,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_fun=
cs =3D {
        .get_gpu_metrics =3D smu_v13_0_6_get_gpu_metrics,
        .get_pm_metrics =3D smu_v13_0_6_get_pm_metrics,
        .get_xcp_metrics =3D smu_v13_0_6_get_xcp_metrics,
+       .get_npm_cap =3D smu_v13_0_12_get_npm_cap,
        .get_thermal_temperature_range =3D smu_v13_0_6_get_thermal_temperat=
ure_range,
        .mode1_reset_is_support =3D smu_v13_0_6_is_mode1_reset_supported,
        .mode1_reset =3D smu_v13_0_6_mode1_reset, diff --git a/drivers/gpu/=
drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu=
13/smu_v13_0_6_ppt.h
index 6554780afff7..1b6926625cc3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -111,6 +111,7 @@ void smu_v13_0_12_tables_fini(struct smu_context *smu);=
  int smu_v13_0_12_get_npm_data(struct smu_context *smu,
                              enum amd_pp_sensors sensor,
                              uint32_t *value);
+u64 smu_v13_0_12_get_npm_cap(struct smu_context *smu);
 int smu_v13_0_12_get_system_power(struct smu_context *smu,
                                  enum amd_pp_sensors sensor,
                                  uint32_t *value);
--
2.49.0

