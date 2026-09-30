Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164BCC9830E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 06:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BEB410F1C2;
	Wed, 30 Sep 2026 06:05:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tzreiq8x";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012005.outbound.protection.outlook.com
 [40.107.200.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D99310F1C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 06:05:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhSp+AqYG2y9ZwhETF8Q/sms1oSdyi1CSPnhLQzgCVcQJ9DToz0KRdfpmYbGe+w2XIrzeKg+5O+hdNnGRnNx5DDDhd41uCsOoNvR7PXIH7KqqfS/UWCUCLt+aeGy256AB5wnKlXnSf4wq57hXdk9LRcltBbZwlc5Ki1LTxV4BXv2GBqij3b1ZB6bfTflhSS5VZkFuNaTCe7PkPiV5FIlbVs5yGj2wjJGNK/LE+hWv3vcypdxsE6Bp3jjVDPzHeaqA+uHOozapZvOBm9jIOUDxVvOpeHDCCzgW4qASGAsUHL2YZi5aDSqxAJA1/Z2JCnZhNX+/8UpkOTIu9SVqKGRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHqKW8JzvyZhbx4lXpg3JKIESRtq0rt3D0ymDuD7x4Q=;
 b=rGuLHApXJuWqaXMhxIL+2QPGDddgY4XRqwlYLGuoUidc7oiPl+Y2Y9L2i9HJcmthLCEhh5rkR+YuTAwrbG6Klr4P6GvjnDxY2YXQ51P3oZKGAf+GlnZMtLRvbogEKWUbAQNzbQeWmNSSkOhHfaAsmDn/3EaxQ/VvrCwSdFFGsKYKdaljTlE+sObacH+aW/ELL64xSXH1NpyltlLDbPvVEuPoYp4HNQoIfWdS8d0utxcRQ8+HNgfZ37WsxSVliz6mZqgSIrIa8NNpniXaNHpgoZSxPmfKp1TO+TF0OT2uoL3kT22Q5gjZ0svcK2YRmXWfGdsbBDuFrwBqQZjdyaLWxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHqKW8JzvyZhbx4lXpg3JKIESRtq0rt3D0ymDuD7x4Q=;
 b=tzreiq8xQ1MtDNf12u1Vu6Nr2ns5AA7n1ZbzXilDMFbZpjDA7Jld5PhwhVkccuHdh7hjjK7SQCBXj/cqelQnrszDAQGrh3x1baGr3wsr7cf29P2mrUDpua5ieEdeWTK5OCbgQU2yppNGPuTzO7eFFD3zHktC/8VHtC13uQVhxVA=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 06:05:12 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 06:05:05 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH v3 5/5] drm/amdgpu: track user queue guilt and report
 reset status
Thread-Topic: [PATCH v3 5/5] drm/amdgpu: track user queue guilt and report
 reset status
Thread-Index: AQHdSmhJOcrySkpqXkacWv1OcoBHnrbmrejQ
Date: Wed, 30 Sep 2026 06:05:05 +0000
Message-ID: <PH7PR12MB60006CCB8582F9AAD4DD211DFB8B2@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260922075852.2335748-1-Prike.Liang@amd.com>
 <20260922075852.2335748-5-Prike.Liang@amd.com>
In-Reply-To: <20260922075852.2335748-5-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-30T06:03:06.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|LV0PR12MB999092:EE_
x-ms-office365-filtering-correlation-id: a580f75b-50ce-4e40-ad9a-08df1eb8c5d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|38070700021|4143699003|6133799003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: KFi6cXqp968Qn1JMQX3AsEBpo5VfQT42qTUYdD+VDZX2s5fSd0VHGY51fSZjrCKSXWP8cH6+USUJyXP55AZbVbCZii+O+PWV60TCI2NxMQExsDwuVqo7lGnAtv4aZJnMhJTERdktv5LYMjmh/DaTfwqC1hBhwTQHPVd9qUV0b4d1agAbgxCjWV13JfSrTBb2w3mKNjmjDVc7wKBaMXNX01VrQ4uWiZbfw/SrzHj/Mhw0jTs5HWF5kpcAiJ34U3UgY1TZxiC0mwX5tJomEcqbepH4eITr1eLuBgJ+9DwDaiIt/auVPV/anCl9sw0RnfMsa3OvqS/IOmErOwHXaVdQQ3B3s0mC48UuRbCx1VnRN8X1XMNv5Z0vbYEC/KKNQMw4grE6yHt5q/aD9FxB3mgrMhQia38253Gs4VSAymmQjFAlCsAbKtP4E1E1yVauW5Rfel7dd9rGnf4MVWSeiFLsoDs60E4NAOS51NiUhSd2bmMtKf8FiaMiJoDQkSvfNyXQ8oWkJ2YBnUB97O5lpTrUjhr25npM0v5UxTED3CAi/apcx8ZWypybHuqHqwCgNTUXrJE1W1o4yV2GY1oetLOsSUNKWDXZTO2oUa4Cz+9WbRMAUd8wKATr4rApDDewha9MDwZ7V1GdD5L+2zSUS4jRfWQmvybcKwvZgqQDsLlxbrg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UBQiZAV5bwdW+4qM/94tzme56wEirCjGVWTTd7/4ESzTUjiVsvrymS1qqJp8?=
 =?us-ascii?Q?Yt6k955Hu+O0Ibmx6ZQl/lxF/o3bWtJ0Cu3jHVlfxCXvcR/mLg0thkLED2uQ?=
 =?us-ascii?Q?LKsBR6+q70d7H3rziBnugKsZejJ2x7qdZjbBdxoyaJcqLiHc0k8u2PviX1rb?=
 =?us-ascii?Q?ZBhoICNtP7oL5RT42qp+z+Ra2LQ84mYleToi6RDGqVbF7jjRyNJ1rP0LSk+y?=
 =?us-ascii?Q?eMPq22A9ukvI8ieu8ZibudYgfh6jvmIZ76ZYaUd25+YPsFvcM17Q2e8Eu8H+?=
 =?us-ascii?Q?9pmjM31cdfpiG+tJhSD380xLPIqAEhIwNpeo5oggNkuEY1qNlbVghd55ALHp?=
 =?us-ascii?Q?GdRcnEkzRG6tmJGlDHstBt6J0BmrnnSvyqLM7j6y3nYb2wedsuopf0S1QJKm?=
 =?us-ascii?Q?RhT/SMIxfoehF99N4xMdt69999hV9bCreZguk8ZHfFiyyiU8qavaGWsjAI0d?=
 =?us-ascii?Q?EvRA3xjjrLroZi1ywZH94Nxz6l+AbOzoY4b3BB2CmDUuRNcbFi+soap3zxr4?=
 =?us-ascii?Q?gIqBmRb539Sqc0uEu9zNbxwPo6quOB5MIcQnnB+0lbakQh2cRvyVCxa1KavH?=
 =?us-ascii?Q?4NRG28CXLCL00dGe5+dzWXyLNZRbRVeHzZj3+A+/VKcWO6ihDZ6ylqE48wd5?=
 =?us-ascii?Q?+hZak93Ql6jzAJLzN9kIcluvKmc9yHxhr6PPIZYjJlUHT5wPoB6vqFnEcgcP?=
 =?us-ascii?Q?BXSkAy319mbDMrD54PGKRLimaonBHaLcGg4G0Os5Xg74BR8/Oejhbx+AANUL?=
 =?us-ascii?Q?OehDJhujPhWhNJpprpFnqqI6d7XIC2zyOFtngwaTfiRkKJO4iAMCNsigJ/lR?=
 =?us-ascii?Q?ywzp2Yhn8KyUAx+iUFhXplMwz5QR9ukMMjSP4P3tVv0Enrkm9DdCDCbXigk7?=
 =?us-ascii?Q?TTfmQ+5hib1EcXs+tv9H7KEdiGVyfq9jTmr1L8i0B56UqK+yfwx7c+VWggvc?=
 =?us-ascii?Q?ara/4itVeTrRbon4D7pJy5d6tTKW8YL/CVApKWhyW4Wa8av4U3fNwZj8QCSo?=
 =?us-ascii?Q?OixARn91bbE3c/oHAT4B1kBj3xAvEwQlLLKe53soMSN396ds+gUJCVk1fWrl?=
 =?us-ascii?Q?bBBhX4EKMR0l/Aw7rDN830HXAszHY3upkLDViGU36FuzVsA7uILM7/FrdOC0?=
 =?us-ascii?Q?EaDzi4g2yfPckfNSFZcu2sEcLOcAAhTsvG4XeknJat7mpnb+qxWj+rrj6gRh?=
 =?us-ascii?Q?t6FOuurs4CJZo+cI4ByQszd5DRp05iW82aNtY75MDVPypEnX6iA/Vv6x5tJg?=
 =?us-ascii?Q?qg42wcLWnuZIK7gfunjcUJimBXmV0Oh6Ud96B8aawPzsVCDn1O8JKBSJxvyP?=
 =?us-ascii?Q?aTiROe4/EGmAsZQyRLxrokF6V6xgj8eVSq4EyRQNgijDHrcMhFCxcWPDguN8?=
 =?us-ascii?Q?iNDzrsbxZtqQX3ySmdytJz3yIvjVMMF5kdvPLDiGrlBC/Mq9mnbUij/t4fPM?=
 =?us-ascii?Q?39NfIk/eDKZNARwnQ184R1DWHfDqABkKFcNhZeWYEOtIdMSeVvGC+ZbMvxW8?=
 =?us-ascii?Q?Zjm0HG6Zaph+GKFpQmhWLSF+bE5RoncG9PsPsVE7D/tcV2ckNMTIWi/miB1l?=
 =?us-ascii?Q?07Fab+Me0Fm35vh3ucPvYnt6Tcriu/lRrxECKM22GR6xI1dbKQXsLd7RTmI3?=
 =?us-ascii?Q?Fyjp0v+YOMOclWj+38vMocxyn9Ych0zhGnrI2iu2eyj2aq3ecW+VItSpxZpV?=
 =?us-ascii?Q?XTV22Bt/xqlwc65pl59rJJ7BkBVo+iLvsbxJ7lOJBneSmrEG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a580f75b-50ce-4e40-ad9a-08df1eb8c5d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 06:05:05.1296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +to/7v3Z4ObPbcaG+oJWMxRqZ7aIL9TEHgnEX1rv9Uzcqh7JxA0m0Tv7JYQ0BMmx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092
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

The corresponding Libdrm patch updated as: https://gitlab.freedesktop.org/m=
esa/libdrm/-/merge_requests/487, please help review the series patch togeth=
er, thanks!

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, September 22, 2026 3:59 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pell=
oux-
> prayer@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH v3 5/5] drm/amdgpu: track user queue guilt and report res=
et status
>
> A hung user queue must not be replayed after reset because its context ma=
y be
> corrupted. Keep the guilty state on the queue and report it through the s=
ticky HUNG
> status. Skip guilty queues and queues whose VM generation has changed whe=
n
> mapping or restoring them.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 ++++++++++++++++++++---
> drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 +++
>  include/uapi/drm/amdgpu_drm.h             | 11 ++++++---
>  3 files changed, 37 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 4ddd22af63c5..8ac63beca995 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -148,6 +148,8 @@ static void amdgpu_userq_hang_detect_work(struct
> work_struct *work)
>               }
>       }
>
> +     WRITE_ONCE(queue->guilty, true);
> +
>       if (amdgpu_userq_is_reset_type_supported(adev, queue->queue_type,
>
> AMDGPU_RESET_TYPE_PER_QUEUE)) {
>               int r;
> @@ -174,7 +176,7 @@ static void amdgpu_userq_hang_detect_work(struct
> work_struct *work)
>        * handler to another is illegal if you don't take extra precaution=
s!
>        */
>       if (gpu_reset)
> -             amdgpu_userq_mgr_reset_work(&queue->userq_mgr->reset_work);
> +             amdgpu_userq_mgr_reset_work(&uq_mgr->reset_work);
>  }
>
>  /*
> @@ -338,6 +340,10 @@ static int amdgpu_userq_restore_helper(struct
> amdgpu_usermode_queue *queue)
>               adev->userq_funcs[queue->queue_type];
>       int r =3D 0;
>
> +     if (READ_ONCE(queue->guilty) ||
> +         queue->generation !=3D amdgpu_vm_generation(adev, queue->vm))
> +             return 0;
> +
>       if (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED) {
>               trace_amdgpu_userq_state_start(queue);
>
> @@ -388,6 +394,10 @@ static int amdgpu_userq_map_helper(struct
> amdgpu_usermode_queue *queue)
>               adev->userq_funcs[queue->queue_type];
>       int r;
>
> +     if (READ_ONCE(queue->guilty) ||
> +         queue->generation !=3D amdgpu_vm_generation(adev, queue->vm))
> +             return 0;
> +
>       if (queue->state =3D=3D AMDGPU_USERQ_STATE_UNMAPPED) {
>               trace_amdgpu_userq_state_start(queue);
>
> @@ -692,6 +702,7 @@ amdgpu_userq_create(struct drm_file *filp, union
> drm_amdgpu_userq *args)
>       queue->queue_type =3D args->in.ip_type;
>       queue->vm =3D &fpriv->vm;
>       queue->priority =3D priority;
> +     queue->reset_counter =3D atomic_read(&adev->gpu_reset_counter);
>       queue->generation =3D amdgpu_vm_generation(adev, &fpriv->vm);
>       queue->xcp_id =3D (fpriv->xcp_id !=3D AMDGPU_XCP_NO_PARTITION) ?
>                               fpriv->xcp_id : 0;
> @@ -831,14 +842,20 @@ amdgpu_userq_query_status(struct drm_file *filp, un=
ion
> drm_amdgpu_userq *args)
>       }
>
>       args->out_qs.flags =3D 0;
> -     if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG)
> +     if (queue->reset_counter !=3D atomic_read(&adev->gpu_reset_counter)=
)
> +             args->out_qs.flags |=3D
> AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET;
> +     if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG ||
> +         READ_ONCE(queue->guilty))
>               args->out_qs.flags |=3D
> AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
>       if (queue->generation !=3D amdgpu_vm_generation(adev, &fpriv->vm))
>               args->out_qs.flags |=3D
> AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
>       if (queue->state =3D=3D AMDGPU_USERQ_STATE_INVALID_VA)
>               args->out_qs.flags |=3D
> AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA;
> -     amdgpu_userq_put(queue);
> +     if (amdgpu_in_reset(adev))
> +             args->out_qs.flags |=3D
> +AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET_IN_PROGRESS;
>       mutex_unlock(&uq_mgr->userq_mutex);
> +     /* The final put may destroy the queue and take userq_mutex. */
> +     amdgpu_userq_put(queue);
>
>       return 0;
>  }
> @@ -900,6 +917,7 @@ static int amdgpu_userq_input_args_validate(struct
> drm_device *dev,
>               }
>               break;
>       case AMDGPU_USERQ_OP_FREE:
> +     case AMDGPU_USERQ_OP_QUERY_STATUS:
>               if (args->in.ip_type ||
>                   args->in.doorbell_handle ||
>                   args->in.doorbell_offset ||
> @@ -1596,7 +1614,11 @@ int amdgpu_userq_post_reset(struct amdgpu_device
> *adev, bool vram_lost)
>       int ret =3D 0, r;
>
>       xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> -             if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG
> && !vram_lost) {
> +             if (vram_lost || READ_ONCE(queue->guilty) ||
> +                 queue->generation !=3D amdgpu_vm_generation(adev, queue=
->vm))
> +                     continue;
> +
> +             if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG) {
>                       trace_amdgpu_userq_state_start(queue);
>
>                       userq_funcs =3D adev->userq_funcs[queue->queue_type=
];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index d1a2e2a45861..c2349115f404 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -51,6 +51,8 @@ struct amdgpu_userq_obj {  struct amdgpu_usermode_queue
> {
>       int                     queue_type;
>       enum amdgpu_userq_state state;
> +     /* Reset due to a hang; must not be re-mapped, userspace recreates.=
 */
> +     bool                    guilty;
>       uint64_t                doorbell_handle;
>       uint64_t                doorbell_index;
>       u32                     doorbell_offset;
> @@ -79,6 +81,7 @@ struct amdgpu_usermode_queue {
>       struct dma_fence        *last_fence;
>       u32                     xcp_id;
>       int                     priority;
> +     unsigned int            reset_counter;
>       uint64_t                generation;
>       struct dentry           *debugfs_queue;
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h index
> 2f81ec3265cd..7e928c4e8868 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -360,18 +360,23 @@ union drm_amdgpu_ctx {  #define
> AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
>  /* the invalid userq VA unmapped */
>  #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA (1 << 2)
> +/* indicate a GPU reset occurred since the queue was created */ #define
> +AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET (1 << 3)
> +/* indicate that a GPU reset has not completed yet */ #define
> +AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET_IN_PROGRESS (1 << 4)
> +
>  /*
>   * This structure is a container to pass input configuration
>   * info for all supported userqueue related operations.
>   * For operation AMDGPU_USERQ_OP_CREATE: user is expected
>   *  to set all fields, excep the parameter 'queue_id'.
> - * For operation AMDGPU_USERQ_OP_FREE: the only input parameter expected
> - *  to be set is 'queue_id', eveything else is ignored.
> + * For operations AMDGPU_USERQ_OP_FREE and
> AMDGPU_USERQ_OP_QUERY_STATUS:
> + *  only 'op' and 'queue_id' should be set; all other fields must be zer=
o.
>   */
>  struct drm_amdgpu_userq_in {
>       /** AMDGPU_USERQ_OP_* */
>       __u32   op;
> -     /** Queue id passed for operation USERQ_OP_FREE */
> +     /** Queue id passed for operations USERQ_OP_FREE and
> +USERQ_OP_QUERY_STATUS */
>       __u32   queue_id;
>       /** the target GPU engine to execute workload (AMDGPU_HW_IP_*) */
>       __u32   ip_type;
> --
> 2.34.1

