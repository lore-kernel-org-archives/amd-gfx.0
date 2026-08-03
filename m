Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8ADC55182
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 14:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB0F810E046;
	Mon,  3 Aug 2026 14:07:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fFGMTpQm";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADD7110E046
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 14:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5JSgMIcqofrIg+Bpf3acQmR8RAaEmAYFGbriXHXgteY2q44CicndyRhlONrbO5oZJXaYmuzgK5xq0My89nXaPXTeTV4ztDdVPULn/1Qh4ugO1Ak48xV6W8OqnhNCPj7q/Z3LWDR/TCUe0GIOZ0RKYbUF8CCtDj/5NSrXBOEziz1Ajsei+jxbPQBcxD7Wt/bCks3TzBIlpLxdRkFfJuhAExP+CBrKoqcgPACnTPRi1aHw18eZ5ATVKAwtaB5eHKtYEze+8bp25RM0dL2A/+qCEQBUz0iVVpXXUz10ikcSYyvlrH2TbbcCbnRUoH5Vpojnq+BxgDFsMANtkUtyQzXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNkTeQt9cF8+LF7HxgEvhWMw7Jwt1SoaBA/bgmsUFAE=;
 b=FnYwGpK3DF6trZKxFhnzh7iSnCAg3wQh79mPZnncHYKsL1b0MhRfMUqpz5H+bLJz/CRwBaq1sDeSfvyWFPIPIVBZmvxu2jw4sURR/zk+AR0G09VqqtFV+N9rfotcLpSUFls6gmifrLIKFqyn1qf+f92ajjY6N0au75s6vhVJp3hw1X3ch3OofgdVU9bSu7RQBseYcmPi9M8q2h+RyYGxgcHseGj6u0G3PBq57CJcT0psRJeyvf43ioLplGrk5yYKlRhm7qlbuui+ajv5uz6TcxZwQCxZ5DuF5TxQirnNbqrP3bcotjMxJKEXjRjeHiiwXTyHjua5J4u+b3kBZ/mMaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNkTeQt9cF8+LF7HxgEvhWMw7Jwt1SoaBA/bgmsUFAE=;
 b=fFGMTpQmD9FTNOuizcrBN7DwCSPSq3LIF/ygci5YqNc0RDa2DmTlZNJpgr488DHtipu9cstou/XdYOHdKlOlnuqrWN97COn40wwBotMnpb7IJ/1+5yOKcd6O8lPBcnyTpz8DUdvcTCJSqMgfMeHntW8kMG2mYllE0T6qwzWYa3I=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:07:07 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 14:07:07 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Chen, Michael" <Michael.Chen@amd.com>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdkfd: enable rs64mem for kfd queue
Thread-Topic: [PATCH v2 2/2] drm/amdkfd: enable rs64mem for kfd queue
Thread-Index: AQHdH8hzQdA6V0UvE0Ox2HMImbZFT7aMYxVQ
Date: Mon, 3 Aug 2026 14:07:07 +0000
Message-ID: <DS7PR12MB600539B792A32BC346F23EFCFBD52@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260730020911.234193-1-Prike.Liang@amd.com>
 <20260730020911.234193-2-Prike.Liang@amd.com>
In-Reply-To: <20260730020911.234193-2-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-03T14:06:48.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|BL3PR12MB9052:EE_
x-ms-office365-filtering-correlation-id: 63e943e5-89ba-48f5-a668-08def16880c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|4143699003|56012099006|10067099003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: E5HkHwoMRNvQFaAfwaf2RwA5RNH5VTFjWhdr/5Wb2/dZTtaUbsE81aJyePRwuEDW3EQTreqWcxS95r7eR6mJqI2pcmCkCAtXUK7jyRxPQIl7NtV9nbL8btPZEZiqBjeqWioJk57bx6Jsw4AlSYcBQpeV6vpBsVvrQkysvQulteY87dgXZHwltKnFFuK5pHVISRNlQVfOEsFpAemJiKU6Tik5SC0s8Rkl30+Dh4f6R6BDFxJ+E808/BvT6F5aC+ynQCvSPn1cEaedztiegcVdXNmxr822XwsUXMK74r/n0fLETCWH/N7DktTN+Xo8do1hTNnMw0x8w3qioQ2EiXI+OSjsXTugvW5W7ru7lGLedMxasfVWOgYGHPDBKdp1z3WZ+Q3RQEX6JE3DJ+AL3vZtxrm2kDh/aX3dbVXYQfxcZG4qAc3BWUEST1vYYxzstMPWD33zvh3qt2VaCqlDufB7Z7IXdLyFw0ElhkkuDbocRJ75fc1enZGM+dBjl1jX9qcxb2fZ7wrMDZr6+3XBJeBgXE6E6C9rHbx0Us8A3TjNHJ7iTNOTPjvrTHXtibTOOmmpCgrJJ2eODUSv9lvlvoCO9rjqKZOQAByXMOwn8+OxT3h6SUAmHlFJv0XpGwxhXNVoZQbP+gdI6en8ps0KI8ZUBD0vyT+XMXS9akF9P7DxBw9jGuNuykj5zNb3O5j1j9WoGEAGqOAU/9t234S+mRKSc3XDksa00He5DRsB1xxHGLs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?up0zgk+Ds2gxaZLeOMc0+bv0Qi2P5M0a6q00KiHhlQExhfaW8vulCFwa15VS?=
 =?us-ascii?Q?hcmBAu01+SDCEkFWNnhnkX9oHRzQgbPUAuFlsrG8vfZ8IIrcwlrXgVDRBQf6?=
 =?us-ascii?Q?G0htpCKJ77i5hT5bl3Em98dksjgoIKPnFJ80A6bJJWHVmwgsrQLkfgIkIZFz?=
 =?us-ascii?Q?F5BArr3iLu9sK4PtGSSKyUgdY6rP8MBY91+QXo33xZl5jXtgu/awAp7uRbcm?=
 =?us-ascii?Q?GxgKpheX9iGu95K0kkmFhh4FhPkCep+plDdirWwnvau+rM6bh2RjSbUz2Aj6?=
 =?us-ascii?Q?g8uPWJlvkagV9MtCxhvMgj/A953WKDLpivvqFpRx3psps+XCemWoFUR/BsDy?=
 =?us-ascii?Q?bnSGMgb8Lu6erL/q/L8gfE4hRVmZcWb2CUvZRkj1PqDHXYsrzSKEyApvd3ky?=
 =?us-ascii?Q?PNSos+0Wwi3cdiNLLnoOjuZW2YmEjuoYu7ucfGqgx5ypLrB0KucC5j10YwXm?=
 =?us-ascii?Q?EUGp3QdVTHoj9s1JUaObgaFm9cu02X2WNFuUrLnfh+t3cB3SSx5a0wbM0Ims?=
 =?us-ascii?Q?R+iyD0SP+OMqZ5RJArayMJYnsYryuQJhcpxuY6I5q4Pg5DJtBxjd1vRpFsdJ?=
 =?us-ascii?Q?z3uYc2e4avxp7HONyW5JgrfEnxSWEuzLLXPNGyQ1kTXY0VYpSyoKs/wqdT6K?=
 =?us-ascii?Q?OHMpKKNx/ZCbZYSQm+m8kOVDjjRn3p/svMLNewlcRuOh1n15CTKibVLHNkUY?=
 =?us-ascii?Q?cFowvfmuG5rEtKajDQa0wT+jlyNF7xKOlx/kEV572eyzSdeIy7IjSZkCiSQr?=
 =?us-ascii?Q?h9iGRyJSou+DtXuO52YuRwcwevfj6d6SDEocS0YtUtWLH6cZRfjD3yqYQ4eh?=
 =?us-ascii?Q?GJKyTdPQGVCHp9kwBXAtZ/+dH1vfv36ukz7gw2+jzuGyCzga095x+tXC5aZt?=
 =?us-ascii?Q?DrIZfD8DtXYzz9hEmWolgkNZ65H7DlrtDCVThXsQXxc90uSmOTAL6umFRQAX?=
 =?us-ascii?Q?j8zf/vsCyz10pv41J4MEMg+3Zaecav18sDJ+ZSv4kAgTJbVcvd0SXWUmDbpY?=
 =?us-ascii?Q?7yEa2Mx72ROZP3shYh1WP9Ay5IcGUxhp0zo/C/TKvkqEwJBkfNlyKKPl8Djf?=
 =?us-ascii?Q?WAG1+u8eMRG+BxoFTz/Qc3dJ34vbsz7GzspI0+8PkoDj3TD4NSxBv/T0JHYK?=
 =?us-ascii?Q?dAK0eB2ceu4UurYbBF8trTjXXoyW8cSXyfJVeung5dvFy+IKbcrCDbd7276z?=
 =?us-ascii?Q?Qvz60WuzQAZNNtH3IUqmxkW5bS8LEKvwWMWZNigmTlC8HOlOXcPhQL4CXWvC?=
 =?us-ascii?Q?MTk1ZCBVG2LFQ6e8VtxIHsXh1MOb70vVhoDmbBnMyp5grdk3HnJB50G+teb3?=
 =?us-ascii?Q?AdhCJkn4u09MfaHlJ++/lXOKnOk5KMJ3JfeLDFv8vojbfigedcAQK57Xlp2c?=
 =?us-ascii?Q?3Dv14LUjXJDSEVb+lLB6WGN80T+rR/yMsjF3r+ZIdDDlGTIrEMxwmw43IyvT?=
 =?us-ascii?Q?JdfTRMNNGhM7LmaS8QT1HHF9slGfGw0xXxwm+/JZ08iA5gt5WOkeus23tYrn?=
 =?us-ascii?Q?djlL8r3RW40+ho4+wJadORSvPVZ7YMDfAxzUC5tgrqINeyJhclId0GSWKOho?=
 =?us-ascii?Q?2IvA1WL9fESDsQjZ//FvhfrLiwBRHFJz89P2wePibW2sZnlMPvu2pomJT/bX?=
 =?us-ascii?Q?dAu2K+uznbZHt7zGQRYPaQvjR9lJASqX7m+hB8CRZr6rmxiCI4t4nYxvDRtb?=
 =?us-ascii?Q?Om01pWIMZWX7h8Tj65xDqF+LtG0MN7fJobiuLPDIeqKWCRro?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e943e5-89ba-48f5-a668-08def16880c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 14:07:07.2590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EyAIQuwvKFG59Q1ja9eR5dZ1MrxN6hW+FpaZxVZL6+4kNBsvCaoPjBLbn98GQ7bo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9052
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
> Sent: Thursday, July 30, 2026 10:09 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Chen, Michael <Michael.Chen@amd.com>; Liu,
> Shaoyun <Shaoyun.Liu@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH v2 2/2] drm/amdkfd: enable rs64mem for kfd queue
>
> Enabled RS64mem for KFD queues by integrating process and gang context in=
dex
> allocation in the per KFD device process and queue creation.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  3 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  |  3 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c               |  5 ++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 10 ++++++++++
>  4 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 51ee9c39104b..ea9d87450eae 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -226,8 +226,10 @@ static int add_queue_mes(struct device_queue_manager
> *dqm, struct queue *q,
>       /* MES unit for quantum is 100ns */
>       queue_input.process_quantum =3D KFD_MES_PROCESS_QUANTUM;  /*
> Equivalent to 10ms. */
>       queue_input.process_context_addr =3D pdd->proc_ctx_gpu_addr;
> +     queue_input.process_context_array_index =3D pdd->proc_ctx_array_ind=
ex;
>       queue_input.gang_quantum =3D KFD_MES_GANG_QUANTUM; /* Equivalent
> to 1ms */
>       queue_input.gang_context_addr =3D q->gang_ctx_gpu_addr;
> +     queue_input.gang_context_array_index =3D q->gang_ctx_array_index;
>       queue_input.inprocess_gang_priority =3D q->properties.priority;
>       queue_input.gang_global_priority_level =3D
>
>       AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> @@ -303,6 +305,7 @@ static int remove_queue_mes_on_reset_option(struct
> device_queue_manager *dqm, st
>       queue_input.queue_type =3D convert_to_amdgpu_ring_type(q-
> >properties.type);
>       queue_input.remove_queue_after_reset =3D flush_mes_queue;
>       queue_input.xcc_id =3D ffs(dqm->dev->xcc_mask) - 1;
> +     queue_input.gang_context_array_index =3D q->gang_ctx_array_index;
>
>       amdgpu_mes_lock(&adev->mes);
>       r =3D adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input); d=
iff -
> -git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 88191a4c1657..3b89bcc625b3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -635,6 +635,7 @@ struct queue {
>       void *gang_ctx_bo;
>       uint64_t gang_ctx_gpu_addr;
>       void *gang_ctx_cpu_ptr;
> +     uint32_t gang_ctx_array_index;
>
>       struct amdgpu_bo *wptr_bo_gart;
>  };
> @@ -871,6 +872,8 @@ struct kfd_process_device {
>       uint64_t proc_ctx_gpu_addr;
>       void *proc_ctx_cpu_ptr;
>
> +     uint32_t proc_ctx_array_index;
> +
>       /* Tracks queue reset status */
>       bool has_reset_queue;
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index eb508fe3ded7..0a7c1900da95 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1215,9 +1215,12 @@ static void kfd_process_destroy_pdds(struct
> kfd_process *p)
>               kfd_free_process_doorbells(pdd->dev->kfd, pdd);
>
>               if (pdd->dev->kfd->shared_resources.enable_mes &&
> -                     pdd->proc_ctx_cpu_ptr)
> +                     pdd->proc_ctx_cpu_ptr) {
> +                     amdgpu_mes_free_proc_ctx_index(&pdd->dev->adev->mes=
,
> +                                                    pdd->proc_ctx_array_=
index);
>                       amdgpu_amdkfd_free_kernel_mem(pdd->dev->adev,
>                                                  &pdd->proc_ctx_bo);
> +             }
>               /*
>                * before destroying pdd, make sure to report availability
>                * for auto suspend
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 8054e4fe0381..72913b5c8338 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -210,6 +210,7 @@ static void pqm_clean_queue_resource(struct
> process_queue_manager *pqm,
>       }
>
>       if (dev->kfd->shared_resources.enable_mes) {
> +             amdgpu_mes_free_gang_ctx_index(&dev->adev->mes,
> +pqn->q->gang_ctx_array_index);
>               amdgpu_amdkfd_free_kernel_mem(dev->adev, &pqn->q-
> >gang_ctx_bo);
>               amdgpu_amdkfd_free_kernel_mem(dev->adev, (void **)&pqn->q-
> >wptr_bo_gart);
>       }
> @@ -282,6 +283,9 @@ static int init_user_queue(struct process_queue_manag=
er
> *pqm,
>                       goto cleanup;
>               }
>               memset((*q)->gang_ctx_cpu_ptr, 0,
> AMDGPU_MES_GANG_CTX_SIZE);
> +             /* Bind one MES gang context slot per queue (gang). */
> +             amdgpu_mes_alloc_gang_ctx_index(&dev->adev->mes,
> +                                             &(*q)->gang_ctx_array_index=
);
>
>               /* Starting with GFX11, wptr BOs must be mapped to GART for=
 MES
> to determine work
>                * on unmapped queues for usermode queue oversubscription (=
no
> aggregated doorbell) @@ -304,6 +308,7 @@ static int init_user_queue(struc=
t
> process_queue_manager *pqm,
>       return 0;
>
>  free_gang_ctx_bo:
> +     amdgpu_mes_free_gang_ctx_index(&dev->adev->mes,
> +(*q)->gang_ctx_array_index);
>       amdgpu_amdkfd_free_kernel_mem(dev->adev, &(*q)->gang_ctx_bo);
>  cleanup:
>       uninit_queue(*q);
> @@ -386,6 +391,11 @@ int pqm_create_queue(struct process_queue_manager
> *pqm,
>                       goto err_allocate_pqn;
>               }
>               memset(pdd->proc_ctx_cpu_ptr, 0,
> AMDGPU_MES_PROC_CTX_SIZE);
> +             /* Bind one MES process context slot to the whole process
> +              * (per device); every queue of this process reuses it.
> +              */
> +             amdgpu_mes_alloc_proc_ctx_index(&dev->adev->mes,
> +                                             &pdd->proc_ctx_array_index)=
;
>       }
>
>       pqn =3D kzalloc_obj(*pqn);
> --
> 2.34.1

