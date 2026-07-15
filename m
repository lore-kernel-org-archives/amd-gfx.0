Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB7EC44507
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 08:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01FF10E14C;
	Wed, 15 Jul 2026 08:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dZXt3GeY";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013022.outbound.protection.outlook.com
 [40.93.196.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8317210E14C
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 08:57:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reFywwgPKR9SuHdnzGwN5GIFX8cxNkL3B2e995sZ3C89Yxks2YmXGoxqMuUs6qKqdq6O6P104pj97MK7Oel4PlmEH92yhsoaMV8ZFXwFGTA2mOKPYD7zeN8AG9jAsmW/3PwOZMwgSOdhx2VMN5lSW6rTDBgy/6vd7lQooLliP5FBviNoN2eHmsS85330DR7CRqQrssarX+/O2ipPF84jpdPheprQP5BZX9Tfsf7WtQI29+yBOwXIARk98qrXgzwFn1oMoO1Nz5q2dBWyj+schGpZ5s1SwQaqEgcEtF9/SuHqnoFIvFb1PTQljgq/GkRQofPJi+j/b8NdCrloIW6w2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0EZlzQQbFKScSyhSLaiOZX7ru141GuvQCrzKnAlv7o=;
 b=wzA0YCWY1p6Se2jMozwmjYj7P3kdRQclS20ObeF6QhMjUsjdP6HqFkARh8o+VIFiMXol7voKgOLXZBlEwrd4ZVPouFQdxg04lPEsyy2iF9qTyCxzOikDM+C0EOezET39Ov9yV/TfP5eWpTLz0m4v1TRJAII+MhZHFMl8CPf/AZcJvJDZuKKfag+5HUCLUDMRDP3QBikO+9KmpSdwgUCyMpCr7Qv26hd8r/CGm4bydsxaW+g0F/W/TBMBlBklu/xxLJvHgEYuESY42HLo8klPn8hWylCTO6/bgB7ZXoEbkvAYq1fbHLdvCmJ96TSOsby9pqhTFuIBoGEm9aOqRZwnlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0EZlzQQbFKScSyhSLaiOZX7ru141GuvQCrzKnAlv7o=;
 b=dZXt3GeYpo5csuSQftIrv+AH4v77vJ4+XXuxXktav45gQncuLD4WRxIhfa6C4vXWzdIXPMiDFj7meiFEr01Q3UybsOpmfYsyyqx761SRxmxQKR4pcMxYwv0IsOQhsdlIwpL/UB4KC89E1k9iizKP/JrG1arrS4a5k8yW9CWxQo8=
Received: from BL1PR12MB5127.namprd12.prod.outlook.com (2603:10b6:208:31b::14)
 by DS0PR12MB7994.namprd12.prod.outlook.com (2603:10b6:8:149::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 08:57:05 +0000
Received: from BL1PR12MB5127.namprd12.prod.outlook.com
 ([fe80::2760:8b04:f874:e077]) by BL1PR12MB5127.namprd12.prod.outlook.com
 ([fe80::2760:8b04:f874:e077%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 08:57:04 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amd/ras: add ras ce log switch for uniras
Thread-Topic: [PATCH 5/5] drm/amd/ras: add ras ce log switch for uniras
Thread-Index: AQHdFC5ANm4aqLrdWUuf8NmcTtp5mrZuPweAgAAHAEA=
Date: Wed, 15 Jul 2026 08:57:04 +0000
Message-ID: <BL1PR12MB5127187AC95C256DB499E271B0F82@BL1PR12MB5127.namprd12.prod.outlook.com>
References: <20260715074734.2668631-1-tao.zhou1@amd.com>
 <20260715074734.2668631-5-tao.zhou1@amd.com>
 <BN9PR12MB52575849F098B6FD36227AB1FCF82@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52575849F098B6FD36227AB1FCF82@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-15T08:25:25.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5127:EE_|DS0PR12MB7994:EE_
x-ms-office365-filtering-correlation-id: ec1e2cd2-6416-4e9c-2a61-08dee24f0af7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|22082099003|18002099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: CUe7LmZ0XXjWi46ILm2Gn1tmXbYHy3tluouW4oR58oDD35mDaBiyzCg7NOEAvLczy10cY8678nb1yPUx0SUh83Bf4Qf6MUiUn6/itpkpEg32+jZTNkDhhqkmPrH+jQkMjRMyQrldqaigUEXcZXEWJmKkjVL+NWiriTnQnb6E10MJZEu7rMi7SPoZjbm7wGVAK2io3S73n/2ul7Or1gsI7B5KXpssKJAE9g2HjF/AkIG2YXr85Y76ECoUumb+FCMZIc9s1DjK1NFLOyTqsOx5uOcuD1nMJ1olrWa6EsrpNLyIhcDfe3puaqHE6dG0Ba+CfkhEY+8hD8nehlxWuJwLHehLbqb2hpSUPKvrlqUfOiGtTfiqOMTUdIq2hd/euJCnXPE6uf8W2gt/YoNcsYZAzMZrNWm3UmRBLN3VtuOyAbd7jsINHRxC76G+N/l2YEYMXac3jT7yAuLbJoCI20GTuGtze150rhlZ4x0jrAFSVbPAl0FWxO9XnuMkUTmnAD+Y2aboxj6FBMBk9BuqL7Y2jWy5BHOojXeeteytzKMWoxKo0HV9MclvKwAvkGJTzlSUrpLg2yiDPxK+DJtuYHv+01bpRVtLZD9KUSrs8zJKL+dJJ60TCw+sGpMAv9jr65hO+Q2se8CjFrWSOElA0x4FbsVbeMdI+FbaurX7aDS4K08iXs6IYayOYKtuLa0eRR44SiClRQfr1tv0CpCOPZKDKZtYiNZuK55YGS/LiBFGOjo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5127.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JsFEzMtZx+c9gzQsla+ZFdBOWj60R1RRtafqYhnRPmUgpww1+ADxE2M7iQEA?=
 =?us-ascii?Q?Ces9OLh/7dlF/hsR0kIZz43KPtHFfLaN5rLsGTRQkRV6Z2pCMNawjjSmk0T7?=
 =?us-ascii?Q?qUURMV2z7cwejWu75WfHjWRnglvVi7t4Bjelwvz4OSTHz4WRVA5z2HtdkHiE?=
 =?us-ascii?Q?dTx4eX2tAntXAg8ZCxt0RvTK1KiPZMKs92Zk/3o4mx8RurUf1v+JnSYX8f3A?=
 =?us-ascii?Q?5hkzAiC7t727r7baq0O+VDPydYEDYp6wpFe8Bblt8awytDerdlEa5fe26TeW?=
 =?us-ascii?Q?r2O178I8c9mXyIuMyB6sW9koZOP79LiqNGT0NnWcKjKmYGnpGLHUvJRtLiiN?=
 =?us-ascii?Q?oWJx2pOcLnkeQHGMZBz1q0o/YTxOYo5MwRYPVxSdltSr7fME1qb8tFKWnrbt?=
 =?us-ascii?Q?NUpvlH+Z8a4vUYiUCu2Job+ZEVM15Gh/8cDERsEndx8HiEWDMbOJkK5iJ1gz?=
 =?us-ascii?Q?8c2tMNCM+lcXLweIANF4m0JQ5ihDd8xelkd1L4PdqivEzxh3WjcqGY4DwYoG?=
 =?us-ascii?Q?6HIYh2E8UFhD/t2JVUQqL1PuPtMfwSy6I7BEMnC4sCB4a7fqQRQDK3JCn4mz?=
 =?us-ascii?Q?NcsvXFVgBXlol19rz/GjpPBcUtFBr222E/BxZA2li6uvhAXNg8PK+E3/blQe?=
 =?us-ascii?Q?CxfHBBeditGBQKl5p3ghpy8vFiHxKXZRZL80nL0AX9XYKDvZix8jfOBz9rBC?=
 =?us-ascii?Q?bAEozwTwX7kB/7ZDSfk6LtNP9v0bqxrUh5e9iNBSjFgvMorDGlsSUhPbP20+?=
 =?us-ascii?Q?4j+yUpzJwxmIaXGVlx8gOnnDyfC5zRZ1xl98myF8DiJDZ03XQBWB7hOa66zU?=
 =?us-ascii?Q?6DLm2U6Ny8A3KWkg9QpHutyIgHktM62Ftu6W5xFjBEEQCPlMjQGKX701erLm?=
 =?us-ascii?Q?Ces7+IszgZHj4hWNWaOrhdxP7GZ2Z6Z8RZkxStwdW/UBw6VOj4kxOjpZqfZ6?=
 =?us-ascii?Q?GwmxmUbhxVrRu3Jw3qq6gDMQYdr3Q99H4NGJJUq3hx7wzCR3WkSmXDzdL9jy?=
 =?us-ascii?Q?tlJ+U2TwJCRSEXj1kaNu/n2a8pzVNiDXBqigprRcfbEZuJGlO2Z5kPb3epuA?=
 =?us-ascii?Q?CF7OpB7qL9J1dChP1bjeIAll/n9Hg9Xqd29jAKQi/e9YCX3fWZ5sW94nQHk8?=
 =?us-ascii?Q?AY5Fz7u5FoCFcsjCC+zUli4Q81C99zedc0YG8VhN1LKdU4UqXYdJjFeS2VPk?=
 =?us-ascii?Q?tejZFfprEbMbj3WpwwGAs6lZwIEq264kl6RkYC7rwJDyE5OykHAMDxLYrPt/?=
 =?us-ascii?Q?JIqmkaioHT6PjVEgMpSoz1NrCRs6LVLr5b/yVJAaWHvEpIoWDdTNevGbmy7Y?=
 =?us-ascii?Q?rsKx3Nq2nFDE1z+4FSpu+TkkkHDGKjI3jC9bU67O+9BxYy0ksg9ruMvVT72R?=
 =?us-ascii?Q?jM4GKbgrs2O05ksjpLG0BmJZ3miOI6IxhpVP8nQf8bPD4JX6r3OtXFzs6iiv?=
 =?us-ascii?Q?l+YvLOqt9CXf2jQUtI2exnfxcU7Akx/YHdtwHfrdql9Xxj36q3JD8BtKXop5?=
 =?us-ascii?Q?xRjcCkGYs2/Eb2ibjdVaSbetU0zn/WhFcCwQB4PA/UOIuGVpSqxviraQrmxH?=
 =?us-ascii?Q?PMDY3EdVLh51pW1bJgVFmYSEha8jWCuny5J9Bwz2j22a9aysIcwhK9Y93lCG?=
 =?us-ascii?Q?eLDyhE3HoNFPHII2yiYRpM3i6rfM6MxoybEfkmdoczJVzWKHlrpSEfbyRNr9?=
 =?us-ascii?Q?KuxcNWDR4RIhpzaTML8X5d5Od4gNIlgkNOpqESEh57TuBfqk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5127.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1e2cd2-6416-4e9c-2a61-08dee24f0af7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 08:57:04.7234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /XG/5QqZMrQrW/IJRq/zUmcLuUqtdz3kq2JhRwMGbTsbIzbtHGwDap9aJKZnS1DY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7994
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

OK. Since Ce is working on it as well, he will refine his code per my patch=
 and your suggestion.

Regards,
Tao

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Wednesday, July 15, 2026 4:27 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: RE: [PATCH 5/5] drm/amd/ras: add ras ce log switch for uniras
>
> AMD General
>
> +       init_config.debug_disable_ce_logs =3D adev->debug_disable_ce_logs=
;
>
> Let's pass the full amdgpu_debug_mask to ras core
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zh=
ou
> Sent: Wednesday, July 15, 2026 3:48 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 5/5] drm/amd/ras: add ras ce log switch for uniras
>
> So we can disable ce log manually.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 1 +
>  drivers/gpu/drm/amd/ras/rascore/ras.h            | 2 ++
>  drivers/gpu/drm/amd/ras/rascore/ras_aca.c        | 7 ++++++-
>  drivers/gpu/drm/amd/ras/rascore/ras_core.c       | 1 +
>  4 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index c55288c2df9a..1e95419989b4 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -310,6 +310,7 @@ static struct ras_core_context
> *amdgpu_ras_mgr_create_ras_core(struct amdgpu_dev
>                 amdgpu_ras_mgr_eeprom_is_supported(adev);
>         init_config.poison_supported =3D
>                 amdgpu_ras_is_poison_mode_supported(adev);
> +       init_config.debug_disable_ce_logs =3D adev->debug_disable_ce_logs=
;
>
>         amdgpu_ras_mgr_init_aca_config(adev, &init_config);
>         amdgpu_ras_mgr_init_eeprom_config(adev, &init_config); diff --git
> a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore=
/ras.h
> index 5719bc1b6167..9d538a07c50e 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
> @@ -301,6 +301,7 @@ struct ras_core_config {
>
>         bool poison_supported;
>         bool ras_eeprom_supported;
> +       bool debug_disable_ce_logs;
>         const struct ras_sys_func *sys_fn;
>
>         struct ras_aca_config aca_cfg;
> @@ -348,6 +349,7 @@ struct ras_core_context {
>         bool ras_core_enabled;
>
>         u64 ras_fw_features;
> +       bool debug_disable_ce_logs;
>  };
>
>  struct ras_core_context *ras_core_create(struct ras_core_config *init_co=
nfig); diff --
> git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> index 67a35409ff0e..9760894c4c66 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> @@ -98,7 +98,7 @@ static void aca_report_ecc_info(struct ras_core_context
> *ras_core,
>                         blk_name(blk));
>         }
>
> -       if (ecc_count.new_ce_count) {
> +       if (ecc_count.new_ce_count && !ras_core->debug_disable_ce_logs)
> + {
>                 RAS_DEV_INFO(ras_core->dev,
>                 "{%llu} socket: %d, die: %d, %u new correctable hardware =
errors detected
> in %s block\n",
>                         seq_no, skt, aid, ecc_count.new_ce_count, blk_nam=
e(blk)); @@ -
> 114,6 +114,11 @@ static void aca_bank_log(struct ras_core_context *ras_co=
re,  {
>         int i;
>
> +       if (ras_core->debug_disable_ce_logs &&
> +           bank->ecc_type =3D=3D RAS_ERR_TYPE__CE &&
> +           !bank_ecc->real_de_count)
> +               return;
> +
>         RAS_DEV_INFO(ras_core->dev,
>                 "{%llu}" RAS_HW_ERR "Accelerator Check Architecture event=
s logged\n",
>                 bank->seq_no);
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> index 2346918c7736..cdef7727decb 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> @@ -377,6 +377,7 @@ int ras_core_hw_init(struct ras_core_context *ras_cor=
e)
>                         ras_core->config->ras_eeprom_supported;
>
>         ras_core->poison_supported =3D ras_core->config->poison_supported=
;
> +       ras_core->debug_disable_ce_logs =3D
> +ras_core->config->debug_disable_ce_logs;
>
>         ret =3D ras_psp_hw_init(ras_core);
>         if (ret)
> --
> 2.34.1
>

