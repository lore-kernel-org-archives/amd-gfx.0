From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/5] *** Dedicated vmid per process ***
Date: Fri, 21 Apr 2017 18:05:37 +0800
Message-ID: <1492769142-31180-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1210251448=="
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

--===============1210251448==
Content-Type: text/plain; charset="all"
Content-Transfer-Encoding: 8bit

The current kernel implementation, which grabs the idle VMID from pool when emitting the job may:

    The back-to-back submission from one process could use different VMID.
    The submission to different queues from single process could use different VMID

It works well in most case but cannot work for the SQ thread trace capture.

The VMID for the submission that set the {SQTT}_BASE, which refers to the address of the trace buffer, is stored in shader engine.

If the profiling application have to use different VMIDs to submit IBs in its life cycle:

    Some trace is not captured since it actually uses different VMID to submit jobs.
    Some part of captured trace may come from different application since they are accidentally uses the owner’s VMID to submit jobs.


ChunmingrZhour(5):
  drm/amdgpu: handle flags when context alloc
  drm/amdgpu: add dedicated vmid field in vm struct
  drm/amdgpu: add context flagn for dedicated vmid reqest
  drm/amdgpu: implement grab dedicated vmid
  drm/amdgpu: add limitation for dedicated vm number

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    |  14 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 137 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |   6 ++
 include/uapi/drm/amdgpu_drm.h              |   3 +
 6 files changed, 158 insertions(+), 4 deletions(-)

-- 
1.9.1


--===============1210251448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1210251448==--
