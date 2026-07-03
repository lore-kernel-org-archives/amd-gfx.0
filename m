Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F231C43458
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2026 15:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72D1B10E086;
	Sat,  4 Jul 2026 15:40:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="hhLQwlX1";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E856010E63D
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 16:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1783096371; x=1783701171; i=natalie.vock@gmx.de;
 bh=li6JD5BzxFrXyhk2BReSodr3KolfnDlr1k9+PHB66B4=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=hhLQwlX1jkeKN24vaTbhVBSQ8Ji34v/69i5AhHRynzVwVEYWLgJj0zyjisfJ7dVy
 gpOo7Kc7rLxq5Aq06FNKnCId4UQITMuBrBXqw5VG55koJ7BReGBjilHEJTzu4YSUv
 qFJgleyebEsBsRfgdsMvaIX3QxpPlBT64yfBgB/2VbhWMUzvamaK1Tz3KO+g1Lipn
 fKtcPTicikuWkuWtT+YAdaFkuQiPSQ0y05MXNmw9B+GFLUH4eWZWBd6xMWeZon4tT
 fSu8R9lNzUzVy1SUe9OyISPVZSLZcCQKVfP2mGKawsfCQlGKiICqZwnW7Y5xEWRvG
 fT9nx+rOMvnEMxyd9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1wV8RY40hS-00TsuG; Fri, 03
 Jul 2026 18:32:51 +0200
From: Natalie Vock <natalie.vock@gmx.de>
Date: Fri, 03 Jul 2026 18:31:25 +0200
Subject: [PATCH 05/10] drm/ttm: switch to
 ttm_bo_lru_for_each_reserved_guarded for swapout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260703-ttm_2_drm_exec-v1-5-43685ac1286b@gmx.de>
References: <20260703-ttm_2_drm_exec-v1-0-43685ac1286b@gmx.de>
In-Reply-To: <20260703-ttm_2_drm_exec-v1-0-43685ac1286b@gmx.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Provags-ID: V03:K1:TyKwjnSWrx97wHMmNHlof2HVSIzmL9oN3qV5qkMyaHWrnjXtP2U
 7yHv1eoullH+6Rpgpi4Lxx8lVWxKqYkrwLDqN3o/sdijuyLuNBCaJO9g4tYnxComAkjfLd5
 rULbVL272mY+pG8MoUPIExCqsae445mtAOmw32CFJi2QL9HfCl7XbkyBLUaPOL5VJ2KwZg3
 RO8Qt9obHkSdHNhEnVxlg==
UI-OutboundReport: notjunk:1;M01:P0:uqo61cKQ6gY=;+YGARjrHCnQWijs1LsexEELFWYe
 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
X-Mailman-Approved-At: Sat, 04 Jul 2026 15:40:15 +0000
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

From: Christian K=C3=B6nig <christian.koenig@amd.com>

Instead of the walker wrapper use the underlying foreach. Saves us quite
a bunch of complexity and loc.

Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/ttm/ttm_bo.c     | 58 +++++++----------------------------=
=2D----
 drivers/gpu/drm/ttm/ttm_device.c | 19 ++++++++++---
 include/drm/ttm/ttm_bo.h         |  5 ++--
 3 files changed, 27 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 1fb8c53da0362..24c52df169ac8 100644
=2D-- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1080,25 +1080,18 @@ int ttm_bo_wait_ctx(struct ttm_buffer_object *bo, =
struct ttm_operation_ctx *ctx)
 EXPORT_SYMBOL(ttm_bo_wait_ctx);
=20
 /**
- * struct ttm_bo_swapout_walk - Parameters for the swapout walk
+ * ttm_bo_swapout() - Swap out buffer objects on the LRU list to shmem.
+ * @bo: The buffer to swap out.
+ * @ctx: The ttm_operation_ctx governing the swapout operation.
+ * @gfp_flags: The gfp flags used for shmem page allocations.
+ *
+ * Return: The number of bytes actually swapped out, or negative error co=
de
+ * on error.
  */
-struct ttm_bo_swapout_walk {
-	/** @walk: The walk base parameters. */
-	struct ttm_lru_walk walk;
-	/** @gfp_flags: The gfp flags to use for ttm_tt_swapout() */
-	gfp_t gfp_flags;
-	/** @hit_low: Whether we should attempt to swap BO's with low watermark =
threshold */
-	/** @evict_low: If we cannot swap a bo when @try_low is false (first pas=
s) */
-	bool hit_low, evict_low;
-};
-
-static s64
-ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo=
)
+s64 ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx=
 *ctx,
+		   gfp_t gfp_flags)
 {
 	struct ttm_place place =3D { .mem_type =3D bo->resource->mem_type };
-	struct ttm_bo_swapout_walk *swapout_walk =3D
-		container_of(walk, typeof(*swapout_walk), walk);
-	struct ttm_operation_ctx *ctx =3D walk->arg.ctx;
 	struct ttm_device *bdev =3D bo->bdev;
 	struct ttm_tt *tt =3D bo->ttm;
 	s64 ret;
@@ -1166,7 +1159,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct =
ttm_buffer_object *bo)
 		bdev->funcs->swap_notify(bo);
=20
 	if (ttm_tt_is_populated(tt)) {
-		ret =3D ttm_tt_swapout(bdev, tt, swapout_walk->gfp_flags);
+		ret =3D ttm_tt_swapout(bdev, tt, gfp_flags);
 		if (!ret) {
 			spin_lock(&bdev->lru_lock);
 			ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
@@ -1183,37 +1176,6 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct=
 ttm_buffer_object *bo)
 	return ret;
 }
=20
-/**
- * ttm_bo_swapout() - Swap out buffer objects on the LRU list to shmem.
- * @bdev: The ttm device.
- * @ctx: The ttm_operation_ctx governing the swapout operation.
- * @man: The resource manager whose resources / buffer objects are
- * goint to be swapped out.
- * @gfp_flags: The gfp flags used for shmem page allocations.
- * @target: The desired number of pages to swap out.
- *
- * Return: The number of pages actually swapped out, or negative error co=
de
- * on error.
- */
-s64 ttm_bo_swapout(struct ttm_device *bdev, struct ttm_operation_ctx *ctx=
,
-		   struct ttm_resource_manager *man, gfp_t gfp_flags,
-		   s64 target)
-{
-	struct ttm_bo_swapout_walk swapout_walk =3D {
-		.walk =3D {
-			.process_bo =3D ttm_bo_swapout_cb,
-			.arg =3D {
-				.ctx =3D ctx,
-				.trylock_only =3D true,
-			},
-		},
-		.gfp_flags =3D gfp_flags,
-	};
-
-	return ttm_lru_walk_for_evict(&swapout_walk.walk, bdev, man, target);
-}
-EXPORT_SYMBOL_FOR_TESTS_ONLY(ttm_bo_swapout);
-
 void ttm_bo_tt_destroy(struct ttm_buffer_object *bo)
 {
 	if (bo->ttm =3D=3D NULL)
diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_de=
vice.c
index d3bfb9a696a74..e4188e2ee7ab1 100644
=2D-- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -171,6 +171,12 @@ int ttm_device_swapout(struct ttm_device *bdev, struc=
t ttm_operation_ctx *ctx,
 		       gfp_t gfp_flags)
 {
 	struct ttm_resource_manager *man;
+	struct ttm_bo_lru_cursor cursor;
+	struct ttm_buffer_object *bo;
+	struct ttm_lru_walk_arg arg =3D {
+		.ctx =3D ctx,
+		.trylock_only =3D true
+	};
 	unsigned i;
 	s64 lret;
=20
@@ -179,10 +185,15 @@ int ttm_device_swapout(struct ttm_device *bdev, stru=
ct ttm_operation_ctx *ctx,
 		if (!man || !man->use_tt)
 			continue;
=20
-		lret =3D ttm_bo_swapout(bdev, ctx, man, gfp_flags, 1);
-		/* Can be both positive (num_pages) and negative (error) */
-		if (lret)
-			return lret;
+		ttm_bo_lru_for_each_reserved_guarded(&cursor, man, &arg, bo) {
+			lret =3D ttm_bo_swapout(bo, ctx, gfp_flags);
+				continue;
+			/* Can be both positive (num_pages) and negative (error) */
+			if (lret && lret !=3D -EBUSY && lret !=3D -EALREADY)
+				return lret;
+		}
+		if (IS_ERR(bo))
+			return PTR_ERR(bo);
 	}
 	return 0;
 }
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 0fcd5082a7080..bbed63064c9a9 100644
=2D-- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -408,9 +408,8 @@ void *ttm_bo_kmap_try_from_panic(struct ttm_buffer_obj=
ect *bo, unsigned long pag
 int ttm_bo_vmap(struct ttm_buffer_object *bo, struct iosys_map *map);
 void ttm_bo_vunmap(struct ttm_buffer_object *bo, struct iosys_map *map);
 int ttm_bo_mmap_obj(struct vm_area_struct *vma, struct ttm_buffer_object =
*bo);
-s64 ttm_bo_swapout(struct ttm_device *bdev, struct ttm_operation_ctx *ctx=
,
-		   struct ttm_resource_manager *man, gfp_t gfp_flags,
-		   s64 target);
+s64 ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx=
 *ctx,
+		   gfp_t gfp_flags);
 void ttm_bo_pin(struct ttm_buffer_object *bo);
 void ttm_bo_unpin(struct ttm_buffer_object *bo);
 int ttm_bo_evict_first(struct ttm_device *bdev,

=2D-=20
2.55.0

