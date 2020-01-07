Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B62C33C99
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 08:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7582075A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 08:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Wl20fSb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7582075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EE736E7EA;
	Tue,  7 Jan 2020 08:09:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F31E86E7EA
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 08:09:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtdA8o1kKVboMcmMwo10edo0GZq43M/0TRGpaizhtgkayDbcwO57KgSJHpMp7r0KCZOutdwkPO1R7yXCexY1G6a0Vqwrh6dlRa4aGPIrUBu7gedREZR0Ab8N5WxkrtIVlokNrk50VnkCTbSvNBAY5Njm5KMsRKwze5IvKiUabGo7/+hkmrPWKyGquXwsjPa6G6s9zWxFRVS0WV5jbsMhmeQqst6TysJ5pKMkm+laPfnfkhR4xobKvB+uEJPKe0oOu4nlqH9I9/1lzl6x/OI7iKk2O2N5GDTcrKUNZr+z8rgbpXPEKkza1xdec/kCBi3NYBBv/Qhq7ER6vskwqc56gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Jv5q3pYcNjxLWaYbyFWxO593p4ovpo8HystesxuURs=;
 b=Hhr/LfYhiKHqd4FVRl3sLJaV4aex5bWRbmwK5O4AhJ4NENgw8vGcb47584EWvBp/Y/gdKSsVufILKRuEmzuOUuqGy26vRAUy9buCCAqOejE1ZZ2nC2550z+93a7rO09J8tuLsI0SsxLEEpSkI/POrvHRqf6QHvAalhQ4lzmCDXGXOxmr8is/LkZXialY5/tt8CW4D/rRNjuP+YZ8Fj6ztB7hob6LzUCnn62vnRCFUIuUXVyek9OGVs4CXohIAkMBA15W5yEvbGa9B6/LEvq4KbKP3RvUM3DNEV39yQgohn4DFD28ZFu/Hdi3sAyFY19Rxd2fQPfxjIroO9oSZ/NUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Jv5q3pYcNjxLWaYbyFWxO593p4ovpo8HystesxuURs=;
 b=Wl20fSb3H1Yq8wdPRy6xF7Nw12dvh7kUsWTHQEhiKKrkUwDxOYOvmAKipz/J5TY6rbPsN5VoiP6fTN2rAH53AlfxqHLbGIr98NuL1lIdmazigH5Kviz6ZUQNq6GKkHhhjqG+TaOKAxkmHE+p9K38Zw5i34VwyneLcs4yFUmLOrY=
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3319.namprd12.prod.outlook.com (20.178.54.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Tue, 7 Jan 2020 08:09:52 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269%6]) with mapi id 15.20.2602.015; Tue, 7 Jan 2020
 08:09:52 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: updated UMC error address record with correct
 channel index
Thread-Topic: [PATCH] drm/amdgpu: updated UMC error address record with
 correct channel index
Thread-Index: AdXFK7YtNH2ongd8QiOefN8IMtm+SgABWBSw
Date: Tue, 7 Jan 2020 08:09:52 +0000
Message-ID: <BYAPR12MB280600880BC934A9404B7A0EF13F0@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <MN2PR12MB36634DB3BB902D08EE331367FB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB36634DB3BB902D08EE331367FB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-01-07T08:09:12Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e4679bea-e3a9-456b-b7d1-0000d1b5ce22;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-01-07T08:09:49Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 8c3bace5-d650-4b4e-b151-000014d81937
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b906445-b0d6-402c-aeaa-08d79348f933
x-ms-traffictypediagnostic: BYAPR12MB3319:|BYAPR12MB3319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB33199C68799A7CCA54854144F13F0@BYAPR12MB3319.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(199004)(189003)(8936002)(66476007)(66946007)(52536014)(71200400001)(8676002)(110136005)(9686003)(76116006)(6506007)(55016002)(81166006)(15650500001)(186003)(26005)(53546011)(7696005)(64756008)(33656002)(81156014)(4744005)(66446008)(66556008)(5660300002)(86362001)(2906002)(316002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3319;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DdSy6THsZDpzAszs5VlINV5AfiK+zzO7PVL8twkTPQ+jUZ+8vditnLUMoun/sAGxgd7J9BRVnKjy9ox/2mz4SGSwk/u9tX4XD1K8Vvm+XqznP5ODwthNWL3HeQz7c+rxtXo/qX+bo2C8GELU9/h6ug9lZeevkMV14vN0WzEjiEFZc49ShZewPYKIzNfOXyZAfzGlWHCligjhcqNGYQgDo7/O7M0jCNWphM38exjAu/Ct1XnJJJIU5DKaV3YADtUk3Gf42cTbzDVPh8UcXg2oXbM6GVuaWa+UrdXFilTHq856oI+/LbP/zTegHgi7gjIR8Q1ai7DULjAVhxUE8qh6d246/d9WwxtevEbTA+42cYmFFasPa5bgZ6W2qX1hl16TWU/GykAiFuDPsh8yevHwd3qBJB5WSWoM21cqbUo9oqT7ZV0FW/Yr8MUUI/CuQxBX
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b906445-b0d6-402c-aeaa-08d79348f933
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 08:09:52.2477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k5nr5SpikKvWmoK/3bXilWK5ZWPSrDGITY01hGfdAuYJdBjQC4WGQbT6UNBVbLpgoHBRzJuDuTq1XCC16efRhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3319
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
Content-Type: multipart/mixed; boundary="===============0895529287=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0895529287==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB280600880BC934A9404B7A0EF13F0BYAPR12MB2806namp_"

--_000_BYAPR12MB280600880BC934A9404B7A0EF13F0BYAPR12MB2806namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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

From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, January 7, 2020 3:28 PM
To: amd-gfx@lists.freedesktop.org; dl.srdc_lnx_ras <dl.srdc_lnx_ras@amd.com=
>
Subject: [PATCH] drm/amdgpu: updated UMC error address record with correct =
channel index


[AMD Official Use Only - Internal Distribution Only]

Resolved issue with inputting an incorrect UMC channel index into the UMC e=
rror address record.

Defined macros for repetitive for loops

Thank you,
John Clements

--_000_BYAPR12MB280600880BC934A9404B7A0EF13F0BYAPR12MB2806namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
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
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Tuesday, January 7, 2020 3:28 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; dl.srdc_lnx_ras &lt;dl.srdc_lnx_r=
as@amd.com&gt;<br>
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

--_000_BYAPR12MB280600880BC934A9404B7A0EF13F0BYAPR12MB2806namp_--

--===============0895529287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0895529287==--
