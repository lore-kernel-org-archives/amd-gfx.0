Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A76DEB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 13:09:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC02310E28B;
	Mon, 10 Jul 2023 13:09:20 +0000 (UTC)
X-Greylist: delayed 452 seconds by postgrey-1.36 at gabe;
 Mon, 10 Jul 2023 07:46:28 UTC
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA8D010E203
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 07:46:28 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4QzwqH1bwpzBHXh3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 15:38:51 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1688974731; x=1691566732; bh=1pv9U2ejg50V6ues3fPMO0Cknci
 SgisMrIyVi0p4I4g=; b=0zDIx8qbSBbLhsZBxHNYyCIARocYe7tUU2eX2z8Ne37
 McN7z6lf6DaK7HoTfG6DGh/5Tqdnk9xDw7VocPVN1c5H+FywlOOl2VRvrIW4k2ob
 n8IOicj11yg9zMt7/kgKd8ByndZTzbSZbWAA8wsaSj8HvuXA9wvrDsb+ygzmHDC+
 2Uvbk89MhdsBw/1mY/r4SGPwTiu/2XBpTSOL9soAM/IvQgTGrBwPKsGqFKiVsAUo
 +hRpibTUWILfpBHy81P/4ZBTu4BjDCHOKIVoqmrK+PSiY8Vsy7JdEr3DHGfEUHGH
 N+bZSQaqHzQ/5uRPNRGqyoJN/EY9hxvTKiHchq2LBQg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id MXRs-L3OfbwP for <amd-gfx@lists.freedesktop.org>;
 Mon, 10 Jul 2023 15:38:51 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4QzwqG6ZnlzBHXgs;
 Mon, 10 Jul 2023 15:38:50 +0800 (CST)
MIME-Version: 1.0
Date: Mon, 10 Jul 2023 15:38:50 +0800
From: sunran001@208suo.com
To: airlied@gmail.com, daniel@ffwll.ch
Subject: [PATCH] drm/radeon: ERROR: "foo * bar" should be "foo *bar"
In-Reply-To: <20230710073659.54188-1-xujianghui@cdjrlc.com>
References: <20230710073659.54188-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <656c6d33a676c141ea35fadb519ccfbc@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 10 Jul 2023 13:09:18 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix nine occurrences of the checkpatch.pl error:
ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/radeon/atom.c | 14 +++++++-------
  1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atom.c 
b/drivers/gpu/drm/radeon/atom.c
index c1bbfbe28bda..11a1940bb26d 100644
--- a/drivers/gpu/drm/radeon/atom.c
+++ b/drivers/gpu/drm/radeon/atom.c
@@ -1156,7 +1156,7 @@ static struct {
      atom_op_shr, ATOM_ARG_MC}, {
  atom_op_debug, 0},};

-static int atom_execute_table_locked(struct atom_context *ctx, int 
index, uint32_t * params)
+static int atom_execute_table_locked(struct atom_context *ctx, int 
index, uint32_t *params)
  {
      int base = CU16(ctx->cmd_table + 4 + 2 * index);
      int len, ws, ps, ptr;
@@ -1216,7 +1216,7 @@ static int atom_execute_table_locked(struct 
atom_context *ctx, int index, uint32
      return ret;
  }

-int atom_execute_table_scratch_unlocked(struct atom_context *ctx, int 
index, uint32_t * params)
+int atom_execute_table_scratch_unlocked(struct atom_context *ctx, int 
index, uint32_t *params)
  {
      int r;

@@ -1237,7 +1237,7 @@ int atom_execute_table_scratch_unlocked(struct 
atom_context *ctx, int index, uin
      return r;
  }

-int atom_execute_table(struct atom_context *ctx, int index, uint32_t * 
params)
+int atom_execute_table(struct atom_context *ctx, int index, uint32_t 
*params)
  {
      int r;
      mutex_lock(&ctx->scratch_mutex);
@@ -1359,8 +1359,8 @@ void atom_destroy(struct atom_context *ctx)
  }

  bool atom_parse_data_header(struct atom_context *ctx, int index,
-                uint16_t * size, uint8_t * frev, uint8_t * crev,
-                uint16_t * data_start)
+                uint16_t *size, uint8_t *frev, uint8_t *crev,
+                uint16_t *data_start)
  {
      int offset = index * 2 + 4;
      int idx = CU16(ctx->data_table + offset);
@@ -1379,8 +1379,8 @@ bool atom_parse_data_header(struct atom_context 
*ctx, int index,
      return true;
  }

-bool atom_parse_cmd_header(struct atom_context *ctx, int index, uint8_t 
* frev,
-               uint8_t * crev)
+bool atom_parse_cmd_header(struct atom_context *ctx, int index, uint8_t 
*frev,
+               uint8_t *crev)
  {
      int offset = index * 2 + 4;
      int idx = CU16(ctx->cmd_table + offset);
