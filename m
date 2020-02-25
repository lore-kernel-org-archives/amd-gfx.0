Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC96C35DF9
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 11:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51CD921D7E
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 11:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l2mXLl6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CD921D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11076EA8A;
	Tue, 25 Feb 2020 11:04:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EF6F6EA8A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 11:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TawophL91nehHfsZoJ6DZ/mtvrDf+j9WnBHwvnTCORI1b0CcfPWVSXzA53DvS/wsscWGlTiBN+/pR8I6HLwB+lQ5zDyuy8M+wJ4+P3+BtKM6JB6orq0xO++u4BvzTsrInhF7BY6Ci+hNL0xJPyXNZFPDZbDRd7n9vRsMbTMU5ZsHmpVLiDSUf7XK2XzcGskR+pzzipdqNrx2kuWNlnPpY5KPz3THybOt+Y+GxO/jIeVOFldWuP/8m98VV8OEaEfb9XZe3+Y2RIOBWLtdWIlYob/2Xlhitcvg5FA+eYYMcZQHxhCEFgp85vzlbIiITK4CXPmv86/gb392u21dPV57qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtXdclGyJVb4QepO2KmFUdYAAUpO2DgWiH1EvlAZ57A=;
 b=i/6Yfjlfz7gSRq2rLLrLxm0PFiziIJb79BzJ0X90veKq597ATNX7dqz/XL1eWpaMatrq8NgMVrdQySiQsk1HYWVUaqmbGqbgZZdVn7iJ83Bw++GSwpplL3QcimDwSCM5Qnb0iCKjfGvP05pwW+d6oHyKTgV3uLPXDMEUBJs8w2v4MUdiB2wqyBe5UvNVKH2/FC9AqMDR+0C4+M/ml2zlaxtaoBD/MnxmgLfhEPJWjqenp8PnD1+oXeSNtLey01Ji5tMZvWSqqbb7RrzwJVZyUarySHTlz9ZbGVV56RnyApkValGHVkMp1I/EoqA/2z6oX+OkEZ4KaGeAutAJMksV3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtXdclGyJVb4QepO2KmFUdYAAUpO2DgWiH1EvlAZ57A=;
 b=l2mXLl6vks7V8XBEs5t6RjtVuhazl2zJsl+elbqzor5KH0JLkYlIsxMX7DhGNlLmftM7nMnD4NRTy68vEBpaxnKYvCeYhOSx6zxMUtAyID5yjcUd99wKWVpvr5tct7H/GUXfQ8u1i/UeprkrEq7sJXrWFWzO21/l47++lGvjQo0=
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20)
 by BYAPR12MB3111.namprd12.prod.outlook.com (2603:10b6:a03:dd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Tue, 25 Feb
 2020 11:04:04 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 11:04:03 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Clements, John"
 <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add Arcturus D342 page retire support
Thread-Topic: [PATCH] drm/amdgpu: Add Arcturus D342 page retire support
Thread-Index: AdXrwfXc71Ex/YysSc+kD4OiPsAZuQABg8TAAADEaNA=
Date: Tue, 25 Feb 2020 11:04:03 +0000
Message-ID: <BYAPR12MB2806044141C93D3D40BF7897F1ED0@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <MN2PR12MB36636BDD1DC83862F3F975D6FBED0@MN2PR12MB3663.namprd12.prod.outlook.com>
 <DM5PR12MB141825D44F7FCC06C1AD77A4FCED0@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB141825D44F7FCC06C1AD77A4FCED0@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-02-25T11:02:42Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=38d8b7ea-d20b-4dc7-9342-0000861c7259;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-02-25T11:04:00Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 22722320-c00d-40fe-95fc-000095c830de
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [101.224.57.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9220887d-992a-455e-fef2-08d7b9e26cfe
x-ms-traffictypediagnostic: BYAPR12MB3111:|BYAPR12MB3111:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB31111D919978F5D7B882279AF1ED0@BYAPR12MB3111.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(81166006)(66556008)(86362001)(81156014)(7696005)(8676002)(8936002)(9686003)(71200400001)(6506007)(5660300002)(186003)(26005)(498600001)(53546011)(55016002)(66946007)(76116006)(52536014)(110136005)(66476007)(66446008)(64756008)(33656002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3111;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2l28ab9QQyI19WZm0LUfPFbV+2p4GXmtNZoEdFCPO6Z/tBVTrOOzslaVcJraf4RTAPL3wK5E6lZCm9HfP1xLVxMjpF6GuCrO7wx5VUYszRb39b1sGNOZqlPObdvvv+2qDMNs0sjXGgpqf4RPG10MKnmVnRs3FHPEHAITKHZQHokWlTq73drePoJmogT/GHjEUU9SB+GriWS8+EBR6oriT3HluMuX+DUD5tYhazH7jj/d+2xuPydnOCGeP3UC54XkQI9Ddb5CL8HTPX7sG1S8rUUrL8YUmvuxQ+ZD7G4BZt5cjapKfRJQKQ2I0Dt27WdOlS2K+7ce7StYQJImBJfyw1t8QOGd/u6LAam39yuRPhEz/n/cJvNR7TUZpEwLTtjkRJasqdsIu5VknsamI59Ftfwqg2Hdn6tRrM9g8WAXPSyj2PvEk3IwJqtQFR/jjjBA
x-ms-exchange-antispam-messagedata: FjB0ZJyD2pKlF6s70KDDUT69ips0QlJ7P47CiW+i3fUE71VAClGYbhb2Q9BNrOp++fE44XtP6bL/5DE82IYltwpCJAogHT18YvGGWGRJwUGwcYcwkf2X+GIcTYRWuDDoRittHYIjVJQ2M58mXUXzbw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9220887d-992a-455e-fef2-08d7b9e26cfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 11:04:03.5574 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a+LZdhqEcodQkfM8JPXAHXTuUJbQPdamZxT8nllQVXktI9Ui5tCCeH3dGB6oRKxYwtwfQB8sLFvwZ/DpVHgiCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3111
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
Content-Type: multipart/mixed; boundary="===============2138008455=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2138008455==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2806044141C93D3D40BF7897F1ED0BYAPR12MB2806namp_"

--_000_BYAPR12MB2806044141C93D3D40BF7897F1ED0BYAPR12MB2806namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

case CHIP_ARCTURUS:
+                           return __get_eeprom_i2c_addr_arct(adev, i2c_add=
r);
+                           break;

This 'break' is not needed. Please remove it.

Regards,
Guchun

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Tuesday, February 25, 2020 6:42 PM
To: Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: Add Arcturus D342 page retire support


[AMD Official Use Only - Internal Distribution Only]

Please fix your coding style in the follow if/else code segment by removing=
 the unnecessary {}. Other than that, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.=
com>>

+             if (strnstr(atom_ctx->vbios_version,
+                         "D342",
+                                 sizeof(atom_ctx->vbios_version)))
+             {
+                             *i2c_addr =3D EEPROM_I2C_TARGET_ADDR_ARCTURUS=
_D342;
+             }
+             else
+             {
+                             *i2c_addr =3D EEPROM_I2C_TARGET_ADDR_ARCTURUS=
;
+             }

Regards,
Hawking
From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Tuesday, February 25, 2020 17:58
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Zh=
ang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Subject: [PATCH] drm/amdgpu: Add Arcturus D342 page retire support

Add support for detecting Arcturus SKU to resolve the correct bad page reti=
rement EEPROM I2C address.

Thank you,
John Clements

--_000_BYAPR12MB2806044141C93D3D40BF7897F1ED0BYAPR12MB2806namp_
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
<p class=3D"MsoNormal">case CHIP_ARCTURUS:<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return __get_eeprom_i2c_addr_arct(adev, =
i2c_addr);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This &#8216;break&#8217; is not needed. Please remov=
e it.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Zhang, Hawking<br>
<b>Sent:</b> Tuesday, February 25, 2020 6:42 PM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Add Arcturus D342 page retire suppo=
rt<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please fix your coding style in the follow if/else c=
ode segment by removing the unnecessary {}. Other than that, the patch is<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;<a href=3D"mailto:Haw=
king.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (strnstr(atom_ctx-&gt;vbios_version,<o:p></o:p=
></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &quot;D342&quot;,<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; sizeof(at=
om_ctx-&gt;vbios_version)))<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *i2c_addr =3D EEPROM_I2C_TAR=
GET_ADDR_ARCTURUS_D342;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *i2c_addr =3D EEPROM_I2C_TAR=
GET_ADDR_ARCTURUS;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:Jo=
hn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, February 25, 2020 17:58<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a>; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.=
com">Hawking.Zhang@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Add Arcturus D342 page retire support<o=
:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Add support for detecting Arcturus SKU to resolve th=
e correct bad page retirement EEPROM I2C address.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_BYAPR12MB2806044141C93D3D40BF7897F1ED0BYAPR12MB2806namp_--

--===============2138008455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2138008455==--
