Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1352CCF9FF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB07C10EB47;
	Fri, 31 Oct 2025 13:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ma5hWRpb";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB6A10EB43
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:44:48 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4770e7062b5so16275095e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 06:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761918287; x=1762523087; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8l4ubcMd7fh1t9v6bYRfKmDgoG7zfmnbjqlGtcnGlQ4=;
 b=ma5hWRpbhOG2HoBos7+ThsqEm6o5UpFORhqJ79ExSuUN2nEw03tzyXf/azIL6Kg3iZ
 RWN5lxcBzH9krdEgLcHS4inNi0648k4sDMisVs6eNQYJcwc0jJScGbLO1obAwADubZXR
 KE6ScmSJdQ3bV7ZzELD0AMkqSgc51LuzulK3w83g/Os1fSyDm30Nj+P/3ORU4VL6mQFg
 6e4SwvIDiL9u9WVv/ojHQ136v+yO+u+nn2QGZbffgCGPF1bGXmYvzBkYy70qQ/IiVABX
 Y41LVEm7hVISHX8sTsHg+Jk3n4KyjgQ1/rbmmplN8MDx48uTEie7BpVxAwpYpGG9cZJi
 IlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761918287; x=1762523087;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8l4ubcMd7fh1t9v6bYRfKmDgoG7zfmnbjqlGtcnGlQ4=;
 b=p1sN6Qwv7tBYrrLcpWciEq8tpxm4HAQWzjqnaJzYmFteTCJKYVgPYzJv8BrzQObamL
 2p49c5Pz6/4YufOjljEg8p/hdNlOz1jadSUXmmAmlQBnyzPHl73gZnevKujeaEnUBo1c
 LxFlNZLwf+BrpAn1sfiUelkPGNYtdpG9EUuchG0ay52f+lD79P0E9+wBQ32X0QeNHOaN
 CchT22Ix7MuDx9NPOT2qpMrr67MGxvrTZJpZWBx/hEblIiMH8vgtxTf+FPTVYsJ0FRSU
 HgAJ3UNwPxMg49LjFmkAqGyYuq/ASx/7LD8JVuLqOzST7GSk73u6MTneH8BagDlUty/E
 IkPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvcM1YCEMVC5AvtFl+cOxVYP8yBy3/eRgcG3YcXNyuNKxgOO3yOHmKCbs3bfzxu1EG7wNZMATC@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzC3X2AiNW0Oc6j1nRrFKNNuVmHr8IcHCjgpEkStti3ZBAZom07
 pP8Sm1FPgpsWzxPcbOfWxJp6v8ZxtF7/EeBIJ4efcGliPUvHG4WgZ7hU
X-Gm-Gg: ASbGncvH7aiX6U7wZTeMdyawVDyFGa1KJvv2Qli6TIPcRtIy2OxjlMboETbhIR6H2lC
 RTWQQWY7IRafazf+3knDx16C8Qi31Agndg/tfsc6nDQbIhYDixWjXx029UJu4wmYLqDUjEcPort
 AmtPJlJ8Pj2akOKsD0X/BnuMfFI70KmuHOjWUt3ZHf477WhhvqP/Ks8hHW6DFtW0UbzVtxVOZAB
 Nw//79XdCeEu3F62Dbx0MGMxpoZBiVn6MvvEFcnYbGicwgwMf23dxz56qG9WcjhWsYpxkisFT43
 XJkyK+UdQRlKLbv07Gb1QXdqa3ksfJc+SyP5F4B7HnKS/DVkZ/Pz6qLfcZGmzjrYpiHS3LG9yUU
 03B42nA2XBWBwWSwfmZk4lC/TXyN0ysKBBvVjX40KxI9jrHy9TqlmgddQ71SWyiCdGqFJLSvAp0
 QIgFoTFyZXAWW1VA==
X-Google-Smtp-Source: AGHT+IFPyGiMbJajkSi+avrTdCfsEH04+atqUrSKZodvnp1ote0dv/5nDF8K1ptv4L/v5ax2GjW3nw==
X-Received: by 2002:a05:600c:871b:b0:475:dddc:8c08 with SMTP id
 5b1f17b1804b1-47730833ec7mr32394245e9.15.1761918286821; 
 Fri, 31 Oct 2025 06:44:46 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1599:7d00:73cb:d446:bf90:f1c0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732fe119bsm34502635e9.10.2025.10.31.06.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:44:45 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, airlied@gmail.com, felix.kuehling@amd.com,
 matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: Independence for dma_fences! v2
Date: Fri, 31 Oct 2025 14:16:34 +0100
Message-ID: <20251031134442.113648-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

Hi everyone,

dma_fences have ever lived under the tyranny dictated by the module
lifetime of their issuer, leading to crashes should anybody still holding
a reference to a dma_fence when the module of the issuer was unloaded.

The basic problem is that when buffer are shared between drivers
dma_fence objects can leak into external drivers and stay there even
after they are signaled. The dma_resv object for example only lazy releases
dma_fences.

So what happens is that when the module who originally created the dma_fence
unloads the dma_fence_ops function table becomes unavailable as well and so
any attempt to release the fence crashes the system.

Previously various approaches have been discussed, including changing the
locking semantics of the dma_fence callbacks (by me) as well as using the
drm scheduler as intermediate layer (by Sima) to disconnect dma_fences
from their actual users, but none of them are actually solving all problems.

Tvrtko did some really nice prerequisite work by protecting the returned
strings of the dma_fence_ops by RCU. This way dma_fence creators where
able to just wait for an RCU grace period after fence signaling before
they could be save to free those data structures.

Now this patch set here goes a step further and protects the whole
dma_fence_ops structure by RCU, so that after the fence signals the
pointer to the dma_fence_ops is set to NULL when there is no wait nor
release callback given. All functionality which use the dma_fence_ops
reference are put inside an RCU critical section, except for the
deprecated issuer specific wait and of course the optional release
callback.

Additional to the RCU changes the lock protecting the dma_fence state
previously had to be allocated external. This set here now changes the
functionality to make that external lock optional and allows dma_fences
to use an inline lock and be self contained.

This patch set addressed all previous code review comments, is now based
on drm-tip instead of amd-staging-drm-next, includes my changes for amdgpu
as well as Mathew's patches for XE.

Please review and comment,
Christian.

