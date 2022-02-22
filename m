Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C547C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 02:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A262810E5A3;
	Tue, 22 Feb 2022 02:30:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95E2F10E5AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 02:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ocp0GvqdgPwlcYVtkMaKjned9SxTfKMSh14n5nWsGBGtKp/fEfUm6tq2nU/SUdcbwphMmyrYM91bLlZoZ0czvPBV0SCWqokwtETE6dPoPEGxdKu2Ah3Ewx7dPkli415B3iGwRe77h2VRT3a9hjEAKn++8CqtEHzSwQIIyDG0zY9wg0bwZ6/qAoSK7JxWjmdNk5O1Kw+uEubgAodlCyvcn6Q/+4lr/7l/3u5m5Rnuh3K+4rNtkzK4S5Oji9JC7bVkqU5/bQtdWqXc5jY65RLb5RRGSraRItwLUwA7TM56poKJ9dhr8wSELOyJM+u4r+V7Z36gjbYBtC4g20PoIt5kDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIOzEKgXNHol+ifJmdc1A2Bb3v4eyBs8dR56tB6xjb8=;
 b=WJgjVVR84NRGXO8RY5l2u8mr1LmmSdG7rE7U7QmV9QwRyHI6qqttMKXc2EiS8M+qC3ba+VQGuu4XuR2ZLEexTlJz9S4PtoSz5Cc/l2NCPvF9xmc/0y4aRvdGri8wGnfflrr3cS9tC4OfhVKAIYvUsGRUrVnciAZ8nx8GgFlbcgpRJiclv1XEivCitrZ/lySmlK0i5tIaXMR5Q74mxMyr1QcFlYs5JWHfDctwrUUNpcCjk7uQJuNjm046etNEIF/7HAgj3sbNWAqXZudYNvRVfZu/2STMW1V74V54Mz2zXjlGS/LHBcNbDgNdiX2we8wqy7HuWgCawWQtWU06gKB8Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIOzEKgXNHol+ifJmdc1A2Bb3v4eyBs8dR56tB6xjb8=;
 b=dEjRJOJnebCUkQDiazU3maBnUmu1AsJ8sjx0bvwh8i8TsmIhzh0oxnpIN6CksMmMQcQBWeaHGpRhqfUK3DNRf2RI3B2bQj7xtfNHIpbj6ADssxbH8VS4l4EamlFFKn94lace92ZGlje1KKJ3O7670OJhRP89B9nJd75ojQJ85Ig=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 22 Feb
 2022 02:30:42 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::7d61:f517:f3f8:9ea]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::7d61:f517:f3f8:9ea%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 02:30:42 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Slivka, Danijel" <Danijel.Slivka@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: new v3 SmuMetrics data structure for Sienna
 Cichlid
Thread-Topic: [PATCH] drm/amd/pm: new v3 SmuMetrics data structure for Sienna
 Cichlid
Thread-Index: AQHYJMQv4AEYiuVs8USujfZiM4kBHaye3qug
Date: Tue, 22 Feb 2022 02:30:41 +0000
Message-ID: <DM6PR12MB2619F61204605A3EADED38E3E43B9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220218123616.10401-1-danijel.slivka@amd.com>
In-Reply-To: <20220218123616.10401-1-danijel.slivka@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-22T02:30:38Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0779b469-e15c-4cd0-b56b-93c667d7de84;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-22T02:30:38Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 7a6bcb2b-6657-46a0-b274-86e8b1926d3a
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc23cc28-ed61-44be-d101-08d9f5ab526c
x-ms-traffictypediagnostic: BY5PR12MB4180:EE_
x-microsoft-antispam-prvs: <BY5PR12MB41800FD35A61E4016F94F325E43B9@BY5PR12MB4180.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gPygETmka5u1a4p7FcuZXdrNavR1exsRP6wsZZUmr+60s7gaogkUvqpAys3ktUm5P4Hp1SbIxQL0oevGM47+zgPiqL+wNqP9PM+4hRdCo3/dbIT1EwgMmPHZjZy9pawoHMcwOI1J+wDRyVBJJgGIziFemZTity5T4inJLa8zEN5VMWuOjorD4wiKwn+m9VOMs+YTEOyI3qMB9GZZRwfwhG5QZ1p0yh9TNLBbm1EtcAHGPUFj5oA33Kp5FEOB31ZQgyJGKSSWtsDHaTUbXHa7ScBcoSsEWoXFbnfgpLUuRqVngCE7vCjbONmEJsg9Aq0nQkjYASbPQ6nZ2sK6P2RDU95Hm7jykqYkN+5Uu2dJmGg65m/9lVlhw4o4EmjpKdGxsAeZgAuYrwn1TpNQ9fqeCee9NfUxyBiyF90T2jnUHiVdrL76NRmRn2bR6UR9YP5blrDqUv91Od+RArnzlLGyOe+ey5mZqFvhQDAuXn7mpdNM433uYpyv6yyjrfOq16YwSQsyE8dtfZTJfWwMFUbCkBiVVAgzpXPeWtNo7fpog7vjW4kkrna7aIQBnnCCcU9H4h4TyHcMUvqPY/jP2OvK1SPgSNR4BGCUJyePnfFu/mN3ABBEDElfIZuau0pksMUaKUT6wEIxfCj7fQwP443cM9J7vsFCbGl/LPKOciF7cDqr/2jF0gbj5gvyjUaO62uL5WYtVxDXVu0GA9e4CHwyrQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(7696005)(6506007)(9686003)(508600001)(5660300002)(38070700005)(38100700002)(8936002)(30864003)(52536014)(2906002)(66446008)(186003)(55016003)(4326008)(8676002)(110136005)(71200400001)(64756008)(83380400001)(122000001)(76116006)(316002)(33656002)(86362001)(66946007)(26005)(66556008)(66476007)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GfAq5lsuYiwkX6wS4WuO7mLxGdcEzZpYJNnQgFBtjMd5dUVABsG+ordp/NTn?=
 =?us-ascii?Q?EJ0nlU7D37EpCHEHYMhQWHv23Rr9YatvmPIitK1jJzdADiuWCxjAGxzGui+t?=
 =?us-ascii?Q?OsKyshh0dibFExjJa4lwPZiPbCstG5hMa+SsrBlS+lTSatHGMkHnZ1fdd7Nh?=
 =?us-ascii?Q?ciwWv5S9Tm5cgW8A+jMeCh/PLmJqWwzeteICtoS/AdLKxUdQ57ZbKc2MUmyH?=
 =?us-ascii?Q?rntclmtfBiMV9Ci4MdEiYcEz4uGG7Kmt2wPJH/hVGpXDcPs01TDEa3dEhtij?=
 =?us-ascii?Q?4pVpmCsEOOzqzBzib0iah3vh6yVaQx2g1GGCsz7uAafQ9DZ6ZAm8j4PQZ9mX?=
 =?us-ascii?Q?Klevtw7ZOZvId6vmlGhpkXcKaRdz50kiOrDRKQaMyoQtfO7HCifBC96v0mld?=
 =?us-ascii?Q?YBcyBlQyO0eJx9ooFg8kDGAov6/DiBb/im/vf4c71bpMNX00RlpBM9rw3M2J?=
 =?us-ascii?Q?q51IPiQ/4valqwu70CNfoTL6wYnYEsj2tL87LE/4uIJ7pkZOPbVJ8uWO8TdX?=
 =?us-ascii?Q?/e6QpFAUe4GvqjBjwY3b3/oxn+jBSywrPmEXpkB3dyURNJbg3wmlY+DiQ+1o?=
 =?us-ascii?Q?w3RBA1E/wd4BO6YW95uQ1zeM0jOF4TcF0yKvbQh8ihhKMPAN0nNzgfE+KjSW?=
 =?us-ascii?Q?jZ0pep/F31xu9vFGrvuHOguVgdtHTx2tCiflrUZoRgwgecSJLQT3a7Cqodpu?=
 =?us-ascii?Q?oaleMYoKY39I2Llcd+fOeb2tNsX3IfWEPUzMic2n4joIPiIJkXF/Qcd9jI2u?=
 =?us-ascii?Q?PhKoQKCw44cpkGWNo8pAVHiKfE98rAey0/hs7PQBXemQdZ/PowfcwVyNMIqq?=
 =?us-ascii?Q?sIW09rpMESd6DLNj/bYw8J8+7kgx5rfEINJgzu4KOG2v7KJUQl7c6u2PJ1wl?=
 =?us-ascii?Q?q+BxnQ4NggQLyDtvRbv533SkNymKmb3eg29LDXzVDgnnpS7N1z0d/VdZfCqN?=
 =?us-ascii?Q?libTGo4QM7GD+//BpgaQWgFPwdSsd/i/vpq+YPaBxJJzY4HK4R4G2858kQgB?=
 =?us-ascii?Q?iM4Wo+aNw+llPuksbJJ6d8SCykB1r87V1cVX12LtRqak5TM4DjCXYzZpjRU5?=
 =?us-ascii?Q?0tLT4ogNUpZ6jKXFHwY+42zWhXvj7dlIVkRrb3pBP6kEDFEGX7ps/ZWVlj/4?=
 =?us-ascii?Q?/OJJD/eCixSRZ8rudCu/MBnswVyterqLtmf0kzVY8HGvBGkZgRNUkIkdz8OR?=
 =?us-ascii?Q?F7AsfouM8VuDFRdsI1ccU4JgRw8Q05cSQ2Q1e8b70lVL9cW71p7rP9vb4YEB?=
 =?us-ascii?Q?bC1wSWxtR6mG+XGHLFCNQDCVbhWnB+L+3/oJe8uoJrxAUiEkGBRKLQihjPW9?=
 =?us-ascii?Q?l1VR2fYtT08jvW6mM2KWhfxT1zt07qWQdaPuBQ9YtyUx+hng72uKWSY/Mow7?=
 =?us-ascii?Q?Lrk6SS+3eZkF57Mie2y1+QiZ8BipPR9Br+f8f3FyjVKVrcMxTgxi5mjHaz7/?=
 =?us-ascii?Q?by9a2YZFT9+vuUcp2O1+JqFD+zE/obPhnpARLcSuMO0GRW96/o1truUVdOlh?=
 =?us-ascii?Q?LqkA19aM+BP1NgVsNHLdPPT9u7eAWMK1i9nw5htbY9x/Zi8D38qrrArvrWpC?=
 =?us-ascii?Q?+bi9XaJNiYZQhBqni7M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc23cc28-ed61-44be-d101-08d9f5ab526c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 02:30:41.8836 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dcooLcXuCMPMpjdYv5kK+PeTtlwJpmjMnyqbyzxrq//+rPI+aVJTkaYy7S09Z5Si
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
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
Cc: "Slivka, Danijel" <Danijel.Slivka@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Acked-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Danijel Slivka
> Sent: Friday, February 18, 2022 8:36 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Slivka, Danijel <Danijel.Slivka@amd.com>
> Subject: [PATCH] drm/amd/pm: new v3 SmuMetrics data structure for
> Sienna Cichlid
>=20
> structure changed in smc_fw_version >=3D 0x3A4900,
> "uint16_t VcnActivityPercentage" replaced with
> "uint16_t VcnUsagePercentage0" and "uint16_t VcnUsagePercentage1"
>=20
> Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
> ---
>  .../pmfw_if/smu11_driver_if_sienna_cichlid.h  |  58 ++++++
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 181 ++++++++++++------
>  2 files changed, 178 insertions(+), 61 deletions(-)
>=20
> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_
> cichlid.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_
> cichlid.h
> index b253be602cc2..3e4a314ef925 100644
> ---
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_
> cichlid.h
> +++
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_
> cichlid.h
> @@ -1480,10 +1480,68 @@ typedef struct {
>=20
>  } SmuMetrics_V2_t;
>=20
> +typedef struct {
> +  uint32_t CurrClock[PPCLK_COUNT];
> +
> +  uint16_t AverageGfxclkFrequencyPreDs;
> +  uint16_t AverageGfxclkFrequencyPostDs;
> +  uint16_t AverageFclkFrequencyPreDs;
> +  uint16_t AverageFclkFrequencyPostDs;
> +  uint16_t AverageUclkFrequencyPreDs;
> +  uint16_t AverageUclkFrequencyPostDs;
> +
> +
> +  uint16_t AverageGfxActivity;
> +  uint16_t AverageUclkActivity;
> +  uint8_t  CurrSocVoltageOffset;
> +  uint8_t  CurrGfxVoltageOffset;
> +  uint8_t  CurrMemVidOffset;
> +  uint8_t  Padding8;
> +  uint16_t AverageSocketPower;
> +  uint16_t TemperatureEdge;
> +  uint16_t TemperatureHotspot;
> +  uint16_t TemperatureMem;
> +  uint16_t TemperatureVrGfx;
> +  uint16_t TemperatureVrMem0;
> +  uint16_t TemperatureVrMem1;
> +  uint16_t TemperatureVrSoc;
> +  uint16_t TemperatureLiquid0;
> +  uint16_t TemperatureLiquid1;
> +  uint16_t TemperaturePlx;
> +  uint16_t Padding16;
> +  uint32_t AccCnt;
> +  uint8_t  ThrottlingPercentage[THROTTLER_COUNT];
> +
> +
> +  uint8_t  LinkDpmLevel;
> +  uint8_t  CurrFanPwm;
> +  uint16_t CurrFanSpeed;
> +
> +  //BACO metrics, PMFW-1721
> +  //metrics for D3hot entry/exit and driver ARM msgs
> +  uint8_t D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
> +  uint8_t D3HotExitCountPerMode[D3HOT_SEQUENCE_COUNT];
> +  uint8_t ArmMsgReceivedCountPerMode[D3HOT_SEQUENCE_COUNT];
> +
> +  //PMFW-4362
> +  uint32_t EnergyAccumulator;
> +  uint16_t AverageVclk0Frequency;
> +  uint16_t AverageDclk0Frequency;
> +  uint16_t AverageVclk1Frequency;
> +  uint16_t AverageDclk1Frequency;
> +  uint16_t VcnUsagePercentage0;
> +  uint16_t VcnUsagePercentage1;
> +  uint8_t  PcieRate;
> +  uint8_t  PcieWidth;
> +  uint16_t AverageGfxclkFrequencyTarget;
> +
> +} SmuMetrics_V3_t;
> +
>  typedef struct {
>    union {
>      SmuMetrics_t SmuMetrics;
>      SmuMetrics_V2_t SmuMetrics_V2;
> +    SmuMetrics_V3_t SmuMetrics_V3;
>    };
>    uint32_t Spare[1];
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index d9d634ce9575..38f04836c82f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -554,6 +554,11 @@ static uint32_t
> sienna_cichlid_get_throttler_status_locked(struct smu_context *s
>  	int i;
>=20
>  	if ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 7))
> &&
> +	     (smu->smc_fw_version >=3D 0x3A4900)) {
> +		for (i =3D 0; i < THROTTLER_COUNT; i++)
> +			throttler_status |=3D
> +				(metrics_ext-
> >SmuMetrics_V3.ThrottlingPercentage[i] ? 1U << i : 0);
> +	} else if ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11,
> 0, 7)) &&
>  	     (smu->smc_fw_version >=3D 0x3A4300)) {
>  		for (i =3D 0; i < THROTTLER_COUNT; i++)
>  			throttler_status |=3D
> @@ -574,11 +579,20 @@ static int
> sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>  		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))-
> >SmuMetrics);
>  	SmuMetrics_V2_t *metrics_v2 =3D
>  		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))-
> >SmuMetrics_V2);
> -	bool use_metrics_v2 =3D ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D
> IP_VERSION(11, 0, 7)) &&
> -		(smu->smc_fw_version >=3D 0x3A4300)) ? true : false;
> +	SmuMetrics_V3_t *metrics_v3 =3D
> +		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))-
> >SmuMetrics_V3);
> +	bool use_metrics_v2 =3D false;
> +	bool use_metrics_v3 =3D false;
>  	uint16_t average_gfx_activity;
>  	int ret =3D 0;
>=20
> +	if ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 7))
> &&
> +		(smu->smc_fw_version >=3D 0x3A4900))
> +		use_metrics_v3 =3D true;
> +	else if ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11,
> 0, 7)) &&
> +		(smu->smc_fw_version >=3D 0x3A4300))
> +		use_metrics_v2 =3D  true;
> +
>  	ret =3D smu_cmn_get_metrics_table(smu,
>  					NULL,
>  					false);
> @@ -587,96 +601,119 @@ static int
> sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>=20
>  	switch (member) {
>  	case METRICS_CURR_GFXCLK:
> -		*value =3D use_metrics_v2 ? metrics_v2-
> >CurrClock[PPCLK_GFXCLK] :
> +		*value =3D use_metrics_v3 ? metrics_v3-
> >CurrClock[PPCLK_GFXCLK] :
> +			use_metrics_v2 ? metrics_v2-
> >CurrClock[PPCLK_GFXCLK] :
>  			metrics->CurrClock[PPCLK_GFXCLK];
>  		break;
>  	case METRICS_CURR_SOCCLK:
> -		*value =3D use_metrics_v2 ? metrics_v2-
> >CurrClock[PPCLK_SOCCLK] :
> +		*value =3D use_metrics_v3 ? metrics_v3-
> >CurrClock[PPCLK_SOCCLK] :
> +			use_metrics_v2 ? metrics_v2-
> >CurrClock[PPCLK_SOCCLK] :
>  			metrics->CurrClock[PPCLK_SOCCLK];
>  		break;
>  	case METRICS_CURR_UCLK:
> -		*value =3D use_metrics_v2 ? metrics_v2-
> >CurrClock[PPCLK_UCLK] :
> +		*value =3D use_metrics_v3 ? metrics_v3-
> >CurrClock[PPCLK_UCLK] :
> +			use_metrics_v2 ? metrics_v2-
> >CurrClock[PPCLK_UCLK] :
>  			metrics->CurrClock[PPCLK_UCLK];
>  		break;
>  	case METRICS_CURR_VCLK:
> -		*value =3D use_metrics_v2 ? metrics_v2-
> >CurrClock[PPCLK_VCLK_0] :
> +		*value =3D use_metrics_v3 ? metrics_v3-
> >CurrClock[PPCLK_VCLK_0] :
> +			use_metrics_v2 ? metrics_v2-
> >CurrClock[PPCLK_VCLK_0] :
>  			metrics->CurrClock[PPCLK_VCLK_0];
>  		break;
>  	case METRICS_CURR_VCLK1:
> -		*value =3D use_metrics_v2 ? metrics_v2-
> >CurrClock[PPCLK_VCLK_1] :
> +		*value =3D use_metrics_v3 ? metrics_v3-
> >CurrClock[PPCLK_VCLK_1] :
> +			use_metrics_v2 ? metrics_v2-
> >CurrClock[PPCLK_VCLK_1] :
>  			metrics->CurrClock[PPCLK_VCLK_1];
>  		break;
>  	case METRICS_CURR_DCLK:
> -		*value =3D use_metrics_v2 ? metrics_v2-
> >CurrClock[PPCLK_DCLK_0] :
> +		*value =3D use_metrics_v3 ? metrics_v3-
> >CurrClock[PPCLK_DCLK_0] :
> +			use_metrics_v2 ? metrics_v2-
> >CurrClock[PPCLK_DCLK_0] :
>  			metrics->CurrClock[PPCLK_DCLK_0];
>  		break;
>  	case METRICS_CURR_DCLK1:
> -		*value =3D use_metrics_v2 ? metrics_v2-
> >CurrClock[PPCLK_DCLK_1] :
> +		*value =3D use_metrics_v3 ? metrics_v3-
> >CurrClock[PPCLK_DCLK_1] :
> +			use_metrics_v2 ? metrics_v2-
> >CurrClock[PPCLK_DCLK_1] :
>  			metrics->CurrClock[PPCLK_DCLK_1];
>  		break;
>  	case METRICS_CURR_DCEFCLK:
> -		*value =3D use_metrics_v2 ? metrics_v2-
> >CurrClock[PPCLK_DCEFCLK] :
> +		*value =3D use_metrics_v3 ? metrics_v3-
> >CurrClock[PPCLK_DCEFCLK] :
> +			use_metrics_v2 ? metrics_v2-
> >CurrClock[PPCLK_DCEFCLK] :
>  			metrics->CurrClock[PPCLK_DCEFCLK];
>  		break;
>  	case METRICS_CURR_FCLK:
> -		*value =3D use_metrics_v2 ? metrics_v2-
> >CurrClock[PPCLK_FCLK] :
> +		*value =3D use_metrics_v3 ? metrics_v3-
> >CurrClock[PPCLK_FCLK] :
> +			use_metrics_v2 ? metrics_v2-
> >CurrClock[PPCLK_FCLK] :
>  			metrics->CurrClock[PPCLK_FCLK];
>  		break;
>  	case METRICS_AVERAGE_GFXCLK:
> -		average_gfx_activity =3D use_metrics_v2 ? metrics_v2-
> >AverageGfxActivity :
> +		average_gfx_activity =3D use_metrics_v3 ? metrics_v3-
> >AverageGfxActivity :
> +			use_metrics_v2 ? metrics_v2->AverageGfxActivity :
>  			metrics->AverageGfxActivity;
>  		if (average_gfx_activity <=3D
> SMU_11_0_7_GFX_BUSY_THRESHOLD)
> -			*value =3D use_metrics_v2 ? metrics_v2-
> >AverageGfxclkFrequencyPostDs :
> +			*value =3D use_metrics_v3 ? metrics_v3-
> >AverageGfxclkFrequencyPostDs :
> +				use_metrics_v2 ? metrics_v2-
> >AverageGfxclkFrequencyPostDs :
>  				metrics->AverageGfxclkFrequencyPostDs;
>  		else
> -			*value =3D use_metrics_v2 ? metrics_v2-
> >AverageGfxclkFrequencyPreDs :
> +			*value =3D use_metrics_v3 ? metrics_v3-
> >AverageGfxclkFrequencyPreDs :
> +				use_metrics_v2 ? metrics_v2-
> >AverageGfxclkFrequencyPreDs :
>  				metrics->AverageGfxclkFrequencyPreDs;
>  		break;
>  	case METRICS_AVERAGE_FCLK:
> -		*value =3D use_metrics_v2 ? metrics_v2-
> >AverageFclkFrequencyPostDs :
> +		*value =3D use_metrics_v3 ? metrics_v3-
> >AverageFclkFrequencyPostDs :
> +			use_metrics_v2 ? metrics_v2-
> >AverageFclkFrequencyPostDs :
>  			metrics->AverageFclkFrequencyPostDs;
>  		break;
>  	case METRICS_AVERAGE_UCLK:
> -		*value =3D use_metrics_v2 ? metrics_v2-
> >AverageUclkFrequencyPostDs :
> +		*value =3D use_metrics_v3 ? metrics_v3-
> >AverageUclkFrequencyPostDs :
> +			use_metrics_v2 ? metrics_v2-
> >AverageUclkFrequencyPostDs :
>  			metrics->AverageUclkFrequencyPostDs;
>  		break;
>  	case METRICS_AVERAGE_GFXACTIVITY:
> -		*value =3D use_metrics_v2 ? metrics_v2->AverageGfxActivity :
> +		*value =3D use_metrics_v3 ? metrics_v3->AverageGfxActivity :
> +			use_metrics_v2 ? metrics_v2->AverageGfxActivity :
>  			metrics->AverageGfxActivity;
>  		break;
>  	case METRICS_AVERAGE_MEMACTIVITY:
> -		*value =3D use_metrics_v2 ? metrics_v2->AverageUclkActivity :
> +		*value =3D use_metrics_v3 ? metrics_v3->AverageUclkActivity :
> +			use_metrics_v2 ? metrics_v2->AverageUclkActivity :
>  			metrics->AverageUclkActivity;
>  		break;
>  	case METRICS_AVERAGE_SOCKETPOWER:
> -		*value =3D use_metrics_v2 ? metrics_v2-
> >AverageSocketPower << 8 :
> +		*value =3D use_metrics_v3 ? metrics_v3-
> >AverageSocketPower << 8 :
> +			use_metrics_v2 ? metrics_v2->AverageSocketPower
> << 8 :
>  			metrics->AverageSocketPower << 8;
>  		break;
>  	case METRICS_TEMPERATURE_EDGE:
> -		*value =3D (use_metrics_v2 ? metrics_v2->TemperatureEdge :
> metrics->TemperatureEdge) *
> -			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +		*value =3D (use_metrics_v3 ? metrics_v3->TemperatureEdge :
> +			use_metrics_v2 ? metrics_v2->TemperatureEdge :
> +			metrics->TemperatureEdge) *
> SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>  		break;
>  	case METRICS_TEMPERATURE_HOTSPOT:
> -		*value =3D (use_metrics_v2 ? metrics_v2-
> >TemperatureHotspot : metrics->TemperatureHotspot) *
> -			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +		*value =3D (use_metrics_v3 ? metrics_v3-
> >TemperatureHotspot :
> +			use_metrics_v2 ? metrics_v2->TemperatureHotspot :
> +			metrics->TemperatureHotspot) *
> SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>  		break;
>  	case METRICS_TEMPERATURE_MEM:
> -		*value =3D (use_metrics_v2 ? metrics_v2->TemperatureMem :
> metrics->TemperatureMem) *
> -			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +		*value =3D (use_metrics_v3 ? metrics_v3->TemperatureMem :
> +			use_metrics_v2 ? metrics_v2->TemperatureMem :
> +			metrics->TemperatureMem) *
> SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>  		break;
>  	case METRICS_TEMPERATURE_VRGFX:
> -		*value =3D (use_metrics_v2 ? metrics_v2->TemperatureVrGfx :
> metrics->TemperatureVrGfx) *
> -			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +		*value =3D (use_metrics_v3 ? metrics_v3->TemperatureVrGfx :
> +			use_metrics_v2 ? metrics_v2->TemperatureVrGfx :
> +			metrics->TemperatureVrGfx) *
> SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>  		break;
>  	case METRICS_TEMPERATURE_VRSOC:
> -		*value =3D (use_metrics_v2 ? metrics_v2->TemperatureVrSoc :
> metrics->TemperatureVrSoc) *
> -			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +		*value =3D (use_metrics_v3 ? metrics_v3->TemperatureVrSoc :
> +			use_metrics_v2 ? metrics_v2->TemperatureVrSoc :
> +			metrics->TemperatureVrSoc) *
> SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>  		break;
>  	case METRICS_THROTTLER_STATUS:
>  		*value =3D sienna_cichlid_get_throttler_status_locked(smu);
>  		break;
>  	case METRICS_CURR_FANSPEED:
> -		*value =3D use_metrics_v2 ? metrics_v2->CurrFanSpeed :
> metrics->CurrFanSpeed;
> +		*value =3D use_metrics_v3 ? metrics_v3->CurrFanSpeed :
> +			use_metrics_v2 ? metrics_v2->CurrFanSpeed :
> metrics->CurrFanSpeed;
>  		break;
>  	default:
>  		*value =3D UINT_MAX;
> @@ -3656,12 +3693,22 @@ static ssize_t
> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>  		&(metrics_external.SmuMetrics);
>  	SmuMetrics_V2_t *metrics_v2 =3D
>  		&(metrics_external.SmuMetrics_V2);
> +	SmuMetrics_V3_t *metrics_v3 =3D
> +		&(metrics_external.SmuMetrics_V3);
>  	struct amdgpu_device *adev =3D smu->adev;
> -	bool use_metrics_v2 =3D ((adev->ip_versions[MP1_HWIP][0] =3D=3D
> IP_VERSION(11, 0, 7)) &&
> -		(smu->smc_fw_version >=3D 0x3A4300)) ? true : false;
> +	bool use_metrics_v2 =3D false;
> +	bool use_metrics_v3 =3D false;
>  	uint16_t average_gfx_activity;
>  	int ret =3D 0;
>=20
> +	if ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 7)) &&
> +		(smu->smc_fw_version >=3D 0x3A4900))
> +		use_metrics_v3 =3D true;
> +	else if ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 7))
> &&
> +		(smu->smc_fw_version >=3D 0x3A4300))
> +		use_metrics_v2 =3D true;
> +
> +
>  	ret =3D smu_cmn_get_metrics_table(smu,
>  					&metrics_external,
>  					true);
> @@ -3670,29 +3717,30 @@ static ssize_t
> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>=20
>  	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>=20
> -	gpu_metrics->temperature_edge =3D
> +	gpu_metrics->temperature_edge =3D use_metrics_v3 ? metrics_v3-
> >TemperatureEdge :
>  		use_metrics_v2 ? metrics_v2->TemperatureEdge : metrics-
> >TemperatureEdge;
> -	gpu_metrics->temperature_hotspot =3D
> +	gpu_metrics->temperature_hotspot =3D use_metrics_v3 ? metrics_v3-
> >TemperatureHotspot :
>  		use_metrics_v2 ? metrics_v2->TemperatureHotspot :
> metrics->TemperatureHotspot;
> -	gpu_metrics->temperature_mem =3D
> +	gpu_metrics->temperature_mem =3D use_metrics_v3 ? metrics_v3-
> >TemperatureMem :
>  		use_metrics_v2 ? metrics_v2->TemperatureMem : metrics-
> >TemperatureMem;
> -	gpu_metrics->temperature_vrgfx =3D
> +	gpu_metrics->temperature_vrgfx =3D use_metrics_v3 ? metrics_v3-
> >TemperatureVrGfx :
>  		use_metrics_v2 ? metrics_v2->TemperatureVrGfx : metrics-
> >TemperatureVrGfx;
> -	gpu_metrics->temperature_vrsoc =3D
> +	gpu_metrics->temperature_vrsoc =3D use_metrics_v3 ? metrics_v3-
> >TemperatureVrSoc :
>  		use_metrics_v2 ? metrics_v2->TemperatureVrSoc : metrics-
> >TemperatureVrSoc;
> -	gpu_metrics->temperature_vrmem =3D
> +	gpu_metrics->temperature_vrmem =3D use_metrics_v3 ? metrics_v3-
> >TemperatureVrMem0 :
>  		use_metrics_v2 ? metrics_v2->TemperatureVrMem0 :
> metrics->TemperatureVrMem0;
>=20
> -	gpu_metrics->average_gfx_activity =3D
> +	gpu_metrics->average_gfx_activity =3D use_metrics_v3 ? metrics_v3-
> >AverageGfxActivity :
>  		use_metrics_v2 ? metrics_v2->AverageGfxActivity : metrics-
> >AverageGfxActivity;
> -	gpu_metrics->average_umc_activity =3D
> +	gpu_metrics->average_umc_activity =3D use_metrics_v3 ? metrics_v3-
> >AverageUclkActivity :
>  		use_metrics_v2 ? metrics_v2->AverageUclkActivity : metrics-
> >AverageUclkActivity;
> -	gpu_metrics->average_mm_activity =3D
> +	gpu_metrics->average_mm_activity =3D use_metrics_v3 ?
> +		(metrics_v3->VcnUsagePercentage0 + metrics_v3-
> >VcnUsagePercentage1) / 2 :
>  		use_metrics_v2 ? metrics_v2->VcnActivityPercentage :
> metrics->VcnActivityPercentage;
>=20
> -	gpu_metrics->average_socket_power =3D
> +	gpu_metrics->average_socket_power =3D use_metrics_v3 ?
> metrics_v3->AverageSocketPower :
>  		use_metrics_v2 ? metrics_v2->AverageSocketPower :
> metrics->AverageSocketPower;
> -	gpu_metrics->energy_accumulator =3D
> +	gpu_metrics->energy_accumulator =3D use_metrics_v3 ? metrics_v3-
> >EnergyAccumulator :
>  		use_metrics_v2 ? metrics_v2->EnergyAccumulator : metrics-
> >EnergyAccumulator;
>=20
>  	if (metrics->CurrGfxVoltageOffset)
> @@ -3705,37 +3753,45 @@ static ssize_t
> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>  		gpu_metrics->voltage_soc =3D
>  			(155000 - 625 * metrics->CurrSocVoltageOffset) / 100;
>=20
> -	average_gfx_activity =3D use_metrics_v2 ? metrics_v2-
> >AverageGfxActivity : metrics->AverageGfxActivity;
> +	average_gfx_activity =3D use_metrics_v3 ? metrics_v3-
> >AverageGfxActivity :
> +		use_metrics_v2 ? metrics_v2->AverageGfxActivity : metrics-
> >AverageGfxActivity;
>  	if (average_gfx_activity <=3D SMU_11_0_7_GFX_BUSY_THRESHOLD)
>  		gpu_metrics->average_gfxclk_frequency =3D
> -			use_metrics_v2 ? metrics_v2-
> >AverageGfxclkFrequencyPostDs : metrics->AverageGfxclkFrequencyPostDs;
> +			use_metrics_v3 ? metrics_v3-
> >AverageGfxclkFrequencyPostDs :
> +			use_metrics_v2 ? metrics_v2-
> >AverageGfxclkFrequencyPostDs :
> +			metrics->AverageGfxclkFrequencyPostDs;
>  	else
>  		gpu_metrics->average_gfxclk_frequency =3D
> -			use_metrics_v2 ? metrics_v2-
> >AverageGfxclkFrequencyPreDs : metrics->AverageGfxclkFrequencyPreDs;
> +			use_metrics_v3 ? metrics_v3-
> >AverageGfxclkFrequencyPreDs :
> +			use_metrics_v2 ? metrics_v2-
> >AverageGfxclkFrequencyPreDs :
> +			metrics->AverageGfxclkFrequencyPreDs;
> +
>  	gpu_metrics->average_uclk_frequency =3D
> -		use_metrics_v2 ? metrics_v2-
> >AverageUclkFrequencyPostDs : metrics->AverageUclkFrequencyPostDs;
> -	gpu_metrics->average_vclk0_frequency =3D
> +		use_metrics_v3 ? metrics_v3-
> >AverageUclkFrequencyPostDs :
> +		use_metrics_v2 ? metrics_v2-
> >AverageUclkFrequencyPostDs :
> +		metrics->AverageUclkFrequencyPostDs;
> +	gpu_metrics->average_vclk0_frequency =3D use_metrics_v3 ?
> metrics_v3->AverageVclk0Frequency :
>  		use_metrics_v2 ? metrics_v2->AverageVclk0Frequency :
> metrics->AverageVclk0Frequency;
> -	gpu_metrics->average_dclk0_frequency =3D
> +	gpu_metrics->average_dclk0_frequency =3D use_metrics_v3 ?
> metrics_v3->AverageDclk0Frequency :
>  		use_metrics_v2 ? metrics_v2->AverageDclk0Frequency :
> metrics->AverageDclk0Frequency;
> -	gpu_metrics->average_vclk1_frequency =3D
> +	gpu_metrics->average_vclk1_frequency =3D use_metrics_v3 ?
> metrics_v3->AverageVclk1Frequency :
>  		use_metrics_v2 ? metrics_v2->AverageVclk1Frequency :
> metrics->AverageVclk1Frequency;
> -	gpu_metrics->average_dclk1_frequency =3D
> +	gpu_metrics->average_dclk1_frequency =3D use_metrics_v3 ?
> metrics_v3->AverageDclk1Frequency :
>  		use_metrics_v2 ? metrics_v2->AverageDclk1Frequency :
> metrics->AverageDclk1Frequency;
>=20
> -	gpu_metrics->current_gfxclk =3D
> +	gpu_metrics->current_gfxclk =3D use_metrics_v3 ? metrics_v3-
> >CurrClock[PPCLK_GFXCLK] :
>  		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_GFXCLK] :
> metrics->CurrClock[PPCLK_GFXCLK];
> -	gpu_metrics->current_socclk =3D
> +	gpu_metrics->current_socclk =3D use_metrics_v3 ? metrics_v3-
> >CurrClock[PPCLK_SOCCLK] :
>  		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_SOCCLK] :
> metrics->CurrClock[PPCLK_SOCCLK];
> -	gpu_metrics->current_uclk =3D
> +	gpu_metrics->current_uclk =3D use_metrics_v3 ? metrics_v3-
> >CurrClock[PPCLK_UCLK] :
>  		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_UCLK] :
> metrics->CurrClock[PPCLK_UCLK];
> -	gpu_metrics->current_vclk0 =3D
> +	gpu_metrics->current_vclk0 =3D use_metrics_v3 ? metrics_v3-
> >CurrClock[PPCLK_VCLK_0] :
>  		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_VCLK_0] :
> metrics->CurrClock[PPCLK_VCLK_0];
> -	gpu_metrics->current_dclk0 =3D
> +	gpu_metrics->current_dclk0 =3D use_metrics_v3 ? metrics_v3-
> >CurrClock[PPCLK_DCLK_0] :
>  		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCLK_0] :
> metrics->CurrClock[PPCLK_DCLK_0];
> -	gpu_metrics->current_vclk1 =3D
> +	gpu_metrics->current_vclk1 =3D use_metrics_v3 ? metrics_v3-
> >CurrClock[PPCLK_VCLK_1] :
>  		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_VCLK_1] :
> metrics->CurrClock[PPCLK_VCLK_1];
> -	gpu_metrics->current_dclk1 =3D
> +	gpu_metrics->current_dclk1 =3D use_metrics_v3 ? metrics_v3-
> >CurrClock[PPCLK_DCLK_1] :
>  		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCLK_1] :
> metrics->CurrClock[PPCLK_DCLK_1];
>=20
>  	gpu_metrics->throttle_status =3D
> sienna_cichlid_get_throttler_status_locked(smu);
> @@ -3743,12 +3799,15 @@ static ssize_t
> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>  			smu_cmn_get_indep_throttler_status(gpu_metrics-
> >throttle_status,
>=20
> sienna_cichlid_throttler_map);
>=20
> -	gpu_metrics->current_fan_speed =3D use_metrics_v2 ? metrics_v2-
> >CurrFanSpeed : metrics->CurrFanSpeed;
> +	gpu_metrics->current_fan_speed =3D use_metrics_v3 ? metrics_v3-
> >CurrFanSpeed :
> +		use_metrics_v2 ? metrics_v2->CurrFanSpeed : metrics-
> >CurrFanSpeed;
>=20
>  	if (((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 7)) &&
> smu->smc_fw_version > 0x003A1E00) ||
>  	      ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 11)) &&
> smu->smc_fw_version > 0x00410400)) {
> -		gpu_metrics->pcie_link_width =3D use_metrics_v2 ?
> metrics_v2->PcieWidth : metrics->PcieWidth;
> -		gpu_metrics->pcie_link_speed =3D
> link_speed[use_metrics_v2 ? metrics_v2->PcieRate : metrics->PcieRate];
> +		gpu_metrics->pcie_link_width =3D use_metrics_v3 ?
> metrics_v3->PcieWidth :
> +			use_metrics_v2 ? metrics_v2->PcieWidth : metrics-
> >PcieWidth;
> +		gpu_metrics->pcie_link_speed =3D
> link_speed[use_metrics_v3 ? metrics_v3->PcieRate :
> +			use_metrics_v2 ? metrics_v2->PcieRate : metrics-
> >PcieRate];
>  	} else {
>  		gpu_metrics->pcie_link_width =3D
>=20
> 	smu_v11_0_get_current_pcie_link_width(smu);
> --
> 2.20.1
