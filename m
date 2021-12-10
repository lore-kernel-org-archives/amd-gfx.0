Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A37C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 15:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB70A10E5B9;
	Fri, 10 Dec 2021 15:19:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8467110E5B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 15:19:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNowEJBOao58hbO+/KM+vXQnkb+Umn3yW6awlZpvVq1597ZJshAjwsd6e5C5qIQuJx/s649Tyb4cAorIkhdgbIPJsgJ+56/FiOVNQUdemEFrnsSCcCwXmaFqIMoasB6im/mNAXJQykgVlHfr4DL5O/s/C12IeVlwJdBM8D7qtyiEtSoynEYoHd/kAbe2ef8AWUAdoJkm9izX51bfrr84IjVEHsXCGfG0uwIoZ712/x30ygHzSzFlOryz5vuor8Q6qQ589OiR/c1RwP0wgZb/gpElhdjAkr6fxwzDwTY/uUQ8LnoSNsM5Ux1cyhAFg+l6ByI5cgzQ+FG0lWUxTqZJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeyVNNx0bvyrYoGC4br9CaUjmQbfCYWMIN25tFjED5w=;
 b=FHO843ba4WSLptUkBroQ6GRX7SV6jSIAgc4vdMh+SwBMJESC5AUL3VZqkIzDq9ikQEgbUTP9AI0+TNsyUZQDSURQdlFtS/uf3eQ1AYD4AcF/t7jW0g9wOFeI3DAYYlHeFUEFvjnF6NUbfMR9ushnuUACv9irFbvMTifsyXDF/9bnm2R42MsHhdDyqTUef7O13w9c3bZZjKwMmv/mSwPOVsZxKtgaqQalID2WP/19nnyLDapVifzkiG5L9z18sLuJMi2Fw8qbw5sPSOjEwYZZD+UHiSIt47w2Jh1FqO+MsGFr23UEyJbYqhOo8VtDYp40pBwVy6P2VczTMC3XIj95CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeyVNNx0bvyrYoGC4br9CaUjmQbfCYWMIN25tFjED5w=;
 b=Dp46tffTA1KW/t+C9e9qsx2mR+wWyIvQfTXfWmMGvGLHHqAvN1tNH1zq3bUkRYH1G6+mjHy+hnOilA6pskXKwYXJgOYdPdf2dHNZFhHWKyQ0HHJzEzEko7ubUkBkJpW1XP7B1NQTpJMavzQ/U/3HX3TWwVnPPcg2JYcWS95Sjic=
Received: from DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21)
 by DM6PR12MB3980.namprd12.prod.outlook.com (2603:10b6:5:1cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Fri, 10 Dec
 2021 15:19:41 +0000
Received: from DM6PR12MB4300.namprd12.prod.outlook.com
 ([fe80::5da2:b748:bed:9e49]) by DM6PR12MB4300.namprd12.prod.outlook.com
 ([fe80::5da2:b748:bed:9e49%5]) with mapi id 15.20.4755.022; Fri, 10 Dec 2021
 15:19:41 +0000
From: "Nikolic, Marina" <Marina.Nikolic@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 premission in ONEVF mode
Thread-Topic: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 premission in ONEVF mode
Thread-Index: AQHX7b2IGhO3CVBrKEqPARHKG7ZcnKwr1rOE
Date: Fri, 10 Dec 2021 15:19:41 +0000
Message-ID: <DM6PR12MB430083B7980BCBE2A4373DB98E719@DM6PR12MB4300.namprd12.prod.outlook.com>
References: <20211210120020.39737-1-Marina.Nikolic@amd.com>
In-Reply-To: <20211210120020.39737-1-Marina.Nikolic@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-10T15:19:41.154Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 8dd7a703-4fcb-2332-aabc-64e53f610fe9
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c84266e6-7900-43e0-ae02-08d9bbf07d46
x-ms-traffictypediagnostic: DM6PR12MB3980:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3980F3361944BF4E1EA90EE48E719@DM6PR12MB3980.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YkCNPGGMcTRbhGYBXGI/UlqO8jirGm/6/NlyiRd17WrQirfBvW3RDxaSyvoOcuVsZSYrMKfChDmWanZxj7ztOrTSyKY/ZIZOtS+0lTPnWkQhlKiqAAsDZWHjwJHvdj92auo1FxnYShWsDyWN7vq+SO1qJqneL88G6SMrrPusrayToicqS8aAWhav2CSWOJRdUi3TvpzS/iqBx2BpoTcPJQbumU0YsgiDVHGX+pkhd7Z5Y6QxKqSXMjWCVCqwCFyEzEOh+wjQoeHsKEsqRh5eSmHJ3a7sz0WNGn2zFak9u2VNS7hHJmHQVOiLvRL+78ohpKn3IED26LuFNdP71F+dRVj/0g4cGCw3NlP14CeUFDT+cuqfZ8NCZqm1OWZ/POkCzm+jh9Iv3+j03alY78243fyeHMULrF76qFlCJEkb4tRHUxFIDNd7QshhiNyyoCIuEi9YKCnGK8jVZxpZ6KdZWvOaSHMWWD2ks6S9arbWcC+mLtt8zCdG+/lqg9POG2kXw5R3/ZpHtwgz5ywe/o1w3ybbBuHgtq23ebGd5hP8hScBHs5DaFzEGKO2VgI2Jdjona2qCb3+45sFXp3bzSd4523kCsWlFBWD/Tw8RgygsQc533VR0JfzlEGLN8zXK36RVr3XECVW8i6dpGL2OYEoyEJWATzd0NEbEoLM0+02ubyxaG8S5tS805MqOObphUsYxwuUCvuSObca2LEcHgnbTw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4300.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(2906002)(38100700002)(52536014)(26005)(55016003)(316002)(5660300002)(6916009)(9686003)(91956017)(53546011)(6506007)(76116006)(19627405001)(71200400001)(86362001)(33656002)(83380400001)(38070700005)(66556008)(64756008)(66476007)(508600001)(66946007)(66446008)(8676002)(7696005)(186003)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xo145IU94NHLMWMRjHkWdlccb3hVyxpnnZzkhYHJoU5UPSM8sqhr15IJ77KQ?=
 =?us-ascii?Q?C9TgWGVg5fPWDh5aoRWMf5utVgRjpy5c4i3MsuC7zpdMrVQ4SoyuvPhbnPE3?=
 =?us-ascii?Q?xxi2ljv4KB6nuMz/9LyxB0/NJBersViYPPIJ/dxHYM38VJpcXGmOOEGwPMdV?=
 =?us-ascii?Q?t7oa5HlWGD86h+Yr865OaKnhhvPyal4U/I4H/nX5fpfRIwiwJTwX3IrtVaz1?=
 =?us-ascii?Q?APDlAB4wALAzHtp24BhJaLFCJnTPYinEPUMxMRKCHxHxOQcoUxHAM2TK/nik?=
 =?us-ascii?Q?8FTkTvizSg2vFvRqH+IX4xf/6GtJm+D/ERRWpXY1lkLipSVSQDVxYQeENEuE?=
 =?us-ascii?Q?ECYEBElLDuRC8AT3p5Me/YvcE6gg4fY7x2ut35FvPiQ8hY1s2CEsrSldzSnl?=
 =?us-ascii?Q?Q0S2ZMUzDSmSUuFM4j3hjIeSCemNs80wp0ndtFCv18Et68jBfoMF1xWnUaZF?=
 =?us-ascii?Q?KlGBipSBwuJTTPtguyFAZas1zSm4QmTx4s3ToIDkw86GBwOkcR8CF3+q21Ab?=
 =?us-ascii?Q?DDGjjbc95dlBTt69GTJMPi7A8jcM3vFJc2niJ5B+kBOmWpbv57bqyqsu8Dv+?=
 =?us-ascii?Q?WCYTP8fOBBH33O+4fJL0vylGoih+JZnSuJZaEDOF0N3XYpK5mdwEW+XGBUj2?=
 =?us-ascii?Q?OaiJXoX1/Y+t+jzV2c5yK/Ffv9obbCtCkUmxtUxkaB2IRMyQhBd1ho+UXaIg?=
 =?us-ascii?Q?7BvUoKhNm4syOcx+Y9jdDNVukhPSGfnnMeH8MA3GBcr0XHJl/D/Q8R+vaGLs?=
 =?us-ascii?Q?r57Dadeqf0jQ+kCSXrIKDTVWOTM73uP6aUthQ3HnDPg3jQ1H6498rCmbqN0t?=
 =?us-ascii?Q?WAhmc6zt+J63yqIIya0DvQK1XpbKbRD20p964Oic8MGrlf+kX9p/h75We/+Z?=
 =?us-ascii?Q?wLbz0Mr2qiq6wawoutxh+YJ8cAFoTggh6/XuttSQDLIcn9iY9ibjAm9TkI1i?=
 =?us-ascii?Q?qltsAuwv06VnJzvJM2dXCBvaJWrWt77BMfI2gIb6BWTI8wCeMzQixo81WhzU?=
 =?us-ascii?Q?1CacDjD9ioRC8DXPOQKyQaLl0r5UHoaHip18mxNBy/xbGvkXJj1EoNU7SW2c?=
 =?us-ascii?Q?6+HyZwmDXrU4pi+0ZyA4Inz6QGHyoysrBNes4sZTvs9nKEU3lxGyma3hk7ws?=
 =?us-ascii?Q?eaeVnltfJDl+apnwVokalkvH3Pj1vyGbCUpfkWr6Jh77P9GI8MEBm4741eKi?=
 =?us-ascii?Q?lTgdTaHln9xrNjuch092/c1pTGfD2TjHGX4htDSJPDFjrarhIOpO7Rq3eM1g?=
 =?us-ascii?Q?+2wbPoMi51iKrBfD+Cj0FcK+Tl2YHob7My/DmUMGpc4b/u00TBMPpTBblBDa?=
 =?us-ascii?Q?su3y6im6k4QmFwFbT3f+H+BuprMtky0iqgUGbVhJpSpkLB4OQA9/iUB+QOAA?=
 =?us-ascii?Q?B+1tW5UVys2T+LyHoyeKC1tVgNaBeXwZ+W4YPckFUzxvE86RS/xkyVGIrSX0?=
 =?us-ascii?Q?gBUYEHlegYq8LIk9an2kOvVwwYslr+OKtv/R9BnErODwjUBEUYoJaOvGi4wY?=
 =?us-ascii?Q?V9NPBoMr7anxXVV03dZxdPJM6k3Otm1qn6hkDMmkeCdXx2FeFmCnqsIgHBzu?=
 =?us-ascii?Q?eHC1j/L6BK9xCF25uknK5rDovDOC9AKcirh6wQmHsYvw++mrzcShFjgUuGbk?=
 =?us-ascii?Q?ug=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB430083B7980BCBE2A4373DB98E719DM6PR12MB4300namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84266e6-7900-43e0-ae02-08d9bbf07d46
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 15:19:41.6715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UKoOY/36ZM4683LM4m4JSe5bBQrrDgl7c4f9TFTy71QnqOyT+TNfsHMf1uT60q3w12Ixa06FW9UJzHncCCdqDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3980
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

--_000_DM6PR12MB430083B7980BCBE2A4373DB98E719DM6PR12MB4300namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Please ignore this one.
There was some issue, and all changes are not included in the patch.
I have sent an update in a new mail (same subject).
Sorry for inconvenience.

BR,
Marina
________________________________
From: Marina Nikolic <Marina.Nikolic@amd.com>
Sent: Friday, December 10, 2021 1:00 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Nikolic, Marina <Marina.Nikolic@amd.com>; Nikolic, Marina <Marina.Nikol=
ic@amd.com>
Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read prem=
ission in ONEVF mode

=3D=3D Description =3D=3D
Due to security reasons setting through sysfs
should only be allowed in passthrough mode.
Options that are not mapped as SMU messages
do not have any mechanizm to distinguish between
passthorugh, onevf and mutivf usecase.
A unified approach is needed.

=3D=3D Changes =3D=3D
This patch introduces a new mechanizm to distinguish
ONEVF and PASSTHROUGH use case on sysfs level
and prohibit setting (writting to sysfs).
It also applies the new mechanizm on pp_dpm_sclk sysfs file.

=3D=3D Test =3D=3D
Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.
Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:
"calling process does not have sufficient permission to execute a command".
Sysfs pp_dpm_sclk will not be created in MULTIVF mode.

Signed-off-by: Marina Nikolic <marina.nikolic@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c     | 2 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 082539c70fd4..a78dd0799492 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2021,7 +2021,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[=
] =3D {
         AMDGPU_DEVICE_ATTR_RO(pp_cur_state,                             AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
         AMDGPU_DEVICE_ATTR_RW(pp_force_state,                           AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
         AMDGPU_DEVICE_ATTR_RW(pp_table,                                 AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-       AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
+       AMDGPU_DEVICE_ATTR_RRW(pp_dpm_sclk,                             ATT=
R_FLAG_BASIC, ATTR_FLAG_ONEVF),
         AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,                              AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
         AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,                            AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
         AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,                              AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/p=
m/inc/amdgpu_pm.h
index a920515e2274..1a30d9c48d13 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -79,6 +79,10 @@ struct amdgpu_device_attr_entry {
                              amdgpu_get_##_name, NULL,                   \
                              _flags, ##__VA_ARGS__)

+#define AMDGPU_DEVICE_ATTR_RRW(_name, _flags_full, _flags_restricted, ...)=
      \
+        AMDGPU_DEVICE_ATTR_RW(_name, _flags_full, ##__VA_ARGS__),         =
     \
+        AMDGPU_DEVICE_ATTR_RO(_name, _flags_restricted, ##__VA_ARGS__)
+
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev);
 int amdgpu_pm_virt_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev);
--
2.20.1


--_000_DM6PR12MB430083B7980BCBE2A4373DB98E719DM6PR12MB4300namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Please ignore this one.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
There was some issue, and all changes are not included in the patch.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I have sent an update in a new mail (same subject).</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Sorry for inconvenience.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
BR,<br>
Marina&nbsp;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Marina Nikolic &lt;Ma=
rina.Nikolic@amd.com&gt;<br>
<b>Sent:</b> Friday, December 10, 2021 1:00 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Nikolic, Marina &lt;Marina.Nikolic@amd.com&gt;; Nikolic, Marina =
&lt;Marina.Nikolic@amd.com&gt;<br>
<b>Subject:</b> [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only re=
ad premission in ONEVF mode</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">=3D=3D Description =3D=3D<br>
Due to security reasons setting through sysfs<br>
should only be allowed in passthrough mode.<br>
Options that are not mapped as SMU messages<br>
do not have any mechanizm to distinguish between<br>
passthorugh, onevf and mutivf usecase.<br>
A unified approach is needed.<br>
<br>
=3D=3D Changes =3D=3D<br>
This patch introduces a new mechanizm to distinguish<br>
ONEVF and PASSTHROUGH use case on sysfs level<br>
and prohibit setting (writting to sysfs).<br>
It also applies the new mechanizm on pp_dpm_sclk sysfs file.<br>
<br>
=3D=3D Test =3D=3D<br>
Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.<br>
Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:<br>
&quot;calling process does not have sufficient permission to execute a comm=
and&quot;.<br>
Sysfs pp_dpm_sclk will not be created in MULTIVF mode.<br>
<br>
Signed-off-by: Marina Nikolic &lt;marina.nikolic@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp; | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h | 4 ++++<br>
&nbsp;2 files changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 082539c70fd4..a78dd0799492 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -2021,7 +2021,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[=
] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(pp_c=
ur_state,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_f=
orce_state,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_t=
able,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_O=
NEVF),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RRW(pp_dpm_sclk,&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ATTR_FLAG_BASIC, ATTR_FLAG_ONEVF),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_d=
pm_mclk,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_d=
pm_socclk,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_d=
pm_fclk,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/p=
m/inc/amdgpu_pm.h<br>
index a920515e2274..1a30d9c48d13 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h<br>
@@ -79,6 +79,10 @@ struct amdgpu_device_attr_entry {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_##_name, NULL,&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; _flags, ##__VA_ARGS__)<br>
&nbsp;<br>
+#define AMDGPU_DEVICE_ATTR_RRW(_name, _flags_full, _flags_restricted, ...)=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(_name, _f=
lags_full, ##__VA_ARGS__),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(_name, _f=
lags_restricted, ##__VA_ARGS__)<br>
+<br>
&nbsp;int amdgpu_pm_sysfs_init(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_pm_virt_sysfs_init(struct amdgpu_device *adev);<br>
&nbsp;void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev);<br>
-- <br>
2.20.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB430083B7980BCBE2A4373DB98E719DM6PR12MB4300namp_--
