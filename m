Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863F4C388F9
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 07:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CFAF2084C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 07:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFAF2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BDA66E4CB;
	Fri, 23 Oct 2020 07:47:17 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF1F86E4CB;
 Fri, 23 Oct 2020 07:47:14 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7E6D4AD4F;
 Fri, 23 Oct 2020 07:47:13 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amd/display: Clean up debug macros
Date: Fri, 23 Oct 2020 09:46:56 +0200
Message-Id: <20201023074656.11855-4-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201023074656.11855-1-tiwai@suse.de>
References: <20201023074656.11855-1-tiwai@suse.de>
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
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch simplifies the ASSERT*() and BREAK_TO_DEBUGGER() macros:
- Move the dependency check of CONFIG_KGDB into Kconfig
- Unify the kgdb_breakpoint() call
- Drop the non-existing CONFIG_HAVE_KGDB

Also align the behavior of ASSERT() macro in both cases with and
without CONFIG_DEBUG_KERNEL_DC.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/amd/display/Kconfig       |  1 +
 drivers/gpu/drm/amd/display/dc/os_types.h | 33 +++++++++++--------------------
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index f24abf428534..60dfdd432aba 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -42,6 +42,7 @@ config DRM_AMD_DC_SI
 config DEBUG_KERNEL_DC
 	bool "Enable kgdb break in DC"
 	depends on DRM_AMD_DC
+	depends on KGDB
 	help
 	  Choose this option if you want to hit kdgb_break in assert.
 
diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index 32758b245754..95cb56929e79 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -94,36 +94,27 @@
  * general debug capabilities
  *
  */
-#if defined(CONFIG_DEBUG_KERNEL_DC) && (defined(CONFIG_HAVE_KGDB) || defined(CONFIG_KGDB))
-#define ASSERT_CRITICAL(expr) do {	\
-	if (WARN_ON(!(expr))) { \
-		kgdb_breakpoint(); \
-	} \
-} while (0)
+#ifdef CONFIG_DEBUG_KERNEL_DC
+#define dc_breakpoint()		kgdb_breakpoint()
 #else
-#define ASSERT_CRITICAL(expr) do {	\
-	if (WARN_ON(!(expr))) { \
-		; \
-	} \
-} while (0)
+#define dc_breakpoint()		do {} while (0)
 #endif
 
-#if defined(CONFIG_DEBUG_KERNEL_DC)
-#define ASSERT(expr) ASSERT_CRITICAL(expr)
+#define ASSERT_CRITICAL(expr) do {		\
+		if (WARN_ON(!(expr)))		\
+			dc_breakpoint();	\
+	} while (0)
 
-#else
-#define ASSERT(expr) WARN_ON_ONCE(!(expr))
-#endif
+#define ASSERT(expr) do {			\
+		if (WARN_ON_ONCE(!(expr)))	\
+			dc_breakpoint();	\
+	} while (0)
 
-#if defined(CONFIG_DEBUG_KERNEL_DC) && (defined(CONFIG_HAVE_KGDB) || defined(CONFIG_KGDB))
 #define BREAK_TO_DEBUGGER() \
 	do { \
 		DRM_DEBUG_DRIVER("%s():%d\n", __func__, __LINE__); \
-		kgdb_breakpoint(); \
+		dc_breakpoint(); \
 	} while (0)
-#else
-#define BREAK_TO_DEBUGGER() DRM_DEBUG_DRIVER("%s():%d\n", __func__, __LINE__)
-#endif
 
 #define DC_ERR(...)  do { \
 	dm_error(__VA_ARGS__); \
-- 
2.16.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
