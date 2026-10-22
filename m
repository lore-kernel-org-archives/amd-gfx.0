Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AB4606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 00:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.a=rsa-sha256 header.s=google header.b=WUDgeKCo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C85F2112277;
	Thu, 22 Oct 2026 00:31:23 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C52A910E010
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 00:31:15 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso1268077f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 17:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1792629074; x=1793233874;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I5ukXGqciLAXOq2MsbQDunhloyUVSK+JPqzV4cX6MXM=;
 b=WUDgeKCoeTDMB7nd3v3fVsHIqK4lMYzstIiCnBezwAoC5RscZolzuQtTAh0gCgJp55
 F1SMxjttQrL70TAQMxSFSfJSy8a+iNOpKT3nl06M8S/k5U+mmwwiHxNtPf7Vujqu6Skc
 UsxajnqtWi8lUw5Er+5Raa1fk18W01UaWOSMyWxJ0awDr/dnPMtZWioZGjZ9mYacv6je
 vEKpNjvyE9nOW+KtE++VhESOxvBRbuCi/lWSsXdBGjb24lYPcMOL2jaD3q+L/vJhf2wj
 WM0K8rym/32d9hbCkQ8wmLZ34D82tYDAe9XUMJUhw4GMxVlVorLUUfcJPfw/GFXjRz03
 qQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792629074; x=1793233874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I5ukXGqciLAXOq2MsbQDunhloyUVSK+JPqzV4cX6MXM=;
 b=niLTQnx+ibYK1KEzTlPQC4/GJsK7I+0DHgd4jhGVYFwFGu3SbsTDYaJH2UmE1FUrPI
 Bm4bpKI6/12m7uNK9cB/5MehZjD3Jg5gfeQgKGjtDKs3Kpx4R3RyBtcjL+yWFwvuEob4
 9O1si/gkTAy8/h6xrleYHWqTH8/no5WbnX0JqYJGLS8epMdQxMh3kPUvd6aG4vMIhD3Q
 UTN7Fs7oK48TN3bNv3RoVfYX96CqALFuevjn3sKB1NefLl6qAeYnQgng+I685pOAFig3
 1RKhlOei0ENfFTMzvdNKh54cVRYGWGFJq0IB5FsISIBYmYIoUaLl5ArjdJ3WAnTozyGe
 KHfA==
X-Gm-Message-State: AFq9FYLoMgzfSxYePpu8O6SJnN8WdOXNP82ETtFZJbKF3ETXEKyVEQC+
 3IqnpVzWI/UuIkydKNFpgDwJDCzEcCcQ2qppMZ8e/iwWevOfbXvGShTs6w6dPzGHiDhCEPqinIW
 tC15LojQ=
X-Gm-Gg: AYBFou1qCHYJ8SipiRWUN0lyaTlxfEGilycq+7NHc6VyedVv7DD5oqDVIgAsO55NUZF
 g/tq0+cUUnjcLVrljIns+eIQkNCMXNTe4bkYU/u+d9p4r9KDdBDOGOBPvKK/jD2RvRtb/lZIjZI
 ivmjuKkoJL0Z9QjqwjEGTY4f/R45xLQMhbcuVRSg6zSFP8LenDIfE7KnABhLfBro3/umAXuM0qD
 npyZ4pHDIJu+xnDD5GOYLgq5wsmdlafZGjxyFvSr31tFfpm8GX6COkKFZUSUeWVH6M2Zz0P1bD2
 p8NcNVRWW5qfKry7C3dXDX7u05jNeXM1FNYkcWSNK986zasCAJ2KarPv3MWwJrwHTsVV74AaWT/
 VM+4NnAyHWhEiRzJxL+86fD+mdoPv9FrijZOq6lWwq0IVA+60Rq2usCu/BxUHwrbDnytiVgJt38
 IhAufcrU9rHZRB1+7QVC5aMYXTL/wHiFNcr33zQ2u0BGVyGlMPW94e3j7NI/mo3a6NhHcNBlFzu
 OQ+t7eED3NBePqi/UGmw8kJVp/XY0DXovEbZ+uirl3wgc5sNwZuYDLI8DMm3bj9oeZSOPpnsnYH
 qbpLYOUZhUkRcjff+f1h7F+FKwiJrmeNzK3y0fy2Ybq7
X-Received: by 2002:adf:ee81:0:b0:48b:2a2:31dc with SMTP id
 ffacd0b85a97d-48e264e8d7fmr5633887f8f.49.1792629074175; 
 Wed, 21 Oct 2026 17:31:14 -0700 (PDT)
Received: from bas-workstation ([143.58.146.30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2584c374sm7954532f8f.58.2026.10.21.17.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 17:31:13 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, samuel.pitoiset@gmail.com, natalie.vock@gmx.de,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH 5/5] drm/amdgpu: Bump the driver version for the new flag.
Date: Thu, 22 Oct 2026 01:30:58 +0100
Message-ID: <20261022003058.1723817-6-bas@basnieuwenhuizen.nl>
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

For AMDGPU_CS_NO_IMPLICIT_SYNC.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 9c5e93cd3ee6..c154c4c9697e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -128,9 +128,10 @@
  * - 3.63.0 - GFX12 display DCC supports 256B max compressed block size
  * - 3.64.0 - Userq IP support query
  * - 3.65.0 - Add userq syncobj timeline signaling support
+ * - 3.66.0 - Support AMDGPU_CS_NO_IMPLICIT_SYNC.
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	65
+#define KMS_DRIVER_MINOR	66
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
-- 
2.56.0

