Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98912C3DA70
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Jul 2024 15:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BE4B10E1E5;
	Sun, 28 Jul 2024 15:43:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SYcPsECY";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85CA110E1E0;
 Sun, 28 Jul 2024 15:43:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E882A61215;
 Sun, 28 Jul 2024 15:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12446C4AF0A;
 Sun, 28 Jul 2024 15:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722181383;
 bh=W/KIzT/8ojxaMk4N7CQev7o4V8WAU8jUDQvqftuntXs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SYcPsECYwn3bmtLpjj54REe7GVOTbN51LXg2EWVD8bZ7iKmM+WWZ26sTIaFNocD+e
 yqiMIJJ0dKH4Jial7Ga6srdajqziwl4Lo9VBwLUlQo33oK6guCciXEny0ZXVdiZVA9
 a/aIKm2/esRfu6Z0uGoPSMmVGrHlimmPFu24lrtXWcqJUMQxleJBzwydoL1BTOY2UH
 aqvv7T8Lin2THl2E8nVq0nyFnRosfN9jRMEf0VR++iAJhFu0kQK5Z0apxylk0vNzPS
 G8VVxpDhIFYIsiHxSlb13n0VganwoCCllDZNuGBcEuMCyqtmM+GiatkvhhXdRfRtAB
 I0gFdVze6AZnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 Felix.Kuehling@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 06/34] drm/amd/amdkfd: Fix a resource leak in
 svm_range_validate_and_map()
Date: Sun, 28 Jul 2024 11:40:30 -0400
Message-ID: <20240728154230.2046786-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154230.2046786-1-sashal@kernel.org>
References: <20240728154230.2046786-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>

[ Upstream commit d2d3a44008fea01ec7d5a9d9ca527286be2e0257 ]

Analysis of code by Coverity, a static code analyser, has identified
a resource leak in the symbol hmm_range. This leak occurs when one of
the prior steps before it is released encounters an error.

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 31e500859ab01..92485251247a0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1658,7 +1658,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	start = map_start << PAGE_SHIFT;
 	end = (map_last + 1) << PAGE_SHIFT;
 	for (addr = start; !r && addr < end; ) {
-		struct hmm_range *hmm_range;
+		struct hmm_range *hmm_range = NULL;
 		unsigned long map_start_vma;
 		unsigned long map_last_vma;
 		struct vm_area_struct *vma;
@@ -1696,7 +1696,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		svm_range_lock(prange);
-		if (!r && amdgpu_hmm_range_get_pages_done(hmm_range)) {
+
+		/* Free backing memory of hmm_range if it was initialized
+		 * Overrride return value to TRY AGAIN only if prior returns
+		 * were successful
+		 */
+		if (hmm_range && amdgpu_hmm_range_get_pages_done(hmm_range) && !r) {
 			pr_debug("hmm update the range, need validate again\n");
 			r = -EAGAIN;
 		}
-- 
2.43.0

