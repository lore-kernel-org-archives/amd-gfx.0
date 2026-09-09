Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D218C79FAD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 09:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0116F10F07C;
	Wed,  9 Sep 2026 09:47:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="wOvH354F";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C994110F087
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 09:47:34 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49557167508so65919585e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Sep 2026 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1788947253; x=1789552053;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4/HIVazkafDF+8hPirTfPnMH9fb4lkFfW6ga7qAMbzE=;
 b=wOvH354FEEBdwurUakpUcy8Mvvy5pKXAzg2kvBz+JSf5LM1Q3oejvBYaPv61Q2PWn6
 GysawwxEtFtItshFHeHa1rfZPm9CwPo2ZS1PqIDx8KbYKHQBTjLUsWe6q1Jj69ihPl1c
 PYPpTWHTx2P+HJ97pyXHGrrw98IsSQ+5XGLukSPLi7wYAsQUvplONUYRd+c0TTjku+go
 YaTqUEKe9uzNzhDRXLLnLUcPGb3kXhedDnhCjwOdwExzsvL5ebhw/CXKBNsrV5H/37Lh
 XhUb3sNH0ZTNb2Dbl+9cOyYA+GSaeNN8pXbfyfzz1YfevjbRH0omT9j9fm4vMhQ22kLN
 GCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788947253; x=1789552053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4/HIVazkafDF+8hPirTfPnMH9fb4lkFfW6ga7qAMbzE=;
 b=Pxe+yKJAxDxG5TGJYTiwmqETPHqS28chDFeE6279DoOtdzwLanMHBQXQ33o/0ZYECp
 k24IrIhCRAP9BBqEg0lIN0fSzqeU5s6HMwSxqT3pT2WN4D7wMg4uPQGVtR9Hxvvnd2aE
 hZOl2Xnh/lLYl/g+MQabEmUqsqS/ZU05dI2XoOQyxM3K/0AzuegVmYUwIh/cxpewC6Ul
 W422CgSXNNHi29zwaQevmix9rJurm6X/PYcljyDhCQ/r3+dW9oBZ3HZgSsVmhUxR6wou
 TXyqH227bBOrCaqGn7DtObbU6hmGr8nuUuoVoC3OCD+u5Ps46M61s+rUYOt5ka3w9tvD
 ZXqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAcF1EYVMeC7dnW+Qupnd39GRqlb5tutWH8GaBT+RlpiQZCphMRxR4aEwQ48vXk0qKL/e8ec5y@lists.freedesktop.org
X-Gm-Message-State: AFuF++kfrPjS8oWE9xrfyQwHG2lpdf8YbA92Ma+cxHLkL8crd/QHF2NT
 NjGglNZsvOUHinzYQqmGNyf6Xi7Nhjydg6tqg0VpHpbAkhbw6sfVbW/NmRd8MYa/PPQma28/B92
 H7dP1imDm
X-Gm-Gg: AYBFou0nVcIb1u7TBa6TVdDjlcosp9C+VzffODdn/i2rfwTndncCuj84FvbPYwHZSYY
 mjTgp+Ib1cV74CrhEZ1ZEPK3jZgTuwjKIMgoAXBh3177zHES+ixiEe0HhaQF6y6D9u5xVZFwTKj
 hY9+HB7oYL3qSRTtMmykrzPM/rFEVwuLjDn3Jfakh/1tDwnaW3tbGsHy+5kPHfU4V3Z+MJFdcD8
 PKhucGj5dcMxf9PWHBqnhp/dowAN5E4LJ1MdD5tRDIohAdm2Mk4SNPCg0TFreHzan3F8FNqLCxy
 G7/6QKucL6rstCweEX2y3eb0x9aIjxiLd90khWCTBekiJIKUrz9AZ358Qp7/cPNKW77g4huNb3K
 zCVvh57ac60JCMVT93WwW2TCeXd6ZiD3VkMdk1NrPFTFfRAShR8T6kWtMWz1v71kJzAtEqltj98
 XESZdLY/xhZhV++hryTL2mStcYQXBqteUPbd1BRbMSSBUvt6o5Pt9IIZEbTPOePb0mCZNyTpV0R
 L8TCx58CwZMFv/4k4lyKDfsb2A=
X-Received: by 2002:a05:600c:4514:b0:49d:1e09:694a with SMTP id
 5b1f17b1804b1-49d1e096970mr124975675e9.11.1788947252972; 
 Wed, 09 Sep 2026 02:47:32 -0700 (PDT)
Received: from quark ([2a01:4b00:d309:1c00:7807:3ba6:3446:4db2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d476esm597615395e9.1.2026.09.09.02.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 02:47:32 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: dakr@kernel.org, aliceryhl@google.com, alexander.deucher@amd.com,
 mukul.joshi@amd.com, rust-for-linux@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Mike Lothian <mike@fireburn.co.uk>
Subject: [PATCH] rust: drm: gem: add missing handle_free to the object vtables
Date: Wed,  9 Sep 2026 10:47:29 +0100
Message-ID: <20260909094729.1593-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
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

Both OBJECT_FUNCS and the shmem VTABLE initialise every member of
drm_gem_object_funcs explicitly, so adding a field to the C struct
breaks the Rust build:

  error[E0063]: missing field `handle_free` in initializer of
  `drm_gem_object_funcs`

The callback is optional and the Rust abstraction has no equivalent
DriverObject method, so leave it unset.

The shmem copy is only built with CONFIG_RUST_DRM_GEM_SHMEM_HELPER,
which DRM_TYR selects.

Fixes: b67d2d039f64 ("drm/gem: Add callback for when handle count goes to 0")
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:Opus-5 [Claude Code]
---

b67d2d039f64 is only in agd5f/drm-next, so this can be squashed into it
instead if you would rather keep that branch bisectable.

The shmem hunk is by inspection - CONFIG_RUST_DRM_GEM_SHMEM_HELPER is
not set in my config, so only the mod.rs copy is compile-tested.

 rust/kernel/drm/gem/mod.rs   | 1 +
 rust/kernel/drm/gem/shmem.rs | 1 +
 2 files changed, 2 insertions(+)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 80d8f524f9d5..ae61ca7e1246 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -278,6 +278,7 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, Ctx> {
         vm_ops: core::ptr::null_mut(),
         evict: None,
         rss: None,
+        handle_free: None,
     };
 
     /// Returns the `Device` that owns this GEM object.
diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index a687d46d170d..d08a03cb7a13 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -145,6 +145,7 @@ impl<T: DriverObject> Object<T> {
         // SAFETY: `drm_gem_shmem_vm_ops` is a valid, static const on the C side.
         vm_ops: unsafe { &raw const bindings::drm_gem_shmem_vm_ops },
         evict: None,
+        handle_free: None,
     };
 
     /// Return a raw pointer to the embedded drm_gem_shmem_object.
-- 
2.55.0

