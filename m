Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06492C10DCE
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 14:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD0F20770
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 14:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aUYrYhMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD0F20770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7583D6E2A0;
	Wed, 18 Mar 2020 14:36:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB8556E2A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 14:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gM9kUulLCMHXf6Bgxl8WmbA/LjkCZ+C/dKr54gKSBWE+3IMXvJUIT5u+8JUT/vZ+TQFsUDdLoc7QPnZwlCaHbxR6DPbnt//VcV+alFD5XPHbJUX4zweNeeWOMy2pp0t1C/JBapkO6oRldHWcgJtJnei6psQ2VsNwXTRX0rJ0/qM+Pl0wS7mDtP7CtCQOtpnBSZkEk4EBrpAm3Um+coImI7kYd8N1ISTprv9bvbBgDWpSaY0kO6mrRUhl4HgnVNAcN8d1wbT7uQ3W530US1iqbVYKJ2I/GFdfXW9+VbBz7bDE7c24IAk3VLvqf8gxRIZcOp0x5dUjC4q3ht8/lm/XUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCjWCn3DlnCI98a5QNXEWjKm4OK8hHvDxW0bcQCUGyA=;
 b=J8YQR4A1sbrwSCY21lZyr0dGXa+Wu2P8UQl0G/6rw12eStTd/AVrYEsKu2pa4hJ3K8VBngZXLXwCN/hIg0FoKS7udpqHCAuDL+VcwYRI1PWSuyogpRVqdY2Y0IHYMfOId8jI/5TwQh9sNyGm/+KNUKxoCHPw6DZLympFzV5sX8Y0JPVZ4WEhvmgtLrth6u3uhwHuv4MuVeMYmXfq6ipXxAVR2mWtX7xvh2mL+Xtb3m7h7GbVeJj0H2HrIcSGGv1ZhMADhY4k/1RwsO++HlmOq4lx3pETQgHl3bfoxb07k4df0kVt4wdLP6wmdRyVS7f5zUYdwCxqMDyG3eLfH4LF7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCjWCn3DlnCI98a5QNXEWjKm4OK8hHvDxW0bcQCUGyA=;
 b=aUYrYhMvspCgdMNSa4PgF5+bh4v5+VQjGY4R27eH5kslTd3IUO3fuRa1Mr0H83k/VIG7rL5RLvryufPrBrhCPGh7MhVi0bBYlmFKizgOCVTWKDsOLcufLPQweM+vdCRD8uHSwdOHQFI2c59adsXSCQyH9n31NPBYpd7+aWctYDw=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Wed, 18 Mar
 2020 14:36:50 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 14:36:50 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH ] amd/powerplay: arcturus baco reset disable all features
Thread-Topic: [PATCH ] amd/powerplay: arcturus baco reset disable all features
Thread-Index: AdX9LuOx8zN4SVpcTCq1frau/F96SQAA6saB
Date: Wed, 18 Mar 2020 14:36:50 +0000
Message-ID: <MN2PR12MB44888E32CE4F39730B1B27ECF7F70@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <MN2PR12MB3663E140D2D046113B5FC4CAFBF70@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3663E140D2D046113B5FC4CAFBF70@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-18T14:36:49.895Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4195b36a-1677-4b9a-9ff6-08d7cb49cbb3
x-ms-traffictypediagnostic: MN2PR12MB4208:|MN2PR12MB4208:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42080A9A25A433F6C47E0A62F7F70@MN2PR12MB4208.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(199004)(7696005)(4744005)(186003)(6636002)(33656002)(19627405001)(19627235002)(66446008)(26005)(66476007)(64756008)(76116006)(66946007)(66556008)(316002)(8676002)(71200400001)(81166006)(81156014)(52536014)(8936002)(110136005)(478600001)(53546011)(5660300002)(86362001)(55016002)(2906002)(9686003)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4208;
 H:MN2PR12MB4488.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZWRmTb4oIoKXXH8iWGBE9/tqcKg9ynHfccPXloIUPlNDDwkSNQLBNGIP6AmRNL/s3vz9uO16SMEmTzm5hb0TIoVJrg8H1wNA1VFy7vivJE5pWT7wZgXVZzNOyFS71ISMdhjXqRsfgaa5f30KUY1XaftVa2iuydSDZv5PphSy0iMtNsRx21/BXzvXzk7JLwdwg/6EeqT+TQVrZasuxGUvSH/OEIh1qNCSxvj405E7xSphXQTXZxdeXGS1TvQhYMohAOvAGNDo+ek24E+gllYzoXVeig23WQH1aDD4Ckfp6hnTswcpxAmSTDv4wD6IdJHGO3vsYEabYPywJ8JPi1tdnFhZ3bpycSG4TSfZxbnhdqVzGUVpyu9xZIkd/cNJLbdVpnjOWwLuy5grFYVhrCMfO3Zo15+qiBctj9W+5JHAlaFdnxGhvr6cp9vf2QxAL4KS
x-ms-exchange-antispam-messagedata: 8CPJ3WEyJrjI9VlJbG2N92NsODTztAgObMMDJPcfUuONyi9jqaiY/8hx9eDpW3SM1qCFbo+k/9qSq8ctbKQFztyiA40p/Ei5itF3esdPXx6lhxa1WL0pc+HG5lkb8gyDkpq+TJNGD0r07yZv/drmjg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4195b36a-1677-4b9a-9ff6-08d7cb49cbb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 14:36:50.5229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qA/g98RxZE8ZXDg1hqVtk2cDLiOXQRWbHWX8Q7YfMWwQsiUgPPSiop81wqBxhUSGWYIJaMlfiV1GsypnnkQlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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
Content-Type: multipart/mixed; boundary="===============0706357207=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0706357207==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44888E32CE4F39730B1B27ECF7F70MN2PR12MB4488namp_"

--_000_MN2PR12MB44888E32CE4F39730B1B27ECF7F70MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Clements=
, John <John.Clements@amd.com>
Sent: Wednesday, March 18, 2020 10:11 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Zhang, H=
awking <Hawking.Zhang@amd.com>
Subject: [PATCH ] amd/powerplay: arcturus baco reset disable all features


[AMD Official Use Only - Internal Distribution Only]


Submitting patch for review to issue smu cmd disable all features upon baco=
 entry sequence in arcturus.



This helps resolve issue with I2C controller not being disengaged properly =
on GPU reset affecting RAS eeprom stability on re-entry

--_000_MN2PR12MB44888E32CE4F39730B1B27ECF7F70MN2PR12MB4488namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Clements, John &lt;John.Cleme=
nts@amd.com&gt;<br>
<b>Sent:</b> Wednesday, March 18, 2020 10:11 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH ] amd/powerplay: arcturus baco reset disable all fea=
tures</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle17
	{font-family:"Calibri",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-family:"Calibri",sans-serif}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<p class=3D"x_msipheadera92e061b" align=3D"Left" style=3D"margin:0"><span s=
tyle=3D"font-size:10.0pt; font-family:Arial; color:#0078D7">[AMD Official U=
se Only - Internal Distribution Only]</span></p>
<br>
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal">Submitting patch for review to issue smu cmd disab=
le all features upon baco entry sequence in arcturus.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">This helps resolve issue with I2C controller not b=
eing disengaged properly on GPU reset affecting RAS eeprom stability on re-=
entry</p>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB44888E32CE4F39730B1B27ECF7F70MN2PR12MB4488namp_--

--===============0706357207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0706357207==--
