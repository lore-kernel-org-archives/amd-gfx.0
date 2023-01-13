Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743ECC54EBE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 02:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 041F210E1C4;
	Fri, 13 Jan 2023 02:07:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8383A10E1C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 02:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3BNpxx6LVAmrzu7W2V/tXuRQ8e5etyKoJ4gdxhNwMuAhQNCmawipwx+lUwMLPLpu7sNhDSLObVQNwjUYUqDsuuP4sBP2lfYNd/GqOs69gIxsejAaoEhj9DXItiWGsxhROToFPGpMMGSvJw859aJZCW6EnE+Luf4eu7geIU61FK/G5nCF5MBLi0zqcP5LPkfBuNwY5THDssHKeXmPmyLt92pus8sPA8qC8j9H2EnVONHYjN/JlFcD0U9v7v3hYcVOPFpg47qGeVQqMJk0FXAYPfAb1vzY5YR+c+y1HtXrURG8ElpNaDBT1tNj4eJj+odBOecIkgLNAAnNGxY09qe2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKiYFZxbCmXGsXMaUbLXEMvnhCAE470LfkEph8itpa0=;
 b=XjkWZE4wH+dfpmeTnI8P0z2qO9YjV9g6fgfWxuezGzDT0ObcOWyUv2c5O0boRLe6KIwyKeUwyC/GAQ6Gg52xU2tyWT7yW0H9Y3vQ8ImK3u1dDa1SyW3J9OvXDpcMrioFwrmhHBetY/hcukXB4WadnL9CTbpExn6aIAR0k7zc9HTEWB1kpEtHFhId7DJNLNwB24J1I1UoL3079ZXPn31jQl8zeAkepscER9uaaLzgzDJIauHAL5/jlFzPHRvx75pQNeKenbttgcc4NyobcyV26VX9L23rwRWRak+JigCY2pZnDlmSH2G7wkITgdMcoEA8BWNIiBkOphumWatJWoBaug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKiYFZxbCmXGsXMaUbLXEMvnhCAE470LfkEph8itpa0=;
 b=vpVB8UxXoi00SccbX1iL/xCzBBmDYuSvQzuFDVxiYCYzwGKQhtgZyd+1+y2bWup1fcbyZuDJiTnVochpXHijDOSjQqK+gPzEyzcrw3W/z0CkswW72XSS8x9wfWAnz//1ABIxwqe6Vt/xlZ3PIGA0kR9WFQ29YLbVfdWw5YoMfGk=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 02:07:04 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8662:7aff:5c10:42d7]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8662:7aff:5c10:42d7%4]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 02:07:04 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Renoir/Cezanne GPU power reporting issue 
Thread-Topic: [PATCH] drm/amdgpu: Renoir/Cezanne GPU power reporting issue 
Thread-Index: Adkm84Bniu300x3pRRiPzXiF0/oFCA==
Date: Fri, 13 Jan 2023 02:07:03 +0000
Message-ID: <DM4PR12MB515254D7E44C0DA90F3A907FE3C29@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-13T02:04:29Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e2928a47-3d15-413e-ac41-6caafb88ba96;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-13T02:07:02Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 4206fe6d-7ea6-4d89-82d3-46c1bda11ed7
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS0PR12MB8503:EE_
x-ms-office365-filtering-correlation-id: 2727b203-9e84-420e-0e15-08daf50add6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JwJGpDuqAA/lbWEsOjY0PTIZL0148+2yQcjQ4reYEeZJBdZ8ILWnGx7VQKuvqnvPF8L9dqFZiRcJMiaCSoAcu+FE9hPnFfl4S1UC/ZRgONMBjPFHTE728cEfCSH8HnKH5u91IvTjsf5py+KOcijZpGu8/BNTSRybTYXXDTRIGrEpPotpqfXn6qbM5R4rr+wkL8qle2OquvNPw/WR3DHUkUu1xM2C5FM1AYf2Azhi/hLPExBfUt6bel9qOpWYYdA8hfKvlqHVMcJA2wJfRwxBdKmaIDGwliTUkl/mtplW8LMRMNDxKzcyes0qrRTlfqPDNU6fG+KrTg9Eb7Cr8Lb5bqWC2f307Z0TpH0MZ+g2EccJTdpML6lE4S9b1PSTxM33LOK5MnV0P2Xch/6saigi0H8PK6X/PZpREmlrFJhj0embWQ7et+5RAR0W71oeWxd4OWNFQgCfWK0qI+Wi3xkagu+yHnmRJgcGBULAtOTVt/cpSBacKDqa54ZbrpFN3owQzziNO/f8jlG8ObRFMbVwqDlaxv7uLWdOUV+nT3x1hUhK5N8OYHhOorxm4V+UyJYa6/rdqF1HuiVZHI7x6OQ69tG7eOyrpOI5kFgDgkpEdxBMan5wy6mlmtKMOD5EGHG8UPSjEh+8K40w7IT1gVrOWg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(6506007)(38100700002)(122000001)(166002)(2906002)(966005)(478600001)(33656002)(4743002)(86362001)(26005)(5660300002)(186003)(316002)(7696005)(71200400001)(9686003)(8936002)(38070700005)(52536014)(6862004)(55016003)(8676002)(41300700001)(64756008)(76116006)(66946007)(6636002)(66556008)(66446008)(66476007)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YjSAa5URhQJamx2z/KIcexKyBP4ZWIo0ja4LFGTbBgE8XZI2AvVUMHLZiJYF?=
 =?us-ascii?Q?UjE5cAQsxjrwxShib8G7ECP/PePBnw42hkDW5kLrWCMmAF7Hl5Y0ErHspKZI?=
 =?us-ascii?Q?HSho7eo0tp14tRZ4w8je8GuYELKQEbc4G5h0wSkTR1osE9sMQm6y4g6Ruj5n?=
 =?us-ascii?Q?FoAUTJ7WeeO3OvYw+O+yhYkQ3b6uRWYWmYS6QMx88F7ZayEC2k/1h0tCKOso?=
 =?us-ascii?Q?q2qWEw+Jbvf9n4g4rgZeJkl9Pf3LrhJh/3mooYGpoONb5sr2Pbbb88r605aE?=
 =?us-ascii?Q?tMh/qd/Cn6I5YcG13VnlVXKFVh+sb8wcC5YTBI5/2KgpXQeg0HfO6FbxO7dt?=
 =?us-ascii?Q?pNRaO3bb8LOrZSl1NFD0m8DsHD7RPuSK1ZraVzeu0SgFHcHTb28nuzWxDSMR?=
 =?us-ascii?Q?KP7hcFoe2Z0mat79EgO2Z7xkw25Lmr+65f5nzs7Bn2q7H5G6NMOyHkcfjqjg?=
 =?us-ascii?Q?OxFBvHZDKegkaXlRVLneqczufPrd2PYGMV5SJjrhSc7gkwZjrsT9CYknI6n4?=
 =?us-ascii?Q?AySo0PK6HzyL9/EbeLssdwZ851msJwLlic8IS713LER8px4whGagW85/Z4DR?=
 =?us-ascii?Q?jaGnv6g4/Naz8Tj7X4MZrKAInNPQkhZIwFjtoAtGYPZUyRdjlA9h605qwCtC?=
 =?us-ascii?Q?zz1LiCDXbVEQ6Wqz3tMVQddtBd5sBn04hO0brUOthkUD35ou7fXlshD1fMVx?=
 =?us-ascii?Q?znFMqw7ZDRT6EpW9tBMRjotPuq+8X00yj7i7c/SoqT47u3K0xM/fLha7oHrf?=
 =?us-ascii?Q?4N8IZO3tf5nwJIvAw5gSuj5ExOw/OnbECx0rrLKygWUsLLiwvui2ZsrAlS8X?=
 =?us-ascii?Q?Nkc/kg8ShuEjRGmw0cZmVb5RlqELftkAV/EYjd4M3gB39Ep2Nkg8PgQLMZOj?=
 =?us-ascii?Q?pGd8sDP5yuWavsWhLuBpJ6eti1OHkOLQ5pCqnkJ3tBvSO1L2LYv90/Z/qSEJ?=
 =?us-ascii?Q?rGbAiJrz7HipVONjJOud7HgEguM9DJdQqnI5kGhgi21sg4ngQ4Thr/OzHfh1?=
 =?us-ascii?Q?qoiKZZ6mPT5pzn1C7AsaegVu911hcGL9WvqQ/bqFSIW6vmNdhHyzUyJUJj8D?=
 =?us-ascii?Q?pI2hPiOnh80432h7bLCfpBAhzMt9oqr1JPJAIlNk10GjTqLmrGTzVeYvBnHq?=
 =?us-ascii?Q?LI9s10I4xdMu+w3OMNRwD0jOcmzxi90SuzSszh5AyJTfIuAO6A7Glzjv/B4d?=
 =?us-ascii?Q?dRv4FP6MJdexAwqoHE/7sMK2jgf9MBewLr7ABO4McJwnVNxqA78pgLsaKaA6?=
 =?us-ascii?Q?G6OTy+ErFhFYjgv3tczAMj3EuS+h5nEvyXn4TAq14rtVnG/amGPG2KaSWgMn?=
 =?us-ascii?Q?0VMx5exaT1u5OWOuJaQw1e/dnPTv6PftQI+IlV+KIHvgdOfjnfAiybGtHlJ2?=
 =?us-ascii?Q?d/Lj4Lt515hjuZiVf0Kk36gAgQk9bZVyfLzmRO6cVnPi4T5gVv09F5WkvNhw?=
 =?us-ascii?Q?mwD+TAfY/Ijj33iqnp/OoFgqaRjc4TJQVL4MLTmiuDkCuSo1Gn5MHJTH3DpD?=
 =?us-ascii?Q?lAav929Nd4pwKQb7wTbi2Z8ll3EzN0cVnQs703zZsH30fDbHQNQD80pgNYfU?=
 =?us-ascii?Q?YVIzZnTP0nHAuGIh8GJDvMnt3B+9Vt9rZ2aikxEX?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB515254D7E44C0DA90F3A907FE3C29DM4PR12MB5152namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2727b203-9e84-420e-0e15-08daf50add6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 02:07:03.9136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0AOG5b3hFRK7H+6ZB2zYiZ+4m8V2aT4vp6e39lpZAmCYIEl1WQHUEV3YXyo92+ZNdbg/0SA7a5XKq/bgxnsVQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB515254D7E44C0DA90F3A907FE3C29DM4PR12MB5152namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


    drm/amdgpu: Correct the power calcultion for Renior/Cezanne.
    From smu firmware,the value of power is transferred  in units of watts.
    Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2321
    Fixes: 137aac26a2ed ("drm/amdgpu/smu12: fix power reporting on renoir")

    Acked-by: Alex Deucher alexander.deucher@amd.com<mailto:alexander.deuch=
er@amd.com>
    Signed-off-by: Jesse Zhang Jesse.Zhang@amd.com<mailto:Jesse.Zhang@amd.c=
om>

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 85e22210963f..96a49a3b3ad9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1171,6 +1171,7 @@ static int renoir_get_smu_metrics_data(struct smu_con=
text *smu,
        int ret =3D 0;
        uint32_t apu_percent =3D 0;
        uint32_t dgpu_percent =3D 0;
+       struct amdgpu_device *adev =3D smu->adev;


        ret =3D smu_cmn_get_metrics_table(smu,
@@ -1196,7 +1197,11 @@ static int renoir_get_smu_metrics_data(struct smu_co=
ntext *smu,
                *value =3D metrics->AverageUvdActivity / 100;
                break;
        case METRICS_AVERAGE_SOCKETPOWER:
-               *value =3D (metrics->CurrentSocketPower << 8) / 1000;
+               if (((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, =
0, 1)) && (adev->pm.fw_version >=3D 0x40000f))
+                       || ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSI=
ON(12, 0, 0)) && (adev->pm.fw_version >=3D 0x373200)))
+                       *value =3D metrics->CurrentSocketPower << 8;
+               else
+                       *value =3D (metrics->CurrentSocketPower << 8) / 100=
0;
                break;
        case METRICS_TEMPERATURE_EDGE:
                *value =3D (metrics->GfxTemperature / 100) *

--_000_DM4PR12MB515254D7E44C0DA90F3A907FE3C29DM4PR12MB5152namp_
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
	{margin:0cm;
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
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
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
<p class=3D"msipheaderdf3d92d6" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly - General]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; drm/amdgpu: Correct the power cal=
cultion for Renior/Cezanne.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; From smu firmware,the value of po=
wer is transferred&nbsp; in units of watts.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Bug: <a href=3D"https://gitlab.fr=
eedesktop.org/drm/amd/-/issues/2321">
https://gitlab.freedesktop.org/drm/amd/-/issues/2321</a><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Fixes: 137aac26a2ed (&quot;drm/am=
dgpu/smu12: fix power reporting on renoir&quot;)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Acked-by: Alex Deucher <a href=3D=
"mailto:alexander.deucher@amd.com">
alexander.deucher@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Signed-off-by: Jesse Zhang <a hre=
f=3D"mailto:Jesse.Zhang@amd.com">
Jesse.Zhang@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/reno=
ir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 85e22210963f..96a49a3b3ad9 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.=
c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.=
c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1171,6 +1171,7 @@ static int renoir_get_smu_metr=
ics_data(struct smu_context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =
=3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t =
apu_percent =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t =
dgpu_percent =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
device *adev =3D smu-&gt;adev;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D s=
mu_cmn_get_metrics_table(smu,<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1196,7 +1197,11 @@ static int renoir_get_smu_met=
rics_data(struct smu_context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D metrics-&gt;AverageUvdAct=
ivity / 100;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METR=
ICS_AVERAGE_SOCKETPOWER:<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D (metrics-&gt;CurrentSocketPowe=
r &lt;&lt; 8) / 1000;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((adev-&gt;ip_versions[MP1_HWIP][0] =
=3D=3D IP_VERSION(12, 0, 1)) &amp;&amp; (adev-&gt;pm.fw_version &gt;=3D 0x4=
0000f))<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; || ((adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 0)) =
&amp;&amp; (adev-&gt;pm.fw_version &gt;=3D 0x373200)))<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; *value =3D metrics-&gt;CurrentSocketPower &lt;&lt; 8;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; *value =3D (metrics-&gt;CurrentSocketPower &lt;&lt; 8) / 1000;<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METR=
ICS_TEMPERATURE_EDGE:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D (metrics-&gt;GfxTemperatu=
re / 100) *<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM4PR12MB515254D7E44C0DA90F3A907FE3C29DM4PR12MB5152namp_--
