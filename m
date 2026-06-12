Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC197CD98E3
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 08:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 052B410E28F;
	Mon, 15 Jun 2026 08:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="gZt+NKjA";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3574A10E67B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 23:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=OaR4szg3hTCiTSjz207EtEIC5B9GahQqwiezvnSwekU=; b=gZt+NKjA02f2IwzEh1KqPiNI3z
 7kB/IBN88yXBAS+YORdUcKqI4JV4hrwNU4EJSCMNsHJ+TUhmvBS4nAllInDsZJDicijfwSWzdeCFh
 87Pd2fM9hshftE+zKqLOIdNTTvZ60AjlsJZsr/BI2qQfc/+Dsbq1WvAJ11s2pqkS8DMgkwYXFyTSC
 UT2BXRTZ0jx3O+4gXzioYD1Pgyy+i26LPyjQsHZH8CPMxFcqJ34GoBV/bVFhnbbeN5VqUbNZ2weBi
 MsDKC4qcoSuop9vmrUj48J4FeQCnHa0ZoYmAGUOpIa+Rc3QZWCX6KGUvWi/EdPoHhaLRMAnL2tZlf
 N2hMThsg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wYBYY-0000000BlyE-3O9Y; Fri, 12 Jun 2026 23:44:58 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] kdoc: xforms: ignore special static/inline macros
Date: Fri, 12 Jun 2026 16:44:56 -0700
Message-ID: <20260612234458.1084156-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 15 Jun 2026 08:22:58 +0000
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

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c contains 7 (for
now) functions that use STATIC_IFN_KUNIT or INLINE_IFN_KUNIT macros for
function qualifiers (static or not, inline or not).

These cause parse warnings from kernel-doc:
Invalid C declaration: Expected identifier in nested name, got keyword:
  struct [error at 29]
STATIC_IFN_KUNIT const struct drm_color_lut * __extract_blob_lut (const
  struct drm_property_blob *blob, uint32_t *size)

Handle these in kernel-doc to prevent multiple warnings.

Fixes: 647d1fd04652 ("drm/amd/display: Add KUnit test for color helpers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: drop an unsubmitted patch so that this one applies with no problem

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Ivan Lipski <ivan.lipski@amd.com>
Cc: Dan Wheeler <daniel.wheeler@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org

 tools/lib/python/kdoc/xforms_lists.py |    2 ++
 1 file changed, 2 insertions(+)

--- linext-2026-0610.orig/tools/lib/python/kdoc/xforms_lists.py
+++ linext-2026-0610/tools/lib/python/kdoc/xforms_lists.py
@@ -102,6 +102,8 @@ class CTransforms:
         (CMatch("__no_context_analysis"), ""),
         (CMatch("__attribute_const__"), ""),
         (CMatch("__attribute__"), ""),
+        (CMatch("STATIC_IFN_KUNIT"), ""),
+        (CMatch("INLINE_IFN_KUNIT"), ""),
 
         #
         # HACK: this is similar to process_export() hack. It is meant to
