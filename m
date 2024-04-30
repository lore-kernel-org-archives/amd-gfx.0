Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD45C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 20:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 554A1112EF4;
	Tue, 30 Apr 2024 20:16:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QrSXVuLo";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF0D112EF4
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 20:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdol8R9JNN/QlQ4dtiehBKjp5S7z/M5+42XVjYAbJnCZVcOt239jiNe97Ldvq0GbTCBUpAgf4SHwzhA+YDcKjo9UFxYk/n9Ot/QhtAhMOSl7IEGaY9OZsfVF2A4BP7aIWcTC+zPn8LCsB/vZLleEQPXwp2DQiIz9Pl/ZjIV9AOEdgsZ1tFEggs6dNfvMDQup8KLFD722Fl4pnNWgA2vWIFb3r8B4TpbVanG+SxEt2EOTOySUx5eegufe3mKXUWBjaySzyWPy3lEpA1vTs1NHc54ODjjh0pkTl7LFblocyM08o2XzSEt4O0AX24FeMmenOA4XrfdrSR+I++Oj77Vddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTxU9BagefmN0QhtqYhhAUUT+eMoid70+6qKy4jZgyo=;
 b=UPT6z/+nL3zcUjgqjrxTV8SxAtX3oRwGpEzfzJEDB2+6TTDZEk7isJewngnWI2Wy3PpPJHnHLTztnB8mKu6lW7HcDJPnxYQFXset83FlJe4TUg5UOWjSLng8nCeGY+qRFsMmm2epdho7lL08JLehmezUCiQ5Bib52USk2OSrHc73uHbK+GXMIgzaGdqtNkOzHqShNTpkiFVUpIQBrCJ/qbM+BF+zRFV+sD55plebUcZahQrnpCGASJehJJsU7Q9EHcclJmg8DC5YsG4pMk5I38qttxk7ZH2ZlBSM44x7fIalGVVuz7qC5zqJ2MUgIwMXJscT2n8M8/O+QmhzDAgwPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTxU9BagefmN0QhtqYhhAUUT+eMoid70+6qKy4jZgyo=;
 b=QrSXVuLoBPOE9H+6/tiOT1Iv6f9PUeUe4pABRIsfzpRHoqIXEWLOiPyWqpPQbfcS0tNXMc2VzlIw2Jwsi13AMLnLmiwmJGiJDLlx45Zb1qA5NX4wUpHexmSzWvZxkCUrCt72wfvVr12rSQfM8+ZtdLD7gznOpyAykyJH/0yUCKs=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 20:16:08 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 20:16:08 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Poag,
 Charis" <Charis.Poag@amd.com>, "Cheung, Donald" <donald.cheung@amd.com>, "Yat
 Sin, David" <David.YatSin@amd.com>, "Chaudhary, Jatin Jaikishan"
 <JatinJaikishan.Chaudhary@amd.com>, "Du, Wenkai" <Wenkai.Du@amd.com>
Subject: RE: [PATCH] Revert "drm/amdkfd: Add partition id field to location_id"
Thread-Topic: [PATCH] Revert "drm/amdkfd: Add partition id field to
 location_id"
Thread-Index: AQHalXFdgrOJjh2p3EulGyPGPZHj77GBS2FA
Date: Tue, 30 Apr 2024 20:16:07 +0000
Message-ID: <CY8PR12MB7435A96499E2B06903101ECA851A2@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20240423112803.231769-1-lijo.lazar@amd.com>
In-Reply-To: <20240423112803.231769-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=15b871ce-a5a2-4912-9c5c-3cf32e1bcbde;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-30T20:15:55Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|MN2PR12MB4110:EE_
x-ms-office365-filtering-correlation-id: bff930b9-2921-4d49-ffe1-08dc69525ee1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?cj1JdcHPRup8knM7IM+SGL1EEaMP1B4kgqmWqpoZf8egZTKxschE0AC0hAjz?=
 =?us-ascii?Q?QBrPGVvvM9TjfmyrgQojOSFM4PenB+SKcVBBYje48vLEVLChv6PoPm0SDyWl?=
 =?us-ascii?Q?FMKotGHsQ4zP7srq4cRjJhU2k2kt69OvpVnbY2jkU1G63jaT3ZWGY6xhLs8w?=
 =?us-ascii?Q?p7x1KTBYQXG2ewnrhzmPO5ZG0wErBKO4p5UF6PsUab1AUWzoU1fyPAjXLaio?=
 =?us-ascii?Q?MTLPk4QYPVns0RFg92HwUhuldDsVRgSLdih6lM89YdIGij65IXVgH5rIM68w?=
 =?us-ascii?Q?k9wVHQekzFmAorCSuUkHhPczLQqfhqWHHI7z5ojxRrAaWXeXtSdYda7m68jD?=
 =?us-ascii?Q?766LRQpJQjkajFCNzeKtF9AjV4G5zVvVv77QuTOfaZ592KG3Gps1P2jI/97g?=
 =?us-ascii?Q?BbFCO4hh2uwaSwv0XqafYJJnlR/B+mpCIWtAfDFx+mMb22ukAutOTP1FnV1X?=
 =?us-ascii?Q?wbqfyOBoa3U48u/uT33m5k+xZzjxkg7acHwgIUV+ZxHWFHooeP4MpmZ4dBq2?=
 =?us-ascii?Q?7ru/hmcNj6PChMaHiP0k1P8aBfydQsUHCz7/jFGR2SZu+kTp17QMev/rIkUf?=
 =?us-ascii?Q?bgNE40VZrAuBnp6SIEH1nZBe+K3dqrcQhna/7D2nVgM50HSWmfF596kW19S8?=
 =?us-ascii?Q?KW7r2mKxVs5YnP184c0uCQoy9EhLKS8/atN4OI/R+pwm4/dyHnju3bkjjicy?=
 =?us-ascii?Q?NmY9yovbNfQxRVgM7+f11JGgo68r10tIKzD8FuJtCpz7VJfxqbnCWJlYS9XE?=
 =?us-ascii?Q?irwmJGiP120U8aQXtbqQGJNauEWMqF/uVmE8Qic7pLgtWP9sfsC8ELimdtRB?=
 =?us-ascii?Q?ndXiwEJTSU6RxdGYH3DFdDS9RFpvpCcCz0JP2zaMpLrtQtKnOqJ8y3eETr2c?=
 =?us-ascii?Q?mnBiLxafPd0VPeGeMCVFr1AedAArexcm94cxyIu8Lds3u+Y74MRi0vJdK5I8?=
 =?us-ascii?Q?63Wmf2ZjxRzaAIHMJq7qK36dXieUetEy3d/rNdGsgZritF8s6dMHXHaxoo1c?=
 =?us-ascii?Q?aVu7XlTPS1eg4zgO7e4vBkfdURYdIrevqiIx5sPwbZaPKEVIGgJQaWArJD/a?=
 =?us-ascii?Q?HfYv37m+25rUpJsWqFmKkLgxLudnjnoO+GnmRbwr0VrH1HqmRb4+NQmKB0a8?=
 =?us-ascii?Q?byge2wMiTI4xooE98KLtj/CrCSGWT/SQzknq/e/EyjBQjA2w+8UKPThkQFVR?=
 =?us-ascii?Q?B6c9sbeg9BI1LclJXLPU2sVdFzwu6JkujhEVBrxVbEW+DZx47t7orhxr69eb?=
 =?us-ascii?Q?yiXRfKLn2eowOyRyDl8hbqGIHDPI6eH+SIompz+EC+jCEvcfhlHuKPX+vGhx?=
 =?us-ascii?Q?6UNMfxGO5cZXmSgqxR1X/lQpsW0ChfqvUdHc+YsLkPW7eQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/s+5nP3NOwQ1jWV5e0oW2h+8dgNLptZTWTPNC3yNEj4vUMRFOrEekaqbUEk7?=
 =?us-ascii?Q?hWQjh3FLrZDxL04KWRpoj1L1H9+1AfSwPs8Yk4B2PdOdggcYUq3XBlQZyCMn?=
 =?us-ascii?Q?CNQoBWw+awcppkje1+G78Oh1MB+WQN3jXsRdi47p9lKem/8/Dkywz9qk7uFZ?=
 =?us-ascii?Q?ra5mj0XGKj659TZ3JUQF3QptORRH72f8Kfk83HIwGEIxf7W31huWSGHxeMgv?=
 =?us-ascii?Q?NsjMZASfgUSNfI3Olyt8ygsk3difPKYksww4TNXmpNoNVEyA/iLvpDFffb52?=
 =?us-ascii?Q?6Nv0LZrFazb+0CU4Gq1lTYHgiiRl7LtiA6Xwk29FeACsWeQEdvjC2SFeGU9Z?=
 =?us-ascii?Q?hh6aVuVBDGH6N4KY+2uxfeqHWixDJEKfMbTBhr7wlF4pOwr/lqImCZvJRQj8?=
 =?us-ascii?Q?Z6nxkzpEN2fEXYTY3/JynJlPrXx8vIF+BXfq0uznmE4XAlSnn7IHwQY5uU2L?=
 =?us-ascii?Q?h7bP65QCRV++4YmxIaZr8VNeDo7zJEZmbVN7D+jauK+DQwFEpAlwRprhC+YD?=
 =?us-ascii?Q?Ad985AQHT1Rx7ojJET7LHeTlNQjaecWMS+Rl8GSnzpjUW3DnIyMaX2g6E/SG?=
 =?us-ascii?Q?pFQcg5FMa11x1Kkc5MshDJT2DsZ6nazIEAHXZaCxwtVA08J09u0myp2QVIhu?=
 =?us-ascii?Q?Kui+tzol64ESQHhcxbeNYPCzTCUXOCCa59+aWwkhTacj4GZkhphnLIstXFtJ?=
 =?us-ascii?Q?y7zdns414WwFmY9ZSZGKaXaa4K/4RI583gTrLO/D0mmDmkEGO0LzqoILhRtT?=
 =?us-ascii?Q?2lkmY2a/hS9aYTn7kfeSkk7x4YCpwnL1HP+XSVk6LFBNJEVlwu/rue5ON2dM?=
 =?us-ascii?Q?jFqOar4Czw0wE1yyD/Rsgak7c/rPYXqTGvuXOdTJuWY37Uu+hkTvqdq9MWlD?=
 =?us-ascii?Q?/Aez/xmn532A88NpLNpmA5sXuQ8mOsSGMn3BnoX5khJQAZoka1Lqj86OxFMP?=
 =?us-ascii?Q?GnQEjAZTfOqajQy4DJ8Jl8726wHkK+XSloWh0m13OphRjf7742o7epJ6f3yz?=
 =?us-ascii?Q?CbmQJVGH/YDjiuXVckyBImXSZ0ib+xFsHtws72arjfPDkKl6nHEMYoVGuOw4?=
 =?us-ascii?Q?pqZMUf5oZFGPo+YjJMjtDA/gQwJ+JnbMGX/OL8v5K2z29iRTy5/MnmloMQg2?=
 =?us-ascii?Q?HCcOujgzUlNJVLrv6WD9Bz8irC8DxO7VKGyJ6ydXhL8pMLqboOLw8AQFc6j7?=
 =?us-ascii?Q?Cax+/duU8Tp5fA1RyKepUZQBmPSC6up3KKPkAVaDjDanegS8dGKiakWbcrK4?=
 =?us-ascii?Q?9/uu429w1daC7k50m07ccn6HHon88JjcvXB24jHQGCANR0s7cmiLeZmfBjOp?=
 =?us-ascii?Q?soUi0rwFagq4exd/6dnObBRr8UYAtmfFkfdMwxiEEtj3ifoOuMev5osDCFTm?=
 =?us-ascii?Q?6sdojbUtcWEt4fMEpzseHkxFDNQnolR9GxqRSzspHzpuJMiHWcvkBsL0z3uM?=
 =?us-ascii?Q?JmMkdxfLB2qlb6/MBGEyVWkjAEn/STge6htBUrZiYxz2UgG056F2wqtQkPBR?=
 =?us-ascii?Q?SvSShRXId2ZSw+im6EmLo6x5V5C9NIUVOrX83aUmbkLnz2ZAafr1152jd+fp?=
 =?us-ascii?Q?6IB+9cCrcfgwhLoBxcw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff930b9-2921-4d49-ffe1-08dc69525ee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 20:16:07.9311 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36H+bEJ6UIXh8fUTPryqd+O8twmifie5qW33s9Bb4Lb12kJzdJ2im4hfFNQNziQ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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

[Public]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, April 23, 2024 7:28 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>;
> Kim, Jonathan <Jonathan.Kim@amd.com>; Poag, Charis
> <Charis.Poag@amd.com>; Cheung, Donald <donald.cheung@amd.com>; Yat
> Sin, David <David.YatSin@amd.com>; Chaudhary, Jatin Jaikishan
> <JatinJaikishan.Chaudhary@amd.com>; Du, Wenkai <Wenkai.Du@amd.com>
> Subject: [PATCH] Revert "drm/amdkfd: Add partition id field to location_i=
d"
>
> This reverts commit 925c7bd1d1cf9f173b22603c8bd4816d142d4935.
>
> RCCL library is currently not treating spatial partitions differently,
> hence this change is causing issues. Revert temporarily till RCCL
> implementation is ready for spatial partitions.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index c51f131eaa2f..bc9eb847ecfe 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1997,9 +1997,8 @@ int kfd_topology_add_device(struct kfd_node
> *gpu)
>                       HSA_CAP_ASIC_REVISION_MASK);
>
>       dev->node_props.location_id =3D pci_dev_id(gpu->adev->pdev);
> -     /* On multi-partition nodes, node id =3D location_id[31:28] */
> -     if (gpu->kfd->num_nodes > 1)
> -             dev->node_props.location_id |=3D (dev->gpu->node_id << 28);
> +     if (KFD_GC_VERSION(dev->gpu->kfd) =3D=3D IP_VERSION(9, 4, 3))
> +             dev->node_props.location_id |=3D dev->gpu->node_id;
>
>       dev->node_props.domain =3D pci_domain_nr(gpu->adev->pdev->bus);
>       dev->node_props.max_engine_clk_fcompute =3D
> --
> 2.25.1

