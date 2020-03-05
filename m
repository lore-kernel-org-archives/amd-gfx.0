Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4261C3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 10:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8039420848
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 10:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LRzly/10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8039420848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E0316E1A4;
	Thu,  5 Mar 2020 10:19:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70FA26E1A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 10:18:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLfLOsUb7L88m/LbYyN2tqqE5wPIiz/uUHnM8v4lHYBNp0EXleckS6vPUAOxRJyf+vHZbsgQAJdKQQH3TO6n/nzGs+1eo0sDa5MtEzcSEwQ6NZZzG7tf9E4SRQz4dEKT/hMcmyX0vZ/bm/1zXeI2a5AD0seridiuc3rEUqtmbbw7aIhkKW9jqNb+dNcs1jVC+/4o+pxRrpl84Itr/VFGFBJW8i/Meus7BvOqsq2H4Vj7o8qLvgSNnuhyI003XHhm+RAcUHf1SuexEZ4/D9Nktuw49lB1QKiHozfzqdj1ifjS6qWLXjmCZr5eM6lqCmJbKeV5n9dSXALM5ZRKm69UVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Htc1XY4c/1C/6+5MlBVwJQbq803p90I1xxL6AlhgC3g=;
 b=MzWRKj/z4scz9cJHlG11meIGAfnocfyP0shVWHoubGG2DpSXgD5Ex/MW5djMiijr3qOxp4ocQ9Z/mb/As/S8ZtZ3MSv5hvOTqw0q7Szp7cesdf2ZRq2We72+lW7oNT+VydVXIi/wFI1m91Z0xwAXAjtAPBR9cOy9B+li8McrBXRxqiZB45NKYLGAWAdCHxlsK0T0f8/7taPhZP9kSV1Fg11eQoo6IcgcXynVbuhbEDmuIcfDH9TI5HrnA9fY5U6KCW4AkMavVvJoqSR4DFM15Edv9soD102cJTunKEHVrAiVvo5z8NeBMuOiSTlJchZtvBLeaT5f3tZ+Zlc5fH2pwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Htc1XY4c/1C/6+5MlBVwJQbq803p90I1xxL6AlhgC3g=;
 b=LRzly/10np5zQviNNKlMhgxsr06th0MxYhu/b/f4QmjC5sAxYiThSdK2kL2jXG2WVBPUib9GajwHJiBRh+XnetxLenGB3L4qfSVBJ63lSglnTiZk57X+7AmpluoNOiCH1rsIuFDFJB64J8VU7DDTWsVXd3E8SJdVf6tNAv/VhIs=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (2603:10b6:208:16e::22)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 5 Mar
 2020 10:18:57 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7%7]) with mapi id 15.20.2793.013; Thu, 5 Mar 2020
 10:18:57 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1, 
 Tao" <Tao.Zhou1@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update page retirement sequence
Thread-Topic: [PATCH] drm/amdgpu: update page retirement sequence
Thread-Index: AdXy0f9EIn2WkBwySKekkStORNst4QAAeMzgAABOtbA=
Date: Thu, 5 Mar 2020 10:18:57 +0000
Message-ID: <MN2PR12MB366325AEAAEC19067ED553ACFBE20@MN2PR12MB3663.namprd12.prod.outlook.com>
References: <MN2PR12MB366376914E9DE0A1D1D39440FBE20@MN2PR12MB3663.namprd12.prod.outlook.com>
 <DM5PR12MB14180E64D6C5E62E05DA8D0AFCE20@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB14180E64D6C5E62E05DA8D0AFCE20@DM5PR12MB1418.namprd12.prod.outlook.com>
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-05T10:18:54Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 156e427a-3f24-4a5b-a3d0-00007f6f1134
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [114.88.224.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78f4ef20-8c9e-4cd8-a875-08d7c0ee9dd9
x-ms-traffictypediagnostic: MN2PR12MB4094:|MN2PR12MB4094:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4094D1861311F6FBF98375E3FBE20@MN2PR12MB4094.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(189003)(199004)(2906002)(9686003)(15650500001)(6506007)(6636002)(55016002)(26005)(110136005)(81156014)(8936002)(7696005)(53546011)(81166006)(186003)(33656002)(52536014)(71200400001)(86362001)(66446008)(5660300002)(8676002)(478600001)(66946007)(66556008)(64756008)(316002)(66476007)(76116006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4094;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QAjxPnghPJeO46BvRNpZAK7FzXrs5NGYC1rhhZxgEnIxG0bvHGMyYOZVmjpz+7CPZu30s5vlNFDSMKzbSOnCHeEoLXUjUPCYIA8XyxPFNeT0rfnbvlSaQNtowfY5pSWH4eeu1qJWV7+5P/OBPzcNoZ5wjSQ9fl978SRxVNJ3+XgkyZfHjwFcDlCm9kVs93xmW/n8JZeQG4CwyH3PetkGCEhwMTkDDXqW6qE0NKeOFDSuVwpAegntxwYGQAmdxnhRvBSaxlV8NrYYPX6O3232GmoxEPR6yhVuipb8Kdalwq1mmq9cExoTc8YT3YasGA9QcubeMjfRHAVIomixTvJ0TDoq1J48i7TVwgdBI/DppFiHRkqeZOIKNbbEMg8x7tv8bvXniD1yofMg2G8Fonw+TSzO/3cdL0QNFRb/+dCsD+F7z7yrr6BgwIujJ5czLykx
x-ms-exchange-antispam-messagedata: Oyn1OLk4noStlP8bGe8idWsGFcVNomiS3cJkXQ3yctNW2A0OLt7ENh0syhLoAntKwdzPeYeNZclr3M5uSxfJY5uikHF6Q13IOiW41J+qOLZZcem321r6aVjdslQSBDF1xmidSNWGpYfAXugIvm1kbw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f4ef20-8c9e-4cd8-a875-08d7c0ee9dd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 10:18:57.6652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /II5bxzykleveI4lKDa/p/LPdEI8kQVNm+FddYeb0T3tpHfOFJImrHA1ZW+WpRIMxWnHSVds3vp3qW0bPXy5Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
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
Content-Type: multipart/mixed; boundary="===============1617001550=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1617001550==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB366325AEAAEC19067ED553ACFBE20MN2PR12MB3663namp_"

--_000_MN2PR12MB366325AEAAEC19067ED553ACFBE20MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

In the original sequence, if the key bits are not set in the mca_status, th=
e page retirement will not happen and the status register will be cleared.
If there is a UMC UE, that register will be cleared erroneously 31 times.

If MCA Status =3D=3D 0 already from the beginning there is no reason to pre=
ss forward with the rest of the checks and clear the register.

From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Thursday, March 5, 2020 5:56 PM
To: Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org; =
Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Guchu=
n <Guchun.Chen@amd.com>
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

--_000_MN2PR12MB366325AEAAEC19067ED553ACFBE20MN2PR12MB3663namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
<p class=3D"MsoNormal"><b>From:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.co=
m&gt; <br>
<b>Sent:</b> Thursday, March 5, 2020 5:56 PM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx@lists.free=
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

--_000_MN2PR12MB366325AEAAEC19067ED553ACFBE20MN2PR12MB3663namp_--

--===============1617001550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1617001550==--
