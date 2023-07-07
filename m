Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDA4EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 06:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD3DD10E510;
	Fri,  7 Jul 2023 06:32:48 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C6B410E510
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 06:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688711561; x=1689316361; i=friedrich.vock@gmx.de;
 bh=WygZv8BKwDBEyLLrZ5hAVPeFQ8LPglydAq/ZxVrM2bY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=an0wF4NbyBPqDa8sE5xHjEKcEN1fAC/BSXQhCp5lctmaOuDsxgCVDndCtSVMZZ/vfZC6pgd
 gryPuBJnz/1UpOEdzdjm/My4MiR+U8XVTbAXp5fo7eMwi4irWDCVxxJIwBBgDECnu15SLLFLp
 gT7DIxNvUuvHtGJfDUhVeIuuq0V/xzkrploEjxQqnhtl8/Lwnt837eO7UaKZg4ux0jreGbDMW
 t2bswcm50/PnIJKRJvH5F1im1nZMnnVdSH7VckWuzQbtsJM1fR7SOnJ4o3TNLG2GaUv0vonis
 TwjuFaE1ykqpsil2rFuSKbjWx0Olyj9b3rlo0SE11jsW9eOiYT2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from arch.fritz.box ([213.152.119.29]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8QS8-1qM2jx0Nua-004TvL; Fri, 07
 Jul 2023 08:32:41 +0200
From: Friedrich Vock <friedrich.vock@gmx.de>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Always emit GDS switch when GDS/GWS/OA is used
Date: Fri,  7 Jul 2023 08:28:50 +0200
Message-ID: <20230707062908.9470-2-friedrich.vock@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Iy883m4wEtcqRisx5zmY1s/iLjoqC+8vDCIEK9Pwa+IsILflDXp
 otrp1gUM+Ax1aRDnhP2hny1IirE3lb+5Zd/m/IVQTsogc73Cz9Md5uouIOlmgwGWATIulmK
 hV/uJgvm4hhGTgsrXr+cVY/GoODWvQFCV2KsGVnqoIl2YPN1j0osZFdUoQKDJuwI/vLozfD
 o3Cq/7etAwLaesBPROuIg==
UI-OutboundReport: notjunk:1;M01:P0:oZaunybAQu8=;pWdVqrvIl7k9WgVrCpC2JMXpzD6
 45zUFPvioFWlbyt7DSZ2vn7uwLqg4Ennjwb3J+OevPOncRSQd0nY1X6vcewUeCC3szoPCCHnv
 EaTlbKw2vCTOs3vlAEJ6jIYnfo5XJcYdhVpuai/sb2SF1ZCCAVxnWL9njsmjAq9Bgvq3kcg7u
 8MEhRhcia6nsCKbG8AOTuO5fkMngluOAnHmYe44duVEGkLrspBJazdcg88/e49enMQX9OKzCn
 cz1ElukjsYHxiOFTMuPELYiHc9uD+Ws+StiJYO7IpKciQYfWLmZV+hukQ0OrOT6YvdcUeW2WT
 J+QWwfw8nuVXQxKKcLCZlEL/IByslHUJkWbrjYfug3scl8Hm1xJ6Tf07VoeltgThXYR1xZOYC
 nEDonwb+bKVHNaJlyT3k5zum8G9YWU9NXcIW+F0Q1vewut4MIF1Iyp0Pyy3E489A6o6OkrwY4
 pH6xTQ8GpgKS5JZSbAs1/vV2fIqbMmVsNJnYBAKqJYx9g7KCllY/sGFTw4RnuuHvWXw9fLPUH
 +9wpQmL5HNnkSj0Ht4BfxM+Zsdc/3wAevqLVC4+yoSjm/QJYaBgSjRJu3przaAQF3wrubMVZ2
 gW2Da+aXKXyiZYM+oNksTQeDsVBjJMICSuxYgUxIBO4yjuWDD2Z2oiLj+zQDlEdptq/Knk3cA
 vOubZ5jXUe7faZmMNMHFcVNPAcik25Eu9gt00ToBDSNeSL5diYAJXxmDF0khTK+CMgz72fovF
 mDCijyPq5Tl67qH4FgjWXi+Q6bFaC7zgLQanPKbEOXtX7SQpk7yVMJHsPWAhxWQmEhWDIyTR7
 SZHRgDKqQXeuYwEEjP6KRIjc/ry4abvwlSYcIns6Q1Nx5DyF8laLolq8K5UN3LGt4rObUbafN
 yalwh//ciayeDrBRhxS7WoDzdwWu/2wzvn+yEV3JVBwDMSjDn+2dY88urCHa47ioVg2PTbWOv
 ip1rhVBcqBw0ifoGiABMVMBQi9k=
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
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During gfxoff, the per-VMID GDS registers are reset and not restored
afterwards. The kernel needs to emit a GDS switch to manually update the
GWS registers in this case. Since gfxoff can happen between any two
submissions and the kernel has no way of knowing, emit the GDS switch
before every submission.

Fixes: 56b0989e29 ("drm/amdgpu: fix GDS/GWS/OA switch handling")
Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2530
Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 22 +++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 10 ++++++++--
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ids.c
index ff1ea99292fb..de73797e9279 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -165,24 +165,17 @@ bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device =
*adev,
 		atomic_read(&adev->gpu_reset_counter);
 }

-/* Check if we need to switch to another set of resources */
-static bool amdgpu_vmid_gds_switch_needed(struct amdgpu_vmid *id,
-					  struct amdgpu_job *job)
-{
-	return id->gds_base !=3D job->gds_base ||
-		id->gds_size !=3D job->gds_size ||
-		id->gws_base !=3D job->gws_base ||
-		id->gws_size !=3D job->gws_size ||
-		id->oa_base !=3D job->oa_base ||
-		id->oa_size !=3D job->oa_size;
-}
-
 /* Check if the id is compatible with the job */
 static bool amdgpu_vmid_compatible(struct amdgpu_vmid *id,
 				   struct amdgpu_job *job)
 {
 	return  id->pd_gpu_addr =3D=3D job->vm_pd_addr &&
-		!amdgpu_vmid_gds_switch_needed(id, job);
+		id->gds_base =3D=3D job->gds_base &&
+		id->gds_size =3D=3D job->gds_size &&
+		id->gws_base =3D=3D job->gws_base &&
+		id->gws_size =3D=3D job->gws_size &&
+		id->oa_base =3D=3D job->oa_base &&
+		id->oa_size =3D=3D job->oa_size;
 }

 /**
@@ -434,7 +427,6 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdg=
pu_ring *ring,
 		list_move_tail(&id->list, &id_mgr->ids_lru);
 	}

-	job->gds_switch_needed =3D amdgpu_vmid_gds_switch_needed(id, job);
 	if (job->vm_needs_flush) {
 		id->flushed_updates =3D amdgpu_vm_tlb_seq(vm);
 		dma_fence_put(id->last_flush);
@@ -503,7 +495,7 @@ void amdgpu_vmid_free_reserved(struct amdgpu_device *a=
dev,
  * @vmhub: vmhub type
  * @vmid: vmid number to use
  *
- * Reset saved GDW, GWS and OA to force switch on next flush.
+ * Reset saved GDS, GWS and OA data.
  */
 void amdgpu_vmid_reset(struct amdgpu_device *adev, unsigned vmhub,
 		       unsigned vmid)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_job.h
index a963a25ddd62..2898508b1ce4 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -53,7 +53,6 @@ struct amdgpu_job {
 	uint32_t		preamble_status;
 	uint32_t                preemption_status;
 	bool                    vm_needs_flush;
-	bool			gds_switch_needed;
 	bool			spm_update_needed;
 	uint64_t		vm_pd_addr;
 	unsigned		vmid;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vm.c
index 291977b93b1d..61856040cae2 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -557,6 +557,12 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_device=
 *adev)
 	}
 }

+/* Check if the job needs a GDS switch */
+static bool amdgpu_vm_need_gds_switch(struct amdgpu_job *job)
+{
+	return job->gds_size || job->gws_size || job->oa_size;
+}
+
 /**
  * amdgpu_vm_need_pipeline_sync - Check if pipe sync is needed for job.
  *
@@ -579,7 +585,7 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *=
ring,
 	if (job->vm_needs_flush || ring->has_compute_vm_bug)
 		return true;

-	if (ring->funcs->emit_gds_switch && job->gds_switch_needed)
+	if (ring->funcs->emit_gds_switch && amdgpu_vm_need_gds_switch(job))
 		return true;

 	if (amdgpu_vmid_had_gpu_reset(adev, &id_mgr->ids[job->vmid]))
@@ -609,7 +615,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct a=
mdgpu_job *job,
 	struct amdgpu_vmid *id =3D &id_mgr->ids[job->vmid];
 	bool spm_update_needed =3D job->spm_update_needed;
 	bool gds_switch_needed =3D ring->funcs->emit_gds_switch &&
-		job->gds_switch_needed;
+		amdgpu_vm_need_gds_switch(job);
 	bool vm_flush_needed =3D job->vm_needs_flush;
 	struct dma_fence *fence =3D NULL;
 	bool pasid_mapping_needed =3D false;
=2D-
2.41.0

