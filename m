From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: set tbo pointer as null after amdgpu bo is
 freed
Date: Mon, 10 Sep 2018 16:57:56 +0800
Message-ID: <1536569876-27262-2-git-send-email-ray.huang@amd.com>
References: <1536569876-27262-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0707274790=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1536569876-27262-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom StDenis <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

--===============0707274790==
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit

The tbo pointer will still have value even the amdgpu bo is freed.
It doesn't make sense that it still points a freed memory. It could be refered
mistakenly, so set it as null.

Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Tom StDenis <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index de990bd..ae84c08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -108,6 +108,7 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 	}
 	kfree(bo->metadata);
 	kfree(bo);
+	tbo = NULL;
 }
 
 /**
-- 
2.7.4


--===============0707274790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0707274790==--
