Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8646CC4708F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 06:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382396140F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 06:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382396140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01BE56F597;
	Fri,  4 Jun 2021 06:58:35 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2089.outbound.protection.outlook.com [40.107.96.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 557806F597
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 06:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EM9KcKkvGwiZDUBnKenQVt1PCLglkv+9jUJgSUmNd1B0Q8ET5Cp1VlEhzAaugAJyJU76eDlH403yPHuiJkQClBuMlsKaNzU12C7m+XbIsduAh2qzHJtXDHhFlaR0gVnys/C4pVQcmuiQ4YHeyW0T0cvLJb2YRT3a3o3UxxAua5pcjWBZQIJQfCaU09Rh/9nX7tmBaKEHsZ1nXLOcXWf7sWEEPeacUnYEAWI7sqtbwFsHhuiFGaiS5TGJdIL5NZtHQLUdo8vESBeoZIdayPfOfc7mlGnv/63XR205KUIm2+RzzvGDfmQ0rK8hSpaKTZOl7nqUD6eqBy/r1bP9CKPxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5ZmoF2+RmWPkQ8JDdaylQDDXA2VEI5DlTnHIy4b4F8=;
 b=Bq7fg7oWG+cIhJCHoTrepPecGYzGiZAUuLb+Ya5+gXKBq27XjTPuCWs1eP4fBQaq6bTv2JmCdO4Wym7Pcm2J6RCcNl881OQZH+5TAL2q90PMjbq2kvYEuTIF40d7N6Ka0Y8t+SeK1WFIs6Z/5MOPUKHfRvoER/hSMn09mXkAKFid4qjLNutaKFt5hIsfx5UpvTTh2UFxMJ3smVWTAmr9YbRv00TeSHeTKA1NLwqSXcenVUv0lCFj35A9q2Uy4bN/uP1mHooDBqT/Lk2+9SF3dWzhq1svd0kOQGaxUK+070OL4zS1RjSJAc4YUeO0Kdp0/1aKAMJf4BEgMGGi6q7uUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5ZmoF2+RmWPkQ8JDdaylQDDXA2VEI5DlTnHIy4b4F8=;
 b=BXG+yZbynbmqcc7TTYia/DsFe39KEO98cBUVBXk18rcdCWfWIvTFHG7dWrvyYUKpsMqgmfF7BtCQtsgmFaOBi5A30iEFzIqTDDlCF3d0J8OCtd1eoP/2PDL2FlF6RCSOOj80rrqKqnRM8wMtGWBup69KUEkqBY9bcmC9TI/Zxs4=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5171.namprd12.prod.outlook.com (2603:10b6:610:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 06:58:30 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9%3]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 06:58:30 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Remove BACO check for aldebaran
Thread-Topic: [PATCH] drm/amd/pm: Remove BACO check for aldebaran
Thread-Index: AddZDjg3Cu9CTGIiTJylT/P58zU13Q==
Date: Fri, 4 Jun 2021 06:58:30 +0000
Message-ID: <CH0PR12MB5348A2718AAC812DE39B7DEC973B9@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-04T06:58:25Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=efa9b7c4-960f-4f7c-8c9a-0c6b44e79a63;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [2401:4900:2352:158d:ec71:65c6:5505:11d2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64b2d83d-7dee-471d-d2a9-08d92726294d
x-ms-traffictypediagnostic: CH0PR12MB5171:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5171403161B85962DDA13854973B9@CH0PR12MB5171.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v9A0VgHGLd+IeRbPnVYaEXFxjeaxb8s7VfZ0F5Wcw12/iPAADm5saVnVGgdxSHYKjVrPmt6ibUOkFqaDquzTVjsMwiwP/sZI48SqqB9Sb56slblDZguLAq/+V0NyIZd7iUQ3aRmMcYmWV3H30mVlyyKiDgX0MCDrAV6mZObNvYJe5ny0ggB5zSMIaBvq1Kj+121DgRHuCWFPdJURdzvX3ZUaGmiwrUkX2F6OrXhqzjk4/wv4SUlFh5SRrEXP0vjmeu7nhODCofyBeGbn0l0S414JoCa/HaoiwFmb4GjhcElNpl2QC7gmubWhARz2GIjD29IGKCIaFD7y7VmfPs6EAt6mEnyddwP9Vx7O+Q0WknR94asgEm/gPUpI5Vf8stiGJl5NbyTsMJatIzLrwRuCBxcPSbgWDWqczZ74DrzI9milPKY3ZmxlglUDGX4bnUDV9cj72pP8Z7IgtohaBh8jeQET5ojxkXLnw310JCu+QOiCz5JKLFfQHqsmVnoHIum8sxx9R2UdrH3qD+QQQkocyydckiawoffGPWZzfJxr0thJn1lQS5tqDGfp7xfsjk9D2hjPhKgn7ge1J8N3RILExhJSSyocTFn4HZItPU7qaiI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(8676002)(186003)(5660300002)(478600001)(9686003)(64756008)(66446008)(8936002)(66556008)(55016002)(2906002)(66476007)(52536014)(316002)(6916009)(122000001)(38100700002)(86362001)(4326008)(66946007)(6506007)(76116006)(7696005)(54906003)(83380400001)(71200400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BlVI0JDSf41EwC1/V7a98exPIBlJybDkFUala7Svew8mtSdejtq5LTYnE+0F?=
 =?us-ascii?Q?REH76bwgP7DO2j2zBIHupXLYZkv4Ehlty5SZGGA31IyZZ5TRJ4K0AzFOAN4o?=
 =?us-ascii?Q?yRrESsk9XiZVsxUQGWsjTYUw9K43entdGcq5xeVqhA4wPNfCQXn25A2oNOMA?=
 =?us-ascii?Q?BE2WSNX+x8ILWxD6r+YwbnV1T5UjQI2VEOB8jrxJW6yPzu9reG4czl+m8EFa?=
 =?us-ascii?Q?IPCT2S3gayGJhbfox0jt59jdXbISkv+bz5E6sTgH9jOwFI4JE3+fr2kGPGcF?=
 =?us-ascii?Q?+6tB+xzQo9jiWoYJEtHVw8acmUXvNFd+THaFgJVUQ1Hxp8jWZG8NlmuxP2OP?=
 =?us-ascii?Q?cIRippQnBdWBSGmsJAlGuNDD3eviceme0H/qX9CZQDPDqCSkzaU4HXOrFRPn?=
 =?us-ascii?Q?l7wxKv8Y0l/b+SSpUltY3i26I9X1MTMS2zxkO7FR8cF7wR7dYnOvti3ikZLT?=
 =?us-ascii?Q?bFnyXY03X3P2MWntiRXkYBZUwVUQtJW6E8F4jnk2RqG/mWa1yqlMEGdrl2kq?=
 =?us-ascii?Q?6RMPmHCGxWfWaUurlLKpfJmpeVI2bZxA+CFUp3iYTGirAihueZfGX7jPNzNC?=
 =?us-ascii?Q?+82faUgnRUii/UMh4xAk9JSj7zRGcIORtBJiaOsshv6unEkzrJIBy8JpSGta?=
 =?us-ascii?Q?sc+GfjKEUCp9e2BerpT8AP8jRWElf/FtdUQCzEFd6Nx29gp8dKh6gK9z7Lr8?=
 =?us-ascii?Q?/fhuU84CHAtPtlDuj7HNvkBadCCS2jOeFtwyDzLNykk0HQYi+jA9Nf3en5m4?=
 =?us-ascii?Q?bxl0c/cl4rfdZ8Zd7Nkfw35X3D1pEDMC+/zIIZwJ32i25WKy1k8tEbJwDcip?=
 =?us-ascii?Q?cXcnSD4HHRPtBI/lWoY6q9l2FkXmgn9Q1a5Mv03VeGwtb6qXGMAI2z2rr9Oy?=
 =?us-ascii?Q?c/PzPwBYeINmFlBGyghRsff5lhXAK5XgRILcXFl634PApNpQLWhkDON++ASi?=
 =?us-ascii?Q?zLt/+3EcJyT1oSslKyXB3Eux+Vc0Yjx1sgTW4nY7biQZCT/urJTs+P5dMgW6?=
 =?us-ascii?Q?SrTDCE9HeU29twV2pZ0TBoJ5x9/ByDn+2gaK+RJfBw5bSiEMKFJmlyQ7J7w3?=
 =?us-ascii?Q?CJU3F+fjpG27v6RlvZ/FDxlb8jRAJhh/RhH2v5Mj/dtDpQdT30Ehg8SKiklz?=
 =?us-ascii?Q?LMqjGn1sGbXI2oKCZldmLOmkyZsoUxIIqWyYjfgcZ2VBxx1os6rBSFZBmXC4?=
 =?us-ascii?Q?bODR+18TMUuUBxVxWTe9p1uzTfj52GEwAuTzx7btqMqo2hnIcS5sFe0SAEiY?=
 =?us-ascii?Q?tYeZ6uY1T4wu/AcDXVtBo0rVV8GZeonwDE5ndihdgssbNxC0BdptsHxXSD/A?=
 =?us-ascii?Q?s0wu++y9KdMD2+GJPtI0qzIzJzurDIcvUWlFPcf0P2makwFsl5CrGFGnfSAA?=
 =?us-ascii?Q?DDnJUqpkHXw8cmhXQKdMF6Lcnb5l?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b2d83d-7dee-471d-d2a9-08d92726294d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 06:58:30.3020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ClXPauskbClEcX5XGYOrAWMI+rLDyAEar2RlgweZARaSKq2/SuDqnBKIA7WypXhM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5171
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1032015436=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1032015436==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH0PR12MB5348A2718AAC812DE39B7DEC973B9CH0PR12MB5348namp_"

--_000_CH0PR12MB5348A2718AAC812DE39B7DEC973B9CH0PR12MB5348namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

BACO/MACO is not applicable for aldebaran. Remove the redundant check.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 7 -------
1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7a1abb3d6a7a..6ee9c4186f02 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -355,13 +355,6 @@ static int aldebaran_check_powerplay_table(struct smu_=
context *smu)
               struct smu_table_context *table_context =3D &smu->smu_table;
               struct smu_13_0_powerplay_table *powerplay_table =3D
                               table_context->power_play_table;
-              struct smu_baco_context *smu_baco =3D &smu->smu_baco;
-
-              mutex_lock(&smu_baco->mutex);
-              if (powerplay_table->platform_caps & SMU_13_0_PP_PLATFORM_CA=
P_BACO ||
-                  powerplay_table->platform_caps & SMU_13_0_PP_PLATFORM_CA=
P_MACO)
-                              smu_baco->platform_support =3D true;
-              mutex_unlock(&smu_baco->mutex);
                table_context->thermal_controller_type =3D
                               powerplay_table->thermal_controller_type;
--
2.17.1

--_000_CH0PR12MB5348A2718AAC812DE39B7DEC973B9CH0PR12MB5348namp_
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
<p class=3D"msipheaderc10f11a2" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#008000">[Public]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">BACO/MACO is not applicable for aldebaran. Remove th=
e redundant check.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;=
<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |=
 7 -------<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 7 deletions(-)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/alde=
baran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<o:p></o:p>=
</p>
<p class=3D"MsoNormal">index 7a1abb3d6a7a..6ee9c4186f02 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -355,13 +355,6 @@ static int aldebaran_check_powe=
rplay_table(struct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_context =
=3D &amp;smu-&gt;smu_table;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_13_0_powerplay_table *powerplay=
_table =3D<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;pow=
er_play_table;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context *smu_baco =3D &amp;smu-=
&gt;smu_baco;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu_baco-&gt;mutex);<o:p></o:p>=
</p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (powerplay_table-&gt;platform_caps &amp; SMU=
_13_0_PP_PLATFORM_CAP_BACO ||<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; powerplay_table-&gt;platform=
_caps &amp; SMU_13_0_PP_PLATFORM_CAP_MACO)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_baco-&gt;platform_supp=
ort =3D true;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu_baco-&gt;mutex);<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;thermal_controller=
_type =3D<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; powerplay_table-&gt;t=
hermal_controller_type;<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
</div>
</body>
</html>

--_000_CH0PR12MB5348A2718AAC812DE39B7DEC973B9CH0PR12MB5348namp_--

--===============1032015436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1032015436==--
