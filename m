Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1A0C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECFFA10F265;
	Fri, 28 Jan 2022 14:53:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D5210F259
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:53:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDR/N1RKSk/jz7ykKIGbvC16xr0rhOs/5/dRXVyIm3+IhBzwBwk7sfwiCp2WPRe3xhL1+6P3UnUyXyCoKvSdZQ5rdNuXBH+PA7FJQgY5SbCxPmf8EL/0A6WhcE7tm60LClCpwyej0NkY1B9yFm5XFHzK21uMELaPjF5gyayeCh//pRuwn4fT92/k1f2SkKxpGwlmZWMWRUTpvHlJ2O9WOUDztoh6ZFruDi0fmEIbFEKCaOHAM6dp63Mn907/A76enAHHSSxMjSh1haJKCTvsoqdEPKSe4M9uUs5fh1uTpOPv+IdZPZ1wnVX25AvKvnbComfR9prI1uJPk8zUz2nX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8yYoE3H00apzFiEoSfDgkJzhX0tJoFmkYNWB1tnSG8=;
 b=hCkw/uLd9S2+5Y7olKuIOzoZBFAE7J16d45fw93jAfIHr0ryMyoevrcyn7ozMYITVoVeBxsdSZA+8A6rUQMXyOQd9AoNxQi+Ef7VGSdrPUpVQjtvB6Gm1H0/GGus2ZFHK9J9NOVAZ5IX75Kyp/pfQ3/VdW31ZMCpUmPhxeI8OQ+pp8zTyNoJMWjPPTZ4GRSC1DAlxBhozIx0c+0i2lEm/FS74VSfxCYq3BTSD7EQSETlolJz2Y6wZ9i07HBuKlXHAPTR1qcAIMyC2++lo0sdQKcOpq/fowWcTlkqMQ8ZO41+JAHBsCo1Fzi1RTExuivpUG95RFplJfmjJy/uXaCGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8yYoE3H00apzFiEoSfDgkJzhX0tJoFmkYNWB1tnSG8=;
 b=mFuQLC9Mm6GDib1HTJCh01WxyBw0XKz1OckeuSPzzwkAcXsEDextxJJPXTBWFJ9dS1GvCMGZwfABvDvxa5Vo8EdHkBF5B66K3NfqgcIsrvR5x/uUu465QFZildxAVYOEf9bowZ+lel4ZrnnFUHlO7w/3d+UK3SAx/RbdyIUrGfA=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB4618.namprd12.prod.outlook.com (2603:10b6:5:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 14:53:09 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%6]) with mapi id 15.20.4930.017; Fri, 28 Jan 2022
 14:53:09 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH V3 2/7] drm/amd/pm: unify the interface for retrieving
 enabled ppfeatures
Thread-Topic: [PATCH V3 2/7] drm/amd/pm: unify the interface for retrieving
 enabled ppfeatures
Thread-Index: AQHYFBVwXGLEm0K3qUSwOXtI9H4Sgax4hTwe
Date: Fri, 28 Jan 2022 14:53:09 +0000
Message-ID: <BL1PR12MB51442EC8ADB50C29B584A7DFF7229@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220128070455.202014-1-evan.quan@amd.com>
 <20220128070455.202014-2-evan.quan@amd.com>
In-Reply-To: <20220128070455.202014-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-28T14:53:08.952Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: c3ef5f44-147e-d8e4-d40f-d3efb2c2ee3a
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86499494-0e59-4239-3828-08d9e26de687
x-ms-traffictypediagnostic: DM6PR12MB4618:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4618C008B5DAC388965EAD56F7229@DM6PR12MB4618.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jsjpMRPF/nNr45AWYZkvmDveoS+Vf4zuw/Dh/90trc6xJFzuOtnaacR0YeKPR/j25I3O1pqOwaeaoORsfa++yoOVvIG8srYib2he9smPvy82fn0/+oG1e4VmnfDaNm2v1QCilSVfOxGIGmLF2yrVqlonIu12YzDzwRXB2FMx4H6NpWZsRS4Dv1cEv+35OEgCCnTCs9SlGgqrRw+TJdu6LGgPPQsxXlfE37wPmXIaEuqRSfNy8ATowwmEkl0XOw3reUtwCCvsM+VYfDhAA/xkCrMV8t9ISUt/357byp0dOhY6YeXtNH+IgHM86+b23D5ONrLiCwDI18No+cjsSnUJAZiSkB/FI/B5KDYSdlOdLZjAU062KKgOnHPigblOj+KhGfaTSrlUwzdpWoyclvyUV01ah9QoDVLru8llw/hW+hyUZaAHfRhq2H6T/JntmJ+CXwV/HnMXhwOQPl6xF6TQXDPpzbH+kHaFwBaZgI7zEM2GoEtsquLFprD6/YyJm2J9tdfDWFjEfEVEKgWUM3dwqh7Pd39ft9niQswVD5Bphm0KMXiMv0ScbPgLyKhDvukdHr8a0d1UnSukYst8RnzkluZsHmTl86jTD59nRtwy5CLxapshK6epnlXZ4W2BCiLiYL7b2lXVr4OeBDqiicN4eiyjD04wCLIC55bmHCeVlgPHkqL/YsqGa2SR9sASQnQy2Yo0o2//dfukcYwWiFrDqg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(316002)(38070700005)(33656002)(122000001)(186003)(38100700002)(86362001)(64756008)(83380400001)(26005)(8936002)(110136005)(8676002)(66476007)(66446008)(6506007)(66946007)(5660300002)(7696005)(53546011)(9686003)(2906002)(76116006)(52536014)(66556008)(19627405001)(508600001)(71200400001)(55016003)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+na8pFA6fgWwne1r7nuEmdBaysLcLBA1XdqYTi5ZCCVWGAhz40uYvMViRakX?=
 =?us-ascii?Q?CvzaGuDV/S/PjmC9bJi8GjZAWoXEs/xM8IYK13AQxex5F+jl9WpcWqDVys85?=
 =?us-ascii?Q?pgerGugrpGnd2RR6qibN0KdklVI/RsCRy2ccAk/dmAYF2D7AAr62ClWgqxSg?=
 =?us-ascii?Q?6zblYDg2PkC8HBFx50Dd2zRdJfWhWaUr9ywmCxPgvY2Sxgq0DSQRS5ewDJVs?=
 =?us-ascii?Q?PDPOxe2iosliM/yj20jBPuHLWtJ0XKYYLhcjoiHHX2EVTvOXAhXlRERKa1ud?=
 =?us-ascii?Q?u6XWBG377drT/9RTNSZIIDcF+5I3LMnD3AnDrpZwbNgslPLX1Nkz17U3t5Lr?=
 =?us-ascii?Q?SmVRi2wjXXxhXuA32m0L4uCcngHIIMOtyN8rx2xRc68ULIyQkBMm4RNDWs/p?=
 =?us-ascii?Q?DAVNyy5bXofOz4VrW5zPIjuoauItfE0HkvVut3j0YYe+ap897epj7L+0yGPF?=
 =?us-ascii?Q?37CQ335FMCLddhhUxrP7m+3Knqg3h26G7981goUqXCHbwNlQpn6oljMWN6zh?=
 =?us-ascii?Q?DUBjLtVw1ySdTo+CVDFRMBk7NVLiqf/sverZrnP4nm/QdfKqzFPYsv7Mh5df?=
 =?us-ascii?Q?WOkSFDIotxeMmhNKSsmmPOfJD8aSzgOrSqRAWqtTbJn77TVRgDvaGM6dVNZU?=
 =?us-ascii?Q?ZxdNL+7R9zOAAFk+dfjm55wu4O4IDKh2WwMsVG/QDDKm90ZWzFzsYaVbMi3z?=
 =?us-ascii?Q?q2DHBr8LvAlpfDKclr42GT//YDo2W8d1T2TWbrwVhReTEYtAsQRlhTTu3wn6?=
 =?us-ascii?Q?s6IJISKIeJhqSeGtrxsIK+YAq4xFnY8RE+4ee3jlH5tFv35XZbYQnjCrHozV?=
 =?us-ascii?Q?rwdXSjD+w7aVYCWKvI5yFrb/llC9Q2FLveEzQg6lzIV1o282RLHxUzsEArZs?=
 =?us-ascii?Q?DKkv0tbIp6/86yBYprBnteNn8fXK70Dg4HBNst1u6OyfJlpEpM15Zu8ajAaY?=
 =?us-ascii?Q?ZzUAEjBkrdpqFv1y2ghxHKHbPDjGdlCBOAbYhXCRA4NAohPisGhGLmKw+MW8?=
 =?us-ascii?Q?a65OIuKTTCJsSETyvjLzGxR006Lx7gXDCyhuoBjWHggNZVlXHOAkaT3xd2d4?=
 =?us-ascii?Q?0XwVg/+XUlzZoVM/wvaF90kLLg8UwW6NQDx/o1q8bhxKLBw4gKqiubBdFwTE?=
 =?us-ascii?Q?a8BGlClggNecw02LjTgdqwSCncy1i8jnXVByHeZU/n61qdT2xNn7g8ebpoqF?=
 =?us-ascii?Q?oh9xRBwfWhPWnmaCSnSNbMceyC9WjPh87s34yMgwdh7i2G2qiqIncscOMVts?=
 =?us-ascii?Q?UX3I88+ezRRpF6H6hytG6ErDRy6p4mZEgzrSb80xTk1ylFdOBJRpwHxPtvfP?=
 =?us-ascii?Q?YgT10pomRFi4OyopffAKG1hq+E5fcJGAl7DMrYsqF5CqiUH1hhUx6bYRe3xc?=
 =?us-ascii?Q?+6nfGEzvLuPrdXpAf/oFML+oT7WgoREc6Jf96+uNyKzkXVP1rtNsbctARYsx?=
 =?us-ascii?Q?1lg6zaQzPMPt79EQXio0HSd7v39fx9jyq2OrnXVnXO31JXAvG4r1V8ornP00?=
 =?us-ascii?Q?uTOnu5q1HQJQJWi/HTG8U7093FB9eZzyvUENMb+lw7SG8zP5AndCx16c1QSf?=
 =?us-ascii?Q?Y0wrbhimQl64deyZCk281nWtUJIDaXucYdFYgIHJMlwu9jSSgsBS/KvGmLzt?=
 =?us-ascii?Q?hWW2swXdMfrhPZjav+ZS5jU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51442EC8ADB50C29B584A7DFF7229BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86499494-0e59-4239-3828-08d9e26de687
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 14:53:09.5476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r1VIMxHD+8btDuToJgh7/9BK+mZXc7nZtQtv9i0evyikpIaUKFGNTPkMPiHhV+K16D7Gv5m7eh86RRL8eszBMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4618
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

--_000_BL1PR12MB51442EC8ADB50C29B584A7DFF7229BL1PR12MB5144namp_
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
Subject: [PATCH V3 2/7] drm/amd/pm: unify the interface for retrieving enab=
led ppfeatures

Instead of having two which do the same thing.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I6302c9b5abdb999c4b7c83a0d1852181208b1c1f
--
v1->v2:
  - use SMU IP version check rather than an asic type check(Alex)
---
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  6 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  6 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 95 ++++++++-----------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  4 -
 5 files changed, 46 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 2f57333e6071..cc080a0075ee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -357,7 +357,7 @@ static bool cyan_skillfish_is_dpm_running(struct smu_co=
ntext *smu)
         if (adev->in_suspend)
                 return false;

-       ret =3D smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
+       ret =3D smu_cmn_get_enabled_mask(smu, feature_mask, 2);
         if (ret)
                 return false;

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 721027917f81..b4a3c9b8b54e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -507,7 +507,7 @@ static bool vangogh_is_dpm_running(struct smu_context *=
smu)
         if (adev->in_suspend)
                 return false;

-       ret =3D smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
+       ret =3D smu_cmn_get_enabled_mask(smu, feature_mask, 2);

         if (ret)
                 return false;
@@ -1965,7 +1965,7 @@ static int vangogh_system_features_control(struct smu=
_context *smu, bool en)
         if (!en)
                 return ret;

-       ret =3D smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
+       ret =3D smu_cmn_get_enabled_mask(smu, feature_mask, 2);
         if (ret)
                 return ret;

@@ -2182,7 +2182,7 @@ static const struct pptable_funcs vangogh_ppt_funcs =
=3D {
         .dpm_set_jpeg_enable =3D vangogh_dpm_set_jpeg_enable,
         .is_dpm_running =3D vangogh_is_dpm_running,
         .read_sensor =3D vangogh_read_sensor,
-       .get_enabled_mask =3D smu_cmn_get_enabled_32_bits_mask,
+       .get_enabled_mask =3D smu_cmn_get_enabled_mask,
         .get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
         .set_watermarks_table =3D vangogh_set_watermarks_table,
         .set_driver_table_location =3D smu_v11_0_set_driver_table_location=
,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index bd24a2632214..f425827e2361 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -209,7 +209,7 @@ static int yellow_carp_system_features_control(struct s=
mu_context *smu, bool en)
         if (!en)
                 return ret;

-       ret =3D smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
+       ret =3D smu_cmn_get_enabled_mask(smu, feature_mask, 2);
         if (ret)
                 return ret;

@@ -258,7 +258,7 @@ static bool yellow_carp_is_dpm_running(struct smu_conte=
xt *smu)
         uint32_t feature_mask[2];
         uint64_t feature_enabled;

-       ret =3D smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
+       ret =3D smu_cmn_get_enabled_mask(smu, feature_mask, 2);

         if (ret)
                 return false;
@@ -1174,7 +1174,7 @@ static const struct pptable_funcs yellow_carp_ppt_fun=
cs =3D {
         .is_dpm_running =3D yellow_carp_is_dpm_running,
         .set_watermarks_table =3D yellow_carp_set_watermarks_table,
         .get_gpu_metrics =3D yellow_carp_get_gpu_metrics,
-       .get_enabled_mask =3D smu_cmn_get_enabled_32_bits_mask,
+       .get_enabled_mask =3D smu_cmn_get_enabled_mask,
         .get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
         .set_driver_table_location =3D smu_v13_0_set_driver_table_location=
,
         .gfx_off_control =3D smu_v13_0_gfx_off_control,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index c3c679bf9d9f..c2e6c8b603da 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -545,67 +545,59 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
                              uint32_t *feature_mask,
                              uint32_t num)
 {
-       uint32_t feature_mask_high =3D 0, feature_mask_low =3D 0;
         struct smu_feature *feature =3D &smu->smu_feature;
+       struct amdgpu_device *adev =3D smu->adev;
+       uint32_t *feature_mask_high;
+       uint32_t *feature_mask_low;
         int ret =3D 0;

         if (!feature_mask || num < 2)
                 return -EINVAL;

-       if (bitmap_empty(feature->enabled, feature->feature_num)) {
-               ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeat=
uresHigh, &feature_mask_high);
-               if (ret)
-                       return ret;
-
-               ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeat=
uresLow, &feature_mask_low);
-               if (ret)
-                       return ret;
-
-               feature_mask[0] =3D feature_mask_low;
-               feature_mask[1] =3D feature_mask_high;
-       } else {
-               bitmap_copy((unsigned long *)feature_mask, feature->enabled=
,
+       if (!bitmap_empty(feature->enabled, feature->feature_num)) {
+               bitmap_copy((unsigned long *)feature_mask,
+                            feature->enabled,
                              feature->feature_num);
+               return 0;
         }

-       return ret;
-}
-
-int smu_cmn_get_enabled_32_bits_mask(struct smu_context *smu,
-                                       uint32_t *feature_mask,
-                                       uint32_t num)
-{
-       uint32_t feature_mask_en_low =3D 0;
-       uint32_t feature_mask_en_high =3D 0;
-       struct smu_feature *feature =3D &smu->smu_feature;
-       int ret =3D 0;
-
-       if (!feature_mask || num < 2)
-               return -EINVAL;
-
-       if (bitmap_empty(feature->enabled, feature->feature_num)) {
-               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetEna=
bledSmuFeatures, 0,
-                                                                          =
      &feature_mask_en_low);
+       feature_mask_low =3D &feature_mask[0];
+       feature_mask_high =3D &feature_mask[1];

+       switch (adev->ip_versions[MP1_HWIP][0]) {
+       case IP_VERSION(11, 0, 8):
+       case IP_VERSION(11, 5, 0):
+       case IP_VERSION(13, 0, 1):
+       case IP_VERSION(13, 0, 3):
+               ret =3D smu_cmn_send_smc_msg_with_param(smu,
+                                                     SMU_MSG_GetEnabledSmu=
Features,
+                                                     0,
+                                                     feature_mask_low);
                 if (ret)
                         return ret;

-               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetEna=
bledSmuFeatures, 1,
-                                                                          =
      &feature_mask_en_high);
-
+               ret =3D smu_cmn_send_smc_msg_with_param(smu,
+                                                     SMU_MSG_GetEnabledSmu=
Features,
+                                                     1,
+                                                     feature_mask_high);
+               break;
+       case IP_VERSION(12, 0, 0):
+       case IP_VERSION(12, 0, 1):
+       /* other dGPU ASICs */
+       default:
+               ret =3D smu_cmn_send_smc_msg(smu,
+                                          SMU_MSG_GetEnabledSmuFeaturesHig=
h,
+                                          feature_mask_high);
                 if (ret)
                         return ret;

-               feature_mask[0] =3D feature_mask_en_low;
-               feature_mask[1] =3D feature_mask_en_high;
-
-       } else {
-               bitmap_copy((unsigned long *)feature_mask, feature->enabled=
,
-                                feature->feature_num);
+               ret =3D smu_cmn_send_smc_msg(smu,
+                                          SMU_MSG_GetEnabledSmuFeaturesLow=
,
+                                          feature_mask_low);
+               break;
         }

         return ret;
-
 }

 uint64_t smu_cmn_get_indep_throttler_status(
@@ -710,20 +702,11 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context=
 *smu,
         size_t size =3D 0;
         int ret =3D 0, i;

-       if (!smu->is_apu ||
-           (smu->adev->asic_type =3D=3D CHIP_RENOIR)) {
-               ret =3D smu_cmn_get_enabled_mask(smu,
-                                               feature_mask,
-                                               2);
-               if (ret)
-                       return 0;
-       } else {
-               ret =3D smu_cmn_get_enabled_32_bits_mask(smu,
-                                       feature_mask,
-                                       2);
-               if (ret)
-                       return 0;
-       }
+       ret =3D smu_cmn_get_enabled_mask(smu,
+                                      feature_mask,
+                                      2);
+       if (ret)
+               return 0;

         size =3D  sysfs_emit_at(buf, size, "features high: 0x%08x low: 0x%=
08x\n",
                         feature_mask[1], feature_mask[0]);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h
index f0b4fb2a0960..4e34c18c6063 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -61,10 +61,6 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
                              uint32_t *feature_mask,
                              uint32_t num);

-int smu_cmn_get_enabled_32_bits_mask(struct smu_context *smu,
-                                       uint32_t *feature_mask,
-                                       uint32_t num);
-
 uint64_t smu_cmn_get_indep_throttler_status(
                                         const unsigned long dep_status,
                                         const uint8_t *throttler_map);
--
2.29.0


--_000_BL1PR12MB51442EC8ADB50C29B584A7DFF7229BL1PR12MB5144namp_
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
<b>Subject:</b> [PATCH V3 2/7] drm/amd/pm: unify the interface for retrievi=
ng enabled ppfeatures</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Instead of having two which do the same thing.<br>
<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
Change-Id: I6302c9b5abdb999c4b7c83a0d1852181208b1c1f<br>
--<br>
v1-&gt;v2:<br>
&nbsp; - use SMU IP version check rather than an asic type check(Alex)<br>
---<br>
&nbsp;.../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c&nbsp;&nbsp; |&nbsp; 2 +-<=
br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c&nbsp; |&nbsp; 6 +-<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c&nbsp; |&nbsp; 6 +-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 95 ++++++++-----------<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 4 -<br>
&nbsp;5 files changed, 46 insertions(+), 67 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c<br>
index 2f57333e6071..cc080a0075ee 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c<br>
@@ -357,7 +357,7 @@ static bool cyan_skillfish_is_dpm_running(struct smu_co=
ntext *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_suspend)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_enabled_32_bits_m=
ask(smu, feature_mask, 2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_enabled_mask(smu,=
 feature_mask, 2);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
index 721027917f81..b4a3c9b8b54e 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
@@ -507,7 +507,7 @@ static bool vangogh_is_dpm_running(struct smu_context *=
smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_suspend)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_enabled_32_bits_m=
ask(smu, feature_mask, 2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_enabled_mask(smu,=
 feature_mask, 2);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
@@ -1965,7 +1965,7 @@ static int vangogh_system_features_control(struct smu=
_context *smu, bool en)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!en)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_enabled_32_bits_m=
ask(smu, feature_mask, 2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_enabled_mask(smu,=
 feature_mask, 2);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
@@ -2182,7 +2182,7 @@ static const struct pptable_funcs vangogh_ppt_funcs =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpm_set_jpeg_enable =3D v=
angogh_dpm_set_jpeg_enable,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_dpm_running =3D vangog=
h_is_dpm_running,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D vangogh_r=
ead_sensor,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_enabled_mask =3D smu_cmn_get_ena=
bled_32_bits_mask,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_enabled_mask =3D smu_cmn_get_ena=
bled_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pp_feature_mask =3D s=
mu_cmn_get_pp_feature_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_watermarks_table =3D =
vangogh_set_watermarks_table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_driver_table_location=
 =3D smu_v11_0_set_driver_table_location,<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
index bd24a2632214..f425827e2361 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
@@ -209,7 +209,7 @@ static int yellow_carp_system_features_control(struct s=
mu_context *smu, bool en)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!en)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_enabled_32_bits_m=
ask(smu, feature_mask, 2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_enabled_mask(smu,=
 feature_mask, 2);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
@@ -258,7 +258,7 @@ static bool yellow_carp_is_dpm_running(struct smu_conte=
xt *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask[2];<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t feature_enabled;<=
br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_enabled_32_bits_m=
ask(smu, feature_mask, 2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_enabled_mask(smu,=
 feature_mask, 2);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
@@ -1174,7 +1174,7 @@ static const struct pptable_funcs yellow_carp_ppt_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_dpm_running =3D yellow=
_carp_is_dpm_running,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_watermarks_table =3D =
yellow_carp_set_watermarks_table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_gpu_metrics =3D yello=
w_carp_get_gpu_metrics,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_enabled_mask =3D smu_cmn_get_ena=
bled_32_bits_mask,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_enabled_mask =3D smu_cmn_get_ena=
bled_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pp_feature_mask =3D s=
mu_cmn_get_pp_feature_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_driver_table_location=
 =3D smu_v13_0_set_driver_table_location,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gfx_off_control =3D smu_v=
13_0_gfx_off_control,<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c<br>
index c3c679bf9d9f..c2e6c8b603da 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
@@ -545,67 +545,59 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *feature_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t num)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask_high =3D 0, fea=
ture_mask_low =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature *featur=
e =3D &amp;smu-&gt;smu_feature;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *feature_mask_high;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *feature_mask_low;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!feature_mask || num &=
lt; 2)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bitmap_empty(feature-&gt;enabled,=
 feature-&gt;feature_num)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesH=
igh, &amp;feature_mask_high);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesL=
ow, &amp;feature_mask_low);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; feature_mask[0] =3D feature_mask_low;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; feature_mask[1] =3D feature_mask_high;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bitmap_copy((unsigned long *)feature_mask, feature-&gt;enabled,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bitmap_empty(feature-&gt;enabled=
, feature-&gt;feature_num)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bitmap_copy((unsigned long *)feature_mask,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; feature-&gt;enabled,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; feature-&gt;feature_num);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
-<br>
-int smu_cmn_get_enabled_32_bits_mask(struct smu_context *smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t *feature_mask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t num)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask_en_low =3D 0;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask_en_high =3D 0;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature *feature =3D &amp;=
smu-&gt;smu_feature;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!feature_mask || num &lt; 2)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bitmap_empty(feature-&gt;enabled,=
 feature-&gt;feature_num)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetEnabledS=
muFeatures, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &amp;feature_mask_en_low);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_mask_low =3D &amp;feature_mas=
k[0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_mask_high =3D &amp;feature_ma=
sk[1];<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 8):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 5, 0):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 1):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 3):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; SMU_MSG_GetEnabledSmuFeatures,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; feature_mask_low);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetEnabledS=
muFeatures, 1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &amp;feature_mask_en_high);<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; SMU_MSG_GetEnabledSmuFeatures,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; feature_mask_high);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(12, 0, 0):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(12, 0, 1):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* other dGPU ASICs */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; SMU_MSG_GetEnabledSmuFeaturesHigh,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; feature_mask_high);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; feature_mask[0] =3D feature_mask_en_low;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; feature_mask[1] =3D feature_mask_en_high;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bitmap_copy((unsigned long *)feature_mask, feature-&gt;enabled,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature-&gt;feature_num);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; SMU_MSG_GetEnabledSmuFeaturesLow,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; feature_mask_low);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;uint64_t smu_cmn_get_indep_throttler_status(<br>
@@ -710,20 +702,11 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context=
 *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t size =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0, i;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;is_apu ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (smu-&gt;adev=
-&gt;asic_type =3D=3D CHIP_RENOIR)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_get_enabled_mask(smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_mask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_get_enabled_32_bits_mask(smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; feature_mask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_enabled_mask(smu,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f=
eature_mask,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D&nbsp; sysfs_emit_=
at(buf, size, &quot;features high: 0x%08x low: 0x%08x\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; featu=
re_mask[1], feature_mask[0]);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h<br>
index f0b4fb2a0960..4e34c18c6063 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
@@ -61,10 +61,6 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *feature_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t num);<br>
&nbsp;<br>
-int smu_cmn_get_enabled_32_bits_mask(struct smu_context *smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t *feature_mask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t num);<br>
-<br>
&nbsp;uint64_t smu_cmn_get_indep_throttler_status(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; const unsigned long dep_status,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; const uint8_t *throttler_map);<br>
-- <br>
2.29.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51442EC8ADB50C29B584A7DFF7229BL1PR12MB5144namp_--
