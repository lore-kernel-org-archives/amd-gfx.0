Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D309CD5BC0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 07:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C5F210E0BC;
	Mon, 25 May 2026 07:48:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OCgIXqV1";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010007.outbound.protection.outlook.com
 [52.101.193.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC3F710E0BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 07:48:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmMaqfGUaCCIeabIK1Abmarobzeb1vLxcu9tKX0RTGuASc1y1zUh1QspXw4XwLq186rpczEc4pJAOdmqBJ7vqrkOifetoIq2y2it8UPS5oU800bB1pjKVKACjWtS1EYw8rHqgbnFzHi0QJF+MkD26vHsjzi0HRmgkvZV8vuOe57KWFzl7epLr/qLZBEeXgCDa+KliYeuJbNsL3Iioy4W0+vdIcoNlwjejM9qhaZscWHQaofAKZ+e5jtX08+j8BIa7vt3kbRcWD1t2uLI1ukwELHc2KDHmz+YVFmTKTJJQ1MyiOdAfD1hdOA825NLJ1plSYuw383/zQAzmb4TRuJOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUMst9ioz3L+NZsbpIDWDrTy8424fBOwc47xpmT7D9w=;
 b=EGYP1Aj+I5s2ipPb9IGqB963E9xqaHBHg1dI6pLGIz1gWBcusB/MnXmbQZ6+dR5J2crR8HgasWPnY3j6Cctzeacr1NPVwOSSOoXvKWQvLfm5n3q0Sr/SVYPDDGNU+D840lcqYpf4HTaNbHhZdf6XVsvKNPq4+eZdDAyAJ36bBbp627QGZ/BOtnfNyR+6PHx1+CHtgoxMb/dLonxvbsHFHPLt5iwX1QDgPD6/+ntSOCl0shoMKgH8bYQjqcqgu0kyHPL98g99jpLgqJMBQK449KU9RQcM3jTioa7hrJnyyFfxSLeS7OiEn+FRSUoISFU8KqJJ++c0y2Cs0EdPcQ82Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUMst9ioz3L+NZsbpIDWDrTy8424fBOwc47xpmT7D9w=;
 b=OCgIXqV1abK/27YY3APabSDsa7gdLlUSw2ru1rb+8Tv0T3WckGRQyoA5kCAiNQEn+XcppePWQKWOTCjHZd9SSWt4V+P9P3C6IrTV94sLpiBAE75kvJczv8Pd0mwJa96RL255VGIgSOtz3JHPkqfyX5lCrrSA34FZFMml/yun1Ag=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 07:48:43 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 07:48:43 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "Lin, Amber" <Amber.Lin@amd.com>, "Liu, Shaoyun"
 <Shaoyun.Liu@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 02/42] drm/amdgpu: don't reemit if there is nothing to
 reemit
Thread-Topic: [PATCH 02/42] drm/amdgpu: don't reemit if there is nothing to
 reemit
Thread-Index: AQHc6YDoWk2A4qAJjEeMhOLbDqzlC7YeYU/g
Date: Mon, 25 May 2026 07:48:43 +0000
Message-ID: <DM4PR12MB5152C5D31C34F45B44D8212AE30A2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
 <20260522002048.98506-3-alexander.deucher@amd.com>
In-Reply-To: <20260522002048.98506-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-25T07:43:21.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MN6PR12MB8567:EE_
x-ms-office365-filtering-correlation-id: d22f67af-83ab-46b1-4944-08deba320b2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|921020|38070700021|5023799004|11063799006|6133799003|4143699003|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: nMXptE4Qzap9mApqplkc8JCCTIk0rKMOJK00hN3Tui1532CwJ8vKJqOI19Re6KHAQh/md3hWm+0jYQoo7afZk52R4t/5rt5UySW74NjOI06Y3GZMFTkLqFGgbDkE5dRHjvBxGmiw9J89VzHA/UBNjRX1gQlnpM549/LgBvWoO8bIzXRy02AQgbR4E/RUo/cA2xGxvtRfdqhnDN4dSx2ZWasBgt70rZ0zHveQRYa0Ov80xOjZA42GtGpWhoXkMgQF7MDeFgFw4QzBmp8KoiC+u5dUH+WjFT64vh6HVW+7fvTM++gs5GfjcTP5pfIA2H0iwS4foiUqIP+eUMKARKkbyrRa3srL3ud5Y/WOsIRAdduN37jqeee/OtkSEuFlJIAGNZ8guyoBKFnkPD5snzLE3lB99SPARJLQZxvSl3GeKYw3KzppKyxGMaNhgiC+ZsnnmWw0AUqYiw+VVdTpEx/udkBO8pMwGbCAJlJX2VRFtJB9J8uqq/xnqRDt1jQiVLptjC9vR9+xVxQgPYgsmGwlpAEEUDk02asWeFJ4rBRqiVLmoVQrVMkYv4mbR7Dp2tW4ui/P/9W7vsN0RRmhShJGLBMczYTK45TBUL8ERMsX09eQUdbTXAyankBzOcko+cS7AtNvQDOR6cc1U1ywjlyUQVWuHeU1RgI8arJh8Y528KAW5jxgZTjEd6xu65jG97rdh90yzeAVuhXOXlBAZHdI4Zwjd8aUPiGGSuoHsnnsR5gL9g94jLu4Eh9Y5IVthY1ha3eh936z0XRsoT6lfJFdjw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(921020)(38070700021)(5023799004)(11063799006)(6133799003)(4143699003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mb4b/bN44VTzVL9U3whqW7KhmqgOikczZojQk8qqHl/c01egecFv02u0md1e?=
 =?us-ascii?Q?RlvHsUvBHhWI+FFD4vzkZ6bECmtSuQj79xYRRW5bWq7kINKRZdxqNj7x0JRc?=
 =?us-ascii?Q?lztFoSoipiu85Y+JAkjkYGR4EvC/SXXJwpgjX9uGZUN19OYG7Zes0mSXr/o7?=
 =?us-ascii?Q?AfP6Y7jcO39PhsJiYb78NB8ibpizLmHtw2UsxnZ8WrNtiwmoWf7B1jXrqd3Q?=
 =?us-ascii?Q?4I5acoSR2jTsKPIvyT6GrjFkEp3f5t61veia4fvtVBNLuHhnBNj73TqBpvNF?=
 =?us-ascii?Q?zwPo2nuuVOI7Iq1GWfgcPCxIIgeka3/r0pWh0EjRd4ZN0kZD9TKMSVbwG4tN?=
 =?us-ascii?Q?V5sg0bDTk8hSv+thPOnyL+32W1JYey9W9UDh7tClzbZ2G7g+f0FLQnwe1CHN?=
 =?us-ascii?Q?Y2Zuh7vka3xsTG/wRewA4SNiq+eymsBokWkUpxUlWzJ852Q/LqgkhnBCJzgm?=
 =?us-ascii?Q?cO6Iz+qd+po3IwlWJ7JNSCahIZ7AQYiHR9DR8YFO/WSvaaS3WXP/s2iLmEpO?=
 =?us-ascii?Q?tv8TKa0y0e04BFZqQDQrur4JfTzqUVPGwBbkUvU57gPLJuxEngc7Psgx7fDt?=
 =?us-ascii?Q?eaw10bV3b2wIuIw0kDySBjxWFcv1X/Z05NqHdk87mzLFbzDzgJBdxV4PNhIf?=
 =?us-ascii?Q?o1l+F8+Z/HVw8sEBFHh/LKwO0yQSRodUMq0gRzgzzx6ji9y+Py8tdO8KvM5x?=
 =?us-ascii?Q?FI3ctLVtUvy+CdBjFRF+VJwIUWhUt4ZCYrMs8+YI/X+22Tl1icmnyK4Nggy4?=
 =?us-ascii?Q?1bOy93rVSTpmexdnMCUCMXdj/uUXpuryD8fnkWWnOWkcdyrk6pzfWISnAUQi?=
 =?us-ascii?Q?pPpQ3F4EjYZAW8sefluQ5q5kh6RXRePqzeH+ovtTpk9V6M2Q3v3xuaMjxtqa?=
 =?us-ascii?Q?s+702SWwLhbsanU6OLft/cmMUPaXR+8V5cJaheu273BSnfKATHkVmdEcKZEy?=
 =?us-ascii?Q?/hfS6PPoN5Ciph2OEMCqW7AwAnQwu15Gvho9Wv3zBDKFoM2w0edoE9Nhh/HX?=
 =?us-ascii?Q?R1JGcTNOSPsOK58zsjnvmp4E9hU5ZnwCmC+X4jW9EqJhdI3621ZaGq5c8aFJ?=
 =?us-ascii?Q?r3tIYa8SN2IKJ8A0iq98mGBOr5oxPAR/CUN3XAo3wKNPvoyHEegstqSvw/Md?=
 =?us-ascii?Q?uh9r0BrNm4FURdmIKL2Fc3RwamlbxNC3SYtJIuDEXLaO/gi/DoKvR7yHUEyr?=
 =?us-ascii?Q?JWwAYW+REXgGqX5JuRXUdLHDJTOvCmUB/nXK9U48MiVQjNYM8gs6GtZfo0fN?=
 =?us-ascii?Q?GIYUVUwbTT4RaWPjSrVZqDStnuFxOoJqYwgGUQpDtPdxu9tNFMu8nG5lPQmS?=
 =?us-ascii?Q?QF7PplcRFwZirQk/v5Lgb+g1453kPo/7Xeh5D7tQW3Q3w2maAytK3sxDwiev?=
 =?us-ascii?Q?G9UMGNthFU+8Q2cQ2qqKFf2K+nNarebBU5XXFZx9HdgzI+QURfyaVzkcZTCM?=
 =?us-ascii?Q?KZJMZm4OPX9ynFkE3gGcC289CNVLF58SOMKS8T9sHQJl996dHMNeSGLjIWUD?=
 =?us-ascii?Q?1ePn8QMYgjpEeidAra7kUFairO9NqKglh2/h+4Oca8n5D13VLrfrlSdNBFNR?=
 =?us-ascii?Q?JUAtl+al/ihoyUO01Crp4Sqfgk411621Im0qk92nIzqmrGJkLOwWJVao3aWq?=
 =?us-ascii?Q?a0oyzIdGMg98ML0Pre6Aj6/9oBT2T6F0byCoDG+OgaQq63eaQQMTMBF79R7B?=
 =?us-ascii?Q?SzqaoXJv6q5+YZRzAMlETPI4ipsPE6aS240vGlcAQnWKCMu6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22f67af-83ab-46b1-4944-08deba320b2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 07:48:43.1657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tep9IPhLn/k+r+p/FrTZ3Lt4FQuIH1MI2jzI93x2dgo4VGROXrAut6FNXDpDmqQLIVXsqUuFZKo+dbVXZuTJ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
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

> -----Original Message-----
> From: Alex Deucher <alexander.deucher@amd.com>
> Sent: Friday, May 22, 2026 8:20 AM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Lin, Am=
ber
> <Amber.Lin@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu,
> Shaoyun <Shaoyun.Liu@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 02/42] drm/amdgpu: don't reemit if there is nothing to re=
emit
>
> Return early in amdgpu_ring_set_fence_errors_and_reemit()
> if ring_backup_entries_to_copy is 0.  That means that either the ring is =
idle and
> there is nothing to reemit, or there some reason why we should reemit, so=
 return
> early and signal the fences (if applicable).
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index ea69b1bac7c6e..6a43c8494fa8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -727,6 +727,15 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct
> amdgpu_ring *ring,
>       last_seq =3D amdgpu_fence_read(ring) & ring->fence_drv.num_fences_m=
ask;
>       seq =3D ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
>
> +     /* If there is nothing to reemit, return early and set an error on =
the fence
> +      * if applicable. If all of the fences are siganlled, this will be =
a nop.
> +      * if there are still fences and ring_backup_entries_to_copy is 0, =
then
> +      * we are skipping it on purpose.
> +      */
> +     if (!ring->ring_backup_entries_to_copy) {
[Zhang, Jesse(Jie)]  should we  check if guilty_fence is NULL?
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
> +             amdgpu_fence_driver_force_completion(ring, &guilty_fence->b=
ase);
> +             return;
> +     }
>       ring->reemit =3D true;
>       amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
>       spin_lock_irqsave(&ring->fence_drv.lock, flags);
> --
> 2.54.0

