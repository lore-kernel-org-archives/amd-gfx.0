Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D29C56201
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 07:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5172085B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 07:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5172085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8B546E4D7;
	Fri, 23 Oct 2020 07:47:16 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D9D36E4B7;
 Fri, 23 Oct 2020 07:47:14 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 5ECCEAC43;
 Fri, 23 Oct 2020 07:47:13 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amd/display: Fix kernel panic by dal_gpio_open() error
Date: Fri, 23 Oct 2020 09:46:54 +0200
Message-Id: <20201023074656.11855-2-tiwai@suse.de>
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

Currently both error code paths handled in dal_gpio_open_ex() issues
ASSERT_CRITICAL(), and this leads to a kernel panic unnecessarily if
CONFIG_KGDB is enabled.  Since basically both are non-critical errors
and can be recovered, drop those assert calls and use a safer one,
BREAK_TO_DEBUGGER(), for allowing the debugging, instead.

BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1177973
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c
index f67c18375bfd..dac427b68fd7 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c
@@ -63,13 +63,13 @@ enum gpio_result dal_gpio_open_ex(
 	enum gpio_mode mode)
 {
 	if (gpio->pin) {
-		ASSERT_CRITICAL(false);
+		BREAK_TO_DEBUGGER();
 		return GPIO_RESULT_ALREADY_OPENED;
 	}
 
 	// No action if allocation failed during gpio construct
 	if (!gpio->hw_container.ddc) {
-		ASSERT_CRITICAL(false);
+		BREAK_TO_DEBUGGER();
 		return GPIO_RESULT_NON_SPECIFIC_ERROR;
 	}
 	gpio->mode = mode;
-- 
2.16.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
