Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB613CD8C8E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 08:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A1710EF1B;
	Mon,  8 Jun 2026 08:27:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yg4Z/TqT";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011015.outbound.protection.outlook.com
 [40.93.194.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90A9310EF1B
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 08:27:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkGxYvTBA7M2otRNjrbFEZ4yF8dNHU/JPBsSK3L97m4LreBzHnqs50z/yd7Mfa0rYfJ4Ntg3ytfni+wMIjbP4x9ULvNcFSDj1c3a9FRiDP4mBqhLpD1e/UcBondLHwZRU4gckOCnWLtN7/aVkjc8CvAtXcYmRxh6fJGs7yCVmZsSNbQYihNV7D7M/Zaug2LJsdXEQAgVXvcuxP9W99JlPiu99X7Vy4VIvDjvwbgsa9C+rso5xl3FOydj/OAAwkOhnBJFMKcIjMjfqI0g3AAubwJVugHEPAuAmpndvceu225XbgabFu2X53MsKl3d69/pOfRbctolVkWSvotMcqUCSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NC5F9kD8p3DgeJQUglMMk/DbE6euEDfNYNqxcnMOqow=;
 b=ZFPC57RqehsEH5q2cejn1bbl7hvF9SrX0TrKA2PN3pt868tSjZdqjl71nzjdw7+1aBRpCllY03XR1kn9VynRgYQvQ5M9uR58PpBbkoE63EeOgaW2PjXjvt82xCAbN6iRCVNPcciYD9u4LTnJobdpfZdmBgK4XDIz5Iw+ItHkWlNmAzYYultAPj1GB7eeq21ug9Gl3B2ExsDzQ3Q1CcHdlQL7gZtdfPNjEHcBRNUG69YS3sNAjKoLMTrxJUukY1VbVnRT6aEzZEkNDMj1Jjc2jJebdicJsDiAGkDMPxevOdwYW4QBQD5HAp6Lcpm7MPlUkJiYYFgCtzpL5+AmZy8heg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC5F9kD8p3DgeJQUglMMk/DbE6euEDfNYNqxcnMOqow=;
 b=yg4Z/TqTyHrEugr9nxMkgNpmb/wU8151WFVcehYI3WqPKz8oiP8Au8YxejcNkFfELIo7IvIOLG0eCOEMHloiuCGbONiAKo4A7iuVRwcNCV+bX4VycpsQwczmkB2uMsbMg4+4US9JuJ8+YSb/vKIX+kqc8qEiPrek7EfZWUPKwPY=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 08:27:03 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:27:03 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: add userq job and state transition trace
 events
Thread-Topic: [PATCH 2/2] drm/amdgpu: add userq job and state transition trace
 events
Thread-Index: AQHc7dMwbTv00Xxo9EymkgLv/hnlcLYk1GCAgAYaPQCACXR4oA==
Date: Mon, 8 Jun 2026 08:27:03 +0000
Message-ID: <DS7PR12MB6005CF500F8E5330B4F2EEFAFB1C2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260527122001.69831-1-Prike.Liang@amd.com>
 <20260527122001.69831-2-Prike.Liang@amd.com>
 <DS7PR12MB6005453059156B25B61CBF15FB162@DS7PR12MB6005.namprd12.prod.outlook.com>
 <DS7PR12MB6005F460B0924D40A58EDC3CFB122@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005F460B0924D40A58EDC3CFB122@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Pierre-eric.Pelloux-prayer@amd.com
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
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA3PR12MB7949:EE_
x-ms-office365-filtering-correlation-id: d93dfb27-aaa1-43ed-face-08dec537b7e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: /0xkdHNPbo0zxExhGtBtAvmQz20xjSWmuUV6MLDgvAlzk5rsVnIvJM95xYmkkepdE9O6Q1aXINpF2Jpta7o/l0WKDEIqDXsikhz1RCqwbEApw6EEyC2B+YOj5sAhPJCSlOZVs6FzNVuoRMpwnyYtHP7gUGQ+EC7NWWIQ9hKtZmoSbMJLGxn1GT37k1xJb0iUG7yhCkWqKnIYOl3Jq18Rg5h+ckYdehh3DYwIuS2JCXqWoSrqLQMDp0IIYa5KFgQNxTtFROnW+Xd4Gst9Xr6h2KfXvkPL1FF/m8np29079HjRXx+PNlX1dPnz2jSYTzqTOenhFlkb6S5yVWIPccSRHX5VRJ5Qn/oO6ymLHY0F+Ubt0ThqWB+6VLBmw+FeVlfSa1cB023cl5FtTYpivZeCQ0HVaZXJ0voshELAHFRlzYOGMqVYI/DKZyU7iuHhF/eRsblWcXd/6P7NT+r7dMvpddp9sWiu6Re3J3lKw+rkGOXUY/vo2vosMq5DzDKDTcxk9hJi/0RvO+zXJeW8bjKW8pB8SkwP8AAHhi6DBXXp7ND66s48CwX7+RPfCm/YbUAhoMwmWGKNvCrDoKxshspk648EJT/oZFdpuHh4tZgqz5q+INo/D2CapjXvQVuukSCS2bkuvB+dcHZ+ILgX9XQ1I1RcIIaih0uyRAruteAv+f5/m1e+4uj0eeURIl6pjasry6ZfL0/IvI6PON9LX//t67x3E0J4CZoa8GHcweDQHsUWweR6w2i/a50NHJK1ClpM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p/vQ9nXvX/oQSVbG8KkeVvZ893I5TdafkBn+U8SNVBisIxYJDaJu2jSnaCo3?=
 =?us-ascii?Q?2CF7fmnZlCxti/VY1FlOBxTOH6WCIgovbUc65CT4FS+I9JPX1BHDMtlULcqh?=
 =?us-ascii?Q?POU1ZWneY0c29NxS6M2dkLGFyjAORh7l+PUxkvUVETdbfztB6mSU+SougT1V?=
 =?us-ascii?Q?OL1Wyg7QX7EP20XwykDDM/eo4W9BK8tYixAn340NX3sJ1YWCe61UpCRu+51C?=
 =?us-ascii?Q?qeXKLSatcdEsx15TjV/pK6a5HOXHvBVIrKQPhwTvk5qAq0o1n6e7QDfRAGKV?=
 =?us-ascii?Q?87IJqmGB7W2ORNpALdUMvqM3a3hNszieJyh3NxOYc5nTUymAEfoRIYrb19i6?=
 =?us-ascii?Q?3JRAPA3sn77g47ORyx4mbvUBtJ1qkP865SH3JNJZZ6wT+6ETUMtza/rPJJ5e?=
 =?us-ascii?Q?oPruFqfQmEw/yVrF304ye3B3IvEpYTTKc7e/fgClL9Yy0/oVTQ+Qe3d4aphh?=
 =?us-ascii?Q?YhfY5n/eVb3wvXS/1G0BBtjSlsQ44gKCptNIf4b34Pd/jV3BocWjcfxv/nl8?=
 =?us-ascii?Q?MZ/nph2+SFML2Nf1vedXaUe3epVGWdp/CO86XF+TKSk1GpystqaKXtTgwhZQ?=
 =?us-ascii?Q?OHhyH//o4+6F3G6McYxpkDeFRFSa+3nb4D7yJ3D7VnShzaXrUyWLMFppwv6s?=
 =?us-ascii?Q?ew3xFj5niEhih7h5Y12EfvYltUdj8VmNq4lI+/h37nq4d3PZQfOzkO4yVkbD?=
 =?us-ascii?Q?lXk3IUgOHug8p7iXz/m+jpRxbeAd7Kmi6KbzVxuMp9VVOMrsz1gRDguBj40y?=
 =?us-ascii?Q?KIt5dKe5n3eqws/TtvdCk0ySE6RNY0z5EdeDTxh1C/aGWwooWrGBixtSAKii?=
 =?us-ascii?Q?ElPHjnp4cS6ofAkfqVX8o7cORvUlovquOMoRnAYrorGYsrLOWfL7DH3E+BNF?=
 =?us-ascii?Q?qGMxFz5Yrj9FRQWCO2NsZuNK4Mx/XeBp8SCnCdDsbc8iVGXc1SNMYzS0FwLS?=
 =?us-ascii?Q?gGFhw6g+AUJqF3taiMh4TqWOCUwYgrh0dvbdZtARLQMo5TXCOgNwdH34GC+D?=
 =?us-ascii?Q?MJ/k0ck1bPukISutUU6R5D1ZbzH2L4+ZG0Wyz6OqsV+71VbvnNOrqZKgjS4s?=
 =?us-ascii?Q?8B2H00RYFp2uaQ/eAVyjEDDmspTpbm0651pLzON/OM6CfqpfyWdn7hfylsJ6?=
 =?us-ascii?Q?wXNebKe/f/qI7xRGUlwfHFhweWMjSfYOxXxrQj+4Zn3gISfxjkX+qs+cYuFS?=
 =?us-ascii?Q?3DAeMnPrdC/TRpUSP4aemDSdt9951lwkTqU3oTujftG1dhBvsFeRFCvayVPl?=
 =?us-ascii?Q?9S8QySMoHVQAXLWNfRZu+UQnrNEUuWlnnn+XKs+3AQ07HvjFJWnl0ltPQ72u?=
 =?us-ascii?Q?JYmr+LVJqohw4XKNS9DpuhhxMsHCtdPX0yatTM9/7DhCDnL/j5baK2MVYYni?=
 =?us-ascii?Q?jJagsWVpgAzV48lOCOlx6zToe86dnXSb3iu273QnaP1T9rX/mX1i6z/KO68i?=
 =?us-ascii?Q?xyy1YH7VQASBUXk3W38W7NVMp2O2ZEe4YmokchM2j+7zljjCy/Pfke//27cR?=
 =?us-ascii?Q?R/Y+ZIKxNkm7Xpgak08xNKRevGqGKdN5NE9KNsZlEZJyOpGeBRfs22T8WLGW?=
 =?us-ascii?Q?JnHXu+NIzHsWUw0NIU8ZAODDJ0HSg+MUD0hQd3HeqX2ngb248xUOZ47cKOLA?=
 =?us-ascii?Q?f4iUzDjjVgCyO36oBtH95/6w8U8A3jPDRmIJAEUkDqbX7nX2e6qJnTcNQ/qI?=
 =?us-ascii?Q?SBPhrKTfw9+cbp2UmfFRmuXZ8+rL/TEm3xni6bk771YhjKex?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93dfb27-aaa1-43ed-face-08dec537b7e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 08:27:03.1789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0dt5q1yv3MNCEbjQKwSrB55RySA2BzNf0t24S1pGUp067yY63pl/VEODbEnCs29
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949
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

Hi @Pelloux-Prayer, Pierre-Eric   Could you check whether this version meet=
s the UMR tool profiling objectives, or is anything missing?

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike
> Sent: Tuesday, June 2, 2026 4:00 PM
> To: 'Liang, Prike' <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pell=
oux-
> prayer@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-
> prayer@amd.com>
> Subject: RE: [PATCH 2/2] drm/amdgpu: add userq job and state transition t=
race
> events
>
>
> These patch sets can be beneficial for profiling userq state transitions =
and latency.
>
> Ping on this series.
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Liang, Prike
> > Sent: Friday, May 29, 2026 8:49 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pelloux-Prayer, Pierre-Eric
> > <Pierre-eric.Pelloux- prayer@amd.com>; Pelloux-Prayer, Pierre-Eric
> > <Pierre-eric.Pelloux- prayer@amd.com>
> > Subject: RE: [PATCH 2/2] drm/amdgpu: add userq job and state
> > transition trace events
> >
> > AMD General
> >
> > Ping
> >
> > Regards,
> >       Prike
> >
> > > -----Original Message-----
> > > From: Liang, Prike <Prike.Liang@amd.com>
> > > Sent: Wednesday, May 27, 2026 8:20 PM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > Christian <Christian.Koenig@amd.com>; Pelloux-Prayer, Pierre-Eric
> > > <Pierre-eric.Pelloux- prayer@amd.com>; Pelloux-Prayer, Pierre-Eric
> > > <Pierre-eric.Pelloux- prayer@amd.com>; Liang, Prike
> > > <Prike.Liang@amd.com>
> > > Subject: [PATCH 2/2] drm/amdgpu: add userq job and state transition
> > > trace events
> > >
> > > From: Pierre-Eric Pelloux-Prayer
> > > <pierre-eric.pelloux-prayer@amd.com>
> > >
> > > Add ftrace events for tracking the userq fence emit, signal and
> > > queue state
> > transition.
> > >
> > > Signed-off-by: Pierre-Eric Pelloux-Prayer
> > > <pierre-eric.pelloux-prayer@amd.com>
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 113 ++++++++++++++++=
++
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  21 ++++
> > >  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  12 +-
> > >  3 files changed, 143 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> > > index df98be22f1f5..ef6a1fb82ff3 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> > > @@ -28,6 +28,8 @@
> > >  #include <linux/types.h>
> > >  #include <linux/tracepoint.h>
> > >
> > > +#include "amdgpu_userq_fence.h"
> > > +
> > >  #undef TRACE_SYSTEM
> > >  #define TRACE_SYSTEM amdgpu
> > >  #define TRACE_INCLUDE_FILE amdgpu_trace @@ -636,6 +638,117 @@
> > > DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
> > >            TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
> > >            TP_ARGS(queue, result));
> > >
> > > +TRACE_EVENT(amdgpu_userq_job_run,
> > > +         TP_PROTO(struct device *device, struct
> > > +amdgpu_usermode_queue
> > > *queue, struct amdgpu_userq_fence *fence),
> > > +         TP_ARGS(device, queue, fence),
> > > +         TP_STRUCT__entry(
> > > +                          __field(u64, fence_context)
> > > +                          __field(u64, fence_seqno)
> > > +                          __string(dev, dev_name(device))
> > > +                          __field(u64, doorbell_index)
> > > +                          __field(u64, client_id)
> > > +                          __field(u32, queue_type)
> > > +                          ),
> > > +         TP_fast_assign(
> > > +                        __entry->fence_context =3D fence->base.conte=
xt;
> > > +                        __entry->fence_seqno =3D fence->base.seqno;
> > > +                        __assign_str(dev);
> > > +                        __entry->doorbell_index =3D queue->doorbell_=
index;
> > > +                        __entry->client_id =3D queue->userq_mgr->fil=
e->client_id;
> > > +                        __entry->queue_type =3D queue->queue_type;
> > > +                        ),
> > > +         TP_printk("dev=3D%s, client_id=3D%llu, type=3D%u, doorbell=
=3D%llu,
> > > fence=3D%llu:%llu",
> > > +                   __get_str(dev), __entry->client_id,
> > > + __entry->queue_type, __entry-
> > > >doorbell_index,
> > > +                   __entry->fence_context,
> > > +                   __entry->fence_seqno) );
> > > +
> > > +TRACE_EVENT(amdgpu_userq_job_queue,
> > > +         TP_PROTO(struct device *device,
> > > +                  struct amdgpu_usermode_queue *queue),
> > > +         TP_ARGS(device, queue),
> > > +         TP_STRUCT__entry(__field(u64, context)
> > > +                          __string(dev, dev_name(device))
> > > +                          __field(u64, doorbell_index)
> > > +                          __field(u64, client_id)
> > > +                          __field(u32, queue_type)
> > > +                          ),
> > > +         TP_fast_assign(__assign_str(dev);
> > > +                        __entry->doorbell_index =3D queue->doorbell_=
index;
> > > +                        __entry->queue_type =3D queue->queue_type;
> > > +                        __entry->client_id =3D queue->userq_mgr->fil=
e->client_id;
> > > +                        __entry->context =3D queue->fence_drv->conte=
xt;
> > > +                       ),
> > > +         TP_printk("dev=3D%s, client_id=3D%llu, type=3D%u, doorbell=
=3D%llu,
> > > context=3D%llu",
> > > +                   __get_str(dev), __entry->client_id, __entry->queu=
e_type,
> > > +                   __entry->doorbell_index, __entry->context) );
> > > +
> > > +TRACE_EVENT(amdgpu_userq_job_add_dep,
> > > +         TP_PROTO(struct device *device, struct
> > > +amdgpu_usermode_queue
> > > *queue, struct amdgpu_userq_fence *dep),
> > > +         TP_ARGS(device, queue, dep),
> > > +         TP_STRUCT__entry(
> > > +                          __field(u64, context)
> > > +                          __field(u64, dep_context)
> > > +                          __field(u64, dep_seqno)
> > > +                          __string(dev, dev_name(device))
> > > +                          __field(u64, doorbell_index)
> > > +                          __field(u64, client_id)
> > > +                          __field(u32, queue_type)
> > > +                          ),
> > > +         TP_fast_assign(
> > > +                        __assign_str(dev);
> > > +                        __entry->doorbell_index =3D queue->doorbell_=
index;
> > > +                        __entry->queue_type =3D queue->queue_type;
> > > +                        __entry->client_id =3D queue->userq_mgr->fil=
e->client_id;
> > > +                        __entry->context =3D queue->fence_drv->conte=
xt;
> > > +                        __entry->dep_context =3D dep->base.context;
> > > +                        __entry->dep_seqno =3D dep->base.seqno;
> > > +                        ),
> > > +         TP_printk("dev=3D%s, client_id=3D%llu, type=3D%u, doorbell=
=3D%llu,
> > > + context=3D%llu
> > > depends on fence=3D%llu:%llu",
> > > +                   __get_str(dev), __entry->client_id,
> > > + __entry->queue_type, __entry-
> > > >doorbell_index, __entry->context,
> > > +                   __entry->dep_context,
> > > +                   __entry->dep_seqno) );
> > > +
> > > +TRACE_EVENT(amdgpu_userq_state_start,
> > > +         TP_PROTO(struct amdgpu_usermode_queue *queue),
> > > +         TP_ARGS(queue),
> > > +         TP_STRUCT__entry(
> > > +                          __field(u64, doorbell_index)
> > > +                          __field(u64, client_id)
> > > +                          __field(u32, queue_type)
> > > +                          __field(u32, from)
> > > +                          ),
> > > +         TP_fast_assign(
> > > +                        __entry->doorbell_index =3D queue->doorbell_=
index;
> > > +                        __entry->queue_type =3D queue->queue_type;
> > > +                        __entry->client_id =3D queue->userq_mgr->fil=
e->client_id;
> > > +                        __entry->from =3D queue->state;
> > > +                        ),
> > > +         TP_printk("client_id=3D%llu, type=3D%u, doorbell=3D%llu, fr=
om=3D%d",
> > > +                   __entry->client_id, __entry->queue_type,
> > > +__entry->doorbell_index, __entry->from) );
> > > +
> > > +TRACE_EVENT(amdgpu_userq_state_changed,
> > > +         TP_PROTO(struct amdgpu_usermode_queue *queue, enum
> > > amdgpu_userq_state new_state),
> > > +         TP_ARGS(queue, new_state),
> > > +         TP_STRUCT__entry(
> > > +                          __field(u64, doorbell_index)
> > > +                          __field(u64, client_id)
> > > +                          __field(u32, queue_type)
> > > +                          __field(u32, to)
> > > +                          ),
> > > +         TP_fast_assign(
> > > +                        __entry->doorbell_index =3D queue->doorbell_=
index;
> > > +                        __entry->queue_type =3D queue->queue_type;
> > > +                        __entry->client_id =3D queue->userq_mgr->fil=
e->client_id;
> > > +                        __entry->to =3D new_state;
> > > +                        ),
> > > +         TP_printk("client_id=3D%llu, type=3D%u, doorbell=3D%llu, to=
=3D%d",
> > > +                   __entry->client_id, __entry->queue_type,
> > > +__entry->doorbell_index, __entry->to) );
> > > +
> > >  #undef AMDGPU_JOB_GET_TIMELINE_NAME  #endif
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > index 9dc6cb579ac7..536e73c7e9ef 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > @@ -296,11 +296,15 @@ static int amdgpu_userq_preempt_helper(struct
> > > amdgpu_usermode_queue *queue)
> > >       int r;
> > >
> > >       if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) {
> > > +             trace_amdgpu_userq_state_start(queue);
> > > +
> > >               r =3D userq_funcs->preempt(queue);
> > >               if (r) {
> > > +                     trace_amdgpu_userq_state_changed(queue,
> > > AMDGPU_USERQ_STATE_HUNG);
> > >                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> > >                       return r;
> > >               } else {
> > > +                     trace_amdgpu_userq_state_changed(queue,
> > > +AMDGPU_USERQ_STATE_PREEMPTED);
> > >                       queue->state =3D AMDGPU_USERQ_STATE_PREEMPTED;
> > >               }
> > >       }
> > > @@ -316,10 +320,14 @@ static int amdgpu_userq_restore_helper(struct
> > > amdgpu_usermode_queue *queue)
> > >       int r =3D 0;
> > >
> > >       if (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED) {
> > > +             trace_amdgpu_userq_state_start(queue);
> > > +
> > >               r =3D userq_funcs->restore(queue);
> > >               if (r) {
> > > +                     trace_amdgpu_userq_state_changed(queue,
> > > AMDGPU_USERQ_STATE_HUNG);
> > >                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> > >               } else {
> > > +                     trace_amdgpu_userq_state_changed(queue,
> > > AMDGPU_USERQ_STATE_MAPPED);
> > >                       queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
> > >               }
> > >       }
> > > @@ -337,12 +345,15 @@ static int amdgpu_userq_unmap_helper(struct
> > > amdgpu_usermode_queue *queue)
> > >
> > >       if ((queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) ||
> > >           (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED)) {
> > > +             trace_amdgpu_userq_state_start(queue);
> > >
> > >               r =3D userq_funcs->unmap(queue);
> > >               if (r) {
> > > +                     trace_amdgpu_userq_state_changed(queue,
> > > AMDGPU_USERQ_STATE_HUNG);
> > >                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> > >                       return r;
> > >               } else {
> > > +                     trace_amdgpu_userq_state_changed(queue,
> > > +AMDGPU_USERQ_STATE_UNMAPPED);
> > >                       queue->state =3D AMDGPU_USERQ_STATE_UNMAPPED;
> > >               }
> > >       }
> > > @@ -359,11 +370,15 @@ static int amdgpu_userq_map_helper(struct
> > > amdgpu_usermode_queue *queue)
> > >       int r;
> > >
> > >       if (queue->state =3D=3D AMDGPU_USERQ_STATE_UNMAPPED) {
> > > +             trace_amdgpu_userq_state_start(queue);
> > > +
> > >               r =3D userq_funcs->map(queue);
> > >               if (r) {
> > > +                     trace_amdgpu_userq_state_changed(queue,
> > > AMDGPU_USERQ_STATE_HUNG);
> > >                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> > >                       return r;
> > >               } else {
> > > +                     trace_amdgpu_userq_state_changed(queue,
> > > AMDGPU_USERQ_STATE_MAPPED);
> > >                       queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
> > >               }
> > >       }
> > > @@ -894,6 +909,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr
> > > *uq_mgr)
> > >               if (!amdgpu_userq_buffer_vas_mapped(queue)) {
> > >                       drm_file_err(uq_mgr->file,
> > >                                    "trying restore queue without va
> > > mapping\n");
> > > +                     trace_amdgpu_userq_state_changed(queue,
> > > +AMDGPU_USERQ_STATE_INVALID_VA);
> > >                       queue->state =3D AMDGPU_USERQ_STATE_INVALID_VA;
> > >                       continue;
> > >               }
> > > @@ -1389,12 +1405,14 @@ void amdgpu_userq_pre_reset(struct
> > > amdgpu_device
> > > *adev)
> > >               if (queue->state !=3D AMDGPU_USERQ_STATE_MAPPED)
> > >                       continue;
> > >
> > > +             trace_amdgpu_userq_state_start(queue);
> > >               userq_funcs =3D adev->userq_funcs[queue->queue_type];
> > >               userq_funcs->unmap(queue);
> > >               /* just mark all queues as hung at this point.
> > >                * if unmap succeeds, we could map again
> > >                * in amdgpu_userq_post_reset() if vram is not lost
> > >                */
> > > +             trace_amdgpu_userq_state_changed(queue,
> > > AMDGPU_USERQ_STATE_HUNG);
> > >               queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> > >               amdgpu_userq_fence_driver_force_completion(queue);
> > >       }
> > > @@ -1413,6 +1431,8 @@ int amdgpu_userq_post_reset(struct
> > > amdgpu_device *adev, bool vram_lost)
> > >
> > >       xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> > >               if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG &&
> > > !vram_lost) {
> > > +                     trace_amdgpu_userq_state_start(queue);
> > > +
> > >                       userq_funcs =3D adev->userq_funcs[queue->queue_=
type];
> > >                       /* Re-map queue */
> > >                       r =3D userq_funcs->map(queue); @@ -1420,6
> > > +1440,7 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev,
> > > bool
> > > vram_lost)
> > >                               dev_err(adev->dev, "Failed to remap
> > > queue %ld\n", queue_id);
> > >                               continue;
> > >                       }
> > > +                     trace_amdgpu_userq_state_changed(queue,
> > > AMDGPU_USERQ_STATE_MAPPED);
> > >                       queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
> > >               }
> > >       }
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > > index 008330a0d852..6071e83acd9e 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > > @@ -30,7 +30,7 @@
> > >  #include <drm/drm_syncobj.h>
> > >
> > >  #include "amdgpu.h"
> > > -#include "amdgpu_userq_fence.h"
> > > +#include "amdgpu_trace.h"
> > >
> > >  #define AMDGPU_USERQ_MAX_HANDLES     (1U << 16)
> > >
> > > @@ -528,6 +528,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device
> > > *dev, void *data,
> > >       /* Create the new fence */
> > >       amdgpu_userq_fence_init(queue, fence, wptr);
> > >
> > > +     trace_amdgpu_userq_job_run(dev->dev, queue, fence);
> > > +
> > >       mutex_unlock(&userq_mgr->userq_mutex);
> > >
> > >       /*
> > > @@ -701,7 +703,7 @@ amdgpu_userq_wait_add_fence(struct
> > > drm_amdgpu_userq_wait *wait_info,  }
> > >
> > >  static int
> > > -amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
> > > +amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct
> > > +drm_file *filp,
> > >                                   struct drm_amdgpu_userq_wait *wait_=
info,
> > >                                   u32 *syncobj_handles, u32 *timeline=
_points,
> > >                                   u32 *timeline_handles, @@ -835,6
> > > +837,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
> > >               goto free_fences;
> > >       }
> > >
> > > +     trace_amdgpu_userq_job_queue(dev->dev, waitq);
> > > +
> > >       for (i =3D 0, cnt =3D 0; i < num_fences; i++) {
> > >               struct amdgpu_userq_fence_driver *fence_drv;
> > >               struct amdgpu_userq_fence *userq_fence; @@ -869,6
> > > +873,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
> > >
> > >               amdgpu_userq_fence_driver_get(fence_drv);
> > >
> > > +             trace_amdgpu_userq_job_add_dep(dev->dev, waitq,
> > > + userq_fence);
> > > +
> > >               /* Store drm syncobj's gpu va address and value */
> > >               fence_info[cnt].va =3D fence_drv->va;
> > >               fence_info[cnt].value =3D fences[i]->seqno; @@ -968,7
> > > +974,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void
> > > +*data,
> > >                                                  gobj_write,
> > >                                                  gobj_read);
> > >       } else {
> > > -             r =3D amdgpu_userq_wait_return_fence_info(filp, wait_in=
fo,
> > > +             r =3D amdgpu_userq_wait_return_fence_info(dev, filp,
> > > + wait_info,
> > >                                                       syncobj_handles=
,
> > >
> > > timeline_points,
> > >
> > > timeline_handles,
> > > --
> > > 2.34.1

