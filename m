Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C78CD6E4A
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 08:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42A010ED13;
	Tue,  2 Jun 2026 08:00:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dVVDyqHk";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AF8510ED33
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 08:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUlxvV6W3KJkcN6AQtFX4h6N5EYJDhAKg+PMc+jUdou+cJ5tLExV1Bs9R+gwH0+5xstgvZycC+dvmKTGE7rdG3sW2SpdXoB1VO/VkakutFP4PfUcq0mTk9XPm9KgGf3sz9hJVOIkW/MbFoWXrYhRfyQzRsTOvoQbrT1q/da/FRl7920M+lkFbs4kr9jK0SMBDjqkdHbLHZE9Z1DZh1RGfQV+BLxazjq8v/rS+oVpwrEdAkIXm6MqPxEnWZL72SioR+PaZnAl2nZ/bRlwtVN1hqDW2uzqgrD9rJ1Cf4qIHFigd6H32xp+0gtIcT9Dw0ExSvRubVS+ukNa1S/eRHC/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KC9z1EsiupOyZZgvxgOG1Vchw7AZ5HtTc7ww+aMvwI8=;
 b=X451oXIq55HSVpSfQWd/FblBp1WfDD+A25MFVj34CKJ42OPy56zy5NsB6BzgToUmB3wdAgGD67r7F+rBCkfZ9XFcrI07K8Dr3A8/1waH6m2XTOw+VhgFdatPQ8gZyzM9lOD3XrMoChMG3FUqOBUNDJtDBpn184QlcP1UnNyLJ/vWK739MAv1qGUSi9svEiHcMGpJNjCtSAjG5RiDdx6k26IqQe9NNtJaf1cx0H4Bz2zvZ7YLVkmnz3kFhGCjBheVnnqrdIGpcPKFv6tu+7++i+xdCQZFvaMneyU8ZkRPiUSFTubfq0GT9Sqpa1eF4inupslPbvAFL4lQPajzmwJ3kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KC9z1EsiupOyZZgvxgOG1Vchw7AZ5HtTc7ww+aMvwI8=;
 b=dVVDyqHkcj5KUD689fzvIFVndkAflq4my2P5ysKXU9UmiJazMFcWRGnPXeSy62GxWHwds7nEc154sVduNxn6HIDaOVwQH9tyFQvYoOGTwf4rsplkUKgsxsEEdgViHThvcJKCeYWgHeU8zvjSZMKki1MEeSht9xu30zhY4D1qz04=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS2PR12MB9752.namprd12.prod.outlook.com (2603:10b6:8:270::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.14; Tue, 2 Jun 2026 08:00:07 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 08:00:07 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: add userq job and state transition trace
 events
Thread-Topic: [PATCH 2/2] drm/amdgpu: add userq job and state transition trace
 events
Thread-Index: AQHc7dMwbTv00Xxo9EymkgLv/hnlcLYk1GCAgAYaPQA=
Date: Tue, 2 Jun 2026 08:00:07 +0000
Message-ID: <DS7PR12MB6005F460B0924D40A58EDC3CFB122@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260527122001.69831-1-Prike.Liang@amd.com>
 <20260527122001.69831-2-Prike.Liang@amd.com>
 <DS7PR12MB6005453059156B25B61CBF15FB162@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005453059156B25B61CBF15FB162@DS7PR12MB6005.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS2PR12MB9752:EE_
x-ms-office365-filtering-correlation-id: 8168691e-c311-4832-bfd5-08dec07cf642
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|6133799003|56012099006|11063799006|4143699003|18002099003;
x-microsoft-antispam-message-info: EsmhqArwI/AkQ35tkRkJ7X3z7fQJt1x0B82/379cMnbcArEIG5smm9eUUz39iFnAVI25CyRrvKCWQb6VFsHORA5pZ+UaZS4d0yNGrO2DrWixVMJ6BFXHK0oxA2j99DpWJl/nTqzHUZiK10VeG5hYs3RFBBulSzAcGQ1j314yem5YurqRr+tBFwdTckLec8xsNji0Il3dDXEPZrYJLUP1T4ek5HDw4EKF2NY9zxT/eyjvG2ai6O55kkWjtusUw5XUf56E2O/dkDEx2UFpZ9GmEXEYutyAiGkwU4davKtzACvQTiFt9B6jXeSVRuio5rWZaQd1UIV/SJwq1v493ksvHxoUiAEtxvetAOoC9pw5n1A1TrukzscoEhSOhoECK/vv+2lTkY0m2deGh+JHExyqRm2ZE6ADJgWQIxn8aKfw40BZk4jYRZnrrV7rTdnDLLlpyeTuyqWk8aRHOmJP9mDZSg6wETH2GomMwx0zxFymuNAFIDKk1biTDr3rXlFb7gujG5aI68I03VjBu1kYITIam4cNCQcIDGD3udYM9d/ibr1JIYJgCXiTG3bo7JsDeYWxV7iaSYUpBiFJiQZlcBx+v/Ow0Tp2HescQv0MeM2RT0s6Apg6Gape+mbVBNx3Ob2qgyerOFSQo0mT/BH0JQ4ToEDRFhApXMibAKNhNzaZTkFcbSN+B8ZTMBGZetY0V72eRmTKJ2GW27Dd4e8wwYPvwZ5cvy7A/maFPvpGMUvlv1BojwkB/e7m1hzNOwfmfxEW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(6133799003)(56012099006)(11063799006)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ViP149GNLk3hXZgpm9Dpg1yRMqvUwnjFRxgoNaV+Y5PKdmKckbBFuh2G81iB?=
 =?us-ascii?Q?iiKC0ewtWIJq/vsh6tUNdY5lO3R0mUDskYhTUhn/0InRU4frgPhIbM++5qh5?=
 =?us-ascii?Q?aWAx71Q9YQjbLpe7I1+06NcwfYJ75gy6fpJPKTgXAVF/ccH5MGAPuOPCT9zJ?=
 =?us-ascii?Q?i7kfDX11gk9jSkS5l8jtQzoFjoRjpcYfYHlY4FsLITRdyANzrCcnTVx3M87F?=
 =?us-ascii?Q?rRUEWwQXdayM3X5ONBb+hOVE4MV69A7riDPIX9ciaiXCUpSYxhdMjst436ED?=
 =?us-ascii?Q?ke6V/Nh5Q/5Yi7fUeCmJjDVCDI6rn0/Bt5bGZYb1iGfxKOKrmjLyLp+V6kse?=
 =?us-ascii?Q?l4gZ+DM0PPDj+QCVSF2SddCcRblCk4WOzUmPNy/iwPOod0r9ottUiteU8ifN?=
 =?us-ascii?Q?KXF0/qGRQsdGuuFuADyCwgJY1NjIyldhLgWxMZmreXJgWj7UJshsqepUxCBJ?=
 =?us-ascii?Q?byCOOvSh21wMCqkpvkVEwmh9aXHDNuZKGL8RswOi1WDjJFMkeNdIvOX0HFul?=
 =?us-ascii?Q?hVHbLNPVP6mi9Yfy/n858hDkMyw/Xfs/1EhDgi2/rPg/XIa2ZeBKeEByd/WY?=
 =?us-ascii?Q?RxVAy+fDTsSU6TbC5WTtlLhcOfBPdIGHjDSPIgGToDXuHuLhl3BaO8DlWqZy?=
 =?us-ascii?Q?f8L6ygN1AkOS/9T8HdiedaWLoY1rGOBAUiODUfVe3Vtk7d+4YuPlwI89/zPd?=
 =?us-ascii?Q?Ru6kdp8fIHK3vuuJicvChG6H95OxXW4/JOkyCeAQRsTjf8lSewzABWcsBbrb?=
 =?us-ascii?Q?cN5PsFyYNNelCtc8gB3VAfnPrDsFeHRCw2Vy9odATeu+kk8hTx+yHAZfRUE6?=
 =?us-ascii?Q?bF9mboYE4rs1lCA0xj32fvEFaC1wJ4qzAuD5Zj+drPPox1Bjz135K73ZoiSE?=
 =?us-ascii?Q?hbiHhPkfgQ9VwURnY9CHjYlU6gA3LeB8CC7MBbNz43BdF5dcSJX5nxbp96xk?=
 =?us-ascii?Q?N1c3zxSXP122mAkrazoFQ053h77RZvXbczFTBE8Awl0+LYsK+EvTG6pAh7sh?=
 =?us-ascii?Q?zCuUWkebF6wFgbWoe3zWx9ai4fZVcXjhBSjmo+tM9NIFx9b+Dp+R48kQTGWg?=
 =?us-ascii?Q?Pzn2nVsdcplzjIymZDaXe7e1cNrkugGk0JY9pOoCkNWew1hylSA2Z77SF6w8?=
 =?us-ascii?Q?u5TOi/LSNXrh+tKYY3JmO8zk7Hq5ipr8keRZVgWNkut8OU+Tng8wFhYblkMo?=
 =?us-ascii?Q?u3Myy1h59zAiTG6SKuIgYSI/Hhq7QsdNe5Ci3YV0YgkSR5V+0UHxztxigaY0?=
 =?us-ascii?Q?WjTlGFopfbiyNFhxo/6CNLceKt+ag8soLXdWVs5Cq8iv2olXBuWv0mcpGfLE?=
 =?us-ascii?Q?DYIK84xQd9JoBQjM3dHeAxTPclnEv+MSNV8X+zG3ho2fYebnyVVwUGhM9a+J?=
 =?us-ascii?Q?JB3tQ4E6XmYsEOjKTgcGpYAcnX3qDgkrTTPMVejnR4cjeRmdMMiYJYbElRK8?=
 =?us-ascii?Q?DIvWTNrECnKXfyzAXPFQ8CkG91uoOk0v80+OYAHuZQnKnhFzyZUocH7kAPAf?=
 =?us-ascii?Q?MIdS4RTOn6pMPJ4jO+a22FVpUvdHI4TPtFdy1S8Vm3uewmMHek2AnzWUUAnh?=
 =?us-ascii?Q?bIb0aUwsFJFfceX7vv/5S3HrETY65I0ygPaA1QFEWluS8z/fdERA8i4UkhIl?=
 =?us-ascii?Q?w6c/gh5H9uL0i8N9BMUUhzDrq1d/fIdPskiDmpF7Sd8VhhneX+t44mUw8EK5?=
 =?us-ascii?Q?f+VAWdXnZgzKGf1c+avVXPPCs01Qh9bMzWTYAB68To08ISHe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8168691e-c311-4832-bfd5-08dec07cf642
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 08:00:07.2998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lnl2zVLUezds23qiU5NeLz8p0/CIQuCkeP+WvSvdheCAJVYFnrEvVJHfLyPjiv30
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9752
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

These patch sets can be beneficial for profiling userq state transitions an=
d latency.

Ping on this series.

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liang,=
 Prike
> Sent: Friday, May 29, 2026 8:49 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pell=
oux-
> prayer@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-
> prayer@amd.com>
> Subject: RE: [PATCH 2/2] drm/amdgpu: add userq job and state transition t=
race
> events
>
> AMD General
>
> Ping
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Liang, Prike <Prike.Liang@amd.com>
> > Sent: Wednesday, May 27, 2026 8:20 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pelloux-Prayer, Pierre-Eric
> > <Pierre-eric.Pelloux- prayer@amd.com>; Pelloux-Prayer, Pierre-Eric
> > <Pierre-eric.Pelloux- prayer@amd.com>; Liang, Prike
> > <Prike.Liang@amd.com>
> > Subject: [PATCH 2/2] drm/amdgpu: add userq job and state transition
> > trace events
> >
> > From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> >
> > Add ftrace events for tracking the userq fence emit, signal and queue s=
tate
> transition.
> >
> > Signed-off-by: Pierre-Eric Pelloux-Prayer
> > <pierre-eric.pelloux-prayer@amd.com>
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 113 ++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  21 ++++
> >  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  12 +-
> >  3 files changed, 143 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> > index df98be22f1f5..ef6a1fb82ff3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> > @@ -28,6 +28,8 @@
> >  #include <linux/types.h>
> >  #include <linux/tracepoint.h>
> >
> > +#include "amdgpu_userq_fence.h"
> > +
> >  #undef TRACE_SYSTEM
> >  #define TRACE_SYSTEM amdgpu
> >  #define TRACE_INCLUDE_FILE amdgpu_trace @@ -636,6 +638,117 @@
> > DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
> >            TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
> >            TP_ARGS(queue, result));
> >
> > +TRACE_EVENT(amdgpu_userq_job_run,
> > +         TP_PROTO(struct device *device, struct amdgpu_usermode_queue
> > *queue, struct amdgpu_userq_fence *fence),
> > +         TP_ARGS(device, queue, fence),
> > +         TP_STRUCT__entry(
> > +                          __field(u64, fence_context)
> > +                          __field(u64, fence_seqno)
> > +                          __string(dev, dev_name(device))
> > +                          __field(u64, doorbell_index)
> > +                          __field(u64, client_id)
> > +                          __field(u32, queue_type)
> > +                          ),
> > +         TP_fast_assign(
> > +                        __entry->fence_context =3D fence->base.context=
;
> > +                        __entry->fence_seqno =3D fence->base.seqno;
> > +                        __assign_str(dev);
> > +                        __entry->doorbell_index =3D queue->doorbell_in=
dex;
> > +                        __entry->client_id =3D queue->userq_mgr->file-=
>client_id;
> > +                        __entry->queue_type =3D queue->queue_type;
> > +                        ),
> > +         TP_printk("dev=3D%s, client_id=3D%llu, type=3D%u, doorbell=3D=
%llu,
> > fence=3D%llu:%llu",
> > +                   __get_str(dev), __entry->client_id,
> > + __entry->queue_type, __entry-
> > >doorbell_index,
> > +                   __entry->fence_context,
> > +                   __entry->fence_seqno) );
> > +
> > +TRACE_EVENT(amdgpu_userq_job_queue,
> > +         TP_PROTO(struct device *device,
> > +                  struct amdgpu_usermode_queue *queue),
> > +         TP_ARGS(device, queue),
> > +         TP_STRUCT__entry(__field(u64, context)
> > +                          __string(dev, dev_name(device))
> > +                          __field(u64, doorbell_index)
> > +                          __field(u64, client_id)
> > +                          __field(u32, queue_type)
> > +                          ),
> > +         TP_fast_assign(__assign_str(dev);
> > +                        __entry->doorbell_index =3D queue->doorbell_in=
dex;
> > +                        __entry->queue_type =3D queue->queue_type;
> > +                        __entry->client_id =3D queue->userq_mgr->file-=
>client_id;
> > +                        __entry->context =3D queue->fence_drv->context=
;
> > +                       ),
> > +         TP_printk("dev=3D%s, client_id=3D%llu, type=3D%u, doorbell=3D=
%llu,
> > context=3D%llu",
> > +                   __get_str(dev), __entry->client_id, __entry->queue_=
type,
> > +                   __entry->doorbell_index, __entry->context) );
> > +
> > +TRACE_EVENT(amdgpu_userq_job_add_dep,
> > +         TP_PROTO(struct device *device, struct amdgpu_usermode_queue
> > *queue, struct amdgpu_userq_fence *dep),
> > +         TP_ARGS(device, queue, dep),
> > +         TP_STRUCT__entry(
> > +                          __field(u64, context)
> > +                          __field(u64, dep_context)
> > +                          __field(u64, dep_seqno)
> > +                          __string(dev, dev_name(device))
> > +                          __field(u64, doorbell_index)
> > +                          __field(u64, client_id)
> > +                          __field(u32, queue_type)
> > +                          ),
> > +         TP_fast_assign(
> > +                        __assign_str(dev);
> > +                        __entry->doorbell_index =3D queue->doorbell_in=
dex;
> > +                        __entry->queue_type =3D queue->queue_type;
> > +                        __entry->client_id =3D queue->userq_mgr->file-=
>client_id;
> > +                        __entry->context =3D queue->fence_drv->context=
;
> > +                        __entry->dep_context =3D dep->base.context;
> > +                        __entry->dep_seqno =3D dep->base.seqno;
> > +                        ),
> > +         TP_printk("dev=3D%s, client_id=3D%llu, type=3D%u, doorbell=3D=
%llu,
> > + context=3D%llu
> > depends on fence=3D%llu:%llu",
> > +                   __get_str(dev), __entry->client_id,
> > + __entry->queue_type, __entry-
> > >doorbell_index, __entry->context,
> > +                   __entry->dep_context,
> > +                   __entry->dep_seqno) );
> > +
> > +TRACE_EVENT(amdgpu_userq_state_start,
> > +         TP_PROTO(struct amdgpu_usermode_queue *queue),
> > +         TP_ARGS(queue),
> > +         TP_STRUCT__entry(
> > +                          __field(u64, doorbell_index)
> > +                          __field(u64, client_id)
> > +                          __field(u32, queue_type)
> > +                          __field(u32, from)
> > +                          ),
> > +         TP_fast_assign(
> > +                        __entry->doorbell_index =3D queue->doorbell_in=
dex;
> > +                        __entry->queue_type =3D queue->queue_type;
> > +                        __entry->client_id =3D queue->userq_mgr->file-=
>client_id;
> > +                        __entry->from =3D queue->state;
> > +                        ),
> > +         TP_printk("client_id=3D%llu, type=3D%u, doorbell=3D%llu, from=
=3D%d",
> > +                   __entry->client_id, __entry->queue_type,
> > +__entry->doorbell_index, __entry->from) );
> > +
> > +TRACE_EVENT(amdgpu_userq_state_changed,
> > +         TP_PROTO(struct amdgpu_usermode_queue *queue, enum
> > amdgpu_userq_state new_state),
> > +         TP_ARGS(queue, new_state),
> > +         TP_STRUCT__entry(
> > +                          __field(u64, doorbell_index)
> > +                          __field(u64, client_id)
> > +                          __field(u32, queue_type)
> > +                          __field(u32, to)
> > +                          ),
> > +         TP_fast_assign(
> > +                        __entry->doorbell_index =3D queue->doorbell_in=
dex;
> > +                        __entry->queue_type =3D queue->queue_type;
> > +                        __entry->client_id =3D queue->userq_mgr->file-=
>client_id;
> > +                        __entry->to =3D new_state;
> > +                        ),
> > +         TP_printk("client_id=3D%llu, type=3D%u, doorbell=3D%llu, to=
=3D%d",
> > +                   __entry->client_id, __entry->queue_type,
> > +__entry->doorbell_index, __entry->to) );
> > +
> >  #undef AMDGPU_JOB_GET_TIMELINE_NAME
> >  #endif
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > index 9dc6cb579ac7..536e73c7e9ef 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > @@ -296,11 +296,15 @@ static int amdgpu_userq_preempt_helper(struct
> > amdgpu_usermode_queue *queue)
> >       int r;
> >
> >       if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) {
> > +             trace_amdgpu_userq_state_start(queue);
> > +
> >               r =3D userq_funcs->preempt(queue);
> >               if (r) {
> > +                     trace_amdgpu_userq_state_changed(queue,
> > AMDGPU_USERQ_STATE_HUNG);
> >                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> >                       return r;
> >               } else {
> > +                     trace_amdgpu_userq_state_changed(queue,
> > +AMDGPU_USERQ_STATE_PREEMPTED);
> >                       queue->state =3D AMDGPU_USERQ_STATE_PREEMPTED;
> >               }
> >       }
> > @@ -316,10 +320,14 @@ static int amdgpu_userq_restore_helper(struct
> > amdgpu_usermode_queue *queue)
> >       int r =3D 0;
> >
> >       if (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED) {
> > +             trace_amdgpu_userq_state_start(queue);
> > +
> >               r =3D userq_funcs->restore(queue);
> >               if (r) {
> > +                     trace_amdgpu_userq_state_changed(queue,
> > AMDGPU_USERQ_STATE_HUNG);
> >                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> >               } else {
> > +                     trace_amdgpu_userq_state_changed(queue,
> > AMDGPU_USERQ_STATE_MAPPED);
> >                       queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
> >               }
> >       }
> > @@ -337,12 +345,15 @@ static int amdgpu_userq_unmap_helper(struct
> > amdgpu_usermode_queue *queue)
> >
> >       if ((queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) ||
> >           (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED)) {
> > +             trace_amdgpu_userq_state_start(queue);
> >
> >               r =3D userq_funcs->unmap(queue);
> >               if (r) {
> > +                     trace_amdgpu_userq_state_changed(queue,
> > AMDGPU_USERQ_STATE_HUNG);
> >                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> >                       return r;
> >               } else {
> > +                     trace_amdgpu_userq_state_changed(queue,
> > +AMDGPU_USERQ_STATE_UNMAPPED);
> >                       queue->state =3D AMDGPU_USERQ_STATE_UNMAPPED;
> >               }
> >       }
> > @@ -359,11 +370,15 @@ static int amdgpu_userq_map_helper(struct
> > amdgpu_usermode_queue *queue)
> >       int r;
> >
> >       if (queue->state =3D=3D AMDGPU_USERQ_STATE_UNMAPPED) {
> > +             trace_amdgpu_userq_state_start(queue);
> > +
> >               r =3D userq_funcs->map(queue);
> >               if (r) {
> > +                     trace_amdgpu_userq_state_changed(queue,
> > AMDGPU_USERQ_STATE_HUNG);
> >                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> >                       return r;
> >               } else {
> > +                     trace_amdgpu_userq_state_changed(queue,
> > AMDGPU_USERQ_STATE_MAPPED);
> >                       queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
> >               }
> >       }
> > @@ -894,6 +909,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr
> > *uq_mgr)
> >               if (!amdgpu_userq_buffer_vas_mapped(queue)) {
> >                       drm_file_err(uq_mgr->file,
> >                                    "trying restore queue without va
> > mapping\n");
> > +                     trace_amdgpu_userq_state_changed(queue,
> > +AMDGPU_USERQ_STATE_INVALID_VA);
> >                       queue->state =3D AMDGPU_USERQ_STATE_INVALID_VA;
> >                       continue;
> >               }
> > @@ -1389,12 +1405,14 @@ void amdgpu_userq_pre_reset(struct
> > amdgpu_device
> > *adev)
> >               if (queue->state !=3D AMDGPU_USERQ_STATE_MAPPED)
> >                       continue;
> >
> > +             trace_amdgpu_userq_state_start(queue);
> >               userq_funcs =3D adev->userq_funcs[queue->queue_type];
> >               userq_funcs->unmap(queue);
> >               /* just mark all queues as hung at this point.
> >                * if unmap succeeds, we could map again
> >                * in amdgpu_userq_post_reset() if vram is not lost
> >                */
> > +             trace_amdgpu_userq_state_changed(queue,
> > AMDGPU_USERQ_STATE_HUNG);
> >               queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> >               amdgpu_userq_fence_driver_force_completion(queue);
> >       }
> > @@ -1413,6 +1431,8 @@ int amdgpu_userq_post_reset(struct amdgpu_device
> > *adev, bool vram_lost)
> >
> >       xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> >               if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG &&
> > !vram_lost) {
> > +                     trace_amdgpu_userq_state_start(queue);
> > +
> >                       userq_funcs =3D adev->userq_funcs[queue->queue_ty=
pe];
> >                       /* Re-map queue */
> >                       r =3D userq_funcs->map(queue); @@ -1420,6 +1440,7
> > @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool
> > vram_lost)
> >                               dev_err(adev->dev, "Failed to remap
> > queue %ld\n", queue_id);
> >                               continue;
> >                       }
> > +                     trace_amdgpu_userq_state_changed(queue,
> > AMDGPU_USERQ_STATE_MAPPED);
> >                       queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
> >               }
> >       }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > index 008330a0d852..6071e83acd9e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > @@ -30,7 +30,7 @@
> >  #include <drm/drm_syncobj.h>
> >
> >  #include "amdgpu.h"
> > -#include "amdgpu_userq_fence.h"
> > +#include "amdgpu_trace.h"
> >
> >  #define AMDGPU_USERQ_MAX_HANDLES     (1U << 16)
> >
> > @@ -528,6 +528,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device
> > *dev, void *data,
> >       /* Create the new fence */
> >       amdgpu_userq_fence_init(queue, fence, wptr);
> >
> > +     trace_amdgpu_userq_job_run(dev->dev, queue, fence);
> > +
> >       mutex_unlock(&userq_mgr->userq_mutex);
> >
> >       /*
> > @@ -701,7 +703,7 @@ amdgpu_userq_wait_add_fence(struct
> > drm_amdgpu_userq_wait *wait_info,  }
> >
> >  static int
> > -amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
> > +amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct
> > +drm_file *filp,
> >                                   struct drm_amdgpu_userq_wait *wait_in=
fo,
> >                                   u32 *syncobj_handles, u32 *timeline_p=
oints,
> >                                   u32 *timeline_handles, @@ -835,6
> > +837,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
> >               goto free_fences;
> >       }
> >
> > +     trace_amdgpu_userq_job_queue(dev->dev, waitq);
> > +
> >       for (i =3D 0, cnt =3D 0; i < num_fences; i++) {
> >               struct amdgpu_userq_fence_driver *fence_drv;
> >               struct amdgpu_userq_fence *userq_fence; @@ -869,6 +873,8
> > @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
> >
> >               amdgpu_userq_fence_driver_get(fence_drv);
> >
> > +             trace_amdgpu_userq_job_add_dep(dev->dev, waitq,
> > + userq_fence);
> > +
> >               /* Store drm syncobj's gpu va address and value */
> >               fence_info[cnt].va =3D fence_drv->va;
> >               fence_info[cnt].value =3D fences[i]->seqno; @@ -968,7
> > +974,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *dat=
a,
> >                                                  gobj_write,
> >                                                  gobj_read);
> >       } else {
> > -             r =3D amdgpu_userq_wait_return_fence_info(filp, wait_info=
,
> > +             r =3D amdgpu_userq_wait_return_fence_info(dev, filp,
> > + wait_info,
> >                                                       syncobj_handles,
> >                                                       timeline_points,
> >
> > timeline_handles,
> > --
> > 2.34.1

