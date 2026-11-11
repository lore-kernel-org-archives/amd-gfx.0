Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EB3606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=by3uHs/5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5080711210A;
	Thu, 12 Nov 2026 13:56:08 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A181910E35D
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 18:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=cJBbvgW6WNr7izYYiF8ue2aP2x49wmFYcp3dUqc2frs=; t=1794421710; x=2109781710; 
 b=by3uHs/5MekOLM4QrU+zc1bZI0m07if7YSL4fcams1PsJf/RDoFgKdHrugWiDcEIId4vDiAh+hy
 ILrGo0CcbSfWnrSXNWs284bmZnVHi6wx64veG8EIKI/eQs5A1LDru9D0if9XLWtQj+rE+ualG8iem
 gFNbyUdTNMZmE1FOnHp7Q21hbFtJO6L1FkXhfo5JAdon/WnYZ0FFQ4lVcYofQJx8azCacyVLckLoj
 v8/1E1qGXjEtPNae+/XBUeS5EW9tx6o3kBf3VeJH9XsilpAiiBga+T7TXWMlAEDut4/xAF440ZZG9
 b3RPf8oDrpennc4/tnGZIyaP06kNCiQYG5Mw==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xRD3c-008y53-GE; Wed, 11 Nov 2026 19:28:28 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Wed, 11 Nov 2026 15:28:12 -0300
Subject: [PATCH] drm/amdgpu: clear the entire mapping when partially unmapping
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-amdgpu_partial_mappings_fix-v1-1-02c5dfa20889@igalia.com>
X-B4-Tracking: v=1; b=H4sIALyz9GoC/yXM3QrCMAyG4VsZObawFf/mrYiU2GY14mpoNhHG7
 t2o39nzHbwLKFUmhVOzQKUXKz+Lods0EG9YMjlOZvCt33c2h2PKMgfBOjE+wogiXLKGgd8ubo/
 p4Hsadn0LVpBKdv/q58vfOl/vFKdvEtb1A+mQ4X5/AAAA
X-Change-ID: 20261111-amdgpu_partial_mappings_fix-c48d729ef590
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.16-dev-62088
X-Mailman-Approved-At: Thu, 12 Nov 2026 13:56:07 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When we partially clear a BO mapping, we only add the partially unmapped
region to the freed list. That will update the page table to clear that
mapping and leave the other endpoints mapped.

However, we move the endpoints to the invalids list. When later closing
that BO, it will simply free the mapping and not clear the GPU page
tables.

Drop the optimization and clear the entire mapping from the page tables.
As the endpoints are already in the invalids list, when that BO mapping
needs to be accessed, the page tables will be updated.

Though that may clear, then write page table entries and even lead to
new page table allocations in certain situations, those would already
happen in the clear path.

When measuring a given workload, it was noticed an extra allocation in
less than 10% of the cases, but no noticeable extra latency. In any
case, correctness is more important and this fixes the scenario
described.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a99c2ef14be9..808b77083a5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2108,12 +2108,6 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 	list_for_each_entry_safe(tmp, next, &removed, list) {
 		amdgpu_vm_it_remove(tmp, &vm->va);
 		list_del(&tmp->list);
-
-		if (tmp->start < saddr)
-		    tmp->start = saddr;
-		if (tmp->last > eaddr)
-		    tmp->last = eaddr;
-
 		tmp->bo_va = NULL;
 		list_add(&tmp->list, &vm->freed);
 		trace_amdgpu_vm_bo_unmap(NULL, tmp);

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261111-amdgpu_partial_mappings_fix-c48d729ef590

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

