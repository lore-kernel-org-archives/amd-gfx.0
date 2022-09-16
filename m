Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF92C54EE9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 09:09:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D23A110ED06;
	Fri, 16 Sep 2022 09:09:06 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7F0C10ECF8
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 09:08:53 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id c11so34960276wrp.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 02:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=GMIWrhVlEcU8pjfwEh51A5FgI/x2o9JZD6yol26VGKI=;
 b=N7e+shiI4pAwdtJw0S/Ec/8MZ4Zrx4GeIIa7XCbpn9aux3w8GTNQHoWcj6YuUKbcs3
 BtMkgVZiiKYRIlviQaB3UbbzvWJqBNAPyWXsII/Xg416fSSRHqJcJbKRl2GSk/om5oJq
 fPxMaPpIkabmj6sSDDdgY+TBlgN2k8EJMc2Hf6qocLVzycAFQYlgKOLPkek9bWrLAD4L
 DPWn088CcfdmGNTYHTbtySCrFEzPErJ5dmwP3p21RF9RrtQXuzdvSh+Plezh0vfCCWrq
 8bIaGE0eP8pSmyV5UAGMdz59EGG7o1RsezO6QVEkdVSq4os49Q9ELXZnGgBVfBwizIAY
 1j4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=GMIWrhVlEcU8pjfwEh51A5FgI/x2o9JZD6yol26VGKI=;
 b=OowcHmbmpXvjFU3auc6E7E7Tbwrmuo7kpreOOSQ0oOtC230b4ynTN1A8ouDAA36qI9
 57hl8OzIIAWtMsNZW/jTIbKw/reHkH3LHKQYuwgw/1LafUQk77x1YpzZzQUjE3T0tYyk
 qSGyLLPYtZ49KKwC1pKexx1vEieut4KKl+l+et0DUN9G2yf2Y21plV3NOWhguWThA/U+
 0Ko2ynx6N6yikiAmKAxWuk/i0cgYJcju9gBBnAe9jOW2oH0gftfkQCAfij3uGEoz07k7
 XVqQrfwJdE9kh4+V9zlzPlgMwKGfioYLkNRL/LlcYHe0wQ1uDVZfSF2KZfErk0mZiitB
 KlzQ==
X-Gm-Message-State: ACrzQf3EN+4gwqDg4PsG5HBA9Dc3fChfVC5DUsQqUJSdzWx9IwDZ2IES
 UCs7WY/0Zq0lWn2agzxbxapVnLtiirDmtA==
X-Google-Smtp-Source: AMsMyM6mbL+Iv8DHjhXZA4X+Lve/B6yiBLryITI4qayGO10lbNK/Iw3NLs5Nb/xLANn9XJRGHijd/Q==
X-Received: by 2002:a05:6000:1548:b0:22a:c113:c9d0 with SMTP id
 8-20020a056000154800b0022ac113c9d0mr2263071wry.653.1663319331954; 
 Fri, 16 Sep 2022 02:08:51 -0700 (PDT)
Received: from able.fritz.box (p4fc20ebf.dip0.t-ipconnect.de. [79.194.14.191])
 by smtp.gmail.com with ESMTPSA id
 b12-20020adff24c000000b00226d1711276sm4604145wrp.1.2022.09.16.02.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Sep 2022 02:08:51 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Subject: [PATCH 3/8] drm/amdgpu: fix user fence CS check
Date: Fri, 16 Sep 2022 11:08:40 +0200
Message-Id: <20220916090845.3336-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916090845.3336-1-christian.koenig@amd.com>
References: <20220916090845.3336-1-christian.koenig@amd.com>
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
Cc: bas@basnieuwenhuizen.nl,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

An offset of zero is valid, check if the BO is present or not.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 5c37dde97ff2..265ed2118a80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -313,7 +313,7 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 
 	ring = to_amdgpu_ring(entity->rq->sched);
 	/* MM engine doesn't support user fences */
-	if (p->job->uf_addr && ring->funcs->no_user_fence)
+	if (p->uf_entry.tv.bo && ring->funcs->no_user_fence)
 		return -EINVAL;
 
 	if (chunk_ib->ip_type == AMDGPU_HW_IP_GFX &&
-- 
2.25.1

