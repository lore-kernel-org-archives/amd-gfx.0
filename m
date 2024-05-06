Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828EBC25B74
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 17:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 925841122B2;
	Mon,  6 May 2024 17:00:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jBadRP9f";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CBB51122B2
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 17:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fb6BsfncjTlVi5sfzTbt+nl+2Ah8/gn2rYXlBLIlNTo=; b=jBadRP9fTpkkQMA0fZGaMWqHu6
 sRUqKKCdQiZgsfJCudTeObd/pDCFc5Y5LwsQhTpverjMrSiQRTbuVqZyZT8UrZS4UdBOKQ/ayZsn8
 8wuRGJngdab3ihfnOA4oQc0Eym/ZrrJ37tfoEzKg0bf0Yjv23NwBEQ6nNovWAQ68ZBwMZZOf7Qgbs
 a1NXSCV+c75wQcZCaG6F9RhIIUNB/VdI7nIpMA2IJU0enNjMCpNBIzsYOg+iililSEZ8nM0zjo8d4
 BtIfuylxWHa4UruVlxReuO7m+X6bcfGJ02uKadshcQjGN8AgHruvlp8WuBU6V7pWN9my0JIIDvajb
 kEYM1nIw==;
Received: from [84.69.19.168] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s41h6-001QfL-Qz; Mon, 06 May 2024 19:00:05 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.keonig@amd.com>,
 Rob Clark <robdclark@chromium.org>
Subject: [PATCH 4/5] Documentation/gpu: Document the situation with
 unqualified drm-memory-
Date: Mon,  6 May 2024 17:59:58 +0100
Message-ID: <20240506165959.50648-5-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506165959.50648-1-tursulin@igalia.com>
References: <20240506165959.50648-1-tursulin@igalia.com>
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Currently it is not well defined what is drm-memory- compared to other
categories.

In practice the only driver which emits these keys is amdgpu and in them
exposes the total memory use (including shared).

To prevent any confusion, document that drm-memory- is deprecated and an
alias to drm-total-memory-.

While at it also clarify that the reserved sub-string 'memory' refers to
the memory region component, and also clarify the intended semantics of
other memory categories.

v2:
 * Also mark drm-memory- as deprecated.
 * Add some more text describing memory categories. (Alex)

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.keonig@amd.com>
Cc: Rob Clark <robdclark@chromium.org>
---
 Documentation/gpu/drm-usage-stats.rst | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
index 6dc299343b48..7fee316c9582 100644
--- a/Documentation/gpu/drm-usage-stats.rst
+++ b/Documentation/gpu/drm-usage-stats.rst
@@ -128,7 +128,9 @@ Memory
 
 Each possible memory type which can be used to store buffer objects by the
 GPU in question shall be given a stable and unique name to be returned as the
-string here.  The name "memory" is reserved to refer to normal system memory.
+string here.
+
+The region name "memory" is reserved to refer to normal system memory.
 
 Value shall reflect the amount of storage currently consumed by the buffer
 objects belong to this client, in the respective memory region.
@@ -136,6 +138,9 @@ objects belong to this client, in the respective memory region.
 Default unit shall be bytes with optional unit specifiers of 'KiB' or 'MiB'
 indicating kibi- or mebi-bytes.
 
+This key is deprecated and is an alias for drm-total-<region>. Only one of the
+two should be present.
+
 - drm-shared-<region>: <uint> [KiB|MiB]
 
 The total size of buffers that are shared with another file (e.g., have more
@@ -143,20 +148,34 @@ than a single handle).
 
 - drm-total-<region>: <uint> [KiB|MiB]
 
-The total size of buffers that including shared and private memory.
+The total size of all created buffers including shared and private memory. The
+backing store for the buffers does not have to be currently instantiated to be
+counted under this category.
+
+This is an alias for drm-memory-<region> and only one of the two should be
+present.
 
 - drm-resident-<region>: <uint> [KiB|MiB]
 
-The total size of buffers that are resident in the specified region.
+The total size of buffers that are resident (have their backing store present or
+instantiated) in the specified region.
 
 - drm-purgeable-<region>: <uint> [KiB|MiB]
 
 The total size of buffers that are purgeable.
 
+For example drivers which implement a form of 'madvise' like functionality can
+here count buffers which have instantiated backing store, but have been marked
+with an equivalent of MADV_DONTNEED.
+
 - drm-active-<region>: <uint> [KiB|MiB]
 
 The total size of buffers that are active on one or more engines.
 
+One practical example of this can be presence of unsignaled fences in an GEM
+buffer reservation object. Therefore the active category is a subset of
+resident.
+
 Implementation Details
 ======================
 
-- 
2.44.0

