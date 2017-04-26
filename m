From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/6 v3] *** Dedicated vmid per process v3 ***
Date: Wed, 26 Apr 2017 19:10:33 +0800
Message-ID: <1493205039-3721-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1902091677=="
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

--===============1902091677==
Content-Type: text/plain; charset="all"
Content-Transfer-Encoding: 8bit

*** BLURB HERE ***
The current kernel implementation, which grabs the idle VMID from pool when emitting the job may:

    The back-to-back submission from one process could use different VMID.
    The submission to different queues from single process could use different VMID

It works well in most case but cannot work for the SQ thread trace capture.

The VMID for the submission that set the {SQTT}_BASE, which refers to the address of the trace buffer, is stored in shader engine.

If the profiling application have to use different VMIDs to submit IBs in its life cycle:

    Some trace is not captured since it actually uses different VMID to submit jobs.
    Some part of captured trace may come from different application since they are accidentally uses the owner’s VMID to submit jobs.

V2:
1. address Christian's comments:
	a. drop context flags for tag process, instead, add vm ioctl.
	b. change order of patches.
	c. sync waiting only when vm flush needs.

2. address Alex's comments;
	bump module version

V3:
  address Jerry and Christian's comments.
  and only reserve gfxhub vmid


Chunming Zhou (6):
  drm/amdgpu: add vm ioctl
  drm/amdgpu: add dedicated vmid field in vm struct
  drm/amdgpu: reserve/unreserve vmid by vm ioctl v3
  drm/amdgpu: add limitation for dedicated vm number v3
  drm/amdgpu: implement grab dedicated vmid V2
  drm/amdgpu: bump module verion for reserved vmid

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 148 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   6 ++
 include/uapi/drm/amdgpu_drm.h           |  22 +++++
 5 files changed, 178 insertions(+), 2 deletions(-)

-- 
1.9.1


--===============1902091677==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1902091677==--
