Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D82C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 11:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5741B10E5F8;
	Fri, 19 May 2023 11:41:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E568B10E5F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 11:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdMbrgvHIjxsJMnKcBilrft3JF61M15ySuwhoW7bRIpnRa830j9D5oxv9VWn/2y1qKfsOsQcuPDbibOdt9Km7LtNFMNX1AY8hJ+pXXTZoZTE0EUOcPrLmdkA1lirxSl0IosjJ67YzdT5aeVnjI6LQV4tRXK74MeLcv8PNEm4XUrRv5q8sX0Smlgprb22jmzILP3+LrQQdozJbRuBy5EdyrdZ9M1Mkz/dP0BXAJ942u5uMFlq2jv+xwV/dP3ljJplHaS+NLQLA9OmBmBlDLZIYo4Aab3raz5JWziuNZn4lFpq5/JJFuahvVb6Z7k0fbIC5Fa80Sm0v2vbpINQaDGzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Cjx1SvgzAVOrCrY7+8HSXjLp0cv6xQq8hymKCuThzI=;
 b=k4YFvLDB3wQNej0WqG1jDdPfr906KPgLMXppZbmCBRkNxLNxN7rC6OEgLSZWqj+dYBE1b783SmMso+PtdSG7YgxodtrXhRtTRozMj/3Yh1+LEN1AE5H6ZGJzXv1vCyhYAVFPKPiFoFOUel+UqCMtqljHuQvt4TrFA+tlpeEv4iybK/89u1JoGcftFjKZaeZLn3KruPFfAYgeZJKhAjXUUvXSF8f1UCOjDVGES3eGtcXQXn1IEMjfVEQT/4IdN9hjN/ZBLq5Arkzb6qzDEtQw+0NsRphQ4uXL1OLKKZDUlJpxafhnYKVeBn3OYfUv9R1rSwfxBxT7cB8DbiTyfc17sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Cjx1SvgzAVOrCrY7+8HSXjLp0cv6xQq8hymKCuThzI=;
 b=JxKZt86zx6rLCRosoZHumiARet92OegBWorYCnpX5IVm0tnvmCGaMr4+GBYl1C6BOGHwjHw6Gqs9qXNI+myJ2yjt42ndPdQOu3NJ9G9vKHRUYJNy6455OUM21/mfNAUQ7qkN1gZ3jJXv0sYktje3R+FdG+KeR8dQqmtPxhvTvBg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB7185.namprd12.prod.outlook.com (2603:10b6:510:201::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 11:41:03 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 11:41:03 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: retire set_vga_state for some ASIC
Thread-Topic: [PATCH 2/2] drm/amdgpu: retire set_vga_state for some ASIC
Thread-Index: AQHZikLKR9XkJPDL7km6pDo4fnDa1a9hchtwgAAGANA=
Date: Fri, 19 May 2023 11:41:03 +0000
Message-ID: <BN9PR12MB5257C9D372A91929C874D75DFC7C9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230519111158.1354372-1-likun.gao@amd.com>
 <20230519111158.1354372-2-likun.gao@amd.com>
 <DM4PR12MB5181D8C765B9AAFBEBFE86C6EF7C9@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5181D8C765B9AAFBEBFE86C6EF7C9@DM4PR12MB5181.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-19T11:41:00Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8e47d1a7-ab69-40ed-911e-c9963da38f9b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB7185:EE_
x-ms-office365-filtering-correlation-id: 40e7a164-1d61-42dd-148d-08db585ded23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fIxbK+ZoICH1jVSctzgarWTw8euU4pK0BCm4Xb6rv8jOyr5XyMHDqd0kmhl7+hmVE86WKUTcf30ZfS/PDKYxPhNiTRllEqKkC4iuOAmwmAZSat/diYqfV6c8Fu9/4nV9wu4035tsVZPcTZtnK4WZVEd1lmIkDM/7ZgURpISZsU8lgiivBx4Tk+S+OjpvcJSngTJKJZHOvitbey/PkdcAS3OG2B1u1F8NuBnr1qJ8JnRCYG8KdJ4valuNRoM7r/frme94ox0wtgV6NI4QNoYUThPOXG6UJvE84E7ouXBlDMCRUwRuP0h+FTxkoPlkitf6rogblwP5/htCQo/YUr12YaQbiDFWMZE5+Ct+W5eVpu8t8fTfM2FhLSIIjVX7GHnHbxt6N3y0xMmLZWgsuJA6VvNpUA6LnAU8LivX834xbvISFPYp80hLHOLvi4qJxTgiF2ZN1dAxztnIs6yyfoRndkvCMh2bZHnNokB1hI3sIArk+GYspfsYythKaRFaKoHEK0feo90nQL0M6vQ06rDFYwvSV2dRR9zXFgUNGzSrq5IDeN/wBrbPzJdfsoAFSSYLmmzvSE5prUP63q9Ipirk9+ZZbGC3RXUWS/o2rFOULIc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(5660300002)(41300700001)(71200400001)(2906002)(52536014)(83380400001)(38100700002)(86362001)(122000001)(38070700005)(33656002)(8936002)(26005)(9686003)(6506007)(55016003)(8676002)(186003)(7696005)(53546011)(66556008)(66946007)(64756008)(66446008)(66476007)(76116006)(110136005)(478600001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pP77E55bODQw895PHtePvBCkT8BmySQS4kZFy7pfbItUmMn2ggX75La2Xuiz?=
 =?us-ascii?Q?SwVjFXBjFSL7AGScanI9Dw6ZyuqyKM5m20naRXZ0A8zFfoBqsjwCeV7jYE/y?=
 =?us-ascii?Q?BDONY1go5PUBga7cvGPyT2o1GGTshB0UhbcLHdYc1vgnOkh1CnXETVQp2JY5?=
 =?us-ascii?Q?D3Ik+3zVAn7rCgfjBU6fwVEezFz1i3Nzkly9S0fXkFv3pfRjsF/lU2SZ39up?=
 =?us-ascii?Q?4q0mvxQa06a8hkHGojM4hNCU136H3+o2k6HAZ3bdptk9VRN08ZNmJSmQEQNU?=
 =?us-ascii?Q?O5z7SwCWY1NbCGI7yJasdl+DgYgnexVdnn2ik6/l5J0bx+/z9oKzPtdSYpuH?=
 =?us-ascii?Q?GkhAsNtMMJcPDV+/vJbgB3ZDMRunUgZmMYIDSly5DwgdrmSh0+vful+mj4lW?=
 =?us-ascii?Q?3nyAsmJv5a/Dhq//NSCs8rvKJm/RtwOOfSuqvOn/FAH5y2ryHEvBGRSrEdiE?=
 =?us-ascii?Q?au1VW8fzTNGeA6XnlpvuIVG7GOJTAhqUVDrRQl8RyQVAtHAgOzFaf75fiJfn?=
 =?us-ascii?Q?2SY/urhjllIkb1ndV2XwfEG+/jyPXjuTGkNktgnjIMLujQDTznDq2Uu6vmhY?=
 =?us-ascii?Q?dhAs6YSLOzu4wGrLGWQMRVzo/OJ2suhjhiO/wJIT3XMh0zuLS3UgeOpYwFrb?=
 =?us-ascii?Q?dcIZvlSrQj2a4jJDya5j5KoAWMRM1PknK7CeErWeIOzNg9Pxcy68HOgNtAK/?=
 =?us-ascii?Q?EUQOUhx1T+4PXfObUIwVpjckFMHlPqJykxKXuaFHNZAR19SGtxX9rbJLDqP9?=
 =?us-ascii?Q?qtRpNpQoijHg2+i5kGvkegOoP7wRUuS1UE3bPz1/EVVCsY5D5o33WAxSdpiD?=
 =?us-ascii?Q?NHhXbQCiVNVMGMd2586vX3fEHt6Cq5CndyZDCBacxI/51UJnN8wBpN/7Jp2B?=
 =?us-ascii?Q?zCs9DL/U/DUYftbgj/3FuegihTcqgFSqcMi5+P4tGeim4ZGseSbjxXo/wg1X?=
 =?us-ascii?Q?eBskID0c1hIZElto5rkLxtY2W18vYrq2u73u77w3BQtFRDW0twVQ6pSf1lEj?=
 =?us-ascii?Q?Es6kM7Bpd06XXmudbOWaV0lSk5bOuz8UY5r6UZ6TKGC5uAujwUm/JDObSM7N?=
 =?us-ascii?Q?UswEONxTGAam2AxSkFSiAAYMULjAb3lbSYC4Bbgpi2aXf/6HeJPAxNX/y5fB?=
 =?us-ascii?Q?lDaSWVmVlgFGY/gicAnfaCdBxrFDoRU+m7b+O8CVU0QZssM3WnN2mqqKICx3?=
 =?us-ascii?Q?b43Rt4zJMakHo9PP13PdBHc5VacXT8evHfm7sbWgSq6HV+PK8ZQVmPH6UoNm?=
 =?us-ascii?Q?Z6U3DWluCMk0dD0AZAsS0kvbFneulAtGX0Uy/Z5BfS8RDkeyqp2VhqEvHC8x?=
 =?us-ascii?Q?RIx0BECn+8JtLFPOYD5bfm1jgCl1MpaYrwiW8/eHR2mMSViCn4VoMR11q7Xh?=
 =?us-ascii?Q?llA2hbqO6Bu3TGBlPaC+LM/FtLg3dScDWdbDhlGMgr9gpUIYZH4cEUWMMAlg?=
 =?us-ascii?Q?XpWR3BOC1Tv1izF4DjBJkNfF3psyXkc38dw8FptZVnVzF0kPON0BW9vYLfYg?=
 =?us-ascii?Q?hj/S3DNqYgchFIg8Tvj4D0UuXpwQQ2yGcVtTy2nAzdhCYA4RCTvVtChmIvXc?=
 =?us-ascii?Q?jksikAkJz7a2rdSe04SWpYeTHg64SJPjlpUxUX29?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e7a164-1d61-42dd-148d-08db585ded23
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 11:41:03.6622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIBPe0oR4wZbQcW84RJJGaQ2khstWAOH+V2lWc4IoE23vvGeFiN/98/2Xq5IeaGaa5hv8kc4Gzog/WYwg6k/Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7185
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

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com>=20
Sent: Friday, May 19, 2023 19:17
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: retire set_vga_state for some ASIC

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
        .set_vce_clocks =3D &nv_set_vce_clocks, diff --git a/drivers/gpu/dr=
m/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
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

