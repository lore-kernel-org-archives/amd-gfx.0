Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6900F606A32D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fxlee/cS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6A3C112582;
	Fri, 13 Nov 2026 13:44:24 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F29510E5C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 21:14:33 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c49c32650adso35208366b.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 13:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794518071; x=1795122871; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N0YmB8FsSYeAkZgYqa3Gx2IrnA1/WyknVVqtsY0aqDY=;
 b=fxlee/cSBPZCwdoV2fAxE13FXFNb/Cc/8pfrPuw5k3e6imSh8Qn+Ej+3O7+731KS0/
 hLfBkZlZvxPMI/YQcVzOtuVf8EkBQfflaUkKq33DixSDHNaO5Vs3yJqVqnZ/pK+ITvoN
 nc0ushY89VIrQZu+CiwuXwW2bf7M1h6ITW7ySC1Z7mGFMbA8jeEhm9hNtEe5+wkySY5g
 yp2UjDjAL+tgORZ1F1Q/83e1qLX0BmTvETNgqO42uBpxoZW6m6UG1ibBxZvDCvcB4fyx
 +ZuNFulTkwuFZpXBNSyWBL6umoQPe5ew1xKkSuhx5ER1RlBRP49KINvzj1I4Vt1/bCJw
 ynBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794518071; x=1795122871;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N0YmB8FsSYeAkZgYqa3Gx2IrnA1/WyknVVqtsY0aqDY=;
 b=G9cIPM6xAIxoH+gg5UB0OK7GeTlx+a78R5FcJ9oIoy7zHdDLzov7NY0aj11V+07mcN
 LRZvwlH3iFOgDjEOX+gwLe/hEXBMD90W16jTmvi/NXnd6qpbXA2Plp0D0lpiTSgnk9M7
 YkXvG9HFFHPF1UyFi0+EfNocTj42ilFqMAdPJHEntDh1cD6H4bcbo8wfPQjSykQ0qe3q
 xshRmyXbg3AkR2CX4asmY35X8fkI3HP44XLK/1Pf3HnJRQkzf0XQRKOwCdMiBSeaN50+
 6uMQM7tHy9GFF8i/OVltPQsUGfUbHOtZMXTGpSIUN5xHOoS9pk9oBSwggC0+TTjapd9f
 cAJg==
X-Gm-Message-State: APuU4Z9xT5m9vE5gQS1GZg2fjoDFRBHluCBm4KT7aNyVGZ2VRQu0dCuq
 OcE5prwuloA4GD4kTexedeEFLU3KKZKWlz472iYCnzDp+1brjYHSAvHMR6m6H4x0
X-Gm-Gg: AYBFou1MeTVvojVR6Wm7aHrk9ZA1Bb2T34dFCg2VuaQX+ic4HncpzyylF7GEqmkgmyx
 f5MSXzIkuqaegdWmXEvw/Vj1AZKJNFNGmhD7NihJCnk4HOZK5f2PjFYzQLZdpf7P0DCUvFwmqB7
 jnS5httFIjtZ+aHJxm7iIBilSbLNXgVhftqqhtaUrfKHqkJLbb8lrmR8D29LaeRqqKNj162Ty6K
 dyXdy0DNnKzj0Gtf4kNXU/EXe0mIO0HCjQWtu7ep2fzpsozL6D9t8yWFlIbfNTYGiNtrETC/1bP
 Lo10MT/+rLAJd7ZsgJxhvTjn+Va7KOpQCNj/8Xn+2SsPjsYxeEp13NT3A4E0M567IUfzvANuM0z
 3L8BtVlcF9DvstTnvBssLF9abUeIJPWDgk0JddgIpCmSJ6vWu0DuR+F0hMR62upoc6cFz+nxZQ9
 IuiRhzQxAx0OtWzVZ938+atjyDGhe6XAnONm18JL+fUNPgU+L0Ry+szrH9ar8NtDmj/HDIJTWCz
 bUrckT3xhnDUA9qHF0CgqNGYKf6cKXIPzVtdQaQ0xaqI0Qvc2XFyFIemelm7glzjlJxKcvq1hbd
 tFJv/ACfh785cPMgsXK5ujfww2HcAJMS9KMOtjthM9NTQeTFXKOhAbo56oItwi1jZYQOMsOkYXP
 9Txc/etodI7B5AXpO5Hovmy0wYbZ78s2RHLnGhHBR67SIOMAGVW40a+SdGR7eHx0WI9j/3FOutm
 HkvQO+hivofymLBEWQU/QD3QQ6LeCFQvRSrL8qc97uc3b7NCWNrHXrSm5cM2WF0/gSMKitvgA0c
 gL/SRFxzFtGJWLShWAb4cGlvNvf25s+G5KHYPdPqPHBlOK7c3ph0SkP0jrC++WZRz89nZXgRao5
 0U/3Ga5b0KrMGTy/5U4MxOJ1Xm8KuDdXyF3s3kULL6GGAaDJk6c7w3e4AuRa+kpz+Y99ymzHLsh
 IMBu8UtX5VPJRHfL4vF08sg==
X-Received: by 2002:a17:907:1c9e:b0:c50:93b6:52ed with SMTP id
 a640c23a62f3a-c509654e2f8mr41721866b.40.1794518071149; 
 Thu, 12 Nov 2026 13:14:31 -0800 (PST)
Received: from albatros (ip-091-065-217-039.vkd74.pools.vodafone-ip.de.
 [91.65.217.39]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b23708sm17442266b.24.2026.11.12.13.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:14:29 -0800 (PST)
From: Erhan Bilgili <erhan.bilgili@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Arunpravin.PaneerSelvam@amd.com, Erhan Bilgili <erhan.bilgili@gmail.com>
Subject: [PATCH] drm/amdgpu: Fix UserQ fence driver reference race
Date: Thu, 12 Nov 2026 22:12:53 +0100
Message-ID: <20261112211253.82256-1-erhan.bilgili@gmail.com>
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

USERQ_WAIT adds the driver to fence_drv_xa before taking its
reference. Once the lock is dropped, USERQ_SIGNAL can remove the
entry and put the driver before WAIT gets its reference. This can
free the driver while WAIT is still using it.

Take the reference before dropping fence_drv_lock.

Fixes: a292fdecd728 ("drm/amdgpu: Implement userqueue signal/wait IOCTL")
Signed-off-by: Erhan Bilgili <erhan.bilgili@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index dd976a50e053..13a339918ee3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -912,12 +912,12 @@ amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct drm_file *fil
 		mutex_lock(&waitq->fence_drv_lock);
 		r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
 			     xa_limit_32b, GFP_KERNEL);
+		if (!r)
+			amdgpu_userq_fence_driver_get(fence_drv);
 		mutex_unlock(&waitq->fence_drv_lock);
 		if (r)
 			goto put_waitq;
 
-		amdgpu_userq_fence_driver_get(fence_drv);
-
 		trace_amdgpu_userq_wait_deps(dev->dev, waitq, userq_fence);
 
 		/* Store drm syncobj's gpu va address and value */
-- 
2.56.1

