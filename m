Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A782BC34056
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 19:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D7C4206F4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 19:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nafeTVWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7C4206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CBCF6EC89;
	Wed, 19 Feb 2020 19:20:01 +0000 (UTC)
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFDFF6EC87
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 19:19:59 +0000 (UTC)
Received: by mail-il1-x142.google.com with SMTP id s85so21547754ill.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 11:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jiBMSy1zITe5BvcaCXukNMpQl0WE0ztEvH2rD6tVL2g=;
 b=nafeTVWBHXfew/5JJc7zC2sXq16eQYkLhJfDHHoXKpM0k/INc0d/Oy3VsFImeX9Vq9
 AYsHp7UArsfxnbchvIT0FPxUobx4nM2Nvse/8uig9fxeDphIyQyqad+XVfc3wl8aWRit
 GoteDKgGbmJwqrkQsL0rweovk5XcaygE2KDiKAmevZV4Vk7DgBdO83IYRS8J4kC7U+C9
 lfvN2CTK6Q/3i0kB26SIBCOc1uAVI+iFSQY3hRo16N0bMQCUX60Ce3XgtVog1CqZnBE5
 NdCBGnIPlp+BGnGOo254pKX7jc6Ks7D90zTjZvrS9IlLZ6rD3guwOZjVmbTy57HVuaOF
 rI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jiBMSy1zITe5BvcaCXukNMpQl0WE0ztEvH2rD6tVL2g=;
 b=dZcOWBtO31tIlpncCeQhbRniF9ISP6ksciwFFgMHJ1G5PbiZNJc/s4kxQrtAn+jMGw
 qDxXO0PHVH7aHUJ9UyxLxthwUzcy6SunvRd1oHLdAsj4PTENOmgDJkbQrzEIQaqGxebq
 J3dAe6TcJxMXgRKO/3Gfynqc7kaEEeS+3DUVLrniw2QntNjyIsw0s9/MWjcDkkytLS9U
 gWw/mu+Q9N3KtiBRvugj3fQ7NS3IFD7OXJ16a4MCG6n1LM7oxadcA9w4w1p5uI5wkvuT
 ZSl9efcebrsSvKdyzStgUzFScr1hz/lGiRoltNLtPoNQaMnZ6Rl5EFGDOCIa6y6SM6C3
 XFcg==
X-Gm-Message-State: APjAAAUqOHwJc0npyZ4xymnBITYfiLgjprSYtQHMjXrlra6GzthhRWfM
 zTpWKhImIud5pYPqywpduc0=
X-Google-Smtp-Source: APXvYqwwQ/KcQYtgdzCSJOrBw01ntuOJ3w5K7jlEy3Lq+JESI+E1S3uIWCHcoszNEtQfZGBeaFfGIQ==
X-Received: by 2002:a92:9857:: with SMTP id l84mr26142390ili.109.1582139999137; 
 Wed, 19 Feb 2020 11:19:59 -0800 (PST)
Received: from mcoffin-dev-tower.ec2.internal
 ([2602:ae:10d1:b00:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id h19sm245706ild.76.2020.02.19.11.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 11:19:58 -0800 (PST)
From: Matt Coffin <mcoffin13@gmail.com>
To: alexdeucher@gmail.com
Subject: [PATCH 2/2] drm/amdgpu/smu: Add message sending lock
Date: Wed, 19 Feb 2020 12:19:41 -0700
Message-Id: <20200219191941.67724-3-mcoffin13@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <5d301d58-49c7-6c3c-0652-6e051514d1ff@amd.com>
References: <5d301d58-49c7-6c3c-0652-6e051514d1ff@amd.com>
MIME-Version: 1.0
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
Cc: Matt Coffin <mcoffin13@gmail.com>, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This adds a message lock to the smu_send_smc_msg* implementations to
protect against concurrent access to the mmu registers used to
communicate with the SMU
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 220bf0b10971..19bebba3e0a4 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -102,11 +102,12 @@ smu_v11_0_send_msg_with_param(struct smu_context *smu,
 	if (index < 0)
 		return index;
 
+	mutex_lock(&smu->message_lock);
 	ret = smu_v11_0_wait_for_response(smu);
 	if (ret) {
 		pr_err("Msg issuing pre-check failed and "
 		       "SMU may be not in the right state!\n");
-		return ret;
+		goto out;
 	}
 
 	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
@@ -119,18 +120,19 @@ smu_v11_0_send_msg_with_param(struct smu_context *smu,
 	if (ret) {
 		pr_err("failed send message: %10s (%d) \tparam: 0x%08x response %#x\n",
 		       smu_get_message_name(smu, msg), index, param, ret);
-		return ret;
+		goto out;
 	}
 	if (read_arg) {
 		ret = smu_v11_0_read_arg(smu, read_arg);
 		if (ret) {
 			pr_err("failed to read message arg: %10s (%d) \tparam: 0x%08x response %#x\n",
 			       smu_get_message_name(smu, msg), index, param, ret);
-			return ret;
+			goto out;
 		}
 	}
-
-	return 0;
+out:
+	mutex_unlock(&smu->message_lock);
+	return ret;
 }
 
 int smu_v11_0_init_microcode(struct smu_context *smu)
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
