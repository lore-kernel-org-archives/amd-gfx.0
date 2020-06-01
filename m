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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3B5C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508482074B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU4mbkYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508482074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E746E293;
	Mon,  1 Jun 2020 18:03:54 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AD556E293
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:53 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id e16so8470250qtg.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WVdkBFQH/BQPvlAS0UvJ1uTEXGCpZ3oW4VGdgjtiBlo=;
 b=YU4mbkYTySc9SX1aFjsJbGPd2FwVaCZz7VhdjLsGiOAYbvYjKLzbfpsv6AOtQD6sN5
 lY0Z8To5HBKfI/M1vIjRVnRuo21zmAC8vaeXnzLauJJVOpTRRCz78ANdZKgGqeEp+tSU
 HyM94Ag/KlLNu25jfLk3tx7G7QV4KhiXOPHT94z/6uOqxqiTEVLtNMA7f+K9QH5gHmc3
 VB7cPrqgwBIFmAcQ1dDBNwwD+WzV67/FQZSSYolIL5cCJeeruHHqd7VFbtnsbuZSSz+V
 E2TDTPz/47DZxKgN4q7bR8x8UsJhqgfYPv7RkTa97i6jr/f0owalEa4Qwd3AWPWvWZin
 Ot+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WVdkBFQH/BQPvlAS0UvJ1uTEXGCpZ3oW4VGdgjtiBlo=;
 b=U8nD/RmNx8ijjlm1OQaL/7xPPMt5yKVonD1VWBVqpOMfMYxiSO+XEXZs7RnJYJS8xA
 E85StxN9xNuurlftcC/m3k6A5GZKJJdS+aPqPhwxa9rqVNksbnLjWbCDUTbBTvaUKAi+
 jf2tdolNUBj0/g7Mq5aWELEHmmg/zy6UpGpVJcIMgpDfbi35wnlh5fmvPKflRRFpX9Oy
 pQHQKxvgDO1oXgVIl+BbhltibEyXWWb3LKo/PZO2dGxZhV6GZ/QixWBFmsLKqmERjw4T
 meSyaJRe5G91q6KuSwZgdwug2ESPJqTMvoBmpYFErk6T2nPBkzqf6ACcl9yfn0CO8sHg
 DGyw==
X-Gm-Message-State: AOAM532vJOFwnciiEjmTqDpMFbD+u2MVgwhUGexVvR2xfRDwfHhu7oIJ
 A7qTHHk2VcuXtC1OGurHSgIq0U+3
X-Google-Smtp-Source: ABdhPJz6b6RecvkzzhvqlVbneRxCMAFrJKJKP5c55Oloi2iKVNoREhZlyBLivi9uWuDpD0L85YRgOw==
X-Received: by 2002:ac8:6bc6:: with SMTP id b6mr23407285qtt.101.1591034632030; 
 Mon, 01 Jun 2020 11:03:52 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:51 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 046/207] drm/amdgpu/psp: add psp support for sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:58 -0400
Message-Id: <20200601180239.1267430-43-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
 Jack Xiao <Jack.Xiao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Jack Xiao <Jack.Xiao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 982899aaad9d..6c05071defdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -98,6 +98,7 @@ static int psp_early_init(void *handle)
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
+	case CHIP_SIENNA_CICHLID:
 		psp_v11_0_set_psp_funcs(psp);
 		psp->autoload_supported = true;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 427eccc649dc..349fc6f2de12 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -55,6 +55,8 @@ MODULE_FIRMWARE("amdgpu/navi12_ta.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_sos.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_asd.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
+MODULE_FIRMWARE("amdgpu/sienna_cichlid_sos.bin");
+MODULE_FIRMWARE("amdgpu/sienna_cichlid_asd.bin");
 
 /* address block */
 #define smnMP1_FIRMWARE_FLAGS		0x3010024
@@ -95,6 +97,9 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 	case CHIP_ARCTURUS:
 		chip_name = "arcturus";
 		break;
+	case CHIP_SIENNA_CICHLID:
+		chip_name = "sienna_cichlid";
+		break;
 	default:
 		BUG();
 	}
@@ -167,6 +172,8 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 				le32_to_cpu(ta_hdr->ta_dtm_offset_bytes);
 		}
 		break;
+	case CHIP_SIENNA_CICHLID:
+		break;
 	default:
 		BUG();
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
