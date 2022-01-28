Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3963C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 340AA10F303;
	Fri, 28 Jan 2022 14:56:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CB7B10F303
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:56:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFTU6lplR+SlLbsYdOpPtKMqr1cYBzT/rFZY3zhUKb0tz+QkX3VyWu/JkXaNztw6LokJaTlrx+hMSL2wBzcd63SD1qWpNa5VJTNjgVzNGNSuJ6HRKk0FBkuscMfETyMrPjEuW5289BrJdbUvMNJqtnc6eSsbBQdpo3bWEM7yoZNC4GH0FDoB1HSAnnGhzkvaAeQrToMxSNgAtvjU76pifBLDwzuMf90I/+gmAD7lpub71RM8LNN8WYW8ifbJcv+zCmxd4tvEvc55aUFLbEI+NKAks9gNuJftRhp/EOoa1TbBxGY4KPiKs3sNOgM0WnmNesn2xV22jw2HhYdZ5l2rEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLFI13r0GdMrNn0ojjmO+oSwL+fRQFcFTaXPcl2tiCI=;
 b=IQ460MqwmTFhPf5LT78MMsuuoow/HOXj7EbSw6dDU/ygpySPDNstQpYsQonorHqhPhVkE0WNJzYlwrdYOSd+hsN3p+gr58hJzUQ71EdllRIzRhN+1Bsre2kIA3eI3lMNKPjCpZTEzI3vY8AbbZMAAuG55Y6JJtHFqww8PAsGISG7gLtnWszNWE9cf5PIlZ+/RAWbbaKuxMeLIMzFarIukGPcEgtVM/MWDDiFs0gsm41UrNR1dGlg1BF55BtEYdcB/dFq8816YLcuWFuDwDrR7PzqcvNWTwbNo/ut1/CYJiWkgjxdtlVViXBGOBfNB8HSafSdTbXHQgiBPFKEjAK0gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLFI13r0GdMrNn0ojjmO+oSwL+fRQFcFTaXPcl2tiCI=;
 b=P8jx9ROX1XM1lslV5HXELTDnTwXMpnbLO5semyCwi66k+tad6BDN7M6Rjnn3sTUTEsXJd8TsQ/e1Qhmhvga5BmQ4xwRyg+otyaayZDoOewEqRtOs842Oy+f54XqSUk4doXAjYu1tKyi+ZQbqQV8a8TjrJMdDSzgetLSM9Werv3Q=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MWHPR12MB1616.namprd12.prod.outlook.com (2603:10b6:301:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 14:56:15 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%6]) with mapi id 15.20.4930.017; Fri, 28 Jan 2022
 14:56:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH V3 6/7] drm/amd/pm: avoid consecutive retrieving for
 enabled ppfeatures
Thread-Topic: [PATCH V3 6/7] drm/amd/pm: avoid consecutive retrieving for
 enabled ppfeatures
Thread-Index: AQHYFBV0hiT05lboZkaxWQINtdx3wKx4hjKI
Date: Fri, 28 Jan 2022 14:56:15 +0000
Message-ID: <BL1PR12MB5144B4652B0296AF5AEE2973F7229@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220128070455.202014-1-evan.quan@amd.com>
 <20220128070455.202014-6-evan.quan@amd.com>
In-Reply-To: <20220128070455.202014-6-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-28T14:56:15.041Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 63735f03-a229-48ad-4c15-7dcfc183a70e
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25dbca12-97e0-4d6e-c660-08d9e26e5575
x-ms-traffictypediagnostic: MWHPR12MB1616:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1616757F253F3BE1E264D9FFF7229@MWHPR12MB1616.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XR1Jj0p80vNse/nhHx/z/wHqbI+eB3Sb0X+CGZCIsO3hIOjinH0p8gQGHvgy3BC0TMPhx/B+g57f9oRCJ/SWLzIDFdXI2ril481agKS+/6rW5OBMeAb+Y+DTXetmzc+1+C/Br5W3GVYNwr++JWJLdJO4AN8rmPkoFu1ATafZ+Rx0ra5I6psvNwrUo13Ss5Uly0mr+hUK81NquoD1UBd5Vbr+Q4IVIyGT5LJ5pS3Ba8N9dqmFh4Gl2Phbx/jBAY5HSR+Dau9mzsazwCHOHNNz0G8QI4njXmICM522MU7CnRr8d4CqW9l3UMe24CX86x8e1c5gkDIkkXB1sILx0JbwrEC3PErclbsyyEzf6Hh6hmMlBP2mMWTnDI8S1VJA6I2yG+JvIB5e+Z3rcPoHjjAZ1EJGeDhmPzhUm1pj7LJV/g+geYHkGfo9sH/T00nuW64hwWQVFbBGj2k8fZu3eCu8YIUWrhN+WP/JPEakXk8VOzoczsclA96OIiHEV+fhVW/+L22kRG6CE51czcZvblbR3iaocm6TjJA92qmBfYbM3ZLXAFhW4kjgzczIrhhQQp8RIV9D2goKcRJMbTolq5PE1+8di4B5R1MSkTkQzVt5a+pl/oS480JJN7dCzVh4Pb60FbxdgWrWLKWDEzrb+TjB9L8V3mMf/LQUjo+oZsIydsgwi2aZhd2AyDsDlXxnsfj9FchyRRmliXz7oW10hOz/UQPZ7/Tyjgg/Mr6rHw43LcU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(38100700002)(122000001)(2906002)(33656002)(19627405001)(83380400001)(76116006)(186003)(52536014)(26005)(316002)(53546011)(9686003)(7696005)(86362001)(6506007)(71200400001)(508600001)(55016003)(66946007)(64756008)(66476007)(66556008)(66446008)(4326008)(8676002)(8936002)(5660300002)(110136005)(309714004)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6R/k1XrYlmp3Hvpudvdaa9S6m8PrLK/WqS3WaN//bsUs7K4SZ5Inw+QdRg4Y?=
 =?us-ascii?Q?QZS4TJfUQblE9iQ8y1PKkeYHNblWDnarTTuUxZQkW/EPeRjrmENjIYzar/R6?=
 =?us-ascii?Q?NqzI2hiK5VTI1g2Wngja+OvyNWgNZHxCOVkejs066rLv0r442eHSqKtyJR6N?=
 =?us-ascii?Q?mdndhwMp2K9tzS8mz+8JHQSU3kM+/aW2Iw+HGfX9i4/ThNZHLvT2dWST2IPr?=
 =?us-ascii?Q?0FRsJiwNl+FFgHnsVX5A4dP2+/1DNdNkdlnlK96xb9wohpsMcHWrAV2NbI50?=
 =?us-ascii?Q?xywxEiCbalprWnJT8Vuys6XdEjBobnUx9duJkYC6i3ZNFuPHrbx2Blnx6Rd1?=
 =?us-ascii?Q?0K736//gXcNeJ80UxJzy+C8xL39qcOALvOBXOObNdWceqH0RdskU348cfvsA?=
 =?us-ascii?Q?3F4gm3yPUOMkS7SYPzj3s2Qbb90PsLHi7JdFbcgRH5mHRqi+DoAXANBDLMd/?=
 =?us-ascii?Q?rhef4yxb1T12JeL6SWnCf10saSd9NZt32cHKuM31/Q7f5Ayr/kM3penX/LQH?=
 =?us-ascii?Q?4tQJsTrEG1Y3bxhlcia3ZcLtJd41WOZDfTqwG1441/UeYFz1/OxjyOT3FBHR?=
 =?us-ascii?Q?aTRZcpEVVPcFBNEeWwe1ayp0RuOoAyhSRq2jPJPA97q2u+RVGw1TkodrwsJg?=
 =?us-ascii?Q?neJkfrQhSR+abXXxGN2/Eknul8LfYQh0LkcI944adCAJh7nLVVYNIIydoerC?=
 =?us-ascii?Q?lVCqXSH3YsewjkAqiljSMh3pr7Qe6n5TwQc0n5AABDLOUixzZp8UvMR7HVI8?=
 =?us-ascii?Q?NAYMw61CUTrL06HdrY+tj0gMzcjhGnn9qlDpBW04n3WVPPw+4e0LLlvcrxPn?=
 =?us-ascii?Q?zcPn4fZbzB0j7PoGGAh7/D+6ADRPiyrIBx07e0BwOHI4TyR4KmhE7HGgXHR/?=
 =?us-ascii?Q?DoZg0Rn2iAQyde2aj1CG0Ww/6KU33apY1DGChXsHduGvOWRCB0XAEyb8BvXu?=
 =?us-ascii?Q?3iNZ2jEdTvVyIdkym14lfqZKXdGKpUN+cHSPL5DMdU4M6zhxQA/HuCvBi1d8?=
 =?us-ascii?Q?6KHxCx2gWRkBp62xz4XwseN6Rp2ESrcoiNgAM5qFhEDiryrPvPmURXz61vv5?=
 =?us-ascii?Q?db5yZCKdz2tBmaYmMKAPk2WSglM8dfCOMlB4WE40eRfrFy3M3KUCyefmmQTy?=
 =?us-ascii?Q?8zNtxyo+ahR2mPGEequYCpsO2eEyHoWDBDdrIwSbFebW7xgkOl8fWBRLDfOi?=
 =?us-ascii?Q?lkgeW7WZ5Lr0jEkARyQ9kOGihEiwCoUJHlzRqj1qZuu7fJcsoJ+aUcB/M9+Q?=
 =?us-ascii?Q?1IAQkrXsgSLAP8C2ZtIvZhRP95BV6yIO0aA5ajd4SCZSXVjpf+gFiJHtKz/r?=
 =?us-ascii?Q?uXsAfk+qshO+8Ac6BYFh7uWnbs9RpdaF15pRXSuANODddty19ODcfW9cCUwN?=
 =?us-ascii?Q?mYB19l3a1hcA+YArBqcHJEwt01LUmRuIVuevhLoCoX0YWAC4UnR/3N81aPQC?=
 =?us-ascii?Q?cMlA9VNNWXWGTarXz8XcxMDWG/xbkLbr1XDDQCs03u3dqbcUsv1GpshSaUYF?=
 =?us-ascii?Q?wDY5idAUy9N18VpxhiNpVLkiAWr7io54efwJk3kTo3gtpELUDpNtaM+/spEL?=
 =?us-ascii?Q?v6J10bB5pk1RBVgNPayZAxeW9xZ1kO9I7CkPujfU3wiXI1GO+TIOyGMJwmpK?=
 =?us-ascii?Q?I4yb5GPt+SFfyE3KJU4itMM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144B4652B0296AF5AEE2973F7229BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dbca12-97e0-4d6e-c660-08d9e26e5575
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 14:56:15.6447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CjpfZouLmXWlkRdYIQy52rhD73Zp/6DXjfmEPltUz/C9k5LnTcSL0CaK3hZWAixiiEhqKQicwyZsKB4KbuvoMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1616
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144B4652B0296AF5AEE2973F7229BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, January 28, 2022 2:04 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar=
@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH V3 6/7] drm/amd/pm: avoid consecutive retrieving for enable=
d ppfeatures

As the enabled ppfeatures are just retrieved ahead. We can use
that directly instead of retrieving again and again.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I08827437fcbbc52084418c8ca6a90cfa503306a9
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 3d263b27b6c2..acb9f0ca191b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -680,6 +680,7 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *=
smu,
         int8_t sort_feature[SMU_FEATURE_COUNT];
         size_t size =3D 0;
         int ret =3D 0, i;
+       int feature_id;

         ret =3D smu_cmn_get_enabled_mask(smu,
                                        &feature_mask);
@@ -708,11 +709,18 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context=
 *smu,
                 if (sort_feature[i] < 0)
                         continue;

+               /* convert to asic spcific feature ID */
+               feature_id =3D smu_cmn_to_asic_specific_index(smu,
+                                                           CMN2ASIC_MAPPIN=
G_FEATURE,
+                                                           sort_feature[i]=
);
+               if (feature_id < 0)
+                       continue;
+
                 size +=3D sysfs_emit_at(buf, size, "%02d. %-20s (%2d) : %s=
\n",
                                 count++,
                                 smu_get_feature_name(smu, sort_feature[i])=
,
                                 i,
-                               !!smu_cmn_feature_is_enabled(smu, sort_feat=
ure[i]) ?
+                               !!test_bit(feature_id, (unsigned long *)&fe=
ature_mask) ?
                                 "enabled" : "disabled");
         }

--
2.29.0


--_000_BL1PR12MB5144B4652B0296AF5AEE2973F7229BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Friday, January 28, 2022 2:04 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Lazar, Lij=
o &lt;Lijo.Lazar@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH V3 6/7] drm/amd/pm: avoid consecutive retrieving for=
 enabled ppfeatures</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">As the enabled ppfeatures are just retrieved ahead=
. We can use<br>
that directly instead of retrieving again and again.<br>
<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
Change-Id: I08827437fcbbc52084418c8ca6a90cfa503306a9<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 10 +++++++++-<br>
&nbsp;1 file changed, 9 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c<br>
index 3d263b27b6c2..acb9f0ca191b 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
@@ -680,6 +680,7 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *=
smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int8_t sort_feature[SMU_FE=
ATURE_COUNT];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t size =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0, i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int feature_id;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_enable=
d_mask(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &amp;feature_mask);<br>
@@ -708,11 +709,18 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context=
 *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (sort_feature[i] &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* convert to asic spcific feature ID */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; feature_id =3D smu_cmn_to_asic_specific_index(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CMN2ASIC_MAPPING_FEATURE,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sort_feature[i]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (feature_id &lt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size +=3D sysfs_emit_at(buf, size, &quot;%02d. %-20s =
(%2d) : %s\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count++,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_get_feature_name(smu, sort_f=
eature[i]),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !!smu_cmn_feature_is_enabled(smu, sort_feat=
ure[i]) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !!test_bit(feature_id, (unsigned long *)&am=
p;feature_mask) ?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;enabled&quot; : &quot;disa=
bled&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.29.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144B4652B0296AF5AEE2973F7229BL1PR12MB5144namp_--
