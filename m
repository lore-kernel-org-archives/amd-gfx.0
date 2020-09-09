Return-Path: <SRS0=5+Vp=CS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39152C43461
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 07:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A741721741
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 07:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZWg2yvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A741721741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0CC66E9F1;
	Wed,  9 Sep 2020 07:05:20 +0000 (UTC)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE696E970;
 Wed,  9 Sep 2020 05:29:21 +0000 (UTC)
Received: by mail-pg1-x541.google.com with SMTP id j34so1228462pgi.7;
 Tue, 08 Sep 2020 22:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IhJZzsST3gRwdDdOyZSCwbfCQK/u9uNH5w2yjyQDKJM=;
 b=uZWg2yvBmywVfO4I5BDBCJw5AfEMqL1A+McWPALyquTIhyk2CJ1uYwk7gZJBtTNgqW
 4FuoCoQ/oHxlFAZfrUQRdoPxBtGnK1q68Ki5wXNXu/JtLHryCGinviZtLc37UvxUOxTR
 0dSv6j+L9MkGkBQ2wn/tZAF0ElerAtwoStgI09SOw/ZYoDl6yT/SCXY8XxN7n8uR7J+h
 qndq0F+QU7VB6Z7DTbI4ybY37rTWXOZ5AjQf+qAmuQQBVrza+322CS/hr07w7cf5X12s
 gXCeyINPploxN0mzPWT6BqUn89kTrL/Qh01Pp1RK9WeLeYrtwY9DLBzanIlrzQjUUw0t
 IMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=IhJZzsST3gRwdDdOyZSCwbfCQK/u9uNH5w2yjyQDKJM=;
 b=joHpsGHInu4x7uBQK3MUPJCyGm5hxSY6rTYq3ZyvVhX6UR46vi3Hr8eC771SU8H0N1
 pp0B4IVy6hNqFhjEGRyDaqZ+qqarTxbOBsvWY1KadpHi+MkmKKPVCX/koTK0PYwvymZe
 eAbkrP6FDQ7pwdkU26aV3ugVSm6MiOYzbj7fTwUj5T9S7xhGFwvcLYqQGmF/MZco8vbz
 kntplkd+RX718/rBPmzqXQLuZMD7+aCepZVcTrvkHjeo1fU9Nith6Mku6N90TOvWKLl0
 Iui8yz66ufix0c9xM/6JN0slTJ4tZ5Q+NslHb9Y2Y0PBkvIz8l55kT2yirXF2A0YJzzs
 gNcA==
X-Gm-Message-State: AOAM533CZ4B0dWl8E1Nj0DUrf6dPp3dlVtC9c4v7Qr3G+z1iMnrcBwmA
 UmirG+ZIpfQiucWJU/PUtqA=
X-Google-Smtp-Source: ABdhPJxvDXIhW8TYQZjk8ZGxA8N6i1u7r9Owl06QIWUsh9Kn/KTszz9p4awVXKktuiJfp71iZlIC1A==
X-Received: by 2002:a62:26c5:: with SMTP id m188mr2105865pfm.156.1599629360855; 
 Tue, 08 Sep 2020 22:29:20 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id mt8sm790024pjb.17.2020.09.08.22.29.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Sep 2020 22:29:20 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>
Subject: [PATCH 2/2] drm/amdgpu: Don't use WC for VRAM if
 !AMDGPU_GEM_CREATE_CPU_GTT_USWC
Date: Wed,  9 Sep 2020 13:29:11 +0800
Message-Id: <1599629351-17937-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1599629351-17937-1-git-send-email-chenhc@lemote.com>
References: <1599629351-17937-1-git-send-email-chenhc@lemote.com>
X-Mailman-Approved-At: Wed, 09 Sep 2020 07:05:18 +0000
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
Cc: Huacai Chen <chenhc@lemote.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Though AMDGPU_GEM_CREATE_CPU_GTT_USWC is initially used for GTT, but
this flag is bound to drm_arch_can_wc_memory(), and if arch doesn't
support WC, then VRAM should not use WC.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 5ac7b55..04299f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -136,8 +136,10 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 
 		places[c].fpfn = 0;
 		places[c].lpfn = 0;
-		places[c].flags = TTM_PL_FLAG_WC | TTM_PL_FLAG_UNCACHED |
-			TTM_PL_FLAG_VRAM;
+		places[c].flags = TTM_PL_FLAG_UNCACHED | TTM_PL_FLAG_VRAM;
+
+		if (flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC)
+			places[c].flags |= TTM_PL_FLAG_WC;
 
 		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
 			places[c].lpfn = visible_pfn;
-- 
2.7.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
