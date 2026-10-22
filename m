Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFB8606A31D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 00:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.a=rsa-sha256 header.s=google header.b=HweTWkYB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A484F10E089;
	Thu, 22 Oct 2026 00:31:16 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8423610E010
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 00:31:10 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so1196132f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 17:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1792629069; x=1793233869;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nNxW08xxyzNHy8tka2AMI3vdAzOd6AMSCHZa8DamGKM=;
 b=HweTWkYBtC6UPv1mnhOBu0iveF1JVM+HPqyc/6YcCxPw1fwY3rz9GmtZc/ORirXgik
 E41ZupFvVcqo6dpeOqoCHiZLp9ZNOkJjpTHgu+e24u2d3rgYvUtzzqgAIS/YU+3KW8yF
 5wP4y2poUYmGMu34HXdKfh6eDgn/f6rKdmwf5DGQR7e7W2RfEoUOMdxtQpAilVWjf2aa
 J5IJwB7vVTLKlSnf6O52HoXckvZM8m+64RvdTq4VSCWYiP9Fz3IDvWjonoqPrN8H2n26
 LrGVeohqORpoVva7rQePkDV/1tVFzS/c4t2T5NYPaNyJ/DErICVx7Qj3qo99Sy7iYEfG
 YWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792629069; x=1793233869;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nNxW08xxyzNHy8tka2AMI3vdAzOd6AMSCHZa8DamGKM=;
 b=go8hTC0rs/H7GQoK+8eRraP5o7V9wtgHlQO0dndgFwtLGh77T3KAGMnp+nsFTOzikk
 +Eb3fiw7T0vjtXUH7eog42NwY6u6DQTC23aZVmgx9WAXaQvNxX4qSl2TdjeDqTvom8Xv
 8h7MoRg+KMG4c9cIynmLGK7bCsO/ufYjJRLLAQhtn4vUSxppODPLz26ER/1R07Jo9yG4
 cxtIsNZfPsAAAatZXcfikTHeHElIcZ1G7AMLnUFltAqlaWbTYhyWOiuxM9J/bBLb60HV
 MW6tp6vMQOS+r/Ye5nEwxyfynkCIHkicoCfwBXpIEeF2D4US2NOoKsI24X1QneEDhduV
 h/ZA==
X-Gm-Message-State: AFq9FYLGJSE6oce1G9Ey1/Jf3RYQPMvJz2UqdVifhINYIZG2uxPfDs4c
 AfuiTnXjJ8fpysf67vCg38XUhpPnebsvgDfS/i7zedwOTd+lC50ncjXNsYV1rR7/fbzJzpVVJWe
 gUgEHWZM=
X-Gm-Gg: AYBFou2i72sBP8xB4l8Hu52F7Lox6L26vJMeeAt6CLR0fH4DsIgA7BYaaaWcKVc28NO
 DzfR9CVWr7W4BxHjcBOOfn/xuoCvrNewaS1V6ghCm3KgS5t4sziv6I5VSZMdaqcSyQy+ZJF9S6s
 k7JnT8ybs/5eEAqqcg2hZGGAkKUNELcOJ9hiKsoCHBRFaUGwlV829U7CpCIMTMlkamFUY/h5vS3
 swjp9lMAf7rVSizQQmKih1RT4gDFiO1R6vHRO8gx1uSIhM6ZqE3f5oIPa2DsxjfasPnlBMpxvAg
 /V2+VUPvyF8JG0DKVOsfzIsz0wFe2YF4pj0o2ZavSkj5SS6mK1VDnRnxn9+OLo4Rwyq8++FfFhD
 oG7xJjfqeDeUr/5aVBwZmUqhnBnjwjGTBE1IwVf0lVOtJGh854GVIUninYGq1GGOBG5Rp7KXyNO
 0CkewcZj+/l4sUDkjXcuZVxsFdw+KUPSPy7ICaWvQh0gYNvGSGFlrL5cmCFSynyYXW2RBJLret7
 iF7b+YPy85bJ0wW3nJk5rr1qP+Z5DW4SOccSeFQafmCZKHBXvC4QfJMj1iVVwR2v0hRp/EDYTg4
 tsVzzShM18JVTzkhzT6blTP6VseUN7s2tLX4O2F6HH6v
X-Received: by 2002:a05:6000:4808:b0:487:f37:7ec4 with SMTP id
 ffacd0b85a97d-48e264b38b8mr7312678f8f.24.1792629068335; 
 Wed, 21 Oct 2026 17:31:08 -0700 (PDT)
Received: from bas-workstation ([143.58.146.30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2584c374sm7954532f8f.58.2026.10.21.17.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 17:31:07 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, samuel.pitoiset@gmail.com, natalie.vock@gmx.de,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH 0/5] Add submission flag to disable implicit sync.
Date: Thu, 22 Oct 2026 01:30:53 +0100
Message-ID: <20261022003058.1723817-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Submitted this patch series like 2 years ago but folks were busy and
I forgot. This is pretty much just a rebase.

The key is basically that we still have problems with implicit sync in
compositors:

1. In RADV we want a global BO list, meaning that potentially all BOs
   given to a compositor might be "attached" to a submission.
2. Apps work on these BOs and then insert a WRITE fence for submission.

And in a swapchain where we have multiple BOs that might mean
accidentally synchronizing on BOs that are not currently being presented,
but being rendered to.

This resolves that by having a submission flag for a submission to not
participate in implicit sync at all, and leaving it to userspace to
insert/extract implicit fences. Of course we still use BOOKKEEP fences
so the usage is protected against e.g. moves.

libdrm code incl a test:
https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/tree/explicit-sync3?ref_type=heads

mesa code:
https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/tree/basic-explicit-sync3?ref_type=heads


Bas Nieuwenhuizen (5):
  drm/amdgpu: Check cs flags.
  drm/amdgpu: Add usage argument to amdgpu_sync_resv.
  drm/amdgpu: Add UAPI for disabling implicit sync per submission.
  drm/amdgpu: Implement disabling implicit sync per submission.
  drm/amdgpu: Bump the driver version for the new flag.

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        | 33 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c      |  9 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h      |  5 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  8 +++--
 include/uapi/drm/amdgpu_drm.h                 |  3 ++
 9 files changed, 52 insertions(+), 14 deletions(-)

-- 
2.56.0

