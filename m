From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [bug report] drm/radeon: never unpin UVD bo v3
Date: Tue, 26 Nov 2019 07:50:59 +0300
Message-ID: <20191126045059.xod22qsrqrh3n22l@kili.mountain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0315566366=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0315566366==
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Christian König,

The patch 9cc2e0e9f133: "drm/radeon: never unpin UVD bo v3" from Jul
12, 2013, leads to the following static checker warning:

	drivers/gpu/drm/radeon/radeon_uvd.c:225 radeon_uvd_init()
	warn: inconsistent returns '*rdev->uvd.vcpu_bo->tbo.base.resv'.

drivers/gpu/drm/radeon/radeon_uvd.c
   195          r = radeon_bo_reserve(rdev->uvd.vcpu_bo, false);
                ^^^^^^^^^^^^^^^^^^^^^^
   196          if (r) {
   197                  radeon_bo_unref(&rdev->uvd.vcpu_bo);
   198                  dev_err(rdev->dev, "(%d) failed to reserve UVD bo\n", r);
   199                  return r;
   200          }
   201  
   202          r = radeon_bo_pin(rdev->uvd.vcpu_bo, RADEON_GEM_DOMAIN_VRAM,
   203                            &rdev->uvd.gpu_addr);
   204          if (r) {
   205                  radeon_bo_unreserve(rdev->uvd.vcpu_bo);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   206                  radeon_bo_unref(&rdev->uvd.vcpu_bo);
   207                  dev_err(rdev->dev, "(%d) UVD bo pin failed\n", r);
   208                  return r;
   209          }
   210  
   211          r = radeon_bo_kmap(rdev->uvd.vcpu_bo, &rdev->uvd.cpu_addr);
   212          if (r) {
   213                  dev_err(rdev->dev, "(%d) UVD map failed\n", r);
   214                  return r;
                        ^^^^^^^^
Do we have to unreserve this?

   215          }
   216  
   217          radeon_bo_unreserve(rdev->uvd.vcpu_bo);
   218  
   219          for (i = 0; i < rdev->uvd.max_handles; ++i) {
   220                  atomic_set(&rdev->uvd.handles[i], 0);
   221                  rdev->uvd.filp[i] = NULL;
   222                  rdev->uvd.img_size[i] = 0;
   223          }
   224  
   225          return 0;


regards,
dan carpenter

--===============0315566366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0315566366==--
