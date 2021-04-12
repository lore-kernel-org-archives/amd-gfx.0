Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3C2C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 06:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603A461209
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 06:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603A461209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBCBF89F63;
	Mon, 12 Apr 2021 06:06:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2FE789F63
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 06:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POL3hiSG6UvQLpj1b2HgFRbKi463f+dRuXLxusaCR0PVBQCWgG9Qxcc5DPuz+T5Jgh80frmKC7McV2uGXi1vOOTiFjLmFS9DDXRlXF7d2XqO6OxXhXH1ZvqlTcSCSu7Q2RacxcnFk1fOVLt86LXcRdMeFyXb9+Wc6hwT2yLqOJvjUVNawSziD8Jb417HP5WAnCs5WtLjrxKyZ6EEsTe+DjJonFeyYVtA/orfDz2Dw+OcO4n7NThBkHBUZw5/Dmvhn/H3Xqm0IU6b+m1WorttooTjic1bn2Tff7PLAdbmHiQ+tx2hrBaSpzuEcCR0ufw3QBu8K12s5etqLALvrjnueA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CblPVmK7i24yBD27/jHUO7VCMoKnB5fALcOzRMRXTzs=;
 b=QRn8v7Ux3yb//eU6UIJa1X3FqM7Hg1Ec8E1Fc4atAOs/1WNAi7jy1WqbUdEEA3TVBXHT3HAc0n6M2kSD35pYmcvjh7uFzuzVqmBxde6kd9lxiFDkHJQuAgH0EDaSepwUTvpL2D9aA0PJoAZITk/ivWhMPm8jAK29aVrZIcmgV9hcv8slcmJtobdoHnUDvBW3fYKFbXXpeAIiIsFEDwSTvj/n/+NhjIMpQI7e8k7lfhfNxVjYn5OU91Mxi9ONik7BpNJkWbf7XwqQOsgplh+xek7KioqqE76xlxPCV5A3JEEcl5cn8hNnTHkUaPlD+uIineWzER98uNtyaNXZkNaPhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CblPVmK7i24yBD27/jHUO7VCMoKnB5fALcOzRMRXTzs=;
 b=JQX8boKvuUwoGPueqE2SXnerDSk66Dg32CL15ZikBseH0AIPcFodeQ+bxlAcyKk+GxcmJISiYLIE5d1k9yOc7nXrVP76tO1badmMf6WhhMQMCpCvAPsFstx/r7B23EHxUbmcC5p9PiJarfoldyNqLqJev5N8lX5AN6yPXtFI6bs=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Mon, 12 Apr
 2021 06:06:08 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::b83b:b880:25cc:c1b9]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::b83b:b880:25cc:c1b9%9]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 06:06:07 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Use VBIOS PPTable for aldebaran
Thread-Topic: [PATCH] drm/amd/pm: Use VBIOS PPTable for aldebaran
Thread-Index: AdcvYcvnGouKBqz9SOC8GbANB1m7Rg==
Date: Mon, 12 Apr 2021 06:06:07 +0000
Message-ID: <MN2PR12MB4549536629A4C68E418BA83097709@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-12T06:06:06Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=80f1b83c-a987-4700-8978-1b715d52c242;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.211.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72a9536f-e23b-4c89-825d-08d8fd79104a
x-ms-traffictypediagnostic: MN2PR12MB4343:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4343C1E97A1E44004BF850BE97709@MN2PR12MB4343.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ql2mPfUQu0QHgRpTPmfKm/hqIjJmpceXuzUUL8uyeC3+1arv3VDb5z60C4rAuQftV610m3RC//UylWa4G8DnI0iN9o6ZO7k7OPWhBdh5Pj4V/KZukn/ViGdRKtl5V+kEQiYNifOar4HkfMZvGFThRUoXVPm05sEJ+noePYo5dsgYaBDGnp5jRuSEeV9+6YCDz8+frb9flZfiHyZ7taSvih2omYWWZwswSmO2tVkjkeJbxHUpIQcfjGIfobFDDd15DPkymuc5P2zUr8izL4bnVtHeg+WzleyyllxgzyDn08k7GGjWjt3aqMd/79wHCgnQ2K9l1Ftyc+dc6nQ0v+P48PlA5+BWQFkL8TaEmZD92tTrzHw+lmayTAnPkY1crHQzNIiNHcJwqdLmFGR3ChrpBy+C2cSMoXzURWAE6zOQBJuWh/7eT96GX79fEdUf1SHi+2oOIRb1kkgwlHKdRYeQNzfHxxwQlAV+pLXp97kJOj8whxmh/9TT6OYknkPEqSlWtPr7QYgIXattDYVsJ0P4VHEfQV2IFH+Rn1OzD/YkIAUxwgABO9SfU0ngPaOSvavt1W39TvvotcEHhdGVnvm8IquwnelATF74cDfKUH8aJjE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(54906003)(5660300002)(83380400001)(33656002)(8676002)(76116006)(7696005)(55016002)(8936002)(4326008)(6506007)(6916009)(26005)(9686003)(66556008)(38100700002)(52536014)(64756008)(55236004)(66446008)(186003)(478600001)(2906002)(316002)(66946007)(71200400001)(66476007)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ImOlLCWJYuyL7W+qyQ5t/ZefVHQeR8vaxkcqpdnkr3gzp77MrlFoaFKnCWff?=
 =?us-ascii?Q?B3d+Yamq562TY5MkOvmZTlLrnXXDQMBqwKCtVRo9TkQIgCSvdTukiD9bv3Ea?=
 =?us-ascii?Q?aTrp1blY23zJRV0YWVUMEDQ5sVNmGbiGttNdY65Tu7OU/kiPAixVNM7nADeS?=
 =?us-ascii?Q?kKwMLs2GTxtrCa1kyO0zA8JwmwdozRUQrskJ7j9hgCcnWkS1AlvAEu62d6iJ?=
 =?us-ascii?Q?cyxLpz+trBVpGhn1RlPZ1vA4ynVdWib2HljUtKnsyXjig3CShKcA3SYQVOUw?=
 =?us-ascii?Q?oLapZb+bz/0OU3+Kp1sJpizjaXeKhJY0DIcWVgypkOzpXS81sv1cgusvgGeJ?=
 =?us-ascii?Q?lJYJv8Y4HmtBEZl1ixDSmakGIJJBRE1YtN7NcJ4ZA5NG3Za6ymGu1n2F38rE?=
 =?us-ascii?Q?uyH/1BDyMW4seOmzW8g5qKKdMyMg0/YUTQ8iGeTKsWJH+27vVEEkxEZvrj8X?=
 =?us-ascii?Q?KxagScRzGN19FMaRvmEjAVNOrTecUZE8FjTL/jGtzQhMTgmZSbHa+06PGYSS?=
 =?us-ascii?Q?IoPtrh6pzch8RYwbXHsuGH+rgjj5Oo7XX56BMxkyW5+VcbJYFVouwXhodBzX?=
 =?us-ascii?Q?+FKSW7y724Ut+tSWy/ttaC43douI1dT5CMk0/Vt0mDuojnDjqG6T7PTQuBxH?=
 =?us-ascii?Q?UrSNtBdc55d9e0/vCQxU33BrAJGu45zgb/RFqEMqyVAcQtS01cEoZIU1GaLh?=
 =?us-ascii?Q?WTtgk7qxshKeNM7QaxJrpn4LZLDJ35siCIe3AziFXbCKZmPaR9YyfSUkUHKD?=
 =?us-ascii?Q?eJJAtgIOjJBW+3mduaXbeGAErFZer04QY62XWKBqgaPlO0vlmb1EXlulabkJ?=
 =?us-ascii?Q?Ty4W/f+i+qJJP0Nkil2hy+GKjuiB8Dyq2h8m9W2dNrOD6lUaG/rx2K3BJ1vp?=
 =?us-ascii?Q?1Oe1jIQkB1sXd0nSXlNHzn1T0g8xdmWq18OIdgSO5TJeZ1c8UI5yh6cYJwgj?=
 =?us-ascii?Q?LJRdC/iiiGwuGFb+/jHyKEkNwrfrdJjJJWXhyhFwJXvgRlLz2TTzjCRXekRd?=
 =?us-ascii?Q?8Gj4/18GoNBCgJAIhKXhOjhtxe4Mv2pnN2kNRBlq/Eh7tGw2NjymuXMF5+hq?=
 =?us-ascii?Q?wKGupZtBbtCD0qCsEvptY78lUMmv6+i+7eIDbcTRwaKPEgLeSdsRuXwFKUXx?=
 =?us-ascii?Q?bVXH6zO41wcp/zSYPZWN0T+5cfS5sLlfd6KhZIp3YJmPGAc9LeCtuP7h0dWD?=
 =?us-ascii?Q?0uaPR15eI7gF0qhrFZpa9IsJ9f+kYV+nvLul+47ar45V/c9rS+RuezHOrKhj?=
 =?us-ascii?Q?QlsU0n6ivkwu4fRRh4IjUEzuTqZDl4y8zhtngdjgsZocnldnJ9wt2s0BraEi?=
 =?us-ascii?Q?rh6OouUULEvywjyzZb8+VQTv?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a9536f-e23b-4c89-825d-08d8fd79104a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 06:06:07.7899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nO3Zi0LFm5qqReS+BU7CH/P86zdlaLklh55wx2RwBeukggf4f6YqpuRCQrctLht3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============2014772157=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2014772157==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4549536629A4C68E418BA83097709MN2PR12MB4549namp_"

--_000_MN2PR12MB4549536629A4C68E418BA83097709MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Keep the logic to force-use VBIOS PPTable in aldebaran rather
than in generic SMU13.

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 3 +++
drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     | 2 --
2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index abe80226a0ee..af6e0ce9b6a7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -407,6 +407,9 @@ static int aldebaran_setup_pptable(struct smu_context *=
smu)
{
               int ret =3D 0;
+             /* VBIOS pptable is the first choice */
+             smu->smu_table.boot_values.pp_table_id =3D 0;
+
               ret =3D smu_v13_0_setup_pptable(smu);
               if (ret)
                               return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 30c9ac635105..0864083e7435 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -276,8 +276,6 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
               void *table;
               uint16_t version_major, version_minor;
-              /* temporarily hardcode to use vbios pptable */
-              smu->smu_table.boot_values.pp_table_id =3D 0;
                if (amdgpu_smu_pptable_id >=3D 0) {
                               smu->smu_table.boot_values.pp_table_id =3D a=
mdgpu_smu_pptable_id;
--
2.17.1

--_000_MN2PR12MB4549536629A4C68E418BA83097709MN2PR12MB4549namp_
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
<p class=3D"MsoNormal">Keep the logic to force-use VBIOS PPTable in aldebar=
an rather<o:p></o:p></p>
<p class=3D"MsoNormal">than in generic SMU13.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |=
 3 +++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;=
&nbsp;&nbsp;&nbsp; | 2 --<o:p></o:p></p>
<p class=3D"MsoNormal">2 files changed, 3 insertions(+), 2 deletions(-)<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/alde=
baran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<o:p></o:p>=
</p>
<p class=3D"MsoNormal">index abe80226a0ee..af6e0ce9b6a7 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -407,6 +407,9 @@ static int aldebaran_setup_pptab=
le(struct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* VBIOS pptable is the first choice */<o:p></o:p></p=
>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_table.boot_values.pp_table_id =3D 0;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_setup_pptable(smu);<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p=
></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_=
v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 30c9ac635105..0864083e7435 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c=
<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c=
<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -276,8 +276,6 @@ int smu_v13_0_setup_pptable(stru=
ct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *table;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t version_major, version_minor;<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; /* temporarily hardcode to use vbios pptable */=
<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_table.boot_values.pp_table_id =3D 0=
;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_smu_pptable_id &gt;=3D 0)=
 {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_table.boo=
t_values.pp_table_id =3D amdgpu_smu_pptable_id;<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4549536629A4C68E418BA83097709MN2PR12MB4549namp_--

--===============2014772157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2014772157==--
