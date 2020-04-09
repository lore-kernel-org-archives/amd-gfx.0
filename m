Return-Path: <SRS0=3NI5=5Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4212CC2BB1D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 01:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1913720787
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 01:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="gGAFmj/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1913720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aurabindo.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C36206EB34;
	Thu,  9 Apr 2020 01:42:46 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 426C06EB2F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2020 01:28:23 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id s18so4781899qvn.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Apr 2020 18:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aurabindo.in; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iAZ49xsLFafBw1eWwQbQgcyCMLWhUsSohaRadPz3t44=;
 b=gGAFmj/fpiuOrhiYazOd8ZJKb6FeO5AcwBXbcykszik2Cxb11C6INXDPGjZMgX/IFL
 +8D0QXaBjKOfXqrfiz6uxYMOaI+BTDldCTv+XLW5SH3eY3eJ9F4BdJAQvelqu8zm58RA
 kOFtmJcThBkMtMItCWkwgfjkzJVC141uKOV6IXm/dAyZ0eueS4wO3b437dyZRrVzdG6I
 601kOarVFZTFtZOMcPJkE9U7ugiUoPFoXsFT+CLNnzBlQ5DKbHJQpeHrHCMSO18ArPJ6
 5XSjo+2ShjDn/GNQK7IhGamQxv+BtZuN4R9pV98ffL7O6gPAENUwTiasoXfWUWVkjRf1
 j2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iAZ49xsLFafBw1eWwQbQgcyCMLWhUsSohaRadPz3t44=;
 b=j3GB/DPrf5SfhNRq6mD4K4zynAQRm89DJc89h0p0b5u7G+PaT4coLj9thj0fZ+WUsZ
 yzcX5/p1GElCT1fB0OzgQqadhnpGFnLmrR6eFUB6tLGWvwiM5C6uIAjGWsoqSmE/Mkv5
 9mRVo+iZU1RsXcZwuiN0xJaahT+KdTw2CyHf3otgefR3dW2t5b582WjPAA+JOlF+mZpH
 UaVS4IA7YFeAxlMfIXQQODrciB/1PhAqnU0qGbieUPtoFZ0Uk2S9/DNSa7Kuv6DVbTaS
 opTSjrm8WYtjQ4upB/jpOzG3BXLD4agWl+jSfvVPwG08zFZ9wUwnKGpWtANMkz4xIaK6
 QuHQ==
X-Gm-Message-State: AGi0PubMdKv6Kph4Hf2O8xIBlhTk8AvPRkaUIjh6/1qJS5s6TqJMXpBD
 uXC0xi4TvkgrUaTpzSRtpM5Fzw==
X-Google-Smtp-Source: APiQypJc2DhYwtTtM+Ce7usYBK/yFp24XNfCDvHn8AqXL3/muK8IGYc5YthGfwGZy0C04JbdRiUWqQ==
X-Received: by 2002:a05:6214:9cb:: with SMTP id
 dp11mr9948057qvb.60.1586395702443; 
 Wed, 08 Apr 2020 18:28:22 -0700 (PDT)
Received: from localhost.localdomain (135-23-249-169.cpe.pppoe.ca.
 [135.23.249.169])
 by smtp.gmail.com with ESMTPSA id h13sm11710186qkj.21.2020.04.08.18.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2020 18:28:22 -0700 (PDT)
From: Aurabindo Pillai <mail@aurabindo.in>
To: christian.koenig@amd.com, alexander.deucher@amd.com, David1.Zhou@amd.com
Subject: [PATCH v2 2/3] drm/amd/amdgpu: add print prefix for dev_* variants
Date: Wed,  8 Apr 2020 21:28:14 -0400
Message-Id: <20200409012815.22309-3-mail@aurabindo.in>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200409012815.22309-1-mail@aurabindo.in>
References: <20200409012815.22309-1-mail@aurabindo.in>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 09 Apr 2020 01:42:45 +0000
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
Cc: airlied@linux.ie, Felix.Kuehling@amd.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Define dev_fmt macro for informative print messages

Signed-off-by: Aurabindo Pillai <mail@aurabindo.in>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 67d654a89..7a52d37e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -34,6 +34,12 @@
 
 #define pr_fmt(fmt) "amdgpu: " fmt
 
+#ifdef dev_fmt
+#undef dev_fmt
+#endif
+
+#define dev_fmt(fmt) "amdgpu: " fmt
+
 #include "amdgpu_ctx.h"
 
 #include <linux/atomic.h>
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
