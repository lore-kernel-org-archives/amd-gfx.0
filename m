Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8B8C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 14:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04DE9206DA
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 14:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DE9206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A98626E320;
	Thu, 14 Nov 2019 14:00:37 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820051.outbound.protection.outlook.com [40.107.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FA6A6E320
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 14:00:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqULpISlxsWQmB2c5XThTEXOkaozLb/0r7JzLJdpuGx5dPJq8nFvpERGrNU1Lzbmkj/GSp4n3JLeG7ureiB1QEHBZxE3P7wLrVdaTfbyCrI9O4XXieSGqioTtA+Ra2SPLcb7Qv7imCIjtq+w4JAZPi6SKdAgV1KudVKeul2PmZTPooVltIVPerIs42Y2v7EzCFe7A+bDrgd5C/pQ4QXGe93k0c82+sc2olS00W3o79UYFztUaAggsADMotv3SYRzeMpNEc5jh1j1zUvIAxkOmOr6r4AmpsUhB94afeH+dhJA25mwVDPNkL2MrstycKsxO0jzGkTbygQJeKACWZzrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOFAsVpout+fCHA0eqFADd9hown7XP5p1gZMMLRu1wQ=;
 b=Dr7Z7iMybEAUpkgRHHrqvUCsrYnZ2EVnqgPKr8qmfAOResMcol7N8rBzSaSEl3KVl1JfjJiLQ/zTmFUola1HyEfzJQTRpzfqcj9wcfGJ7UCe44NuFe1tG8d3QrGSkfVoodn1ODwyMaAyPJSw+F0F9J4Dfm9u80wDDHekhhPkSquoRvEMyBZ1I49zXNPZhf0kPDUckXwbSiQlW0x1Juv5dEafEAqYRZjG+FW5ZOGpEkj/LLiuxi1KADLYEn1VZ8/Cw4C+B8Fi37tV8068UpimPzhfRbw1pj1TJSKa6itWV5KzVDpyKWOh7Es32Vlpv5YUjGQl/I+6gJ0rM3KYxib92A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1820.namprd12.prod.outlook.com (10.175.88.143) by
 DM5PR12MB1802.namprd12.prod.outlook.com (10.175.86.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.26; Thu, 14 Nov 2019 14:00:34 +0000
Received: from DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807]) by DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807%5]) with mapi id 15.20.2451.023; Thu, 14 Nov 2019
 14:00:34 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: issue no PPSMC_MSG_GetCurrPkgPwr on
 unsupported ASICs
Thread-Topic: [PATCH] drm/amd/powerplay: issue no PPSMC_MSG_GetCurrPkgPwr on
 unsupported ASICs
Thread-Index: AQHVmr3voIko33IXkUaaJcs1mOsLW6eKsjoB
Date: Thu, 14 Nov 2019 14:00:34 +0000
Message-ID:
 <DM5PR12MB18200DAF7DDBF9899480E291F7710@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <20191114073347.12034-1-evan.quan@amd.com>
In-Reply-To: <20191114073347.12034-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: faa4f494-46c0-4bdc-aa9c-08d7690b0505
x-ms-traffictypediagnostic: DM5PR12MB1802:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB180200DAB95C59BCCA5457D4F7710@DM5PR12MB1802.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:421;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(199004)(189003)(3923003)(76116006)(74316002)(76176011)(229853002)(5660300002)(52536014)(476003)(55016002)(14454004)(19627405001)(102836004)(446003)(11346002)(71200400001)(7696005)(6506007)(110136005)(6246003)(33656002)(316002)(6116002)(3846002)(53546011)(99286004)(71190400001)(966005)(66556008)(66476007)(64756008)(236005)(478600001)(66946007)(6436002)(86362001)(25786009)(6306002)(9686003)(54896002)(8936002)(105004)(606006)(8676002)(66446008)(81156014)(81166006)(66066001)(2906002)(26005)(486006)(2501003)(7736002)(256004)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1802;
 H:DM5PR12MB1820.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i0LVT2/xG0j4051oBmwyxYVdAvMYDRnlBbOS9X+Pa5st65BEE5dP0LNfE1t9uPhqOALUHXL3G/rgCl7yFx0/NBEKCMYeoWiTAa6XL4/azqebb54zchPLegRWp1bRUO+buJt11Jfyv24oK/K9PdsOLvqc+VCA4hsZqcxkQo3qWpkngjFS8Poj6f0DvNYnNcuEf40MOdA/7YqykMQI2XzHKMnj6bMXycJbdZ//O4ZnOSpR1AZBBDIzE4NDIn1Tid4WI0IoaU90A1VQuFcd4RU0+xvIENT7hNBZ+nm6FlcvmenMWYLn3rbwJXiQoNlYS5OgWGc1zPTt9kdPQfWIEFXWv6kmMJeHH3UDiJYICkDhns8IDHKT5qU3gR5ZpGQpXUFJPgADFQpMeT8FRWiijWHTUxupaxlk4iPYqbHtlp1QbtKGyrtaPBfbRMVva3Ke0AdqZQsl6sFgraRHQKQEHJazp45UeZ4ICbC7jd145DAqaPk=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa4f494-46c0-4bdc-aa9c-08d7690b0505
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 14:00:34.5009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GLKqn524UUVrMiTpBSDngW/6Spxn4Vc0ogu+YcTJ+/BVJ3QGg8okekieNejIS+nBeOiuMlFstkYjHt17DeGVrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOFAsVpout+fCHA0eqFADd9hown7XP5p1gZMMLRu1wQ=;
 b=pIpc40NNGFw6v/qeK7qcKUbyrjJ+9CmM9e2Z3JkhRI3iDzx3rT/Uzw5AiNf+iyN5paOA7LoIpdp1lxePSHbKvrg+RzmhJrJFGC1nyRGB7lYM1BlxTPjC+aJaBgS0SWsj2Z/jDC5lUylIRIehaShwXpexM7GNCc7Scygnj5rZQGs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0834007285=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191114140034.XZF31HOw8bZI5yg0qoyGFwkpfQI8avpJg9upzgsSGqw@z>

--===============0834007285==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB18200DAF7DDBF9899480E291F7710DM5PR12MB1820namp_"

--_000_DM5PR12MB18200DAF7DDBF9899480E291F7710DM5PR12MB1820namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Evan Qua=
n <evan.quan@amd.com>
Sent: Thursday, November 14, 2019 2:33 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/powerplay: issue no PPSMC_MSG_GetCurrPkgPwr on uns=
upported ASICs

Otherwise, the error message prompted will confuse user.

Change-Id: I44b9f870a8663714d715a1d5bf2aa24abe75bb8e
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c  | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index d3c3b3512a16..5c6b71b356e7 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -3476,18 +3476,31 @@ static int smu7_get_pp_table_entry(struct pp_hwmgr =
*hwmgr,

 static int smu7_get_gpu_power(struct pp_hwmgr *hwmgr, u32 *query)
 {
+       struct amdgpu_device *adev =3D hwmgr->adev;
         int i;
         u32 tmp =3D 0;

         if (!query)
                 return -EINVAL;

-       smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_GetCurrPkgPwr,=
 0);
-       tmp =3D cgs_read_register(hwmgr->device, mmSMC_MSG_ARG_0);
-       *query =3D tmp;
+       /*
+        * PPSMC_MSG_GetCurrPkgPwr is not supported on:
+        *  - Hawaii
+        *  - Bonaire
+        *  - Fiji
+        *  - Tonga
+        */
+       if ((adev->asic_type !=3D CHIP_HAWAII) &&
+           (adev->asic_type !=3D CHIP_BONAIRE) &&
+           (adev->asic_type !=3D CHIP_FIJI) &&
+           (adev->asic_type !=3D CHIP_TONGA)) {
+               smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_GetCur=
rPkgPwr, 0);
+               tmp =3D cgs_read_register(hwmgr->device, mmSMC_MSG_ARG_0);
+               *query =3D tmp;

-       if (tmp !=3D 0)
-               return 0;
+               if (tmp !=3D 0)
+                       return 0;
+       }

         smum_send_msg_to_smc(hwmgr, PPSMC_MSG_PmStatusLogStart);
         cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
--
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB18200DAF7DDBF9899480E291F7710DM5PR12MB1820namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Thursday, November 14, 2019 2:33 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: issue no PPSMC_MSG_GetCurrPkgPwr=
 on unsupported ASICs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Otherwise, the error message prompted will confuse=
 user.<br>
<br>
Change-Id: I44b9f870a8663714d715a1d5bf2aa24abe75bb8e<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c&nbsp; | 23 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----<br>
&nbsp;1 file changed, 18 insertions(&#43;), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
index d3c3b3512a16..5c6b71b356e7 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -3476,18 &#43;3476,31 @@ static int smu7_get_pp_table_entry(struct pp_hw=
mgr *hwmgr,<br>
&nbsp;<br>
&nbsp;static int smu7_get_gpu_power(struct pp_hwmgr *hwmgr, u32 *query)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!query)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc_with_parameter(h=
wmgr, PPSMC_MSG_GetCurrPkgPwr, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D cgs_read_register(hwmgr-&gt;d=
evice, mmSMC_MSG_ARG_0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *query =3D tmp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * PPSMC_MSG_GetCurrPkgPwr i=
s not supported on:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp; - Hawaii<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp; - Bonaire<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp; - Fiji<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp; - Tonga<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type !=3D CHIP=
_HAWAII) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt=
;asic_type !=3D CHIP_BONAIRE) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt=
;asic_type !=3D CHIP_FIJI) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt=
;asic_type !=3D CHIP_TONGA)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_GetCurr=
PkgPwr, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; tmp =3D cgs_read_register(hwmgr-&gt;device, mmSMC_MSG_ARG_0)=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *query =3D tmp;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp !=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (tmp !=3D 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc(hwmgr=
, PPSMC_MSG_PmStatusLogStart);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_ind_register(hwm=
gr-&gt;device, CGS_IND_REG__SMC,<br>
-- <br>
2.24.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB18200DAF7DDBF9899480E291F7710DM5PR12MB1820namp_--

--===============0834007285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0834007285==--
