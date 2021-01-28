Return-Path: <SRS0=NjTA=G7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C64FC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 07:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D8A64DD1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 07:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D8A64DD1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 533D36E8F1;
	Thu, 28 Jan 2021 07:44:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 436D46E8F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jan 2021 07:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCkPU7ZnETt4vDXFeMNjdR0qvCw6uspxl4oK3yj41/Xkc/MU+AGL0TBo7wZUc0vZ2nGA3XoGUpSEW5lR6zkDkVtR2o3rpWgmqi1wtUwuXCdVZ954q5XgrtuGf8QbHK3oJ69YC0XJjKHV7zYV4jip3siub9kNxEsuMjtmEeTyOfuq2teVTnjofxlZkO0RIkKrHI6UIbEqE1aF8hEieh+s9QJEQnvJ3KfGRbYJEe9OcSA+JRTbq91SF2BDVR6e4gNuegyThpi8lYAJR60NkUn+R2WmYGlprHmLomCdsfo5X3vZ3EgLHDsQwP3q+j6E2Ao5tJ+nNU7QCsnC/wyOTmuTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCdeWqV1uFXm+9St9yqjOHb6fi9Qm57rqKBGuKWSmMI=;
 b=gnawOo4YE00OaktoyMuA2tWAtBzqJfDcdV5lwgVz2Hs0pxP7mMY9YUeewdKGOlhrO3FBGF9efXy0ZFCH8NS8J6UxjgbvFBbTPEEoIqCl6RmhL1i28Geh6b4qUJ21hj3CedPuNg1OUwyL9+NIZIHUxb7RuOmBbyUP6F2ejaafpCimmXEDGIWFRsC+QiWnlf8FRWnkreahV0svc9iiOhlEhz2Et2Lu7p31fW4UFcIkTuEaCv+h+tCguLQX8XQX6PuOhyB1Mah0TwL5wI6GbpqyNWq7hKM92wJSQRMLiOsq7drtdZIBCiJGVqD5wy6WvCH7/YZUSIUMgjUmHkJxkPo+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCdeWqV1uFXm+9St9yqjOHb6fi9Qm57rqKBGuKWSmMI=;
 b=sGP6h5b83Ev1Yz+6xlFjwYMax/aybZ1Tfcu9koSMPkGW8JyJZqga43E5qwFRv1zi95HAciXEbLfhgo8PtqdhqpfgcuTUGlNniw8XfEIhnPmV2Nxs32Tq1mVLYUHDeAUZj1rBN6a8gmmJACi4p2UHInYAGQ7eLpcSlTg4EhA0EZQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1644.namprd12.prod.outlook.com (2603:10b6:4:f::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.14; Thu, 28 Jan 2021 07:44:12 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3805.017; Thu, 28 Jan 2021
 07:44:12 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/swsmu: use percent rather than rpm for manual
 fan control
Thread-Topic: [PATCH] drm/amdgpu/swsmu: use percent rather than rpm for manual
 fan control
Thread-Index: AQHW9P2IJVVpIo9Ksk+hp+nQ9sh7p6o8qAIQ
Date: Thu, 28 Jan 2021 07:44:12 +0000
Message-ID: <DM6PR12MB2619FDDDD740C0CE1D25EFFBE4BA9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210127224052.3957-1-alexander.deucher@amd.com>
In-Reply-To: <20210127224052.3957-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4d68b792-7840-4029-9b3b-7c9bdfff3eb1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-28T07:41:31Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44798bfb-d5f5-4b1a-6b07-08d8c3608115
x-ms-traffictypediagnostic: DM5PR12MB1644:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB164449647DD4B36B6E76C448E4BA9@DM5PR12MB1644.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ar/mtFnOtV+CpO36cC2JW2Uhq+6HlB+fcSWyOU+Vzds1YqJKX1oC2TXIQhgh6P9CUFmLvOjc3T4ute7fOF5xuo4Ttno+l2NKbVOyvebEVdZQnoJpuVi697y0+/ItYMmqBdbQSj1aZMtrOsnFxtwNGqkC6FtxPsqOo9pqg0zgQCti/abh2xUix78ZKxSbScRMLmz/SZvsVxIfDVU1a0xXGj5jZf8AgFJv19m9sjWiyaqEbHZKK85cFj/JND+bcAp5Fiwwqr2bFJ1ldEW5zfIKlo+id4eEj8qyUIdf+FLs2fFyREW0Trk1Ij5t7J1xKWjt4U6t6CSBh9i8Vl1SbPspinEcPCzd2Nvs9S6SW3pTSsnuI2S1BeSB02ukdE8bXASWyNRb50ulRXX3FkJZw5atqfa6nIuEG4av0QiU7lhpF/kGvA5RFv6nNtlQZkP2MyNGGXzJi/XEDIf8mqCxL+ZmZ2Qu+ilkUz09PvOZKkqVH5RFyxT28uAbKhCAQyAqz6pIIc6bGJnOTlwrJ54NzHJQv3bDZrxoeP4XxZjWAUAPZKbuThaHi4VreDNK5J4ZG+qv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(26005)(45080400002)(6506007)(30864003)(53546011)(8676002)(52536014)(316002)(5660300002)(2906002)(76116006)(71200400001)(7696005)(66946007)(83380400001)(966005)(66476007)(478600001)(86362001)(110136005)(66446008)(66556008)(9686003)(8936002)(33656002)(55016002)(4326008)(64756008)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3RF9S4ujC0tgI/4aS+hvRkOtZBX+veeq+bcfaDUCgoQa8IE07Iez9m2Zjdnu?=
 =?us-ascii?Q?s/6OwrVEkK++vQ70CjCgGVZJf7mzWyIXfu+FMUy/UV09kRFtSoLrmd/dEyig?=
 =?us-ascii?Q?vEUcmghwVpa2HWeaXtVpu9xhe474/ToS3eJvkMn4AKua+35ioeIGTRgXCi5D?=
 =?us-ascii?Q?jx+zzHCR0BrJjKcs5i9fO6r1DBxi7DP1vx0QBf27iXs6UCfa/8PPDnI6Yt45?=
 =?us-ascii?Q?oiqQP/orTh5Z3EHcX8yT6sZP7RT5npqQIdlVdbCSYAWLS44+XUyrLAD6JC+0?=
 =?us-ascii?Q?2Qbwnam8iYu/OT++qpru1hArF9/cfnKaUayQ/eGowXF1AOFgX81gW+ufLP4q?=
 =?us-ascii?Q?uANzFXKXJ7hIlushqVlVJcZA/Yixj7a4ko/N4vBqJ4hrMOPl4cwZpFvezEt6?=
 =?us-ascii?Q?XnayngbO0Ndf0dgY4wH9Ibt3sMSl28m1D7pf7h+aL0h3kd82IQN4ZaAuF/7O?=
 =?us-ascii?Q?93iG2X0p6dqLXkfTi9fdCz7LIKXTTGwDFS/H/VCSLOIsBk8nUlUeTaIHVFs+?=
 =?us-ascii?Q?KlxnRtndCGnto20UySivwsqCV5gs01XyHfmBB6YizgtW3kgZV/L+BRxGTiYf?=
 =?us-ascii?Q?qRo4Ib6a+iWW21EKowu0+IfyK16rAnwv9mO01olH+HmPinSl9MvXUJx+yoAA?=
 =?us-ascii?Q?10qlQOrO/eVgvL9nCMokU2vpK4emOiyNcDNF8YOwRqiioxZl/xgvm0ntyhcB?=
 =?us-ascii?Q?3QFPydJfpLZGCdj0RJPwkTSdY8k+8NVz5XRNtII27vXGdOpLEYlm0l3iiZQS?=
 =?us-ascii?Q?FlRzOW/DRmV5rnvqp9mWilDpwQr3+q5B0e7FMVaVT1AWuBgP9vXwDfAzYPA0?=
 =?us-ascii?Q?0K58iwZcnEzsNo8qsiz/jhkjQEbOob56TdMkqW1cX9E92CxTU7pn0x7pCdoR?=
 =?us-ascii?Q?jzOwtqAgoABVga9CEtbgg5gGu3+o6GDQmU/+zsqAG/u1VRVdsvJKEC3J1sDG?=
 =?us-ascii?Q?oeWZc5L5SdJQrKwcx7cQmEjc2Y2y0ePlYCnZSWO15TuGhAVkjK/APCX85Lrr?=
 =?us-ascii?Q?SdLjwR7RyGIuYBxHsE6RPJZazm+wpKwzS/9GG+Y/0BqFuWgaa+nSyFUoQe0l?=
 =?us-ascii?Q?uSQLp51S?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44798bfb-d5f5-4b1a-6b07-08d8c3608115
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 07:44:12.2166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +iH4M0zMeRMa/OxCN3xHuer/Q3hdQzFJld8fJauyi8jmqcEVBCcGYOmpF0I9sx0T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1644
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

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, January 28, 2021 6:41 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/swsmu: use percent rather than rpm for manual fan control

On some boards the rpm interface apparently does not work at all
leading to the fan not spinning or spinning at strange speeds.
Both interfaces work properly on the boards I have.
Let's try and use the percent interface instead.

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1408&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cc6a08573394046ec138808d8c314a9e7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473840813816002%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=bBwGsp2cAmmcsIgUXvecB6ziXRwgkxJzQu9IIbgR%2Fo0%3D&amp;reserved=0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       | 12 +--
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  7 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 35 ++++----
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 26 ++++--
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 26 ++++--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 26 ++++--
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 89 +++++++------------
 7 files changed, 117 insertions(+), 104 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 631a36a75ae3..44279c2afccb 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -173,7 +173,7 @@ enum smu_memory_pool_size
 struct smu_user_dpm_profile {
 uint32_t fan_mode;
 uint32_t power_limit;
-uint32_t fan_speed_rpm;
+uint32_t fan_speed_percent;
 uint32_t flags;

 /* user clock state information */
@@ -472,7 +472,7 @@ struct smu_context
 struct work_struct interrupt_work;

 unsigned fan_max_rpm;
-unsigned manual_fan_speed_rpm;
+unsigned manual_fan_speed_percent;

 uint32_t gfx_default_hard_min_freq;
 uint32_t gfx_default_soft_max_freq;
@@ -648,9 +648,9 @@ struct pptable_funcs {
 bool (*is_dpm_running)(struct smu_context *smu);

 /**
- * @get_fan_speed_rpm: Get the current fan speed in RPM.
+ * @get_fan_speed_percent: Get the current fan speed in percent.
  */
-int (*get_fan_speed_rpm)(struct smu_context *smu, uint32_t *speed);
+int (*get_fan_speed_percent)(struct smu_context *smu, uint32_t *speed);

 /**
  * @set_watermarks_table: Configure and upload the watermarks tables to
@@ -951,9 +951,9 @@ struct pptable_funcs {
 int (*set_fan_control_mode)(struct smu_context *smu, uint32_t mode);

 /**
- * @set_fan_speed_rpm: Set a static fan speed in RPM.
+ * @set_fan_speed_percent: Set a static fan speed in percent.
  */
-int (*set_fan_speed_rpm)(struct smu_context *smu, uint32_t speed);
+int (*set_fan_speed_percent)(struct smu_context *smu, uint32_t speed);

 /**
  * @set_xgmi_pstate: Set inter-chip global memory interconnect pstate.
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 102a0cf12d7a..c7d57e9555cc 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -203,11 +203,8 @@ int
 smu_v11_0_set_fan_control_mode(struct smu_context *smu,
        uint32_t mode);

-int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
-       uint32_t speed);
-
-int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
-uint32_t *speed);
+int smu_v11_0_set_fan_speed_percent(struct smu_context *smu,
+    uint32_t speed);

 int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
      uint32_t pstate);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f958b02f9317..1c7ac81fe417 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -368,8 +368,8 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 return;
 }

-if (!ret && smu->user_dpm_profile.fan_speed_rpm) {
-ret = smu_set_fan_speed_rpm(smu, smu->user_dpm_profile.fan_speed_rpm);
+if (!ret && smu->user_dpm_profile.fan_speed_percent) {
+ret = smu_set_fan_speed_percent(smu, smu->user_dpm_profile.fan_speed_percent);
 if (ret)
 dev_err(smu->adev->dev, "Failed to set manual fan speed\n");
 }
@@ -2025,6 +2025,7 @@ int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)

 int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed)
 {
+u32 percent;
 int ret = 0;

 if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2032,10 +2033,11 @@ int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed)

 mutex_lock(&smu->mutex);

-if (smu->ppt_funcs->set_fan_speed_rpm) {
-ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
+if (smu->ppt_funcs->set_fan_speed_percent) {
+percent = speed * 100 / smu->fan_max_rpm;
+ret = smu->ppt_funcs->set_fan_speed_percent(smu, percent);
 if (!ret && smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
-smu->user_dpm_profile.fan_speed_rpm = speed;
+smu->user_dpm_profile.fan_speed_percent = percent;
 }

 mutex_unlock(&smu->mutex);
@@ -2270,7 +2272,7 @@ int smu_set_fan_control_mode(struct smu_context *smu, int value)
 /* reset user dpm fan speed */
 if (!ret && value != AMD_FAN_CTRL_MANUAL &&
 smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
-smu->user_dpm_profile.fan_speed_rpm = 0;
+smu->user_dpm_profile.fan_speed_percent = 0;

 return ret;
 }
@@ -2279,17 +2281,15 @@ int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed)
 {
 int ret = 0;
 uint32_t percent;
-uint32_t current_rpm;

 if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 return -EOPNOTSUPP;

 mutex_lock(&smu->mutex);

-if (smu->ppt_funcs->get_fan_speed_rpm) {
-ret = smu->ppt_funcs->get_fan_speed_rpm(smu, &current_rpm);
+if (smu->ppt_funcs->get_fan_speed_percent) {
+ret = smu->ppt_funcs->get_fan_speed_percent(smu, &percent);
 if (!ret) {
-percent = current_rpm * 100 / smu->fan_max_rpm;
 *speed = percent > 100 ? 100 : percent;
 }
 }
@@ -2303,18 +2303,18 @@ int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed)
 int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 {
 int ret = 0;
-uint32_t rpm;

 if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 return -EOPNOTSUPP;

 mutex_lock(&smu->mutex);

-if (smu->ppt_funcs->set_fan_speed_rpm) {
+if (smu->ppt_funcs->set_fan_speed_percent) {
 if (speed > 100)
 speed = 100;
-rpm = speed * smu->fan_max_rpm / 100;
-ret = smu->ppt_funcs->set_fan_speed_rpm(smu, rpm);
+ret = smu->ppt_funcs->set_fan_speed_percent(smu, speed);
+if (!ret && smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
+smu->user_dpm_profile.fan_speed_percent = speed;
 }

 mutex_unlock(&smu->mutex);
@@ -2325,14 +2325,17 @@ int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed)
 {
 int ret = 0;
+u32 percent;

 if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 return -EOPNOTSUPP;

 mutex_lock(&smu->mutex);

-if (smu->ppt_funcs->get_fan_speed_rpm)
-ret = smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
+if (smu->ppt_funcs->get_fan_speed_percent) {
+ret = smu->ppt_funcs->get_fan_speed_percent(smu, &percent);
+*speed = percent * smu->fan_max_rpm / 100;
+}

 mutex_unlock(&smu->mutex);

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index cd7b411457ff..f0cc4de9ced5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1080,15 +1080,27 @@ static int arcturus_read_sensor(struct smu_context *smu,
 return ret;
 }

-static int arcturus_get_fan_speed_rpm(struct smu_context *smu,
-      uint32_t *speed)
+static int arcturus_get_fan_speed_percent(struct smu_context *smu,
+  uint32_t *speed)
 {
+int ret;
+u32 rpm;
+
 if (!speed)
 return -EINVAL;

-return arcturus_get_smu_metrics_data(smu,
-     METRICS_CURR_FANSPEED,
-     speed);
+switch (smu_v11_0_get_fan_control_mode(smu)) {
+case AMD_FAN_CTRL_AUTO:
+ret = arcturus_get_smu_metrics_data(smu,
+    METRICS_CURR_FANSPEED,
+    &rpm);
+if (!ret && smu->fan_max_rpm)
+*speed = rpm * 100 / smu->fan_max_rpm;
+return ret;
+default:
+*speed = smu->user_dpm_profile.fan_speed_percent;
+return 0;
+}
 }

 static int arcturus_get_fan_parameters(struct smu_context *smu)
@@ -2281,7 +2293,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 .print_clk_levels = arcturus_print_clk_levels,
 .force_clk_levels = arcturus_force_clk_levels,
 .read_sensor = arcturus_read_sensor,
-.get_fan_speed_rpm = arcturus_get_fan_speed_rpm,
+.get_fan_speed_percent = arcturus_get_fan_speed_percent,
 .get_power_profile_mode = arcturus_get_power_profile_mode,
 .set_power_profile_mode = arcturus_set_power_profile_mode,
 .set_performance_level = arcturus_set_performance_level,
@@ -2326,7 +2338,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 .display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 .get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 .set_fan_control_mode = smu_v11_0_set_fan_control_mode,
-.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
+.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
 .set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 .gfx_off_control = smu_v11_0_gfx_off_control,
 .register_irq_handler = smu_v11_0_register_irq_handler,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 7ebf9588983f..f7f78daffd27 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1317,15 +1317,27 @@ static bool navi10_is_dpm_running(struct smu_context *smu)
 return !!(feature_enabled & SMC_DPM_FEATURE);
 }

-static int navi10_get_fan_speed_rpm(struct smu_context *smu,
-    uint32_t *speed)
+static int navi10_get_fan_speed_percent(struct smu_context *smu,
+uint32_t *speed)
 {
+int ret;
+u32 rpm;
+
 if (!speed)
 return -EINVAL;

-return navi10_get_smu_metrics_data(smu,
-   METRICS_CURR_FANSPEED,
-   speed);
+switch (smu_v11_0_get_fan_control_mode(smu)) {
+case AMD_FAN_CTRL_AUTO:
+ret = navi10_get_smu_metrics_data(smu,
+  METRICS_CURR_FANSPEED,
+  &rpm);
+if (!ret && smu->fan_max_rpm)
+*speed = rpm * 100 / smu->fan_max_rpm;
+return ret;
+default:
+*speed = smu->user_dpm_profile.fan_speed_percent;
+return 0;
+}
 }

 static int navi10_get_fan_parameters(struct smu_context *smu)
@@ -2413,7 +2425,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 .display_config_changed = navi10_display_config_changed,
 .notify_smc_display_config = navi10_notify_smc_display_config,
 .is_dpm_running = navi10_is_dpm_running,
-.get_fan_speed_rpm = navi10_get_fan_speed_rpm,
+.get_fan_speed_percent = navi10_get_fan_speed_percent,
 .get_power_profile_mode = navi10_get_power_profile_mode,
 .set_power_profile_mode = navi10_set_power_profile_mode,
 .set_watermarks_table = navi10_set_watermarks_table,
@@ -2456,7 +2468,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 .display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 .get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 .set_fan_control_mode = smu_v11_0_set_fan_control_mode,
-.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
+.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
 .set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 .gfx_off_control = smu_v11_0_gfx_off_control,
 .register_irq_handler = smu_v11_0_register_irq_handler,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 24f3c96a5e5e..e3ba40d9f83f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1237,15 +1237,27 @@ static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)
 return !!(feature_enabled & SMC_DPM_FEATURE);
 }

-static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
-    uint32_t *speed)
+static int sienna_cichlid_get_fan_speed_percent(struct smu_context *smu,
+uint32_t *speed)
 {
+int ret;
+u32 rpm;
+
 if (!speed)
 return -EINVAL;

-return sienna_cichlid_get_smu_metrics_data(smu,
-METRICS_CURR_FANSPEED,
-speed);
+switch (smu_v11_0_get_fan_control_mode(smu)) {
+case AMD_FAN_CTRL_AUTO:
+ret = sienna_cichlid_get_smu_metrics_data(smu,
+  METRICS_CURR_FANSPEED,
+  &rpm);
+if (!ret && smu->fan_max_rpm)
+*speed = rpm * 100 / smu->fan_max_rpm;
+return ret;
+default:
+*speed = smu->user_dpm_profile.fan_speed_percent;
+return 0;
+}
 }

 static int sienna_cichlid_get_fan_parameters(struct smu_context *smu)
@@ -3087,7 +3099,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 .display_config_changed = sienna_cichlid_display_config_changed,
 .notify_smc_display_config = sienna_cichlid_notify_smc_display_config,
 .is_dpm_running = sienna_cichlid_is_dpm_running,
-.get_fan_speed_rpm = sienna_cichlid_get_fan_speed_rpm,
+.get_fan_speed_percent = sienna_cichlid_get_fan_speed_percent,
 .get_power_profile_mode = sienna_cichlid_get_power_profile_mode,
 .set_power_profile_mode = sienna_cichlid_set_power_profile_mode,
 .set_watermarks_table = sienna_cichlid_set_watermarks_table,
@@ -3130,7 +3142,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 .display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 .get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 .set_fan_control_mode = smu_v11_0_set_fan_control_mode,
-.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
+.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
 .set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 .gfx_off_control = smu_v11_0_gfx_off_control,
 .register_irq_handler = smu_v11_0_register_irq_handler,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 147efe12973c..cf6176afd4d5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1137,10 +1137,10 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
 uint32_t
 smu_v11_0_get_fan_control_mode(struct smu_context *smu)
 {
-if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT))
-return AMD_FAN_CTRL_MANUAL;
-else
+if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT))
 return AMD_FAN_CTRL_AUTO;
+else
+return smu->user_dpm_profile.fan_mode;
 }

 static int
@@ -1174,6 +1174,35 @@ smu_v11_0_set_fan_static_mode(struct smu_context *smu, uint32_t mode)
 return 0;
 }

+int
+smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
+{
+struct amdgpu_device *adev = smu->adev;
+uint32_t duty100, duty;
+uint64_t tmp64;
+
+if (speed > 100)
+speed = 100;
+
+if (smu_v11_0_auto_fan_control(smu, 0))
+return -EINVAL;
+
+duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
+CG_FDO_CTRL1, FMAX_DUTY100);
+if (!duty100)
+return -EINVAL;
+
+tmp64 = (uint64_t)speed * duty100;
+do_div(tmp64, 100);
+duty = (uint32_t)tmp64;
+
+WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
+     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL0),
+   CG_FDO_CTRL0, FDO_STATIC_DUTY, duty));
+
+return smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC);
+}
+
 int
 smu_v11_0_set_fan_control_mode(struct smu_context *smu,
        uint32_t mode)
@@ -1182,7 +1211,7 @@ smu_v11_0_set_fan_control_mode(struct smu_context *smu,

 switch (mode) {
 case AMD_FAN_CTRL_NONE:
-ret = smu_v11_0_set_fan_speed_rpm(smu, smu->fan_max_rpm);
+ret = smu_v11_0_set_fan_speed_percent(smu, 100);
 break;
 case AMD_FAN_CTRL_MANUAL:
 ret = smu_v11_0_auto_fan_control(smu, 0);
@@ -1202,58 +1231,6 @@ smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 return ret;
 }

-int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
-       uint32_t speed)
-{
-struct amdgpu_device *adev = smu->adev;
-int ret;
-uint32_t tach_period, crystal_clock_freq;
-
-if (!speed)
-return -EINVAL;
-
-ret = smu_v11_0_auto_fan_control(smu, 0);
-if (ret)
-return ret;
-
-/*
- * crystal_clock_freq div by 4 is required since the fan control
- * module refers to 25MHz
- */
-
-crystal_clock_freq = amdgpu_asic_get_xclk(adev) / 4;
-tach_period = 60 * crystal_clock_freq * 10000 / (8 * speed);
-WREG32_SOC15(THM, 0, mmCG_TACH_CTRL,
-     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL),
-   CG_TACH_CTRL, TARGET_PERIOD,
-   tach_period));
-
-ret = smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC_RPM);
-
-return ret;
-}
-
-int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
-uint32_t *speed)
-{
-struct amdgpu_device *adev = smu->adev;
-uint32_t tach_period, crystal_clock_freq;
-uint64_t tmp64;
-
-tach_period = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL),
-    CG_TACH_CTRL, TARGET_PERIOD);
-if (!tach_period)
-return -EINVAL;
-
-crystal_clock_freq = amdgpu_asic_get_xclk(adev);
-
-tmp64 = (uint64_t)crystal_clock_freq * 60 * 10000;
-do_div(tmp64, (tach_period * 8));
-*speed = (uint32_t)tmp64;
-
-return 0;
-}
-
 int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
      uint32_t pstate)
 {
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cc6a08573394046ec138808d8c314a9e7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473840813825998%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=wsnrRkmMa9fFtC%2F4NkOG6jAczgnvZDOPv6fmEcSacqc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
