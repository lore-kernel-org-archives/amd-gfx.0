Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613EEC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 05:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE43F20707
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 05:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE43F20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CF116E530;
	Wed, 27 Jan 2021 05:32:45 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC42D6E52F
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 05:32:43 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id r9so626946qtp.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jan 2021 21:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xAzp8VGwlZn0PC2khuHZLpE4BqnMFk9w7CPs2NrnkWU=;
 b=S2BLda9EanjbL20HjpzTU053br0FB+ZRE7RrS61WsSfAgQietFIF9PZn3ZITA5rI0z
 LtLOP1gbZ71JycOumvCxx4wtegr93ltPKPJLORl+yRWEieIjJF4p16gNaQUzg5PKNCvy
 XMlErXliyurYVdDMQwoIr6UZQhPFpYCNFd/maox5wg8tgXhgTIDKysjebSW3kXupVQHI
 iuFrTlZJSD3NFhqGl0WOQ2xrkGcL0jv/fGDiwaqrk5zF/CITlWJQ4VUkIIE8aS6yhWIY
 Y54KvHXcEwRtnFEQ+tEWpB/ZGm+7HH4boihEbJJ3RTBX9n82P7pwO/JF/Hevz4SFzhrF
 1R6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xAzp8VGwlZn0PC2khuHZLpE4BqnMFk9w7CPs2NrnkWU=;
 b=fmxGrUsY986jcY3taHPZTfb0z2BGaD3SasQsJFPEeVZXSF2KlAOuvYJn5P4qlKIK48
 TnzaEh7AVR3fT983Jj/01fFop6drMfG8lVek3LXoiFftvTjGli5lPtGeXjopwIeP43Dr
 eT9Xdvbrg3qn8qvJObLF7iUVkTJiP3zB4bxdtIVWSWCS/JhV1bzDyZgHRp6Mq5C+2RMX
 2OdS25mkpTHKDURtqXxDSLXeytkl5K6EV+ypEigikK4qABdhDa7kB/OTMwUS7PEI1Aig
 VFHI1GSvxvRI6f5mtOnkWLw0hO+W9ADlVtaUZfZKKa5xKCqYXyn+on7z9PVQeXsHN1hn
 WhqQ==
X-Gm-Message-State: AOAM5327d8YJixOuYKWvk+D79ZJSesLmmoUiamWem7mVNZRBVyO8n4z6
 8+6oNNsUaNp/ne4MmUhcm3SsieD73v4=
X-Google-Smtp-Source: ABdhPJy/aXFVRybsHNuXi/LDgUg7WNVVPfPQhYL8w15K99IozH4Nf0eURYgJA05M9mkJb3fu5F60GA==
X-Received: by 2002:ac8:598e:: with SMTP id e14mr8316957qte.346.1611725562658; 
 Tue, 26 Jan 2021 21:32:42 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id t184sm555982qkd.100.2021.01.26.21.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jan 2021 21:32:42 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: add asic callback for querying video codec
 info (v2)
Date: Wed, 27 Jan 2021 00:32:28 -0500
Message-Id: <20210127053231.202843-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will be used by a new INFO ioctl query to fetch the decode
and encode capabilities from the kernel driver rather than
hardcoding them in mesa.  This gives us more fine grained control
of capabilities using information that is only availabl in the
kernel (e.g., platform limitations or bandwidth restrictions).

v2: reorder the codecs to better align with mesa

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f4ff8ddb52d4..3ff8d08e3cf0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -582,6 +582,27 @@ enum amd_reset_method {
 	AMD_RESET_METHOD_BACO
 };
 
+#define AMDGPU_VIDEO_CODEC_TYPE_MPEG2			0
+#define AMDGPU_VIDEO_CODEC_TYPE_MPEG4			1
+#define AMDGPU_VIDEO_CODEC_TYPE_VC1			2
+#define AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC		3
+#define AMDGPU_VIDEO_CODEC_TYPE_HEVC			4
+#define AMDGPU_VIDEO_CODEC_TYPE_JPEG			5
+#define AMDGPU_VIDEO_CODEC_TYPE_VP9			6
+#define AMDGPU_VIDEO_CODEC_TYPE_AV1			7
+
+struct amdgpu_video_codec_info {
+	u32 codec_type;
+	u32 max_width;
+	u32 max_height;
+	u32 max_level;
+};
+
+struct amdgpu_video_codecs {
+	const u32 codec_count;
+	const struct amdgpu_video_codec_info *codec_array;
+};
+
 /*
  * ASIC specific functions.
  */
@@ -626,6 +647,9 @@ struct amdgpu_asic_funcs {
 	void (*pre_asic_init)(struct amdgpu_device *adev);
 	/* enter/exit umd stable pstate */
 	int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
+	/* query video codecs */
+	int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
+				  const struct amdgpu_video_codecs **codecs);
 };
 
 /*
@@ -1218,6 +1242,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_pre_asic_init(adev) (adev)->asic_funcs->pre_asic_init((adev))
 #define amdgpu_asic_update_umd_stable_pstate(adev, enter) \
 	((adev)->asic_funcs->update_umd_stable_pstate ? (adev)->asic_funcs->update_umd_stable_pstate((adev), (enter)) : 0)
+#define amdgpu_asic_query_video_codecs(adev, e, c) (adev)->asic_funcs->query_video_codecs((adev), (e), (c))
 
 #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
