Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8950AC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 12:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E13DB10F5CF;
	Fri, 12 Apr 2024 12:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rvFybzK+";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B93EB10F5CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 12:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3PE62FmDK2Mf4pwTPtus3DBGiXu4FNJp4F1rA26tLZjl7VTZjlkANQces5Si6g7dYcNp5ynV/kbzQsfqUJ4rE/GOFRntknyH0pnQylHmx+a5+xehoY3WOWIf3cY3bQOb1Mh02xLJXXcKPoxNwufcxtzgap/rQ8753kFQTkE3WJQVm4fl21VqCNheSin4gyqI3Kf73AHhq8heSgq9f7Rta5hTmY2qpHCa/a+ZtWi6v+nycm6Z2q71wwFEU1K8Np8vJ4S49wFxwLh+8h+eqYP9011IJYeUkcNttsnkKUsTdRaP6KXJTL9kAk2QGtVX6AbxU4l9Zlqaf9jIegJWN3wSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXPlZlTHG7+/vGHOjlzvas4F/CfTDAtz6dfUj+G7xKo=;
 b=fJA7LWjQYIIeDrILVRlc5Yci+Xnk6AQflMZX+ERDOm8nwGTupPuYOdAiDkklCdib9R19Q8SgOBjZm8fecwbuFT+jg8dpRgtUcPCToUOmIR13xt8diZ56dotxWe162LCPJ2nymJpTi6zOwVudvvFOs/tv9R6zhA6yX//SJ0qnyI0T2/eiSwMLQDUi46wrEHJVsxvxESQQXy0SOLqKicXJEiYc7bjxdEB9cEu4YlKkJ8r1opLRF08I2qC02haQTf22ADM3QS9Iy3HrjOntnEghiDJeDdJ5MivHM0w1ublRbHY7oJfH//1Q+TvJjMWQrvHu9k1FWEgOCHSCklttxCcShA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXPlZlTHG7+/vGHOjlzvas4F/CfTDAtz6dfUj+G7xKo=;
 b=rvFybzK+pDkD3MYThyVFu5Kn5AWRAHlWR635iWjSyrADfXBuWakMOEC/KIoGg2aZajThKo0F1vtg4hJ+s8c2IQq+PWvb9JvHjhGbOk/c+DLJwZxhoLouofBTOOpqPABvRrlcRB7YRStlCDz3RDbpOYCtTY7WcGBQQ9Ib0yWe+/8=
Received: from DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) by
 SJ2PR12MB9241.namprd12.prod.outlook.com (2603:10b6:a03:57b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 12:06:54 +0000
Received: from DM8PR12MB5462.namprd12.prod.outlook.com
 ([fe80::1be8:1c01:29ba:579]) by DM8PR12MB5462.namprd12.prod.outlook.com
 ([fe80::1be8:1c01:29ba:579%4]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 12:06:54 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Gao, Likun" <Likun.Gao@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: replace tmz flag into buffer flag
Thread-Topic: [PATCH] drm/amdgpu: replace tmz flag into buffer flag
Thread-Index: AQHajNHoQlm5VCr0MEqW6HPIoLfZ2g==
Date: Fri, 12 Apr 2024 12:06:54 +0000
Message-ID: <DM8PR12MB54626DE19C749CB7F2468047E9042@DM8PR12MB5462.namprd12.prod.outlook.com>
References: <20240412120037.78562-1-Frank.Min@amd.com>
In-Reply-To: <20240412120037.78562-1-Frank.Min@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=552b2088-5dda-45b6-9846-b5a03e7eaabf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-12T12:03:16Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5462:EE_|SJ2PR12MB9241:EE_
x-ms-office365-filtering-correlation-id: b7cd6045-fec4-4fed-a8af-08dc5ae90b49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1gFZ9tf5biIIHPHgkZRkWM1Kv3dOyrXwnp4QHMyWu5/a3PM7toet2q9nW/AGBXqKthdcHFkYsiIQ7g6Eub9A2BKB5xbrti1pK1LtS0Or9dEissjpsMdkUWeG7de4v2DaXjOBbaRqKF4kcEdjKy8K/LT5q6f1TZaZp6O7c/Btl0W2XPZLmrVg3GfFeFc/IJv+MkEOcWSKVJjhZhYk3G11pr0G+s24kKXk2nnMcA+2DkRmqTpdSVq51LC7+wCpUxDnB7OFn3Z55sSqEOAurhuiZZwuStad6xmF7jnto0DGQbOvibXVP0b8tTnrJ9sOXc12eDxUWjyKkZYhCw5wR2ThjAHXjQ4o86toGtTsz/f9OD63M6oIXRY33iunjsoTeXQWiSqft1T2qCuxDM4MkyMpr8THw7sRARHyCzQ2IYYjFqZAZKd2xQgZj1KWlfj7g30YxqRVwFDYLi/eJjPAi5h1A9dr/qBb7Jtv4oQKbGWShpt69DFRY1wkqtBTiA98ONONTfQC6v2lrCteWFBHEvTmMnYhz5cDH4SWqxKsOLw2Vd60B+wyWBv8QsP2RWeAGIkre8gQ5th7zELAp6w5l4TQN993xwG93i0GXXIpfF+vSK7OulIDhKoz89hrn1iwhSZUgjaAtJMfOxKnXCunWKBOZGk+68OhB+xbH+KjZ77EdNtNUmUqWgeeoK1wOAVPk7LGykJ02YFGho319kJkfpORfg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5462.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yZBnqSelX7zkAWndyNOXcgWxBheNFMlmJJlZ2NT8dFyVHX0K3IdfHrvgI3Nr?=
 =?us-ascii?Q?FhEIizAUD18ToRAFie/FLGYR9SWJerkidZCmEkQ93DgcTDmpVK28oGmsHOxe?=
 =?us-ascii?Q?HJxzZ4lNdx+HUKyJY9SjmZnyyPRI1PqYmQ6uCyAbkdNYURpfw2OayPy7OgaA?=
 =?us-ascii?Q?Ewr5Ism0tuAESdxQGp1+RbBYRkvy64kiV4g3rXPQoGqDNoSo0OH7DX3/RtSd?=
 =?us-ascii?Q?XfHTUSHgblrd9jU+g9TjI/h/pFJZKTat1JlLcjlKv6zaVZJOwAjmMMu2Yp0K?=
 =?us-ascii?Q?pQh1U+SjzvGi/t2GAIPRpDa3plNIRpdX3LVEazrBx98zYpOwrcLaEIlhYok5?=
 =?us-ascii?Q?fIxNPztRGxq90N9NXn7GEWl+rYR8MLlj9aVJCddPjiBxlZftktzAh5TrFb4C?=
 =?us-ascii?Q?Rz8irTA3xH+QlkbpAHONj0IcpKVF1dwVFpNMxY1ZUAMtMLnS1YJV+QtvMwfG?=
 =?us-ascii?Q?XG8WQERwpA4WJyLvDxlX7MlGoKLTL9DbfAf22ITo2qRHefXtqqfP8CRq/fiF?=
 =?us-ascii?Q?8SIo+Ch7aNJpwLjSwHM61g0eqzSpjr/xGedO97+99vuiAeV3CSCpkm7HPOS7?=
 =?us-ascii?Q?8NSv7Lt4aflQg8M/LL+LTfudYrBN8nA4k5riBrifQbqQqfQ17l/MEUZKKmdZ?=
 =?us-ascii?Q?RgCBvTctricqElslWAySn7VvmDRwIZmwWKrn7QxdcV1nTCZPfrkG68tdexZC?=
 =?us-ascii?Q?6aTO/wv0fLp+dzYdKlzfWzGZZldGCwSYi0Gcvy3At54YKr9naviIwgIOzV1c?=
 =?us-ascii?Q?PnuDZZYSWGeFyzQJuS4yIVS+vP7bzEe9LF5qcRvFDLJYOEye5L8xzYxPKM+B?=
 =?us-ascii?Q?+aVDaO92bhfJuhseNDm27wj1kpax1HA5fIRSeoUbabQ6CtHfve986bZ9f/I6?=
 =?us-ascii?Q?HIpUBmF9bA16I0Q+eYEHvFMRgqhgKuLYAfmLnBKsqll6UwGuIhpUsKGbQGSH?=
 =?us-ascii?Q?oyqEcIrEVaNFj5JA+J6qLZHPVw5TwGn8Ew5l2xYYXarxhBYQC2ILJU0CG//5?=
 =?us-ascii?Q?ozmbuxZDdmbnETV6AbW9DWaTZTrYRh5cksH4EDlKNJ4J2byJur1xE5je5HnA?=
 =?us-ascii?Q?jCn2R0QTZakqwHC2S8LKvc6wbZW8D0U6jXt9F0zxZGNGGFQ1XHbdM7yadYTG?=
 =?us-ascii?Q?acwMYjF72GFgm2GH0YG44XZA0jRnl7h1FXv3/fEDDI6QVxhJX5TvUg86IynS?=
 =?us-ascii?Q?IthUk/Lf7W+6zTeCb0pid1SdxhsHlTy4sPChJ3FMhLEFhIE5hMY9WW1L+e53?=
 =?us-ascii?Q?IwZrT7umQtzUjTCkS+n8PVx9AxGVGTyGmvYxkz8WSLNRe7nqrADGbykMiU9D?=
 =?us-ascii?Q?Dho99HNxrtsb+07061INDof/qN1hQBhq7xfh9SCc0hhVJEVas2wUF+XhymZK?=
 =?us-ascii?Q?2dLsAyy3TZ6trxvuBld/HnkfP5afvvPbhAHFBnhdS4yggZHrCtCbXHNf+mL9?=
 =?us-ascii?Q?kb6B32I88GwwwsyZUTOCnz7FemUgVshDfMKqvsgyiCa+dBgg42TorG4svU/m?=
 =?us-ascii?Q?pnL5k0y+vwbD+hX08QbgdFO6wQjfYAqMTFiTgBiv+ruCSG2Ds4A8y1xyU0Tp?=
 =?us-ascii?Q?xxlzmP5asTQqhxFUqhs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cd6045-fec4-4fed-a8af-08dc5ae90b49
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 12:06:54.2976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jw5BKfaKH1R0F8elCqi7F/ihcfuqJgiXqZlKBxTBwkkYOZLEPR0zzjTVzSP59uUi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9241
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

[AMD Official Use Only - General]

From: Frank Min <Frank.Min@amd.com>

Replace tmz flag into buffer flag to make it easier to understand and exten=
d

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 18 +++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  4 +++-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |  5 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  4 ++--
 15 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_benchmark.c
index edc6377ec5ff..199693369c7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -39,7 +39,7 @@ static int amdgpu_benchmark_do_move(struct amdgpu_device =
*adev, unsigned size,
        for (i =3D 0; i < n; i++) {
                struct amdgpu_ring *ring =3D adev->mman.buffer_funcs_ring;
                r =3D amdgpu_copy_buffer(ring, saddr, daddr, size, NULL, &f=
ence,
-                                      false, false, false);
+                                      false, false, 0);
                if (r)
                        goto exit_do_move;
                r =3D dma_fence_wait(fence, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 38742ff0ff49..abb1505c82ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -791,7 +791,7 @@ int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow, =
struct dma_fence **fence)

        return amdgpu_copy_buffer(ring, shadow_addr, parent_addr,
                                  amdgpu_bo_size(shadow), NULL, fence,
-                                 true, false, false);
+                                 true, false, 0);
 }

 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.h
index a22c6446817b..b5bde6652838 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -136,7 +136,7 @@ struct amdgpu_buffer_funcs {
                                 uint64_t dst_offset,
                                 /* number of byte to transfer */
                                 uint32_t byte_count,
-                                bool tmz);
+                                uint32_t copy_flags);

        /* maximum bytes in a single operation */
        uint32_t        fill_max_bytes;
@@ -154,7 +154,7 @@ struct amdgpu_buffer_funcs {
                                 uint32_t byte_count);
 };

-#define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_=
funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
+#define amdgpu_emit_copy_buffer(adev, ib, s, d, b, f)
+(adev)->mman.buffer_funcs->emit_copy_buffer((ib), (s), (d), (b), (f))
 #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_fun=
cs->emit_fill_buffer((ib), (s), (d), (b))

 struct amdgpu_sdma_instance *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index f0fffbf2bdd5..d58ab879e125 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -267,7 +267,7 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_obje=
ct *bo,
        dst_addr =3D amdgpu_bo_gpu_offset(adev->gart.bo);
        dst_addr +=3D window * AMDGPU_GTT_MAX_TRANSFER_SIZE * 8;
        amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr,
-                               dst_addr, num_bytes, false);
+                               dst_addr, num_bytes, 0);

        amdgpu_ring_pad_ib(ring, &job->ibs[0]);
        WARN_ON(job->ibs[0].length_dw > num_dw); @@ -327,6 +327,8 @@ int am=
dgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
        struct dma_fence *fence =3D NULL;
        int r =3D 0;

+       uint32_t copy_flags =3D 0;
+
        if (!adev->mman.buffer_funcs_enabled) {
                DRM_ERROR("Trying to move memory with ring turned off.\n");
                return -EINVAL;
@@ -354,8 +356,11 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *a=
dev,
                if (r)
                        goto error;

-               r =3D amdgpu_copy_buffer(ring, from, to, cur_size,
-                                      resv, &next, false, true, tmz);
+               if (tmz)
+                       copy_flags |=3D AMDGPU_COPY_FLAGS_TMZ;
+
+               r =3D amdgpu_copy_buffer(ring, from, to, cur_size, resv,
+                                      &next, false, true, copy_flags);
                if (r)
                        goto error;

@@ -1782,7 +1787,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_b=
uffer_object *bo,
                swap(src_addr, dst_addr);

        amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr,
-                               PAGE_SIZE, false);
+                               PAGE_SIZE, 0);

        amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
        WARN_ON(job->ibs[0].length_dw > num_dw); @@ -2596,7 +2601,7 @@ int =
amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
                       uint64_t dst_offset, uint32_t byte_count,
                       struct dma_resv *resv,
                       struct dma_fence **fence, bool direct_submit,
-                      bool vm_needs_flush, bool tmz)
+                      bool vm_needs_flush, uint32_t copy_flags)
 {
        struct amdgpu_device *adev =3D ring->adev;
        unsigned int num_loops, num_dw;
@@ -2622,8 +2627,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint=
64_t src_offset,
                uint32_t cur_size_in_bytes =3D min(byte_count, max_bytes);

                amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_offset,
-                                       dst_offset, cur_size_in_bytes, tmz)=
;
-
+                                       dst_offset, cur_size_in_bytes, copy=
_flags);
                src_offset +=3D cur_size_in_bytes;
                dst_offset +=3D cur_size_in_bytes;
                byte_count -=3D cur_size_in_bytes;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.h
index fe37697a76b9..22cdbb52ba4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -121,6 +121,8 @@ struct amdgpu_copy_mem {
        unsigned long                   offset;
 };

+#define AMDGPU_COPY_FLAGS_TMZ          (1 << 0)
+
 int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size);  v=
oid amdgpu_gtt_mgr_fini(struct amdgpu_device *adev);  int amdgpu_preempt_mg=
r_init(struct amdgpu_device *adev); @@ -158,7 +160,7 @@ int amdgpu_copy_buf=
fer(struct amdgpu_ring *ring, uint64_t src_offset,
                       uint64_t dst_offset, uint32_t byte_count,
                       struct dma_resv *resv,
                       struct dma_fence **fence, bool direct_submit,
-                      bool vm_needs_flush, bool tmz);
+                      bool vm_needs_flush, uint32_t copy_flags);
 int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
                               const struct amdgpu_copy_mem *src,
                               const struct amdgpu_copy_mem *dst, diff --gi=
t a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_=
sdma.c
index ee5dce6f6043..ab1f112a0cbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -1305,7 +1305,7 @@ static void cik_sdma_emit_copy_buffer(struct amdgpu_i=
b *ib,
                                      uint64_t src_offset,
                                      uint64_t dst_offset,
                                      uint32_t byte_count,
-                                     bool tmz)
+                                     uint32_t copy_flags)
 {
        ib->ptr[ib->length_dw++] =3D SDMA_PACKET(SDMA_OPCODE_COPY, SDMA_COP=
Y_SUB_OPCODE_LINEAR, 0);
        ib->ptr[ib->length_dw++] =3D byte_count; diff --git a/drivers/gpu/d=
rm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 7ffaaaf1fcdd..93e933915e86 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -1191,7 +1191,7 @@ static void sdma_v2_4_emit_copy_buffer(struct amdgpu_=
ib *ib,
                                       uint64_t src_offset,
                                       uint64_t dst_offset,
                                       uint32_t byte_count,
-                                      bool tmz)
+                                      uint32_t copy_flags)
 {
        ib->ptr[ib->length_dw++] =3D SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |
                SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v3_0.c
index c5ea32687eb5..45ccd12bd857 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1631,7 +1631,7 @@ static void sdma_v3_0_emit_copy_buffer(struct amdgpu_=
ib *ib,
                                       uint64_t src_offset,
                                       uint64_t dst_offset,
                                       uint32_t byte_count,
-                                      bool tmz)
+                                      uint32_t copy_flags)
 {
        ib->ptr[ib->length_dw++] =3D SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |
                SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c
index 7ae5f134f09b..90b936545dc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2468,11 +2468,11 @@ static void sdma_v4_0_emit_copy_buffer(struct amdgp=
u_ib *ib,
                                       uint64_t src_offset,
                                       uint64_t dst_offset,
                                       uint32_t byte_count,
-                                      bool tmz)
+                                      uint32_t copy_flags)
 {
        ib->ptr[ib->length_dw++] =3D SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |
                SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) |
-               SDMA_PKT_COPY_LINEAR_HEADER_TMZ(tmz ? 1 : 0);
+               SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags & AMDGPU_COPY_F=
LAGS_TMZ)
+? 1 : 0);
        ib->ptr[ib->length_dw++] =3D byte_count - 1;
        ib->ptr[ib->length_dw++] =3D 0; /* src/dst endian swap */
        ib->ptr[ib->length_dw++] =3D lower_32_bits(src_offset); diff --git =
a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdm=
a_v4_4_2.c
index fec5a3d1c4bc..7d1d65dca627 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1981,11 +1981,11 @@ static void sdma_v4_4_2_emit_copy_buffer(struct amd=
gpu_ib *ib,
                                       uint64_t src_offset,
                                       uint64_t dst_offset,
                                       uint32_t byte_count,
-                                      bool tmz)
+                                      uint32_t copy_flags)
 {
        ib->ptr[ib->length_dw++] =3D SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |
                SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) |
-               SDMA_PKT_COPY_LINEAR_HEADER_TMZ(tmz ? 1 : 0);
+               SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags & AMDGPU_COPY_F=
LAGS_TMZ)
+? 1 : 0);
        ib->ptr[ib->length_dw++] =3D byte_count - 1;
        ib->ptr[ib->length_dw++] =3D 0; /* src/dst endian swap */
        ib->ptr[ib->length_dw++] =3D lower_32_bits(src_offset); diff --git =
a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_=
v5_0.c
index c1ff5eda8961..6a669613d028 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1836,11 +1836,11 @@ static void sdma_v5_0_emit_copy_buffer(struct amdgp=
u_ib *ib,
                                       uint64_t src_offset,
                                       uint64_t dst_offset,
                                       uint32_t byte_count,
-                                      bool tmz)
+                                      uint32_t copy_flags)
 {
        ib->ptr[ib->length_dw++] =3D SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |
                SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) |
-               SDMA_PKT_COPY_LINEAR_HEADER_TMZ(tmz ? 1 : 0);
+               SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags & AMDGPU_COPY_F=
LAGS_TMZ)
+? 1 : 0);
        ib->ptr[ib->length_dw++] =3D byte_count - 1;
        ib->ptr[ib->length_dw++] =3D 0; /* src/dst endian swap */
        ib->ptr[ib->length_dw++] =3D lower_32_bits(src_offset); diff --git =
a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_=
v5_2.c
index c441a20a41a3..aa0901135f30 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1778,11 +1778,11 @@ static void sdma_v5_2_emit_copy_buffer(struct amdgp=
u_ib *ib,
                                       uint64_t src_offset,
                                       uint64_t dst_offset,
                                       uint32_t byte_count,
-                                      bool tmz)
+                                      uint32_t copy_flags)
 {
        ib->ptr[ib->length_dw++] =3D SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |
                SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) |
-               SDMA_PKT_COPY_LINEAR_HEADER_TMZ(tmz ? 1 : 0);
+               SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags & AMDGPU_COPY_F=
LAGS_TMZ)
+? 1 : 0);
        ib->ptr[ib->length_dw++] =3D byte_count - 1;
        ib->ptr[ib->length_dw++] =3D 0; /* src/dst endian swap */
        ib->ptr[ib->length_dw++] =3D lower_32_bits(src_offset); diff --git =
a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_=
v6_0.c
index f423cc6cc9d2..8a3889a20c60 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1604,11 +1604,11 @@ static void sdma_v6_0_emit_copy_buffer(struct amdgp=
u_ib *ib,
                                       uint64_t src_offset,
                                       uint64_t dst_offset,
                                       uint32_t byte_count,
-                                      bool tmz)
+                                      uint32_t copy_flags)
 {
        ib->ptr[ib->length_dw++] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP=
_COPY) |
                SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) =
|
-               SDMA_PKT_COPY_LINEAR_HEADER_TMZ(tmz ? 1 : 0);
+               SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags & AMDGPU_COPY_F=
LAGS_TMZ)
+? 1 : 0);
        ib->ptr[ib->length_dw++] =3D byte_count - 1;
        ib->ptr[ib->length_dw++] =3D 0; /* src/dst endian swap */
        ib->ptr[ib->length_dw++] =3D lower_32_bits(src_offset); diff --git =
a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_=
v7_0.c
index 33f1a549e7b5..0245b0374f65 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1606,11 +1606,12 @@ static void sdma_v7_0_emit_copy_buffer(struct amdgp=
u_ib *ib,
                                       uint64_t src_offset,
                                       uint64_t dst_offset,
                                       uint32_t byte_count,
-                                      bool tmz)
+                                      uint32_t copy_flags)
 {
        ib->ptr[ib->length_dw++] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP=
_COPY) |
                SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) =
|
-               SDMA_PKT_COPY_LINEAR_HEADER_TMZ(tmz ? 1 : 0);
+               SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags & AMDGPU_COPY_F=
LAGS_TMZ)
+? 1 : 0);
+
        ib->ptr[ib->length_dw++] =3D byte_count - 1;
        ib->ptr[ib->length_dw++] =3D 0; /* src/dst endian swap */
        ib->ptr[ib->length_dw++] =3D lower_32_bits(src_offset); diff --git =
a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd=
_migrate.c
index 0ed275dd6ecf..c96e10b5b86f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -77,7 +77,7 @@ svm_migrate_gart_map(struct amdgpu_ring *ring, uint64_t n=
pages,

        dst_addr =3D amdgpu_bo_gpu_offset(adev->gart.bo);
        amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr,
-                               dst_addr, num_bytes, false);
+                               dst_addr, num_bytes, 0);

        amdgpu_ring_pad_ib(ring, &job->ibs[0]);
        WARN_ON(job->ibs[0].length_dw > num_dw); @@ -153,7 +153,7 @@ svm_mi=
grate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
                }

                r =3D amdgpu_copy_buffer(ring, gart_s, gart_d, size * PAGE_=
SIZE,
-                                      NULL, &next, false, true, false);
+                                      NULL, &next, false, true, 0);
                if (r) {
                        dev_err(adev->dev, "fail %d to copy memory\n", r);
                        goto out_unlock;
--
2.34.1

