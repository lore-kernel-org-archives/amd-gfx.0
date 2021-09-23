Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E267FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 08:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0986103C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 08:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C0986103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E211B6E0E4;
	Thu, 23 Sep 2021 08:35:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6029C6E0E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 08:35:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiQ6BDN/7BUBZssmGnPA0XD+6O8F7QInkyg8G9pewvU8CFeqURpLtDW8TDmNRQW+U6GdUiK26dGpU0qBUBQIoqKowBV4p/NJ8TwnBFjc9WouMlONiA0gwIWgK/P9I2iRQh2B9FNl4Ag0V6CXi6XUBgmeFOzq71FFdNymPXv3Q/6/O6E8QZB8nLtPHW9q0YqtRJ4AJ8VAjcotfLS2uYtkG3YJuV8ylD/4dvyqqBTB2xwD3BwLDujZ4zorA1EptRCNKrbN8IyMkyXgf3rV4YF3K1ETbKo/eAcjfsrrUqrRj2hm9N87GxoDJ1wWmq16//8giGLPIR0feMS8zSPI49Invw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=s/cKL/BbGZ7g4SnF2SugmN8jzw3rj5/xFbfaPMYSSB4=;
 b=UAR+KpVUjqQXk3vkdHQ5qtdzimHJ6a8b5S5Ixv26qU4CfjIAo2+pMaEGJeNI24VV8SfW1+rFU/cKTNywt/Np7bF2ShOWwgICSiYRLskDX+KO4IF0earbWQ6d1uCB1DR5Yg1xL0EQnD20JJq0s7Qyyid7nYRwndNR0b2faYP49c1uKhwcEebjZzMFXVaL9oNgOnpVS8ljaFO8/Xi68FBnQ/KZfkKL4atRMA8dX9YxWHYk2u8VOakFF/tdSs+4jEECdZ7sj0Euju58CMHlP87v6Rwyub1FJWZkyEQXqpOXsR0U24XLHMLdTwXwa3QLlSmcwuOv+IJknm3Yy/ZGc9Q6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/cKL/BbGZ7g4SnF2SugmN8jzw3rj5/xFbfaPMYSSB4=;
 b=mTXtvH+/7orhjGjHC15/G96ptjP9et5IF0YfjtRCWY62LyHsaHgt+ZP5f33dF8QltW6tYfEtRUEuQmZ6tN/ro1InAKhSmSs120SBTN27mPPp/YvEklk10HfdR+nXtieEZVGePjknU8yVgj2Uk8Ws1qWBqYAyaGxSgpdJNvSVDVI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 08:35:21 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%7]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 08:35:20 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Consolidate RAS cmd warning messages
Thread-Topic: [PATCH] drm/amdgpu: Consolidate RAS cmd warning messages
Thread-Index: AdewVRRPJn7b+HXdSjuE4UMuNi8xqQAANIZw
Date: Thu, 23 Sep 2021 08:35:20 +0000
Message-ID: <BN9PR12MB525798BA5AA849F8142BE267FCA39@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <BN9PR12MB52261DD3067B1F6747731B9EFBA39@BN9PR12MB5226.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52261DD3067B1F6747731B9EFBA39@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-23T08:35:18Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4c4f64c4-0ac6-424b-af8c-0e39fc797825;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80bcee91-b533-4fbc-7c31-08d97e6d1470
x-ms-traffictypediagnostic: BN9PR12MB5337:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB53376EBC191896CAE68D1F74FCA39@BN9PR12MB5337.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F0H6XJqOwEnSw3Rd2Z2X66UzczTubPv4azhra88QHCy1fP3CSmFi6PQ8QzcCUtqAiTy1iVEJS0DAz2Onh7aIXCJfPQ4TJum0ETRFOS7CjAV9/irR4RioN/aFIrnm6u0G6VIQ1Ncse5ZB+WvORB3d3LI8xamVj0ThFS2JorXPp1CBx9kyABhOPT/+d4/hM1vsY05qjYfDyllzndcbQptOrI2PAEF7Bk3kTGVLR1sB3ix82XRip09mSbzQZ7qEBDXmMrKj9MuF6TZSJc5moUAIc/e/WXYgXJ+UnXpqwda0rbaN1TwYweWQbPs1u5Jb5BXZ1p0oSpasfYypdaNHYYyXbhr1lhRfl8UioxcnyAqqKJJvLTwVDsK3s+g2uZmGSN7x1gktYrgwNc/T1jBxWDcOtHwPLWW0OKsDNqHEfE6wO374DnqL9C+51E9wSdQ2sQyYasWx22GGbKk60BhNBdzZKcy34MVZj8ehNPYMc5BaWNAS7gHwYmzhagzXnKdmKu/KztPf6vqZ2RStHaZVRcIKmlWGCWEMQ4Mut+qZJauRiPBqCFBnoqmNijFjl1Ie341ZsaAI5aaKN+3v9TqqZW0jizEI7ErynkkDkeRLnLpc7Z/W9kPAhTbnNASGiCCgJ8gDBNBPz0ui3nnU6NdX/k7KMs8m3FyHVYq2SC6YN1UN8hj6vRSdGuVndFyq0j85+7lfIKJG1iSkrzPfUFLsgcoU4g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(110136005)(76116006)(55016002)(9686003)(66476007)(66946007)(66446008)(122000001)(4744005)(38100700002)(64756008)(71200400001)(5660300002)(52536014)(66556008)(2906002)(316002)(8676002)(33656002)(53546011)(508600001)(15650500001)(38070700005)(86362001)(26005)(7696005)(186003)(6506007)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F0rR5WITBmwI8mUyiQA3vzDxVEkXD6PEbNpUQq7sBE+LN2Ocn96vr5Vb5IxT?=
 =?us-ascii?Q?Y4o2ASI/uyeBj7x9I/hH5hTctWnISGzLJxtWiylU0hwBPpRhykYGd/WZnEg/?=
 =?us-ascii?Q?g3F5jyqm9arLW/L6bK0vgI1cI2zwoSerG2imiw30fwfy3dRymST6oJxojO8U?=
 =?us-ascii?Q?FZs0w5785BnTCf5fYiJcSxqaCX8RyHMk8LhruQfMlzQYnTt8yIDofMsSZi+O?=
 =?us-ascii?Q?U2xiOKE1TZS82uksbUQsEkovaooFLaPoTtEbl1q86BPZUBZ23IegyqA2w/Rg?=
 =?us-ascii?Q?8nEa84/CWtjb9ZHxcNEPdrDnkyxCEUSHgmBWzSi7sgKm6+N0C9Iybbms3aA8?=
 =?us-ascii?Q?Rt7u9MX+immn8TaZDzyInO3PRJVA1EzoGyWbKTi2EsMo2Tkdu6T/TV29gH3b?=
 =?us-ascii?Q?B5jAO2W/IOWXYfjRSDpnZr2nEiNF7QYOZJjgMxwnibf9jBW8VWAn2nPB/XdY?=
 =?us-ascii?Q?hN1b5aLW65ti1k3JJ21KBeznB7CTyPpoZgGXs1OnWOH3tYwzWnXdV5Lnj4dO?=
 =?us-ascii?Q?37zQMrN5sRSo2O0DLdffXdWbp7ZWrKo2x0HFFvrE8Zv2CCIbEpWHYZg4NNBr?=
 =?us-ascii?Q?dMS0Z4McFTflpMCGopevNV/16Fo1le30V8g9EFC3yLu/sA8/KbWBHHMGsJlg?=
 =?us-ascii?Q?hIT2HyviEH/u/35/d/Ncflsto96TPTQ52VOM0NmPDQ/EMZ4twp3XrSxFGMxu?=
 =?us-ascii?Q?6GV7DtCcWK8Dn2sINxzrsYTnt4nrbpsK411WK9QD4pn4VdDJlmAfR0H8yND5?=
 =?us-ascii?Q?aJDKJH6mmYJNpKYwQAGM/3Dnc3hF5Z7+tRRS/mDmwf03WbnD3fbaKPYPImZ9?=
 =?us-ascii?Q?nAEkvp6txtuTGKI+m1RNWFrWYi7KA1kBjHBfZ6BCjIRBV1fxjNoFJzdzz+ig?=
 =?us-ascii?Q?6dFDJuhtqnp6mkwNqLxrR5WunoAheh+za/h61pTJzGTcbZ4Wkjil6i0CNN4M?=
 =?us-ascii?Q?OxCKvgBlXNIHj/yYKUf/logiSVY1Ka2HOZ37Ap7RdF3DVR7126G+yqPizWTp?=
 =?us-ascii?Q?8ZESESjDdTXp0njFh0DoiNlxGyfm2dfiub1kjf44U2neGSAOISSAE1Hg0/pi?=
 =?us-ascii?Q?RoGMS/zvjLdhhArw2gn88nIZNKQjSOVU0+1lCbcE7vtRMIY8wVTce6cSAm4u?=
 =?us-ascii?Q?5s7Ry68svOWPnSA+BSrTWAyrMTPjUlrxvXyiE8kd6PHkeYIYEjxK0nsKzd+T?=
 =?us-ascii?Q?EL2ag6MHxjzk1Y1snoUFRO0ZNjxhGde2uZhKiJmbPtkGwXb+qyM5MGUe1hqD?=
 =?us-ascii?Q?onwQcvosBGcTNL5yOCupyZsCleGm25ZbsYdaOrWA14vmX9bC2K6TIsTXk8RM?=
 =?us-ascii?Q?PFlW14iPouhAvipHpWaWX7B3?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB525798BA5AA849F8142BE267FCA39BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bcee91-b533-4fbc-7c31-08d97e6d1470
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 08:35:20.6906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/S788d38oVgMfAXD1AB75LXNh4QaRKLaacQNinUTjwcp5Kg34qKwulpffpDAnEcfEO4t2aXdoPJhndOzAzIJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
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

--_000_BN9PR12MB525798BA5AA849F8142BE267FCA39BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Thursday, September 23, 2021 16:30
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Consolidate RAS cmd warning messages


[AMD Official Use Only]

Submitting patch to explicity post warning if RAS cmd is issued against uns=
upported IP

--_000_BN9PR12MB525798BA5AA849F8142BE267FCA39BN9PR12MB5257namp_
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
<b>Sent:</b> Thursday, September 23, 2021 16:30<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Consolidate RAS cmd warning messages<o:=
p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to explicity post warning if RAS cm=
d is issued against unsupported IP<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB525798BA5AA849F8142BE267FCA39BN9PR12MB5257namp_--
