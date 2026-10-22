Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1212D606A31B
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 00:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.a=rsa-sha256 header.s=google header.b=hE2/EiCR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE26A10E346;
	Thu, 22 Oct 2026 00:31:20 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 708CE10E346
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 00:31:14 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so1988005e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 17:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1792629073; x=1793233873;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CogsRBvotxq/9/9uhsT9B5u2UDEO8FjhLEZbsb5LS1c=;
 b=hE2/EiCRpgpNIgyS1MCYKHkXZtowsMUyLNhlyNTU+dilekG89JJP3UlKYkvu6I2n+E
 y46x1EQp6HANYCT9FeVBRQ7KFhYE8YdKv4xqxQbWcOuleDD6/DzdKsGXu0aQXhBCfgLZ
 JFwzIsI3/wEjYXEDtj0hzmi6CZoPZMEp+sfOWn2WoE/LoMnBaKF/AwRyf2dASa2cHtuo
 o1RtExZg02jUuEmm+BX9xq/MBRm48JCqgBnl1sDmV+RyWuT4Q6kMj9Q5G1gcpRP0uf0o
 M7cl1K+6EgpayzjI2XhNWGvMHxUcGSuI4YUr9UhxpDvahDcVg4Pn7GNszOAZJH83LmA6
 12Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792629073; x=1793233873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CogsRBvotxq/9/9uhsT9B5u2UDEO8FjhLEZbsb5LS1c=;
 b=ffU+v5H81RuyXPzKEhaB1qmLAfWmwoelkhdqQFLViEZGF72HvVJ2wmoAqxmRhBQWm5
 mpgR52Pb9Xj75pobz+R1blrNzFjymQrN15rsi6yMNXfHrL2d1l99NIS2ogVQy9VRe2mG
 8mLmbztVFlDx73TNaAxQLECxwmRVFe6I2BtZG++hsyHUrd4iJCSOp1Sskn3fmimSZiGj
 tyEf4CZKHXmAXwd6/3OkeE9vWsMz5xiV4lKGCLw8igQvBKt7V5nhpiZ5ZceuVHcUL9PS
 OM8JaZuJibjXYDTpnJWiF6SqIb9BFXK5xeegciFzD2GBb/7MZLtJ/2HF+6QC6TKE9Lui
 9nEQ==
X-Gm-Message-State: AFq9FYI0ncVeMzR2EErqvrV+E0svYcXT0q8yi8PmTc/2Fw0X0imE0SaW
 jlmxkpS9AvYtbsHcJ6DdOGPedfpofZzWmLmVlwhp9Ql26YqAXq3jqPOeeWch8wocbm88NTWN4WU
 NE0C+Ap0=
X-Gm-Gg: AYBFou3RC7uGpG/HzDk+Ymnzm/ecCCykZNfrNJ7W74SiGj0WSqLy16iAtpoug7po0gv
 +9zHTNYU6C3t5AD+C1cIQcSqa9WU7iQrjYv+Gfjj2Up1hfY3rmU4VBrwWKW4ADjBaQxG1oKSPob
 2E2H53C3cIPM9CPhcCUTWgIH1gHXK5WeaxKdh6i/iJrychdTEmmfs0zIcbbQ5GvNxEXqeHY1+6V
 T5js5WTqFQefBxlbaJ0MGZCKYp7LZ45ASAfzpeQa+aHrUBpYKedj9Mabwo9xxz6gCAs6/PLBrCB
 shtWmT4nloQt3v3YLy9V57J3vZTPqZbuWmezESAQBYOQ0PeYfWVvlggZzZjGbrbymobPBYr0gHm
 ONGamfjNZfI9NzH0yByCZ6Iv4utUeCCzfQ0i6h7ZueiuKXp7oZ4d5w5cDUxIKZz5tCIxbntmR+b
 BRBY3xUlN+r4B5E/fmy01DIahN9Yk6iVbs9QyMsKbF22vVyzORsQbPjfoxqspYogaf5JDw1Z7AV
 lqs8ji8jV5CdDgGGmwsk4+Czwsg7Lp5EZBruliwFpjzesNvkBjhvTpXrdHuzKir06tNw/uZVdh9
 +dyMqwaWwKqBxgX+zhdv6jpmQSguOEdCz5eMEfWHl1F1
X-Received: by 2002:a05:600c:1f87:b0:4a1:9ec4:d939 with SMTP id
 5b1f17b1804b1-4a204cfc27amr17650385e9.17.1792629072653; 
 Wed, 21 Oct 2026 17:31:12 -0700 (PDT)
Received: from bas-workstation ([143.58.146.30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2584c374sm7954532f8f.58.2026.10.21.17.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 17:31:10 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, samuel.pitoiset@gmail.com, natalie.vock@gmx.de,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH 3/5] drm/amdgpu: Add UAPI for disabling implicit sync per
 submission.
Date: Thu, 22 Oct 2026 01:30:56 +0100
Message-ID: <20261022003058.1723817-4-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022003058.1723817-1-bas@basnieuwenhuizen.nl>
References: <20261022003058.1723817-1-bas@basnieuwenhuizen.nl>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Per submission flag because:

1) Slightly simpler & more flexible than per context flag.
2) We'd need to extend the per-BO struct if we want to put
   it there.
3) Doing it per BO is annoying implementation wise as we
   disassociate it from the BO list before doing the fences.
4) I don't really anticipate an usecase for doing it per BO.
   (e.g. I don't think we need to selectively do implicit in
    radv and I don't see radeonsi tracking READ vs. WRITE at
    this point.)

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>
---
 include/uapi/drm/amdgpu_drm.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index cd1b8034a2fb..0f75221064b0 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -143,7 +143,14 @@ extern "C" {
 #define AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS	(1 << 5)
 /* Flag that BO is always valid in this VM */
 #define AMDGPU_GEM_CREATE_VM_ALWAYS_VALID	(1 << 6)
-/* Flag that BO sharing will be explicitly synchronized */
+/* Flag that BO sharing will be explicitly synchronized
+ *
+ * This flag should not be used unless the client can guarantee that no
+ * other driver which ever touches this BO will ever want to use implicit
+ * synchronization as it disables implicit sync on this BO system-wide.
+ * Instead, drivers which use an explicit synchronization model should
+ * prefer AMDGPU_CS_NO_IMPLICIT_SYNC.
+ */
 #define AMDGPU_GEM_CREATE_EXPLICIT_SYNC		(1 << 7)
 /* Flag that indicates allocating MQD gart on GFX9, where the mtype
  * for the second page onward should be set to NC. It should never
@@ -974,6 +981,9 @@ struct drm_amdgpu_gem_va {
 #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
 #define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
 
+/* Disable implicit sync on BOs wrt other submissions. */
+#define AMDGPU_CS_NO_IMPLICIT_SYNC 1
+
 struct drm_amdgpu_cs_chunk {
 	__u32		chunk_id;
 	__u32		length_dw;
-- 
2.56.0

