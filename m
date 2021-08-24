Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4D9C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 06:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E2E761265
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 06:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E2E761265
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B98AF897CD;
	Tue, 24 Aug 2021 06:55:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C3E8897CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 06:55:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4Hqd/PPdE4Bi+qYEDxfbKAmyZNa3gxU+6COkIl4PcMe+CFy8ikoX+0vUAshEYwoyOOF8DKpsafrJ0E4MP+d9+WZHkDbG3WCUdZ1i+HySNaY7SwZ4+okmXUo9HX83KvO2c/nA1ZUtLo+LnBNIKJOd0+vVkBdfm9arXmL2+2g11k4xOEaQGNwmBqq150QUoCCkEU5/Fb6aG8xdjskubpIdV/qLQPbMJs7oY/8VcDl6aSPXWO7jVAGnX8ExmPeroi89LbKhMFGnS+FYHtTmgaduvM8Kt3qifVBdru62Yl+yeNF2oLYzLB15jf7r6KpfhHGn18VJpZ2VwirRXXVy22cEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27dae8XNfPV1g2dYwk+2eJJUgbuoGu4Pq2tuLysrcwA=;
 b=LwKJguvLRkHC7LQQ6oVdx/4pkr1pBr2T+CYKgM0owlII7KKGjRn7E0DSz1bzKRWNQaOR+X3SQqzUTNsQNZVwzrKmJt7KTeMhlN1boMOVTCfZTFwQDEVoe/SmF5pJ87cQHX95FF2kPma/7EzvhSJva1/ZzUVcy7cDyFRxZ4uiON/66ByLHgLo6Gv90FsWiAJ4s+Dza88vNTCdH10Cfv6uWnQsFeDx3jW/8KvQ6yKSegxiR5Xl01MvPPX4ocAIpKqZTaHiChfqvYNwldW6LZZYnwBMe0DOQatDN0K/axc54Oa0AjykXqtzVToSe90PlUUsw7f8FnJPmCxawYCQW4KMxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27dae8XNfPV1g2dYwk+2eJJUgbuoGu4Pq2tuLysrcwA=;
 b=nY88DX5+SbpoYM7Bpl7KCEu238mcvQar6Wi0+a1S7hmsnIrI5Kxvzyp4ycfMbb/62W/wUAgyZ/VIgAVtVH+3b2EtPjA1qfDqVqF2RDJT6ywB29XVa7P63vHpKow38X55jrR+5npp9l01munJb4105vfuJQBcL8N2hrjTQusDeZs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Tue, 24 Aug
 2021 06:55:01 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%6]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 06:55:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Update RAS XGMI Error Query
Thread-Topic: [PATCH] drm/amdgpu: Update RAS XGMI Error Query
Thread-Index: AdeYs/43husXL4AwTJO1w1IFT7vrzwAALdzA
Date: Tue, 24 Aug 2021 06:55:00 +0000
Message-ID: <BN9PR12MB52572DFCC8F560047D9BAF60FCC59@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <BN9PR12MB52265B8C755DC13618C5E3CEFBC59@BN9PR12MB5226.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52265B8C755DC13618C5E3CEFBC59@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-24T06:54:58Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=470a8421-3bbc-44c1-8e08-5b231db3c1b4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afeb9c45-e19f-4be3-419f-08d966cc17f7
x-ms-traffictypediagnostic: BN9PR12MB5130:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5130084773B7CF36A5D95C62FCC59@BN9PR12MB5130.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O6+U7cq+UJfNS2CxZNFo8IzvMumZ5HfEvutdSvsxFaQ6qWqXVEkbrBIy9ngZH+QCOCUjyHhjccBwd0XXv1MxDVvmhf6zjby98ZO2tZZ//tGO5e/VpgtF50wsRksIKiB6A8lU29mZFxoquh1tmpQYIr5P0fro3eqk6kmUuvo84KFBYQpe3R/cyyjFUFbe7GK+BQBbhmLngpwZBzR5YUP0ZpXuyc2U9GRbYoo9geeE1Izz25RM7d1O7it/hlsXUc1MczFSDRwOyzY/qnrIwnROt1CCukmktlqDzUPgA9Ep//QMflLiBXqsZK7cTVfH8NpR4bkGCl8AsyEdz/0Rfkxpn2cyhx2GGd5IOiblxXZkPwHduAaK8l19UBR95J0lUWzNWQbt+O0dcsW7ZZtCTCNO//8KSjeaL+iTvsxgO8wIobf8pWHGLoW4mCvaMXO11U0FMAM48Wq9iT7fxY8Mat2M0wZsrtM6y6gtiRy9tnCTOSHPlQpRqvQtvuf3fHJQyxixD64rytOTNYJkXNdSf+3nBqELUB3Fdp3w23Bm3crdmkX7p4N7MePpMi5lppXsEWdBywPrAfGzQunyiVZHu1O6Ganl8j67HG0NfeXickYD5ivhM8Kh+lRxRUfo3H9wxJ/YABfrqUQf1GQXMq7IkBChfDaM/kFuZHrS6uLCZpe/FSTHDDXx7yEdpLZsikCzZY7EfFQ1DEDAtWhyBaqHZBYbkw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(38070700005)(5660300002)(38100700002)(66556008)(55016002)(83380400001)(110136005)(66946007)(66446008)(64756008)(316002)(66476007)(122000001)(86362001)(15650500001)(53546011)(6506007)(71200400001)(186003)(52536014)(8676002)(33656002)(4744005)(9686003)(478600001)(7696005)(26005)(2906002)(76116006)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wrsOCbzrKRsqQl3L97RGrU63xrfLCPGBRlpjYLsD5oOD1SXD1lbul/ji3uld?=
 =?us-ascii?Q?ZUMELNb971M1Ziw16kstsfmeH9xxXWhXjGPsNB6TAcJTRo+t2Hct/IxKfCSc?=
 =?us-ascii?Q?DbE3/NeDgI7Yck1J6SeBUFT4O0fimTC5pohU3OXSKc37btlumUO0VtG4hCAi?=
 =?us-ascii?Q?Po0XiQvjSd+TTF+Qt2J5dHh6jnUImOPyuoqmsJkqz6a6odcJF9GwDZ1DJauA?=
 =?us-ascii?Q?m3/K8uw0XObk9dJzAxn8EHMciJUzTPp8k2/jV6on3pt6/HrEQelTGK0RukQa?=
 =?us-ascii?Q?AQuBc4BR7SE4dpvCP8VLUcW947+0gFFAOwfQg/3z+ch6DPsDsHZIa3lPjB58?=
 =?us-ascii?Q?k2d3fbhHmnDdMm0H4b4Twpf9LXubwODSPKUjhmRIivCJo5tBWI5cRgB198/e?=
 =?us-ascii?Q?Y7OE8EVC5MbIzVQme9LpOXha7zI3t8Xx0/TpCDLYMw2ssLQyMjiNhwQ3XV3E?=
 =?us-ascii?Q?RBMCyqaQLB0i+4moZ5w1jGXPJeFJgVIaNKdlrExjtTgfvGMxEaD7c4c2MNF2?=
 =?us-ascii?Q?1hAl9Pr556hKoSZ6D/YdbdoYW+j7YdOfxjAPWA+npUvZZbgArbjCvIRQtToJ?=
 =?us-ascii?Q?BVVT45LK2jS9JSHMOtFeMcElrx291d9/YAiLseIFGmfPZjnsR/W0kFFpt4Ba?=
 =?us-ascii?Q?seErcRsrfq0LaY+rEkAfP/PHjmG3Kw1nWUhndyfZlQiyZNkNHVbQ1i7TiXda?=
 =?us-ascii?Q?082CFho135ZYIpG8/KzdIr8i2ATCH4CkeNCJVxbVNrih+mFdoEGV45kyW17z?=
 =?us-ascii?Q?o+2Z4pDfGUP6JgfzJOJzivGYDmSnUEzutvWqjd0fDTAc7NqxO0XqhxLz6BJ9?=
 =?us-ascii?Q?Ix+m7RShX04Og8GPU1p8v1fcGVvajpojxLwI7wN6EYXcXPySIuC+3KppdnRV?=
 =?us-ascii?Q?WcM3fBLNvjQnj5aek2BzmD6wN4WDKrwyfOa00OBH7Gb1F8hPxqEgmoLyVzvj?=
 =?us-ascii?Q?ehBYhZEItWOJM1cspKMo+Cv8hhaglyfe2KN/ncC1PtfLLcjOTbv6hDNxvm4Y?=
 =?us-ascii?Q?EJkmCoiASC8pvG6XPk8Oef2jLYLRFc7mUqBfCs4sesLPX57TbKByHWAiaTSQ?=
 =?us-ascii?Q?p5LMbamUBBHVWVBextOvOP15jp42el+n+m9Xa8egVgygLzeJBE7gBQ9pRSK4?=
 =?us-ascii?Q?ANhOCOKcxi4b/pAz4n/hbosYcmuZTizDAX3MUEA0KiD87Sp3YUGz3OyYb/23?=
 =?us-ascii?Q?2f5EEgzBc4x3GGw0Vyey771gaUvEuw2rRRLRmZ4mFQ9KzmB1w5+X62f/I8QQ?=
 =?us-ascii?Q?Vs7l6/EXdCHqdQE4gSmO6hbFuCBDf7X+w4l9BqjCv6xqxMZBfKa/qu/9970J?=
 =?us-ascii?Q?PZHl2YYwSJgNQ5ibF9GNM7DC?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52572DFCC8F560047D9BAF60FCC59BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afeb9c45-e19f-4be3-419f-08d966cc17f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 06:55:01.0071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BeNdAQmzQNWil9LCt8PYzcZZw1Am7YS8rixMnTwgJg6dAtMmA7OZRRuvOihL1rbqyDfuvBPQxHyacXVgiul4QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5130
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

--_000_BN9PR12MB52572DFCC8F560047D9BAF60FCC59BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Please add a dev_warn in default case to let users know they might issue a =
wrong query operation. Other than that, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, August 24, 2021 14:49
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Update RAS XGMI Error Query


[AMD Official Use Only]

Submitting patch to resolve RAS XGMI error query issue

Thank you,
John Clements

--_000_BN9PR12MB52572DFCC8F560047D9BAF60FCC59BN9PR12MB5257namp_
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
<p class=3D"MsoNormal">Please add a dev_warn in default case to let users k=
now they might issue a wrong query operation. Other than that, the patch is=
<o:p></o:p></p>
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
<b>Sent:</b> Tuesday, August 24, 2021 14:49<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Update RAS XGMI Error Query<o:p></o:p><=
/p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to resolve RAS XGMI error query iss=
ue<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB52572DFCC8F560047D9BAF60FCC59BN9PR12MB5257namp_--
