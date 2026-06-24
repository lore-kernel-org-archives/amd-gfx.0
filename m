Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F743CDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 02:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 158E910ED2C;
	Wed, 24 Jun 2026 02:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qDJCj0/N";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010047.outbound.protection.outlook.com
 [40.93.198.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 005E810ED2C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 02:01:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdQJNEE/xOjMKEkiLVTSqWjiHpq3vJTlBnEHpfph8MCUPtB5xM18AROfnW6sSIDPF96WtJ9aacCaWHH7SFqTe83lgh6LbwmFTNCOCLPTDr+vPJDvUixXbi9TyGqlGQ5U/JVeNfTNDmnCjf0ROAd4bso8v55i5K76ggjPee5ZjXiHtcaES997yUujl886ENPhDsKucEAcgo6nshc4G0dDCAQ/ak/7v485B6mugh7q9D0pjLZ0btN/yqRgHW7/JRr00IRv6p1Ca1Qq4GT7CYYnSSeA/VhHMHYcB7YHX3kHQtLo6XYazg9pMxsGPIAq6Kve/hfcNpWylJvHEhJXoa/hcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aT5z/NylskevOHSba1l4Oc+6uI7DZy+DvzG7NTbnsqc=;
 b=HFd6LJouZ4kBf7jhV8rsZU98zq/kFH4GWanK5lHeAkN1icPlFbleLbDQnt9hQPZQP9fzVFDYVj2eyXEaTTQ2PyZMI+0frGlmu1PLNa5SSBlS/VaE+kzHp2yblBGUzKxCFUD7m56V45UfkyZX5ZmfKZuapJPx8b3jwHzPPsVlDLu4sNfEEc0VtLR7n50JejLEUrj3vZqAZY4od1n/ImSQ4WE2GhygHkDPLGFtRJQC07MGRy0qY71pRHAB2tDzwvK0aJZZrn3kiklDK9YsYzlMzr++SmH/U/1gG8pP0y6InVCDP9sgQdqau1iyNcSI1yDUwyOjSlPE2V4ntUg6yeMwhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aT5z/NylskevOHSba1l4Oc+6uI7DZy+DvzG7NTbnsqc=;
 b=qDJCj0/NPA+ZsvM5ZuiWuDqG9z2EGIWhlNlQGUDMYdBwsO3XOHmj0SycvuRne+txR57T70ff5D6FrEpeOWQPEr/pGkUSgHvhRwyZnpWcGZiVDLPE/TNETqf30AKluYj4PQ0Cj1LgaqZgYJgLd/IOwGUlrdvs4pzJVTNU2rxPnAM=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 02:01:39 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 02:01:39 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
CC: "Lin, Amber" <Amber.Lin@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Add gfx12.0 queue reset support to topology
Thread-Topic: [PATCH] drm/amdkfd: Add gfx12.0 queue reset support to topology
Thread-Index: AQHdAxnW/tqwzHMmR02FSuG7YYsq9rZM7YgA
Date: Wed, 24 Jun 2026 02:01:39 +0000
Message-ID: <DM4PR12MB515225C475F34A5B50158F15E3ED2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260623140825.71342-1-amber.lin@amd.com>
In-Reply-To: <20260623140825.71342-1-amber.lin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-24T01:36:24.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|PH7PR12MB7332:EE_
x-ms-office365-filtering-correlation-id: 05c04f67-11ed-4772-5108-08ded19487b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|38070700021|56012099006|11063799006;
x-microsoft-antispam-message-info: HMfEB8AZ0gJgQ/gNxqgjivxiBK4opYivvPxHGlAOgC8YU/k8TVse34ybOr1EAWueC+nCZ9k8pJUxyGxhC0BkuOgDpxmhenpLa3RqhGvZYqyzIZ8UPidkojl/Po7xJ8fLXpKLji+aUDO3wC6CyLJF5asn6VqJ61rfh7M5LF4X6i1BVCgFQbu4c8qjqqONaZcDMW6NXE+FLbwKuzxJ0EfM2rhNT/zYeaa39IwAy5rDw6oE5TgHNfKxMicjWFzlzC07IMkO2FCy8mIdk5rGYW7Rs12n51+MJ90R6kFGvrVO8orVEdvljS4SUru/fGHg+PXm8tXvyjEEweyj98UZMA0g8sSnYowW4B48GNblHFGgx6u55Kwjn+/usa6y2fWB5vecS3BfUKX/3AOU5j5Ocv3mHrPQhvxlO+65xFCmKBrMU9wz9O+YjfdnSNh/NnuS/ooSEFU5B1Q+Vpa0g2zoNhX+unJlWQB/pTk5DlFyzT/kzbKE99/ICmY8Xtu7liRKzi4p0KxYMzIxwRgxN8OL+biV9zN/BqbfH+T5bVbdolPI6g+HfBk6gmHMh+O7XEFTKASe1+fiMVyuCWhDrmIn10ecpjGwaFlpx+zE+onzLwNCxdfzT5Qoyr4nc35bwHxhZKj2rf+aoRBD7WGl1lhX+dSDnDvo+B110RuL/sixKrvJBBBbzZoAg3xozdPphLBhtQp5FDMSm5DYFqcaw+Cjyes93eBWC2Q7vvapEOCWFnAarqQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5deFERN+Ts1zeb9vatNiTQfy0zli0APTYNseqaDsEQ4qvQREdrTiXKXgA2mW?=
 =?us-ascii?Q?1HUJRQ9QFFXFD13VdGV2NR3nQ8g+fFnzoohGjYmHqoqDKsuVcbubl9IaenFx?=
 =?us-ascii?Q?3eumVkeQl1Qucdf/U/XFLAvv/t9hrzw6+jXqIscQcklMV9Ki7Y0uNZOrM2hr?=
 =?us-ascii?Q?nybWnsQTjnVR1e62bxhx6Y4E3b6SyrQ8NIhY7lggtUafRzrGQd88kaM2C+6T?=
 =?us-ascii?Q?sis15SaQTyteRw9KLnncNjQKq50JiVZXAViYkHdBoWpGOeyaA0M076Pn+/Tf?=
 =?us-ascii?Q?AxvTPhX1OF9bKoqdu2ZyOvXyTYan1ZCLskG0I3WA/NvbzerDGMMN4/Z/LNjm?=
 =?us-ascii?Q?AWRGF/HmxWQePXa9iM6c6xpxJ7chmruz2Q3N6D5rOSjDnDBq99DNCyPqK8Xl?=
 =?us-ascii?Q?3wUkHYRkjQJK7ijvX2jZBbqNQr+SrvRJtink2zlA85m2xbdHC87JYs6iiH8Q?=
 =?us-ascii?Q?RT7oaMbcV8Ma9sKkCdBEo7Di9Y0ogoA9+oZjolQAV7IWv4S8L6EbkZfdQKyL?=
 =?us-ascii?Q?DRzavGYaZeInlsoadR3h5tXl4a2/0Cklp2ZBEErImuv2Uwl/G8W04YCdgSwO?=
 =?us-ascii?Q?qvn4JMfjy8dcRpFkHwiRkzHnXVB0DE5aNA3s8Eja7xobY8FZ1+Vdl/0x+PAE?=
 =?us-ascii?Q?EHZKFu9so5hLX8WIEUXF9Uftq+Sbx/9mLw7r2UHaV7TiyK+Q3A0TkALlx7oo?=
 =?us-ascii?Q?48kB5d4wjlk+Eondzc3hgw+UlWb7ug9Lpzy1NZIRaWOclf9dDA2eYLY9IUCt?=
 =?us-ascii?Q?bqbv5IIf19d7tyce/Cm/1A3DsgzPBLjEFQVRbVWiOk/MH2pXLskTgufLW62/?=
 =?us-ascii?Q?cqsSPvnZeoP5AXNmL9ykfgqNZbWI1RFkR+5XnRLdgqSiGvE897zdI/S5mhb2?=
 =?us-ascii?Q?wPfpq1gSzmAIjWGKBBsU8wAsU99royNf6VS5XkNohAzWbJhh+L8KS8cJ599e?=
 =?us-ascii?Q?KVXfsotHIrFp4i8HLZgoSNKSXUTGW2KGMrQDXNeIF9nDSS9K51WNY20FfWvL?=
 =?us-ascii?Q?dN2wygkiXXmZWmDH2Orwn7oGWykJrdPWTVaCMRRoqX/BJYTmY05yFrhf76IJ?=
 =?us-ascii?Q?BkI13XeLimhl0MLFqZnAcj1eE+RYJXLipW7xNqXHvVHMzZSw9kyUcrw4JB67?=
 =?us-ascii?Q?E+P4VwCASG0UNmU7mi98lC0IpG47xpBtv+9hN/6Ipf2ksyOXJEB/ZQOsBrbW?=
 =?us-ascii?Q?UI7G6TQN3osmcMGFoAku3Z2UQh//O/Yl049DmG+CyjZ3Ljk79n4PYDvmIJr5?=
 =?us-ascii?Q?LtfgoRF9LbpyCuNPRHioxBTFccNNxVLTIDEDGOctNEYGluhyF5r+Ve6DrF+m?=
 =?us-ascii?Q?+mXXw8HqIi4ryO/kZgzGbnHTzh67eNi3PtvZsGFSxUFHMjHv2pxEeMPHMwG9?=
 =?us-ascii?Q?/dhkiYLlxVyX683J/qH4AeQkwksyS2omA7g+y+AtvEY3aWH7tr88UjO88BLB?=
 =?us-ascii?Q?E1FuNCe18csYgEO5Y6pnifopkB6MO/i5T16Je2ni8MfWyo41We9raKDdcO5D?=
 =?us-ascii?Q?FzJeulHShRlwJ2CYKqGUtvmSMdr9+7H8lAt7ZKCbluA85Pbmptb+J9wcrpMu?=
 =?us-ascii?Q?BbYY3taH8uVGCxGKeG3L2tA85SJ8qQ3V3vtcY7ZP11tQhxnbe7lmdbswycdP?=
 =?us-ascii?Q?o3Flld1i2oir/YY98oK9YKohWeJTd+GJ6la989aAkTbYfLn6ijJ54oSjpN2v?=
 =?us-ascii?Q?zwEU8dWmlqBYSqHUvs8RXYl8Dr9RmAcOGyXm3sOYdFhLGlc8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c04f67-11ed-4772-5108-08ded19487b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 02:01:39.4960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tx3unAGgZuxMncKwQVEaJvmfAM/uEJSsakZBX/Xnu7PgZrx6UWdcBuDrRyEHVRZ4b+A0UFbdTHmgjNqy1BA2DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Amber =
Lin
> Sent: Tuesday, June 23, 2026 10:08 PM
> To: amd-gfx@lists.freedesktop.org; Liu, Shaoyun <Shaoyun.Liu@amd.com>;
> Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Cc: Lin, Amber <Amber.Lin@amd.com>
> Subject: [PATCH] drm/amdkfd: Add gfx12.0 queue reset support to topology
>
> This adds queue reset support in KFD topology for gfx12.0.0 and
> gfx12.0.1 on non-sriov mode.
>
> Signed-off-by: Amber Lin <amber.lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index f56b55ef1edd..80f7b14a2e47 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -2020,10 +2020,12 @@ static void kfd_topology_set_capabilities(struct
> kfd_topology_device *dev)
>       } else {
>               dev->node_props.debug_prop |=3D
> HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
>                                       HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
> -             /* gfx11 dGPU */
> +             /* gfx11 dGPU and gfx12.0 */
>               if ((KFD_GC_VERSION(dev->gpu) =3D=3D IP_VERSION(11, 0, 0) |=
|
>                    KFD_GC_VERSION(dev->gpu) =3D=3D IP_VERSION(11, 0, 2) |=
|
> -                  KFD_GC_VERSION(dev->gpu) =3D=3D IP_VERSION(11, 0, 3)) =
&&
> +                  KFD_GC_VERSION(dev->gpu) =3D=3D IP_VERSION(11, 0, 3) |=
|
> +                  KFD_GC_VERSION(dev->gpu) =3D=3D IP_VERSION(12, 0, 0) |=
|
> +                  KFD_GC_VERSION(dev->gpu) =3D=3D IP_VERSION(12, 0, 1)) =
&&
>                    !amdgpu_sriov_vf(dev->gpu->adev))
>                       dev->node_props.capability |=3D
> HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
We have enabled this queue reset flag for gfx12. Do we need to revert the c=
ommit firstly?
commit ecab22cd95dbd  drm/amdkfd: Add queue reset support to gfx12.0

Jesse
>
> --
> 2.43.0

