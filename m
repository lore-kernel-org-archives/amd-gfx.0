Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDA8C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7BB206F6
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="umtyNxJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7BB206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C206E32D;
	Fri, 22 May 2020 05:39:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 262116E32D
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 05:39:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMTWrB3MYo4AM+SUG3j4zUWA62S/CyWU3pUzcs9HZc52OOylUCS3hKvYd1qPRrc0cvz1Y41xT25TZR1OxE/6QlYM1imN8QwpAis+M7t/KwjVDC+sWyEHp+hvm/WdbS9khtWxEzFfB5DhhYMPeVuNtz+nyKIU5UiGZGwO9TPd262NEnEevFcHWlx+pjBzRpvNHwOuTaCCCm9M0FDZDpgW8uiT2HN4ow22pKhcpx1odwgvKveA2u0yaTVsa5tiN5GsgqVpMeFdC+wO7vIGnvEY8lcZFKTZBJGo/5xewvcoGwjMLCsjcJHaWRHBM5El7J8HYEN4MOE7Olu7PYFMQUdrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JszcB1PwN6eZj+RH5oz7DA5fLrT6TXh4xAhHZN2ehjQ=;
 b=b2nYjcOWQ2q8rV+qfnLHJYasGwKc3kuhUzBqTvgpHvMEJSevGInlPqf2VoWEvlzyLzFIhoZB6xu1o4dnbQunGgrWtrY5k/GDrt7iDpXcekiNpc45E1yTNXEuFUiYfT/0JjU9tmEjqDwdx4epKvwZxX7BqbOtyYYXWNRwe0aEmzVYHaIsYdFGCaE1ThaEfVfbLtk8zY/0qbUBT/3kMEY4VIdf2+qdV+ZMfum2GwiSRO0PvYtwNF7YjH3xOXtD11/6hoE6ozJrAcs0eU/RE1AZypqEIRHudulmqgPPdpNjvJ0Yr0Gx1tS1tVYg+IyliT9kEHCcJtqb0GLvNa3tDR0PGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JszcB1PwN6eZj+RH5oz7DA5fLrT6TXh4xAhHZN2ehjQ=;
 b=umtyNxJEzB7T44LMuch8/wdyKq8Jp8G4uLDx7yapWKTZkxtoZaZ/UdDFC1ghcX/X/hRkk6O2Nj4SelFhDE8gNzV2ru9Kku+CQNyiokcJrYvsLv3ZICc/P67fJjV/6yCTSsqG6D71WOVAkfv52TiTMOXeeUxiOwZ+k53UWgJi0qw=
Received: from BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 by BY5PR12MB3956.namprd12.prod.outlook.com (2603:10b6:a03:1ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 22 May
 2020 05:39:13 +0000
Received: from BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c]) by BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c%2]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 05:39:13 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Zhang, Hua" <Hua.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: skip i2c eeprom init/fini under sriov
 mode
Thread-Topic: [PATCH] drm/amd/powerplay: skip i2c eeprom init/fini under sriov
 mode
Thread-Index: AQHWL/o41wyNEeq4W0Klz7cyr0JihKizlUsc
Date: Fri, 22 May 2020 05:39:13 +0000
Message-ID: <BY5PR12MB40680FD70FE24DEA405FB791A2B40@BY5PR12MB4068.namprd12.prod.outlook.com>
References: <20200522053102.17307-1-hua.zhang@amd.com>
In-Reply-To: <20200522053102.17307-1-hua.zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-22T05:39:18.081Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f1deadc-2fcc-4a32-f433-08d7fe1275ee
x-ms-traffictypediagnostic: BY5PR12MB3956:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3956357FDF58513BA380B539A2B40@BY5PR12MB3956.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:113;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8u+Nnj7Z9quTonKgop/lGDYh01+vCmHWuGyH5jaL/FJ6oA14TTytMwZ3ty7tBexdBPwVXmI4ef6zlE1CvvzJVfb07TV8jyLHhtqYfDre1YMD5Vp5TdsFOzhyLLy1iT6jvz3rQE3X09pbEu7hxbafkCNuO1OfGnr1r8abjlnjOllccTNPmwyvCGaSowgoxRi563aMpyoMJiLuUu03ydxyUxSuLcjX8Bh3PCjiKFgbPs++m4fiiVTOe0GF+VhUufW8qJDD6keEBj3Pr0DB+U/xQpxkANNM5WdhW2VUkR9c0CztmQ6F07LJ+yb168DdZ5urZodwgfX9I6zOM4b8CE8TPhsEEFwRCvaDhf3AglvhIGceb41iIom6HuOve+HoRS7ZWUPvYL3wEoIy/P803duRxW5UAtosl+cb+k2OuNynaKID0Xm5e5z8UX7rXByplnoUVcSal4mpV96afpDpcgrZnJrcGilti7npvsD4PjN/0+s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4068.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(2906002)(186003)(64756008)(91956017)(66476007)(19627405001)(76116006)(86362001)(66556008)(66946007)(66446008)(26005)(71200400001)(33656002)(5660300002)(316002)(52536014)(45080400002)(478600001)(53546011)(966005)(7696005)(6506007)(110136005)(166002)(8936002)(8676002)(55016002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: iHzAb2b57utfH+k/0g1WkXhesyNFvuKmPWmhrHhg0PVAbvr05LCFua8C9yNYSe3uyji5LAeqVspfz88/Q89VyYK0RU3n0G9CUqdZqXugcoMoZmtORAxbb8esa+58Fu+JvKzwW2ZsC2kTx3xcg1MBZz4jTB7CrlmhN3+jsWVgo0sQ+3K3i72tyL5ZYCJkkaNmD1l3stDWsaKKnp+D4n/kQocSfIwoMfkkCcsoNA8cw+e/HPdb/yCq8s96wrhVpwET/HYeb2lzXcI/Z9xDnbJj17Qe7FQ15knK4AOG+0iFTtD2OLgOMIFsJsCiqwsFh/iiVa7ZRmlEXOya/hePhxt04QgSEOOAWpYm+64ADe3nK7qQSd+Qnd5MR4LtFTjk/vIPRvFd40J1olyTqCwo36UqMVNd4c3pOrmQ5XMR59ShV4kNAGkx587ijEgTxCe+A5dswkv2I0l2bhUuP1zuCgyGtN7FkSF9BqFrH5LskRzYTlPzFMNrmYjFlH9ugbNkxCDt
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1deadc-2fcc-4a32-f433-08d7fe1275ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 05:39:13.6380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NTxQydAwW9ZFEsbk8iQ5RSW/SRqrNh80h8bWmkKxd8DbqK2p++ksNShQ52uetuSn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3956
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
Content-Type: multipart/mixed; boundary="===============0367769640=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0367769640==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB40680FD70FE24DEA405FB791A2B40BY5PR12MB4068namp_"

--_000_BY5PR12MB40680FD70FE24DEA405FB791A2B40BY5PR12MB4068namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

please add a detailed description of the reason for this patch,
after finshed, the patch is

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Hua Zhan=
g <hua.zhang@amd.com>
Sent: Friday, May 22, 2020 1:31 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hua <Hua.Zhang@amd.com>
Subject: [PATCH] drm/amd/powerplay: skip i2c eeprom init/fini under sriov m=
ode

i2c eeprom init/fini is only needed under bare mental mode.

Signed-off-by: Hua Zhang <hua.zhang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 24 +++++++++++++---------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 8017386d3c33..a78a1f542ea9 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1363,9 +1363,11 @@ static int smu_hw_init(void *handle)
         if (ret)
                 goto failed;

-       ret =3D smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
-       if (ret)
-               goto failed;
+       if (!amdgpu_sriov_vf(adev)) {
+               ret =3D smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
+               if (ret)
+                       goto failed;
+       }

         adev->pm.dpm_enabled =3D true;

@@ -1406,9 +1408,9 @@ static int smu_hw_fini(void *handle)

         adev->pm.dpm_enabled =3D false;

-       smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
-
         if (!amdgpu_sriov_vf(adev)){
+               smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
+
                 ret =3D smu_stop_thermal_control(smu);
                 if (ret) {
                         pr_warn("Fail to stop thermal control!\n");
@@ -1549,9 +1551,9 @@ static int smu_suspend(void *handle)

         adev->pm.dpm_enabled =3D false;

-       smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
+       if (!amdgpu_sriov_vf(adev)) {
+               smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);

-       if(!amdgpu_sriov_vf(adev)) {
                 ret =3D smu_disable_dpm(smu);
                 if (ret)
                         return ret;
@@ -1596,9 +1598,11 @@ static int smu_resume(void *handle)
         if (ret)
                 goto failed;

-       ret =3D smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
-       if (ret)
-               goto failed;
+       if (!amdgpu_sriov_vf(adev)) {
+               ret =3D smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
+               if (ret)
+                       goto failed;
+       }

         if (smu->is_apu)
                 smu_set_gfx_cgpg(&adev->smu, true);
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7Cc8e0d6a298474263093c08d7fe115797%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637257222795940615&amp;sdata=3DLR7lQJ3I2XorNFokkz%2FRe6J=
K6H3TT3hlprc6EWHNPpI%3D&amp;reserved=3D0

--_000_BY5PR12MB40680FD70FE24DEA405FB791A2B40BY5PR12MB4068namp_
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
please add a detailed description of the reason for this patch,<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
after finshed, the patch is</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,<br>
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Hua Zhang &lt;hua.zhang@amd.c=
om&gt;<br>
<b>Sent:</b> Friday, May 22, 2020 1:31 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hua &lt;Hua.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: skip i2c eeprom init/fini under =
sriov mode</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">i2c eeprom init/fini is only needed under bare men=
tal mode.<br>
<br>
Signed-off-by: Hua Zhang &lt;hua.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 24 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------<br>
&nbsp;1 file changed, 14 insertions(&#43;), 10 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 8017386d3c33..a78a1f542ea9 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -1363,9 &#43;1363,11 @@ static int smu_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_i2c_eeprom_init(smu, &amp=
;adev-&gt;pm.smu_i2c);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto failed;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_i2c_eeprom_init(smu, &amp;adev-&gt;pm.smu_i2c);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm_enabled =
=3D true;<br>
&nbsp;<br>
@@ -1406,9 &#43;1408,9 @@ static int smu_hw_fini(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm_enabled =
=3D false;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_i2c_eeprom_fini(smu, &amp;adev-&g=
t;pm.smu_i2c);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)=
){<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu_i2c_eeprom_fini(smu, &amp;adev-&gt;pm.smu_i2c);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_stop_thermal_control(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_wa=
rn(&quot;Fail to stop thermal control!\n&quot;);<br>
@@ -1549,9 &#43;1551,9 @@ static int smu_suspend(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm_enabled =
=3D false;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_i2c_eeprom_fini(smu, &amp;adev-&g=
t;pm.smu_i2c);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu_i2c_eeprom_fini(smu, &amp;adev-&gt;pm.smu_i2c);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(!amdgpu_sriov_vf(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_disable_dpm(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
@@ -1596,9 &#43;1598,11 @@ static int smu_resume(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_i2c_eeprom_init(smu, &amp=
;adev-&gt;pm.smu_i2c);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto failed;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_i2c_eeprom_init(smu, &amp;adev-&gt;pm.smu_i2c);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;is_apu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_set_gfx_cgpg(&amp;adev-&gt;smu, true);<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7Cc8e0d6a298474263093c08d7fe115797%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637257222795940615&amp;amp;sdata=3DLR7lQJ=
3I2XorNFokkz%2FRe6JK6H3TT3hlprc6EWHNPpI%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40=
amd.com%7Cc8e0d6a298474263093c08d7fe115797%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637257222795940615&amp;amp;sdata=3DLR7lQJ3I2XorNFokkz%2FRe6JK6=
H3TT3hlprc6EWHNPpI%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB40680FD70FE24DEA405FB791A2B40BY5PR12MB4068namp_--

--===============0367769640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0367769640==--
