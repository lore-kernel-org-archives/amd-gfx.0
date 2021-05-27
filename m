Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153F8C47089
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 23:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D326161176
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 23:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D326161176
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A5CF6F4F0;
	Thu, 27 May 2021 23:10:28 +0000 (UTC)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 921096F4F0;
 Thu, 27 May 2021 23:10:27 +0000 (UTC)
Received: by mail-io1-xd30.google.com with SMTP id b81so2283032iof.2;
 Thu, 27 May 2021 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Nfy2IfPBB1SzRRj1M8FEyKWIiZqz+B359r93DqSZMBU=;
 b=EIxTA24bC6jvrwGt7a6INUPZdEOCMUS/1wV3tWyvWq7RG8odSBOoO6bRwkqtNUdWkX
 imZoSeaVdxkqMuqGRxZalIEm0dSVhabr+IeAIyu3ZpQ6zus++vi7+EAc+7CeRWpuOKm+
 kvlVhSxyRLH/GuxmK3Wh1mnfZGdDtshlwPG/ghWkxX8tsazVmTq9Mh4iYS8mF8Kukklk
 l0339XlDI0e6JLDK394lOtRN5gCMkKOqkh4p0ZlptgEYfF2IPy3w0or3HoTGZxh+8Sh0
 tW1bGrkTw3IDy6KROQzGYQPxxPRlLMc+ewwddj+Nk+XbhLtjHgr3IjdTW3CFnAy/3vHN
 CsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Nfy2IfPBB1SzRRj1M8FEyKWIiZqz+B359r93DqSZMBU=;
 b=HFUG0o1ZPPP/JIprVWAqx8SZrPnmgJzxepwy4BTzd260j/krZHNqs8tJmzo8BjK0RJ
 9p77iP6dEigw1FtxmhrWbe/Y1H34xXeF9ILliqMoQFcBfG4P/RK/oiVu88SqYPk6TlQ7
 i598IlWnfZtTcimdxExSg/69kPE5I7E20yiP00P9+cRjrZ9T2AhNcPwNvsakfEHqDUOE
 SL+0uPT/1N8v90UAMLwEpjUcLUJqj3QxB9yr3HCAOBf5zfUlsks6xvyS3HtTKx1oEGyd
 h10KR8uJZ2SVQEEQtHbppMZxHhJCSAcuSD5O7GvtDt08ZNVe3tjdD+sT3elmTPPVXlfX
 ybyQ==
X-Gm-Message-State: AOAM531SRpIFVzlNDsY/xufJmoJBDB7MhsjblSVcOwlCtsYupcLaR6Uw
 cxnlBDgtlD2f+NNLwHgGlZo=
X-Google-Smtp-Source: ABdhPJzzDrfBqzx1tvMKp22i200oopXJtvSuhCpPS4llgK9p8ZzFsOXk94lGGj2reSJ7a36ZyYRM1g==
X-Received: by 2002:a5e:c744:: with SMTP id g4mr4783689iop.26.1622157027022;
 Thu, 27 May 2021 16:10:27 -0700 (PDT)
Received: from Harpoon.amd.com ([165.204.55.251])
 by smtp.gmail.com with ESMTPSA id r5sm1860014ilb.1.2021.05.27.16.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 May 2021 16:10:04 -0700 (PDT)
From: Felix Kuehling <felix.kuehling@gmail.com>
X-Google-Original-From: Felix Kuehling <Felix.Kuehling@amd.com>
To: felix.kuehling@amd.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/5] include/linux/mm.h: helper to check zone device
 generic type
Date: Thu, 27 May 2021 19:08:07 -0400
Message-Id: <20210527230809.3701-4-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527230809.3701-1-Felix.Kuehling@amd.com>
References: <20210527230809.3701-1-Felix.Kuehling@amd.com>
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
Cc: Alex Sierra <alex.sierra@amd.com>, dri-devel@lists.freedesktop.org,
 jglisse@redhat.com, amd-gfx@lists.freedesktop.org, jgg@nvidia.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Sierra <alex.sierra@amd.com>

Helper to check if zone device page is generic type.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c9900aedc195..1af7b9b76948 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1158,6 +1158,13 @@ static inline bool is_device_private_page(const struct page *page)
 		page->pgmap->type == MEMORY_DEVICE_PRIVATE;
 }
 
+static inline bool is_device_generic_page(const struct page *page)
+{
+	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
+		is_zone_device_page(page) &&
+		page->pgmap->type == MEMORY_DEVICE_GENERIC;
+}
+
 static inline bool is_pci_p2pdma_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
