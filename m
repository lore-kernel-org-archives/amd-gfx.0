Return-Path: <SRS0=0vKA=BN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0969CC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 06:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE1E206D4
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 06:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D4bvcmme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE1E206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D56BB6E20D;
	Mon,  3 Aug 2020 06:24:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99ECD6E20D
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2020 06:24:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R81ldefN6DjrX+Skba073x5sObgtVXwEBdIw7a9OyJgsTr9ULVwnL5oX3JzPYdRUDudBbp1rDAligh6kqC2ZFLKVU2j4MVsKX3r3iM1KR1rl25fxLDKpNf3kSzlsfYxY2lkKei28UFO5ZEmDuhK3hJEi9nCKtzzgSDooW/cgX78bM/xMFgs13XKiaXpzUoF/yiFGkszliWJCGqvK9cc2ljVEWDMZbp4lg0Y87rP2o+G5CwopC+qIbIbA/mMMEask1pkxmEEGibHpSWpU2SdU+8uEKjpUZnT7bmfQrIvFdKjH51MqUIdsbGAib96HJOm5VddUsZwpzeG1MgmU2azM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdUJIYcMne3CQbcO2S2Q/dExLKRHN19clDFWzMCTkeY=;
 b=KEEw8ATZGVObg3f6EGUJC/ZFvI96Sp5i/XPVYRpS+rf60uQbvmc2lwHVt6d1mGk3b1VQQyog3iMH1w7nyRnGS0I5fVCM8SOGPtxwWwTPwFfpMIH5w3WyhXBK2EY5sprNxS8xomhioO8TOo2jLmS7+oHimOJxJvuEGVYRvb6ZVDDPHILPVb46rY9r4e1Ox7dN7S1AY74DmA2AzU0PWX+S6Ju5bcmjNdPD936b3Gn52AHuGmBKZHA9N75aPUz0Z6IHVT01hgx14JLhZd00yvAe0WkcB4PXkpo5JS5Vj5B2ODcVmLbl1ICx/8bZzO7uBO2nTX9U197DiwQcnjUl3Hvqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdUJIYcMne3CQbcO2S2Q/dExLKRHN19clDFWzMCTkeY=;
 b=D4bvcmmeJvWRfhep/DyyNLufvRaAnahIZ7TENGIRnLIU0UyiN//COOKYDFA4G+SDEfCNA/7MHBg6zYRBsYrRyoN5QiAFCNnSD8lUPIs1+zBEZ0ZDuZWyFheb/ZZqqxxEIib5WusBe7xvI6AtPKmjV+Hlbw7P6JRq1ONoUhWeroY=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Mon, 3 Aug
 2020 06:24:33 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235%7]) with mapi id 15.20.3239.016; Mon, 3 Aug 2020
 06:24:33 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable RAS support for sienna
Thread-Topic: [PATCH] drm/amdgpu: enable RAS support for sienna
Thread-Index: AdZpW0yRASYpPXOeRrWELF9H7Dx0bQAAagtAAABtr5A=
Date: Mon, 3 Aug 2020 06:24:33 +0000
Message-ID: <MN2PR12MB4032B605EB95E9F1172F493DFB4D0@MN2PR12MB4032.namprd12.prod.outlook.com>
References: <MN2PR12MB403260349869815CF543201FFB4D0@MN2PR12MB4032.namprd12.prod.outlook.com>
 <CY4PR12MB12871927038F06D4EAA0D337F14D0@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB12871927038F06D4EAA0D337F14D0@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-03T06:00:38Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8643324a-d5bd-44bd-b7fc-000054a2e6d2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-03T06:24:30Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 1db7561e-6476-4801-9a15-0000f8759172
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3c601f5-b357-4eba-e3a5-08d83775e329
x-ms-traffictypediagnostic: MN2PR12MB4288:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4288BA8F8898197642FDBE8FFB4D0@MN2PR12MB4288.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QrgVXtKQs2zeuRN5wEatySOtr82pNJTbERWmL+j4QuOEjzvH0nQ34vUs9F58s/paSCcGnCvki+mkdC0Gjlyk9XUFZPEAgkFai617k4LckB4043E+VtXzHEjBkkF0FMAraeceNbOkE7QDRqbg7EvV+v1tm8F0i+5wD2gzjRHxa8CY8yqtnxe6eHG/b28xoUPOG2YtcuNR/F1t6zXw00TU70cVvnXPZDxjl+mRBOucGscNqWxqCo4/gjqaOoh2WkiPAF4T89/Ie2e4P71dT2O1syP37RULhM45XnS4Yqs8Q/k8nM14lzS0apAZg4EAy/A/cq32ydobg1I90sRkpyWSww==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(478600001)(110136005)(8676002)(71200400001)(316002)(4744005)(5660300002)(52536014)(33656002)(8936002)(86362001)(66476007)(66446008)(66946007)(66556008)(55016002)(6506007)(7696005)(186003)(26005)(64756008)(2906002)(6636002)(9686003)(76116006)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: LIVTMsfs7WbhnhPeLEnWciTJGMmx4ik3TaUF8oqQtHVGmLvhomFJg0rLvOi4g487xQU/sLScU9rKcI8pMm4FfoJ9lWXbBLoQOIM54Iq5gJuk+mwM8PaIHccsDWU4vMnGJkrJHwifCjzQNc+rJKmP4WbAfiDicno0hpkrrPZsVuuA4rakKafyfXaABn05dX7sljgDoGEu1aILIUoH9RvyQ1PSkd/sTCNY21K+ZpN+zRl+upXH7TRXr8JOuWc/jnfcCYF3rkfsoHAV3dhjQuZ8xEB6OeXPax+SAVjttZx/GZBPgYJUYPvr4JM1btg+csqrRXZauvWJ4mN37hOBK8YzXLetmlotyrXilhv9Npt5w8d5WMf3+Xc1HcUMdI+2H5se1aXF370PQAfT5eAu6tLUzZ4Muz+8OqFJaCVqqZGQVAWUVydaV+KqaLxt8or4JdcC3c/dJfNkW9LXPoQzScTmanPqbenS1Fgh9ZIvE/Ob0epgSXIO2MQ1ZweAGmRYTaVUnAj1vEtH9/GTQzGucNtqkpbRjQqF6QjqWJtoS4CqSs5MiVlWrXDRKSXpx4tDcBie1FCHR/9B8TniYOn7LVWKgYBcR+9tlInK+z1nlhNursYk567Fkfd3YmIXeWtA2fgPc29yTUklpdJxN8hJm9rNVA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c601f5-b357-4eba-e3a5-08d83775e329
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 06:24:33.3650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9w/vyk28ZlkNEcx4wkKkkKCkCas3F+DIUNQLBuvhqstRVR1fvxsKtENPtFvpC/LOzXggLv5NfjgMGwnuvTEEMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
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
Content-Type: multipart/mixed; boundary="===============1447427457=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1447427457==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4032B605EB95E9F1172F493DFB4D0MN2PR12MB4032namp_"

--_000_MN2PR12MB4032B605EB95E9F1172F493DFB4D0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Thank you Guchun!

From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Monday, August 3, 2020 2:15 PM
To: Clements, John <John.Clements@amd.com>; amd-gfx list <amd-gfx@lists.fre=
edesktop.org>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable RAS support for sienna


[AMD Public Use]

In patch subject, chip full name SIENNA_CICHLID is preferred.

With above addressed, the patch is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com<mailto:guchun.chen@amd.com>>

Regards,
Guchun

From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Monday, August 3, 2020 2:01 PM
To: amd-gfx list <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freede=
sktop.org>>; Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd=
.com>>; Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Subject: [PATCH] drm/amdgpu: enable RAS support for sienna


[AMD Public Use]

Submitting patch to turn on GECC error injection /query support for sienna =
cichilid.

Thank you,
John Clements

--_000_MN2PR12MB4032B605EB95E9F1172F493DFB4D0MN2PR12MB4032namp_
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
span.EmailStyle20
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
<p class=3D"MsoNormal">Thank you Guchun!<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt=
; <br>
<b>Sent:</b> Monday, August 3, 2020 2:15 PM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx list &lt;a=
md-gfx@lists.freedesktop.org&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&=
gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: enable RAS support for sienna<o:p><=
/o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In patch subject, chip full name SIENNA_CICHLID is p=
referred.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">With above addressed, the patch is:<o:p></o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Guchun Chen &lt;<a href=3D"mailto:guchu=
n.chen@amd.com">guchun.chen@amd.com</a>&gt;<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:Jo=
hn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Monday, August 3, 2020 2:01 PM<br>
<b>To:</b> amd-gfx list &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org=
">amd-gfx@lists.freedesktop.org</a>&gt;; Zhang, Hawking &lt;<a href=3D"mail=
to:Hawking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;; Chen, Guchun &lt;<=
a href=3D"mailto:Guchun.Chen@amd.com">Guchun.Chen@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: enable RAS support for sienna<o:p></o:p=
></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to turn on GECC error injection /qu=
ery support for sienna cichilid.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4032B605EB95E9F1172F493DFB4D0MN2PR12MB4032namp_--

--===============1447427457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1447427457==--
