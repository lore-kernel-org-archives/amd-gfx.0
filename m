Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8DEC433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 14:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B1B520773
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 14:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SPvH/2ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1B520773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B9B6E405;
	Wed,  2 Sep 2020 14:21:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91A606E916
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 14:21:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPRriS4yiRy9mKrX1BAIyvWbdmo7ITTHz5EQ3qHVQLRfrOnA2PcQ++tUSt+6xyUqztNnqAl7ZfyYn9LNWWzdwYhpK04QjHuy7hePo+C4vjzt2WTSR2DVKlWRRIB9tQnadBwQ9XG13U6owtAG+5fiyfebgUv53V7UVgb42ThLfF2C54lyeMRtNiX5Sue/As7QD1iIyJE7HkyT4P7dvkkAxoFJc65L4Gi6HnGztb1mQoUvlD+O7T+h+zMB9XN1034HdpRVq7PGo1dbWNcJB2ro0RijPAhisySnHMA/FLODR94k+vALtgoufgzK7auJaoNJ85g5lAh/ozFirsseHuPNpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9NXCXBEKifqVR6gl61rKF4ZMl4TRzah9/8abK2zTs8=;
 b=AUtbt1caV4Si1uBwOH6XjZe0wLwm/okrvG5rMZKUshMoSFoukTAJokMUGUWN85aWeXd/YX4+bX3rgpgOqPbk9E9n239GP8PcpapF+7iNZWIsTg2OW6EDxkxotsmqqQbQU4iXj2833usgiBdu0EQ3PIimQq8F/rtF1Uru2uHi0qIxI8Pm7cTRx7/ImjwZpUqiOnTsHFjzfhESTdmx9FHgn6g/jrh7CATFD622Of78Il9hET0F8Xk0iYb481L/lx0eAKe2icfDX8DksJeoxzCBqvNSkvRG6x0DlVZnLQnFlWOWZ0PB9lZcD/ZOQdQ9h51wlQqR5P5XAcm/2jjVi+bUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9NXCXBEKifqVR6gl61rKF4ZMl4TRzah9/8abK2zTs8=;
 b=SPvH/2ck07gRcqCnFloOIefPLZ18x+FLKgwzW0mLeWZ71xwEPorZM1eGeDIaLLTBzDM5HNm9yAQo6eu34JlMjEiV0BY/ZSfUim6duxOYw5w7XiuHh0ok0bg26ObIGelNHF74SYpmx/QqJ+snQi74bCiU7zumHuXnrNBMXw+61ms=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3805.namprd12.prod.outlook.com (2603:10b6:208:15a::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 14:21:46 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 14:21:46 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix max_entries calculation v2
Thread-Topic: [PATCH] drm/amdgpu: fix max_entries calculation v2
Thread-Index: AQHWgTIYFKrQmE7lf022J5/xAW2/HalVZkoT
Date: Wed, 2 Sep 2020 14:21:46 +0000
Message-ID: <MN2PR12MB44888E78A7F651701DCCDE7BF72F0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200902140512.2343-1-christian.koenig@amd.com>
In-Reply-To: <20200902140512.2343-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-02T14:21:45.567Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25c1bcc5-17bf-493b-d068-08d84f4b860e
x-ms-traffictypediagnostic: MN2PR12MB3805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB380509E27B6DD83F5E261E4EF72F0@MN2PR12MB3805.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z3+26X4gwiigX3N6FQ8bNT7CUWH7SP8VuUnfGcIn+8O5Jpda1GJASlrIg9I9m/4q1lB/TSRzf0N79jS5Y1+bfiEOPCppF0AzWv4UklIbGFJzfg36dlXnTk2p1xyTA7ZjYsLJhlkLWqjDQt9EBzGzXJovlkZKqmGNeMOskCtEp/a+1omaVh3nMuPn5kgIIHEBrRbkvkyGCQRaDoADXLbPv0yQWrduN6zRY2Vfuq1B/p5Opu3J8Z1A7+BjzbV04EzPjJ2QQnJuXARblvrl9WkLQl9LIhHqmzO5PMpngySDQDU4avKOSoBjQ1Z+WOi0+Ay8y4WJbbZ9oQe7b/Dyz5/45xD6JrOvxGR8nqIQOCuo3Bg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(478600001)(76116006)(6506007)(64756008)(66476007)(66946007)(66446008)(45080400002)(53546011)(7696005)(316002)(19627405001)(86362001)(2906002)(186003)(83380400001)(5660300002)(66556008)(26005)(52536014)(966005)(9686003)(71200400001)(166002)(33656002)(8936002)(8676002)(66574015)(55016002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: yyKqJ6TcFWDlUtnakFsCxTvOIq9mH5QnfOLNDZVT45zWVt1p0twLKwS4bwoi+fzZTrQLIPa8fvjDNhEUdc30T0lgQPC1DaV2h7B+aPEfXS5ZmUFJaAh9uwXyAm3FVyZKRhf/Aqj6hzgJRaTPDq8kxBtx7UhVvJYbDeknkhwV23WYcHXgSxSa3ffZynN/B20E+KZKpfMntdhKC+siq/tCwulQxLUyXhjfYs/z7+xUu8DKC/WXHSEEk0UtNr866IEki00bGvy+Ju5onGgPaxwQBvsSaWy/5Kyi3X6r0+bPAsDqaglsRRq3wDcUKIKH0GDRVI36n4Azr1YK8f+2uvuFbl2wKw5yOTQMLA1aVX1lODjJQfW0kiRa0Am5FHs+r1/2IHnxaOQWNn8SsqcvkMjQWSo7s9eEJAx4NZT2wqK+bOG3yP+bQ3CAATV9mdq67Clli/MkRIX5iGjGGS2esdKTEakcPRybyoilbl4+YcsvYA0EZaj+Bgsj6zblhq64nod1TY6rLN+ZHd8Z+FAqALdz6wTR9aRm4H96M8RnPBrOqmyZ+s3w8QPw48xSSvdGU78jn568sYDX/wCyui4039hPJYRFLlnELyeAFjQaHL4qx0wz3DkpK77Q1J16Ay52NVNw8W4dVaKciCV0HV87VWcEuA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c1bcc5-17bf-493b-d068-08d84f4b860e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 14:21:46.1701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lctgmDiyCXlerGW7MD2jnMgwXZQHU259NdaIR7JjutYnvRZSenTYhAHlBb4aKahFGd3oDZKIkJkNLyM+oW6dJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3805
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
Content-Type: multipart/mixed; boundary="===============1580067173=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1580067173==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44888E78A7F651701DCCDE7BF72F0MN2PR12MB4488namp_"

--_000_MN2PR12MB44888E78A7F651701DCCDE7BF72F0MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Wednesday, September 2, 2020 10:05 AM
To: Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix max_entries calculation v2

Calculate the correct value for max_entries or we might run after the
page_address array.

v2: Xinhui pointed out we don't need the shift

Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
Fixes: 1e691e244487 drm/amdgpu: stop allocating dummy GTT nodes
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index 8bc2253939be..be886bdca5c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1697,7 +1697,7 @@ static int amdgpu_vm_bo_split_mapping(struct amdgpu_d=
evice *adev,
                                 AMDGPU_GPU_PAGES_IN_CPU_PAGE;
                 } else {
                         addr =3D 0;
-                       max_entries =3D S64_MAX;
+                       max_entries =3D mapping->last - mapping->start + 1;
                 }

                 if (pages_addr) {
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Ce5239f6d94a9480e27e008d84f4939b5%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637346523216694548&amp;sdata=3DOF7UX%2FLbWPJXkymt1=
QsdVVrQCZxI2Avj%2BBv1HYWPzxo%3D&amp;reserved=3D0

--_000_MN2PR12MB44888E78A7F651701DCCDE7BF72F0MN2PR12MB4488namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Wednesday, September 2, 2020 10:05 AM<br>
<b>To:</b> Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix max_entries calculation v2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Calculate the correct value for max_entries or we =
might run after the<br>
page_address array.<br>
<br>
v2: Xinhui pointed out we don't need the shift<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
Fixes: 1e691e244487 drm/amdgpu: stop allocating dummy GTT nodes<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c<br>
index 8bc2253939be..be886bdca5c6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
@@ -1697,7 +1697,7 @@ static int amdgpu_vm_bo_split_mapping(struct amdgpu_d=
evice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GPU_PAGES_IN_CPU_PAGE;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr =
=3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_entries =3D =
S64_MAX;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_entries =3D =
mapping-&gt;last - mapping-&gt;start + 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (pages_addr) {<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Ce5239f6d94a9480e27e008d84f4939b5%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637346523216694548&amp;amp;sdata=3D=
OF7UX%2FLbWPJXkymt1QsdVVrQCZxI2Avj%2BBv1HYWPzxo%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7Ce5239f6d94a9480e27e008d84f4939b5%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637346523216694548&amp;amp;sdata=3DOF7UX%2FLbWPJ=
Xkymt1QsdVVrQCZxI2Avj%2BBv1HYWPzxo%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44888E78A7F651701DCCDE7BF72F0MN2PR12MB4488namp_--

--===============1580067173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1580067173==--
