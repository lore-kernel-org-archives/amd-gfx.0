Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4A2C2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86D3206E3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ALGIBZn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86D3206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E96D16EC13;
	Tue,  3 Nov 2020 08:15:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770070.outbound.protection.outlook.com [40.107.77.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A9CD6EC13
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 08:15:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inOcS5YgP8PsAOdw7KQ2VAC9No50EfL+rThfiPujkvP0sYDfrUk6JsYhnKH+PAXCQ5Ojrf+q++cNtpuVXxP/xufLjNpbmVGL8wIEB7H87itB9A4hkVc4l7cIhBKRa0Y3OSGWlBTEQ7ro+E6Cor3QrMjS8O+Eg9OEGyoi7zElLAVmqxjF4Z4iWGSjkXnkyJwP0M+3bvgJCUojjBgh9+bZeiKo8tByHAdWYriRl8mpj34TOHFLq6IWrmQLYJ809qaLIPnTORvMdJiuhn9ZQXCcXDdCds9p20S4zho8NEQHuHuPCsBIN+L7CyzQphNyHd8fN5OumoWYxpHBRgVK7A2T9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clYRcniIBNsjjkJObpp8/+kG8oDXge2qgmc52WUw4yM=;
 b=XLY0yaK+6wkFE2uW5YslsR91yAp0EA7pnw5iVT9YRSRJ4n2v63Q4H02HhV+E4/77UZ9vk6jPVyG/se+p/ed3TxreOpC+t9dVYGcFlJ9sVxFxugBb+gby5BtlNB/KY0oe4H76bJcK04sOtoL6OpjxIjIWRb2mOYWXnylTfqYC0vXymMnAYJZ7VVo1d2JDrF+8Ryx0YMaw1l+SSWHOR0g3W8s8yts84ZYksjUGRHIOSKLP5Tf1T/8RPyBilIzCqrpxei/PHp/4jRQSDh7px4sMBQu7f9a8LqbJB9kVW2wzTmPU7wVpipR6tWkQ8CabqO960laAdIrp6WltXyfpoGShAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clYRcniIBNsjjkJObpp8/+kG8oDXge2qgmc52WUw4yM=;
 b=ALGIBZn94lxPH6b/HB87hnLvvkYO9ni9uFkFLrXV0sJP43UfGYOVIlh8xSr3jqeirKilC6M0M/5Bq57EWCKGrnVhLVtQykEzqqpun7uUWodbyAW4exqEvU6GaMXmBFs//TryyG1iQF5ViLN5cGhwKr7yiAuGeEyW0W72OQrxanU=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR1201MB0217.namprd12.prod.outlook.com (2603:10b6:4:54::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.29; Tue, 3 Nov 2020 08:15:45 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 08:15:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: resolved ASD loading issue on sienna
Thread-Topic: [PATCH] drm/amdgpu: resolved ASD loading issue on sienna
Thread-Index: AdaxuFqoLbD+1kPMTHiv7p+c33suFgAAR9WA
Date: Tue, 3 Nov 2020 08:15:45 +0000
Message-ID: <DM6PR12MB40751720195E9237B8ED8CE7FC110@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <BY5PR12MB4019A6EA70A151DE464B45B0FB110@BY5PR12MB4019.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4019A6EA70A151DE464B45B0FB110@BY5PR12MB4019.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-03T08:08:31Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e977ac78-95e9-434f-a8bc-0000b4035723;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-03T08:15:43Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 0ea6463f-3a3a-4d21-8cc8-0000de170eee
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d54d88f1-c1eb-4538-567d-08d87fd0a9f5
x-ms-traffictypediagnostic: DM5PR1201MB0217:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0217649FB4C857CCBDC11610FC110@DM5PR1201MB0217.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8qP7tcfJYMTDdz3A+c0FeQL0zXKWHL1BmmgeSx4HZ5B1JDojj5BSciJ7raWJd8CJ35ab+1jBIcZRgFLlntaoMpsZ+Pw8ICwF+vbim9DGO33KibS05gdUaRp9PzXL97zsi+cbkuNHYn9/mMKNtSaouXpCNBzT6nwnvcV6yjOtxeeWgPjIrveh6AShgC5UYFbCRKMmyZuVRm2PkSwMc2hJg55BeJTTSeqGyZTUNrzBTSEHgcRhIOCn+FYjvHSsOOVAyfn24Zc9oIdSDDkGSR7s/gOk9ej2VYxyotSqYzpftZjS/My138ez8wxZxfsymVk2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(2906002)(7696005)(186003)(8936002)(52536014)(9686003)(5660300002)(53546011)(478600001)(55016002)(8676002)(110136005)(26005)(71200400001)(6506007)(76116006)(316002)(33656002)(86362001)(4744005)(64756008)(66446008)(66476007)(66556008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ci7bI/fOUKXg6OKj2Ei4EjgK/FJycbwZC2OkF1gUtns37eDveKUDnoq+WwadldYd9pg/yygbL/vUnAQQk596gSiGZWh2HdzYdZ8cjglGxQOFctCWIf4Vk/NMuNHb8G6ATI0TdimVZuIZBvnEb92JOcOMgcKWXHhTW4CwEbR4koIHoni31Gyv7hLJbzYoX2ZPD+n6Motcsku/CnkjzPVSYZ8GJtpL/W3RmPGOiD03BRkZ+2mALKNEcraN4CRLJBL0QNRWoeNUAgx3sHfvdHzrje7Sy5/tP0FIRnxZKvEfGIeYDOfuYW1UnuI/3M6LbNZhH1yHxE93ADGqhIPfFkKoRoxJXo0TvE0cVYl2m4vev3QdRzvPBXs+0BhkI3wVNaLHDHLCXThG+dHOfniixpUTDre1RosK4il3hhnj9g/VeRpgPI8gTeRcUQXb0EM3Yyr6B3t1Xdlp6nfr7xpJGch0JArMhDFwZ4EBCcw7hvBVRgzUklg/9Qal2QwXCaNkXItoVf8F5LGoX0DX6W+dRtYajmB7CuFbcs6ol/0Ecp6xXYaiEjD+OPyhSbT2LGrqPVReMAV2gVUpMmSOtZgBAg+HUGzWyR+Kgf4eSWHUOd2CaUkwYu8SiMM9WnQOS6c3KpIPkw8uvE4viDKvy358XRT2OQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54d88f1-c1eb-4538-567d-08d87fd0a9f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 08:15:45.3153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kZfU82JiwMxr34D11C2g9hXM1ZIlE7hTE9N4aUv1bn5S/Zj1uR7mlL3CuZwoQD2FTmoI7E/AxcwU+u9YVPju9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0217
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
Content-Type: multipart/mixed; boundary="===============0901826452=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0901826452==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB40751720195E9237B8ED8CE7FC110DM6PR12MB4075namp_"

--_000_DM6PR12MB40751720195E9237B8ED8CE7FC110DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, November 3, 2020 16:09
To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Z=
hang@amd.com>
Subject: [PATCH] drm/amdgpu: resolved ASD loading issue on sienna


[AMD Public Use]

Submitting patch to resolve ASD fw loading issue on ASIC with ta header v2

Thank you,
John Clements

--_000_DM6PR12MB40751720195E9237B8ED8CE7FC110DM6PR12MB4075namp_
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
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
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
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Tuesday, November 3, 2020 16:09<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Zhang, Hawki=
ng &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: resolved ASD loading issue on sienna<o:=
p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to resolve ASD fw loading issue on =
ASIC with ta header v2<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB40751720195E9237B8ED8CE7FC110DM6PR12MB4075namp_--

--===============0901826452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0901826452==--
