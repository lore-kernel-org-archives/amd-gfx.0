Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02FED1715C
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 03:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4318510E0D1;
	Tue, 22 Oct 2024 03:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rSW5DtN6";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CEBB10E0D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 03:12:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5w6rCsdIRr3AkzAEqdHiKbTXAYq3KzJbv+iVZia4DTGRe1FdAP7i9mXd7jSGcKqWYHh5EXAihVKo/iGuDZZifF5nyb4PrjZYd2zMaticsTLwV3Vs0lSWOhldnD15YU5OfaAR0ZV/eAWj4ZAWEoH5TlpMZMWWUmUMExovTzeHgoaNEdr1uW4zyY1Uxym6Ob3LGSVHFUsupM9WqBqH1RNoK3MyTVxYPvfhqSC4shHv4yU+ZbPW9f4CrwSp1rpueLZY6pPFG3ZRzm63q6b5SbnjITJkBGU1q+V8+U+p7NapTQ/C65POlrzG4aXubcP3xUHi/iznkw5mEK/KVkI4GyZqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaN279fFAxgSxQI3pyHpMeFzjR16LAS5tekBSPDTJ2Y=;
 b=I3snpI+3O6tXerfSxYLXU45dB06FYgPN7H1rRm0cw4e7D4SBnePL/tCavDubZgrPQLBEYUvlqvt872AjA/IgNec46VD2CFp6rqZn/vVEZWW2N7/8/H+PUiILFDhZa8gwPh4hcQEkzSEU92I5WnxoDmc5DxN5BBOEi9tnzDHgWXetKzJdOz6nUL9+tB7pDvNjJAlWJCIXyldSFu8af8qpRURpQlfq5OCeaHqntgoUNhgZwswpHmduEKHt1Bn69q5ocVyGq+gf77sDXtAf9siOmJF8IYkO33aVNLKl1OmpIA5EwuQQqY7IAm3418hvPQMZH+ipFbJuAbftDFphH9XDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaN279fFAxgSxQI3pyHpMeFzjR16LAS5tekBSPDTJ2Y=;
 b=rSW5DtN6OgB98tBM6f7Nz32LIdzsI1JgncbGblGrzqp1FA6zWoABiVLSy0PBCZSD7tIc5AU5TT/rJYUhV+dEOmqfzENzkERJB9YFl9+gjmgqBodq8NlzZTbnwOnKz1EdOQbkOnauaifZxcgAt6v/NVyoIxNPZwmh/YugyvzgBDs=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 22 Oct
 2024 03:12:04 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%3]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 03:12:03 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: add amdgpu_gfx_sched_mask and
 amdgpu_compute_sched_mask debugfs
Thread-Topic: [PATCH 1/2] drm/amdgpu: add amdgpu_gfx_sched_mask and
 amdgpu_compute_sched_mask debugfs
Thread-Index: AQHbIQXFFOZ99iWltEmWi776q5v8W7KSHgWg
Date: Tue, 22 Oct 2024 03:12:03 +0000
Message-ID: <DM4PR12MB515215AA5944BC89E6AE2384E34C2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20241018023054.1601248-1-jesse.zhang@amd.com>
In-Reply-To: <20241018023054.1601248-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f2be1a6f-4d7f-4150-a542-0eb73b104ca0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-22T03:11:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SN7PR12MB6885:EE_
x-ms-office365-filtering-correlation-id: d9fb5107-2c19-4eb4-8976-08dcf2474d89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?EfTy/+pO5+e2993mb9YPBK6/RgSh5WgXB7sl+1zC22pobEf2ACsVx76afEA5?=
 =?us-ascii?Q?IvGNFkB/IIFs6FiicQzO27UyPVG48CvwgJGkh41JnboiymbyCBnAkd3ZISDE?=
 =?us-ascii?Q?mex7CvO1l/yIPzumCP9b/4fbsiSGnJmpAm9ipxPcUKoQRMAdDuBFVeRSlwEI?=
 =?us-ascii?Q?Z61Kv/AYt2VipBBeIEKXAsviTxD6RqcELoWux5Kh5+OfbXt2UOKK7KWfGSP9?=
 =?us-ascii?Q?Q/XZqCOPN/GBE1NdMVMBnUlJtku4sapRltpww2ZU6rEPWelbNIgsyAPWWIIu?=
 =?us-ascii?Q?dAgQd/rBhBoRJY8T3rN4ltS+YlIEWJT4Q2bm63XW8bNnn5345NxIHXaawcGV?=
 =?us-ascii?Q?BceHtUZQ93AvQ8APpdDnPJQtfKUwA9/0S0twJ6NJebn640thsS2xX0CtMqY6?=
 =?us-ascii?Q?Ygwd3CsKzlVORIFEZobFmL/rEWrdHcq7JrUMMfmfU6In6B1EQCHH9JORe+tt?=
 =?us-ascii?Q?LoWywlE2d6TA+WEpZQtJ/cVfBJ4GvjajrxtUGFLU6OcFUlUO7gR4xX6sf85U?=
 =?us-ascii?Q?znDba6F4/ZYR2RGBcPEsNRwB5QUw7wOXrE1E/HJ1syR04sFpiIk9RIoVL9f7?=
 =?us-ascii?Q?YrJdGSRZAdn7wbHr66vrFfkmy95VB4BaeqJiO3u2Fu7DwOlky1srooNpYBtt?=
 =?us-ascii?Q?LfwyGLdQiUsX3F91T9zBX22sipnhN5pQ75QZOukuVa6Vm4NIHwZC4dVcast3?=
 =?us-ascii?Q?P1bs6JgxA5EwpJCrdbu12zUzRUj5lhuPCz2XlbQcXPIbaxXCcxVr4pwdgumJ?=
 =?us-ascii?Q?w1ASOxipN03cvLFpJsjrhTgwM+d0CJfx11W+OAMi0yk2KW8AtURETIqAAfJW?=
 =?us-ascii?Q?zccrkDiJwK5CZslGqSL2b7HoVJHCZ69bkP0uhzLN7PUjQ0m+XhCOWZ6RbAHt?=
 =?us-ascii?Q?UIKaG3TSfqStClEAI6uyhlyydbsHA8twkQ9EvcJ9FPKGz4EZD0/fGMJQtCIj?=
 =?us-ascii?Q?2TSqqgoB8Rgdekku3Xy6OP6jEGqD7Cez1X5XLr38i5jri2/HigupnhEuzVu2?=
 =?us-ascii?Q?ziqmMQavZgt/la8an3nGQhxXHarucQ99umPmmE9uckau02i8AvcHhqpH1bbB?=
 =?us-ascii?Q?Uba9yi9dHPGZgcFetTMblXs2RjWCbyKpfo39LO0ZDHMzM9Q9t20Q2UvuFhbt?=
 =?us-ascii?Q?y21nu81QNzaeJgGx8fZnndEQgcOYfhN9pS51NGbUzj03h6HYQX5EHsub/b+T?=
 =?us-ascii?Q?h6rCUO82shKMG9BVZfj1KT0BEtN0gJovJpIzsngZijWp0ULYZNBSKUzC+Svn?=
 =?us-ascii?Q?SJrRs/nIOyusCeK0TDLPPhrieAtgFvmaVE+JemNUV8HOkBZUVyj9pB1L7G+w?=
 =?us-ascii?Q?vlFqDF9W/UNJkipNlNAKtyhPaVQ8EtM8QGjC11KdOLFGopkkOc7JdIxrwajy?=
 =?us-ascii?Q?AYOcv1s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MUhkuFDfu6Df/L9bgAlb1mubMqSyDooqMeiJdgfM4Ls4mpU6RgdCE/gFgDsz?=
 =?us-ascii?Q?4MDEJRoEtIDGl+cLK2FlxWpt2hnH3ijmPzzElBlCGsNIg2PkviiRwEStpiYp?=
 =?us-ascii?Q?2fHI/oYPS3dlkGenImiaJefB+w/OnY6nybBVtIWm32P7JhhW8O3YyyDdt1+j?=
 =?us-ascii?Q?HEqUjA4GqBVNRJEOgzBMab9TrtltbHeyfOBtIA/SkOOy0pJ1xX7VWXTPL4Aw?=
 =?us-ascii?Q?k9QIAC1YtyXiOrdTylz6E/mKm8PnBl0QzKe0F0q2giDTHKzcC4YvUcPQ/Avb?=
 =?us-ascii?Q?RdCgJ4oBboDGbJxh2Cc+hR6e9DvdCO6yAPBdo59GqgReTQdoQw2H4uQXiCF9?=
 =?us-ascii?Q?dWXz0s5ieBEL6yPTe9kni62oGKRZgnXBtsAxjKkQi0MoITzrkwBPsQUgFNCG?=
 =?us-ascii?Q?Bq91F9uS7xUv4KANRjvoPHZNyUaPuq8rfY0Pd62wXwYfVK/RXhN6z16XQWgR?=
 =?us-ascii?Q?zc2wD+TSiTtwElK9VhauCR5EzNtM9c2m0HRq0/3/kDmPpcrA5cIyW1rZ5iiF?=
 =?us-ascii?Q?L8O8DZS0iom7w5/iGR7dLlAUfHL9DwLdpLa5VhSODhWtIdnyCMktyyxMmRzt?=
 =?us-ascii?Q?SreJH3JyuVEAr1+Rp+0VO3oX0qawNUCoRKPqBD/MYhLy32dkfbjVhnrlmDn4?=
 =?us-ascii?Q?t4atMvSEvTVIQM6DqkyIYwgqaIvBt7/4BaE884L0MogJ5NWNkahmOeXpsP04?=
 =?us-ascii?Q?xIhlLGN7JbwATs5xhBPyN0lpSQ3LqL+OY/GDm6bIL+ba67i6vgfiGRN55uI0?=
 =?us-ascii?Q?YemkGjCt4JzUzG4QT6y7+q4iuo7j+OqHUVZ5mhof+61w7Ol7hKcSG/Oz3Yyq?=
 =?us-ascii?Q?/IAuiz4bN0L2n1E2m1bW8ZoAreyXffh5+DWx//YzL61CenZfgXVz/JsGvGUw?=
 =?us-ascii?Q?GVoeM9lQ+/UaoVUZCrhBKd3u0dfjKALvfaPUMLZIUaKcrbnj2zZ5haeRgx2v?=
 =?us-ascii?Q?+Qr5kVhCYkuoOKsrufJRTIiYnMyC0VjQ+loXqtmoQjRhv7pmdn06If8NKHak?=
 =?us-ascii?Q?fSMN/LuXk4d1nW7Opewavt76CLJktrO2I8C2/i8m1JP/X6FUhnsEanQ+OZV1?=
 =?us-ascii?Q?eRs04RN6rhKVTidwXc+v/dMNpDwRBD+NYF66p6awMdewQ9HL4NwSeGVrx3bR?=
 =?us-ascii?Q?Nd0Eg3HnefYsMGz05zYCw5DEwEkyHOnElpWodo/9e716G7LmxBiXwRXtKmvV?=
 =?us-ascii?Q?DKC8xSsjQ1QvxRJUnKpUrP0V8PSHjXLz5bpknOrRYTj4WikGgr3GRUbnDy3I?=
 =?us-ascii?Q?XSPP/hlGpciYfvb1FAqnFe7A8kysGgQBghpp7oCghV7ky8u/VIy2LRgnfuTk?=
 =?us-ascii?Q?IUiM/TXSfFza4DI/RUom3qWoy50NfAv3oZ+WQV/EIIQSbkBSCiP+hXdGLaQD?=
 =?us-ascii?Q?iU3ZpAZd67SttY2SvrUwkl3USpSzlkQQiiaRA+11abxe2KEo3xIst7kSURCx?=
 =?us-ascii?Q?c7vsGhRzDo2G7XSuO7lFwybDsZNLpMxmvaX5BZWm9mbtUdTR2pitzWToYfw6?=
 =?us-ascii?Q?DB/iKpJ2TPqcrxz1QiQBhdFTWpaJQJSxknFkfv7y6CNkxIuykrqGqozV4XtZ?=
 =?us-ascii?Q?Ek+JrVhtfNKQlG4PnmY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fb5107-2c19-4eb4-8976-08dcf2474d89
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 03:12:03.7202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIr77CIFGmpf3PQ9miBKTojjOVVoIYx29ub2LIOsuipQes2TbgvLcRvJ/DEw2ScMOuus/Q0njR2+iXAg9FN5pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885
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

Ping on this series?


-----Original Message-----
From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
Sent: Friday, October 18, 2024 10:31 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add amdgpu_gfx_sched_mask and amdgpu_compu=
te_sched_mask debugfs

compute/gfx may have multiple rings on some hardware.
In some cases, userspace wants to run jobs on a specific ring for validatio=
n purposes.
This debugfs entry helps to disable or enable submitting jobs to a specific=
 ring.
This entry is populated only if there are at least two or more cores in the=
 gfx/compute ip.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com> Suggested-by:Alex Deucher =
<alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c     | 142 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h     |   2 +
 3 files changed, 146 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 37d8657f0776..6e3f657cab9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2096,6 +2096,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
                amdgpu_debugfs_umsch_fwlog_init(adev, &adev->umsch_mm);

        amdgpu_debugfs_jpeg_sched_mask_init(adev);
+       amdgpu_debugfs_gfx_sched_mask_init(adev);
+       amdgpu_debugfs_compute_sched_mask_init(adev);

        amdgpu_ras_debugfs_create_all(adev);
        amdgpu_rap_debugfs_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index b6acbe923b6b..29997c9f68b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1868,3 +1868,145 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(stru=
ct amdgpu_ring *ring)
        }
        mutex_unlock(&adev->enforce_isolation_mutex);
 }
+
+/*
+ * debugfs for to enable/disable gfx job submission to specific core.
+ */
+#if defined(CONFIG_DEBUG_FS)
+static int amdgpu_debugfs_gfx_sched_mask_set(void *data, u64 val) {
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
+       u32 i;
+       u64 mask =3D 0;
+       struct amdgpu_ring *ring;
+
+       if (!adev)
+               return -ENODEV;
+
+       mask =3D (1 << adev->gfx.num_gfx_rings) - 1;
+       if ((val & mask) =3D=3D 0)
+               return -EINVAL;
+
+       for (i =3D 0; i < adev->gfx.num_gfx_rings; ++i) {
+               ring =3D &adev->gfx.gfx_ring[i];
+               if (val & (1 << i))
+                       ring->sched.ready =3D true;
+               else
+                       ring->sched.ready =3D false;
+       }
+       /* publish sched.ready flag update effective immediately across smp=
 */
+       smp_rmb();
+       return 0;
+}
+
+static int amdgpu_debugfs_gfx_sched_mask_get(void *data, u64 *val) {
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
+       u32 i;
+       u64 mask =3D 0;
+       struct amdgpu_ring *ring;
+
+       if (!adev)
+               return -ENODEV;
+       for (i =3D 0; i < adev->gfx.num_gfx_rings; ++i) {
+               ring =3D &adev->gfx.gfx_ring[i];
+               if (ring->sched.ready)
+                       mask |=3D 1 << i;
+       }
+
+       *val =3D mask;
+       return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gfx_sched_mask_fops,
+                        amdgpu_debugfs_gfx_sched_mask_get,
+                        amdgpu_debugfs_gfx_sched_mask_set, "%llx\n");
+
+#endif
+
+void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev) {
+#if defined(CONFIG_DEBUG_FS)
+       struct drm_minor *minor =3D adev_to_drm(adev)->primary;
+       struct dentry *root =3D minor->debugfs_root;
+       char name[32];
+
+       if (!(adev->gfx.num_gfx_rings > 1))
+               return;
+       sprintf(name, "amdgpu_gfx_sched_mask");
+       debugfs_create_file(name, 0600, root, adev,
+                           &amdgpu_debugfs_gfx_sched_mask_fops);
+#endif
+}
+
+/*
+ * debugfs for to enable/disable compute job submission to specific core.
+ */
+#if defined(CONFIG_DEBUG_FS)
+static int amdgpu_debugfs_compute_sched_mask_set(void *data, u64 val) {
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
+       u32 i;
+       u64 mask =3D 0;
+       struct amdgpu_ring *ring;
+
+       if (!adev)
+               return -ENODEV;
+
+       mask =3D (1 << adev->gfx.num_compute_rings) - 1;
+       if ((val & mask) =3D=3D 0)
+               return -EINVAL;
+
+       for (i =3D 0; i < adev->gfx.num_compute_rings; ++i) {
+               ring =3D &adev->gfx.compute_ring[i];
+               if (val & (1 << i))
+                       ring->sched.ready =3D true;
+               else
+                       ring->sched.ready =3D false;
+       }
+
+       /* publish sched.ready flag update effective immediately across smp=
 */
+       smp_rmb();
+       return 0;
+}
+
+static int amdgpu_debugfs_compute_sched_mask_get(void *data, u64 *val)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
+       u32 i;
+       u64 mask =3D 0;
+       struct amdgpu_ring *ring;
+
+       if (!adev)
+               return -ENODEV;
+       for (i =3D 0; i < adev->gfx.num_compute_rings; ++i) {
+               ring =3D &adev->gfx.compute_ring[i];
+               if (ring->sched.ready)
+                       mask |=3D 1 << i;
+       }
+
+       *val =3D mask;
+       return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_compute_sched_mask_fops,
+                        amdgpu_debugfs_compute_sched_mask_get,
+                        amdgpu_debugfs_compute_sched_mask_set, "%llx\n");
+
+#endif
+
+void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
+{ #if defined(CONFIG_DEBUG_FS)
+       struct drm_minor *minor =3D adev_to_drm(adev)->primary;
+       struct dentry *root =3D minor->debugfs_root;
+       char name[32];
+
+       if (!(adev->gfx.num_compute_rings > 1))
+               return;
+       sprintf(name, "amdgpu_compute_sched_mask");
+       debugfs_create_file(name, 0600, root, adev,
+                           &amdgpu_debugfs_compute_sched_mask_fops);
+#endif
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index f710178a21bc..9275c02c94c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -582,6 +582,8 @@ void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdg=
pu_device *adev);  void amdgpu_gfx_enforce_isolation_handler(struct work_st=
ruct *work);  void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgp=
u_ring *ring);  void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgp=
u_ring *ring);
+void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
+void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device
+*adev);

 static inline const char *amdgpu_gfx_compute_mode_desc(int mode)  {
--
2.25.1

