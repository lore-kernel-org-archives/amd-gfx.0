Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1194C44500
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2026 15:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 417F910E660;
	Sat,  4 Jul 2026 15:40:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="EOUpacNs";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 139DC10F855
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 16:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1783096375; x=1783701175; i=natalie.vock@gmx.de;
 bh=le/+4LC5/saAJAT2TchCTLPEnbQcchYmomXsBOcv4vE=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=EOUpacNsn+yo1PQiZ2qHOLWmmtOSLPKM3NY5alEEVLhrfR0GcPqxxbA14Vg4f/Z3
 /7r/F0DYrB9qSs58boseltR1HF58SYbnV02Y3jQXkIeK1Md7RQccQhN6qqRreCWsu
 k1HlZqXX0toTfP/NFbqEGzwuz3n8T01dvC7tCd94zkQXp/Qcecul6VYIGC8Lw0Sjy
 KCLLWtap+M6zrK7RncPsfSdEyMi570dz/DFh4eLmQHeuc+mwlF0SNKasrD6ZYVdFO
 lvoYoeuWUPvdrmi+LyzCpsN8lTHMDb67+Qz6t9lY+RkftTITgPBff1WqS3uFw3sfk
 b7kz+nfO9uWq4txSyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLiCu-1wO1Rf2K00-00KUis; Fri, 03
 Jul 2026 18:32:55 +0200
From: Natalie Vock <natalie.vock@gmx.de>
Date: Fri, 03 Jul 2026 18:31:30 +0200
Subject: [PATCH 10/10] drm/amdgpu: use drm_exec during BO validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260703-ttm_2_drm_exec-v1-10-43685ac1286b@gmx.de>
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
X-Provags-ID: V03:K1:nU9/uYCOrtgAtVdp4hFdQaqvYGdQXzNY1iKWoYGNYkWEXFKYeTp
 gih/inofv97+WAYIWr8pX6T5f7gunoUgcQHg+9E8edQDhANGPDGj6RCc1ABfJkzew69/vs1
 tpHmUTHJ85SZX3Vx+mul7c8gMaW4mCqmWLmoyE9/M3RVIyWNFkA5ejhtl4F5apJbBDYgfib
 uiS3M8RqtqyGEfmKNgmxA==
UI-OutboundReport: notjunk:1;M01:P0:D/wiWASBBc8=;pgbROJ0JP6l5oey5CQ20rR1zauw
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

This allows to detect deadlocks happening because of resource
constraints.

Especially submissions which want to use all of GDS doesn't result in
sporadic -ENOMEM any more.

Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 80 ++++++++++++++++++-----------=
=2D----
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_cs.c
index c2e6495a28bc5..052d41013f7a0 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -793,7 +793,7 @@ static int amdgpu_cs_bo_validate(void *param, struct a=
mdgpu_bo *bo)
 	struct ttm_operation_ctx ctx =3D {
 		.interruptible =3D true,
 		.no_wait_gpu =3D false,
-		.resv =3D bo->tbo.base.resv
+		.exec =3D &p->exec,
 	};
 	uint32_t domain;
 	int r;
@@ -845,7 +845,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parse=
r *p,
 				union drm_amdgpu_cs *cs)
 {
 	struct amdgpu_fpriv *fpriv =3D p->filp->driver_priv;
-	struct ttm_operation_ctx ctx =3D { true, false };
+	struct ttm_operation_ctx ctx =3D { .interruptible =3D true,
+					 .exec =3D &p->exec };
 	struct amdgpu_vm *vm =3D &fpriv->vm;
 	struct amdgpu_bo_list_entry *e;
 	struct drm_gem_object *obj;
@@ -922,47 +923,53 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_par=
ser *p,
 			if (unlikely(r))
 				goto out_free_user_pages;
 		}
-	}
-
-	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
-		struct mm_struct *usermm;
=20
-		usermm =3D amdgpu_ttm_tt_get_usermm(e->bo->tbo.ttm);
-		if (usermm && usermm !=3D current->mm) {
-			r =3D -EPERM;
-			goto out_free_user_pages;
-		}
+		amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
+			struct mm_struct *usermm;
=20
-		if (amdgpu_ttm_tt_is_userptr(e->bo->tbo.ttm) &&
-		    e->user_invalidated) {
-			amdgpu_bo_placement_from_domain(e->bo,
-							AMDGPU_GEM_DOMAIN_CPU);
-			r =3D ttm_bo_validate(&e->bo->tbo, &e->bo->placement,
-					    &ctx);
-			if (r)
+			usermm =3D amdgpu_ttm_tt_get_usermm(e->bo->tbo.ttm);
+			if (usermm && usermm !=3D current->mm) {
+				r =3D -EPERM;
 				goto out_free_user_pages;
+			}
=20
-			amdgpu_ttm_tt_set_user_pages(e->bo->tbo.ttm,
-						     e->range);
+			if (amdgpu_ttm_tt_is_userptr(e->bo->tbo.ttm) &&
+			    e->user_invalidated) {
+				amdgpu_bo_placement_from_domain(e->bo,
+								AMDGPU_GEM_DOMAIN_CPU);
+				r =3D ttm_bo_validate(&e->bo->tbo, &e->bo->placement,
+						    &ctx);
+				drm_exec_retry_on_contention(&p->exec);
+				if (r)
+					goto out_free_user_pages;
+
+				amdgpu_ttm_tt_set_user_pages(e->bo->tbo.ttm,
+							     e->range);
+			}
 		}
-	}
=20
-	amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_threshold,
-					  &p->bytes_moved_vis_threshold);
-	p->bytes_moved =3D 0;
-	p->bytes_moved_vis =3D 0;
-
-	r =3D amdgpu_vm_validate(p->adev, &fpriv->vm, NULL,
-			       amdgpu_cs_bo_validate, p);
-	if (r) {
-		drm_err(adev_to_drm(p->adev), "amdgpu_vm_validate() failed.\n");
-		goto out_free_user_pages;
-	}
+		amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_threshold,
+						  &p->bytes_moved_vis_threshold);
+		p->bytes_moved =3D 0;
+		p->bytes_moved_vis =3D 0;
=20
-	drm_exec_for_each_locked_object(&p->exec, obj) {
-		r =3D amdgpu_cs_bo_validate(p, gem_to_amdgpu_bo(obj));
-		if (unlikely(r))
+		r =3D amdgpu_vm_validate(p->adev, &fpriv->vm, NULL,
+				       amdgpu_cs_bo_validate, p);
+		drm_exec_retry_on_contention(&p->exec);
+		if (r) {
+			drm_err(adev_to_drm(p->adev), "amdgpu_vm_validate() failed.\n");
 			goto out_free_user_pages;
+		}
+
+		drm_exec_for_each_locked_object(&p->exec, obj) {
+			r =3D amdgpu_cs_bo_validate(p, gem_to_amdgpu_bo(obj));
+			drm_exec_retry_on_contention(&p->exec);
+			if (unlikely(r))
+				goto out_free_user_pages;
+		}
+
+		amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
+					     p->bytes_moved_vis);
 	}
=20
 	if (p->uf_bo) {
@@ -973,9 +980,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parse=
r *p,
 		p->gang_leader->uf_addr +=3D amdgpu_bo_gpu_offset(p->uf_bo);
 	}
=20
-	amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
-				     p->bytes_moved_vis);
-
 	for (i =3D 0; i < p->gang_size; ++i)
 		amdgpu_job_set_resources(p->jobs[i], p->bo_list->gds_obj,
 					 p->bo_list->gws_obj,

=2D-=20
2.55.0

