Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422C3CD98CE
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 12:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C74B710EEF3;
	Thu, 11 Jun 2026 12:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h1TnzbsD";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013031.outbound.protection.outlook.com
 [40.93.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A67510EEF3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 12:54:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEGUC1JsBrkIiZ4JGL5DM6HxSUqFQy0ehNwSW4o7REAFQzRArJV8odjSKhzviwXH2bTdRrMzi7cBuWe9/Cre6NhFIYNK2T/xjbil4Li1tX68sVk07pcUVe32fFNa4dziL26F+Yi+va1TA9N6zIVj8G3P1gtJ+x44IAD2T3yj1ExCd3U392Nh0fkAWA0+Q1jumGk0AsQ3OapHD8+LdLb+7F7JK0Op2zXsjbezwU6IJGQsuYK48hAShOSVuqXS/M5qlAld5yOSSfJeBcVhopybMftB6kDr9Wt54w9+XYJZTbghlVQdydcOyRC6N3pho+FCIU93TSk3SBvDg84eUMqcbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlxHVjmbF+xohWmpogmJ8MFbEZchdMH6xEPkv/9+5Eg=;
 b=VjzTamPC0iuhKENuGU5Y5w6FQjYPFOujdeze8cXduSyTUuHAJgNKkyS2cjmwJyuyqnGYU6V32X1xtTE52nD5MVgBOfTbPCiptex8Vt/bDs16IkOCZqrMOVkRh1ScIxq7vzp782kDDmLJGm1Lrmq50baQZtKnpjTg9Li0lGh/nW3jhJd+X5qU8hEETgO1XS0nNpcRD9bYr16AKCAMgQu62PLZwwJJ7FxbJJNi90dtNia5EqNWbbH5m/QTXbkh+XxBlWWqjN6lgYkf3OWPps4wEk5pIZHZbcdpcnQNi/XjXsl50m64wvnLLj9HpwGT1hl+rTW5Fu+if8kSkUlw7Fqu5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlxHVjmbF+xohWmpogmJ8MFbEZchdMH6xEPkv/9+5Eg=;
 b=h1TnzbsDpXVKdquZYGtomQnKJoBKMrSJr6RVzzaySS3J/Wnw3Lm0LKJYtlb/e3PanTQ86E30oRpcv6Ghg21khLE4wwQeeHP+JBstduwy2tkvrQR9J5WTCFskvjnfpEkB7ZgdZW6sGt+78t+A88MAt+cJjUoYh7XNuvtWUTpEwGg=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Thu, 11 Jun
 2026 12:54:02 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%5]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 12:54:02 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "McRae, Geoffrey" <Geoffrey.McRae@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "McRae,
 Geoffrey" <Geoffrey.McRae@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix NULL deref during sysfs teardown
Thread-Topic: [PATCH] drm/amdkfd: Fix NULL deref during sysfs teardown
Thread-Index: AQHc+U/xmf9y8NMDiU2XzTdZBqotALY5T5/w
Date: Thu, 11 Jun 2026 12:54:02 +0000
Message-ID: <BL1PR12MB589873F3653A1647F74FEC99851B2@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260611030150.3713054-1-geoffrey.mcrae@amd.com>
In-Reply-To: <20260611030150.3713054-1-geoffrey.mcrae@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-11T12:52:12.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|SA0PR12MB4384:EE_
x-ms-office365-filtering-correlation-id: 50ac3771-051c-4fb3-12ff-08dec7b8832b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|38070700021|56012099006|11063799006;
x-microsoft-antispam-message-info: 0zxrLsqNTsglEO1Ynr/tyqoD+rCkLt8I6oquGIXywBpiBmx8tSWDf98SzRFnmbc3SyeVyhd29NBs5ZE2IhyQNBFTnrYJ+vIuQLW9h5ZkJYE6KdCR4y0NDsf23Tl7PNhsn6nVVCM/kntD1I9nUXtbLzIyp2QYwRScM7dsAp3x+KEMYbUPF/YItqwky/jl5yEF7IRK5hgEi5FtlqFnalmt0F2rRoHpkrKU1s5U7PlH0uJX5kE/un4CO6d1qfLe/yiMZr85WF93NdNwKFs1SnT5DYCSlPG7pGGMo3rcAyYaS1mP9QHx8BMxImuNkMPcbI0QtLXQkbG3lMh+iwOQZv9N+Cs06kbvHoSEz4kFAZGbYLLszNmC3iABo9zUpx1VnitCsvQYCH2NFG1k2gFHPswEb2t+K+zUk92HtiqDXZGZp2P9L+25bg7iFhpibgfPt5uSR5W4dubWAe9uFlzZq8iaMjeo0DHJ0vpy+1TtMzZMI7kw62hjKQZZ+4D/KqoiN9JMf4jqorDSopkL6OPznzqvtPQKBAZkK1UqIn3rsePTS9+NrTf8HH2Iv3LvoDP+xdvPChvj7KmTo5rQ4BkUI9De1FG4LtQWYBBjxw4GkKir1aQ0szNtiSeA2fvXp72WohGNMQnxPuzCyZN8QxLhskDo1Y2Zy18U2mDJt+suMbh4df0SvguOAF0w5GNhZRNWrCj6qj6kYAMTaQauHmgLHW6rBLF6HQiqBQfFPXMqqxcDX/98+EDhBAakL/c3M1dz8SUq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W5Qlig/YMMh2QEN/+24uWykXjVdJpykAtyJs8bHrWG/zZz9aTqaGru8qTGoN?=
 =?us-ascii?Q?O0ahETKpjP/D5dHl41DZZQzj4j2K5lPDSigK1Pc3uRzRAN0o4ls/Oipcnl/W?=
 =?us-ascii?Q?HLkApFmzYLyYcclXNDox59BJ8O0SJ48h/CCorJcS74cRxssOgEvC/RGrEBuz?=
 =?us-ascii?Q?XEdiHzB5ebFkxi9WzTZg5LvyqsWszS26b3MALoD3+x8ej9UprTCd9gHHQaw9?=
 =?us-ascii?Q?xbAxAcB7PwsILjs9GFoapPyNcT2f3/8ATvaUHHQs6mM2GW8lg9frEn1vlMLt?=
 =?us-ascii?Q?gkwfXA3LRNkHjhaot54wtYMApmPruup8Rk6qO1MPR7JUUOHAC4NNYr0CdgJr?=
 =?us-ascii?Q?KEsiqrnvd0xI4Y429FwOc/BAVxpnR4/7BrPupGYxbOkHRYS2wvGuLTR+cIhx?=
 =?us-ascii?Q?qyQuQE52EkEikp0id7muWnlhiBE29I/Z2lv71tzAFKvxaoOf/ZVah41BvYQU?=
 =?us-ascii?Q?Zyuc7nNvDGgl+4BZmF9FLk39+ljzsXA95CffhiACOM8ux09FAsfbCGW0aiy4?=
 =?us-ascii?Q?yuEx8FXrex3ripD04L3gsbW2OIXI5RFZxcqqusbv/T/pHkOjtPINb1woh8Zm?=
 =?us-ascii?Q?TiXsiZi7iHCn394v2cH4iODGp5IYgG/5DXsUNYnNe92409FEoy0h+AqJdC5R?=
 =?us-ascii?Q?whDU8NVRDBsIsBYZ+d2rsNyIF7GYiUHSzlmLAS8jES29h2WrAM1DF8yKBCAy?=
 =?us-ascii?Q?ITURkhfzLIR0W3YXO1gO8EFCgyN8sF+7BbcKmID/7AIAx84hCEiqUrmnNt1F?=
 =?us-ascii?Q?2rUFpbANpTGP3UmfOeVeKTVfl+9KBZzgIZ4yEnBN5GN2LVWAEopk4oxhkVhY?=
 =?us-ascii?Q?0+aMIK73Khrgyb8nm+ACYS9Ay/IkfSj5Xz0zUzqIlmY2d29g+YWRmPYII7LC?=
 =?us-ascii?Q?ro5YBfVI3snSW8CYWqoGzpbc/lNFk7vdDePL4rTU9Oie31JY/+kCq6i5b7+T?=
 =?us-ascii?Q?YqwEcKI3VY1lE9QiZD6coqviCbAewWQmGfn6LPiP27X8Qz+z/VeG/yyZjIU9?=
 =?us-ascii?Q?dFK/SJv+WXbalTpWyJ4GXBOZq2fGCLiSn4eAPegsADFwc/9bCvlL2x4Gf6nj?=
 =?us-ascii?Q?tIWz3z5Ohy+Hs21l1oGzdjStDsxfhg2T0+5/N0A8rqWVkcn6D+nt9ayeQK1o?=
 =?us-ascii?Q?91b5bIhm9Be4AT/O6mcIbAPrkzaL6nQH7+VrJ97nWSi14VhrgjnEnSEeJbF1?=
 =?us-ascii?Q?w6psoQQYMQF9l7yGv/z4elfxMyBI1QCrLB6+PJ4UswSl8e8OgD6o9G1OUNdG?=
 =?us-ascii?Q?eWe/CatdYKQPXlLILPY39JGiAe3OGwbOdAfvV1rpDeOl08z8tzGGeFyfHMeQ?=
 =?us-ascii?Q?bzSwiSVkKwNLxrAvYc7yxX1Q5GKhHuYi29RjCDnE7GW1ec9ZjSUTBoRtTU93?=
 =?us-ascii?Q?zioe3sC+FvMINmJ7tJE4qcFJ0Vc4TRHXNJiF7iBNaI8DgRKwx51/yNmU/24l?=
 =?us-ascii?Q?bWxVdAiUD2k0kkbXUCwh5gKlO6IMKgpS/HCR3h24QeuG42OEN8rQ81oRoO7R?=
 =?us-ascii?Q?HbcWAB+44joMuEXA6r61nxXGUqJ28XveEa4Jfz/WCbLBEPr8MvTKWjW0HTxr?=
 =?us-ascii?Q?03GQ/H5SDU0DMtU5VQCIuXSoXY2qL9ssMWRaCPTnvDXT4V+/kSXAeK/XidFF?=
 =?us-ascii?Q?yeTYqRZtwYh/YwYrj/JEYrL9owrX2uP38WjLSmz8XiVqqOYaWOpj0rKmnLz9?=
 =?us-ascii?Q?VV0drGrc4Ku7oRPFJklqtZfup0YyTbdch07UkOB1E60Nem7J?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ac3771-051c-4fb3-12ff-08dec7b8832b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 12:54:02.1520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CaIqyJeov/QFsMjggCSGO77CWeBr2DF+fm/qogmPSXaSSxN4j9gJVbFiuCOK0VYIdHdSR3IEMn1s1/+zArP9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
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

Comment inline

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Geoffr=
ey
> McRae
> Sent: June 10, 2026 11:02 PM
> To: Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org; McRae, Geoffrey <Geoffrey.McRae@amd.com>
> Subject: [PATCH] drm/amdkfd: Fix NULL deref during sysfs teardown
>
> Move kfd_process_remove_sysfs() earlier in
> kfd_process_wq_release() so that all sysfs/procfs entries are
> removed before tearing down PDDs and dropping lead_thread.
> The per-process sysfs attributes are backed by struct
> kfd_process_device, and their show/store callbacks dereference
> PDD fields. Since sysfs removal waits for active callbacks to
> complete, removing these entries first closes a race where
> userspace reads sdma_* and stats_* files after PDD teardown.
>
> This race caused NULL pointer dereferences observed in
> kfd_sdma_activity_worker and kfd_procfs_stats_show.
>
> Also harden kfd_process_remove_sysfs() against partially
> initialized or already-freed objects:
> - Check kobj_queues before removing PASID and deleting it
> - Skip NULL pdd entries
> - Guard kobj_stats and kobj_counters before use
>
> These checks prevent invalid dereferences during cleanup.
>
> Fixes: NULL pointer dereference in KFD sysfs/procfs stats paths
> Change-Id: I405b8fb95d3c5e163dfc45928da54f31546d92cc
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 44 +++++++++++++++---------
>  1 file changed, 28 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d28ca581cad0..b47e7dac8b2d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1160,28 +1160,36 @@ static void kfd_process_remove_sysfs(struct
> kfd_process *p)
>       if (!p->kobj)
>               return;
>
> -     sysfs_remove_file(p->kobj, &p->attr_pasid);
> -     kobject_del(p->kobj_queues);
> -     kobject_put(p->kobj_queues);
> -     p->kobj_queues =3D NULL;
> +     if (p->kobj_queues) {
> +             sysfs_remove_file(p->kobj, &p->attr_pasid);
> +             kobject_del(p->kobj_queues);
> +             kobject_put(p->kobj_queues);
> +             p->kobj_queues =3D NULL;
> +     }
>
>       for (i =3D 0; i < p->n_pdds; i++) {
>               pdd =3D p->pdds[i];
> +             if (!pdd)
> +                     continue;

I'm not sure about this check. Did you see a case where pdd was NULL? I thi=
nk the rest of the patch should cover the case you saw.

 Kent

>
>               sysfs_remove_file(p->kobj, &pdd->attr_vram);
>               sysfs_remove_file(p->kobj, &pdd->attr_sdma);
>
> -             sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
> -             if (pdd->dev->kfd2kgd->get_cu_occupancy)
> -                     sysfs_remove_file(pdd->kobj_stats,
> -                                       &pdd->attr_cu_occupancy);
> -             kobject_del(pdd->kobj_stats);
> -             kobject_put(pdd->kobj_stats);
> -             pdd->kobj_stats =3D NULL;
> +             if (pdd->kobj_stats) {
> +                     sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict=
);
> +                     if (pdd->dev->kfd2kgd->get_cu_occupancy)
> +                             sysfs_remove_file(pdd->kobj_stats,
> +                                               &pdd->attr_cu_occupancy);
> +                     kobject_del(pdd->kobj_stats);
> +                     kobject_put(pdd->kobj_stats);
> +                     pdd->kobj_stats =3D NULL;
> +             }
>       }
>
>       for_each_set_bit(i, p->svms.bitmap_supported, p->n_pdds) {
>               pdd =3D p->pdds[i];
> +             if (!pdd || !pdd->kobj_counters)
> +                     continue;
>
>               sysfs_remove_file(pdd->kobj_counters, &pdd->attr_faults);
>               sysfs_remove_file(pdd->kobj_counters, &pdd->attr_page_in);
> @@ -1239,6 +1247,15 @@ static void kfd_process_wq_release(struct
> work_struct *work)
>
>       kfd_debugfs_remove_process(p);
>
> +       /*
> +     * Remove proc/sysfs entries before tearing down PDDs or dropping
> +     * lead_thread. The per-process sysfs attributes are embedded in
> +     * struct kfd_process_device and the show callbacks dereference PDD
> +     * fields. sysfs removal waits for active show/store callbacks, so t=
his
> +     * closes a race with userspace reading sdma_*/stats_* files.
> +     */
> +     kfd_process_remove_sysfs(p);
> +
>       kfd_process_kunmap_signal_bo(p);
>       kfd_process_free_outstanding_kfd_bos(p);
>       svm_range_list_fini(p);
> @@ -1252,11 +1269,6 @@ static void kfd_process_wq_release(struct
> work_struct *work)
>
>       put_task_struct(p->lead_thread);
>
> -     /* the last step is removing process entries under /sys
> -      * to indicate the process has been terminated.
> -      */
> -     kfd_process_remove_sysfs(p);
> -
>       kfree(p);
>  }
>
> --
> 2.43.0

