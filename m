From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/amdgpu: check memory allocation failure
Date: Wed, 23 Aug 2017 07:52:36 +0200
Message-ID: <20170823055236.25451-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie, Monk.Liu@amd.com, David1.Zhou@amd.com, AlexBin.Xie@amd.com, Jerry.Zhang@amd.com, airlied@redhat.com, marek.olsak@amd.com, john@fastquake.com, andresx7@gmail.com, ray.huang@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: amd-gfx.lists.freedesktop.org

Check memory allocation failure and return -ENOMEM in such a case.

'num_post_dep_syncobjs' still has to be set to 0 before the test in order
to have it initialized if 'amdgpu_cs_parser_fini()' is called to free
resources.

The calling graph would be, in such a case!
   failure in amdgpu_cs_process_syncobj_out_dep()
      ---> error code returned by amdgpu_cs_dependencies()
         --> amdgpu_cs_parser_fini() is called

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 15d4a28d73bb..baa90df90aea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1079,6 +1079,9 @@ static int amdgpu_cs_process_syncobj_out_dep(struct amdgpu_cs_parser *p,
 					     GFP_KERNEL);
 	p->num_post_dep_syncobjs = 0;
 
+	if (!p->post_dep_syncobjs)
+		return -ENOMEM;
+
 	for (i = 0; i < num_deps; ++i) {
 		p->post_dep_syncobjs[i] = drm_syncobj_find(p->filp, deps[i].handle);
 		if (!p->post_dep_syncobjs[i])
-- 
2.11.0
