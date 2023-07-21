Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1030C001DC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 08:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 241E910E62C;
	Fri, 21 Jul 2023 08:20:48 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B97D510E0BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 06:51:16 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4R6gFG1fmFzBRDtV
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 14:51:14 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1689922274; x=1692514275; bh=qgoRVZJ5UPM8I4JL2ASPKtZbKEH
 PPt1Pqb5QUXsg76g=; b=zUPwB8WllMvdQeGR1ge5ZfgOSAqC8f1hoLyXiBllzhc
 71RZQjtTGGGB7u5nn2viBD9sBZDnncmTDMaZZGwLwQ6YWBU/OnofVZsGCqC+Nqt9
 kJdv+KSoiuOlt1WqpYJ3ZFlrx6THuGoggvUA54nPCpO71dFiaRyPPF+WCAYN8i7m
 WjfPAP5wA+1jRdF0SXvEX2c/YB2sMvysuZxFWT2ORAZWaWnZ0A2DKjP85mcwWK/5
 4+oc+/BnZd/edkNozU2yA1uQtO0OqNVBVvtevZ/mbg/fERtbYWbFIs0ML9PASdVu
 RYkwITXKGxg5D1foN58Ip7HKLJezaXVRAFghuqIOujA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id ffH9zTeMogwi for <amd-gfx@lists.freedesktop.org>;
 Fri, 21 Jul 2023 14:51:14 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4R6gFF5gh4zBRDrN;
 Fri, 21 Jul 2023 14:51:13 +0800 (CST)
MIME-Version: 1.0
Date: Fri, 21 Jul 2023 06:51:13 +0000
From: sunran001@208suo.com
To: airlied@gmail.com, daniel@ffwll.ch
Subject: [PATCH] drm/radeon: ERROR: "foo * bar" should be "foo *bar"
In-Reply-To: <696ea9a46762e16d993f8fc4bf26fb7f@208suo.com>
References: <20230721060919.5133-1-xujianghui@cdjrlc.com>
 <696ea9a46762e16d993f8fc4bf26fb7f@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <d6f31f5ef758427e95a31892ff153f8c@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 21 Jul 2023 08:20:41 +0000
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

Fix two occurrences of the checkpatch.pl error:
ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/radeon/atom.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atom.c 
b/drivers/gpu/drm/radeon/atom.c
index 11a1940bb26d..93acb0e42bd6 100644
--- a/drivers/gpu/drm/radeon/atom.c
+++ b/drivers/gpu/drm/radeon/atom.c
@@ -68,8 +68,8 @@ typedef struct {
  } atom_exec_context;

  int atom_debug = 0;
-static int atom_execute_table_locked(struct atom_context *ctx, int 
index, uint32_t * params);
-int atom_execute_table(struct atom_context *ctx, int index, uint32_t * 
params);
+static int atom_execute_table_locked(struct atom_context *ctx, int 
index, uint32_t *params);
+int atom_execute_table(struct atom_context *ctx, int index, uint32_t 
*params);

  static uint32_t atom_arg_mask[8] = {
  	0xFFFFFFFF, 0x0000FFFF, 0x00FFFF00, 0xFFFF0000,
