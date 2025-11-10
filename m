Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875D3CCFA13
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Nov 2025 14:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 016CC10E407;
	Mon, 10 Nov 2025 14:50:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WMjNIKPU";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B72310E407
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 14:50:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDwV5EHR/9TnOqHLb5nlZPDLdgzcJEgH7zZ0m7LaWquilWRC9shb/HaWhZWfW8/DAqBcMF8YfqHU2LqEojCZ1byL/NW/387Xd+DrMXIkj67RGnu2F+aVCW4Xnj02gJ2SFRvQlDbp3+OT2bvglrDt5rCtkCsP2vzyWppxB9kGfyF4v+vQbdFfcg4J5m63GcK9idrg+Zh8c1ogoxPfLaN3wyd8+LK/Lec3WI6lpQ6PHqWRJPUA3yBPlx3xIZvWq3QN8OGALRR6GT+20E0hDjEJLAklPI0ZUhZIWusVh7mIGntHw7FWajUyEvgPbVl7K0U0eWC+/sNN0GHHYcbSudeZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/0L7az3chHAJPiZVumzi1gAvNg3ZcgJErNNCZZQDws=;
 b=cXyaxWKEGM8thTm8yuHbSmbBC7OK924eszRUK3kOjzGNdrKsHzv8cKrS7XNunW0ezDfQJCZX97lmGLL61TWhwVSsmBjPjo+utNaFaVxozqeEQPdlMiCYPbtRowNrP9z9oPzY+0ZNv/3QdFgivhpseI2zKwk4ogBPJyZW55rLCwgXvEAImWcjYmfJINRKE206jT00L1vsBb6VQX3wQRugwzIiwGqpe4fdqYWox7oD1o0K1Ajk3QGBw60gy1lxlYawmIc2NMCiEN25bDht9aCPZ4tSHwEXEVfnivs10YfbRO/bqGOchP7PLTuXZJ+p8Gg4304RQPFwA2TM9rtjeG9IpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/0L7az3chHAJPiZVumzi1gAvNg3ZcgJErNNCZZQDws=;
 b=WMjNIKPUEeJQbDuhI9Q5iEb1lKlqqP4f/7O4UBI8p/42uW3HzvTQ8pZyYz9rGG2XHxOpgx+YbVPvupPMpLfYwHbj+QhP5Jk999Qob1OZOz0o1hycHl53wlZPWV6HgfuAo2KJMGlBXhkYgNkqia+jSvx8lcrk8vCx3R8mU2KBs/g=
Received: from SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 14:50:09 +0000
Received: from SN7PR12MB7451.namprd12.prod.outlook.com
 ([fe80::4ca9:555b:174c:855c]) by SN7PR12MB7451.namprd12.prod.outlook.com
 ([fe80::4ca9:555b:174c:855c%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 14:50:08 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Six, Lancelot" <Lancelot.Six@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdkfd: relax checks for over allocation of save area
Thread-Topic: [PATCH] drm/amdkfd: relax checks for over allocation of save area
Thread-Index: AQHcUEqreHTebAKU3E6UB5WzHvG42LTsAdaw
Date: Mon, 10 Nov 2025 14:50:08 +0000
Message-ID: <SN7PR12MB7451001D3551BB2F5B39162E85CEA@SN7PR12MB7451.namprd12.prod.outlook.com>
References: <20251108005717.3414138-1-jonathan.kim@amd.com>
In-Reply-To: <20251108005717.3414138-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-11-10T14:49:34.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7451:EE_|PH7PR12MB7282:EE_
x-ms-office365-filtering-correlation-id: 2bf20543-ed69-49f1-1fd5-08de206871ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ZIqpTErxCNYwKEZbcYjMopdRSZ7qUJSKPVYbedKY8vJZXd3zJFOmQNdkGX++?=
 =?us-ascii?Q?+e2IJNBn21SOp0idl2i6hpoChFV+ZVEJz2N3UE3E/PcIn//z1h9+jHg1yQ76?=
 =?us-ascii?Q?ccDiRhpZBCbhRTgyYgD7y46qIhdncaQDisJDDjIyW79XuWO/dKD/Wb0X2pGG?=
 =?us-ascii?Q?FDjMrBClOMqiFq2nwcC0hIrePgYS9hFIMZ+dhVXswMwPfZH323T/ibdy4FD6?=
 =?us-ascii?Q?PRLA9jf037gjeZgyGMpLZP17GL3G5weuiUQGnRTLvTEKozCuhgmqTrqnzxFp?=
 =?us-ascii?Q?En0Wg12Cqus3wUKNAut6Zsmve0Fwl8soDgaLA+bg60bY0OZDXUsBACMxhXWM?=
 =?us-ascii?Q?N7Q/yLqg5milfyXqd3nVlKeSPi9TqfSmMlMzWrZysxKDFQQByEMwUaPky6Tc?=
 =?us-ascii?Q?9cDE8+tmuo2pO9izFZVcTxyKcS2itIdN/47NXWut/Kj6IEwQiHkR6Xt17/BT?=
 =?us-ascii?Q?Ef/COgHKuPpErYWdH7wBTJzkUAC9Q8IpzHiMENRv2bc3cPwh7lXCWGC5CvEu?=
 =?us-ascii?Q?3JN4v+jokcvMK/+tRBZ/VyIWgY6ehcE/akSqfvMK3MwCqyCmISQeLn/6yVso?=
 =?us-ascii?Q?G9fheF5wKfoQJNx4YQOqbqPvzOu+0iQzWK62A6oIo2WVvMZF3UFKVyO5Nj3b?=
 =?us-ascii?Q?O0moL+43043JY3iyjfKTZGaevBicYJBKbZy4RFPpK/QnaSrO3YpIeUijMyqb?=
 =?us-ascii?Q?ufjx4NlL3LxA0MH1Pn5zkXhnng+OqcR+b+pDvSdmrLmKjOxpb1Dn4zJcsXS9?=
 =?us-ascii?Q?7VzwjvgwsfbeyK/Y96Fx2B8bMWSqb2oWMUwxYrhP2MinNjuP4e4EtF3jXNF/?=
 =?us-ascii?Q?IILRy+JfHzdvt1qWzCe+X3xgYZ4MMpPuIHRmU/USl+f1BA/22y0XOH5u/KY7?=
 =?us-ascii?Q?EvrXj8TrC9/W2wjxdZccMIvmt/AN3WWBaeYxudeh9+Lf7s43sNKtYxtGJw0N?=
 =?us-ascii?Q?8PdX8gd98dLmf8CKUuoYYRSKeQ03QZLySId17bB81HrUZLvB0947iz3kwQWF?=
 =?us-ascii?Q?AawuKjp5iNKvee+pyL91/5arad4cnnbqoWcdbFOmvXmcRPAyxNeZq9sC8P/z?=
 =?us-ascii?Q?QgmuZOVV6QHQvTv7EDpim9AfUabwNLE8bR1eAnLKgx15ZzwAoE2MDPYHKZnX?=
 =?us-ascii?Q?pd3zQTWQ6ZxNApfxTdhoXfSK/XmAlROZIbpYL6KLO8je7P92xrk23MHZXnEF?=
 =?us-ascii?Q?9UbH5yiGIX5aaZVQMkY3EuFVwYhxivfykC/LED6PC+oLctDDAPLPyYMX+9It?=
 =?us-ascii?Q?PxZTQJMA3+3mw0F379Fn/RqltpmAIs5ZCxlhUc+v/TmI18BNhy13k2RMosim?=
 =?us-ascii?Q?yaZ5Bb+WYywKYvnK0fe5lyrRCvZVuCAlZwWKt7IS/aVvK/9TfzlasWDcCn3w?=
 =?us-ascii?Q?bfrPnHJAO4tBCgIg2iynvZs+GiPAL2Qbn2KvaFAIaT/pj2k+uJTX1mpNTMF6?=
 =?us-ascii?Q?3dHFsJKBI9Pxl3kCmg9xSpo0FLVhqnmtVo797CzZ1LerQgrWCUfL08arUJBL?=
 =?us-ascii?Q?UUHsi1Cn2FP2nDpDM0eH/veIMBlNR9se+rMU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7451.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SDSprY6fUAhEKKqG8qiGxqYrMB0185zafuR6dvwuYeRhy/6X0BoW10L5v74I?=
 =?us-ascii?Q?qsD9sSzpLeOGJQC+KDeQ6eET+044O6lqFhDTDNs48FiIUgATXeP4tMCaM15z?=
 =?us-ascii?Q?Lj4fSaXxxIHR5vYGUeCESOcr2C+16kA3T/AZxkArY2gZecI1VSpOfRJguhgW?=
 =?us-ascii?Q?aSeq7tW3A8wRHVxQzjF9bhrGWmNrcTAkrPENp669ZoSXSGmryuDLlU6of7Ek?=
 =?us-ascii?Q?XfQB4kSiPwH81Aup6FGfqGQBoloF5CxrCvxKAWLHqTHNspehR1ZW+EZ3X9ez?=
 =?us-ascii?Q?yOTN/ZFKL75b0M0Fm6hhupcUjFYycKyyVYKpjzkHmfeLc5k0nIE0rKAM/4sF?=
 =?us-ascii?Q?Wqzbb5GVnGDMiOpL++QMR2vi727Bafk2TAKwKSi/cSmD7uHWNyKvO8UpXJ7p?=
 =?us-ascii?Q?5v91CMMSayCh3U8ddx6m+bYZw9h50KUy1QBiAMQG7c2lPn4DzIaZvkjpP8zF?=
 =?us-ascii?Q?mEJPwRsPvd/bi4xdNRj8569AX4NBftOU5fwi277j7gebWO0ZvjYg8nptx0eP?=
 =?us-ascii?Q?SJ0F9aYvbA5hls7+UWDNDnWOho+EjQVaGxKk5jjFsEFlfMB6oG/kCscEzEgI?=
 =?us-ascii?Q?4mBbbfIWBw76CPB65NivRRcJC7j5O03TPeihbcEEYfABYbPtScPQOeL833uw?=
 =?us-ascii?Q?KnGhiF5XIdZgtiywo4czAACYWDTI3mL7aT5L/7ZBufZ66qiDu2rR8EcoY3ai?=
 =?us-ascii?Q?+4SEiURUZi1ghfmX7NK3r/Ya6NorJWHoxNeZqBRE2R8ICqPuYR9CcbxwoR6Y?=
 =?us-ascii?Q?9dVIV0zEDNcF/RdoNB82e3Gu4c0Gt1Z0n1cpEECN/wCBYQUBD6Mv+tsfJhlU?=
 =?us-ascii?Q?+mQgC+5rOpv0o1ylG3UfJKSe/wwl1xBLYZv5fq/5J/QJiOniXIJ6SWVE84I9?=
 =?us-ascii?Q?je5ryxxmh5gyf21p6KUutj2bixdqNpuV/Yt0rTUkaDui5wQVOwzCNmfHdS7s?=
 =?us-ascii?Q?mgKTuXaPgEp4OsuswOQZQI1TSUbWiLPCo1u8TMb7DR/Nv4rgMoGIdIAexdHF?=
 =?us-ascii?Q?V5qfYKNLX8DySP+zZGM8fbDmDegi83L7YgzwJ8cD9uiGga6ISmIyGEZHUxBD?=
 =?us-ascii?Q?ICYSPWpYo13mN4ZFGbS0Yp5GMM7bOD2YD8wJukpLfkh2s5+pojBXn1vTxk8u?=
 =?us-ascii?Q?UPQarXgmvP5w2+eTA27+rPF7xPfRGfK1AjCkuIDMoZ53gYOfurcF7kSbcdVa?=
 =?us-ascii?Q?C3r6D5J0hjPIgdT8Su2vsl7kbItLcrx/jsrgQN2IWfk2uWoEoLnx7NzKuNzC?=
 =?us-ascii?Q?zxSOEY4LNjLgDnWRC3n7aKPNLyMaXqm8YFSfn2XYMtFAjV/DXLG5nmQKGeUF?=
 =?us-ascii?Q?8wDWmEiT/EqLQ1tyJRalXMYdvAYiYqNbNElOh7rIVWE8oJDqjVv+SDNrsnmq?=
 =?us-ascii?Q?Yf99W/c+QOQt1xHDIWB6YJLBYIO2UAWWpRML7TsJiqJc49Q9gXAKC8zbjvlH?=
 =?us-ascii?Q?v9YgXsChoqnZ2xCqe34b56TwH85y4br7MW8oMHzVrEDPIqC6P3DHdqVD4GkD?=
 =?us-ascii?Q?g5AcoXxGU/bx/H2dsDe2RXIzJ9dT7w456UpFBt25HYGU17fj+DgdZ3o0wa0U?=
 =?us-ascii?Q?Q4WusKm7y+DPdqLh2h4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7451.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf20543-ed69-49f1-1fd5-08de206871ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 14:50:08.8838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z91flZ94wMJzF72AuwcPw9TNFu9WQPBuwwV2wSo+cAPjmPXYjNdStVkp8jdB+3or
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
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

Ping

> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Friday, November 7, 2025 7:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Six, Lancelot <Lancelot.Six@amd.com>; Yang, Phi=
lip
> <Philip.Yang@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: [PATCH] drm/amdkfd: relax checks for over allocation of save are=
a
>
> Over allocation of save area is not fatal, only under allocation is.
> ROCm has various components that independently claim authority over save
> area size.
>
> Unless KFD decides to claim single authority, relax size checks.
>
> v2: remove warning
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index a65c67cf56ff..f1e7583650c4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -297,16 +297,16 @@ int kfd_queue_acquire_buffers(struct
> kfd_process_device *pdd, struct queue_prope
>               goto out_err_unreserve;
>       }
>
> -     if (properties->ctx_save_restore_area_size !=3D topo_dev-
> >node_props.cwsr_size) {
> -             pr_debug("queue cwsr size 0x%x not equal to node cwsr size
> 0x%x\n",
> +     if (properties->ctx_save_restore_area_size < topo_dev-
> >node_props.cwsr_size) {
> +             pr_debug("queue cwsr size 0x%x not sufficient for node cwsr=
 size
> 0x%x\n",
>                       properties->ctx_save_restore_area_size,
>                       topo_dev->node_props.cwsr_size);
>               err =3D -EINVAL;
>               goto out_err_unreserve;
>       }
>
> -     total_cwsr_size =3D (topo_dev->node_props.cwsr_size + topo_dev-
> >node_props.debug_memory_size)
> -                       * NUM_XCC(pdd->dev->xcc_mask);
> +     total_cwsr_size =3D (properties->ctx_save_restore_area_size +
> +                        topo_dev->node_props.debug_memory_size) *
> NUM_XCC(pdd->dev->xcc_mask);
>       total_cwsr_size =3D ALIGN(total_cwsr_size, PAGE_SIZE);
>
>       err =3D kfd_queue_buffer_get(vm, (void *)properties-
> >ctx_save_restore_area_address,
> @@ -352,8 +352,8 @@ int kfd_queue_release_buffers(struct kfd_process_devi=
ce
> *pdd, struct queue_prope
>       topo_dev =3D kfd_topology_device_by_id(pdd->dev->id);
>       if (!topo_dev)
>               return -EINVAL;
> -     total_cwsr_size =3D (topo_dev->node_props.cwsr_size + topo_dev-
> >node_props.debug_memory_size)
> -                       * NUM_XCC(pdd->dev->xcc_mask);
> +     total_cwsr_size =3D (properties->ctx_save_restore_area_size +
> +                        topo_dev->node_props.debug_memory_size) *
> NUM_XCC(pdd->dev->xcc_mask);
>       total_cwsr_size =3D ALIGN(total_cwsr_size, PAGE_SIZE);
>
>       kfd_queue_buffer_svm_put(pdd, properties-
> >ctx_save_restore_area_address, total_cwsr_size);
> --
> 2.34.1

