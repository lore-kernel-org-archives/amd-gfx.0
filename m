Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3354C28CF5
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 12:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 699EB10E53D;
	Wed, 26 Jan 2022 12:37:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4D2310E53D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 12:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNCJF8E8C+pMpjKaO/TETos5FZKELNk35PPPOxNhE4EKKYQdGwDtAwLUpqx4EUCJpklFL2QvTYgeYB7Y9IfQ8ThMiV/rh2iutz18njD6Rz5Un7EyBJWYxRA2LXA/dBvYzs+n7WuqNh11KOkOuyzXfakyhDLv5QoDd2WSe63TGAfmrzAmOkHTKMtie6DY5GOh5Ybz2cNnVf+ujr4n3Fcec0+yp844fHe84vVsUJfvMENCNBrOCs67mocXSbQAMoWBf4Y9lMJkJXYxtkKQz/pBFtel1O6cQ3aag+GwO84YcJRK1f/sizwYgAJX2dlL0DxAqTp0u7u+MX7NAQfqJo4b1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQeLmMDXmGWPP/ohqvMGseU57WubFiewttYH5JhZWPU=;
 b=C3OKxx+/MCGZ/rOz/tBc9RQMb4/f3wfMHPx/BZKgZlP3X0JSCCk1d+k+1Qzx93po9N2ydds1N1rkZQ3As/+S5s0gIyzfewntRz/FMIE3A8vNK8iHFjimVc1iTh01poP8qmzzt5oG9Z7EHKbmdjePXTLC2cR945U8e+FXP6YpKhS3SZfEcEOHvnz5zQrzxXQQvuATaF1wb4T8cv7Clug/5BknYJbuIrburixg2NC5+/Inyvls9kSXmkLL8DFEXfZf9rbmY86dKBJkAqq5kvcHtXE8aRxXCz+GQ1IBF6gYRmNFag0rXKpQwE45mUhdckuxDQD3tmRkUm1s5xDiATSi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQeLmMDXmGWPP/ohqvMGseU57WubFiewttYH5JhZWPU=;
 b=TkG1PLEuRa9GG6B7XEFNujntmV1XtjOEmLNiC6mH+m5LPV7xylsb3xD/i9ty7F09i3p8HkWscTEyFYiOBHvtJ5vhEFpH1x13UZQrFdgvT121BXyasx0/u65oamoDZTAqlL3ztv38eomI/c0RHX1l0VHekDtwGRXscZS6KRh69O0=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 BN6PR12MB1505.namprd12.prod.outlook.com (2603:10b6:405:5::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.12; Wed, 26 Jan 2022 12:37:41 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::989c:5eff:f1be:c7ac]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::989c:5eff:f1be:c7ac%5]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 12:37:41 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add safeguards for accessing mmhub CG
 registers
Thread-Topic: [PATCH] drm/amdgpu: add safeguards for accessing mmhub CG
 registers
Thread-Index: AQHYEoneecc7xFzME02I6HZtGOhQT6x1NPuAgAAG00A=
Date: Wed, 26 Jan 2022 12:37:41 +0000
Message-ID: <DM6PR12MB4250B91402EB9297F6178F6BFB209@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20220126075326.1134770-1-Lang.Yu@amd.com>
 <BYAPR12MB461439BFC58135ABF0C42D8597209@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB461439BFC58135ABF0C42D8597209@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-26T12:37:38Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-26T12:37:38Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 68298fa8-ec0f-4daa-9e23-fab512bd01a8
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 501dd91d-05a6-4545-3791-08d9e0c8a4ff
x-ms-traffictypediagnostic: BN6PR12MB1505:EE_
x-microsoft-antispam-prvs: <BN6PR12MB15054514C46A42F344AC8F65FB209@BN6PR12MB1505.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6OtuKr/UHBoHCWnd7JqBxAU9b3tJohYotVB3TVvjN4QmmOxSYF7lmDRw0j/yhlOyCg2+iXhikrldDeXh9pLmoYy6HqDFsFEkhKNhWaoIbODQKm26qafhLn1VTE5K2BF+5wupWUdDZVu/T8TNs08hqQXeh9bYlfHbUn3PK9RZn0pLg4ykWOjGQlDMHAcxe+ZW3eKUyYGxDlsGZBwrysa10ADJluERKWurLnnbgH9jipHp/ArUt8ksI2HQkgOEV9kQWmV5CEuTloKcE6bpsSeaMvYaDGNhs1UJ3EIqlxa7xeAXhCZb6cXyB4FPoFsModz/+YSpVp5hoW+EeDZVvDTbuDjvwczdfeg8SimhNysmGj1gjHGIeriBiCbMKjadocrVuF+N7RGxVRQoSIpgE48CaJa6IgDw/ubHCNWcNYdSWmWFRfjPeHYQwP3NQz20Ez0QOx+YV+wD3X8zLIrdsYHRnmyH1CeAEoCe2eVqLuq3eg6SiscYR2uHOjLgGAL2vmn3Nz4+ru05n0a5PUV/zskjEUDHAIh/EonImdZbbh4opyg96250FEKPtRUyJiTSkgFvJqDDHBrux3kBLKP3RzkdDEFIYAny1MMfIAOfacqUP5ttSFqSknIOPmtzpdHG5GG7zqYD5AqNm3qZFMnbq0zVXUe31/e5qpF2ITsVDPjwxlld7kqULspZcHGtbmrknBBjfEtkk1hB2+ARklJlbfKtLg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(66446008)(4744005)(7696005)(66556008)(64756008)(110136005)(5660300002)(66946007)(83380400001)(33656002)(86362001)(4326008)(38070700005)(54906003)(8936002)(38100700002)(122000001)(55016003)(186003)(508600001)(9686003)(6506007)(2906002)(52536014)(53546011)(8676002)(76116006)(66476007)(26005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aQoc5uDfAwgVuXcA5rGYmG3T5Sgn6q27IRYOWCjCY/dZePWKQm8L80ULHqG5?=
 =?us-ascii?Q?2haczdmhmRfuOrIyIlkYAuPUdLs+xa48Ian9AEJh3TGZcQ0fmPk1fGId8nuq?=
 =?us-ascii?Q?oWLNFq9TnSuMlBV6BMla4Q/kAlYbam0huhhtVNn2m1+ZbBhsfqW9t6B2GsNl?=
 =?us-ascii?Q?xhqIgCa8Q48cEs69F30dLBjCIK9D3WFxyQof5nf3g9AcnXw1XGIUO+ACKEdp?=
 =?us-ascii?Q?FTZf7GXqBZ2FWnWgSIb+Ljt10oYYxqoXe8QchilvrT9Ny+uwoEj0uduM7XhM?=
 =?us-ascii?Q?yti+e5Mh9YRq6GF8KdBPXS1+h1KLi+0WvGHTMk3JLVPDp21IIsN8iKK3lpQV?=
 =?us-ascii?Q?XzLMU+G6JQsngybOLetaVaJdWRLBbTMy+Tl3TTRb8D2gND9DDd8mLrc7aHwO?=
 =?us-ascii?Q?x7BUCeg6nighccJseUGE1c/lvLbFn2WgmCttiTqrO8OIh5B40W+tsi76YRTx?=
 =?us-ascii?Q?27lz5iegnRM8GFQKKtQUCE6Vxkvp8DQvBkCgAjmmsY7PzYslMvxDwX49ySDX?=
 =?us-ascii?Q?+okw8MbYulIr1cZrUOdKuNq87DDckj8Sq4xoHT/9jgEOwYSkme0IReCJio4u?=
 =?us-ascii?Q?JjnAfwNdni/FgZdD5VU8tn8VD0keVSQK8cloObsadSSI7scTijSwLV/LWP0C?=
 =?us-ascii?Q?2D+TCfm+3SHG9T/87BJ90+9zGYKBW4F+wO5qiKzl5Sinf0YRKVHcB3S7IHfb?=
 =?us-ascii?Q?8PsCFrwLPEzC0VGRq7mfigMdsKz93D5PeXt8JBcK14pAWJ28wRlAiSv+Favw?=
 =?us-ascii?Q?zFntT836rXQDaDYc9dsvNbGE4yKVaR3IoKYDF1ybbsqMz+CnTOfdztWFhsVM?=
 =?us-ascii?Q?dIfym3LvxWU4sPTolKi9njwm3g3z3Hnzwtx6P1EH7lpfsjt7sU/zzBeZKAvA?=
 =?us-ascii?Q?uioM++XnnqLX3ZrBTl/i9LKtZofhfM7XDXmAOXZ4SNIP/YHQo6EkDEfIuI3u?=
 =?us-ascii?Q?TLIuDbussKlD2xV/MMva/5854yiPjXajy3My7m7f0yOSg0gCAYgB8CON8Ztr?=
 =?us-ascii?Q?mBCy4t6TNNvSyv4rCvWLltdHQn9uJ8VrTpsm4rZb2aWujwlw2DRwbZskqJYL?=
 =?us-ascii?Q?nSrj+BkHFGzAZAsLWh+iExwdz5LaA4c1Ihtpo8uIrfkotteLlmrkTgFYD/bn?=
 =?us-ascii?Q?SgT1hpe2UkcIMIciw+Q8CTg5sW68vLly16kFyMgYGK6+BtB6bzbw2T0EgC8U?=
 =?us-ascii?Q?OF7a2+K5dLAs4KLsTbE2WpKczcNuKP/Hi9g6XN+u01zT/oSN0v1LZsuef64q?=
 =?us-ascii?Q?w65y7v/SJdevp9TAnQl1vBtISYH5o9TwUeKsOuknAGpqEP3rvnyR1M0z93bE?=
 =?us-ascii?Q?636DMdcNac4M2dBQzafqD8VkldShOtTiHvYiYi8fDf87DvwSBSK+Q11lLGzQ?=
 =?us-ascii?Q?Lp4mIyWWwWXG82HWG3rZseuTo8dK5CFakFOCmm2RxvEpsKKDnTTc0zQ5Z3p4?=
 =?us-ascii?Q?zSC6WBo2VC+EvRQ5s6hJUGmzfEDHjn5nJ0B0Nyy54hc2Fd5bJQ7G5CKc5b8x?=
 =?us-ascii?Q?b7oYOt/gLVAKavVZBN8v23ZQMP55h0jAbWPyMb6QSdiSUvA2ICr65TWI7AXH?=
 =?us-ascii?Q?RLFDwL7/0YyjxJ0Gwwj4vF/bpnfDq442WyPXAEJGpBIkoJbpXUYQJTTpHHOf?=
 =?us-ascii?Q?XA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB4250B91402EB9297F6178F6BFB209DM6PR12MB4250namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501dd91d-05a6-4545-3791-08d9e0c8a4ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 12:37:41.4500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xC9WOSRbGt3OmCvq2AdWDwjv+DLU8I48Z79S7CoyJwH9o93bdwAjSIf7E7vY876HBTS2V1CQqv150SlhgS2QUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1505
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB4250B91402EB9297F6178F6BFB209DM6PR12MB4250namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi Lijo,

For cyan skillfish, both adev->cg_flags and adev->pg_flags are zero. I just=
 found "RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG);" in mmhub_v2_0_get_clo=
ckgating() caused a gpu hang(cat amdgpu_pm_info). I didn't check if it's so=
me sort of PG which causes the issue.

Regards,
Lang

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, January 26, 2022 8:06 PM
To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Yu, Lang <Lang.Yu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add safeguards for accessing mmhub CG regi=
sters


[Public]

Hi Lang,

There are ASICs in which driver doesn't enable CG, and then these flags wil=
l be false. However, the CG will be enabled by another component like VBIOS=
. Driver still reports the CG status eventhough driver doesn't enable it. F=
or those, this logic doesn't work.

BTW, could you check if it's some sort of PG which causes the issue?

Thanks,
Lijo

--_000_DM6PR12MB4250B91402EB9297F6178F6BFB209DM6PR12MB4250namp_
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
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
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
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Lijo,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">For cyan skillfish, both adev-&gt;cg_flags and adev-=
&gt;pg_flags are zero. I just found &#8220;RREG32_SOC15(MMHUB, 0, mmMM_ATC_=
L2_MISC_CG);&#8221; in mmhub_v2_0_get_clockgating() caused a gpu hang(cat a=
mdgpu_pm_info). I didn&#8217;t check if it's some sort of
 PG which causes the issue.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Lang<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Wednesday, January 26, 2022 8:06 PM<br>
<b>To:</b> Yu, Lang &lt;Lang.Yu@amd.com&gt;; amd-gfx@lists.freedesktop.org<=
br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Yu, Lang &lt;Lang.Yu@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: add safeguards for accessing mmhub =
CG registers<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">Hi L</span><span style=3D"font-size:12.0pt;color:#212121">ang,</span><=
span style=3D"color:#212121"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:#212121">There are ASICs in which driver doesn't enable CG, an=
d then these flags will be false. However, the CG will be enabled by anothe=
r component like VBIOS. Driver still reports
 the CG status eventhough driver doesn't enable it.&nbsp;For those, this lo=
gic doesn't work.&nbsp;</span><span style=3D"color:#212121"><o:p></o:p></sp=
an></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:#212121">BTW, could you check if it's some sort of PG which ca=
uses the issue?</span><span style=3D"color:#212121"><o:p></o:p></span></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p class=3D"MsoNormal">Thanks,<br>
Lijo<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB4250B91402EB9297F6178F6BFB209DM6PR12MB4250namp_--
