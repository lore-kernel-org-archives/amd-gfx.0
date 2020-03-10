Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E4BC18E5B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 09:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE8620663
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 09:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1qr7rITu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE8620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98D086E15C;
	Tue, 10 Mar 2020 09:01:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56CC96E15C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 09:01:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zlt/XDa8ruGofr1ehehH/HCPj2TJGje+8QASfEeepoPDJIAaPkNrMYy2q/hU6MBywYHfy/bN66I+VEoNxdZlEXIntip6eEVZ0hq6bqccvTeerS2lssJw8JWVv0cW3OQ9/Dt4J1uWfkwWURRONGPPaS6FV0z5AsogfbRb1lwqYg4ICLyYAx0pCAfKQQXfAax0hLasI/AyEZng2GYdSymi/k2AFKpMaOs4MY2cCwoqIjWjCAB0xAu9BxM/DLzeiKC9JYdnkMt9b7xzr23UKPzICo2fJca9YL2KGGe0fMsuCUGFE3WBaL6XecGmvEBtbLzwZmmUcDljRktLumv8bWUCdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4QUlQzqDwKkhDshRnMLubB8LeRZuWrs4ji5fK31/Bw=;
 b=HtsyU+H0RSIp4GKND9kRmbz9pjO+6uvKhSU7Nr8GPHMesPSgmH6v3PmkV/DYWJKpjT0Hr2Ch9Aw80J8IqkmIfbcfHGWYpCKQnPbWwIN4m42ImB9yJDOoxbm6oEH/kGNOEQtN7t+kbugsD5bjEoa5BVezqBaH9jR3vSdGRQrg+G90uLHFgPLW2PHAvjoywu+svwSLrb5mvsZ5NbahwWSEkVRtx82StmF/1hANRwIaLFhDzpCpeOZNgk2sEHV87XrkeLetKv+mrbTSB0jx+Lq0gBO4s3XF8cUiFAt2zy8Yz0JAtlGqMcpCmRyK3C3lzwWZC+e+mvGxt5DpygXxS7+37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4QUlQzqDwKkhDshRnMLubB8LeRZuWrs4ji5fK31/Bw=;
 b=1qr7rITupDnMHrKlCYiik0fGMp0wV4g9ewMsNo+0YsC5tYBUK3RowXgy1P/VRyxriQzTQLMNL+UVyBRGdx56oUpMLMzxnxxutqbmHO7QeO3Wd3P3CBGpNlDIMBaAXAFp3bCpgCReT1Bk1LDCV8N0LZSvXG39lshMvgLLCzzPnao=
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20)
 by BYAPR12MB3094.namprd12.prod.outlook.com (2603:10b6:a03:db::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Tue, 10 Mar
 2020 09:01:46 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f%7]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 09:01:46 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Clements, John"
 <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resolve failed error inject msg
Thread-Topic: [PATCH] drm/amdgpu: resolve failed error inject msg
Thread-Index: AdX2t3DemT+t8diMQKysDPFlyWTrvAAAkwBgAAAh82A=
Date: Tue, 10 Mar 2020 09:01:46 +0000
Message-ID: <BYAPR12MB2806D68DBC6AA181EC5E22D5F1FF0@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <MN2PR12MB3663BFD340186E29FCDEC728FBFF0@MN2PR12MB3663.namprd12.prod.outlook.com>
 <DM6PR12MB4075BBF8C68B97067BDB2AB3FCFF0@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075BBF8C68B97067BDB2AB3FCFF0@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-10T09:01:17Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6f70939b-4e0f-488a-b711-0000bfca149f;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-03-10T09:01:43Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 0f4f8454-3d81-4286-bc34-0000d4aa9399
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [101.224.57.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5b4b896-4934-4004-df17-08d7c4d1a996
x-ms-traffictypediagnostic: BYAPR12MB3094:|BYAPR12MB3094:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB309404C158D8F522E048B9BEF1FF0@BYAPR12MB3094.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(189003)(199004)(2906002)(316002)(110136005)(53546011)(86362001)(81156014)(71200400001)(8676002)(7696005)(6506007)(9686003)(33656002)(6636002)(26005)(66446008)(52536014)(55016002)(186003)(5660300002)(81166006)(8936002)(76116006)(66556008)(478600001)(66476007)(66946007)(64756008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3094;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z3fGgjWHNhXcOcG5Yg6W0jJONGexl3Vfxwi1QSUZTwH6yntivCQeZSK9LQY2eLV/RXJJ8QzS6i3VHXwASHGPOj+DTJVY6TkikrYggvj2Ak21voEuLCIhh1UHIPwNwjrm+680zP3hTI/p8fFx98+iapaaGY8KlYDMVaj7u13ZHoBI3Gs6oL7igClLfbBYkdiOQ+W3suINSkRDg6oYuqfzEHTk77gm7pLKR/yvCMKdDsMH+BVldng/6S5iQkYh9Mjq3qIGiBauzVG8fLDdmNUC12Mit0RTsCr6D9lNkTu/ZSluhd62SymXnIMhaypmG32jiPwfWCaBEROLM172ceotGX8brcFHbL41lKJPhnNqn0Tf0AEiXFB1/ZRDkFLbbhowncHKfSZCMuHKzCdu7s6lfYeKB2KVZItiker1RlHpGgI2x6fx+uEywzvP2Vvt/EtG
x-ms-exchange-antispam-messagedata: 9EuPW0VchrHfHjgW+9/Rx0JNEikFfROWmChRgPLhHNYy6bzJA3G+W9Ji+Jk9b6wxOk4tKI/jHu8iJRXGJi5XhtnOjVXtxP4HEWERFwewnbdMHlU42b9YZSFeRKZVCgTIayFXOzlW3M2wznhJ5erk8Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b4b896-4934-4004-df17-08d7c4d1a996
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 09:01:46.8190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPODQyVUdczZns3Oidb6JFPeihtlp004I+w/bp5p5jFLckYnjqdHXSGlhAFMMi/dJrQvA18KCGSaFymWq33XVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3094
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
Content-Type: multipart/mixed; boundary="===============0907113458=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0907113458==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2806D68DBC6AA181EC5E22D5F1FF0BYAPR12MB2806namp_"

--_000_BYAPR12MB2806D68DBC6AA181EC5E22D5F1FF0BYAPR12MB2806namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Spelling typos in commit message. With below typos fixed, the patch is: Rev=
iewed-by: Guchun Chen <guchun.chen@amd.com>

invoking an error injection succesfully will cause an at_event intterupt th=
at
will occur before the invoke sequence can complete causing an invalid error

succesfully --> successfully
intterupt --> interrupt

Regards,
Guchun

From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, March 10, 2020 4:56 PM
To: Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org; =
Chen, Guchun <Guchun.Chen@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Li, Can=
dice <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resolve failed error inject msg


[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.=
com>>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Tuesday, March 10, 2020 16:42
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Zh=
ang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Chen, G=
uchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; Li, Dennis <Dennis=
.Li@amd.com<mailto:Dennis.Li@amd.com>>; Li, Candice <Candice.Li@amd.com<mai=
lto:Candice.Li@amd.com>>
Subject: [PATCH] drm/amdgpu: resolve failed error inject msg


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to resolve issue where during a successful error inject in=
voke the associated at_event interrupt causes a false negative and outputs =
an error in the kernel message.

Thank you,
John Clements

--_000_BYAPR12MB2806D68DBC6AA181EC5E22D5F1FF0BYAPR12MB2806namp_
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
<p class=3D"MsoNormal">Spelling typos in commit message. With below typos f=
ixed, the patch is: Reviewed-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">invoking an error injection succesfully will cause a=
n at_event intterupt that<o:p></o:p></p>
<p class=3D"MsoNormal">will occur before the invoke sequence can complete c=
ausing an invalid error<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">succesfully <span style=3D"font-family:Wingdings">&a=
grave;</span> successfully<o:p></o:p></p>
<p class=3D"MsoNormal">intterupt <span style=3D"font-family:Wingdings">&agr=
ave;</span> interrupt<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.co=
m&gt; <br>
<b>Sent:</b> Tuesday, March 10, 2020 4:56 PM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx@lists.free=
desktop.org; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Li, Dennis &lt;Denni=
s.Li@amd.com&gt;; Li, Candice &lt;Candice.Li@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: resolve failed error inject msg<o:p=
></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;<a href=3D"mailto:Haw=
king.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:Jo=
hn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, March 10, 2020 16:42<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a>; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.=
com">Hawking.Zhang@amd.com</a>&gt;; Chen, Guchun &lt;<a href=3D"mailto:Guch=
un.Chen@amd.com">Guchun.Chen@amd.com</a>&gt;; Li,
 Dennis &lt;<a href=3D"mailto:Dennis.Li@amd.com">Dennis.Li@amd.com</a>&gt;;=
 Li, Candice &lt;<a href=3D"mailto:Candice.Li@amd.com">Candice.Li@amd.com</=
a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: resolve failed error inject msg<o:p></o=
:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to resolve issue where during a suc=
cessful error inject invoke the associated at_event interrupt causes a fals=
e negative and outputs an error in the kernel message.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_BYAPR12MB2806D68DBC6AA181EC5E22D5F1FF0BYAPR12MB2806namp_--

--===============0907113458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0907113458==--
