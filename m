Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29190C3F2CD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 20:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C571E246AE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 20:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LHSw5/48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C571E246AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F5C6F4CF;
	Fri, 28 Feb 2020 20:59:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 245456F4CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 20:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lU7mnjtCIb5/+beV4LyPlU8Pxwq2K6uI2dnef2ImOD4reWQQGmf9dpzbkq/TqYuUguGh31Db/cso41oytCveN2QtMqODL4H7kkbPZ/CH/ycF2Un3YdE+I/vY3STq96Y0Can7WflvOQXtfTwU05SBUQBPj1vxEWJDhD0NcfaAF779k1CMuBPN2El86YvYUesFDo3sFHYTVtzYAKBDDdstB7lzXVsMSoAVHj+PjNAfg+lUMcxegar1EnBe68KBdD5c9kZspAOA0yolX8dRnRklmmff7Bn/y1SxW5CtXOU5hOT2Cz/XOc0ekMl+LddHu5kEUBXdrA6MvBqlBqdcbRa90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNJL5sy0r5Nkb6XTMlMu9X2VMZgtTW+Hub/0d4phNS4=;
 b=iZCNrrsrRKT78ZMt95B8PiOa4q8X+SMJyNIFBV9QsI5/ZYcltKnHcA+PXkscNkXvhhXsztj9vNE5K5Chqy6Z283m+2EiFbCTOHqDRfESih1bT6WXi4QaKisqWSewF4R2JFBX6nwyeDPpC4qf0hazCXrLtAKvu60zlv46o09je6L6vv330UJQhCkYfVotUkFcRDWyaWFNhSk1HpjsTPKu5P99D7kiXw1jQd3XI41WCVGxo47Tq3LqGtZF4hO1z3EJdRHqIf6P8DwG0DzCb9L5ZG44QolYDu++/kW0fsJmjBusjvA8C9a/nSUgmFscsE8FKS/Rz1utAx+HySWVCm3Qxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNJL5sy0r5Nkb6XTMlMu9X2VMZgtTW+Hub/0d4phNS4=;
 b=LHSw5/48dzr+AUC8LdFS3IosnFBvlJfFX+oG6aJ+t2J79BPSnKMDhr6wOd/zHgGJrv/6TLtiK9srs/xmC9RLB68lHEXJxGDK5/uOFFHFoqAivIr4vhu0SPodIbChVS6M6iX7JsOyb1U+96xgYqeYF2Jk1Fw7omX8xWVjQuGLk9w=
Received: from MN2PR12MB3840.namprd12.prod.outlook.com (2603:10b6:208:16f::23)
 by MN2PR12MB3981.namprd12.prod.outlook.com (2603:10b6:208:165::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Fri, 28 Feb
 2020 20:59:42 +0000
Received: from MN2PR12MB3840.namprd12.prod.outlook.com
 ([fe80::c187:b10:e9b5:73aa]) by MN2PR12MB3840.namprd12.prod.outlook.com
 ([fe80::c187:b10:e9b5:73aa%7]) with mapi id 15.20.2772.012; Fri, 28 Feb 2020
 20:59:42 +0000
From: "Wu, Hersen" <hersenxs.wu@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark clock
 settings to smu resume from s3
Thread-Topic: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark clock
 settings to smu resume from s3
Thread-Index: AQHV7YYgld4ORuMO6kCKd4l5jJ+nsKgv6tEAgAEpcQI=
Date: Fri, 28 Feb 2020 20:59:41 +0000
Message-ID: <MN2PR12MB38404E1958870D36B236B217FDE80@MN2PR12MB3840.namprd12.prod.outlook.com>
References: <20200227155349.10993-1-hersenxs.wu@amd.com>,
 <MN2PR12MB33448440496BD112CE52820BE4E80@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB33448440496BD112CE52820BE4E80@MN2PR12MB3344.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-28T20:59:41.465Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hersenxs.wu@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6851735f-c857-4ede-434e-08d7bc9121f0
x-ms-traffictypediagnostic: MN2PR12MB3981:|MN2PR12MB3981:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB39819E3D8218ACD875B74AFCFDE80@MN2PR12MB3981.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(199004)(189003)(26005)(66446008)(6506007)(53546011)(81166006)(81156014)(66476007)(8676002)(66556008)(19627405001)(52536014)(76116006)(91956017)(186003)(71200400001)(64756008)(5660300002)(66946007)(2906002)(7696005)(33656002)(4326008)(316002)(110136005)(478600001)(9686003)(8936002)(55016002)(86362001)(32563001)(357404004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3981;
 H:MN2PR12MB3840.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V47EJ843f6yg7cmMHx77pepyEgv4W2WC4sXdVadKGRjt12/8S456ZU8t/9ZSUElS2hcG66vjZgG8gtPSF+6oxkn54S/ylqluwevpTYhWWZu+tkksul6ayIMAN+LuL+rHirsx6lN/kB8MzQ7rQUNo0gwBdnb88udBNVzgYtmuSlzfVuK3x/6v5FQAnmqE9svtogVzNC28VOtRq6LwLR8MWBeZNsyN+x7VLhlOOVn4A3i4LGrkzr8a8f/MFfURaYTaYqYK6PSGQ6GaFj0ms1v6MyD7pRHIZ4qe5FXKbZyHztk7ToSZaA7GpLA6Mjpzf6z6n36P5wC+jowMo+svXUB9bHuQd1T5EfPGe5Gub7GzA+aIusCnS/hXMUIRnEmyL6UF5/VQGxJYLHp9QnxLXZnyW4sRhbcezE1AGbjCzN0SGa7msA5S99qMHuv3xG0eK2o0ZxI4OZpMMYwtmzOdZkWmKLFkwF3e4UBMMz9dqAksz+qFbzxE+iwky2m/9CVLF6xYywq9bR/26QulkLxcHL0CAA==
x-ms-exchange-antispam-messagedata: HFi5DSCHroruO8kivwvrc206k2DLTNf/UNBBt2gnhIzp6ock67qI+pKlFsmL0YavRR/rSbGfvSzgUqmqXPEqWqhLW7pUolCAqvMZ/Vdw/uCMaOVFZNg+RTsqmFXqhlWZFhdv0Qbd84ZPBtxM8Z8n7Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6851735f-c857-4ede-434e-08d7bc9121f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 20:59:41.9539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cgzq4PyUTzbMZQQvBd934QNfFRGQQXhwJpX6wpjc8iPCUfLNpHb79YSsCVczn5cTzRGBtj2hyKVo9hn7PrxveA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3981
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: multipart/mixed; boundary="===============1263587901=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1263587901==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB38404E1958870D36B236B217FDE80MN2PR12MB3840namp_"

--_000_MN2PR12MB38404E1958870D36B236B217FDE80MN2PR12MB3840namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Follow Evan's review, add smu->mutex.


This interface is for dGPU Navi1x. Linux dc-pplib interface depends
 on window driver dc implementation.

 For Navi1x, clock settings of dcn watermarks are fixed. the settings
 should be passed to smu during boot up and resume from s3.
 boot up: dc calculate dcn watermark clock settings within dc_create,
 dcn20_resource_construct, then call pplib functions below to pass
 the settings to smu:
 smu_set_watermarks_for_clock_ranges
 smu_set_watermarks_table
 navi10_set_watermarks_table
 smu_write_watermarks_table

 For Renoir, clock settings of dcn watermark are also fixed values.
 dc has implemented different flow for window driver:
 dc_hardware_init / dc_set_power_state
 dcn10_init_hw
 notify_wm_ranges
 set_wm_ranges

 For Linux
 smu_set_watermarks_for_clock_ranges
 renoir_set_watermarks_table
 smu_write_watermarks_table

 dc_hardware_init -> amdgpu_dm_init
 dc_set_power_state --> dm_resume

 therefore, linux dc-pplib interface of navi10/12/14 is different
 from that of Renoir.

Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 931cbd7b372e..1ee1d6ff2782 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1435,6 +1435,72 @@ static void s3_handle_mst(struct drm_device *dev, bo=
ol suspend)
  drm_kms_helper_hotplug_event(dev);
 }

+static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev=
)
+{
+ struct smu_context *smu =3D &adev->smu;
+ int ret =3D 0;
+
+ if (!is_support_sw_smu(adev))
+ return 0;
+
+ /* This interface is for dGPU Navi1x.Linux dc-pplib interface depends
+ * on window driver dc implementation.
+ * For Navi1x, clock settings of dcn watermarks are fixed. the settings
+ * should be passed to smu during boot up and resume from s3.
+ * boot up: dc calculate dcn watermark clock settings within dc_create,
+ * dcn20_resource_construct
+ * then call pplib functions below to pass the settings to smu:
+ * smu_set_watermarks_for_clock_ranges
+ * smu_set_watermarks_table
+ * navi10_set_watermarks_table
+ * smu_write_watermarks_table
+ *
+ * For Renoir, clock settings of dcn watermark are also fixed values.
+ * dc has implemented different flow for window driver:
+ * dc_hardware_init / dc_set_power_state
+ * dcn10_init_hw
+ * notify_wm_ranges
+ * set_wm_ranges
+ * -- Linux
+ * smu_set_watermarks_for_clock_ranges
+ * renoir_set_watermarks_table
+ * smu_write_watermarks_table
+ *
+ * For Linux,
+ * dc_hardware_init -> amdgpu_dm_init
+ * dc_set_power_state --> dm_resume
+ *
+ * therefore, this function apply to navi10/12/14 but not Renoir
+ * *
+ */
+ switch(adev->asic_type) {
+ case CHIP_NAVI10:
+ case CHIP_NAVI14:
+ case CHIP_NAVI12:
+ break;
+ default:
+ return 0;
+ }
+
+ mutex_lock(&smu->mutex);
+
+ /* pass data to smu controller */
+ if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
+ !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+ ret =3D smu_write_watermarks_table(smu);
+
+ if (ret) {
+ DRM_ERROR("Failed to update WMTABLE!\n");
+ return ret;
+ }
+ smu->watermarks_bitmap |=3D WATERMARKS_LOADED;
+ }
+
+ mutex_unlock(&smu->mutex);
+
+ return 0;
+}
+
 /**
  * dm_hw_init() - Initialize DC device
  * @handle: The base driver device containing the amdgpu_dm device.
@@ -1713,6 +1779,8 @@ static int dm_resume(void *handle)

  amdgpu_dm_irq_resume_late(adev);

+ amdgpu_dm_smu_write_watermarks_table(adev);
+
  return 0;
 }

--
2.17.1

________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: February 27, 2020 9:58 PM
To: Wu, Hersen <hersenxs.wu@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark cloc=
k settings to smu resume from s3

Thanks. But could you help to confirm whether this is correctly protected b=
y "mutex_lock(&smu->mutex)"?

-----Original Message-----
From: Hersen Wu <hersenxs.wu@amd.com>
Sent: Thursday, February 27, 2020 11:54 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; W=
u, Hersen <hersenxs.wu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark clock se=
ttings to smu resume from s3

 This interface is for dGPU Navi1x. Linux dc-pplib interface depends  on wi=
ndow driver dc implementation.

 For Navi1x, clock settings of dcn watermarks are fixed. the settings  shou=
ld be passed to smu during boot up and resume from s3.
 boot up: dc calculate dcn watermark clock settings within dc_create,  dcn2=
0_resource_construct, then call pplib functions below to pass  the settings=
 to smu:
 smu_set_watermarks_for_clock_ranges
 smu_set_watermarks_table
 navi10_set_watermarks_table
 smu_write_watermarks_table

 For Renoir, clock settings of dcn watermark are also fixed values.
 dc has implemented different flow for window driver:
 dc_hardware_init / dc_set_power_state
 dcn10_init_hw
 notify_wm_ranges
 set_wm_ranges

 For Linux
 smu_set_watermarks_for_clock_ranges
 renoir_set_watermarks_table
 smu_write_watermarks_table

 dc_hardware_init -> amdgpu_dm_init
 dc_set_power_state --> dm_resume

 therefore, linux dc-pplib interface of navi10/12/14 is different  from tha=
t of Renoir.

Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 931cbd7b372e..c58c0e95735e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1435,6 +1435,68 @@ static void s3_handle_mst(struct drm_device *dev, bo=
ol suspend)
                 drm_kms_helper_hotplug_event(dev);
 }

+static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device
+*adev) {
+       struct smu_context *smu =3D &adev->smu;
+       int ret =3D 0;
+
+       if (!is_support_sw_smu(adev))
+               return 0;
+
+       /* This interface is for dGPU Navi1x.Linux dc-pplib interface depen=
ds
+        * on window driver dc implementation.
+        * For Navi1x, clock settings of dcn watermarks are fixed. the sett=
ings
+        * should be passed to smu during boot up and resume from s3.
+        * boot up: dc calculate dcn watermark clock settings within dc_cre=
ate,
+        * dcn20_resource_construct
+        * then call pplib functions below to pass the settings to smu:
+        * smu_set_watermarks_for_clock_ranges
+        * smu_set_watermarks_table
+        * navi10_set_watermarks_table
+        * smu_write_watermarks_table
+        *
+        * For Renoir, clock settings of dcn watermark are also fixed value=
s.
+        * dc has implemented different flow for window driver:
+        * dc_hardware_init / dc_set_power_state
+        * dcn10_init_hw
+        * notify_wm_ranges
+        * set_wm_ranges
+        * -- Linux
+        * smu_set_watermarks_for_clock_ranges
+        * renoir_set_watermarks_table
+        * smu_write_watermarks_table
+        *
+        * For Linux,
+        * dc_hardware_init -> amdgpu_dm_init
+        * dc_set_power_state --> dm_resume
+        *
+        * therefore, this function apply to navi10/12/14 but not Renoir
+        * *
+        */
+       switch(adev->asic_type) {
+       case CHIP_NAVI10:
+       case CHIP_NAVI14:
+       case CHIP_NAVI12:
+               break;
+       default:
+               return 0;
+       }
+
+       /* pass data to smu controller */
+       if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
+                       !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+               ret =3D smu_write_watermarks_table(smu);
+
+               if (ret) {
+                       DRM_ERROR("Failed to update WMTABLE!\n");
+                       return ret;
+               }
+               smu->watermarks_bitmap |=3D WATERMARKS_LOADED;
+       }
+
+       return 0;
+}
+
 /**
  * dm_hw_init() - Initialize DC device
  * @handle: The base driver device containing the amdgpu_dm device.
@@ -1713,6 +1775,8 @@ static int dm_resume(void *handle)

         amdgpu_dm_irq_resume_late(adev);

+       amdgpu_dm_smu_write_watermarks_table(adev);
+
         return 0;
 }

--
2.17.1


--_000_MN2PR12MB38404E1958870D36B236B217FDE80MN2PR12MB3840namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Follow Evan's review, add smu-&gt;mutex. <br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
This interface is for dGPU Navi1x. Linux dc-pplib interface depends<br>
<div>&nbsp;on window driver dc implementation.<br>
</div>
<div><br>
</div>
<div>&nbsp;For Navi1x, clock settings of dcn watermarks are fixed. the sett=
ings<br>
</div>
<div>&nbsp;should be passed to smu during boot up and resume from s3.<br>
</div>
<div>&nbsp;boot up: dc calculate dcn watermark clock settings within dc_cre=
ate,<br>
</div>
<div>&nbsp;dcn20_resource_construct, then call pplib functions below to pas=
s<br>
</div>
<div>&nbsp;the settings to smu:<br>
</div>
<div>&nbsp;smu_set_watermarks_for_clock_ranges<br>
</div>
<div>&nbsp;smu_set_watermarks_table<br>
</div>
<div>&nbsp;navi10_set_watermarks_table<br>
</div>
<div>&nbsp;smu_write_watermarks_table<br>
</div>
<div><br>
</div>
<div>&nbsp;For Renoir, clock settings of dcn watermark are also fixed value=
s.<br>
</div>
<div>&nbsp;dc has implemented different flow for window driver:<br>
</div>
<div>&nbsp;dc_hardware_init / dc_set_power_state<br>
</div>
<div>&nbsp;dcn10_init_hw<br>
</div>
<div>&nbsp;notify_wm_ranges<br>
</div>
<div>&nbsp;set_wm_ranges<br>
</div>
<div><br>
</div>
<div>&nbsp;For Linux<br>
</div>
<div>&nbsp;smu_set_watermarks_for_clock_ranges<br>
</div>
<div>&nbsp;renoir_set_watermarks_table<br>
</div>
<div>&nbsp;smu_write_watermarks_table<br>
</div>
<div><br>
</div>
<div>&nbsp;dc_hardware_init -&gt; amdgpu_dm_init<br>
</div>
<div>&nbsp;dc_set_power_state --&gt; dm_resume<br>
</div>
<div><br>
</div>
<div>&nbsp;therefore, linux dc-pplib interface of navi10/12/14 is different=
<br>
</div>
<div>&nbsp;from that of Renoir.<br>
</div>
<div><br>
</div>
<div>Signed-off-by: Hersen Wu &lt;hersenxs.wu@amd.com&gt;<br>
</div>
<div>---<br>
</div>
<div>&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 68 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;<br>
</div>
<div>&nbsp;1 file changed, 68 insertions(&#43;)<br>
</div>
<div><br>
</div>
<div>diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
</div>
<div>index 931cbd7b372e..1ee1d6ff2782 100644<br>
</div>
<div>--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
</div>
<div>&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br=
>
</div>
<div>@@ -1435,6 &#43;1435,72 @@ static void s3_handle_mst(struct drm_device=
 *dev, bool suspend)<br>
</div>
<div>&nbsp; drm_kms_helper_hotplug_event(dev);<br>
</div>
<div>&nbsp;}<br>
</div>
<div>&nbsp;<br>
</div>
<div>&#43;static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_dev=
ice *adev)<br>
</div>
<div>&#43;{<br>
</div>
<div>&#43; struct smu_context *smu =3D &amp;adev-&gt;smu;<br>
</div>
<div>&#43; int ret =3D 0;<br>
</div>
<div>&#43;<br>
</div>
<div>&#43; if (!is_support_sw_smu(adev))<br>
</div>
<div>&#43; return 0;<br>
</div>
<div>&#43;<br>
</div>
<div>&#43; /* This interface is for dGPU Navi1x.Linux dc-pplib interface de=
pends<br>
</div>
<div>&#43; * on window driver dc implementation.<br>
</div>
<div>&#43; * For Navi1x, clock settings of dcn watermarks are fixed. the se=
ttings<br>
</div>
<div>&#43; * should be passed to smu during boot up and resume from s3.<br>
</div>
<div>&#43; * boot up: dc calculate dcn watermark clock settings within dc_c=
reate,<br>
</div>
<div>&#43; * dcn20_resource_construct<br>
</div>
<div>&#43; * then call pplib functions below to pass the settings to smu:<b=
r>
</div>
<div>&#43; * smu_set_watermarks_for_clock_ranges<br>
</div>
<div>&#43; * smu_set_watermarks_table<br>
</div>
<div>&#43; * navi10_set_watermarks_table<br>
</div>
<div>&#43; * smu_write_watermarks_table<br>
</div>
<div>&#43; *<br>
</div>
<div>&#43; * For Renoir, clock settings of dcn watermark are also fixed val=
ues.<br>
</div>
<div>&#43; * dc has implemented different flow for window driver:<br>
</div>
<div>&#43; * dc_hardware_init / dc_set_power_state<br>
</div>
<div>&#43; * dcn10_init_hw<br>
</div>
<div>&#43; * notify_wm_ranges<br>
</div>
<div>&#43; * set_wm_ranges<br>
</div>
<div>&#43; * -- Linux<br>
</div>
<div>&#43; * smu_set_watermarks_for_clock_ranges<br>
</div>
<div>&#43; * renoir_set_watermarks_table<br>
</div>
<div>&#43; * smu_write_watermarks_table<br>
</div>
<div>&#43; *<br>
</div>
<div>&#43; * For Linux,<br>
</div>
<div>&#43; * dc_hardware_init -&gt; amdgpu_dm_init<br>
</div>
<div>&#43; * dc_set_power_state --&gt; dm_resume<br>
</div>
<div>&#43; *<br>
</div>
<div>&#43; * therefore, this function apply to navi10/12/14 but not Renoir<=
br>
</div>
<div>&#43; * *<br>
</div>
<div>&#43; */<br>
</div>
<div>&#43; switch(adev-&gt;asic_type) {<br>
</div>
<div>&#43; case CHIP_NAVI10:<br>
</div>
<div>&#43; case CHIP_NAVI14:<br>
</div>
<div>&#43; case CHIP_NAVI12:<br>
</div>
<div>&#43; break;<br>
</div>
<div>&#43; default:<br>
</div>
<div>&#43; return 0;<br>
</div>
<div>&#43; }<br>
</div>
<div>&#43;<br>
</div>
<div>&#43; mutex_lock(&amp;smu-&gt;mutex);<br>
</div>
<div>&#43;<br>
</div>
<div>&#43; /* pass data to smu controller */<br>
</div>
<div>&#43; if ((smu-&gt;watermarks_bitmap &amp; WATERMARKS_EXIST) &amp;&amp=
;<br>
</div>
<div>&#43; !(smu-&gt;watermarks_bitmap &amp; WATERMARKS_LOADED)) {<br>
</div>
<div>&#43; ret =3D smu_write_watermarks_table(smu);<br>
</div>
<div>&#43;<br>
</div>
<div>&#43; if (ret) {<br>
</div>
<div>&#43; DRM_ERROR(&quot;Failed to update WMTABLE!\n&quot;);<br>
</div>
<div>&#43; return ret;<br>
</div>
<div>&#43; }<br>
</div>
<div>&#43; smu-&gt;watermarks_bitmap |=3D WATERMARKS_LOADED;<br>
</div>
<div>&#43; }<br>
</div>
<div>&#43;<br>
</div>
<div>&#43; mutex_unlock(&amp;smu-&gt;mutex);<br>
</div>
<div>&#43;<br>
</div>
<div>&#43; return 0;<br>
</div>
<div>&#43;}<br>
</div>
<div>&#43;<br>
</div>
<div>&nbsp;/**<br>
</div>
<div>&nbsp; * dm_hw_init() - Initialize DC device<br>
</div>
<div>&nbsp; * @handle: The base driver device containing the amdgpu_dm devi=
ce.<br>
</div>
<div>@@ -1713,6 &#43;1779,8 @@ static int dm_resume(void *handle)<br>
</div>
<div>&nbsp;<br>
</div>
<div>&nbsp; amdgpu_dm_irq_resume_late(adev);<br>
</div>
<div>&nbsp;<br>
</div>
<div>&#43; amdgpu_dm_smu_write_watermarks_table(adev);<br>
</div>
<div>&#43;<br>
</div>
<div>&nbsp; return 0;<br>
</div>
<div>&nbsp;}<br>
</div>
<div>&nbsp;<br>
</div>
<div>-- <br>
</div>
<div>2.17.1<br>
</div>
<span></span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> February 27, 2020 9:58 PM<br>
<b>To:</b> Wu, Hersen &lt;hersenxs.wu@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Wu, Hersen &lt;herse=
nxs.wu@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn waterma=
rk clock settings to smu resume from s3</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Thanks. But could you help to confirm whether this=
 is correctly protected by &quot;mutex_lock(&amp;smu-&gt;mutex)&quot;?<br>
<br>
-----Original Message-----<br>
From: Hersen Wu &lt;hersenxs.wu@amd.com&gt; <br>
Sent: Thursday, February 27, 2020 11:54 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Quan, Evan &lt;Evan.Quan@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@am=
d.com&gt;; Wu, Hersen &lt;hersenxs.wu@amd.com&gt;<br>
Subject: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark clock se=
ttings to smu resume from s3<br>
<br>
&nbsp;This interface is for dGPU Navi1x. Linux dc-pplib interface depends&n=
bsp; on window driver dc implementation.<br>
<br>
&nbsp;For Navi1x, clock settings of dcn watermarks are fixed. the settings&=
nbsp; should be passed to smu during boot up and resume from s3.<br>
&nbsp;boot up: dc calculate dcn watermark clock settings within dc_create,&=
nbsp; dcn20_resource_construct, then call pplib functions below to pass&nbs=
p; the settings to smu:<br>
&nbsp;smu_set_watermarks_for_clock_ranges<br>
&nbsp;smu_set_watermarks_table<br>
&nbsp;navi10_set_watermarks_table<br>
&nbsp;smu_write_watermarks_table<br>
<br>
&nbsp;For Renoir, clock settings of dcn watermark are also fixed values.<br=
>
&nbsp;dc has implemented different flow for window driver:<br>
&nbsp;dc_hardware_init / dc_set_power_state<br>
&nbsp;dcn10_init_hw<br>
&nbsp;notify_wm_ranges<br>
&nbsp;set_wm_ranges<br>
<br>
&nbsp;For Linux<br>
&nbsp;smu_set_watermarks_for_clock_ranges<br>
&nbsp;renoir_set_watermarks_table<br>
&nbsp;smu_write_watermarks_table<br>
<br>
&nbsp;dc_hardware_init -&gt; amdgpu_dm_init<br>
&nbsp;dc_set_power_state --&gt; dm_resume<br>
<br>
&nbsp;therefore, linux dc-pplib interface of navi10/12/14 is different&nbsp=
; from that of Renoir.<br>
<br>
Signed-off-by: Hersen Wu &lt;hersenxs.wu@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 64 &#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;<br>
&nbsp;1 file changed, 64 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 931cbd7b372e..c58c0e95735e 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -1435,6 &#43;1435,68 @@ static void s3_handle_mst(struct drm_device *dev=
, bool suspend)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_kms_helper_hotplug_event(dev);<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device <=
br>
&#43;*adev) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D &amp;=
adev-&gt;smu;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!is_support_sw_smu(adev))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This interface is for dGPU Nav=
i1x.Linux dc-pplib interface depends<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * on window driver dc imple=
mentation.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For Navi1x, clock setting=
s of dcn watermarks are fixed. the settings<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * should be passed to smu d=
uring boot up and resume from s3.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * boot up: dc calculate dcn=
 watermark clock settings within dc_create,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * dcn20_resource_construct<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * then call pplib functions=
 below to pass the settings to smu:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * smu_set_watermarks_for_cl=
ock_ranges<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * smu_set_watermarks_table<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * navi10_set_watermarks_tab=
le<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * smu_write_watermarks_tabl=
e<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For Renoir, clock setting=
s of dcn watermark are also fixed values.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * dc has implemented differ=
ent flow for window driver:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * dc_hardware_init / dc_set=
_power_state<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * dcn10_init_hw<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * notify_wm_ranges<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * set_wm_ranges<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * -- Linux<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * smu_set_watermarks_for_cl=
ock_ranges<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * renoir_set_watermarks_tab=
le<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * smu_write_watermarks_tabl=
e<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For Linux,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * dc_hardware_init -&gt; am=
dgpu_dm_init<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * dc_set_power_state --&gt;=
 dm_resume<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * therefore, this function =
apply to navi10/12/14 but not Renoir<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch(adev-&gt;asic_type) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* pass data to smu controller */=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((smu-&gt;watermarks_bitmap &a=
mp; WATERMARKS_EXIST) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(smu-&gt;wa=
termarks_bitmap &amp; WATERMARKS_LOADED)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_write_watermarks_table(smu);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&q=
uot;Failed to update WMTABLE!\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu-&gt;watermarks_bitmap |=3D WATERMARKS_LOADED;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&nbsp;/**<br>
&nbsp; * dm_hw_init() - Initialize DC device<br>
&nbsp; * @handle: The base driver device containing the amdgpu_dm device.<b=
r>
@@ -1713,6 &#43;1775,8 @@ static int dm_resume(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_irq_resume_late(=
adev);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_smu_write_watermarks_ta=
ble(adev);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
--<br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB38404E1958870D36B236B217FDE80MN2PR12MB3840namp_--

--===============1263587901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1263587901==--
