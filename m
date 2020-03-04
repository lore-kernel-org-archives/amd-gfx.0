Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FABDC3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 14:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE592072A
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 14:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f8iGLBoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE592072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEFEE6E198;
	Wed,  4 Mar 2020 14:15:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 444296E191
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 14:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1v5DcMkyLHZZ4JKToV0isk9IKX8Gm/hO/Zii6e4gbXBcACuBhAyG6zboBZmox7rNYXbSmPMMf4YYSXAbnFRe9QlStC0HNRb61CYmykcNl7j8CkOG0FRHx6H9rPWijEwAzPjeWytICoU3+X/UGx+k1TIvYq1Dtx9HjHg0ACR5BXd4sp9F4pmtbqk8dZ2cNhqxjbF0zTsO3WmakLVLIL7zjFvCHJUP4fP4YRn/V1JNJTaK0yCdzY/FjyG28eA3tpk5+38F9dNQLBAAtPwboNoLojyK9EWEzC+3cpsHnB9qqON0Lz1SiiNHsTAkjGbur0xthhw3vdBDectdlhjKaggwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPjyaqQ1ujbIo4bPFoihmFjY/ezH0MazgIvtSXdxyaU=;
 b=RI4fDDWThReGcj0dOJzbBf/+Wk1s5MBSfSoRuBrWdxnqUGVCkqOqQy+Tg1+Yxi2DY8haUl9CJP8s9B3Cxmo6Ps4BjiOrE+GquZClO+d+7Xb+AxTHZLnUGW8ZDviMn7/XrCthSqg7gWhZ4Tla0rUx5Gv6fFXHmy94GT2PllAolSneFpg0dtvDXTq7Ge2yW64AcUB+UvKgXslWajw+wEPx04er9w4FzqBf5r3SWgGUNvjnICIFGz4+3sXPRwpMvo1CLx01yywaS03mLsNUIh2eWEPo6RtN9pLRS5sIUBQk5UlWFlXKiBEYa8hUJncvqF4t5lz1U5irw+djrJY4LkHNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPjyaqQ1ujbIo4bPFoihmFjY/ezH0MazgIvtSXdxyaU=;
 b=f8iGLBoeeS3cdW9FUpnzNXrc04ANWSLENNlzK1ecnPbyo9HuRww4fC+oGqpGavJ6652roNMXcZkZhGib/FqnEBwo7TOdBCqeQx2bEhl+rf3ZhIweS/MJ4WLFeu69kvIEdwiJXSuNhsvNFXVfZ1Zcp4b8arcwTI1pyJ4tTBTRNFo=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (2603:10b6:610:2c::22)
 by CH2PR12MB3893.namprd12.prod.outlook.com (2603:10b6:610:21::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 14:15:39 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 14:15:39 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: honor the BACO setting from VBIOS
Thread-Topic: [PATCH] drm/amd/powerplay: honor the BACO setting from VBIOS
Thread-Index: AQHV8f2UafNhkB1I8Ue7YGYxZxAKt6g4eqaB
Date: Wed, 4 Mar 2020 14:15:39 +0000
Message-ID: <CH2PR12MB3912139F34120236A93B45F0F7E50@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <20200304081807.466-1-evan.quan@amd.com>
In-Reply-To: <20200304081807.466-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-04T14:15:39.182Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cee659e6-552a-4c88-c6c6-08d7c046845e
x-ms-traffictypediagnostic: CH2PR12MB3893:|CH2PR12MB3893:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB389311FCF75E8A686A77C9C7F7E50@CH2PR12MB3893.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:519;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(189003)(199004)(6506007)(45080400002)(478600001)(966005)(110136005)(2906002)(316002)(86362001)(7696005)(52536014)(66946007)(76116006)(5660300002)(186003)(53546011)(26005)(55016002)(71200400001)(33656002)(66446008)(81166006)(19627405001)(66476007)(66556008)(64756008)(8936002)(9686003)(8676002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3893;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n5lYKpvA6O4Q7fDgaGYlG17dxKWj/pFmUuQfyfqupvmGrl9wI6XaXuSNY/jpxdivelF3WemvoxjCe9GcNFUdFETTEuroB/+eKIWREI9ZBOHNeEmcbzzp4QdjAu/ND+vOHxRc/8AyFz86ia7aKyOdjLRp37BDIBq6an0wQfKi3NG81pcfd3dY9/UkW6ImjODM9oTpvxeeA7RgHJ6xM5+Fb8kEeaKm8oVEStDdc0YeitBYJHORjscq8RZz/CFvM6oJqM0zMx9LGLpRwylx3rabYUNBOUCJGWVnJW+gG14qwi3t8ciag0iJ84CX2hPR2E0K+Iphl5xYM8sGq5sQLPcgW+dtfb5XFXTllmzjpsrnKrmD2VqNjeCA33ttXq4OtyNn6asTXzphBkPYrkUL1DbMAT/sO/Z8Fc34PJYvsnNioh8usAwd6oHLdaGj/kqclKfp2nWEp02lwCoL66LvrRBliCj0ayLvnOv2y/YgDcK7oxs=
x-ms-exchange-antispam-messagedata: SDVAmqLrudV4iuztJ6euVxbbdhUzjlg6IVOrfo+cirwyZYcxM1dRw6q0dW/Pl2fMpT7809qnP9TwwdGrCeR9+mgL55dN0hhrp2ZUbJxiivVWbPcgICWmRV7ngkJI6xyuxkbPRo22su21IYnvO9ItAg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee659e6-552a-4c88-c6c6-08d7c046845e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 14:15:39.5982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9qSaZONazI+9+rgf88y1A4MxQZgww01AGbjCtRtVQbIXEFIEFcwCt1lUOheK/oOZBxsQQCZnbJ2eQMBdaCF4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3893
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
Content-Type: multipart/mixed; boundary="===============1655435939=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1655435939==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB3912139F34120236A93B45F0F7E50CH2PR12MB3912namp_"

--_000_CH2PR12MB3912139F34120236A93B45F0F7E50CH2PR12MB3912namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Evan Qua=
n <evan.quan@amd.com>
Sent: Wednesday, March 4, 2020 3:18 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/powerplay: honor the BACO setting from VBIOS

Should not enable BACO always on Vega20. That will
break the VBIOS setting.

Change-Id: I2609fc3f86dc785d385d9320574446810b5b693d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 08b6ba39a6d7..eed4da1131d1 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -182,9 +182,6 @@ static int vega20_set_features_platform_caps(struct pp_=
hwmgr *hwmgr)
         phm_cap_set(hwmgr->platform_descriptor.platformCaps,
                         PHM_PlatformCaps_TablelessHardwareInterface);

-       phm_cap_set(hwmgr->platform_descriptor.platformCaps,
-                       PHM_PlatformCaps_BACO);
-
         phm_cap_set(hwmgr->platform_descriptor.platformCaps,
                         PHM_PlatformCaps_EnableSMU7ThermalManagement);

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C767116f089aa41e6365108d7c014a10a%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637189067484709745&amp;sdata=3D3n6MKnuioG1XD9ACSC8=
nVCyBbNsSUJCnqkzUdj3sLqo%3D&amp;reserved=3D0

--_000_CH2PR12MB3912139F34120236A93B45F0F7E50CH2PR12MB3912namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Wednesday, March 4, 2020 3:18 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: honor the BACO setting from VBIO=
S</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Should not enable BACO always on Vega20. That will=
<br>
break the VBIOS setting.<br>
<br>
Change-Id: I2609fc3f86dc785d385d9320574446810b5b693d<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 3 ---<br>
&nbsp;1 file changed, 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
index 08b6ba39a6d7..eed4da1131d1 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
@@ -182,9 &#43;182,6 @@ static int vega20_set_features_platform_caps(struct=
 pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_cap_set(hwmgr-&gt;plat=
form_descriptor.platformCaps,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_P=
latformCaps_TablelessHardwareInterface);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_cap_set(hwmgr-&gt;platform_descri=
ptor.platformCaps,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_PlatformCaps=
_BACO);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_cap_set(hwmgr-&gt;plat=
form_descriptor.platformCaps,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_P=
latformCaps_EnableSMU7ThermalManagement);<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C767116f089aa41e6365108d7c014a10a%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637189067484709745&amp;amp;sdata=3D=
3n6MKnuioG1XD9ACSC8nVCyBbNsSUJCnqkzUdj3sLqo%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C767116f089aa41e6365108d7c014a10a%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637189067484709745&amp;amp;sdata=3D3n6MKnuioG1XD9ACS=
C8nVCyBbNsSUJCnqkzUdj3sLqo%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB3912139F34120236A93B45F0F7E50CH2PR12MB3912namp_--

--===============1655435939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1655435939==--
