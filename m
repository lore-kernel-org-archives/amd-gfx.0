Return-Path: <SRS0=trOe=7I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F5DC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 10:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5332071A
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 10:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QJtsAc+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5332071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9D346E14A;
	Tue, 26 May 2020 10:18:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FFA06E14A
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2020 10:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gu1axRGSbbJ7v3ig5gecxgJShCXHH/m9GZp/E2ra8AIEse8Ccmfe1Lz8kFuKH2p9MdR/Vgkd1BOV7rSyAtOAIJg6GafGbIZwJFQePjqSp8JcH4XhXTVjYIIs+7txzgO/rr6WxOdECz5l4SxG1jPqkHeqx0QRNg9vvyo+2RaKCqCHYaH9vW52DHBY7VGPgsyjxhpHSGdC8+/6X1jw3ED5VZv/ddsHr28sLFPQpFSq6nQXUhMV+SPCM51GIxdpqqW+CgqLhRe+YLstYhX6X4lU+w/gmN2zziChBWcaYED7U4eEE98U5QyWfK0dKm09Hk/ZVdDZeFHczxtdMBq/2/qWHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXHgCZcvD3T3YjvxgpH9EUUXsVL8F21Twd/kmanJEnI=;
 b=HG5kviytBGLiwFAqOpsHQwbXEUD2GmYiISsTXQDY1KDcJDOFD3efoyLcBUoJ00LygQHgSsxKrfi2t5hjtE2S3lYYeenTAk7uQyKqoH7xi61ZNN2/ohHWkBzF035Zd7YwUepDL559/xPAcWfpsZooz6rG6JR1hgRtM2oTUb6AtjnIHT0rCbb5YUteALjoQBlGhMs4BdmvFgWEfejjtIc76YICnPxKP0xSdrkLyyzQ+KCqq9OYSlgZaFDNoGXIaAU3XKG/AIJoBAp0M1nGxtq2FGhXLnZdudsHzuXw5c6Jv4zZR3mdVbrYHz1FpcuEl8ROFq8Q0EWJsRbH/Ld0zapu1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXHgCZcvD3T3YjvxgpH9EUUXsVL8F21Twd/kmanJEnI=;
 b=QJtsAc+oj1GSxEYCY57rXdmpq2/xE+uUmqleh0/wJuP/9Jwd2qSRifdHXGzjnvkD8UqnGVXMtIZ2FP5TRYJ+iYzfBCycziUCZKj35VYFTfbCFa5DS5nU9CGZhbrSCLVaWYfMR7LffLfZGV2GV+jMWeC6Mthlxll6VNrhVPL/8Ss=
Received: from BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Tue, 26 May
 2020 10:18:24 +0000
Received: from BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c]) by BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c%2]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 10:18:23 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 4/4] drm/amd/powerplay: add check before i2c_add_adapter
Thread-Topic: [PATCH 4/4] drm/amd/powerplay: add check before i2c_add_adapter
Thread-Index: AQHWM0VITymifZ6VXE2IJb4YBHrH3Ki6JqEu
Date: Tue, 26 May 2020 10:18:23 +0000
Message-ID: <BY5PR12MB406869380A58A3C1BC96170AA2B00@BY5PR12MB4068.namprd12.prod.outlook.com>
References: <20200526100543.5844-1-Wenhui.Sheng@amd.com>,
 <20200526100543.5844-4-Wenhui.Sheng@amd.com>
In-Reply-To: <20200526100543.5844-4-Wenhui.Sheng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-26T10:18:22.471Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: beccfadd-4e93-48e3-a9ca-08d8015e1f6d
x-ms-traffictypediagnostic: BY5PR12MB4209:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB42090C41032FE5566EF6532DA2B00@BY5PR12MB4209.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dsWg39H4Jvc3vaxox+GjAyDksHPUbkFS7HOr8IIxsiDnSyJsc3XWnt+HIRLlSOn/jHrC65TsmoP/Rr44aHzdjBVJNpD3dsCfVZa0uISWYxLA8HItJtc+CG/0mlVTwIMa7bg837j/Tejqdq+MXAz0sDuHdXNkunQHF+FYYnQo3ooL4TQDistHz7D88MdherBNR4phhdvz8p5OkwOAjQ+0IKaGUhvYljUXXn9B3JPS+LKPX0O0qS7vtmDBYSxYnUgcKFVoSlJN39zXv1/Uv3FYRpIP1YRf4qhqB+iQlLTMgmBUPcTb8IsfQHhtPav9HEfoGaWsQtGDMAKzG3XhBc5dPUUkIJyClWN4HzN93nZRmtg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4068.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(45080400002)(5660300002)(478600001)(4326008)(71200400001)(86362001)(19627405001)(966005)(9686003)(33656002)(55016002)(2906002)(186003)(7696005)(316002)(110136005)(64756008)(66946007)(76116006)(91956017)(8676002)(8936002)(26005)(53546011)(166002)(6506007)(66556008)(66446008)(66476007)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: cv0TTePum5NKHRjWJJIlPn//h8kV+0b3Nxc+aJivtlisBke5qzwBx+wcxUOURYF08hcwNiS5QivubK5+jCz8RlCCvDxAfI60EgVHKV061ZQtBrAyr8YFaD481Xsx7cde3ssXgdPhBozdGM1Tk9w/7k9dLbuL1R+2zkcnkqmRhUjm7rJv7tfTPFymAloedQauuUm5ZBK5egNRH4qIi86gELLEPsh15VwhQWQzlVkO8bGt7YBhqIL+D9rtAasGRCPs9LFDp507qx6dgldAdR11g2DpnswW+deGEWcEZvw/mgEiaLhD2/wjR5wTO+NwGmL00npAlXZxSGU0X4l+Zp3WNkqZVkkiIWEGIIK8/HLVD6QXSS6TQBVyHSJevQHKwAci34zkPoKA5zbua8ACEVS1qV0IMsa/6CttGKBMs4dVpAM31eGnMAyVXEk9MnKTgxWPapYjNdWCEeGCUCD2WA/VRRMsPdfU8SJE3JGqDeMrb4VZKeoY1W90lbCnizeD5ztj
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beccfadd-4e93-48e3-a9ca-08d8015e1f6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 10:18:23.6638 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UkVgpZ3ppASMUQNVrKqvGPTOWUi+0uYFg+cq92oZZvBdt09HVwKFLHoGCtLBONEE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1317527593=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1317527593==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB406869380A58A3C1BC96170AA2B00BY5PR12MB4068namp_"

--_000_BY5PR12MB406869380A58A3C1BC96170AA2B00BY5PR12MB4068namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Wenhui S=
heng <Wenhui.Sheng@amd.com>
Sent: Tuesday, May 26, 2020 6:05 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Sheng, Wenhui <Wenhui.Sheng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd=
.com>
Subject: [PATCH 4/4] drm/amd/powerplay: add check before i2c_add_adapter

smu_i2c_eeprom_init may be invoked twice or more
under sroiv mode, while we don't want to add check
if (!amdgpu_sriov_vf) before we invoke smu_i2c_eeprom_init/fini
each time, so we check if i2c adapter is already added
before we invoke i2c_add_adapter

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
Change-Id: I3500ff474e0f04ea6bd4f9adf9f97b159443dfd9
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c   | 24 +++++++-------------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 14 ++++++++++++
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 1e9be1dcc62b..8ce907280dc9 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1354,11 +1354,9 @@ static int smu_hw_init(void *handle)
         if (ret)
                 goto failed;

-       if (!amdgpu_sriov_vf(adev)) {
-               ret =3D smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
-               if (ret)
-                       goto failed;
-       }
+       ret =3D smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
+       if (ret)
+               goto failed;

         adev->pm.dpm_enabled =3D true;

@@ -1396,9 +1394,7 @@ static int smu_hw_fini(void *handle)

         adev->pm.dpm_enabled =3D false;

-       if (!amdgpu_sriov_vf(adev)) {
-               smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
-       }
+       smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);

         ret =3D smu_stop_thermal_control(smu);
         if (ret) {
@@ -1539,9 +1535,7 @@ static int smu_suspend(void *handle)

         adev->pm.dpm_enabled =3D false;

-       if (!amdgpu_sriov_vf(adev)) {
-               smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
-       }
+       smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);

         ret =3D smu_disable_dpm(smu);
         if (ret)
@@ -1586,11 +1580,9 @@ static int smu_resume(void *handle)
         if (ret)
                 goto failed;

-       if (!amdgpu_sriov_vf(adev)) {
-               ret =3D smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
-               if (ret)
-                       goto failed;
-       }
+       ret =3D smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
+       if (ret)
+               goto failed;

         if (smu->is_apu)
                 smu_set_gfx_cgpg(&adev->smu, true);
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index 70cc1c12f196..437f8a317838 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2224,11 +2224,22 @@ static const struct i2c_algorithm arcturus_i2c_eepr=
om_i2c_algo =3D {
         .functionality =3D arcturus_i2c_eeprom_i2c_func,
 };

+static bool arcturus_i2c_adapter_is_added(struct i2c_adapter *control)
+{
+       struct amdgpu_device *adev =3D to_amdgpu_device(control);
+
+       return control->dev.parent =3D=3D &adev->pdev->dev ? true : false;
[kevin]:
please change code from
"return control->dev.parent =3D=3D &adev->pdev->dev ? true : false;"
to
"return control->dev.parent =3D=3D &adev->pdev->dev".

after fixed, Series is
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

+}


+
 static int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
 {
         struct amdgpu_device *adev =3D to_amdgpu_device(control);
         int res;

+       /* smu_i2c_eeprom_init may be called twice in sriov */
+       if (arcturus_i2c_adapter_is_added(control))
+               return 0;
+
         control->owner =3D THIS_MODULE;
         control->class =3D I2C_CLASS_SPD;
         control->dev.parent =3D &adev->pdev->dev;
@@ -2244,6 +2255,9 @@ static int arcturus_i2c_eeprom_control_init(struct i2=
c_adapter *control)

 static void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
 {
+       if (!arcturus_i2c_adapter_is_added(control))
+               return;
+
         i2c_del_adapter(control);
 }

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7C598c8cf6946745005df908d8015c692b%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637260843721510576&amp;sdata=3DlQSeaMsfm7pHjDP%2FLo94JqV=
zSZEIF1NLTNz3fSvkJ3k%3D&amp;reserved=3D0

--_000_BY5PR12MB406869380A58A3C1BC96170AA2B00BY5PR12MB4068namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Wenhui Sheng &lt;Wenhui.Sheng=
@amd.com&gt;<br>
<b>Sent:</b> Tuesday, May 26, 2020 6:05 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Sheng, Wenhui &lt;Wenhui.Sheng@amd.com&gt;; Zhang, Hawking &lt;H=
awking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 4/4] drm/amd/powerplay: add check before i2c_add_ada=
pter</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">smu_i2c_eeprom_init may be invoked twice or more<b=
r>
under sroiv mode, while we don't want to add check<br>
if (!amdgpu_sriov_vf) before we invoke smu_i2c_eeprom_init/fini<br>
each time, so we check if i2c adapter is already added<br>
before we invoke i2c_add_adapter<br>
<br>
Signed-off-by: Wenhui Sheng &lt;Wenhui.Sheng@amd.com&gt;<br>
Change-Id: I3500ff474e0f04ea6bd4f9adf9f97b159443dfd9<br>
Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp; | 24 &#43;&#43=
;&#43;&#43;&#43;&#43;&#43;-------------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 14 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;2 files changed, 22 insertions(&#43;), 16 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 1e9be1dcc62b..8ce907280dc9 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -1354,11 &#43;1354,9 @@ static int smu_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_i2c_eeprom_init(smu, &amp;adev-&gt;pm.smu_i2c);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_i2c_eeprom_init(smu, =
&amp;adev-&gt;pm.smu_i2c);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto failed;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm_enabled =
=3D true;<br>
&nbsp;<br>
@@ -1396,9 &#43;1394,7 @@ static int smu_hw_fini(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm_enabled =
=3D false;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_i2c_eeprom_fini(smu, &amp;adev-&gt;pm.smu_i2c);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_i2c_eeprom_fini(smu, &amp;ade=
v-&gt;pm.smu_i2c);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_stop_thermal_c=
ontrol(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
@@ -1539,9 &#43;1535,7 @@ static int smu_suspend(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm_enabled =
=3D false;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_i2c_eeprom_fini(smu, &amp;adev-&gt;pm.smu_i2c);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_i2c_eeprom_fini(smu, &amp;ade=
v-&gt;pm.smu_i2c);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_disable_dpm(sm=
u);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
@@ -1586,11 &#43;1580,9 @@ static int smu_resume(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_i2c_eeprom_init(smu, &amp;adev-&gt;pm.smu_i2c);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_i2c_eeprom_init(smu, =
&amp;adev-&gt;pm.smu_i2c);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto failed;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;is_apu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_set_gfx_cgpg(&amp;adev-&gt;smu, true);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index 70cc1c12f196..437f8a317838 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -2224,11 &#43;2224,22 @@ static const struct i2c_algorithm arcturus_i2c_=
eeprom_i2c_algo =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .functionality =3D arcturu=
s_i2c_eeprom_i2c_func,<br>
&nbsp;};<br>
&nbsp;<br>
&#43;static bool arcturus_i2c_adapter_is_added(struct i2c_adapter *control)=
<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D to=
_amdgpu_device(control);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return control-&gt;dev.parent =3D=
=3D &amp;adev-&gt;pdev-&gt;dev ? true : false;</div>
<div class=3D"PlainText">
<div style=3D"margin: 0px; font-family: &quot;Segoe UI&quot;, &quot;Segoe U=
I Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacS=
ystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color=
: rgb(255, 255, 255)">
[kevin]:</div>
<div style=3D"margin: 0px; font-family: &quot;Segoe UI&quot;, &quot;Segoe U=
I Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacS=
ystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color=
: rgb(255, 255, 255)">
please change code from</div>
<div style=3D"margin: 0px; font-family: &quot;Segoe UI&quot;, &quot;Segoe U=
I Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacS=
ystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color=
: rgb(255, 255, 255)">
&quot;<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web =
(West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemF=
ont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: rgb(=
255, 255, 255); display: inline !important">return control-&gt;dev.parent =
=3D=3D &amp;adev-&gt;pdev-&gt;dev
 ? true : false;&quot;</span></div>
<div style=3D"margin: 0px; font-family: &quot;Segoe UI&quot;, &quot;Segoe U=
I Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacS=
ystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color=
: rgb(255, 255, 255)">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: rgb(255, 2=
55, 255); display: inline !important">to&nbsp;</span></div>
<div style=3D"margin: 0px; font-family: &quot;Segoe UI&quot;, &quot;Segoe U=
I Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacS=
ystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color=
: rgb(255, 255, 255)">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: rgb(255, 2=
55, 255); display: inline !important"><span style=3D"font-family: &quot;Seg=
oe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;=
, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sa=
ns-serif; background-color: rgb(255, 255, 255); display: inline !important"=
>&quot;return
 control-&gt;dev.parent =3D=3D &amp;adev-&gt;pdev-&gt;dev&quot;.</span></sp=
an></div>
<div style=3D"margin: 0px; font-family: &quot;Segoe UI&quot;, &quot;Segoe U=
I Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacS=
ystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color=
: rgb(255, 255, 255)">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: rgb(255, 2=
55, 255); display: inline !important"><span style=3D"font-family: &quot;Seg=
oe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;=
, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sa=
ns-serif; background-color: rgb(255, 255, 255); display: inline !important"=
><br>
</span></span></div>
<div style=3D"margin: 0px; font-family: &quot;Segoe UI&quot;, &quot;Segoe U=
I Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacS=
ystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color=
: rgb(255, 255, 255)">
after fixed, Series is&nbsp;</div>
<div style=3D"margin: 0px; font-family: &quot;Segoe UI&quot;, &quot;Segoe U=
I Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacS=
ystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color=
: rgb(255, 255, 255)">
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<br>
&#43;}</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">&#43;<br>
&nbsp;static int arcturus_i2c_eeprom_control_init(struct i2c_adapter *contr=
ol)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D to_amdgpu_device(control);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int res;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* smu_i2c_eeprom_init may be cal=
led twice in sriov */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (arcturus_i2c_adapter_is_added=
(control))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;owner =3D THIS=
_MODULE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;class =3D I2C_=
CLASS_SPD;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;dev.parent =3D=
 &amp;adev-&gt;pdev-&gt;dev;<br>
@@ -2244,6 &#43;2255,9 @@ static int arcturus_i2c_eeprom_control_init(struc=
t i2c_adapter *control)<br>
&nbsp;<br>
&nbsp;static void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *cont=
rol)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!arcturus_i2c_adapter_is_adde=
d(control))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c_del_adapter(control);<=
br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7C598c8cf6946745005df908d8015c692b%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637260843721510576&amp;amp;sdata=3DlQSeaM=
sfm7pHjDP%2FLo94JqVzSZEIF1NLTNz3fSvkJ3k%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40=
amd.com%7C598c8cf6946745005df908d8015c692b%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637260843721510576&amp;amp;sdata=3DlQSeaMsfm7pHjDP%2FLo94JqVzS=
ZEIF1NLTNz3fSvkJ3k%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB406869380A58A3C1BC96170AA2B00BY5PR12MB4068namp_--

--===============1317527593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1317527593==--
