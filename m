Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7705DC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 07:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291B66140A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 07:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291B66140A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B37AE6E955;
	Wed, 21 Apr 2021 07:00:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CC116E955
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 07:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Exx9CcsBFa9yEGvO21NNk4Mllfo8R5Li524rNGbNPVlJSvTwcpprS7RZ1/sAJ5eM5nN1x71deIQTqCMzjwJgMryJ07ZBpuaTRSLCyo4/r2ZWrWWQdLcLkLc6dsFQhBW0Gh9OgdH1AoO7sTt9aoNa0R+e4UCOIAgfnDdcp7RczgWZgMeh+gIZ2Y2qAIGEoPdJCIbhxQDuQPB45yfgQfqh78J3EIo1QNtiJnR6okF4dCpOyNnh6FMROsL8DdadSKXuVMIyc5BsZN/JdVxsnh/96UBpCV3YoE2RRkc3dhfYsnfmgANo3dvRMtNZa4X4DI0sQckgP6WpLiY90chYvZQmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ryfSFX6N50uqWo1gbZGKezTC1IWGdzWL8JZMSM0+2c=;
 b=NwcvYEB1AxmtQeyWf+SN0EEN6E7/cRaMDRPf1dQ9cmRN5oiuqlXcEViDQh+IfqLo3W+yv6PCuvA7BoohVgleIIVBqEY2jws2p+zMz7KXNMFUMW8u4FLi8ut6GxCGzDI2vWIoi0eFRim2I6Z7a6suWBd8Ox/oGZy5LorwIK0WOdAqAjX+uR9TD+29uDr+7b2rlwu4bR55o5Q85cWUvx8om2roWT6iEKpSmWdR5umYwCf6m2W37pA6LY/+KhAk0zf4uyUIgQoTk9aAZmF/Gedw1h8eNGzabbbQ3oVV8biE6UrNHKlbn6zoAJ3rZKF4sD1zTVewXgwcx9FWQ2RSMGBpGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ryfSFX6N50uqWo1gbZGKezTC1IWGdzWL8JZMSM0+2c=;
 b=C/1k7Q0WD6GkJl8aNcfLb2K84P/QDI+eMXj/DBFc0DPy0JoeYsXBwa2vSpkhPCVEA9CkvS8og+xzhqfIQG9DHjpXYzwm35uqvQZa0rJTbbwbnNHOJgxRSJueShYGuVsgAisGjx7BGbCv2Bsd/8/KoRlYJdwdkHgcOwhbnQS/qfA=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5193.namprd12.prod.outlook.com (2603:10b6:408:11a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Wed, 21 Apr
 2021 07:00:03 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4065.021; Wed, 21 Apr 2021
 07:00:03 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add support for ras init flags
Thread-Topic: [PATCH] drm/amdgpu: add support for ras init flags
Thread-Index: Adc2e2sVzY4y+ytVSquzemrmPH/DYgAAHgNg
Date: Wed, 21 Apr 2021 07:00:03 +0000
Message-ID: <BN9PR12MB5368AFFCEBC7064C6F8D4B8BFC479@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <CY4PR1201MB0072C488E2F3326FDE1A1DF3FB479@CY4PR1201MB0072.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR1201MB0072C488E2F3326FDE1A1DF3FB479@CY4PR1201MB0072.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-21T07:00:01Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=886e1622-052f-47eb-9697-356fb92f9a54;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf5f082e-53fd-4640-da8e-08d9049316a4
x-ms-traffictypediagnostic: BN9PR12MB5193:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5193E07D0AA1F4C233291EE3FC479@BN9PR12MB5193.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WoAomur5QKN2dN4l6RDCqrCxU9zX2QSn+W8uvoCL1cDEavMOm18fAIvAhTk5ChiU0xQA3XgRskBiiuAmK/ZOII2f4pKqBKk/nIpoLSe1Ixn29Ew3Sjy5NR57LXsSjXrfm4+CfbSJYP7BAPAeT4Czim+287GP2TtfxZbG957qxi9DmjSsXpCW7INK1Ybyce35G5bcTJI4YwPBmpsTM4hK/0EiecUJ2BntcLug+ELV6WSr1o/ffp2TlCQ2QkOR6ZpCQxKwKeknEBN+aQmiUKhRWJUR3pkCvr4Ukr8lw1IXhPbZKh8Y0Cq1J8LvgAPGhewClACt510z0xkuzQS+ROHsvQP87pEUyviglPt7ujoDbe0dKBhuar/rV/jt9ewxaInVbMCDALKjBNifAsqe0LSXsQNNWFtZmvv5/4aOHDiEqVbm/PwoVmhDHlPVIYC8xNx2upzm9EuYHGY3mA1AU7+d9/XFRn+n841MqSKYiZYETmg1tJiAm/P61RkIS6EHUTbAKF90+C+kGzuHumQ8NJpmC7kIjDspkSq/vtg1kITsySnCKE1KuZ7Dpi9H0ujZbS3e21iFv3vj0FxErN2RO/R1w6Qt4196XPRFkAiECuloG8o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(122000001)(76116006)(8936002)(5660300002)(66446008)(52536014)(64756008)(33656002)(478600001)(9686003)(7696005)(6506007)(86362001)(26005)(8676002)(38100700002)(316002)(71200400001)(53546011)(4744005)(55016002)(186003)(66556008)(66946007)(66476007)(110136005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gRlVXwnl3ZpbNTzrS71hPNrt54nq5B0o2iSna98oZwAfQLiLGRncV99iZBiY?=
 =?us-ascii?Q?nfsWBAME6UkZyvp07tFjmprn2MNkZRiXwEw3itL0K6/wBAPzVccwIPfvR/Cy?=
 =?us-ascii?Q?mxC408SVbG32D8WSy3h4xbKheTbQ0p5xQhxyIgOiaHOBQ8f5ABXbvF9q096G?=
 =?us-ascii?Q?6tqP5L6s7zcfmJudLfnmjEd/KlU/ssXxLnafslQc7ZK5ZXzCY4dibRfUw+Zp?=
 =?us-ascii?Q?LT6xQuitR9CcyoIxK1TrPcWULan8UaQ1QzfoHsVZJfkUAMC68pgtJBHOgKvW?=
 =?us-ascii?Q?mwoeGvhR/gSWqR8TeLhgYfwc7JP6Ru5ydNTMMgLgt++twOfn85wHmwp5rDsA?=
 =?us-ascii?Q?VUdnF722eTQNppSn7g0WXGv6kFEmmXySp/wzICRr4uvPpWqLH5GkNmh3SnBC?=
 =?us-ascii?Q?YJ1haH6farwspWYI7oxojmdpJV0d0M0c8nu6pS56sdcJEZq6+P39ne5o926h?=
 =?us-ascii?Q?WhD2rC/ngfd+zn6wbNasoO7ERSzhViZWS+QSmcbPCvg77EZE8/jmH7FzvNb3?=
 =?us-ascii?Q?Q3cuRioel0GwS0kX56lpmLVsfI7UwEU9pGBv+LD5Z3g+1x2bTO++y3zQS1w/?=
 =?us-ascii?Q?+ZkS0cdgyGLdCAimEJVnJMTrD/L6X1FKiqzMOCsunM8NoAKUHyLo/Y9f0cis?=
 =?us-ascii?Q?7QvR/t74BEbLgRuXvvfTgO3LGgwBD7eMyj2mU1a0WBTGlb07W/XFfJ9W2qq/?=
 =?us-ascii?Q?ULd3FxRqS/twSbSxz+p8ZWE6q8aKTsHNdXmuAKIbaYglDjvxU6IqbblsKo5R?=
 =?us-ascii?Q?dUA5yxqtNUTYINyeHw5I8uV70wJpxnA+DCQ7RKOz43ZztBhMFTbfCfuoorat?=
 =?us-ascii?Q?yYwgnrKRJSUvk+JZvXdCAW4GV8Qee0O9pERo4yMr7RvU36xupP9xvBAw7Q10?=
 =?us-ascii?Q?fore7KOu92Qe1GGBe1M+ERyU81wHulgK+gMwlTNx/zlu34K7SaIUuB5MxOld?=
 =?us-ascii?Q?5LqOcbvMcUUrBItJwda1MBePHULrdui+KuoRg4UcxXvUtt/XqAb9Ko+ZgTAL?=
 =?us-ascii?Q?VCisRR4KxQJYuIcLtQcevlEbv5Nm3u4QCq1eA+UvCeRscYR+jvSr0ygny3hW?=
 =?us-ascii?Q?w/t5tdcXfb+IfikZqVdoqR1CI9RyEoWVr5/foKqncFVUQmGjLrSJfcjf8Pf2?=
 =?us-ascii?Q?YayaBBV70InYFPnBEQqM+T7K/ZmdhKNrJ0dCZYwczQtSxjMRp/tGGms6JN2E?=
 =?us-ascii?Q?xHypmSitopnac8uuFD7Wjz9RnzI2ib97KXR+FHPCr3UTtkXACGXMbDr14kxo?=
 =?us-ascii?Q?czUhaxx9JqKHtYFFe70aOHZpEA9cw+yLY3o4x64PAr5oZqmZlEO1q1Q4qNUz?=
 =?us-ascii?Q?xtJl7I3e3oN54Tmbj5XmREA7?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5f082e-53fd-4640-da8e-08d9049316a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 07:00:03.4838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2hS9qKKX5x08KITkBS3VbElYv3ai9UtdJ/mkT8fyKtdDS8kcmvg5Bmuwd/3eaEdF81eGg9CXjOwOUahNwpck6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5193
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
Content-Type: multipart/mixed; boundary="===============1533723396=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1533723396==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB5368AFFCEBC7064C6F8D4B8BFC479BN9PR12MB5368namp_"

--_000_BN9PR12MB5368AFFCEBC7064C6F8D4B8BFC479BN9PR12MB5368namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Wednesday, April 21, 2021 14:57
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add support for ras init flags


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to select RAS dGPU mode/poison propagation mode

--_000_BN9PR12MB5368AFFCEBC7064C6F8D4B8BFC479BN9PR12MB5368namp_
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
<b>Sent:</b> Wednesday, April 21, 2021 14:57<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add support for ras init flags<o:p></o:=
p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92f4c5c" style=3D"margin:0in"><span style=3D"font-fa=
mily:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - I=
nternal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to select RAS dGPU mode/poison prop=
agation mode<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB5368AFFCEBC7064C6F8D4B8BFC479BN9PR12MB5368namp_--

--===============1533723396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1533723396==--
