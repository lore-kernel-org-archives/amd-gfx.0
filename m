Return-Path: <SRS0=7Usp=F3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F52DC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 08:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBFF2070B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 08:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBFF2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B054C6E8D0;
	Wed, 23 Dec 2020 08:14:06 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFC0689B27;
 Wed, 23 Dec 2020 08:04:04 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id c12so9910299pfo.10;
 Wed, 23 Dec 2020 00:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=YwhKeQ95NsQxO4i1B4M2YvP1DI+YaSx95x3VhWlw4c0=;
 b=Z3p9ls8iU7RsPuqa6E0pHKrw+VfFahKvI/G4pCscJDgbZD3I7rVQe4mY4hVO4k2P4B
 ltT6ecB0vN9YE3JcXLuhsbtB826TEKOYWlE2QYC7ah8pld+3MGvaNa8fOGjdnpelC5Z+
 1p8ipojt0lDJeBVCq1oPg5Or+WPyLlsu5PbtGSjdZ3w71UZa7AAPemC1GAtAvtyw4J16
 Eso7rJ9xlH61h1rY5eZrVSM2vlgZNx3w1kLwRDbPHOYy1cRcH/11W+PyuXIeurEnime3
 uo9Yz0Ng0muKjkxb3cmyitn8I/RGln+wot+TEeazojATMxzCh8BBfXaOVzQePegh4He/
 a9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=YwhKeQ95NsQxO4i1B4M2YvP1DI+YaSx95x3VhWlw4c0=;
 b=XbsWV1tnWtSC9lBWv3lFAYBC48MwUz/q5ttBqsvcuah7qX0MK/Xgjfcmy8hPDy8hih
 fXRvAtTOR8scHiSOwCLJtq6fxQWewf2o0t7Nbr96pDHQcfr2MwJPb6HudpnapnDN6OMa
 EDuI0M7bZDtcEe4tf3Txr/EiRAH/1UsyLBnBoec3APyxeuyu4Onjh9PuNx6jicvbZOgy
 5f5/Cagw0YgIwZ+BK803WNsVg/P0HH64ep+KDAHYmZrX6TrO4s2UUny+++ukZNErzAd/
 1SeIbciMuBOAbotNDv/3+MWy9RMPO8SKf9bTh6Xqgel+AsgmT+1TMEp/Vc9chnVKq0er
 1NTw==
X-Gm-Message-State: AOAM531eZd72sKUuJAY2k45Oj/kVt79A1mHNY4lQmsf7eO7ovRWlf6zL
 ivkiZfV0U30OIcNIWwGhOBU=
X-Google-Smtp-Source: ABdhPJym+vMqd6iwnr4LOe1QbzeKgsfM8RMzZvjWO1mt7guqxTu6K3LZTyO/2YtpSyRGzypACKxcbw==
X-Received: by 2002:a63:4c4b:: with SMTP id m11mr23409784pgl.20.1608710644608; 
 Wed, 23 Dec 2020 00:04:04 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
 by smtp.gmail.com with ESMTPSA id iq3sm21735654pjb.57.2020.12.23.00.04.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Dec 2020 00:04:04 -0800 (PST)
From: Yejune Deng <yejune.deng@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, nirmoy.das@amd.com, luben.tuikov@amd.com,
 Hawking.Zhang@amd.com, le.ma@amd.com, yejune.deng@gmail.com
Subject: [PATCH] drm/amdgpu: kref_put() may not require a lock.
Date: Wed, 23 Dec 2020 16:03:54 +0800
Message-Id: <1608710634-5118-1-git-send-email-yejune.deng@gmail.com>
X-Mailer: git-send-email 1.9.1
X-Mailman-Approved-At: Wed, 23 Dec 2020 08:14:06 +0000
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

kref_put() can be outside of mutex_lock(),and use amdgpu_ctx_put()
instead of kref_put().

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 0350205..af26ec2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -282,6 +282,15 @@ static void amdgpu_ctx_do_release(struct kref *ref)
 	amdgpu_ctx_fini(ref);
 }
 
+int amdgpu_ctx_put(struct amdgpu_ctx *ctx)
+{
+	if (ctx == NULL)
+		return -EINVAL;
+
+	kref_put(&ctx->refcount, amdgpu_ctx_do_release);
+	return 0;
+}
+
 static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
 {
 	struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
@@ -289,10 +298,9 @@ static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
 
 	mutex_lock(&mgr->lock);
 	ctx = idr_remove(&mgr->ctx_handles, id);
-	if (ctx)
-		kref_put(&ctx->refcount, amdgpu_ctx_do_release);
 	mutex_unlock(&mgr->lock);
-	return ctx ? 0 : -EINVAL;
+
+	return amdgpu_ctx_put(ctx);
 }
 
 static int amdgpu_ctx_query(struct amdgpu_device *adev,
@@ -439,15 +447,6 @@ struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id)
 	return ctx;
 }
 
-int amdgpu_ctx_put(struct amdgpu_ctx *ctx)
-{
-	if (ctx == NULL)
-		return -EINVAL;
-
-	kref_put(&ctx->refcount, amdgpu_ctx_do_release);
-	return 0;
-}
-
 void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
 			  struct drm_sched_entity *entity,
 			  struct dma_fence *fence, uint64_t *handle)
-- 
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
