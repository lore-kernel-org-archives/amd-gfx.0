Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6232BC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 10:26:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E0ED206BE
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 10:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ze59qGfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0ED206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C45016E530;
	Tue, 19 May 2020 10:26:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4FD46E580
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 10:26:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcawGu90VuZGPk7HstaKa517qWX5kXN1wHVHuxwjxknXgOIykGGPINTpI1z0R2mGwtSquxm5XeNMrmS+uiBAIaFmV6jKjzl8mzAht52+OHSF6B1XtfPpG49MZngFHJ8q3Zoy7LxQPX28OO6UMuqJJ9IuPsBM9a+E8JScZkHSoScPyg50OKgCyMyPbzDTSPNTI2ycF11v43eaS8F2wHUfjweRhlYAQp9LwmWaBKBVZuEBhqSpH0crZ/250nXNUoRnj66XlDaDnK0QFuKDKTJyHcEUazrEsQCXYkxd0troV8EwqY479KQuPqbeq2Nm8CMqjAwwrtVsmZrKVHpL2dqDwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCBPJglhbpE79ztcCAgO+hewRmLPaUjSZ7pSj6Ymp98=;
 b=KURtsKr7o0PiULBbd3i6uiLzsf+VasuXPYz74r0bcRGlgu2RjxxXFtrBr+ge+6ZDz0TToR/3IEkbRP/3XG8n6hL8tid6bgyA+fkeVd+lNA2RnHP0V/ErrmsXzn2aBfKDeyRIWsQoBvTs02+C1A7TYYgxBr/diNzDpwRtRiJGe0mmoKyQU250MOAJ+lVT8tv7R5xAyPH/QjIx0LKfHKhtsbJYBd1iTKEEZJe/d7xT7DPtGYbmRzxr0XN8teAx919QKkoVdA8um4lEt3CRiT2n62XzOKpBnaDHTHizyQiyE67K3eZbkmvNPYMqxPwt6sgyv5vp27ixD2K7jaAhcMXL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCBPJglhbpE79ztcCAgO+hewRmLPaUjSZ7pSj6Ymp98=;
 b=Ze59qGfFF3ZO4595+eHyu+bGuZ7d8s13CudFWoPPGel5kXWlSqU2qhUZh34cFOvju8IxzubgCoris7evl5JLnLf9OOySFaykzn5oOEJUFY1ITtjiwA6Orde7aHTKB5rz/n7F9rQTS3X3DHpN1ct5anD7oimtTPutCoII6OnXcD4=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3692.namprd12.prod.outlook.com (2603:10b6:5:14a::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.27; Tue, 19 May 2020 10:26:42 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.3000.033; Tue, 19 May 2020
 10:26:42 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: resolve ras recovery vs smi race condition
Thread-Topic: [PATCH] drm/amdgpu: resolve ras recovery vs smi race condition
Thread-Index: AdYtvciAHbipIGpZT6qk0o/TamXupgACE0yg
Date: Tue, 19 May 2020 10:26:42 +0000
Message-ID: <DM6PR12MB4075736EFBC2A476F7EE3F78FCB90@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <DM6PR12MB4026718C8DD47807F9856F3FFBB90@DM6PR12MB4026.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4026718C8DD47807F9856F3FFBB90@DM6PR12MB4026.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-19T09:14:31Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6334e757-9313-4c47-aeb1-00001eb443f7;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-19T10:26:39Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 3a5c668a-cd0f-4fc7-b53a-000020e1bcc8
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a118e5e-5441-4017-5150-08d7fbdf1fba
x-ms-traffictypediagnostic: DM6PR12MB3692:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3692BF8FB65E350108F7659FFCB90@DM6PR12MB3692.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3zqq6gvUq5kRAGj+qaEdabH3dEqMzCjK2WcKFSB1BP/1ac+UtoeD3afygaRt2jHdEJed5OCpvPZ/PVv1Fn1BEBgLodXyHfmYgL9fP4S60uaX0KFp6jHoD8PB60Yo1d7fzTlJ3flGeF6/zUNDIZPl1MJTx0TV7m3NEE43LHNRZdo99UWV21PP3Harf1MJGB7iCJEpnVAI0q9MplLWGIatGpnkRo0ek+QY9+DJrh+Z2dStzm9NNZWUKXhbwY1n3zKBjigGIVqF3CphgtXB/1xbZqw0S+kEHFkqqAQpBaQny+m2kraJEECKB01lKlbUw7anRZPb/tCKQsp2kjJS6XO/G9Svzq0/1SPJpIy/q8YRC9wBYJzpKA0SRl0KhwLOz8gBDJxORgFgVjIcEBpulUch0IwWgQ6RVl2F2appMDuIUU1ZJxAJx6C0gQXA9ftWo3kj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(110136005)(4744005)(186003)(316002)(86362001)(478600001)(66946007)(66476007)(26005)(66556008)(5660300002)(76116006)(64756008)(66446008)(33656002)(8676002)(8936002)(53546011)(52536014)(7696005)(6506007)(9686003)(2906002)(71200400001)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: zF3nyrpDMkwsdOlkBpQzAjVBZdEtfX4no2D/p3Y5zvYhH3Kxi+v+vOtD9O5sHZHJd3t/zNsYVzH00T9FuqU/gzYFmkxUR6M104KozHV7NW8zeWBuGh9x3w2z/6zKRQkoaLzRJ/GPaHAl5aI1ipK81kjL4LCmxtNCLIls3TweqPwskuVlYV4S0W8q4GRHnPuMuamqgdZRrDk10SVjWOJTd37SFRU6DnzfKueAewifJYpiizr2MBhxeBDiyOxO+1oENdH2UhsKfwsi4uZcEAzxXs+e1k/NjVV/zG0atkLhYZTKdU/ydfO2IN/SzryAXuPrqWYEpdX/7OUVz2DYIXj+dFw7c045GcOWcoBJpl4zdg36GLoQ50+3vyMmPYDiyndHfi6oIHSrA3qdNHtrS9wYW1BW0zQD8VpItxCMdc2qbLeKM3RxT+NbzRvbtxjoRDEjyh7JGgn0LweZSvcL7ZtyI8wwqurHj3lQkm40Qo/+D9Z5y8noQlRDzEsCIQZlQqZH
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a118e5e-5441-4017-5150-08d7fbdf1fba
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 10:26:42.3254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPFuCwuoBMn65m/nnCshMWpfAXCQ0MZ2J8NsGSjDOji7/kdiV+bCXLb0XHqVwPUu9jetehJ76bjHqxohSsdtmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3692
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
Content-Type: multipart/mixed; boundary="===============1298582117=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1298582117==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075736EFBC2A476F7EE3F78FCB90DM6PR12MB4075namp_"

--_000_DM6PR12MB4075736EFBC2A476F7EE3F78FCB90DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Please only apply the check to arcturus - we don't need to check ras fatal =
error event on all the NV series.

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, May 19, 2020 17:15
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: resolve ras recovery vs smi race condition


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to block SMU access' via SMI during RAS recovery

--_000_DM6PR12MB4075736EFBC2A476F7EE3F78FCB90DM6PR12MB4075namp_
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
<p class=3D"MsoNormal">Please only apply the check to arcturus &#8211; we d=
on&#8217;t need to check ras fatal error event on all the NV series.<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Tuesday, May 19, 2020 17:15<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: resolve ras recovery vs smi race condit=
ion<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to block SMU access&#8217; via SMI =
during RAS recovery<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4075736EFBC2A476F7EE3F78FCB90DM6PR12MB4075namp_--

--===============1298582117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1298582117==--
