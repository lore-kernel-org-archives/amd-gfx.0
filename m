Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEA3C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 09:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73C0B10E13F;
	Wed, 15 Jul 2026 09:35:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mghmxb1N";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012067.outbound.protection.outlook.com
 [40.93.195.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43F2210E13F
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 09:35:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oy+pcL5oosbIFMCZP3b7VTnUD7fI7FBQDYyzs1tFRrqXaWllhqWiZ1Zod/c/RHr3IswjwD07xJ+UtT9bB6wmWP/uscQi7tU2zV2mu7v27OraoFSftfbIq2l+LA1QmpoElfceN2uDmvXWxn6j1oNBL/VSyY+KzMRP3yrBBz2EDyStFV/cZydXC3iXJp+a3DoFEZ2Xdl8dXrjLM25ZIQ+ws6w1qCrgx4VvFO9L/o1XJUyaVz+ZM7NdwM4ZI0NQAM7MWI0a5bdzKQ5z65gu0WGVNzxbRjYcg2b/3KwA8eMnu9WBA/Cd4ufN8B07J6qUVzV7uw5/w8Jl+b0Tz9db8dRWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fE+g8a8dFfctb2PbUvj4b77wXFnJxVKbiVyCvzZVsNY=;
 b=dtT8AEFp04NsAJulEDI9S66RGmUFgoFTxowUC2b3afDyqpzbCsE73Rp4QS/dg2d0JAl1K8huKsKZHgm49r7T0zOyWADqy7xoys4sGAW3RoFr7uWOMEVFOL9kUPmeYy3fm7uuhS5eAKLvFCs5mzeH1/PSiwXBy4Uuk/gj7WG6coeFH4Aqlv3m9ZEyi5U/uTefjY4dXWhCck/IX7Y6xFqUG56xNY8Lz+rGOU1spF6qPMTxRXbvtdNqnSuHig1ROYrvGfc3ODtgIxfIQjV/4BTLKvAX94U+vdsh3os6tHHPtcX7e0AlGOjc4x+UMlvkKMe6hBt0Lz3aRUQ72lNg25XsYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fE+g8a8dFfctb2PbUvj4b77wXFnJxVKbiVyCvzZVsNY=;
 b=mghmxb1NVSu0mhDRv+DhrMGr8MgGWCEOVQ71gObW1yOqezGLUeZTvqR2B4pd0xQ//TqHYv0FYeTnV/W1zQd/RuviZF2exLiJA1R7PJiQvK4ufRTNS25YIBXrlUFBJzYcqwTzjdLN4Y0PkBzzbA/aVBB3/UaDSAl97b4qOmwMdbg=
Received: from CH0PR12MB5123.namprd12.prod.outlook.com (2603:10b6:610:be::12)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 09:35:00 +0000
Received: from CH0PR12MB5123.namprd12.prod.outlook.com
 ([fe80::f6fc:f6bf:4c44:1e8c]) by CH0PR12MB5123.namprd12.prod.outlook.com
 ([fe80::f6fc:f6bf:4c44:1e8c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:35:00 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/5] drm/amd/ras: add real ras deferred error count
Thread-Topic: [PATCH 4/5] drm/amd/ras: add real ras deferred error count
Thread-Index: AQHdFC4+Haz6NDq5mk2U42AOiJ+D97ZuUFgAgAAA1aA=
Date: Wed, 15 Jul 2026 09:35:00 +0000
Message-ID: <CH0PR12MB512339D00AF5EA7400D2D45EB0F82@CH0PR12MB5123.namprd12.prod.outlook.com>
References: <20260715074734.2668631-1-tao.zhou1@amd.com>
 <20260715074734.2668631-4-tao.zhou1@amd.com>
 <BN9PR12MB525757867B3C2EB0FED0CE73FCF82@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525757867B3C2EB0FED0CE73FCF82@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-15T09:22:27.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5123:EE_|IA1PR12MB8519:EE_
x-ms-office365-filtering-correlation-id: 26548f02-9311-4fde-6bb5-08dee254578e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|4143699003|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: WweB86PeWGJ2GBKwBD8YOhkI+J+U3AnVx27I8eOYwWlUZYWK5pBifd/zFde45HfaM7UzezgtfjFLY0Span766hgkB2n3txoU0+2UAtfcbCoOP8Fata4nvAyid+Pmr8ZitKzVNYn0OIhZAU4tVu6A2gaOKdcL62Qa9w6JVTjG6rVGTidqCPRb3bnC5d8v//3YHAHdsfBEwUh66rLsqbL7MTcouu8zHEZ1uIsB394SNACuR9M7yYNTImIqY+N0rVLc4XNBoAZ1mPZCaTk2koS/amXVpM7CuFeXqsbyrlls4ohou2ChctRyOxSrmXHO1836X1GBJaNspy/cAHTTRsy7gQfdCJDPrupchlmbbtcsarg10CVU1qtjkTMeMzVKnYofV8XPkM0phrFnjfPLsqnkLsxONR4s0kCZbsiyiX9uy1ArFISrV9SMO+f5gQRpkN6SFCDMZPM0M8b2h0cAUMsskrIVbSLNuShm1pcv3cgXnE0RbjreH+lprYIw0BQ8YjN++p7CIDsyvzqKmdPW8BC9kx5UWlbWcrY2XRIOrqPaJpUAJGYJneP+oYSII1f4YIKpfud4sG63N7zL4w8sK6hZ7drRbAVSXB3AWEzfel2yCZm5tY3Uf2rJzdUopVsX6DoVrb0r2PmljTnmmMqinpuBVFPLlTt32k6d0evGK6KdqqtsRryjiRvH8k8lC+vBSW9Q6Rt6e6UBCND6soh8QhOcfrEJRWnbmL8KcqhCv5FO7jo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5123.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oqijRlHq5iOrLbg3WROkSmJ4JP0GZhFlbH10NuIXCrZYj+Lv8y/d05SCYPj3?=
 =?us-ascii?Q?zR25Ce53erAkVmyB+6nrPSvoRmZPZpQEVHzeHDQ5ylWvlYO6Fxn7MkaHnXOI?=
 =?us-ascii?Q?sXa6/SiGWCWNuBUOuHaaauQatLiy1jGWAcmO9E+ToXj1bb0pv1Bsy8bLJ1KJ?=
 =?us-ascii?Q?bDDFuCKqcbOHvnAftpTCVPdn7PFw5I2+5Ai5j0H7yMGD4oxweC3cBf1dZr9o?=
 =?us-ascii?Q?JHKg/Kyh8R7Dz+8kKDmqgAIln22ZgRAWIpiTLxXL2NDoNbTewKJw+TLZO2tj?=
 =?us-ascii?Q?8dA/Qjp06ctyptjypCVDf1Qe4g81FAKoS+oLkDWy8mOtrf2xE8ebhjwvsC0W?=
 =?us-ascii?Q?xGGkiujuZg5J8AzG2Yi+XVsl4GxVDvcVlozJUUTH+7rYRQ+rI/KJrTfHQleT?=
 =?us-ascii?Q?3Q/MZ3yzPDMfSE06phdpCoxj7FqQxACWhhV5EDZOqz185mJ+OJRvynRUvT50?=
 =?us-ascii?Q?sL4Fkaqdq1HsqfGtdi2xdKKuEKhB7pCjZL8L4bUdQly01Z6FiKLbd2e3aY2C?=
 =?us-ascii?Q?mbF9T5d87fwj0T7we1WiArUscGksbmhdh/pTteLroBVqy7lsMdwexUy1prKU?=
 =?us-ascii?Q?+Upmw28cYQ/3Fb19C4enAQyEqcWaXo3uvhGJ/H0WEtdCeoIQp/oA+QGcPjsO?=
 =?us-ascii?Q?EE5ym9jvFFvZrsP0IEi0YgA2nSiJ3PjozXzg2Z3VhKdgePHj0q8QoFFYj+md?=
 =?us-ascii?Q?wDw6m63C5WNQxU6fb51M3cpCCAXPk0jmCDmhilo7KwuNkCsYZjTIkrNAIzzY?=
 =?us-ascii?Q?wJ+4OKsAzxQmEL4rb7PNGnOUe3wzpfN4UxPjhFf/RK5VeISfXzyv6qiXUc9N?=
 =?us-ascii?Q?ptcyEzixa8qEXrO5TGv9DKo1z2ckleJAiM8a/uXl2IUKe9nxsGUd8d1hQc3/?=
 =?us-ascii?Q?tV53cWOSAYRz4/PhsfmwILMZ2VRi82z3wp3EqHPuMJn3G0Wfx4y8nigQO6Y8?=
 =?us-ascii?Q?ANHtrohsZ+ewutmPkTvenV9MJvWR7PqteSE/sMO4mV881ZF0oRH84RGlyCu/?=
 =?us-ascii?Q?FoXAgBNopzWMDWsdVPm0UNMzVcgXNWOR1LPX2ecaA+gQ+9YVKSVJ0BcsZLwr?=
 =?us-ascii?Q?SRv4uBmZzkiWRF2KAW2IDY/256QcydVphs9o0/RMDjef+wHeQzpINrp1w2Jj?=
 =?us-ascii?Q?M7PnYEY30FbjwPPlM70B7dFanwPFqy96d78XNiNl8ZwBkLtWAzgVJHRgS3nd?=
 =?us-ascii?Q?7vE+KS8ueCTMLE8XO/zCPnrQE4XUdYRxw4Xa7367FswOvB4wCe6AjloSika8?=
 =?us-ascii?Q?6JCfiVSspcHC5gZ8+P+csbfA0kOAUZ+SNVbgozhu1WpJM4ZWwCnhdDADqgmN?=
 =?us-ascii?Q?1Y6Oeh7fNlUBbuiyNy49IMO8kx9wAhdMjbC13bdrX14y2OIqF/srbM61XzHS?=
 =?us-ascii?Q?JfZaoQ2Zll3U8LjeOspQr8V3faM+q3ZAApcp3g3Nr2wKdRajy7espBXm8rtg?=
 =?us-ascii?Q?/4kpostjwv9GMoY2iO2WDr+//71q/gMHLVobISastWkHjbCo0pUpXR5Z8rlY?=
 =?us-ascii?Q?TEOTIqnLZ2LgHdP3GbHKFoNXNUj4kWB4GYtzOdv3Nu51BMcFEbwbPlV3nqCW?=
 =?us-ascii?Q?wEN+/CWelsamWlQKQXLk73Ff9vVWF3y+C1t+VUUTYojKWGgbQ6OgQnxzHSyV?=
 =?us-ascii?Q?Sdwa4h6IEqzvgZ9ArNrCodGdVPNMqLyfEAPCIv8bznRz27rq1L28lSfY5aw+?=
 =?us-ascii?Q?1vncA7bDjMptHzwLTr2HTme4OPjQsPXAT+uAMMFRohExEUWE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26548f02-9311-4fde-6bb5-08dee254578e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 09:35:00.7101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJKOrJkvoewukUWIrWmRfwJKSqFusarvFjFAd7kixqAbRC3ILJzhuarUpA7gTsc3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Wednesday, July 15, 2026 5:29 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: RE: [PATCH 4/5] drm/amd/ras: add real ras deferred error count
>
> AMD General
>
> Can we just use ACA_REG__MISC0__ERRCNT instead? Was trying to understand
> the use of real_de_count
>
> Regards,
> Hawking

[Tao] as you can see in aca_parse_bank_default:

         if (aca_check_bank_is_de(ras_core, status)) {
                 ecc->de_count =3D 0;
 ...

for non-umc blocks, the ecc->de_count is 0 even aca_check_bank_is_de is tru=
e, so I introduce real_de_count to represent the status of aca_check_bank_i=
s_de.

BRs,
Tao

>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zh=
ou
> Sent: Wednesday, July 15, 2026 3:48 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 4/5] drm/amd/ras: add real ras deferred error count
>
> It only depends on the status of ras bank register, and can be used in co=
mmon aca
> layer.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/rascore/ras_aca.h      |  2 ++
>  drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c | 18 +++++++++++-------
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.h
> b/drivers/gpu/drm/amd/ras/rascore/ras_aca.h
> index f61b02a5f0fc..0bde803f7472 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.h
> @@ -83,6 +83,8 @@ struct aca_bank_ecc {
>         u32 ce_count;
>         u32 ue_count;
>         u32 de_count;
> +       /* only depends on bank reg status */
> +       u32 real_de_count;
>  };
>
>  struct aca_ecc_count {
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
> index 840610538c1f..41df331587a0 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
> @@ -207,6 +207,13 @@ static bool aca_check_umc_ce(struct ras_core_context
> *ras_core, uint64_t mc_umc_
>                      !(aca_check_umc_ue(ras_core, mc_umc_status)))));  }
>
> +static bool aca_check_bank_is_de(struct ras_core_context *ras_core,
> +                               uint64_t status) {
> +       return (ACA_REG_STATUS_POISON(status) ||
> +                               ACA_REG_STATUS_DEFERRED(status)); }
> +
>  static int aca_parse_umc_bank(struct ras_core_context *ras_core,
>                         struct aca_block *ras_blk, void *data, void *buf)=
  { @@ -230,6 +237,9
> @@ static int aca_parse_umc_bank(struct ras_core_context *ras_core,
>         ext_error_code =3D ACA_REG_STATUS_ERRORCODEEXT(status0);
>         misc0_errcnt =3D ACA_REG_MISC0_ERRCNT(bank-
> >regs[ACA_REG_IDX__MISC0]);
>
> +       if (aca_check_bank_is_de(ras_core, status0))
> +               ecc->real_de_count =3D misc0_errcnt ? misc0_errcnt : 1;
> +
>         if (aca_check_umc_de(ras_core, status0))
>                 ecc->de_count =3D misc0_errcnt ? misc0_errcnt : 1;
>         else if (aca_check_umc_ue(ras_core, status0)) @@ -240,13 +250,6 @=
@ static
> int aca_parse_umc_bank(struct ras_core_context *ras_core,
>         return 0;
>  }
>
> -static bool aca_check_bank_is_de(struct ras_core_context *ras_core,
> -                               uint64_t status)
> -{
> -       return (ACA_REG_STATUS_POISON(status) ||
> -                               ACA_REG_STATUS_DEFERRED(status));
> -}
> -
>  static int aca_parse_bank_default(struct ras_core_context *ras_core,
>                                   struct aca_block *ras_blk,
>                                   void *data, void *buf) @@ -266,6 +269,7=
 @@ static int
> aca_parse_bank_default(struct ras_core_context *ras_core,
>
>         if (aca_check_bank_is_de(ras_core, status)) {
>                 ecc->de_count =3D 0;
> +               ecc->real_de_count =3D 1;
>         } else {
>                 if (bank->ecc_type =3D=3D RAS_ERR_TYPE__UE)
>                         ecc->ue_count =3D 1;
> --
> 2.34.1
>

