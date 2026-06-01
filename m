Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1E5CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 06:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAEF2112E86;
	Mon,  1 Jun 2026 06:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="COzFYtWX";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012000.outbound.protection.outlook.com
 [40.107.200.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D25A1112E86
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 06:57:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TogzoeDU2hZwDSoYbbKSVdZbpzmyAtu7bQ+8oUEC2pSSwt08B7+FRoZinwpIPllHdKZuTfxBTk6nMYR/JpcILRO8PIarvmA/Oc10pCCh4V+XsNIhmp3+5RKsE0s2Q6xJFKt+4jNFMZ1v3u7rG+Pw1t7uzVyhQ7469q7GZ47UtGB08jONE+rQONSRLmdbmEees3zb7sZYvodsGdyW+z80e1URNnMj+bvDa0zbwX3YIt5LS6Q8WE/vXVe3vS8rO5TKlzzC1fH51R1qX4+4l8HTnZiPXHgGiKjlxidXOH7IGGE4pW5ffHkkS2lZOfLnzu+6NYMEOMg5D7ZQQ+SCO0PFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTsjIDRAC87JAkVAdFDkzydrqOxw0gACuZLCJviGT5s=;
 b=MaeThXYoMxRcCc0b2jtB/Fwwqy2ahTdAVSwRAaLj54DpyRyOaPAL4hv/x/cKX+uiec2fGlZngnPjf17krHnQ5cta4EOeHsfuYToOQ7wfsm8wEUOYOLRhauypx4X8ZQDptXrHJ8khxitpj2H4W7xntU4jdVNIR3PuSK5DnumLqMz7nXmCmdxnzQIg3LarVwP4H1q1bIcLI2RAmVBi46Fabb6Q3qNZ+IRxOBfi2zTyphULWssEyfEKaYsT404lsXMnfapkHFu28DrJrgCo85PBq7fljuUewvqgVwQipYFz4MKFU6b+LfFzQ0LSOjDR3CAp6Zf9VCSBpmM15K8s6zNn1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTsjIDRAC87JAkVAdFDkzydrqOxw0gACuZLCJviGT5s=;
 b=COzFYtWX/3GeGCSmFWtMshbdwsEjst4vqXFp0ymkYUXhHc7v4ouE6FokYTPvACPyuG6JAqYdUa4ZZz8MBz528S5FubkAzU+VLPw5aM1KfxswhF4JgAjwIicKgckdNYaZHQUO6q7jLQG7pg9kdpnjTUYU4J6QRezQFPL93ZPxaOo=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 06:57:49 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 06:57:49 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH v2 23/42] drm/amdgpu/userq: drop detect_and_reset callback
Thread-Topic: [PATCH v2 23/42] drm/amdgpu/userq: drop detect_and_reset callback
Thread-Index: AQHc8YsEL/A0smcqyEOS2A87kdecS7YpQc2w
Date: Mon, 1 Jun 2026 06:57:48 +0000
Message-ID: <DS7PR12MB6005BCB9080D57E4DC2D6997FB152@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
 <20260601055034.3700921-23-Jesse.Zhang@amd.com>
In-Reply-To: <20260601055034.3700921-23-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-01T06:46:59.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CH3PR12MB7521:EE_
x-ms-office365-filtering-correlation-id: d7dbfda2-71e1-4516-a7ff-08debfab17a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: tcwLx+mnSf7O3Hc0qeDZkYIioMq8h8TQ4zKfYdC62+wi3np9pb2SMxU1vjJHGfUkmTredvbvubPsq0FQRpQI+5NdEy0yrVYy7DyRqVgVku8mngY9r12jUK6LyTgUaO0JQ5a6ZJVpL0sqUjRQ2eF88ae6TSLYshfc40RWrOyr5FOqCLvEZaPdjohsfhMuZGTP0Otg2ct7fuZfS8fHZKVCpNUQsEkwY5rFNm4fCgOragpYdrhCkiXq3qD4v+letUQfR6ecCdS2pjW8KG34P0Wviu/XJihvXZyahgYNOOoncvL33BtlYkGV3Osbi0+vpxia/TqORn5Fm2FvIvYP62Cct+yhBZi2BOoBblS4QnWk7JxjDbYWzg5o+JwsGfHGFGqfg93/BmUvhhux479Upm/JdLK5Y2JReldCBC2F8xry63zQRTVVYJ/V2oyMyxSwPB7eoqO2Dk7eTDZuBpKcDhJ5SDO4dCNrVF6Smnc6M5S6chGVhFxN1eklfIJelFO8SSFFCS/gCv+FPxfnuUqarPevipvBEefC8hDs+JWCUmbYX/VkaK7J+wt6NtlDvBaVOjM+E8Lm03iDbhTk4BvX4r0ENQpvQ+jhCfZ4U3tDZnrVOiZwveQ2F8l+95MOPEp7URrcZDmNM1y+tvdeb9Wq+4E4xPUFTisuApaQ/WjDGgCoTpgQdh64JChVxCtlCZ3aLCfz4+2j2XunDD2up+M0CHyQVPYKTpdnDyWNxPnIhPZgt4ew9FN+sYPb+sluhTl40Kg9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IHyTuN7FXCMn5fR5k7ONajsYTyFmswisweH7/B9yTaHX1ICC7SHqmiI7bn8T?=
 =?us-ascii?Q?5n9HCyWJE0Lg24glaE6aqJId0OUBbH8BieoHqRY5Ql9gXkS9q7F7Q4JZsfoi?=
 =?us-ascii?Q?2c/w1wSWn7s3mhYD9P4M5XeiENvv9XGgU9hV+HjsWc++bxRYr3ONpomLAbBp?=
 =?us-ascii?Q?uJ1H/7JFLcYXb7xw03W63ZiRtgzZ4ZWEiCmeb5hHDMln4Xk1oqKauQO+vpM+?=
 =?us-ascii?Q?FtiyawTtO6K7kU3XVIv4Y2t2mSUGBffRJOenOf6U+SH1FpONbxn+NGLLveGd?=
 =?us-ascii?Q?Syrlx6Al9B4nk/KpUkrRw1qM1qG0sIZJ3MSHR398zWAjmVisS+x7UGX/uWN8?=
 =?us-ascii?Q?uYCXrrPJd+JkBWo1PlRfg6URGGU0ujX/ejBscsJcO7WdnbZA/BlEMrsPhzm2?=
 =?us-ascii?Q?uYZEpNN5lgiYf3tquNEO/wa0Myi9aTvJ6ZIyOqH1G+Bsyu6EUF88jA+/H/3Q?=
 =?us-ascii?Q?73tAI3eum4NP72y2io8DVYWh+GZSReVk8xXjgFaZMcpFEAJ3e72n37pJb6q2?=
 =?us-ascii?Q?6OJ13EyDa231KFBmwWOZ23hCCpGm9pKptmoUWNH/59b5WjbUPT36e0HaCeYM?=
 =?us-ascii?Q?E5JQcU55aS4keZ6Y2qDkj+aD5jY+imFu2Ng1D6dO5zB1kmdDTY/4X6cc/On6?=
 =?us-ascii?Q?4AnnMaDOc6qbplgHV7I3GvueXn/9tmhJ7zlV99oi7jYNcufuTQfBG+5YeScm?=
 =?us-ascii?Q?uf4vFjWIUgU4eVUL2uV+kYw2H++1f9SK2OYKClLMD/YZyOODMsWmrJZ9j26Q?=
 =?us-ascii?Q?7xSFa0SSvv+1JMfvn0eTROYhmcGA6AoSoG1HfWVKhR2N+vDb9JZVTg3oEzDG?=
 =?us-ascii?Q?HZL8csuzLK5vNHb3H2QWyS0gHmu56pzIA8EtLWSzAg9+4g7lki9BCw8uQQIU?=
 =?us-ascii?Q?hIbTQIp57/Ei8qVpoIl/Gf6ATjjTMw99AlQdc+EPFl1ZZ8tWwroyiYOaADLn?=
 =?us-ascii?Q?HIkXSmXLLG8/pWpXHkprFcvxgCuigpya+Cc+9scuO/fZcD9ptiMSSWTHNp7l?=
 =?us-ascii?Q?PENk7xcLBBUBSYjSE8ZO+b/u4UlIlbSc5XCrezLUaiTfv1U8RTF7MzJs7NRs?=
 =?us-ascii?Q?uusB4W2TwCWb0RDcDH8+hDkkr86gLxTOSFW7DA4u9SuZFh4o6mWtW/1ZcXQx?=
 =?us-ascii?Q?wCj0Rwg2nH50JPDDR+/cGHf/OHljfCDVGqVPzmFznY4/5b9HWsl2v0lzLV5v?=
 =?us-ascii?Q?qOQ1Cl6CA3xZ+ScqG4J0cD/J93ej6lWb9O5EykwRaSm60Q3Qu9plofVXXMOI?=
 =?us-ascii?Q?dlBXgUwI4htc0+LQhmtwLK0ErsTMz7ebcacM35JjywsTjLWzpAYUqntoRh2/?=
 =?us-ascii?Q?Q3M51yhS2L9nNHRUxCTiOBJJqeFxI/LuSdNPgWy8mT6z6M7+Es4p9OMFU7V1?=
 =?us-ascii?Q?TvY+kkwteTMAgQFhW+Qqa2kyUTi2ENbapb9Xhthibt8nYiR70MvKwNhZ5+kt?=
 =?us-ascii?Q?VhNhMdlKQ2xlFi8Oi/jBFVo2uVOp2fpSuH9fUnlG3kKhHiCWQkqiJ+cAajqD?=
 =?us-ascii?Q?5HpGoQvSOBksZXDO7gHsH0113Q0MTdwOHliIbI94eE9hOdbzql+lGU3Ii6W4?=
 =?us-ascii?Q?PoLc7UwDf6l3RH1pwOZkCx6hgTsUKQtfLaVS3kAoqL+TQGijLvcvy98W8uYp?=
 =?us-ascii?Q?FfoChGRNAQ5TpU0Y9dLm4KiHvyHQcDokSfvxNWOvXOSVwKNCQ22D4wlVAnP/?=
 =?us-ascii?Q?oc2LkwHrM3dBOxxcJM1MUK7YCTzgcRuPQgubpJeo7Gp6/5bR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7dbfda2-71e1-4516-a7ff-08debfab17a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 06:57:48.9841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwGaESSBE7z31PCvYdGwqQzOageBk6xQmqM7UZRRgmEzONSAiigTy/AqjLuBcRDw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521
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

Patch 19-23 are Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Reset the user queue per queue directly rather than walk over all the queue=
s type each time, which is also my plan to improve the reset latency and si=
mplicity and the idea was pointed out at the Christian's fix about rework t=
he userq reset work scheduled patch upstream period.

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse
> Zhang
> Sent: Monday, June 1, 2026 1:49 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH v2 23/42] drm/amdgpu/userq: drop detect_and_reset callbac=
k
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> No longer needed.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 -
> drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 53 ----------------------
>  2 files changed, 55 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 2403a5d990f2..631315f89bb1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -106,8 +106,6 @@ struct amdgpu_userq_funcs {
>       int (*map)(struct amdgpu_usermode_queue *queue);
>       int (*preempt)(struct amdgpu_usermode_queue *queue);
>       int (*restore)(struct amdgpu_usermode_queue *queue);
> -     int (*detect_and_reset)(struct amdgpu_device *adev,
> -               int queue_type);
>       int (*reset)(struct amdgpu_usermode_queue *queue);  };
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 4f285a8218dd..cf7e2ab66d10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -219,58 +219,6 @@ static int mes_userq_create_ctx_space(struct
> amdgpu_userq_mgr *uq_mgr,
>       return 0;
>  }
>
> -static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
> -                                   int queue_type)
> -{
> -     int db_array_size =3D amdgpu_mes_get_hung_queue_db_array_size(adev)=
;
> -     struct mes_detect_and_reset_queue_input input;
> -     struct amdgpu_usermode_queue *queue;
> -     unsigned int hung_db_num =3D 0;
> -     unsigned long queue_id;
> -     u32 db_array[8];
> -     bool found_hung_queue =3D false;
> -     int r, i;
> -
> -     if (db_array_size > 8) {
> -             dev_err(adev->dev, "DB array size (%d vs 8) too small\n",
> -                     db_array_size);
> -             return -EINVAL;
> -     }
> -
> -     memset(&input, 0x0, sizeof(struct mes_detect_and_reset_queue_input)=
);
> -
> -     input.queue_type =3D queue_type;
> -
> -     amdgpu_mes_lock(&adev->mes);
> -     r =3D amdgpu_mes_detect_and_reset_hung_queues(adev, queue_type, fal=
se,
> -                                                 &hung_db_num, db_array,=
 0);
> -     amdgpu_mes_unlock(&adev->mes);
> -     if (r) {
> -             dev_err(adev->dev, "Failed to detect and reset queues, err =
(%d)\n", r);
> -     } else if (hung_db_num) {
> -             xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> -                     if (queue->queue_type =3D=3D queue_type) {
> -                             for (i =3D 0; i < hung_db_num; i++) {
> -                                     if (queue->doorbell_index =3D=3D db=
_array[i]) {
> -                                             queue->state =3D
> AMDGPU_USERQ_STATE_HUNG;
> -                                             found_hung_queue =3D true;
> -                                             atomic_inc(&adev-
> >gpu_reset_counter);
> -
>       amdgpu_userq_fence_driver_force_completion(queue);
> -
>       drm_dev_wedged_event(adev_to_drm(adev),
> DRM_WEDGE_RECOVERY_NONE, NULL);
> -                                     }
> -                             }
> -                     }
> -             }
> -     }
> -
> -     if (found_hung_queue) {
> -             /* Resume scheduling after hang recovery */
> -             r =3D amdgpu_mes_resume(adev, input.xcc_id);
> -     }
> -
> -     return r;
> -}
> -
>  static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>                               struct drm_amdgpu_userq_in *args_in)  { @@ =
-545,7
> +493,6 @@ const struct amdgpu_userq_funcs userq_mes_funcs =3D {
>       .mqd_destroy =3D mes_userq_mqd_destroy,
>       .unmap =3D mes_userq_unmap,
>       .map =3D mes_userq_map,
> -     .detect_and_reset =3D mes_userq_detect_and_reset,
>       .preempt =3D mes_userq_preempt,
>       .restore =3D mes_userq_restore,
>       .reset =3D mes_userq_reset,
> --
> 2.49.0

