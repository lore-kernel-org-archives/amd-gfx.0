Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8CAC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 14:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D5D710E401;
	Wed,  9 Feb 2022 14:55:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D10510E50A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 14:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644418384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j/VJVwJcabH5SXTn4ZvXEnmPqcRm07U+dAsv8ELCv4A=;
 b=ZUnUbGvowMVxiMUCtLP03qoHy6wxoZ6IRx0YRR+xyr6NIeQpVmtBtPFpKoTsynWVV0vJTA
 9e9RXqe3CQSeU/mCBx5aeNQfD0A3/Xxmtvu++orFB/63qZSNxQN1w+0FAyzHDXncRyROa/
 X8Z7M31HL3DsQeFNupNW4PNTO0Yp0rw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-w4mvEufLPQuUfbG8xTIpFQ-1; Wed, 09 Feb 2022 09:53:03 -0500
X-MC-Unique: w4mvEufLPQuUfbG8xTIpFQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 j30-20020ac84c9e000000b002cf986622d1so1895225qtv.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Feb 2022 06:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=j/VJVwJcabH5SXTn4ZvXEnmPqcRm07U+dAsv8ELCv4A=;
 b=3FtmihrX/qU36z8n4AvUsVnaRuTs/Zyhm+SQyhEdDlaOtAfKSkpt1lD76p4zCLV4GH
 R34Gv+1FZ4933kw3ErOFpKRRCcCkBu8HRA2+SDNwHaXlhGKD+yT2Ab/CLDGpoiZJDZic
 HvrbupPcxWx8/ovt3pfuQ5E2n3FeTiFlQKohnc2wfF9vbi9DN5e/vzsS1khINlzcfMr/
 05SWba/Jp64HNS7otSLM4NyKyGlYQcR2Cr51SOcx6uXlXG2UM2oTmbJUersXdfhOF1Vs
 fqg0/o5AinjLtjssy7Sbt6ucjflB19GfNQcdBWMrnIPIS9FBD32Zwqc2thqOPGfMmzgi
 dkMg==
X-Gm-Message-State: AOAM531RcJVGmwQnMuUxUgK3nn54jty97DBaCEKKYhNSGeahnK2I4yoA
 S8QPzHuPCJHQ7g04wgchQ6R/nn42KnJw0Xav+HRV8uOp2A4+qRUrdXtEi1kpuAJi//yC6eYJvpq
 2DAO658DPnnBcmRAiS6ue2JQJ7g==
X-Received: by 2002:a05:622a:87:: with SMTP id o7mr1562247qtw.38.1644418382984; 
 Wed, 09 Feb 2022 06:53:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5wcZMgzdbV24kPRKWlIzraNFqysXb9opnZC+c5gQEfuzVCDVwwO+VOEAL5ibZQMRfOE0JJw==
X-Received: by 2002:a05:622a:87:: with SMTP id o7mr1562236qtw.38.1644418382803; 
 Wed, 09 Feb 2022 06:53:02 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com.
 [24.205.208.113])
 by smtp.gmail.com with ESMTPSA id bk19sm8421478qkb.125.2022.02.09.06.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Feb 2022 06:53:02 -0800 (PST)
From: trix@redhat.com
To: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
 david.yatsin@amd.com, rajneesh.bhardwaj@amd.com
Subject: [PATCH] drm/amdkfd: fix freeing an unset pointer
Date: Wed,  9 Feb 2022 06:52:54 -0800
Message-Id: <20220209145254.2291158-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-Mailman-Approved-At: Wed, 09 Feb 2022 14:55:47 +0000
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

clang static analysis reports this problem
kfd_chardev.c:2092:2: warning: 1st function call argument
  is an uninitialized value
        kvfree(bo_privs);
        ^~~~~~~~~~~~~~~~

When bo_buckets alloc fails, it jumps to an error handler
that frees the yet to be allocated bo_privs.  Because
bo_buckets is the first error, return directly.

Fixes: 5ccbb057c0a1 ("drm/amdkfd: CRIU Implement KFD checkpoint ioctl")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 64e3b4e3a7126..636391c61cafb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1982,10 +1982,8 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 	void *mem;
 
 	bo_buckets = kvzalloc(num_bos * sizeof(*bo_buckets), GFP_KERNEL);
-	if (!bo_buckets) {
-		ret = -ENOMEM;
-		goto exit;
-	}
+	if (!bo_buckets)
+		return -ENOMEM;
 
 	bo_privs = kvzalloc(num_bos * sizeof(*bo_privs), GFP_KERNEL);
 	if (!bo_privs) {
-- 
2.26.3

