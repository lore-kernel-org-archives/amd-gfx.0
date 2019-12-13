Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E0AC43603
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D83B20663
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcmiqqVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D83B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F3A6E2ED;
	Fri, 13 Dec 2019 18:49:05 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F0BF6E2ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 18:49:04 +0000 (UTC)
Received: by mail-qk1-x731.google.com with SMTP id l124so32857qkf.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 10:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sJMfDKBED8WOWv97+NhtVS8rFL70OIbmtMFOpQ0JD5o=;
 b=QcmiqqVbk+TSU6OlK7ZMcq1buC3ZCYwmT27QgoHvr/JSN07l6ls5P5tpzLaoNq3zRG
 zWjrnxgRv3jBRzF+c74SYZt1pa3R7/Hkr/n2jWK0IzikuOvuP9QmyJNNynU9vaqg63FA
 YFt6gESfJLWNIBGXzIGQNmmKS2dLcoQsZDCUBFSJKjqSHHiHUqCEkBtXok3aLVmf00TE
 nzpGyWKlhYEq4uieSKetPkNvV5gZ3PYfn8QmHK5bt/bsHQy0bdp3nCvoGNNG04gz1yMg
 EIPDcSWb2G6pKszDiCJezpwqxURESFPw5jHcbW/kvFWv/ILvWvuwdEurhZt6PX7EDWeN
 6rDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sJMfDKBED8WOWv97+NhtVS8rFL70OIbmtMFOpQ0JD5o=;
 b=GcxFhAteKe3JSyo1NbbXnndIFndUM1kB1XGU/aLdKEd1F65n5IxHRCPOb9KCSKvcc3
 75hcpA1oBCWF5XCtrpKq2vNhTfsOo90971M9BVbcqj1lKJ5TFtsR9QojXtcmoZGMHDNn
 64NtRvDxFAbHk/hLHgsZc3rmRUaPB0LQshCRlz+vrggr6dqsAoqhoS2+skcpQgfcqb1s
 /Q8bhfBZnySkjbftV4lG6cHKl0SlriuF+mLLN44R4YA6We6+RjQ6DPY9D/skEha7yfSc
 /yVOmbtaTDZwQk2kE8JS8vNYPmxCZZ/5uUS1zmQ+4JQakAzOjdXSx8c52uDDzQvxT7kd
 d/Ag==
X-Gm-Message-State: APjAAAWepn/p8xfuK22Ql0oYyJM0j7ljHzTFqTR+uHi1t7AKN0Y8zK1Q
 MYfEnML9bTlZzWKqizV6hnHO1FJc
X-Google-Smtp-Source: APXvYqzxX65l+OFDFGAR2BiiCVubYekoMFB0PhEVJhqeNgQ26V/Sfx/4QmFPRk2iqgCzcK8A6ZZhnQ==
X-Received: by 2002:a37:7cc7:: with SMTP id x190mr14750702qkc.10.1576262943060; 
 Fri, 13 Dec 2019 10:49:03 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id 200sm3098563qkn.79.2019.12.13.10.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2019 10:49:02 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/gfx10: make ring tests less chatty
Date: Fri, 13 Dec 2019 13:48:53 -0500
Message-Id: <20191213184854.3901-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We already did this for older generations.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 39 +++++++-------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8cdef79de9d4..3ede19ce9f1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -472,18 +472,10 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
 		else
 			udelay(1);
 	}
-	if (i < adev->usec_timeout) {
-		if (amdgpu_emu_mode == 1)
-			DRM_INFO("ring test on %d succeeded in %d msecs\n",
-				 ring->idx, i);
-		else
-			DRM_INFO("ring test on %d succeeded in %d usecs\n",
-				 ring->idx, i);
-	} else {
-		DRM_ERROR("amdgpu: ring %d test failed (scratch(0x%04X)=0x%08X)\n",
-			  ring->idx, scratch, tmp);
-		r = -EINVAL;
-	}
+
+	if (i >= adev->usec_timeout)
+		r = -ETIMEDOUT;
+
 	amdgpu_gfx_scratch_free(adev, scratch);
 
 	return r;
@@ -533,14 +525,10 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	}
 
 	tmp = RREG32(scratch);
-	if (tmp == 0xDEADBEEF) {
-		DRM_INFO("ib test on ring %d succeeded\n", ring->idx);
+	if (tmp == 0xDEADBEEF)
 		r = 0;
-	} else {
-		DRM_ERROR("amdgpu: ib test failed (scratch(0x%04X)=0x%08X)\n",
-			  scratch, tmp);
+	else
 		r = -EINVAL;
-	}
 err2:
 	amdgpu_ib_free(adev, &ib, NULL);
 	dma_fence_put(f);
@@ -3607,23 +3595,16 @@ static int gfx_v10_0_cp_resume(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 		ring = &adev->gfx.gfx_ring[i];
-		DRM_INFO("gfx %d ring me %d pipe %d q %d\n",
-			 i, ring->me, ring->pipe, ring->queue);
-		r = amdgpu_ring_test_ring(ring);
-		if (r) {
-			ring->sched.ready = false;
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
 			return r;
-		}
 	}
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		ring = &adev->gfx.compute_ring[i];
-		ring->sched.ready = true;
-		DRM_INFO("compute ring %d mec %d pipe %d q %d\n",
-			 i, ring->me, ring->pipe, ring->queue);
-		r = amdgpu_ring_test_ring(ring);
+		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			ring->sched.ready = false;
+			return r;
 	}
 
 	return 0;
-- 
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
