Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4564D116F3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 17:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 550A710E435;
	Mon,  1 Dec 2025 17:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="47gZarzX";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013065.outbound.protection.outlook.com
 [40.93.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38BB510E2BD
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 17:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuJRbaB41X6HgRxJiP9aCNiAnXpWri4sisvFhd+U84tZF1fUhnXj7FcwMpswqy/L4PMpudiCGFa3vCPCjPWTzdaIPp3F0Iir+qFfmub2LzrHU/Jos3OjKVqmuxWbwLAm51um5T/IhEJUAWFPRiYXlkpmTMm8Npha9/DngX87zdiNmJ9rcvJpZEVTjWMa6sUuRPLxgOPJMpohTaes8ED8k2sdY8gGeN+xcG45QtTY7rwUaYijSpU6r2DmzxYm9M4MO2atdGSTfIGs6g/MFl1o7nsca3ozlEi0XkAdERpumjdxpX07Ckp8u1okUSsLuuSso1pfwEFgX3vIgJrwZs14lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDu8xItKEBQSaAN7DYrvho5ObwZCvIcTRUvyrB556NU=;
 b=Qozr6hPz4jbu0rylLBzSYE1qBI3kIomWko2zz6OAOOezHgvjeuaGSN88o6+5xAIt0CGCh81g61tcmIlbcET1dKXSjAyrBqUSAJ2OO6+fzmz3g57D9moMMvBMMnVzwrqPcC9E0l+z8Myp/ZR1wS85eh74gGKZoQYgkGsfs56LCiEa0DaA5kSCUOsaxm5Gfn+vn58e2+zIWq14lY7gbk8z+ZAeTPRBbhG/NKZcqEIsO2HAVJt9kQoCYNtzajQPxQ7xJuFE/tgZhil5y35NlD+ONLc/Gyzd0fSZvkyeCYZ7O4QpO7hUzo+rZbKKIx9ri/uZxxh5BhOsGaJQddYkZXzvdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDu8xItKEBQSaAN7DYrvho5ObwZCvIcTRUvyrB556NU=;
 b=47gZarzXRhTKPWJCiSnMOiYT39rphGK+kVNcmjsbNJ2Na6tuI8F08vasVrCw4pnDfOHfm+rBGgw3IuMhxJ3rgRIirTfK3bs32yx42fh98thwHyHJw4309OuLdHhKIiNxzDJMqvZOXh2TTpOFekxpbLKhY1K+3KW0B+9V+NSw8tg=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by CH2PR12MB9459.namprd12.prod.outlook.com (2603:10b6:610:27d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 17:38:15 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 17:38:15 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Yat Sin, David" <David.YatSin@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH v2 2/4] drm/amdkfd: Add domain parameter to alloc kernel BO
Thread-Topic: [PATCH v2 2/4] drm/amdkfd: Add domain parameter to alloc kernel
 BO
Thread-Index: AQHcYs7bSXxj0P+fBk+0yiPkx+JAULUNDKIQ
Date: Mon, 1 Dec 2025 17:38:15 +0000
Message-ID: <BL1PR12MB58984080C0F17CDA486C8B8085DBA@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20251201142838.1516452-1-Philip.Yang@amd.com>
 <20251201142838.1516452-3-Philip.Yang@amd.com>
In-Reply-To: <20251201142838.1516452-3-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-12-01T17:37:54.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|CH2PR12MB9459:EE_
x-ms-office365-filtering-correlation-id: fbe40053-6db0-43e9-42ac-08de31006875
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Gepe7bRnLejU1I/6kmgDjAzLK0R2u4UEcofCYUkk8ILWiuloviwSAtbAlERn?=
 =?us-ascii?Q?PeO11dCxZW0C1ecDdGNNwB5JehSJvf462ay0oQjXizFB03sKl48+yNWUGoz7?=
 =?us-ascii?Q?ILNIBOgN+9PVIBjf31QXhRwrBLa1nlcu8W/1GkbRT8qOr9dm7EgTI+4WYRxx?=
 =?us-ascii?Q?r/5MyrZJ9tUdyvmays4/dbQJu034G0SlnVJFCGN96iAtqHp045nf9BUZJIFQ?=
 =?us-ascii?Q?wbAWBRbz5rFN0Hj/cWq2RyCmKMIkUaWNeCfC0hzMC7E21qHgycN+JM3O6+rD?=
 =?us-ascii?Q?nDO7pnjzEq4pHobCiUecmChRT0C2PHES3kD+LCIAU1TSIM238uDG+j8WycXa?=
 =?us-ascii?Q?zh0tt2Y/RLbCg4B5fs7HyP6em8HNzZcwSi2tKekOzMrwSfPBjkppCukovtIL?=
 =?us-ascii?Q?qCDivgSbvg1OBv6kb5GWHKtPrU4gjTnu4FviJKmHaUJERtNFuYE7tzp0D0Cz?=
 =?us-ascii?Q?XsLfliB3QRtjR0jJtUzJKLs0V98FeaQUYwonwrZ4nzVVs/fk2ng0xyifFJci?=
 =?us-ascii?Q?YnbluLJRRHO7tMq4tZl9WFjhskfBHvg9aDikbp6Qk7rC334n+z68wJcyl4TL?=
 =?us-ascii?Q?BwRnRDtebEfSA2w1N9KN/52+Ww8yttuPTYzm7BVtf0D0uJbZqCaY9NWyTYhC?=
 =?us-ascii?Q?d9GF82drJBc/EVsiY7rocj8En0EB6UoHdoYRHEGkO6APNYUnCO79jAyra1yK?=
 =?us-ascii?Q?VpkChrJ8WDCYcAj/J+xWDG+0F66xOoRFGssEX7rkbzGV25NoKV7ycy9LKIv4?=
 =?us-ascii?Q?s10iMLw0hE/L4g0G//DcpErGKelmb4MQBAlJCuF+I2gXy3s4JULpZwK3Hkq7?=
 =?us-ascii?Q?QD0G4pXXmp2P3BR/s6bWWpaRwg8fvkF490u2dlsJY5j7I7Jj5czeuMbfdX55?=
 =?us-ascii?Q?8CTQBGlUP6hRcb+CxU0215DKrcshiA0HqPBKewvO+OwexsLLSMQNvlK/sT/9?=
 =?us-ascii?Q?TwcGkjLAEb59frddeTrFXGnMwZ/qbPoNPzFrwbYSG3t5LWS05gBf44kJ+fas?=
 =?us-ascii?Q?ia99OdJ6DIBLM5R1HZA5ajWIcO+75fbwiNKfyAr2hUfY5rWhHHxdDOZ37kzq?=
 =?us-ascii?Q?m8HGH8b+4IqLo3ZDadSjIRcLS/0Y6zdo11YBIt6LqL7E/QO1Xy5Qp0CYhHnj?=
 =?us-ascii?Q?MEbHRfUdYqjWg59jskSeyqg/+o+aEHXrRxpXwenSds5gimA5GdSckBomHcn+?=
 =?us-ascii?Q?7UlO2YsaNaBfW6bBNzT/Yyvqu2nGB1H7PsiMh7kQGNJDteN2fRTfPrAXl45+?=
 =?us-ascii?Q?Nq7kS4whyyyC3GGrgm6alwbYCu4XEVI5eILCR5cF5hhNUXc+jw+5WfqBMJIy?=
 =?us-ascii?Q?6z6Jz+gBmKpm6QV1PIdaiJS5yNCbWoqdBrdFHKAFS2aJimbwUUt5qveSxhXy?=
 =?us-ascii?Q?F6jdWtIDGC33/AfwZjYJKKRWziaZa+Y80Y3gKAzoXdx8SRhBoNiajkuVJOSP?=
 =?us-ascii?Q?0W1EbEZjcRGBwH1ILIvH6q8jtXumFWGGFdM/HnvyluWpgCoAX8P/AGXSqZib?=
 =?us-ascii?Q?IK7GvoEsLJ/0W9pVXSb3y18EX/Psc+soxO8o?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+SyRTGL4MPqes3pgD/5rj8SRJfoEjFQC4DG7ifZE1fw6ydX0mfbWCJjKDl8Y?=
 =?us-ascii?Q?zZmBUxcWIljlENWEPa+v5Oh2bbBj76xNK5psrcT67vTUy6rFcAIcLOWiW25o?=
 =?us-ascii?Q?PrN1G0ZlJnTGtPfpjpBVQ+bqqwVMytVbIq4iY/wQrUOp2pisoqneGRUNVIkZ?=
 =?us-ascii?Q?57JxhmPWuaMRyfI2C8jILPYODnxUn3Qka4excMWTAwdiKDqBqi3YHxEKJ9BA?=
 =?us-ascii?Q?wjJ8Aw6dq7fQmiixVmo/A/sUU8K0ipOoNgj6qp68CgZKDEs6Cf6mGDCDuuiU?=
 =?us-ascii?Q?a+TGyMHQdfXF2QmvbR0FpWmSYe/d/+QqsdTlEN9dnPosoiy/Erc1rm/BS/ad?=
 =?us-ascii?Q?cJEm20r0mRiZ1j7CWY3KFO2o6obCBKzqqtewxEhP8EaPOGAGhXnFV5f2t6hV?=
 =?us-ascii?Q?cH4K+6XHmM7Cehhp/nrSU9P0h6Fyb1NLUx1eh45PAuw4KsOMY7SJCJgAtFQ2?=
 =?us-ascii?Q?9L1EkTOvl3o9DqdZwfolSztNCVo///uFVCwckE7d0uGRcVHpVQnFeeAxTE98?=
 =?us-ascii?Q?oCNWhOjGGj6M8htksnrkVewJ2HCVg/WSc/nnYvubTJcVRldzBy4t3sj64w2E?=
 =?us-ascii?Q?fNzDGb332uE2OeCmpqehoi4Fl7MuswES44WYb0MJGanvPYgqSYzH21l/gfoD?=
 =?us-ascii?Q?AeOVdkP/xN8EeRZvupugs06tACbgISCREpVCFCa2CnWSp6FEh4RVyypcZ4S9?=
 =?us-ascii?Q?Hnx4ARSJhmLDVQWbTWbVVPUcuOx49+K+gGDeDrj9A8Fpo8SlQlp5ISv8GJbP?=
 =?us-ascii?Q?guklz2PmbS06eD2Kxm8dsxNQ3NsMkXWS3q/N7MGwCW43OgMyqUOo3jtKZcWW?=
 =?us-ascii?Q?Y6gONWcu7vb3pWm4sNd1kzIgbmRXJhXsQ+FZ4bdy56nTma7SqnWRqybBbuzr?=
 =?us-ascii?Q?xzfLf9N4vfHPrb3dHj+8hXkVe1OHy3O6GPqWkQRU2dIBaiYk904LGLLc2SsK?=
 =?us-ascii?Q?CNWd8l5fW5EsMlM02RgSWtJhslD+tBnSEQbYS9Vhm276tKWvwzOilARu+dn6?=
 =?us-ascii?Q?FD88a+2xvMchqxYnQZ+hWTrb4bcutKin5B34OJRe13T8Sg0GbMqDvjSemQmi?=
 =?us-ascii?Q?ngISS6+RrjlQACr2tOOYwtnaKwDkByT9i3mDAO4mGTaYAhxse4xnkLjCYVcj?=
 =?us-ascii?Q?T/0SekwZJAxdfcPVoHfeiFmZl9IYno3JcEqHPhN82oa8/f99HMSAZwLg2QGd?=
 =?us-ascii?Q?XKS+Wz/RnyfvguW+urxmAUDEj8ckdcMpKeWtQwSf3MM7rIxmZ92Va8yD4mu7?=
 =?us-ascii?Q?D3cyi/cJPLsjg/sSZoXDlGBya9UahuuwdFPmhPmnAp4kP5AcE3/KAIn+IZEG?=
 =?us-ascii?Q?PYBPpEU2QquzhcXsy+lETlqxjMBm7uegRGzvCMeSGIrORxJYWHRjHK40HJBm?=
 =?us-ascii?Q?qw5Gpf/uNUVp1PSj6GAy4HLBcTuolhoYBJ0Cgl+vHOEb8g1RcM4nkZbmD/Kp?=
 =?us-ascii?Q?8AA7zp/D6kS20D9m1FqGmFPB+BnbvYreond5J3ulIiEf7GywUMBQl/OEkAQC?=
 =?us-ascii?Q?Rt9Mnv6qlzO36mD5fRTtIAB29l+rZZqqDzAxQnAQLi+tjOaM8WZS1s4lo/xA?=
 =?us-ascii?Q?UvHtcw1bClDPGveGptU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe40053-6db0-43e9-42ac-08de31006875
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 17:38:15.4427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7CTlSBFGtOnZRGtrbcUJHv3GbaAXYPCaXOxTD+NiCsULrhP+wUBCvltg71dVU2UlKtO0moMjWCsDIfxrZPZ1AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9459
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

I know that it makes the change more complicated, but should we be renaming=
 the function since we're no longer guaranteeing a GTT memory allocation in=
 the alloc_gtt_mem function?

 Kent

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Philip=
 Yang
> Sent: Monday, December 1, 2025 9:29 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Yang,
> Philip <Philip.Yang@amd.com>
> Subject: [PATCH v2 2/4] drm/amdkfd: Add domain parameter to alloc kernel =
BO
>
> To allocate kernel BO from VRAM domain for MQD in the following patch.
> No functional change because kernel BO allocate are all from GTT domain s=
o far.
>
> amdgpu_amdkfd_alloc_gtt_mem has many duplicate code as
> function amdgpu_bo_create_kernel, with one extra flag MQD_GFX9
> to bind MQD and control stack in GART with different mtype,
> the duplicate code could be removed in future.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c             | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h             | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c                 | 1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c                | 3 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c        | 1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 ++
>  7 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index a2879d2b7c8e..9cd1660b8f60 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -317,7 +317,7 @@ void amdgpu_amdkfd_gpu_reset(struct amdgpu_device
> *adev)
>  }
>
>  int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
> -                             void **mem_obj, uint64_t *gpu_addr,
> +                             u32 domain, void **mem_obj, uint64_t *gpu_a=
ddr,
>                               void **cpu_ptr, bool cp_mqd_gfx9)
>  {
>       struct amdgpu_bo *bo =3D NULL;
> @@ -328,7 +328,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device
> *adev, size_t size,
>       memset(&bp, 0, sizeof(bp));
>       bp.size =3D size;
>       bp.byte_align =3D PAGE_SIZE;
> -     bp.domain =3D AMDGPU_GEM_DOMAIN_GTT;
> +     bp.domain =3D domain;
>       bp.flags =3D AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>       bp.type =3D ttm_bo_type_kernel;
>       bp.resv =3D NULL;
> @@ -351,7 +351,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device
> *adev, size_t size,
>               goto allocate_mem_reserve_bo_failed;
>       }
>
> -     r =3D amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
> +     r =3D amdgpu_bo_pin(bo, domain);
>       if (r) {
>               dev_err(adev->dev, "(%d) failed to pin bo for amdkfd\n", r)=
;
>               goto allocate_mem_pin_bo_failed;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 335d733751cb..14b5ab6fa051 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -237,7 +237,7 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct
> amdgpu_bo *bo,
>  #endif
>  /* Shared API */
>  int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
> -                             void **mem_obj, uint64_t *gpu_addr,
> +                             u32 domain, void **mem_obj, uint64_t *gpu_a=
ddr,
>                               void **cpu_ptr, bool mqd_gfx9);
>  void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_o=
bj);
>  int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index ba9a09b6589a..494a563e072e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -359,6 +359,7 @@ int kfd_dbg_set_mes_debug_mode(struct
> kfd_process_device *pdd, bool sq_trap_en)
>       if (!pdd->proc_ctx_cpu_ptr) {
>               r =3D amdgpu_amdkfd_alloc_gtt_mem(adev,
>                       AMDGPU_MES_PROC_CTX_SIZE,
> +                     AMDGPU_GEM_DOMAIN_GTT,
>                       &pdd->proc_ctx_bo,
>                       &pdd->proc_ctx_gpu_addr,
>                       &pdd->proc_ctx_cpu_ptr,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 9f183d27a0ef..b0cfad750919 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -787,7 +787,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>       size +=3D 512 * 1024;
>
>       if (amdgpu_amdkfd_alloc_gtt_mem(
> -                     kfd->adev, size, &kfd->gtt_mem,
> +                     kfd->adev, size, AMDGPU_GEM_DOMAIN_GTT,
> +                     &kfd->gtt_mem,
>                       &kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
>                       false)) {
>               dev_err(kfd_device, "Could not allocate %d bytes\n", size);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 36ac35d64126..028fca1d2755 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2906,6 +2906,7 @@ static int allocate_hiq_sdma_mqd(struct
> device_queue_manager *dqm)
>               NUM_XCC(dqm->dev->xcc_mask));
>
>       retval =3D amdgpu_amdkfd_alloc_gtt_mem(dev->adev, size,
> +             AMDGPU_GEM_DOMAIN_GTT,
>               &(mem_obj->gtt_mem), &(mem_obj->gpu_addr),
>               (void *)&(mem_obj->cpu_ptr), false);
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 2e9b6bcf2704..a489d43d5f64 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -139,6 +139,7 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_no=
de
> *node,
>                       (ALIGN(q->ctl_stack_size, PAGE_SIZE) +
>                       ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
>                       NUM_XCC(node->xcc_mask),
> +                     AMDGPU_GEM_DOMAIN_GTT,
>                       &(mqd_mem_obj->gtt_mem),
>                       &(mqd_mem_obj->gpu_addr),
>                       (void *)&(mqd_mem_obj->cpu_ptr), true);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 5f8cda4733f9..e0c5ec7e2fe9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -266,6 +266,7 @@ static int init_user_queue(struct process_queue_manag=
er
> *pqm,
>       if (dev->kfd->shared_resources.enable_mes) {
>               retval =3D amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
>                                               AMDGPU_MES_GANG_CTX_SIZE,
> +                                             AMDGPU_GEM_DOMAIN_GTT,
>                                               &(*q)->gang_ctx_bo,
>                                               &(*q)->gang_ctx_gpu_addr,
>                                               &(*q)->gang_ctx_cpu_ptr,
> @@ -369,6 +370,7 @@ int pqm_create_queue(struct process_queue_manager
> *pqm,
>       if (!pdd->proc_ctx_cpu_ptr && dev->kfd->shared_resources.enable_mes=
) {
>               retval =3D amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
>                                                    AMDGPU_MES_PROC_CTX_SI=
ZE,
> +                                                  AMDGPU_GEM_DOMAIN_GTT,
>                                                    &pdd->proc_ctx_bo,
>                                                    &pdd->proc_ctx_gpu_add=
r,
>                                                    &pdd->proc_ctx_cpu_ptr=
,
> --
> 2.50.1

