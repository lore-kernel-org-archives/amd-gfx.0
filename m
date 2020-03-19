Return-Path: <SRS0=hs5v=5E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B81EC4332B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 06:14:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E48220714
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 06:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hE6LwBfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E48220714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC4E06E07D;
	Thu, 19 Mar 2020 06:14:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D29BA6E07D
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2020 06:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGmNrcbSDE03iR6LvHn1mnZO2n6V/QdW4jNVM+Lq3Bd/h35lUBhC0XNauqCDWppfK+e+1+8OJNcQj9leBByTZSmbsM40+rAjjxSQs9UuUFGMpGQ0L/EjlqTg16h1hZgubj4ZC+aO+MUE6LCYgrBFNK23kdhxq/J5d9qO7CzC0TdXi4XpU8BSst0NRpUmQngzhVY+a7vkJ1C1wm09/qTGnXZsIBddlQnoAL6mqerddbxG/AoDj6s434uY/XtqbQTQWXGH6dZCbO3WrTdVtO7Weq6XKfQvq952xatdPP4FNzc84YOu1DrfDN+6LjmW7vUAIVIKO8SwmbXEkeh8ePCAYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyWbYSC/b8c0nmcZeAuklA7awgBhm6dodhCXR/Ah6O8=;
 b=hbBLdHn8r3VCbAWmo8JK6rtRpT06Zj5st6LCIYvjWV4q0oOYUzCFpHy9xc7j6ejfHGQfXc8aBJPcjFLCarwV0Xg22LlOxJc0Lrfp+cieFsfPtWM6bk2Qc+TPElZLFgiqcHGkUXFPZn1FLdag46HuxrSvSWRf5pkLwH7TCnACmKG7WlJsbol8cVpVOHBomM++NuC8BjREzJxVt0P4TIjOc3E69Abo/egphc2sDOAUTQ3Zo7mFutdPprkW126Ot81NQKId0ZS/HO4/SKv0ZTGH4o+6XcbECeLkJxPHmV1VUt1ZuM+IzF/ItlZTAra2JKDToyUxJl4hjIbJJA0q8V3jMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyWbYSC/b8c0nmcZeAuklA7awgBhm6dodhCXR/Ah6O8=;
 b=hE6LwBfndwarCNMGvar9dvmlzui20IAvajsL2CwswI2Rg7JNEJyvrYaX6Rn52Wx45VapYwIkcY8t0hURoJpgo86s5JxKHzZrmKRcGlKF/xFf37B3wcptEVeVyPpymWGtZabXJeoGbrRhmnhnRDYfRE1oY9MOYayesSOwRl1KrQw=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2666.namprd12.prod.outlook.com (2603:10b6:5:4d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16; Thu, 19 Mar 2020 06:14:18 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 06:14:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: protect RAS sysfs during GPU reset
Thread-Topic: [PATCH] drm/amdgpu: protect RAS sysfs during GPU reset
Thread-Index: AdX9RCQVSI9ZMbqdSK2p2WF8PrfNngAcXCww
Date: Thu, 19 Mar 2020 06:14:18 +0000
Message-ID: <DM6PR12MB4075DD80328DBBCC02D0C615FCF40@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB366319CB1D5C555E104DCA90FBF70@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB366319CB1D5C555E104DCA90FBF70@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-18T16:43:08Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=008f71a3-e69b-4a8e-99e5-000051632fbb;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-03-19T06:14:15Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: aadfbfe3-937d-4a5f-957d-0000af0d0a5e
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 397424bb-4b36-4262-067d-08d7cbccc1ee
x-ms-traffictypediagnostic: DM6PR12MB2666:|DM6PR12MB2666:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2666F02D8590AD244FCA608EFCF40@DM6PR12MB2666.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(66446008)(71200400001)(8676002)(81166006)(26005)(53546011)(2906002)(4744005)(6506007)(81156014)(186003)(52536014)(55016002)(478600001)(9686003)(316002)(66556008)(8936002)(76116006)(64756008)(66946007)(7696005)(5660300002)(110136005)(33656002)(86362001)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2666;
 H:DM6PR12MB4075.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tx1Tt7uPGTzDZWY0yV7dhlFV+355lkYyqDeraxtRkltJZW9QmzcpdksyW6yIAd9RHUlnejmqkvoHBuItixaidRdxQaB+AjI6THQ9CqiLBENIh/9Pbt1BRCFWQF6DGM5/OxAS+rHSH6yI2lLUXRxsm/AeEANNiMgH/uyxty8deQqZmnQNUxUDcY0L2N+a18jMokNCeb4BBB2/0hYTit8n+8QaM8oRyjrskG4F5nB1hsnwB0ehAXNaD9wlmqX4KmteTJAFsgBTStuYp3PNNkexu8ChLccf5b6rihPpawYYleWNVU8eDzH+mp9BH2EuiGYyj7SXsLSBAqxl44NsGTgv1PBz0rVCGj3TycTnGbdNzZL6hBYvVTZNc03MdGIcCQJqElxxgZBVJdUdR5t8V8AdVNkWPzDLICPBD+R1n5izovrkD0SShdn2YG5Qs7SPfgXt
x-ms-exchange-antispam-messagedata: Kpz6GFrhHbY4Z3FG37aH1Yvdi1HTL9020VQBFDSvBw1fL+cV/+6tpArkBucqrcuIzYa5tifeUXe3fag23upAAr4U4AdVCsMWA6o8RQdkUKvQGtKa9QBKdsbfYpO8e0orxSMkdskzLylPBJkIiSGXww==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397424bb-4b36-4262-067d-08d7cbccc1ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 06:14:18.2747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LT3lFMMeCuQXraJQe7CfpFqQBGyC8Pove163WFyiLKhoYGC2CR20ngpGuStZrpiDG2lm3/AzHGs2pJZjBNL29g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2666
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
Content-Type: multipart/mixed; boundary="===============0780525191=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0780525191==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075DD80328DBBCC02D0C615FCF40DM6PR12MB4075namp_"

--_000_DM6PR12MB4075DD80328DBBCC02D0C615FCF40DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Thursday, March 19, 2020 00:43
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: protect RAS sysfs during GPU reset


[AMD Public Use]

Submitting patch for review to protect RAS sysfs access' during a RAS event=
 and to clear the MMHub EDC registers early on in a BACO reset

--_000_DM6PR12MB4075DD80328DBBCC02D0C615FCF40DM6PR12MB4075namp_
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
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
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
<b>Sent:</b> Thursday, March 19, 2020 00:43<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: protect RAS sysfs during GPU reset<o:p>=
</o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch for review to protect RAS sysfs acc=
ess&#8217; during a RAS event and to clear the MMHub EDC registers early on=
 in a BACO reset<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4075DD80328DBBCC02D0C615FCF40DM6PR12MB4075namp_--

--===============0780525191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0780525191==--
