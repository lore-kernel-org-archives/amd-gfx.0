Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B23AC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 03:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A61A207D8
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 03:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q4Gqf9VH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A61A207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB6DD89F19;
	Fri, 22 May 2020 03:38:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33E9489F19
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 03:38:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjKdjBzoXp86C6rEbbWi3M3fbrlNSrzoNz9vNmdRqi/hZBoWJAOomgo/h5DVUVger1hCWtmyn9mA2DU2TBV5CIYFp3Tg3SJML81jU6AvU2M1HKfZRx382EienOcJXLtyJWI2QpQ9XSjoO5bWf51Mh7n2Oa7jY2/SdKB5oGpYwgQ1qzoeeMxGuGHxQuXxz9jcE+phNYTHksPZ6ty8XJgAXKPU8daOmxMiBc2s7PRtKvElUgdQTsEghXnQFVOSPlBzoc/dmr+yaFAhioS8d/Jm9o9gZADhxCxL8ipNAZ3fbh8XJznmt8HqRyYsSUd5RqHPBikBd1yKwfO+DRf1eLbe1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkIIgI4hWcoSZ9XKLfanuipiwBKRP9mUN52xZVOVHPg=;
 b=GZyYHteT7YskKJ102CQemZafUuqHYm/5DQWPEB+SpKLOHlTIP0JqdXp2/HKzBJHOpA0t/oCkuqRA1jm/cqqcAygI3QZTKl+JEb1aWY/sXalovuMihBi+HcJWpbM+F6eHUKLtHLhXrXVkU3v1+EzYmKpFUk1uSgz1MBwBYXfOb/INDyCegppKlcFDk/rzyazS201JUbRNXnCfz/1ak2JSygBsejsjt9cuJSAxNazxxCROB1CF463XbJqp2BKIQ4Nvz/CuqEwGNTMcMwjndYt/rdVi+pB623MsVBax2x2UNrVd80X8GRMap2c4Oy5K1j+qLqHmeP/GjyHOWP4VAhAY6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkIIgI4hWcoSZ9XKLfanuipiwBKRP9mUN52xZVOVHPg=;
 b=q4Gqf9VHbluAJBurHiKBYRNthXU6oiZ1SHHsgwN9qjf07J9H+SE0Wu3s6/fazDkHJPdIdHyAjrFYeYv71TdlyZzdB5jJBnXugBtVcFlyGUObDS/lhyqBJJwwGXsY8tdkEWSy5zudRBPBl6fRPYR2Jd2ZE1FYmtaVnQIYhgpaddY=
Received: from BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Fri, 22 May
 2020 03:38:07 +0000
Received: from BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c]) by BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c%2]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 03:38:06 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 1/3] Revert "drm/amdgpu: off by one in
 amdgpu_device_attr_create_groups() error handling"
Thread-Topic: [PATCH 1/3] Revert "drm/amdgpu: off by one in
 amdgpu_device_attr_create_groups() error handling"
Thread-Index: AQHWL63UCNxQDodY3EWyETjCXrP5aaizdK1wgAAASPQ=
Date: Fri, 22 May 2020 03:38:06 +0000
Message-ID: <BY5PR12MB40685AD6EEC359E5AAFCABFDA2B40@BY5PR12MB4068.namprd12.prod.outlook.com>
References: <20200521202308.1996496-1-alexander.deucher@amd.com>,
 <CY4PR1201MB01362D39E86460165D3C4272EFB40@CY4PR1201MB0136.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR1201MB01362D39E86460165D3C4272EFB40@CY4PR1201MB0136.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-22T03:38:10.809Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 067abbd5-5fc0-4c9e-05ba-08d7fe018a77
x-ms-traffictypediagnostic: BY5PR12MB4081:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB408138B8137D6B21FA941E1FA2B40@BY5PR12MB4081.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:61;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 66cx6hehKd9gXYj0xOI1fOy1Zl/0u0/mlWSpmLJnBd3gUvCk2kWYQh6HqcLJFrRxzRz3VFUQ61R9c/tmFSQ99f7WNLdyTE2TpfOFbPOyoHBp9qW+GFXXSCVeeqxWPE6CA8nODJphgb4yM+X/dr2QwA7wE3ss8mw6ZUUzwR02Jwnk3zqatLbcRJk5GewYk7cSoXhchi2FLgZDBulvqOgplVvnRhPC1qjzKlePOd58Oa0gDJ55LDM+5pWLEk9GFHLZjtl8bY1iR7B2pM5Dtw2R96MNE/n4WEuh5aSFAEiZwlmtitGFERepCoXPY7fzmEdwJ3Lea61zef1mFMNVv8TAwf3s1GsyzHSasamThuVSJ0o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4068.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(186003)(8676002)(9686003)(53546011)(2906002)(6636002)(26005)(6506007)(55016002)(316002)(8936002)(52536014)(110136005)(966005)(478600001)(64756008)(166002)(4326008)(66476007)(91956017)(5660300002)(86362001)(7696005)(66556008)(19627405001)(76116006)(66946007)(71200400001)(45080400002)(66446008)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ioalVXcneK+7wKBg31ZdUBpsYAgcFnHjXxvlODjZYpybuLhY48PQQNGJTx2Xao6Sz8S3qDckPuYTagmiCNC1r9vy3j1Xo6h01V3dcBDovxr79JCgK9PzsQGqNbnOgWyZV4b2Z4wtb9t1SqPMjDmmZgrKXzcJSLacFUrf4zsXf3FUmc2kNvNxZUFdaIF0tiJzJ/HZxDiYwA0O2HlcE93QwR2317XiLOZCgAkEdn0YpLPqp06g3LUkBXXTEhq1Y/G93rjRGissijU+RMJAmYIxbYjYS+0iH+1D/h+x4ajBH/cQLNZraoxaKGtzsJjflhIB1kAE3OySHjQArIG7vwjb3hiFu0uheig38xVkAX3x2DOGtj0Y7TGdosO8bI7JAo5yTZ1X03zCQdE3UMlvazWGDxDc8fT+B0uocFH6KTP1vWrFfaPdQr1FDSPs9U+wggOyHcx1/jfaXdcVzuf+H6V98DjedrE933Uca7iAGH2LM08VEvh/zIMKfQMFt8Nt9djv
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067abbd5-5fc0-4c9e-05ba-08d7fe018a77
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 03:38:06.4785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXdQq4yv6AwudB3wVtHY2Pfe8b5dIhPEn3zOyL+2VF4sjKaB0Ykop5MyhpdxXeOb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0330686655=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0330686655==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB40685AD6EEC359E5AAFCABFDA2B40BY5PR12MB4068namp_"

--_000_BY5PR12MB40685AD6EEC359E5AAFCABFDA2B40BY5PR12MB4068namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Series is:
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, May 22, 2020 4:23 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/3] Revert "drm/amdgpu: off by one in amdgpu_device_attr_c=
reate_groups() error handling"

This reverts commit b41d9df2b680b96913cc3ccf929252e2dce71b24.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index 2fc51f815eaa..72bbb8175b22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1843,8 +1843,9 @@ static int amdgpu_device_attr_create_groups(struct am=
dgpu_device *adev,
         return 0;

 failed:
-       while (i--)
+       for (; i > 0; i--) {
                 amdgpu_device_attr_remove(adev, &attrs[i]);
+       }

         return ret;
 }
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CLikun.Ga=
o%40amd.com%7C6bb02ce265514761907d08d7fdc4ce0c%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637256894700890419&amp;sdata=3DjiAa7VaiOak3oRjY4xd19fHlEnO=
Wi%2Fed66AXfwVdGUo%3D&amp;reserved=3D0

--_000_BY5PR12MB40685AD6EEC359E5AAFCABFDA2B40BY5PR12MB4068namp_
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
</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: black; background-color: rgb(255, 255, 255)">
<span style=3D"margin: 0px">Series</span><span>&nbsp;</span>is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
-----Original Message-----<br>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">From: amd-gfx &lt;amd-gfx-bounces@lists.freedeskto=
p.org&gt; On Behalf Of Alex Deucher<br>
Sent: Friday, May 22, 2020 4:23 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
Subject: [PATCH 1/3] Revert &quot;drm/amdgpu: off by one in amdgpu_device_a=
ttr_create_groups() error handling&quot;<br>
<br>
This reverts commit b41d9df2b680b96913cc3ccf929252e2dce71b24.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 3 &#43;&#43;-<br>
&nbsp;1 file changed, 2 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index 2fc51f815eaa..72bbb8175b22 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -1843,8 &#43;1843,9 @@ static int amdgpu_device_attr_create_groups(struc=
t amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;failed:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (i--)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (; i &gt; 0; i--) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_attr_remove(adev, &amp;attrs[i]);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
-- <br>
2.25.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CLikun.Gao%40amd.com%7C6bb02ce265514761907d08d7fdc4ce0c%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637256894700890419&amp;amp;sdata=3DjiAa7Vai=
Oak3oRjY4xd19fHlEnOWi%2Fed66AXfwVdGUo%3D&amp;amp;reserved=3D0">https://nam1=
1.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.o=
rg%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CLikun.Gao%40amd.=
com%7C6bb02ce265514761907d08d7fdc4ce0c%7C3dd8961fe4884e608e11a82d994e183d%7=
C0%7C0%7C637256894700890419&amp;amp;sdata=3DjiAa7VaiOak3oRjY4xd19fHlEnOWi%2=
Fed66AXfwVdGUo%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB40685AD6EEC359E5AAFCABFDA2B40BY5PR12MB4068namp_--

--===============0330686655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0330686655==--
