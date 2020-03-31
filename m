Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600A9C2D0F3
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 21:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368BA2080C
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 21:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFisECZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368BA2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E1D6E892;
	Tue, 31 Mar 2020 21:22:53 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C68456E88D
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 21:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585689770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9RtJAS2utlkXsWNeESZnCO0nEPegoqsF+a6F9yXKmSk=;
 b=MFisECZhOG19AVb956j23UtyW9+R97CNUMLIAyoRrMord2aa4cFFjuiIrxSLE52CurwgmP
 9LvPU088ZsmE4yhQQqAszwVcYiTI7jqEptlx0KaNiZs36IyY0531SwGNFcXEreGhFIeOkh
 CVWjZOgI2L2kysHOf93/4O4EQUTMKj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-TKFEF2VHO8uuSDVoyeGJ3Q-1; Tue, 31 Mar 2020 17:22:47 -0400
X-MC-Unique: TKFEF2VHO8uuSDVoyeGJ3Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01E0D800D5B;
 Tue, 31 Mar 2020 21:22:45 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-113-88.rdu2.redhat.com [10.10.113.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84BE15C1C5;
 Tue, 31 Mar 2020 21:22:43 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/dc: Kill dc_conn_log_hex_linux()
Date: Tue, 31 Mar 2020 17:22:24 -0400
Message-Id: <20200331212228.139219-3-lyude@redhat.com>
In-Reply-To: <20200331212228.139219-1-lyude@redhat.com>
References: <20200331212228.139219-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Wyatt Wood <wyatt.wood@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DRM already supports tracing DPCD transactions, there's no reason for
the existence of this function. Also, it prints one byte per-line which
is way too loud. So, just remove it.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 .../gpu/drm/amd/display/dc/basics/Makefile    |  3 +-
 .../drm/amd/display/dc/basics/log_helpers.c   | 39 -------------------
 .../amd/display/include/logger_interface.h    |  4 --
 3 files changed, 1 insertion(+), 45 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/basics/log_helpers.c

diff --git a/drivers/gpu/drm/amd/display/dc/basics/Makefile b/drivers/gpu/drm/amd/display/dc/basics/Makefile
index 7ad0cad0f4ef..01b99e0d788e 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/basics/Makefile
@@ -24,8 +24,7 @@
 # It provides the general basic services required by other DAL
 # subcomponents.
 
-BASICS = conversion.o fixpt31_32.o \
-	log_helpers.o vector.o dc_common.o
+BASICS = conversion.o fixpt31_32.o vector.o dc_common.o
 
 AMD_DAL_BASICS = $(addprefix $(AMDDALPATH)/dc/basics/,$(BASICS))
 
diff --git a/drivers/gpu/drm/amd/display/dc/basics/log_helpers.c b/drivers/gpu/drm/amd/display/dc/basics/log_helpers.c
deleted file mode 100644
index 26583f346c39..000000000000
--- a/drivers/gpu/drm/amd/display/dc/basics/log_helpers.c
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * Copyright 2012-16 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-#include "core_types.h"
-#include "logger.h"
-#include "include/logger_interface.h"
-#include "dm_helpers.h"
-
-void dc_conn_log_hex_linux(const uint8_t *hex_data, int hex_data_count)
-{
-	int i;
-
-	if (hex_data)
-		for (i = 0; i < hex_data_count; i++)
-			DC_LOG_DEBUG("%2.2X ", hex_data[i]);
-}
-
diff --git a/drivers/gpu/drm/amd/display/include/logger_interface.h b/drivers/gpu/drm/amd/display/include/logger_interface.h
index 6e008de25629..02c23b04d34b 100644
--- a/drivers/gpu/drm/amd/display/include/logger_interface.h
+++ b/drivers/gpu/drm/amd/display/include/logger_interface.h
@@ -40,8 +40,6 @@ struct dc_state;
  *
  */
 
-void dc_conn_log_hex_linux(const uint8_t *hex_data, int hex_data_count);
-
 void pre_surface_trace(
 		struct dc *dc,
 		const struct dc_plane_state *const *plane_states,
@@ -102,14 +100,12 @@ void context_clock_trace(
 #define CONN_DATA_DETECT(link, hex_data, hex_len, ...) \
 		do { \
 			(void)(link); \
-			dc_conn_log_hex_linux(hex_data, hex_len); \
 			DC_LOG_EVENT_DETECTION(__VA_ARGS__); \
 		} while (0)
 
 #define CONN_DATA_LINK_LOSS(link, hex_data, hex_len, ...) \
 		do { \
 			(void)(link); \
-			dc_conn_log_hex_linux(hex_data, hex_len); \
 			DC_LOG_EVENT_LINK_LOSS(__VA_ARGS__); \
 		} while (0)
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
