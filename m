Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7730C61DDA
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 12:49:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B7BD10F022;
	Thu, 27 Aug 2026 12:49:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Du3sDW4n";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A296710F013
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 12:49:22 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso17575185e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787834961; x=1788439761; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3CHxWs/Md4mrbf4xKUbJKKgRpO4/sfgLi1L7Ppk/eX4=;
 b=Du3sDW4nEH+nZlbBm1/dnFG3Otmv9JAbOjHCTZt270Xs8FSAQ7YWZQw2NRpe0gt5Xo
 88/T5d4OIR72B5ctFfpaUBBnFJIjyJyv2hK/egYUWQKMhpTkc3asGpNCwEzX8WJuCUto
 iUB/N93yQbYpxpM3466C1n1nVOvjaunWGHEVL9Bt6+BEWcuhcl6Fx7P649v/gv9p6ezO
 cklflpmh+Zbq5MLFnHSIac9BwI58+9Fo3ZZOf/SJwGK6xzwGf8joZQrPdHAJI7VwA6eD
 4Du3Pj/sH2wbTGCv2Yny2L8NkCk8AWGMJP4IJI0aCsXaX9QJOI9C9oUlkUtbYl35uEDc
 T6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787834961; x=1788439761;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3CHxWs/Md4mrbf4xKUbJKKgRpO4/sfgLi1L7Ppk/eX4=;
 b=l+CBOUkOblMsIzq64QBMrOatN8b9yh0oDJVsyRMXMXWiR9aXmSBL5a25UGZcirtV+i
 KpufeDkzYYaKomF5ry1w3+IItu2SRoeVK6X+ovjyyPRP4TbhMkqCSxW+M7KlC8Oc7H+S
 9oc25h1GVjyA+Umr+/WXeVgENDBZuJZX7iaQtIfz9gHTmSwaUpp6wJbfveJ6Bk0gIr/m
 C0mWxD92NEE6TFtwd8Kfwj8a4Se6Lhf/V33eNXwlh0GLNfG/OF9NdNwKxk1qWIZuEDqn
 smya0Ar3zrx0/1KF1mdkVzUUV+MSWm4817MutAW2AwFr/P+bz4xjELutoZUZW/TM14EI
 imSw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqumWkP1JV6oDzlkij/lglZ3ODJC6wkDUI85wA4uIwcCZeHvwISiFIBjxiNANb9uAldim6kw65/@lists.freedesktop.org
X-Gm-Message-State: AFuF++mIY0ZLri46W4MgL+jOfMY6Z23xr1ewiPz72w4SXzWWVrhI9+I8
 nogacO4yvhEdfnDvuXQ4/Jlp/FDuT2+g+ctQm1+B2i3Ovu/HlQsG9xwF
X-Gm-Gg: AR+sD13NH9mHTQLsDqKCHtyR3YMCD5JhlPV71C/damvx3HybejJpzBbd/KNtivCZj80
 eqRpWr+bYH2gtpLRk+l4iy853YZs0W8w+vHni2O8mVW/z8svk3CTin0ffCN9nVdenxBvisbmtZe
 cOZihYIDLiF1x40TPLi74HzI5y/hkc5b9YgwKEtr7slBL7wJCTEu6Uev9sZ0QbQOUbEpIhvB1mR
 5dHN69kHCQTg3GUQNbBuy41xYzyXXb+aX0kGQvWsr1/lKKKg1Gf5pKUmGkCXBa1aNpDnJ7EHcTf
 gq204BHw8BKYqWDr4D35ee7EdNlWgJcI84x0V45wOG2aV6cAI52t53ml+lIWuCzh2S+xMiR6kod
 YweCfpM2nXlceDcptkDCsORFdhkcwU/gCh+rQTjSPLwlWo9GMv7QapDQxaMrLNydP0mVO93A/KD
 AmzMFpGQbEixVZ/M5kSU+grgVgqfCHlJ00jgROafPehXYm2/zlEB2P8qD/cAxeQ/rbnVS22ctEs
 Jpscrvr1LLnew==
X-Received: by 2002:a05:600c:4fc7:b0:499:dbae:86be with SMTP id
 5b1f17b1804b1-499dc72675dmr173963305e9.14.1787834960864; 
 Thu, 27 Aug 2026 05:49:20 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1524:4300:a4b8:720e:f64f:4778])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b465226d8sm52089985e9.0.2026.08.27.05.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:49:20 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/10] drm/xe: Use dma_resv_alloc for lockdep annotation
Date: Thu, 27 Aug 2026 14:38:55 +0200
Message-ID: <20260827124910.2245-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827124910.2245-1-christian.koenig@amd.com>
References: <20260827124910.2245-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace the stack-allocated dma_resv in xe_pm_runtime_lockdep_prime()
with a dynamically allocated one using dma_resv_alloc(). This aligns
with the move away from embedded dma_resv structures and towards
reference-counted dynamic allocation.

The lockdep priming function is used to establish lock ordering
dependencies between runtime PM and dma_resv locks. The resv is only
used temporarily for lockdep annotation and is immediately freed after
use with dma_resv_put().

If allocation fails, we silently return since this is optional lockdep
annotation that only affects dependency checking, not functional
behavior.

Signed-off-by: Christian König <christian.koenig@amd.com>
Assisted-by: Claude:Sonnet 4
---
 drivers/gpu/drm/xe/xe_pm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 99562f691080..33b19bcb6f71 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -762,15 +762,20 @@ static void xe_rpm_might_enter_cb(const struct xe_device *xe)
  */
 static void xe_pm_runtime_lockdep_prime(void)
 {
-	struct dma_resv lockdep_resv;
+	struct dma_resv *lockdep_resv;
+
+	lockdep_resv = dma_resv_alloc();
+	if (!lockdep_resv)
+		return;
 
-	dma_resv_init(&lockdep_resv);
 	lock_map_acquire(&xe_pm_runtime_d3cold_map);
 	/* D3Cold takes the dma_resv locks to evict bos */
-	dma_resv_lock(&lockdep_resv, NULL);
-	dma_resv_unlock(&lockdep_resv);
+	dma_resv_lock(lockdep_resv, NULL);
+	dma_resv_unlock(lockdep_resv);
 	lock_map_release(&xe_pm_runtime_d3cold_map);
 
+	dma_resv_put(lockdep_resv);
+
 	/* Shrinkers might like to wake up the device under reclaim. */
 	fs_reclaim_acquire(GFP_KERNEL);
 	lock_map_acquire(&xe_pm_runtime_nod3cold_map);
-- 
2.43.0

