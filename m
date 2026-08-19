Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A4EC5DF81
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 13:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8576A10E54C;
	Wed, 19 Aug 2026 13:39:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AUKuToEX";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B8C210E54C
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 13:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pnyoa2aci1Gaq5PCH3+sLQxpEJzaszEiOCjz42DTSXudcAsvh9poJsvt+uB9H/tRS/3pAvmYYe/1peikjooacTuSQqOeNxB6n8CmxRiW/tPfhSWZlsPzir3iEl+OZDForTqYMfthmeI896+gX8LYlUw0e02pUTxIYC3UjxPUfmNTcckEc9cFjC9UBqQQ/jmEZsceUwo/9wzFoeiEq0Py42Tne7A1QhnLf5ZbEs1QA6nFCka3RI55ZG967DTCJhMAMD5FkAmf+pG4XgvJP1cdpywEwTyu6roPga/AgChQg1hx1ANqiiEWp0ZgemuZv0P7u/1m0+o4cDa5fG6x1evYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZAymej3pMhdkxya3ZBiGuLk/W3aXHcYiyumWVK7GJg=;
 b=OED5vqR9EiHvzRzI0MsAQ5BolZIqJG6IyN8cAN5PyT/H4uuwFIyryaafVLPmD9aKVkfP+Udo2toUvVBbnlQsIxfWHnVREZLCnBuheeSgbaJi8Zoc11OOQhwNho04LE0wCGcguTJUQZ5rxVvj9b5853yOp+HMoSYnQZeVoU9onLalzED5ExNuoKHMn+ihPG7mDxxxnZVJ2IyK55L41vDOG9JZQ8guHVjNLKhxHfUE8HiymQLAGldgnmONo4UfLsfDGu4No3/nE6MtMGsNpDwoBES1EwsBZVjhislF99bCki7G53U8cXOmNIBD8IIVnlMI9Zt/NH3bTs6ankTKmKPCoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZAymej3pMhdkxya3ZBiGuLk/W3aXHcYiyumWVK7GJg=;
 b=AUKuToEX10zMXcOtImKd9Mc6NcB3UWy6ODr2M6hNybSTs3ZT2c0auRupahLsaEhErOqtHrQ4GpVi1F7QR2PJATVrvglE4ZYFtcNT6zVSBojbVhGc4+aYBXVpp+wa+bTGlIM0i4gfjJo00IF/rnyhIU5btebEs6vGN1/YTj10E8w=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.8; Wed, 19 Aug 2026 13:39:08 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:39:08 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu/userq: fix lock missing for userq fence
 error set
Thread-Topic: [PATCH v2] drm/amdgpu/userq: fix lock missing for userq fence
 error set
Thread-Index: AQHdK52lu6cNuxwavE+gPq8QvqJlL7alaOyQ
Date: Wed, 19 Aug 2026 13:39:07 +0000
Message-ID: <DS7PR12MB60058CCC10065C661C05B2C1FBA52@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260814033302.406402-1-Prike.Liang@amd.com>
In-Reply-To: <20260814033302.406402-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-19T13:38:54.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MW6PR12MB8736:EE_
x-ms-office365-filtering-correlation-id: b6eab6ce-2863-4233-5c78-08defdf73e86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|22082099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: +GtD4xZm1tLv2DClUXg3jcX5Czn4But43I+4UF7iS9voZyyuBCeiF8U4WpjCmaco4BH47HHfdUHqNleEyJ4f1RY1LlRalTQg7fTUoup7HlgwuNhw7THwYZ4jB6K+MimgTR2j4gmW9fzSccFuWOFZuwK5HATp5BW0fKW3dAXOh7R3u0TbxBmDwVjVKEpH8UWas9fKhVCvVCusL6PAB9YP6axBuIUjpNnEQSPgGHPoHZ1hWcmVaTt0E6kmvn5ekisp3Dj6NUSOvoKz9nb7rmT6JQzQbivLsI8hVNb/RVAx93f2iI7UDadfQ7VHlmiAFhKBdyb0NqsNV9EjZ0P6z3srX8c/Ap2BJXccq/RyGTif/q6JqlSS043xW39WICKPIWlxYoQbLNVsYYAmyMYv0U3ssrErjPSJQ2hpPfEs13exxkPyFPecWAO/LbN4nFWICGX3X7lHKcus93JsBLiwgXnyVwzae9EZTZyhjvbtOqW5tFmMpjAdqe9EenWqOn0/aygkbBM7dXkIN3i0Agh3inDxcVvPEiHNQuCwFNVF76GsOXb4ttacMTKcVCyPtOkjTM8A+KtmGh0HlqzblkcFAcOJ6bDog6ighjXgavBnVfWQNdJd8SYHMwVnFC7njb6Ht6EkpB2jN2I+7PPAjnj7EFErcazmF0xLHjemgG4uiFLBLjl5BNbT+fIf7LBUrbWT+TP98At970fI9ZzqnRNbvX95FELr9DB94SCLjZUrcKA6dmE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DJ165jp3qDwK4zQTA1DrJaVLLRykumADruw3AaDs39ToVjmgPjVKD8MAZ4uI?=
 =?us-ascii?Q?Pr8VHp5LL75pyE1xBRStjrH+Cqx+vtK0tsJjPDmc4lcONKH46cq6RDsPORwr?=
 =?us-ascii?Q?L2NKDhoWovr429JkHXeR2AjisnVVLhW+2gqEcYsEOMrd9axlhpVYcs6BVBKl?=
 =?us-ascii?Q?vhWJlAwYkHj8Ka93MXh338U7LYefxONU/HILJfvmzdMJGPE5KL8jBTt4tYs0?=
 =?us-ascii?Q?/no5CMRnC/l40XsWrzY7r6kV9l+sDAEOTZ10fdkjbwnXktyw/tk3aXC1w/j1?=
 =?us-ascii?Q?6KZzju1O1BADBfal6ei0eDe48qWExyUTwoTYFM9YMd9/sYxTJuGir25pwcX1?=
 =?us-ascii?Q?TvbafOblu0rbROQSoPRWgnB6mD1J0eT6KsDmShCr0WuIdgppASidAi2o7hYJ?=
 =?us-ascii?Q?PO4XzFE6AJJZt+8HSrVg+rqU0EhhhF+WgxEfMV5kN0Yrxs65BFC3L+U/OXmr?=
 =?us-ascii?Q?qGrm/JTH2FHtjtwnpYhaZr03yxSB/VLwbx55ZfoNwY0qPwGKBATz5TNLWFc9?=
 =?us-ascii?Q?PCxfjKYs4rUNhket+qg4EYiNEdKM0qkxBPFYU5nz98TryEvv6+kyU08dgowX?=
 =?us-ascii?Q?EU+bmgnPh+oC3Ef0YqcgHag8mA8Zo6P7uOMuRA4qsAnzNF1CyPd5DwDXTc1X?=
 =?us-ascii?Q?J4yz7T+khX+3oDiJyfGgHSMH5MGPteYb82Jm+norbPifXRsXYqNAKkzi1ycU?=
 =?us-ascii?Q?/nB3LNSEKw4z6y6WHw6n5W9k3FwIIhlOmZwZM0w6thI74qXswOnbXsn4updi?=
 =?us-ascii?Q?G1sVelSWBKt39VdojVCtU4NGr/wtzDDHMkwAN0qbRzCq5kPITI/JDZIYc1Wg?=
 =?us-ascii?Q?5aSyYXhlBwnC9FBZkMr2BVUFjKw+1i0rqO+P5uE8Ez0MOvzvEDMHaXlrH2Gn?=
 =?us-ascii?Q?MdAQ6PYhRupq8PjG9R0LyKTS5zquy8bh3jRPsFQeYH0ElrO9iuE5SROx02O5?=
 =?us-ascii?Q?Zi7cjDA9AVHTzhaDd67+Jkjhbj5x0Nd9pzR32mpqoKuKTJIHhJ3CGwdzuNju?=
 =?us-ascii?Q?R3iWYu+JLDSjli80crjQm2oNAtmS2SEI9sSOHBq7pyTDF1CD1I826ha6Zk3H?=
 =?us-ascii?Q?91fsA+WsqLrKxS/H6S8IWXlkXcFL+LcY3DMKp/DsCNwCrjqKa5my/kI2mUk2?=
 =?us-ascii?Q?y6EX3F8fBywm5uQhwmZy211RJN29LJXZoxDZvhBLyZVD8y1UeX5cowNR7W6m?=
 =?us-ascii?Q?vRDGm9cdb/G1R3iNlVI5sZGSBz6Y6rdLIDQV8NqAgm9SFbXgOOoH5wQlRJqq?=
 =?us-ascii?Q?uxo8O2sf85EvZ0qHV+gdDuMNAFqc63cTxlCzvYjvsFvwXydkgJn8OxnDbjCF?=
 =?us-ascii?Q?m53tCnB5TQj01WtMH7ILdMKM+Z/jlCIt3hb9woxbmHMpObMuihFKMb25Sf1t?=
 =?us-ascii?Q?Uhz9Cii7DUovZfXXwO32CoBGjLPWErUy2fYXx5PJReT5stQQiCB49QRJrpxm?=
 =?us-ascii?Q?L3rEYJRd6JlRAUwdk4tE4oLqg9Ywtiu5abFiuyyp/D2Z0yaDE1eimuSdlSKZ?=
 =?us-ascii?Q?L9aoAEZ0EOj4xrx7SgQBo1LkQra7MNZS06UzBTYaPzt7PcfVE9ysF4NtILNp?=
 =?us-ascii?Q?vBR851kEhQ4ya3Qagg+s+m4C+0YOIlFdwmAcpYUXKTX6NNBUnlHvwnHEFq0z?=
 =?us-ascii?Q?AUGN4U979BwGnvd7RHyj4SUy2Ycct2W5k/jsAP/b+KFsG/+YqthmydUnhwpx?=
 =?us-ascii?Q?CCAKAna0WBC4IRmciCzCRCuUCTzUWyt9rwOuub6bHb85nkyo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6eab6ce-2863-4233-5c78-08defdf73e86
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 13:39:08.0352 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++Wc+T766zFCWfHi+GavtAx+zLWOUtCd4wNzfBvEZtmQm8r4d2LfWlHCb88ko+46
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736
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

Ping..

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Friday, August 14, 2026 11:33 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH v2] drm/amdgpu/userq: fix lock missing for userq fence er=
ror set
>
> amdgpu_userq_fence_driver() and amdgpu_userq_fence_driver_destroy()
> don't acquire the dma_fence spinlock, so locking the dma_fence lock befor=
e test the
> signaled state and set error state.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 20 ++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 19af1adc2921..09e2079cfdbd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -191,14 +191,15 @@ void amdgpu_userq_fence_driver_destroy(struct kref
> *ref)
>       struct dma_fence *f;
>
>       spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> +     lockdep_assert_held(&fence_drv->fence_list_lock);
>       list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
>               f =3D &fence->base;
> -
> -             if (!dma_fence_is_signaled(f)) {
> +             spin_lock(dma_fence_spinlock(f));
> +             if (!dma_fence_is_signaled_locked(f)) {
>                       dma_fence_set_error(f, -ECANCELED);
> -                     dma_fence_signal(f);
> +                     dma_fence_signal_locked(f);
>               }
> -
> +             spin_unlock(dma_fence_spinlock(f));
>               list_del(&fence->link);
>               dma_fence_put(f);
>       }
> @@ -423,11 +424,16 @@ amdgpu_userq_fence_driver_set_error(struct
> amdgpu_userq_fence *fence,
>       struct dma_fence *f;
>
>       spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> -
> +     lockdep_assert_held(&fence_drv->fence_list_lock);
>       f =3D rcu_dereference_protected(&fence->base,
>                                     lockdep_is_held(&fence_drv->fence_lis=
t_lock));
> -     if (f && !dma_fence_is_signaled_locked(f))
> -             dma_fence_set_error(f, error);
> +     if (f) {
> +             /* nest f->lock inside fence_list_lock */
> +             spin_lock(dma_fence_spinlock(f));
> +             if (!dma_fence_is_signaled_locked(f))
> +                     dma_fence_set_error(f, error);
> +             spin_unlock(dma_fence_spinlock(f));
> +     }
>       spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);  }
>
> --
> 2.34.1

