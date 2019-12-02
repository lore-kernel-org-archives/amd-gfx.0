Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125EEC432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 12:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3203214AF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 12:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3203214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 937DD6E1B2;
	Mon,  2 Dec 2019 12:02:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770059.outbound.protection.outlook.com [40.107.77.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52F776E1B2
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 12:02:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQ4Wi2cTCotGNUVlJWiU0uDzOsXTEiHawiwlArTpL1jOX7ZuVion2Q8NyK73f6lKbSiZRgb9sAs8T5zRM/uj1smNv50xizd5sM/iMgVDC+Suzt/HPb1OvWCEGjNDN48fa2zXOP2Vf1o0pAS4C+GLfAMLyfmeENbKScdMS3vyGx9eNl8uMX1zKxVt8yOlSP9Wx3fwi/HHoiQkavm+xq0hmdXT0d/Q49f6mOWT+vMcWxvLp02dNUUF+smy0FUMuH/9mqEuHvwt8kDxHoOB1APqpfcS80KAZzY4n9dZerkzhsr18TtkLxfl0HmfFM8CRH4sZAWOm7Sdh3aPqyM9wcXbWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvz4lD2EfuzMTb2xPkz0XmAhAPW3KgkgADPeROy6mCc=;
 b=bUvmG4Kl7piJ8yi+ezkpuL9sU327WhOE+k4urvkuK21VxELiS6cSEZMCMwtDRKJLrJqa+ThmTdKPm105oL98nGQ64PasHwDV/owZSkcQhEeXMF+6mVWMOG/kxAP/hPFig4Q9iN2/Wp43ivzTTD2xDicoZIC5Vxp6MO2+2nZhie70BmPpg2uxCyzXT2WrZLzhEUi0BL+VeEAeXD3vlW8RpARutJFxMdS8K+ShvYCWBO+OTWcMOg9RaXRFOrLABzCR5b0Ma6mN/kvopHzepTUkz+WZs72mTzjIv5R5ecXqks06gPc4GhZBfBTTTjXYh23+su3X+XUU0WOq/D44e1NEGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3296.namprd12.prod.outlook.com (20.179.80.139) by
 MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 12:02:17 +0000
Received: from MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::b02a:3af3:a3c2:61f3]) by MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::b02a:3af3:a3c2:61f3%6]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 12:02:17 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] amd/amdgpu/sriov swSMU disable for sriov
Thread-Topic: [PATCH] amd/amdgpu/sriov swSMU disable for sriov
Thread-Index: AQHVqQBuP5tDwITY5Uat6nz6qptUp6emvoN8
Date: Mon, 2 Dec 2019 12:02:16 +0000
Message-ID: <MN2PR12MB3296CF41EBCB1158B79888D6A2430@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20191202110519.3504-1-Jack.Zhang1@amd.com>
In-Reply-To: <20191202110519.3504-1-Jack.Zhang1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-02T12:02:16.528Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c0ee881a-f22d-4a40-c659-08d7771f79ff
x-ms-traffictypediagnostic: MN2PR12MB3838:|MN2PR12MB3838:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB38380CF0FC0E9B6E9E67F166A2430@MN2PR12MB3838.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(189003)(199004)(8936002)(52536014)(81166006)(76176011)(9686003)(6436002)(236005)(54896002)(6306002)(6246003)(45080400002)(99286004)(102836004)(186003)(966005)(6506007)(55016002)(26005)(110136005)(446003)(478600001)(105004)(25786009)(11346002)(74316002)(33656002)(606006)(7696005)(81156014)(8676002)(53546011)(3846002)(229853002)(316002)(19627405001)(91956017)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(7736002)(66066001)(6116002)(14454004)(2906002)(5660300002)(256004)(14444005)(2501003)(71190400001)(71200400001)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3838;
 H:MN2PR12MB3296.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bn5pOL4uIzZtJdla0g+NYd1uEC5eSfECQfjRDxVOwg+Cw2Zhs5P35+E5JYcoDT4dixJs7361QypMegfoCG+fPqp9VjH7p0uMGtG2VYowNjs8gLhMf7xjepOj8tXSpdfO/f/DqwawDxTwviifluvMKvwyao+JXGxPxsnSalSUxfORIdXhO9ZLvKQ0HWyibvyayASRK02HU4OXxA0nbbuAOeBkc2/16Tr9Qa8x24s8KPzNVj9xd2nsOewycbaP2Z7EjFfORhGHGCW+ZIdOBdtVsATfJQHi/1rTSjFXNhaenct9lRPmKG2dt4sEdm8sQg8T3jKkGEdVAK+6vuNxoFJukykT5g6BetLz/X40jwPmzNWNEHH24dbdjl1BGwc8iXK7tv995nwkUP6wznREg/CkNB9Vnxn1OuVjqdz005LeYbbv54zS+siy4E0T0G1chIk7wnp7N7waz5UNIjMSGVK4FX8Xx9bk5UOnGZPr/wPysxQ=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ee881a-f22d-4a40-c659-08d7771f79ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 12:02:16.9452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LgvJIH8VI7pxlnFXeAFyH0uCLgpfMbTcY3yZjLeBbzHM50CC9xRht8fq4kE2zNA6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3838
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvz4lD2EfuzMTb2xPkz0XmAhAPW3KgkgADPeROy6mCc=;
 b=vJ8BXEQl2O1wN/1px0ZWcDI+FZFmkeUyFBpu7Za3CM2nZx5Dqy59qUYM4UYqXoXkwtb2VUBUsietgbZF4fXq8/yZBJDIrIaLZhSq6jLnGgkCOnctTyZ1l5k05HqCX6JZqbz/L/ckuKYZ5ELh7m1Xe33BrF4mWp0F9VAbNugWGSU=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
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
Content-Type: multipart/mixed; boundary="===============1882384864=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1882384864==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296CF41EBCB1158B79888D6A2430MN2PR12MB3296namp_"

--_000_MN2PR12MB3296CF41EBCB1158B79888D6A2430MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
But it's better to optimize the flow of control in is_support_sw_smu()

Best Regards,
Kevin


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jack Zha=
ng <Jack.Zhang1@amd.com>
Sent: Monday, December 2, 2019 7:05 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: [PATCH] amd/amdgpu/sriov swSMU disable for sriov

For boards greater than ARCTURUS, and under sriov platform,
swSMU is not supported because smu ip block is commented at
guest driver.

Generally for sriov, initialization of smu is moved to host driver.
Thus, smu sw_init and hw_init will not be executed at guest driver.

Without sw structure being initialized in guest driver, swSMU cannot
declare to be supported.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 36001a4..0b8a53b 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -531,7 +531,10 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
         if (adev->asic_type =3D=3D CHIP_VEGA20)
                 return (amdgpu_dpm =3D=3D 2) ? true : false;
         else if (adev->asic_type >=3D CHIP_ARCTURUS)
-               return true;
+               if (amdgpu_sriov_vf(adev))
+                       return false;
+               else
+                       return true;
         else
                 return false;
 }
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7Cc80551b2c7d9426a7d5e08d777178bb9%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637108815398674653&amp;sdata=3D5dFralarJqC8%2FkwhQWCjsU8=
b5UQDILN2p6HafXGi0TM%3D&amp;reserved=3D0

--_000_MN2PR12MB3296CF41EBCB1158B79888D6A2430MN2PR12MB3296namp_
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
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif">
<span style=3D"margin: 0px; font-family: &quot;segoe ui&quot;, &quot;segoe =
ui web (west european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmac=
systemfont, roboto, &quot;helvetica neue&quot;, sans-serif; color: rgb(50, =
49, 48); background-color: rgba(0, 0, 0, 0)">Reviewed-by: Kevin Wang &lt;ke=
vin1.wang@amd.com&gt;</span></div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif">
<span style=3D"margin: 0px; font-family: &quot;segoe ui&quot;, &quot;segoe =
ui web (west european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmac=
systemfont, roboto, &quot;helvetica neue&quot;, sans-serif; color: rgb(50, =
49, 48); background-color: rgba(0, 0, 0, 0)">But it's better to optimize th=
e
 flow of control in&nbsp;<span style=3D"font-size: 14.6667px; background-co=
lor: rgb(255, 255, 255); display: inline !important">is_support_sw_smu()&nb=
sp;</span></span><br>
</div>
<div style=3D"margin: 0px; font-family: &quot;Segoe UI&quot;, &quot;Segoe U=
I Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacS=
ystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; color: rgb(50, 4=
9, 48)">
<br>
</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif">
<span style=3D"margin: 0px; font-family: &quot;segoe ui&quot;, &quot;segoe =
ui web (west european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmac=
systemfont, roboto, &quot;helvetica neue&quot;, sans-serif; color: rgb(50, =
49, 48); background-color: rgba(0, 0, 0, 0)">Best Regards,</span></div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif">
<span style=3D"margin: 0px; font-family: &quot;segoe ui&quot;, &quot;segoe =
ui web (west european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmac=
systemfont, roboto, &quot;helvetica neue&quot;, sans-serif; color: rgb(50, =
49, 48); background-color: rgba(0, 0, 0, 0)">Kevin</span></div>
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Jack Zhang &lt;Jack.Zhang1@am=
d.com&gt;<br>
<b>Sent:</b> Monday, December 2, 2019 7:05 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Jack (Jian) &lt;Jack.Zhang1@amd.com&gt;<br>
<b>Subject:</b> [PATCH] amd/amdgpu/sriov swSMU disable for sriov</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">For boards greater than ARCTURUS, and under sriov =
platform,<br>
swSMU is not supported because smu ip block is commented at<br>
guest driver.<br>
<br>
Generally for sriov, initialization of smu is moved to host driver.<br>
Thus, smu sw_init and hw_init will not be executed at guest driver.<br>
<br>
Without sw structure being initialized in guest driver, swSMU cannot<br>
declare to be supported.<br>
<br>
Signed-off-by: Jack Zhang &lt;Jack.Zhang1@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 5 &#43;&#43;&#43;&#43;-<=
br>
&nbsp;1 file changed, 4 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 36001a4..0b8a53b 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -531,7 &#43;531,10 @@ bool is_support_sw_smu(struct amdgpu_device *adev)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=
=3D CHIP_VEGA20)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return (amdgpu_dpm =3D=3D 2) ? true : false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;asic_typ=
e &gt;=3D CHIP_ARCTURUS)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;}<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7Cc80551b2c7d9426a7d5e08d777178bb9%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637108815398674653&amp;amp;sdata=3D5dFral=
arJqC8%2FkwhQWCjsU8b5UQDILN2p6HafXGi0TM%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40=
amd.com%7Cc80551b2c7d9426a7d5e08d777178bb9%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637108815398674653&amp;amp;sdata=3D5dFralarJqC8%2FkwhQWCjsU8b5=
UQDILN2p6HafXGi0TM%3D&amp;amp;reserved=3D0</a></div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3296CF41EBCB1158B79888D6A2430MN2PR12MB3296namp_--

--===============1882384864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1882384864==--
