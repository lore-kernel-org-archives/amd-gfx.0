Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8D6C33C99
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 08:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE65207E0
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 08:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3JsfS5Tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE65207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 588356E7EF;
	Tue,  7 Jan 2020 08:32:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB3086E7EF
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 08:32:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPha1pkC+aqiiQUtcwXajVmyYFONu7mpI7dkcL4+lGXRX7pliTYYEKLkd8UpwHJIq3x8TyTozvS3osaIYHuW6FoOet3l7j9k2qa0ovCMDLz60o54ORuTNpPIUa3EpQ5ECrlUvluxsboMBb60WxjdJ2kWA+HvKte4nTyCMDDb9x9yNHAC+2bBIJJgKz25eytpEAL1WBN6/lpEuLmNxv+wUHBZkoUyDzgRUwObjVIrIu/yvGh3lz7SHFUFg7WAMkK14NJ/1xi8bCSx22G8yT+RKficd3Rh3hfkGwuhjB3R+/yov4Ovjf4bBl+sS/fqoEx8hR2DEipZcCmBvRRChJPW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2R6/EZ/DP7SrJkugZmLb2pfJjGdNKyNfyFHE3DX7/t4=;
 b=NsZ/HF1R/OUL0GoeTmYXCBXh1PdeHAp60wQoQ/r3dsOlDSDSB5pbRRNvSlJkjZZDyyRoquPA6qfaOlFmuDMzFwu7/qUiLsaImtLNuN00s5cMH4kUCnPm3A1xQvXOypJGOl1zMvu4oCfGtwzqTW73VpZ6oFgXNFblkkNzpswzCJsVv1bfpLxZztD2N7ieiSw4Y64msrUGXRQxFbf6rPylXt9wynGsteykhbIRbm46G6XVE6vTknQ1y1KDgih8IEyrRwknU7XDweF04UUPoFk513HDNdClek8dnHunC5olJiuH4XhBtolMnNfuNKs4GLqOArBKCyUa/W+tEbOvqFFVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2R6/EZ/DP7SrJkugZmLb2pfJjGdNKyNfyFHE3DX7/t4=;
 b=3JsfS5Tb1nz88aIy/cRXK3wlFqnOiWJf2ANfGdeP6wfa2Fe6ZWE44Vn97bReApxKvMh8OYjd/LsuJUbzKzrY4b0/TXfvOs0P/ASccImTbsjjshc0vbb2ETThfHt2YMv34YupTL28QVLwnGPy0p3JKN9qe5ZVR1vEz//BQewaaIc=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB3616.namprd12.prod.outlook.com (20.178.243.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Tue, 7 Jan 2020 08:32:23 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166%6]) with mapi id 15.20.2602.016; Tue, 7 Jan 2020
 08:32:23 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, dl.srdc_lnx_ras <dl.srdc_lnx_ras@amd.com>
Subject: RE: [PATCH] drm/amdgpu: updated UMC error address record with correct
 channel index
Thread-Topic: [PATCH] drm/amdgpu: updated UMC error address record with
 correct channel index
Thread-Index: AdXFK7YtNH2ongd8QiOefN8IMtm+SgABqqA3AAChhdA=
Date: Tue, 7 Jan 2020 08:32:23 +0000
Message-ID: <MN2PR12MB3663B586991448BA33DE9EF7FB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
References: <MN2PR12MB36634DB3BB902D08EE331367FB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
 <MN2PR12MB30543BD6C60A1D3667627DB9B03F0@MN2PR12MB3054.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB30543BD6C60A1D3667627DB9B03F0@MN2PR12MB3054.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-07T08:21:37.097Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-07T08:32:19Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 9889e186-2e82-4699-9535-0000823d41d3
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad5afe07-a308-4c11-232c-08d7934c1e7a
x-ms-traffictypediagnostic: MN2PR12MB3616:|MN2PR12MB3616:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB36163082C56C2A2F23D8C0B3FB3F0@MN2PR12MB3616.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(189003)(199004)(8936002)(5660300002)(478600001)(66556008)(52536014)(66446008)(86362001)(66476007)(81166006)(64756008)(8676002)(81156014)(66946007)(33656002)(7696005)(15650500001)(71200400001)(6636002)(2906002)(55016002)(26005)(316002)(76116006)(53546011)(6506007)(110136005)(186003)(9686003)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3616;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pSUnukTW/90tfTkCdYb8wawZMvaxuRixU9EONzmn5YDevVVumRlc8bmVas/1ukVbfDelTuZ1/3YPjGuprROWAt3Caofbcz/Zdij24zNHRrwZ5uKVY+zxukSLrms6yBmDol7cHUhjfnLnLZd8cVdK9hhuV0wIOBkCLHYHGgbGC1lLKv6Wfq6cACMqoooU2ewVHzz29cMirgJ2OqKRK0ML/CjzDOjtLYThR5sYwlt4FJmtwr0CKyUh6D2jfhlGkq9WEa3JkgG/2i7RNrbQi9Ejb5FkBXmiQN3xi/S33Gag7rkRiz2DIT0/ZkMlzb/iEHMRBmfpDNfj2A9rrsvLC4tcg9rwQyCkp7mAG1DbOFYSMeq1rgBPRsBbb9hD48vee0b9xWLFakg5sTYgIFBYEo3b3jObjQqNJ34AVMBIgAU72ujiF2cNxerovQb1rR01+Dh4WzcuvxHWzAe2OpP5ydMRSTpzcQx9NYjwkeKvCzFEn0A=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5afe07-a308-4c11-232c-08d7934c1e7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 08:32:23.3663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yuGHvO5dZtvle8ovCaROYSmieFDkoLlCCaXAn/j9aBlkL8YUsyOi4j3Bw4kvUZ8G+pcqEGZQWxTHEopwQPR5Xw==
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
Content-Type: multipart/mixed; boundary="===============0482476265=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0482476265==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3663B586991448BA33DE9EF7FB3F0MN2PR12MB3663namp_"

--_000_MN2PR12MB3663B586991448BA33DE9EF7FB3F0MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks Tao, I've updated the patch with this change and followed up in the =
other thread.

Thank you,
John Clements

From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, January 7, 2020 4:22 PM
To: Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org; =
dl.srdc_lnx_ras <dl.srdc_lnx_ras@amd.com>
Subject: Re: [PATCH] drm/amdgpu: updated UMC error address record with corr=
ect channel index

I prefer to calc channel_index like this:

channel_index =3D
    adev->umc.channel_idx_tbl[umc_inst * adapt->umc.channel_inst_num + ch_i=
nst];

idx_tbl is ASIC specific, using adev->umc.channel_idx_tbl instead can avoid=
 adding "if (adev->asic_type =3D=3D xxx)" in the future.

Regards,
Tao
________________________________
From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Tuesday, January 7, 2020 3:28 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; dl.srdc=
_lnx_ras <dl.srdc_lnx_ras@amd.com<mailto:dl.srdc_lnx_ras@amd.com>>
Subject: [PATCH] drm/amdgpu: updated UMC error address record with correct =
channel index


[AMD Official Use Only - Internal Distribution Only]


Resolved issue with inputting an incorrect UMC channel index into the UMC e=
rror address record.



Defined macros for repetitive for loops



Thank you,

John Clements

--_000_MN2PR12MB3663B586991448BA33DE9EF7FB3F0MN2PR12MB3663namp_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
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
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsochpdefault, li.xmsochpdefault, div.xmsochpdefault
	{mso-style-name:x_msochpdefault;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsipheader4d0fcdd7, li.xmsipheader4d0fcdd7, div.xmsipheader4d0fcdd7
	{mso-style-name:x_msipheader4d0fcdd7;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.xmsohyperlink
	{mso-style-name:x_msohyperlink;
	color:#0563C1;
	text-decoration:underline;}
span.xmsohyperlinkfollowed
	{mso-style-name:x_msohyperlinkfollowed;
	color:#954F72;
	text-decoration:underline;}
span.xemailstyle17
	{mso-style-name:x_emailstyle17;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle24
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
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
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks Tao, I&#8217;ve updated the patch with this c=
hange and followed up in the other thread.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt; <b=
r>
<b>Sent:</b> Tuesday, January 7, 2020 4:22 PM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx@lists.free=
desktop.org; dl.srdc_lnx_ras &lt;dl.srdc_lnx_ras@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: updated UMC error address record wi=
th correct channel index<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">I prefe=
r to calc channel_index like this:<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><i><span style=3D"font-size:12.0pt;color:black">chan=
nel_index =3D</span></i><span style=3D"font-size:12.0pt;color:black"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><i><span style=3D"font-size:12.0pt;color:black">&nbs=
p;&nbsp;&nbsp; adev-&gt;umc.channel_idx_tbl[umc_inst * adapt-&gt;umc.channe=
l_inst_num &#43; ch_inst];</span></i><span style=3D"font-size:12.0pt;color:=
black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">idx_tbl=
 is ASIC specific, using adev-&gt;umc.channel_idx_tbl instead can avoid add=
ing &quot;if (adev-&gt;asic_type =3D=3D xxx)&quot; in the future.<o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Regards=
,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Tao<o:p=
></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Clements, John &lt;<a href=3D"mailto:John.Clements@=
amd.com">John.Clements@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, January 7, 2020 3:28 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; dl.srdc_lnx_ras &lt;<a href=3D"mailto:d=
l.srdc_lnx_ras@amd.com">dl.srdc_lnx_ras@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: updated UMC error address record with c=
orrect channel index</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"xmsipheader4d0fcdd7"><span style=3D"font-size:10.0pt;font-famil=
y:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - Inte=
rnal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"xmsonormal">Resolved issue with inputting an incorrect UMC chan=
nel index into the UMC error address record.<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Defined macros for repetitive for loops<o:p></o:p><=
/p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Thank you,<o:p></o:p></p>
<p class=3D"xmsonormal">John Clements<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3663B586991448BA33DE9EF7FB3F0MN2PR12MB3663namp_--

--===============0482476265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0482476265==--
