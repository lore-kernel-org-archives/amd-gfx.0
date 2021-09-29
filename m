Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF20C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 07:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799F260F6E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 07:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 799F260F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFCD76E9D4;
	Wed, 29 Sep 2021 07:04:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E8E6E192
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 07:04:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIM2Z6kpZ48IWgh3MjCiwPZF6nR6wI+Z7QJs2mjTECVsS/hV0w+JB1GpTBZwsM/s95dT4F6QjeK2xonetbUljrU85vbItRfhwSKBF/CQAcytA1V9k7VKuDbXFymtiEU5bHb7UqjNUTNDTeo29aZVUHAnNNpeKkf/YlMeafzuF3yttp0RC8jKqbUXwFTmAdNyD1XjQ0k4zYg5rdVzVwGF1AU2zgpe8LJd5BLZdlvH9lqLD5c9kJT/4DANDXKWvunT9KHmAmeXRv2+TzlwQopYeiA4T6c9Dw134VEa/tDTTHcmSCKAEKCQIi8klo4zCH4bzefTDXTL73QR6iElZtbR7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=xQmQICGZD6AEAJO15/ME5wPPMfj6y91f4rJgQltR0XI=;
 b=cbvvun907jg8eSPAQ0qX1e0NiRbZB+5MbF+hcN93P2FlEgleE0sBn5XHcoayZ6c4Ofq4IgN2aa0H5tz70IF0tFBkponuzQ+tIxqle8aVuKTv7uLKqv6NsyaoPwetBEBYcgGYOwAaABPjUi7KhbbhqJM0NYY2dxpLl6T8AglMKiN41VmUpSpOesgUzMznO1StclYalKtpxXV/vh0/v8BuTw+vX2K2LWWnEuozF0kWM5F+tDIwWyE9O3qZEQjBHUFrwULxq6k31YXqvIhCLpsnkLa5wmWtNFHrivdWDz597MaHH9EzPDlZZol1T25hw9/5zf5zFmKSmc4LEkQ9/ld2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQmQICGZD6AEAJO15/ME5wPPMfj6y91f4rJgQltR0XI=;
 b=xxo9y6aV8WS23i0rdiKO8c8YfLEYkFtlbauDIH6/8q5brrUib1gnSpyzGSE4Sc+6WaOCRvKci/Ie+nH+BgmDYf10OmQUgsTdr03Ln7s2QWD5/tH25jKEWj0N9KOSKJGs5C5mALr0M7zGpMP/f11witfM81nSowoQvpe1NqV6RRY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 29 Sep
 2021 07:04:00 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%7]) with mapi id 15.20.4566.014; Wed, 29 Sep 2021
 07:04:00 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] V2: drm/amdgpu: resolve RAS query bug
Thread-Topic: [PATCH] V2: drm/amdgpu: resolve RAS query bug
Thread-Index: Ade0//sY0aEdGir/STOuqDf0HZYaBgAACL9w
Date: Wed, 29 Sep 2021 07:04:00 +0000
Message-ID: <BN9PR12MB525750EB26C350808AF9221CFCA99@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <MWHPR1201MB254209E86784E97EC5C15BE2FBA99@MWHPR1201MB2542.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR1201MB254209E86784E97EC5C15BE2FBA99@MWHPR1201MB2542.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-29T07:02:47Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=87f4871e-644d-4853-897a-0c7e793a7ed9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07f74e58-377d-409a-6c96-08d98317506f
x-ms-traffictypediagnostic: BN9PR12MB5257:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB525769EB842B66CA0EDE5993FCA99@BN9PR12MB5257.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UI2Zsb7p9vom3S/SjwHQ18sTUIRcXFpEZbeFIAbnjdvYhPfrCwN3RBAQWcnxHPBhDCPyKRtLCk2Iyl69YS407TZi2Bj2+TL0VuTZn3vZzUi2atouOaf06aC0+aMN05bGDPaJzPjajJdw01BhemRIJIJoWAxTx6MGAY+DU+3aGFAaXtkoSrlnV6gyxckoqWEmm+Ud89SmSD3aNprWVgjFiNGkvEe89kekFCqGHz5t3JqcuRVUfEBgpdzSnoeFJ8G9WxRjN7JlISDQ3qgQ5vakpAujOv9R1khjJRpe2SYayJo5JqX1YunN1DvWTMpPYGJiLMqJprCSD5mTsvoDFBrLu8UIykjGPrMhxf0+e0L3anXVhcgeGHB3ON3VAVmLPcDb+fDTzXn798qSlHr6hOdB/C4R9WpA/F3QBJrGss8+GXa3mvB+AAKvKLa4dh02dSFlqnb45UrGDyT1rjtUAwmv1zqtu9rps//3qOStWka4UB7U0YFcnjr5XEL9dWvK4Dsi8Y9rK62oegVy/mKW3ADGsCrbeSmDuwfAqe36bATmzZYQzX4RnqvNoDXUVRlAv6wHW4EDwEc4TdB1WNxiCAFqnDi9lMgP+b+jBW8OSoVLkWJYgUgwzozjV4dq0GraLVG/DRhdywL1eJvQUNxAbTTZDNmKEmMHETgZHJM+q/DNyWjcpWuJpB8pa2TnSjYLLICHv+ejaa7owKkNsRipjUiKDQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(26005)(5660300002)(8676002)(33656002)(83380400001)(52536014)(86362001)(71200400001)(186003)(508600001)(66476007)(66556008)(66446008)(64756008)(7696005)(110136005)(66946007)(76116006)(8936002)(38070700005)(38100700002)(9686003)(316002)(53546011)(55016002)(4744005)(6506007)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lh4ieWti+DSdBrCaQmU9UBN5jkz0LPTMZtcKnK9WOb16hgrRa9SbJlqaCTes?=
 =?us-ascii?Q?Nrpko3aiA4C5larljqa4fw2eAMOyyCCpcYSivNLW2Vvkwbw2R5ZQ+IKGB4Y5?=
 =?us-ascii?Q?X/kfM4SzEBKGyav53qPAm76Hci7pklQkRrOPuCbN3t011w7Kn+NSIqtX/WYj?=
 =?us-ascii?Q?pnoLKoT78PIpcoID50vWzg5Ecz80+v/r+SrKVptZg08G2qKNdCEMWcIpem6w?=
 =?us-ascii?Q?/p+cdNT0fpVkJGFKS246oKhzxBZcGTwIg/5+yE+uBxyHx+VfsnizxGp3RiVr?=
 =?us-ascii?Q?QVNZDAAm777d+HdgIKnp7BN8bV/U4nNSACxEwCKa34WO11z45lmBNu3YJ9Nd?=
 =?us-ascii?Q?766zofWFXF0dcm8UGWtVrQxZ5PSzS3XGeaoiFD13FPdrethh0HYErjiWW1S3?=
 =?us-ascii?Q?Bkv8t9fkoen0KvqHad4U62cJg5fBMffL92BvRI6R2ffg9ZwaX765nJAwW4pC?=
 =?us-ascii?Q?mREIYJIxrJLtGaLKF2BTUy39WcxnF2J0uvCw9BYnM8qQdUlRn+u6fp5Hwx6h?=
 =?us-ascii?Q?ZvP5u8rLlHI5x0Qz5JffFiF5zlnvkANS44nyZO1BClSL6VO3EZ8vjJR0AZSP?=
 =?us-ascii?Q?C7luX7qc+nGeZbM76Q9+EGwNwcGskeVSOYROtSH1wnHuwbAqmudOo+gaezlO?=
 =?us-ascii?Q?yBHpR8+x+u5uBmJGb6a8QyFyLH+B0ochwxPplBEUAMHiV4HL3ZTZ3hqimBuW?=
 =?us-ascii?Q?rlNs27wgvfx9lFAKrSVBnnI9UhKEsS3A1R/WhTV5l9I6HdRrO82kODq1xDzT?=
 =?us-ascii?Q?oZXj9d6Y4P82uLB/QEHNOWV9M2VdX0g4nN0Vk1VLgYsyJotPpR7AVlKfdFxt?=
 =?us-ascii?Q?WjdK9mTzV3wlc/cIgNUHvANdhF5nAbt3d5TO1fvD/yeZzd0c+xuyPGm5fWsk?=
 =?us-ascii?Q?EbZ3SHxhl5BoDghYbDWCsoa+CAJaHzh/LswLr0C9uS+DBLdG5uokUTTPzTDQ?=
 =?us-ascii?Q?fe9jD52s+jK9ve/jFHn/KNM3X/89gjpg2g6f7RRI11vKBAo6p+dD8a1UxTAM?=
 =?us-ascii?Q?8Pja7PwlIzQYwiG7eeCezYkBF0mkfuHI/JoWNwLPWfG8KZloEzG4Ilyf/WfK?=
 =?us-ascii?Q?Fy1IVZxadV9r8PtPf7mNDg5Hn1jNex5QGlQpSaFlVhsTYE0YWnzgVeyxRXbM?=
 =?us-ascii?Q?Lne86tcGP7vzWAzhGFMdjWB0luDJuPS75VWA/ZT2fxd+Gy0L01ctIRj1HSwq?=
 =?us-ascii?Q?Np+qlGmxdqpQ8eeVU9Xd3kNyAWfTz5a/om67JA3Gfgx6WrslM8RK6tX8WEB3?=
 =?us-ascii?Q?VkS8uRxlblDZBh/ZzobsUfSFQDFpoVs/bpHWomvTmO4bCvOHbEr29V24mFJy?=
 =?us-ascii?Q?zzaTHV6Bre/3aO6eRaqV7G4G?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB525750EB26C350808AF9221CFCA99BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f74e58-377d-409a-6c96-08d98317506f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 07:04:00.6024 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qtbkGCApfOHqWPDjF0mAaxRZQX+R6RheNcXcXxC13Hpe762Hn9FWvZfMHJsoVjzGa+TkxOSAQATYg3pwQ4rVwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5257
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB525750EB26C350808AF9221CFCA99BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Wednesday, September 29, 2021 15:03
To: Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org; =
Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] V2: drm/amdgpu: resolve RAS query bug


[AMD Official Use Only]

Updated patch with simpler solution

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Clements, John
Sent: Wednesday, September 29, 2021 2:07 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Zh=
ang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Subject: [PATCH] drm/amdgpu: resolve RAS query bug


[AMD Official Use Only]

Submitting patch to clear RAS error encounters during error query if persis=
tent harvesting is not enabled

Thank you,
John Clements

--_000_BN9PR12MB525750EB26C350808AF9221CFCA99BN9PR12MB5257namp_
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
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle21
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
<b>Sent:</b> Wednesday, September 29, 2021 15:03<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx@lists.free=
desktop.org; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] V2: drm/amdgpu: resolve RAS query bug<o:p></o:p=
></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Updated patch with simpler solution<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-b=
ounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
<b>On Behalf Of </b>Clements, John<br>
<b>Sent:</b> Wednesday, September 29, 2021 2:07 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a>; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.=
com">Hawking.Zhang@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: resolve RAS query bug<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to clear RAS error encounters durin=
g error query if persistent harvesting is not enabled<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB525750EB26C350808AF9221CFCA99BN9PR12MB5257namp_--
