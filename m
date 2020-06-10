Return-Path: <SRS0=jeuu=7X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A41C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 06:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E3820760
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 06:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AtLylIed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E3820760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82B096E02D;
	Wed, 10 Jun 2020 06:30:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E1F6E02D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2020 06:29:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQ4x34tOKSlJLi1aln4PMrifd1TImWdHXRuhkAoBrGA70RhugoTQ/ROHXMplVDG3rl7OQXuL3Xt1fM8yXlANgSwdRQ2et6ueeK6HEfW2enWCITGHd9a43jb5tUIeo4gw/sGwfG/DZ4pcjIh7DEIjSgBZdAygy1Kgi+WXsCLcL8Y6isGKVQ6Trm5Hjoap3Le2UM8Hk1Zya/gKUzRy5VMCXaS1OVc8xfpiYqnm0grdC5bw//Y8I31Lf4jldpLHPNusj17BN9R/JqgcvoswNWNwg27ggCPeSru8EioBI0feBeinuWMepItQXhWx+E0RhmrPKtTqCaxHlPzDNdhnNQHuLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNeIGwr3dbM/CeoknzdvPW4Wd9gGD2t9G7sbtnAH3jc=;
 b=EqmoTzePazNQq60GUGrs49qffGcsUcHAhDg/jR+F/PiYEKqghnMwV0ND+cr0ZGUWHcAizT1wLiwjEsDcoetid2FzsZXlZS3erSNSfxFvXmao5rS4n3kqrB2+x8dp4F1K22SQuRvupJHpgO3ue49n/rVk159Z4ryqwKRLjMoydkxH/OgtNaWgaxAqMEY2u5Db25mJzd30CiL7vUAPsqGjnb37in1ymrgatc2ASRiUA95M5dPPvlyt4cjp2uqJzSQpJQ50E1gDlkl2IlOmwz7kUdY2SR0jRJeAsdu5831IvKwFcL4K3T3QfAEu9/CFZy3zadQUK85ugTTejeY4ix65yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNeIGwr3dbM/CeoknzdvPW4Wd9gGD2t9G7sbtnAH3jc=;
 b=AtLylIedzxIawt36x8ARf+jcrHw0PnLJs3cEMDZfbtypg+sCinELHUqN0txdnVP+rHTe0OMhOdpCvhsUnvJNF6vBcxZGtxlkKeVIVmD3tRTRJraIBFV/RzJ0u3SzVCjhoQJaWn2062iLrvAIvBIaeqOzyuI5ohl5j4OmDkFuoHM=
Received: from DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) by
 DM5PR12MB1258.namprd12.prod.outlook.com (2603:10b6:3:79::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.20; Wed, 10 Jun 2020 06:29:57 +0000
Received: from DM5PR12MB2440.namprd12.prod.outlook.com
 ([fe80::cdac:3b10:3487:83be]) by DM5PR12MB2440.namprd12.prod.outlook.com
 ([fe80::cdac:3b10:3487:83be%6]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 06:29:57 +0000
From: "Zhou, David(ChunMing)" <David1.Zhou@amd.com>
To: =?iso-8859-2?Q?Marek_Ol=B9=E1k?= <maraeo@gmail.com>, amd-gfx mailing list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove distinction between explicit and
 implicit sync (v2)
Thread-Topic: [PATCH] drm/amdgpu: remove distinction between explicit and
 implicit sync (v2)
Thread-Index: AQHWPk0YXcCUUZGuYUuXjjiyqdNm9KjRYOWA
Date: Wed, 10 Jun 2020 06:29:57 +0000
Message-ID: <DM5PR12MB24405F71791676A64CB02D9EB4830@DM5PR12MB2440.namprd12.prod.outlook.com>
References: <CAAxE2A6T-hGWE7r_aFVmPyO__wh5kptbJiJ7rYd7dFg2TH2BKw@mail.gmail.com>
In-Reply-To: <CAAxE2A6T-hGWE7r_aFVmPyO__wh5kptbJiJ7rYd7dFg2TH2BKw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-10T06:29:26Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f04e1ae7-c470-45a4-9a41-0000cc73ac00;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-10T06:29:26Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: ea24f354-55d6-4b30-9b6b-0000ba43a3b3
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [240e:e0:8c85:a100:ad9c:55c2:6752:d97a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0413def-079c-4100-55b5-08d80d07b1d1
x-ms-traffictypediagnostic: DM5PR12MB1258:
x-microsoft-antispam-prvs: <DM5PR12MB12583C290BE93F833A7F77D2B4830@DM5PR12MB1258.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QMULBXO7OCtoqQfP4hvu9FAd+2sAlfoaTvaedP9+u2Yfbir4bxHeVlCb1VcCL8Cs8Z2oAZYgIzLn0oi9JhiaGnr4MhTx+ikXJBoeDeeuSz84yP5MatjExLRFU6vpfkIn8+N1Fi95hU/0FGCj2eVeq111fnadojci1OuCXsitfd4macHlOCilwOYnp8uNu7k7wo16KGRrQni6c4+o1w4n8moHIdBy6HJ2h0uiQ+ohpix7gBckv8mNx4qGPf+9V2penexvyLHo0fizxwp/IGpZ4VjgYJn6gGR8c92p8z2tvz3onaztVev/bAF7Z3igZxME
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2440.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(8936002)(53546011)(71200400001)(5660300002)(4744005)(8676002)(110136005)(52536014)(7696005)(6506007)(2906002)(86362001)(33656002)(64756008)(316002)(186003)(478600001)(76116006)(66946007)(55016002)(66476007)(9686003)(66556008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 360787clJsJkphsZF8tWS/mYV3OFa3R/9oGkWdBHPSqUAWJdJ9UetWwV+tr0Fd6imJFPr7ZJl6ByXP1vPRe7tvb/Znk/GDks59wDINqTfhUDFytu00x3ZoMooSwPt9S/e0FY9pNeLElf4vR+TULwun/EQCbjrv/nJS2smK/5nFkpduCUt2f9GbcF2NJ+WvZ80DgM1t4tK2vbkduw5vNQJChrXJ/Gjh8v1/MVJZmTGMpWLACeEZSax3RQ6L6mZQNh3cW5ebzlhacABE4oHAtwtDCtUu93ngQmNEAluF9+dwm0P3h3NCeCztUPXN55FRYOw3sPKKm+VPX4H8CofeAQ6cWtxMFqIQDdBB5B1sqqrQEA2C/KMtTXjjgYos49QJAWV1ub6sA5ScdTMTExtArCCAc0LjQeaSfxzpwoByLeNJTlFh5c2nIAxXPIUJvA0hcpaU36WY2ZNho8Q6ebEcJvysgLD1xHjvZu/e/oi0DYiqNLAIEeeipPNNZ6EnrpNDscWUiEpHnQuueTWhAATM4bPORPuDQU/ZVhp89uf65ObrQ=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0413def-079c-4100-55b5-08d80d07b1d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 06:29:57.0904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oq6cKkTLMZzJfEhsjQaBkzQYa2jvHhe3OHQoHiPKTA8RuopkAnUmvZNQpcg/a5xI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1258
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
Content-Type: multipart/mixed; boundary="===============0140189416=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0140189416==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB24405F71791676A64CB02D9EB4830DM5PR12MB2440namp_"

--_000_DM5PR12MB24405F71791676A64CB02D9EB4830DM5PR12MB2440namp_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Not sue if this is right direction, I think usermode wants all synchronizat=
ions to be explicit. Implicit sync often confuses people who don't know its=
 history. I remember Jason from Intel  is driving explicit synchronization =
through the Linux ecosystem, which even removes implicit sync of shared buf=
fer.

-David

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Marek Ol=
=B9=E1k
Sent: Tuesday, June 9, 2020 6:58 PM
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove distinction between explicit and implic=
it sync (v2)

Hi,

This enables a full pipeline sync for implicit sync. It's Christian's patch=
 with the driver version bumped. With this, user mode drivers don't have to=
 wait for idle at the end of gfx IBs.

Any concerns?

Thanks,
Marek

--_000_DM5PR12MB24405F71791676A64CB02D9EB4830DM5PR12MB2440namp_
Content-Type: text/html; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
2">
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
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
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
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Not sue if this is right direction, I think usermode=
 wants all synchronizations to be explicit. Implicit sync often confuses pe=
ople who don&#8217;t know its history. I remember Jason from Intel &nbsp;is=
 driving explicit synchronization through the
 Linux ecosystem, which even removes implicit sync of shared buffer.<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-David<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Marek Ol=B9=E1k<br>
<b>Sent:</b> Tuesday, June 9, 2020 6:58 PM<br>
<b>To:</b> amd-gfx mailing list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: remove distinction between explicit and=
 implicit sync (v2)<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">This enables a full pipeline sync for implicit sync.=
 It's Christian's patch with the driver version bumped. With this, user mod=
e drivers don't have to wait for idle at the end of gfx IBs.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Any concerns?<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Marek<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB24405F71791676A64CB02D9EB4830DM5PR12MB2440namp_--

--===============0140189416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0140189416==--
