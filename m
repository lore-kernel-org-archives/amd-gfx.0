Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F41C433E5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 02:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7090920714
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 02:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Lofn/k9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7090920714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D64A6E137;
	Tue, 28 Jul 2020 02:55:58 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700078.outbound.protection.outlook.com [40.107.70.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 296826E125
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 02:55:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAtkth3phJi2f71JVokxYi7au0qHzMuHinDVMIDyAwyGnd1jt5xhPXn7lwqC65PfJzJlvBdiIeu13SzhBNmrzEygMy6TzHBZawnU/qt1eOf5Hj8P7kYVrJ38vBcZRQeUSfDc8eli2QZxUXrFRDNB82YCvZmes474H7kYt9VaVaH4TsgYP9lJgbhstYioYfKixH36IXMVAFydzBBJKsDDyx7PbKwJej/VZpA0xirlfk2ewF+5PTNAq6f2rCV4DktfwUKYvMeyDLeyquiXkPhuKO1DNOkGcroW/5bkusZpSFvdN7+ONpA2ayF9t24i0uZXnPZfBik4tkx/O5zsE7dZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aobTvaPtGqo1f/4sNBPIVuGXnVWGPAqnD0JcWE7MF9I=;
 b=PVlB5tMG8dwba9RRTOpM7IK8oQ8Ntlp8ty+vpMDrpCZrAA5IIDhok1znZEKLxrn0Ne+uFAVzX4n6tvidRPmDQfZ1g2qAwTuXst62iPo7bjn15/0zqeBI827++yYdEFcSvLK8VfIffAKNRFAgn9+q1Z3Pg/bBmxzij7HXVGMitGI8AnyDCCd/G9wxWi6sqkSiWR374T7tc7Iosgz7n2vT0l8Cx/uoVdUAk6yt2Zu60LpiJ6Cx8rYkvyy9I3ZJ3NcU9L8aPIWmuf0a7MYOERYh7VTw1aEzxC75vXPAc4U/kAXkKiBQWEJZs8OfHInOdut4hMm9oUBfxZTfbRI3AWZhnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aobTvaPtGqo1f/4sNBPIVuGXnVWGPAqnD0JcWE7MF9I=;
 b=Lofn/k9aXk9IJJw/Oo4i0Sonxac/OevvUCVP0KXwIm8o/dFR7LNlqpp2Q76lyCD9gKnenv0nDg9+vFQpVPsUC4yEooqqXqs+pI10cKjxsFvQPNnFaMNCWnV29GUB89/pAa4UmAPsaLDw58JSdjkmDmlHqRA6XgmNZ3esRaK21QA=
Received: from BY5PR12MB4019.namprd12.prod.outlook.com (2603:10b6:a03:1a8::23)
 by BYAPR12MB3398.namprd12.prod.outlook.com (2603:10b6:a03:aa::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Tue, 28 Jul
 2020 02:55:49 +0000
Received: from BY5PR12MB4019.namprd12.prod.outlook.com
 ([fe80::c5e4:b405:5508:19d7]) by BY5PR12MB4019.namprd12.prod.outlook.com
 ([fe80::c5e4:b405:5508:19d7%3]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 02:55:49 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10
Thread-Topic: [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10
Thread-Index: AdZj8ChRB8kbyPg9T927y1qmSWUoxwAAomPAACXuepA=
Date: Tue, 28 Jul 2020 02:55:49 +0000
Message-ID: <BY5PR12MB40196338BA23F96BAE77652AFB730@BY5PR12MB4019.namprd12.prod.outlook.com>
References: <DM6PR12MB40262ED0408E4FD14160D1A1FB720@DM6PR12MB4026.namprd12.prod.outlook.com>
 <CY4PR12MB12877CAFF60DAB4B6DE3492CF1720@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB12877CAFF60DAB4B6DE3492CF1720@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Guchun.Chen@amd.com
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-27T08:32:21Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=af532301-b71d-4340-96dd-0000519c31b9;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-28T02:55:47Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 3d15c382-b7bc-467f-a5b9-000008a11080
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7caadcc-c101-48f7-f78c-08d832a1bc14
x-ms-traffictypediagnostic: BYAPR12MB3398:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB33983088574F35704D9E7EFFFB730@BYAPR12MB3398.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /MnLB2hXHxmvO+h68x9DCRPFPFKCERrYDOEqjOVT4WSnH2/r6hHUxtrVBmaoJIiClt/Sio8L2BJCqfHiHtrSS3hACfaL5cHe2r+NMvizFvFu+L3ST6+M2+pLgvQooFb1CRcwOPFpaL64VHsj5LeJPN4sPCrfsq7X72ujS11roQbGWsqb2n48S02qD97czzmXcr9Ngvs6TwZhHxsZgU6MSSQD0eXCfZWSot0iLdgKCA/0VM6IRyH/TzVd753sr/CtkhSvMtqiHLnWvjEZHL7LDAJh356kXKkkX+cewLkcHzIFqO3VxZvqZ+CxPlGbhRDZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4019.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(110136005)(5660300002)(52536014)(53546011)(6506007)(186003)(26005)(99936003)(83380400001)(66476007)(9686003)(55016002)(66616009)(66946007)(8936002)(478600001)(66556008)(8676002)(7696005)(71200400001)(66446008)(33656002)(64756008)(2906002)(6636002)(316002)(76116006)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: fgn6CaIeLzE+jammGn8rBt4ad5NYEKXlAHMy6Icky+noPmUWFmB3fg07yPwpxX/HwydZJE0Ce055zMi8ipuuwp4e2/32aUT56e5s4+3yX8UgAMUpkMeJArIjDTLmOSCX+oM6c7aiW/SwAs22fL3Rh4Q/2rxJG9zbU7XsLuvT7kdi05s2zqgluxK/wUq7BHx/+hC40cz6whjngtH8gHxpEhJEbl1b9Lv1DkFdUNTtc0B85LHc6Yi1+6llLRCjmVzT51/KuJYjboKEWUepCtwSEJQ+qHluepWUavYcv54+0+/ZmsGcG+AQ1PhCsQvRQk1GAj/ZVmJcQrzeKNN9Rh/8yz5S4DA7akhOB73K9ewBuSTumilaxRR8tCN5qjtzS2990p5ashaYC5OJ8zRPQsXo2dAjA9FwZvhwnTIttyTjBaYOZhJngoBpfmKdnHAtNZR4yOVEPZ0dVnw/YL7WpMoOet2btlO6N29VSrvYr5004Ful+zBIebwH1dUDF0kRJ8A6
Content-Type: multipart/mixed;
 boundary="_004_BY5PR12MB40196338BA23F96BAE77652AFB730BY5PR12MB4019namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4019.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7caadcc-c101-48f7-f78c-08d832a1bc14
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 02:55:49.7920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZQ77AlyGbqdSY/HlJszxrxa/LklaAznDqOlEL+pfSoPGA9SIPOGod+bOxeaUvPXmbEmaqoydJU9cD+U0Myvoqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3398
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

--_004_BY5PR12MB40196338BA23F96BAE77652AFB730BY5PR12MB4019namp_
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB40196338BA23F96BAE77652AFB730BY5PR12MB4019namp_"

--_000_BY5PR12MB40196338BA23F96BAE77652AFB730BY5PR12MB4019namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Thank you for the feedback @Chen, Guchun<mailto:Guchun.Chen@amd.com>,

I've attached an updated patch with the corrected typo and also an addition=
al change to add the new UMC source to the makefile

Thank you,
John Clements

From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Monday, July 27, 2020 4:50 PM
To: Clements, John <John.Clements@amd.com>; amd-gfx list <amd-gfx@lists.fre=
edesktop.org>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10


[AMD Public Use]

One typo in commit subject.

add support for umc 8.7 initialzation and RAS interrupt

s/initialzation /initialization

With this fixed, the patch is:
Reviewed-by: Guchun Chen guchun.chen@amd.com<mailto:guchun.chen@amd.com>

Regards,
Guchun

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Clements, John
Sent: Monday, July 27, 2020 4:32 PM
To: amd-gfx list <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freede=
sktop.org>>; Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd=
.com>>
Subject: [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10


[AMD Public Use]

Submitting patch to enable UMC 8.7 GECC functions in GMC v10

--_000_BY5PR12MB40196338BA23F96BAE77652AFB730BY5PR12MB4019namp_
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
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
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
span.EmailStyle21
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#317100;}
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
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you for the feedback <a id=3D"OWAAM9AC35672AFB=
14F88AEB8946109A01695" href=3D"mailto:Guchun.Chen@amd.com">
<span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decoration:n=
one">@Chen, Guchun</span></a>,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;ve attached an updated patch with the correc=
ted typo and also an additional change to add the new UMC source to the mak=
efile<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt=
; <br>
<b>Sent:</b> Monday, July 27, 2020 4:50 PM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx list &lt;a=
md-gfx@lists.freedesktop.org&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&=
gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10=
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">One typo in commit subject.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">add support for umc 8.7 initialzation and RAS interr=
upt<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">s/initialzation /initialization<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">With this fixed, the patch is:<o:p></o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Guchun Chen <a href=3D"mailto:guchun.ch=
en@amd.com">
guchun.chen@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-b=
ounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
<b>On Behalf Of </b>Clements, John<br>
<b>Sent:</b> Monday, July 27, 2020 4:32 PM<br>
<b>To:</b> amd-gfx list &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org=
">amd-gfx@lists.freedesktop.org</a>&gt;; Zhang, Hawking &lt;<a href=3D"mail=
to:Hawking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10<o:p=
></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to enable UMC 8.7 GECC functions in=
 GMC v10<o:p></o:p></p>
</div>
</body>
</html>

--_000_BY5PR12MB40196338BA23F96BAE77652AFB730BY5PR12MB4019namp_--

--_004_BY5PR12MB40196338BA23F96BAE77652AFB730BY5PR12MB4019namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-enable-umc-8.7-functions-in-gmc-v10.patch"
Content-Description: 0001-drm-amdgpu-enable-umc-8.7-functions-in-gmc-v10.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-enable-umc-8.7-functions-in-gmc-v10.patch";
	size=4196; creation-date="Tue, 28 Jul 2020 02:55:00 GMT";
	modification-date="Tue, 28 Jul 2020 02:55:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwZTJkYmY3NWYyNTI5NWU3ZjgzZGQyNjllZDNhMjQ3YTg2M2VlNDVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMjggSnVsIDIwMjAgMTA6NTM6MTggKzA4MDAKU3ViamVjdDogW1BBVENIIDEv
MV0gZHJtL2FtZGdwdTogZW5hYmxlIHVtYyA4LjcgZnVuY3Rpb25zIGluIGdtYyB2MTAKCmFkZCBz
dXBwb3J0IGZvciB1bWMgOC43IGluaXRpYWxpemF0aW9uCgphZGQgdW1jIDguNyBzb3VyY2UgdG8g
bWFrZWZpbGUKClNpZ25lZC1vZmYtYnk6IEpvaG4gQ2xlbWVudHMgPGpvaG4uY2xlbWVudHNAYW1k
LmNvbT4KQ2hhbmdlLUlkOiBJNTBiMzM5NDRkMGExMTY1YzE2NmZlOTBiNWQxMjg5ZDA5ODM1Y2Rk
MwotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L01ha2VmaWxlICAgIHwgIDIgKy0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIHwgNTAgKysrKysrKysrKysrKysr
KysrKysrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9NYWtlZmlsZSBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L01ha2VmaWxlCmluZGV4IDQwM2VjM2RiMjlkZi4u
MGJhMzk2ZTlkN2U0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9NYWtl
ZmlsZQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9NYWtlZmlsZQpAQCAtODUsNyAr
ODUsNyBAQCBhbWRncHUteSArPSBcCiAKICMgYWRkIFVNQyBibG9jawogYW1kZ3B1LXkgKz0gXAot
CXVtY192Nl8xLm8gdW1jX3Y2XzAubworCXVtY192Nl8xLm8gdW1jX3Y2XzAubyB1bWNfdjhfNy5v
CiAKICMgYWRkIElIIGJsb2NrCiBhbWRncHUteSArPSBcCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192MTBfMC5jCmluZGV4IDFhNzgwNzNjMmYwNS4uMzVkMjFmMzMwYjBhIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwpAQCAtMjUsNiArMjUsNyBAQAogI2luY2x1ZGUg
ImFtZGdwdS5oIgogI2luY2x1ZGUgImFtZGdwdV9hdG9tZmlybXdhcmUuaCIKICNpbmNsdWRlICJn
bWNfdjEwXzAuaCIKKyNpbmNsdWRlICJ1bWNfdjhfNy5oIgogCiAjaW5jbHVkZSAiaGRwL2hkcF81
XzBfMF9vZmZzZXQuaCIKICNpbmNsdWRlICJoZHAvaGRwXzVfMF8wX3NoX21hc2suaCIKQEAgLTU1
LDYgKzU2LDE0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc29jMTVfcmVnX2dvbGRlbiBnb2xkZW5f
c2V0dGluZ3NfbmF2aTEwX2hkcFtdID0KIH07CiAjZW5kaWYKIAorc3RhdGljIGludCBnbWNfdjEw
XzBfZWNjX2ludGVycnVwdF9zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKKwkJCQkJ
IHN0cnVjdCBhbWRncHVfaXJxX3NyYyAqc3JjLAorCQkJCQkgdW5zaWduZWQgdHlwZSwKKwkJCQkJ
IGVudW0gYW1kZ3B1X2ludGVycnVwdF9zdGF0ZSBzdGF0ZSkKK3sKKwlyZXR1cm4gMDsKK30KKwog
c3RhdGljIGludAogZ21jX3YxMF8wX3ZtX2ZhdWx0X2ludGVycnVwdF9zdGF0ZShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKIAkJCQkgICBzdHJ1Y3QgYW1kZ3B1X2lycV9zcmMgKnNyYywgdW5z
aWduZWQgdHlwZSwKQEAgLTEzMSwxMCArMTQwLDIwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1k
Z3B1X2lycV9zcmNfZnVuY3MgZ21jX3YxMF8wX2lycV9mdW5jcyA9IHsKIAkucHJvY2VzcyA9IGdt
Y192MTBfMF9wcm9jZXNzX2ludGVycnVwdCwKIH07CiAKLXN0YXRpYyB2b2lkIGdtY192MTBfMF9z
ZXRfaXJxX2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQorc3RhdGljIGNvbnN0IHN0
cnVjdCBhbWRncHVfaXJxX3NyY19mdW5jcyBnbWNfdjEwXzBfZWNjX2Z1bmNzID0geworCS5zZXQg
PSBnbWNfdjEwXzBfZWNjX2ludGVycnVwdF9zdGF0ZSwKKwkucHJvY2VzcyA9IGFtZGdwdV91bWNf
cHJvY2Vzc19lY2NfaXJxLAorfTsKKworIHN0YXRpYyB2b2lkIGdtY192MTBfMF9zZXRfaXJxX2Z1
bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewogCWFkZXYtPmdtYy52bV9mYXVsdC5u
dW1fdHlwZXMgPSAxOwogCWFkZXYtPmdtYy52bV9mYXVsdC5mdW5jcyA9ICZnbWNfdjEwXzBfaXJx
X2Z1bmNzOworCisJaWYgKCFhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHsKKwkJYWRldi0+Z21jLmVj
Y19pcnEubnVtX3R5cGVzID0gMTsKKwkJYWRldi0+Z21jLmVjY19pcnEuZnVuY3MgPSAmZ21jX3Yx
MF8wX2VjY19mdW5jczsKKwl9CiB9CiAKIC8qKgpAQCAtNTY5LDEyICs1ODgsMjkgQEAgc3RhdGlj
IHZvaWQgZ21jX3YxMF8wX3NldF9nbWNfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
CiAJCWFkZXYtPmdtYy5nbWNfZnVuY3MgPSAmZ21jX3YxMF8wX2dtY19mdW5jczsKIH0KIAorc3Rh
dGljIHZvaWQgZ21jX3YxMF8wX3NldF91bWNfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCit7CisJc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKKwljYXNlIENISVBfU0lFTk5BX0NJ
Q0hMSUQ6CisJCWFkZXYtPnVtYy5tYXhfcmFzX2Vycl9jbnRfcGVyX3F1ZXJ5ID0gVU1DX1Y4Xzdf
VE9UQUxfQ0hBTk5FTF9OVU07CisJCWFkZXYtPnVtYy5jaGFubmVsX2luc3RfbnVtID0gVU1DX1Y4
XzdfQ0hBTk5FTF9JTlNUQU5DRV9OVU07CisJCWFkZXYtPnVtYy51bWNfaW5zdF9udW0gPSBVTUNf
VjhfN19VTUNfSU5TVEFOQ0VfTlVNOworCQlhZGV2LT51bWMuY2hhbm5lbF9vZmZzID0gVU1DX1Y4
XzdfUEVSX0NIQU5ORUxfT0ZGU0VUX1NJRU5OQTsKKwkJYWRldi0+dW1jLmNoYW5uZWxfaWR4X3Ri
bCA9ICZ1bWNfdjhfN19jaGFubmVsX2lkeF90YmxbMF1bMF07CisJCWFkZXYtPnVtYy5mdW5jcyA9
ICZ1bWNfdjhfN19mdW5jczsKKwkJYnJlYWs7CisJZGVmYXVsdDoKKwkJYnJlYWs7CisJfQorfQor
CiBzdGF0aWMgaW50IGdtY192MTBfMF9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKIHsKIAlzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsK
IAogCWdtY192MTBfMF9zZXRfZ21jX2Z1bmNzKGFkZXYpOwogCWdtY192MTBfMF9zZXRfaXJxX2Z1
bmNzKGFkZXYpOworCWdtY192MTBfMF9zZXRfdW1jX2Z1bmNzKGFkZXYpOwogCiAJYWRldi0+Z21j
LnNoYXJlZF9hcGVydHVyZV9zdGFydCA9IDB4MjAwMDAwMDAwMDAwMDAwMFVMTDsKIAlhZGV2LT5n
bWMuc2hhcmVkX2FwZXJ0dXJlX2VuZCA9CkBAIC03OTAsNiArODI2LDE0IEBAIHN0YXRpYyBpbnQg
Z21jX3YxMF8wX3N3X2luaXQodm9pZCAqaGFuZGxlKQogCWlmIChyKQogCQlyZXR1cm4gcjsKIAor
CWlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7CisJCS8qIGludGVycnVwdCBzZW50IHRvIERG
LiAqLworCQlyID0gYW1kZ3B1X2lycV9hZGRfaWQoYWRldiwgU09DMTVfSUhfQ0xJRU5USURfREYs
IDAsCisJCQkJICAgICAgJmFkZXYtPmdtYy5lY2NfaXJxKTsKKwkJaWYgKHIpCisJCQlyZXR1cm4g
cjsKKwl9CisKIAkvKgogCSAqIFNldCB0aGUgaW50ZXJuYWwgTUMgYWRkcmVzcyBtYXNrIFRoaXMg
aXMgdGhlIG1heCBhZGRyZXNzIG9mIHRoZSBHUFUncwogCSAqIGludGVybmFsIGFkZHJlc3Mgc3Bh
Y2UuCkBAIC05NTAsNiArOTk0LDkgQEAgc3RhdGljIGludCBnbWNfdjEwXzBfaHdfaW5pdCh2b2lk
ICpoYW5kbGUpCiAJaWYgKHIpCiAJCXJldHVybiByOwogCisJaWYgKGFkZXYtPnVtYy5mdW5jcyAm
JiBhZGV2LT51bWMuZnVuY3MtPmluaXRfcmVnaXN0ZXJzKQorCQlhZGV2LT51bWMuZnVuY3MtPmlu
aXRfcmVnaXN0ZXJzKGFkZXYpOworCiAJcmV0dXJuIDA7CiB9CiAKQEAgLTk4MSw2ICsxMDI4LDcg
QEAgc3RhdGljIGludCBnbWNfdjEwXzBfaHdfZmluaSh2b2lkICpoYW5kbGUpCiAJCXJldHVybiAw
OwogCX0KIAorCWFtZGdwdV9pcnFfcHV0KGFkZXYsICZhZGV2LT5nbWMuZWNjX2lycSwgMCk7CiAJ
YW1kZ3B1X2lycV9wdXQoYWRldiwgJmFkZXYtPmdtYy52bV9mYXVsdCwgMCk7CiAJZ21jX3YxMF8w
X2dhcnRfZGlzYWJsZShhZGV2KTsKIAotLSAKMi4xNy4xCgo=

--_004_BY5PR12MB40196338BA23F96BAE77652AFB730BY5PR12MB4019namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_BY5PR12MB40196338BA23F96BAE77652AFB730BY5PR12MB4019namp_--
