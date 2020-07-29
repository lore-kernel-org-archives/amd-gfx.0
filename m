Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB46BC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4432070B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zaukIy54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4432070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49CBA6E430;
	Wed, 29 Jul 2020 02:26:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB58F6E430
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 02:26:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwLoOu3IBBvIlZq7q1X5lwJxK2a6EMSd8kD5xYyKGeQ2myloHJxUFTfXZ0eOnwAfT7BbsA/5xay1Z5yyeWS+w74UdwFnbHaP7JvuG1TVYG/jl6LkM2S2HV/I9oKp4voou20GGbJNtsJBiXs/rkctk4vHFUuKQNkU9pQp1rR2J07LwsodMZh5C2EJoh4GDlfo4tmfvAjIp1iw0kyo8TGKIxegkul5MG7Hu/zzf9tzwJ3g3P1VTqfGuYEsSOa/Z4QbTU1P6/2VbYW9HVv8D/YuQmlxebl6WRV5gLCm6Gj5/aB/oZMnMzq822fLfOx5B37ymukYmmo39fNahdwIQZo+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uopyVHEWKRirJJpinzpQ1i3QS7MZVH+1Tbw0937O2/8=;
 b=ZptZs+TwopZ9yi6syUCRMdLAieP2s7LH3MleIsCa0Oig4FMaXICk7RdETUOc8tYfWJBlqrJ9VI+caft8mirP/ogoL8H1X1EnoEBZ3tfrpUWF91uoDba65aoAdgp0WnQtAXBSmYybl9nQjSqqgxomBdKrLt/LeeiZmtwNhstxBQB1p5JIfUnsxOw6xnFOheJhIOp8LQYvmVmoqzB3jORdErYRYQ/ZNmyZ/5SyuowHlecko3qD69LiSfaLrEmq64ULW6Sr2tkoII5ePN2KJV0FBgPVirQurJNN3IMVqYXv60/6qr6Z+xonaIfbdfdsGfnZPHrB4BbPDg8hFRwx1fS16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uopyVHEWKRirJJpinzpQ1i3QS7MZVH+1Tbw0937O2/8=;
 b=zaukIy542yFRRq7Itwoey5lnlC22V8iBJ1ZYkRb4dZYILYHYfnltDFv0KKOcJU/0i9Y/UWzeZKHkA1QpwCUQFUNPAC7eoBHpKCd2Uqmtpx8ywkR5/Txx4xagTlRetteuzjE+CcX9cZ5I1NhSUk7sk8qZNQsLqSGL0ZGywR9drCg=
Received: from BY5PR12MB3777.namprd12.prod.outlook.com (2603:10b6:a03:1a9::14)
 by BYAPR12MB3240.namprd12.prod.outlook.com (2603:10b6:a03:136::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.28; Wed, 29 Jul
 2020 02:26:25 +0000
Received: from BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::391f:5cf2:69c7:9962]) by BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::391f:5cf2:69c7:9962%7]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 02:26:25 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: reconfigure spm golden settings on Navi1x
 after GFXOFF exit(v2)
Thread-Topic: [PATCH] drm/amdgpu: reconfigure spm golden settings on Navi1x
 after GFXOFF exit(v2)
Thread-Index: AQHWZK1YnwW1EpkXyU+8coijLQA6HKkdCggAgADHYCs=
Date: Wed, 29 Jul 2020 02:26:25 +0000
Message-ID: <BY5PR12MB37779475B76793867FE1CCE095700@BY5PR12MB3777.namprd12.prod.outlook.com>
References: <20200728070433.4265-1-tianci.yin@amd.com>,
 <MN2PR12MB44884A56B4F6E0C013DA86F1F7730@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB44884A56B4F6E0C013DA86F1F7730@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-29T02:26:24.672Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27c0e11e-2d50-4c1a-c134-08d83366cac1
x-ms-traffictypediagnostic: BYAPR12MB3240:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB324076134761639A262181D195700@BYAPR12MB3240.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mCuyzPSwNsPYCqgnQaM6juuG0OuCk+8IXnmMUn1HdjVaPb0OvQbC3I7Vrp0fO1q8YVSu9/ypn7liaaG5tFyhDYEn/Tj08niL6r3uPbyrcDSxnrdhEnzq0W0tFlvvKvQKMvg7svXiheTeeY11k+MsdCxXnkdc0+isX1JZAqrabaiAzHVLN3J+DojmRTdjoCY3PaJ4yRvYv6/8EJX8c6BrFBW2TnnLRLWb0JrMyshe8/e39mJ02xBHOS0tbBA21N453lzrBE0wRX01Bt7nbP1qHXoIQgmHwvna3xLFK10d+lFbcTNvhqeSTEQLLOOTYq4cAAGrxBVUdhbZtkI6fbqqJN66FLye0VGDx4mTsaB2WE2kS21WqT6B4V9nCFSBvVTT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3777.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(33656002)(66946007)(316002)(53546011)(71200400001)(4326008)(8676002)(26005)(66446008)(6506007)(52536014)(5660300002)(66476007)(66556008)(64756008)(91956017)(76116006)(83380400001)(2906002)(478600001)(86362001)(8936002)(54906003)(110136005)(186003)(7696005)(55016002)(19627405001)(9686003)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: KL5PtN5hB0EDOZb61FnWdyx5PFHjhX8xuZjYxwh4oPLYY2KYM0lvuUR7gnEIvY9GARPPGGqr26/DsmqDP7CzvUwHz2Nrvag9rJq9v9b29y8CslbsF37KdkDzJjVK6Nv5jD5BLvI18DSZlehcUUP5gTKZW9q0eWL8HvcUYNpBgeicj4A+BP+J+gzdds/5OlA0W4wzmRVtx08JDaOLcYxyK6sBEDrBATTCqdPQJ40NxjjzFdHGnKeDVSUAXPSVlgcaoYKnKQTxbPTQLCnyrz1cY4yELri+3MV4y3n7rNC5BKV2JhGW7XGrzsAkaI5JxVZPDAFgkKdyrbanD9SWQ6rF2otsKhmB/1g5na8icvNgZpPbzhgcHpOvJyo55PQ7UHa9LCQwLjrYKcsU4TwXEBLfAS8WAQECzoxRvz26Wu6iPjKDrQ0jET9TbtQlTo9I1x58hnhC8z/GXLzvarttWrsG0uc7fAT3yy9nFM5o788dPi+ylBZZaZ5hyEW5ESPThxko
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3777.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c0e11e-2d50-4c1a-c134-08d83366cac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 02:26:25.2802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: voZDIsYPXhL4HPlAR15g0IWhvaE+MKn9aP70tmzKxKWGIcFJDgTgfdRwDsVOdIYM/WYjdwMazHLuQ0q9syT0pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3240
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Hesik, 
 Christopher" <Christopher.Hesik@amd.com>, "Swamy,
 Manjunatha" <Manjunatha.Swamy@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0689886924=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0689886924==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB37779475B76793867FE1CCE095700BY5PR12MB3777namp_"

--_000_BY5PR12MB37779475B76793867FE1CCE095700BY5PR12MB3777namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Hi Alex,

amdgpu_gfx_off_ctrl() invoked by a few other functions, like amdgpu_info_io=
ctl() ,
putting the code into amdgpu_gfx_off_ctrl() will cost more meaningless time=
 on SPM golden reconfiguration.
amdgpu_gfx_off_ctrl(adev, false);
amdgpu_asic_read_register(adev, se_num, sh_num, info->read_mmr_reg.dword_of=
fset + i, &regs[i]);
amdgpu_gfx_off_ctrl(adev, true);

In most cases, we don't care about the SPM, so I think smu_enable_umd_pstat=
e is a better place.

Thanks very much!
Rico
________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, July 28, 2020 22:16
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Zhang, Hawking <Hawking.Zhang@amd=
.com>; Xu, Feifei <Feifei.Xu@amd.com>; Hesik, Christopher <Christopher.Hesi=
k@amd.com>; Swamy, Manjunatha <Manjunatha.Swamy@amd.com>; Quan, Evan <Evan.=
Quan@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Feng, Kenneth <Kenneth.F=
eng@amd.com>
Subject: Re: [PATCH] drm/amdgpu: reconfigure spm golden settings on Navi1x =
after GFXOFF exit(v2)


[AMD Public Use]

Would it be better to put this code into amdgpu_gfx_off_ctrl()?  Then we'll=
 handle this in all cases where we disable gfx off.

Alex

________________________________
From: Tianci Yin <tianci.yin@amd.com>
Sent: Tuesday, July 28, 2020 3:04 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.X=
u@amd.com>; Hesik, Christopher <Christopher.Hesik@amd.com>; Swamy, Manjunat=
ha <Manjunatha.Swamy@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Guchun=
 <Guchun.Chen@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Yin, Tianci (=
Rico) <Tianci.Yin@amd.com>
Subject: [PATCH] drm/amdgpu: reconfigure spm golden settings on Navi1x afte=
r GFXOFF exit(v2)

From: "Tianci.Yin" <tianci.yin@amd.com>

On Navi1x, the SPM golden settings will be lost after GFXOFF enter/exit,
reconfigure the golden settings after GFXOFF exit.

Change-Id: I9358ba9c65f241c36f8a35916170b19535148ee9
Reviewed-by: Feifei Xu <Feifei Xu@amd.com>
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 55463e7a11e2..41487123c207 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1309,6 +1309,7 @@ static int smu_enable_umd_pstate(void *handle,

         struct smu_context *smu =3D (struct smu_context*)(handle);
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
+       struct amdgpu_device *adev =3D smu->adev;

         if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
                 return -EINVAL;
@@ -1318,12 +1319,22 @@ static int smu_enable_umd_pstate(void *handle,
                 if (*level & profile_mode_mask) {
                         smu_dpm_ctx->saved_dpm_level =3D smu_dpm_ctx->dpm_=
level;
                         smu_dpm_ctx->enable_umd_pstate =3D true;
-                       amdgpu_device_ip_set_powergating_state(smu->adev,
+                       amdgpu_device_ip_set_powergating_state(adev,
                                                                AMD_IP_BLOC=
K_TYPE_GFX,
                                                                AMD_PG_STAT=
E_UNGATE);
-                       amdgpu_device_ip_set_clockgating_state(smu->adev,
+                       amdgpu_device_ip_set_clockgating_state(adev,
                                                                AMD_IP_BLOC=
K_TYPE_GFX,
                                                                AMD_CG_STAT=
E_UNGATE);
+
+                       if (adev->asic_type >=3D CHIP_NAVI10 &&
+                           adev->asic_type <=3D CHIP_NAVI12 &&
+                           (adev->pm.pp_feature & PP_GFXOFF_MASK)) {
+                               if (adev->gfx.funcs->init_spm_golden) {
+                                       dev_dbg(adev->dev,"GFXOFF exited, r=
e-init SPM golden settings\n");
+                                       amdgpu_gfx_init_spm_golden(adev);
+                               } else
+                                       dev_warn(adev->dev,"Callback init_s=
pm_golden is NULL\n");
+                       }
                 }
         } else {
                 /* exit umd pstate, restore level, enable gfx cg*/
@@ -1331,10 +1342,10 @@ static int smu_enable_umd_pstate(void *handle,
                         if (*level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_EXI=
T)
                                 *level =3D smu_dpm_ctx->saved_dpm_level;
                         smu_dpm_ctx->enable_umd_pstate =3D false;
-                       amdgpu_device_ip_set_clockgating_state(smu->adev,
+                       amdgpu_device_ip_set_clockgating_state(adev,
                                                                AMD_IP_BLOC=
K_TYPE_GFX,
                                                                AMD_CG_STAT=
E_GATE);
-                       amdgpu_device_ip_set_powergating_state(smu->adev,
+                       amdgpu_device_ip_set_powergating_state(adev,
                                                                AMD_IP_BLOC=
K_TYPE_GFX,
                                                                AMD_PG_STAT=
E_GATE);
                 }
--
2.17.1


--_000_BY5PR12MB37779475B76793867FE1CCE095700BY5PR12MB3777namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Alex,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
amdgpu_gfx_off_ctrl() invoked by a few other functions, like amdgpu_info_io=
ctl() ,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
putting the code into amdgpu_gfx_off_ctrl() will cost more meaningless time=
 on SPM golden reconfiguration.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<i><span style=3D"color: rgb(23, 78, 134);">amdgpu_gfx_off_ctrl(adev, false=
);</span></i>
<div><i><span style=3D"color: rgb(23, 78, 134);">amdgpu_asic_read_register(=
adev, se_num, sh_num, info-&gt;read_mmr_reg.dword_offset + i, &amp;regs[i])=
</span><span style=3D"color: rgb(23, 78, 134);">;</span><span><br>
</span></i></div>
<div><i><span style=3D"color: rgb(23, 78, 134);">amdgpu_gfx_off_ctrl(adev, =
true);</span></i>
<br>
</div>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
In most cases, we don't care about the SPM, so I think smu_enable_umd_pstat=
e is a better place.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks very much!<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Tuesday, July 28, 2020 22:16<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Zhang, Hawking &lt;H=
awking.Zhang@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Hesik, Chri=
stopher &lt;Christopher.Hesik@amd.com&gt;; Swamy, Manjunatha &lt;Manjunatha=
.Swamy@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;; Chen, Guchun
 &lt;Guchun.Chen@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br=
>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: reconfigure spm golden settings on =
Navi1x after GFXOFF exit(v2)</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#317100=
; margin:15pt">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Would it be better to put this code into amdgpu_gfx_off_ctrl()?&nbsp; Then =
we'll handle this in all cases where we disable gfx off.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Alex</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Tianci Yin &lt;tian=
ci.yin@amd.com&gt;<br>
<b>Sent:</b> Tuesday, July 28, 2020 3:04 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&=
gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Hesik, Christopher &lt;Christoph=
er.Hesik@amd.com&gt;; Swamy, Manjunatha &lt;Manjunatha.Swamy@amd.com&gt;;
 Quan, Evan &lt;Evan.Quan@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com=
&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Yin, Tianci (Rico) &lt;Ti=
anci.Yin@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: reconfigure spm golden settings on Navi=
1x after GFXOFF exit(v2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.=
com&gt;<br>
<br>
On Navi1x, the SPM golden settings will be lost after GFXOFF enter/exit,<br=
>
reconfigure the golden settings after GFXOFF exit.<br>
<br>
Change-Id: I9358ba9c65f241c36f8a35916170b19535148ee9<br>
Reviewed-by: Feifei Xu &lt;Feifei Xu@amd.com&gt;<br>
Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 19 +++++++++++++++----<b=
r>
&nbsp;1 file changed, 15 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 55463e7a11e2..41487123c207 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -1309,6 +1309,7 @@ static int smu_enable_umd_pstate(void *handle,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D (struct smu_context*)(handle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;is_apu &amp;&=
amp; !smu_dpm_ctx-&gt;dpm_context)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -1318,12 +1319,22 @@ static int smu_enable_umd_pstate(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (*level &amp; profile_mode_mask) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_d=
pm_ctx-&gt;saved_dpm_level =3D smu_dpm_ctx-&gt;dpm_level;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_d=
pm_ctx-&gt;enable_umd_pstate =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_set_powergating_state(smu-&gt;adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_set_powergating_state(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMD_IP_BLOCK_TYPE_GFX,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMD_PG_STATE_UNGATE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_set_clockgating_state(smu-&gt;adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_set_clockgating_state(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMD_IP_BLOCK_TYPE_GFX,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMD_CG_STATE_UNGATE);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asi=
c_type &gt;=3D CHIP_NAVI10 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;asic_type &lt;=3D CHIP_NAVI12 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (adev-&gt;pm.pp_feature &amp; PP_GFXOFF_MASK)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.funcs-&gt;init_spm_golden)=
 {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dev_dbg(adev-&gt;dev,&quot;GFXOFF exited, re-init SPM golden settings\=
n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_gfx_init_spm_golden(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dev_warn(adev-&gt;dev,&quot;Callback init_spm_golden is NULL\n&quot;);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* exit umd pstate, restore level, enable gfx cg*/<br=
>
@@ -1331,10 +1342,10 @@ static int smu_enable_umd_pstate(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*=
level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *level =3D smu_dpm_ctx-&gt;saved=
_dpm_level;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_d=
pm_ctx-&gt;enable_umd_pstate =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_set_clockgating_state(smu-&gt;adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_set_clockgating_state(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMD_IP_BLOCK_TYPE_GFX,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMD_CG_STATE_GATE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_set_powergating_state(smu-&gt;adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_set_powergating_state(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMD_IP_BLOCK_TYPE_GFX,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMD_PG_STATE_GATE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_BY5PR12MB37779475B76793867FE1CCE095700BY5PR12MB3777namp_--

--===============0689886924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0689886924==--
