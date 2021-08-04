Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82E9C19F34
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 09:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8423260F14
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 09:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8423260F14
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1589F6EA33;
	Wed,  4 Aug 2021 09:18:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 132C66EA33
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 09:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aE4UW+grs4i1Vjmf2qmJuXocTsT13YCM/B/PuuNOB4uXq7bxZdhm74s0dtG8ehu781GGwG7SmB81Ea50uShd0cksR48g9Mg05v0ckvTKXNreHwip+ukAsl7NaZ0h5NJvzZgdClPD+kt+XmMHnKUfFI/9ySjjwTXpzeZ322tCYOU8bN9xdHfRdTVOF+68NgaZP7p4zZn2STo9fYDZZyyhKQW6Kq0iGIprz8bElfoYjGwVnaYA5a+xvJqAoLSKszp8za3EstQ7b15F9i1hML+Qboe47GZjEY6sZdJrqkKtin9polvzkSSQBFhhCahPLRszgFTJwDyXjBAd4vv4lYl1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssJFnSV1ZMnw/fFkJCZMO9WeyVEuyAP7/2Y8+FhrTH4=;
 b=eGy4mcCRZD7TymM8hNfGro6hg+mIchfUYAxhZGLc5gGdspp2QTDpf9N6vIfTbwGrxz3SkCu4OJlCrx3jfsoDLSZY9NjMII01pamN79V/NkjFFxdfIkYkVTsRSoSIQwTJTw7/uxnm6c0u0SamKabvkc5PKG9b7jriOIMIdOTZfM6rvmmTqagrglwKHZH2hBl4/WNk+hDF444UKJDuHBIVEWsNFDKHYSMgdq0cLmXucsndKM/zeHR/lsPg657ptcYl6gX6wphNY59hUk+CebFeG9oKLKZRksE6ZztHe+HVLozrIbgsavUhHy8P2fuh9RosHeUdvs/YQzZWt9dXrMqpJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssJFnSV1ZMnw/fFkJCZMO9WeyVEuyAP7/2Y8+FhrTH4=;
 b=c26WU1GnLiPIsZX9cmHkgBrmXcxg7YZOPMAD3OM+w5qYjO+53tgxV3PsPMzd5IKtqstv1M5En4U+S8W2dSKFFeby7D3zchERBk4DsUmJwWXXk6B0oTeAQVp10Dkz1GWl5Ifz4gw2c1nwsbTI8cnRWEGasGr7pFdFg9Qfx8STuoU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5290.namprd12.prod.outlook.com (2603:10b6:408:103::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Wed, 4 Aug
 2021 09:18:39 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5dd:148c:8b35:b31b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5dd:148c:8b35:b31b%3]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 09:18:39 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: set RAS EEPROM address from VBIOS
Thread-Topic: [PATCH] drm/amdgpu: set RAS EEPROM address from VBIOS
Thread-Index: AdeJDVbWTr3gUddJQAKxCNFB1i4ygwAA6j2AAAAoGMA=
Date: Wed, 4 Aug 2021 09:18:39 +0000
Message-ID: <BN9PR12MB52574B415706CB67F20BE8B9FCF19@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <BN9PR12MB52266E0B3F150CA07FE3BF67FBF19@BN9PR12MB5226.namprd12.prod.outlook.com>
 <BN9PR12MB522688A0B5F337FE81B8774AFBF19@BN9PR12MB5226.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB522688A0B5F337FE81B8774AFBF19@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-04T09:18:37Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2208cb53-684d-43f3-89cc-d391535d2bed;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c396655e-b170-41aa-a919-08d95728d8a3
x-ms-traffictypediagnostic: BN9PR12MB5290:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB529020107862D00CD587D84BFCF19@BN9PR12MB5290.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MGdHByv/CgUQwv/RKrmWL3bmRqeYMTQTjd0RQ5d3Tm8ZqfG+X3nPb2DPxaUPKv0F9JD3x7BCfHyRr//DDisBJFi1YMCizWzsAkHlxsOGIy4NG0YMgLKZ9KQ/AjoKQlbgQiaC8GPrk9d9nNxeKWsfGgOFq4YG5A2LeIRbCVSylX3E+FX7UvCxryxK8xXoPHliDwpNsDkVcnPmq+NJHl8qZaEvE+LzjhUDhvTCnF7dVKuZx3nXRbmT2S7knBph5/TTTX/FCoStk47JtOUcgmnioVO20oDIWPta35bDCjwDpS8mzYb/CgCJrJLgD2AYoxot6NWHv2+DyKE2818vNiezoAdcX3fiFpkHaIjD6BdUDPZv4+o7dB3cQCQFWxZvLjLXa7ZF0RZQT/fbaWItI1Lsyfz32gGG1NfRanl6SVV+srTYnQ3fjvs8HXXnDyXAm31eGxXVSIhfSpQc74HK+R9ZSiA+oYZClJyjFDwC3Ex89e38IsMfZlDJKdgdqRENmJAR/0YppSxMsKBrimr/hOkVagA9Vqn5v2crxzqNwkkVzu+rjpopQSSLXGnOt3kN6Id/OdEcx/esXjgzo7sg3BuDNpMbIQcV79zbhDc/J7D9IVlmjm0DgEXIWiOQfE3PdYf5ibwGE9wym5xldi9NEc3x3pqYKMPbMhz06zm3lNXMhdEe9kbHddwTucKyfZv5LMzPjHEM7U43J3hTZPotNZFoCQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(52536014)(186003)(2906002)(8676002)(7696005)(5660300002)(55016002)(53546011)(8936002)(83380400001)(38070700005)(66476007)(110136005)(71200400001)(122000001)(66946007)(316002)(4744005)(33656002)(6506007)(66556008)(38100700002)(478600001)(9686003)(64756008)(26005)(76116006)(66446008)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LtYDKcmVVUiyykAuXPGw25RS7VJ6TndFC0PPlwTe5SQaQj7Iw5cAZYUHloRt?=
 =?us-ascii?Q?PAmkWAVXVg2g/styG3ar6R+hrb9odX15SftFawMZ/qLPz6rMvd92aZaRsR3r?=
 =?us-ascii?Q?EpTKBY8TllAZx/fzKSD3SOudG3uTU29PUom2wlS67s4wuoVN8ux8B4KKUtSR?=
 =?us-ascii?Q?Xy4EUlCpaLQf1ZHL6RPkxbpUDkq3gbTi5M5BaYYDELXPz+lXW5JwklSbv+u9?=
 =?us-ascii?Q?WrDjbjhj7Fwd+V8uLEyt3IV3+84U8MJh4qbTg7QBhm5mLgfNLEm7Ybrf9X9a?=
 =?us-ascii?Q?7D4v6M95P5M5y2zijo8HSMpwUI/8EWnX4XPuW1n41KzQtIX+TEHtYzKp/IeD?=
 =?us-ascii?Q?+J20AghXe/hxJefimB6DdyUvQvgzPS7BDf5m6jEl3XnH0MWgXIT/+QkeT8zW?=
 =?us-ascii?Q?9RK+JjzOEU7O8dDfGacowQa6fgv555hfpPjyuIKHu+1HuRKaIGkEtTHiYpb7?=
 =?us-ascii?Q?xkHWVOR7XYHNVILHuDH1me5H63QVlFB+WfzPRXfngMyaCqAAF8oVcR0eZAB7?=
 =?us-ascii?Q?Nx5VenRt7j6a1f1X7Y4J8eD2GYhWjeFx3EUiHk42vLNsa3AW7mvnYWS9aIB/?=
 =?us-ascii?Q?T9J22oc1dSqyu8uFpWxPB5o+/liujH5y/DrMCj0MYO29NcGNpdHA3kf0uAPf?=
 =?us-ascii?Q?Gc9fRamWmJhL8dO6MRW3k2ZnA+xjEKhyl2e/YvI3tGI7Mfg4MRElcAE/cs51?=
 =?us-ascii?Q?nLJ2BUFdIXoESB0D/atjvdNU8VvQcf/JXaJbGIuqmjYP03wZ690FxX1ln6a6?=
 =?us-ascii?Q?Mb2vsduQCN90HKKKeIWxZ88LX3/SNaWkMMfsOJlmJdArVXM+of58yvxPFvpd?=
 =?us-ascii?Q?dMSlRa9WujvKjYkqwsTmkmlrlJm22Nb03xPe87uFgqrKOMO4A4A7Kth82ZQf?=
 =?us-ascii?Q?KW8PbaU0L1w3hiInJo4XHFo+IVoOFJsSOoP042IeVN2PJbdzcfhEsfeBZ3bg?=
 =?us-ascii?Q?Qa/VvFYTThcnVH8AEoKx0waB2m09IxeZ8cz4X5sRUzWXVV9BzNc05WnmhLbG?=
 =?us-ascii?Q?0qdPxPgWTQ7cLM8PCcCPaMgxDx6sbDHJmjWUC2DQ5v9z1xdZsmAa3H/GSdeo?=
 =?us-ascii?Q?mPD7uoTtZ3iVJsw9Ibxjigrhk/aVTwhFfMBsdK5awwKJY05QvmmVpwYsccgn?=
 =?us-ascii?Q?VV9XRHws5iV4a5ilFf+QcnuABo0cg0IMOMJjmEBitR/oxe30vKvfhEyghGa0?=
 =?us-ascii?Q?hy9UoU496L5fXdqMh0y9bHc0Hhc35n3XjnSLymnNfEJFTPVWR3ka5YLaU+0x?=
 =?us-ascii?Q?GTXm/z17J1GjyBBk7YY5MRDklyRohzBz+ndZHXESfE8BIJKga9r/kR5wJQBo?=
 =?us-ascii?Q?EuFGgZahYmaALXNAgFG3lXmU?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52574B415706CB67F20BE8B9FCF19BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c396655e-b170-41aa-a919-08d95728d8a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 09:18:39.3592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jb7ojyHlAEQO5mlaFJ/c1R4V/KPPhsCWH9TuxsxtyRMLCttXf10+qKj1/Wx5IwnKtn5dAePktHGX9YxHkUlPKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5290
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

--_000_BN9PR12MB52574B415706CB67F20BE8B9FCF19BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Wednesday, August 4, 2021 17:14
To: Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: set RAS EEPROM address from VBIOS


[AMD Official Use Only]

Updated patch with reviewed changes

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Clements, John
Sent: Wednesday, August 4, 2021 4:48 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Subject: [PATCH] drm/amdgpu: set RAS EEPROM address from VBIOS


[AMD Official Use Only]

Submitting patch to get RAS EEPROM I2C address from VBIOS FW info table.

Thank you,
John Clements

--_000_BN9PR12MB52574B415706CB67F20BE8B9FCF19BN9PR12MB5257namp_
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
span.EmailStyle19
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
<p class=3D"MsoNormal">The patch is<o:p></o:p></p>
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
<b>Sent:</b> Wednesday, August 4, 2021 17:14<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: set RAS EEPROM address from VBIOS<o=
:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Updated patch with reviewed changes<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-b=
ounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
<b>On Behalf Of </b>Clements, John<br>
<b>Sent:</b> Wednesday, August 4, 2021 4:48 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;<br>
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

--_000_BN9PR12MB52574B415706CB67F20BE8B9FCF19BN9PR12MB5257namp_--
