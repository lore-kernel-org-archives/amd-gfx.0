Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF180C624D0
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 03:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8917710EFB6;
	Wed,  2 Sep 2026 03:04:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wsMfD47E";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013051.outbound.protection.outlook.com
 [40.93.196.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78D7510EFB3
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 03:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjyXlYhCIIUfZqEN9tw1537vs8dRBhSyWKmluEzBmc19eTXNrEnnE/q8kvFaftui4K5tj63nDHm1lxqWtlC1HRzfaq+GKZEf9DT04JgTPE04SYObijGaC0lVBGrjfDxkSMADQMBEbzbr7+vcZUNWM0fpF2L5BieLuc9rJUmEcgUMZjZWzb64Et77TF4jlWYd5gG5U07qWuJ8gQOo8yepQdLnq5toXAxOjACK7MTmULIudG2n6wnx322K1g1QlSzOF4gN7M9s70HbJjbkYqjkpzHX5pkk33eDOuyA33vj1E71htAzbCryvphNDUesWxozKvLwGs9DJNvU5ec6DG0DBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INnk1Q0C+8MlwYGT0ek/SiHAhxch2/1AOdEbNJpPxPs=;
 b=MXh3ZF/5sw3KBea/W9AJZx1SL0Gllyy3n8vHhswmuWv7vM95jX75mZM4vJWxrb86DfHRlLCVwoc5BXWwhNirOopk6Ojwa12fhFJBsrvkOhg3AKD3HETpXWYAZ28iaN5dw235hfiXFAqu58JPDX/rguihYTtUiYT+F9gJfhaQFTJr6hWwAkw15HX/RMd0mCKOkAbp7rHrT7XPcLrdup7iNZxcyFfftgCFg7blvPay4KdDs7vZrKPkReWFfRuKKM+5zcCGhLue0Uq6jEuKbKBvBXFFIZNQepyK+9bDzllVBeIrGBWZRYpmhSMBtgHeu2TCfxmSXd7C/lIdmyEizCpr9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INnk1Q0C+8MlwYGT0ek/SiHAhxch2/1AOdEbNJpPxPs=;
 b=wsMfD47EGEnEkJYMlRP7Wd/SoSSFKYYiowQILGvelonpxktZBaH0fczwVMTJBm57F63nDzZAxOR2Y87A4mlQc6T3N2kFET9KD6YSxr1jZ8hOfcGVOIOr8veNzRj+8uzonD5px3vUpjp6vZs3Z71MRQFqGeyOnIX6j9DIq3DDw5M=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 2 Sep
 2026 03:04:31 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 03:04:31 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 22/31] drm/amdgpu/gmc: rework pasid flushing
Thread-Topic: [PATCH 22/31] drm/amdgpu/gmc: rework pasid flushing
Thread-Index: AQHdOk4QOXxN+tKVFUa0z2UHlV4Pbba6ln6w
Date: Wed, 2 Sep 2026 03:04:30 +0000
Message-ID: <DM4PR12MB5152EF84783AD6122FB926E8E3B72@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
 <20260901201034.2960437-23-alexander.deucher@amd.com>
In-Reply-To: <20260901201034.2960437-23-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-02T02:48:36.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CY8PR12MB8244:EE_
x-ms-office365-filtering-correlation-id: cc3bba97-518b-4cba-1146-08df089ee8a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|11063799006|38070700021|6133799003|10067099003|56012099006|4143699003;
x-microsoft-antispam-message-info: 8gKMhFPV5zyBjx+DXdMXFkd+NSL2p6//5Ke3t494sq3z7UZIOgJ4wpbo+vVcXdNMN78Sou1YLMrTWEeADjIFrr8/q5BrRhNyp8eIFi/rmCF5IGcBbyMC3Gy/1/oAvMevHozSJA62W7qRL4d0H52Amnx5gxMJKP2bxvDn7PyWwn3Ygtr4FMjBmgEeUop4SL0id0yi3e33ureJxD9qgBU15Vyy/iE6b2xSnJVgQ8vir8IhzA6t5UPaGDKSCEEHEo0TYyCGmFelMbpSD7z8zjEIMJfZ1ErKeoULvXRXMWOHDVTXJORBh0z4Su6bj3CFL/Fz/J0OhG39OaSRcz4W2x5CukxZTTN4d/JJ3sYWWWEASpspsYADsfUZZLAAtdgSYDNYcAhXZqrdNiDteFE0k0iBnKQZrmUsc1PSErmUv1D/orVFJQFZHj2879Loy8gu2NwFGKOOw5Ezo7EmQZbv8JKK2pIZhSn9kvbKlPvtG4i/tuJQ9/NcvlISiZnjFJ1z4lcmYPWhq3wur2Q2zFlVlWWtCLJcna9lZzhr8yioYP1w8O/1l1h1IXd7VdzMJAsuJnspsI02Q6xAGxkVF9DESEWrVYUpl9IKQn6bxUpUsOgzAqypLxknv0QS7tKBGygoMNOhiP3LAhUB73Fh4BpyV+9mcRclQvR3zmo97iFkXKOng38u6bJzg6aKdmNdNpgky0i/BboKeJtoPFhCRfyLpACINp9wulssvlJSfjw0IwQx3Ao=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(38070700021)(6133799003)(10067099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Xd0f8Z+hHpaMrGZDbCT8vCW1bbjyvXwZ5vrsnm9TLT7BaaJBrh0as7UnNBN?=
 =?us-ascii?Q?lu4NuUqjPO1py6xrYkH611xFUCa3kiVyVtnK/GMIeNJlq2DlwJKeDcD8PalC?=
 =?us-ascii?Q?vTcQszvDcAtUWlMFA1ynLSWQ8L2cHMcTxIuxm/NVU1D5YZRj8kMzbjg+ZbKY?=
 =?us-ascii?Q?Eqp7Wxm82gTFTg4x0H0pEMkL2z7tfjEcAOOJWgW5iC5fek1bA4DmmDDJBmvQ?=
 =?us-ascii?Q?tKb+BqMvRysqJz8H5qlM/B5MZBxYusrb6yr3rUFeYlI5mhkkEDWdNgNN2DSP?=
 =?us-ascii?Q?qcSl2ue+wYDkzRmS+IUkbl6wULOZivtMEKCuR/02KDOJUH5V/dLy9NbkD3zK?=
 =?us-ascii?Q?vTon41f4k9csb4XMIYUIvxLj0QoWc2kWesq+FU6EwCZxa2ja6Z4cZmU9xMDT?=
 =?us-ascii?Q?r69qqf1OuLm9AIEEnHZ5av4DPfi8lBC8BYcHg3cWdKdTTPsTvTqUo9PBbZ5l?=
 =?us-ascii?Q?HJmQD//fhewt3lrhPcLMe67FTO33BkwDDHB8YXkn9DrgpY6j+nmM2cQvx0wp?=
 =?us-ascii?Q?OQx0TA2LFTQboXaCEhS9sMX9NEZLpWDaNIP4NN+A45q94KiIH3iglwykInHO?=
 =?us-ascii?Q?j0KChmumjwnmdLrLi+BJacs/ql+XLAyra6nfldD1Fzj/5FisP0lLc4Y70VEn?=
 =?us-ascii?Q?3rX7NnAvmUkqS3FUrh7kbn5Mf8qu5RXMm3bJ4sxMolFZxGxLXhb7WPkpIXSx?=
 =?us-ascii?Q?RAcNtr0lZ8PXfcyp5E4ltKzFOxb5qAMx/QpD0DSXnVdbF/K+jO1HjDWMcHqL?=
 =?us-ascii?Q?gnOHYX1ODLGer7VUWh471zAlo3UT7cotLQVA6DNJyIK9PuzNDuh2Ovj1RTUL?=
 =?us-ascii?Q?yLftJMsxnkhToo2O+tNSkeF66BeibgZCiA/xDrF4qNlRcJSa6wGb6IqJw5qw?=
 =?us-ascii?Q?auW/46ZBOx+oasN8kRZ5VD1mA+ek+nJBvsY3+QfwkXzGdmkr3T+1AvhAl7xi?=
 =?us-ascii?Q?2Vtgmaw0MZattVQYFU3QOLmqRUTYBN6ov7SdXBxrXAaiuAKJijJ2BC7NiZOK?=
 =?us-ascii?Q?HDufcTCmwKZ+Ckrpf0CJnspkJ/6Bt7GoOhJkqA0WPl7ZHALLlIxQnfOhHOzk?=
 =?us-ascii?Q?NtMcLi8a1KZyUV778ENgLrAMi5l38cx9e0dmsd0Jguw9/xgQ/mqQOEt/pP4a?=
 =?us-ascii?Q?+QxwLHhd8VWEJccy/FxOrwEluIkVN9oyd3Uhvw5kOn4jXpz2S36lSNiimuCb?=
 =?us-ascii?Q?AsPfJYScJ/gd1py/JTQb3gBpPaK3YMfZVXJEHxVNKdYyEgQupzHVnNK626C1?=
 =?us-ascii?Q?ithYQe5MNpbrOpa7EaWXk0j4xRX49aXRdNLh5NCxoGFEj3z3HP/Oo6fJAMKf?=
 =?us-ascii?Q?yy2BGbvCMfmR/NtlQiR7mxsm3cZjQ2QigfR61qTfIinTPhpkrVDkM6HjRUC+?=
 =?us-ascii?Q?DJxXIz4ccOxo4qYPmjAzMCxI4sd3gzj6E/IelrQB2GcXE1u4T3La25DdAaT8?=
 =?us-ascii?Q?rolQeCtAXvF0956JAuf6Wg/JQC+d918zvyFFdtkSG1cXGzYVcf0WRr8A8ee/?=
 =?us-ascii?Q?x4+anvKyHwXTkdj5SM9SaNcZ47icV+fKsO6sxsq0yfNsazzb+GtIfLa6cVQ8?=
 =?us-ascii?Q?o+8Rs0VmE5GNqTjpEIr/bBq2O6dw3OxFb+a1zO1/2YZZRyCSx8ijDnsWDbY2?=
 =?us-ascii?Q?WvEC3RAMOZ17WYlIsWVyeW9b+w18iExkgMdOyF0O5rKBCJW/++7Qi6Grv1R5?=
 =?us-ascii?Q?OWpqYq1d2Ikic/pFjwnADKBWtjT0VV1EwYfequM4kIOvcNHc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3bba97-518b-4cba-1146-08df089ee8a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 03:04:31.0236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kx/vuZHzU+w3u+VRyV8QZAm7n9c6VLRbzJEqdnUROM6GBPmDO6RHw7NMBv8BJOVoDSHFTiE9c0Q5wshyqOcJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244
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
> Sent: Wednesday, September 2, 2026 4:10 AM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 22/31] drm/amdgpu/gmc: rework pasid flushing
>
> Split out all of the various flush methods and use the new pasid flush me=
thod enum
> to determine which one to use.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 247 +++++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |   2 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |   2 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |   2 +
>  4 files changed, 201 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 8a975eddd75c7..2800eebe50649 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -788,9 +788,66 @@ void amdgpu_gmc_flush_gpu_tlb_gart(struct
> amdgpu_device *adev,
>       dev_err(adev->dev, "Error flushing GPU TLB using the SDMA (%d)!\n",=
 r);  }
>
> -int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t =
pasid,
> -                                uint32_t flush_type, bool all_hub,
> -                                uint32_t inst)
> +static int amdgpu_gmc_flush_gpu_tlb_sdma_helper(struct amdgpu_device *ad=
ev,
> +                                             uint16_t pasid, uint32_t fl=
ush_type,
> +                                             bool all_hub, uint32_t inst=
)
> +{
> +     struct amdgpu_ring *ring;
> +     struct dma_fence *fence;
> +     struct amdgpu_job *job;
> +     uint16_t queried;
> +     /* Use register 17 for GART */
> +     u32 eng =3D 17;
> +     int vmid, r, i, ndw;
> +
> +     /* flush hdp cache */
> +     amdgpu_device_flush_hdp(adev, NULL);
> +
> +     ndw =3D ALIGN(adev->mman.buffer_funcs->tlb_inv_num_dw * 16 *
> AMDGPU_MAX_VMHUBS, 8);
> +     ring =3D to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
> +
> +     mutex_lock(&adev->mman.default_entity.lock);
> +     r =3D amdgpu_job_alloc_with_ib(ring->adev, &adev-
> >mman.default_entity.base,
> +                                  AMDGPU_FENCE_OWNER_UNDEFINED,
> +                                  ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
> +                                  AMDGPU_KERNEL_JOB_ID_VM_UPDATE,
> +                                  &job);
> +     if (r)
> +             goto exit;
> +
> +     for (vmid =3D 1; vmid < 16; vmid++) {
> +             bool valid;
> +
> +             valid =3D adev->gmc.gmc_funcs->get_vmid_pasid_mapping_info(=
adev,
> vmid, inst,
> +                                                                      &q=
ueried);
> +             if (!valid || queried !=3D pasid)
> +                     continue;
> +
> +             if (all_hub) {
> +                     for_each_set_bit(i, adev->vmhubs_mask,
> AMDGPU_MAX_VMHUBS)
> +                             amdgpu_emit_tlb_inv(adev, &job->ibs[0], vmi=
d, i, eng,
> +                                                 flush_type, inst);
> +             } else {
> +                     amdgpu_emit_tlb_inv(adev, &job->ibs[0], vmid,
> AMDGPU_GFXHUB(inst), eng,
> +                                         flush_type, inst);
> +             }
> +     }
> +     amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> +     fence =3D amdgpu_job_submit(job);
> +     mutex_unlock(&adev->mman.default_entity.lock);
           It should be double unlock, and  it unlocks again at exit.  we c=
an remove it .
                Regards
            Jesse

> +
> +     dma_fence_wait(fence, false);
> +     dma_fence_put(fence);
> +
> +exit:
> +     mutex_unlock(&adev->mman.default_entity.lock);
> +
> +     return r;
> +}
> +
> +static int amdgpu_gmc_flush_gpu_tlb_kiq_helper(struct amdgpu_device *ade=
v,
> +                                            uint16_t pasid, uint32_t flu=
sh_type,
> +                                            bool all_hub, uint32_t inst)
>  {
>       struct amdgpu_ring *ring =3D &adev->gfx.kiq[inst].ring;
>       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[inst]; @@ -798,6 +855,110=
 @@
> int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t p=
asid,
>       int r, cnt =3D 0;
>       uint32_t seq;
>
> +     /* 2 dwords flush + 8 dwords fence */
> +     ndw =3D kiq->pmf->invalidate_tlbs_size + 8;
> +
> +     if (adev->gmc.flush_tlb_needs_extra_type_2)
> +             ndw +=3D kiq->pmf->invalidate_tlbs_size;
> +
> +     if (adev->gmc.flush_tlb_needs_extra_type_0)
> +             ndw +=3D kiq->pmf->invalidate_tlbs_size;
> +
> +     spin_lock(&adev->gfx.kiq[inst].ring_lock);
> +     r =3D amdgpu_ring_alloc(ring, ndw);
> +     if (r) {
> +             spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> +             return r;
> +     }
> +     if (adev->gmc.flush_tlb_needs_extra_type_2)
> +             kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
> +
> +     if (flush_type =3D=3D 2 && adev->gmc.flush_tlb_needs_extra_type_0)
> +             kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
> +
> +     kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
> +     r =3D amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
> +     if (r) {
> +             amdgpu_ring_undo(ring);
> +             spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> +             return r;
> +     }
> +
> +     amdgpu_ring_commit(ring);
> +     spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> +
> +     r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +
> +     might_sleep();
> +     while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
> +            !amdgpu_reset_pending(adev->reset_domain)) {
> +             msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> +             r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT=
);
> +     }
> +
> +     if (cnt > MAX_KIQ_REG_TRY) {
> +             dev_err(adev->dev, "timeout waiting for kiq fence\n");
> +             r =3D -ETIME;
> +     } else
> +             r =3D 0;
> +
> +     return r;
> +}
> +
> +static int amdgpu_gmc_flush_gpu_tlb_mes_helper(struct amdgpu_device *ade=
v,
> +                                            uint16_t pasid, uint32_t flu=
sh_type,
> +                                            bool all_hub, uint32_t inst)=
 {
> +     struct mes_inv_tlbs_pasid_input input =3D {0};
> +     int r;
> +
> +     input.xcc_id =3D inst;
> +     input.pasid =3D pasid;
> +     input.flush_type =3D flush_type;
> +
> +     /* MES will invalidate hubs for the device(including slave xcc)
> +      * from master, ignore request from slave
> +      */
> +     if (!amdgpu_gfx_is_master_xcc(adev, inst))
> +             return -EINVAL;
> +
> +     input.hub_id =3D AMDGPU_GFXHUB(0);
> +     amdgpu_mes_lock(&adev->mes);
> +     r =3D adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
> +     amdgpu_mes_unlock(&adev->mes);
> +     if (r)
> +             return r;
> +
> +     if (all_hub) {
> +             /* invalidate mm_hub */
> +             if (test_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask)) {
> +                     input.hub_id =3D AMDGPU_MMHUB0(0);
> +                     amdgpu_mes_lock(&adev->mes);
> +                     r =3D adev->mes.funcs->invalidate_tlbs_pasid(&adev-=
>mes,
> &input);
> +                     amdgpu_mes_unlock(&adev->mes);
> +                     if (r)
> +                             return r;
> +             }
> +             if (test_bit(AMDGPU_MMHUB1(0), adev->vmhubs_mask)) {
> +                     input.hub_id =3D AMDGPU_MMHUB1(0);
> +                     amdgpu_mes_lock(&adev->mes);
> +                     r =3D adev->mes.funcs->invalidate_tlbs_pasid(&adev-=
>mes,
> &input);
> +                     amdgpu_mes_unlock(&adev->mes);
> +                     if (r)
> +                             return r;
> +             }
> +     }
> +     return 0;
> +}
> +
> +int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t
> pasid,
> +                                uint32_t flush_type, bool all_hub,
> +                                uint32_t inst)
> +{
> +     struct amdgpu_ring *ring;
> +     bool use_mmio =3D false;
> +     int r;
> +
>       /*
>        * A GPU reset should flush all TLBs anyway, so no need to do
>        * this while one is ongoing.
> @@ -805,8 +966,38 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
> amdgpu_device *adev, uint16_t pasid,
>       if (!down_read_trylock(&adev->reset_domain->sem))
>               return 0;
>
> -     if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
> +     switch (adev->gmc.pasid_inv_method) {
> +     case AMDGPU_TLB_INV_METHOD_MMIO:
> +     default:
> +             use_mmio =3D true;
> +             break;
> +     case AMDGPU_TLB_INV_METHOD_SDMA:
> +             ring =3D to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
> +             if (!ring->sched.ready)
> +                     use_mmio =3D true;
> +             else
> +                     r =3D amdgpu_gmc_flush_gpu_tlb_sdma_helper(adev, pa=
sid,
> flush_type,
> +                                                              all_hub, i=
nst);
> +             break;
> +     case AMDGPU_TLB_INV_METHOD_KIQ:
> +             ring =3D &adev->gfx.kiq[inst].ring;
> +             if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready)
> +                     use_mmio =3D true;
> +             else
> +                     r =3D amdgpu_gmc_flush_gpu_tlb_kiq_helper(adev, pas=
id,
> flush_type,
> +                                                             all_hub, in=
st);
> +             break;
> +     case AMDGPU_TLB_INV_METHOD_MES:
> +             ring =3D &adev->mes.ring[MES_PIPE_INST(inst, 0)];
> +             if (!ring->sched.ready)
> +                     use_mmio =3D true;
> +             else
> +                     r =3D amdgpu_gmc_flush_gpu_tlb_mes_helper(adev, pas=
id,
> flush_type,
> +                                                             all_hub, in=
st);
> +             break;
> +     }
>
> +     if (use_mmio) {
>               if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid) {
>                       r =3D 0;
>                       goto error_unlock_reset;
> @@ -825,54 +1016,6 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
> amdgpu_device *adev, uint16_t pasid,
>               adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
>                                                        flush_type, all_hu=
b,
>                                                        inst);
> -             r =3D 0;
> -     } else {
> -             /* 2 dwords flush + 8 dwords fence */
> -             ndw =3D kiq->pmf->invalidate_tlbs_size + 8;
> -
> -             if (adev->gmc.flush_tlb_needs_extra_type_2)
> -                     ndw +=3D kiq->pmf->invalidate_tlbs_size;
> -
> -             if (adev->gmc.flush_tlb_needs_extra_type_0)
> -                     ndw +=3D kiq->pmf->invalidate_tlbs_size;
> -
> -             spin_lock(&adev->gfx.kiq[inst].ring_lock);
> -             r =3D amdgpu_ring_alloc(ring, ndw);
> -             if (r) {
> -                     spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> -                     goto error_unlock_reset;
> -             }
> -             if (adev->gmc.flush_tlb_needs_extra_type_2)
> -                     kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_h=
ub);
> -
> -             if (flush_type =3D=3D 2 && adev->gmc.flush_tlb_needs_extra_=
type_0)
> -                     kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_h=
ub);
> -
> -             kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_=
hub);
> -             r =3D amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAI=
T);
> -             if (r) {
> -                     amdgpu_ring_undo(ring);
> -                     spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> -                     goto error_unlock_reset;
> -             }
> -
> -             amdgpu_ring_commit(ring);
> -             spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> -
> -             r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT=
);
> -
> -             might_sleep();
> -             while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
> -                    !amdgpu_reset_pending(adev->reset_domain)) {
> -                     msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> -                     r =3D amdgpu_fence_wait_polling(ring, seq,
> MAX_KIQ_REG_WAIT);
> -             }
> -
> -             if (cnt > MAX_KIQ_REG_TRY) {
> -                     dev_err(adev->dev, "timeout waiting for kiq fence\n=
");
> -                     r =3D -ETIME;
> -             } else
> -                     r =3D 0;
>       }
>
>  error_unlock_reset:
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 4bb10a89ce582..e7c529620199b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -974,6 +974,8 @@ static int gmc_v10_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>       int r;
>
>       adev->gmc.flush_pasid_uses_kiq =3D !amdgpu_emu_mode;
> +     if (adev->gmc.flush_pasid_uses_kiq)
> +             adev->gmc.pasid_inv_method =3D
> AMDGPU_TLB_INV_METHOD_KIQ;
>
>       /* The sequence of these two function calls matters.*/
>       gmc_v10_0_init_golden_registers(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index acab9f4180da6..a35c84cc7385f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -950,6 +950,8 @@ static int gmc_v11_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>       int r;
>
>       adev->gmc.flush_pasid_uses_kiq =3D !amdgpu_emu_mode;
> +     if (adev->gmc.flush_pasid_uses_kiq)
> +             adev->gmc.pasid_inv_method =3D
> AMDGPU_TLB_INV_METHOD_KIQ;
>
>       /* The sequence of these two function calls matters.*/
>       gmc_v11_0_init_golden_registers(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 3c13a6920171a..317b44412b5a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2162,6 +2162,8 @@ static int gmc_v9_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>       int i, r;
>
>       adev->gmc.flush_pasid_uses_kiq =3D true;
> +     if (adev->gmc.flush_pasid_uses_kiq)
> +             adev->gmc.pasid_inv_method =3D
> AMDGPU_TLB_INV_METHOD_KIQ;
>
>       /* Vega20+XGMI caches PTEs in TC and TLB. Add a heavy-weight TLB
> flush
>        * (type 2), which flushes both. Due to a race condition with
> --
> 2.55.0

