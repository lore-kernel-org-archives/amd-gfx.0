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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2257DC4741F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B962323A31
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzLWg32+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B962323A31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 400346ED7C;
	Fri, 25 Sep 2020 20:11:43 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 946F66ED7B
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:41 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id cv8so2020818qvb.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pEMxI+SHzaiXEllIBUTUdPHIl/NuY6uK0nZoRQW7V8s=;
 b=lzLWg32+uLRJK9gu9yecOL2RxQw5hQxoJ7pCP416/ZgqQNpUx3Fp73/gVVreNYp2+Q
 x8mhaDhFqglNuHCQh048GCYN9YK5Ow+qkB9SrAYN4UfvwDABBV9uO72ZVeX6e5Jxpnd9
 2edk6yf9O0yTKlGaWufZ826FTN22vircHqkEd9AIrbFoC481bpzAp4I532gv+LeJ8lCl
 oyu6VEBmhLP6eLgUhRUBjz75eEPuahXeyR221BRIdqUQO40o0YLA5BJ9wQIkGwVEjPI4
 PgCL0wm9upSc9bHoUSrGT7N1sKsct4+wuvLJQvGjVq9EHL3qjUDspWq2Ri1GOMJPyF8w
 lBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pEMxI+SHzaiXEllIBUTUdPHIl/NuY6uK0nZoRQW7V8s=;
 b=nkj7P2RQPhxu5fjyT4WEuTkK/2tI9RP9FArfwytSRpfLA0GhbQKwdtC6cQRPEFSht/
 BTlyV3+PohwYSMTBJ2yoRyittzhKPxRPjdUc4WmP+kmcNhgEjrlsimhc50YqeIj77qXY
 DNQWJqqZqW1Adrm/A03eWAGFdLpnYUhHIGdgeVLIEwGwrXQYIV4z2GeiSbejxqfrx+HC
 seMcA6R1hcCTv8gNSb4v4EqhT8QEXQp5h9iCh/EdQrT+Qyo6P2AZ70sccESr74ToMVA4
 iwOIghfNWogtWtaTIIAoNpKyp3dwN0gXcqAJIx6PpD48VSRX2/Z+Vk2l5J5vdywuweS7
 vmGQ==
X-Gm-Message-State: AOAM533mxHj37nSkUYk2EHdn4BoLp3IOMnqoQDSJOFO4tShzA2vMagY0
 udsag/w15sZhPF7Vsh/3dCZUY9RGpoE=
X-Google-Smtp-Source: ABdhPJxbINmw8qDZGiDQBzNKtQ42dkxohQxQcJrhmjw+R6xANa8UNE+E7qaF153Y7scQw+O0Ia6+Vg==
X-Received: by 2002:a05:6214:84:: with SMTP id n4mr365691qvr.26.1601064700501; 
 Fri, 25 Sep 2020 13:11:40 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:39 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 33/45] drm/amd/powerplay: add vangogh ppt into swSMU
Date: Fri, 25 Sep 2020 16:10:17 -0400
Message-Id: <20200925201029.1738724-33-alexander.deucher@amd.com>
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

This patch is to add vangogh ppt funcions into swSMU block.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c   | 4 ++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5534125f1df3..d4cc2825d364 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -33,6 +33,7 @@
 #include "navi10_ppt.h"
 #include "sienna_cichlid_ppt.h"
 #include "renoir_ppt.h"
+#include "vangogh_ppt.h"
 #include "amd_pcie.h"
 
 /*
@@ -401,6 +402,9 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 	case CHIP_RENOIR:
 		renoir_set_ppt_funcs(smu);
 		break;
+	case CHIP_VANGOGH:
+		vangogh_set_ppt_funcs(smu);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile b/drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile
index f98d97192635..0138c982dfd3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile
@@ -26,6 +26,7 @@
 SMU11_MGR = arcturus_ppt.o \
 	    navi10_ppt.o \
 	    sienna_cichlid_ppt.o \
+	    vangogh_ppt.o \
 	    smu_v11_0.o
 
 AMD_SWSMU_SMU11MGR = $(addprefix $(AMD_SWSMU_PATH)/smu11/,$(SMU11_MGR))
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
