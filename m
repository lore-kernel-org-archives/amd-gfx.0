Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E51CC9831E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 12:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BF5210F519;
	Thu, 24 Sep 2026 12:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bRpWzDA7";
	dkim-atps=neutral
Received: from mail-dl2-f39.google.com (mail-dl2-f39.google.com
 [74.125.229.167])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B58AC10E941
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 16:28:54 +0000 (UTC)
Received: by mail-dl2-f39.google.com with SMTP id
 a92af1059eb24-1438cb9b3a3so1179932c88.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 09:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790180934; x=1790785734; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iB3sCFIdT441Ve5Xr6bVNZSuT6o8nHC9HcOE4t6cLwY=;
 b=bRpWzDA7n12g0D4rLy7fGRxlA5wUrNs8OOxrH41hOplYyZAY/HFpvk9Tc61DYwBNRf
 vOq7BzuWY0Om+apv2reB6QS7OIbPMCI3V5PR1GZxuZfrjyo/MqI0jCsEFjSwtR+g6srG
 wJyluzqzJEDuvBwGIOOw9KBv/lcB+X54rK9d7+kXdtyC67YDdo9BvkuxaAKCbGRLFfUp
 Xa0mLZDASkZumAeDwK9oqFxIjunW8sey9hIrMx9vWEQpTQwEVZlUpC9VOo/yUoNYiO1n
 cZ6tduMxPA2Iwi2PsCYM5jLCm/gXhbd0sKApYRZvWDuSg3ipyXUb8BqPKXJS4wWMNVIU
 4fDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790180934; x=1790785734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iB3sCFIdT441Ve5Xr6bVNZSuT6o8nHC9HcOE4t6cLwY=;
 b=sEDbE0PTktgFkQQ6QVdEdBpnr2QaOdsbyTgDBkjrWwcZawhnKCMmDE+qi3ZAnJSxtE
 LVRrCFqI90763dcU6w5RU/CTZs/ud1LxlPHkhGswrBcj5GlzgbQIMe2n4PTaz93sbfc5
 VGh3SUlt8nLbU1DL/qopuP2DYf7kExA/ud3r1i5tMVkcKVhHoohoSNGspbzwi5ibqJRc
 aWMC5+sgx62zSTUpF+dv1XYkUUNqt4SKooViVS3U32xN8e0ZoQeQNszWFPGTz1GW3Mdp
 2XFzhm9ni7SVsvhmiAb1ucOXRrec2cgW3Y1TrmiDIjdCWaaFQ7oXwetXN3FF7lnkp6ag
 C/RA==
X-Gm-Message-State: AFuF++neod+YyJL/Va4VlCWqdO6HOKk0HJfGT+fLKm1QXKS/O/63RotG
 tOJrLg2fkpzPD3T5m1pUwBNccZn8TUZvz6rtLKTbUGWhgjoi0kONDnU3
X-Gm-Gg: AYBFou32nVkWqL4fMTqQ4O2gzrUJNVwSgOGElzOKd6oWFZdS9ba/vIcaemMPJ/wToz2
 DiJZ6WrTnelaS7LUhST9XonL5El7i7IIsYbsodCSoWsmZHnwkBzU/XL5aHiO3cRmKfKkXWMM/eW
 p4JAMEEkxJj1YDnhmTSaqV0ekAZ7/piJReHlOeXBDaRpGCbLCK9MESMFG2LOht7Y4PKSD4PmTx9
 NCXJXGiQgJCOwGQq2n8cQ9epmdJP4QPoNJMqCq9wfOEeZQf8YrjYrv9lWw+vOauETSKYhahLcEu
 2NoXtAPM5X1epnLBSGsMDGuVVQJKKnyD5KpLiqyam3G9yRaLI+aU8hXzPUqDF9HJUjkm2o3CTz0
 DsLti/lu2sBxQrowyAtEg12XIRGNWxn4uyiKbFbfkAuhJsitQlSj6djdUMC/QJ+324FssmhqL0f
 bTauhe978LHTyb0NsJwtkDX3aESBsy3r8HS62Z7oCAlNiTqeU+h6MDrFzHW/YTpE4R
X-Received: by 2002:a05:693c:2518:b0:33c:e61:e1e5 with SMTP id
 5a478bee46e88-33e8d9c95bcmr3116205eec.21.1790180932368; 
 Wed, 23 Sep 2026 09:28:52 -0700 (PDT)
Received: from beelink.. ([187.13.30.172]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e939fd955sm7844052eec.1.2026.09.23.09.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 09:28:52 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Aldo Ariel Panzardo <qwe.aldo@gmail.com>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2] drm/amdgpu: fix ATOM parameter space index bounds check
Date: Wed, 23 Sep 2026 13:28:39 -0300
Message-ID: <20260923162839.1379927-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923163157.1354872-1-qwe.aldo@gmail.com>
References: <20260923163157.1354872-1-qwe.aldo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Sep 2026 12:46:10 +0000
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

atom_get_src_int() and atom_put_dst() use idx as a dword index into
the uint32_t *ps array (ctx->ps[idx]), but compare it against
ctx->ps_size which is in bytes. A malformed ATOM table operand with
idx between ps_size/4 and ps_size-1 passes the bounds check but
accesses up to 3 dwords (12 bytes) beyond the stack-allocated
parameter buffer.

For example with ps_size = 16 bytes (4 dwords), idx = 5 passes
the check (5 < 16) but ctx->ps[5] reads/writes the 6th dword at
byte offset 20, 4 bytes past the allocation.

Divide ps_size by 4 in both comparisons and in the diagnostic
messages to match the dword indexing.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add coordinate ATOMBIOS table support")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2: also fix the pr_info() messages to print ps_size/4 (dwords)
    instead of ps_size (bytes), so the logged limit matches the
    actual check (found by Sashiko AI review).

 drivers/gpu/drm/amd/amdgpu/atom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index e0e585f..dd6c22a 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -232,10 +232,10 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 		(*ptr)++;
 		/* get_unaligned_le32 avoids unaligned accesses from atombios
 		 * tables, noticed on a DEC Alpha. */
-		if (idx < ctx->ps_size)
+		if (idx < ctx->ps_size / 4)
 			val = get_unaligned_le32((u32 *)&ctx->ps[idx]);
 		else
-			pr_info("PS index out of range: %i > %i\n", idx, ctx->ps_size);
+			pr_info("PS index out of range: %i >= %i\n", idx, ctx->ps_size / 4);
 		if (print)
 			DEBUG("PS[0x%02X,0x%04X]", idx, val);
 		break;
@@ -510,8 +510,8 @@ static void atom_put_dst(atom_exec_context *ctx, int arg, uint8_t attr,
 		idx = U8(*ptr);
 		(*ptr)++;
 		DEBUG("PS[0x%02X]", idx);
-		if (idx >= ctx->ps_size) {
-			pr_info("PS index out of range: %i > %i\n", idx, ctx->ps_size);
+		if (idx >= ctx->ps_size / 4) {
+			pr_info("PS index out of range: %i >= %i\n", idx, ctx->ps_size / 4);
 			return;
 		}
 		ctx->ps[idx] = cpu_to_le32(val);
-- 
2.43.0
