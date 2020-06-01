Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6A6C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3268B20872
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUpaXDlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3268B20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84776E2DE;
	Mon,  1 Jun 2020 18:04:49 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE7BC6E2DC
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:48 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id c185so9949539qke.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Eq1RCjYVU3iPGM6c/3oPA2MNCrWXxQpkQDhvbudDjfc=;
 b=kUpaXDlJeJ1Z5GeXo099dS50ShtRp+U9AXINA5glgfNdTIdOE8qMvrZYoLrQCwHAy6
 e9OctpXFHGHjw6bF8ZlN3JUHMwQknDkoVEK5QhgKIvGgC1yoUWNzgIrm5j7U2BIi/192
 k//AmEadh69ibkIN39X6X8acB5/N4CsWNfSOiPvxtVylA9x0w/DVfU4RRaKa6DftiPVZ
 KYj87esfnzjGppzkDV5fKQDfIrylv/sCo3HXNozbxk5rm+pSHEl9m9IGA1p1/U8bqYra
 ew8jYQkqnxlebOzyIS35iESk6co6EOvKb1aq8zswBQdBzc57laJJakSbmcD2+Q+KMh1l
 ML3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Eq1RCjYVU3iPGM6c/3oPA2MNCrWXxQpkQDhvbudDjfc=;
 b=QKHdy7doYwgH0PSQqzmZdBcal32dyqVY01DnnUzPrApg2fZDo68AJly+3RdzbH8Oqw
 4SmTK88ZSDlNF8Ht0cva0HSJh/uL6zJjTl5+SU/d02V7zC94tHjWkoBv44R0yLBmaxPe
 3epoLpY2BzWjd3OpvNwYvnRAmYzIMBrPY0ciDNH69YSsa4d17V/0yYaAL0y83pafOBkj
 5uJMfHR29QaCZGZ+eBH5hTDscU4gPgN+VeCnr2UI9SlTnFmr9CcHuhpfXy9J47ShPtIa
 chycDlKOpEwwtsQccZkybEYT+2SFnamenKpF6NftAKe25e0NjzAHmLbmM8pWW6NMED0E
 3FqA==
X-Gm-Message-State: AOAM533G87MQErrLTTY+jjedVfxLEZFvWWvWQv0xkY3nzr6EYq9DuQ2B
 L/nV9jBSmg6SOpY3Q8Bqq4vQIJ4O
X-Google-Smtp-Source: ABdhPJx2cJv/JT8jtlzQMybuOqC2arJv4yfSqBOfs4JZp9V35iQTXZl4goVtpizFlIM1vyssy7Ml2Q==
X-Received: by 2002:a37:a7c5:: with SMTP id
 q188mr20440002qke.384.1591034687959; 
 Mon, 01 Jun 2020 11:04:47 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:47 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 085/207] drm/amdgpu: add Sienna_Cichlid VCN to the VCN family
Date: Mon,  1 Jun 2020 14:00:37 -0400
Message-Id: <20200601180239.1267430-82-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Liu <leo.liu@amd.com>

By adding Sienna_Cichlid VCN firmware

Signed-off-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 2badbc0355f2..fff77b629d04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -42,6 +42,7 @@
 #define FIRMWARE_NAVI10 	"amdgpu/navi10_vcn.bin"
 #define FIRMWARE_NAVI14 	"amdgpu/navi14_vcn.bin"
 #define FIRMWARE_NAVI12 	"amdgpu/navi12_vcn.bin"
+#define FIRMWARE_SIENNA_CICHLID 	"amdgpu/sienna_cichlid_vcn.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
 MODULE_FIRMWARE(FIRMWARE_PICASSO);
@@ -51,6 +52,7 @@ MODULE_FIRMWARE(FIRMWARE_RENOIR);
 MODULE_FIRMWARE(FIRMWARE_NAVI10);
 MODULE_FIRMWARE(FIRMWARE_NAVI14);
 MODULE_FIRMWARE(FIRMWARE_NAVI12);
+MODULE_FIRMWARE(FIRMWARE_SIENNA_CICHLID);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 
@@ -107,6 +109,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
+	case CHIP_SIENNA_CICHLID:
+		fw_name = FIRMWARE_SIENNA_CICHLID;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
