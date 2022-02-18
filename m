Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2463EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 17:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8170C10E242;
	Fri, 18 Feb 2022 17:43:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2F4110E3AF
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645205963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xAam+qFCmo3Rl80e7z26slziDVWmWKJYDMPephJD4B8=;
 b=O8tBTxSIQpcIdgkYwaxVf6s0H4YdmLxMn6jMugdH0dPBzgl8Rs7mOCoT9t6gaM9p07P78Q
 Nqyq8uY7tyVnGu7lnAkww1xZ2QnYRRV5iunjGCAoxeUboFm5THTh+Vpfvx9z/dgbyAD1A1
 gaIYo56xlKKc0cWjYSpL6V1EthwzQ0o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-oqjlRKW-Ps6zuHb8gpmL-A-1; Fri, 18 Feb 2022 12:39:19 -0500
X-MC-Unique: oqjlRKW-Ps6zuHb8gpmL-A-1
Received: by mail-qv1-f71.google.com with SMTP id
 gi11-20020a056214248b00b0042c2cc3c1b9so9583065qvb.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 09:39:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xAam+qFCmo3Rl80e7z26slziDVWmWKJYDMPephJD4B8=;
 b=WcVpYL8uQn6FHTel/PF2mjJKl6Xe+9xPmb8/fnjVZViFyhsMxRY0SxJF++EByHFMJ/
 kBSowikP2CCh0Kxle25evdKv8kymqI6oNLtHyrg++/S19qVYHUFkplTl96KeVh3+xv3r
 3oE3YxeuOmrEBFZLzRklfQi/TyO3ZBt/nVuJeBZYT0j5SCjyiE4vKL8N53At7hytqeEI
 kg/RA5NtkfuJd/s7WXA3NGeINE+4SCaFnx2mcpTXqwZsQE+xkqsN9bIwBYlhgDW4+/6b
 nxBWaolSgKO3JlCD5zwNWctZGL4/D8C8nuerxKa+LrCaX2FBllx5L03+p4sw898L09Ih
 /kZw==
X-Gm-Message-State: AOAM5337ivTdyDwoRS7Sp0tkGrSk8r2q3XKsIAA6+HZ2GpdjxHjXMRfX
 kVwbh/Gxt09pgs7jErgaJ1bKmi1D+5g3bAPRnA8v5F0LWdefUVDkKSGH4UolMQCYLDIlO42HBvh
 sUwvgsShjUXOJrHioMlPTsr2pAw==
X-Received: by 2002:a05:6214:6ae:b0:42d:8c32:9697 with SMTP id
 s14-20020a05621406ae00b0042d8c329697mr6639088qvz.128.1645205959332; 
 Fri, 18 Feb 2022 09:39:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHRTUjyiPCyav3YHqFIKehE5vskU34OYALKehiwfJAPYRDA2JG2akysROtDLt0A6lF7XH17w==
X-Received: by 2002:a05:6214:6ae:b0:42d:8c32:9697 with SMTP id
 s14-20020a05621406ae00b0042d8c329697mr6639057qvz.128.1645205959074; 
 Fri, 18 Feb 2022 09:39:19 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com.
 [24.205.208.113])
 by smtp.gmail.com with ESMTPSA id g22sm3425738qkp.63.2022.02.18.09.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Feb 2022 09:39:18 -0800 (PST)
From: trix@redhat.com
To: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
 david.yatsin@amd.com, rajneesh.bhardwaj@amd.com
Subject: [PATCH] drm/amdkfd: rework criu_restore_bos error handling
Date: Fri, 18 Feb 2022 09:39:13 -0800
Message-Id: <20220218173913.3376948-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-Mailman-Approved-At: Fri, 18 Feb 2022 17:43:15 +0000
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
Cc: Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this problem
kfd_chardev.c:2327:2: warning: 1st function call argument
  is an uninitialized value
  kvfree(bo_privs);
  ^~~~~~~~~~~~~~~~

If the copy_from_users(bo_buckets, ...) fails, there is a jump to
the generic error handler at exit:.  The freeing of bo_privs and
unwinding of the dmabuf_fd loop do not need to be done.

Add some specific labels for the early failures.
Reorder the frees to be the reverse of their allocs.

Move the initialize of 'i' back to the loop.
The problem with the early frees predates the loop
unwinding problem.

Fixes: 73fa13b6a511 ("drm/amdkfd: CRIU Implement KFD restore ioctl")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 965af2a08bc0..1d5f41ac3832 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2102,7 +2102,7 @@ static int criu_restore_bos(struct kfd_process *p,
 	const bool criu_resume = true;
 	bool flush_tlbs = false;
 	int ret = 0, j = 0;
-	uint32_t i = 0;
+	uint32_t i;
 
 	if (*priv_offset + (args->num_bos * sizeof(*bo_privs)) > max_priv_data_size)
 		return -EINVAL;
@@ -2119,13 +2119,13 @@ static int criu_restore_bos(struct kfd_process *p,
 	if (ret) {
 		pr_err("Failed to copy BOs information from user\n");
 		ret = -EFAULT;
-		goto exit;
+		goto free_buckets;
 	}
 
 	bo_privs = kvmalloc_array(args->num_bos, sizeof(*bo_privs), GFP_KERNEL);
 	if (!bo_privs) {
 		ret = -ENOMEM;
-		goto exit;
+		goto free_buckets;
 	}
 
 	ret = copy_from_user(bo_privs, (void __user *)args->priv_data + *priv_offset,
@@ -2133,12 +2133,12 @@ static int criu_restore_bos(struct kfd_process *p,
 	if (ret) {
 		pr_err("Failed to copy BOs information from user\n");
 		ret = -EFAULT;
-		goto exit;
+		goto free_privs;
 	}
 	*priv_offset += args->num_bos * sizeof(*bo_privs);
 
 	/* Create and map new BOs */
-	for (; i < args->num_bos; i++) {
+	for (i = 0; i < args->num_bos; i++) {
 		struct kfd_criu_bo_bucket *bo_bucket;
 		struct kfd_criu_bo_priv_data *bo_priv;
 		struct kfd_dev *dev;
@@ -2323,8 +2323,11 @@ static int criu_restore_bos(struct kfd_process *p,
 		if (bo_buckets[i].alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
 			close_fd(bo_buckets[i].dmabuf_fd);
 	}
-	kvfree(bo_buckets);
+free_privs:
 	kvfree(bo_privs);
+free_buckets:
+	kvfree(bo_buckets);
+
 	return ret;
 }
 
-- 
2.26.3

