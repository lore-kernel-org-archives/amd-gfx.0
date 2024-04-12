Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F00DC00A94
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 14:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EC6910E0AD;
	Fri, 12 Apr 2024 14:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ETmQvRj";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57E4210E0AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 14:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mu18yQnqlfpnJHRT9gAIq0JXQU6fjv3+7SglLDI8Fu3G0eLUvEWnt1tjQo5/B0JZbZz2hMT3efJP6O20B81S3NFowP8WEbAxIr5LVGUycesOzmCcLtnljfuP3d0kuSWyaoAwszs5nxEizk29/MnivuxBBEIbsv9R2zzOLIvqNpLXA9iFifi/ma3bNdsxz0AT8rkkv8Uzn+Dh9bGBsK09QizE2DqfzK8tPThDrGIccSBrzOJPRASDKqFfPFBFy73H/5jvCTcT0zSfM9rqOl6UdLCIqJVwCtpCXSv2YKqK+sNzS27U0A+pS81Bh3uV2jhtiif9yCGbW0geKHTcHyLxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moTgcFvku/+QPviyNDb0PI807SL88HQyNRd11GnXEPs=;
 b=B143qMyG2Qh45/Dsyt9sEhg25nY/QazYpkXXfYBCMp3kSqANJLdotmBMZG2hzhqeaP26VE2GbRNrAG+mn7F4kil6EnQD+N2fBComwyIOvvZ3q4+to0Yy72QJQBUkMYkkyjswU3bS7EtXQbeLQFF1E3cynnmqqf6lGZ/Cx+oNGdbgkWDDCeNxQWFntJ58u3Vr+1tH8mvWMgay/ZamssFjmt49Oira5h0pDChWbor/5WghjO+nGiFyVLy79ju2pQqGzNCZsbFlC6cLdrsu6ufiJ2tv69xjIjDrXCwTRQZNdrc/qnU3xo4tcjtWKoR1/CNgxtogkZKUOEtkWdbZb8Ka7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moTgcFvku/+QPviyNDb0PI807SL88HQyNRd11GnXEPs=;
 b=4ETmQvRj7bEjqZNZyo4SZvKwFNQWPhhTkczuCGv9FVCZ538MsJE2xQO1v3PYj574ACnrkX7jHuPgexLK+5T9W161Y3OMqneWz/e9qVLwoRR6Fu8XDId5bRAuLvThZs3xrYjj7Z4v6/GjugBKdAsTjXJ10IIDNW9j6ZlXMng5IMI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 14:50:22 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7409.055; Fri, 12 Apr 2024
 14:50:22 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Min, Frank" <Frank.Min@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Gao, Likun" <Likun.Gao@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: replace tmz flag into buffer flag
Thread-Topic: [PATCH] drm/amdgpu: replace tmz flag into buffer flag
Thread-Index: AQHajNHoQlm5VCr0MEqW6HPIoLfZ2rFkt8q4
Date: Fri, 12 Apr 2024 14:50:22 +0000
Message-ID: <BL1PR12MB5144F4BFA1CC6285A5945638F7042@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240412120037.78562-1-Frank.Min@amd.com>
 <DM8PR12MB54626DE19C749CB7F2468047E9042@DM8PR12MB5462.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB54626DE19C749CB7F2468047E9042@DM8PR12MB5462.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-12T14:50:22.099Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB7913:EE_
x-ms-office365-filtering-correlation-id: 893ae8d4-7012-46a0-3e1b-08dc5affe17f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3BwEbctU40yhNMN5m+qgKAVwNwxJS7bIjhei2VsqFXJPJK7iZzJ5Xx+AO8RU4QxQiWmLXTyNS8iLpqMpccQohVwQ3cHMzL9XT1x6gq0IQ2R7M29t603yiAXA6my1UY/0um+oz/92ivmtWPDuGoYTptyfKt2TqEgjKS+x5NsssYYllqcW5GCyNQmzXn+Gm5j2BQI/kvxA3A/MS2f53kmlF7077lFs1ZfeweQ4Fq6O0NFhKtaEu2OS+R4/K+D52nb5Rbir+2eZobSEWfMOz4l4a8AtmwZZe6Dh68ZQ9tY3ktqFFyQgCJbxOImo+F8MSl4brvTZ/b9k5UA8xxIZK3EdYGFKRawJQiOSUmTkGFbvjMiJmNm0CzFaYtLB7ojlt3jMCdbUpfOH1oTZggq2GKk/wcZ0ZWxSaWaYqGDbh7HJidoIaznBQYVqznhN5nX7iSGGXK9jtFG/JRSXHavIoDD6D6Tar4abkIV1JamwIfO65sNPZ4YWkTYAXq4VNxozkXkVHcx08SGMeqWKVfsqXJOlb1QcJGI+ve2/6YU+h5RDc/0QyUG0pL7bzf4Y0h0CHW+aOt1G6UjGF5pHmMlxqEwbF2w7/dALWEgXVTnMdK2hhHgYpNp7LdFeI4bVu6zNus/qpEDMt0Tzb//RKF3930ypj7Mi45VMb/9mB40oFWBgiK/nHuclszJT2XUr4t6XJtZvh0wZl97NBwopnf10hCmNfXkk3NGzqEZzyQXJUc3yCGw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+jNp40Wa4yNjZfPdegRKBadVEqw8Pud2jlYIuRB3ref+rg3Pg7bo7C0906lj?=
 =?us-ascii?Q?3c1izNrjl56vD8BMvyrjunsKgdHGV03I32mnhB12bFtB3Yvaopiby4rKv36u?=
 =?us-ascii?Q?YahMrys36SATE777cHfBwsuij9Q5jlkNleB+ZA0nwjAC3/W6IClWKsL7YwTF?=
 =?us-ascii?Q?NEdqp6MYDpMrIsk57HEP4zt+RUZeKdeoE2s98ETMFdr1/lRf2ZLUYpL8B045?=
 =?us-ascii?Q?Y+TFrjMCeBfdK3vBlxXE4w4wUCNEs1+N4RfGHArab+fU5TvnzgArgJ5NXyNg?=
 =?us-ascii?Q?88fUNpu9F3DZeV9ontKBhtIh/egrI3RnejLxv7vt/eIFbj38XXVfoAkiBCco?=
 =?us-ascii?Q?vaLSSch+AB51hAvBx88HOLisnM3f8XoeD2Yvhz5tsgMaOBRWIOcgIkJguTx6?=
 =?us-ascii?Q?ratm/DOXnDO6Jp/j2Hqxx4xCAk2sYGCldJnJonO3iYnHDyPKi2eo02JwAtFZ?=
 =?us-ascii?Q?KFFJ1qRsZf8oP979Yhtfi6EHJkOotDPloBwdfydLwnfpR+0KzSC4AQ3VSJrX?=
 =?us-ascii?Q?nJ3gemTgwtqed6XPaHAPmiAYaHUJUQl/SpSU9F+hCoKD+F++9yAgtdwmYuFc?=
 =?us-ascii?Q?k0aEnniVUsSdjG/1dnTJx5HtGd4HDyhuf+n9BwGqutPDv9R0e9o+Ef63vsTU?=
 =?us-ascii?Q?h3rW0R4hgxEa/09kqx0Sk0dw/8myVR22RdHsn+UlzPpO+WqkDqVpEtvYLke8?=
 =?us-ascii?Q?ud0CePpu3GP/8rP9hrqgSByfZEHi+wo9pjzEmlMiB5bJhTGhADjA3pRqgsEt?=
 =?us-ascii?Q?FE3raxeKWKQbkN7XJAb0pCTea5mALkZQ+yvFyfwavdiL+szMlX4pc8MPs16P?=
 =?us-ascii?Q?qMk+yAzakxu0Ul03rY4CRY8cSZMi3s+pGaNYKC4pqhCj9uFASzrTZgEVH9hN?=
 =?us-ascii?Q?t2Zg5GCnpKZzWg64YWBFhsYM6JoQ5y0hrTS2Q9XdLevR/q+dvXyy3nm5ig3P?=
 =?us-ascii?Q?j8Z6o9wb3iub1fyryI1afQbb07FaFsU/iG8B8tMuCDcWVMhk33buHZdY5dvJ?=
 =?us-ascii?Q?cHX6IS0ATNqtrvkXIlapFNQe6/0mhFXjVEGXkwc9va6HcqfitS3CKxiTJQ7y?=
 =?us-ascii?Q?Cjw82anvmZsW9gte8bDYQAAlbKv5QUgyITiHHp+nl7GAsaoJl/ve+XaTEmOf?=
 =?us-ascii?Q?sG9DJRIMFOFSUyO/IPBBJABWlBGpvPcMTh1ZWCNBq+YvuPbUzDVr3PZFM7MK?=
 =?us-ascii?Q?0TcbcYxEGqjLRNwg5bZO1fMMz+YFiR0/fxzCDcPt+VnIgssMMgJQjWUQqiTB?=
 =?us-ascii?Q?0LaJSAWKww2T6Z5Aq+z1lNa6WNmgF84lOLh4WAitEWS+QbvcuUrAdpnUOczi?=
 =?us-ascii?Q?daK2zcEMcfNsVqFb85jZ76BNb78yemO3aRpVo+qdDjwt90g6GqJYXLkSXQ7q?=
 =?us-ascii?Q?IL0WBW/UJA5KKOsxdJkwq4aE1IHjE6y+skod26F4FUs8B3cozGCsLNXvJ66t?=
 =?us-ascii?Q?1Cjo/nXhV9vLiu5v8chANZWNRDO7Pg6sadijyf4hvSyTDfe1BxfaIEqWc7cp?=
 =?us-ascii?Q?8JwUJUeQKJyWu/ePKVO6p2PY7pYAzEbe2vQgXLHyx5c+JvXbf1eZgO35hDeJ?=
 =?us-ascii?Q?8swH7/bYnCGdxXEo1Bs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144F4BFA1CC6285A5945638F7042BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893ae8d4-7012-46a0-3e1b-08dc5affe17f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 14:50:22.5582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J92geODCdMPIF6o3FnTac6CViarwoaE4Xuf5qhlNTvw4VM24ndBmvqSr/iaO1p0g9vpOYAOL2qmo3q7gpHkzUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913
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

--_000_BL1PR12MB5144F4BFA1CC6285A5945638F7042BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Min, Frank <Frank.Min@amd.com>
Sent: Friday, April 12, 2024 8:06 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Gao, Likun <Likun.Gao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=
 Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christi=
an.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: replace tmz flag into buffer flag

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


--_000_BL1PR12MB5144F4BFA1CC6285A5945638F7042BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Min, Frank &lt;Frank.=
Min@amd.com&gt;<br>
<b>Sent:</b> Friday, April 12, 2024 8:06 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Gao, Likun &lt;Likun.Gao@amd.com&gt;; Zhang, Hawking &lt;Hawking=
.Zhang@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; K=
oenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: replace tmz flag into buffer flag</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - General]<br>
<br>
From: Frank Min &lt;Frank.Min@amd.com&gt;<br>
<br>
Replace tmz flag into buffer flag to make it easier to understand and exten=
d<br>
<br>
Signed-off-by: Likun Gao &lt;Likun.Gao@amd.com&gt;<br>
Signed-off-by: Frank Min &lt;Frank.Min@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.c&nbsp;&nbsp;&nbsp; |&nbsp; =
2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 4 ++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 18 +++++++++++-------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 4 +++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/cik_sdma.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 4 ++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 4 ++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 4 ++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 4 ++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 4 ++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 5 +++--<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_migrate.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 4 ++--<br>
&nbsp;15 files changed, 36 insertions(+), 29 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_benchmark.c<br>
index edc6377ec5ff..199693369c7c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c<br>
@@ -39,7 +39,7 @@ static int amdgpu_benchmark_do_move(struct amdgpu_device =
*adev, unsigned size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; n; i++) {<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D adev-&gt;mman.buffer_funcs_rin=
g;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; r =3D amdgpu_copy_buffer(ring, saddr, daddr, size, NULL, &a=
mp;fence,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f=
alse, false, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f=
alse, false, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto exit_d=
o_move;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; r =3D dma_fence_wait(fence, false);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c<br>
index 38742ff0ff49..abb1505c82ec 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
@@ -791,7 +791,7 @@ int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow, =
struct dma_fence **fence)<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_copy_buffer(ring, =
shadow_addr, parent_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_size(shadow), NU=
LL, fence,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true, false, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true, false, 0);<br>
&nbsp;}<br>
<br>
&nbsp;/**<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.h<br>
index a22c6446817b..b5bde6652838 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h<br>
@@ -136,7 +136,7 @@ struct amdgpu_buffer_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t dst_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* number of byte to transfer */=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t byte_count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool tmz);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t copy_flags);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* maximum bytes in a single ope=
ration */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; fill_max_bytes;<br>
@@ -154,7 +154,7 @@ struct amdgpu_buffer_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t byte_count);<br>
&nbsp;};<br>
<br>
-#define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)-&gt;mman.buff=
er_funcs-&gt;emit_copy_buffer((ib),&nbsp; (s), (d), (b), (t))<br>
+#define amdgpu_emit_copy_buffer(adev, ib, s, d, b, f)<br>
+(adev)-&gt;mman.buffer_funcs-&gt;emit_copy_buffer((ib), (s), (d), (b), (f)=
)<br>
&nbsp;#define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)-&gt;mman.bu=
ffer_funcs-&gt;emit_fill_buffer((ib), (s), (d), (b))<br>
<br>
&nbsp;struct amdgpu_sdma_instance *<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index f0fffbf2bdd5..d58ab879e125 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -267,7 +267,7 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_obje=
ct *bo,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst_addr =3D amdgpu_bo_gpu_offse=
t(adev-&gt;gart.bo);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst_addr +=3D window * AMDGPU_GT=
T_MAX_TRANSFER_SIZE * 8;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_emit_copy_buffer(adev, &a=
mp;job-&gt;ibs[0], src_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst_addr, num_bytes, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst_addr, num_bytes, 0);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_pad_ib(ring, &amp;jo=
b-&gt;ibs[0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(job-&gt;ibs[0].length_dw=
 &gt; num_dw); @@ -327,6 +327,8 @@ int amdgpu_ttm_copy_mem_to_mem(struct am=
dgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *fence =3D NULL=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t copy_flags =3D 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;mman.buffer_funcs_=
enabled) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_ERROR(&quot;Trying to move memory with ring turned off.=
\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -354,8 +356,11 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;=
<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_copy_buffer(ring, from, to, cur_size,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
esv, &amp;next, false, true, tmz);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (tmz)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; copy_flags |=3D =
AMDGPU_COPY_FLAGS_TMZ;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_copy_buffer(ring, from, to, cur_size, resv,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
amp;next, false, true, copy_flags);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;=
<br>
<br>
@@ -1782,7 +1787,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_b=
uffer_object *bo,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; swap(src_addr, dst_addr);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_emit_copy_buffer(adev, &a=
mp;job-&gt;ibs[0], src_addr, dst_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE, 0);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_pad_ib(adev-&gt;mman=
.buffer_funcs_ring, &amp;job-&gt;ibs[0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(job-&gt;ibs[0].length_dw=
 &gt; num_dw); @@ -2596,7 +2601,7 @@ int amdgpu_copy_buffer(struct amdgpu_r=
ing *ring, uint64_t src_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t dst_offs=
et, uint32_t byte_count,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_resv *=
resv,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence =
**fence, bool direct_submit,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool vm_needs_flush, b=
ool tmz)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool vm_needs_flush, u=
int32_t copy_flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D r=
ing-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_loops, num_dw;<=
br>
@@ -2622,8 +2627,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint=
64_t src_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t cur_size_in_bytes =3D min(byte_count, max_bytes);<=
br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_emit_copy_buffer(adev, &amp;job-&gt;ibs[0], src_offs=
et,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dst_offset, cur_size_in_bytes, tmz);<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dst_offset, cur_size_in_bytes, copy_flags);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; src_offset +=3D cur_size_in_bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dst_offset +=3D cur_size_in_bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; byte_count -=3D cur_size_in_bytes;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.h<br>
index fe37697a76b9..22cdbb52ba4e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
@@ -121,6 +121,8 @@ struct amdgpu_copy_mem {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; offset;<br>
&nbsp;};<br>
<br>
+#define AMDGPU_COPY_FLAGS_TMZ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; (1 &lt;&lt; 0)<br>
+<br>
&nbsp;int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size=
);&nbsp; void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev);&nbsp; int am=
dgpu_preempt_mgr_init(struct amdgpu_device *adev); @@ -158,7 +160,7 @@ int =
amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t
 src_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t dst_offs=
et, uint32_t byte_count,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_resv *=
resv,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence =
**fence, bool direct_submit,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool vm_needs_flush, b=
ool tmz);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool vm_needs_flush, u=
int32_t copy_flags);<br>
&nbsp;int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amdgpu_copy_mem *src,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amdgpu_copy_mem *dst, diff --gi=
t a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_=
sdma.c<br>
index ee5dce6f6043..ab1f112a0cbd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c<br>
@@ -1305,7 +1305,7 @@ static void cik_sdma_emit_copy_buffer(struct amdgpu_i=
b *ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ui=
nt64_t src_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ui=
nt64_t dst_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ui=
nt32_t byte_count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool tm=
z)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_=
t copy_flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D SDMA_PACKET(SDMA_OPCODE_COPY, SDMA_COPY_SUB_OPCODE_LINEAR, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D byte_count; diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drive=
rs/gpu/drm/amd/amdgpu/sdma_v2_4.c<br>
index 7ffaaaf1fcdd..93e933915e86 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c<br>
@@ -1191,7 +1191,7 @@ static void sdma_v2_4_emit_copy_buffer(struct amdgpu_=
ib *ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t src_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t dst_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t byte_count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
ool tmz)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t copy_flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v3_0.c<br>
index c5ea32687eb5..45ccd12bd857 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
@@ -1631,7 +1631,7 @@ static void sdma_v3_0_emit_copy_buffer(struct amdgpu_=
ib *ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t src_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t dst_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t byte_count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
ool tmz)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t copy_flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c<br>
index 7ae5f134f09b..90b936545dc9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
@@ -2468,11 +2468,11 @@ static void sdma_v4_0_emit_copy_buffer(struct amdgp=
u_ib *ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t src_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t dst_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t byte_count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
ool tmz)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t copy_flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SDMA_PKT_COPY_LINEAR_HEADER_TMZ(tmz ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags &amp; AMDGPU_COPY_FL=
AGS_TMZ)<br>
+? 1 : 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D byte_count - 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D 0; /* src/dst endian swap */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D lower_32_bits(src_offset); diff --git a/drivers/gpu/drm/amd/amdgpu/sdma=
_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c<br>
index fec5a3d1c4bc..7d1d65dca627 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c<br>
@@ -1981,11 +1981,11 @@ static void sdma_v4_4_2_emit_copy_buffer(struct amd=
gpu_ib *ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t src_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t dst_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t byte_count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
ool tmz)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t copy_flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SDMA_PKT_COPY_LINEAR_HEADER_TMZ(tmz ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags &amp; AMDGPU_COPY_FL=
AGS_TMZ)<br>
+? 1 : 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D byte_count - 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D 0; /* src/dst endian swap */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D lower_32_bits(src_offset); diff --git a/drivers/gpu/drm/amd/amdgpu/sdma=
_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
index c1ff5eda8961..6a669613d028 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
@@ -1836,11 +1836,11 @@ static void sdma_v5_0_emit_copy_buffer(struct amdgp=
u_ib *ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t src_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t dst_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t byte_count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
ool tmz)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t copy_flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SDMA_PKT_COPY_LINEAR_HEADER_TMZ(tmz ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags &amp; AMDGPU_COPY_FL=
AGS_TMZ)<br>
+? 1 : 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D byte_count - 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D 0; /* src/dst endian swap */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D lower_32_bits(src_offset); diff --git a/drivers/gpu/drm/amd/amdgpu/sdma=
_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
index c441a20a41a3..aa0901135f30 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
@@ -1778,11 +1778,11 @@ static void sdma_v5_2_emit_copy_buffer(struct amdgp=
u_ib *ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t src_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t dst_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t byte_count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
ool tmz)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t copy_flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SDMA_PKT_COPY_LINEAR_HEADER_TMZ(tmz ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags &amp; AMDGPU_COPY_FL=
AGS_TMZ)<br>
+? 1 : 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D byte_count - 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D 0; /* src/dst endian swap */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D lower_32_bits(src_offset); diff --git a/drivers/gpu/drm/amd/amdgpu/sdma=
_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c<br>
index f423cc6cc9d2..8a3889a20c60 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c<br>
@@ -1604,11 +1604,11 @@ static void sdma_v6_0_emit_copy_buffer(struct amdgp=
u_ib *ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t src_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t dst_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t byte_count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
ool tmz)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t copy_flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_COPY) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) =
|<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SDMA_PKT_COPY_LINEAR_HEADER_TMZ(tmz ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags &amp; AMDGPU_COPY_FL=
AGS_TMZ)<br>
+? 1 : 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D byte_count - 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D 0; /* src/dst endian swap */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D lower_32_bits(src_offset); diff --git a/drivers/gpu/drm/amd/amdgpu/sdma=
_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c<br>
index 33f1a549e7b5..0245b0374f65 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c<br>
@@ -1606,11 +1606,12 @@ static void sdma_v7_0_emit_copy_buffer(struct amdgp=
u_ib *ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t src_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t dst_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t byte_count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
ool tmz)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t copy_flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_COPY) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) =
|<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SDMA_PKT_COPY_LINEAR_HEADER_TMZ(tmz ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags &amp; AMDGPU_COPY_FL=
AGS_TMZ)<br>
+? 1 : 0);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D byte_count - 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D 0; /* src/dst endian swap */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D lower_32_bits(src_offset); diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_=
migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<br>
index 0ed275dd6ecf..c96e10b5b86f 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<br>
@@ -77,7 +77,7 @@ svm_migrate_gart_map(struct amdgpu_ring *ring, uint64_t n=
pages,<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst_addr =3D amdgpu_bo_gpu_offse=
t(adev-&gt;gart.bo);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_emit_copy_buffer(adev, &a=
mp;job-&gt;ibs[0], src_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst_addr, num_bytes, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst_addr, num_bytes, 0);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_pad_ib(ring, &amp;jo=
b-&gt;ibs[0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(job-&gt;ibs[0].length_dw=
 &gt; num_dw); @@ -153,7 +153,7 @@ svm_migrate_copy_memory_gart(struct amdg=
pu_device *adev, dma_addr_t *sys,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; r =3D amdgpu_copy_buffer(ring, gart_s, gart_d, size * PAGE_=
SIZE,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N=
ULL, &amp;next, false, true, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N=
ULL, &amp;next, false, true, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(ade=
v-&gt;dev, &quot;fail %d to copy memory\n&quot;, r);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_un=
lock;<br>
--<br>
2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144F4BFA1CC6285A5945638F7042BL1PR12MB5144namp_--
