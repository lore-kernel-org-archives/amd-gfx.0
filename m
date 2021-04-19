Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99D2C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 03:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DCE161077
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 03:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCE161077
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 037A06E1A4;
	Mon, 19 Apr 2021 03:14:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE776E19B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 03:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpUzo41e/oxkhGSMbpsEszjUJV114F75GGEEar6aXtDZIPIMOmDui2aVDEUYyjwCsCl1THEPDwRFlJaAtCnFw7gdBzcAmObv7shSPfOwgojvyPs8wrW0/QAqW+qFyXupyF+Q6DiTFaU0iDMOmAj+uDWl1fyNTo7AcLxgQYianIdi0ZIusjjLbk5pkvVLwDJfbtBmFLY4+xhd0l4LGTIi4HpjZOz57IFjRUrZFmu9ytV5NJc2aKOblfhkO/Xiqy3qsdjpErYVVk+JywWiBJLrPnEnTFDxkEQXooXGoLrAWiKHwIzZH0qW7AOMkUukAoIYGhHgBaf6UCHfS/jEUs8jOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2QD8CYGl9/+jzFz0rvyKmOv/wnQvsGgiQ6oi0TqCWo=;
 b=PYAHISsm8Za7MP5bFqagI4V1ATHMbSCOHKnT76WJ1BhOkMOFVoi3GU4xRCFDBxYa0lvgodA6JShAUzU0PjRtJVSCv0dUUL8W6fTtquSdh+Q/p5Hets+a75HltS6Y+qZgyO7lEdCuFRuWYZQjlb18+1W3vh9Xr0z9BWdaEG2Oz3hrlqp82HN6a2CTZURX+74xdPzHs9IHwGWJIwU0L2258x5AVj24KUDFUQquzCi6vUUuE75i4mVPKF58Tb3r8SceIrdOylcnkhLV8bFCWa2NLlKC4qA30+VjU8v5UECBuGM+TIekyWCdLSX1p4rpCAB+GWrAhhaZgK6ZXFI2gelS3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2QD8CYGl9/+jzFz0rvyKmOv/wnQvsGgiQ6oi0TqCWo=;
 b=MiggNOD/DbVd8fg/k3h4KJ0Ts+1unyS1H85YTMN+9YYz7BZcRMecpz5ntxHl1iq5rWFKvYYL1ibsEUAgtlBN+RwZ730Dga6Qux9goBgmh59xnAylBSvVadPuepN+D8zm9kcmNQVXVOtBlRkBApbK1UHxYwxydwEkhQmBvqO1CXg=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5132.namprd12.prod.outlook.com (2603:10b6:408:119::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 03:14:41 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::1ef:6c3d:170c:8328]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::1ef:6c3d:170c:8328%6]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 03:14:41 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: resolve erroneous gfx_v9_4_2 ras prints
Thread-Topic: [PATCH] drm/amdgpu: resolve erroneous gfx_v9_4_2 ras prints
Thread-Index: Adc0xjP0y4AQVY4vRsaWPqugsOvC1wAA808Q
Date: Mon, 19 Apr 2021 03:14:41 +0000
Message-ID: <BN9PR12MB5368B3C8F6A56D3B78646530FC499@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <CY4PR1201MB0072EA9CE113F9CAEC0348F9FB499@CY4PR1201MB0072.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR1201MB0072EA9CE113F9CAEC0348F9FB499@CY4PR1201MB0072.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-19T03:14:39Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=d095485d-8725-4aa7-a12f-f6ffee5aeeef;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f17a99db-530c-4e71-f8ef-08d902e145e2
x-ms-traffictypediagnostic: BN9PR12MB5132:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB51329CCD27DDDBB53EF5F0A8FC499@BN9PR12MB5132.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z5HSUhocv+4O34hYagO2UYABQmASZOEqbK1S4u29viApt4lQ7f+fMdZgAq06KV9oSwiwLveuBDHQU6+iSZgYFg/5FQWse1Hvizl++GUricJtSUsqpZaFlyZdRwe3kh077GPloDaOGFVuy5dJos393ceLVcLqbPWg1nN+lbStx50UGGQAY4jwMg0/72t6gchaP4sxoC2jSeN/uCy8BVFjSMWPH5cG0QOxZ3vq8RNEGvnoA+I0U2ljABRH/izMNA13vxxwa/lKeg0rK+swe43LSYsQaaG7ADj0UAj9mbixNCVx0pPsSXHkUL+HNqeYs8G+oMpJj7SZRGWUl8GK+qL8I2QzDvYWB1WqH2PU74QYaO32SK1zNtO12I6YX/AmUFQnXoLoTn6EIDT2hSj4FipuukX5gY0g8ibBFBcDt0FBxMjklgnUIah10hRCzOdCozjr91svmDng8spLATCnbj1krEYIOB/u+oy0zjz/YDp0Ew6AYRnp24YJTgekn6HBIS5J5b0SGDe3yzJIfynJ2GqMl1qF4WkSdIO0+x5cczuGyiZ5xxkRczSpPjcylHBDpM5RBnLS9ZkWOWUPvlYXhP4sQZiV7azDiok0HdZtr7KkCXw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(122000001)(2906002)(38100700002)(76116006)(7696005)(6506007)(9686003)(4744005)(53546011)(66946007)(8676002)(8936002)(71200400001)(26005)(110136005)(66446008)(86362001)(33656002)(64756008)(52536014)(5660300002)(186003)(66556008)(66476007)(55016002)(316002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RWpA44rtkw7fp5lPaovPI1QkuchmwwvOZvOecVxqhyGmV2Pkhjufn4tdM4bj?=
 =?us-ascii?Q?erEBLUUZQT8G2W3TJGw3UdgqGrtMGq8McieqMsUa15rC6NzO+6sc5sUH/eaz?=
 =?us-ascii?Q?kEWpzWK5WS24h8CciICsYUo1zQUn/k2y75jMDDaP9mWao6M5hphTYm2rZYOX?=
 =?us-ascii?Q?TaI47Yb1Cwx0V+8PAPlbtZb8N3lGkTccAqMpTG0Kj++eoApV5ASqVKQtur2W?=
 =?us-ascii?Q?ty9VqCYrHASBe8iHxmY4S2SGr4SuqOMz0IvEU2OWgbrjYKvnUpMUaXdUPDsr?=
 =?us-ascii?Q?2Z9s1Ku70hsNvWr+Wnr94nh5+KXUVlU5FS0r/iKimj2h7yJstzcUMkcJ+vFU?=
 =?us-ascii?Q?oA8FcFfZsw2UOH9S7tJ2zle+jgc9XW0ivU+zEJ1hsooQuh9qdJHsKSuv6wbA?=
 =?us-ascii?Q?tFxIiOHt0ZMPr495EBuzW5Wzn6/bcgSUcfT7w+I18EXSvgja/eszoaUtcZpc?=
 =?us-ascii?Q?Ud4KJFTwU0A4tz6mBDVG3qjwZcJOGiTm+c37Yy61qjg7LmAw8UBUwFfLkCgt?=
 =?us-ascii?Q?WDwouaNoUNLN3PvyVKLJ+Q9s8X12/NiIqsgevD9r8py+lrzjWH3wcS47aDYM?=
 =?us-ascii?Q?Hb0bafN8wRG2NNmiL40pMkVBeTKx/PqhfediA+Glg7wkaacv4IRABwkjZlW7?=
 =?us-ascii?Q?cNazMFgNE3mrGL+gFrDOYoSJ9qITirXDj5jJwMx0bEjIQ/LWqXZkePFGOHoa?=
 =?us-ascii?Q?5S0tjlHosc4sJBkdgCkOwmHtlkrGnYhJnEYk9Phlj8J/no1ZlOGzJDYKXX19?=
 =?us-ascii?Q?DuDMVu3JmQThowEoXd+S+BkVYmnjvlAU7SIi5la36vq28CN4zXi3rPxyw3bs?=
 =?us-ascii?Q?nhBUbbstE9A5R8RH5G6X7LPOz459UuwVeHFnxahYPe45cI9H+63urzVCcKTl?=
 =?us-ascii?Q?5CAmCSL4wb48jovR+7iN3QbDxcsb33ozgzgjlP94EJVMaWS1I882Ra4F8jmO?=
 =?us-ascii?Q?aH1Nzdm04kV2hWH99fmoVTvBoYvxjhZC7z6kUqlVUh/YnpFGM0f9UtTIKAJP?=
 =?us-ascii?Q?Gv3pvTdAux3GfZsYLw0ex198B910C8m5XSohPYeTvszD1H/UluriaHCJmW2U?=
 =?us-ascii?Q?0XSD2W6vmmutBvJs1I02pYzhuJoSw6p8FGdJCBBMEem+84heR4vNqTwcYA2u?=
 =?us-ascii?Q?SqGdXWtAkq39yOLBW4mmUVWx80maJ+LC5mtT2uRNl3kM5bgFSgBxF4LJMcsi?=
 =?us-ascii?Q?IoruvYiAPD9wHgm8+/QADDrHVRy02bru+lbRjMJbF37P0XIoRxoCScGqWYdD?=
 =?us-ascii?Q?KVFo1APNAFtl4IyT/LVMaSA2QBO/7Dwewx8uapTeA2MNfRuLbxzM8Vgv7vLB?=
 =?us-ascii?Q?SbkSAoHl7UoKFFuiZipFr47h?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17a99db-530c-4e71-f8ef-08d902e145e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 03:14:41.1572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CpKTcldqrpq7CzQ9RJfECDbG1u4Q1o1kbxDlpWm6ELaLBcmhqw0/NVs3+lpIkSyxuTIUpy6hB6xtZWGJUgaezQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5132
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
Content-Type: multipart/mixed; boundary="===============0034161024=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0034161024==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB5368B3C8F6A56D3B78646530FC499BN9PR12MB5368namp_"

--_000_BN9PR12MB5368B3C8F6A56D3B78646530FC499BN9PR12MB5368namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Monday, April 19, 2021 10:47
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: resolve erroneous gfx_v9_4_2 ras prints


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to resolve bug where gfx_v9_4_2 ras related prints would a=
ppear on driver loading when there are no ras errors.

Thank you,
John Clements

--_000_BN9PR12MB5368B3C8F6A56D3B78646530FC499BN9PR12MB5368namp_
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
p.msipheadera92f4c5c, li.msipheadera92f4c5c, div.msipheadera92f4c5c
	{mso-style-name:msipheadera92f4c5c;
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
<b>Sent:</b> Monday, April 19, 2021 10:47<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: resolve erroneous gfx_v9_4_2 ras prints=
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92f4c5c" style=3D"margin:0in"><span style=3D"font-fa=
mily:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - I=
nternal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to resolve bug where gfx_v9_4_2 ras=
 related prints would appear on driver loading when there are no ras errors=
.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB5368B3C8F6A56D3B78646530FC499BN9PR12MB5368namp_--

--===============0034161024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0034161024==--
