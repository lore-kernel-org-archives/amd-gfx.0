Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD0DC48BF8
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Feb 2024 18:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA8610E090;
	Mon, 19 Feb 2024 18:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oTxSoSqj";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7021610E090
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Feb 2024 18:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeCQXxDrGCpNVPGdQb6sLx8b8Hh5qzGuJExzyc2rfMU/vUuHOhCDPEPJh0lmyP5ezhAOmcuwFx2iL6XnN2wdhSWcAT5XlXXVtsooNQVRgk0p1FHqBvxbNjZxUzbRbei8Dx0yrhgC/IA/vemTwF1N2WdV9YGpOI5RqUKnl8oUjsqqAb8CnAaauBLOpaj/ZkGfZo+jHnIzY3oXAx3+T+xcFnSXlq/JZ0RZByvCw14N07l/yJL5JsuuO+MbL3GtK8wzZHM54+9wsM6E6/L7S0XltEOAD5dTBb1VSjFqdleq0NB5vMXWuNvmNnEg2c/PNuopd8lQuYjJlP5iTjjBocmWkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeHUQq0uNwq2uUbRVOKyLlCG2RMr9MwNTxhMFVagc4g=;
 b=LAKWLDKKqNtBc2qn+O2TcwLYj8J+M214F0t4mLM3OsV4DMjfobJmFx+fw4UlFqJFGDXt6ca6v5Q00G9tyKgK1FXzxKd1eZlY459BkCfw5SXO6Raxqf6FIRxd/QGTkd6FVH19VdPJr/PJDIkG0s/G+K2nwOjl87SrgHjOLoBlEbWlF4d03TTAPhISJ43jNBEDtcGNZOJWWmsiyq4k1JZHdwOccwgfBWwW3nUsMmuA/Pn7q2OXq3dE+Ix/A5gconVKOzdP3Ma92YyEPbNk5PkUo6cXwvWKb/AxsjKulrxLu8jfogV3ocf/Wyniu/tQGWsjIQu27ggkjQkfRo1Ooh2Z8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeHUQq0uNwq2uUbRVOKyLlCG2RMr9MwNTxhMFVagc4g=;
 b=oTxSoSqjmrUYqUIZpbllbmL53u2I3lL743/Piawj6h8AuXLDW674r36aHAwKtdqc3II7J85XkU3kWmvlqpMRecJE0VhjOxEAyLcERMBzgAcdzyOfJvQZSGHpTY3isftTl3UktBV9HVyN2icNTn5qJeYXTs4LCDANizo8ruMMhm4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Mon, 19 Feb
 2024 18:58:49 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::65c2:9692:66a8:2388]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::65c2:9692:66a8:2388%4]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 18:58:48 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Drop redundant parameter in
 amdgpu_gfx_kiq_init_ring
Thread-Topic: [PATCH] drm/amdgpu: Drop redundant parameter in
 amdgpu_gfx_kiq_init_ring
Thread-Index: AQHaYv6hAVm8jObfgkix0nGba5l/VbESBUFG
Date: Mon, 19 Feb 2024 18:58:48 +0000
Message-ID: <BL1PR12MB5144993411507A21C7C96EBDF7512@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240219064055.1678968-1-Jun.Ma2@amd.com>
In-Reply-To: <20240219064055.1678968-1-Jun.Ma2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-02-19T18:58:48.534Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ2PR12MB7942:EE_
x-ms-office365-filtering-correlation-id: bbbd7a52-43a4-4ea1-ba79-08dc317cce71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: inPsKoTxoXFnSJceGoIjS8DHP8mWTt6GV6GrN7nU6uXHqKzI19MvUE6CHR20t9TMsOTFlDhhCXMqNtxeLKlr82swTOIbgUMTR0BOyJgSPlRbPqG0P0ebwYGIVp8Y7k5ZMsUdak7OkdzC8IreBmoCrtYQtej0rM4k00+tICzgt4JjzexYAE3phlhRDqq7YYdqaHCPFYs0zgPc8f1AItIDI21EuU05c4PO3yOWYZ1+IKGonvOB6rIonQfPansECBXd5O9HdnztH4lrpQfttmcTVQk8DW681NiJiy2pHJ+sea0QLgjo6s8W7CbgvSk4v/8DMH8UHwxmCS2G943Z/V55gZ1NVHJuhY/zOmfJNqlitDecQMnvdM6xm/Jv2vmQUjXFlbOOA/5sQMeTIbd8vU/eEs8SRqYO2WH8qlA2FzOUhMR7PeogQToq/5VTIdpYRrKBpnzkW0nVrVNh62WR8Z8EvfqEQdAT605XxTbpnTrpPWs6XVZvWicuEilFWCZ6kEWZoMPWQCu17wtcyIh+j7sWcvMbG40aiYzoXWG7dAx16850ymnaSYSnRvMKjM4mcrl3N4wo6Xxn5VNpZ3VTq5unh7QtKF5Uaw/B/j9fIu13aZDdSBFcDZI774005U5F3Vnl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GAXY34utZ1vClYIrqDdm+kOsar5cgTFZLJmC/zDNTIjDSq2+r5hjp+HRGOYr?=
 =?us-ascii?Q?5mBwZMzFBzVhzTsecIi/ffHdc02t0IgjGO6lwSXJW3W9muC2I0Xx0uzq7+Xx?=
 =?us-ascii?Q?jeuQTdS2VMA1pxXb+LgFG3HuKOFI8jKn7i1feA/Ehz5DmCp+tES/lLzL+jeF?=
 =?us-ascii?Q?V8VJ1LJXV/JwAwNWRmhPVBCgHESim7JxeK/UkEtklOwwj17rYZYUznM3Rjna?=
 =?us-ascii?Q?SKpegiuTiQvS6hmNLOm+FhvISxI6Q/6EbkP7MIPr3RNxfUC/zwB7wu3Y0eeQ?=
 =?us-ascii?Q?yt6pdWGBQDvFkGBW0hc80I/FjgH6D/Rot+AQl6SQZz3JqkLyOs589nTHLt59?=
 =?us-ascii?Q?g8QwsSyTTgCHUBNbK5hjPF1mb19Tz+69ciN3VwjiybbY2Xgas82p/UUpiLS9?=
 =?us-ascii?Q?JsXNisijsQzZ9vKg39Ml8TQ+u7qjUxgajAY1cn8WH53Mj3UOQXDi2hnJkbgp?=
 =?us-ascii?Q?pSgM2WGE5WhONhdj96wsfsog7wU3HXfDlaSFFS/dzUlZ1eAxLcwxWyPVk3kK?=
 =?us-ascii?Q?1/i67uDnWxo6FwxvqXmJZ2p2UF/wZwkoyLOIWZ15mTbFsK1a5CcjE7CuOU8t?=
 =?us-ascii?Q?/I0F4WAq6YlAdZqcmBdkm+451hqa92+8NWFJ8E6eVV92ATH4N8g2ILP95P0Y?=
 =?us-ascii?Q?iWgZ3CcbGmzzP4ZjcHbB2wO0DNrHdFob4Tsrvx6TjF1+/6uNMsmYeM1kjbMD?=
 =?us-ascii?Q?V0JM2ObZYauAEJuz/pkaOLiR2UjeboBLecPE0ufUuQDSAF3MHxq1o7BWhoIg?=
 =?us-ascii?Q?vmNMofA9rXtjHTsrf9/aXU/UjqMzvwfzJiWLzurCWD71/3+XVen155DL/L66?=
 =?us-ascii?Q?Bnl+xVnzLcBUfSdKlFCkhoyFf3ng+vCvD9BA1xQgSzQECSrEiGguxFWTeUGC?=
 =?us-ascii?Q?d1MlLAqF7Pwp/JNGV5+ZLC7lArz5ElaXLhBKMAUKFsoadbdJ4cruwzgymkBr?=
 =?us-ascii?Q?akII9wPdAC8CRvRG2O14ks6dOMjJNpBbKfNbcwIGdQrdI4NFQhjnG1TFZElg?=
 =?us-ascii?Q?qRFf8ViPxOAEOg9tLjrTNadLUWF8munzpQ3KMTfhq4Jdin88NrRv11+NAWce?=
 =?us-ascii?Q?WDgPZCxSrxq3c4HOlOz8PUMxzTdTJyBHtG1LcdBrQjaMiKXe6f+n59gCZts5?=
 =?us-ascii?Q?lBvc3tKsmdHhJDtjSNbpr6lhaRFqgfbgbhlo3lVshdgYNxdILZmzNAPJDiMP?=
 =?us-ascii?Q?2kRRRxWAt88Sd9BqacxVOVuqLKMw629GEE2UCRmHj5oOfUdTew1niO+3CUal?=
 =?us-ascii?Q?R5d5Vyh6WeEQ8bCJyKl0KpEbpN8CZ5hhgLfQ9cH2TDEYhk5Yr06EZUCsEjav?=
 =?us-ascii?Q?FIADM2rMrXxVeyT8h8wq1GdXWg7qkh/hGRPA+aMtpQ3UPEVi12SozlZpOnMO?=
 =?us-ascii?Q?fKSSkC9Bck3YB03rdSaSA86QbogVItCEuKWdA+8JPw1Ag5INVt96tgUX3cEY?=
 =?us-ascii?Q?U7+TD4Phi0ARe+IUSk6DgoNGjrIXYQlI9+yttBodadMc/USVfROPIAdk6PwL?=
 =?us-ascii?Q?TG/JXuRJb+q6hRe33S/JYNZVRC9+UxKH3hLYPE5gtP6Kx9NB+hOqebLMMH7w?=
 =?us-ascii?Q?aB9EmzRdL2c+xeTAyNU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144993411507A21C7C96EBDF7512BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbd7a52-43a4-4ea1-ba79-08dc317cce71
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 18:58:48.8764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JyI0cYIFOlUE40uNXcQFjZ/HcYYAcn6IvvAFZGFjo840jC55+E436BoAHWANGNyL0R2B9fDwWrtUYsyG0jtfTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942
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

--_000_BL1PR12MB5144993411507A21C7C96EBDF7512BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Monday, February 19, 2024 1:40 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Koenig, =
Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher=
@amd.com>
Cc: Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu: Drop redundant parameter in amdgpu_gfx_kiq_ini=
t_ring

Drop redundant parameters in function amdgpu_gfx_kiq_init_ring
to simplify the code

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 4 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 5 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 5 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 5 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 5 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 +---
 7 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index e114694d1131..4835d6d899e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -304,11 +304,11 @@ static int amdgpu_gfx_kiq_acquire(struct amdgpu_devic=
e *adev,
         return -EINVAL;
 }

-int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
-                            struct amdgpu_ring *ring,
-                            struct amdgpu_irq_src *irq, int xcc_id)
+int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev, int xcc_id)
 {
         struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
+       struct amdgpu_irq_src *irq =3D &kiq->irq;
+       struct amdgpu_ring *ring =3D &kiq->ring;
         int r =3D 0;

         spin_lock_init(&kiq->ring_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index f23bafec71c5..8fcf889ddce9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -471,9 +471,7 @@ static inline u32 amdgpu_gfx_create_bitmask(u32 bit_wid=
th)
 void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se,
                                  unsigned max_sh);

-int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
-                            struct amdgpu_ring *ring,
-                            struct amdgpu_irq_src *irq, int xcc_id);
+int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev, int xcc_id);

 void amdgpu_gfx_kiq_free_ring(struct amdgpu_ring *ring);

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index b02d63328f1c..691fa40e4e01 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4490,7 +4490,7 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_=
device *adev, int ring_id,
 static int gfx_v10_0_sw_init(void *handle)
 {
         int i, j, k, r, ring_id =3D 0;
-       struct amdgpu_kiq *kiq;
+       int xcc_id =3D 0;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
@@ -4619,8 +4619,7 @@ static int gfx_v10_0_sw_init(void *handle)
                         return r;
                 }

-               kiq =3D &adev->gfx.kiq[0];
-               r =3D amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq,=
 0);
+               r =3D amdgpu_gfx_kiq_init_ring(adev, xcc_id);
                 if (r)
                         return r;
         }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 2fb1342d5bd9..9d8ec709cd52 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1329,7 +1329,7 @@ static int gfx_v11_0_rlc_backdoor_autoload_enable(str=
uct amdgpu_device *adev)
 static int gfx_v11_0_sw_init(void *handle)
 {
         int i, j, k, r, ring_id =3D 0;
-       struct amdgpu_kiq *kiq;
+       int xcc_id =3D 0;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
@@ -1454,8 +1454,7 @@ static int gfx_v11_0_sw_init(void *handle)
                         return r;
                 }

-               kiq =3D &adev->gfx.kiq[0];
-               r =3D amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq,=
 0);
+               r =3D amdgpu_gfx_kiq_init_ring(adev, xcc_id);
                 if (r)
                         return r;
         }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index ea174b76ee70..b97ea62212b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1900,8 +1900,8 @@ static void gfx_v8_0_sq_irq_work_func(struct work_str=
uct *work);
 static int gfx_v8_0_sw_init(void *handle)
 {
         int i, j, k, r, ring_id;
+       int xcc_id =3D 0;
         struct amdgpu_ring *ring;
-       struct amdgpu_kiq *kiq;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

         switch (adev->asic_type) {
@@ -2022,8 +2022,7 @@ static int gfx_v8_0_sw_init(void *handle)
                 return r;
         }

-       kiq =3D &adev->gfx.kiq[0];
-       r =3D amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq, 0);
+       r =3D amdgpu_gfx_kiq_init_ring(adev, xcc_id);
         if (r)
                 return r;

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 169d45268ef6..7669f82aa1da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1997,8 +1997,8 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_d=
evice *adev, int ring_id,
 static int gfx_v9_0_sw_init(void *handle)
 {
         int i, j, k, r, ring_id;
+       int xcc_id =3D 0;
         struct amdgpu_ring *ring;
-       struct amdgpu_kiq *kiq;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
         unsigned int hw_prio;

@@ -2151,8 +2151,7 @@ static int gfx_v9_0_sw_init(void *handle)
                 return r;
         }

-       kiq =3D &adev->gfx.kiq[0];
-       r =3D amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq, 0);
+       r =3D amdgpu_gfx_kiq_init_ring(adev, xcc_id);
         if (r)
                 return r;

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index aace4594a603..ec92c3c2080b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -843,7 +843,6 @@ static int gfx_v9_4_3_compute_ring_init(struct amdgpu_d=
evice *adev, int ring_id,
 static int gfx_v9_4_3_sw_init(void *handle)
 {
         int i, j, k, r, ring_id, xcc_id, num_xcc;
-       struct amdgpu_kiq *kiq;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

         adev->gfx.mec.num_mec =3D 2;
@@ -912,8 +911,7 @@ static int gfx_v9_4_3_sw_init(void *handle)
                         return r;
                 }

-               kiq =3D &adev->gfx.kiq[xcc_id];
-               r =3D amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq,=
 xcc_id);
+               r =3D amdgpu_gfx_kiq_init_ring(adev, xcc_id);
                 if (r)
                         return r;

--
2.34.1


--_000_BL1PR12MB5144993411507A21C7C96EBDF7512BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Ma, Jun &lt;Jun.Ma2@a=
md.com&gt;<br>
<b>Sent:</b> Monday, February 19, 2024 1:40 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Ma, Jun &lt;Jun.Ma2@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Drop redundant parameter in amdgpu_gfx_=
kiq_init_ring</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Drop redundant parameters in function amdgpu_gfx_k=
iq_init_ring<br>
to simplify the code<br>
<br>
Signed-off-by: Ma Jun &lt;Jun.Ma2@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 +++---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 4 +---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp; | 5 ++---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c&nbsp; | 5 ++---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp; | 5 ++---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp; | 5 ++---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 +---<br>
&nbsp;7 files changed, 13 insertions(+), 21 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c<br>
index e114694d1131..4835d6d899e7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
@@ -304,11 +304,11 @@ static int amdgpu_gfx_kiq_acquire(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;}<br>
&nbsp;<br>
-int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct amdgpu_ring *ring,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct amdgpu_irq_src *irq, int xcc_id)<br>
+int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev, int xcc_id)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq =3D=
 &amp;adev-&gt;gfx.kiq[xcc_id];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *irq =3D &amp;k=
iq-&gt;irq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D &amp;kiq=
-&gt;ring;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_init(&amp;kiq-&g=
t;ring_lock);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h<br>
index f23bafec71c5..8fcf889ddce9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
@@ -471,9 +471,7 @@ static inline u32 amdgpu_gfx_create_bitmask(u32 bit_wid=
th)<br>
&nbsp;void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned max_sh);<br>
&nbsp;<br>
-int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct amdgpu_ring *ring,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct amdgpu_irq_src *irq, int xcc_id);<br>
+int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev, int xcc_id);<br>
&nbsp;<br>
&nbsp;void amdgpu_gfx_kiq_free_ring(struct amdgpu_ring *ring);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index b02d63328f1c..691fa40e4e01 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -4490,7 +4490,7 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_=
device *adev, int ring_id,<br>
&nbsp;static int gfx_v10_0_sw_init(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j, k, r, ring_id =
=3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcc_id =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(=
adev, GC_HWIP, 0)) {<br>
@@ -4619,8 +4619,7 @@ static int gfx_v10_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kiq =3D &amp;adev-&gt;gfx.kiq[0];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_gfx_kiq_init_ring(adev, &amp;kiq-&gt;ring, &amp;kiq=
-&gt;irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_gfx_kiq_init_ring(adev, xcc_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index 2fb1342d5bd9..9d8ec709cd52 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -1329,7 +1329,7 @@ static int gfx_v11_0_rlc_backdoor_autoload_enable(str=
uct amdgpu_device *adev)<br>
&nbsp;static int gfx_v11_0_sw_init(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j, k, r, ring_id =
=3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcc_id =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(=
adev, GC_HWIP, 0)) {<br>
@@ -1454,8 +1454,7 @@ static int gfx_v11_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kiq =3D &amp;adev-&gt;gfx.kiq[0];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_gfx_kiq_init_ring(adev, &amp;kiq-&gt;ring, &amp;kiq=
-&gt;irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_gfx_kiq_init_ring(adev, xcc_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c<br>
index ea174b76ee70..b97ea62212b6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
@@ -1900,8 +1900,8 @@ static void gfx_v8_0_sq_irq_work_func(struct work_str=
uct *work);<br>
&nbsp;static int gfx_v8_0_sw_init(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j, k, r, ring_id;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcc_id =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
@@ -2022,8 +2022,7 @@ static int gfx_v8_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kiq =3D &amp;adev-&gt;gfx.kiq[0];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gfx_kiq_init_ring(adev, =
&amp;kiq-&gt;ring, &amp;kiq-&gt;irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gfx_kiq_init_ring(adev, =
xcc_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 169d45268ef6..7669f82aa1da 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -1997,8 +1997,8 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_d=
evice *adev, int ring_id,<br>
&nbsp;static int gfx_v9_0_sw_init(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j, k, r, ring_id;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcc_id =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int hw_prio;<br>
&nbsp;<br>
@@ -2151,8 +2151,7 @@ static int gfx_v9_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kiq =3D &amp;adev-&gt;gfx.kiq[0];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gfx_kiq_init_ring(adev, =
&amp;kiq-&gt;ring, &amp;kiq-&gt;irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gfx_kiq_init_ring(adev, =
xcc_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c<br>
index aace4594a603..ec92c3c2080b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
@@ -843,7 +843,6 @@ static int gfx_v9_4_3_compute_ring_init(struct amdgpu_d=
evice *adev, int ring_id,<br>
&nbsp;static int gfx_v9_4_3_sw_init(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j, k, r, ring_id, x=
cc_id, num_xcc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mec.num_mec =
=3D 2;<br>
@@ -912,8 +911,7 @@ static int gfx_v9_4_3_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kiq =3D &amp;adev-&gt;gfx.kiq[xcc_id];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_gfx_kiq_init_ring(adev, &amp;kiq-&gt;ring, &amp;kiq=
-&gt;irq, xcc_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_gfx_kiq_init_ring(adev, xcc_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144993411507A21C7C96EBDF7512BL1PR12MB5144namp_--
