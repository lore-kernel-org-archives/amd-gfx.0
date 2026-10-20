Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723CC606A31B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=YBvI7baE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18E8F10E567;
	Tue, 20 Oct 2026 13:27:50 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D5510EBF6
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=4yg2PHbKz/l4fOAlokqTj8cfe5TK1aZvmW3rOy6L9cs=; b=YBvI7baEFb52JRaaZEwYmY+HEn
 o/ggElskiXN12syz3TxEjnaYChQviYiEMHaMckfFyIlgKYJnKfBYwXCbYubjJ8RkOzYZ21huYGV9O
 vJ4uxhald/j8DtwZZ0ulGarMY45vWK4+mAw8DJJYBSocehl9E0n0217x9HQ7oHmLp6+Xe9PZ6Ad1X
 ZHuZ2CcLbg6K9KZj/2MhcjDbHiXhxSwtV71dgEkkOlkCPtKMZkN1Z/0mNGHtMRsg/pchkYNgGVCfi
 F8kAzaA+ewE/7nalk6P0+BjDBrkz08kPkWW4CvnKnJivwhjSjtEQYORe0SgrJiCBMHyY3kB/Zdsi6
 DYIyCQTA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJ9sT-004c6F-Lj; Tue, 20 Oct 2026 15:27:41 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/3] Misc amdgpu cleanups
Date: Tue, 20 Oct 2026 14:27:36 +0100
Message-ID: <20261020132739.31852-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A few tiny cleanups I found while working on something else. No functional
changes were intended.

Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>

Tvrtko Ursulin (3):
  drm/amdgpu: Size the buffer_funcs array by maximum number of SDMA
    instances
  drm/amdgpu: Size the vm_pte_scheds array by maximum number of SDMA
    instances
  drm/amdgpu: Simplify amdgpu_ring_init

 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 12 +++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |  2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

-- 
2.56.0

