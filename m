Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B97CEE33F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 16:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F203910E4FC;
	Tue, 18 Nov 2025 16:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QiXzHBud";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8415410E4FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 16:56:30 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b739ef3f739so400942466b.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 08:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763484989; x=1764089789; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BbsAIDQ87Afxd8vSbYgQ0MrOOb/Av9mc8jx/aW27muo=;
 b=QiXzHBudHSrCZf9frEQnE0Y5Np1jlZmyQ/DjmOcUthzZhBAzfCbIPW4819t5zuZ8j3
 ejchvwGp8mpi3dKBd/jThf0ubqINteAYGDecMfhU6z1Yz8xk9ixDHyazr4xt1aEI0S22
 qrE8GO6yTffxl1FtJ/Uq7YnNMXiulepc6nT31Mspvaahgqqq/HeGI8q6B06fRPdtGfZh
 oHtXZ4GGYwcKOqKeFXtEInmBxdwmCud9KW7FRnTI4PyjTceiPLffTYVmpiuDku6BL7DB
 H+PYxLAqWr88hgGXX8YRlpqWh9mrf0NvUsAPN82WE8ZQbMd204SWfoo5Zfeobv9H4u2k
 n7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763484989; x=1764089789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BbsAIDQ87Afxd8vSbYgQ0MrOOb/Av9mc8jx/aW27muo=;
 b=NTED048Qtnzl10IRjRFFKSHswkWOdxliDcJXzNyJHFS5ehHpW3qyG7o0LNvvMR8J5j
 UeS6P0TKF4yYqNtUpx0GVVeKJzDpGyLxr+Ga/YWZmypHbf+f5UqPSsdTiGZjWqVMYKWZ
 YKfrwkd0QwbN5CWBtgKZAe9EACukRV6XwxBpIEjm3Wu3ACshnyAC/j5rQ0peu/QKte+U
 kIcap1BQDJFTXJCTz+8Kix9GAhCipAit2OPWokizyYztptTj2/iLjrITyl8YM3O+bK/A
 31nlqxdrhBWdPVLcj6zay3HMQvHSI4i7dM7pKnObqMw1KR2OwWDW504sJG7vlJxXqnH8
 fR5Q==
X-Gm-Message-State: AOJu0Yzl33UZ+Bbaah0eUMTUYPAiSCOSHm7embW9vzZpW17o1dnqKRnn
 mBZ7hFGe6lVxVRS0vWduFolIUU6i5vxxA4euORDOzuLe9UYodgbTfS8JldvIKN+A
X-Gm-Gg: ASbGncuRgE+QFaoEZbuS49QK5diw/QckFmXmbyHKYrqgXjnwyGy1ipc6ZaTeO8xr+vC
 tUzeoorT5Yzv31y0XuPS4asRitS7KqN5Bg+fvoUZCkfqEs7ZVeWii8FiUf9k0dCRScu2ysB/7Ue
 UYoVC3Vkrk64/xRlavFeMOBULArJGQ7dVq9Jy70kZ+yxnPO8fvf2WwrSkef/YZbEHZgpcQQ1Srh
 M0i52DPtzfROvaB0EUB9indOpouP5H2VcSPqWQErw+/EsW+gwTImAogjbkfW5mr5f4cIqhAIG3h
 IMiwsprArRKn0Jn+EqLAFWNQLyZDyK8/ffv24kWh6ODeKFYNqBrYFDsw3z1V5XcWihCopneI/6b
 EKnqp11eEtECueJP4zLzUa7qgbi7SOqxuxjLjcqiICH8l+KUMTQJKU1ugNtX0WDhp+BvfFGJ480
 XZ70XJGyH101/3fjwSlvJj9WSfg8g/7VKU5V3lQSmsh/aTLOE=
X-Google-Smtp-Source: AGHT+IHGxt/9tpDXrnqXwXX3JiG9d3uzBtVXyvltLeAX6BVVqbXHy1XEBcfV85I45PZCu4b0GDddRw==
X-Received: by 2002:a17:907:97d5:b0:b74:9862:3e36 with SMTP id
 a640c23a62f3a-b749862587amr519124166b.51.1763484988846; 
 Tue, 18 Nov 2025 08:56:28 -0800 (PST)
Received: from Timur-Max (82-198-214-3.briteline.de. [82.198.214.3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fad44b4sm1408197766b.28.2025.11.18.08.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 08:56:28 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/3] drm/amdgpu/uapi: Clarify comment on AMDGPU_VM_PAGE_PRT
Date: Tue, 18 Nov 2025 17:56:19 +0100
Message-ID: <20251118165620.216753-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118165620.216753-1-timur.kristof@gmail.com>
References: <20251118165620.216753-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In the context of the amdgpu uAPI, the PRT flag is referring only
to unmapped pages of a partially resident texture (aka. sparse
resource), but not the full resource.

Virtual addresses marked with this flag behave as follows:
- Reads return zero
- Writes are discarded

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 include/uapi/drm/amdgpu_drm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 406a42be429b..f43592997b49 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -883,7 +883,7 @@ struct drm_amdgpu_gem_list_handles_entry {
 #define AMDGPU_VM_PAGE_WRITEABLE	(1 << 2)
 /* executable mapping, new for VI */
 #define AMDGPU_VM_PAGE_EXECUTABLE	(1 << 3)
-/* partially resident texture */
+/* unmapped page of partially resident textures */
 #define AMDGPU_VM_PAGE_PRT		(1 << 4)
 /* MTYPE flags use bit 5 to 8 */
 #define AMDGPU_VM_MTYPE_MASK		(0xf << 5)
-- 
2.51.1

