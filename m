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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B347C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05EC02073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmm/wRtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05EC02073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD63A6E375;
	Mon,  1 Jun 2020 18:22:50 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 666CD6E375
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:49 +0000 (UTC)
Received: by mail-qt1-x835.google.com with SMTP id i68so8493854qtb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JDrXNsBHP87c4IE24ZaTC+NQZ9W61M3XcfxqzlCSAvo=;
 b=lmm/wRtLyJH7sH2/9zAFfqaIVe2ixayliGwfNEDau7Vv4lXbV9XRBwpPkv+3kBYbNW
 VHhXqSlRoYkSTTddiotQav1ZOqDCY+Pkhv++NQGtNDUv6CPFhW2GhXBsyZhJSP40n4I4
 ifaF9XvCoCUPan3U+oqgBQh6bVpfNFzIrw6PllTL9tqJ++zySPu39FEFj8UdnxhoHvdK
 F/E7lowcAMWKwNIX3GjUMPpMpqiRIrPr5AolH+emi0qIypVW4nmYTi6U+fbc6EpRuAVj
 5z1IKv4rr0bEWugupXWYz1LpO43ZtMnW1VVCJG/eBQFr9FBD3Au5HL/aZFZtaOmdO5yK
 bokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JDrXNsBHP87c4IE24ZaTC+NQZ9W61M3XcfxqzlCSAvo=;
 b=pCPEvO8vTaXX76IysK2uDwZIpaoLWs2WCSAtrdE9ls51sL8V9I4lzajV7LKp+EzFbB
 WhQaRMTmKIYTrFtusCaCR7w9L80OEtb4NznV0Zdh5p1nI1irYF6HdHYhIIAz7tWzWJlw
 Pn7+3QZigwfF8299rPSsEEYOAM6uLihKxlIkftCOdjg5J0DhsI1JIV2gK58d3Qt2QAXj
 r4MSwlEnp8cXuEKTWU1xSP4zUsgm3ZJTpgc7sx2tTj0kEyRL0Nf+2GwX9WuUysJxjTc7
 0uft4vA7oAn75XXpcYgzPcuGeWrwOKAXcrDeeqkojIQcHzy8rtl7k9hEUVHAfK8Q8q07
 0mJQ==
X-Gm-Message-State: AOAM532puO82fx+VutEIY5F7x9eqv5n1PQ0rr4DYWAOGD1RopG0SIzOp
 Htm7psB3Q2T3tj05PZEUs1hepW4Q
X-Google-Smtp-Source: ABdhPJwnWH8UhXU1vg/KlaO0umnp6vEjsJik50BC6E5Yi07SCpsVsOrG+bxwNSB/+AGSE4GbhzRBOw==
X-Received: by 2002:ac8:75cb:: with SMTP id z11mr12160948qtq.111.1591035768320; 
 Mon, 01 Jun 2020 11:22:48 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:47 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 168/207] drm/amdgpu/psp: add structure to support PSP SPL
Date: Mon,  1 Jun 2020 14:20:15 -0400
Message-Id: <20200601182054.1267858-79-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add support for PSP SPL (Security patch level) table to support
anti-rollback of FW loaded by Trusted OS.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h   | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index e19b98d48c98..e66958a01458 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -222,10 +222,12 @@ struct psp_context
 	uint32_t			sos_bin_size;
 	uint32_t			toc_bin_size;
 	uint32_t			kdb_bin_size;
+	uint32_t			spl_bin_size;
 	uint8_t				*sys_start_addr;
 	uint8_t				*sos_start_addr;
 	uint8_t				*toc_start_addr;
 	uint8_t				*kdb_start_addr;
+	uint8_t				*spl_start_addr;
 
 	/* tmr buffer */
 	struct amdgpu_bo		*tmr_bo;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index b0e656409c03..df402c7b3233 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -99,6 +99,14 @@ struct psp_firmware_header_v1_2 {
 	uint32_t kdb_size_bytes;
 };
 
+/* version_major=1, version_minor=3 */
+struct psp_firmware_header_v1_3 {
+	struct psp_firmware_header_v1_1 v1_1;
+	uint32_t spl_header_version;
+	uint32_t spl_offset_bytes;
+	uint32_t spl_size_bytes;
+};
+
 /* version_major=1, version_minor=0 */
 struct ta_firmware_header_v1_0 {
 	struct common_firmware_header header;
@@ -266,6 +274,7 @@ union amdgpu_firmware_header {
 	struct smc_firmware_header_v2_0 smc_v2_0;
 	struct psp_firmware_header_v1_0 psp;
 	struct psp_firmware_header_v1_1 psp_v1_1;
+	struct psp_firmware_header_v1_3 psp_v1_3;
 	struct ta_firmware_header_v1_0 ta;
 	struct gfx_firmware_header_v1_0 gfx;
 	struct rlc_firmware_header_v1_0 rlc;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
