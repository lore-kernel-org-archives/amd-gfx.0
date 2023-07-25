Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61172C001E0
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 13:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B25F910E3C9;
	Tue, 25 Jul 2023 13:23:37 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3967310E3C1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 08:13:24 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4R98t96bm8zBRydW
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 16:13:21 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1690272801; x=1692864802; bh=YgqX7QCncubAlbC1mLbNMV/XhTM
 zTbCKkfaV7JVxeTg=; b=J6dRdyKwp5IddTSZTbVGzgAIBqEK2UsdSEXy/8lwV5F
 B1RG5NWXaDTj2nmwjqhua9ES/ISpf55f1HR6aiIqiBR1E1WT1piRADBx8fQXt6P1
 Bu6iJRp70a/8ILkUmhcR2HVkRGNXArFxYHq1bKpCF+TLnsh7yd9j3ejPKxV+XdNZ
 xfZ42r4ZwrZBikFIIjyUbwIT8gCJu/24+0qaxHhnlOwKiKEdvlDaR0X9jB2OlLO9
 V6LLDva/+OHLX7vOlC6MUHk58iNP5rclAMF0W01KPI0aS/+z0flLlGaWYXff7SO9
 Ych444o99J4QiYIgRUcsvaroZkArIYQ5Ck3IemoI+NA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id tto45JM7AdJK for <amd-gfx@lists.freedesktop.org>;
 Tue, 25 Jul 2023 16:13:21 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4R98t94CJzzBL0tD;
 Tue, 25 Jul 2023 16:13:21 +0800 (CST)
MIME-Version: 1.0
Date: Tue, 25 Jul 2023 16:13:21 +0800
From: wuyonggang001@208suo.com
To: alexander.deucher@amd.com
Subject: [PATCH] drm/radeon: ERROR: "foo * bar" should be "foo *bar"
In-Reply-To: <20230725080906.2028-1-zhanglibing@cdjrlc.com>
References: <20230725080906.2028-1-zhanglibing@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <b5933d7391b8e526894316b7e17b9637@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 25 Jul 2023 13:23:35 +0000
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

Fix the error(s):
ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
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
