Return-Path: <SRS0=ij9B=3O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876D5C35243
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Jan 2020 15:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6888520704
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Jan 2020 15:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6888520704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sk2.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EAB06E88D;
	Sat, 25 Jan 2020 15:50:03 +0000 (UTC)
X-Greylist: delayed 2350 seconds by postgrey-1.36 at gabe;
 Sat, 25 Jan 2020 12:26:24 UTC
Received: from 7.mo2.mail-out.ovh.net (7.mo2.mail-out.ovh.net [188.165.48.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 419E26E81E
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Jan 2020 12:26:24 +0000 (UTC)
Received: from player159.ha.ovh.net (unknown [10.110.171.54])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 3CAED1B833A
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Jan 2020 12:47:12 +0100 (CET)
Received: from sk2.org (nat-fit.net.vutbr.cz [147.229.117.36])
 (Authenticated sender: steve@sk2.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id F2C3EE9AA732;
 Sat, 25 Jan 2020 11:46:57 +0000 (UTC)
From: Stephen Kitt <steve@sk2.org>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH] amdgpu: use dma-resv API instead of manual kmalloc
Date: Sat, 25 Jan 2020 12:46:24 +0100
Message-Id: <20200125114624.2093235-1-steve@sk2.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Ovh-Tracer-Id: 3080180672509660668
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrvdejgdeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpddugeejrddvvdelrdduudejrdefieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduheelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopegrmhguqdhgfhigsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhg
X-Mailman-Approved-At: Sat, 25 Jan 2020 15:50:02 +0000
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
Cc: linux-media@vger.kernel.org, Stephen Kitt <steve@sk2.org>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of hand-coding the dma_resv_list allocation, use
dma_resv_list_alloc, which masks the shared_max handling. While we're
at it, since we only need shared_count fences, allocate shared_count
fences rather than shared_max.

(This is the only place in the kernel, outside of dma-resv.c, which
touches shared_max. This suggests we'd probably be better off without
it!)

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 888209eb8cec..aec595752200 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -234,12 +234,11 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
 	if (!old)
 		return 0;
 
-	new = kmalloc(offsetof(typeof(*new), shared[old->shared_max]),
-		      GFP_KERNEL);
+	new = dma_resv_list_alloc(old->shared_count);
 	if (!new)
 		return -ENOMEM;
 
-	/* Go through all the shared fences in the resevation object and sort
+	/* Go through all the shared fences in the reservation object and sort
 	 * the interesting ones to the end of the list.
 	 */
 	for (i = 0, j = old->shared_count, k = 0; i < old->shared_count; ++i) {
@@ -253,7 +252,6 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
 		else
 			RCU_INIT_POINTER(new->shared[k++], f);
 	}
-	new->shared_max = old->shared_max;
 	new->shared_count = k;
 
 	/* Install the new fence list, seqcount provides the barriers */
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
