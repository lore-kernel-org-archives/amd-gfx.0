Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3EA606A323
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sNrfPReu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAFBC11258B;
	Fri, 13 Nov 2026 13:44:25 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19DF911240A
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 23:39:52 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c40f29667e6so46892866b.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 15:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794526790; x=1795131590; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nQIfwkswx6HF89WCxtEHrFaYfww+N5ri/gLQMPAhHEs=;
 b=sNrfPReuGksFdy/wHH6QS1BBqX6S/JFPwtVm0RRzgWWBozMTwepNPhnuLHiLP2KKCe
 TzrIjpDykuzHQZDxCxjrnrxyOct9VYtQh32bgPCu4O4pjvlmJ39tZPJOAhA/u1lZbjzD
 Wfce15wtZKvuMSrnpHGcnQ+evllUXP2YPSd6Ycd4bKah5v/xHsWBKjXkBjqn2SIJ9ePn
 hGtpHTcAYGujQWsij7nO+jK+Fi7xaQ1MGv1x9yVQvERu2SSboBbGJXFAUwFhYCdAgd1K
 dTufU9EtasNEJJFQDZVWd2YZByFioxx4aC1lqLpUQVRURGvECMM0SWijliybktI9wOSY
 aZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794526790; x=1795131590;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nQIfwkswx6HF89WCxtEHrFaYfww+N5ri/gLQMPAhHEs=;
 b=uZzfQFa7MdJ1JH3/kGF4AWViH/2BibVi0CNDu0wbYD8oPzE0WC1lcRCmCqHqVq3KnO
 V6450k7XFhK9nLLZI8KEiARxb/N9leFuLBCyuk3UVYXoSvDlTof1uSTflFk1DwIxCTmF
 G+ZfyJ/epbh6NUGSidGTejgxsxIXvXE0M9hGXR5eD7Bqn8k90w3SEHOk/+VE0jlOC57a
 rZMx+NGAWqiQEL56klMsUrOqc6gQKlosN2cAnbd9roB+3seSID9ZcFmJUsGY9o0vJb+K
 yHeeaxt7rRgO+3qKEt8IIg6ez3ca2j+yCWYWCcYgFIu1VGeAFLZBEGBgYAgeA72J5n2z
 s3KQ==
X-Gm-Message-State: APuU4Z8bMLhbZ8HmSWkWQVOgfyI+DH5rI4L1LhdaMo9jrltlttRgNEVi
 FEZGe2TbihUeIEThs0Ef/4YAAnuAgCgwah1EANzs+PP7T8e8IKshKyccgHWAiNHQ
X-Gm-Gg: AYBFou1gFzwB7st1okisQ7edTjT/1Dt7+yagge5epoOESwfYXbiwZd/WJF+twzG4LaT
 uRBHwLH0Xf4dU0tALZKHxS1PPQckZjaeBqBj2rcNk1Z5k1AcjavwJPrZGoTsVQjxRvgUeG8VUaz
 V82eNDSBU6rKKKbv3GOyaKHBu/cl4Wr5DM5o5YhwcnHVGmnOfn4JQM6oC96OO/0V8/MXa7a1dR2
 xpdkZBm4+6Tanjj1J4BPm2KweXSC5wbrqe5vxICEVE690dw7Vo3clzlg3kFNCUGcqykCrMmr/gv
 STpXvpNK4otJwrCLOw2hOCSXZz8EFfKJZd+0eSTucbfaiTVQsGWG/LscsbWHkzNPi7RiqXj3BoR
 McQXXPPWRmNnFGKF5Curvgc8Pj5ippydED4AkfumdilZJI7nXjZsF9/5HXhumYQDdt2w9LwiS9R
 V6VytczAUiAoexvodTDe9L9HMYjp4kxzGrMEqTzUa2fkqKbeKCVH7qV0KI3BhAoGpknADW0lQAg
 E1Pw3rkRwiyNZFvygt6oLfJA6Y8CXrgr18bJIlR02sGatuTPm7Xw3T1KghEoQ5iGRZUCZCwr84h
 1xvgUtyRTdOWLLr+JJljhPZVVWqvgKdO4Rt2l1+1dnbByD0MIB5wsct0nrgt8eYnwixEaXX+6DH
 6Rep+nPBjFHnRhmCmJjWmxDTBxqp6pkTsC+aAPypZPPkkQ21igeYlynkb5yiE26U+gZgiqWpdiG
 n3o/Yflo/PeIq3ifKcEO0YvIA2p5CzyEP3j4RxdkcrsUfioFUoCDRRBCqQfcxA5YA5vnKdXQJsf
 ZRN6UKqanc20ZQdDzvdbmXm4RWaRLU069siUhf6WirZbMIGDrFmcYUyNgElqcGLt6W53hTr4oI/
 YBnrFDr/bDed3H6hja4fLkIzaCcB6vPAOAXL56ZQNebeu2VNDOgPvStys/nW8tguoUIlAsqBwfJ
 rhTvGV60IBK325ie8GIk36o4nBjus1MhyDz+D4cRHQQ==
X-Received: by 2002:a17:907:60d3:b0:c31:8441:35ff with SMTP id
 a640c23a62f3a-c50968355eemr63383066b.48.1794526790323; 
 Thu, 12 Nov 2026 15:39:50 -0800 (PST)
Received: from albatros (ip-091-065-217-039.vkd74.pools.vodafone-ip.de.
 [91.65.217.39]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b5ac2asm27449466b.55.2026.11.12.15.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 15:39:48 -0800 (PST)
From: Erhan Bilgili <erhan.bilgili@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Erhan Bilgili <erhan.bilgili@gmail.com>
Subject: [PATCH] drm/amdgpu: Fix UserQ fence iterator cleanup
Date: Fri, 13 Nov 2026 00:37:22 +0100
Message-ID: <20261112233722.172499-1-erhan.bilgili@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Nov 2026 13:44:24 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If a fallback wait is interrupted, USERQ_WAIT leaves the unwrap loop
without releasing the reference taken by dma_fence_unwrap_first().
That reference is normally dropped by dma_fence_chain_walk().

Drop iter.chain before returning the error.

Fixes: 15e30a6e4792 ("drm/amdgpu: Add wait IOCTL timeline syncobj support")
Signed-off-by: Erhan Bilgili <erhan.bilgili@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index dd976a50e053..e7b63c227421 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -796,6 +796,7 @@ amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct drm_file *fil
 			r = amdgpu_userq_wait_add_fence(wait_info, fences,
 							&num_fences, f);
 			if (r) {
+				dma_fence_put(iter.chain);
 				dma_fence_put(fence);
 				goto free_fences;
 			}
-- 
2.56.1

