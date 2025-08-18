Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B2ECA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 07:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D42B10E3D0;
	Mon, 18 Aug 2025 07:08:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rcal8P0f";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C5C10E3D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 07:08:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJQPZhhXa/J1TIJxTK0QmC0b6oVcxBY73XX5SMZedL7flj6wPbAtGZECfR3vQnWrAQkXGHbwZ5hvdhf3W78iL7cyptaPf6RhGRM5tOBHXjUwzp2fMEz8kZwtFbjui6dkWofaLJyGmPMMf1fy/4/w8hKcVUD+5BuqfldaaN50D5vFq1WCg3ZLvUTRFx7NC6+CJH6TW+L3lZ17JbiuJ8Crsys0yzNlDHkq4hd3VQLWXNflv98diF1KvA+9Db1Z+psEndmrF5la9biTPn2T17t0oP136eHzPZ6MARtrcW5MA9qQ4z772AetNo2sFZ0hbW+j7ZsBK3EuLtsHcKp0QcwesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkPf7OpIXeliCItD7lN1Vfov84NdAtL+9t0FMIjrqzk=;
 b=lIRBrJX1LjPyM7MGPwUfVESyi40FdZ80VQ1j8xv3tPKnCbwxZaGP8cW47i+lNeUB+W2vRdL8Lj3wU7A549yXt1LvHEDTkqIo3W+GBChTw9qsKm/oAq3HvLJf8phhUV/DDxNBX6r7Z4bRiNMzkZCYq0Wz4wHkZmtPeu6LQpFcJOaVlyd+CS0QePN59C9HGR5sBQueWABwWg9jgVVVZAe5BT+W9RIQN6jCyxoBz713BbDtMJFd4ujO0ZGVccCDBEEvf/tjm2y1m/axDhn/hUF6rpZFf6XcpFEi2IQZ2K5mDSNCifFpQJaHx3+PwPK7X2S2bZf6JXwxon1YfeXnFZV1Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkPf7OpIXeliCItD7lN1Vfov84NdAtL+9t0FMIjrqzk=;
 b=Rcal8P0fgwz5FEZiHbzYOQYZfNfoYO/hgtZ8pi7hGmo884Ac9RJ+pqJeleKf6v+pbPZXSriMUtOTDXC5i+bDwaJwpG07Eahk81JTTgJgBxcJhIkj/MdFRS8PQnWZSCdOLiHxyM7PabXaBIOOkxfSLqbWUbalcipf1UCo6DPo/gw=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Mon, 18 Aug 2025 07:08:43 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 07:08:43 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Make use of __free for cleanup
Thread-Topic: [PATCH] drm/amd/pm: Make use of __free for cleanup
Thread-Index: AQHcEAfQwg4uGtheW0aEOsmSHBKn4LRn/ZgQ
Date: Mon, 18 Aug 2025 07:08:43 +0000
Message-ID: <DS0PR12MB7804238A87AB187F4109A3349731A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250818061715.2044236-1-lijo.lazar@amd.com>
In-Reply-To: <20250818061715.2044236-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-18T07:08:05.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|SA0PR12MB4448:EE_
x-ms-office365-filtering-correlation-id: 3cb18b06-ffba-4352-0e2d-08ddde261127
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Vdc6oXfmu4neb+9nGbAaOuUdHhWRGtnsLngKsrte0C5QegAdQjj0aZxP9sI+?=
 =?us-ascii?Q?3+fuDZCsbU0LbV2RmrH1m6gJnRm62O1csIF0isj6EcqznYTVSsFIZ9UJyv3H?=
 =?us-ascii?Q?qPCB3ECd5yPXewINUah1jK62gX7QKoQJ4UbNiH1xg7/3Pa3ps2PFdrzUbi5X?=
 =?us-ascii?Q?ixxu7V1pdMDkucg0pHL+1aW5KFun0uDPwNNjkStvN4Y17trZRGNr+rw0mYzI?=
 =?us-ascii?Q?70kXTeYxNH3I0X/K7xdBGeataYBKxyxt81BFpBwzIMSu1xERu+gRsrFRuLPF?=
 =?us-ascii?Q?2/2AdimomQVolXNdVcCAegU6SzPFEpv65EiuoJdeAmD/4fkk9Zv0DTtXAIy4?=
 =?us-ascii?Q?p+nPxQOusRV8KTSYFnPY25h1Heq/ZJgF6+WY7sMCaP8JD62VzxgCKdM0JCxw?=
 =?us-ascii?Q?aTG0VQcUuk4DokAzhTrsxszsRp3IVqS9mlYTOPDa+sf6Ls04GkJfj5eswjG/?=
 =?us-ascii?Q?rKcXmyiAl6BRruJ2gOZVtgMm/KO2Cb+APpd3e72QnRf6bKQCI1TdlbFT8x1G?=
 =?us-ascii?Q?TQKQhdrIVZxvMNTey5dkxVQnfHk/7fyIXeU0N2XGX3ipi3tdT4azSg1pkRbP?=
 =?us-ascii?Q?7P90IJdKrJ6JkRsQqRO/Dv1jWKJoqrDTkY/pbNfHqeCbldLnbwOAFZHPajo8?=
 =?us-ascii?Q?CyMlfDkrmJ2wALoR4I3HmFmJmFmySc8WXbfMIuK7MabTqzEDip1pO4j6dC0O?=
 =?us-ascii?Q?UAVWhCps6QfDHOGcFnT+A1X4F+V073CyhRztJBMq/DhmGsdvdns4r+taTjXU?=
 =?us-ascii?Q?IDHDV81wgYKEqXuYm6JPg7XIjAqI9IbQKtSZfz/qIYxs2LgnTG87MwxjOOV+?=
 =?us-ascii?Q?VK1BlLzl24ivNLMOJ9AvskPqkQE0i8m3pO5eyQ9dc8x1jXu6VlNLJyQi+ZuH?=
 =?us-ascii?Q?PScq7A6V82gIl3P3H5fEfDe07fc4eb22mcATWFj/ZeWhVAhm+IFfF3yjdPKK?=
 =?us-ascii?Q?2fOPtl6FwaBNVhmXTkiXVwOmzFTwtcBUn6AwfPFgc8dxR6qfq+iyayViLnru?=
 =?us-ascii?Q?ZGfLdCT4/FAYGNW4lCs7OGBgsQ5f9yLMDL7u3ZD9GFm7yZz4AOq+zeKcLVcn?=
 =?us-ascii?Q?YCHMlZ62lXq3E1Vf5BW1PWkxnw0rzKfRZ45LtQQbJsXzOGeB1ZNrgT9lhnx6?=
 =?us-ascii?Q?lMhsC3Z9Ntshl7Ta/2BE3HI92uUycLx4aBZafKVLB4d6wL6Roun/jQL4GBAq?=
 =?us-ascii?Q?TdfoZ48udEcgy/7DxCwj6LP0EOPj/mWbbNRAiPHtujoaCwx53i0N4MmS4Tti?=
 =?us-ascii?Q?wp3WVtOY3SH+Y9RZdXkTOBmv3aF+FgaM2vF+OZra2ngCQuSWL418FMz5Bgpb?=
 =?us-ascii?Q?s6LQEIqmgzdDW0aDBqNnbf4i98AyZZNCYhmHApsZBfg9rhB4yOgDiTXDl+R/?=
 =?us-ascii?Q?Qf7c/cFo1wbEna/KBh8HxOsseITgUNWyzuySZRpWSZmWCzl7n+8EpcSTtPxZ?=
 =?us-ascii?Q?jfjrXZAHm0UCaZBZ22wyV7s4qg7fh28VXFIwI1w8yDv73EvogfRpIXrehUxC?=
 =?us-ascii?Q?1lKMl52Z0g3Vf/M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?431pGriDeo17JMFmi1XK5imm9Qmlp2SczpKa5FyfE76dwMks7UORbSnL3Gqy?=
 =?us-ascii?Q?Q6blFiLl1qiMHEjrGJUey3jchiyldIUgeSiE0V62o0nusz676S9QyqVawhZs?=
 =?us-ascii?Q?hQ/0NKu31Dafo15v6wUs+QS9QUh70FPGD6DkSiVaNKvGtK5JIrF5Y+0NguX+?=
 =?us-ascii?Q?V2FdSTFCMK4lEgYe9CdEc0E1fCLJS0gJZFALOcBt+39J6y4aY2qxaQE2KBfH?=
 =?us-ascii?Q?qXfmmoWBWkP7c0ivL5NnFKkGm3L1X74jdENBruojk8yMegxHNhYP/ZaEZBN4?=
 =?us-ascii?Q?6daa2hfhMPd9nRFUvpY7gguWBcvQnJHFb01Y3oPKJ/yD0V2L4YotWQVy6CxJ?=
 =?us-ascii?Q?3u7VcokqXGVS+q1mJV76fgVob36URIk/8JgBZD83sKSkR75V0wlWL5eaLDbS?=
 =?us-ascii?Q?FHEk79t0mcpGtEutqdh3kwf6Pix+NqoDXHIbu1gZnaoQfMxQLES4Xg1EW7Xq?=
 =?us-ascii?Q?Vs7Df5dEqKNw9nhd9jdp0jky3zICSYKB55iuiDcOEgdTDbEAzo0ApY2+hOv2?=
 =?us-ascii?Q?N3N+lsDx8HAWqVqCo/z50ZFuuCc4DuhLohRPaSF82Vtlx8tbe0ECqOwxHVl5?=
 =?us-ascii?Q?911lJAfk0/Uk5vQ9ZPXvv9pdPrQAEqfjTG7IGNcLlasOgj96cFP1v6+sUxXY?=
 =?us-ascii?Q?8xM/JIjhSulK5/pLItZm94vVMIv2U3PimJfNMbKisyiHGWXBmEgCHaxaOLC7?=
 =?us-ascii?Q?5dl0kx5YWDbi8u4qG8iuo3yB7epZ4R9sApqi7CS5AXdHV1zhSxq3jU9N28Gp?=
 =?us-ascii?Q?H67sHz8FuRzkjv2JDTy5wJzVoFPlo35X1skCzsQbcZoYQCunC4IKNyi9xL5B?=
 =?us-ascii?Q?5uXyrNcV3cy+H/4o0VmcheBBFmTycypOupYcdK3tn6vJj8Jt1/IvVvsHXXfw?=
 =?us-ascii?Q?fqeeEJWZtt+w11yMSnZlgTFIOGvFcTHXMptX/oUJRwYGmLWM50Mjr34Fkn4h?=
 =?us-ascii?Q?dB5W1P3KmkzsDJ+ropUWgTc6HtmSE7UzitiZSHMmnCeAZKVWrX2LgHE4tNTf?=
 =?us-ascii?Q?aEP2YZvvDdJq73QgzbRMtTZKVR5HoHD3Gw7sBw1cGh02RYI16zgnGIMWkPc6?=
 =?us-ascii?Q?bBxpuJI8DH9e4HK5mzh0hOVHPxsC8w1O4g0sku9rDdzx+dQUcn7t7jxCWV/3?=
 =?us-ascii?Q?dgz1ai1+FMMaj5ANV9kVyRP5isBFQp+T0mjbUhq3yIDiifQUsdPpdFlOzFg5?=
 =?us-ascii?Q?X1gY1jPgYL60wrlDz2nICV2e0UqvuAcM5xSI8r2D0lOEf+t5P+bBclcKuCSP?=
 =?us-ascii?Q?YxTBHVNY8nhGU+pTDjG2wGMbZ8bU1359pn3NhoHAGfQUpoqSv81kqAEfm/pw?=
 =?us-ascii?Q?36SH3GPPmf7aViRvT0YmU/r/oeRzXnKJzHwmxbPOVKDEVweQ9P49odditjgk?=
 =?us-ascii?Q?br23xMl46zZScrMcggYBDM9z7rlJjZWp6HRZEZqe7RYbR7V9ObXqO/DkJduf?=
 =?us-ascii?Q?2jnY85Z2pkobQiLOYxbiGw+tsbzHi5jd2HBjLqt8uKSoaLHsY+RbL4+ce2iA?=
 =?us-ascii?Q?v/N/XRfxDEqBACLlZRP/iLabVfwFN4HrTj8M/Wa4XkN1BocPLhH3+BLOlkfh?=
 =?us-ascii?Q?idAva2v6RdD1veToajo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb18b06-ffba-4352-0e2d-08ddde261127
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 07:08:43.3886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2hZ7fB4979SnPzsd1L4n8ji9sH+aeRFIUXbYePaVm9wkQt6wzxw+byV43ZW0y1K8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
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

Please ignore this. There are a few more places; will send a v2 covering ot=
her ones as well.

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Monday, August 18, 2025 11:47 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Make use of __free for cleanup

Use __free() for cleanup during table initialization in SMUv13.0.6

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 30 +++++++++----------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 627a8188d868..f9363edf16dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -535,6 +535,9 @@ static int smu_v13_0_6_tables_init(struct smu_context *=
smu)  {
        struct smu_table_context *smu_table =3D &smu->smu_table;
        struct smu_table *tables =3D smu_table->tables;
+       void *gpu_metrics_table __free(kfree) =3D NULL;
+       void *driver_pptable __free(kfree) =3D NULL;
+       void *metrics_table __free(kfree) =3D NULL;
        struct amdgpu_device *adev =3D smu->adev;
        int gpu_metrcs_size =3D METRICS_TABLE_SIZE;
        int ret;
@@ -553,37 +556,32 @@ static int smu_v13_0_6_tables_init(struct smu_context=
 *smu)
                       PAGE_SIZE,
                       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);

-       smu_table->metrics_table =3D kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL=
);
-       if (!smu_table->metrics_table)
+       metrics_table =3D kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
+       if (!metrics_table)
                return -ENOMEM;
        smu_table->metrics_time =3D 0;

        smu_table->gpu_metrics_table_size =3D sizeof(struct gpu_metrics_v1_=
8);
-       smu_table->gpu_metrics_table =3D
+       gpu_metrics_table =3D
                kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
-       if (!smu_table->gpu_metrics_table) {
-               kfree(smu_table->metrics_table);
+       if (!gpu_metrics_table)
                return -ENOMEM;
-       }

-       smu_table->driver_pptable =3D
-               kzalloc(sizeof(struct PPTable_t), GFP_KERNEL);
-       if (!smu_table->driver_pptable) {
-               kfree(smu_table->metrics_table);
-               kfree(smu_table->gpu_metrics_table);
+       driver_pptable =3D kzalloc(sizeof(struct PPTable_t), GFP_KERNEL);
+       if (!driver_pptable)
                return -ENOMEM;
-       }

        if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D
            IP_VERSION(13, 0, 12)) {
                ret =3D smu_v13_0_12_tables_init(smu);
-               if (ret) {
-                       kfree(smu_table->metrics_table);
-                       kfree(smu_table->gpu_metrics_table);
+               if (ret)
                        return ret;
-               }
        }

+       smu_table->gpu_metrics_table =3D no_free_ptr(gpu_metrics_table);
+       smu_table->metrics_table =3D no_free_ptr(metrics_table);
+       smu_table->driver_pptable =3D no_free_ptr(driver_pptable);
+
        return 0;
 }

--
2.49.0

