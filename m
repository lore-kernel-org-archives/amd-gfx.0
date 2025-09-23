Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97FDCAC5B0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 13:10:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DD0810E12F;
	Tue, 23 Sep 2025 13:10:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NrFB2PZF";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 624C510E12F
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 13:10:29 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso2954409f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758633028; x=1759237828; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zOSmp04ejqwWY1rBfI5jUzI4eB7hFqr7ooGdTBInmLE=;
 b=NrFB2PZFcLjqh5JWMk/QFNXBHKWN/wVmM0884R/AdtJmtZMyqmyb9lH2+oF9FLn3Ni
 hNYx8VuVmFNyzSfyZzoXzGUNHT6QwL/YUb15lnn18KZQFVhHOkSHHUeiT0kXaHwYHY+F
 oIdGZty/EX9l+rUj3hkMEyWh5fOggmex4SQoYp7ZAv8lmC1mG5RJ/El633fGXL60+bLO
 0Fzq4Okd+spO6aI7/yNxYdlosf2TCi6wbK7NgJCqMwibng9X6N06ogMx6A+hlx+UB3Z4
 qfFBCwtZBvAZPQ7SaBHmYV+eCXE0jDQjlCJSTzidmv6K5Z/gbXrK/96VA+ENpbIZnBTl
 +acQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758633028; x=1759237828;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zOSmp04ejqwWY1rBfI5jUzI4eB7hFqr7ooGdTBInmLE=;
 b=YlSxYOx7rpsUf9ddWxPjheqv/cfJiHaE1aMqifAXnuHC1QRXXS5BZsAJaklNBMFspp
 J4XIkDXY3914GqTdZgN+um9BLTQIHcTXROnF1iCmdIaLNPKQvENRVQvnzckQh26fXXBE
 Gb1udel5FRlwTIwlqXMjLfJx8/zIWXVqjqAq1l33VOBhjScZ/nOYxpZkY2M5XXs3ueo4
 n53pPp+/0aUreRTlfrrHY3lcqbO/yNOQ7Ob+BFOvmMdFRlZkfsH4x8b57QheiOk4RS9J
 2n8wb4K4MzBSYcrUKDote0JhqzrijankGHy1TweAxJk0TgfklizIqKmw24Zy3Hc9tfX1
 F2pw==
X-Gm-Message-State: AOJu0YznbNwkXBE4O5D5437HhxOt5bJVw74Q73fZa4z6fxTzuehu5EUq
 dLw0mey44TczUz8UrWykYgzj7/vmZ3CkVJHn6xjpAGCVQGClhSSIbC+H
X-Gm-Gg: ASbGncsm461PQatEB1p8091oyW6uUZ0/wl4J3VYjATWqoNJvE/TCPmMZTdRARQs6RRT
 pb85MPbj7cavm3U3QS71RR/hWy7JgvNznWVNdit64a87vfvDy69AD3cTcva8LWYl6lmT0ZIcHBl
 mSvQdbLpbvWz/YUT8UgI6EK2PshKE/6vIWrmjcU+2WIdbvvFk2Fnw4pAucoK8XKyY1klFMQEvNw
 TQNBKpRI7oV7kefSnCUIg8XHKQCnLqiVEbn5ixD2nbKQB+7gATfwE1V9ESHdb9sW6TZtZRRzBq0
 RvnoPaduYOzFobo/jVUdq106UWwvWE0jpFZnUh1hswteYP+ohIqrmIsjI7OXE5+AphSozAoLTMb
 boOSQQK7Hv8fJ+6ZyW9zNHtCyjZ0fXo0zNA==
X-Google-Smtp-Source: AGHT+IHBWMupgMvyNkcQk21Ec290Jw1w3ZEVmXMUV3G1ETgA8z5dAQCxVdG9n/OZ+Im03OK0IiXt8w==
X-Received: by 2002:a05:6000:2f88:b0:3e7:6474:1b63 with SMTP id
 ffacd0b85a97d-405ccae15d8mr2018825f8f.63.1758633027486; 
 Tue, 23 Sep 2025 06:10:27 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:154b:6000:92aa:f6c5:aa55:21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f88de2d075sm12491740f8f.35.2025.09.23.06.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 06:10:26 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com,
	Marek.Olsak@amd.com,
	timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: remove two invalid BUG_ON()s
Date: Tue, 23 Sep 2025 15:10:24 +0200
Message-ID: <20250923131025.3268-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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

Those can be triggered trivially by userspace.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 66c47c466532..d61eb9f187c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5862,8 +5862,6 @@ static void gfx_v11_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 	u32 header, control = 0;
 
-	BUG_ON(ib->flags & AMDGPU_IB_FLAG_CE);
-
 	header = PACKET3(PACKET3_INDIRECT_BUFFER, 2);
 
 	control |= ib->length_dw | (vmid << 24);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 710ec9c34e43..93fde0f9af87 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4419,8 +4419,6 @@ static void gfx_v12_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 	u32 header, control = 0;
 
-	BUG_ON(ib->flags & AMDGPU_IB_FLAG_CE);
-
 	header = PACKET3(PACKET3_INDIRECT_BUFFER, 2);
 
 	control |= ib->length_dw | (vmid << 24);
-- 
2.43.0

