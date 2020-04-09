Return-Path: <SRS0=3NI5=5Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1ADC2BA2B
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 01:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BDDF20787
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 01:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="NlMqSZt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDDF20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aurabindo.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 528A46EB32;
	Thu,  9 Apr 2020 01:42:46 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67AC86EB2D
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2020 01:28:21 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id g4so4742100qvo.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Apr 2020 18:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aurabindo.in; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a8mBf/x6tKmxXEyAN6VSKYHc9JSU+mIaA50Z6TnFau4=;
 b=NlMqSZt8QFI8sd/DDnRRiuydXjaYLzxItlei1QSWHbiyShTaKKSGURBOkhrkk91CxW
 /X+Qgb5kT/Tps0tzjntpYhBtxqSIyEiUAJrD28KSW+Ak6UERz5KiIAuFmidnFOXF3saq
 y5hxwSo82HWB2DKzD+N3OLxUlzmHRmC7x9lEqr/VOOaWRmBSLLr5JZ1o1m2bcGFp2N8K
 CMMceFTqTpBOdT8lUa6F6lNm7O38kfcGVYWCp2tJIxAZHD7mDG/r8vp2SL6SxRNJ0j6b
 ewLTd/FthX6hcv+JmkjXbKfzvZNfibmvWUqRC0qmB1IZrqJkjbZSCFgDsIDSquzFIxOR
 J1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a8mBf/x6tKmxXEyAN6VSKYHc9JSU+mIaA50Z6TnFau4=;
 b=qVw5HOd5Vwj3KJkZV4fJo00MODsjX1CSiDqOIhDOvt4pN7tq0caWUPU9yy8FFV419p
 iFahmilhRyYN70c1FbhqG2UhcFTvahhnr3W6b6Nfn2Un2MIEcDR59Ay17P0Rnme3iT08
 xcQDQQLVWJVuLYVsPULlpMfvGuICXe3HEKnlHkqs2LkC7Pdgl1tr14G9RZg+MrpPuPUa
 oYtpIN+a0Fzzyi9B2JdFhQDxk5aLrlpnzwTaua3bihaj3MiYwaYL/bfTPUJF/DCbdRUR
 2eoN/zBE864rcUQBNE77bSBEjOZy3P1tFK3NzpE6jufRBpnu8IvtY7oHzBmReyOEXgNm
 S5dA==
X-Gm-Message-State: AGi0PubmvRmSM5t7cKaj/T88vUo9KzKVNSfJt5mtrGhY1YgScP66LOGx
 m479DgLfRXWivLyARov4Unlsaw==
X-Google-Smtp-Source: APiQypLHyltpW2woM041SGTay/GRNOYCz+x3AjvXnaurPcRm5EFzWLaZMasX8iJ0rPqFFM0GH+KX3Q==
X-Received: by 2002:a0c:bd99:: with SMTP id n25mr10491345qvg.149.1586395700553; 
 Wed, 08 Apr 2020 18:28:20 -0700 (PDT)
Received: from localhost.localdomain (135-23-249-169.cpe.pppoe.ca.
 [135.23.249.169])
 by smtp.gmail.com with ESMTPSA id h13sm11710186qkj.21.2020.04.08.18.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2020 18:28:20 -0700 (PDT)
From: Aurabindo Pillai <mail@aurabindo.in>
To: christian.koenig@amd.com, alexander.deucher@amd.com, David1.Zhou@amd.com
Subject: [PATCH v2 1/3] drm/amd/amdgpu: add prefix for pr_* prints
Date: Wed,  8 Apr 2020 21:28:13 -0400
Message-Id: <20200409012815.22309-2-mail@aurabindo.in>
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

amdgpu uses lots of pr_* calls for printing error messages.
With this prefix, errors shall be more obvious to the end
use regarding its origin, and may help debugging.

Prefix format:

[xxx.xxxxx] amdgpu: ...

Signed-off-by: Aurabindo Pillai <mail@aurabindo.in>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index da3bcff61..67d654a89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -28,6 +28,12 @@
 #ifndef __AMDGPU_H__
 #define __AMDGPU_H__
 
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) "amdgpu: " fmt
+
 #include "amdgpu_ctx.h"
 
 #include <linux/atomic.h>
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
