Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFD0C2D0EA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 13:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5150A2074F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 13:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="oNGBRMTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5150A2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aurabindo.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 110586EA66;
	Wed,  8 Apr 2020 13:42:14 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F41E16EA65
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2020 13:37:40 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id y3so38629qky.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Apr 2020 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aurabindo.in; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a8mBf/x6tKmxXEyAN6VSKYHc9JSU+mIaA50Z6TnFau4=;
 b=oNGBRMTTT4G0ujvkoAxRMd3XDpqMEs3ISjiGTl3+WMr3y0jNbTYWFZVr6oSkfSctjo
 820mOtbknzXiP1a+VHzTLSrRoFPDtBkZyrvm3Y3KHV/5L1o66DFPQqYtjEqM7Q2tmeN2
 bZYbGMP/wDNJ20bM9UVlVtK9xYk0ZDHBaRHDUwPMUyRhgJFh220KAzu6Ob9GFKhlQauB
 xWQdo4bNV/1iV8qJjw+cDLSSoaWUxzOP+3oFmut9SJFXCDdi73L1QXjveEoi4S959mUF
 MlfOIVkuGAoI/PZErdQEivO3GhuWEOt1ALkBlCc746rf7CeiGoO3crXm+N6ddXc4vbo8
 YTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a8mBf/x6tKmxXEyAN6VSKYHc9JSU+mIaA50Z6TnFau4=;
 b=Ir7i8Aj2OV9RRf3EmbNVBB7a5U5SZTQq9b1HRRVUWZvqbcHnsPmcqxuZPaPZokPPk8
 RFiya1Shvz84Teh2Ddnv6qoJJm4e97BOdPTQXGt2SE1kD5lCkMKqlHmL3xqJks4/Ictm
 xBYYoIXS+1EVMKYaG648tA1giruLg2p//ML/Q5NX/MAUu0GvBeDS6pA5WXhijaIc6DYh
 59FiCiOrxVopY6wd8fjZEfksYuTsZ1RnsGzfLjlLIhhuMD03ZpY/D7w3XwXOK9/s+dgx
 g4higmRYCWI/HlrK9nBpswmvfO8s3L+2BCyTL6KNpiK0CKdnfidHM4VZ+qM0W+sPRVEv
 vstA==
X-Gm-Message-State: AGi0PubTOnHIvx0v2IgpL9caE7ASor3Bf3e+7YvO5LCttZimcpRZsBci
 4AqEys9HNMzfrAlSOLyZ6og82Q==
X-Google-Smtp-Source: APiQypLRBp+bZkFj4khOGASSTYhMEobSFxchIEOA/aHpRrEQBTYsVV97VRsDR3YR4b6DeyK0CmNFZA==
X-Received: by 2002:a37:9e17:: with SMTP id h23mr7319606qke.315.1586353060016; 
 Wed, 08 Apr 2020 06:37:40 -0700 (PDT)
Received: from localhost.localdomain (135-23-249-169.cpe.pppoe.ca.
 [135.23.249.169])
 by smtp.gmail.com with ESMTPSA id q5sm8493827qkn.59.2020.04.08.06.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2020 06:37:38 -0700 (PDT)
From: Aurabindo Pillai <mail@aurabindo.in>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Subject: [PATCH] drm/amd/amdgpu: add prefix for pr_* prints
Date: Wed,  8 Apr 2020 09:37:35 -0400
Message-Id: <20200408133735.7679-1-mail@aurabindo.in>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 08 Apr 2020 13:42:13 +0000
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
Cc: airlied@linux.ie, avid1.Zhou@amd.com, linux-kernel@vger.kernel.org,
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
