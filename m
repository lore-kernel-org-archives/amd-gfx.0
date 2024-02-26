Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F82C5478C
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Feb 2024 16:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DD6510E792;
	Mon, 26 Feb 2024 16:22:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PpOKDUqW";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB12B10E792
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 16:22:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPnG3hiNvH0bQzDYENXpwgrBIHT6Y3Qws8rb1HCewoqWf4YEmijZc/sWEbC/zEZtwHYHSuA32hbZioFXk5hFqCKiBw8zpFd+nh1uhyGKUs5i4ZQ/ZpJjolcnMMCdmfnnRpqVW8oE8eYkpvsWidFZ9PEwHERyS4C3Dwn4aL0VcouzyRO64CDuXL7rYiem06zPUVdt7LHNcap27mdGfezk1kwsmFggvn9pJVjpW7XgXyjbVdUShzkLM+Og9si4cRc+Lk4iuDKJ3c4KQZt2ahbFoAWo8euzyv1NuNKNKKs/hOu1YPFzJMgn5Zo4ztzEULR89cum0lphTUD2UL6N94yIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXvsYvZICI8LcA52Vp9ktd/4ZVtI7L7Gwp7jqA8yE24=;
 b=J2i67aJBXQ8I1rPNIDMRtVU7VDXhZ+LimSmwHbGxeDnLSP1WDoyY390AFnMbb1k3nlETWYxGZIvwLYWp0RAM340ItyNkZv/qJyaT7zept0OxQPEdFTcSZoa/j8Szkxp/aBvik6D9x8oUimbpkg+tBXLdQ8DsDYFdrmD+wtIlBKH6ZTnmV0imR1I/vVVKTePf21OYuDM3z6nPvbNzPQEMjI6msDzyCWfhAFlWbRE9AOaRD3Jo3R6IwSbl10GeyS3HhQRBeywV2oCf05Q53CWyQD6/7/69NWDVivpzuJtg7aADqpT5nE0t5i09OZDOgrT9omtnJCEt3flTBvAPJOOYww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXvsYvZICI8LcA52Vp9ktd/4ZVtI7L7Gwp7jqA8yE24=;
 b=PpOKDUqWjETjqJ8MnqwUYwJ5cbZuQgDYWW0dubxUURLozfQ4VZwGjXEAvLNBRnCkCVj8cgqhSjwcvRUT0f6vsmckcsp7cZpQI65wxRGYHJSkV8BlHdZh+zUvimb9Ul6aftR0nK2PzzD1nZWftlcrSMbJfdEk/PTQxD2EYzk0oGA=
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.31; Mon, 26 Feb
 2024 16:22:09 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::baa0:7590:7bdd:e60]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::baa0:7590:7bdd:e60%2]) with mapi id 15.20.7316.023; Mon, 26 Feb 2024
 16:22:09 +0000
From: "Sharma, Shashank" <Shashank.Sharma@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>
Subject: Re: [PATCH v3 1/3] drm/amdgpu: replace TLB seq callback with HW seq
Thread-Topic: [PATCH v3 1/3] drm/amdgpu: replace TLB seq callback with HW seq
Thread-Index: AQHaZl4t3gc1kVCc5kiUJHwh/9ywjLEcuEmAgAAarjg=
Date: Mon, 26 Feb 2024 16:22:09 +0000
Message-ID: <MW4PR12MB5667E3C07D9DAC31F3ED25D9F25A2@MW4PR12MB5667.namprd12.prod.outlook.com>
References: <20240223134206.899-1-shashank.sharma@amd.com>
 <df699975-9663-43d5-9243-3c675a6cb014@gmail.com>
In-Reply-To: <df699975-9663-43d5-9243-3c675a6cb014@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-26T16:22:09.238Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB5667:EE_|PH7PR12MB6665:EE_
x-ms-office365-filtering-correlation-id: cf7b1af6-2f71-4188-a9fa-08dc36e714f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7UJiyfh8VUyCVXZZay+3+uuB+M0/SnfFthRwZVWiTExAD29YRuvzGH14FAa+1UfMgUP70IOwpgiyDglRtk0DQ4f4ZpyP0HxOLq6AlNRqd3G9q3EnW7N/jY8Ls8Wx2NaSE48+25bWkiIW0D/GmKVp2L6WpLlwqxQVVm6s7JrJkAtd13utn2qdcGdhvptgE1gXLqCCwgd9HH0s7Lus/nVYj0PFRrAGe0/aZiSLWuJtFGu8zFi81fySeOaERLJrsMPK81Nb91z5xudSaRstPxaNjVRVcCzsputw/pU38jsOZhdOv/v+uB5YXEF5l9UiglogJL0vS+nRKWxdlpc3g0GG0Sg5zDqwNxgl7j6B19xUD2a5P1oKFa/y6mmKR/+mrcmVMeKAj6YRfQ7/Z8gBpAP8QerqrMs9C/GseDthxOhCUQd9TMOwzZqy3Ma0BTJ4yU0/2CyQRU0b/sRX7Fkp8Nt8I1gyBi7PzLwlxZUid4ITB4dsTmlwpkFPbEBtd9ULrE6pv+4cjijTbrMeAUkpNpkIjlKe+aXuEu1wLxwaSSwYPSV4rgbxWGm9FKFZDqfp17BcQ+v4dyQveQX4tqkLfFHeKo0h96lybSg/clTL2FFT4IluTChIf8ZAdEJBuzmS3opmfewHI/ro6I31+f6ZkVToHS/WER9dBJZ9mMkkiLzGlQXfWo39XQ9vcIMQs80m5wyyXSevFwa0BiWXd2m9ZzpvNchSiWyf+d1BCQQSySWAlfU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IDZo6E7yU0wDDUt8ccj1rUtYtoLT79cHKO457IYEiqN77GZnQYC7Av4KGt?=
 =?iso-8859-1?Q?z04iKkw/lDMgXchXcWVzvm8W7C95JRxdg6q+ib5CWVnSOjsVVwtM4z0RIZ?=
 =?iso-8859-1?Q?+j7D9f2I18296FzgmGfs1eCOGdDAQ850AG5zHyGbN8sA4Yeky7CtsvWGeY?=
 =?iso-8859-1?Q?LHvJnqKEnfnKMWlyV/wuK5P6YuKxeMbPnlDTZR1eVPV7ouTtBOkuJAtYXY?=
 =?iso-8859-1?Q?PMTQ0Oc8DFZ7BCw+qh9I6GKMRDSjrO5aWSqMHgWWdKpVCjyjNSa5O7RmE6?=
 =?iso-8859-1?Q?/RxIBogPwtofvtRxOYd92weQLaprG3Rxx2mIPQOp+gATwCO3Lj7YKlskwq?=
 =?iso-8859-1?Q?vpEieW+tvzMsPBG8KeLdE86shfWJ3R0rDRMqbw04yumvWefWOw9Q40LDlJ?=
 =?iso-8859-1?Q?1/0bhoJESLwwqZBxx8kvaW9OIy06rHZ/n9q6kAU5vmUWpVoqEzyCzDi3DN?=
 =?iso-8859-1?Q?cIs2Ery0OMZNW08y5hWu5NN0gLbaB6fMQ0UBLVBbyLsRoPtZKkoPXnc9SK?=
 =?iso-8859-1?Q?US0KYYOGokezRBFGN93E+SR6rt0d4fBpdsTL5Eaa7NWOLiD4l7BKochwdj?=
 =?iso-8859-1?Q?bKaeVtw/hRejY3AGPQE3+YiVXaOPRMrqqS8JdbrokF1MqZMp04gofuRx54?=
 =?iso-8859-1?Q?xv+RcE+IK67eKm42R0tkqvsgmdd3oQs4TeNRXscpWgeg4JNxqoiLbE4CII?=
 =?iso-8859-1?Q?cmqwPsNjVYeXXVzco+kLzm/9A6CTmlwyEyHh/iszQ04B71URygcAAQDtBT?=
 =?iso-8859-1?Q?beeLJhvKPjKGhcq1zs8ZtTA2ECvnyEf/cQXMY+fyMiHlYOiIF5pWxuyFmW?=
 =?iso-8859-1?Q?jWJCp+dhO8sQMuQwnCO077SA8ovqALFDdHbQzXO5e+ux9vwo7aB1FiRNdP?=
 =?iso-8859-1?Q?JAK12yMbeDtSO/zRzId8vLPqsmuxKE3yUm6qamw2XiUSs7eebpAorZ7DKz?=
 =?iso-8859-1?Q?z2rONCeF3DgZlEgxkPcJhKCsAhl3FP6Y1bUWmC2pgapj4AWYUtn+K7Rw4j?=
 =?iso-8859-1?Q?onEWcT4Px+aGTjpjXE2vRnVQ2d913iU4rBLjC+o94oUCuJn1edWn+7XBzE?=
 =?iso-8859-1?Q?ok6/OMxSIigNFBAY5UYp3MNpde70htm7GIb3/BE/7YKHpyP4gA2Axm7qrh?=
 =?iso-8859-1?Q?WNYBHJUSXCD4pCMaFmP+86DOkR0haftNFZYElzpfg/DmHJbZlJ2IZ/RDbu?=
 =?iso-8859-1?Q?5XKFEXNefQyxU9YIG1zBI/xjUo7U5FWq5ou4dmjYSfsMOx5HcMNHlPVa+g?=
 =?iso-8859-1?Q?L1PEyGks7rZax907fhzzmZGZzFe8G8pTyeu6emYUKDNc0JW6NTLyqc05UX?=
 =?iso-8859-1?Q?cgkYzxAPoDKEdVMxAmQ5Z1EWY2fo4gmV8CazVgLvJSMMRfL5obGtmiaQeb?=
 =?iso-8859-1?Q?lq8YVesKzeJwayv1OOWmyTbga6nL6m7CwlwihRm8pZEob6M3hrwooZ8vhT?=
 =?iso-8859-1?Q?FVg8ZetZg7iks7eVW6+9SSVNE496S4ZzKZxhScmqhHT/rIauwdtRRbVJLJ?=
 =?iso-8859-1?Q?tdkcoPw/k9m7jbkvX97DJI7aSuTW1O2qhpXviyr2IMI/yYBq3c33lWM1+9?=
 =?iso-8859-1?Q?q9H5kFyxStfdXSRsMdmPCSNU4IVEdtHR9v5XFUDTijQjLoKqiBqfVBaN/O?=
 =?iso-8859-1?Q?J5hJpBDR8dCNQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW4PR12MB5667E3C07D9DAC31F3ED25D9F25A2MW4PR12MB5667namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7b1af6-2f71-4188-a9fa-08dc36e714f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 16:22:09.6160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nXeyIHtkeukDH8LdO597oOvboQGFf+2FMRJnUaEtJpnI1rV0MNzDbI5xB0VCg1iaEzigahV0jabWYxkJ/tyeDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665
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

--_000_MW4PR12MB5667E3C07D9DAC31F3ED25D9F25A2MW4PR12MB5667namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Please feel free to use:
Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>

Regards
Shashank
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Monday, February 26, 2024 3:45 PM
To: Sharma, Shashank <Shashank.Sharma@amd.com>; amd-gfx@lists.freedesktop.o=
rg <amd-gfx@lists.freedesktop.org>
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Bhardwaj, =
Rajneesh <Rajneesh.Bhardwaj@amd.com>
Subject: Re: [PATCH v3 1/3] drm/amdgpu: replace TLB seq callback with HW se=
q

Am 23.02.24 um 14:42 schrieb Shashank Sharma:
> From: Christian K=F6nig <christian.koenig@amd.com>
>
> The callback we installed for the SDMA update were actually pretty
> horrible. since we now have seq64 use that one and HW seq writes
> instead.
>
> V2:(Shashank)
>   - rebased on amd-drm-staging-next
>   - changed amdgpu_seq64_gpu_addr
>
> Cc: Christian K=F6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>

Shashank can I get an rb on this patch here so that I can push it to
amd-staging-drm-next?

The patch was basically just to double check if the seq64 code works as
intended.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c   | 14 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h   |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 79 ++++-----------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      | 27 ++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  5 ++
>   7 files changed, 42 insertions(+), 89 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_seq64.c
> index 3d0d56087d41..300dc79fa2b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -199,6 +199,20 @@ void amdgpu_seq64_free(struct amdgpu_device *adev, u=
64 va)
>                __clear_bit(bit_pos, adev->seq64.used);
>   }
>
> +/**
> + * amdgpu_seq64_gpu_addr - Calculate GPU addr from va
> + *
> + * @adev: amdgpu_device pointer
> + * @va: virtual address in client address space
> + *
> + * Calculate the GART address for a VA.
> + */
> +u64 amdgpu_seq64_gpu_addr(struct amdgpu_device *adev, u64 va)
> +{
> +     return va - amdgpu_seq64_get_va_base(adev) +
> +             amdgpu_bo_gpu_offset(adev->seq64.sbo);
> +}
> +
>   /**
>    * amdgpu_seq64_fini - Cleanup seq64 driver
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_seq64.h
> index 4203b2ab318d..63e8ac0a2057 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
> @@ -43,6 +43,7 @@ void amdgpu_seq64_free(struct amdgpu_device *adev, u64 =
gpu_addr);
>   int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>                     struct amdgpu_bo_va **bo_va);
>   void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv=
 *fpriv);
> +u64 amdgpu_seq64_gpu_addr(struct amdgpu_device *adev, u64 va);
>
>   #endif
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index ed4a8c5d26d7..0960e0a665d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -111,21 +111,6 @@ struct amdgpu_prt_cb {
>        struct dma_fence_cb cb;
>   };
>
> -/**
> - * struct amdgpu_vm_tlb_seq_struct - Helper to increment the TLB flush s=
equence
> - */
> -struct amdgpu_vm_tlb_seq_struct {
> -     /**
> -      * @vm: pointer to the amdgpu_vm structure to set the fence sequenc=
e on
> -      */
> -     struct amdgpu_vm *vm;
> -
> -     /**
> -      * @cb: callback
> -      */
> -     struct dma_fence_cb cb;
> -};
> -
>   /**
>    * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
>    *
> @@ -862,23 +847,6 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev=
,
>        return r;
>   }
>
> -/**
> - * amdgpu_vm_tlb_seq_cb - make sure to increment tlb sequence
> - * @fence: unused
> - * @cb: the callback structure
> - *
> - * Increments the tlb sequence to make sure that future CS execute a VM =
flush.
> - */
> -static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
> -                              struct dma_fence_cb *cb)
> -{
> -     struct amdgpu_vm_tlb_seq_struct *tlb_cb;
> -
> -     tlb_cb =3D container_of(cb, typeof(*tlb_cb), cb);
> -     atomic64_inc(&tlb_cb->vm->tlb_seq);
> -     kfree(tlb_cb);
> -}
> -
>   /**
>    * amdgpu_vm_update_range - update a range in the vm page table
>    *
> @@ -911,7 +879,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
>                           struct dma_fence **fence)
>   {
>        struct amdgpu_vm_update_params params;
> -     struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>        struct amdgpu_res_cursor cursor;
>        enum amdgpu_sync_mode sync_mode;
>        int r, idx;
> @@ -919,12 +886,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *ade=
v, struct amdgpu_vm *vm,
>        if (!drm_dev_enter(adev_to_drm(adev), &idx))
>                return -ENODEV;
>
> -     tlb_cb =3D kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
> -     if (!tlb_cb) {
> -             r =3D -ENOMEM;
> -             goto error_unlock;
> -     }
> -
>        /* Vega20+XGMI where PTEs get inadvertently cached in L2 texture c=
ache,
>         * heavy-weight flush TLB unconditionally.
>         */
> @@ -942,6 +903,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
>        params.immediate =3D immediate;
>        params.pages_addr =3D pages_addr;
>        params.unlocked =3D unlocked;
> +     params.needs_flush =3D flush_tlb;
>        params.allow_override =3D allow_override;
>
>        /* Implicitly sync to command submissions in the same VM before
> @@ -955,7 +917,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
>        amdgpu_vm_eviction_lock(vm);
>        if (vm->evicting) {
>                r =3D -EBUSY;
> -             goto error_free;
> +             goto error_unlock;
>        }
>
>        if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
> @@ -968,7 +930,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
>
>        r =3D vm->update_funcs->prepare(&params, resv, sync_mode);
>        if (r)
> -             goto error_free;
> +             goto error_unlock;
>
>        amdgpu_res_first(pages_addr ? NULL : res, offset,
>                         (last - start + 1) * AMDGPU_GPU_PAGE_SIZE, &curso=
r);
> @@ -1018,7 +980,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *ade=
v, struct amdgpu_vm *vm,
>                tmp =3D start + num_entries;
>                r =3D amdgpu_vm_ptes_update(&params, start, tmp, addr, fla=
gs);
>                if (r)
> -                     goto error_free;
> +                     goto error_unlock;
>
>                amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZ=
E);
>                start =3D tmp;
> @@ -1026,22 +988,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *ad=
ev, struct amdgpu_vm *vm,
>
>        r =3D vm->update_funcs->commit(&params, fence);
>
> -     if (flush_tlb || params.table_freed) {
> -             tlb_cb->vm =3D vm;
> -             if (fence && *fence &&
> -                 !dma_fence_add_callback(*fence, &tlb_cb->cb,
> -                                        amdgpu_vm_tlb_seq_cb)) {
> -                     dma_fence_put(vm->last_tlb_flush);
> -                     vm->last_tlb_flush =3D dma_fence_get(*fence);
> -             } else {
> -                     amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
> -             }
> -             tlb_cb =3D NULL;
> -     }
> -
> -error_free:
> -     kfree(tlb_cb);
> -
>   error_unlock:
>        amdgpu_vm_eviction_unlock(vm);
>        drm_dev_exit(idx);
> @@ -2260,10 +2206,14 @@ int amdgpu_vm_init(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
>        INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>        INIT_KFIFO(vm->faults);
>
> -     r =3D amdgpu_vm_init_entities(adev, vm);
> +     r =3D amdgpu_seq64_alloc(adev, &vm->tlb_seq_va, &vm->tlb_seq_cpu_ad=
dr);
>        if (r)
>                return r;
>
> +     r =3D amdgpu_vm_init_entities(adev, vm);
> +     if (r)
> +             goto error_free_seq;
> +
>        vm->pte_support_ats =3D false;
>        vm->is_compute_context =3D false;
>
> @@ -2283,7 +2233,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, stru=
ct amdgpu_vm *vm,
>
>        vm->last_update =3D dma_fence_get_stub();
>        vm->last_unlocked =3D dma_fence_get_stub();
> -     vm->last_tlb_flush =3D dma_fence_get_stub();
>        vm->generation =3D 0;
>
>        mutex_init(&vm->eviction_lock);
> @@ -2322,10 +2271,11 @@ int amdgpu_vm_init(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
>        amdgpu_bo_unref(&root_bo);
>
>   error_free_delayed:
> -     dma_fence_put(vm->last_tlb_flush);
>        dma_fence_put(vm->last_unlocked);
>        amdgpu_vm_fini_entities(vm);
>
> +error_free_seq:
> +     amdgpu_seq64_free(adev, vm->tlb_seq_va);
>        return r;
>   }
>
> @@ -2441,7 +2391,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm)
>        struct amdgpu_bo_va_mapping *mapping, *tmp;
>        bool prt_fini_needed =3D !!adev->gmc.gmc_funcs->set_prt;
>        struct amdgpu_bo *root;
> -     unsigned long flags;
>        int i;
>
>        amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
> @@ -2453,11 +2402,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm)
>        amdgpu_vm_set_pasid(adev, vm, 0);
>        dma_fence_wait(vm->last_unlocked, false);
>        dma_fence_put(vm->last_unlocked);
> -     dma_fence_wait(vm->last_tlb_flush, false);
> -     /* Make sure that all fence callbacks have completed */
> -     spin_lock_irqsave(vm->last_tlb_flush->lock, flags);
> -     spin_unlock_irqrestore(vm->last_tlb_flush->lock, flags);
> -     dma_fence_put(vm->last_tlb_flush);
> +     amdgpu_seq64_free(adev, vm->tlb_seq_va);
>
>        list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
>                if (mapping->flags & AMDGPU_PTE_PRT && prt_fini_needed) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 666698a57192..ac9380afcb69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -247,9 +247,9 @@ struct amdgpu_vm_update_params {
>        unsigned int num_dw_left;
>
>        /**
> -      * @table_freed: return true if page table is freed when updating
> +      * @needs_flush: true whenever we need to invalidate the TLB
>         */
> -     bool table_freed;
> +     bool needs_flush;
>
>        /**
>         * @allow_override: true for memory that is not uncached: allows M=
TYPE
> @@ -328,9 +328,11 @@ struct amdgpu_vm {
>        struct drm_sched_entity immediate;
>        struct drm_sched_entity delayed;
>
> -     /* Last finished delayed update */
> +     /* Sequence number indicating necessary TLB flush */
>        atomic64_t              tlb_seq;
> -     struct dma_fence        *last_tlb_flush;
> +     uint64_t                tlb_seq_va;
> +     uint64_t                *tlb_seq_cpu_addr;
> +
>        atomic64_t              kfd_last_flushed_seq;
>
>        /* How many times we had to re-generate the page tables */
> @@ -549,22 +551,7 @@ int amdgpu_vm_pt_map_tables(struct amdgpu_device *ad=
ev, struct amdgpu_vm *vm);
>    */
>   static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>   {
> -     unsigned long flags;
> -     spinlock_t *lock;
> -
> -     /*
> -      * Workaround to stop racing between the fence signaling and handli=
ng
> -      * the cb. The lock is static after initially setting it up, just m=
ake
> -      * sure that the dma_fence structure isn't freed up.
> -      */
> -     rcu_read_lock();
> -     lock =3D vm->last_tlb_flush->lock;
> -     rcu_read_unlock();
> -
> -     spin_lock_irqsave(lock, flags);
> -     spin_unlock_irqrestore(lock, flags);
> -
> -     return atomic64_read(&vm->tlb_seq);
> +     return READ_ONCE(*vm->tlb_seq_cpu_addr);
>   }
>
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vm_cpu.c
> index 6e31621452de..0f8fd0acef7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -108,7 +108,8 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_upda=
te_params *p,
>   static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
>                                struct dma_fence **fence)
>   {
> -     /* Flush HDP */
> +     if (p->needs_flush)
> +             *p->vm->tlb_seq_cpu_addr =3D atomic64_inc_return(&p->vm->tl=
b_seq);
>        mb();
>        amdgpu_device_flush_hdp(p->adev, NULL);
>        return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm_pt.c
> index a160265ddc07..95dc0afdaffb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -1056,7 +1056,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_p=
arams *params,
>                        while (cursor.pfn < frag_start) {
>                                /* Make sure previous mapping is freed */
>                                if (cursor.entry->bo) {
> -                                     params->table_freed =3D true;
> +                                     params->needs_flush =3D true;
>                                        amdgpu_vm_pt_free_dfs(adev, params=
->vm,
>                                                              &cursor,
>                                                              params->unlo=
cked);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vm_sdma.c
> index 349416e176a1..91cc3121fd4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -126,6 +126,11 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_up=
date_params *p,
>
>        WARN_ON(ib->length_dw =3D=3D 0);
>        amdgpu_ring_pad_ib(ring, ib);
> +     if (p->needs_flush) {
> +             p->job->uf_addr =3D amdgpu_seq64_gpu_addr(p->adev,
> +                                                     p->vm->tlb_seq_va);
> +             p->job->uf_sequence =3D atomic64_inc_return(&p->vm->tlb_seq=
);
> +     }
>        WARN_ON(ib->length_dw > p->num_dw_left);
>        f =3D amdgpu_job_submit(p->job);
>


--_000_MW4PR12MB5667E3C07D9DAC31F3ED25D9F25A2MW4PR12MB5667namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Please feel free to use:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Shashank Sharma &lt;shashank.sharma@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Regards</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Shashank</div>
<hr style=3D"display: inline-block; width: 98%;">
<div dir=3D"ltr" id=3D"divRplyFwdMsg"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Christ=
ian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b>&nbsp;Monday, February 26, 2024 3:45 PM<br>
<b>To:</b>&nbsp;Sharma, Shashank &lt;Shashank.Sharma@amd.com&gt;; amd-gfx@l=
ists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b>&nbsp;Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher=
, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, Felix &lt;Felix.Ku=
ehling@amd.com&gt;; Bhardwaj, Rajneesh &lt;Rajneesh.Bhardwaj@amd.com&gt;<br=
>
<b>Subject:</b>&nbsp;Re: [PATCH v3 1/3] drm/amdgpu: replace TLB seq callbac=
k with HW seq</span>
<div>&nbsp;</div>
</div>
<div><span style=3D"font-size: 11pt;">Am 23.02.24 um 14:42 schrieb Shashank=
 Sharma:<br>
&gt; From: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
&gt;<br>
&gt; The callback we installed for the SDMA update were actually pretty<br>
&gt; horrible. since we now have seq64 use that one and HW seq writes<br>
&gt; instead.<br>
&gt;<br>
&gt; V2:(Shashank)<br>
&gt;&nbsp;&nbsp; - rebased on amd-drm-staging-next<br>
&gt;&nbsp;&nbsp; - changed amdgpu_seq64_gpu_addr<br>
&gt;<br>
&gt; Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
&gt; Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; Cc: Felix Kuehling &lt;felix.kuehling@amd.com&gt;<br>
&gt; Cc: Rajneesh Bhardwaj &lt;rajneesh.bhardwaj@amd.com&gt;<br>
&gt; Signed-off-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
<br>
Shashank can I get an rb on this patch here so that I can push it to<br>
amd-staging-drm-next?<br>
<br>
The patch was basically just to double check if the seq64 code works as<br>
intended.<br>
<br>
Thanks,<br>
Christian.<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c&nbsp;&nbsp; | 14=
 ++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h&nbsp;&nbsp; |&nb=
sp; 1 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | 79 ++++-----------------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | 27 ++-----<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c&nbsp; |&nbsp; 3=
 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c&nbsp;&nbsp; |&nb=
sp; 2 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |&nbsp; 5 ++<b=
r>
&gt;&nbsp;&nbsp; 7 files changed, 42 insertions(+), 89 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_seq64.c<br>
&gt; index 3d0d56087d41..300dc79fa2b9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c<br>
&gt; @@ -199,6 +199,20 @@ void amdgpu_seq64_free(struct amdgpu_device *adev=
, u64 va)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; __clear_bit(bit_pos, adev-&gt;seq64.used);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt; +/**<br>
&gt; + * amdgpu_seq64_gpu_addr - Calculate GPU addr from va<br>
&gt; + *<br>
&gt; + * @adev: amdgpu_device pointer<br>
&gt; + * @va: virtual address in client address space<br>
&gt; + *<br>
&gt; + * Calculate the GART address for a VA.<br>
&gt; + */<br>
&gt; +u64 amdgpu_seq64_gpu_addr(struct amdgpu_device *adev, u64 va)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return va - amdgpu_seq64_get_va_base(adev) +=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_bo_gpu_offset(adev-&gt;seq64.sbo);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * amdgpu_seq64_fini - Cleanup seq64 driver<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_seq64.h<br>
&gt; index 4203b2ab318d..63e8ac0a2057 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h<br>
&gt; @@ -43,6 +43,7 @@ void amdgpu_seq64_free(struct amdgpu_device *adev, u=
64 gpu_addr);<br>
&gt;&nbsp;&nbsp; int amdgpu_seq64_map(struct amdgpu_device *adev, struct am=
dgpu_vm *vm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va **bo_=
va);<br>
&gt;&nbsp;&nbsp; void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct=
 amdgpu_fpriv *fpriv);<br>
&gt; +u64 amdgpu_seq64_gpu_addr(struct amdgpu_device *adev, u64 va);<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt;&nbsp;&nbsp;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c<br>
&gt; index ed4a8c5d26d7..0960e0a665d3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; @@ -111,21 +111,6 @@ struct amdgpu_prt_cb {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence_cb cb;<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp;<br>
&gt; -/**<br>
&gt; - * struct amdgpu_vm_tlb_seq_struct - Helper to increment the TLB flus=
h sequence<br>
&gt; - */<br>
&gt; -struct amdgpu_vm_tlb_seq_struct {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @vm: pointer to the amdgpu_vm struct=
ure to set the fence sequence on<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @cb: callback<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence_cb cb;<br>
&gt; -};<br>
&gt; -<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * amdgpu_vm_set_pasid - manage pasid and vm ptr mapp=
ing<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt; @@ -862,23 +847,6 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *a=
dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt; -/**<br>
&gt; - * amdgpu_vm_tlb_seq_cb - make sure to increment tlb sequence<br>
&gt; - * @fence: unused<br>
&gt; - * @cb: the callback structure<br>
&gt; - *<br>
&gt; - * Increments the tlb sequence to make sure that future CS execute a =
VM flush.<br>
&gt; - */<br>
&gt; -static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence_cb *cb)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_tlb_seq_struct *tlb_cb;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tlb_cb =3D container_of(cb, typeof(*tlb_cb),=
 cb);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; atomic64_inc(&amp;tlb_cb-&gt;vm-&gt;tlb_seq)=
;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; kfree(tlb_cb);<br>
&gt; -}<br>
&gt; -<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * amdgpu_vm_update_range - update a range in the vm =
page table<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt; @@ -911,7 +879,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *a=
dev, struct amdgpu_vm *vm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct dma_fence **fence)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_update_para=
ms params;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_tlb_seq_struct *tlb_cb;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_res_cursor cur=
sor;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_sync_mode sync_m=
ode;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, idx;<br>
&gt; @@ -919,12 +886,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *=
adev, struct amdgpu_vm *vm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!drm_dev_enter(adev_to_d=
rm(adev), &amp;idx))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -ENODEV;<br>
&gt;&nbsp;&nbsp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tlb_cb =3D kmalloc(sizeof(*tlb_cb), GFP_KERN=
EL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!tlb_cb) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D -ENOMEM;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto error_unlock;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Vega20+XGMI where PTEs ge=
t inadvertently cached in L2 texture cache,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * heavy-weight flush T=
LB unconditionally.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; @@ -942,6 +903,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *a=
dev, struct amdgpu_vm *vm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; params.immediate =3D immedia=
te;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; params.pages_addr =3D pages_=
addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; params.unlocked =3D unlocked=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; params.needs_flush =3D flush_tlb;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; params.allow_override =3D al=
low_override;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Implicitly sync to comman=
d submissions in the same VM before<br>
&gt; @@ -955,7 +917,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *a=
dev, struct amdgpu_vm *vm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_eviction_lock(vm);=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;evicting) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D -EBUSY;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto error_free;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto error_unlock;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!unlocked &amp;&amp; !dm=
a_fence_is_signaled(vm-&gt;last_unlocked)) {<br>
&gt; @@ -968,7 +930,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *a=
dev, struct amdgpu_vm *vm,<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D vm-&gt;update_funcs-&g=
t;prepare(&amp;params, resv, sync_mode);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto error_free;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto error_unlock;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_first(pages_addr =
? NULL : res, offset,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=
last - start + 1) * AMDGPU_GPU_PAGE_SIZE, &amp;cursor);<br>
&gt; @@ -1018,7 +980,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *=
adev, struct amdgpu_vm *vm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; tmp =3D start + num_entries;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_ptes_update(&amp;params, start, tmp, ad=
dr, flags);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unlock;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, num_entries * AMDGPU_GPU_P=
AGE_SIZE);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; start =3D tmp;<br>
&gt; @@ -1026,22 +988,6 @@ int amdgpu_vm_update_range(struct amdgpu_device =
*adev, struct amdgpu_vm *vm,<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D vm-&gt;update_funcs-&g=
t;commit(&amp;params, fence);<br>
&gt;&nbsp;&nbsp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (flush_tlb || params.table_freed) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tlb_cb-&gt;vm =3D vm;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (fence &amp;&amp; *fence &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; !dma_fence_add_callback(*fence, &amp;tlb_cb-&gt=
;cb,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_vm_tlb_seq_cb)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(vm-&gt;la=
st_tlb_flush);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;last_tlb_flush =
=3D dma_fence_get(*fence);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_tlb_seq_cb(NU=
LL, &amp;tlb_cb-&gt;cb);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tlb_cb =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -error_free:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; kfree(tlb_cb);<br>
&gt; -<br>
&gt;&nbsp;&nbsp; error_unlock:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_eviction_unlock(vm=
);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dev_exit(idx);<br>
&gt; @@ -2260,10 +2206,14 @@ int amdgpu_vm_init(struct amdgpu_device *adev,=
 struct amdgpu_vm *vm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_WORK(&amp;vm-&gt;pt_fre=
e_work, amdgpu_vm_pt_free_work);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_KFIFO(vm-&gt;faults);<b=
r>
&gt;&nbsp;&nbsp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_init_entities(adev, vm);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_seq64_alloc(adev, &amp;vm-&gt;t=
lb_seq_va, &amp;vm-&gt;tlb_seq_cpu_addr);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_init_entities(adev, vm);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto error_free_seq;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;pte_support_ats =3D f=
alse;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;is_compute_context =
=3D false;<br>
&gt;&nbsp;&nbsp;<br>
&gt; @@ -2283,7 +2233,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, s=
truct amdgpu_vm *vm,<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;last_update =3D dma_f=
ence_get_stub();<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;last_unlocked =3D dma=
_fence_get_stub();<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;last_tlb_flush =3D dma_fence_get_stub=
();<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;generation =3D 0;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;vm-&gt;evict=
ion_lock);<br>
&gt; @@ -2322,10 +2271,11 @@ int amdgpu_vm_init(struct amdgpu_device *adev,=
 struct amdgpu_vm *vm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;root_bo=
);<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; error_free_delayed:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(vm-&gt;last_tlb_flush);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(vm-&gt;last_un=
locked);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_fini_entities(vm);=
<br>
&gt;&nbsp;&nbsp;<br>
&gt; +error_free_seq:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_seq64_free(adev, vm-&gt;tlb_seq_va);<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt; @@ -2441,7 +2391,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, =
struct amdgpu_vm *vm)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va_mapping =
*mapping, *tmp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool prt_fini_needed =3D !!a=
dev-&gt;gmc.gmc_funcs-&gt;set_prt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *root;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_gpuvm_destroy_=
cb(adev, vm);<br>
&gt; @@ -2453,11 +2402,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev,=
 struct amdgpu_vm *vm)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_set_pasid(adev, vm=
, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_wait(vm-&gt;last_u=
nlocked, false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(vm-&gt;last_un=
locked);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_wait(vm-&gt;last_tlb_flush, false)=
;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Make sure that all fence callbacks have c=
ompleted */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(vm-&gt;last_tlb_flush-&gt;=
lock, flags);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock_irqrestore(vm-&gt;last_tlb_flush=
-&gt;lock, flags);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(vm-&gt;last_tlb_flush);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_seq64_free(adev, vm-&gt;tlb_seq_va);<=
br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(map=
ping, tmp, &amp;vm-&gt;freed, list) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (mapping-&gt;flags &amp; AMDGPU_PTE_PRT &amp;&amp; p=
rt_fini_needed) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.h<br>
&gt; index 666698a57192..ac9380afcb69 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&gt; @@ -247,9 +247,9 @@ struct amdgpu_vm_update_params {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_dw_left;<br=
>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @table_freed: return true if page ta=
ble is freed when updating<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @needs_flush: true whenever we need =
to invalidate the TLB<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; bool table_freed;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool needs_flush;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @allow_override: tru=
e for memory that is not uncached: allows MTYPE<br>
&gt; @@ -328,9 +328,11 @@ struct amdgpu_vm {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity imme=
diate;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity dela=
yed;<br>
&gt;&nbsp;&nbsp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Last finished delayed update */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Sequence number indicating necessary TLB =
flush */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tlb_seq;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *last_tlb_flush;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tlb_seq_va;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *tlb_seq_cpu_addr;<b=
r>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_last_flush=
ed_seq;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* How many times we had to =
re-generate the page tables */<br>
&gt; @@ -549,22 +551,7 @@ int amdgpu_vm_pt_map_tables(struct amdgpu_device =
*adev, struct amdgpu_vm *vm);<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm =
*vm)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; spinlock_t *lock;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Workaround to stop racing between th=
e fence signaling and handling<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the cb. The lock is static after ini=
tially setting it up, just make<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * sure that the dma_fence structure is=
n't freed up.<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rcu_read_lock();<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; lock =3D vm-&gt;last_tlb_flush-&gt;lock;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rcu_read_unlock();<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(lock, flags);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock_irqrestore(lock, flags);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return atomic64_read(&amp;vm-&gt;tlb_seq);<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return READ_ONCE(*vm-&gt;tlb_seq_cpu_addr);<=
br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; /*<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_vm_cpu.c<br>
&gt; index 6e31621452de..0f8fd0acef7b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c<br>
&gt; @@ -108,7 +108,8 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_u=
pdate_params *p,<br>
&gt;&nbsp;&nbsp; static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_pa=
rams *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Flush HDP */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;needs_flush)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p-&gt;vm-&gt;tlb_seq_cpu_addr =3D atomic64_inc_return(&amp;p-&gt;vm-&g=
t;tlb_seq);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_flush_hdp(p-&g=
t;adev, NULL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vm_pt.c<br>
&gt; index a160265ddc07..95dc0afdaffb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c<br>
&gt; @@ -1056,7 +1056,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_updat=
e_params *params,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (=
cursor.pfn &lt; frag_start) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Make sure previous mapping is f=
reed */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cursor.entry-&gt;bo) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pa=
rams-&gt;table_freed =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pa=
rams-&gt;needs_flush =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; amdgpu_vm_pt_free_dfs(adev, params-&gt;vm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp=
;cursor,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; para=
ms-&gt;unlocked);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
&gt; index 349416e176a1..91cc3121fd4b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
&gt; @@ -126,6 +126,11 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm=
_update_params *p,<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(ib-&gt;length_dw =3D=
=3D 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_pad_ib(ring, ib)=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;needs_flush) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; p-&gt;job-&gt;uf_addr =3D amdgpu_seq64_gpu_addr(p-&gt;adev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; p-&gt;vm-&gt;tlb_seq_va);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; p-&gt;job-&gt;uf_sequence =3D atomic64_inc_return(&amp;p-&gt;vm-&gt;tlb=
_seq);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(ib-&gt;length_dw &gt=
; p-&gt;num_dw_left);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f =3D amdgpu_job_submit(p-&g=
t;job);<br>
&gt;&nbsp;&nbsp;<br>
<br>
</span></div>
</div>
</body>
</html>

--_000_MW4PR12MB5667E3C07D9DAC31F3ED25D9F25A2MW4PR12MB5667namp_--
