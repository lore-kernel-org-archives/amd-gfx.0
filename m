Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EBAC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 16:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D81360F42
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 16:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D81360F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F026E030;
	Thu, 26 Aug 2021 16:59:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B31846E879
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 16:59:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgoEJXy4i5xo3+mFSKgWcKdT1Ot9O6B5z7gZiIOH21YHic8913qK4AxFH6aeqbKN7kMQClvlPJAo0lR7hkeWUVb+SZ3ar9SffyvSXooKhiqvAYhHxllc/5gruXhB7+DlFRwKbU04g9M2xh1Ti99EuGTiNaHoSaWOKxlJy3IK0r2cLeYaZOi9DlpnqamiIX2QqoATDciS9McYCQvB+OLCOOPl4bg5WqsJUPr1MAZ14jc2X4+dZ/udfGjzXzxG0pF3u2lpxzrcPh0JNNhiz6LXNITSkW0nFMljyoPE9h0I227ciS8fVXI+QNH0Qdmfu4gA6FJECAASFGbHolq3HaCjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7UXGEI/5cj5zoYOUVrgT9L8926xG5UbhtkO0uWSWRc=;
 b=UxgP4F6lTas3dhShD/GD0ZTmm6YCUUAnTiR3+81ObfzGGywnIAReYhAqWfuihmS5x9DjBKcvjTTSmGFcvkYnt8A9BNwzB+QSzYHSY3sJ87ZMQmgDuuECKmGzvAZlkpVKmUiauia4GR/lGUA5peO3ntoBECBnJ0Hr7Hbdqn0aKyz3lkW8R8kjtwMVNF49F8iLZEiFhuRoPMCp4kFY5nrQtCHjKpoXAGJZaFhFeYL5e2SO/6sQ24MZVqjs2tn+3RawLvv+B5s20tPO9OxOiRG4E0utg+wg3rfWkaGE7g8xzH73vZTRuWrnUI1MCiM3C+Tj/jHcby/6Ms58NrzSF5I5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7UXGEI/5cj5zoYOUVrgT9L8926xG5UbhtkO0uWSWRc=;
 b=CJrvISz8Btcw7r0Tj2dv3f4D+fgd418ueQfMvwe6AGgUylX+JQNiRC/zg81Z1DAAwWxvqD8691WQAkbYJv3bGUMRPkAGCwk5CRH7jisNCipPfKsg9SAB980REZ3DXv2Cu7BFWaFZEN4RnY6oDrLNWyX6k8e4jymeI9A0eHKO674=
Received: from CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Thu, 26 Aug
 2021 16:59:09 +0000
Received: from CH2PR12MB4151.namprd12.prod.outlook.com
 ([fe80::3ca9:a7fc:e46d:ab22]) by CH2PR12MB4151.namprd12.prod.outlook.com
 ([fe80::3ca9:a7fc:e46d:ab22%7]) with mapi id 15.20.4457.020; Thu, 26 Aug 2021
 16:59:09 +0000
From: "Wu, Hersen" <hersenxs.wu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: add dcn register DP_MSA_VBID_MISC for dcn1.x
 and dcn2.x
Thread-Topic: [PATCH] drm/amd/display: add dcn register DP_MSA_VBID_MISC for
 dcn1.x and dcn2.x
Thread-Index: Adeam6rz1or1EhI6SJmeHmo8N6tHTA==
Date: Thu, 26 Aug 2021 16:59:09 +0000
Message-ID: <CH2PR12MB41517A80B79301CC995E6977FDC79@CH2PR12MB4151.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-26T16:59:07Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7f893751-acca-4271-9bc0-0ee4a2ba3b83;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbb41a0f-d00f-4738-b054-08d968b2d280
x-ms-traffictypediagnostic: CH2PR12MB4327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB43271ED4F18CB75B5A761B9FFDC79@CH2PR12MB4327.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GmVQF6K+xvZo6AOlOFSNtRmo+u8EYtH2LWIzqXoXqb6jjf1kOL5LLhTNEfBhY2i5CaJKZXpgcntIO7t1TzGJvgobBjblNO/BoxXNiej75U/h0buwumnpGpsbtNUQKKrVDcTcUKlWgKa+GA95Hjo4twLK6ArOzBOLnt4femyzNz4vI0F1SURpHbbn1WYOW+hXyEdLKKpxrhUDT+eXMo2k+fXYrFuGfWF9+8Uev6hivHzP3wRA122H6Sf78+quhVdnvJjA5eX8D7IKewaxUM0Fg8p6k4oXg/6s5VKetcxT4vIhU7zmcAlOWOKiOL/2RLDabOb/yxtaB8fwrn2R95SZaHJc3XD9OcnkVbgElxwVte8gafUeIgO5S0zrhZ/vJZRHRn8d7pNMGdKa1pxsGx0ow9RDjMhHl/PdvlrU9/QINjOUDbJk6Q4t+qi+suHZGyCQMW2s/jwIapKeoPkoV1+7QyXBP2VCLUcKG5uigcWIBUF2o7hfL80Rdmf4Ab9LLebTB7ME2gqjCAycVEj8XhDvob/IfAjv11XBFLIdAXWEXhIEInwFlhVweBIwCUHLULjtxaFXowHfsh9W7vmc96hE/Lgv16x0f+GhA5nD72TnfrWbKYxH98/OuqGHl4yASLHbD5vbszQvokqlQaLeEaE2wc2jBRIad83iJnDK6KZHhXO70Ouc4ClsNls88unIe7kJ91B0fnHTi8ajK6NdJW9MDQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4151.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(7696005)(478600001)(6506007)(53546011)(55016002)(76116006)(9686003)(316002)(54906003)(6916009)(33656002)(2906002)(186003)(64756008)(66556008)(66476007)(122000001)(66946007)(4326008)(86362001)(8676002)(71200400001)(8936002)(52536014)(38100700002)(38070700005)(5660300002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/A6oPXV2gKGlA4E3PI15Eoe00uegKg04UH0UgICtBmgkYTS2cOOkyVzBEsu2?=
 =?us-ascii?Q?dhBnlwoyE4UJt0gryZUmGIXjD7zxPcQbAsokYaKjeiM+PwYfJe9dlb116RdM?=
 =?us-ascii?Q?JafL9SUiaYPHvq4a1whho8BDi3Xm3fZJRxgQsIqyONF99oOzal97CyLYZvP9?=
 =?us-ascii?Q?9dIFRKWlfsDDFPpix5UULSGIXGSOb9qDalmKnBPAhdtrnmRHoW70Hxw2vUfU?=
 =?us-ascii?Q?qMFdes9XGHmyixNGnV0TFuQwE/0AsTQYCHnzGIFPXILeVAO0tSe6UDFkZr4A?=
 =?us-ascii?Q?2oa0xWyrDVic+rE567eRQJkdCmB7ATb1/oRaSFHgD5Nlm3njbrRVK9FIqfiz?=
 =?us-ascii?Q?dJos8axdIrHsVYjOT6dAkMJttbZaLAzD/gB2f5BRmK3+ENsvamHhoJWhT/y/?=
 =?us-ascii?Q?ecBay0j129QiDj48fRE2YOjvl1aZlwDubBNHpzlE6WbfKFduBSwvQjWkKJys?=
 =?us-ascii?Q?6bQbkkXfalUI75EWokyoXCjWpzbyVbeW/eNCUEbY8zvwzYg1YATqdHH9oPrL?=
 =?us-ascii?Q?+DRyUTmtGVj6WpSp0TGUayvnvL9UZNaRg5pqwFgJXbaEt7L9kvuRZWCwroDW?=
 =?us-ascii?Q?L7dOdZ0IyqqI6qrzC0Z6wwyxNUUhkY/8B1S544Rg+XC8qFGIpN7fn00Ck9ti?=
 =?us-ascii?Q?rf47ZgtBfLWGotDFMzA2S1uPLE1ly6q77KRVBh+K/h35eN6fUKhm382AuepW?=
 =?us-ascii?Q?bA1VxvNRu4T8+sUmzozbS0YTkitTvB57inOhv1SBFnQ1zm/weejj/4B8Z7D+?=
 =?us-ascii?Q?Nn+Egms7iETgiQDqz600zFhuCJAFyLnajeGDzg48budFcNeQGLI4N3wwkBx/?=
 =?us-ascii?Q?hDoiGIGA4wqU9/WVC5WsvfdG4fr9G4fAmzm/lTq+kclLHzh6mYC7c/1TDw4p?=
 =?us-ascii?Q?Luy01wSQMv1LcDWaqFNapGOzxNSw1J63UTrRf+q1DZRrk0pa9F2PtbmcYwB6?=
 =?us-ascii?Q?RhlNauQqwZJC+lI3+LbWxssV9rK0VxnQWq/wD4F4fdGwgKANRk4EG/TrTUzo?=
 =?us-ascii?Q?317RNd7fULtq1Us8dvCxUD6FjrMQZXp0M8zMB/iAajGAwtLj2O/V56on790T?=
 =?us-ascii?Q?P+doXN0M0uVuuldR3ll1HgCRndYSUqOnJX/L5EOtXOb9mY/dcwCQvP52Ijrp?=
 =?us-ascii?Q?E/kPA12r1nyQF8XYmwOYnm15YPFTqzdlL0ZlA3fP3DQ//d6qFxv17br1y3pX?=
 =?us-ascii?Q?QAWSLhNbVVn/dUGi/5cgaOrnceUoCV1lEFrXSCMWexuX15yf3ge0H0C1QeLs?=
 =?us-ascii?Q?ZhYWRL9wf4v/jaAe9WOWoZPSioZhkQkhbwRktFPJ9BsRD5G9JUnBjDtvyU7s?=
 =?us-ascii?Q?mpYjirea/K9NZEOyyou3i6m1usXbBlXUAnIKqxN8eN8/QSYHKrOdVhGp3SoU?=
 =?us-ascii?Q?qNN6v0uyDOLjksvMhSw+9HJ9kpDa?=
Content-Type: multipart/alternative;
 boundary="_000_CH2PR12MB41517A80B79301CC995E6977FDC79CH2PR12MB4151namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4151.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb41a0f-d00f-4738-b054-08d968b2d280
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 16:59:09.3149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iW8ZCTE0PJvFbDtKDNNaRc1CoGTCjAl5EsFKuKMtAbJV6MZ5iPWJiSK8JLs8CSF6dgMZYFgXv4OeXNPulndfKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
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

--_000_CH2PR12MB41517A80B79301CC995E6977FDC79CH2PR12MB4151namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

This patch add missing AMD ASIC register for DP programming in up stream.

From 05768b78865d9b41a1d35e9f8e34901321208f2a Mon Sep 17 00:00:00 2001
From: Hersen Wu hersenwu@amd.com<mailto:hersenwu@amd.com>
Date: Thu, 26 Aug 2021 12:49:08 -0400
Subject: [PATCH] drm/amd/display: add dcn register DP_MSA_VBID_MISC for dcn=
1.x
and dcn2.x

DP_MSA_VBID_MISC is missing in upstream. this register is needed
for DP programming.

Signed-off-by: Hersen Wu hersenwu@amd.com<mailto:hersenwu@amd.com>
---
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h | 1 +
1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/=
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
index 0d86df97878c..35acb3342e31 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
@@ -73,6 +73,7 @@
               SRI(HDMI_ACR_48_1, DIG, id),\
               SRI(DP_DB_CNTL, DP, id), \
               SRI(DP_MSA_MISC, DP, id), \
+             SRI(DP_MSA_VBID_MISC, DP, id), \
               SRI(DP_MSA_COLORIMETRY, DP, id), \
               SRI(DP_MSA_TIMING_PARAM1, DP, id), \
               SRI(DP_MSA_TIMING_PARAM2, DP, id), \
--
2.17.1

--_000_CH2PR12MB41517A80B79301CC995E6977FDC79CH2PR12MB4151namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"msipheadera4477989" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">This patch add missing AMD ASIC register for DP prog=
ramming in up stream.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">From 05768b78865d9b41a1d35e9f8e34901321208f2a Mon Se=
p 17 00:00:00 2001<o:p></o:p></p>
<p class=3D"MsoNormal">From: Hersen Wu <a href=3D"mailto:hersenwu@amd.com">=
hersenwu@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">Date: Thu, 26 Aug 2021 12:49:08 -0400<o:p></o:p></p>
<p class=3D"MsoNormal">Subject: [PATCH] drm/amd/display: add dcn register D=
P_MSA_VBID_MISC for dcn1.x<o:p></o:p></p>
<p class=3D"MsoNormal">and dcn2.x<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">DP_MSA_VBID_MISC is missing in upstream. this regist=
er is needed<o:p></o:p></p>
<p class=3D"MsoNormal">for DP programming.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Hersen Wu <a href=3D"mailto:hersenwu@=
amd.com">hersenwu@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_en=
coder.h | 1 +<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 1 insertion(+)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dc=
n10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_en=
coder.h<o:p></o:p></p>
<p class=3D"MsoNormal">index 0d86df97878c..35acb3342e31 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_str=
eam_encoder.h<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_str=
eam_encoder.h<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -73,6 +73,7 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(HDMI_ACR_48_1, DIG, id),\<o:p></o:p></=
p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(DP_DB_CNTL, DP, id), \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(DP_MSA_MISC, DP, id), \<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SRI(DP_MSA_VBID_MISC, DP, id), \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(DP_MSA_COLORIMETRY, DP, id), \<o:p></o=
:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(DP_MSA_TIMING_PARAM1, DP, id), \<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(DP_MSA_TIMING_PARAM2, DP, id), \<o:p><=
/o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
</div>
</body>
</html>

--_000_CH2PR12MB41517A80B79301CC995E6977FDC79CH2PR12MB4151namp_--
