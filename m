Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6A2C433E7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 21:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55FC521D7F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 21:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnWVYiVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FC521D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A3406EB7A;
	Wed, 14 Oct 2020 21:25:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A19E06EB6F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 21:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602710298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=8K91tpPhSfeMTW8U/TmEjC3SOUcTAJmMSlYekWW/OxY=;
 b=MnWVYiVliCDKduQJB5hg5VWgR9of5NXdWKmStObM6eYWWaNJTVYeb4uHcGBUjArG+EwlXK
 LSwsURzT2fkdiqo4+F1GA8g1maUOkuvv/AI8V1GSmh6HQBNLPjibbcOdnVBFTXJcIYGjBA
 w4XXYJtJ7WKdso2mKJJDiflqbwPTZyo=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-R1SeSKw5OdeWJGNgRaT5bg-1; Wed, 14 Oct 2020 17:18:13 -0400
X-MC-Unique: R1SeSKw5OdeWJGNgRaT5bg-1
Received: by mail-oi1-f199.google.com with SMTP id e82so179104oia.15
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 14:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=8K91tpPhSfeMTW8U/TmEjC3SOUcTAJmMSlYekWW/OxY=;
 b=fkT/9xZtgVkYjY0evRZGghH2UrJWWwfKVDZPTtsLFRTYOFRCQnhnP0MoC91YKEXexb
 TPz17omZGPk5j+sxkSECnz17/us7by85Kiyp15GOBY8MSac81rqJe38b2VQS+VAWIWug
 CGS+8th1TUHApOgsOwwj6JZoh0uGW16c728L0ggfLtP8u+RG8tX2UZ3pbw65p70qoshk
 p6/YxzbEBreMBvswjGlrxRyjHa1HMOgKMwGTlZbK/pHLYlgoQbwujt+KCYKjUHdn2NvA
 5YadF3Y8tWzrclhr3oAqECF/S0/o++CJvUDLgjXLmDgFekmUUtC9zc4pUsJnjsvE8GV0
 VjFQ==
X-Gm-Message-State: AOAM532YLv5kktlvv77eg8R/V8Cng82RGB3QbKr/k+MsJJNy6KdDb1b9
 AFWUUKcvEWvTZt77T8ZP61j2RSqe8jDgxgHeeaed/83oCuitBf6mX4f+8nI8WyCBzNA82Uy79ex
 1MBTPFQLdPuS2GJ3OIxIhzqJ8Fg==
X-Received: by 2002:a05:6830:1301:: with SMTP id
 p1mr443983otq.241.1602710292781; 
 Wed, 14 Oct 2020 14:18:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9w+ALYnZxhun1GSiSOJtZIsFA++Kd8+X4Bet9rJd1T4rMk1BW+ckqvG/zmRHnTzML5VPvuA==
X-Received: by 2002:a05:6830:1301:: with SMTP id
 p1mr443961otq.241.1602710292532; 
 Wed, 14 Oct 2020 14:18:12 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id h15sm232082ots.31.2020.10.14.14.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 14:18:11 -0700 (PDT)
From: trix@redhat.com
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 tao.zhou1@amd.com, ray.huang@amd.com, guchun.chen@amd.com,
 sonny.jiang@amd.com, xiaojian.du@amd.com
Subject: [PATCH] drm/amdgpu: add missing newline at eof
Date: Wed, 14 Oct 2020 14:18:06 -0700
Message-Id: <20201014211806.16282-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Wed, 14 Oct 2020 21:25:24 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Rix <trix@redhat.com>

Representative checkpatch.pl warning

WARNING: adding a line without newline at end of file
 30: FILE: drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h:30:
+#endif

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h
index f26246a600c6..4089cfa081f5 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h
@@ -745,4 +745,4 @@
 #define RLC_EDC_CNT2__RLC_SPM_SE7_SCRATCH_RAM_SEC_COUNT_MASK                                                  0x30000000L
 #define RLC_EDC_CNT2__RLC_SPM_SE7_SCRATCH_RAM_DED_COUNT_MASK                                                  0xC0000000L
 
-#endif
\ No newline at end of file
+#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
index 29929b360db8..d8696e2274c4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
@@ -27,4 +27,4 @@
 
 extern void vangogh_set_ppt_funcs(struct smu_context *smu);
 
-#endif
\ No newline at end of file
+#endif
-- 
2.18.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
