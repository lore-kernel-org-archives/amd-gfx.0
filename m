Return-Path: <SRS0=hs5v=5E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BBAC4332D
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 07:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 253882071C
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 07:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jjAe6pHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253882071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C3BA6E0F0;
	Thu, 19 Mar 2020 07:12:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE7E6E0F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2020 07:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U44Fsn0+0B5uTBo3RqunJ0E2zQEl9+qsjyj2AAw3MdjRfZp+Fr/OVBPl4JlPgCf4oRwxc8InC4SwqdGdPqAEUmV4lqu9uqnkpTjm+eAjzNWkzYFDi3z84uqkEfhUZbJfZVLAAFVP0aOdtKToekMZ0R3MS7Y4el0sg2670lH/1Ms1THM+j4IGUovSLycnvUUWlNKbNbbNm8uQq8uZEdrf4wh+xmfd6vhiD4Y43A69Y7tSVlke+WVtgweA+Np1fJ7yWGZ+wmf13dI+aVzW5o9G6utIfgI/9wZjQlPJhDS5Cw5v7iFW5h9D4b50MtDU4fUElNwx36iV2QdT8XkwMDt+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Xl0HTNs32vsujktyQw1Of4Aa6865W/oLGcJT+MkZok=;
 b=BPMSo2wlLVcGM3/+5ryc8PBfesdY56pCEAJPMtS/GDkW2iMkeLoqZeGMOqeg15CA0IGwTo03Bv70QpbkAJu15RIn0r4oLKrU3Jetw0c7qQ06dXVRJAh8rbjHUP4URDTuh6Q0SHAjBC4R9hVWTZKYCZIblvPhLYAnUYt303r78Y9pmbycCFN/pDotFMZPHiFIbCAh5cmdN5QduCJWHUKCX2xRBhrH/4lLmwg9DbWb/mk2yAy2P6cwk46jQFQ6/B8DmbHi5JZzB1Sy3K+q6ZuLQmOAe4+tNYntmxDQwjdcmH7/i0toWjIgGVkRsKEvyOD6oJAwzkXB0X39s6ArySNEow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Xl0HTNs32vsujktyQw1Of4Aa6865W/oLGcJT+MkZok=;
 b=jjAe6pHg9tGHS2otqK6XVPmYOqJ2j8veRdLyf2UB/FKQVVoLPvToOW3O+bpfyS+Gz28FpGPpauy3IfBfQfMKzBqCOq/aLEumIebw93TLbcVv510Hwp8lgeDIQXNkMpzQaWRnxvlQibEFgXlKMuF4vHA2rAot43Hzelw/2ClxkMQ=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Thu, 19 Mar 2020 07:12:04 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 07:12:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: protect RAS sysfs during GPU reset
Thread-Topic: [PATCH] drm/amdgpu: protect RAS sysfs during GPU reset
Thread-Index: AdX9RCQVSI9ZMbqdSK2p2WF8PrfNngAeYBIA
Date: Thu, 19 Mar 2020 07:12:03 +0000
Message-ID: <DM6PR12MB4075603F944A6C0638D9C55DFCF40@DM6PR12MB4075.namprd12.prod.outlook.com>
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
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-03-19T07:12:00Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: e334b51b-fb28-47cd-9286-00005a6957c4
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4636ddd0-96a9-4c6a-70d0-08d7cbd4d3a6
x-ms-traffictypediagnostic: DM6PR12MB4234:|DM6PR12MB4234:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4234CC3C6DE4EB893F716ADFFCF40@DM6PR12MB4234.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(199004)(66556008)(66946007)(55016002)(66446008)(76116006)(71200400001)(26005)(186003)(52536014)(5660300002)(2906002)(53546011)(9686003)(6506007)(478600001)(64756008)(4744005)(66476007)(7696005)(110136005)(86362001)(81166006)(33656002)(81156014)(8936002)(8676002)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4234;
 H:DM6PR12MB4075.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qRiHoaDWheA+wd7xFlEk9pDmHSfgdQp9ItkKcKQf9iZ9EuRODxtVQTGPG+HpxGt1Wz3S4SQtKC/mubpPioBgdmg8yuo+mCF9Av04nzHcge/bxP89VAriV0yQUdcmvUQIsZRDVCFUiatf2YrMcZ/I6+jwR2r5+LblTRgDVOje6bIxsPP4ESfxd2LmcgRZhnhxFxkJjQz3za16IXL2ARJkGzR/lY0vXGkiNlM6RIrQR7wGeDdIdBEfSgapeuVXgHqi2Y6wDRDZOxKSz0Hs0MxKfq0cF4KfObaZVOTlPO5BqwPZYLpsV7GFd5GXXvDHuja6bCmO7E+/Y6ZJ0ExeByxuT8VUNbvesNAkuIKrLqnALPUBncwTeKiX6OqLTPFEmwxGWe4pCwvmU/fYNQoY3NqW2gxtuX+9FeWuy3BM2KhJsMeAS1TdboQAKDvzTzEVle7R
x-ms-exchange-antispam-messagedata: T2RNKRkvdUG93EjmeFLrNBeBDeMST2OMigr1G+tQzps4Ruwlxd93EcbXaFe0p25YkEUBboOC/Q764XgunhGJ0L3LN6etQMvWkZoHAxq4HCj/T2ql0dmOZ/l4mdJNPCC/igfnSkMpohjeJCrZlrT97w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4636ddd0-96a9-4c6a-70d0-08d7cbd4d3a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 07:12:03.9475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xL3DeU/1SE6I1TdU+YXePqlHpAH5wnNvOsUdXzSjETnyZxNiaIprqgCLZDH5KwaR6jV41pfmZB/SUI3q4RfWXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
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
Content-Type: multipart/mixed; boundary="===============1959643975=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1959643975==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075603F944A6C0638D9C55DFCF40DM6PR12MB4075namp_"

--_000_DM6PR12MB4075603F944A6C0638D9C55DFCF40DM6PR12MB4075namp_
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

--_000_DM6PR12MB4075603F944A6C0638D9C55DFCF40DM6PR12MB4075namp_
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

--_000_DM6PR12MB4075603F944A6C0638D9C55DFCF40DM6PR12MB4075namp_--

--===============1959643975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1959643975==--
