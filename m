Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18311C71153
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Aug 2023 06:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B9A010E3B6;
	Tue, 29 Aug 2023 06:17:10 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6323610E0F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 06:17:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCiKr3TTZftVU0U4XVI7YgyuSH8p99UvEBUAPr/8RZPBARx+RWUoJY4CnTDVCQKNklnwylihS/ep5jaIBzMse7/za4V1Emy2n2SnxEx1JJGIIESC0Gx7x5riuyqRBYS2H6sA8sTDHVnzekyyJoZfm+DKU6m5tqiySIoIsUlP28eWxbuKpfVn5sFblABRLp+KMqRt2nFP4inXSIXhdByTLSnGvHeMD+UhszHGwLk2bdxuV8ZoByHR1NhkO4pOAd/wrzUD06tE9YPpruUMf+clEncg6n0xK8Ra7//3dryiRrmY6V1yqNy/QF723UhacjeFW1AuBOIRkZjClSSKYCo6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzrdkB3FjfjUnZZazNz/uuNtgSdywKmr+1wkpmNFbZ0=;
 b=S+uBJb5Fr1OzeCGcsaxagb6wptNKeGE6OkuFQtPj2jEW3y+49nM1JZnDGM0/Vdc1FDe2b+xxoPxMLZFXxkqYnfRGIrB+y9AcKQR9NLdr70yKZM4qqk2yPi0uLY5/gfrOJlc9RTvD5+4vgTzDn1Ws8Y8jlTX9wIonSGhm8mDYb4Ugy8r7xhTWourhVAC6Xb5wLaodGJ2C3TMXyuD7ND4AzminaYO9jdXBhLLI4fpStq/1m2onM/x8RR6tbRSnq3L6rsGPpmS27ZuKAXUdyHPGSCO/gU8Em60igzr5bWSF8mrGm6DuzNwTEawMUyBiYEd6XwmOM8IpIhFALUnVt5o5+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzrdkB3FjfjUnZZazNz/uuNtgSdywKmr+1wkpmNFbZ0=;
 b=eUsrUgvtUNw2pS02g+ou/oOBuvhc7G8AlLjyUN4TTKaWljn7A6da1MpN980kvuhUGCo5JgkPPC4zDKzUjKQpEPHUfNMuxjC9HXJaGwQT6dxCWus6a1e24ublNYDQTk4q2u7vunXfLay6utJHMf8GFKVdmFG83JzWshxKGu2Mjuk=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MW3PR12MB4523.namprd12.prod.outlook.com (2603:10b6:303:5b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 06:17:04 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::b4ba:c624:2cb2:90cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::b4ba:c624:2cb2:90cd%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 06:17:04 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, =?iso-8859-1?Q?Christian_K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for
 gfx10 onwards APUs
Thread-Topic: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for
 gfx10 onwards APUs
Thread-Index: AQHZ1uvvohHWYJx9c0OqJMFaLXkm2K//bUHwgAAMWICAABsUQIAAA7eAgABuV4CAAMiYEA==
Date: Tue, 29 Aug 2023 06:17:04 +0000
Message-ID: <CY5PR12MB6369A28D10CBB70F702C507AC1E7A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230825003348.3978418-1-yifan1.zhang@amd.com>
 <20230825003348.3978418-2-yifan1.zhang@amd.com>
 <IA1PR12MB635664DEA385477CF3996C8DC1E0A@IA1PR12MB6356.namprd12.prod.outlook.com>
 <4f64681c-11de-7c9d-c71c-d96b4099a9bf@gmail.com>
 <CY5PR12MB6369567CA37A1148A55BC2ACC1E0A@CY5PR12MB6369.namprd12.prod.outlook.com>
 <a7d9611d-32a1-df24-2d7b-0031dde56cb4@amd.com>
 <BL1PR12MB5144A8C64BA08B326BEFE330F7E0A@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144A8C64BA08B326BEFE330F7E0A@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-28T18:05:54.672Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|MW3PR12MB4523:EE_
x-ms-office365-filtering-correlation-id: b83f4188-9ca2-43f6-8541-08dba85790c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WfJqkJS0qLcqcyU/zDs9kDIFdCteAFMF/H14pBG9h7JaEt+lthermsMWIxbYxD3BSF96drnv/UCqdW7psTFqf4CrSVl0twj1LYw+Wl2kY65S0lFnaVBiOagksjXcDB7wl+gY/jkm67C3wkJdwsqk+mX5gFz/F1Y5g3edqki3nep5jWatp3Qj1ZVHogaGUPQhWvgJNQhT67YnXuGDNJnpbn1Bf/I8g6l0VOU0h0lkWdEfYFgLB1PwaAoZ0ub2RB37lqEXbiXZWSVXVZJJROMWKgxgO7ge9/VlKQTVf9vMYBVrNfpakUzDwWB97pQ7OUzCFYQQlMH+D1oJfHOH0QoUSST6UFLfzHtrLhd/FLXri7mA1rLNZg2Vf6FJzLiWBNGvNNagXpihrDIVFYKBuapHIVslA815IEFZbvyXmmk3QtX5N8vbms3O9dmyq+onz8vFrtu3k50cIGxwcc16DYiTZNuGjD7rXdmw5kKoGnFAeVGGI4hpRQXC2F3VgZemut1QMr2ehysnyC1Tomae2+m/oW0KXlexIz9QiShPCER5xQuhE+YNXkLzTWE4Rk3kTcoijIMSO7JcYlX9rZQ/euRHyTLQaOY0uECkk9Qm6cRD/vrzXgve8R9FFMrQEte/7k8D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199024)(1800799009)(186009)(9686003)(71200400001)(6506007)(7696005)(55016003)(33656002)(86362001)(38100700002)(38070700005)(122000001)(2906002)(26005)(83380400001)(53546011)(478600001)(110136005)(41300700001)(66476007)(66556008)(52536014)(66946007)(8936002)(8676002)(66574015)(76116006)(5660300002)(66446008)(64756008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mxkJl+B0+GwY4e26mVr692E7YqArf+Z0x4IXQCGc1vZfDmH/YuUu32lWw9?=
 =?iso-8859-1?Q?k+ADjt3EPFq5o6zXug1PDva/JzLunPikQwaUgfeyKQpipNBe20/S7OHJRO?=
 =?iso-8859-1?Q?iffXsEtjctZRM68Aji993FfkdXnKPNaNuEofn/jjsCoLsKfj3CS3oeDiOd?=
 =?iso-8859-1?Q?+bnSIdKgvBMGAnmxyLmO+NvIfZK+5LuO5k6NEHHxXFz7/R/oFz7hRh+7eG?=
 =?iso-8859-1?Q?7Kmb4TRQZjQWah5vmah5FTqmkgIMR5ptn0nRZo1fH+8jLioo94Hu77ZcF+?=
 =?iso-8859-1?Q?W6X7witzMHHq+siDsfHurYgZue9noThoxsr6baJg3BdH/VQlktEhYQ6crf?=
 =?iso-8859-1?Q?5vDA+MBYyk9+uxQUZql1bCQwxvzFrir6UK/+H96pr0a26WlUdrZ5scXt2T?=
 =?iso-8859-1?Q?33r64hMvf6hEW70H/RgMfMMgYv3twXQVFmV9vY0gTn1YvJvnCapTiT23nq?=
 =?iso-8859-1?Q?3qhP68j+akqdDg0878ckq6S2XzzSbVnkgBU20apkyfVl6o++hXj53PHNuW?=
 =?iso-8859-1?Q?CVo3HxLp6OmMoMefAMLtdACpKlGFF92lqX3jpY8Dkn0c+WFoMAP72hUNMr?=
 =?iso-8859-1?Q?WpfyisUm4W5cdG6NQvF14mMYVlT5oJ0WvjvgbaVZUutjqTXrvhTQO0eQVw?=
 =?iso-8859-1?Q?xAm0GwUncNLrX1i/9lSDMDpgDeSvT1vtRAkJ8KV8YRNGnb4/Dyjqc5GWn7?=
 =?iso-8859-1?Q?wPhbkpjsyndmMViLD40FPu1wi8oKBkyXCd8sOphDDryMdn+ahIV54Wmm8j?=
 =?iso-8859-1?Q?tsj5zYG3uNFIqTz+4KpnzZu1fmm20inMR/WGyN0VmRr+I9I/YbUPMQPm7W?=
 =?iso-8859-1?Q?rydqWn0iLasN3ZJUEYHGoxtsmasGmEKgKU6YIcn6nbKtQNWUaDLTqPQ0ms?=
 =?iso-8859-1?Q?ZMxkkSeUniD2HsSIT0hWTgKHut8otd/Kd+b22SrhS16awVb4xX5KN4vO2T?=
 =?iso-8859-1?Q?yhDkM73540ptknynmeo+fUIlnBN8/HHcHwLROd12CrA7g7EJ9SkGMvmFFK?=
 =?iso-8859-1?Q?5D5hmXoQnVPSUHO4H/wvfg3f26mBf4NvIFAzNtUXuUH0YjRjv3kIArakgO?=
 =?iso-8859-1?Q?TBhHz0JVOnBn7ueCyXp+L5V3uXM/ODtCHUipX/Rjv/9SGOU+AoL/3Jvjar?=
 =?iso-8859-1?Q?8zMB/aahF3oMlmveH09pB/QcYC+cHwg8a0gvjWwwKZOUDjGkOBzvdq4/aZ?=
 =?iso-8859-1?Q?DHdCA74UwWs85u9YSZFg9DxTQ1Vhl7HPTn0OiwnGQLHVa8FSC2wXv4Prdd?=
 =?iso-8859-1?Q?CEz/2QFn4vKMb7fqx4JFjJWkmOC6G6rFjWypOjER4Rx27C8kUU7p45zRT4?=
 =?iso-8859-1?Q?y2A9MZ3hzNOxB07H3c51nWdmIAe4gupsDXvrbpth2x850RfN+XoNU67dmg?=
 =?iso-8859-1?Q?6zEmYan5do43MzHT0Q2MNoc3bPMOojx9zCo4rDTGimhDeLDZztZXP9fH62?=
 =?iso-8859-1?Q?bk12/0hFl4gyojEr5FwnwoJFq0T5MWj1ouTMyiOfZgfNi0/x2UQkPfZYpt?=
 =?iso-8859-1?Q?RGH/xGNyQVu/85Iff4uTUqo6OE/N90B6O09lhE0O1Cnfm5kzgOky13RrpK?=
 =?iso-8859-1?Q?FjqGFEAieRM+X04jO1mASHyp/gy7Qk2ezLF0MR/yEYyoHT5fReyG/L7W94?=
 =?iso-8859-1?Q?HC//TOEJ0RQVg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB6369A28D10CBB70F702C507AC1E7ACY5PR12MB6369namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83f4188-9ca2-43f6-8541-08dba85790c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 06:17:04.6860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: me2kKgURqNCm9ozFVTFGY6yW9PAaF+gf2a0MN9IbrF48hYTQ/rCg+a3/1AVxGe39
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4523
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

--_000_CY5PR12MB6369A28D10CBB70F702C507AC1E7ACY5PR12MB6369namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Validated on Phoenix and Raphael w/ IOMMU remapping mode, and found random =
page fault when launching Xorg. I will debug this issue and update the patc=
h.

Best Regards,
Yifan

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, August 29, 2023 2:06 AM
To: Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Yifan <Yifan1.Zhan=
g@amd.com>; Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; amd-gfx@l=
ists.freedesktop.org
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for g=
fx10 onwards APUs


[AMD Official Use Only - General]

Technically the AMD IOMMU uses direct mapping mode for any device which cla=
ims to support ATS in order to support the IOMMUv2 functionality, but that =
was also the case with Raven systems which were problematic when remapping =
mode was enabled.  That said, now that IOMMUv2 support has been removed, th=
ere's no reason to use direct mapping in the IOMMU driver so that may chang=
e.

Alex

________________________________
From: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@a=
md.com>>
Sent: Monday, August 28, 2023 7:30 AM
To: Zhang, Yifan <Yifan1.Zhang@amd.com<mailto:Yifan1.Zhang@amd.com>>; Chris=
tian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.leichtzumerke=
n@gmail.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedeskt=
op.org> <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org=
>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for g=
fx10 onwards APUs

Well, there seems to be a very basic misunderstood here: The IOMMU
isolation level is *not* ASIC dependent!

Try to set amd_iommu=3Dforce_isolation on the kernel command line.

This is a configuration option customers can use to harden their systems
and when this isn't properly tested we can't allow page tables in system
memory.

Regards,
Christian.

Am 28.08.23 um 13:23 schrieb Zhang, Yifan:
> [Public]
>
> Not yet. It will be only enabled for gfx10.3.3 and later APU initially, I=
OMMU is pass through in these ASIC.
>
> -----Original Message-----
> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.=
leichtzumerken@gmail.com>>
> Sent: Monday, August 28, 2023 5:41 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com<mailto:Yifan1.Zhang@amd.com>>; amd=
-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuche=
r@amd.com>>; Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.K=
oenig@amd.com>>
> Subject: Re: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for=
 gfx10 onwards APUs
>
> Is that now validated with IOMMU in non pass through mode?
>
> Christian.
>
> Am 28.08.23 um 10:58 schrieb Zhang, Yifan:
>> [AMD Official Use Only - General]
>>
>> Ping
>>
>> -----Original Message-----
>> From: Zhang, Yifan <Yifan1.Zhang@amd.com<mailto:Yifan1.Zhang@amd.com>>
>> Sent: Friday, August 25, 2023 8:34 AM
>> To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuch=
er@amd.com>>; Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.=
Koenig@amd.com>>; Zhang, Yifan <Yifan1.Zhang@amd.com<mailto:Yifan1.Zhang@am=
d.com>>
>> Subject: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for gf=
x10 onwards APUs
>>
>> To decrease VRAM pressure for APUs, put page tables to GTT domain for gf=
x10 and newer APUs.
>>
>> v2: only enable it for gfx10 and newer APUs (Alex, Christian)
>>
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com<mailto:yifan1.zhang@amd=
.com>>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 9 ++++++---
>>    1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vm_pt.c
>> index 96d601e209b8..4603d87c61a0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -515,10 +515,13 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
>>           bp.size =3D amdgpu_vm_pt_size(adev, level);
>>           bp.byte_align =3D AMDGPU_GPU_PAGE_SIZE;
>>
>> -       if (!adev->gmc.is_app_apu)
>> -               bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;
>> -       else
>> +       if (adev->gmc.is_app_apu ||
>> +               ((adev->flags & AMD_IS_APU) &&
>> +               (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 3, 3)=
)))
>>                   bp.domain =3D AMDGPU_GEM_DOMAIN_GTT;
>> +       else
>> +               bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;
>> +
>>
>>           bp.domain =3D amdgpu_bo_get_preferred_domain(adev, bp.domain);
>>           bp.flags =3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>> --
>> 2.37.3
>>

--_000_CY5PR12MB6369A28D10CBB70F702C507AC1E7ACY5PR12MB6369namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle21
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Validated on Phoenix and Raphael w/ IOMMU remapping =
mode, and found random page fault when launching Xorg. I will debug this is=
sue and update the patch.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Best Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Yifan<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Tuesday, August 29, 2023 2:06 AM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Zhang, Yifan=
 &lt;Yifan1.Zhang@amd.com&gt;; Christian K=F6nig &lt;ckoenig.leichtzumerken=
@gmail.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memor=
y for gfx10 onwards APUs<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black">Technically the AMD IOMMU uses direct map=
ping mode for any device which claims to support ATS in order to support th=
e IOMMUv2 functionality, but that was also the
 case with Raven systems which were problematic when remapping mode was ena=
bled.&nbsp; That said, now that IOMMUv2 support has been removed, there's n=
o reason to use direct mapping in the IOMMU driver so that may change.<o:p>=
</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black">Alex<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Koenig, Christian &lt;<a href=3D"mailto:Christian.K=
oenig@amd.com">Christian.Koenig@amd.com</a>&gt;<br>
<b>Sent:</b> Monday, August 28, 2023 7:30 AM<br>
<b>To:</b> Zhang, Yifan &lt;<a href=3D"mailto:Yifan1.Zhang@amd.com">Yifan1.=
Zhang@amd.com</a>&gt;; Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leic=
htzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memor=
y for gfx10 onwards APUs</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Well, there seems to =
be a very basic misunderstood here: The IOMMU
<br>
isolation level is *not* ASIC dependent!<br>
<br>
Try to set amd_iommu=3Dforce_isolation on the kernel command line.<br>
<br>
This is a configuration option customers can use to harden their systems <b=
r>
and when this isn't properly tested we can't allow page tables in system <b=
r>
memory.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 28.08.23 um 13:23 schrieb Zhang, Yifan:<br>
&gt; [Public]<br>
&gt;<br>
&gt; Not yet. It will be only enabled for gfx10.3.3 and later APU initially=
, IOMMU is pass through in these ASIC.<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@g=
mail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
&gt; Sent: Monday, August 28, 2023 5:41 PM<br>
&gt; To: Zhang, Yifan &lt;<a href=3D"mailto:Yifan1.Zhang@amd.com">Yifan1.Zh=
ang@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com=
">Alexander.Deucher@amd.com</a>&gt;; Koenig, Christian &lt;<a href=3D"mailt=
o:Christian.Koenig@amd.com">Christian.Koenig@amd.com</a>&gt;<br>
&gt; Subject: Re: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory =
for gfx10 onwards APUs<br>
&gt;<br>
&gt; Is that now validated with IOMMU in non pass through mode?<br>
&gt;<br>
&gt; Christian.<br>
&gt;<br>
&gt; Am 28.08.23 um 10:58 schrieb Zhang, Yifan:<br>
&gt;&gt; [AMD Official Use Only - General]<br>
&gt;&gt;<br>
&gt;&gt; Ping<br>
&gt;&gt;<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: Zhang, Yifan &lt;<a href=3D"mailto:Yifan1.Zhang@amd.com">Yif=
an1.Zhang@amd.com</a>&gt;<br>
&gt;&gt; Sent: Friday, August 25, 2023 8:34 AM<br>
&gt;&gt; To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists=
.freedesktop.org</a><br>
&gt;&gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd=
.com">Alexander.Deucher@amd.com</a>&gt;; Koenig, Christian &lt;<a href=3D"m=
ailto:Christian.Koenig@amd.com">Christian.Koenig@amd.com</a>&gt;; Zhang, Yi=
fan &lt;<a href=3D"mailto:Yifan1.Zhang@amd.com">Yifan1.Zhang@amd.com</a>&gt=
;<br>
&gt;&gt; Subject: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory =
for gfx10 onwards APUs<br>
&gt;&gt;<br>
&gt;&gt; To decrease VRAM pressure for APUs, put page tables to GTT domain =
for gfx10 and newer APUs.<br>
&gt;&gt;<br>
&gt;&gt; v2: only enable it for gfx10 and newer APUs (Alex, Christian)<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Yifan Zhang &lt;<a href=3D"mailto:yifan1.zhang@amd.=
com">yifan1.zhang@amd.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 9 ++=
++++---<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 6 insertions(+), 3 deletions(-)<=
br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_vm_pt.c<br>
&gt;&gt; index 96d601e209b8..4603d87c61a0 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c<br>
&gt;&gt; @@ -515,10 +515,13 @@ int amdgpu_vm_pt_create(struct amdgpu_device=
 *adev, struct amdgpu_vm *vm,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.siz=
e =3D amdgpu_vm_pt_size(adev, level);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.byt=
e_align =3D AMDGPU_GPU_PAGE_SIZE;<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gmc.is_app_apu=
)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.is_app_apu =
||<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ((adev-&gt;flags &amp; AMD_IS_APU) &amp;&amp;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_versions[GC_HWIP][0] &gt;=3D IP_VERSION(10=
, 3, 3))))<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.domain =3D AMDGPU_GEM_DOMAIN_G=
TT;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;<br>
&gt;&gt; +<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.dom=
ain =3D amdgpu_bo_get_preferred_domain(adev, bp.domain);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.fla=
gs =3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |<br>
&gt;&gt; --<br>
&gt;&gt; 2.37.3<br>
&gt;&gt;<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY5PR12MB6369A28D10CBB70F702C507AC1E7ACY5PR12MB6369namp_--
