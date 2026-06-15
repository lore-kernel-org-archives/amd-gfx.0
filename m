Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01036CD98C7
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 12:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D0110E3BA;
	Mon, 15 Jun 2026 12:13:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A0XF2gKI";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011007.outbound.protection.outlook.com
 [40.93.194.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A57C10E3BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 12:13:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBK/sz2drQZhn0aJ85wIUfSqbPr2Jw7YJpeqpJ2IAk493gDlV7xz76d/a86LR3RukXq7oYhwKEPFdHnNpKHHpJ2aUaVMJ73GRbEa3VjBuW21BB4j2sLzXEeBs0COz9i5F8m8ZmSG5J6IuT4WC9cB+setwujhnvV1wlUgA67zY/U/NGNm29o36jrfGdPemOyYthNxopneF1HGupvao1v0fCZSOmABBM3YlS2+VucKHh35kekV4LmHIffDQDH3xgS8jrJLFStscxeffIcAlNARjxiLXsNwFDGljBmnNys5JbBLasP+wI1R5d017J+1XXuESBnuvYQuKX79KTawdO4ufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lizC7NX5lQZPFUMqTZ4qrIv9Z+4ZVAHXXfhG+vHEXP0=;
 b=WT6GRStA8ZcekW5Pg/it5TUpdH3LHrtaQIP2KZ+u9mXG99mOUWc6lJi9TwDaA3kMx30/0Y5OtkLzt1pQnQQkYQ3qFbX9oJ85RlbjcTjESFjg4Pn3kSSmJYrzwZGV0H4iyOMGYg+LVJgrDffft0ex/WgGGUM4GGXke/3I/rT46pLcmPBHo3wkEzEJTk3E6xBrg9WQbXrxDqMBq790JfPlEfr3vapxiLG+jFb5ouHSYZyWPEMgpjPoZDexIVte8RsuPbvDp6tez+Nqehn79ATskuPoEjF2HCY7wkc871ra30B7ogx8BiXhvYgcD4UN0h3WPiAhqGCwRbE+vSlB4Mvzbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lizC7NX5lQZPFUMqTZ4qrIv9Z+4ZVAHXXfhG+vHEXP0=;
 b=A0XF2gKIt1D9KkU4tv7BWOfE0JTRZFOx2ZRTa27mErZwx/zP6/h0sMwHPbGlnRsQFuwRSkbO2GEe06K2pOdR7Wc1npk4Wxn9DVvGvspiBHb2OQOAJbWbfFWmMHvg7ibKcG/J70NPsCJfEQZZD5C1yai4oQvf6fywZknINulsTpU=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 LV9PR12MB9759.namprd12.prod.outlook.com (2603:10b6:408:2ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 12:13:06 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 12:13:06 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH v3 3/3] drm/amdgpu: add userq job and state transition
 trace events
Thread-Topic: [PATCH v3 3/3] drm/amdgpu: add userq job and state transition
 trace events
Thread-Index: AQHc+jarZQL80dfqxE6OWVZqUJ9/DbY/i/pA
Date: Mon, 15 Jun 2026 12:13:06 +0000
Message-ID: <DS7PR12MB6005D8E085F3E9B60619669CFBE62@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260612064223.196556-1-Prike.Liang@amd.com>
 <20260612064223.196556-3-Prike.Liang@amd.com>
In-Reply-To: <20260612064223.196556-3-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-15T12:12:14.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|LV9PR12MB9759:EE_
x-ms-office365-filtering-correlation-id: 3c9c0f30-56e4-4e97-d6a8-08decad774fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|4143699003|11063799006|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: JHY75HyB/vUCFjEU1yNT5c9nCxfO9MhOqbjuJKxgGHAO764R9OS4DRCMvlWDuM+D2Gi6l8wLFJgKMdMyk8MIoBYZ8OfrS0N6qF/QZjSU6vtl4gzObivfSfs3GwsUcpKuu/SpPhnOhlkJOZAky3a+hZZxtGjHLXCsncvr04/WVL2ieMYPCEKzYzVKMlYJj65O39KtVHn4NzVV3Ps8kh2AvetXbJt9B6pO2g/Qlvww37/FLWpEy/GuExoMhoahjm+vaBfmCPyUPgF+mQc6pN5yiKYQ9XNOYRCINpfedInSO7+gsoS4DrWqoCpowuz5iull8xxIwnOq8rYzt6JdtPiCz8+3kMEIC5mtK56+cTvxM8aExO5dKZuJfK6avcXCWhX3QmRLkE1TqUlRWmSYLXYRHMdRXfZCFcvVD+52OLFWVatnqUmgiF/tsU8jDBc5aJskEMQFeV+aTbqIDTyxQYXJW97gyCsFhgq/8wz7JB/I8b0Nx+7hpa+0Ermbm4ztYlzzXnE4Rakdpd6+8f6grW65OMvNJNnLAFBffHM54rHZBTg/AyIxhdcmmZhy0aI/Pd7K4xPqJ7oB/f/kDCnCMHMNCNssyhptvH6a0oWPHXeVzs5NS90LhqYvccIOgDi9dDirCpNn6FpClFsGSXuGn8pmuEmlWfWO7uNoSCtDQdPDK5EVHWdsUs4UxBoYNWx69YHNjhs602QOslUH4TlqfqZsT/KCmvmO69kU415RD2CKLJ7wm8EgtIQoQlNT8GV/3+n9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(4143699003)(11063799006)(6133799003)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J3T3ZvtVK88/z9PhZuckEsGQWyXzO3/XxsYWMf+yZDxOEf35R2KwmYSAjQP/?=
 =?us-ascii?Q?oocPAF93CsDc7JH6Rclv1FbAeu+2z8LJy/VBAnSYG9C4n/bnB1I6e7LSvDyV?=
 =?us-ascii?Q?7uSt3j3Bj8+ikMmXsOgnhRm2z2nkFkHPFrrCfG+Z1lIRdqMBngR7khyDrZkP?=
 =?us-ascii?Q?KLZUrIj777pHLo8jxp8wtYjNEg1iMaMymGu297UzgcrSI22Fz1CP9J+WMUsY?=
 =?us-ascii?Q?HnT45uHJZil/nLlgsR3h09Ugdh2m3g94YylvP8mDxZAIIWSUssxIn7mLYt6U?=
 =?us-ascii?Q?mnzx2hbCNvqESZOv79KUvyK+bWK1rC7RDQ7e1bjUq3DFyzGhPsHNgPsu2RaA?=
 =?us-ascii?Q?4v7+LBFVEgkCeJT2YwyAbc8RZP8dBZf/jpdyTPID5DUpIRUaYMVeNrqBmc4X?=
 =?us-ascii?Q?0XDVeqEphfcbo2lzthguhgcJwdAqgGwv2WPCh+OWf5+UstXehYFvMtCe2r8G?=
 =?us-ascii?Q?xBrkU03j63XekaZxYkAU6wiKO+rsDCmBFg2XZV1d1EZx0Z9Ewl+AOz8Z2zHq?=
 =?us-ascii?Q?7N7DPHZyImdZ9akJ1/dCLm3B13bm4vvLS9GCo9PIzQadjCFtwb6VpzvTO+yS?=
 =?us-ascii?Q?UcZ9L8NqCrL78Usc2p4fQACcr+XgQW8ahkfe2ppHThO2JNWhz4iPoJPpk7TI?=
 =?us-ascii?Q?jjjXQXNINly3Nmp74bgj34/OweBak9ySPtBCrRxyIudQa72q+dXh+r4+2beJ?=
 =?us-ascii?Q?PQjX3JHreQ8k0bjxGKzUX6AcsLUqBsugGC8ob4RqOMIweaO1jsiJsmM6UxXZ?=
 =?us-ascii?Q?vOonJN+gqAiZtnTKtkbi5oO6CdEQ1x+St6WgohB2tl1Aj5NOGRcDEnoG61qd?=
 =?us-ascii?Q?uc49qXyvf7ZnghlcA7XAIOHB29xl9YGifViiJJpnTDc+W3T6i22St+hiY7HU?=
 =?us-ascii?Q?V1Ui/0lQPyYDBlAEi7W9vzsEisNweku88kaBvBnsGF8EVBnwWSLpyWoO5Wn6?=
 =?us-ascii?Q?ichxwiV6LncJeKnZ53zKBFLMCiAPY1zKSKqSv+9Dl6VIebsKW4LQ/q8gaLdl?=
 =?us-ascii?Q?iTGJTkqXnAGOo+MuTxRzvisEj/hXcCKocKkv4SqwzwDZFiBHeDjNibTS37NR?=
 =?us-ascii?Q?K/DGjyDzVxOwGhdaozcHyJGW6J5r8EwcxNByVzbsA0i91ZfhTI9FZtDgQmVm?=
 =?us-ascii?Q?6ujkGxBHxQuVt+C6IfxOAEAcLZTB+mF9II14d1uqHHSHKQ8oj5Fue7DYRGdi?=
 =?us-ascii?Q?x18SYaLctDtKPSLQf9hdVCeO+v/1HjcDmZGl8TP7MRqv1vSanLsb8arUd2vg?=
 =?us-ascii?Q?NH+hrRXzIAQ6ujHEux91us1JTBb3pBcAg4Clhwohzy2JQ5kOappcDYmFCou6?=
 =?us-ascii?Q?8PgJKVLTadpMU+l/MVDWR07MVNAcFIvIhcpPiiF7jtcVo2B9PkOEGVh/Phhy?=
 =?us-ascii?Q?tOin4HJ+KWXGWvKjGkldWzm/LPkTjqLChozhi3mW3Sdhb1FpKmCfmjH96nXa?=
 =?us-ascii?Q?bG+uF9d3PR1BmTT4VrZKrq73gL8sagbGeAObI5LqNavl9CKch6IJPN35GuDq?=
 =?us-ascii?Q?vYCmZpB/7J7Etsny/igjG8ALwXeBqw7UVhmtv/Wn65bG4MSxHQ0CSDzULApQ?=
 =?us-ascii?Q?kp8J56kuMgbmgy/4WsyEpNAZiHPh8WoL9twjDrF+QRPh2QmqT/Di+aA4AjPc?=
 =?us-ascii?Q?fZ/n7HyF0ihErWToR0iQjgWBeuT1HaTRjr7kdizJlcAhfkM+4OpsCkFQlByK?=
 =?us-ascii?Q?k0pKs7DvEUeWYzw9001Tf3mHwH7Yon5RbqjuE1Inb0rli5qi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9c0f30-56e4-4e97-d6a8-08decad774fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 12:13:06.2413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8zQDGxXoOWvdnXeLKliQ2vmLYAJgaWTogo4VsTsxT41z885lgAxLK9CU7v0Dxj8T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9759
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

Ping on the patch1,3

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Friday, June 12, 2026 2:42 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pell=
oux-
> prayer@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-
> prayer@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH v3 3/3] drm/amdgpu: add userq job and state transition tr=
ace
> events
>
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>
> Add ftrace events for tracking the userq fence emit, signal and queue sta=
te transition.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> Co-developed-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 92 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 21 +++++
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 10 +-
>  3 files changed, 120 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index df98be22f1f5..fcd4cf2f4cd8 100644
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
>  #define TRACE_INCLUDE_FILE amdgpu_trace @@ -636,6 +638,96 @@
> DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
>            TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
>            TP_ARGS(queue, result));
>
> +TRACE_EVENT(amdgpu_userq_emit_fence,
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
> +TRACE_EVENT(amdgpu_userq_wait_deps,
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
> index c6b9e8fc6293..210d83b0aba5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -294,11 +294,15 @@ static int amdgpu_userq_preempt_helper(struct
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
> @@ -314,10 +318,14 @@ static int amdgpu_userq_restore_helper(struct
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
> @@ -335,12 +343,15 @@ static int amdgpu_userq_unmap_helper(struct
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
> @@ -357,11 +368,15 @@ static int amdgpu_userq_map_helper(struct
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
> @@ -890,6 +905,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr
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
> @@ -1382,12 +1398,14 @@ void amdgpu_userq_pre_reset(struct amdgpu_device
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
> @@ -1406,6 +1424,8 @@ int amdgpu_userq_post_reset(struct amdgpu_device
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
> @@ -1413,6 +1433,7 @@ int amdgpu_userq_post_reset(struct amdgpu_device
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
> index c0d68863fa17..751535a7aef9 100644
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
> +     trace_amdgpu_userq_emit_fence(dev->dev, queue, fence);
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
>                                   u32 *syncobj_handles, u64 *timeline_poi=
nts,
>                                   u32 *timeline_handles,
> @@ -869,6 +871,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *=
filp,
>
>               amdgpu_userq_fence_driver_get(fence_drv);
>
> +             trace_amdgpu_userq_wait_deps(dev->dev, waitq, userq_fence);
> +
>               /* Store drm syncobj's gpu va address and value */
>               fence_info[cnt].va =3D fence_drv->va;
>               fence_info[cnt].value =3D fences[i]->seqno; @@ -969,7 +973,=
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

