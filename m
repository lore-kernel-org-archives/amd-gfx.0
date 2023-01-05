Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C044C3DA7D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 11:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D120F10E033;
	Thu,  5 Jan 2023 11:17:08 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE8FD10E033
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 11:17:06 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id kw15so89167160ejc.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Jan 2023 03:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=10hZMgeJ40hU2yLyk0Z+sXG8BgZPgumeuQXveBLp884=;
 b=G9DH15suJ34rnr/uaZ022xUoxChPTym13hqJbLT2poj7wlPvtSxh0qiaQ5Ep4T8TSz
 kWTyXCkublqORqfhXRWackOSRpBGpwiorBDU29oAWnD9nLnpFXd51M9hPwtnNPGChPyi
 uLZk/vDdkje82TW1vemCC66MzfKPjwBNzbNtH7PmK+f85ofbcmF+6dEJ2IkhjIGH6sPn
 gjaTA+FKxaXeTaKdxexPUNgj8n6q5OdzUjPh2VTL5zXhpJGhX/9hZ22TYQWhZt1i1DIV
 S7mTat4g9lTOQyEmVm5xpRVycsV8VHEx3Amr661nUE+DkgGnp5kOzuII/oAMItk2bI5j
 U5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=10hZMgeJ40hU2yLyk0Z+sXG8BgZPgumeuQXveBLp884=;
 b=zXmfyHSpc+L3G1r9KpkAuhVjHvZGlemea5YZUkTuQAfy5ngjqlYRJHOjD6ICkzGlkt
 Pk8z1ThiHm8qGyqrOWVFWOpXwlMuDf5J6h5E+lnMlmA1nEYW+G2IDs6qlGBt+OMU/rX9
 Knf9PT0071JEYR6Tw4PhB649eLItkLrxx+AEaRBjH5+s2IDjf6yMikduYLVZFj4iaUc7
 ctyzon6TyY3Mw6Kq6H5Xta4aHzBArLiQnrCqmrSG5RE1lCONbzj3st1M88Jw9Y9JTEcy
 YSfknckiHTzucvUMsHwJ1YXz06alu2hKVAE+rsuagiNY+NjJVLffHjzxCBiNc5+XwEca
 kbrw==
X-Gm-Message-State: AFqh2koaqZnCuk2fA6TPmOnkCCtH+7VDVJScmXDqIZqtg/W+LDgygEGD
 4CA+OdinB8Qast91do+iPSn1hb85slA=
X-Google-Smtp-Source: AMrXdXtXitpjAlZisDU4mX8+ELbs9QSByI8MCJrAmpNWY4MdcsBl/++ZtZgTMSMkjm3r7Y2LstEV3Q==
X-Received: by 2002:a17:906:c18d:b0:843:770e:777f with SMTP id
 g13-20020a170906c18d00b00843770e777fmr42930369ejz.24.1672917425434; 
 Thu, 05 Jan 2023 03:17:05 -0800 (PST)
Received: from able.fritz.box (p5b0ea2e7.dip0.t-ipconnect.de. [91.14.162.231])
 by smtp.gmail.com with ESMTPSA id
 ta13-20020a1709078c0d00b0077a201f6d1esm16328289ejc.87.2023.01.05.03.17.04
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jan 2023 03:17:04 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: fix another missing fence reference in the CS
 code
Date: Thu,  5 Jan 2023 12:17:02 +0100
Message-Id: <20230105111703.52695-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drm_sched_job_add_dependency() consumes the references of the gang
members. Only triggered by mesh shaders.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 1728baa7e4e6 ("drm/amdgpu: use scheduler dependencies for CS")
Tested-by: Mike Lothian <mike@fireburn.co.uk>
Tested-by: Bert Karwatzki <spasswolf@web.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 8516c814bc9b..47763ac0d14a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1254,9 +1254,12 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 			continue;
 
 		fence = &p->jobs[i]->base.s_fence->scheduled;
+		dma_fence_get(fence);
 		r = drm_sched_job_add_dependency(&leader->base, fence);
-		if (r)
+		if (r) {
+			dma_fence_put(fence);
 			goto error_cleanup;
+		}
 	}
 
 	if (p->gang_size > 1) {
-- 
2.34.1

