Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E77C55178
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 07:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F2620853
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 07:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F2620853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88EE36E4D0;
	Fri, 23 Oct 2020 07:47:16 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B02D56E4CA;
 Fri, 23 Oct 2020 07:47:14 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6E158AC83;
 Fri, 23 Oct 2020 07:47:13 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amd/display: Don't invoke kgdb_breakpoint()
 unconditionally
Date: Fri, 23 Oct 2020 09:46:55 +0200
Message-Id: <20201023074656.11855-3-tiwai@suse.de>
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

ASSERT_CRITICAL() invokes kgdb_breakpoint() whenever either
CONFIG_KGDB or CONFIG_HAVE_KGDB is set.  This, however, may lead to a
kernel panic when no kdb stuff is attached, since the
kgdb_breakpoint() call issues INT3.  It's nothing but a surprise for
normal end-users.

For avoiding the pitfall, make the kgdb_breakpoint() call only when
CONFIG_DEBUG_KERNEL_DC is set.

https://bugzilla.opensuse.org/show_bug.cgi?id=1177973
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/amd/display/dc/os_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index 330acaaed79a..32758b245754 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -94,7 +94,7 @@
  * general debug capabilities
  *
  */
-#if defined(CONFIG_HAVE_KGDB) || defined(CONFIG_KGDB)
+#if defined(CONFIG_DEBUG_KERNEL_DC) && (defined(CONFIG_HAVE_KGDB) || defined(CONFIG_KGDB))
 #define ASSERT_CRITICAL(expr) do {	\
 	if (WARN_ON(!(expr))) { \
 		kgdb_breakpoint(); \
-- 
2.16.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
