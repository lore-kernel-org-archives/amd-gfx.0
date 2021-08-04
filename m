Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39E4C4338F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 09:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6615160184
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 09:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6615160184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F08196EA24;
	Wed,  4 Aug 2021 09:00:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E63B6EA2A
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 09:00:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDT1OJ2X6r6MxaUVlahvkFHJJDga/3pTpXHDA8Kl2jtEgO1/mSbnQeLPCElCt3jn7yefaimgAXjmawY2P9HZF3Scvb37m9W0BT20s0Jl6SrCMwr8ET9MBfAHgr5rfw+aUw/DgcawznU9yX92PiB5aHr9U4dqZNgFXwrYpsN2DSQciimfxLohnGtK3C+C5N6H1+yZK4jJLKTy9K9lIQOcNfI+Xj/XoCHe2rnmm4YvwvAvx9XG8zvvOBOabfxU3HYBpa6oEBzKXQFTWo0g5xfnOkWiI87sclmeUTmaeBKMu7Tx9qY+yWRWMoIkPRTLo8BZ0DzzxvQ0eMQV8jJDTxtoBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HWgvD+GpLJ2ax1rj1mxXR7OspeonTtW+Bh18UFEbIs=;
 b=ROw03UN6R38+ztUjG7wvbmcjUVEuNqvLLMFzySTYrvIZQUKpDioZxubfD4bfUzugMc4qhN85TmGqs7fVhIWbKcmwD8GHYdc5pR3WF/kj6JAILj5KZzokKxStp+ttdJwNIfZoEn3GLbNYJopH7b2VypOAIO7nRxcipZQ9Oc+9V4I5A0n3I0lBJ7FCDAa/6TzrwV5a8HDGT8QrghjjYfIQtEi0OTmuN4EQmgK8lV8eFbqmeqPO+xTmDre7YMNBsAYfKf/iK9ihzVNAG23mm08IXHZmhZLgQa/2MkNs2n9QPK5vfvROWaMz9IsnArrRlH0HBwTTnh6anUCWZYztQKn/Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HWgvD+GpLJ2ax1rj1mxXR7OspeonTtW+Bh18UFEbIs=;
 b=xOH47PwHYves76KAKAbjD9eUtW880CCX0jSZe/EzNSh6R3aoJmNP6KPAR+9DJtu+t4cfL1A46kT42dBr24I9hdPik42gyIHAtW1ZBA2gi3JdUlkSjFJX491/XVW6o4iO92Ca5PVvSkpzgjxUzYoeTkzOuByrjPjWtOGaVy0xVxU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Wed, 4 Aug
 2021 09:00:51 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5dd:148c:8b35:b31b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5dd:148c:8b35:b31b%3]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 09:00:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: set RAS EEPROM address from VBIOS
Thread-Topic: [PATCH] drm/amdgpu: set RAS EEPROM address from VBIOS
Thread-Index: AdeJDVbWTr3gUddJQAKxCNFB1i4ygwAAaW6Q
Date: Wed, 4 Aug 2021 09:00:51 +0000
Message-ID: <BN9PR12MB52578FE09317533616368F40FCF19@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <BN9PR12MB52266E0B3F150CA07FE3BF67FBF19@BN9PR12MB5226.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52266E0B3F150CA07FE3BF67FBF19@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-04T09:00:48Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d85b9a83-ccf9-422e-8df1-d8188f5d5714;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3d95627-26bf-44ff-ac47-08d957265c08
x-ms-traffictypediagnostic: BN9PR12MB5324:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB532403F2C327753F614248E6FCF19@BN9PR12MB5324.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BVNVsoelAkM56b8JTd9Ihb1/1oJGgTlfXA4PdbIhSExHWljhpyCp0Y2JMcWJQgh8GGEE2hLH8Xx2tQoMWvPvkhqRRaUCPRbGSPOKmA2Pl8ua/NZJz3I+qvY5i7AxtkogXPP4i9mXqY8Xw6eCNGAojTttZkCZNfQseIF1b8IBXFJfcN4Yz3GzVKb9BFpOMJecxKcyBLC/BnD/bMErJgvcG1SjywHSEMd4Hl2W1qzlc1thmtO74RUqO67CZsLTNxUJLRj5Ug9oyUL32Y+6Q6g948izOyC6EbQ4pM9mssmYRLRFdmmVHOTC46RhIannWJkZovDkIvYRupYFaYDhAL9mEd67mO6W6e4DMXjoZLifxBlfTKDsS6mdWZBh+AQKPwetXpxRLkrdtqKrTpI5+TyQkucKO8s1r4yHhS1i7qb752nMx2XRLkaM0Da6D+VBcsCleH3EsWgxOPE3DufQKncanPplbzocnN0BdqWWJ2doJVQn4lzUxzYfLQldyqMG7Qki8mnm6UWzq82vX5P5NClu1L8EahAd3mogv4M22LPsWPVB65Yz2LPWtWjB8xxeizp4lmhPCH+OXrcM5rAcIXHUg+sZZ4HSm6AuOfZU1S57TNp73tVf2RI/vrPhXGQ3zOCvz2cQO6MF9oOGsZ1Xe1bYkapmemjHT+oyVdrEG6Zl3SLapu1SM8xk2OAY0vJL4awMqfTTqknfUQddFeTCWdNq6g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(478600001)(26005)(5660300002)(186003)(4744005)(53546011)(6506007)(52536014)(83380400001)(8936002)(55016002)(7696005)(9686003)(76116006)(64756008)(66446008)(66476007)(86362001)(66556008)(71200400001)(33656002)(66946007)(38100700002)(122000001)(110136005)(2906002)(316002)(38070700005)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ylVV8t5433G7ly6GyYxme5DmnEljxTwfCIp+cVdhir8Al176C2kn5taRVC0O?=
 =?us-ascii?Q?KVw4YJkxq5RG6ZWigpJPW8S/sCUUqd5EIX82jBhqrz+Fs/1aPz92/nBZVqU7?=
 =?us-ascii?Q?2yPqN2LEODH56kAKnMIUff8mU8Xl0h4L0efyyNUC8c0isSeZAv2DtZADPBeV?=
 =?us-ascii?Q?FYKThJnJAHT7282EYO+lxeC8VONp3utosn4fPJg3eGGLLsuCMQmY3g8QRpbf?=
 =?us-ascii?Q?ObiaSngF0cAXJynY6qSfeCVH8ZV1Ha60ym2hXJlvpi0jLUhoxiN/7CATQMXs?=
 =?us-ascii?Q?QWamd12UtjRBBlEX4HTyeumDMVa/q6yYoZVYYvGDghiKcvXQK6taKahNC31g?=
 =?us-ascii?Q?jNrrtafjyMiQTL2IltBBzV9F5ZV5UNXxypA/eFBNUvl7FGsvCcaROk6d9Qtm?=
 =?us-ascii?Q?qsJVRVz20DlhyIePgVQPY6UGx2NrcOVnWmWZ3vza3aF+T3fjBQr76uH+WVNP?=
 =?us-ascii?Q?DISvmkjWlLs1rOK6Pk+mmVrHMLflhOwuQ3e/QZlaNu9QRCi5R+5XdqL2oseM?=
 =?us-ascii?Q?Tegq5IpeDKefMlwOAqlRbhuiECx4XaPJ5qmOD0MuvER27Tv6jxP/096J005g?=
 =?us-ascii?Q?3tNfNDsope6ED7QFgBhY7dMgURNMUTtuP2/fpTW+nZ4J8oqzCVhzWoQZM3wX?=
 =?us-ascii?Q?YhFmVDH0xpAFEjaLHKLu/KOnrGNxFVCUHIrrka8Yp3alg0xOtySpIe4Ddgwj?=
 =?us-ascii?Q?NCnxNLZVwwgPx/pojF8NBgy5JrXqTg9OEzND0QYPKNyJMWpglkJ+iL4ezO7D?=
 =?us-ascii?Q?U8KW1Xs8xvPY7XszYaQiW+79SLMWOcAqJ7HVgYbOX15Go1rxSrbsWHmrQGt/?=
 =?us-ascii?Q?XhcDygfu+JI/w0CJNnxjs2aBG2nwr93JoPHILJ3Ktt16ESor9N5YX6FHkKbl?=
 =?us-ascii?Q?6AmYiB30z3GrRVC/MDtow2km8ziVw9Ti5XZr2YTxmhSc7XvPDIdrP98RGEu6?=
 =?us-ascii?Q?B5BBB317diJcq2IfPYlvEQsapD7qkn+I/+fmMBF7DNr6uyLMu04VQqUG27dd?=
 =?us-ascii?Q?k0OxOSIdrCjvN8EoxCQNEpf7UkcsSWvaloB1wWZEHIRACCo7plbmxZVkckis?=
 =?us-ascii?Q?GA4vRRUNsZH2zjuByPO9R3F7N1lQABUBz+J3RoQr+UQjOYw6hT4DXNFweZfr?=
 =?us-ascii?Q?lrCZDqp4zdwNiXPj4rKxH5YhMx4FlIiq8cQEomCq6IlQI0GcLlpKl6cEICY1?=
 =?us-ascii?Q?LjEZEATz16jnB6p9uH13XqdQFRaoHwzelKloi9VFf/HNQlPsyPowVA9N1tzJ?=
 =?us-ascii?Q?qzMJ/8AJ8DbTM9IUY+KQQnJkAU5e5vuynawCnA5+KGT09AKuqo5RdbSpSRoZ?=
 =?us-ascii?Q?gkjbI39XuGRCPWRg4pEHWNbs?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52578FE09317533616368F40FCF19BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d95627-26bf-44ff-ac47-08d957265c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 09:00:51.3165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RzUrpemUPo35gTvLY5Mx7oushHit7+oCzAjfwzZdl6YQmUybLsH8josmdAf5bg/TgPqiWKLFDOQkTMHEwVxeLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5324
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

--_000_BN9PR12MB52578FE09317533616368F40FCF19BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi John,

Can you please add error code check in the new atomfirmware interface so dr=
iver know exactly whether there is RAS EEPROM onboard, and accordingly, jum=
p out and stop any further I2C request from here.

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Wednesday, August 4, 2021 16:48
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: set RAS EEPROM address from VBIOS


[AMD Official Use Only]

Submitting patch to get RAS EEPROM I2C address from VBIOS FW info table.

Thank you,
John Clements

--_000_BN9PR12MB52578FE09317533616368F40FCF19BN9PR12MB5257namp_
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
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
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
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi John,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Can you please add error code check in the new atomf=
irmware interface so driver know exactly whether there is RAS EEPROM onboar=
d, and accordingly, jump out and stop any further I2C request from here.<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Wednesday, August 4, 2021 16:48<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: set RAS EEPROM address from VBIOS<o:p><=
/o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to get RAS EEPROM I2C address from =
VBIOS FW info table.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB52578FE09317533616368F40FCF19BN9PR12MB5257namp_--
