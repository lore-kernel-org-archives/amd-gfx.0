Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534E7CD6E4A
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 12:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA9E310FE9F;
	Fri, 29 May 2026 12:49:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hZT/bgE2";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B035210FE9F
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 12:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THTkFtp7oe7iSrLM6ygcgy6kdHMPNg+g/GgGEkRgzwc4ZTH0JTQtFLEj/y/Gi5oiixt+U6wEOJCZyVXMSPGIqc9G0NjEOmbBIM93gaDfCMWtoWIBEQ0xKaAfx63P+s3E+qt5PcwnNzKR+ablLO8HwQ+gkrTZCdZuwyAHYWM8JDRYesOqnc2gOf2UVu3mztODRJds+luFCYBdRWx+Jb4qrGwTF8/4mrkcv/wxkdtIoP0QPJlNW62Mi5fRDhU8Er+pyACyr3jZUs2UIYpghJmLxpGhiE/OXw8hy5K74EKC5BT33zhIlk6AswxigHmN+YZ7yHtE/bztvA8HKkKLofE0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4waU/24qbLHoHHXax2vomMPcjLFqzgzzk9yFPSIgxio=;
 b=ooythg+2pbg7HI+leXnG/ju8E6mcZCicA4TkK06QmPF/IDR2oKY4k50soOsj39SDfL1ueRVaI1hVBFH8Sq1su5QGinaxq/CNGw38xO04U0IZbs59n/ZPPjKPXSuDVFoGq0BqrMId76MGpK0TFoIo8QVxuqyRkiXYHdqqTMrBHQs2Cw7qA3BJuy8oykYwX9e83Wd4OjZDVdsR1i+dUVRAII7cHYCjwdFhuEcPwwRIllG+TV+p3ecgckV3s821lCslfcDVT4uQDSYgxbykneYfPA03engDSrCwnMxRTAaoC/IxvHmeHDG9wyZRFHckt0+A4tIpMmDB3pfXMKlmzZYStQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4waU/24qbLHoHHXax2vomMPcjLFqzgzzk9yFPSIgxio=;
 b=hZT/bgE2cC6KaFipGWumf2f+oK/OuHsCQOFI+YPE1f0hZW1A2W0+IcBu6SjpfhrRKJGtYnbJ1NB7L0djm3sTtycZ6MiFysMwunrzbbLkcH+mIcHLb2/mnQd+9tSz8PA/igOLvuC5cEe7BqvWSzT35T5RTGppuLuKOU8g7j4X29I=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.15; Fri, 29 May 2026 12:49:10 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 12:49:09 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: add userq job and state transition trace
 events
Thread-Topic: [PATCH 2/2] drm/amdgpu: add userq job and state transition trace
 events
Thread-Index: AQHc7dMwbTv00Xxo9EymkgLv/hnlcLYk1GCA
Date: Fri, 29 May 2026 12:49:09 +0000
Message-ID: <DS7PR12MB6005453059156B25B61CBF15FB162@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260527122001.69831-1-Prike.Liang@amd.com>
 <20260527122001.69831-2-Prike.Liang@amd.com>
In-Reply-To: <20260527122001.69831-2-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T10:43:40.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH7PR12MB8596:EE_
x-ms-office365-filtering-correlation-id: 9b95b962-ead5-48d4-9460-08debd80ad83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|4143699003|38070700021|56012099006|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: ISbjnAYhy/mf6fKbPSKtxl95CpSSljFpShjXDcVSaxPTzsLZq85G3Lyq4LdlDSfrqb9BFQVEaxzzRNXUKAX+FdmQtwsIE9uvS8kYSAteJunX8lOau1h/JNyy0FQX7AYOw7Luw9E7O2Y0bwc+Ni1i1GsEJWi8oXJChCV8cYG9+5YvwLQu2xvvRNKZLaUN7IFk6boYyUSZ+4/RLClXmfviDP9EMv5ieVQPdRnbR9FLuIsEupBW0VuvKTM2Xtlq2xs7P47Lk7KG+xMTzxUOWlxiEgvuN8EV4NbMjQJsgnbBvUw87puJqreVobfiwq66Fexl4FSJ7ZIGoV14AJrMyXQfHjq/A1Z0cSxqT3U+vqcXbad4Q020VTPfAfJh32ilf1jFVd1ysSIFES49/b9s598JOkb5z3JbWWeFeCR1FlMkqiEzRXV57DBrRxIAX3fikiaYM6YU1SWuMmsbCj3Jc18Rdm6NvmBbfItOM2N9WQIo8c6KwJvdafOKPq/bJokYmm7ZlVCRvYcG/6IWaHFHghsLlF0YGiMi8AxXNvf/365x6GB4m7i+sB/98dKOm6mW/5LOPzeeI0EkDUf79ixs+nFniBQsJC4cRPrLlScjqLEGbvbIx4qwaeomXPSilc8FhdgnTdrx1kNC/NNn2vuN1oFRSnAUkDOxMSopoua07wO72rrgcEAjAKkKO/aHjYNkGmzLpegrQDn/l27hPJCuYnecGXNVltIyP/Nq9dJnFfO12kbE0mLjkphcKO9hK4ZGyGQS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(4143699003)(38070700021)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o1aklRcTerSnBgd8GbTiFMEoxVNSKkTnYuOfUILgy+7KsXHjm1ExcVguriN3?=
 =?us-ascii?Q?hHtTTQomrXV64WpfdLbFqYF3dGxiJ3x7V3Uht+j4HJvPE1BbvSQwFpEnWXQ7?=
 =?us-ascii?Q?Qvb3OTa2gyUg4tyyPiD9QLmK6DS+5DfmvGN3qyOqCDVLIH1p/UsFMGNA5/US?=
 =?us-ascii?Q?LTwgvHHZS7zhvXApDxyIj0I8iBTj16vsUbA978mZ95nZU2X4i6PZfVcI7Zft?=
 =?us-ascii?Q?PiYlBI3klVe49gNnDMqETq7Oufb0ZLEVLmpjbCPtVuso0r7QC2Es1Xbuhrjp?=
 =?us-ascii?Q?MaWXyeCXvUDMXsRpghPqxAyjP+maABt0btKHVB0eL9XDeIRDMKT+LCIfPbyk?=
 =?us-ascii?Q?vGCsOZPHCXIB2TucR/PpwS6jlQpPcgPuuOWj4PPj47vGLuFGA6EeFMbYb7lD?=
 =?us-ascii?Q?OJg1DUZry5i//CG4P5mYeiZC2oF1KIiUa3J/U4LOJaPdhmIvhRZOk+Yhayzs?=
 =?us-ascii?Q?TvaPnawuGWO0be0j8QREz5TljCucXtS4+JmTFQkhdquNpx+qvPZMiXsJtdsv?=
 =?us-ascii?Q?jCcb5Hs8rcaY3tu/Ue3/Vztjbc74oDEnuhuPwig9B0keMeFnQ7Hj6RqzDk4Z?=
 =?us-ascii?Q?Q8MlCqhaq4YwQe0WCXoxvO3e1FqMfnm/o0s8YiLWeH5VfDqQNyabSuJy4iMm?=
 =?us-ascii?Q?forVB7pUamJRx+TS/PJsabfZlXuOf4xa5XmHICtzsn9vyjoGcfq5da+/TN6D?=
 =?us-ascii?Q?s5LMcnTPu2t5664uvE0jUsuipTwPDYGXORK7/Cpv3M9g5mNdsf1nlCDBF5we?=
 =?us-ascii?Q?cD6WZm9Ow58kfU5qpDtoA7Tg/pYsG51ooXdz7SWhsyumwodbfvsvkV++zsl+?=
 =?us-ascii?Q?lfqDmkyvk81/+nF/WQvyzHWJ5i1LLvJ+0CEzo0Yxe8OFCeSHMK7ripUcpaKE?=
 =?us-ascii?Q?hPNAdIiriIYckcnHSbXdTI9IlOJjvA3+UiUNZYVDH/B0LLskhXKcQEkm015r?=
 =?us-ascii?Q?MyvoI/yAQospRR8Ay9OjzcCyxM84n59DqEnf7CKfdg4EGssk3j8Y45dPccsx?=
 =?us-ascii?Q?jzBjV2G/aX7LMYJ1iwBW7EseaE7bZZTRnTdAyQRycJRlOHWFc/3sTs9DuGG8?=
 =?us-ascii?Q?98TpuP1ktVD53B3nvkoj2wtUNu5LIxt3+QZeB6W1eH/v8QTs+A4AQt3vuz14?=
 =?us-ascii?Q?uvH89M/RUPXN1CHYgfv3vPkMqbvg+gvoM2UCohtDU2oH2GmmgswTcGTnfY3y?=
 =?us-ascii?Q?/xOACMFUY6av/eh2lMbbQm6UdwMWd3ixi3LZFDq0+VNvAfWzJRioBuIkrruY?=
 =?us-ascii?Q?l8VT1X4GsH+e6AspyMP8QL+3YnAtPL+S6NIHwyEaWumw055pcKb8SKWKUqPy?=
 =?us-ascii?Q?oXh2zkquaSMgxfhnMhy8MxGPqfkiyrl+fv1UjkT3nq1Um8gq/R1sNGKwWvon?=
 =?us-ascii?Q?ObosQWYiEvA+8POwFmzJI9LVxrhuSH7WHRkn2Gexs0N+a5p4lqp3VuKLWRjb?=
 =?us-ascii?Q?eGT+JTOu40UAM7+1B+E5oJJK5nXrQ0nskEMH9TPR8rn0jHH+mmIgDcmBscda?=
 =?us-ascii?Q?6N7aP+ictMZc1TiEyT+u1XGJgHqONwVbJCKO5HUqxc1TXLIcc+Hz2mrtF2ul?=
 =?us-ascii?Q?dIThNkyHKxtIi9weylLbyPpwTr18mMwfwLy5cuxT81drQuOwdX9Bwn4Ll0G8?=
 =?us-ascii?Q?aLsVfSIoS1uDM0rY+ujUKlLdUP3prv+EuAzlFyBTmh5xrmkEBIjXQyA9QEdG?=
 =?us-ascii?Q?5eMrHGDgi+srvNlhcJZ4vlAeHjVCybn2jWdgW/5cwK8ZiiOE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b95b962-ead5-48d4-9460-08debd80ad83
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 12:49:09.7327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2o29EImiP6t24IpfEhzMiDjTmbK3X1kEUhoiP6gkcc29alUU69ngSNRUqwOFhBn8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8596
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

Ping

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Wednesday, May 27, 2026 8:20 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pell=
oux-
> prayer@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-
> prayer@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: add userq job and state transition trace=
 events
>
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>
> Add ftrace events for tracking the userq fence emit, signal and queue sta=
te transition.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 113 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  21 ++++
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  12 +-
>  3 files changed, 143 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index df98be22f1f5..ef6a1fb82ff3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -28,6 +28,8 @@
>  #include <linux/types.h>
>  #include <linux/tracepoint.h>
>
> +#include "amdgpu_userq_fence.h"
> +
>  #undef TRACE_SYSTEM
>  #define TRACE_SYSTEM amdgpu
>  #define TRACE_INCLUDE_FILE amdgpu_trace @@ -636,6 +638,117 @@
> DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
>            TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
>            TP_ARGS(queue, result));
>
> +TRACE_EVENT(amdgpu_userq_job_run,
> +         TP_PROTO(struct device *device, struct amdgpu_usermode_queue
> *queue, struct amdgpu_userq_fence *fence),
> +         TP_ARGS(device, queue, fence),
> +         TP_STRUCT__entry(
> +                          __field(u64, fence_context)
> +                          __field(u64, fence_seqno)
> +                          __string(dev, dev_name(device))
> +                          __field(u64, doorbell_index)
> +                          __field(u64, client_id)
> +                          __field(u32, queue_type)
> +                          ),
> +         TP_fast_assign(
> +                        __entry->fence_context =3D fence->base.context;
> +                        __entry->fence_seqno =3D fence->base.seqno;
> +                        __assign_str(dev);
> +                        __entry->doorbell_index =3D queue->doorbell_inde=
x;
> +                        __entry->client_id =3D queue->userq_mgr->file->c=
lient_id;
> +                        __entry->queue_type =3D queue->queue_type;
> +                        ),
> +         TP_printk("dev=3D%s, client_id=3D%llu, type=3D%u, doorbell=3D%l=
lu,
> fence=3D%llu:%llu",
> +                   __get_str(dev), __entry->client_id, __entry->queue_ty=
pe, __entry-
> >doorbell_index,
> +                   __entry->fence_context,
> +                   __entry->fence_seqno)
> +);
> +
> +TRACE_EVENT(amdgpu_userq_job_queue,
> +         TP_PROTO(struct device *device,
> +                  struct amdgpu_usermode_queue *queue),
> +         TP_ARGS(device, queue),
> +         TP_STRUCT__entry(__field(u64, context)
> +                          __string(dev, dev_name(device))
> +                          __field(u64, doorbell_index)
> +                          __field(u64, client_id)
> +                          __field(u32, queue_type)
> +                          ),
> +         TP_fast_assign(__assign_str(dev);
> +                        __entry->doorbell_index =3D queue->doorbell_inde=
x;
> +                        __entry->queue_type =3D queue->queue_type;
> +                        __entry->client_id =3D queue->userq_mgr->file->c=
lient_id;
> +                        __entry->context =3D queue->fence_drv->context;
> +                       ),
> +         TP_printk("dev=3D%s, client_id=3D%llu, type=3D%u, doorbell=3D%l=
lu,
> context=3D%llu",
> +                   __get_str(dev), __entry->client_id, __entry->queue_ty=
pe,
> +                   __entry->doorbell_index, __entry->context) );
> +
> +TRACE_EVENT(amdgpu_userq_job_add_dep,
> +         TP_PROTO(struct device *device, struct amdgpu_usermode_queue
> *queue, struct amdgpu_userq_fence *dep),
> +         TP_ARGS(device, queue, dep),
> +         TP_STRUCT__entry(
> +                          __field(u64, context)
> +                          __field(u64, dep_context)
> +                          __field(u64, dep_seqno)
> +                          __string(dev, dev_name(device))
> +                          __field(u64, doorbell_index)
> +                          __field(u64, client_id)
> +                          __field(u32, queue_type)
> +                          ),
> +         TP_fast_assign(
> +                        __assign_str(dev);
> +                        __entry->doorbell_index =3D queue->doorbell_inde=
x;
> +                        __entry->queue_type =3D queue->queue_type;
> +                        __entry->client_id =3D queue->userq_mgr->file->c=
lient_id;
> +                        __entry->context =3D queue->fence_drv->context;
> +                        __entry->dep_context =3D dep->base.context;
> +                        __entry->dep_seqno =3D dep->base.seqno;
> +                        ),
> +         TP_printk("dev=3D%s, client_id=3D%llu, type=3D%u, doorbell=3D%l=
lu, context=3D%llu
> depends on fence=3D%llu:%llu",
> +                   __get_str(dev), __entry->client_id, __entry->queue_ty=
pe, __entry-
> >doorbell_index, __entry->context,
> +                   __entry->dep_context,
> +                   __entry->dep_seqno)
> +);
> +
> +TRACE_EVENT(amdgpu_userq_state_start,
> +         TP_PROTO(struct amdgpu_usermode_queue *queue),
> +         TP_ARGS(queue),
> +         TP_STRUCT__entry(
> +                          __field(u64, doorbell_index)
> +                          __field(u64, client_id)
> +                          __field(u32, queue_type)
> +                          __field(u32, from)
> +                          ),
> +         TP_fast_assign(
> +                        __entry->doorbell_index =3D queue->doorbell_inde=
x;
> +                        __entry->queue_type =3D queue->queue_type;
> +                        __entry->client_id =3D queue->userq_mgr->file->c=
lient_id;
> +                        __entry->from =3D queue->state;
> +                        ),
> +         TP_printk("client_id=3D%llu, type=3D%u, doorbell=3D%llu, from=
=3D%d",
> +                   __entry->client_id, __entry->queue_type,
> +__entry->doorbell_index, __entry->from) );
> +
> +TRACE_EVENT(amdgpu_userq_state_changed,
> +         TP_PROTO(struct amdgpu_usermode_queue *queue, enum
> amdgpu_userq_state new_state),
> +         TP_ARGS(queue, new_state),
> +         TP_STRUCT__entry(
> +                          __field(u64, doorbell_index)
> +                          __field(u64, client_id)
> +                          __field(u32, queue_type)
> +                          __field(u32, to)
> +                          ),
> +         TP_fast_assign(
> +                        __entry->doorbell_index =3D queue->doorbell_inde=
x;
> +                        __entry->queue_type =3D queue->queue_type;
> +                        __entry->client_id =3D queue->userq_mgr->file->c=
lient_id;
> +                        __entry->to =3D new_state;
> +                        ),
> +         TP_printk("client_id=3D%llu, type=3D%u, doorbell=3D%llu, to=3D%=
d",
> +                   __entry->client_id, __entry->queue_type,
> +__entry->doorbell_index, __entry->to) );
> +
>  #undef AMDGPU_JOB_GET_TIMELINE_NAME
>  #endif
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 9dc6cb579ac7..536e73c7e9ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -296,11 +296,15 @@ static int amdgpu_userq_preempt_helper(struct
> amdgpu_usermode_queue *queue)
>       int r;
>
>       if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) {
> +             trace_amdgpu_userq_state_start(queue);
> +
>               r =3D userq_funcs->preempt(queue);
>               if (r) {
> +                     trace_amdgpu_userq_state_changed(queue,
> AMDGPU_USERQ_STATE_HUNG);
>                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
>                       return r;
>               } else {
> +                     trace_amdgpu_userq_state_changed(queue,
> +AMDGPU_USERQ_STATE_PREEMPTED);
>                       queue->state =3D AMDGPU_USERQ_STATE_PREEMPTED;
>               }
>       }
> @@ -316,10 +320,14 @@ static int amdgpu_userq_restore_helper(struct
> amdgpu_usermode_queue *queue)
>       int r =3D 0;
>
>       if (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED) {
> +             trace_amdgpu_userq_state_start(queue);
> +
>               r =3D userq_funcs->restore(queue);
>               if (r) {
> +                     trace_amdgpu_userq_state_changed(queue,
> AMDGPU_USERQ_STATE_HUNG);
>                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
>               } else {
> +                     trace_amdgpu_userq_state_changed(queue,
> AMDGPU_USERQ_STATE_MAPPED);
>                       queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
>               }
>       }
> @@ -337,12 +345,15 @@ static int amdgpu_userq_unmap_helper(struct
> amdgpu_usermode_queue *queue)
>
>       if ((queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) ||
>           (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED)) {
> +             trace_amdgpu_userq_state_start(queue);
>
>               r =3D userq_funcs->unmap(queue);
>               if (r) {
> +                     trace_amdgpu_userq_state_changed(queue,
> AMDGPU_USERQ_STATE_HUNG);
>                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
>                       return r;
>               } else {
> +                     trace_amdgpu_userq_state_changed(queue,
> +AMDGPU_USERQ_STATE_UNMAPPED);
>                       queue->state =3D AMDGPU_USERQ_STATE_UNMAPPED;
>               }
>       }
> @@ -359,11 +370,15 @@ static int amdgpu_userq_map_helper(struct
> amdgpu_usermode_queue *queue)
>       int r;
>
>       if (queue->state =3D=3D AMDGPU_USERQ_STATE_UNMAPPED) {
> +             trace_amdgpu_userq_state_start(queue);
> +
>               r =3D userq_funcs->map(queue);
>               if (r) {
> +                     trace_amdgpu_userq_state_changed(queue,
> AMDGPU_USERQ_STATE_HUNG);
>                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
>                       return r;
>               } else {
> +                     trace_amdgpu_userq_state_changed(queue,
> AMDGPU_USERQ_STATE_MAPPED);
>                       queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
>               }
>       }
> @@ -894,6 +909,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr
> *uq_mgr)
>               if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>                       drm_file_err(uq_mgr->file,
>                                    "trying restore queue without va mappi=
ng\n");
> +                     trace_amdgpu_userq_state_changed(queue,
> +AMDGPU_USERQ_STATE_INVALID_VA);
>                       queue->state =3D AMDGPU_USERQ_STATE_INVALID_VA;
>                       continue;
>               }
> @@ -1389,12 +1405,14 @@ void amdgpu_userq_pre_reset(struct amdgpu_device
> *adev)
>               if (queue->state !=3D AMDGPU_USERQ_STATE_MAPPED)
>                       continue;
>
> +             trace_amdgpu_userq_state_start(queue);
>               userq_funcs =3D adev->userq_funcs[queue->queue_type];
>               userq_funcs->unmap(queue);
>               /* just mark all queues as hung at this point.
>                * if unmap succeeds, we could map again
>                * in amdgpu_userq_post_reset() if vram is not lost
>                */
> +             trace_amdgpu_userq_state_changed(queue,
> AMDGPU_USERQ_STATE_HUNG);
>               queue->state =3D AMDGPU_USERQ_STATE_HUNG;
>               amdgpu_userq_fence_driver_force_completion(queue);
>       }
> @@ -1413,6 +1431,8 @@ int amdgpu_userq_post_reset(struct amdgpu_device
> *adev, bool vram_lost)
>
>       xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>               if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG
> && !vram_lost) {
> +                     trace_amdgpu_userq_state_start(queue);
> +
>                       userq_funcs =3D adev->userq_funcs[queue->queue_type=
];
>                       /* Re-map queue */
>                       r =3D userq_funcs->map(queue);
> @@ -1420,6 +1440,7 @@ int amdgpu_userq_post_reset(struct amdgpu_device
> *adev, bool vram_lost)
>                               dev_err(adev->dev, "Failed to remap queue %=
ld\n",
> queue_id);
>                               continue;
>                       }
> +                     trace_amdgpu_userq_state_changed(queue,
> AMDGPU_USERQ_STATE_MAPPED);
>                       queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
>               }
>       }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 008330a0d852..6071e83acd9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -30,7 +30,7 @@
>  #include <drm/drm_syncobj.h>
>
>  #include "amdgpu.h"
> -#include "amdgpu_userq_fence.h"
> +#include "amdgpu_trace.h"
>
>  #define AMDGPU_USERQ_MAX_HANDLES     (1U << 16)
>
> @@ -528,6 +528,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev,=
 void
> *data,
>       /* Create the new fence */
>       amdgpu_userq_fence_init(queue, fence, wptr);
>
> +     trace_amdgpu_userq_job_run(dev->dev, queue, fence);
> +
>       mutex_unlock(&userq_mgr->userq_mutex);
>
>       /*
> @@ -701,7 +703,7 @@ amdgpu_userq_wait_add_fence(struct
> drm_amdgpu_userq_wait *wait_info,  }
>
>  static int
> -amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
> +amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct
> +drm_file *filp,
>                                   struct drm_amdgpu_userq_wait *wait_info=
,
>                                   u32 *syncobj_handles, u32 *timeline_poi=
nts,
>                                   u32 *timeline_handles,
> @@ -835,6 +837,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *=
filp,
>               goto free_fences;
>       }
>
> +     trace_amdgpu_userq_job_queue(dev->dev, waitq);
> +
>       for (i =3D 0, cnt =3D 0; i < num_fences; i++) {
>               struct amdgpu_userq_fence_driver *fence_drv;
>               struct amdgpu_userq_fence *userq_fence; @@ -869,6 +873,8 @@
> amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>
>               amdgpu_userq_fence_driver_get(fence_drv);
>
> +             trace_amdgpu_userq_job_add_dep(dev->dev, waitq, userq_fence=
);
> +
>               /* Store drm syncobj's gpu va address and value */
>               fence_info[cnt].va =3D fence_drv->va;
>               fence_info[cnt].value =3D fences[i]->seqno; @@ -968,7 +974,=
7 @@ int
> amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>                                                  gobj_write,
>                                                  gobj_read);
>       } else {
> -             r =3D amdgpu_userq_wait_return_fence_info(filp, wait_info,
> +             r =3D amdgpu_userq_wait_return_fence_info(dev, filp, wait_i=
nfo,
>                                                       syncobj_handles,
>                                                       timeline_points,
>                                                       timeline_handles,
> --
> 2.34.1

