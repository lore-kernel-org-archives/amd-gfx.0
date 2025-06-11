Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD769C678DC
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 14:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4B2C10E675;
	Wed, 11 Jun 2025 14:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rqwylRKm";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A74510E67D
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 14:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r21VKatEzSsPfNkGDJWPCwX6BXHfe21f97tt3Sv6ZVUtoGWHiu83WOGiOTtiWrj5gk/NFwicuc9Ijm4mTh5OpoxOr7/lBRdBYUQTA6hORNgLQuhOKMb3dGGEcguDVpLFTplwqIo0EniXDiAgjHfOB73Y6RQOYk0kF4CJwhCUuBd3jYZJBWX4WNKXR9tx239xgAgSmH7Xg9Ur92QU95UKVbjsvFL4o52O9G95kIeIe7GsdWMD4xsHPM/XsBZSHGAAFocB/DWnQrqJBpoiCEAeLk5T2BR7dZOwpkk2KqBXNcf2/71z3LYmb5iCWpsMzm/Ntt5wROSVtUJ/ZQa/tZDhRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCTEkPAUIxKgIqbXCjCaCD7/UkEZS77RE6GSchOnpvA=;
 b=dcacEN0aSC6qdxfiSgHT9v2r1g/7+9CNj/nF3JLL2H0/Twyk3+42eyQdBiM09je5K+BgPKjvloVFnqvKlavr5FmK4IRhRtThY+LkJYx1ovEmokacutEcvInjbuVosP7xpskrA9nIlQICfa2snpg4jaAgVNixUvnIszBP49M+8yyRZxQrQ5S/ebm0rhhnUpvCvbtHZXdJNiD+46t60nPR9mtpobAEE2Uqgp/Lk1VtAEeb3/Im6E9VdQkKtPcnJ+y4+Ta3Znh8tzDV7gFIPLCMrNrtebHDobkfRCkZCFDFhFixE4bZoSbT5AhLeNYN40yUXYB1fPhPbh3B2feCEKYzDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCTEkPAUIxKgIqbXCjCaCD7/UkEZS77RE6GSchOnpvA=;
 b=rqwylRKm3lO2ig6lifdi/6aQ53jfvQE1BPdKKTht5B4/HQJc0mRvUF37TjniWPXeDsfUpSUhWh7e95GMHbyvZjHv+PQrfF6uwlltvkr+BaWyOcFNrbrLHgyq9rvTah+lpegMj3r6NpLYO+UmM4YXB8wx6RCeKLoyer2hCLNYhM0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 14:00:03 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%5]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 14:00:03 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Mario Limonciello <superm1@kernel.org>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Pierre-Loup A .
 Griffais" <pgriffais@valvesoftware.com>, Vicki Pfau <vi@endrift.com>
Subject: RE: [PATCH v2 1/2] drm/amd: Allow printing VanGogh OD SCLK levels
 without setting dpm to manual
Thread-Topic: [PATCH v2 1/2] drm/amd: Allow printing VanGogh OD SCLK levels
 without setting dpm to manual
Thread-Index: AQHb2Oxe2Wc9pEqmv0ioLqnXTc3WELP+ACuA
Date: Wed, 11 Jun 2025 14:00:03 +0000
Message-ID: <BL1PR12MB5144DB6BC3C6820665EFBC59F775A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250609031227.479079-1-superm1@kernel.org>
In-Reply-To: <20250609031227.479079-1-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=c45b66fd-28db-4ee9-b51a-40958c9d3a5a;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-11T13:59:23Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM4PR12MB5843:EE_
x-ms-office365-filtering-correlation-id: 0a4f71fd-ca60-41a9-be04-08dda8f043b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?v2TS7krpUrwPqG2IZcCZbv1bShcwQJ/L4QsFIkrHIhooCX9dpf+4Yn4zKUr6?=
 =?us-ascii?Q?sGC4dsxI89mGInup9RNDJY+WSmep0aY4wc6sdz4HZSMBHPVCQA+5gc5MhayC?=
 =?us-ascii?Q?0fmoVXmchOThdvRpl3jtrANty7Z2cWtO+0WzwXLjzz5Aq8xHCmOmYzqHEFH7?=
 =?us-ascii?Q?FFAYnhkW/9xsFxJ0uVdHqJzF5k+N/x585ojOII3UFK6LMV//cVmCsybyDIw0?=
 =?us-ascii?Q?qiG4CJ8fK8V7NKPrj5A9f3ncbM5RD79AFkz7ibAXOYhvsMSMmiuvxIiJxZ1U?=
 =?us-ascii?Q?IZu4m5fdvOj4k5HGKaWux1jvCfoYrl5KYiWQloWTDeygUvjq3I81KNZqu6xO?=
 =?us-ascii?Q?vsOYa2ItH32MHQN4JDbZYj62pzKHh8jTbyLeVR8UcWrXKRjdhH35vZyjVxjC?=
 =?us-ascii?Q?JpTFApLdNAWOkeNsoM44bJe3qqDIW4Q9i4AC2cNwEU3BVaoKrGWb9GeFyoii?=
 =?us-ascii?Q?XhnxVSP1QvXAlQDwF5+BEhNFfVtIukOuLYPUlQQpYCiv2Qbr22UbEiTusVbY?=
 =?us-ascii?Q?CGAZbR13pbQ3ZFHxDG5JscEVD4C+xHTeXgKdrnR8A6aYeO86s/hPjSMHPhWu?=
 =?us-ascii?Q?vgjGPTu+lAfqFoOKH+cljKxzp3/cPuUgF2qwz+7gz7euLbmC9B6eFTw2OUaD?=
 =?us-ascii?Q?yZdonXBLgONO3mDXHYXTvk+bYU5m/pT62g0I7DUoYnGAGho/IoQAA4jP5PYP?=
 =?us-ascii?Q?tzNUxD1Ndv/zc4x1uSfJ+KD5smyAo944zEGOtVKN2R2xd6GosNfIGLnfkQMj?=
 =?us-ascii?Q?9E1xT2aIUn5DEMrknKG42TdM2DSQm6gJPcizXZ2lRHZdPz7kNvE9KnEsMiLg?=
 =?us-ascii?Q?xV8AbBAemOhm3XA/RsEtb8xs5WzIMCfwcHwGAW6ibBxpmbZayA8BdHodd4z4?=
 =?us-ascii?Q?o+x5vptD7xaHsNzoNFN5XXrWWAifVRgaCZR2JuU9OKavy4hAsz5Y+O9obvnq?=
 =?us-ascii?Q?+nPN+1+g+g7Qe5McfscVX7HSJHvBJRzEo9dHOt/D5gBWU9a9dIZ2E6IGSaYu?=
 =?us-ascii?Q?lu8GMug7/An3sTvqPkx81s3tQRm/e/dqhZORuPXQSs/ksZflsnqLIiBiUxet?=
 =?us-ascii?Q?up/fh7o6crmRZH2ZQKb64tU0lul0k6IcSdhQaqnDolyEEOSaKvzSBBVLRPGv?=
 =?us-ascii?Q?jCLU72H9bdh26UoWEtYVsdIeU5ZVayWka7d9c0AYRTsWwhh80trhhO9YOyzx?=
 =?us-ascii?Q?Ib9qqm32/rKJXteqiliB2QLUVFGtYwoMBf9qOpKs3I+lDtYW4nwcaR/QXxY9?=
 =?us-ascii?Q?uXlvpYedtL4qXeGARZqX9P2B0/ltwCh5UovtOoR+EO9xaDuw0xvMlnbpH2zu?=
 =?us-ascii?Q?gAl8G3//JRh6CYpUiFFz0mjYSR8QeRzjM0hKZ4LNz9tv2rIGesFvkY/YuOGE?=
 =?us-ascii?Q?t5+sACpDnnvZsdrx8DffKyEAeolBKvx5eKjYhtDQk0IKsQ0OoaO86qS2BSCu?=
 =?us-ascii?Q?/SGslB6/5/u2CzDwRogQngrZhW+Z1MyBFehYuDMHPXnfUPGblqOuULX/Jtnz?=
 =?us-ascii?Q?py+wghbgcdgPrns=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sqGTcW38T8I/ltW40nk9vCqEZ73cKrn7mddgDLeMyF7bignkQXQBVol+MPg4?=
 =?us-ascii?Q?QCtqlCdpAMmpw1C++ZU9Qx/+2X2v2YM5+f5pHuPTH6TNmBJyXXR2C4p5idMX?=
 =?us-ascii?Q?DLDUPxE82hsbAtoqXZ1jx5gJaUOotwHgDUgnOfww0fPfXK5t1UTalpoIU2rZ?=
 =?us-ascii?Q?DyU3KLIQQMWHL2Kv5drBroYrhpCnDJBCgAA1EAHMbkXAaKutj2AZpOd6tFzC?=
 =?us-ascii?Q?c44mzWp7g7LHb/n1YofoAAqWDyWVBsy9zAU9v9AMco1lza+fskO9hzNV6VGc?=
 =?us-ascii?Q?oKUW4oIFMBAAsbsj3+fDccFTUC/o/GV2rksIYUcV8dh5X4K8JzNUV+oqNO78?=
 =?us-ascii?Q?Muk6/ei+XZLQB5PkSVCahni1ByihCX8wXGJqKYW61ZoPcYlVpDh0EP2lWHxW?=
 =?us-ascii?Q?HPf1+m1vPcs2O+/s1bTf+Baavf7evZM/gBRNn8HP55C//NRucUcq3xVTg9nP?=
 =?us-ascii?Q?JxTLeyL7+wjq/0ojkZyD0Ie3e1u+App4PYsyWaNSa8xT9KkWYIj4B0Kz3Tbt?=
 =?us-ascii?Q?A9FsAqRmtKzQa8ZZFC0yd6oMUaP0EhwCLi2ad7azxPF/c9lRNaSj22dW09fp?=
 =?us-ascii?Q?+33I7VZikJ9wL1qMLg5EfDGSPHLAx0p9FFeWYp/uYrzJZMt1iE5V4+az94pP?=
 =?us-ascii?Q?R8DR3mnuKPE3iR9zGa9SDH2Jc7O/AtDELFW2+tKr+6wx38T0i57Jiw5HhU4K?=
 =?us-ascii?Q?DgYVv5v12ekCZezIqFCVWM33Skb72WkWSNeiTBCmf3kWkRfpaV1m2mpW5sY3?=
 =?us-ascii?Q?aZsjiuG9RIXVwOqC2YshGX1oLTC0ax65+UL/b7k0NRb5R4TbRPArsigJguA2?=
 =?us-ascii?Q?C3qhzpnJ37dKrxUmdBYi0QKhymxoTHvx6HylcaRBDONeTLCMjAdHAO0iKnOz?=
 =?us-ascii?Q?ciMh0a3kwD5scz/HhRx5/jeJdon2t9E71g96AlmfcpX4lLPQMPtHZRvg3mKV?=
 =?us-ascii?Q?75ptLcPtpeFNmjvdsYC6+LSkq42L0c/BnPCOSbL7Dbf4/FI4nrS1s6N8CpWi?=
 =?us-ascii?Q?uTAELW35+NxAfixJyAqY10fIEpEyHE5WHLWz+Ahm8nH8+Xr/AbYyblf85Meq?=
 =?us-ascii?Q?XgM+heVMYgulbZpLmvu84ZQCQNnDFvzlVtN1iA8VCoKFN9/+2hhUAO8qIWFL?=
 =?us-ascii?Q?w7sJs40dY/1RHLG0gc9UfsDexxCxsr2Nl3GxNUYfcoH9nJqFaQXSO9r2dSJO?=
 =?us-ascii?Q?0V3QOBOMp1GSdQ4KMo9Er4XAF1baSVr+LGi2zbie0C7EpvxhvTlE3o/d3W/C?=
 =?us-ascii?Q?/7dhoFnjI6PjwgcUOzeC7dOKjlX0EYeyrC1oybozjxitABzlMC0K5uBX8ghM?=
 =?us-ascii?Q?RFmoynXMKvCIF15vdGpXsw/RQusyknFeCFWK8/r/OsURxuxb6KkKDQEpSp9U?=
 =?us-ascii?Q?sCmVFoX+Lgn7aj+92JfdzsfF5IL2vCGcg5lKYcyuh+fDCqwWv6ouI/CNg24S?=
 =?us-ascii?Q?FCkq+vXYnvbeqcEBLtIMD14oJH2fO34eVEjUuZQ2BHyGuK68r+/pS3bCvzP9?=
 =?us-ascii?Q?X/+7f6eezbm1y61bHm/L8fgLr0r3n4UQYX3pwNpRAtz6PWAtLRNr8N5/vEpY?=
 =?us-ascii?Q?HOOqMQMrjt0xYpI3B8o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4f71fd-ca60-41a9-be04-08dda8f043b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 14:00:03.7727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/zQQMPImxBfRx4XvfZ9SSNwDN18LnFhbji9PVKPkisx/B7L2Blt8Ku1aJnAGtY6/94H5k4dG3VQ8ZORM00ZAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843
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

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello
> Sent: Sunday, June 8, 2025 11:12 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Pierre-Loup A . Griff=
ais
> <pgriffais@valvesoftware.com>; Vicki Pfau <vi@endrift.com>
> Subject: [PATCH v2 1/2] drm/amd: Allow printing VanGogh OD SCLK levels wi=
thout
> setting dpm to manual
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Several other ASICs allow printing OD SCLK levels without setting DPM con=
trol to
> manual.  When OD is disabled it will show the range the hardware supports=
. When
> OD is enabled it will show what values have been programmed. Adjust VanGo=
gh to
> work the same.
>
> Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
> Reported-by: Vicki Pfau <vi@endrift.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v1: https://lore.kernel.org/amd-gfx/20250323145316.859797-1-
> superm1@kernel.org/
> v1 (resend): https://lore.kernel.org/amd-gfx/20250421210639.1138228-1-
> superm1@kernel.org/
> v2: rebase
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 37 ++++++++-----------
>  1 file changed, 15 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index a55ea76d73996..2c9869feba610 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -666,7 +666,6 @@ static int vangogh_print_clk_levels(struct smu_contex=
t
> *smu,  {
>       DpmClocks_t *clk_table =3D smu->smu_table.clocks_table;
>       SmuMetrics_t metrics;
> -     struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
>       int i, idx, size =3D 0, ret =3D 0;
>       uint32_t cur_value =3D 0, value =3D 0, count =3D 0;
>       bool cur_value_match_level =3D false;
> @@ -682,31 +681,25 @@ static int vangogh_print_clk_levels(struct smu_cont=
ext
> *smu,
>
>       switch (clk_type) {
>       case SMU_OD_SCLK:
> -             if (smu_dpm_ctx->dpm_level =3D=3D
> AMD_DPM_FORCED_LEVEL_MANUAL) {
> -                     size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_SCL=
K");
> -                     size +=3D sysfs_emit_at(buf, size, "0: %10uMhz\n",
> -                     (smu->gfx_actual_hard_min_freq > 0) ? smu-
> >gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
> -                     size +=3D sysfs_emit_at(buf, size, "1: %10uMhz\n",
> -                     (smu->gfx_actual_soft_max_freq > 0) ? smu-
> >gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
> -             }
> +             size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
> +             size +=3D sysfs_emit_at(buf, size, "0: %10uMhz\n",
> +             (smu->gfx_actual_hard_min_freq > 0) ? smu-
> >gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
> +             size +=3D sysfs_emit_at(buf, size, "1: %10uMhz\n",
> +             (smu->gfx_actual_soft_max_freq > 0) ? smu-
> >gfx_actual_soft_max_freq :
> +smu->gfx_default_soft_max_freq);
>               break;
>       case SMU_OD_CCLK:
> -             if (smu_dpm_ctx->dpm_level =3D=3D
> AMD_DPM_FORCED_LEVEL_MANUAL) {
> -                     size +=3D sysfs_emit_at(buf, size, "CCLK_RANGE in
> Core%d:\n",  smu->cpu_core_id_select);
> -                     size +=3D sysfs_emit_at(buf, size, "0: %10uMhz\n",
> -                     (smu->cpu_actual_soft_min_freq > 0) ? smu-
> >cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
> -                     size +=3D sysfs_emit_at(buf, size, "1: %10uMhz\n",
> -                     (smu->cpu_actual_soft_max_freq > 0) ? smu-
> >cpu_actual_soft_max_freq : smu->cpu_default_soft_max_freq);
> -             }
> +             size +=3D sysfs_emit_at(buf, size, "CCLK_RANGE in Core%d:\n=
",
> smu->cpu_core_id_select);
> +             size +=3D sysfs_emit_at(buf, size, "0: %10uMhz\n",
> +             (smu->cpu_actual_soft_min_freq > 0) ? smu-
> >cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
> +             size +=3D sysfs_emit_at(buf, size, "1: %10uMhz\n",
> +             (smu->cpu_actual_soft_max_freq > 0) ? smu-
> >cpu_actual_soft_max_freq :
> +smu->cpu_default_soft_max_freq);
>               break;
>       case SMU_OD_RANGE:
> -             if (smu_dpm_ctx->dpm_level =3D=3D
> AMD_DPM_FORCED_LEVEL_MANUAL) {
> -                     size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RAN=
GE");
> -                     size +=3D sysfs_emit_at(buf, size, "SCLK: %7uMhz
> %10uMhz\n",
> -                             smu->gfx_default_hard_min_freq, smu-
> >gfx_default_soft_max_freq);
> -                     size +=3D sysfs_emit_at(buf, size, "CCLK: %7uMhz
> %10uMhz\n",
> -                             smu->cpu_default_soft_min_freq, smu-
> >cpu_default_soft_max_freq);
> -             }
> +             size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
> +             size +=3D sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n"=
,
> +                     smu->gfx_default_hard_min_freq, smu-
> >gfx_default_soft_max_freq);
> +             size +=3D sysfs_emit_at(buf, size, "CCLK: %7uMhz %10uMhz\n"=
,
> +                     smu->cpu_default_soft_min_freq, smu-
> >cpu_default_soft_max_freq);
>               break;
>       case SMU_SOCCLK:
>               /* the level 3 ~ 6 of socclk use the same frequency for van=
gogh */
> --
> 2.43.0

