Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42115C3F2C6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 03:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 147CC20658
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 03:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qx3tZQG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147CC20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C81016E9A9;
	Fri, 28 Feb 2020 03:03:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D356E9A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 03:02:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIbX00cw9j5HYmuqEViGDWK6q5XVxGSMdlPDSPQpQxr/8/5q3ZCRnDEFRRFAASpcwyPq/lb3nHb8jTkzUVcCL2jB93aCwH5m2JPXmndMPQFn3wfdCtej8KR9idDhm4cLCiL/YnfskzDCGFaxZJ3PQv5JQYIw9Cgs/nvcT8vt3O1WqnHYokP/0v3dnHeCeNeefacdHiedA1PoDqakKFX+8iShgBv5hDAyrP5TSSTtxO7BEH6/iq8AAqkHdEJ7Q6CQaDdBa0uF9+fhvXR60b8/N6F4Vl+I71xuBtcevJaNzhvqwwRo5iWlPbdLsGhEZ6mGCtkbdPt8KiWbzpRJI2igYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjDOGs6hsJ2v5ILrIBha4V3qZFtP5QGV9Lr6Aatv5XM=;
 b=Y84Y0M6q8fhMg9FsZKN5Rh/WKeGHAoMYvpr3rh06BDPh5pKHzOJezfiSIWd2NOUyatXBzPavzld1A2lXvkRVASNwtKYnapJtJHRlJizWyMiHUKNyLyfMFuduxg8d2Z3mqvInLYJ8A/6w/XttbI10MKuDzlBgPNlpgt1qkaqt3ZKzZ2UVLm3SK747Z26sW4A10PSmbqqS3FlwpTpanb4vjst1Qwu3uvb4KmCiP9D8+iItArqjHiD7TdUY5OMlFim6X4fqkCr2RlkkNVstoaEgjk3wyeqqVtKS49BqJVl0GMpUN9Au0j6nbskJvXid0VETdVVQT/LyfpeCrCuK6HFfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjDOGs6hsJ2v5ILrIBha4V3qZFtP5QGV9Lr6Aatv5XM=;
 b=Qx3tZQG4h/FkIyZ7VdXku7oxMg4MfHBJCS3lyH/l1XKp/AiHU2LIa/eHTqij/8iwlZgNwmSdblyTi9X0EsR/8q4gVJ1hP2GSt2LAf2JfEqFG1hZSMKX53SveqdtuoCvLn2RZToDRtHrslb0wpVBnrkDp7uSphScVUSUhglC4VNM=
Received: from MN2PR12MB3056.namprd12.prod.outlook.com (2603:10b6:208:ca::15)
 by MN2PR12MB3552.namprd12.prod.outlook.com (2603:10b6:208:ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 28 Feb
 2020 03:02:57 +0000
Received: from MN2PR12MB3056.namprd12.prod.outlook.com
 ([fe80::10cb:fc6c:98ff:d995]) by MN2PR12MB3056.namprd12.prod.outlook.com
 ([fe80::10cb:fc6c:98ff:d995%7]) with mapi id 15.20.2772.012; Fri, 28 Feb 2020
 03:02:56 +0000
From: "Zhao, Jiange" <Jiange.Zhao@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/sriov: Use VF-accessible register for
 gpu_clock_count
Thread-Topic: [PATCH] drm/amdgpu/sriov: Use VF-accessible register for
 gpu_clock_count
Thread-Index: AQHV7WAZPKgsQIwr9kWWASZqWxnkkagvGB6AgADT7YM=
Date: Fri, 28 Feb 2020 03:02:56 +0000
Message-ID: <MN2PR12MB3056EF4F92975A794D55D304E1E80@MN2PR12MB3056.namprd12.prod.outlook.com>
References: <1582802479-14724-1-git-send-email-Jiange.Zhao@amd.com>,
 <CH2PR12MB3912BF71221F4F9C9FDEA665F7EB0@CH2PR12MB3912.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB3912BF71221F4F9C9FDEA665F7EB0@CH2PR12MB3912.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-02-28T03:02:54.591Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jiange.Zhao@amd.com; 
x-originating-ip: [223.116.87.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7efd975-e6c4-4c41-9fbb-08d7bbfab62d
x-ms-traffictypediagnostic: MN2PR12MB3552:|MN2PR12MB3552:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3552B9F25D187232D99C3900E1E80@MN2PR12MB3552.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(189003)(199004)(478600001)(26005)(55016002)(4326008)(45080400002)(33656002)(19627405001)(53546011)(9686003)(91956017)(186003)(64756008)(6506007)(966005)(66556008)(66446008)(76116006)(66946007)(54906003)(52536014)(8676002)(5660300002)(316002)(66476007)(8936002)(7696005)(2906002)(71200400001)(110136005)(81156014)(81166006)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3552;
 H:MN2PR12MB3056.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: usE/wxsJKnFaXCSlqtN0SVoc+oN5Ep/v8jY/sdrwWdCfM+28sqDtEE/elicDlvTaALYR26p+vKX9DTz2ZkILiwOZshnr4CB/X4jDlhr2L+u6mPSJAEyG1/DtkD5/k1ry8htKYFXEyY6aqzjoSyA6vJDFFcjnyS87BMQGDQZsulpZT0bnyHYw4flH7GTd95a5ub8OuRBWnCAkq//WUNAX6RiHV+GQ2oRSj5DtbYnR2GXnxxU1L8ioRgkqDSwibavZuuaQkBmW7vqKH7W3hYYpuZLoHuAKti0L7lz5cFKyNmhc+CgXPQhwHoHIokhjW0l/nnQyJis3mirBcqIbmzO54JZEkcg0WOEw1A4dJix8sze16y5DsIo0cEuwT/g6fswcPgCLLn17zUQyJmklue4BnFDrNzB8zu9aiOrNVFwE25o/ulReXmB5Y2UceU5CrQcQCGHO4QCfhqU/CSTEocvaIAiPMZOGgvHAVTeyWXQiwTE=
x-ms-exchange-antispam-messagedata: ri5RjYwsUBg4KX+oCCSPwe7zRQN4tkyeJ/HwVjWKasURYxt/Umzt3xC7S6Z9jgXLW8F+eSzWaB5YZSOyDN+Z/K2aew3mKcT/OYdXuVhidOrVW+vQRBAqMo5QgywKWMbPFlKsAC1QS94lXDG0gERtwg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7efd975-e6c4-4c41-9fbb-08d7bbfab62d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 03:02:56.7616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZdxZWjzW7gCek/jwshnzBMOBrrm3LkFxH7F2rM7qrni69q1K6xOSJT6JASM7IH/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3552
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: multipart/mixed; boundary="===============0832171799=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0832171799==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3056EF4F92975A794D55D304E1E80MN2PR12MB3056namp_"

--_000_MN2PR12MB3056EF4F92975A794D55D304E1E80MN2PR12MB3056namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I got feedback from Linux team and they simply don't want to change.

I believe that it would work for bare metal as well.

Jiange
________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Thursday, February 27, 2020 10:23 PM
To: Zhao, Jiange <Jiange.Zhao@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Deng, Emily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu/sriov: Use VF-accessible register for gpu_c=
lock_count


[AMD Public Use]

Is there any reason to not just use this for bare metal as well?

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of jianzh <=
Jiange.Zhao@amd.com>
Sent: Thursday, February 27, 2020 6:21 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deng, Emily <Emily.Deng@amd.com>; Zhao, Jiange <Jiange.Zhao@amd.com>; L=
iu, Monk <Monk.Liu@amd.com>
Subject: [PATCH] drm/amdgpu/sriov: Use VF-accessible register for gpu_clock=
_count

Navi12 VK CTS subtest timestamp.calibrated.dev_domain_test failed
because mmRLC_CAPTURE_GPU_CLOCK_COUNT register cannot be
written in VF due to security policy.

Solution: use a VF-accessible timestamp register pair
mmGOLDEN_TSC_COUNT_LOWER/UPPER for SRIOV case.

Signed-off-by: jianzh <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 44f00ec..8787a46 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -35,6 +35,8 @@

 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
+#include "smuio/smuio_11_0_0_offset.h"
+#include "smuio/smuio_11_0_0_sh_mask.h"
 #include "navi10_enum.h"
 #include "hdp/hdp_5_0_0_offset.h"
 #include "ivsrcid/gfx/irqsrcs_gfx_10_1.h"
@@ -3920,9 +3922,14 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(stru=
ct amdgpu_device *adev)

         amdgpu_gfx_off_ctrl(adev, false);
         mutex_lock(&adev->gfx.gpu_clock_mutex);
-       WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
-       clock =3D (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_LSB) =
|
-               ((uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_MSB) <=
< 32ULL);
+       if (!amdgpu_sriov_vf(adev)) {
+               WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
+               clock =3D (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COU=
NT_LSB) |
+                       ((uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUN=
T_MSB) << 32ULL);
+       } else {
+               clock =3D (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COU=
NT_LOWER) |
+                       ((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUN=
T_UPPER) << 32ULL);
+       }
         mutex_unlock(&adev->gfx.gpu_clock_mutex);
         amdgpu_gfx_off_ctrl(adev, true);
         return clock;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C9b14a49e41fd48f7138f08d7bb773ed9%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637183993593225894&amp;sdata=3DjFUVpgeEcTTJbTJ3a7i=
bAPOyAU3RVF%2FEIN41zaqS0eM%3D&amp;reserved=3D0

--_000_MN2PR12MB3056EF4F92975A794D55D304E1E80MN2PR12MB3056namp_
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
Hi,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I got feedback from Linux team and they simply don't want to change.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I believe that it would work for bare metal as well.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jiange<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Thursday, February 27, 2020 10:23 PM<br>
<b>To:</b> Zhao, Jiange &lt;Jiange.Zhao@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deng, Emily &lt;Emily.Deng@amd.com&gt;; Liu, Monk &lt;Monk.Liu@a=
md.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/sriov: Use VF-accessible register fo=
r gpu_clock_count</font>
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
Is there any reason to not just use this for bare metal as well?</div>
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
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of jianzh &lt;Jiange.Zhao@amd.=
com&gt;<br>
<b>Sent:</b> Thursday, February 27, 2020 6:21 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deng, Emily &lt;Emily.Deng@amd.com&gt;; Zhao, Jiange &lt;Jiange.=
Zhao@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/sriov: Use VF-accessible register for gp=
u_clock_count</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Navi12 VK CTS subtest timestamp.calibrated.dev_d=
omain_test failed<br>
because mmRLC_CAPTURE_GPU_CLOCK_COUNT register cannot be<br>
written in VF due to security policy.<br>
<br>
Solution: use a VF-accessible timestamp register pair<br>
mmGOLDEN_TSC_COUNT_LOWER/UPPER for SRIOV case.<br>
<br>
Signed-off-by: jianzh &lt;Jiange.Zhao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;---<br>
&nbsp;1 file changed, 10 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 44f00ec..8787a46 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -35,6 &#43;35,8 @@<br>
&nbsp;<br>
&nbsp;#include &quot;gc/gc_10_1_0_offset.h&quot;<br>
&nbsp;#include &quot;gc/gc_10_1_0_sh_mask.h&quot;<br>
&#43;#include &quot;smuio/smuio_11_0_0_offset.h&quot;<br>
&#43;#include &quot;smuio/smuio_11_0_0_sh_mask.h&quot;<br>
&nbsp;#include &quot;navi10_enum.h&quot;<br>
&nbsp;#include &quot;hdp/hdp_5_0_0_offset.h&quot;<br>
&nbsp;#include &quot;ivsrcid/gfx/irqsrcs_gfx_10_1.h&quot;<br>
@@ -3920,9 &#43;3922,14 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(=
struct amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, =
false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;g=
fx.gpu_clock_mutex);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU=
_CLOCK_COUNT, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock =3D (uint64_t)RREG32_SOC15(GC, =
0, mmRLC_GPU_CLOCK_COUNT_LSB) |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_MSB) &lt;&l=
t; 32ULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; clock =3D (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUN=
T_LSB) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((uint64_t)R=
REG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_MSB) &lt;&lt; 32ULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; clock =3D (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUN=
T_LOWER) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((uint64_t)R=
REG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER) &lt;&lt; 32ULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt=
;gfx.gpu_clock_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, =
true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return clock;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C9b14a49e41fd48f7138f08d7bb773ed9%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637183993593225894&amp;amp;sdata=3D=
jFUVpgeEcTTJbTJ3a7ibAPOyAU3RVF%2FEIN41zaqS0eM%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C9b14a49e41fd48f7138f08d7bb773ed9%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637183993593225894&amp;amp;sdata=3DjFUVpgeEcTTJbTJ=
3a7ibAPOyAU3RVF%2FEIN41zaqS0eM%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3056EF4F92975A794D55D304E1E80MN2PR12MB3056namp_--

--===============0832171799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0832171799==--
