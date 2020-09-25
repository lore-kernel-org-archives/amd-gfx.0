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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A831C4741F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0050D23A31
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw7nLSRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0050D23A31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB126ED7E;
	Fri, 25 Sep 2020 20:11:46 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE9A46ED80
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:43 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id f142so4064853qke.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ln0JwnmaR+eh82Q9wFtDZTTk9SI+XfQ4RWfrVN5GM9c=;
 b=lw7nLSRHD9wd9WgUTsKAvGP3hTx2YsrP+k6uC41VHz7gGe+NqqX3sTSyJTExHyG9qi
 gmktF2jr1u9BP8faDxcN4SkTcQyEdpMW+wGMlcL2qqBGGDzQEHdbOcYNz4kOl8NSGpVZ
 7onUyGugJbuvukg+ZOBPc1lT9cX2WPNP4a9BL3aqvdOkQsuA5Q7y2p2tVS08TmrgfyhT
 h8vVKC5UoMxcFfZq7pPDx+Yz52jto0UnZCKdtT8s+QrWMaoteQQDQ/wSFpN7SvZyoKin
 lBM88vbHewEBC9bjkKy1lI5m9V6C4sJ0VWps2Zby8swpufJI//G+Q9A9I8G1t7ezMtTh
 Aagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ln0JwnmaR+eh82Q9wFtDZTTk9SI+XfQ4RWfrVN5GM9c=;
 b=MBJP4eE9yYsb1CGgMiIZL12kKq+oKYO7M8B3imS/uZw/imwcW089THb0IxIesiMW0+
 1WEpkhSNZKbndalFcDpKFgM8oAOuusHFZ8604imB+7d8OsqFHRhuR7k1twTJn1PovwyH
 IGQA7pwHcxvsl/Q+jeGf0Zs4AN/Yj28hzRBkxkSJlQrn3KQ2yjU+UufaE7GLEEPIEbbu
 RwomV3HppY3jKqQ0iSszo88ZQVJwyWkafkXuaK3kPyvCodgI784kpKvxfC8iNKm9tzkz
 nDqVi98klxmn/Y0Utbzi/oGz9x4y7N1hUof7NYWdhudNglB31GjoVsYMXQbS1e5c30BX
 duiA==
X-Gm-Message-State: AOAM530/XtAOyBxuwXngQoFqkxjBWvdJRmbJaOIzSpY37IudnH5qyH5C
 VKlLwypeF32W0hN1wQoYuoX6qErI9JM=
X-Google-Smtp-Source: ABdhPJzNp3NIIxKqFV0P3gK3oiZ1Jt5lqIJaXW+2OXpjtkFDYZR0POy/y85tT/4qHwAvF1reBmReDw==
X-Received: by 2002:a37:77c4:: with SMTP id s187mr1784135qkc.327.1601064702942; 
 Fri, 25 Sep 2020 13:11:42 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:42 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 35/45] drm/amdgpu: add TOC firmware definition
Date: Fri, 25 Sep 2020 16:10:19 -0400
Message-Id: <20200925201029.1738724-35-alexander.deucher@amd.com>
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

This patch is to add TOC firmware definition on uapi.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index d98d4e6f311b..64ae821b01ef 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -727,6 +727,8 @@ struct drm_amdgpu_cs_chunk_data {
 	#define AMDGPU_INFO_FW_TA		0x13
 	/* Subquery id: Query DMCUB firmware version */
 	#define AMDGPU_INFO_FW_DMCUB		0x14
+	/* Subquery id: Query TOC firmware version */
+	#define AMDGPU_INFO_FW_TOC		0x15
 
 /* number of bytes moved for TTM migration */
 #define AMDGPU_INFO_NUM_BYTES_MOVED		0x0f
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
