Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CD5C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81F92074B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNEsCock"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81F92074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 495966E5B0;
	Mon,  1 Jun 2020 18:29:47 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 935EA6E5B0
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:29:45 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id g28so9304429qkl.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k4co2XU2C4ot9YhPC5w/raztWtieugZUn55HdMQWkOI=;
 b=NNEsCockZkzfGXCoaduAWyWIiwr7H4lImrzabC23BEghEdzHBp59mtIhFduk+IZiFt
 tdOaFUklfN5/nZAJ1h7otvKlSzEUJC0luMUK7l1xbo/LMKhxu6uuYOe8uzAbPAj01tly
 njeHSTG5DDO+NX60z1HpXZ+sOL85+5FZ23F5bD4UqTSVOL6nuQTQ8pU25cCGQ6SbtlMK
 NLfcp+0zWnvaRSll8n2OUZ94oUYCa1B/HJDbujmZZoEfWOHgqYg0xQKV6IWToTuHlMW4
 1cYiUQLHXklDetG4DqWp6UUx/30h0P+EF/mDktIPx3+UOQdZccZloLKCaEJEEiF+eA9M
 aZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k4co2XU2C4ot9YhPC5w/raztWtieugZUn55HdMQWkOI=;
 b=M0VjWfmb2vOXq0Q2WNHuqjZcA2rldEok64MXrw3wYMHcxyZr3Lx8RAdDx030YxOcg6
 lLNLIn7ZX9M3T02M7wADq2tHNQz0xHRMLpONNuRVZMYupgS/CdRKFtnZvdE/UBZ6Y83G
 YPrU5o/gt5CzH2nmJ+Rp2PEi6Gjsm//G36fmXZLmpbhEbpc1rbSr5lrcAilK7NfZdRrx
 uROCeJOac+eJ3mSOFpLd1bZgeyEpYpUYFUqPQn2+xDrCgp93ZTz6/2kkVtyl7MAiRy76
 NIs2DNaBGBnk49YXJ8isYVF/L1dRMrVqhoygeJGbE7WX3ksI7YdtLC1A+UI2lma/mUCm
 ohuQ==
X-Gm-Message-State: AOAM532NccKx436So2PbvLkZLUS8e/d4fN2vhkspXdrN7EzFy4ma3sG9
 h0NZ9AdkJL/m5AwifIqcXHlkCHZr
X-Google-Smtp-Source: ABdhPJzIckvSjOcE0kLQo1c7Y0MQLArfs6QH8LLZ/O0DWP+I3kDJ50qdlp8VbWiZqUSEw1kNuAiqzQ==
X-Received: by 2002:a37:e302:: with SMTP id y2mr20059602qki.405.1591036184487; 
 Mon, 01 Jun 2020 11:29:44 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id z194sm8592qkb.73.2020.06.01.11.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:29:43 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 184/207] drm/amd/display: Add DCN3 OPP header
Date: Mon,  1 Jun 2020 14:29:03 -0400
Message-Id: <20200601182926.1267958-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182926.1267958-1-alexander.deucher@amd.com>
References: <20200601182926.1267958-1-alexander.deucher@amd.com>
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Add support to program the DCN3 OPP (Output Plane Processing)

HW Blocks:

    +-------+
    |  OPP  |
    +-------+
        |
        v
    +--------+
    |  OPTC  |
    +--------+
        |
        v
    +--------+       +--------+
    |  DIO   |       |  DCCG  |
    +--------+       +--------+

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_opp.h  | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_opp.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_opp.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_opp.h
new file mode 100644
index 000000000000..78f7cf772bbc
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_opp.h
@@ -0,0 +1,36 @@
+/* Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DC_OPP_DCN30_H__
+#define __DC_OPP_DCN30_H__
+
+#include "dcn20/dcn20_opp.h"
+
+
+#define OPP_REG_LIST_DCN30(id) \
+	OPP_REG_LIST_DCN10(id), \
+	OPP_DPG_REG_LIST(id), \
+	SRI(FMT_422_CONTROL, FMT, id)
+
+#endif
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
