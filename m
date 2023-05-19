Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA02C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 11:17:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D921110E5EF;
	Fri, 19 May 2023 11:17:07 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38B5410E5EF
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 11:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlY+8eI9daJbBldNtmjGvkBuKFJmYh+T21L7xwvBLm35qpSv3srOI69Ccfh0GaXQmB7TSR2zsX4ByksD1tCbFNEVmdUDdvR5d1mkBfxQulR0lZlHbjVNBc30f4HEG5sfGFe4GGimwJHG3xbF42T0K60qp4l1K3tW+1BG8by3/TZQBlQ1CSGw9G2V22Pj3hgkc9I0eOXj7HqiYtnl3o/f6nIFCDLgoLeCcVmUcv7852vIWFVppcdQ/nbNd53tUqcA3eMWUbHUik1PPFauNsCeoaN7+aliILWR4GlMf4pkA26/a/xRFFABhkV12y4vavQvIY7RlvOVxvAgee3VzNhaSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+au/81dYLPafdeRpNGIvWWZUUOOGG/z3w3AWztpLwY=;
 b=S4MYIO6y+g3VSzgTnRWX6pCn7v6LcgjBPp8X8WPFM5yKohe2pPnzSiBz5RC7iEMrod6KOCIXiR2a2KOBuhmR3XidiaAPAfpgjLIBAAbrbvrWir/l5JDrFZW/My21WfOm3cZVEsszNOQkQcp5eVDwQ5a3z9cpDmS3QPVSU2hi7AkcOoPoejrZ3Rkerc4JwEOrktaXlbkLTfM006hGBK8S7oc+6AvybpyOmQNo7zlWBPztagIxk1onEv1bPOmGw3nxt2ZqAAokoMdiIZ0AWXjvZft4jBaZ5LETHAsSN+8yBEBycF9cadmnYfjBDOJAeSUrXTcBwQaSCpOQX28oZDLGOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+au/81dYLPafdeRpNGIvWWZUUOOGG/z3w3AWztpLwY=;
 b=2a270RzpzH00lpjvGwLa2Fec385Av+LytWJn8dKF8K0ChrtAxVIRFph0hBg1mhePCdYpHv5hxnGSvwAb4T6XjgR2W5OIj+bS5VOyVyCuX2rU9zDiV9J8jpy8NiTaMidl5MMMDAFuh/59V9QGnE5mgoWOBL6iFtqNST0/Rz7jbiY=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 11:17:03 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::2eea:1d6d:9e75:8cea]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::2eea:1d6d:9e75:8cea%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 11:17:03 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: retire set_vga_state for some ASIC
Thread-Topic: [PATCH 2/2] drm/amdgpu: retire set_vga_state for some ASIC
Thread-Index: AQHZikLKR9XkJPDL7km6pDo4fnDa1a9hchtw
Date: Fri, 19 May 2023 11:17:03 +0000
Message-ID: <DM4PR12MB5181D8C765B9AAFBEBFE86C6EF7C9@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20230519111158.1354372-1-likun.gao@amd.com>
 <20230519111158.1354372-2-likun.gao@amd.com>
In-Reply-To: <20230519111158.1354372-2-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8e47d1a7-ab69-40ed-911e-c9963da38f9b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-19T11:16:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|DS0PR12MB8342:EE_
x-ms-office365-filtering-correlation-id: f69da186-f2b9-4b96-fa9e-08db585a92ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bC7kAX4+0ENvFIdK7D0cqJYmSPbu3mQAeMJllWwGPrSHn8JUdTOBbDDr25Zu1LYwpfjNYhwZoGPNHT1KejYtZdDDvlEm5hNAWMF7VI64JOjiGR4MYhXxQCUWO7C0OxkFhU5v3fafbN0aER2x7UhFg1IdFq74hB4pCr1F7/eBDIoued1u3wZsTWk/szgvlvSYFyz3DaOCqSP32ugrkPOFv+Xb8KWPS1vhFWnFG8NFJb3OM59GqtS6Cf3qJOer9oI5HZheFZFLoHmRRVdOv/vMVkTIqSse0hdJBnC0Y1HrFufmqDpBbXIlQ7jP2MFYEPWJy69hCslepdMusyvljo/dqjfj1kkKJo3yhj+rboI511Y7/Frotxm+qd5MmG9yTo/0k1tJAkUstaAA6iDcNsaIhYzSa9ar14PPbrOlRYw42SPHkqb/0FQnBzf/OoSHGj4HPjLxeXLbNyUcMUCuY415CAIWgtjrxSiG5hf7vaZ/xf/wDGKyCjAFQdmqSZluoYz+sS8Z70KeJg3KyH8XIPTGkXAeOBisBwXnZER/jQhIW+9C3nnMTgbIqYwVMaxj2VLYDg+jujAZJX/5In6lPnXmQ+1b/MqMVEJJLN1ArGJEDts=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(55016003)(66476007)(4326008)(66946007)(6916009)(66446008)(76116006)(8936002)(8676002)(478600001)(5660300002)(52536014)(64756008)(41300700001)(316002)(122000001)(38100700002)(83380400001)(7696005)(71200400001)(186003)(66556008)(26005)(6506007)(9686003)(86362001)(33656002)(2906002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XlnKYVlADFA4/CDi06RRSbh51skBG0+rbAVUh2/ElhE8+Ij8CRRa/KuCznGk?=
 =?us-ascii?Q?OiqKHMtqU8ENypHrSiO7qsksj9UEYlOJZ79OkWZrgw1DGMUu17rMHYFcd+JX?=
 =?us-ascii?Q?Kn+GHUkZYim7WFNa3k1mmfq+IyPjVnY9DLHBicYwE7tY7oYmC3ho+UAlKMIR?=
 =?us-ascii?Q?KklZjqZjvnw3ZsoG4Yuw0PUFcvcixf3XhOJC7tDev2uRgkJAxs9+YGbnPdf6?=
 =?us-ascii?Q?libR7RVIWaDgcarZVNHETOTtnqU8YibA4iCKjkyGl6Gh0p4754ST4Kne/1qa?=
 =?us-ascii?Q?dBMvWOXCTxbC7EiOhoLgbMi1XPZyZf0SEkCxrfVxSwQ5rWNLtfS0jZps2EH5?=
 =?us-ascii?Q?zqtM5yRCHVp6UR6GQMru5wVr6wqHTdARLPBH6FUJtbLN51Sle3C0GX0sLVHm?=
 =?us-ascii?Q?cSyaixCQHBS4z2f+hkm+AXHGLmvhPg0ZO7+qSNYwP6jx2CmICfHoNdYwur2+?=
 =?us-ascii?Q?RT5lzBo+LacK68BTb5E83ugFjsBjk9IlgflC4bQkhzwajvRA08obPQnMrw31?=
 =?us-ascii?Q?f6M/ZWe3HaROv7ydI1ccqZxPMlC7WZnuscb49/g/kJFt364ZPnV9ElE7v87E?=
 =?us-ascii?Q?SyIq9l8Q6tFLDq3oO+3KowAuoPdSeqR5yXBb+PEQaYCQ74xj+4lLTkCi29Va?=
 =?us-ascii?Q?EDM2PSDwAVVTBcmR+4Zesk4CxuUEy16Df4RJ1ABZ71XKZImIHMoJIZmTdx/8?=
 =?us-ascii?Q?Wa9/BqGpOxOQRvBzd6pRan9aXG5GEgW7ZKJ6sEJjNaZ9OHFUoV5yq6BTYZgk?=
 =?us-ascii?Q?+gDsTXM2F+z75nvn/EAHixNqqyCBH22NsE2QPO6oovp/0cY1cA3eiUsluiqz?=
 =?us-ascii?Q?kakqdw3//g09vAXxH7+lEu4IW800XdGHyaXWd410LBeYd/AvgZ5g/Vv6SEEN?=
 =?us-ascii?Q?xNAoWbEp/qAcc/PH64GPvLjTM3iRx9UOOgw3WiM7LuA1s2dOFUVF94UZv+3N?=
 =?us-ascii?Q?WeJFjs0IZFTFOAsUh3Jtogq0Z8WpGaRaJrvj2kSqMmqzzrKpefST3jsVTHzz?=
 =?us-ascii?Q?7JDRQMuBJhjTyvyxJV4mgShK3+pg8xcBlYLTxKYO8JidqJcWGO4e8JPze10v?=
 =?us-ascii?Q?/1P+fll0QA+KZyfA67Uwbv+BSMYAb54xHEk9FOcHd3LfkNH8r6nPYcEBhp61?=
 =?us-ascii?Q?snbcKQpsU69KfibsdOHktzmxtHmAHicvUIs5Uq5D4INLTv7LK0rf5U5knwjM?=
 =?us-ascii?Q?TLo0b/H2ShcUL0DEQRqqXQTL4B5b6VB1B5Lt7DFoYKEup9yrDWG6A5Pso8ix?=
 =?us-ascii?Q?XYSnPnbrzRWXSI8JDBQB1rjSbb4AUL3TLVFEiBUbUj6WqJQkTAvnLHtkW20b?=
 =?us-ascii?Q?/B4hANnGH92qyhSVtM8ra6uEP3rAh78UdJI8kf8oPHunjPCmdj/9oiW+b4ik?=
 =?us-ascii?Q?alKdvxdp7fpUjA+w6ryBO26qCrnbS4GLIP4ucI+SAid6sXOBtNjViRUF5Nx9?=
 =?us-ascii?Q?ALIMdxxpF020LOQiFRosy7p6bLn6jFcyV3A8TET+8yULIyYsrJRhcOH7dr+B?=
 =?us-ascii?Q?mOM2wcrUb/feiYCnk9sARwHnja6hf5cuqZUQD8rZqJshJ29WwHjVrJLo37/X?=
 =?us-ascii?Q?to7XVjtp8mizCNLQKBM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69da186-f2b9-4b96-fa9e-08db585a92ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 11:17:03.7908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7NskPD4ZVUkZdSSDn2t8EVdlBMpAT6I/Zr2qRkwANvP6o+BELD24uWhmxChYMYyw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

From: Likun Gao <Likun.Gao@amd.com>

set_vga_state operation only allowed on SI generation ASIC, retire the real=
ted function on those ASIC which did not do anything.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c    | 6 ------
 drivers/gpu/drm/amd/amdgpu/soc15.c | 8 --------  drivers/gpu/drm/amd/amdgp=
u/soc21.c | 6 ------
 drivers/gpu/drm/amd/amdgpu/vi.c    | 6 ------
 4 files changed, 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index a5f76c9538c4..51523b27a186 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -341,11 +341,6 @@ void nv_grbm_select(struct amdgpu_device *adev,
        WREG32_SOC15(GC, 0, mmGRBM_GFX_CNTL, grbm_gfx_cntl);  }

-static void nv_vga_set_state(struct amdgpu_device *adev, bool state) -{
-       /* todo */
-}
-
 static bool nv_read_disabled_bios(struct amdgpu_device *adev)  {
        /* todo */
@@ -654,7 +649,6 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =3D
        .read_register =3D &nv_read_register,
        .reset =3D &nv_asic_reset,
        .reset_method =3D &nv_asic_reset_method,
-       .set_vga_state =3D &nv_vga_set_state,
        .get_xclk =3D &nv_get_xclk,
        .set_uvd_clocks =3D &nv_set_uvd_clocks,
        .set_vce_clocks =3D &nv_set_vce_clocks,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 122ba1a505c3..135440b5afe9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -346,11 +346,6 @@ void soc15_grbm_select(struct amdgpu_device *adev,
        WREG32_SOC15_RLC_SHADOW(GC, xcc_id, mmGRBM_GFX_CNTL, grbm_gfx_cntl)=
;  }

-static void soc15_vga_set_state(struct amdgpu_device *adev, bool state) -{
-       /* todo */
-}
-
 static bool soc15_read_disabled_bios(struct amdgpu_device *adev)  {
        /* todo */
@@ -849,7 +844,6 @@ static const struct amdgpu_asic_funcs soc15_asic_funcs =
=3D
        .read_register =3D &soc15_read_register,
        .reset =3D &soc15_asic_reset,
        .reset_method =3D &soc15_asic_reset_method,
-       .set_vga_state =3D &soc15_vga_set_state,
        .get_xclk =3D &soc15_get_xclk,
        .set_uvd_clocks =3D &soc15_set_uvd_clocks,
        .set_vce_clocks =3D &soc15_set_vce_clocks, @@ -871,7 +865,6 @@ stat=
ic const struct amdgpu_asic_funcs vega20_asic_funcs =3D
        .read_register =3D &soc15_read_register,
        .reset =3D &soc15_asic_reset,
        .reset_method =3D &soc15_asic_reset_method,
-       .set_vga_state =3D &soc15_vga_set_state,
        .get_xclk =3D &soc15_get_xclk,
        .set_uvd_clocks =3D &soc15_set_uvd_clocks,
        .set_vce_clocks =3D &soc15_set_vce_clocks, @@ -893,7 +886,6 @@ stat=
ic const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =3D
        .read_register =3D &soc15_read_register,
        .reset =3D &soc15_asic_reset,
        .reset_method =3D &soc15_asic_reset_method,
-       .set_vga_state =3D &soc15_vga_set_state,
        .get_xclk =3D &soc15_get_xclk,
        .set_uvd_clocks =3D &soc15_set_uvd_clocks,
        .set_vce_clocks =3D &soc15_set_vce_clocks, diff --git a/drivers/gpu=
/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 6bff936a6e55..e5e5d68a4d70 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -248,11 +248,6 @@ void soc21_grbm_select(struct amdgpu_device *adev,
        WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, grbm_gfx_cntl);  }

-static void soc21_vga_set_state(struct amdgpu_device *adev, bool state) -{
-       /* todo */
-}
-
 static bool soc21_read_disabled_bios(struct amdgpu_device *adev)  {
        /* todo */
@@ -559,7 +554,6 @@ static const struct amdgpu_asic_funcs soc21_asic_funcs =
=3D
        .read_register =3D &soc21_read_register,
        .reset =3D &soc21_asic_reset,
        .reset_method =3D &soc21_asic_reset_method,
-       .set_vga_state =3D &soc21_vga_set_state,
        .get_xclk =3D &soc21_get_xclk,
        .set_uvd_clocks =3D &soc21_set_uvd_clocks,
        .set_vce_clocks =3D &soc21_set_vce_clocks, diff --git a/drivers/gpu=
/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c index 8e70581960fb..=
770f2d7a371f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -580,11 +580,6 @@ void vi_srbm_select(struct amdgpu_device *adev,
        WREG32(mmSRBM_GFX_CNTL, srbm_gfx_cntl);  }

-static void vi_vga_set_state(struct amdgpu_device *adev, bool state) -{
-       /* todo */
-}
-
 static bool vi_read_disabled_bios(struct amdgpu_device *adev)  {
        u32 bus_cntl;
@@ -1435,7 +1430,6 @@ static const struct amdgpu_asic_funcs vi_asic_funcs =
=3D
        .read_register =3D &vi_read_register,
        .reset =3D &vi_asic_reset,
        .reset_method =3D &vi_asic_reset_method,
-       .set_vga_state =3D &vi_vga_set_state,
        .get_xclk =3D &vi_get_xclk,
        .set_uvd_clocks =3D &vi_set_uvd_clocks,
        .set_vce_clocks =3D &vi_set_vce_clocks,
--
2.34.1

