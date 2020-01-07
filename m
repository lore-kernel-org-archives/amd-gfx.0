Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9713C33C99
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 09:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981822073D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 09:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i1qS5gKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981822073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F836E802;
	Tue,  7 Jan 2020 09:08:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA0C26E802
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 09:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hI7eUbk0tKdW9x56fZfdJUQ9IQ29LnUiy3IJWyJXigOK+XIA9fcUuObsjwwWMdUtMPuRAZKK/MYEygF2yuodk9O/JhwwCkjMVWd++skrPsW+QS77Z2R1ZMQqqkV6TEPGgqcWunirkQIZTXv9CCLYRsWqifNVkKF1sYWwhsrpCWrZ81cCkID+abSTW/PVSKtypCLpYU+J8HXzO/JgG0oPBumljelVgAC8XUOWpENmH2jpNuqo53XEv+dqDfns6YrvYxxkrLkNmY4qQega3DDzSTgIgGZiDuVtXGFAPiJ6iwNTOZtLMlc9APg0xdEZUWjg4+JJcF4OHX8jiNi7eHbe8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu+J/felVHJJx35yf6zFCxuxDiyD1zvh6AswTKYQdlo=;
 b=GPbqruF+UeKbiKsCZ/8rnAntED04ZNGV2qZSRYAoEiBHtKk+xPQ4Nlj2tP88hKO9Uhkp9LJU3WEq75fGvaObWMIfva+p5DZ0rf/n6hOfFF3MynQvt3neI3jRtfonNbKAf1XNL4q5qgOSYES4jiE4o8rmkaYZZNztC1RG8rMNtBj7RuySn+GrxKAZLFPuy+lxmuYkPPKby6PFyV8pAuuhGrS5Vy/0WrxZmWgKlch/TvMU7ogTBOBUuf77Ns0fW+d364PH/jsDQnFJj5o3Ppq8yySUx/scvyyEFnKTd4Ddx39RmSayX+yuDrJMlO/fiBm9ib8WaDUn+twDtBe4SFqYjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu+J/felVHJJx35yf6zFCxuxDiyD1zvh6AswTKYQdlo=;
 b=i1qS5gKOB4Yw9QnouYgf3BIgqbo5LrlryAMjjztiQuTixTGy35UCa1GuDLUxxgT562VH0w5bx+/wh3YF2yPEMMxNU3fFHxSrhBzLr4p1rkYnCCrFfZz347+HeSMB5+0Jy1Sfn2v/dwbxn0lt7HBiMl+XY1Lpb8SbpWQDBoScPgk=
Received: from MN2PR12MB3054.namprd12.prod.outlook.com (20.178.244.79) by
 MN2PR12MB3886.namprd12.prod.outlook.com (10.255.238.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Tue, 7 Jan 2020 09:08:46 +0000
Received: from MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::fd1e:ce54:2a7d:b849]) by MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::fd1e:ce54:2a7d:b849%5]) with mapi id 15.20.2602.015; Tue, 7 Jan 2020
 09:08:46 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: updated UMC error address record with correct
 channel index
Thread-Topic: [PATCH] drm/amdgpu: updated UMC error address record with
 correct channel index
Thread-Index: AdXFK7YtNH2ongd8QiOefN8IMtm+SgABWBSwAADS56AAAUGscg==
Date: Tue, 7 Jan 2020 09:08:46 +0000
Message-ID: <MN2PR12MB305412F23D9F0CA1E1D18202B03F0@MN2PR12MB3054.namprd12.prod.outlook.com>
References: <MN2PR12MB36634DB3BB902D08EE331367FB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
 <BYAPR12MB280600880BC934A9404B7A0EF13F0@BYAPR12MB2806.namprd12.prod.outlook.com>,
 <MN2PR12MB3663DB0BC9273A8F918876CEFB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3663DB0BC9273A8F918876CEFB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-01-07T09:08:46.148Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tao.Zhou1@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f982b7b-b555-4084-e9f7-08d7935133e4
x-ms-traffictypediagnostic: MN2PR12MB3886:|MN2PR12MB3886:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB388611295A76C871A5623E48B03F0@MN2PR12MB3886.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(91956017)(110136005)(76116006)(19627235002)(66446008)(66946007)(86362001)(186003)(66476007)(55016002)(316002)(478600001)(8936002)(19627405001)(64756008)(66556008)(26005)(52536014)(33656002)(9686003)(15650500001)(71200400001)(2906002)(7696005)(6506007)(8676002)(81156014)(53546011)(81166006)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3886;
 H:MN2PR12MB3054.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nuzV/KJBOGybG9b7k2anv7mYliJvqRXTLpyhNB+gf8ktH+XCI4i2qa6NRo7yuGoCrYD9o/KTay18eHMnBnY+t05TUNp7177Ni5MpwknUysPxeSe6110C5FSpXxSc5NLGsKgAeta2L6/zkV0teMZ4lsiKEqbfu675yf25nhccLgf6tLuVssqQU27MAPtEdsGFVgOo+cafZJvcIGLninehKPFuAN/UldfTQt3Rj9z/Ser0fYejac9iXieZB9aYhoOZPbsWoqu6sNBHQZfSFJABsbmBW35t5dWRQTlRGCJNuaPPd3cXio5x7iTmv0qOPicpPjk0/o5EEu7zgljUiHb92UQxvKRYjlW/xiuTm5VQvor5xlm43OujY+eQQ1LGZ7WktHGw/zRkXE5WCw1XEHeLDy63mfPCdixF+uJdrLVAcS1iOfHsCiwotNATINJ9pUYT
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f982b7b-b555-4084-e9f7-08d7935133e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 09:08:46.6999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZxC0SGqQalcMBxcfpRZuDCwVBm/gx8xe3iOJMUXKGfcoUxbVvdoWZozbdjc5GwH+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3886
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
Content-Type: multipart/mixed; boundary="===============1861375404=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1861375404==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB305412F23D9F0CA1E1D18202B03F0MN2PR12MB3054namp_"

--_000_MN2PR12MB305412F23D9F0CA1E1D18202B03F0MN2PR12MB3054namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

uint32_t channel_index =3D adev->umc.channel_idx_tbl[umc_inst * adev->umc.c=
hannel_inst_num + ch_inst];

The code is too long, it can be separated into two lines.

With that fixed, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Clements=
, John <John.Clements@amd.com>
Sent: Tuesday, January 7, 2020 4:31 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: updated UMC error address record with corr=
ect channel index


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

              LOOP_UMC_CH_INST(channel_inst) {=85



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

--_000_MN2PR12MB305412F23D9F0CA1E1D18202B03F0MN2PR12MB3054namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span>uint32_t channel_index =3D adev-&gt;umc.channel_idx_tbl[umc_inst * ad=
ev-&gt;umc.channel_inst_num &#43; ch_inst];<br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The code is too long, it can be separated into two lines.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
With that fixed, the patch is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Clements, John &lt;John.Cleme=
nts@amd.com&gt;<br>
<b>Sent:</b> Tuesday, January 7, 2020 4:31 PM<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: updated UMC error address record wi=
th correct channel index</font>
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
a:link, span.x_MsoHyperlink
	{color:#0563C1;
	text-decoration:underline}
a:visited, span.x_MsoHyperlinkFollowed
	{color:#954F72;
	text-decoration:underline}
p.x_msonormal0, li.x_msonormal0, div.x_msonormal0
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
p.x_msipheader4d0fcdd7, li.x_msipheader4d0fcdd7, div.x_msipheader4d0fcdd7
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
p.x_msipheader87abd423, li.x_msipheader87abd423, div.x_msipheader87abd423
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle20
	{font-family:"Calibri",sans-serif;
	color:windowtext}
span.x_EmailStyle21
	{font-family:"Calibri",sans-serif;
	color:windowtext}
span.x_EmailStyle22
	{font-family:"Calibri",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"x_WordSection1">
<p class=3D"x_msipheader87abd423" style=3D"margin:0in; margin-bottom:.0001p=
t"><span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-seri=
f; color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Hello GuChun/Tao,</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Thank you for your feedback, I have implemented bo=
th of your changes.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Thank you,</p>
<p class=3D"x_MsoNormal">John Clements</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&=
gt; <br>
<b>Sent:</b> Tuesday, January 7, 2020 4:10 PM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: updated UMC error address record wi=
th correct channel index</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_msipheader87abd423" style=3D"margin:0in; margin-bottom:.0001p=
t"><span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-seri=
f; color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">If we have to improve the macro definition for rep=
etitive loops, I assume we can merge the two defines into one, like:</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">#define LOOP_UMC_CH_INST(umc_inst) for ((umc_inst)=
 =3D 0; (umc_inst) &lt; adev-&gt;umc.umc_inst##_num; (umc_inst)&#43;&#43;)<=
/p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Then when we call the double loop, it can be done =
like:</p>
<p class=3D"x_MsoNormal">LOOP_UMC_CH_INST(umc_inst)</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; LOOP_UMC_CH_INST(channel_inst) {=85</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Next we should name the macro more friendly.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Regards,</p>
<p class=3D"x_MsoNormal">Guchun</p>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:=
John.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, January 7, 2020 3:28 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a>; dl.srdc_lnx_ras &lt;<a href=3D"mailto:dl.srdc_lnx_ras@a=
md.com">dl.srdc_lnx_ras@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: updated UMC error address record with c=
orrect channel index</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_msipheader4d0fcdd7" style=3D"margin:0in; margin-bottom:.0001p=
t"><span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-seri=
f; color:#0078D7">[AMD Official Use Only - Internal Distribution Only]</spa=
n></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Resolved issue with inputting an incorrect UMC cha=
nnel index into the UMC error address record.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Defined macros for repetitive for loops</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Thank you,</p>
<p class=3D"x_MsoNormal">John Clements</p>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB305412F23D9F0CA1E1D18202B03F0MN2PR12MB3054namp_--

--===============1861375404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1861375404==--
