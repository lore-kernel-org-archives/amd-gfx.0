Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE4AC33C99
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 08:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3924207E0
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 08:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ssS0WQjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3924207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93B0C6E7E6;
	Tue,  7 Jan 2020 08:31:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A10466E7EF
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 08:31:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idGHISeUPuPYCouIipMaBegum+c1w/fxJx89LjY4ZdmQLXzSg9J4PKuIJ6RVAfx+lsOGaUbj558ZSrxHXtPrgbcXIeZFAVh6PWHGTLait+een7zONjZx/2ZNuuk+AXlU3HNUIWrELjt6FWdxZFIF54U/5s/xCPAo6l7umk/QzdBAZRqfwC/JTWm+QveXMfNVPl4mbpPAgfpFJTNa1skbyra2bF9sExP1VU1QuBcZWazSxo/zVrtlz9LmricdzcXQaaZfWIFSKl0MnAxHcWKg4YJdzDcaqKAhd6UUGjbbcofC/nX5jX51iysdSYziloSOorWG/LF+UVJbYoU0a1AYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niC12id+n8er2IEgBUGN3dOvYdavW3VQ9Z5xFtx0pOM=;
 b=PzhfQ1f48iB75M54OdEc9tbSKMZTJCGSNWl9OYmNifDsL7sdHCk4MtndadfpA4rjPEuszyE8Ua3tMLXQ5Gav9IWEvk8IEcj9BRmdZNjyREMs2sXEmPgNHev8Z42HJfHllPqX24cSQ09h82CHYlRsV2fg2kiu/9uBIkaLuBfMU7jVPt3kWTwf3FZeRojpVcp+XgBCn7NsNCHULCwF/zeDNmrIfQrjQ2CEWv1E+kLdI3PFiv2jnes1siXZdcrkb+nj5yJk5J3U0OmZrRo9PUPO6FlUHNwAKavW68cIezVrDFBvPLksgFnz6JHy0r0mVKCU2cN1xLdpe8ImTTaXcuhS6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niC12id+n8er2IEgBUGN3dOvYdavW3VQ9Z5xFtx0pOM=;
 b=ssS0WQjt6NIGBiI1W1Y6cCmT2vpzP/o6VYX36hMeXoCH11GSJa85aGcGo+uKMpkEfS49FJhZ3zUsYF4zAJEe+DtowmnG7khy5vXd0BGA3ECg7vN/5jgqER1XkfbxyxIU5MM570hJtnRlL6JoQ8LkvM50WjAv3PI047DHauIGZ48=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB3616.namprd12.prod.outlook.com (20.178.243.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Tue, 7 Jan 2020 08:31:47 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166%6]) with mapi id 15.20.2602.016; Tue, 7 Jan 2020
 08:31:47 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: updated UMC error address record with correct
 channel index
Thread-Topic: [PATCH] drm/amdgpu: updated UMC error address record with
 correct channel index
Thread-Index: AdXFK7YtNH2ongd8QiOefN8IMtm+SgABWBSwAADS56A=
Date: Tue, 7 Jan 2020 08:31:47 +0000
Message-ID: <MN2PR12MB3663DB0BC9273A8F918876CEFB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
References: <MN2PR12MB36634DB3BB902D08EE331367FB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
 <BYAPR12MB280600880BC934A9404B7A0EF13F0@BYAPR12MB2806.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB280600880BC934A9404B7A0EF13F0@BYAPR12MB2806.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-01-07T08:09:12Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e4679bea-e3a9-456b-b7d1-0000d1b5ce22;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-01-07T08:31:39Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: c1be88ac-6b36-43ec-bd64-00000fc39238
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a440978-3a9d-4439-c1ab-08d7934c0951
x-ms-traffictypediagnostic: MN2PR12MB3616:|MN2PR12MB3616:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3616623B55059D5BB0B8AA4CFB3F0@MN2PR12MB3616.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(55016002)(2906002)(53546011)(6506007)(110136005)(186003)(9686003)(316002)(26005)(76116006)(66556008)(52536014)(66446008)(478600001)(64756008)(8676002)(81156014)(66946007)(86362001)(66476007)(81166006)(8936002)(5660300002)(66616009)(33656002)(71200400001)(7696005)(15650500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3616;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sq5VgjD7AEn9Jh0aPBqaHptv80XQrPSSfBokM+OBhQ1sDM6FdNqWw0ht2c8TOllPuYlkNC1Cw7XmhVMy2/ti3gRTcnQbGQJcp0bEa5rtX6KOffZjdxx2/oQozjUsoWSoe0xFVGn89TXbcOlVK6DZmbAVESWubMZic7Zov4Cwxl3TIXco/xsLL6lzzug2kRv8DUfNDmNfP9PWycqjmD+u9+cv/SOHrx8vy9EtLijb7vf4wNSZgXc7Xhuw1m4qnOyuc/ymAxCnwK/pBbZlgREn8G4MUCFgC7zoyp6lHHAMrHeLLtc41Kr2v8Q8Nx3SgsJL6nRljACGhIKRtwAhppu2Bt3gEL6NjGp5x3Ru+TNuUziETSYjPhkJFyn+c+sBO+Xr2xy8eZd2k4bid0Np5yKMvUXmQ2mMOihYcD5pGdl5M26ghl0tGbN72ussqWhxr2Me
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB3663DB0BC9273A8F918876CEFB3F0MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a440978-3a9d-4439-c1ab-08d7934c0951
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 08:31:47.8565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oYaO1ziAiWHisWjDYFgRdZXGeviSmRpVXn+D/WUmRgfNNQo3wHbUDUR6AxFAuHuDprNmwqto4NVrcpGfbbxK9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3616
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_004_MN2PR12MB3663DB0BC9273A8F918876CEFB3F0MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3663DB0BC9273A8F918876CEFB3F0MN2PR12MB3663namp_"

--_000_MN2PR12MB3663DB0BC9273A8F918876CEFB3F0MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Hello GuChun/Tao,

Thank you for your feedback, I have implemented both of your changes.

Thank you,
John Clements

From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Tuesday, January 7, 2020 4:10 PM
To: Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: updated UMC error address record with corr=
ect channel index


[AMD Public Use]

If we have to improve the macro definition for repetitive loops, I assume w=
e can merge the two defines into one, like:

#define LOOP_UMC_CH_INST(umc_inst) for ((umc_inst) =3D 0; (umc_inst) < adev=
->umc.umc_inst##_num; (umc_inst)++)

Then when we call the double loop, it can be done like:
LOOP_UMC_CH_INST(umc_inst)
              LOOP_UMC_CH_INST(channel_inst) {...

Next we should name the macro more friendly.

Regards,
Guchun

From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Tuesday, January 7, 2020 3:28 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; dl=
.srdc_lnx_ras <dl.srdc_lnx_ras@amd.com<mailto:dl.srdc_lnx_ras@amd.com>>
Subject: [PATCH] drm/amdgpu: updated UMC error address record with correct =
channel index


[AMD Official Use Only - Internal Distribution Only]

Resolved issue with inputting an incorrect UMC channel index into the UMC e=
rror address record.

Defined macros for repetitive for loops

Thank you,
John Clements

--_000_MN2PR12MB3663DB0BC9273A8F918876CEFB3F0MN2PR12MB3663namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle21
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hello GuChun/Tao,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you for your feedback, I have implemented both=
 of your changes.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt=
; <br>
<b>Sent:</b> Tuesday, January 7, 2020 4:10 PM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: updated UMC error address record wi=
th correct channel index<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If we have to improve the macro definition for repet=
itive loops, I assume we can merge the two defines into one, like:<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">#define LOOP_UMC_CH_INST(umc_inst) for ((umc_inst) =
=3D 0; (umc_inst) &lt; adev-&gt;umc.umc_inst##_num; (umc_inst)&#43;&#43;)<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Then when we call the double loop, it can be done li=
ke:<o:p></o:p></p>
<p class=3D"MsoNormal">LOOP_UMC_CH_INST(umc_inst)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; LOOP_UMC_CH_INST(channel_inst) {&#8230;<o:p></o:=
p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Next we should name the macro more friendly.<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:Jo=
hn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, January 7, 2020 3:28 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a>; dl.srdc_lnx_ras &lt;<a href=3D"mailto:dl.srdc_lnx_ras@a=
md.com">dl.srdc_lnx_ras@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: updated UMC error address record with c=
orrect channel index<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Resolved issue with inputting an incorrect UMC chann=
el index into the UMC error address record.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Defined macros for repetitive for loops<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB3663DB0BC9273A8F918876CEFB3F0MN2PR12MB3663namp_--

--_004_MN2PR12MB3663DB0BC9273A8F918876CEFB3F0MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-updated-UMC-error-address-record-with-cor.patch"
Content-Description:  0001-drm-amdgpu-updated-UMC-error-address-record-with-cor.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-updated-UMC-error-address-record-with-cor.patch";
	size=4308; creation-date="Tue, 07 Jan 2020 08:28:00 GMT";
	modification-date="Tue, 07 Jan 2020 08:28:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkYzY5YWU5NGU5M2RlNDVhNTM1ODY4NjE1MjdkZDdlYmU2ZWU3YTIwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgNyBKYW4gMjAyMCAxNjoyNjo1OSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IHVwZGF0ZWQgVU1DIGVycm9yIGFkZHJlc3MgcmVjb3JkIHdpdGggY29ycmVjdAog
Y2hhbm5lbCBpbmRleAoKZGVmaW5lZCBtYWNyb3MgZm9yIHJlcGV0aXRpdmUgZm9yIGxvb3BzCgpD
aGFuZ2UtSWQ6IElmYTk5ZjMzOTEzNjVjY2QwYTA5MWIzZTdlZWE1NTBhMDQzZTM5ZDQyClNpZ25l
ZC1vZmYtYnk6IEpvaG4gQ2xlbWVudHMgPGpvaG4uY2xlbWVudHNAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjZfMS5jIHwgNjUgKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1jX3Y2XzEuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3VtY192Nl8xLmMKaW5kZXggZmUxOGFlMzNkYTYx
Li4xMWU5MjRkZDg4ZmYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Vt
Y192Nl8xLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1jX3Y2XzEuYwpAQCAt
NDQsNiArNDQsMTAgQEAKIC8qIG9mZnNldCBpbiAyNTZCIGJsb2NrICovCiAjZGVmaW5lIE9GRlNF
VF9JTl8yNTZCX0JMT0NLKGFkZHIpCQkoKGFkZHIpICYgMHhmZlVMTCkKIAorI2RlZmluZSBMT09Q
X1VNQ19JTlNUKHVtY19pbnN0KSBmb3IgKCh1bWNfaW5zdCkgPSAwOyAodW1jX2luc3QpIDwgYWRl
di0+dW1jLnVtY19pbnN0X251bTsgKHVtY19pbnN0KSsrKQorI2RlZmluZSBMT09QX1VNQ19DSF9J
TlNUKGNoX2luc3QpIGZvciAoKGNoX2luc3QpID0gMDsgKGNoX2luc3QpIDwgYWRldi0+dW1jLmNo
YW5uZWxfaW5zdF9udW07IChjaF9pbnN0KSsrKQorI2RlZmluZSBMT09QX1VNQ19JTlNUX0FORF9D
SCh1bWNfaW5zdCwgY2hfaW5zdCkgTE9PUF9VTUNfSU5TVCgodW1jX2luc3QpKSBMT09QX1VNQ19D
SF9JTlNUKChjaF9pbnN0KSkKKwogY29uc3QgdWludDMyX3QKIAl1bWNfdjZfMV9jaGFubmVsX2lk
eF90YmxbVU1DX1Y2XzFfVU1DX0lOU1RBTkNFX05VTV1bVU1DX1Y2XzFfQ0hBTk5FTF9JTlNUQU5D
RV9OVU1dID0gewogCQl7MiwgMTgsIDExLCAyN30sCXs0LCAyMCwgMTMsIDI5fSwKQEAgLTE2MSwz
MSArMTY1LDMwIEBAIHN0YXRpYyB2b2lkIHVtY192Nl8xX3F1ZXJ5X3Jhc19lcnJvcl9jb3VudChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAl1aW50MzJfdCBjaF9pbnN0ICAgICAgICAgPSAw
OwogCXVpbnQzMl90IHVtY19yZWdfb2Zmc2V0ICA9IDA7CiAKLQlmb3IgKHVtY19pbnN0ID0gMDsg
dW1jX2luc3QgPCBhZGV2LT51bWMudW1jX2luc3RfbnVtOyB1bWNfaW5zdCsrKSB7Ci0JCWZvciAo
Y2hfaW5zdCA9IDA7IGNoX2luc3QgPCBhZGV2LT51bWMuY2hhbm5lbF9pbnN0X251bTsgY2hfaW5z
dCsrKSB7Ci0JCQl1bWNfcmVnX29mZnNldCA9IGdldF91bWNfNl9yZWdfb2Zmc2V0KGFkZXYsCi0J
CQkJCQkJICAgICAgdW1jX2luc3QsCi0JCQkJCQkJICAgICAgY2hfaW5zdCk7Ci0KLQkJCXVtY192
Nl8xX3F1ZXJ5X2NvcnJlY3RhYmxlX2Vycm9yX2NvdW50KGFkZXYsCi0JCQkJCQkJICAgICAgIHVt
Y19yZWdfb2Zmc2V0LAotCQkJCQkJCSAgICAgICAmKGVycl9kYXRhLT5jZV9jb3VudCkpOwotCQkJ
dW1jX3Y2XzFfcXVlcnJ5X3VuY29ycmVjdGFibGVfZXJyb3JfY291bnQoYWRldiwKLQkJCQkJCQkJ
ICB1bWNfcmVnX29mZnNldCwKLQkJCQkJCQkJICAmKGVycl9kYXRhLT51ZV9jb3VudCkpOwotCQl9
CisJTE9PUF9VTUNfSU5TVF9BTkRfQ0godW1jX2luc3QsIGNoX2luc3QpIHsKKwkJdW1jX3JlZ19v
ZmZzZXQgPSBnZXRfdW1jXzZfcmVnX29mZnNldChhZGV2LAorCQkJCQkJICAgICAgdW1jX2luc3Qs
CisJCQkJCQkgICAgICBjaF9pbnN0KTsKKworCQl1bWNfdjZfMV9xdWVyeV9jb3JyZWN0YWJsZV9l
cnJvcl9jb3VudChhZGV2LAorCQkJCQkJICAgICAgIHVtY19yZWdfb2Zmc2V0LAorCQkJCQkJICAg
ICAgICYoZXJyX2RhdGEtPmNlX2NvdW50KSk7CisJCXVtY192Nl8xX3F1ZXJyeV91bmNvcnJlY3Rh
YmxlX2Vycm9yX2NvdW50KGFkZXYsCisJCQkJCQkJICB1bWNfcmVnX29mZnNldCwKKwkJCQkJCQkg
ICYoZXJyX2RhdGEtPnVlX2NvdW50KSk7CiAJfQogfQogCiBzdGF0aWMgdm9pZCB1bWNfdjZfMV9x
dWVyeV9lcnJvcl9hZGRyZXNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJCQkgc3Ry
dWN0IHJhc19lcnJfZGF0YSAqZXJyX2RhdGEsCiAJCQkJCSB1aW50MzJfdCB1bWNfcmVnX29mZnNl
dCwKLQkJCQkJIHVpbnQzMl90IGNoYW5uZWxfaW5kZXgsCisJCQkJCSB1aW50MzJfdCBjaF9pbnN0
LAogCQkJCQkgdWludDMyX3QgdW1jX2luc3QpCiB7CiAJdWludDMyX3QgbHNiLCBtY191bWNfc3Rh
dHVzX2FkZHI7CiAJdWludDY0X3QgbWNfdW1jX3N0YXR1cywgZXJyX2FkZHIsIHJldGlyZWRfcGFn
ZTsKIAlzdHJ1Y3QgZWVwcm9tX3RhYmxlX3JlY29yZCAqZXJyX3JlYzsKKwl1aW50MzJfdCBjaGFu
bmVsX2luZGV4ID0gYWRldi0+dW1jLmNoYW5uZWxfaWR4X3RibFt1bWNfaW5zdCAqIGFkZXYtPnVt
Yy5jaGFubmVsX2luc3RfbnVtICsgY2hfaW5zdF07CiAKIAlpZiAoYWRldi0+YXNpY190eXBlID09
IENISVBfQVJDVFVSVVMpIHsKIAkJLyogVU1DIDZfMV8yIHJlZ2lzdGVycyAqLwpAQCAtMjUyLDE4
ICsyNTUsMTYgQEAgc3RhdGljIHZvaWQgdW1jX3Y2XzFfcXVlcnlfcmFzX2Vycm9yX2FkZHJlc3Mo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJdWludDMyX3QgY2hfaW5zdCAgICAgICAgID0g
MDsKIAl1aW50MzJfdCB1bWNfcmVnX29mZnNldCAgPSAwOwogCi0JZm9yICh1bWNfaW5zdCA9IDA7
IHVtY19pbnN0IDwgYWRldi0+dW1jLnVtY19pbnN0X251bTsgdW1jX2luc3QrKykgewotCQlmb3Ig
KGNoX2luc3QgPSAwOyBjaF9pbnN0IDwgYWRldi0+dW1jLmNoYW5uZWxfaW5zdF9udW07IGNoX2lu
c3QrKykgewotCQkJdW1jX3JlZ19vZmZzZXQgPSBnZXRfdW1jXzZfcmVnX29mZnNldChhZGV2LAot
CQkJCQkJCSAgICAgIHVtY19pbnN0LAotCQkJCQkJCSAgICAgIGNoX2luc3QpOwotCi0JCQl1bWNf
djZfMV9xdWVyeV9lcnJvcl9hZGRyZXNzKGFkZXYsCi0JCQkJCQkgICAgIGVycl9kYXRhLAotCQkJ
CQkJICAgICB1bWNfcmVnX29mZnNldCwKLQkJCQkJCSAgICAgY2hfaW5zdCwKLQkJCQkJCSAgICAg
dW1jX2luc3QpOwotCQl9CisJTE9PUF9VTUNfSU5TVF9BTkRfQ0godW1jX2luc3QsIGNoX2luc3Qp
IHsKKwkJdW1jX3JlZ19vZmZzZXQgPSBnZXRfdW1jXzZfcmVnX29mZnNldChhZGV2LAorCQkJCQkJ
ICAgICAgdW1jX2luc3QsCisJCQkJCQkgICAgICBjaF9pbnN0KTsKKworCQl1bWNfdjZfMV9xdWVy
eV9lcnJvcl9hZGRyZXNzKGFkZXYsCisJCQkJCSAgICAgZXJyX2RhdGEsCisJCQkJCSAgICAgdW1j
X3JlZ19vZmZzZXQsCisJCQkJCSAgICAgY2hfaW5zdCwKKwkJCQkJICAgICB1bWNfaW5zdCk7CiAJ
fQogCiB9CkBAIC0zMTQsMTQgKzMxNSwxMiBAQCBzdGF0aWMgdm9pZCB1bWNfdjZfMV9lcnJfY250
X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAKIAl1bWNfdjZfMV9kaXNhYmxlX3Vt
Y19pbmRleF9tb2RlKGFkZXYpOwogCi0JZm9yICh1bWNfaW5zdCA9IDA7IHVtY19pbnN0IDwgYWRl
di0+dW1jLnVtY19pbnN0X251bTsgdW1jX2luc3QrKykgewotCQlmb3IgKGNoX2luc3QgPSAwOyBj
aF9pbnN0IDwgYWRldi0+dW1jLmNoYW5uZWxfaW5zdF9udW07IGNoX2luc3QrKykgewotCQkJdW1j
X3JlZ19vZmZzZXQgPSBnZXRfdW1jXzZfcmVnX29mZnNldChhZGV2LAotCQkJCQkJCSAgICAgIHVt
Y19pbnN0LAotCQkJCQkJCSAgICAgIGNoX2luc3QpOworCUxPT1BfVU1DX0lOU1RfQU5EX0NIKHVt
Y19pbnN0LCBjaF9pbnN0KSB7CisJCXVtY19yZWdfb2Zmc2V0ID0gZ2V0X3VtY182X3JlZ19vZmZz
ZXQoYWRldiwKKwkJCQkJCSAgICAgIHVtY19pbnN0LAorCQkJCQkJICAgICAgY2hfaW5zdCk7CiAK
LQkJCXVtY192Nl8xX2Vycl9jbnRfaW5pdF9wZXJfY2hhbm5lbChhZGV2LCB1bWNfcmVnX29mZnNl
dCk7Ci0JCX0KKwkJdW1jX3Y2XzFfZXJyX2NudF9pbml0X3Blcl9jaGFubmVsKGFkZXYsIHVtY19y
ZWdfb2Zmc2V0KTsKIAl9CiB9CiAKLS0gCjIuMTcuMQoK

--_004_MN2PR12MB3663DB0BC9273A8F918876CEFB3F0MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB3663DB0BC9273A8F918876CEFB3F0MN2PR12MB3663namp_--
