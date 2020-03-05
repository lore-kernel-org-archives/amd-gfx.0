Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68544C3F2CD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 11:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D092073D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 11:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NiXVWGkr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D092073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A65F66E25B;
	Thu,  5 Mar 2020 11:22:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E0796E25B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 11:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+M/Nqr/mCyhBx4wD68CTuXZzTOQXfWX7ff/GjhaNYGROC6Tsrdef9ka8mrhRI2BOpCk3+1ufSELcw65Wkn2jceBa4SPikQaTMlm3A1PyW9etftu9CN8kiWcJyEbRFHctSiY9vflHqIWj9751Hhmyxe7y7H35aKs0CKyBIT0EyZPqrSGseVsXQLDpHui5uqNshqcFBWKlfmrhZ7iiQh3qjGEEFE7H8ufGgEu8A9SaiLiidZZGLdslS7QdljLuGOZYDgRWGiuDjD+b+8k573JsR3SjQGQ5UpN6IXzHYfCsFPhgWvXQ9r0KPpwQgPjFtmS1bm04zuWyua/SZWIC2SwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNW3EGlQB4FVYbubrSJmDVnJ2KC4TYX5TYdIeFbfj4g=;
 b=L1zETALb+AgYh6HAPq/QuI5xQpvzllq30geMbcvUQH9i8xCIoISpq4q3FPRWQX7cj+Dn2dzLRsJ7ako+gMQ/9bDfINIrIIfBU7vtwuUOkHIcMyi4ogKk3ZwPKW+2afoGvgJiKGagTSO+wayXiMpj+dkzyRjBWPxRB4HFhVrgDF9fI8Q3dH4y6I5pQVgjpcazZkoo2tlQ1WABgBsagEE6eU/lffddvhUN+uAsiIn62pwPVqpg2w/F76CCLs3/yQq6GA3kjn3y8T7iOCtV4sS9xLM3lA6H94anHMHHn3c602+YoaZeZXhz9ZaAPj800gxut8tIbNx3TzcIKJa/r16xZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNW3EGlQB4FVYbubrSJmDVnJ2KC4TYX5TYdIeFbfj4g=;
 b=NiXVWGkreooU4RTV9OMeGsztPFWryjFvdClasgStTIEuxN9q6YPhKk5DOY3SFdgpYncgB8WIlwJCdzUAK8OWK4jaRr7qkgANxhtoxeZSrx4CToxUmPujmwIO1LeWvyqNxDB4xqVjyRyuv+HWTm2GiOKzY42vw/dEUMd/DD+7uok=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) by
 DM5PR12MB1324.namprd12.prod.outlook.com (2603:10b6:3:76::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 5 Mar 2020 11:22:41 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 11:22:41 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1, 
 Tao" <Tao.Zhou1@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update page retirement sequence
Thread-Topic: [PATCH] drm/amdgpu: update page retirement sequence
Thread-Index: AdXy0f9EIn2WkBwySKekkStORNst4QAAeMzgAABOtbAAAn8mkA==
Date: Thu, 5 Mar 2020 11:22:40 +0000
Message-ID: <DM5PR12MB14182ED48CB98E4BE2D695C5FCE20@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <MN2PR12MB366376914E9DE0A1D1D39440FBE20@MN2PR12MB3663.namprd12.prod.outlook.com>
 <DM5PR12MB14180E64D6C5E62E05DA8D0AFCE20@DM5PR12MB1418.namprd12.prod.outlook.com>
 <MN2PR12MB366325AEAAEC19067ED553ACFBE20@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB366325AEAAEC19067ED553ACFBE20@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-05T09:39:47Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ddcdfbbc-89af-4d2f-8549-0000f5c83eff;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-05T11:22:38Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a100b934-27e2-4070-be3c-0000116e75c3
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32b9d283-970c-4d46-ab52-08d7c0f7849a
x-ms-traffictypediagnostic: DM5PR12MB1324:|DM5PR12MB1324:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1324E3980CC9968C010DF87EFCE20@DM5PR12MB1324.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(199004)(189003)(66946007)(66446008)(66476007)(66556008)(8936002)(26005)(76116006)(8676002)(81166006)(478600001)(64756008)(81156014)(186003)(2906002)(33656002)(71200400001)(5660300002)(6636002)(52536014)(86362001)(15650500001)(110136005)(53546011)(316002)(55016002)(6506007)(9686003)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1324;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Ft1ocQXK9mGgoX51PSjjFT7IGLMb3/QYdvWmfxOxO3s5xYeSMkr1MeunhvsDc8PlQpEDywzaufCImNZFCSvkuyt6OHlXzF49wgcMuQrDtMfPnwkV11lxNtiZlKP9xvKVOE3tbG2uMlKUax/buQvE2/3v6rldJs/RY9+WTtrn3efzpG47tPKeZ7ooJ5JjZsFY3G2iHH3p9vzM09N5bNpVwuPiaSLknRNbj924765iHr4xfcmvkpHethaIoVhX/SuXYjajp9uIAfHZi2uxdpkLSFquC+ugsvl5jKaRJ92owrhrQGbURFtam7eL6f9k8BOOlz3sewIbvI1s2JUcPhCvL0yPXjMXATYayZABLh8Erk9rJD7vk1uRDwkfTlv1iXoNuMZS/OX27WjuMhfyIurVxp3ILIAbGLfQ7UNa1yp4/15fxWc97aapbNUcxWFcZaX
x-ms-exchange-antispam-messagedata: YT4PWJJGN2K7zGR6fGsk6/uPhU0PB4T0W6C46V7T8TxZV3owS3R6/xuSVR3t0bge5gOvwlQLcK7OISu9CHOtrDy6FYNI7rCw/i2blBbEXA8bsX+epcpYPpfRd6tgOpjnfTZi55us1j6w+kszoq5LHQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b9d283-970c-4d46-ab52-08d7c0f7849a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 11:22:40.9219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7UrY2gBUTge6D2kyWMENnd+tVN4ZRh+6lQHp7Mgw2Nbrby2ND18bt9PcZKdkbkn8afhOUNgaV66tTNVV50nn4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1324
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
Content-Type: multipart/mixed; boundary="===============0002111637=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0002111637==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB14182ED48CB98E4BE2D695C5FCE20DM5PR12MB1418namp_"

--_000_DM5PR12MB14182ED48CB98E4BE2D695C5FCE20DM5PR12MB1418namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

I see. So it's the following programming that is in risk to corrupt data fo=
r other instances.

                /* clear umc status */
                WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0U=
LL);

For error injection, everytime it should just have one instance had the err=
or status record. Therefore, it make sense to me that we only clear the sta=
tus register once. As discussed, we shall also follow up with umc team on t=
he potential issue with index mode programming.

Please also add some comments in code for this unexpected behavior that we =
shall follow up. Other than that, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Thursday, March 5, 2020 18:19
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; =
Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Guchu=
n <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update page retirement sequence


[AMD Official Use Only - Internal Distribution Only]

In the original sequence, if the key bits are not set in the mca_status, th=
e page retirement will not happen and the status register will be cleared.
If there is a UMC UE, that register will be cleared erroneously 31 times.

If MCA Status =3D=3D 0 already from the beginning there is no reason to pre=
ss forward with the rest of the checks and clear the register.

From: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Sent: Thursday, March 5, 2020 5:56 PM
To: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>; a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Li, Den=
nis <Dennis.Li@amd.com<mailto:Dennis.Li@amd.com>>; Zhou1, Tao <Tao.Zhou1@am=
d.com<mailto:Tao.Zhou1@amd.com>>; Chen, Guchun <Guchun.Chen@amd.com<mailto:=
Guchun.Chen@amd.com>>
Subject: RE: [PATCH] drm/amdgpu: update page retirement sequence


[AMD Official Use Only - Internal Distribution Only]

Hi John,

Can you please explain more on the differences between (a). exit immediatel=
y when mca_status is 0 and (b). exit when some of critical field in mca_sta=
tus is 0?

Regards,
Hawking
From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Thursday, March 5, 2020 17:40
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Zh=
ang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Li, Den=
nis <Dennis.Li@amd.com<mailto:Dennis.Li@amd.com>>; Zhou1, Tao <Tao.Zhou1@am=
d.com<mailto:Tao.Zhou1@amd.com>>; Chen, Guchun <Guchun.Chen@amd.com<mailto:=
Guchun.Chen@amd.com>>
Subject: [PATCH] drm/amdgpu: update page retirement sequence


[AMD Official Use Only - Internal Distribution Only]

check UMC status and exit prior to making and erroneus register access

--_000_DM5PR12MB14182ED48CB98E4BE2D695C5FCE20DM5PR12MB1418namp_
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
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
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
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I see. So it&#8217;s the following programming that =
is in risk to corrupt data for other instances.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* clear umc status */<o:p></o:p></p=
>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG64_PCIE((mc_umc_status_addr &#43=
; umc_reg_offset) * 4, 0x0ULL);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">For error injection, everytime it should just have o=
ne instance had the error status record. Therefore, it make sense to me tha=
t we only clear the status register once. As discussed, we shall also follo=
w up with umc team on the potential
 issue with index mode programming.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please also add some comments in code for this unexp=
ected behavior that we shall follow up. Other than that, the patch is
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Thursday, March 5, 2020 18:19<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.free=
desktop.org; Li, Dennis &lt;Dennis.Li@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1=
@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: update page retirement sequence<o:p=
></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In the original sequence, if the key bits are not se=
t in the mca_status, the page retirement will not happen and the status reg=
ister will be cleared.<o:p></o:p></p>
<p class=3D"MsoNormal">If there is a UMC UE, that register will be cleared =
erroneously 31 times.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If MCA Status =3D=3D 0 already from the beginning th=
ere is no reason to press forward with the rest of the checks and clear the=
 register.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhang, Hawking &lt;<a href=3D"mailto:Ha=
wking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;
<br>
<b>Sent:</b> Thursday, March 5, 2020 5:56 PM<br>
<b>To:</b> Clements, John &lt;<a href=3D"mailto:John.Clements@amd.com">John=
.Clements@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a>; Li, Dennis &lt;<a href=3D"mailto:Dennis.Li@amd.com">Dennis.Li@amd.=
com</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@=
amd.com</a>&gt;; Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Gu=
chun.Chen@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: update page retirement sequence<o:p=
></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi John,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Can you please explain more on the differences betwe=
en (a). exit immediately when mca_status is 0 and (b). exit when some of cr=
itical field in mca_status is 0?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:Jo=
hn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Thursday, March 5, 2020 17:40<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a>; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.=
com">Hawking.Zhang@amd.com</a>&gt;; Li, Dennis &lt;<a href=3D"mailto:Dennis=
.Li@amd.com">Dennis.Li@amd.com</a>&gt;; Zhou1, Tao
 &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@amd.com</a>&gt;; Chen, =
Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.Chen@amd.com</a>&g=
t;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: update page retirement sequence<o:p></o=
:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">check UMC status and exit prior to making and errone=
us register access<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM5PR12MB14182ED48CB98E4BE2D695C5FCE20DM5PR12MB1418namp_--

--===============0002111637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0002111637==--
