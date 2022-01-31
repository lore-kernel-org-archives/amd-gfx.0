Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C9DC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jan 2022 13:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2805E10E38B;
	Mon, 31 Jan 2022 13:52:54 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB4110E404
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jan 2022 13:52:51 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id l5so26812340edv.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jan 2022 05:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NTPjO3AsS4IZMEkHUF+pqgHasgaoC6e6tc1HQWuXChA=;
 b=VXGgzCr4CZe9W3MHgtQnLbe3lpETFPk9BadNKPYnPuv08JVF2QAklSprxkDa8exv+N
 HCSp/K3djMTG8ZwtS/yaMbjafQNIesPegmuS0+dYQL8jb3g0LU5+jK5VD/T+UQqw9/38
 Ms8QNth0unU330trJdILsZESdNewzQTRNiM4CROBsk3IICg7PEJLVZvUUlX1Rj4PiSah
 om13LzA+vq3K8COpNpJoYD4gaySJMuXodsYGFL0UaoySOevumIi5vZflAtJ8MyFdgnuj
 e6EnZ0QMuSp2H4Vo0nLkp7m/7pWtGV9NioC60XTgvmLsao0ELmnGLEQQ24Wi6r2+pcHo
 eZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NTPjO3AsS4IZMEkHUF+pqgHasgaoC6e6tc1HQWuXChA=;
 b=7PoWGEhvuSBmC8EGoLoRYNFv9wnidOPtqKk1WyvjjzYAeGi4VG3T+PPGGhsDjlM9xa
 3dUo9GDETv8Pbv9PAB1KFJmLS4QM8XAgoBAkCjE7nCNbahf0NSBipYF+QC0vZaC4DOCD
 e5yyBfhXdLLnjn+L0jMmLYITO6KEWD0w1Y17tsoHYixh63gHun/a8oUOvEbzIf4KaC+x
 zYuZ/My1o7pnYDbEo2NZ4tmY1BqI/EHx+ePbCJPUuyPXmCIJK2NXYsbwwXJR9rYk+41B
 8el/rtwhIozcwg09kXg3Jof1hnfpc/WrQmGMjouix+JPzGXsM/eMahhhlX3iCOdRP/Lv
 UGWw==
X-Gm-Message-State: AOAM53272NQU04VyS/fw5weSKPKo82CtkrNbAYAVKgha01F2kLGRK0ed
 sQBGlriURkFa1+hvJyUgu7Y=
X-Google-Smtp-Source: ABdhPJwoaiobUJ/DmVNt6SmJ5c0/cMo0me6Afbtb/rGYGgOXBT6iCso1OVE1jtXIh4hJmVqM2SusZQ==
X-Received: by 2002:a05:6402:3587:: with SMTP id
 y7mr20126077edc.224.1643637169935; 
 Mon, 31 Jan 2022 05:52:49 -0800 (PST)
Received: from baker.fritz.box (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id co19sm17893557edb.7.2022.01.31.05.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jan 2022 05:52:49 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: harish.kasiviswanathan@amd.com, benjaminadam.price@amd.com,
 felix.kuehling@amd.com
Subject: [PATCH 2/4] drm/amdgpu: lower BUG_ON into WARN_ON for
 AMDGPU_PL_PREEMPT
Date: Mon, 31 Jan 2022 14:52:44 +0100
Message-Id: <20220131135246.1521-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220131135246.1521-1-christian.koenig@amd.com>
References: <20220131135246.1521-1-christian.koenig@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

That should never happen, but make sure that we only warn instead of
crash.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2b0e83e9fa8a..bc10b3f9015a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -203,7 +203,9 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 
 	BUG_ON(adev->mman.buffer_funcs->copy_max_bytes <
 	       AMDGPU_GTT_MAX_TRANSFER_SIZE * 8);
-	BUG_ON(mem->mem_type == AMDGPU_PL_PREEMPT);
+
+	if (WARN_ON(mem->mem_type == AMDGPU_PL_PREEMPT))
+		return -EINVAL;
 
 	/* Map only what can't be accessed directly */
 	if (!tmz && mem->start != AMDGPU_BO_INVALID_OFFSET) {
-- 
2.25.1

