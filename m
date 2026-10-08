Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F47DCA600C
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 12:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 170C910E7FE;
	Thu,  8 Oct 2026 12:30:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="je8BnbwI";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2C5110E7FE
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 12:30:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqhKSoNTp0yqsIWnobCl6kocXwlZpRYPGoNVcAbap/5vzzZIjdIIAEeomrfrQ3re/Ao2PR1imCBbjIiPF1azUlPglWjh/n1lXRGhWZdQnP7z9ewOs7vqP9CB+JgNwEuu93L1H32ddxLWMjeNM5HUWdR80/h4G72BPeW34fO3Ji8fvBMf6CC9XkpGFsmj0q5PvIwSTEEqbewLBk7SL+B5qey/xuMGoGV375GV2Tz47lVDTOK7ZT1K5jvzEQ6oE6vp5Q3YorAhBy5MwOAc8MtRpOGBEw9HtGCjowLGbpc1y8+wK7xQKRspzQ7GNINFlaoyXPBFbpVdJG/IFedu9PZBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RbIyYbII8BetUs3RfyVkDYZjhEo++VMySOLyWYK6z0=;
 b=vJm7bNcXKFnIk+ogYCldvFOKyWjLZgLo8Jt8SHdJfSZXUMHvafYnOeQ45zuYblM0PY0IVBlLAru5TPYXwE3xxHZ9AyZNdnWM478snxHf4Wnsz1G/T3d9FRPVMvkqNBs1ILznaYycjKtAU8Zhp2u5k0GL2TfwanLEbderLdHY7AKnInWcnlCA/Ly2M/E0QJ8XbI/6l6VY15iZidaIZWEaeHh8e5WvTgJJAth96HpS+bu0HkkUFXQDISaQjPU2DT5i2Ut6UKXMSjLt6cpFFZmNpS66xBLOPLzlzrYHc9slvJjzBJEGa8IyDSecVb47MsHazmgaecIaE5gbCN4a99FLmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RbIyYbII8BetUs3RfyVkDYZjhEo++VMySOLyWYK6z0=;
 b=je8BnbwIM9UeeIZsV47RFpgnTeGhmU8AIMbT6ruWXfATWY3+MD/O6He2uQzghmTNZrSKvuAsVvG2i5QhS4Ow+MLvErbUW6AtBuz5cprf1VTKNLbSnrN3WtLDqWZ+uJg0goMTeu1bAe77DlwUh5KDggSa7bBDdoJcefaN0DlMwts=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 12:30:17 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 12:30:17 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Chen, Michael" <Michael.Chen@amd.com>
Subject: RE: [PATCH v2 06/14] drm/amdgpu/mes: move RS64 query buffer setup to
 software init
Thread-Topic: [PATCH v2 06/14] drm/amdgpu/mes: move RS64 query buffer setup to
 software init
Thread-Index: AQHdT8U7wn3rc2T7OUOyTBvviwR6fbbzobog
Date: Thu, 8 Oct 2026 12:30:16 +0000
Message-ID: <PH7PR12MB60004AE69B9978D2F8903769FB932@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
 <20260929034650.2393125-6-Prike.Liang@amd.com>
In-Reply-To: <20260929034650.2393125-6-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-08T12:29:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|DS0PR12MB8199:EE_
x-ms-office365-filtering-correlation-id: 25255305-8740-4d88-90e2-08df2537e8de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|22082099003|18002099003|10067099003|11063799006|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info: BuFQrOLKb0JV8awucXxsuTMy25A+NMzhTkVmZI3EOAhmus9xi1dqa1NZK7vGfkdBK2I8/cRpcjLStg2eQELxhzmknOBYezYmTN7nsqqfRPX/Kfx5EK1w2REoPE/yb/u5+bBEEY1w/+V7piMeW9Ve3coScwpqFMWkdrpetAVKqa/L4QKlCq4AEkyQ0YGkdtExIhb8cCuvzrcUe4wuZFk8HzFRFiUX2olNzoXOyRJtlukudxbSe+4xlcdO2E0BETnR4tso7ckHsrnOl0H1QUqxZiDPLjYTei/zcTpaQqWeSZQLXREMNw8pY1WPbqXTgHvgX6oPq+Ny7GzJUwM3WAirqVumd7im03vzcvgERbdPEHZ6kSqXPk1Xq1kZfZ1SzuSpKLGgPIL0551h06BjlMUiQS3C6OH+xqssxaF3R2xMoBrRHxvqiItgUsd9bOoQ8zfVmKfxsDdH3kX54U1egcYCD20j+VfBXzlu2SmoyS0sxaoDgXoCUmnpP+yi74P89meT6Sljz1cAUIiEWTV6+RrU+tgzhg87uaOdor9ONTgAC9eiHiZlIrwYwAoSlOqpINHqro3V3Gx+B1xkO8yikvZiZmcvQTinShsDO0MwJrqsl0UdFZTSsHHlgeDsfS4m0+/JItCIrd5Y01jPHuGFQrfH1e8qNvE0cefvFEfqzcoVHe23uFT3vAHpl2g87r703HtDDmFNuKK66tJlQhb17TCouikbFXAnZAjLydsRdiLdNLc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RDr4FPUXhJ2YxdSzgrfP5m9q3Ax7kamNN+X0v6o2rrIqKQNfgYOxGeRx2mv+?=
 =?us-ascii?Q?P7HCDtqR3ocWHFiELa7uBEvemsSmV+U6TFNacte+fDIDyD76YodpXRRpMCG5?=
 =?us-ascii?Q?dUc+n3ngs5HTP5NyODpJ4ODCsn2a+VJj3IP9dt0egbxzzNDgP5zCn81ir3SK?=
 =?us-ascii?Q?qBF9fAgAUHJPvIQEJIudy3euZyfukC6TYTU8gVYXPEXX2aqS4lI6t/4EXUrA?=
 =?us-ascii?Q?DfbSWC6r85kT1T9H4ExbOTpm5ut4p5+1kSsp+mQhxD1cL6XIJAT7FgwDxxJJ?=
 =?us-ascii?Q?WZ1vtNYobnWRdqwzS8iLAz82GgZnGrfRJyNTYnJprXWGEpDaI/YjG9PHSyzE?=
 =?us-ascii?Q?PQfScD0PGFvC39/v4taH+KGGCsYd74Jl4tiywjVHgBxvrMIA9jdF43NHX2IX?=
 =?us-ascii?Q?EBB7u6lsAzcRFQpKUxt9vfEj2+BQ1r3rzsArNEA45PqmYRXCloePJ4MtX5B9?=
 =?us-ascii?Q?23NoZmgVCEh9wF9vSW7LjsDizK32zsxMtqZr6p4vrbQxZ79FFAfJJGmRiDT9?=
 =?us-ascii?Q?pwaJzmNeJjmyp5atn5mHQ6jHOEl81uI8BQt25uY6+gU/T4jghKuCGKgRrIhm?=
 =?us-ascii?Q?9/yxMfvP5GYWrv52Kkl5idn2xQYbHYtlOmRTOQWyYO6KPUWSedhjmkgPZHTy?=
 =?us-ascii?Q?prC4KRlpH112wLmeleDjqK47vQsnH36VuNpnks2uMexkr531tReYegPrJbTi?=
 =?us-ascii?Q?uFEm/fFhcpfD9mf9ugX5CF33nqX6kC1TksxDGl9AhpjB3S4vhCfqACizTXyU?=
 =?us-ascii?Q?0489NRpli++ZN1wS+tI4SbSUmusw8y6MyQ3xEgjlwiGwA3ymX3khjkv0vH2s?=
 =?us-ascii?Q?o2hpRSPfkn53j4IFRwBS7Q1bj2lE58jWDz9pcm8ZMwjpzVdFlv5hRRSBN7qF?=
 =?us-ascii?Q?nKiQmzPwTaq8v3224UBnWfXJoBUz1CL7ZxmX1hM42HnaxrsmsD0SRYSwWTiQ?=
 =?us-ascii?Q?Y2Bg9K5A+qh4tEV7tzS3yC0sY40CtvGE4M6n+CzPIyBli6XXqiqTT6DMFkdM?=
 =?us-ascii?Q?c4+1RJr/KhIeuQbtUhSfTqhHHLePRiCrpvNn/Hxo4WmjLqS3MJymcy86IO1J?=
 =?us-ascii?Q?y6iSPAkQS95IUf93YWlFWq4y8dF1Mnu+uZJnL3xQgGGVMVsqzFFZNWZYZRme?=
 =?us-ascii?Q?I4c9Ply8tdq5DUNt5uJ5+hK8TBveuTuE1xqrhhuUvXOJtZqgOj7R01fA8bVj?=
 =?us-ascii?Q?Tm8C2aeXjttLm/EzKxANX7yPUtJToxd2RYgYNV8+z4jSjbiGROda4KPkgeeZ?=
 =?us-ascii?Q?2tLejV23YT6Qe/Rr9FnHJg8Ok3MT2jq4PzE7KjTNE9gGhx3HGQVe1HXKRVtM?=
 =?us-ascii?Q?JQAs7KvzFUn3qlbuIuLWH1eOw0DGF8JqCmrv5Appdzehg03BzcqdwaUDw47N?=
 =?us-ascii?Q?tkjyRKrNqVWjwTwPaZ78JcNcCcSPGxtQ+cjY9xumN4mTqEtAxhqfIL2nxP7T?=
 =?us-ascii?Q?XYHlokP9Ys6F7OWK7WaPZz9lps0HyKRNu9yg4Km8Cz5Jy4Z0VQ5z1eoZMiM/?=
 =?us-ascii?Q?gfnI+vTyWqlCZ2pZxG+gymPNciaQ/Hfq1cRgt9HhRil0Kiji1ZCqOomFLbR7?=
 =?us-ascii?Q?CHrKuSbIcVHES/MvT5QT6AIBgVhDqTBx8SmaYgKR/6QACenp2zKKhBo1fYRG?=
 =?us-ascii?Q?K+lw4OsLZxLoqh4eemK9kai+JLXSWt45tmqoGrvamxdPh4oppH8vDwC35P4E?=
 =?us-ascii?Q?PmGRDW9fV7uQnevzz5d5Ou7IkqILW6/PmyCYw6GywqmmbIFz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25255305-8740-4d88-90e2-08df2537e8de
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 12:30:16.9988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XjJBui/RvXJwD1A8wSyqNSeOrg1n3EP4JrUCt369+Ohsw6fXdkVG6pAadV8tcJNa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199
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

Ping, any comments?

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, September 29, 2026 11:47 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Lia=
ng,
> Prike <Prike.Liang@amd.com>
> Subject: [PATCH v2 06/14] drm/amdgpu/mes: move RS64 query buffer setup to
> software init
>
> Place the RS64 context-size query buffer's allocation with software initi=
alization,
> outside reset-time hardware initialization and its firmware locks. Hardwa=
re
> initialization only consumes the buffer.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 51bfb672bed7..2f62214ab24f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1746,6 +1746,7 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int pipe, r, bo_size;
>
> +     adev->mes.use_rs64mem =3D false;
>       adev->mes.funcs =3D &mes_v11_0_funcs;
>       adev->mes.kiq_hw_init =3D &mes_v11_0_kiq_hw_init;
>       adev->mes.kiq_hw_fini =3D &mes_v11_0_kiq_hw_fini; @@ -1796,6 +1797,=
14
> @@ static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>               return r;
>       }
>
> +     /* Allocate GPU buffer for array size query results */
> +     r =3D amdgpu_mes_rs64mem_init(&adev->mes);
> +     if (r) {
> +             dev_warn(adev->dev,
> +                      "RS64 memory init failed (%d), using system memory=
\n", r);
> +             adev->mes.use_rs64mem =3D false;
> +     }
> +
>       return 0;
>  }
>
> @@ -1973,8 +1982,6 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>       if (adev->mes.ring[0].sched.ready)
>               goto out;
>
> -     adev->mes.use_rs64mem =3D false;
> -
>       if (!adev->enable_mes_kiq) {
>               if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) =
{
>                       r =3D mes_v11_0_load_microcode(adev,
> @@ -1992,14 +1999,6 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_bloc=
k
> *ip_block)
>       if (r)
>               goto failure;
>
> -     /* Allocate GPU buffer for array size query results */
> -     r =3D amdgpu_mes_rs64mem_init(&adev->mes);
> -     if (r) {
> -             dev_warn(adev->dev,
> -                      "RS64 local memory init failed (%d),"
> -                      "falling back to system memory path\n", r);
> -             adev->mes.use_rs64mem =3D false;
> -     }
>       r =3D mes_v11_0_set_hw_resources(&adev->mes);
>
>       if (r)
> --
> 2.34.1

