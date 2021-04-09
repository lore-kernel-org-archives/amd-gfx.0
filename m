Return-Path: <SRS0=E5im=JG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521D7C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 08:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE8361105
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 08:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE8361105
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC2F86E503;
	Fri,  9 Apr 2021 08:30:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723396E503
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Apr 2021 08:30:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C92T8ieZh7912dz6NQWreuLqwLbPYY4NbRriIg5Ndw2AAUMeHziKMe7LadLjQXUaLtA8HXmYR861bdwcqvnffmnBPqnG/d3f9znDcurTNsKdZR/ZMLYVvom62VvX03zoAag9+eqdxh0fgFdumCcrQjXa/8Y0Cj7r3dgLHqG8E250cGC8C1/TtoFAmoxnDS1dU8YXWfeSSxYabfRX27CIa83//NLkU//ipp0+T251WfNibWaMt2ehzFSAgbmPx6f8wNL8ee0vsftGgJVKWGO74Z4KHf/ufGfqH7KXKSehEfS/VDy92kIDpPtmh9TTtSzqmtBgd55cY8g/cS9bJQ4NDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkzumO0b4OKIpU34NfUK3tXyhFQcyrpNfdDdJ9zZ+ek=;
 b=mWhCNhb32AuEtRot77LGhrGosPRUlO8Avh5D7LsbZOVYH2L40n/qS0fmVXafV3gXEgGZCuu9dtifiScCKgfPZj50XwP6mQ4ItX1Xix4cbuQHQPpYCe3ab9KltpnYeldudBi6dtkgxyCBpmQLT1Yuf3phecw9uA8v3O3xap2X8WYrtKZjJKlEKoVPhjQR0pv7yFNAU65tFz1gfm4Uh/JXx42ZU3XtS3BaBCzlSlQbu4gh38/UjfREF6FyZQDFFMJMr01x9E5HcqIsvd9skS+lukPt5VqpFlHhLcejNbpwReNU00Yt8cBTdUZuyYoWtsasOcbmboohTqZ3EROeN5XKZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkzumO0b4OKIpU34NfUK3tXyhFQcyrpNfdDdJ9zZ+ek=;
 b=Aip8hwyUauOHpdxgtyJwJjudBg5izMljtE+Bi8fzhItXaB2zPKLcNH+b51ixSsE8VRZtkfc45fnAilmEf1q5NiVKKvlwx5ZzLxQcYr4CLN6UXklS41icsibGqGRu0AjF5oJu9/V4TkqgJGyrTpBFQIFN8pnPCrSESH/v5R+UZZk=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2780.namprd12.prod.outlook.com (2603:10b6:5:4e::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32; Fri, 9 Apr 2021 08:30:02 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::c950:d447:1fd0:2686]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::c950:d447:1fd0:2686%5]) with mapi id 15.20.3999.036; Fri, 9 Apr 2021
 08:30:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: page retire over sysfs mechanism
Thread-Topic: [PATCH] drm/amdgpu: page retire over sysfs mechanism
Thread-Index: AdctGNh9xzYbt45bQVGtgDOImVY55QAAODlw
Date: Fri, 9 Apr 2021 08:30:02 +0000
Message-ID: <DM6PR12MB40751131521DD27DB73C908EFC739@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <CY4PR1201MB0072B485CD6BE311CBBD72BEFB739@CY4PR1201MB0072.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR1201MB0072B485CD6BE311CBBD72BEFB739@CY4PR1201MB0072.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-09T08:30:00Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=55cce696-c461-4950-bb38-a8ca917fa295;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c7a739c-e9be-442f-1595-08d8fb31abd9
x-ms-traffictypediagnostic: DM6PR12MB2780:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2780E26DA4DC315671B74F97FC739@DM6PR12MB2780.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T2Uyoi4AeA8PkguyMC/4meYGfWZEeyRwNuD2M1G8xi8j6LcIuUWWbxya6NwUOXsDAHg2RZclp72zfjR50QuhCGn8yqXHyljUc6G7pLUY3aU0msY115KwiOVQs1cnNmz3PfYHBYn3X82NDZOY01wo4FrhmBonJdBNJwCNoR1VjkGyBc5NNkN1y7mgWEU+7vwWAkpz8+4xFLl4CqLkLSGH82dt8hWiS1AJZIs7ZpCa6nawjEV1sr3o7FbIWL520a/pz6QLYXpR4/vCSEhw9id2+zeczTM59GVTKpXcS9aW2NEtyMndE0W6ZIwSdRZXWAD1b0Kzo8YgEgRk+wJAE+iLDjfvo9QE76Y5JQJEYeRZ51tN+8UKm3aZwd+wKQ2sz5YtEYKA+dyqx4rjNP8wxrLqNAxxu39gZ0ndd4DA3P7YeZ2MgVvd3Td1xcLmAvdA/1K6aJ+8PpIFJHZkj2EKw4+3LP5YE+HIj7nG+hPEJih7oUzp62p1aAND7+lGY9OE79NXvC3UU2EB9+uN6xfO96XPRyskd5IRmIYwJVI9Pmv9JU3Zw4ulfkmaP+jhHBQ/NwAwL5CBDlRyWKfHCte27Y7A47LSUI20poKSO1J6q9Ya04JrZO8/XQVwT5g/Swvu5HH93HkJ/60YIQUulrKJZpXYUZnKYM3d/pQBtGH9+vWcBLM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(55016002)(9686003)(7696005)(6506007)(53546011)(83380400001)(26005)(110136005)(2906002)(478600001)(71200400001)(76116006)(8936002)(186003)(66946007)(66476007)(8676002)(33656002)(38100700001)(66556008)(86362001)(66446008)(4744005)(64756008)(5660300002)(316002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5X+mKZDOTzqmdkuzEhNA5ig0k234rHJiz+/E6vUmrhWmCqALzd/wTfTR8JvN?=
 =?us-ascii?Q?f1tfss3ui06MJFXWwoyeF2b+WTotXXpBOHMRX6lU+Vi/lnEsmSXWYC9bVxnW?=
 =?us-ascii?Q?/+6TRlOn54rj1Z6v9ZgfSNZ+TqZGnvem6RTi7iQAjIbStcNnbun1mIY5wPX5?=
 =?us-ascii?Q?2eqwVD1AUCGNs4WerD8jEDgdYi7Zep5Yq4Yu6I3hJGjQPimIgiDOhW/OKPjD?=
 =?us-ascii?Q?XAn8Eh/ixx3dQHpLER8m6EVldtIRPoXSEyv4euzSoxDoTfDOYYI7X4oNlmPb?=
 =?us-ascii?Q?AN629G8iyw+YGGUR6yO6LrtN/hHBXKYfeiZ9wkkZKKclR5sbL+R39VwZ2A4b?=
 =?us-ascii?Q?sRSSJkYLLonvpZ0ALHHeyI1bSWxCrmfjx5hMFOWpfeKlhQ4/fVvKg/nFe3G5?=
 =?us-ascii?Q?SgVz3sURHWl0bxPbOlQyC2YvHyEshuQm+GITl70tBczXu4fRW/Fy17vXvj55?=
 =?us-ascii?Q?DV5HuVF7M5877XHm0SG9c4JGS0q8I70NIlQ0+9cuLV/uFb8qiUS5o6/3OXBJ?=
 =?us-ascii?Q?Jq2H1Y2ZwwaTB448WJAoCSR5crdAFdPnwU9zSw8V2+DW9dK+rSNLj7iJ7hRL?=
 =?us-ascii?Q?iW0T1MYPzlr8O5ZsXf/s5D6r9SBeKfxZEzKnt2hfH2sKiKA1XfR7CRhBnkED?=
 =?us-ascii?Q?uxMm5O+sI/JvS++9SrAC5MN4LsK/YNjoLelJi95VCLGenPqs0ATkAhplnYkR?=
 =?us-ascii?Q?oKSN9noLl4IWLcDgkplUMQQYbRA9KdWJEJEsLzTxFnTptYkyWDtSuwev21Y7?=
 =?us-ascii?Q?f7RkW9UHHJy/8akwpHGySrIkTDlT65DFip58HD7UHERHIYjtPraQ3GurcJXy?=
 =?us-ascii?Q?53jpy9xMic15fB8WsERL1aup5V4Im+SKhhRoKipUUyMJ/hGlzAgijdPfqLio?=
 =?us-ascii?Q?fhjdy1acavIFcgDMKR5Iag427tyv+C6t786MT9v00cpg1g/9k4kHk08JNKDX?=
 =?us-ascii?Q?eQ3GsCCc5XI0VoTTOT1bIhUH3QnwtiNjgWXRmW1JZbWPD2KlKZ6A7BwnyvS2?=
 =?us-ascii?Q?4CiTDONkLJEf61BbfMxrMc1GuNi4t/KVEGPVviATEBtEAJW/+48wmOouWp22?=
 =?us-ascii?Q?ppVQagQmhghTekMKQKr/ZnEnMwFpRjU5cB0GliG3tOCACmQwam2UyrghVd8C?=
 =?us-ascii?Q?QyIX8ZHIX6AqodItu9JYjO0ftsu1z+jsHjYFJekf3am99BuNcAL9abHY+MWl?=
 =?us-ascii?Q?hcQP3NCzooiHmjKlo2UDOTxNS2PHmi99InV+eOIeCbQUuKCHGDmHGhPcNPfM?=
 =?us-ascii?Q?2xuk6LB9q4vgJRW2+PK/wmPNw3Ks6Y2WEuYKscy7BYvKQN1u5XwED2fQ5gwY?=
 =?us-ascii?Q?RdMu2jPP8pFrvS5Ihqapxd2v?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7a739c-e9be-442f-1595-08d8fb31abd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 08:30:02.7228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1YLMiknA34HhtJvJOJFoLNhZihEnUOL5VRg/RNuRDc39wjeWD8kn101wDuSVTKpmWb3JX+ElwjWsxUdVOS6v0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2780
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
Content-Type: multipart/mixed; boundary="===============2025270637=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2025270637==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB40751131521DD27DB73C908EFC739DM6PR12MB4075namp_"

--_000_DM6PR12MB40751131521DD27DB73C908EFC739DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

It's ras debugfs change, so please fix all "sysfs" statement in commit mess=
age. In addition, please also print out message to inform user the retire_p=
age is only for test/debugging purpose and is in risk to corrupt eeprom dat=
a.

Other than that, the patch is
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Friday, April 9, 2021 16:19
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: page retire over sysfs mechanism


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to unit test page retirement feature via ras sysfs interfa=
ce

--_000_DM6PR12MB40751131521DD27DB73C908EFC739DM6PR12MB4075namp_
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
<p class=3D"MsoNormal">It&#8217;s ras debugfs change, so please fix all &#8=
220;sysfs&#8221; statement in commit message. In addition, please also prin=
t out message to inform user the retire_page is only for test/debugging pur=
pose and is in risk to corrupt eeprom data.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Other than that, the patch is<o:p></o:p></p>
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
<b>Sent:</b> Friday, April 9, 2021 16:19<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: page retire over sysfs mechanism<o:p></=
o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92f4c5c" style=3D"margin:0in"><span style=3D"font-fa=
mily:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - I=
nternal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to unit test page retirement featur=
e via ras sysfs interface<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB40751131521DD27DB73C908EFC739DM6PR12MB4075namp_--

--===============2025270637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2025270637==--
