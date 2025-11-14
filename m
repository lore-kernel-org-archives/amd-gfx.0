Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A784DCE8D5D
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 17:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35E7410E24D;
	Fri, 14 Nov 2025 17:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j0jFFLNM";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0381810E24D
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 17:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/t2vlI27KqzbCINGlJpnSrkxVP4nPq8cLgh/8Tk8a0mKshVWNfi17C06reXg+u9qqapmzvskWhluMMMiMzvPr/WOnbMJ5WCB/BOtFVgI4ffsvMf4H1pAbPnDI75cWoFxPuibjFpt3+k9WVpevHwdWyRm/W8mu9A8dAu1k/Euyx+WVQQw6HdyIyWt4kVaqEq423wpQpRrCNgWP+ohjr4nLEoPEsSugVGogQrd2KoydAUUl4MXPbEIFlUbY8pKYk0y4md+fpgicqFEJfShsABACqnmmlGN8tBzlpk4J+dOkbCWYZ1+rXMkaMgPeCDwHZkuKu/8mXn3FdXdV4mMDzV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZOsleWpPD8xiz5L8pTBd2CF7DfhMZXXZHp9t9dmN9U=;
 b=IfDOAuBnXtIFvugbq8KFpJtLSZBptmewZnf8tFVaffaBk0qu1RyWOMwxeSn2qqzVjBjzGCOau5XUszq5PyZfY5FYMWYN7tQfhYy9wLtK/NfTMkARclDpYv8LC6hv/uglLgNlOjF+4M21Xet3mVCkWVdk57tMSnP1II9KsDtqotaj3ytpvsd9alZVlgbanyEZ5U9qAtMtpHSsrl2aMsvx4cVe/rHRWoads7IpG2uBobcuE05rC38fzJcieUi6XNA7AG1alGg2Wwih2shLOiYz77EUMk7oS5T1OIseqlLsJTVyR8C4TRl/56GieKbAuIX0wUkAbcOCGyMFIJ3ixWKPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZOsleWpPD8xiz5L8pTBd2CF7DfhMZXXZHp9t9dmN9U=;
 b=j0jFFLNMd4uE7/cMHadmt9a5ilqizM+D/NubLJS9fSX3tDuy8V+/6j+T+Nnss2omiS0LneExKCQ7kCmZ4kTYCKcf6Bc3+a8vwu9vMFoA7qOE+vMm7z6L8LgFSH/trsvS6afjh7jNZi4AuTq2kodlCudlG1BNtiy572T+hBpkmno=
Received: from PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 17:02:40 +0000
Received: from PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::f2f6:3e9d:fee3:7741]) by PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::f2f6:3e9d:fee3:7741%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 17:02:40 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Martin, Andrew" <Andrew.Martin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Martin, Andrew" <Andrew.Martin@amd.com>
Subject: RE: [PATCH] drm/amdkfd: FORWARD NULL
Thread-Topic: [PATCH] drm/amdkfd: FORWARD NULL
Thread-Index: AQHcVXS0I6eQIVrWZk6mlM0TTKmMwrTyXX6w
Date: Fri, 14 Nov 2025 17:02:39 +0000
Message-ID: <PH7PR12MB590242762FBB162CCE923A0385CAA@PH7PR12MB5902.namprd12.prod.outlook.com>
References: <20251114144033.1432008-1-andrew.martin@amd.com>
In-Reply-To: <20251114144033.1432008-1-andrew.martin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-14T16:32:01.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5902:EE_|SA3PR12MB9199:EE_
x-ms-office365-filtering-correlation-id: 17e9a7ce-d331-4b4c-1918-08de239f9ea9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?n2GFJ4rpxgUE/eSvPvrUpAshy8WGeqxBWDZW+m8RmRaHDjrDNvV5kQ68L4zh?=
 =?us-ascii?Q?EW8jofT6KdiubyS26nuhcq5cMFD//LYAvT2b92JUnqWOb35tPyBr85KrnqFn?=
 =?us-ascii?Q?HNpOLL9SpDa2srwGuhGb4Z+jRotZKDnm9snGSjcziZXfGKubcZ6JCQff5/K8?=
 =?us-ascii?Q?SFFAS7+cawPMCr+vvWvkcFwfbHBakWnACn4W0DIkWO3CIu1IHhdNps0jwhtu?=
 =?us-ascii?Q?9AI7ANEvVu/KIxXsYHJdZNIE/YCliY4ZSRZD2ybF0cM7TJPseQKqECLUDf3E?=
 =?us-ascii?Q?9g1vtrSVnLFhqiHqvxBXUwjqDxvdbHpfCU61fm9AiWQcV4noUeCgBijJ3Xzz?=
 =?us-ascii?Q?lvu341/6SENPUsTwMFNs6XP1A2Nj+sdJ40LkrkqnxrXmhvEKE4Tq0z4q5IOV?=
 =?us-ascii?Q?1sfNnuEh9TXoU/dXSV9Pb2ckuvcf1uIuRRZP2D6ZhhONS6P7TTPjo0XpvPuD?=
 =?us-ascii?Q?NHxtZeG0U0CUvw+i/Nmy/XiXcbVovhM53raXOff7iNz36yDbQlfp028nchPK?=
 =?us-ascii?Q?q1aswXrdJL4zDWVyKON8rHE2E4Rti48FzJQzJpg589PTtY3W1qjOqit5Wfdq?=
 =?us-ascii?Q?tR5PaWGiGezclzXP34dBVCMqYBgGDwPmLKOHdrhivdTetuVaTMdDW+zV6YbA?=
 =?us-ascii?Q?VgwLuZJn1oPJI18YvsJXSxkn3AccanHbvx3UF2Ty2r56PQUdLp8o9O9EjvdZ?=
 =?us-ascii?Q?Pe/1OpkrUqhC1FD2+i1iDwzGmmykdU8DRlKC4w2nkhhhzGRPeaRGTrL9tJmF?=
 =?us-ascii?Q?1g/KIsK3e0/tQBLfYRR5F3vwuj8Z1EPyZm6dgzUZvGm7OoBwvw7x4dODXM96?=
 =?us-ascii?Q?6qT5ZIRLClV6zaOP2+yeFyEc30qMWOgyXNUJYnIpJyI+ZA0eUULDGRyU1qg0?=
 =?us-ascii?Q?e2P92ygZ3xigYftDzkO/6aO2OZa9fQ5lj7D5Wnk6nMTDeKFrKF/oXHPuMLUa?=
 =?us-ascii?Q?TxGOB7r4FilA5Gv8kQTJakQmnpwQxu2/xVZY3uacMkSrvoGjjeRKMiHbePEA?=
 =?us-ascii?Q?G2VIgOSFfv45xSqdLFo7EeTNKe5Xz1Wecd/fElu8g9J5op9/5Md6x0LyjZ70?=
 =?us-ascii?Q?ptFg+ftOk6mlbXciCuqdEs3GRU7RcAYufdb7cT2OemWyQwIPGRRiRPTDACA6?=
 =?us-ascii?Q?Ie1XNQ6QmvIZrSlDnYIKr9AbO14kyqq9mbTCAMbFosb8cGZzQVpggNXkYFCt?=
 =?us-ascii?Q?YRIQ+ZMI9B2RKH/WCsP6gqK+PczKvpWCEhBxxb1RvQgLC1iKSsCfc+JQg4Y2?=
 =?us-ascii?Q?ZZMvi8sU14HRxBEDnJVzy4OY/se9QLREaJEEBtLY2St+VCZMk5M014KP3gWS?=
 =?us-ascii?Q?szILEphQbu7PQ8KLBFz6ZSx5UFgXIoyE0EPlc6slv8uwCEjNdV4SP5dFL1cF?=
 =?us-ascii?Q?N2lm5QwA8c8AmaCJDcFy+0FxvbA0ufR6Eu2qJGhh9/ZE+MEwugy/kVIkBrDs?=
 =?us-ascii?Q?ldkA/nWLWwaySbVY0HRDJVqtOqYzaQhZDH+dpGm5uX8pTl+qu6gogX33Gxz6?=
 =?us-ascii?Q?tTF+SDboGIy6+OD2gNsPBxb99iAuu9fVU0vi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5902.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Il9iaByrJwDULO6ciERerNAdfeOiPIndCMwiUgkDMCEDzmQ1+PEn/kCPAf+T?=
 =?us-ascii?Q?rb6mgOcPaI58hnrBpuZQgNZVj6uwJBOM6iYN+IWL4MlddW4iiI+QkyF6Kf4z?=
 =?us-ascii?Q?KG5/a93ohtuW8P8Cl/JQ7hvpHU+m+lj12LNdZZG7Iv3+jEkID3Rs0vYRVcBt?=
 =?us-ascii?Q?dPWl27xVXuq3EZFTUuYArQfrFyKiNaSKle0aIVusrblw11zCfzhNT9+yXYg8?=
 =?us-ascii?Q?Bag4MspiGba26oxUQ+rUh5hAMXZLGp2Zj1seqoAC/qTR5ZG/H18anWVz7iUd?=
 =?us-ascii?Q?Uz6/SxvpJCfJGlONRur9vtwgdcuh/eNzE1S/5YNACinePTbgEfOnJbwFy77Y?=
 =?us-ascii?Q?f7oenlrhS5e3xFyAwHud6WQNbQqSjKOz5g9zIbImbkp6OmOVo+xmR0Pfl8zM?=
 =?us-ascii?Q?FdAKKKJ3lo+aRkNYJjFjTz8qsHyXSak4gkSNZ26umb+tYCwgyBo7UwdvNnMt?=
 =?us-ascii?Q?hOZv1chlPxiVnJuKQ+FoQ76yCSxBMAt13JEx+vT2TyR42kLgWKU+XhZTKVnr?=
 =?us-ascii?Q?DC6Ptp1XF/TKtzHR8lSmsLfHpsNSewJWn41secR4Z3gNVXuS7UtHYQSxlwZ/?=
 =?us-ascii?Q?q9IAtV9ZSLwyH9PngaXsOoozbb7YlRAtYQw3BEBxBroh+W2x3d3AhlR1idRl?=
 =?us-ascii?Q?iFhoMENlQT3HIxfnQmH0qaidvvvFOPnIbpxbfp5IkPvrmkDTLt3hcD6iQLZw?=
 =?us-ascii?Q?PzlGY0z4K/DHrZflBzRJBlisOSgKMjv1atlFGdi/i4CQmGo8vU+U+TtCWJX9?=
 =?us-ascii?Q?a4ZpNEjVMq0R4JqpIhoddWAITmZxK4uEqwW9Tv/pThGJN/u9nOQ1KkoOPv43?=
 =?us-ascii?Q?i1e8SBwmlqndM14OSNTLlKRIV3UcL7snNgAxH4LvzDsGkIxGnk/5zMKaSJLi?=
 =?us-ascii?Q?77l1xci2EBcU2/PhfJubEzUqIEd8XeRVDHk5lX2tgndM5uR1PSk+kxaNtcy8?=
 =?us-ascii?Q?sCHmpEc18eVv8QYpuBwY3qJfoWFK2sHk/IWVzDWEVpHjf0iOKLT6cvy6y/mp?=
 =?us-ascii?Q?6yb9USXYsTMcy56jhEbND4utgCUMnN2Trboa6krs+/ggG0GtL+wiPnrO5C+Z?=
 =?us-ascii?Q?02EThn2e1ALR3yIdWVf2pdxoMfrAlYwcret3eBka4J6D74wTQMETuHU4uyZ/?=
 =?us-ascii?Q?nVxiOBxMk7HBBkZdXkH/SYv4XQstdnuPK2vJoNyCYLNcO1IQ4+avbcOnEhXy?=
 =?us-ascii?Q?dka/FfZnB3/f4ZaeFI3lHCXacfDM4yZMWjWoYqj6HXtA7+rCa4cq45kvvumx?=
 =?us-ascii?Q?1qzITUTdxSUiLTZmU01hWqfciUpN0DUIO7cDMTHIaoJKckhzRgKKR1zkrvvI?=
 =?us-ascii?Q?iV49972quhwQoQSwosDdBxCNIQUs3OWa8b57bANPGsGnNANSj6EtpwYdDDYc?=
 =?us-ascii?Q?S5AtCe86JLycRdLJ8o6rYSz5WScVx+myg8sI2TVNP98BpSDNnmxNgdlyv6vq?=
 =?us-ascii?Q?NKoztFcOVkqcKBB0pGHfDJzMQzoI6xJjzPlCXrI774yMudcg0lJKcQdT0R4j?=
 =?us-ascii?Q?DV+pdFWc+iLdBEiOXNOJbajU8Gs57rp3BU63aXzAaYbj96tPCzZDfaPmUEJB?=
 =?us-ascii?Q?+jOuD9/U/t8gZ7Jmyvw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e9a7ce-d331-4b4c-1918-08de239f9ea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 17:02:40.1544 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Hpqr/kuEc72orLWpEWMfEaC1BnDIHTLHrP/EF3I8bOuO7G5ZBXh7duwvQied65nRMliqdn71b8wLON3wAuLhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Andrew
> Martin
> Sent: Friday, November 14, 2025 9:41 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Martin, Andrew <Andrew.Martin@amd.com>
> Subject: [PATCH] drm/amdkfd: FORWARD NULL
>
> This patch fixes issues when the code moves forward with a potential
> NULL pointer, without checking.
>
> Signed-off-by: Andrew Martin <andrew.martin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 2 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c           | 6 +++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 3 +++
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> index 1ef758ac5076..71b7db5de69f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> @@ -104,6 +104,8 @@ static const char *amdkfd_fence_get_driver_name(struc=
t
> dma_fence *f)
>  static const char *amdkfd_fence_get_timeline_name(struct dma_fence *f)
>  {
>       struct amdgpu_amdkfd_fence *fence =3D to_amdgpu_amdkfd_fence(f);
> +     if (!fence)
> +             return NULL;

Felix can hopefully confirm, but we may need to have something here, since =
the references here expect something. Like in
#define AMDGPU_JOB_GET_TIMELINE_NAME(job) \
         job->base.s_fence->finished.ops->get_timeline_name(&job->base.s_fe=
nce->finished)

>
>       return fence->timeline_name;
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index ba99e0f258ae..42fa137bdb2f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -517,7 +517,9 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target=
,
> uint32_t *flags)
>
>       for (i =3D 0; i < target->n_pdds; i++) {
>               struct kfd_topology_device *topo_dev =3D
> -                             kfd_topology_device_by_id(target->pdds[i]->=
dev->id);
> +                     kfd_topology_device_by_id(target->pdds[i]->dev->id)=
;
> +             if (!topo_dev)
> +                     continue;
>               uint32_t caps =3D topo_dev->node_props.capability;
>
>               if (!(caps &
> HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED)
> &&
> @@ -1071,6 +1073,8 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process
> *target,
>       for (i =3D 0; i < tmp_num_devices; i++) {
>               struct kfd_process_device *pdd =3D target->pdds[i];
>               struct kfd_topology_device *topo_dev =3D
> kfd_topology_device_by_id(pdd->dev->id);
> +             if (!topo_dev)
> +                     continue;
>
>               device_info.gpu_id =3D pdd->dev->id;
>               device_info.exception_status =3D pdd->exception_status;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index f5d173f1ca3b..f40d93f82ede 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1685,6 +1685,9 @@ int kfd_process_device_init_vm(struct
> kfd_process_device *pdd,
>       struct kfd_node *dev;
>       int ret;
>
> +     if (!pdd)
> +             return -EINVAL;
> +
>       if (!drm_file)
>               return -EINVAL;

Probably easier to just combine the !pdd and !drm_file into the same check.

 Kent
>
> --
> 2.43.0

