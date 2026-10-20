Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F28C606A319
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=AJHek+xx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0864710E894;
	Tue, 20 Oct 2026 13:27:51 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C3010EBF7
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 13:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=ZUnXn0rsQjFDy86T7a/fX36MYmrUasCB3f509ulhCPE=; b=AJHek+xxNWgmQMkdX0BeFcJQay
 lNa09GYcGrxvqSbNbD6ZZJlwBoUtVPlgxw3lxApxjjEtOqKbXOGM8isiqtTy+pjYORcIH/PGEZA2U
 /c66SzRbLi08rXVXRLE4OhDn7WR6I0WkPxie26F7HATgUezKRvo3WIG8saNTrD+fsY2UHXephtdm7
 381Jt9wPejJIl4/4hNe4j28SjDWq/lWSYBoJNedrZsbpfcwrd2l+DckG6pgfW7zDqdWtdgqdWNisZ
 sJmThv5Bad8Ymb6LtglM0CKxw81XIHVWiIwwaaZ+x/sXnoice8M+mt+pv36UQ6J1uxfjgGwrthi0p
 nxbQCqFw==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJ9sV-004c6O-4d; Tue, 20 Oct 2026 15:27:43 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/3] drm/amdgpu: Size the vm_pte_scheds array by maximum
 number of SDMA instances
Date: Tue, 20 Oct 2026 14:27:38 +0100
Message-ID: <20261020132739.31852-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020132739.31852-1-tvrtko.ursulin@igalia.com>
References: <20261020132739.31852-1-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The array is populated from a loop capped by adev->sdma.num_instances so
it makes sense to size it using AMDGPU_MAX_SDMA_INSTANCES and save some
memory.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index b8aa45db1d84..98c48c45ce61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -395,7 +395,7 @@ struct amdgpu_vm_manager {
 	u64					vram_base_offset;
 	/* vm pte handling */
 	const struct amdgpu_vm_pte_funcs	*vm_pte_funcs;
-	struct drm_gpu_scheduler		*vm_pte_scheds[AMDGPU_MAX_RINGS];
+	struct drm_gpu_scheduler		*vm_pte_scheds[AMDGPU_MAX_SDMA_INSTANCES];
 	unsigned				vm_pte_num_scheds;
 	struct amdgpu_ring			*page_fault;
 
-- 
2.56.0

