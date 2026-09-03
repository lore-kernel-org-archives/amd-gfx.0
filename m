Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4534C624D6
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 02:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF5010E041;
	Thu,  3 Sep 2026 02:29:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pVWc6bFY";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011058.outbound.protection.outlook.com [52.101.57.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3191F10E041
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 02:29:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rubajaTlCHD6IU7ZuwjaYFtwBCx7yxAgmZ8lMTqX4Db8ARE0CTjMMPBo4dtH4QFeHxW4n5ovOCA0k6VSA5At6FZKVrRUXeUCi9KjRxegqhzy0VE6HPRcgyZEzr6r6kQRyU9faLKdL6BBt+l8FjEA2B+LLMbTLBWvkvqeh4VFAJTs3QIU7+fNxXmY6/EP4C/4Z8vbMqUI+tUuV0bFxCqs5bUHXfDuRZ83xTdDPh6T/I1YokPvafgeUCwd62RTojlYJAjv8y8PTtUZDp3P/FFut8r65ymgv3FrLfsKl33mQuDmiNkwscXY+N2vdb7Fo0lP5R32Tw7USqbGXQwhPzCpfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35mkh+AR/a8pKs/4z1NvExXzndHYJywgSCGgTu6psTg=;
 b=s2LGQhSJ2NN1tqcSoBwJhcvatgtaKs2bfPrXwtMmg19YvXF1+oLB3GCdt0yrqqvdnkCcOh1vFT95OUJAOngu+r6nQzXRWA+f3FeTXFjZIJKFjXgTcr/qFEXA4FawLjICTWVvmLSHKQ0SmXZzeqC0G0VNI0AkcKhO4OVGi35aCjke+/A/y4Liorml6AFlJH0bN6rY1VMx4+R5hxNRDVN3qbqAHHQy0Ucrxlq89PLeW5x3IDENUqGviXqnNjIRG4xvoBGDElSBRizBJsnC2Ewm65LK3wmxH3xW8HOCUsZyAtXBR5Nu4dVqkMJGMr0dPLn+knljToWrlbc4p8kovVt4DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35mkh+AR/a8pKs/4z1NvExXzndHYJywgSCGgTu6psTg=;
 b=pVWc6bFYk/siAFNCnq8UUUMRE8KHn4/T10HCkB7FLuWx1dhiWDGdT1x5y4X7wJEAcNN9b+wbJIqgJDsH5fxRT8sjsG6JH7pCi2kBtgsI0skhTcvDdkYk27khDt8leQOavA69qRONPkgDBNPJaILp9r8SDxmu1bl5qGNZYWKOXM8=
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by SJ2PR12MB9138.namprd12.prod.outlook.com
 (2603:10b6:a03:565::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 02:29:25 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 02:29:25 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/gmc12: drop duplicate gmc.init_pte_flags
Thread-Topic: [PATCH] drm/amdgpu/gmc12: drop duplicate gmc.init_pte_flags
Thread-Index: AQHdOyQMrCDcuCA+oUe6OmFqGkENDLa8Ia8w
Date: Thu, 3 Sep 2026 02:29:24 +0000
Message-ID: <PHXPR12MB99925629249AD9785B49359650EEB62@PHXPR12MB999256.namprd12.prod.outlook.com>
References: <20260902214241.2903550-1-alexander.deucher@amd.com>
In-Reply-To: <20260902214241.2903550-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-03T02:29:02.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PHXPR12MB999256:EE_|SJ2PR12MB9138:EE_
x-ms-office365-filtering-correlation-id: d9fbec4e-3382-4538-2084-08df09632bb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|38070700021|10067099003|11063799006;
x-microsoft-antispam-message-info: zn5t/9yzyrhDhO+cKUWMZuyvEbKG2ZIYGtsu1gSI0oUSN+lNy5L8jO5evxwXFkuU/A33BXfBVyT9u9VMnjUM9Ur73WGAMMcuNmzfVRhZnCeYv277gpwaNwpvi1FheUYuJCn/6qcf+Zr+NdUv+aAunxvderMwc2iD7sKAjnqrrAipD7+6vdTXJFJ7MBeOiqdMXQHRCWmbCKmntQI4xvOtIm42+cLCAMXyaeZh5vXECc95/WVXM/VX1Sl3UcmHRzaVk8qr09mQsX2IhlfadK3gWFt2+HNUQeWE29FPPXT7xwNAxsoe783J6JStofB/XTswL9EltbDUHMyEpGu7yIqdhWyBFlF12WMHuJCIM9QZgct5s5goE0pIRASJBcZQz9meED6Mvk95SKsgD2aSxxUtlDqMmgYu8T87kf6ZvK71tvQ4vKv6ykYYTNnT19fJ/C4lYFdMRsAE/ol/QY44Mm+ciGYg6yZPcBEqJaD4yQn8JnoJfrdQ5cqlFnOImlcLoxmoowGlWakh/NrICxRfdfvT4S25TQp8SRI23Z2tOiLeoM5EpOuUUOT1AiZoVGyE9Nf/BlaPQCITl+kQDrrJqUz9z2dYOvAG9Me+7lk/lzxQsYH0DQROvbNfZJuYI5CQ2flHvjyddPECjro0kXxvRdf1WBdNpgtoF96dczePgHEY/7nhlU1WojmDhi+72zqBvEmFZjPMK+yf0MY4cWaFbE0j57tYgAmRf2W+EW10xKMuFPM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3bcm4kMeTCPbBc3zppSBHJSdRoRqkbuObZbc+iQP3Fe/4m1Idsm+wIf+M6Jm?=
 =?us-ascii?Q?CRwBgEfXyjKsDgfON00W0aiQL4NQxYv//+2CBdwbwbDlNmA7GI0gcNVzXzRA?=
 =?us-ascii?Q?l8tqf588gGUjnjfpoNfLHC+tpN9xvz2nb5x+/c6pg6HorqCpKdmnS7oqvAJA?=
 =?us-ascii?Q?ZSIUlM7Hztf53idFTR9A8vu/E1ZsgvyDieurPALskG8IEefKybbZi2+nltYT?=
 =?us-ascii?Q?6Z3tyA3qm85bNeShYvmt6M4ZTmvOrzxc8Cb7kqFKhrSQUHp+rgdYXhwcp3GP?=
 =?us-ascii?Q?mLXF308SnB9Tc8SkPjxj8QuRWrX1cbiKQroTIiKJHANw6g9nAHab69/OVivV?=
 =?us-ascii?Q?eMJe4zBUk0bEsy/gvpwCGxvGqoU+4TgoxJ1xYG4cpGs9Hh1aXP19rhNY4Znr?=
 =?us-ascii?Q?7hb1go7X7S2h9awvFHvF/4ED7HuVj4i8EQtMSY79r6hYehMxCWErMY6V858F?=
 =?us-ascii?Q?vJc4tDWKHWE3HF3C+GkOGvByDwz95d51YzsqP7uYCzevDyszE4WXAzP7PM7h?=
 =?us-ascii?Q?i7jEjYiknx3SNYaO/MU8VGsQqyZ6xibIPP+5W70/Gc4GY2IOMIydeNyRA486?=
 =?us-ascii?Q?OnOMzubHnalNC+lnlYn9qoj0uxoFRh6U+IGTnqM2j106A30j8Az/1mF5Kret?=
 =?us-ascii?Q?zsi0e294fNAS056qKOV3ZlfvJ/EmWLYg+oyTEKEmd+do4jtKGU2ttFYvFG+h?=
 =?us-ascii?Q?+zPDIANvL4G7ZVY6jiA8/xMs/PZQkv7lNfbKi+uMU/MorGz53mJ4ztGRUCPQ?=
 =?us-ascii?Q?tLHRFstWiRpSOidJQ3muBU0C2spyA1wLbkjSfuVzOI5cO4FuJ+LCkHc3FTHX?=
 =?us-ascii?Q?8Add9/bZv4w2XXY+M1ykcFfodDbW5jyxU2fqCviCupSGAv8VBCiWBmq0KlE4?=
 =?us-ascii?Q?C49LdPCpibcC/VZVJUqk4PpFVArr8Iua3BWYj9LgNq+X32cAE/yRwKe+TS1Y?=
 =?us-ascii?Q?F1xG4FJtz8UEOjdXoq4ExQ/Q3X7xky2QGDrZnTLngxuE0UJf1YwDNWMRznHF?=
 =?us-ascii?Q?yxawuEWOxviy0i2pcYCHs8Vjdsji4ytbhYubkPj1VyeXRU18uGqUOkNnlYTh?=
 =?us-ascii?Q?k3L5HqIOKDLS9qXJiM/e0WGxitGPUs6Pe3gOTEf8gSMUAyane3kGNNWxun9h?=
 =?us-ascii?Q?Pj4aXBCOsLqcAiuzA4LyviHJsadIj1sD6n2nZaHnKX0TrhwCawb6tW+inZR7?=
 =?us-ascii?Q?jTRSnprWsInG7YSgNwXprIfPdObMQsEUuqVEWZbAZKiWsmAzzFWt6uxJA2wN?=
 =?us-ascii?Q?x8g9bSTPbYkMvqXJsmDf3dF1td4IgHU1WL84FceP/JnTRvxu3obYQ4avnJkg?=
 =?us-ascii?Q?pxnSZRmIwcdNrWbJRNgpjO7psif0lVb7S67jPXjPTdw4nS1tKm25S3SDH2bo?=
 =?us-ascii?Q?8oGMz8DAGR5WoDh5hjJH+erM7p0igisMvV0qihdk4T0Nd1/quIrGUQGMyxJ2?=
 =?us-ascii?Q?cEqiedi24efQl5332srUmroCRKwpPOTuRZzB/SwKKmJNVXiN4dHcLDh0LRKx?=
 =?us-ascii?Q?3BMFaB53pgDuZ0P9rSzVqXNwRylr8iU7kLAVRRcxUhnR43H4Z7XUsGm5AJqC?=
 =?us-ascii?Q?Nw9b/VDcB23dHx4W5vQEbCpvnddPUjwkP0/avonoPABTMMHHgDX8GBGN7bFG?=
 =?us-ascii?Q?7F2m2LMtwkKuF10744tGhwpJqJd/JQy4/ZdJkveBMGnW81Rly1pp3owcynyl?=
 =?us-ascii?Q?T3uJ/S5KhrUB2142U2f1RaoTVUPX6AuUhg2h7zsKHqZ6KwdH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fbec4e-3382-4538-2084-08df09632bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 02:29:24.9460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Pf3F0rIsWNxCMtPcdpTcakRaVDCIN/So4iwUhtJcCH0rW98ugo/qZ5yS1gtUn1QB8AiJRqYU70wq/sWDckQHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, September 2, 2026 5:43 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/gmc12: drop duplicate gmc.init_pte_flags
>
> This is now set for all GMC 12.x variants in
> early_init() so drop the duplicate setting.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 0cc73982ed6f9..b6cd6babb035a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -861,7 +861,6 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>               pte_addr_mask =3D 0x000FFFFFFFFFF000ULL; /* 52 bit PA */
>               dma_addr_bits =3D 52;
>               adev->gmc.translate_further =3D adev->vm_manager.num_level
> > 1;
> -             adev->gmc.init_pte_flags =3D AMDGPU_PTE_IS_PTE;
>               break;
>       default:
>               dev_warn(adev->dev, "Unrecognized GC IP version:
> 0x%08x\n",
> --
> 2.55.0

