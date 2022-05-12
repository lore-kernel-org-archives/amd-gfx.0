Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB165C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 20:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46D7D10E0B0;
	Thu, 12 May 2022 20:54:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E79910E0B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 20:53:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxsWu+RfnEv+hkfWMr1Jx8QrOUaKJihgGnZaINRfMVKMmPYHy9dEBuN+eweAJO5wRIzVRz4t+sJwfFnOuAAXOVwiuwneP9X19OeL9YWx/u6bQ7PMZXFyDuOmjJGs2dYVFnq1DI1paxx1WmpaQmT7Lf7p5WwcgOQAY+0cF5OekAL7QgRriai9X/qBN/9oK7/BzrmYoeww6IEzeBxRJmbhdbQyNG2bfp+KN/rv8kq7cQYkgAhC3djSfacgWU/tHcVnDVrUrPyu3bJSqKvpwiKpbLxDtFmIDCNjiTOZtj8eAHMyIBPG76npvhJWzvE3n7Vgc6+xs6N3p3QTmpcycbGYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SL2fpR5aeveRw/B9FWC6mSG6ClBcfqTJp5mQliF7AWI=;
 b=c1OeRQj2ben6ogIR3gy6kNO9v1xotnYKhoUQUmsoVYTIbCOnNkQ8DYebKBXss8I9bFgmZ1bJNCp7hkKlTF5rgYCxEZVSKeKsdVZ2nZSy/sgWKidjugxNP2OveLNxTsaTAPurhm+d6te3XDimBCC13ym1y6kgg9diNEaPCvKjV/sjy06jg3nSOevpRJy2JstBS2cvbewusLcvfi+g72zb7+yN2LSRR3t4k8MDpAkjiFA/f/Edk3P69UaaKXORuoiiQmAbspioepTGDHPOIc+51DY1wAxH+UldI/PJgsVe43x4QgG60oxjqik+5lr6QO34fc3FVG0qpWjKyi43ja6big==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SL2fpR5aeveRw/B9FWC6mSG6ClBcfqTJp5mQliF7AWI=;
 b=LYcVWe2LCkp8+lwaIYkXsP32Ephw3TOU3Y+x/OCEZDm89QhSbVz5LmvpW+DW9V3Bh9q148aEu+i2/wDyfYbXLMYUv8Dnzva7pvkF4NHVL4oRxjL02R/wjDQMkkzchnKufi8b4EQCuiD7CFCXl6gcHMZ6TJMLlrmj1POwvc6l7mM=
Received: from MN2PR12MB3054.namprd12.prod.outlook.com (2603:10b6:208:d1::15)
 by BYAPR12MB2966.namprd12.prod.outlook.com (2603:10b6:a03:df::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 20:53:57 +0000
Received: from MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::543a:9edd:6fea:5d0]) by MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::543a:9edd:6fea:5d0%3]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 20:53:57 +0000
From: "Kim, Sung joon" <Sungjoon.Kim@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amd/display: add Coverage blend mode for overlay plane
Thread-Topic: [PATCH] drm/amd/display: add Coverage blend mode for overlay
 plane
Thread-Index: AQHYZkHqqPj6Ij/gb0SrqroePalzUa0bt9HQ
Date: Thu, 12 May 2022 20:53:56 +0000
Message-ID: <MN2PR12MB30544B1DAFCE33B87EA432FC97CB9@MN2PR12MB3054.namprd12.prod.outlook.com>
References: <20220512204746.4533-1-Sungjoon.Kim@amd.com>
In-Reply-To: <20220512204746.4533-1-Sungjoon.Kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=68bd0c53-f261-4776-a9fa-0dfe9bb17c49;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-12T20:52:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bbb00fb-5930-4918-451b-08da34598841
x-ms-traffictypediagnostic: BYAPR12MB2966:EE_
x-microsoft-antispam-prvs: <BYAPR12MB29667FD26BFDFE342FA4446497CB9@BYAPR12MB2966.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vi3ZEy6qqYJu3u3P2oAsRR6Og2rQlCaGcEyjfOmyNvQ+OFrU1MVUCf4L8OHb4DpcfKo1BRzs9xZUU/mB+6XUL8gC5JVgBb87Zo1GjIbaeTnSO3kV0SMHAtefcUyG0jz54Yd2mQBv2hqww86pWlho6y3WyJ2kzdotnpRZMIRCB5n76pQV3j4E73X1USySPVXcFxmrYwlxMetICzpZM+xJOSE2pdDhxdtOp9iVx2lgAv5b4bR2C22au6R55SMj7jtBZIUoobKJaaNvdjvG5wDNApGqKI2N7AJlwVYVjjpzN0UCKUDdePSJTeTWjHdBlpGb1+rbuTArJ3Y3eyqD1nRwojeV4pAtRZPJlcqIjRGTK5pwNCR3c0m4aLkLCeHiBxVQNaPLQg+nI6mFgwHnMemAJIjk/+DiIKO5G7orU11RehmBuJg8n5l6Vsb4MH6Rq/dycz+lGVoMLWHK+UmAPoC9xRl/6go020eswzvTkZg9zAASMP264CWyVdtjALRHhWkrRzT6QYPh1fHMXGy/0gm1A7fpnIeffyXsahJ4+4cJ6vmA8WVpLMjtJyDVsXFCR6S14HKITgvGozKxt5ZWTgYjgNPkBbA3ssuayHQWzIBaIHHMnLKnyA3d6OXOD+iq2tyymCQ8yxpuSlDkG4iFD2NDXUZz6vTE/jYzlp0r89PiaQvMAK8DRvTcr6hTs5sMBLJL2s9+yQmJ5fJl/M0/CIYPDLNXiUgtcKWElVyyDlWYHO4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3054.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(54906003)(71200400001)(33656002)(53546011)(76116006)(6636002)(55016003)(66946007)(966005)(8936002)(52536014)(508600001)(7696005)(921005)(8676002)(64756008)(110136005)(186003)(66446008)(66476007)(66556008)(6506007)(4326008)(38100700002)(316002)(38070700005)(9686003)(5660300002)(86362001)(26005)(2906002)(83380400001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c483rkSFPqLXgJtljpKNq5m1QbTRU5mUEuxLm5xMx0z7OOIvwnhtXGR5tKVH?=
 =?us-ascii?Q?w7VpZ8vT8jI4uTVuOyxX64vIs01jPFCfXzehRkGO7B0EcqW9Exai3pxmOUsJ?=
 =?us-ascii?Q?UcmbLRmnWM9K/DKbUKY3cHK+xanfn1t62i1L2Evh3/dDAKxfFJGdzVMQoFxi?=
 =?us-ascii?Q?LtofaiJ5prJVLWPENc8TR2ID7bXlOsFDThXqeIeMZeA5KpPiB8BVtRJWRiCQ?=
 =?us-ascii?Q?CMBO7U0EyTWfaVOYEPHXpoAJ5bY62s6gFlcGcwtuaPD5IpH4egp0KtjKZ+GR?=
 =?us-ascii?Q?PBrsBHaIAiU49JVbpDTjqyRd1bmS1HLxIEexTgYGHbE6KPKTkpxfxFV/QSJG?=
 =?us-ascii?Q?IzO0s9/J0wLahEJtS44SHPlMkj0HJaHpUKKc/WVz3jsso3y0l8aMIMDp0tFQ?=
 =?us-ascii?Q?JmybLxrEDG9V8Dnm5tohhOU01mvkdPF753TkWSNdZcpAPS+lRHRxEvMYyBSa?=
 =?us-ascii?Q?4YoyY08AGMiXDeTFR3SjvLUuMO32Tar9sSHbQ8PJa6WzRMe/yXG62erIO8T/?=
 =?us-ascii?Q?v4BCooNatr9MiqeIQsxEh5oL6msJ1Nsi6HyVroShZYYOc9tJUazM2llhokr0?=
 =?us-ascii?Q?/A0TrZCL3oSwFK4iCOtW1GBINbrDWjLsHrZrT7WgBux7MSaueXCbylPB/nrO?=
 =?us-ascii?Q?EuNyJZEQPcC3qZyUeHeTA4k46m13fhvasVuuvda1QJuoldu7XnBVYaN18J5t?=
 =?us-ascii?Q?boZLjfktX5xfvbEiRhv8KQdftz1r6Ba9S3rBDY5YHDZSLjS/7PyvqRRm1TXL?=
 =?us-ascii?Q?ndIORHHJz7f/t30XYVgSl0IpmqhrPpbEeTN2lGzUzcGhw7CIAlFWjs8GnouI?=
 =?us-ascii?Q?n36bjZWsyRz8kc3c2vE2cZQYS6uV9A/o5wKSZ64Mq4O44CUSyudCSNNT8Kg8?=
 =?us-ascii?Q?5wfMJuLeyNYwmbIGrXArmqWXYszxJkuVkvJqkX11kfq+3oatcUXV/HchfG9J?=
 =?us-ascii?Q?vZNjsi4dCjx9S2leXlxfVgEhqUIwcw7hNro9qbdYv0DBRquoqKfnvD49BgAe?=
 =?us-ascii?Q?JdT2hJvTR7MoAlKzBV2V1gQ2A8daXaQzLeAtCYajaP08dXE96HUCLtVoMxnc?=
 =?us-ascii?Q?ahbTqyaMsXmMxLIEfhBNE8mGrXgLyyFziR4ND91HKn9EXtBMb67B3q7I9OWL?=
 =?us-ascii?Q?HpkdVA8xNgsRv8AFdQxW0f/mMXWL2q7qsvwwXmGEvOiVHnTdAyjjgpgmHUqF?=
 =?us-ascii?Q?kKwgEczwqNQwoUAJmHev2ID3UUPZlcTGcD0KswQoUDDQK4UV3bX5FcaIDlZv?=
 =?us-ascii?Q?B1MDuZD9c4ju6/Ev2+lJp/fygsfj/CtYWf0frnXkrelMNKS37vfCoEhWrAXt?=
 =?us-ascii?Q?/LSAxhVtExodXcPCHb4J8pWoXCWI1H2Oc69g2BRGFW5dRY2SYfDsN3w/odkY?=
 =?us-ascii?Q?9sKqgHFEo4pESPq+6bfvWmH3TxiVAni4zfsMYf0WZjobrMFhbkLmI90mRjN6?=
 =?us-ascii?Q?ZZ3UQtDF99f4Vsfs2ArskQfRpuK7t6Sb4Kkw9kG+w3iEe0FAxm17r26NOUt2?=
 =?us-ascii?Q?sMZk5c81gyU80OL0yfYTypzuW0pF/WizF0KyrcrXIBX+vzHjOnVIRjyAUOJ2?=
 =?us-ascii?Q?/FLDryE4T++myUAnyKDXKH00o3FlsHM/pZDZDgX/77kgQUOvi8iqboBomu8W?=
 =?us-ascii?Q?C/0QpW3oQsc5guU/HCHI+o+6IVrnI2z1VJLmqAA4+qPSL75OT2pYCW7swZEu?=
 =?us-ascii?Q?kwkAs0SW5PoLOPYRcWXF6uNTMBcK49wAXw1X7xGubusvpOif?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3054.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbb00fb-5930-4918-451b-08da34598841
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 20:53:56.8590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wKfuPrr2QpthuCVqgQrvEgP/+tmf+bJRmF1ht/iPrlHqcYwYsrqyPQn8JZWVop9s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2966
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
Cc: "mwen@igalia.com" <mwen@igalia.com>,
 "contact@emersion.fr" <contact@emersion.fr>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "markyacoub@chromium.org" <markyacoub@chromium.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Made a spelling mistake in the amd-gfx email, sending again.

-----Original Message-----
From: Kim, Sung joon <Sungjoon.Kim@amd.com>
Sent: Thursday, May 12, 2022 4:48 PM
To: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Deucher, Alexande=
r <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: amd-gfx@lists.freekdesktop.org; mwen@igalia.com; contact@emersion.fr; m=
arkyacoub@chromium.org; Kim, Sung joon <Sungjoon.Kim@amd.com>
Subject: [PATCH] drm/amd/display: add Coverage blend mode for overlay plane

According to the KMS man page, there is a "Coverage" alpha blend mode that =
assumes the pixel color values have NOT been pre-multiplied and will be don=
e when the actual blending to the background color values happens.

Previously, this mode hasn't been enabled in our driver and it was assumed =
that all normal overlay planes are pre-multiplied by default.

When a 3rd party app is used to input a image in a specific format, e.g. PN=
G, as a source of a overlay plane to blend with the background primary plan=
e, the pixel color values are not pre-multiplied. So by adding "Coverage" b=
lend mode, our driver will support those cases.

Reference:
https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#plane-composition-pro=
perties

Signed-off-by: Sung Joon Kim <Sungjoon.Kim@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 ++++++++++++-----
 drivers/gpu/drm/amd/display/dc/dc.h             |  2 ++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c  | 15 +++++++++------
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2ea20dd7fccf..48a179182d22 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5380,17 +5380,19 @@ fill_plane_buffer_attributes(struct amdgpu_device *=
adev,

 static void
 fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
-                              bool *per_pixel_alpha, bool *global_alpha,
-                              int *global_alpha_value)
+                              bool *per_pixel_alpha, bool *alpha_not_pre_m=
ultiplied,
+                              bool *global_alpha, int *global_alpha_value)
 {
        *per_pixel_alpha =3D false;
+       *alpha_not_pre_multiplied =3D false;
        *global_alpha =3D false;
        *global_alpha_value =3D 0xff;

        if (plane_state->plane->type !=3D DRM_PLANE_TYPE_OVERLAY)
                return;

-       if (plane_state->pixel_blend_mode =3D=3D DRM_MODE_BLEND_PREMULTI) {
+       if (plane_state->pixel_blend_mode =3D=3D DRM_MODE_BLEND_PREMULTI ||
+               plane_state->pixel_blend_mode =3D=3D DRM_MODE_BLEND_COVERAG=
E) {
                static const uint32_t alpha_formats[] =3D {
                        DRM_FORMAT_ARGB8888,
                        DRM_FORMAT_RGBA8888,
@@ -5405,6 +5407,9 @@ fill_blending_from_plane_state(const struct drm_plane=
_state *plane_state,
                                break;
                        }
                }
+
+               if (per_pixel_alpha && plane_state->pixel_blend_mode =3D=3D=
 DRM_MODE_BLEND_COVERAGE)
+                       *alpha_not_pre_multiplied =3D true;
        }

        if (plane_state->alpha < 0xffff) {
@@ -5567,7 +5572,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *ade=
v,
                return ret;

        fill_blending_from_plane_state(
-               plane_state, &plane_info->per_pixel_alpha,
+               plane_state, &plane_info->per_pixel_alpha,
+&plane_info->alpha_not_pre_multiplied,
                &plane_info->global_alpha, &plane_info->global_alpha_value)=
;

        return 0;
@@ -5614,6 +5619,7 @@ static int fill_dc_plane_attributes(struct amdgpu_dev=
ice *adev,
        dc_plane_state->tiling_info =3D plane_info.tiling_info;
        dc_plane_state->visible =3D plane_info.visible;
        dc_plane_state->per_pixel_alpha =3D plane_info.per_pixel_alpha;
+       dc_plane_state->alpha_not_pre_multiplied =3D
+plane_info.alpha_not_pre_multiplied;
        dc_plane_state->global_alpha =3D plane_info.global_alpha;
        dc_plane_state->global_alpha_value =3D plane_info.global_alpha_valu=
e;
        dc_plane_state->dcc =3D plane_info.dcc;
@@ -7905,7 +7911,8 @@ static int amdgpu_dm_plane_init(struct amdgpu_display=
_manager *dm,
        if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY &&
            plane_cap && plane_cap->per_pixel_alpha) {
                unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE) =
|
-                                         BIT(DRM_MODE_BLEND_PREMULTI);
+                                         BIT(DRM_MODE_BLEND_PREMULTI) |
+                                         BIT(DRM_MODE_BLEND_COVERAGE);

                drm_plane_create_alpha_property(plane);
                drm_plane_create_blend_mode_property(plane, blend_caps); di=
ff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/displa=
y/dc/dc.h
index 26c24db8f1da..714047d0c4f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1011,6 +1011,7 @@ struct dc_plane_state {

        bool is_tiling_rotated;
        bool per_pixel_alpha;
+       bool alpha_not_pre_multiplied;
        bool global_alpha;
        int  global_alpha_value;
        bool visible;
@@ -1045,6 +1046,7 @@ struct dc_plane_info {
        bool horizontal_mirror;
        bool visible;
        bool per_pixel_alpha;
+       bool alpha_not_pre_multiplied;
        bool global_alpha;
        int  global_alpha_value;
        bool input_csc_enabled;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/g=
pu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index e1f87bd72e4a..e541fe85c455 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2346,12 +2346,15 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_c=
tx *pipe_ctx)
        blnd_cfg.overlap_only =3D false;
        blnd_cfg.global_gain =3D 0xff;

-       if (per_pixel_alpha && pipe_ctx->plane_state->global_alpha) {
-               blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALP=
HA_COMBINED_GLOBAL_GAIN;
-               blnd_cfg.global_gain =3D pipe_ctx->plane_state->global_alph=
a_value;
-       } else if (per_pixel_alpha) {
-               blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALP=
HA;
+       if (per_pixel_alpha) {
+               blnd_cfg.pre_multiplied_alpha =3D pipe_ctx->plane_state->al=
pha_not_pre_multiplied ? false : true;
+               if (pipe_ctx->plane_state->global_alpha) {
+                       blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_P=
IXEL_ALPHA_COMBINED_GLOBAL_GAIN;
+                       blnd_cfg.global_gain =3D pipe_ctx->plane_state->glo=
bal_alpha_value;
+               } else
+                       blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_P=
IXEL_ALPHA;
        } else {
+               blnd_cfg.pre_multiplied_alpha =3D false;
                blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_GLOBAL_ALPHA;
        }

@@ -2365,7 +2368,7 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx=
 *pipe_ctx)
        blnd_cfg.top_gain =3D 0x1f000;
        blnd_cfg.bottom_inside_gain =3D 0x1f000;
        blnd_cfg.bottom_outside_gain =3D 0x1f000;
-       blnd_cfg.pre_multiplied_alpha =3D per_pixel_alpha;
+
        if (pipe_ctx->plane_state->format
                        =3D=3D SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA)
                blnd_cfg.pre_multiplied_alpha =3D false;
--
2.20.1

