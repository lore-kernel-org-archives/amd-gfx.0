Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21AFC61DD9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 11:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E055310F35F;
	Fri, 28 Aug 2026 11:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j+RB6Oan";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4809D10F347
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 11:41:24 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c2055573c8cso95418866b.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787917283; x=1788522083; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bNciFzyL3WqwQiZP2uT8bmr93YVYPTusqhVzLnsGVt0=;
 b=j+RB6Oan8nxc79Zfc3M/IVOFuQGV8lNt1bxH7I2SjdlcfixWPUAiBtlLaoGJh6tBp6
 UpSQtYfMh489yT1Zsgjyh4VO1oUwkHihL1aSVSFly7ls5EgxxSjF+1D1h6GJyVWz5oO2
 d6v1ZYS8+nNbJBQJC/ikFBzljcxKLnWomkHtfPYaRmIvFzfJGlIXawlHyFgFnfJ01NhM
 dG2/IyZEHr6SXFt0zrGgDHCQdI7oikDUGJNSH5gi2jNB74T7sh771VWWcp1BmSrIe0jq
 FUYHMIuTtNVXYhJZP2cN4FRPAWK94YHjxMeUC7scr/yUKxlBUpUdCwLKn1JcxULginHN
 3IBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787917283; x=1788522083;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bNciFzyL3WqwQiZP2uT8bmr93YVYPTusqhVzLnsGVt0=;
 b=CSrxMQWZHouUbWKDuKrECXiPbe/JZAJSL0IEG/or6JUl8ZSTIOChXYgFA/173jwQ7y
 1536smNdDUM4IK++UtiuE2+IHcOTugDC17Akry9Scf7S7Ot6VAXChZ2DOeHdeikjeXvR
 hGogIh6+GJeFgYo6ylbT8NXxq4V0+RvEO/6EmHAxJloVrs2x/WnwE5iylSCOGxYsjVFc
 5aIJqvvjs6ig0fZaOrr+ODlwSCZBW0QqTJGGqXiH2C8MhqzcalPi/CmwAkqFlJF5IWJP
 BPr5Wq2x+h08FmHMhlB68gjtVrbwGhRAwI8mB/R9O5a/u/N9FROy0TBvQFZaYzbVG8cu
 sdNA==
X-Gm-Message-State: AFuF++k3hKPDlGAVNBn/EyYCv724Q1FksxzCXmrQKk9TifN3osjRwKkk
 vuw/CGBB3X3Ai+6uwY//6MgK0FLTNxd0HYCRZGUoAycOrk89Up/fu0ak5I3rKakn
X-Gm-Gg: AR+sD10pjES3W/L3CaBrHps3ivbyachCIP2EKuAHwFGTGyeJVzEQ0XGaljxrOBQJkrM
 biMRUCFsrVzZ+X03O/CeT0wWSB3b+LD4J9c+/NRKIY5eaEaDBvdrZH5XDM0zPwtq7kYm1cinMsF
 NG/J5sr8STnq8KcIqENmT5JkmyE8sNyMF3VDkwOFS1coxVQ6k2nFGX7u++uPYnT+ayrPV1oEELq
 9OPygz6+6lbVUBuiuYk97GNlp9JhzQ0G0/8HreqG7qKsXD0OM40dBDa2/XUD0yjO27kkLOlnx3I
 Ouubn0kmpw4rhUEPaIKsYvwiQhBNJ89IVFLZ4+QEb01b4TBDQXW6ZNfXd9bELsVneBGLBq7vOCy
 RBOtWKYW8nhOCRTPqsPhd1+NREf/d05Nbseo7vV3uwAN4EHEP5h/oh8pScNEOv0q7TRGyr0vMQs
 6UFfbXlEcqURZn8Vi0TLpsvvdTJuXGAvQJnCl/uWPRwTTpIir4/vtssv6o4zHbjavdURxVMbuOA
 IciJTJNiuvYI3spvNsr7OYu
X-Received: by 2002:a17:906:7306:b0:c1f:1520:4de5 with SMTP id
 a640c23a62f3a-c2556be194dmr450815266b.1.1787917282578; 
 Fri, 28 Aug 2026 04:41:22 -0700 (PDT)
Received: from Timur-Hyperion (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee288a4sm72549566b.16.2026.08.28.04.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:41:22 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 04/11] drm/amdgpu/ih6.1: Use IH_SW_RING_SIZE for soft IH ring
 instead of PAGE_SIZE
Date: Fri, 28 Aug 2026 13:41:06 +0200
Message-ID: <20260828114113.13523-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828114113.13523-1-timur.kristof@gmail.com>
References: <20260828114113.13523-1-timur.kristof@gmail.com>
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

When there are a lot of retry faults happening, the soft IH ring
can fill up really quickly and possibly overflow. PAGE_SIZE was
too small, use IH_SW_RING_SIZE to match what other GPU generations
are doing.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index 6bbf89d048e7..0fc348010ac7 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -590,7 +590,7 @@ static int ih_v6_1_sw_init(struct amdgpu_ip_block *ip_block)
 	/* initialize ih control register offset */
 	ih_v6_1_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
 	if (r)
 		return r;
 
-- 
2.55.0

