Return-Path: <SRS0=YZDW=DB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02A3C4363D
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 10:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A5423977
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 10:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qRXuH1VW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A5423977
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D346B6E1F7;
	Thu, 24 Sep 2020 10:55:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A48C06E201
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2020 10:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoILbpxTUApwHqjX4GCjAN5GLsnE1tIyyK27D+aJeTqgn6EAq6TrzFgCX2qOUWATf2YOksURIc1BxY3nQn3tWzMur10dAoxAnUkUw7oBPnpHnbWnovfPXGzE4ox1o5cSPYSPKCXZmdIs6dgf9rzAmjUQiE9XI6cJnO3r5OjPSLP21H3a6QvZn22jR0SyqXPUYWiejarpWb/zeOre9SQX38athYNLNSMW+alko/6GWbVWY5HWmLHH38wXYlLOCl3W5486NwM3ok/QSIOC6S8uG7/Z8g0CSr2zFdrTTNeTm2/6EDrwcoGpvdyv3fqiNs/AfkWL6jgU3604DpKm8GKnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmWIuHdPn9ylU1c9RBVofs2Aeh4OGOovoKxG1f1zG8M=;
 b=mZc2y/0VRPWVjSZnbG6yRSqje0uvgeQPzjhb9qZfQVX5lcrDLLoQuXfcGcVWSjD9hLz7trOWPPqf5bpYvJUwMhgMYA+oWHMli4qxodrP0UoBynKHrbY6JH4aIKuzJEHynSwo+x3ntSW8xcviEsVI3vHPAbiC3wVgPwnTFTvcS64drHoGNtVoVxL1sd8lmgbxu+EadE6NXpRRNwroV3SU1DO1RHd3HWizZ7OVv+Nr82BPKj/VqB4FrPQdOVB/+KcwJMquJ2fFBmAjFdvz2OlCfU3rpmJN3oQv1zNnDZZJCEGYQG4Vg4263MbPSoJwss//laY5/8o33uJWylqQ8UzRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmWIuHdPn9ylU1c9RBVofs2Aeh4OGOovoKxG1f1zG8M=;
 b=qRXuH1VW+ABTQ8SNJbSdbxvfsSWpx0ib7GqPzZRy4TVfQ1QU13QodY7NvapOdkIZWLTsMtuhzDiPCt1rEu2ddx4kufx7WD/VbiK+YQ/+lF5PytZdhQEnyRLK0dDDsm50Gf9ccbGK4JINx8dVUXqeeE5MpqR9C3OEyYfR5oLwLlo=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1643.namprd12.prod.outlook.com (2603:10b6:4:11::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20; Thu, 24 Sep 2020 10:55:20 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 10:55:20 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>, "Gao, Likun" <Likun.Gao@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable sienna chichlid UMC RAS
Thread-Topic: [PATCH] drm/amdgpu: disable sienna chichlid UMC RAS
Thread-Index: AdaSXo9zLAYJjZoMS5uJ71KjY8zvewAAo3uw
Date: Thu, 24 Sep 2020 10:55:20 +0000
Message-ID: <DM6PR12MB40750093EFFD0507732A4E37FC390@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB4032E752E8201ABE9F7B48BCFB390@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4032E752E8201ABE9F7B48BCFB390@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-24T10:55:16Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=d30f8a5e-6b2e-4f05-a1d5-000069aa6733;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-24T10:55:12Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 18b0df9c-86dd-486e-b83d-000090893978
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-24T10:55:17Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: dd113d95-7216-48cd-8163-00002b8e91c4
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 11d7d754-e3c0-42da-022c-08d8607854b0
x-ms-traffictypediagnostic: DM5PR12MB1643:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB164356B54FF61C0BC68A847FFC390@DM5PR12MB1643.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vxj+xApAPd+81gXiH6UQua1jycW2c9IC4ykknp2q24slbZR/WJMC6aA1Z3gZJr7uFIf+usco2hRuJSFB9Rtw6CVvkTNwrWKldoduCru6CAyvjxcaOsKLw+2HmeTGNsGkGSMqypuXauWJoxtt8ymHsKPPVrqoAgzijqSP3oTUk2ercDHyhlfWWJpVzM2CNU96/39vfOa6bpJGF9u3gaeM+qjGGCFmbew/N28271oJlt9X73PrAsC6vsB1h5vY26smiIYrbtG8aeoNoQ1T70v+LorjOHyTTleQfrYeVGRBUhipkKx0aSlL1vQwmIsi97XQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(186003)(8676002)(8936002)(478600001)(33656002)(66476007)(66946007)(9686003)(71200400001)(64756008)(53546011)(55016002)(4744005)(110136005)(316002)(52536014)(5660300002)(6506007)(76116006)(26005)(66446008)(7696005)(2906002)(6636002)(66556008)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: hHjHGlRlSGTOAuCKH0Bx9RmzoehQGIAn4jHRJ/nCe76JNkYtZjpb5jc2X+wfp3+aNFh4gle8pO2F4mBje/6KD+aJAw330qp11pOYQlSSO+zYo70atISf9OBO0IFmEiUuC9eB/4SV4mXV+Fv/rGd5S46RC/y45HIQk4v3dlTRGXzL+qYRDa/arcrcGJeUFdxpG61m97l5iz88Gjv/XCOFTdszc8SDvJLATAY/pf5gsqXbF5N8qIR6DTxfk92IDv+6oWgqsI21+D4Wdxln4G+Il5qsrdNmf/+ov77g9rpyschDKUaV2JG53v0G/neMnoSSz+Y1lkzjK3Orh/BkpsjcUfk/c2+SJ3a+VSbME2aDx0I7PmWi5YYYoyfbeKzyUQlcC2yfqa9x/oRg8Aln0dcwheGof/vhefbwV/AJa3hA5hDrJYSnwx/JZ35JcseF8PfdUzbria0f57rVHlLd39WsoELnoSu/oX96UXCmozKsG1g2FFYnX4LEQ4+aYFnnkRfuP4ylpEffy6RIIZpiz6nFZkm/KMZT2KTqkzCylUvNp2//x9INBqqhhPlZJdA2l05UXrJZOE08QAs4hju5sbMrOYvdyBSvjP4+aTymae4oyRJ/4uMCMWc4P8QaFWc/Bg2UIUOkqLnt6fsKyuZoESF/kA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d7d754-e3c0-42da-022c-08d8607854b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 10:55:20.5142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mOXNOsM7xNERhwopA3BWQW9bC9uMqi6LPSjVOiIUDNkfqnDVD8X1b5rcBkwfXy7VRzJUE5LvQt38JDIyGfKouw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1643
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
Content-Type: multipart/mixed; boundary="===============1874860352=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1874860352==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB40750093EFFD0507732A4E37FC390DM6PR12MB4075namp_"

--_000_DM6PR12MB40750093EFFD0507732A4E37FC390DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

From: Clements, John <John.Clements@amd.com>
Sent: Thursday, September 24, 2020 18:37
To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Z=
hang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: disable sienna chichlid UMC RAS


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to dsiable UMC RAS for sienna chichlid

--_000_DM6PR12MB40750093EFFD0507732A4E37FC390DM6PR12MB4075namp_
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
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
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
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Thursday, September 24, 2020 18:37<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Zhang, Hawki=
ng &lt;Hawking.Zhang@amd.com&gt;; Gao, Likun &lt;Likun.Gao@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: disable sienna chichlid UMC RAS<o:p></o=
:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Offi=
cial Use Only - Internal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to dsiable UMC RAS for sienna chich=
lid<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB40750093EFFD0507732A4E37FC390DM6PR12MB4075namp_--

--===============1874860352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1874860352==--
