Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC288C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA2E20787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ0snQ1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA2E20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B2F06ECFC;
	Thu, 16 Jul 2020 21:23:32 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E0A56ECF6
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:29 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id b6so8601409wrs.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OB9A5je+ITjs+npj5K9T9J+FLWCfi2rKow4+8bb6mNI=;
 b=WZ0snQ1vq0tCGAlYwMw+sx1mAqAcz1NWk7CvuNzF/Tm0Owu/m72s3MI/dhEDJEaenL
 Zen7ngCl27HS+3BNONCdao7JN4LR4Rznyhyj+vhU/RKCOXEpIOZd/3xIifizkaiMlgNO
 wqfnL93Wx9mVHt/YvPoUyokCdi7FhNZ0HEKF2bpqj84KpfQdTOwC330yHLeGE0KfS0t6
 m5yg1Lp/+XawH1+aDP+R/6E8T30kIIvpJGZ4i8HDeovI+WxqWJRoGOnFdvE8yK/mfJMl
 lVnzRu6yYdCTVLlEiJ5iASh6gimh/5PBxUJO2HcxJbsOVfq80LjFicRX6RGC3G/uFAEJ
 qYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OB9A5je+ITjs+npj5K9T9J+FLWCfi2rKow4+8bb6mNI=;
 b=ryZpRwvyj5DoYdwSnik8Ke4UQLxGg/ZaTIvYuTwyEDvJiDoWwYZuUEgT+Om774miEC
 UxxFt2P2ntCzBCeojF06VUxwiMp+ozK9fCvgL93o9c60XJ7CTILdZuQbHK9rBY05D+bn
 jS+D0DyHKgsBArFqjBnGagdt8/flrH3PD29hMVv2e+/XHpYzLhPQOu9XsT/1TAJA9ZO9
 f7rzH1Gl9viSrtOkbmfo2NkRUSMywvWQMby4y+utsOGbTVE+b0tTjXTeR8D0ku0eDzQ0
 XEszLYUUJqhJEtd9XTXBg3W23FqhtWCV0193WGHBGBC65VQIZHH3ZTLl8FP//yzqV/PQ
 c0Fw==
X-Gm-Message-State: AOAM530BocvGRJqUJt8LuDuYmo/mRrp2EwLWBuR1t4k9edJZDi1vDL+c
 3EOjAcSUNH36mw6lw1wZMNal7JDevXc=
X-Google-Smtp-Source: ABdhPJy8e0yS6jpOofb6Wu9Xpp8hdtt+dhSxaAZLbyeptp0IZc4/PLOHIdK1Q7QxG04KLJBxsLeNXw==
X-Received: by 2002:a5d:4751:: with SMTP id o17mr6983816wrs.345.1594934607805; 
 Thu, 16 Jul 2020 14:23:27 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:27 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 19/27] drm/amdgpu: add some required DCE6 registers (v7)
Date: Thu, 16 Jul 2020 23:22:43 +0200
Message-Id: <20200716212251.1539094-20-issor.oruam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716212251.1539094-1-issor.oruam@gmail.com>
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
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
Cc: alexander.deucher@amd.com, Mauro Rossi <issor.oruam@gmail.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v7: add SCL_HORZ_FILTER_INIT regs
---
 .../gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h | 16 ++++++++++++++++
 .../amd/include/asic_reg/dce/dce_6_0_sh_mask.h   | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h
index 74897b046006..9de01ae574c0 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h
@@ -4514,4 +4514,20 @@
 #define mmLB4_VBLANK_STATUS                             0x46EF
 #define mmLB5_VBLANK_STATUS                             0x49EF
 
+#define mmSCL_HORZ_FILTER_INIT_RGB_LUMA            0x1B4C
+#define mmSCL0_SCL_HORZ_FILTER_INIT_RGB_LUMA            0x1B4C
+#define mmSCL1_SCL_HORZ_FILTER_INIT_RGB_LUMA            0x1E4C
+#define mmSCL2_SCL_HORZ_FILTER_INIT_RGB_LUMA            0x414C
+#define mmSCL3_SCL_HORZ_FILTER_INIT_RGB_LUMA            0x444C
+#define mmSCL4_SCL_HORZ_FILTER_INIT_RGB_LUMA            0x474C
+#define mmSCL5_SCL_HORZ_FILTER_INIT_RGB_LUMA            0x4A4C
+
+#define mmSCL_HORZ_FILTER_INIT_CHROMA              0x1B4D
+#define mmSCL0_SCL_HORZ_FILTER_INIT_CHROMA              0x1B4D
+#define mmSCL1_SCL_HORZ_FILTER_INIT_CHROMA              0x1E4D
+#define mmSCL2_SCL_HORZ_FILTER_INIT_CHROMA              0x414D
+#define mmSCL3_SCL_HORZ_FILTER_INIT_CHROMA              0x444D
+#define mmSCL4_SCL_HORZ_FILTER_INIT_CHROMA              0x474D
+#define mmSCL5_SCL_HORZ_FILTER_INIT_CHROMA              0x4A4D
+
 #endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
index bf262460b0b9..41c4a46ce357 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
@@ -9926,5 +9926,17 @@
 #define VBLANK_STATUS__VBLANK_INTERRUPT_TYPE_MASK          0x00020000L
 #define	VBLANK_STATUS__VBLANK_INTERRUPT_TYPE__SHIFT        0x00000011
 
+// SCL_HORZ_FILTER_INIT_RGB_LUMA
+#define SCL_HORZ_FILTER_INIT_RGB_LUMA__SCL_H_INIT_FRAC_RGB_Y_MASK 0x0000ffffL
+#define	SCL_HORZ_FILTER_INIT_RGB_LUMA__SCL_H_INIT_FRAC_RGB_Y__SHIFT 0x00000000
+#define SCL_HORZ_FILTER_INIT_RGB_LUMA__SCL_H_INIT_INT_RGB_Y_MASK 0x000f0000L
+#define	SCL_HORZ_FILTER_INIT_RGB_LUMA__SCL_H_INIT_INT_RGB_Y__SHIFT 0x00000010
+
+// SCL_HORZ_FILTER_INIT_CHROMA
+#define SCL_HORZ_FILTER_INIT_CHROMA__SCL_H_INIT_FRAC_CBCR_MASK 0x0000ffffL
+#define	SCL_HORZ_FILTER_INIT_CHROMA__SCL_H_INIT_FRAC_CBCR__SHIFT 0x00000000
+#define SCL_HORZ_FILTER_INIT_CHROMA__SCL_H_INIT_INT_CBCR_MASK 0x00070000L
+#define	SCL_HORZ_FILTER_INIT_CHROMA__SCL_H_INIT_INT_CBCR__SHIFT 0x00000010
+
 
 #endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
