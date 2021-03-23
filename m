Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB3EC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 10:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD72619BB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 10:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD72619BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 245F66E89B;
	Tue, 23 Mar 2021 10:54:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 501866E89B
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 10:54:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkitpIRiWJuUmlyuQeP/IA0T31qtstvKTqSV77qVUl9wVQ73vIOmjpnzolnO8XQCTpmXUCaYtG4rG+rWy8pf11mia20dlfJVjLCyeNhb7Fct8Nr5mM6r3IazWblAE4Z7yeBrRdDtNW55z36LXq9m6CDaJFPTpcV9/FtSYRBVnu1VQbrsT1Q2wtAc7LffLTiFhnGPpJAejDy42lECpP7JVMZ+qmwLnWmf2ObrYEh8KV2/A9SLlK8Vk+wuZP1HJTzaSgRFWjA1gZLgVy9QwelTXk7srLH/C6UVAvfjlgw2Yhb6LSDt+buYqLGV6GVhjRSeRu6Dc2G1d9s+7w3CenSFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pLesYUSfdqKv4EHT6LQ4n1wgq+DP/XtwuHwR+ddguA=;
 b=QO25cJkP+s8MvkOgd12TxE40lgZok1idBiq1vFdYKPJRMD+Ynxqkkgyo/VUYvOrTH/l7sSmtpEjFleNJn8BxUNZD2JV8jOlvD42O1QYEsDQm87NqpMIwvikxY9c2+kDStwsQYLl3PvM+e7eXzAS925NOCF5k6u+N87zk2mzq1JkNlAHjOMQJgrkBTb1gWNfL1zB2jhd0EFHvB+RFLnvC2Nctxws7e7KhgF+6xyzARFeIKVXGA2nB/ZIUF632hnPI0q7uri+n59KMPiRY0BHVjpOLRhvg0TmdPnA3A9UuBByQeX7SksxGrOnkRIcuWeV9M5XH3XdQfx6Kvicr3tJZsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pLesYUSfdqKv4EHT6LQ4n1wgq+DP/XtwuHwR+ddguA=;
 b=U6qxkCPMjUcWq/3VwHYuz6GV7Fbq3UH+dJ637uVpRB3xlAbUWJtm7c5/bNBmi9KuuK6gE2ToGhwgUnayrldmz10xhh6sjB6GKJnnO5VlGpgupiR2rWNag8VoiYLTdcqxCFufXajHlM0SD/tXY0M6QFZIFUpI+wemZ8VGhtbJny4=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 10:54:37 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408%5]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 10:54:37 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable recovery on aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Enable recovery on aldebaran
Thread-Index: Adcf0tMtHRCksOs4SDq9sPGZEcAd+Q==
Date: Tue, 23 Mar 2021 10:54:37 +0000
Message-ID: <MN2PR12MB45497585979A4EB92A20FD4297649@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-23T10:54:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=d686db32-2b86-4e3b-a60b-f6e9c99b3abf;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb0c9e40-e8a1-45f2-1995-08d8edea0d1e
x-ms-traffictypediagnostic: MN2PR12MB4254:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42544BDB7F863F503AB3DA4997649@MN2PR12MB4254.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: roFYH0yypsZXkBZCsN+Do2SolfVmqnNCMSBl79Ui2GDsWXMiE9NauvzmdMCZ+GyI/qVyisUJn4Jxuh5ygsv4t87EaZLF91uSYe+M5cQ4Wz0AZX4S98QL/QQLegdUsK7qlZdcy+NmKsr7tvoso4afyUfzZPObVLqkR0TzjA/iFRGbLk7CcpSPckgIW7QaNtau1RATz8lZ2FQoOMxgoftfzQjg1K8D7RNtxUHGsX0+jYR6nErha2GXpLo8Ibmp9FKFAso/RLw/NE+rCvNfqDkofouNZQSa/VmTzLP3RwSNpEr8XeXf9bR3L3vGroo1iQkn0qKIjeOgoe3WUejkkD1B+IkrAWe+MtPrmWFZHrjZc5M1LQ/LpIzzH8bmF7pbDvjh56faXxGhFlUMDI1B2h2c0te64VpPxwZyo/bHk+Ht5YMd2cyoVAXS0dir72RPPQl86l45QVlGXSeBlPauJzyIRz3LfLtrBHoB3QfSuYyYEbG6XFFkBb2LBrFvsMAbPRttIYZsQkIk7ja3ZqcqqngNgL/CuEL9kaXv2XeGeISNIclu+9X8DcMUVCYIicYbrh2kkGGoFbnWDQ7h1Agl8q7XyHwoedtcYVRray0M7+hdhBjFwVXol+KW5eaLnywZC+zZwxEoECK0lYL0I+Vk/ZLuTy1lj4FndzN8usTwsxk48Cw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(66946007)(4744005)(6916009)(316002)(8676002)(54906003)(55016002)(38100700001)(33656002)(9686003)(186003)(7696005)(76116006)(4326008)(86362001)(8936002)(6506007)(66476007)(26005)(2906002)(66556008)(64756008)(66446008)(71200400001)(83380400001)(5660300002)(52536014)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZEvOmY7Q7YIET6HDFzbRPwQtoXoj9TBHPVA3n3tQM3JsmYLiQz6Uw5v1gE8L?=
 =?us-ascii?Q?UdGt+zkoUCLhC64h61lUhYIIu4UU7bg5/Julak1zrFvAZctM2IYdH4zOkTSL?=
 =?us-ascii?Q?hbaGnniMgBTI2e6U7EOBfw4S4QAGsnzgysxq9WhKrLZMUeKeGqeyW4zUOtbv?=
 =?us-ascii?Q?BQveGKx48Zx+sXnptNuFM39moCzvtvNgxl8NCOShMzGb/JlQbff9H65al7ex?=
 =?us-ascii?Q?/KBmhJaBzGnJZhv+OvDJje4i1NDaOfp3JgULQ8xXwd3MmsFZevI+KvGRlWZI?=
 =?us-ascii?Q?6ZEgV3v60CeA19egDa6R88hZe7U+9hXxS3Z8KplXbhwOUmPiX7uVbnprrdaJ?=
 =?us-ascii?Q?w1ba8cyvmaIb1FUL28QsY06Lshyt49LpFwROYEXk49ddV2iPFLVsJUz3kRl4?=
 =?us-ascii?Q?+nOJQlvyGHLQIVU2OurnZqBJK8p+cx8r1SFG0xQmA3gs0ehQwupYLSrYYYrh?=
 =?us-ascii?Q?/5A6MfJrtx228tnGH+/URFNJyw55UThfLICV5ynoPPlfkPF6XyJdhUdJbqv9?=
 =?us-ascii?Q?1yLLnjlVq4BFPhVuBYHixNQ43dRJdMWWGl0hUb2D83twfXy6j73JGUlLhSQW?=
 =?us-ascii?Q?T5BwxVzCFcpOthyJZLKUMomiDg0tWzidfopa2b94GmUzpwtN2ixUOI+biNTA?=
 =?us-ascii?Q?J38zFT15tEodQpf1pFDrnhFLelOPLpC8rv5/E/J+h4DiDI+hvXvbMGj8gWA6?=
 =?us-ascii?Q?ZMlI2QoC7ApecdGdAWoZeERMA7biAGLz92QGhmZgo7n6QGx3eEZ/bmjADGZu?=
 =?us-ascii?Q?35lG+PgQzg0VuzY9XYgvsVurxNUSEALW178JK28OXLc+1s8T7OXq1RgaANKW?=
 =?us-ascii?Q?rf1brgiWtuq5QiAR1gw/KuGFJk1iyb3Mbu01pG4a1XhZyrfJWMdA+QnRYn6O?=
 =?us-ascii?Q?u0UFdgDdd4Ds3LSlqPmwirLSUamJAg95WT4nAe7WKAxnZb9HlFDHWjRgDlUu?=
 =?us-ascii?Q?+xHYfBEidIkEArZyHm8DRnl6Lf2Y9WwEyf6C5f6WRWWP1lM8LW99YaEqDbc8?=
 =?us-ascii?Q?xRiXg8mUQXWet8/O30FJtpFzWW8dupLrB+zPhpSGE7QSwkRUokuWkx70gEva?=
 =?us-ascii?Q?fZEiwR6kk+v2J3Ly8176MfqGxKPVwTpvIU7UDd5f6jCQ/sPE6BJtcgACk57M?=
 =?us-ascii?Q?MaAc/hB26ZP8IJI9obVucoMilr+HsOSCY8xtFg99a9bBNYy3JJJb0B4HcmV8?=
 =?us-ascii?Q?Pzd23JyB1eAkPonqnd/zpaUTceyummEGmSBne/ARZcQSyZWUM6PCWlhjUgfI?=
 =?us-ascii?Q?UxjCIUDAOEt6zDBTHtvXuibxmCO31H5omYiHObYDpDfUIua/7fPhW+wLDNMy?=
 =?us-ascii?Q?BP/wMUmBMVtpDxiMUC+Q3yAZ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0c9e40-e8a1-45f2-1995-08d8edea0d1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 10:54:37.0335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d0ydJyDamy1/+SXuoxFKDVShXLKos3m4iBmC2W4twSOPJHe92K5j2r5AZRBBIY6e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0387524058=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0387524058==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB45497585979A4EB92A20FD4297649MN2PR12MB4549namp_"

--_000_MN2PR12MB45497585979A4EB92A20FD4297649MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Add aldebaran to devices which support recovery

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index b1b83d282090..324b9e6b2965 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4192,6 +4192,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_d=
evice *adev)
                               case CHIP_NAVY_FLOUNDER:
                               case CHIP_DIMGREY_CAVEFISH:
                               case CHIP_VANGOGH:
+                             case CHIP_ALDEBARAN:
                                               break;
                               default:
                                               goto disabled;
--
2.17.1


--_000_MN2PR12MB45497585979A4EB92A20FD4297649MN2PR12MB4549namp_
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
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Add aldebaran to devices which support recovery<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +<o:p=
></o:p></p>
<p class=3D"MsoNormal">1 file changed, 1 insertion(+)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_devic=
e.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p></o:p></p>
<p class=3D"MsoNormal">index b1b83d282090..324b9e6b2965 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p=
></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p=
></o:p></p>
<p class=3D"MsoNormal">@@ -4192,6 +4192,7 @@ bool amdgpu_device_should_reco=
ver_gpu(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVY_FLOUND=
ER:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_DIMGREY_CAV=
EFISH:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ALDEBARAN:<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<o:p></o:p></=
p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
goto disabled;<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB45497585979A4EB92A20FD4297649MN2PR12MB4549namp_--

--===============0387524058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0387524058==--
