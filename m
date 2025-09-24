Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2474FCAC5B3
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 10:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDE6B10E6D9;
	Wed, 24 Sep 2025 10:02:06 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 515EA10E6D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 10:02:03 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 58OA1vh83746277; Wed, 24 Sep 2025 15:31:57 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 58OA1vRS3746276;
 Wed, 24 Sep 2025 15:31:57 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
Subject: [Patch v2 2/2] drm/amdgpu: move variable declaration to top of
 amdgpu_cs_parser_bos
Date: Wed, 24 Sep 2025 15:31:56 +0530
Message-Id: <20250924100156.3746229-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924100156.3746229-1-sunil.khatri@amd.com>
References: <20250924100156.3746229-1-sunil.khatri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In function amdgpu_cs_parser_bos, declare the variables in the beginning
of the function and not during the initialization.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 31eea1c7dac3..a9bdc368c981 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -854,6 +854,9 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_list_entry *e;
 	struct drm_gem_object *obj;
+	struct amdgpu_bo *bo;
+	struct mm_struct *usermm;
+	bool userpage_invalidated;
 	unsigned long index;
 	unsigned int i;
 	int r;
@@ -882,14 +885,12 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	 * amdgpu_ttm_backend_bind() to flush and invalidate new pages
 	 */
 	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
-		bool userpage_invalidated = false;
-		struct amdgpu_bo *bo = e->bo;
+		userpage_invalidated = false;
+		bo = e->bo;
 		e->range = kzalloc(sizeof(*e->range), GFP_KERNEL);
 		if (unlikely(!e->range))
 			return -ENOMEM;
 
-		int i;
-
 		r = amdgpu_ttm_tt_get_user_pages(bo, e->range);
 		if (r)
 			goto out_free_user_pages;
@@ -930,8 +931,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	}
 
 	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
-		struct mm_struct *usermm;
-
 		usermm = amdgpu_ttm_tt_get_usermm(e->bo->tbo.ttm);
 		if (usermm && usermm != current->mm) {
 			r = -EPERM;
-- 
2.34.1

