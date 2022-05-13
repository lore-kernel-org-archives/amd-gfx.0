Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358C6C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 20:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B435110E8C8;
	Fri, 13 May 2022 20:23:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70F7B10E8C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 20:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIqHxDM3Z+lslk0lDTNokq4m4RdOnoER60zTGg+MDm6gmouFic/iXg/3+dVFVfaYAXgGVwmekvb+Za23O6XMh14GqvdR8pQmRNMBbecNFRsMI0p9p3LLOajognLFEYGec4hDzbTitJ3R/vJz2840YVizbsAANlTEd2u6thAdp4qEa0cnzcTboQBzwJIP2b8XHs7ZhPHiZ/UcULwNtx43G7U3Wtia6qDDDe24DcKocEy9XymSGOsXHREsvqJraa3EHJjhwXJa2xfg8ofA/TPEbmcvRkB9CkofORWDebcoD8tmXJvLRLXh9FgODF5Zw6dC5BzDNuQhDoK0Sl9+ik4f1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gLlkJN3kYScUhRJwvo4rJ990EEdU4FH9efEvnO9Jfc=;
 b=cldKBGvmAP7mIq5W4GAGz/AHqWrlx8tkSAVlWittDhLfit6fNXEMyYNUt6AGqnyhunwAgzRFERamn5aP1U4QQ7n0QCurNz76HlRM2iuVCaznkNCjOWhYrl6RIgDquhhLnoTDo2DIvAuSU3qeS1Ca3EPy+f3WFuZfEdjVycGxl8T+XirHggjbLkIIhsuRPYMcVigpNszfBnx8ZMA7NxGyKS2F/GL5V20LyL2H4LrgnCD1+Fthe+iH/3ap0uKaq8YDybUT03PvqHZLI/RlZi7H9aZu/YqU4UACLzbMP2qjMCAz7qD2ogWJH5KQhpYW6xdBvJCXpyU2eWe+IyXkA+yTyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gLlkJN3kYScUhRJwvo4rJ990EEdU4FH9efEvnO9Jfc=;
 b=DbXZz8fLMdGu/Q4muLIEEZj/Qwg79uNbL95HwUyQi2Y0XrcznMxJaZaA79zPCzyp3/AffuSl4PdVTqqzTBx8U8qU9DwEy3Ie2aAcv1zFD+rVj9Z8OR411lSnM1Ew5+pZmzToC8aUfbXLP1eIvvHkpyn0c93Fw5L7TIxbQCBbiWA=
Received: from MN2PR12MB3054.namprd12.prod.outlook.com (2603:10b6:208:d1::15)
 by BN6PR12MB1236.namprd12.prod.outlook.com (2603:10b6:404:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 20:23:51 +0000
Received: from MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::543a:9edd:6fea:5d0]) by MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::543a:9edd:6fea:5d0%3]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 20:23:51 +0000
From: "Kim, Sung joon" <Sungjoon.Kim@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amd/display: add Coverage blend mode for overlay
 plane
Thread-Topic: [PATCH v2] drm/amd/display: add Coverage blend mode for overlay
 plane
Thread-Index: AQHYZwc1GdfGh4+Az0ml2rVVOQ9AW60dQH4g
Date: Fri, 13 May 2022 20:23:51 +0000
Message-ID: <MN2PR12MB305401FF2DDC65CC4B1BCF1B97CA9@MN2PR12MB3054.namprd12.prod.outlook.com>
References: <20220513202200.4698-1-Sungjoon.Kim@amd.com>
In-Reply-To: <20220513202200.4698-1-Sungjoon.Kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-13T20:23:45Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=06df1c72-5819-44c8-a00f-7132ece69288;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-05-13T20:23:45Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 85ff7737-540a-4b9f-a6f2-8e6a97bf547b
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30c79dad-1401-4681-3094-08da351e7e69
x-ms-traffictypediagnostic: BN6PR12MB1236:EE_
x-microsoft-antispam-prvs: <BN6PR12MB12364093EB99B5DA82AD7D9097CA9@BN6PR12MB1236.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 92WXg5ux3RcA3DDMCX9My61m/FqeMIRAypiCzkdMkxp57Fbws5vIuDoTt7tpKoP5sHdxcoZKp5R6WJS8SInvx2oWE9FFl1SHfLqHvdecgNosKBXeo0dd6ws5J3AQBMatWmaH4C9HQMFywfKmRgTJmYkZCUNhP6MRJ8a29afeTlqXJ3TJc3re4wP1tCTaikq9CjYSHez3cLRyBynGW/RjQKUEcgxnr0/S/B5nnCQ7HQP0qCAKcZeRcmXhDdKGX/RDnPvxwVbivIaGlu02sh58FvbI4CnSenwYBfSr2KBJv7FUUubdOQV9vVa1ULWrlECtPcMYPWwgA+i2XK0P2Y/p7XgkD7z0EO3moMJpCsXdkGZqZs5G/oMFJBkIktU7Z5GZvQdYsjkf1lweGwQiLP7Srhb9/AhZoQFcVKWUAdsF7/+uK5ccHAcM/sHFfjXmQHs4RJVc5wFpawduFMYdiT+PZdmxjXEb1qqKcH1kd/CBeLQBmfn1bBpnkQjdG+pUmzmt5ag0pVCbeAoLeXsSBQ3gEDU3OvKrrk6ahF2+S86XEyK2PN0/QrDwlkwbzNZ7I9WGP4LsrHxgN8F+Di1rhMp6GE+b5AG7Zyg7jWyjT9fLA6QO/Yequit6jMvD1BZl76Z8etnPQEBwURa66gA8g9VaxmNuX8NZsRG2NGbNVdwk/gjfP6H+zC4eE1fOdXAOw9utLWql4Fve1XBPxm6OiDm3WwshiOGPEFAAzf8XVzgPDf0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3054.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(66446008)(9686003)(5660300002)(66556008)(76116006)(8676002)(66476007)(64756008)(66946007)(186003)(83380400001)(7696005)(2906002)(52536014)(6506007)(53546011)(8936002)(26005)(508600001)(55016003)(4326008)(966005)(71200400001)(921005)(6636002)(54906003)(122000001)(110136005)(316002)(38100700002)(38070700005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dKjpJJf2GNJerkvIALVzBiDRAnBD0RBDm/AMzj/THeIyjmG7tf52VTW7pYaj?=
 =?us-ascii?Q?kKXCeqKrFyCJ443Nm2ic7MmTLuyLLWEiUc7xPx/rZr0gLILYK62/FWodWSez?=
 =?us-ascii?Q?GPpbXaij17JLvVGN095z/g4Aitrzq7rpkX6gKJ4JWyciPAp32l5T2J/qaMJ4?=
 =?us-ascii?Q?58qC4qW6rNet7R770N2FojB2frmlZEzuNsbJ8MqWKIHCzgMIKkF73vd8nRtM?=
 =?us-ascii?Q?j6eyhuDwJNxm9cUS7hcSrqeZeb7ZYL5FFnYtFquEJXvd3aZmj0L9i/eQp7oH?=
 =?us-ascii?Q?yJMrckCmooUouSkD61fW/SmS1mOnfeyTAqS8/6IU+Fkx8IGZWX2SNpdOI8CV?=
 =?us-ascii?Q?YHRYk2ZvxnbrOgfYAAUXy9SJvm2cC2HBUU8npVsJkrBZ+lcJDoG8/wvJufJx?=
 =?us-ascii?Q?bmpQ4DkxjiUjh09MGDmBwyV3U/TckYWGCRaGBJJpDIZGV2mubPuJuLbnz/Aw?=
 =?us-ascii?Q?kmRGvIrJo9z3WXES3BTM3pQ27riAxaWzwxXiYTmjKe8BeHXvcO2iawH65h7Y?=
 =?us-ascii?Q?6aXEFVlbqj26vclk103SOAh0fpWn5dp/O7ZlsCoGJG0+/Q0tZJtVTE9nWnhy?=
 =?us-ascii?Q?2opHgPGHltfT6FVjY5AhE1qU8sfyx1Z4F0XsFiqMKjcdzCX7K+FulmThv1Bv?=
 =?us-ascii?Q?4E2qCx0r4oTOBP8+OTkNW0bfT9GchILRqaIcizcF+nJr1gW42iG2/azgfm8N?=
 =?us-ascii?Q?woODZiqdmGpjyAkq+Y+BpOn+x9OO45gOIwJ4cTF+IOnDxBvPsWm6ZZftSg9D?=
 =?us-ascii?Q?M8hao5pYnuzH4KX1goiG6A++PKNvJcJerp2MgXdVNEMs8u4FTJQe0VzaPxj9?=
 =?us-ascii?Q?RR3fJohTYOEvtI4Ka8HEkgXA0OAcQBzASyGSTYIx9qWcUsHXsjWjv+d5AJ0y?=
 =?us-ascii?Q?OkcvFB+JluSiPuti8TtpNYCyKfjyRoS+BmcUwR6Oj4smE5x7lnBPbKCGgcme?=
 =?us-ascii?Q?A8ciHmTiDwGUKPIymrCZsXZjVsX0endfMRQRvjMOlkH3AB82uhP3aNPnGanX?=
 =?us-ascii?Q?knjg1Q1nFP/egNhD1NIFNL4fD2jBOFzFSoh2DazBAVq9JWQKg2Bq95D0coUx?=
 =?us-ascii?Q?d5Cjvy724zdk8vyuZPU/aY5tqB2ETuz5sNDOQGRxAtpCyGdDWchljGMHXntx?=
 =?us-ascii?Q?QKddeJ1NLRKHyFZi3WutsoHbDNjqfPtBbw3+fWFf+JiwSftaN2nxHzj73Bnf?=
 =?us-ascii?Q?6P0v3UPI044nIGT286LRRC8LqT/vZP+QQk5afPbgugbwtQ3A4LCh8BA2wAE4?=
 =?us-ascii?Q?1KrnzmV90ESI6cMrppkLsumGkrHTOxpZMi+DyyN9Q8Vpi3SvB/DKmGl7pGLw?=
 =?us-ascii?Q?JQYVA/6rWLvCofkdkNH1ItuiCDs3pZTMrE5A7J+Jbdo2PG7AbOZ/w5NcGUYx?=
 =?us-ascii?Q?LoNUVp4R4u2yxjSEybMiVFba/7gCJE8UA6Y6PfjvfrDtUKQRtZLCG6qrDVp7?=
 =?us-ascii?Q?Hg0zjJuQa2PgNJf1NaLUpn3xdQDSkUUtBQAd5/3pzZHeNOXxe7KpXRdqiQ6A?=
 =?us-ascii?Q?n9ecc/PKwG+bB7Z+Apr2hQLCOHZeMiOGvzbvQMzjGkI6OEktgKTCpN3t2GZQ?=
 =?us-ascii?Q?Zri5ya6C0dCrESjxdBdG0Hlz9eP84sTDutFADS/g5BDJdcXOf+xQfgJoNdOj?=
 =?us-ascii?Q?xaRXn9XPx03rbPDMv5H5Om2Btj5/ewQ28ZyYyGW53F1Jc9fkhd4n1RV533MV?=
 =?us-ascii?Q?Feu6lBw/i9mu5bKURge04PX6IRT0xBmZAjqeT/AElBczQvBqMaG2kwia0Rh7?=
 =?us-ascii?Q?iqRIKNcVjw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3054.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c79dad-1401-4681-3094-08da351e7e69
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 20:23:51.2304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A+oCrinmomvTomRRNRhwHUXsSQgL/mQrFFkbfo1CvEPi9S32FBaJbYCbUEqNJvJ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1236
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



-----Original Message-----
From: Kim, Sung joon <Sungjoon.Kim@amd.com>=20
Sent: Friday, May 13, 2022 4:22 PM
To: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Deucher, Alexande=
r <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: amd-gfx@lists.freekdesktop.org; mwen@igalia.com; contact@emersion.fr; m=
arkyacoub@chromium.org; Kim, Sung joon <Sungjoon.Kim@amd.com>
Subject: [PATCH v2] drm/amd/display: add Coverage blend mode for overlay pl=
ane

Issue fixed: Overlay plane alpha channel blending is incorrect

Issue tracker: https://gitlab.freedesktop.org/drm/amd/-/issues/1769

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

Adding Coverage support also enables IGT kms_plane_alpha_blend Coverage sub=
tests:
1. coverage-7efc
2. coverage-vs-premult-vs-constant

Signed-off-by: Sung Joon Kim <Sungjoon.Kim@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 17 ++++++++----  .../gpu/d=
rm/amd/display/dc/core/dc_surface.c  |  2 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 27 ++++++++++---------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 16 ++++++-----
 5 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2ea20dd7fccf..af2b5d232742 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5380,17 +5380,19 @@ fill_plane_buffer_attributes(struct amdgpu_device *=
adev,
=20
 static void
 fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
-			       bool *per_pixel_alpha, bool *global_alpha,
-			       int *global_alpha_value)
+			       bool *per_pixel_alpha, bool *pre_multiplied_alpha,
+			       bool *global_alpha, int *global_alpha_value)
 {
 	*per_pixel_alpha =3D false;
+	*pre_multiplied_alpha =3D true;
 	*global_alpha =3D false;
 	*global_alpha_value =3D 0xff;
=20
 	if (plane_state->plane->type !=3D DRM_PLANE_TYPE_OVERLAY)
 		return;
=20
-	if (plane_state->pixel_blend_mode =3D=3D DRM_MODE_BLEND_PREMULTI) {
+	if (plane_state->pixel_blend_mode =3D=3D DRM_MODE_BLEND_PREMULTI ||
+		plane_state->pixel_blend_mode =3D=3D DRM_MODE_BLEND_COVERAGE) {
 		static const uint32_t alpha_formats[] =3D {
 			DRM_FORMAT_ARGB8888,
 			DRM_FORMAT_RGBA8888,
@@ -5405,6 +5407,9 @@ fill_blending_from_plane_state(const struct drm_plane=
_state *plane_state,
 				break;
 			}
 		}
+
+		if (per_pixel_alpha && plane_state->pixel_blend_mode =3D=3D DRM_MODE_BLE=
ND_COVERAGE)
+			*pre_multiplied_alpha =3D false;
 	}
=20
 	if (plane_state->alpha < 0xffff) {
@@ -5567,7 +5572,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *ade=
v,
 		return ret;
=20
 	fill_blending_from_plane_state(
-		plane_state, &plane_info->per_pixel_alpha,
+		plane_state, &plane_info->per_pixel_alpha,=20
+&plane_info->pre_multiplied_alpha,
 		&plane_info->global_alpha, &plane_info->global_alpha_value);
=20
 	return 0;
@@ -5614,6 +5619,7 @@ static int fill_dc_plane_attributes(struct amdgpu_dev=
ice *adev,
 	dc_plane_state->tiling_info =3D plane_info.tiling_info;
 	dc_plane_state->visible =3D plane_info.visible;
 	dc_plane_state->per_pixel_alpha =3D plane_info.per_pixel_alpha;
+	dc_plane_state->pre_multiplied_alpha =3D=20
+plane_info.pre_multiplied_alpha;
 	dc_plane_state->global_alpha =3D plane_info.global_alpha;
 	dc_plane_state->global_alpha_value =3D plane_info.global_alpha_value;
 	dc_plane_state->dcc =3D plane_info.dcc;
@@ -7905,7 +7911,8 @@ static int amdgpu_dm_plane_init(struct amdgpu_display=
_manager *dm,
 	if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY &&
 	    plane_cap && plane_cap->per_pixel_alpha) {
 		unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE) |
-					  BIT(DRM_MODE_BLEND_PREMULTI);
+					  BIT(DRM_MODE_BLEND_PREMULTI) |
+					  BIT(DRM_MODE_BLEND_COVERAGE);
=20
 		drm_plane_create_alpha_property(plane);
 		drm_plane_create_blend_mode_property(plane, blend_caps); diff --git a/dr=
ivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/displa=
y/dc/core/dc_surface.c
index e6b9c6a71841..5bc6ff2fa73e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -61,6 +61,8 @@ static void dc_plane_construct(struct dc_context *ctx, st=
ruct dc_plane_state *pl
 		plane_state->blend_tf->type =3D TF_TYPE_BYPASS;
 	}
=20
+	plane_state->pre_multiplied_alpha =3D true;
+
 }
=20
 static void dc_plane_destruct(struct dc_plane_state *plane_state) diff --g=
it a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/d=
c.h
index 26c24db8f1da..c353842d5c40 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1011,6 +1011,7 @@ struct dc_plane_state {
=20
 	bool is_tiling_rotated;
 	bool per_pixel_alpha;
+	bool pre_multiplied_alpha;
 	bool global_alpha;
 	int  global_alpha_value;
 	bool visible;
@@ -1045,6 +1046,7 @@ struct dc_plane_info {
 	bool horizontal_mirror;
 	bool visible;
 	bool per_pixel_alpha;
+	bool pre_multiplied_alpha;
 	bool global_alpha;
 	int  global_alpha_value;
 	bool input_csc_enabled;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/dr=
ivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index e02ac75afbf7..e3a62873c0e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2550,12 +2550,21 @@ void dcn10_update_mpcc(struct dc *dc, struct pipe_c=
tx *pipe_ctx)
 	blnd_cfg.overlap_only =3D false;
 	blnd_cfg.global_gain =3D 0xff;
=20
-	if (per_pixel_alpha && pipe_ctx->plane_state->global_alpha) {
-		blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA_COMBINED_G=
LOBAL_GAIN;
-		blnd_cfg.global_gain =3D pipe_ctx->plane_state->global_alpha_value;
-	} else if (per_pixel_alpha) {
-		blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
+	if (per_pixel_alpha) {
+		/* DCN1.0 has output CM before MPC which seems to screw with
+		 * pre-multiplied alpha.
+		 */
+		blnd_cfg.pre_multiplied_alpha =3D (is_rgb_cspace(
+				pipe_ctx->stream->output_color_space)
+						&& pipe_ctx->plane_state->pre_multiplied_alpha);
+		if (pipe_ctx->plane_state->global_alpha) {
+			blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA_COMBINED_=
GLOBAL_GAIN;
+			blnd_cfg.global_gain =3D pipe_ctx->plane_state->global_alpha_value;
+		} else {
+			blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
+		}
 	} else {
+		blnd_cfg.pre_multiplied_alpha =3D false;
 		blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_GLOBAL_ALPHA;
 	}
=20
@@ -2564,14 +2573,6 @@ void dcn10_update_mpcc(struct dc *dc, struct pipe_ct=
x *pipe_ctx)
 	else
 		blnd_cfg.global_alpha =3D 0xff;
=20
-	/* DCN1.0 has output CM before MPC which seems to screw with
-	 * pre-multiplied alpha.
-	 */
-	blnd_cfg.pre_multiplied_alpha =3D is_rgb_cspace(
-			pipe_ctx->stream->output_color_space)
-					&& per_pixel_alpha;
-
-
 	/*
 	 * TODO: remove hack
 	 * Note: currently there is a bug in init_hw such that diff --git a/drive=
rs/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display=
/dc/dcn20/dcn20_hwseq.c
index e1f87bd72e4a..c117830b8b9d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2346,12 +2346,16 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_c=
tx *pipe_ctx)
 	blnd_cfg.overlap_only =3D false;
 	blnd_cfg.global_gain =3D 0xff;
=20
-	if (per_pixel_alpha && pipe_ctx->plane_state->global_alpha) {
-		blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA_COMBINED_G=
LOBAL_GAIN;
-		blnd_cfg.global_gain =3D pipe_ctx->plane_state->global_alpha_value;
-	} else if (per_pixel_alpha) {
-		blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
+	if (per_pixel_alpha) {
+		blnd_cfg.pre_multiplied_alpha =3D pipe_ctx->plane_state->pre_multiplied_=
alpha;
+		if (pipe_ctx->plane_state->global_alpha) {
+			blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA_COMBINED_=
GLOBAL_GAIN;
+			blnd_cfg.global_gain =3D pipe_ctx->plane_state->global_alpha_value;
+		} else {
+			blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
+		}
 	} else {
+		blnd_cfg.pre_multiplied_alpha =3D false;
 		blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_GLOBAL_ALPHA;
 	}
=20
@@ -2365,7 +2369,7 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx=
 *pipe_ctx)
 	blnd_cfg.top_gain =3D 0x1f000;
 	blnd_cfg.bottom_inside_gain =3D 0x1f000;
 	blnd_cfg.bottom_outside_gain =3D 0x1f000;
-	blnd_cfg.pre_multiplied_alpha =3D per_pixel_alpha;
+=09
 	if (pipe_ctx->plane_state->format
 			=3D=3D SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA)
 		blnd_cfg.pre_multiplied_alpha =3D false;
--
2.20.1
