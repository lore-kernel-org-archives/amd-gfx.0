Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6A1C54EBE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 02:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EF4B10E971;
	Fri, 13 Jan 2023 02:11:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E34C10E971
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 02:11:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0BfaYGR0Qc+WQKvFQgAcjpSsWFkDlbQ4PDqsuJAN7+IN2hWbp3rhj4+hl1cocGO6vDCzxlkYX/ZCv9NDLMSfwpd5ogTfjhZkwcLA7SFkuFDMBU9FoXWtsWwA+Stc5QYK06ywNQUOz1Urp885k8i2wf4V7ovYjVaRrIBccZk9UaGsfBlkr4YiNAR+45IPwa1p4c3OZxahl+4EyZ2PQlAgfpC6sGHI0dSvPTgvnF7AtBGFcg7UMwKzOVkf85tQnFK/cEp59JQ+r+Ck7kfQlzHYvobu88fOwn2n2seAYhBMLOQt4isLxFS3RFc1L3D0u7jl1BvEPcLgAV7MXTE9CA6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9QZE+mS/CKhdy2byLI2drxoxS3wPr1xb2/DcVjzn9o=;
 b=EBfV2hDmMFRI+/QslLZ/baHe3cot3qANK5cFvUzg3dIGAx73opqXL9Ezn5SZdzMxi02cCsllm/dvhgN3Jd5xVtB0ww+R6aOrv2UkcCO2FDhudTx9vCOBz34/WTkbYLoOQhxPinLA7nSaJyzTCOZBHoVBzUydGiQnI7vMVX5MHHn8krSRst61dj2jTgTlIVNfqHdUEMzSD6u22nyklnz0xcdOScvOLkQxIqVPOhN91b9QB/114uS6GO7swI+0gJe/fIgy+W+l/B/1QYgDgFyGv40VTG0yVNRjUK5MpmsXIC9kQsC9T80qRkAr6IiLiKEOG0CLlSLLV+veUZoQkm8Waw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9QZE+mS/CKhdy2byLI2drxoxS3wPr1xb2/DcVjzn9o=;
 b=BEpI92d/D3NVzeIjstXdUADpi3fuAFEcVH2oJhwNWAl5BBJ5txxMGy81/HacOp/fwX07XX7Fsbo+bmfkIACgyy7wKCMQmXwHJqEicRQJKpLopKcWMGbfHYp0g7tQbflpXnbFU8f0tw0mDfKTeCYX7KTnUe3cKaUAw3LNGeqeDIM=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 02:11:22 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::956e:e4cf:6a8d:3f13]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::956e:e4cf:6a8d:3f13%6]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 02:11:22 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Renoir/Cezanne GPU power reporting issue 
Thread-Topic: [PATCH] drm/amdgpu: Renoir/Cezanne GPU power reporting issue 
Thread-Index: Adkm84Bniu300x3pRRiPzXiF0/oFCAAAMbjA
Date: Fri, 13 Jan 2023 02:11:22 +0000
Message-ID: <BL1PR12MB52373015FC820A8B41AB45C9F0C29@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <DM4PR12MB515254D7E44C0DA90F3A907FE3C29@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB515254D7E44C0DA90F3A907FE3C29@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
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
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5237:EE_|DS0PR12MB7748:EE_
x-ms-office365-filtering-correlation-id: 6efc5998-da1a-45c3-7a07-08daf50b7779
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rLA0UO+BY0sPtOzMWU0B+sAUr76+mPKEGLytz1ZgycFA7BHWdtNcNkG2TkA26UYtuG1cMS5Ar+mkh887WWypGVvcG1c/z9VNKtLKJpJPnj22FQWv9ow/hP3owfOp2wbFnN40aI0Pr+TC6FjGz7FKbxUgsJgI9A8oy29Y6+V4bq+WKDIRKqDgz9IzLTaw1vrYeNdiijYcewkw1haKQc6e/28957bqGJSwovZetFhhbcsjs9HV8oNUZPfjatLjl3Eu0n6/TQCMNVLsHKETz7KhmaALVPjuWHOxuQJ3VqnTpLCYS1LsB01PeDiTIaz+OJb4TtKRDTpJ0vPoKm9YVECLMKDO2+AeRpMSAC4DDxBuuSkXiAOLA99UgrIKRE1PlTyVp9isfY8QC2pQeZk69VYCzIN9jJ9uz4lJMppZsWyNzjKo92KH/U1V0kaZniJcwJslhUXF8rvfVYBjLxSmGc3ti8bVpb1MSlwFZ1tGcNtr1Yv55sCVzvH7ErlIAe7Gc29o9BjcTM5sXxtTNpfMgqKgS3onKsGWq4frGItjIavpOS9XM0vzWRR8TrmacWEU1zCI5gyiZWcGUaS31SczRJUhy5kKJDSrUHBoXLenXllUvp/xwSoBesGtQSqikE030NU1FbGLDXlWWntyY0scacKiHw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(6506007)(38100700002)(122000001)(53546011)(166002)(2906002)(966005)(478600001)(33656002)(4743002)(86362001)(26005)(5660300002)(186003)(316002)(7696005)(71200400001)(9686003)(8936002)(38070700005)(52536014)(55016003)(8676002)(41300700001)(64756008)(110136005)(76116006)(66946007)(6636002)(66556008)(66446008)(66476007)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LmbpZIOzWXbzSb2p+nTb+sULtoRSjKgKqzvS+T+CDIQkindAHb/obx6GW11Q?=
 =?us-ascii?Q?8gczauF6xrV0AHvFtTWi5KJObeGG99DepTK5TIH2RvTR31G6Y66C5JK7ldzk?=
 =?us-ascii?Q?ClRyIW2fbFuxvqgC3Du1c1VpKeHvWDYErrUX2ZtujUT9qjPJuUt+6qrGYXAu?=
 =?us-ascii?Q?N9cR34oKLAsvmG/pMk50WtEVlLtBDEjOSFrxRRF1/+mz/J1ctVVRmiAt1n2L?=
 =?us-ascii?Q?tJ9xsIpAac6pLWenUTKdeRlJW5jrNzfHmv22GYmKymenCh3BYUdapvHDGluq?=
 =?us-ascii?Q?2Ox97o/xEAstYBkJlV8C4jE/nfYU0WG9D0i6xuGU0h2e2s59A1dSI8CAQcGQ?=
 =?us-ascii?Q?vL4Xwb+Dwvv5jOHjtA+wkiPvi+YYiGCl/KM1mI6pupS+x9tFmEXtQsMQ3Fya?=
 =?us-ascii?Q?HvRYnQjiY8Xwxt6GOpaRotIQoBMN3s3Eio+uqL1zXjXwHvYx6x5OjAtmJQJc?=
 =?us-ascii?Q?KW6CKAzsa8tn0v+Ey0OnvPX2Q0TFHeRVvn7vXZMdrvB4pXZ/ZzM60r6iFonL?=
 =?us-ascii?Q?Hcnzw6Qwjda2m7inECb8KWYNFcQgxSj+4MS7zaGkPfmqM0K6SWSqFc1EaSo+?=
 =?us-ascii?Q?FUI6seR+1eseGgWtiahT6FmvcmK4n8i0n1UGl6TvOA7AzFJhbKOGsndx+zch?=
 =?us-ascii?Q?gHjxCLqst8Rl8DNrlf4Jvrk6NGQL5Ae41OBOeV/92piNVf4FmZO0fV11D89W?=
 =?us-ascii?Q?CPh0Z0Eq6cB6P+ZFcN4yYoTrOQiQAdeZuXQxZzX4NrMuTT/cbz3h7pRr72H5?=
 =?us-ascii?Q?FjhzLAMCfbS3L8jq7ZZipRujSO5Uxdk5TylCUl5isNg0plLYU0B1YngV2Gxl?=
 =?us-ascii?Q?pDfclmm5RdR1+oJfWwYb8bc0oUTpMcRkAA2wJqQ0tjkoF0PZXscmSEtn7H4Z?=
 =?us-ascii?Q?fDd//ufNcym+VCG8D/+7g69a1dodIJfFC3AfE3YQIsT7N2EjE7r3KyPL7wxz?=
 =?us-ascii?Q?QwIC9aJOAb8SoMWIIuOy+wkSfmB4WKeSu9Zl826Vsn4+jXhdAMDjLYDgMiLJ?=
 =?us-ascii?Q?oIZ866p3+Eu049+F3KpaTTWDIhD2rHCsWT3oQ07azWmNUdUsXC6tvCxoHAGt?=
 =?us-ascii?Q?GD0MSAzWVC7N/4WoqPSVzKCAQGNoLap5xC8eWz/QVx+hUrr4RJDsa0KFKXQ1?=
 =?us-ascii?Q?f5F2u4AKrI8swPfu4uLv4V+gq8yFHZDdk1kvaBEZm+8iiVcgnhX99EoTX3jL?=
 =?us-ascii?Q?SKGml6XvXAa/xxN+H5G0k9Ym/5TCaXAKeoSB+X8vK19oPspkS8s43YPNE6B0?=
 =?us-ascii?Q?Pip/JYmug5Scwz5S7qvz+hjMyx8DKMQY+bEmzurRitI2lv+A4CGPd3BF2T7l?=
 =?us-ascii?Q?dl8LWZRv66ITHj5NqT0fDis26MtjYQck4M3tfxHGB0893qS9jcPvBbkvYiBD?=
 =?us-ascii?Q?yTjLdFdbGezWLDIVcrYj3EhwuKPt9Qk/ltcNPSPrJthK3edTbfvle0I2wV8O?=
 =?us-ascii?Q?Rh/E6Vv6wXkI+vLntwLWOu1p9/ocgw1/XZGMHEwcbprVzECsM2L07iryJ24z?=
 =?us-ascii?Q?bHzsj/Th6IIJaBfNqEdsf/ZYvd6C5WWghmAUAeUJsR9nw+eyJzfep5z6djjd?=
 =?us-ascii?Q?yyQ9QC7kck1spbWRc14=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB52373015FC820A8B41AB45C9F0C29BL1PR12MB5237namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efc5998-da1a-45c3-7a07-08daf50b7779
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 02:11:22.4085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdHy5Q5Ho+7T5+geb5ow+hq7XDgk5LHQxpej6QTp6yhHxopdN81+1Hcebm4+aFZH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748
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

--_000_BL1PR12MB52373015FC820A8B41AB45C9F0C29BL1PR12MB5237namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Aaron Liu aaron.liu@amd.com<mailto:aaron.liu@amd.com>

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, J=
esse(Jie)
Sent: Friday, January 13, 2023 10:07 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Renoir/Cezanne GPU power reporting issue


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

--_000_BL1PR12MB52373015FC820A8B41AB45C9F0C29BL1PR12MB5237namp_
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
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
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
<p class=3D"MsoNormal">Reviewed-by: Aaron Liu <a href=3D"mailto:aaron.liu@a=
md.com">aaron.liu@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Zhang, Jesse(Jie)<br>
<b>Sent:</b> Friday, January 13, 2023 10:07 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Renoir/Cezanne GPU power reporting issu=
e <o:p>
</o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
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
</div>
</body>
</html>

--_000_BL1PR12MB52373015FC820A8B41AB45C9F0C29BL1PR12MB5237namp_--
