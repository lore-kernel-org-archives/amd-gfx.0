Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C259FCF6BE3
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 01:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DDC710E04B;
	Wed,  7 Jan 2026 01:50:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="khi+171L";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 148B710E04B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 01:50:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVNmeUPtqN/2gYhGjER58HI4VQTU8GBtaq0YFWWvwf0lvMlRFV21v45w9Nj0c2P9OTxsChwxnVIjH6C7gP2Pn0Iz9rTDi3816iydGbzgMqMU9rm/KtTS0SGagc0OUSqX+xxAhUbiqT9vreIiNZSai1koQkh0KD/GtauPVq+4jBIaJpy52vZzjd3RjTfZjOAt9zMDZiPlmNFIsnxf2TKRXdg09829hJF5k+ZzmyTdBDimQyt+uyfRgLSye6r60CuEp5v28BE5X8XCkliCKeSrES/LAjS61+6XDh8sIAevRiqqopoD5IPPImbWhgfffB0KqHU9RPG+kIwzgncfAn0B/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ynDuowNFK2R8znn0Li9QBGeVCNpHxvsSzxdmvj0glo=;
 b=A/In4ws+oD9NdRTaE3kNaHm+BtqnpINEU5QyZZ/6Ya+REjdMo+PBq8BbEcF6t0Fm4sswHUB+BbwRiXh8l9awOMen72MqOPNB3nxxoF8RLyRw+wa5dTSUkXaJxSuj2PLTjL1iQaSldC72civr98SC2d2hDdX4rTGQyssXOCm74TbNpP3EkDb7FbTQ0b8u22WyC1n59eSFQt3biz22GzMrLJDoNfWi+Zsp+T7J+5o8TVvfojlbJ2xULqR3ZwvInrHQjFFP1bnWiqmXa5WMSAki9eHiOl0xZLZweMlIA4tFtuiDemLPxjWlqE8KcwcUfgpqR7popfILma+FviKepF6PIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ynDuowNFK2R8znn0Li9QBGeVCNpHxvsSzxdmvj0glo=;
 b=khi+171LPTLYIbBtJ1MFRDtLe+tS+RCt2AcIKJuwxftLzElyLe/s+TGMCm9HaStHkBmHFGp7RjtwZINV8ERVMBSLmZLlKJKu4a/xcOiCa/rDJaLIaRsHzDGXSOZnILdLNnvjkVSK8LZcfBnCbPrGBm/sRIY98EqesX2Va02ENu0=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Wed, 7 Jan
 2026 01:50:52 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 01:50:52 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "phil@jpmr.org" <phil@jpmr.org>
Subject: RE: [PATCH] drm/amdgpu: validate the flush_gpu_tlb_pasid()
Thread-Topic: [PATCH] drm/amdgpu: validate the flush_gpu_tlb_pasid()
Thread-Index: AQHcfw8bLzfrjVkAK0in+Mc3MnRAybVF8aKA
Date: Wed, 7 Jan 2026 01:50:51 +0000
Message-ID: <DS7PR12MB6005F5FD54C06298CB3B60EFFB84A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260106131921.801193-1-Prike.Liang@amd.com>
In-Reply-To: <20260106131921.801193-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-07T01:49:56.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA1PR12MB7199:EE_
x-ms-office365-filtering-correlation-id: 6099faeb-f8d9-4ef5-a89b-08de4d8f305e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?AeMeh/NjNIVZvRTJ6euIBBoQj+gJl45kR+svPeZ0pPGB19buKbIyb22QlZ18?=
 =?us-ascii?Q?avgN4mROOKlGUuW8mUKAO16xIB5e2ZmFeBM4Hkj7lzWQh142o4WWr63OiH5c?=
 =?us-ascii?Q?HE9+xXEk8vwmQf2/w7fk9vnBJeMjmfPowXoBGvDbdHM3rW3py8s5YweFx0b1?=
 =?us-ascii?Q?goUZztX+8oEsN8PpqiEuHLBVPiOqv096boDxj1VPWQAs6NLvwynWKEUS42kt?=
 =?us-ascii?Q?R8HjPX118K2XBtCAHQjvqjWZb95Zh47cmuAoiNzz2aJrpoCv+98O6oeBe/lP?=
 =?us-ascii?Q?KNu4mg7FfKK+SGBmlofZlKwlA+dSdNspwvexkMe0V9FZ7h7+toGdYT5KF2bG?=
 =?us-ascii?Q?8UuJgh57s+W6cbSU+JDR+dC2JLJVo4rbhpo9sQ7MFkOUg7MAloasWxGd5CeJ?=
 =?us-ascii?Q?Sc7gWZOSeLjorYuJM3664idNQ3jMPo7T7Ec2Dir++bt5/of6YQXCO4mW4I52?=
 =?us-ascii?Q?RSC3Meu7GJMC35bZl+D79lv8TwjTttkN0sZKLjKAETdG8RDBLvxGQuw12n9z?=
 =?us-ascii?Q?Y0qplkAZH6j9cej7o8qX/1py1QAMgr7D4B4NYADqrKpdLL85C4daeDLQY/e7?=
 =?us-ascii?Q?0npvpQY2BUBsognmRG+Y++sUCa/ZK2Ek/xlZEQP9MHpljhvs6mNQOGRDQLrj?=
 =?us-ascii?Q?H9MoCO6KzQNCJck1v8CddZ5AAV19WPI+OLaFo8lSw4yDyfnLMnQdVYCsGd90?=
 =?us-ascii?Q?Mq3LCuBgxCVkWyMr9bfusuPz9uPbDWfn5iNehnFNbKRK05F/Ak89YN/yBp8A?=
 =?us-ascii?Q?Ns6ob/iwF+zmZABpeEoic7G07PiL9/Fr8dSa6KyPTdukyueAhW7ns4qHCTX0?=
 =?us-ascii?Q?4hGL9v8EnW1R8iTQHLedYA3ZKjRYE6FjUAVvJpuJ9u44muKYbkAAN1Ow4nMs?=
 =?us-ascii?Q?hbsc80EIlUQFmrT6kWXNb1/qOrzYNKwSRy/VUA26ABcxoFX8NBc4r6ROrLX+?=
 =?us-ascii?Q?mErX2VDlQwsFJYHxSTUixd980FVF2s0CsOMP/HmviRwm2aLGVtrf3D2Zqkir?=
 =?us-ascii?Q?KjxnQXSpOEHyb2eScz6IQJflZLjE9cS3/AAxcKQaS81G0xvQscQ24bU3UL/M?=
 =?us-ascii?Q?gBTz3CKc28tQGXt42TfN8YVVvuQGVcFUOSne6uWDOkK4cBGTwdhh7d6bUZXp?=
 =?us-ascii?Q?q+/ngyfAJJlER8HYDon4t/XQYf9ApmLKV2bi2aXdAp8HLoiPEqTI7HUILw/u?=
 =?us-ascii?Q?KWAVXjbDk9TkZFe+yUyWYV48NFbWZVcZZyfuuTpNFd90vdXepMA8vNQoio31?=
 =?us-ascii?Q?Y0c0N0YLbSiNQt5PcNXIlwW9Zf5BuO8bpSbf0vBGwwZgM+Xn271VUYE0J0Px?=
 =?us-ascii?Q?U4uqLbgTcwGkpcThd5Um76rj6AQAaN+SPWAW4eoow3lMYDfY4fVYV+jkRvG9?=
 =?us-ascii?Q?GNWCq/DRizpSFRLrbtE+RyXKl4Q+ZJUBm0y7DHK5RpBNFl1J956h/zAJMzdN?=
 =?us-ascii?Q?b64BABdBOXtYjzC8ecWrNsBMohoRoul9PyV4xy0fPUnWIqN6p1+A6brxlnq6?=
 =?us-ascii?Q?qYjYNoTYwdrMzZQOHXJkXya1Ncz8nFqj1ryW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?35K6sarvu7VZ1RS08wYLQpfQUcFN1lh7cwsnnjXQB5kjB6JGjbVdixSrl9Y3?=
 =?us-ascii?Q?EpoV6AD+1HJAqdv+3egGFiFWYvKNtYBSnWDrESlM1pit1/XPdjgpHj9PuwhI?=
 =?us-ascii?Q?z1R68LAY+Qi68fN9++7+DGuc9zzybbNEtFsq4kI+Gk6DTVlVgpQfSwMOZN1i?=
 =?us-ascii?Q?lfypSb/OPeL2PD8L/26u4K8t1duKoaJ8KNZJc1VAQ0D9BlaLoXpTqeROcWYB?=
 =?us-ascii?Q?zgVEotyEznNN52YXwPpdCqhtI3ErXKXny7phbf0qW/V4KYdRJ3zc7wBpEBDU?=
 =?us-ascii?Q?Q+Vwwh/k89gn+YTZQs+RJSaTB893fijD5ruxIx9AAgvAsK9mEMd5wwXZ+jRA?=
 =?us-ascii?Q?yRN78fVkUXjA8g4xmBEhT0XX7f8bzZBpLWttZLrG8SLUEC/CcMDK4onaayS2?=
 =?us-ascii?Q?YToA4qfAhZ6momXlNaApndU+4Ay11EgKCOLyAcV1x+ugt14G+rfngN++/Y5o?=
 =?us-ascii?Q?VWpmaBODA/2y4qxjXNQGaSt0YzlDh0QBvV46xbSo7ORpp8tAbAl4JapT8y3/?=
 =?us-ascii?Q?SHmi1HofGSgR+ks/KZYF7i9JL0pxzzuoxFVifJ19beVEZdVRl7lHcAvbs2b7?=
 =?us-ascii?Q?RzGtwuJxSm2m4EZX19A8+ug+cK8iXNVP+OXfPqYg6DhLpbBzjFA2kRcu1iAs?=
 =?us-ascii?Q?tVNOjKaM5FosCcetH5Ds9CTNtkaMPZbq/hI7bcvzU06kjKcJDP5G5lXqoog+?=
 =?us-ascii?Q?c6OkWll2ikTTqG6I48i0MhG12je3whtVK+fClrVzQ9mX/XF2KE+9x0ViN9JM?=
 =?us-ascii?Q?Zykv1rSjTTrv7OK0JJZHF55NmPqb/ZOsFdAtf9NELxIB7J9gFDCxvUS6mM+P?=
 =?us-ascii?Q?ofKGXuXgHltp0mtvxx57b0qwSDfpEyeUu6ELLIe6lVjZAEMYJ9o2Ic4nXOx/?=
 =?us-ascii?Q?neVKUQbp89gzALF0yaTq8C/L0XjfueQFthulKk9c0k0P2M5/m42je2gbyV8A?=
 =?us-ascii?Q?n3KMSIEm1xZ8Ffud5s7kbCj1WOadwLD4xdzS1gXX1zRe5ybpvZbJ4bm7uhzM?=
 =?us-ascii?Q?BTNbl5t1G0icHZBFTWqIWNAvGqA6PaMHCYac0bprHdIEB+Sdxop2j5XKYhDj?=
 =?us-ascii?Q?97OF0ynWHnHh7PYjggz3WTCspwy4TVfPUvEpbQDP9HcQcXYf2WEaNH/8TbBG?=
 =?us-ascii?Q?wDJYourNRXNiY63Y8d/4Xf3RajJCtJeyeaO4+1S+VAe6JKTnuuA/SIWST4nv?=
 =?us-ascii?Q?PXVo327PhmdDVOGCV4QKxovTgeTYm6IGd4PaJrDQmj0HzSmy4XRmi4leifUj?=
 =?us-ascii?Q?X9l0E5zSQZm6O4rk9F56aCP0oe791CSDRB4MjD6+sRA8Nb8Unjj4mOMyTASq?=
 =?us-ascii?Q?j1FRjzdeyTaaqUeXN1r+lAoSO8dJuBDk7mgWlKOY1Pi7WSU9DTZ13p4Cg3Vc?=
 =?us-ascii?Q?kaz2EWPMfN1pB4LxLUAMCvfzgwxzbLPcgk/cu3nKrkWKgUa3FylJpmAz6f5D?=
 =?us-ascii?Q?hK1iKj+53iElQ5F7WKLEE3ZYaivR+hjeMphzj4jj2BaEmZNd//3n9H18tbmj?=
 =?us-ascii?Q?50dq2aqz3hu0Up9WTO1m/wFDsl+PSC3yx1Y73N20qiN90qQ43amuMxftuiJ/?=
 =?us-ascii?Q?own4v2XGq/Ntns5o1b5hyTpczjBHJprzYHgtRZT1E3SswlKuouT6tG41VREl?=
 =?us-ascii?Q?3R/StcF7+PL5cxVgJqSeKcZdZq2DH2HOHNE6FJ4axwXktLqLbigqh1V50YOB?=
 =?us-ascii?Q?mzHvHEqXByivlkdQgglQ6lL+SmasPY11zS90iDH/SpD0QwhE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6099faeb-f8d9-4ef5-a89b-08de4d8f305e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 01:50:51.9931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EQAObnmNVlUKt5TgzxtdKegSoBv5EqDbE8TjaXasrnvGLEtEH7OIubd49daPlo2o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199
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

Add Jean

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, January 6, 2026 9:19 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu: validate the flush_gpu_tlb_pasid()
>
> Validate flush_gpu_tlb_pasid() availability before flushing tlb.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index cd4acc6adc9e..f871f1693483 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -780,6 +780,10 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
> amdgpu_device *adev, uint16_t pasid,
>               return 0;
>
>       if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
> +
> +             if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid)
> +                     return 0;
> +
>               if (adev->gmc.flush_tlb_needs_extra_type_2)
>                       adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasi=
d,
>                                                                2, all_hub=
,
> --
> 2.34.1

