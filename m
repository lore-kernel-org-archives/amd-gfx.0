Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDF6C4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 471042399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxn7vHg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471042399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C44E6ED13;
	Fri, 25 Sep 2020 20:11:08 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17ADB6ED4A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:07 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id cv8so2019949qvb.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2Odi8lVc+ucXInzKoRR5Q+KkJrsXbIjk3O/I3DT4GcM=;
 b=jxn7vHg1U1yyJkipYEfS5MS89f6GiuFcmLhX9kWXHHJn/CcTX8blSqkp+zjfbCGeva
 7Am1y6H1FaYZK6iwISWpyMxFh3rdygh85xdnEku8niBakqHrIRDXG7mytH28F36LmbEn
 QV8S/srMzphmGu6lmnXFVeNxqGrO+AGB9YAnNqYKYcmpmm27cj4GXUqKj5iLamBQMSWx
 piUnJyWXcpzFDQJlywv8GNvqhJqWu7Y2KPi3JPLC/7ZwlVT1eMnlKLOvaMQxSW+Q2nQT
 gLn3Id7NfiEjBC8O8OepjJlK6fG91YnhWYQ8znubb9QlhxGCt5nok1pCsJf60Iubecv/
 4fMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2Odi8lVc+ucXInzKoRR5Q+KkJrsXbIjk3O/I3DT4GcM=;
 b=gXpOv/tU+nt/TAUpKu/zuZzHQKg7hWHCc9En7B9KnUd54WWxBx+kazgsVs0dKX+5q5
 Nmshks5H2+QdIVW6CCnolKJ6XTiEDfonDz47+kEnFkxo51W7lAkQCKY1nieXhoIh4Zxc
 sE4bYmHCknobdaBEyJCDEXH/AiVkuiRfcpipUUkaNwZO32ODWjO114CSYu8FrU+cgwz9
 kcv3EtGJfMrFXZdS7OpkEMtSSTlo7x1FztUsineVZkAklY0qOqDkN9CW0lFldV1FyBzt
 P9FbjBzz0Vne6JkDZx/5YJsthjxvb9j1NyOfoI3t1IezGXxnnjQvK2J5gV0aZwUduV11
 tfoQ==
X-Gm-Message-State: AOAM531idGylwwOrGX7LSe48KQQ2+NnPi6FVJx8oGqxybULJgwPngkhg
 U7ySnf40r7LUVQp3PS4QAsFLlMwE2p4=
X-Google-Smtp-Source: ABdhPJzDQT05SKiq9rH8N6cb91L7WCnClSJ3Nbzv1UW95fNkmuiRrfgfCIBZjO07kJgp2lqr18W3Fg==
X-Received: by 2002:ad4:5387:: with SMTP id i7mr314867qvv.43.1601064666064;
 Fri, 25 Sep 2020 13:11:06 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:05 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/45] drm/amdgpu: skip sdma1 in nv_allowed_read_registers
 list for van gogh (v2)
Date: Fri, 25 Sep 2020 16:09:51 -0400
Message-Id: <20200925201029.1738724-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Van gogh only has one sdma.

v2: use num_instances rather than APU flag

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2077f897d6eb..8616d397da00 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -289,7 +289,8 @@ static int nv_read_register(struct amdgpu_device *adev, u32 se_num,
 	*value = 0;
 	for (i = 0; i < ARRAY_SIZE(nv_allowed_read_registers); i++) {
 		en = &nv_allowed_read_registers[i];
-		if (reg_offset !=
+		if ((i == 7 && (adev->sdma.num_instances == 1)) || /* some asics don't have SDMA1 */
+		    reg_offset !=
 		    (adev->reg_offset[en->hwip][en->inst][en->seg] + en->reg_offset))
 			continue;
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
