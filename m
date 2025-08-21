Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4589CCA0EF8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 13:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C19CC10E2F2;
	Thu, 21 Aug 2025 13:04:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l5Lgl5ef";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B3E410E2F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 13:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3FhNtaMMuSrcax8pNJE2EE/wsibMC2Zi8lGp5nIvK/mVB7NDuhYXCBviWtJmHdl/hAEXvtY1M/aXZUpBCcnBKRCz94r3dDqphA2m+ipl51PfZXRIjb/wlGoqGEycd8TqGJFjtLSNIIIHohHuzfVQpFrADA0ZIXTfhEnFtrk3xfDq8EySsdALPafMtOWFFS1KO3djAYX1wGeyCQgV3vHSvQEJCxHQcfndSO3/JvvoIrC6g0kO1QfzUIy9WxA8xhjZnn2aKd0QCy38RLWvle+FR+95EUhnNzeaVJ+Thp+APwpM0dTDcqgjnKonbPBwX2luzgeeoTVY9RKK95nAHHoeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xu/nuq1v+QWePdMCLuoIaLzg+Nm3LCT5U8I1u/r3ds=;
 b=hefq0K/kawxN6U3tVNHxEDB7BQC8zzBDqqNPFZiw6KV9YAOKw1tdfOMWrBgqgmdBUqAJ0vz61vi2mPrCqGILJMBxie2kvxjV0Chd+BDQQIHQYI264Whb85HJwPnV5qz+oNtZWOcS01T9jG2CDTvFPgtSWVNkLBkPH9Tbnj7lbQ0+D3JB1/stP7O01sKqRQrWCrSWsGF9+wRPZUrHLz/94WqAJCylv5O+lNis/pkxyuIs6RTUfULhtgDpff5uoKLCJgalhpL83z6DQgtt3pjjKAjH62MbxNjE3CdaD8Quy3+Xp8gkJ61ihK/nNgUMJX57eTAMTJDnSSz76p/jEq2Fkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xu/nuq1v+QWePdMCLuoIaLzg+Nm3LCT5U8I1u/r3ds=;
 b=l5Lgl5efDmXS5eURrxM5dtZ8gQFi3qA4ivrjg5sjfYbk2jDD/5aNR7NamVNKO9qjteALH5BsyfEN1cFUDNf+/Ox4qCR8tsFjQye30u5H9RWlJg+xATZ/KTpQDX8q/G6DXESwowl/h04SxwvMJOaYgxeXgXUK5Kb5zvdDh5hvCKM=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 13:04:34 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.9031.018; Thu, 21 Aug 2025
 13:04:33 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: Make use of __free for cleanup
Thread-Topic: [PATCH v2] drm/amd/pm: Make use of __free for cleanup
Thread-Index: AQHcEBLMnC2jogLV10qU2HhfZtmID7RtF9zw
Date: Thu, 21 Aug 2025 13:04:33 +0000
Message-ID: <DS0PR12MB7804793F0D4567A4BEA3681D9732A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250818073550.2074766-1-lijo.lazar@amd.com>
In-Reply-To: <20250818073550.2074766-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-21T13:03:45.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|DS7PR12MB6263:EE_
x-ms-office365-filtering-correlation-id: 7c44b649-b21d-4c12-0238-08dde0b34617
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?vuYN9z27CX12wweRk+Ubc6t86ESpvyhCCS6m3MOrUwiHarwz9zw9VS8kUBTY?=
 =?us-ascii?Q?Y19xNowzH1D66D9pd3Hd0q3slRyJ1zte2tj2maw5iQnDdrKzuKKWV3UsopiI?=
 =?us-ascii?Q?FFKPvkfKxdH/nlUDl+ac2FXyqhaJt38YRaT5WsYHdLTnwfkmMrGvrXdZXGMr?=
 =?us-ascii?Q?EurQl+CGDCDRHEhVe4URZFxtheDKVR4jC6bICFpzrMFSdA0a/CKmnumMPO/I?=
 =?us-ascii?Q?MVfVWI9JuDD5dvL49+uH9Lv4zTB76QD595N8mNrVkgEJCZrEoFgVFkWG+hC0?=
 =?us-ascii?Q?KNspmQAbUadE+icTNaGKm7HOF+onwoTdFpZ2gr6iImL42c1fKU/8DDKas8ZY?=
 =?us-ascii?Q?2JVu/mQzqpVAYyyoW9QXyjqszu1kAZlAqL7KGAp7L2Hp7mOLXVfRezLeXasJ?=
 =?us-ascii?Q?I1x6hN7uZqYCzErO8q58brk9q7iZRzrjnHdd1ShE6L0AhLV2qiaLPuQi7qH7?=
 =?us-ascii?Q?YgLE0amLYiSIT/rLolBTmSObVumKBY4o5TsKeO4mcvVh2daEU65wHJRyKOWo?=
 =?us-ascii?Q?NoLOzWeSvW+lGoaqHqYrVP0/tJfHMS8WMiZLj3VSjWVzELM2513xQ7G3mZBU?=
 =?us-ascii?Q?TAbXE9h97byOgMq8Pk96kuifYlXTu5n9xW9pMM08hG+ZEWEQclV73KECS9zH?=
 =?us-ascii?Q?FHnAU58o7k6HWEV4KBC6KeQvz2QNZRPw5ew2h0qWdCyIRhOVpJZeXA6eIaLZ?=
 =?us-ascii?Q?3dhAxmWFvtkXwNDClKZ6kihNH4GniTieQdzh9h85S9SsLs9H2T/6DsE2vVvE?=
 =?us-ascii?Q?ub5LH9zUKSM1vWacwKAOgPidwRhUTpeUcQOywZ3na0Y/TjsG9kUpNFp2Dr91?=
 =?us-ascii?Q?C4hjCvDQZrgpd6vGU2Z2I9Tv1A5WCKXFiLuTNI6fAylXOohL3mdlspK9AYpJ?=
 =?us-ascii?Q?IiTka/bT+j8Sz6ZYcS6UkyWsq61dQKmRnHXmb3rlGRJ5CWOdpFYikGkmy3dj?=
 =?us-ascii?Q?M1Tleh2Ya5Yj8LbvEVr/qzaGYFnCIbaYT2v4pa8QqhaQ03sEDDkIciaxvGrO?=
 =?us-ascii?Q?n10RSSOFoGoxB40QAE0dfKbjpcRZrt4MJYe3POPs/r0H2GtY60WsB9jfuQ3Z?=
 =?us-ascii?Q?fh1TIT9Jjta9Fgj6Uv0G29x+/f7TS7BkWpnj38gCWxF4myCpVUUGUOWdriaT?=
 =?us-ascii?Q?/QwxNxWX7iv9OPsF+ZYR8SdYEf41S5PBjs/GXEq82IvpVGrEKgNJmUS5BQDo?=
 =?us-ascii?Q?nzYPHP8WeWTARGSzMpcGdbrjS67PnOv37srJLvF7C2YyLdMdsy7GFGRponPs?=
 =?us-ascii?Q?lH/s1xhrl3FnH9aID+52i8/SUrYfEknziztQtBv5Zc1RZ9nkX3GIlEo0O3gU?=
 =?us-ascii?Q?QBSRuvguvpX31njoxIyfI9gNPgQKnxnqxd4AZeEJntnEkM3Imt8Ie2rP9LK0?=
 =?us-ascii?Q?OCFwz0hugtc8pQoEbk6PEdzXFjT/LwV/4iauMhXqc4G5xl9qpLtQKERa6OW1?=
 =?us-ascii?Q?aYteJsUz1Ym3BhbVfRTuMNpvDWIcFgFKEKM8lNW7HpMximflhsSUcgoSJLvq?=
 =?us-ascii?Q?JqHgpy8xdrF+Pus=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oqayweEJ8wdqFQ1gYzfMQfDfYvxMe/5TJHJjwCANWr8tdDLaVQwplBRtzczq?=
 =?us-ascii?Q?eYZjk1TfTlR23PcYuuHFiLe5qDz30TTxeqq/PDrenr9UNH5BVZUPWolvw3m3?=
 =?us-ascii?Q?vQL+v/VX0cz6IAfob8pvkv7XEfyLygnrRvEAwzC9+a0NDgTb/6s6dHZmQASb?=
 =?us-ascii?Q?L0MEVBoeaxURY1r8OUUXzpT9Bk+si4aWcX8I3xUuTRr7oTj/fG6nxpTc0uvW?=
 =?us-ascii?Q?pBt0XznIvJQF5Y+sC3EAxnPlrwSwr29CxPPxPBUFnrgBUYLg3dPiBF61oNL1?=
 =?us-ascii?Q?zMtwvX3ai7c0dc+Ksi2YLx32ePEZCj3BsRZ/0P0qEtNxUoi7LRBe0JiYxXCf?=
 =?us-ascii?Q?uag/0vOi8Sw7gJFP96tTvV+FLLGW+YFMTjlIAlUULzj9yMZp8fFRzyyJYnVc?=
 =?us-ascii?Q?XA02jPOQ8Xh2YWclPrZFGo7yo86Sj0xLHCTvMFKxmVzq9GHEAHKKj6D9KQY5?=
 =?us-ascii?Q?ygUIGy+iDcdOmZYz5nJyViK/kDPTmsGXbnag5IPEv3xZfM0udfStx84Umh56?=
 =?us-ascii?Q?IPPBpPn5W7qRWqJMf/NUPogn/lDb6MWWW5GbbREEAssSIrlriZSAoic3ZIus?=
 =?us-ascii?Q?/Wqw4JBMV6yv7Ix5q5f+meEDWSl7/3ZxHVDOIotQ7d5kB1qZR/iUPnprvOwu?=
 =?us-ascii?Q?Zy5zLPPTlRDNDkEgYF3B3uTL6J1cbXtFfkoPu2nkat2OwC1Vy7Ksc6Xb0hPK?=
 =?us-ascii?Q?RvdoyNsgPqc8f70rqfnnax3FSFJgFGY0TwITvj8XE8yhSYYMp9JCgPqL2NC5?=
 =?us-ascii?Q?EkDmQo6bY+CDjNRzLxfhJucJ2QAZyvGDXO3dUEqy1qba34PkOyQm0uZZco3/?=
 =?us-ascii?Q?hcsnGwOGiRSJGkuuKqi2L2zZfsZNygdS/Rbg4V9C33hSCE22IK7Ou3pHX5dS?=
 =?us-ascii?Q?9/oBlxCB8BX/rK3dHT6RJaFHr0GFj2n128TlXG54k6i5N6cVaiCPnpOjnzO+?=
 =?us-ascii?Q?zqoRnA7qAJXAlC97UV2hpWTYQlek/AYPgKZxadZGMqjk+WHXHfndFmJbHLWw?=
 =?us-ascii?Q?DgRIj8wMeeHc4JPAUJ7CxAxJOe9+dzozkkY7e1/r6wfHdWBlFOx3CfN8oxIx?=
 =?us-ascii?Q?qt2SIj/Z5e4l7edKJ8Cql0qtabMu6oZNmqaORK1wHVo4FzRdHEF/KrtbiMxX?=
 =?us-ascii?Q?SE50g8GFFETOAAzoKkkUnnj3afBM11MdD8I0CjazABxJy8Kh6UnVg4sVjpH3?=
 =?us-ascii?Q?69djqtaD6wCxx7DERh863fuKbo5VA8t+P38ognKsl1rUNErib9zMw7CyL3cb?=
 =?us-ascii?Q?QUUKenoYU1jGX8FxjrMBEsZ3B5aBPLQiuOcZns7y+EPaSX6Ysg3EhBijgOTF?=
 =?us-ascii?Q?CMmqLp+Kn3uLz1zVa6/xDOWyblhfOOVud7cUD8QyO0sA2fCUHMympupu2w/P?=
 =?us-ascii?Q?Jm++lj/6lOC7bNGsJGe2lWW/C8FExB+lwvadyu2gQPxN7yETnedlVM1Gvxib?=
 =?us-ascii?Q?rRghp7XMhQ05QgV4yd0kVlJ3Px39FKgBy48UKHObekTdBa0IVQS65tWvbJtJ?=
 =?us-ascii?Q?+10wLGFK1N+gbm6RRv1RBQ6oMs4qyIEHWcmzQHQovPcU2nl3CwzDJ9Vvx2lJ?=
 =?us-ascii?Q?IzS2p6W5yaiOzVl/v9M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c44b649-b21d-4c12-0238-08dde0b34617
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 13:04:33.5532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yMPYZpQjpaM7vvbO+sF4BBl6kk30PTjEiMKGR+Dbt4txzxQn2B+bf62aJktiT4tp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263
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

<ping>

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Monday, August 18, 2025 1:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH v2] drm/amd/pm: Make use of __free for cleanup

Use __free(kfree) for memory alloc cleanups in SMUv13.0.6

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Use __free in metrics related functions also.

 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 63 ++++++++-----------
 1 file changed, 25 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 627a8188d868..b5d1b2427c3c 100644
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

@@ -2619,9 +2617,9 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu=
_context *smu, int xcp_id,
        const u8 num_jpeg_rings =3D AMDGPU_MAX_JPEG_RINGS_4_0_3;
        int version =3D smu_v13_0_6_get_metrics_version(smu);
        struct amdgpu_partition_metrics_v1_0 *xcp_metrics;
+       MetricsTableV0_t *metrics_v0 __free(kfree) =3D NULL;
        struct amdgpu_device *adev =3D smu->adev;
        int ret, inst, i, j, k, idx;
-       MetricsTableV0_t *metrics_v0;
        MetricsTableV1_t *metrics_v1;
        MetricsTableV2_t *metrics_v2;
        struct amdgpu_xcp *xcp;
@@ -2646,17 +2644,14 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct s=
mu_context *smu, int xcp_id,
                return -ENOMEM;

        ret =3D smu_v13_0_6_get_metrics_table(smu, metrics_v0, false);
-       if (ret) {
-               kfree(metrics_v0);
+       if (ret)
                return ret;
-       }

        if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D
                    IP_VERSION(13, 0, 12) &&
-           smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS))) {
-               ret =3D smu_v13_0_12_get_xcp_metrics(smu, xcp, table, metri=
cs_v0);
-               goto out;
-       }
+           smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+               return smu_v13_0_12_get_xcp_metrics(smu, xcp, table,
+                                                   metrics_v0);

        metrics_v1 =3D (MetricsTableV1_t *)metrics_v0;
        metrics_v2 =3D (MetricsTableV2_t *)metrics_v0; @@ -2727,8 +2722,6 @=
@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int x=
cp_id,
                        idx++;
                }
        }
-out:
-       kfree(metrics_v0);

        return sizeof(*xcp_metrics);
 }
@@ -2739,31 +2732,26 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct s=
mu_context *smu, void **table
        struct gpu_metrics_v1_8 *gpu_metrics =3D
                (struct gpu_metrics_v1_8 *)smu_table->gpu_metrics_table;
        int version =3D smu_v13_0_6_get_metrics_version(smu);
+       MetricsTableV0_t *metrics_v0 __free(kfree) =3D NULL;
        int ret =3D 0, xcc_id, inst, i, j, k, idx;
        struct amdgpu_device *adev =3D smu->adev;
-       MetricsTableV0_t *metrics_v0;
        MetricsTableV1_t *metrics_v1;
        MetricsTableV2_t *metrics_v2;
        struct amdgpu_xcp *xcp;
        u16 link_width_level;
-       ssize_t num_bytes;
        u8 num_jpeg_rings;
        u32 inst_mask;
        bool per_inst;

        metrics_v0 =3D kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
        ret =3D smu_v13_0_6_get_metrics_table(smu, metrics_v0, false);
-       if (ret) {
-               kfree(metrics_v0);
+       if (ret)
                return ret;
-       }

-       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 12) &&
-           smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS))) {
-               num_bytes =3D smu_v13_0_12_get_gpu_metrics(smu, table, metr=
ics_v0);
-               kfree(metrics_v0);
-               return num_bytes;
-       }
+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D
+                   IP_VERSION(13, 0, 12) &&
+           smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+               return smu_v13_0_12_get_gpu_metrics(smu, table, metrics_v0)=
;

        metrics_v1 =3D (MetricsTableV1_t *)metrics_v0;
        metrics_v2 =3D (MetricsTableV2_t *)metrics_v0; @@ -2949,7 +2937,6 @=
@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void =
**table
        gpu_metrics->firmware_timestamp =3D GET_METRIC_FIELD(Timestamp, ver=
sion);

        *table =3D (void *)gpu_metrics;
-       kfree(metrics_v0);

        return sizeof(*gpu_metrics);
 }
--
2.49.0

