Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D587606A31C
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Nov 2026 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rsb/fwgv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9195610E5E4;
	Sun,  8 Nov 2026 15:02:43 +0000 (UTC)
Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 654A010E444
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Nov 2026 09:33:47 +0000 (UTC)
Received: by mail-pj2-f9.google.com with SMTP id
 d9443c01a7336-2e97ddaf3c4so1932235ad.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 08 Nov 2026 01:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794130427; x=1794735227; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=L1j8Lq8aH3eQS1NmaOYlRxmMWR7OBcOWfEbp3qYjkPs=;
 b=Rsb/fwgv3bvt1i6bvF5bJo2sDueN38+HYOEx+YeQXrs3i6iXjQrJpijVcPtMWdJvt8
 qHU/CFgRDLpnhfhtH9lhx66LMvophAbIlG2dUBcz6lKXUUJnL2WJm2Fp/D0JSNhnvGMc
 o11/tsZcJWrtGaCEn7f3gGk3rIf5u9spKLdUhD1pJeTEeusG66AwiugQdvelcLUvAT46
 7VjxehOLD41JSme3QW74bW9+Le3ykt306Po8U4HZYu6q2mRGx4QG0JLiQx+S98bvvcVc
 X3KC95GTU4AB9+II4Xp10O6URObh1gMYu1mNdVXQmdvLlRkQ5RdLxanES0wexz3zqgcD
 1LmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794130427; x=1794735227;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=L1j8Lq8aH3eQS1NmaOYlRxmMWR7OBcOWfEbp3qYjkPs=;
 b=tErS4edc5ta6+g7CJTi2Ai4yoGLXbf8D10hRdUHy87HRDpM7EpQkEK1qxE0o3NvuRq
 3o7pJD4QpkYYHBMwdvCB8Y4wuLA+sY+bpAPzCLjymohvS4RME3whFhMtT0S6g2iHZeme
 1qWPKwRpV53K0G5uXk1q2TspIJArGT8ipAuCIcZlO6rxnqXl95CxLFqik9DtH+tPVEzS
 xZTCpFzOE9gdEBwzFqfmrxs3aMNcvMKWVq6otRZP7lfFZC2B+onzkxHKxzzTNSXbvNa9
 eqOGf9CimpW9SD4xEgcgeagrnssCVBvKFHM5VFQJlj4jT3U9lkXOuhwieENtrDws3XSZ
 tYUQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFFmwAs/AB6f44iWPCvB/CuYkhPyPPwWtPvjUXWWPsburDPszbk1RRkqV4pXZR1MyWQbjtv/fn0@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+MgqI0nRYqguD/AlfGdYrkPhc2TrMVD4q0hgPKZ8uJiHCga/0g
 SBEng7J8L1GspfZw2a9lLI0TVTwXhZWU59VutRM8mZBgQzvhN28zNnkG
X-Gm-Gg: AYBFou0OCf2odkYJpLDGjnH96Hbq5cjd/70OejG5ee+BPpOottrYeWq4FjOYnM+Nl/o
 6lAI+jvDkrd28E/gTdWy0ico7qS+aOpXrYouWs/ROyJ+BrS+S4S+OBzNdswG/uclu/hOtWoWWV8
 yHeUEvMg1vUEvP0DOExp+Ed3I5gcCDGMqEWwS5aNSR7jrC44cIv6H3XwrbNacG5B5A6MlNaYUB5
 XgZCanW5rIUP0jaiD5xLy72chIAZdgAXAsWcPXJr6kgsZZTOQQpCfgrNyr0eDzp/LRSmqTOGIwf
 hGF74nrtcxYZk/h2EU33Zc+oXHexBBT7xgmU8bg22Bm+rFIobm8RV09ppjkF588UE2bqrxa5ya5
 3i2EMgpVKt2oFcucQIVnmOkIS3065eJXoR0KY/uwPTOjaH0ucnUzJdGyLTwe2/fSV9vNYanW7K8
 DTpLu0vlo3eWRXMzQX5XkL3qQTlQerPOMnNpZDXtAslpNDFV1F2O54eITsra9Nu7i9iEKPteA41
 o/mRgcuQvJtSwXpiWsfSOeD4AR+DHXe6sGCsMzfemtjAcBkslwP1K29WywZNmwmOrMmEc7oJry7
 VT5szLXsYUvrzP4/rI8M/Nld05b9Llbhi0WuMx0Rn5KDQHKvIc9z8OHQ9nTn
X-Received: by 2002:a05:6a21:485:b0:3de:71c4:a228 with SMTP id
 adf61e73a8af0-3eed232050bmr1065043637.15.1794130426673; 
 Sun, 08 Nov 2026 01:33:46 -0800 (PST)
Received: from [192.168.50.20] ([50.7.253.42])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb969314a5sm558346a12.17.2026.11.08.01.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 01:33:46 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Date: Sun, 08 Nov 2026 20:15:39 +1100
Subject: [PATCH] drm/amdkfd: preserve the byte address when removing retry
 faults
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-kfd-fault-filter-address-20261108-v1-1-ef13f9dd24e4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2N3QrCMAxGX0VybWAtMn9eRbxI19RFZyfJNoSxd
 3dV2OX5+DhnBmMVNrjsZlCexKTPK7j9DpqW8p1R4srgK187V53wmSImGrsBk3QDK1KMyma4PQ6
 pOtfJB0+OYPW8lZN8fo3r7c82hgc3QxGXRyBjDEq5actUEja9sMydZEZW7XUrHGFZvmGsM4y4A
 AAA
X-Change-ID: 20261108-kfd-fault-filter-address-20261108-4f096f2b2a1a
To: Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, honghuan@amd.com, honglei1.huang@amd.com, 
 linux-kernel@vger.kernel.org, 
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
 Natalie Vock <nat@pixelcluster.dev>, Philip Yang <Philip.Yang@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, 
 Prike Liang <Prike.Liang@amd.com>, psirt@amd.com, sashiko-bot@kernel.org, 
 sashiko-reviews@lists.linux.dev, Simona Vetter <simona@ffwll.ch>, 
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, 
 Sunil Khatri <sunil.khatri@amd.com>, 
 =?utf-8?q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Sun, 08 Nov 2026 15:02:42 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

svm_range_restore_pages() receives a CPU page number, but passes it
unchanged to amdgpu_gmc_filter_faults_remove() when recovery is deferred
or returns -EAGAIN. The software fault filter uses a byte address and
PASID as its key, so this can leave the fault filtered until the entry
ages out.

Pass the original byte address to svm_range_restore_pages() and derive
the CPU page number locally for range operations. Use the original
address for both filter removals. This also preserves the GPU subpage
offset when CPU pages are larger than the 4 KiB GPU page size.

Fixes: b3dc91f97317 ("drm/amdkfd: enable subsequent retry fault")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-203586@kernel.org
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
No testing on AMD hardware. Any test will be appreciated.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 7 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c41e9c0916b7..86ef849097fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3092,7 +3092,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		drm_exec_fini(&exec);
 
 		if (!svm_range_restore_pages(adev, pasid, vmid,
-					     node_id, addr >> PAGE_SHIFT, ts, write_fault))
+					     node_id, addr, ts, write_fault))
 			return true;
 
 		/* Re-acquire the VM lock, could be that the VM was freed in between. */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 79455e23a030..c85d6bb73629 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3130,8 +3130,9 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
-			uint64_t addr, uint64_t ts, bool write_fault)
+			uint64_t fault_addr, uint64_t ts, bool write_fault)
 {
+	uint64_t addr = fault_addr >> PAGE_SHIFT;
 	unsigned long start, last, size;
 	struct mm_struct *mm = NULL;
 	struct svm_range_list *svms;
@@ -3249,7 +3250,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mutex_lock(&prange->migrate_mutex);
 
 	if (svm_range_skip_recover(prange)) {
-		amdgpu_gmc_filter_faults_remove(node->adev, addr, pasid);
+		amdgpu_gmc_filter_faults_remove(node->adev, fault_addr, pasid);
 		r = 0;
 		goto out_unlock_range;
 	}
@@ -3353,7 +3354,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	if (r == -EAGAIN) {
 		pr_debug("recover vm fault later\n");
-		amdgpu_gmc_filter_faults_remove(node->adev, addr, pasid);
+		amdgpu_gmc_filter_faults_remove(node->adev, fault_addr, pasid);
 		r = 0;
 	}
 	return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index c7d7adae4476..38744e716f74 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -178,7 +178,7 @@ int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			    bool clear);
 void svm_range_vram_node_free(struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
-			    uint32_t vmid, uint32_t node_id, uint64_t addr, uint64_t ts,
+			    uint32_t vmid, uint32_t node_id, uint64_t fault_addr, uint64_t ts,
 			    bool write_fault);
 int svm_range_evict_svm_bo(struct amdgpu_bo *bo);
 
@@ -230,7 +230,7 @@ static inline void svm_range_list_fini(struct kfd_process *p)
 static inline int svm_range_restore_pages(struct amdgpu_device *adev,
 					  unsigned int pasid,
 					  uint32_t client_id, uint32_t node_id,
-					  uint64_t addr, uint64_t ts, bool write_fault)
+					  uint64_t fault_addr, uint64_t ts, bool write_fault)
 {
 	return -EFAULT;
 }

---
base-commit: 403b3d68346d7ba25f474f0686ad1d05feb65b7c
change-id: 20261108-kfd-fault-filter-address-20261108-4f096f2b2a1a

Best regards,
--  
Aveline Noir <jm5905938@gmail.com>

