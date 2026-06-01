Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13E5CD6E56
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 01:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 249F9112CD2;
	Mon,  1 Jun 2026 01:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nlao2T69";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012010.outbound.protection.outlook.com
 [40.107.200.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1ACE112CD2
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 01:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Li0FMITbwB+4SfQNv2gp0t8bsN6FqNgrXaFmzuzp6Tv6j/PgXdnTCztsKETSfDwP6ym83o4rRpSi4RPY/2MzFYw1BuS0fJwPVeYYCWfSzUz4D+Af2LCd8MfbyAEw/Uzg/ft9iiqEA48HKyaLSKD/8KDyvSL5msMRPk4lkQvrA0MG1EDvS0HumFLNUsL6bEAdxTyZyUTHiMQenBWC4/vdXzAFWwufE20JakEGN5Rxrx5G6YQiVw2QQpYl27r/R0dbkl7Qvh95HmlUjwXdLOL7Ew0DtYlkiU6X/MTKtn3IZ1ckmJMus+yamMx4cGtvqNU6uzQCzpeuph1BvXIfsWB/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Hr7MMYm3aIIBln+AEHVCGDBDTiierGald3S+5C2Gt4=;
 b=cuOvJwbVozOyz8ZdvPklSFuvEc0cebDH3JgjpdOTYTX2PTcdh8H9ENtu0xp3vTi4O7+1QrBr+rP7XpSTUBxVJHJq5wjQzjAepucqZTauiDsLUFY2oEMozAkjh3Ag4DP9PZrPROqCz/DbxuKVPYkq7g9Lns2iLyvMKUpa68zja1lQawP3JK/aaoa4Ld2ShuL4rbUolGKobQ8l1rToQnrnj2vTKwQS5P4c/ziIKNggEga25jf+YR/jKkHNcI27eQ1nXM4sswNsyfPEWf4YHiEuWk1Qso2ZcHoUdkgDHs7PAclVD2i+dOgdvq6BV4LwiHz5xzKKZbS+VSlbsMbiFtM/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Hr7MMYm3aIIBln+AEHVCGDBDTiierGald3S+5C2Gt4=;
 b=Nlao2T6968MBtz2f98Lyap7fmip8za7qEKRqNcyziyiPyMC7BWICxd4R98wlTjqOautXmGpqQKQW1VEBHCjDCliT/TlDJFGbVazSMo1Y84rdNI2Lta/kP8zO/OdQ37ZEr5W3a3kTcnMYbc6q/wyvbJIDvaIoHvEy07wHkdpqhDc=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by LV5PR12MB9777.namprd12.prod.outlook.com (2603:10b6:408:2b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 01:27:51 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 01:27:51 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Lin,
 Amber" <Amber.Lin@amd.com>
CC: "Rastogi, Manu" <Manu.Rastogi@amd.com>
Subject: RE: [PATCH 14/42] drm/amdgpu/gfx12: Refactor compute pipe reset and
 add HQD cleanup
Thread-Topic: [PATCH 14/42] drm/amdgpu/gfx12: Refactor compute pipe reset and
 add HQD cleanup
Thread-Index: AQHc6YEHu7atyZl3Pk2zO3tkSvfi77YlOHEAgAO/4cA=
Date: Mon, 1 Jun 2026 01:27:50 +0000
Message-ID: <DM4PR12MB5152FBFFD808E0CE037F36D1E3152@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
 <20260522002048.98506-15-alexander.deucher@amd.com>
 <CH0PR12MB5372CB6EE646106B41E1B214F4162@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5372CB6EE646106B41E1B214F4162@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T16:05:40.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|LV5PR12MB9777:EE_
x-ms-office365-filtering-correlation-id: c1145e30-f66d-4c6f-4d3c-08debf7cfeff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|3023799007|18002099003|11063799006|56012099006|4143699003|921020|38070700021;
x-microsoft-antispam-message-info: k6Xz4DSmDqkDSolx8QX886PnNWFoZT/1HpTq8yczQn1kYJ1argaS5k21zjbAhr6Lpu/YgqM61Kn8oRA1RRJm1xEXfSpU2UAD8PbYEg+zcq+KvuAJqNhWzVj7hLx1D85BSRtmDvcMK0knhuDD6Y1slIyNXmC+jVEprDUp1VHq5CAQU1wnFbHuvszgBRJ+7mlOkwAIbA+PK55Nee4mSDwdioUmovym8C6AwBdDmyhxIlHX3gg+NG2wthRqeCgbp0iO8OY/inOT4C+qyG9XYWd6VG/8FoBXZVgUM3PEevPBl34QHC4jzNxvZU0NUJWtKfrDOnJT/TGMF3X0TWV++Lp4IQ3tL4EQ6wLVoNd87FwKO1lQhHL6J0orD8gEvecnZHNlWI7aYeYKxIsDV4BR7SeEEJE7t0u6xHL9fvxExcf0MXh1IPiKw94mizRyFQxAyiLCOZoYVBVBw7lNIkoBVuolOsNYRIIu4E+Io/OUgaGXJJjlgG2xXEF0XN+QNJX2h28ZwlMrrLGeh9G/9f27SNRDt0pbOyI4USH/KDjeOtSdWI0BcaxVinBQJUURiazWgZvv8blxYuMQcjRg6snwGfOI3eeNm6xukrNUaa0u9BmeMEFyhbfI/oAnGIJZrs5Eig0HwRDqacLmtc961knFQg+LvQ7EkHp1iGFff05nVHFCSMjziToIvbWLZv63ci6iAuuMEBF4mk/CFvGiIuKU5Bu+WhhmdUTLTOjCvSwhuRwsXLGzZmXSc5+n76uLo0Fc+qn4KVlzM42SIbFxtYlYzUQDxw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(3023799007)(18002099003)(11063799006)(56012099006)(4143699003)(921020)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/INZCX8NUhDqIE7GUEW4HDtCbPQMTw5dkSG/VAVCJMIw0L3Nt/4S8lG8k9wy?=
 =?us-ascii?Q?HJgBAlvofRxecyiYvcq1c2oUR5N2chfk5C4kwvoMkWiq5lPsLDPozWBILwHC?=
 =?us-ascii?Q?xppW1bFqBvwCwe8U2h4e7eOfk8+seV38A1lQ5CUlyw7lC5AxP1sVXjRl/pap?=
 =?us-ascii?Q?nkYAux21Sgu1MvZ8l2yeDbd3FF2s2/Mfq3WVeuBDvFj0pI7TnfXg1Uh9EJe6?=
 =?us-ascii?Q?f2wwt9UFVMb6HLPVOXz5oTzxki0ncmKxSAzj5MjkrsU2ZWKpg7MYrsQhhpIW?=
 =?us-ascii?Q?SCU6rjGw/tck9VSHJZVpk8JJU/Wf89zlIEFxUgV5hMWvcC9xin2FTLR96iWw?=
 =?us-ascii?Q?k2msZ+FH3aasElkSoPKPeXlL9ShklU0QvlpFstxcOYvqSjTKjSnwFbZ3GUtx?=
 =?us-ascii?Q?7VUOQjxCxrAK/9wCVsmUb2PdlQ3CbR8zoJy03BUJM+j9N1y50PiaZvzPMKxg?=
 =?us-ascii?Q?uyK4u/P+AUDAmq/TR3WsCHTqfnwOOEV8xnLtL0K8ecc5gM1G7njme0DQFuQ2?=
 =?us-ascii?Q?mudwpe+CkS4DVqktULzxN3QZt1ci0r4UWDUCdPwc1/jNzOYBCAa89o3DM9mX?=
 =?us-ascii?Q?Q02a3mtkmcosJiaaXwS0/VWrCoka6+/4fiTDqXhgK4eGvft1BipFNyyx/OC3?=
 =?us-ascii?Q?bvFdJ3Ps2J+MMffGcv8lFTNp0TEPaATISi7wXxUJnHZifOG2ewvRRgWeki+O?=
 =?us-ascii?Q?1svtLl5LlgD92FTxcfSEDLzOSpO3Qg9PGMA77Oo6V5Xg/bM0Y/p2+kWfu4CA?=
 =?us-ascii?Q?3Vlj8sbGE9tLWllDEaZL0gMLlDrmUUXCuP8PAyLOFEfMV7T2LsSovQDnwbjb?=
 =?us-ascii?Q?jgF4C8u9RcVj4EM8klr8WZjY8SrHQUgsTBtn4sJ/pd+XKaT/JNUg5Qs5ZLK1?=
 =?us-ascii?Q?VXCbMx7TSc82pyjDn1LUpvw8N0QiqPv7rls4z3rOzA60OkYUT8MtBTQO6ieh?=
 =?us-ascii?Q?4SiTLNox/W+XSZCuhZKaqD6bpeOAqtWJtQcfw5clXC1keBlMZ5PRmIK4No0i?=
 =?us-ascii?Q?GDU1oAAuCHIG3sitGvjr5Y/RDHhz1r+s8u+kt+5hY0VlmRDVuaZH+4W0d2mQ?=
 =?us-ascii?Q?A/uXgS3SW8GEjzM57drfp5t0J5Wa50+gxJlr18pD4eiw9cy7RHqZ1oJstFEm?=
 =?us-ascii?Q?gY2LgkJgllTsHfCZ5/p5WuJVfs3pMJPhx38sypW+EB3+ScNanSbTVHBnfKQf?=
 =?us-ascii?Q?Gq7VFUjVYERoVJYz+McVPALcUIMdBm8M6Oy8mEuHVYJTPMsCCSGiIQVn3cij?=
 =?us-ascii?Q?6OVzUrQBwwCyGN6QOauG7hTTmD0qXpyZEpqdXo9p+b5qWm9ASVk2qWCTD83N?=
 =?us-ascii?Q?FLcX+r+nDnq9wmyvytjGejM9L+feWAQv8BvGqAUI1QoXQ13Z6h0Uo8LbWrXA?=
 =?us-ascii?Q?jt+5fUVDgUon285+LPq6OUa57maUD6ouLRzrfwfGk8mckyRBrL9Kuk0EHB3s?=
 =?us-ascii?Q?6nczOYvwGKh8as45+FevSgiwzXJJc5PnseAeW5o1jM2Wb8GXTVLUUGQDrJjv?=
 =?us-ascii?Q?QE0iK4INxBJMgm6wAkxHQuRZhL4vg9olY+qQseP31wSzruAZwF5QSaGnNPuZ?=
 =?us-ascii?Q?WxAA8kRadm5SZrRAhM+00zAv1UelUOrwGPGuQa8+LoDDLkp4T0pdlGF9gnDH?=
 =?us-ascii?Q?SNN8i+pLAsnnBJdeu0bZ+NhGp8HXv8xLuz1BLBLqJoSnMppyxJiYChTCpglY?=
 =?us-ascii?Q?q9wAMy75GIQOGpEl9Nx4ySYHtawfsb4sxG74mQtZVGgE/YpO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1145e30-f66d-4c6f-4d3c-08debf7cfeff
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 01:27:50.8099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l4CkAumIbVNY3eJCLUUCuSDxewrE9LTVkonEvZe7cf06dMf+Jhpl0j4a34uHiwQpkdYlf9EDRvGEVLi4dBcAtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9777
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

AMD General

> -----Original Message-----
> From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Sent: Saturday, May 30, 2026 12:11 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>; =
Khatri,
> Sunil <Sunil.Khatri@amd.com>; Lin, Amber <Amber.Lin@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Cc: Rastogi, Manu <Manu.Rastogi@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: RE: [PATCH 14/42] drm/amdgpu/gfx12: Refactor compute pipe reset =
and
> add HQD cleanup
>
> AMD General
>
> Comments in line.
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deuche=
r,
> Alexander
> Sent: Thursday, May 21, 2026 8:20 PM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Lin, Am=
ber
> <Amber.Lin@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu,
> Shaoyun <Shaoyun.Liu@amd.com>
> Cc: Rastogi, Manu <Manu.Rastogi@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 14/42] drm/amdgpu/gfx12: Refactor compute pipe reset and =
add
> HQD cleanup
>
> From: Jesse Zhang <Jesse.Zhang@amd.com>
>
> Refactor gfx_v12_0_reset_compute_pipe() to accept explicit me, pipe, and =
queue
> parameters instead of deriving them from the ring structure. This enables=
 the
> function to be used in generic pipe reset flows.
>
> Introduce gfx_v12_0_clear_hqds_on_mec_pipe() to properly clear
> CP_HQD_ACTIVE and CP_HQD_DEQUEUE_REQUEST for all queues on a
> given MEC pipe while the pipe reset is asserted, ensuring the HQDs are to=
rn down
> correctly before deasserting reset.
>
> Switch the KCQ reset path to use the common MEC pipe reset helper
> amdgpu_gfx_mec_pipe_reset_run(), which coordinates the reset sequence
> including KFD suspend/resume to avoid conflicts with user mode queues.
>
> v2: just update the sequence (Alex)
>
> Suggested-by:  Manu Rastogi <manu.rastogi@amd.com>
> Suggested-by:  Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 123 ++++++++++++++++---------
>  1 file changed, 77 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 4be650ce1fba7..d235e904b806b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5309,10 +5309,38 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring
> *ring,
>         return amdgpu_ring_reset_helper_end(ring, timedout_fence);  }
>
> -static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
> +/*
> + * With MEC pipe reset asserted, clear CP_HQD_ACTIVE /
> +CP_HQD_DEQUEUE_REQUEST for
> + * every queue on (me, pipe). HQDs must be torn down while pipe reset
> +stays
> + * asserted; only then clear the pipe reset bit.
> + * Caller must hold adev->srbm_mutex.
> + */
> +static void gfx_v12_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev,=
 u32
> me,
> +                                            u32 pipe)
>  {
> -       struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t reset_pipe =3D 0, clean_pipe =3D 0;
> +       unsigned int q;
> +       int j;
> +
> +       for (q =3D 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
> +               soc24_grbm_select(adev, me, pipe, q, 0);
> +               /* Start from a clean HQD dequeue state before forcing HQ=
D inactive. */
> +               WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, 0);
> {shaoyunl] : After pipe reset successfully , you should be able to direct=
ly clear
> ACTIVE and DEQUEUE_REQUEST .  One more thing  you need to set
> regSPI_COMPUTE_QUEUE_RESET) to 1 to reset SPI after per queue reset
> through  MMIO .
[Zhang, Jesse(Jie)] Thanks Shaoyun
1.will remove the HQD active poll gfx_v12_0_clear_hqds_on_mec_pipe() - dire=
ct clear under pipe reset.
2. this applies to per-queue MMIO reset(DEQUEUE_REQUEST=3D0x2 + SPI reset) =
in mes_v12_0_reset_queue_mmio().
>
> +               if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
> +                       WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST,
> 1);
> +                       for (j =3D 0; j < adev->usec_timeout; j++) {
> +                               if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIV=
E) & 1))
> +                                       break;
> +                               udelay(1);
> +                       }
> +               }
> +               WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
> +       }
> +}
> +
> +static int gfx_v12_0_reset_compute_pipe(struct amdgpu_device *adev,
> +                                          u32 me, u32 pipe, u32 queue)
> +{
> +       uint32_t reset_val, clean_val;
>         int r =3D 0;
>
>         if (!gfx_v12_pipe_reset_support(adev))
> @@ -5320,75 +5348,78 @@ static int gfx_v12_0_reset_compute_pipe(struct
> amdgpu_ring *ring)
>
>         gfx_v12_0_set_safe_mode(adev, 0);
>         mutex_lock(&adev->srbm_mutex);
> -       soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> -
> -       reset_pipe =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
> -       clean_pipe =3D reset_pipe;
> -
> +       soc24_grbm_select(adev, me, pipe, queue, 0);
>         if (adev->gfx.rs64_enable) {
> -               switch (ring->pipe) {
> +               reset_val =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
> +               clean_val =3D reset_val;
> +
> +               switch (pipe) {
>                 case 0:
> -                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_R=
S64_CNTL,
> -                                                  MEC_PIPE0_RESET, 1);
> -                       clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> -                                                  MEC_PIPE0_RESET, 0);
> +                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE0_RESET, 1);
> +                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE0_RESET, 0);
>                         break;
>                 case 1:
> -                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_R=
S64_CNTL,
> -                                                  MEC_PIPE1_RESET, 1);
> -                       clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> -                                                  MEC_PIPE1_RESET, 0);
> +                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE1_RESET, 1);
> +                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE1_RESET, 0);
>                         break;
>                 case 2:
> -                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_R=
S64_CNTL,
> -                                                  MEC_PIPE2_RESET, 1);
> -                       clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> -                                                  MEC_PIPE2_RESET, 0);
> +                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE2_RESET, 1);
> +                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE2_RESET, 0);
>                         break;
>                 case 3:
> -                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_R=
S64_CNTL,
> -                                                  MEC_PIPE3_RESET, 1);
> -                       clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> -                                                  MEC_PIPE3_RESET, 0);
> +                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE3_RESET, 1);
> +                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE3_RESET, 0);
>                         break;
>                 default:
>                         break;
>                 }
> -               WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_pipe);
> -               WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_pipe);
> +               WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_val);
> +               gfx_v12_0_clear_hqds_on_mec_pipe(adev, me, pipe);
> +               soc24_grbm_select(adev, me, pipe, queue, 0);
> +               WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
>                 r =3D (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << =
2) -
>                                 RS64_FW_UC_START_ADDR_LO;
>         } else {
> -               switch (ring->pipe) {
> +               reset_val =3D RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
> +               clean_val =3D reset_val;
> +
> +               switch (pipe) {
>                 case 0:
> -                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_C=
NTL,
> -                                                          MEC_ME1_PIPE0_=
RESET, 1);
> -                       clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_C=
NTL,
> -                                                          MEC_ME1_PIPE0_=
RESET, 0);
> +                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_CNT=
L,
> +                                                 MEC_ME1_PIPE0_RESET, 1)=
;
> +                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_CNT=
L,
> +                                                 MEC_ME1_PIPE0_RESET,
> + 0);
>                         break;
>                 case 1:
> -                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_C=
NTL,
> -                                                          MEC_ME1_PIPE1_=
RESET, 1);
> -                       clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_C=
NTL,
> -                                                          MEC_ME1_PIPE1_=
RESET, 0);
> +                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_CNT=
L,
> +                                                 MEC_ME1_PIPE1_RESET, 1)=
;
> +                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_CNT=
L,
> +                                                 MEC_ME1_PIPE1_RESET,
> + 0);
>                         break;
>                 default:
> -               break;
> +                       break;
>                 }
> -               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_pipe);
> -               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_pipe);
> -               /* Doesn't find the F32 MEC instruction pointer register,=
 and suppose
> -                * the driver won't run into the F32 mode.
> -                */
> +
> +               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_val);
> +               gfx_v12_0_clear_hqds_on_mec_pipe(adev, me, pipe);
> +               soc24_grbm_select(adev, me, pipe, queue, 0);
> +               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
>         }
>
>         soc24_grbm_select(adev, 0, 0, 0, 0);
>         mutex_unlock(&adev->srbm_mutex);
>         gfx_v12_0_unset_safe_mode(adev, 0);
>
> -       dev_info(adev->dev, "The ring %s pipe resets: %s\n", ring->name,
> -                       r =3D=3D 0 ? "successfully" : "failed");
> -       /* Need the ring test to verify the pipe reset result.*/
> +       dev_dbg(adev->dev, "MEC pipe me%u pipe%u queue%u resets to MEC FW
> start PC: %s\n",
> +               me, pipe, queue, r =3D=3D 0 ? "successfully" : "failed");
>         return 0;
>  }
>
> @@ -5405,7 +5436,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring
> *ring,
>         r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_m=
mio, 0);
>         if (r) {
>                 dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe =
reset\n", r);
> -               r =3D gfx_v12_0_reset_compute_pipe(ring);
> +               r =3D gfx_v12_0_reset_compute_pipe(adev, ring->me,
> + ring->pipe,
> +ring->queue);
>                 if (r)
>                         return r;
>         }
> --
> 2.54.0
>

