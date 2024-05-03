Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6CDC4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 12:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4158A11299F;
	Fri,  3 May 2024 12:37:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WGJIf6L4";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 821F611299F
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 12:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=R3KpFx5djuHUYLEu5F9AdvAVusQeoPej8mFTDEUbblg=; b=WGJIf6L4o1whKC/ExmnxYA11z0
 tqsu0MQXiUFI+N7Sa0r++DrX+ZWmUO9CChTFn0T3lom8mZNBHAh1lngFKQNqCzH7fL1J9cQkbAA0t
 CFLnx07JH9GV5tJKkPlGdpCOJclScP2/P0waeSUJxxUJGUgW5pzob+HRJCw54ksis/hynZcDBX85p
 CGJM/VkcxIEg2yg0Qupp2ga+ktq5ChngawDSvcOabH2AZlxUgY9UDtWzdeODElpz+qSLwN7RWJgxz
 MrOGk/7hPh0HvItSKvZTdFoBhkGZPAC0IfG2kj2FP/LcXWr06gzqgME3WFTGSkaZm2DdxPH6IMOjJ
 FCi794Uw==;
Received: from [84.65.0.132] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s2s9u-0007QB-8J; Fri, 03 May 2024 14:37:02 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.keonig@amd.com>,
 Rob Clark <robdclark@chromium.org>
Subject: [PATCH] Documentation/gpu: Document the situation with unqualified
 drm-memory-
Date: Fri,  3 May 2024 13:36:57 +0100
Message-ID: <20240503123657.9441-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
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

Document that drm-memory- and drm-total-memory- are aliases to prevent any
confusion in the future.

While at it also clarify that the reserved sub-string 'memory' refers to
the memory region component.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.keonig@amd.com>
Cc: Rob Clark <robdclark@chromium.org>
---
 Documentation/gpu/drm-usage-stats.rst | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
index 6dc299343b48..ef5c0a0aa477 100644
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
 
+This is an alias for drm-total-<region> and only one of the two should be
+present.
+
 - drm-shared-<region>: <uint> [KiB|MiB]
 
 The total size of buffers that are shared with another file (e.g., have more
@@ -145,6 +150,9 @@ than a single handle).
 
 The total size of buffers that including shared and private memory.
 
+This is an alias for drm-memory-<region> and only one of the two should be
+present.
+
 - drm-resident-<region>: <uint> [KiB|MiB]
 
 The total size of buffers that are resident in the specified region.
-- 
2.44.0

