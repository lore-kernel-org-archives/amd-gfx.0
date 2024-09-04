Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3621CD37BD
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 02:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E3810E495;
	Wed,  4 Sep 2024 02:10:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mFz3TDo+";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E8C10E443
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 02:10:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8iAH4uhKhPt899eOckdtE7RkmY4psBPDsjJaD+btUzx6VoM74YY2tDR+8zblpNGoCiY6QPnZb5uT2zdUiAyQn4dHKML35y7NmB6sfcZ03a/8pYdhb/DgjzViILlbGP0Y7KpEgTI8WatZmvlmR6mvV8W1+vHqP5PyNem0/FJiCce1BC4O7Nj6fLruw/UV9QHSTaV9NW/tqFvieSX/uhOR1TCiCdL1+P+hI6yTldr9cOw0lpN57rABrEGBFWsGodab9ZCK76vWz/htCsGmEQvV8oOEsUPKay4cAEdkgXVuZA+Wxh2ayoQhfVSYuX08H/7ixOximL5fmv3r3r5/CRUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9zMuuaybUyo9kcMzr4021Sc5s+n/Va+z4+d9PPj46M=;
 b=E9ZFrr2Ink0a8qt2uyjUXjz36tcvK3g10wsn1Q35bO+cyUi1F53EqTnXOIjsJI/YUD9A/HLgIynJwSv+lHIa2R+QHIBnurJRJ0CqGCQQdoKO/EMShHa57UM8SQ/dz69g70Ew9woXosiOiXdtkG2S7MiEdaM8wWUM242N/xIkKIe9nMkeihX6qRZOInBJA/XK7Zv4jkUAeM/GR6aHTRYNCm8oHnRejhYTi7hlhqGAGc2FRz9GEYR44WdW//qmn1l/iveHSGrFL4m4lothqBWsnd5+mSzfrllnkEgvHW6k3zwgoBWlK3wARkAvu54Lo6tsNEoy8W35PM3YuB7mn1WVzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9zMuuaybUyo9kcMzr4021Sc5s+n/Va+z4+d9PPj46M=;
 b=mFz3TDo+oiSipZSlNEOB5rE9GTdQkg3T20w5rC+WM6Bey+YKdNWLWKEjaiCwdJ4+VDKgAkhCJbIqy8/2Sq8M55UNZ9ESinCh90Z2oigiZ/lcEfEHoSZDoShDCgQ61q38Tm0qujUJjfrw2mqi2zGwrocBolRFBT3UA5yIVNUaUXM=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 02:10:31 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8%7]) with mapi id 15.20.7918.019; Wed, 4 Sep 2024
 02:10:31 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 02/10] drm/amdgpu: Use init level for pending_reset flag
Thread-Topic: [PATCH 02/10] drm/amdgpu: Use init level for pending_reset flag
Thread-Index: AQHa/QqXBlQQVQ5DpkaBnU+eIDq2/bJG4Z1A
Date: Wed, 4 Sep 2024 02:10:30 +0000
Message-ID: <CH2PR12MB415202E9D7D3317796D93560FE9C2@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
 <20240902073417.2025971-3-lijo.lazar@amd.com>
In-Reply-To: <20240902073417.2025971-3-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b1f1c0cb-fd27-45f2-80fb-b161560ce219;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-04T01:57:51Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|MN2PR12MB4456:EE_
x-ms-office365-filtering-correlation-id: 34aa2800-4665-48b1-aee1-08dccc86c0c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?83DFyZWTj44QR2dBqZ5oZ6CRKyy4cgHmWy163EiBL88EwecW/lWiX/2c+QFt?=
 =?us-ascii?Q?7c9M1TLeSfDKKGWFSlDr40lXyUahGpdDqLcuIpk1L7mH62XJnl+MHp7HZl33?=
 =?us-ascii?Q?PYP9xmWQEOcC7zak+Mt16XMES5mo7ari88I4m65IvH/EcSjiNnzs3/Zg+vqb?=
 =?us-ascii?Q?wMnsnXxKalMM9lkLjsEalSDR5JTEc/I45OD8UwMXTLil8ibOtSIWFrZRvw3W?=
 =?us-ascii?Q?UEB4E0TyyAAn/D63pz5DocE0hLZSEGvmu3tGhy6h8G7giokMmGVW4AqzNW/c?=
 =?us-ascii?Q?cUIcQTBpOnd4rSZ8uSEnho2MVU6kJ2LgLoHo4c0XFEx6TjnKz41rR+MD4C4+?=
 =?us-ascii?Q?Z3kR07OJ905U+zuI1MXQkGANxniQhpPoir3COCaNUfZKvDaR1q786s7cpFaa?=
 =?us-ascii?Q?EjUOd1sItq2r+aPWI4GEDnOXKgFfw7Yyc7kI8rc+OythTdh0QyqJYmzMBZmZ?=
 =?us-ascii?Q?8cICsbOuaOJtHgSoVguJJ+VKqCfpBlgeqPXAFaDDsiOFz/0nBs3FlGr2+3PG?=
 =?us-ascii?Q?f0XM0oBT13zj4AWsyTYbIIoT/iODpuW1OXFaEWu/e3YT3KxiTri+8+TwNYz4?=
 =?us-ascii?Q?L/wmHb9FBAA2Yg16Z5EAtQdf+Td3g5Teco7EE8IaMd2iJawRrc833Bgp0S/s?=
 =?us-ascii?Q?co/2xpV+5TIrMIDGhDNx3W7LrslSVbl68coY9SlHhQnS1rJQUJeHY9UMpI3W?=
 =?us-ascii?Q?K5H0l5pHyhQ5ZQ4NnFQMDxzd21CVWdJQbW2g/efc42WV1efCVG/R/CSfLhtT?=
 =?us-ascii?Q?E38JFxhkg6pc2sVRML/9oT+We9gZwS/yPX11KonFClzAByQ5mOSEKR+4syRa?=
 =?us-ascii?Q?RjNdnevcm9krX4IrgAxcdAEsISx8IM/5Zw8WjTKtsxNBtygZ90tXYHDEAwoT?=
 =?us-ascii?Q?PhZiC+aZl9dz5PKTklNLo6yYIRiOdNGd+MzC94HRL/1UMA9887oQrQ3mbfFg?=
 =?us-ascii?Q?BxyKOiW7Wm3YZqA/CnQWiD8IS/FM8lFAU22Hv9HdANGDvOKReLe15ciL88AO?=
 =?us-ascii?Q?ncMfgNz+irp/UYWnh8/lo2EdMqyT774iCdZsjMut1ozCSW5CWydgj/LlNKY3?=
 =?us-ascii?Q?8To2YKf7iBflF1EDTM1LKRuMkQ67x4nXIT0T397U1kJdRPg8sIHp7/Vsr0Rg?=
 =?us-ascii?Q?25zyHE1Hlgb1nX1QoTYKdsMNHC+MW6kE0M4r1CLB5yRtxVZsTJAU1g3jcFy2?=
 =?us-ascii?Q?PTE9kaouNwNWYsldbYLVP2BnygB3nkEhSQBqRVoIfHj713vqTjf1n6Lyzujf?=
 =?us-ascii?Q?HFZb65iAbwfumTVJRUJA2EaOHxt3L5NriZwkd57k0PYW1QOZxnYfYYeYj0HA?=
 =?us-ascii?Q?1rZZKgWPGOqMRH1PERKdCrO+Hu3P21CW+G+vmHFWCcwMd3BeTq2v/tPEAUYs?=
 =?us-ascii?Q?ULkoMTYqCaVwGWuz2z6x6dtstVT7WEsSZLD4sP/AbRp9GkmM8w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JaJkMV5gyBmwl8tXJpPlaDHGovmXFknOi5w2FtmJ4bLGz4SRHo6jgNgE7b6s?=
 =?us-ascii?Q?ozTsEljn5+7LWOtLkf6m4Soq/7N8mpFrM61XGsh5TjkOvLZRuipgxEGtBJ40?=
 =?us-ascii?Q?Mh1NGZ4WMh53hvdpyVCV8tBgraScmDINENmQwTfiRovOyMunQzFgqs+gCR4L?=
 =?us-ascii?Q?9S1LeB57ff2S5/bk4yx7bkrBZD2Z8TmLgDFx4fxyzHdCX1DBPVlAJn7szxI7?=
 =?us-ascii?Q?8ScnCyYXKS2kOwoXzuOK5iXxzItYbVndLqNvo/AYJIt8AKol2COC7mZeQRru?=
 =?us-ascii?Q?oJ+M4L/mr1Vs8kx86x0SI8keoz5X2LFhnxSumG3LQvgOP4ij057J8d5zinrn?=
 =?us-ascii?Q?UUPD9A9pim0vulisOeSOBFrTQS7IjjTn+6ksw2u20bPjbBny1aO+FqgTDmAv?=
 =?us-ascii?Q?7KTh4I5fX+h25E5Zsl/Wo/KpNuFH9GYb/5DkLjWSDzhKbTAnBBUpl8nm/J3G?=
 =?us-ascii?Q?uKxXidL1cbW/RbaOMOev5wqz/O9Q37x2GA4cYn1juHF3ye/Iu1HNFpZHdSxC?=
 =?us-ascii?Q?hhvXqoKiagpUR+Yax2Vsvny1CQEdXii92yi4aFAelsxmQrQR26paH6Yd6hq6?=
 =?us-ascii?Q?NFd6Pf87eQUiyvXwu0wQmah3iuKM48lDKJBKaVACiCTWmEZJKnoHKPizn3Rh?=
 =?us-ascii?Q?wekqYsEpJNi5zFs9/idWSy/Sqiql/1M8Ob68Q7794g5ZUHmXmIhdflDJ87K3?=
 =?us-ascii?Q?lT8JS/cJ7Rl3xvzcSmEMpNli/+qb1a3YAGRO2diC6uk9vpjOIoxkJGl3oXmV?=
 =?us-ascii?Q?TMbxBbeSTyqMARmsXxDNuX/b02HAyTytK9qYHmCKDTng6x1QCKh5HoSTkSQt?=
 =?us-ascii?Q?TCNzCTyokIYlkJ2tKcw/Qy6ubxsI5XOzMnlEhYPhGnyj8hO5UbmnQ9PygFhp?=
 =?us-ascii?Q?3RResWUX0LEDdG8XIthe/QTZ61kwerww6hiFpqNlk90yq5HLrA5mt6bxRJyq?=
 =?us-ascii?Q?16Wgrzv3n1ZWl2pCy1Kf7+UX4VALzWOVc/PAD8vTcmb+2DMQk3bYqyhNECEy?=
 =?us-ascii?Q?fRJu4N1qyMG2iSMeRT7shP9onGmbj4in5xQ2Xjxi0zX3noIUd2neGtW4m/j8?=
 =?us-ascii?Q?U6IVH1LERrJR4HbY/lyn37wFI/t7eyqHlxbzIl5chEc+5CCdVLOssLBe5sbv?=
 =?us-ascii?Q?YYepkhNLQamQT64Qy9E7UjpVHSyKEKvNHofoNhnbAsk3E6ZVkKa7W+WaT/pE?=
 =?us-ascii?Q?IWiyg0Y3zo1/CLiDwwfHROivRwt9BwgUExmX2L33mlgB/gEkF696YCOF6AI1?=
 =?us-ascii?Q?CgbBiXLUHm56TEHIqr5F7+bp03Fr2XfUi3959dXUsysyaJjR/2J/SjuhDSts?=
 =?us-ascii?Q?TGF3nKC2h2pedWPj9ngCLMdTBB6y6LBCLXxlXNw3XGQFx174slbNBgaDDxco?=
 =?us-ascii?Q?yCflaLgNtxJEAduYwAIwP5ua8Q1nwq9y7a+CT9drmG4vZYC7n+t78uKfQbfZ?=
 =?us-ascii?Q?e6pb91SBrZ4LCRAC86C+yMAdsJ9Cp3Mqm7XovOw59OvhMpgqAkFW7IyprX2N?=
 =?us-ascii?Q?bm3q2EgQulSXatXZs04fYO40wRYVxoWOhZZ19Moj97ly3l8X4GZM33cxmJwB?=
 =?us-ascii?Q?dSIJpEJxVIOYcQb4YR0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34aa2800-4665-48b1-aee1-08dccc86c0c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 02:10:31.1579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V3Spui7nry48x0B5Egwa1KWLQC3bD6Tm8UI6z2Wh2BuRw6tzDN1cRX3fj85M3zCa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
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

[AMD Official Use Only - AMD Internal Distribution Only]

Comment inline.

Thanks,
Feifei

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Monday, September 2, 2024 3:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: [PATCH 02/10] drm/amdgpu: Use init level for pending_reset flag

Drop pending_reset flag in gmc block. Instead use init level to determine w=
hich type of init is preferred - in this case MINIMAL.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 33 ++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  6 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  3 +-
 6 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 4fb09c4fbf22..db5046e8b10d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1691,7 +1691,7 @@ bool amdgpu_device_need_post(struct amdgpu_device *ad=
ev)
        }

        /* Don't post if we need to reset whole hive on init */
-       if (adev->gmc.xgmi.pending_reset)
+       if (adev->init_lvl->level =3D=3D AMDGPU_INIT_LEVEL_MINIMAL)
                return false;

        if (adev->has_hw_reset) {
@@ -2985,7 +2985,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device=
 *adev)
                amdgpu_ttm_set_buffer_funcs_status(adev, true);

        /* Don't init kfd if whole hive need to be reset during init */
-       if (!adev->gmc.xgmi.pending_reset) {
+       if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL) {
                kgd2kfd_init_zone_device(adev);
                amdgpu_amdkfd_device_init(adev);
        }
@@ -3499,14 +3499,9 @@ static int amdgpu_device_ip_suspend_phase2(struct am=
dgpu_device *adev)
                }

                /* skip unnecessary suspend if we do not initialize them ye=
t */
-               if (adev->gmc.xgmi.pending_reset &&
-                   !(adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_=
TYPE_GMC ||
-                     adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_=
TYPE_SMC ||
-                     adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_=
TYPE_COMMON ||
-                     adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_=
TYPE_IH)) {
-                       adev->ip_blocks[i].status.hw =3D false;
+               if (!amdgpu_ip_member_of_hwini(
+                           adev, adev->ip_blocks[i].version->type))
                        continue;
-               }

[Feifei]:  AMDGPU_INIT_LEVEL_MINIMAL indicate the minimal necessary blocks =
which need to do hw_init if SMC need to handle the mode1 reset. Though in n=
ewer ASICs it is smc doing the reset, in some old one, it is MP0.
               Is it more readable if we use naming like AMDGPU_INIT_LEVEL_=
MINIMAL_SMC to avoid confusion ?


                /* skip suspend of gfx/mes and psp for S0ix
                 * gfx is in gfxoff state, so on resume it will exit gfxoff=
 just @@ -4320,20 +4315,7 @@ int amdgpu_device_init(struct amdgpu_device *a=
dev,
        if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev))=
 {
                if (adev->gmc.xgmi.num_physical_nodes) {
                        dev_info(adev->dev, "Pending hive reset.\n");
-                       adev->gmc.xgmi.pending_reset =3D true;
-                       /* Only need to init necessary block for SMU to han=
dle the reset */
-                       for (i =3D 0; i < adev->num_ip_blocks; i++) {
-                               if (!adev->ip_blocks[i].status.valid)
-                                       continue;
-                               if (!(adev->ip_blocks[i].version->type =3D=
=3D AMD_IP_BLOCK_TYPE_GMC ||
-                                     adev->ip_blocks[i].version->type =3D=
=3D AMD_IP_BLOCK_TYPE_COMMON ||
-                                     adev->ip_blocks[i].version->type =3D=
=3D AMD_IP_BLOCK_TYPE_IH ||
-                                     adev->ip_blocks[i].version->type =3D=
=3D AMD_IP_BLOCK_TYPE_SMC)) {
-                                       DRM_DEBUG("IP %s disabled for hw_in=
it.\n",
-                                               adev->ip_blocks[i].version-=
>funcs->name);
-                                       adev->ip_blocks[i].status.hw =3D tr=
ue;
-                               }
-                       }
+                       amdgpu_set_init_level(adev, AMDGPU_INIT_LEVEL_MINIM=
AL);
                } else if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_V=
ERSION(13, 0, 10) &&
                                   !amdgpu_device_has_display_hardware(adev=
)) {
                                        r =3D psp_gpu_reset(adev);
@@ -4441,7 +4423,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        /* enable clockgating, etc. after ib tests, etc. since some blocks =
require
         * explicit gating rather than handling it automatically.
         */
-       if (!adev->gmc.xgmi.pending_reset) {
+       if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL) {
                r =3D amdgpu_device_ip_late_init(adev);
                if (r) {
                        dev_err(adev->dev, "amdgpu_device_ip_late_init fail=
ed\n"); @@ -4518,7 +4500,7 @@ int amdgpu_device_init(struct amdgpu_device *=
adev,
        if (px)
                vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_=
domain);

-       if (adev->gmc.xgmi.pending_reset)
+       if (adev->init_lvl->level =3D=3D AMDGPU_INIT_LEVEL_MINIMAL)
                queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work=
,
                                   msecs_to_jiffies(AMDGPU_RESUME_MS));

@@ -5490,7 +5472,6 @@ int amdgpu_do_asic_reset(struct list_head *device_lis=
t_handle,
                list_for_each_entry(tmp_adev, device_list_handle, reset_lis=
t) {
                        /* For XGMI run all resets in parallel to speed up =
the process */
                        if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-                               tmp_adev->gmc.xgmi.pending_reset =3D false;
                                if (!queue_work(system_unbound_wq, &tmp_ade=
v->xgmi_reset_work))
                                        r =3D -EALREADY;
                        } else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 82bde5132dc6..3dece2e69608 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2495,7 +2495,6 @@ static void amdgpu_drv_delayed_reset_work_handler(str=
uct work_struct *work)
        for (i =3D 0; i < mgpu_info.num_dgpu; i++) {
                adev =3D mgpu_info.gpu_ins[i].adev;
                flush_work(&adev->xgmi_reset_work);
-               adev->gmc.xgmi.pending_reset =3D false;
        }

        /* reset function will rebuild the xgmi hive info , clear it now */=
 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_gmc.h
index 4d951a1baefa..33b2adffd58b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -182,7 +182,6 @@ struct amdgpu_xgmi {
        bool supported;
        struct ras_common_if *ras_if;
        bool connected_to_cpu;
-       bool pending_reset;
        struct amdgpu_xgmi_ras *ras;
 };

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 61a2f386d9fb..2076f157cb6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3185,7 +3185,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *ad=
ev)
         * when the GPU is pending on XGMI reset during probe time
         * (Mostly after second bus reset), skip it now
         */
-       if (adev->gmc.xgmi.pending_reset)
+       if (adev->init_lvl->level =3D=3D AMDGPU_INIT_LEVEL_MINIMAL)
                return 0;
        ret =3D amdgpu_ras_eeprom_init(&con->eeprom_control);
        /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 7de449fae1e3..a7a892512cb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -860,7 +860,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
        if (!adev->gmc.xgmi.supported)
                return 0;

-       if (!adev->gmc.xgmi.pending_reset &&
+       if ((adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL) &&
            amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
                ret =3D psp_xgmi_initialize(&adev->psp, false, true);
                if (ret) {
@@ -907,7 +907,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)

        task_barrier_add_task(&hive->tb);

-       if (!adev->gmc.xgmi.pending_reset &&
+       if ((adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL) &&
            amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
                list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.=
head) {
                        /* update node list for other device in the hive */=
 @@ -985,7 +985,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
                }
        }

-       if (!ret && !adev->gmc.xgmi.pending_reset)
+       if (!ret && (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL))
                ret =3D amdgpu_xgmi_sysfs_add_dev_info(adev, hive);

 exit_unlock:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index 16fcd9dcd202..7225f63c26b4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1616,7 +1616,8 @@ int smu_v11_0_baco_set_state(struct smu_context *smu,=
 enum smu_baco_state state)
                        break;
                default:
                        if (!ras || !adev->ras_enabled ||
-                           adev->gmc.xgmi.pending_reset) {
+                           (adev->init_lvl->level !=3D
+                            AMDGPU_INIT_LEVEL_MINIMAL)) {


[Feifei] Is it a typo? If adev->init_lvl->level taking place of adev->gmc.x=
gmi.pending_reset, here should be(adev->init_lvl->level =3D=3D AMDGPU_INIT_=
LEVEL_MINIMAL)

                                if (amdgpu_ip_version(adev, MP1_HWIP, 0) =
=3D=3D
                                    IP_VERSION(11, 0, 2)) {
                                        data =3D RREG32_SOC15(THM, 0, mmTHM=
_BACO_CNTL_ARCT);
--
2.25.1

