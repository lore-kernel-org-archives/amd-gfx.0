Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAD7C33C99
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 06:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C4D206DB
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 06:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2Pv9lM+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C4D206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65BE86E500;
	Tue,  7 Jan 2020 06:20:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73F086E500
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 06:20:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b63bZg4hbRwx42/6eu/e0mkZ8jSEiWSQmwL47B7aSnldqt4TeRVqIrOpVFMDbl/i0lOzNEf2tgDTsNAWXpgjC3FpdnDXm05tvnE17DeswMFhtU39ewJYOWHEWMaWA2v60ReaAux2Mvwapsw+1MN04C0SEPVUxU4YFI0npXFz4xEUjfBatpTmOIpathKMUF2IZb3GccBgR7bCUXM8EkTM5KwEWIqP65VzYb993zrFw2gtEkLbzCbwtSXzDgNYWv1PMVR+2/aHJamFc7rxo+M69aNN2jFcFDHXsG5Z2IBj1Q7VdRpx2KsCYtgiFOnEhHpAMqNRpntoXfoQrPA1TJyVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEWWGq/nn0Bf2epWqgiAUWWa4Gmt1lB4/2sTgeqUu+w=;
 b=giW2iHDdGrmJ5lHu28M/U3O1P4uJrb4t0xiHNW6D+qMXG5+VylHfONQ4bgUZW/H6LSlQsrnmBGkOEd5vpweZIC563cqKvTJ99uKl86cxAzqWNr8hj2B5RbaswCErAEnD8mijCzSqes7wLuw9+wPAQpzBYIgD1bxr06PdmZ0xf9sICALsbVRhgjc5vaOdkUO+OZFBcnsSPLoW3k8BJOTeu7e4FlvFyjHw1qW0l2W6LDV43BTsVm9BBsTI94egnR8RwSwXMGG6iC/w2BzskU2UpooNrWoDELqHGwDbB0Jxxy08KTO1u6a78A877Twa5Amv/AExTzemda3b3n471U07Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEWWGq/nn0Bf2epWqgiAUWWa4Gmt1lB4/2sTgeqUu+w=;
 b=2Pv9lM+jQCungfFUMJOr0M4kH5prsSkOT3MrNlbomoCaWCOMAkCHgNN3gSId06QJax9scyBN4Hhe6BJAzsG3uM9YbryXN9WTNFoJGdbqmwnNKfO9ZG30xqmI26PHPWyFltXg4mIsKUdDkVZXNwU7BR5rN44NJbQulX4bO5cCdTs=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB2863.namprd12.prod.outlook.com (20.179.82.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Tue, 7 Jan 2020 06:14:30 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166%6]) with mapi id 15.20.2602.016; Tue, 7 Jan 2020
 06:14:30 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, dl.srdc_lnx_ras <dl.srdc_lnx_ras@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resolved bug in UMC RAS CE query
Thread-Topic: [PATCH] drm/amdgpu: resolved bug in UMC RAS CE query
Thread-Index: AdXFDfX6UjCjdKdbSWODjaMeQHS5aAAEQPTgAACU/2A=
Date: Tue, 7 Jan 2020 06:14:30 +0000
Message-ID: <MN2PR12MB3663926CAD635B140703589CFB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
References: <MN2PR12MB36636EC5042C85407DB96379FB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
 <MN2PR12MB30543EF3A53F4F76F4F5F673B03F0@MN2PR12MB3054.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB30543EF3A53F4F76F4F5F673B03F0@MN2PR12MB3054.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-07T03:53:45Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=22664f26-4177-45a5-a8d6-0000728869ae;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-07T06:14:25Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 253ee2aa-9691-4e57-8470-00007d957df6
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 190d6332-6ac3-411e-2ce6-08d79338db9c
x-ms-traffictypediagnostic: MN2PR12MB2863:|MN2PR12MB2863:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2863BB7FDB4FFC236738B0A1FB3F0@MN2PR12MB2863.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(199004)(189003)(316002)(478600001)(110136005)(6506007)(186003)(26005)(53546011)(9686003)(55016002)(6636002)(81166006)(5660300002)(8936002)(2906002)(71200400001)(86362001)(33656002)(66556008)(81156014)(66446008)(66476007)(64756008)(76116006)(66946007)(52536014)(7696005)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2863;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ss0XvI8pd2Er0Y97UVkbup+zlCuY31cf88rXAh1rN5jLO43QikVMrgFEU3xq1RpwKJEb6FEGLILid0Szi0YR790jHfmiDhZVLQJYzKWVg3ealPNpFPg9+moLi+Hb8/LrAOe64eWeo7niaCGFgNG2N66YD1Ak5hvXvFtC2/LRQxOqxEWipq84eHWbyOyDht4e/Ye2AqXZh8jPykcE92+v9IeeRqTlcdeZNzOUXyd/ZJ/v8m2+bvnzqP97v9Q2n9r+xiCrWiZp97gJDsC1hKtJv5ODUx5tpr6bbq1RnNuTcYxRNZgkUexwt4wjm5BQx5Z6/nBhNr2Mlf38wGJLR9tgeTwIyO8WlFw9UKfHy7pVAYwdK33fUOLnOnBwMTfOh6Wx2F+aC4aqYioYmpbz5HZFHINZRIbVQe4EJe6xsJv0M5S2FKLmaMf+Skxt8Bvcwgrf
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190d6332-6ac3-411e-2ce6-08d79338db9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 06:14:30.6722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wiwsjIs3gqnGoej8ijAvq+r3dvPBkkoqF+oR/j1dHgzlLxbe5oolCNV4u1TzWJwdI0w5GEPxG77lV34DG0VKUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2863
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
Content-Type: multipart/mixed; boundary="===============1047338577=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1047338577==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3663926CAD635B140703589CFB3F0MN2PR12MB3663namp_"

--_000_MN2PR12MB3663926CAD635B140703589CFB3F0MN2PR12MB3663namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Not necessary, but I wanted to make the register all access=1B$B!G=1B(B con=
sistent.

In a future patch I shall replace the MMIO register offsets with the SMN of=
fsets directly instead of having *4 all over the place.

Thank you,
John Clements

From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, January 7, 2020 1:59 PM
To: Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org; =
dl.srdc_lnx_ras <dl.srdc_lnx_ras@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resolved bug in UMC RAS CE query


[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com<mailto:tao.zhou1@amd.com>>

BTW, are you sure replacing RREG32/WREG32 with RREG32/WREG32_PCIE is also n=
ecessary to fix the bug?

Regards,
Tao

From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: 2020=1B$BG/=1B(B1=1B$B7n=1B(B7=1B$BF|=1B(B 11:54
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; dl=
.srdc_lnx_ras <dl.srdc_lnx_ras@amd.com<mailto:dl.srdc_lnx_ras@amd.com>>
Subject: [PATCH] drm/amdgpu: resolved bug in UMC RAS CE query


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to access CE registers via SMN and disable UMC indexing mo=
de.

Thank you,
John Clements

--_000_MN2PR12MB3663926CAD635B140703589CFB3F0MN2PR12MB3663namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:JA;}
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
	font-family:"Calibri",sans-serif;
	mso-fareast-language:JA;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:JA;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle21
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
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;MS=
 PGothic&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">Not necessary, but I wanted to make the register all=
 access=1B$B!G=1B(B consistent.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In a future patch I shall replace the MMIO register =
offsets with the SMN offsets directly instead of having *4 all over the pla=
ce.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt; <b=
r>
<b>Sent:</b> Tuesday, January 7, 2020 1:59 PM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx@lists.free=
desktop.org; dl.srdc_lnx_ras &lt;dl.srdc_lnx_ras@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: resolved bug in UMC RAS CE query<o:=
p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:SimSun">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">Reviewed-by: Tao Zhou &lt;<a href=3D"mailto:tao.zhou=
1@amd.com">tao.zhou1@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BTW, are you sure replacing RREG32/WREG32 with RREG3=
2/WREG32_PCIE is also necessary to fix the bug?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Tao<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:Jo=
hn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> 2020<span lang=3D"ZH-CN" style=3D"font-family:SimSun;mso-farea=
st-language:ZH-CN">=1B$BG/=1B(B</span>1<span lang=3D"ZH-CN" style=3D"font-f=
amily:SimSun;mso-fareast-language:ZH-CN">=1B$B7n=1B(B</span>7<span lang=3D"=
ZH-CN" style=3D"font-family:SimSun;mso-fareast-language:ZH-CN">=1B$BF|=1B(B=
</span>
 11:54<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a>; dl.srdc_lnx_ras &lt;<a href=3D"mailto:dl.srdc_lnx_ras@a=
md.com">dl.srdc_lnx_ras@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: resolved bug in UMC RAS CE query<o:p></=
o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to access CE registers via SMN and =
disable UMC indexing mode.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3663926CAD635B140703589CFB3F0MN2PR12MB3663namp_--

--===============1047338577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1047338577==--
