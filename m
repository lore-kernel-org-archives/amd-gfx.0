Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55B9CD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 03:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60ABF10EA38;
	Tue, 19 May 2026 03:39:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="th21lRa/";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010033.outbound.protection.outlook.com
 [40.93.198.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A7810EA38
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVmkMKR68SNvMZpXy9bxnmJQkM9qvn9pVSkEVw4ZX9nSolIunIlYOgUFwzMfpz8Dgh6cZTI4zGhCmkwWoZ6rz1J7AULSTzGxhPc6nBjlUnePKgCtb4w0Ca0u0uIE/mLsR7YPU/PSbthbhB7XLTFuaEVSBVstdV6V87DTAMyQZr7bH53W6i7Uyna7WRqlh+6+c6D12L4Xv2X1WPvOvPr9XyfqzB3wjqX6n6GN9ApeEPtivC+ht+kv8w5QiyjRoXBTovjZsby3OTQJzmuRSYQvIgNIRmyiEjT6qCFd79LAZPGVlvEEFR57A0qthhv7h5giiUVPLs90SDNJiYG+FL6o7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Yi0pZlKUXnML0bnTRDQcEWW8i1E5sw3JoIJyqtuK0s=;
 b=iJqEONKcqnM5Gh4rlWCNLbUTw2+6W6EmsaZPIw2dZyQmkBlfr7zaABC2OAA62UD04v+/1fZr61wZIUO8tBSlgf+Ie3BIhJ+BZIhq/7nVW2o8CnjHbk4M5BKnQRlJgGS2GXsU/Spl9yWMbbvCGXl4MCSO60GN8hmiJp4GlK6R5xXwX1P2Rvc/DaA1ajcEPnkUMWBYiIw41g1pk4wC5WRfILvkfDy5Gb8Uy7uOGDxRI9udsUhwLy8jakzWyjXc4PgQ5JKFDmGmk5kXygyAi8BwhyU4C2KX7eor9Oxm1ye5lf+ze55ootaScfu+H/p4HskeCI1tJNj/YZBzjrQBnexthQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Yi0pZlKUXnML0bnTRDQcEWW8i1E5sw3JoIJyqtuK0s=;
 b=th21lRa/86BGg6Ilad8FlaTaG3i6hMX0G1XhLTF8onZaln58CwjSGEsWji13tpPgFQrK3rRmI0jRJXO8Aa1fYJ53ZFEvCSeDEV/1ktho3D7OeClmn4KGf46NbdQCht592VDlEe5FjvrUux5JFMsPn+mhktG69ptxv7sfLi2I20Q=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Tue, 19 May
 2026 03:39:30 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 03:39:29 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH 6/7] drm/amd/ras: copy ras log data instead of referencing
 pointers
Thread-Topic: [PATCH 6/7] drm/amd/ras: copy ras log data instead of
 referencing pointers
Thread-Index: AQHc5pc5RQ7JftIsuU2q9hy/t9cUTrYUrETggAAD84CAAAQzsA==
Date: Tue, 19 May 2026 03:39:29 +0000
Message-ID: <PH7PR12MB8796ACC0BAB1F04719F84303B0002@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260518072215.3647120-1-YiPeng.Chai@amd.com>
 <20260518072215.3647120-6-YiPeng.Chai@amd.com>
 <PH7PR12MB87962CC258600331D6D9CBD0B0002@PH7PR12MB8796.namprd12.prod.outlook.com>
 <BN9PR12MB53068862BFAFBACC4F971A36FC002@BN9PR12MB5306.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB53068862BFAFBACC4F971A36FC002@BN9PR12MB5306.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-19T03:08:11.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA1PR12MB8334:EE_
x-ms-office365-filtering-correlation-id: bfe8b207-d985-4071-d0c2-08deb5583bd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|3023799003|22082099003|18002099003|56012099003|11063799003|4143699003|38070700021;
x-microsoft-antispam-message-info: kpdE/1RhxyQcScEVi74Xu5fQA7/dpnHDlwMLIMzgTjErrJ5oekDWSA/sxS/dQx/O8WFnrGfAxsnzUzBoUXM/2RMhadBZ10FfhMBAxWa1Yxvlk5mG012Xd8hex2rbHQrtYGov66I7YCYw08pBkSftEghGpz+oduCSJPuPBMEbTQtvDRMalAD+4+F5i22BFYlhJscYxFDR+Qh4CH8Rm6TjfR0DiRXqn8KjKwTf0DoUQQNjV+wCBVr4ciWhjurjaj6+KUnrVGv8BctATgBMLaEzEj9G+HNvB5sYi59/MxPm7ldA71GiWlKDwqgpDlfnFpBEh8t5i8mjVjPVjmmtT0LXutXfEkGFnhlzYZWZqOJWeXKQUPR6ynhqGxS4f6j0l6gLz9o5xjjj+Y/XeTL+dR6CcHuCM4bVNd3VE4wSNpJ46/AQRLIE+rg2BReetfhXOPabIUl7r4KYMq4M3fFKYNB1IICMZ+ro/EAxWQGrsJ7tKxIyHMHh9pAqsZnZzHiQkznEl2ua7Syo6zrE72NTCpGnbiMDYdCmZZ2Wuvgg+oGjthwo8eoxPTm0J3BRbaa3rX4Re5u6WgUcQqCkU2XIEwnDg4lGBliQaghvg6ylU7ddUQuPP7EgU8EJFwNSUtTyAjvKi0N+dwpouGqUY5xNjj1qVaXzx2w0/EqX7PQu7KG8SSOty1FNQs8qqDt7CE4GXrPmOk8zjT0pEoXqdnU2AuH8GFsLgt2ycVDmLM7eFkH6n94feKcrYqFCkPlvS94ssbNT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(3023799003)(22082099003)(18002099003)(56012099003)(11063799003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MWprIVLmkH4ihVbvPoMshN2HGcERsu7PZHp+88ss5shVvT5L7G4ie89QVCrE?=
 =?us-ascii?Q?ZibfOaR+OdCtJSQhlU4uDqUftCkdvigVjeo/AYfGaVbUhWGAHlg4Z95SYBmW?=
 =?us-ascii?Q?VLY7/NV3TtrvoQhzL8ZcFrf+xMpwk7qxTfMV7tAQGAgEydwzt8QsILUX/8Ai?=
 =?us-ascii?Q?6V/t+qESyNFFo4FDDGh1NolDdacmjy0nqNql1VTqvt3Zux6UrRHXCqfCM/Qw?=
 =?us-ascii?Q?Bvpz5LccpBRxNaarBCTK/uzPCVL6rtDXQb2hL822o8XpkvKnAy48+9Ji4PJl?=
 =?us-ascii?Q?/bew23XMFoRUAy9NNjsg7iyu5mef6WxmyrFOsr8sjfvD6LtVzejhBhzpqCLH?=
 =?us-ascii?Q?u/PFD3sIhre9odWClqi9Z0o4eIxKfeTcfV8t/CgW2YN748MUdbiwrs+tZtei?=
 =?us-ascii?Q?XbWH0PfIi4VoYeYTj0T0EWvpnGVxnhirTErx92FBosTtY8BPr7p4dxj0OcA9?=
 =?us-ascii?Q?DMV249CqNY+FZCFK0mK1JPffCVzpSBOKc4zc/XfFRVW7qCR5hnnY6lKvvyWL?=
 =?us-ascii?Q?x2isuuJ2/y50alAXrcaUNDuXcSGWBswmCUDOM6sUublamrgA9Z2IsBA4OafG?=
 =?us-ascii?Q?JgqFO38/Z9TrH5qDPmbw7qdJpQQatt15tFjQxYG690s7Od6esMfo6tuxM92C?=
 =?us-ascii?Q?Vg62uB2J0tzILDQhxsteSIiX22hJXYOGNZyaDCoXxXnt+V7Z37vjID2cmL+5?=
 =?us-ascii?Q?WtMwI2Sgba50ASMIpvHCUMz7jc4+vZQecNkBKdR0cEomIvMIw3vCuv69Iaop?=
 =?us-ascii?Q?PSDVooabjt5VSxxMt7pZ6q/4gXHTHCQOFhnJ6WKKYSo1+NbUBBSN2s1CmHYn?=
 =?us-ascii?Q?bTw6lCqcAUGNKzvxru5FxEu3vA3daA0OP2zWqGFCINm/tdbjsb+wVB6p3lJk?=
 =?us-ascii?Q?crujGWKSVcnxfSFqE7FOcCNlPWzQBLooR/wHhD6MsPaJ07j3JqZRYi0qaCP6?=
 =?us-ascii?Q?LQyRkawYBsVHJA/gw3hqB/bxyPPudGubAOYhv4coJu4CjlRYoIZ6b4gJJdGH?=
 =?us-ascii?Q?bZvSUtXSbvGkx+JoWz7e4gVheW7e/BnALj0O9Kc9Dd0PeccVrZzbiaVcwlAP?=
 =?us-ascii?Q?4l4pQUQ+Ie7gszjpKvoHjWjRRWA8f/ZmHLtpOb970jK3DZ9n7RB9SofC0UYX?=
 =?us-ascii?Q?PM+yBKIiOfqr6thBsyJDQSHJ3+s/z2CP4Bmw949/l5NZYRM301oy6W7MF+C8?=
 =?us-ascii?Q?Bj6LNKRRpTqIS3+RBrAFDhn3gRi/W1xr5rsIkQtjmoZMAfe2isv2PGua8vi+?=
 =?us-ascii?Q?zhLw1FuoS2N1aRZhnYlQUzddMc82S7GB8AqQ0tFs5cvgDd7gVxtccUyjFmhq?=
 =?us-ascii?Q?0Z4hXQR/sxwdxElRC9OaCn56PFiw9lYgngzIsVxZ3LJyASdVfkl4VrANRRqJ?=
 =?us-ascii?Q?8bEM+LQrYnqsFaneO8izMpa7Z1tXOwV9FG2AZD3zG9CwTVcDm0nozhsQiQUB?=
 =?us-ascii?Q?bsHnxSE68Es0gvOog8tivQkh7psYDIdL5prqgNTA+6rHL652O4zYectjqQaE?=
 =?us-ascii?Q?A5iBuogal1+zHGfLUPBo4FpFVK51dMF3as3T+JyaPjA3SDBHu7mwGx29khn6?=
 =?us-ascii?Q?T8VHYAiy8OTBR+5RN+nLG0wTUYIwgpLHkeZZCyosIW5rkJ90hZoc+k62ovYD?=
 =?us-ascii?Q?nWs/BD2VJpm9xvuvUPcwO3QgZARPRhlD2uTkeSzY+KB7PORwS3dV7s+X6/Fe?=
 =?us-ascii?Q?pqRcAylydZ8eqwomU0EHrc1Hc676VYKNvRfnNhQoZj6D9aKb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe8b207-d985-4071-d0c2-08deb5583bd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 03:39:29.8068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+h2oVC2aBvITexKfIJy73dlcNWwDdIZ/vIRhovxa6vpxCBblGuWq16r39LLbsln
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334
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

Got it. With my concern in patch #7 fixed, the series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Tuesday, May 19, 2026 11:22 AM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>
> Subject: RE: [PATCH 6/7] drm/amd/ras: copy ras log data instead of
> referencing pointers
>
> AMD General
>
> The current patch is to fix a potential invalid pointer access issue.  Th=
e issues
> of simplification and naming consistency can be addressed in subsequent
> patches.
>
>
> Best Regards,
> Thomas
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Tuesday, May 19, 2026 11:11 AM
> To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>
> Subject: RE: [PATCH 6/7] drm/amd/ras: copy ras log data instead of
> referencing pointers
>
> AMD General
>
> [Tao] The buffer has three different names in this patch: trace, trace_ar=
r,
> trace_arry, can we simplify it?
>
> > -----Original Message-----
> > From: Chai, Thomas <YiPeng.Chai@amd.com>
> > Sent: Monday, May 18, 2026 3:22 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley
> > <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> > Subject: [PATCH 6/7] drm/amd/ras: copy ras log data instead of
> > referencing pointers
> >
> > When generating ras cper file, the original data nodes in the ras log
> > ring buffer may be deleted, leading to invalid pointer access. Copy
> > the data from the ras log ring instead of directly referencing the poin=
ters to
> avoid this issue.
> >
> > Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> > ---
> >  .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 12 +++---
> >  drivers/gpu/drm/amd/ras/rascore/ras_cmd.c     | 42 +++++++++++++------
> >  drivers/gpu/drm/amd/ras/rascore/ras_cper.c    | 20 ++++-----
> >  drivers/gpu/drm/amd/ras/rascore/ras_cper.h    |  2 +-
> >  .../gpu/drm/amd/ras/rascore/ras_log_ring.c    | 23 +++++-----
> >  .../gpu/drm/amd/ras/rascore/ras_log_ring.h    |  2 +-
> >  6 files changed, 58 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> > b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> > index b8e9442b2ca5..537f709d8570 100644
> > --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> > +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> > @@ -219,7 +219,7 @@ static bool
> > amdgpu_virt_ras_check_batch_cached(struct
> ras_cmd_batch_trace_record }
> >
> >  static int amdgpu_virt_ras_get_batch_records(struct ras_core_context
> > *ras_core, uint64_t batch_id,
> > -                     struct ras_log_info **trace_arr, uint32_t arr_num=
,
> > +                     struct ras_log_info *trace_arr, uint32_t
> > + arr_num,
> >                       struct ras_cmd_batch_trace_record_rsp *rsp_cache)=
  {
> >       struct ras_cmd_batch_trace_record_req req =3D { @@ -255,7 +255,8
> > @@ static int amdgpu_virt_ras_get_batch_records(struct
> > ras_core_context *ras_core,
> >       }
> >
> >       for (i =3D 0; i < batch->trace_num && i < arr_num; i++)
> > -             trace_arr[i] =3D &rsp->records[batch->offset + i];
> > +             memcpy(&trace_arr[i],
> > +                     &rsp->records[batch->offset + i],
> > + sizeof(*trace_arr));
> >
> >       return i;
> >  }
> > @@ -272,7 +273,8 @@ static int amdgpu_virt_ras_get_cper_records(struct
> > ras_core_context *ras_core,
> >               (struct ras_cmd_cper_record_rsp *)cmd->output_buff_raw;
> >       struct ras_log_batch_overview *overview =3D &virt_ras-
> > >batch_mgr.batch_overview;
> >       struct ras_cmd_batch_trace_record_rsp *rsp_cache =3D &virt_ras-
> > >batch_mgr.batch_trace;
> > -     struct ras_log_info **trace;
> > +     struct ras_log_info *trace;
> > +     uint32_t trace_count =3D MAX_RECORD_PER_BATCH;
> >       uint32_t offset =3D 0, real_data_len =3D 0;
> >       uint64_t batch_id;
> >       uint8_t *out_buf;
> > @@ -289,7 +291,7 @@ static int amdgpu_virt_ras_get_cper_records(struct
> > ras_core_context *ras_core,
> >           req->cper_num > RAS_CMD_MAX_CPER_FETCH_NUM)
> >               return RAS_CMD__ERROR_INVALID_INPUT_DATA;
> >
> > -     trace =3D kcalloc(MAX_RECORD_PER_BATCH, sizeof(*trace),
> > GFP_KERNEL);
> > +     trace =3D kcalloc(trace_count, sizeof(*trace), GFP_KERNEL);
> >       if (!trace)
> >               return RAS_CMD__ERROR_GENERIC;
> >
> > @@ -306,7 +308,7 @@ static int amdgpu_virt_ras_get_cper_records(struct
> > ras_core_context *ras_core,
> >               if (batch_id >=3D overview->last_batch_id)
> >                       break;
> >               count =3D amdgpu_virt_ras_get_batch_records(ras_core,
> > batch_id,
> > -                                                       trace,
> > MAX_RECORD_PER_BATCH,
> > +                                                       trace,
> > + trace_count,
> >                                                         rsp_cache);
> >               if (count > 0) {
> >                       ret =3D ras_cper_generate_cper(ras_core, trace,
> > count, diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
> > b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
> > index 5b7a36596b02..088b9b153f7f 100644
> > --- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
> > +++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
> > @@ -202,11 +202,12 @@ static int ras_cmd_get_cper_records(struct
> > ras_core_context *ras_core,
> >                       (struct ras_cmd_cper_record_req *)cmd-
> > >input_buff_raw;
> >       struct ras_cmd_cper_record_rsp *rsp =3D
> >                       (struct ras_cmd_cper_record_rsp *)cmd-
> > >output_buff_raw;
> > -     struct ras_log_info *trace[MAX_RECORD_PER_BATCH] =3D {0};
> > +     struct ras_log_info *trace =3D NULL;
> > +     uint32_t trace_count =3D MAX_RECORD_PER_BATCH;
> >       struct ras_log_batch_overview overview;
> >       uint32_t offset =3D 0, real_data_len =3D 0;
> >       uint64_t batch_id;
> > -     uint8_t *buffer;
> > +     uint8_t *buffer =3D NULL;
> >       int ret =3D 0, i, count;
> >
> >       if ((cmd->input_size !=3D sizeof(struct ras_cmd_cper_record_req))
> > || @@ -224,6 +225,12 @@ static int ras_cmd_get_cper_records(struct
> > ras_core_context *ras_core,
> >       if (!buffer)
> >               return RAS_CMD__ERROR_GENERIC;
> >
> > +     trace =3D kcalloc(trace_count, sizeof(*trace), GFP_KERNEL);
> > +     if (!trace) {
> > +             ret =3D RAS_CMD__ERROR_GENERIC;
> > +             goto out;
> > +     }
> > +
> >       ras_log_ring_get_batch_overview(ras_core, &overview);
> >       for (i =3D 0; i < req->cper_num; i++) {
> >               batch_id =3D req->cper_start_id + i; @@ -231,7 +238,7 @@
> > static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
> >                       break;
> >
> >               count =3D ras_log_ring_get_batch_records(ras_core,
> > batch_id, trace,
> > -                                     ARRAY_SIZE(trace));
> > +                                     trace_count);
> >               if (count > 0) {
> >                       ret =3D ras_cper_generate_cper(ras_core, trace, c=
ount,
> >                                       &buffer[offset], req->buf_size -
> > offset, &real_data_len); @@ -244,8 +251,8 @@ static int
> > ras_cmd_get_cper_records(struct ras_core_context *ras_core,
> >
> >       if ((ret && (ret !=3D -ENOMEM)) ||
> >               copy_to_user(u64_to_user_ptr(req->buf_ptr), buffer,
> > offset)) {
> > -             kfree(buffer);
> > -             return RAS_CMD__ERROR_GENERIC;
> > +             ret =3D RAS_CMD__ERROR_GENERIC;
> > +             goto out;
> >       }
> >
> >       rsp->real_data_size =3D offset;
> > @@ -254,10 +261,12 @@ static int ras_cmd_get_cper_records(struct
> > ras_core_context *ras_core,
> >       rsp->version =3D 0;
> >
> >       cmd->output_size =3D sizeof(struct ras_cmd_cper_record_rsp);
> > +     ret =3D RAS_CMD__SUCCESS;
> >
> > +out:
> > +     kfree(trace);
> >       kfree(buffer);
> > -
> > -     return RAS_CMD__SUCCESS;
> > +     return ret;
> >  }
> >
> >  static int ras_cmd_get_batch_trace_snapshot(struct ras_core_context
> > *ras_core, @@ -291,7 +300,8 @@ static int
> > ras_cmd_get_batch_trace_records(struct ras_core_context *ras_core,
> >       struct ras_cmd_batch_trace_record_rsp *output_data =3D
> >                       (struct ras_cmd_batch_trace_record_rsp *)cmd-
> > >output_buff_raw;
> >       struct ras_log_batch_overview overview;
> > -     struct ras_log_info *trace_arry[MAX_RECORD_PER_BATCH] =3D {0};
> > +     struct ras_log_info *trace_arry =3D NULL;
> > +     uint32_t trace_count =3D MAX_RECORD_PER_BATCH;
> >       struct ras_log_info *record;
> >       int i, j, count =3D 0, offset =3D 0;
> >       uint64_t id;
> > @@ -309,6 +319,10 @@ static int ras_cmd_get_batch_trace_records(struct
> > ras_core_context *ras_core,
> >           (input_data->start_batch_id >=3D overview.last_batch_id))
> >               return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
> >
> > +     trace_arry =3D kcalloc(trace_count, sizeof(*trace_arry), GFP_KERN=
EL);
> > +     if (!trace_arry)
> > +             return RAS_CMD__ERROR_GENERIC;
> > +
> >       for (i =3D 0; i < input_data->batch_num; i++) {
> >               id =3D input_data->start_batch_id + i;
> >               if (id >=3D overview.last_batch_id) { @@ -317,17 +331,17
> > @@ static int ras_cmd_get_batch_trace_records(struct
> > ras_core_context *ras_core,
> >               }
> >
> >               count =3D ras_log_ring_get_batch_records(ras_core,
> > -                                     id, trace_arry,
> > ARRAY_SIZE(trace_arry));
> > +                                     id, trace_arry, trace_count);
> >               if (count > 0) {
> >                       if ((offset + count) > RAS_CMD_MAX_TRACE_NUM)
> >                               break;
> >                       for (j =3D 0; j < count; j++) {
> >                               record =3D &output_data->records[offset +=
 j];
> > -                             record->seqno =3D trace_arry[j]->seqno;
> > -                             record->timestamp =3D trace_arry[j]-
> > >timestamp;
> > -                             record->event =3D trace_arry[j]->event;
> > +                             record->seqno =3D trace_arry[j].seqno;
> > +                             record->timestamp =3D trace_arry[j].times=
tamp;
> > +                             record->event =3D trace_arry[j].event;
> >                               memcpy(&record->aca_reg,
> > -                                     &trace_arry[j]->aca_reg,
> > sizeof(trace_arry[j]->aca_reg));
> > +                                     &trace_arry[j].aca_reg,
> > sizeof(trace_arry[j].aca_reg));
> >                       }
> >               } else {
> >                       count =3D 0;
> > @@ -346,6 +360,8 @@ static int ras_cmd_get_batch_trace_records(struct
> > ras_core_context *ras_core,
> >
> >       cmd->output_size =3D sizeof(struct
> > ras_cmd_batch_trace_record_rsp);
> >
> > +     kfree(trace_arry);
> > +
> >       return RAS_CMD__SUCCESS;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cper.c
> > b/drivers/gpu/drm/amd/ras/rascore/ras_cper.c
> > index 0fc7522b7ab6..6e93a13bbc4c 100644
> > --- a/drivers/gpu/drm/amd/ras/rascore/ras_cper.c
> > +++ b/drivers/gpu/drm/amd/ras/rascore/ras_cper.c
> > @@ -175,14 +175,14 @@ static int fill_section_runtime(struct
> > ras_core_context *ras_core,  }
> >
> >  static int cper_generate_runtime_record(struct ras_core_context *ras_c=
ore,
> > -     struct cper_section_hdr *hdr, struct ras_log_info **trace_arr, ui=
nt32_t
> > arr_num,
> > +     struct cper_section_hdr *hdr, struct ras_log_info *trace_arr,
> > +uint32_t arr_num,
> >               enum ras_cper_severity sev)  {
> >       struct cper_section_descriptor *descriptor;
> >       struct cper_section_runtime *runtime;
> >       int i;
> >
> > -     fill_section_hdr(ras_core, hdr, RAS_CPER_TYPE_RUNTIME, sev,
> > trace_arr[0]);
> > +     fill_section_hdr(ras_core, hdr, RAS_CPER_TYPE_RUNTIME, sev,
> > +&trace_arr[0]);
> >       hdr->record_length =3D  RAS_HDR_LEN + ((RAS_SEC_DESC_LEN +
> > RAS_NONSTD_SEC_LEN) * arr_num);
> >       hdr->sec_cnt =3D arr_num;
> >       for (i =3D 0; i < arr_num; i++) {
> > @@ -194,21 +194,21 @@ static int cper_generate_runtime_record(struct
> > ras_core_context *ras_core,
> >               fill_section_descriptor(ras_core, descriptor, sev, RUNTIM=
E,
> >                       RAS_NONSTD_SEC_OFFSET(hdr->sec_cnt, i),
> >                       sizeof(struct cper_section_runtime));
> > -             fill_section_runtime(ras_core, runtime, trace_arr[i], sev=
);
> > +             fill_section_runtime(ras_core, runtime, &trace_arr[i],
> > + sev);
> >       }
> >
> >       return 0;
> >  }
> >
> >  static int cper_generate_fatal_record(struct ras_core_context *ras_cor=
e,
> > -     uint8_t *buffer, struct ras_log_info **trace_arr, uint32_t arr_nu=
m)
> > +     uint8_t *buffer, struct ras_log_info *trace_arr, uint32_t
> > + arr_num)
> >  {
> >       struct ras_cper_fatal_record record =3D {0};
> >       int i =3D 0;
> >
> >       for (i =3D 0; i < arr_num; i++) {
> >               fill_section_hdr(ras_core, &record.hdr,
> > RAS_CPER_TYPE_FATAL,
> > -                              RAS_CPER_SEV_FATAL_UE, trace_arr[i]);
> > +                              RAS_CPER_SEV_FATAL_UE, &trace_arr[i]);
> >               record.hdr.record_length =3D  RAS_HDR_LEN +
> > RAS_SEC_DESC_LEN + RAS_FATAL_SEC_LEN;
> >               record.hdr.sec_cnt =3D 1;
> >
> > @@ -216,7 +216,7 @@ static int cper_generate_fatal_record(struct
> > ras_core_context *ras_core,
> >                                       CRASHDUMP, offsetof(struct
> > ras_cper_fatal_record, fatal),
> >                                       sizeof(struct
> > cper_section_fatal));
> >
> > -             fill_section_fatal(ras_core, &record.fatal, trace_arr[i])=
;
> > +             fill_section_fatal(ras_core, &record.fatal,
> > + &trace_arr[i]);
> >
> >               memcpy(buffer + (i * record.hdr.record_length),
> >                               &record, record.hdr.record_length); @@ -
> > 271,7 +271,7 @@ static enum ras_cper_type
> > cper_ras_log_event_to_cper_type(enum ras_log_event eve  }
> >
> >  int ras_cper_generate_cper(struct ras_core_context *ras_core,
> > -             struct ras_log_info **trace_list, uint32_t count,
> > +             struct ras_log_info *trace_list, uint32_t count,
> >               uint8_t *buf, uint32_t buf_len, uint32_t *real_data_len) =
 {
> >       uint8_t *buffer =3D buf;
> > @@ -281,14 +281,14 @@ int ras_cper_generate_cper(struct
> > ras_core_context *ras_core,
> >
> >       /* All the batch traces share the same event */
> >       record_size =3D cper_get_record_size(
> > -                     cper_ras_log_event_to_cper_type(trace_list[0]-
> > >event), count);
> > +
> >       cper_ras_log_event_to_cper_type(trace_list[0].event), count);
> >
> >       if ((record_size + saved_size) > buf_size)
> >               return -ENOMEM;
> >
> >       hdr =3D (struct cper_section_hdr *)(buffer + saved_size);
> >
> > -     switch (trace_list[0]->event) {
> > +     switch (trace_list[0].event) {
> >       case RAS_LOG_EVENT_RMA:
> >               cper_generate_runtime_record(ras_core, hdr, trace_list,
> > count, RAS_CPER_SEV_RMA);
> >               break;
> > @@ -304,7 +304,7 @@ int ras_cper_generate_cper(struct ras_core_context
> > *ras_core,
> >               cper_generate_fatal_record(ras_core, buffer +
> > saved_size, trace_list, count);
> >               break;
> >       default:
> > -             RAS_DEV_WARN(ras_core->dev, "Unprocessed trace
> > event: %d\n", trace_list[0]->event);
> > +             RAS_DEV_WARN(ras_core->dev, "Unprocessed trace
> > event: %d\n",
> > +trace_list[0].event);
> >               break;
> >       }
> >
> > diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cper.h
> > b/drivers/gpu/drm/amd/ras/rascore/ras_cper.h
> > index 076c1883c1ce..e4e3615ecc2e 100644
> > --- a/drivers/gpu/drm/amd/ras/rascore/ras_cper.h
> > +++ b/drivers/gpu/drm/amd/ras/rascore/ras_cper.h
> > @@ -299,6 +299,6 @@ struct ras_cper_fatal_record {  struct
> > ras_core_context;  struct ras_log_info;  int
> > ras_cper_generate_cper(struct ras_core_context *ras_core,
> > -             struct ras_log_info **trace_list, uint32_t count,
> > +             struct ras_log_info *trace_list, uint32_t count,
> >               uint8_t *buf, uint32_t buf_len, uint32_t
> > *real_data_len); #endif diff --git
> > a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
> > b/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
> > index 0a838fdcb2f6..c2fca1a1e780 100644
> > --- a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
> > +++ b/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
> > @@ -265,8 +265,8 @@ void ras_log_ring_add_log_event(struct
> > ras_core_context *ras_core,
> >       ras_log_ring_add_data(ras_core, log, batch_tag);  }
> >
> > -static struct ras_log_info *ras_log_ring_lookup_data(struct
> > ras_core_context *ras_core,
> > -                                     uint64_t idx)
> > +static int ras_log_ring_lookup_data(struct ras_core_context *ras_core,
> > +                                     uint64_t idx, struct
> > +ras_log_info *log)
> >  {
> >       struct ras_log_ring *log_ring =3D &ras_core->ras_log_ring;
> >       unsigned long flags =3D 0;
> > @@ -274,30 +274,27 @@ static struct ras_log_info
> > *ras_log_ring_lookup_data(struct ras_core_context *ra
> >
> >       spin_lock_irqsave(&log_ring->spin_lock, flags);
> >       data =3D radix_tree_lookup(&log_ring->ras_log_root, idx);
> > +     if (data)
> > +             memcpy(log, data, sizeof(*log));
> >       spin_unlock_irqrestore(&log_ring->spin_lock, flags);
> >
> > -     return (struct ras_log_info *)data;
> > +     return data ? 0 : -ENODATA;
> >  }
> >
> >  int ras_log_ring_get_batch_records(struct ras_core_context *ras_core,
> > uint64_t batch_id,
> > -             struct ras_log_info **log_arr, uint32_t arr_num)
> > +             struct ras_log_info *log_arr, uint32_t arr_num)
> >  {
> >       struct ras_log_ring *log_ring =3D &ras_core->ras_log_ring;
> >       uint32_t i, idx, count =3D 0;
> > -     void *data;
> >
> > -     if ((batch_id >=3D log_ring->mono_upward_batch_id) ||
> > +     if (!log_arr || !arr_num || (batch_id >=3D
> > +log_ring->mono_upward_batch_id) ||
> >               (batch_id < log_ring->last_del_batch_id))
> >               return -EINVAL;
> >
> > -     for (i =3D 0; i < MAX_RECORD_PER_BATCH; i++) {
> > +     for (i =3D 0; i < MAX_RECORD_PER_BATCH && i < arr_num; i++) {
> >               idx =3D BATCH_IDX_TO_TREE_IDX(batch_id, i);
> > -             data =3D ras_log_ring_lookup_data(ras_core, idx);
> > -             if (data) {
> > -                     log_arr[count++] =3D data;
> > -                     if (count >=3D arr_num)
> > -                             break;
> > -             }
> > +             if (!ras_log_ring_lookup_data(ras_core, idx, &log_arr[cou=
nt]))
> > +                     count++;
> >       }
> >
> >       return count;
> > diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h
> > b/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h
> > index 0ff6cc35678d..cb66beaa9f43 100644
> > --- a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h
> > +++ b/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h
> > @@ -86,7 +86,7 @@ void ras_log_ring_add_log_event(struct
> > ras_core_context *ras_core,
> >               enum ras_log_event event, void *data, struct
> > ras_log_batch_tag *tag);
> >
> >  int ras_log_ring_get_batch_records(struct ras_core_context *ras_core,
> > uint64_t batch_idx,
> > -             struct ras_log_info **log_arr, uint32_t arr_num);
> > +             struct ras_log_info *log_arr, uint32_t arr_num);
> >
> >  int ras_log_ring_get_batch_overview(struct ras_core_context *ras_core,
> >               struct ras_log_batch_overview *overview);
> > --
> > 2.43.0
>
>

