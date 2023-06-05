Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F854C7EE2A
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 09:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B746410E1B7;
	Mon,  5 Jun 2023 09:11:28 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCED710E1B5
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jun 2023 09:11:26 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9768fd99c0cso497205166b.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Jun 2023 02:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685956285; x=1688548285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pL9j+CA9IBShTXKF1f9QsvbzTSBIudC9K5zY5oh+mZI=;
 b=sC47liUQedhuD6GSLY7/ZjTOyj9VB0LeGDSciS7b0TfeXjFsV9wo5sCop0QiFR72kz
 BwCLrTp7XR51RLnUl6YimtEZIWDNPnxkB+bwjXTnrKj4ea1Mu5quFWDFb/oWoMQh0mc1
 xqcWfinSyUYqM//yoHFU/cSs4/0A5KVSCncNgMV29tWwQvg4FbLq6peHeq/ETRQeFpcb
 C63xoKRd1iDuSewC4VkJLJyDlt6jlnTZXAZEeD64GhInz9e4a2QOIVcZNPtoDXnC7vBv
 k2SKjI/7lB00leOaUzfFO77abMYO4GYHkX8qc7vTNq9/6K9s/Xb+VoBQYQ3RQ4tMzlvv
 IYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685956285; x=1688548285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pL9j+CA9IBShTXKF1f9QsvbzTSBIudC9K5zY5oh+mZI=;
 b=b2uKrYsKwxs47allEJEqdVBThWR95kYnEHXv2mk0DwMqzwcD/FvJruoLLdiCW8dgrQ
 NUXTs8EVC/9TiL1X4uWlLBFhT/dDtOgNnoegbd8tuBtvdH73tgrhogY9JdNnNteAK4KY
 fNsDeXzkovQ5tuoUTFZdKJrYzPeGPQp25Mvkto0rV6LXuUGReo8E165AVns06RZz1iKk
 K9gRvBUucp/MRqNOT0OLhYQ1FhJoz3qBCLpiteP3VrVgRFX3XidkZsAqK1Rx7ER9QE3t
 rgLELKVRE8OQoMvl9QDOB/v0A9vWROyMOkFpNjW42y35pWwl4VXa1hg/9J/vRGgLly9d
 4rSw==
X-Gm-Message-State: AC+VfDyqCURRsQQyeR4ZVAxtLW6NUPXOPx1jQ2uaME6bHSz6NExEWi1L
 EL+tFlb0wYSeUSBH/J3dqIIdWYeNAc8=
X-Google-Smtp-Source: ACHHUZ6asq6LcGx/UuvhvuTiHug6JwmeX6uJxhBipRgfsfnfEAze/xEPKLL+hnIQuB8876oNz8o9Fg==
X-Received: by 2002:a17:907:7b88:b0:973:8edc:5a57 with SMTP id
 ne8-20020a1709077b8800b009738edc5a57mr5885846ejc.4.1685956284542; 
 Mon, 05 Jun 2023 02:11:24 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:156f:3500:5740:cdd2:425c:f4f3])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a1709060a1100b009655eb8be26sm4043134ejf.73.2023.06.05.02.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 02:11:24 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, mikhail.v.gavrilov@gmail.com,
 Guchun.Chen@amd.com
Subject: [PATCH 2/2] drm/amdgpu: make sure that BOs have a backing store
Date: Mon,  5 Jun 2023 11:11:22 +0200
Message-Id: <20230605091122.3363-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605091122.3363-1-christian.koenig@amd.com>
References: <20230605091122.3363-1-christian.koenig@amd.com>
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

It's perfectly possible that the BO is about to be destroyed and doesn't
have a backing store associated with it.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 2bd1a54ee866..249385985a4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1268,8 +1268,12 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 			  struct amdgpu_mem_stats *stats)
 {
-	unsigned int domain;
 	uint64_t size = amdgpu_bo_size(bo);
+	unsigned int domain;
+
+	/* Abort if the BO doesn't currently have a backing store */
+	if (!bo->tbo.resource)
+		return;
 
 	domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
 	switch (domain) {
-- 
2.34.1

