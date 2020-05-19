Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7FFC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 21:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E75D12065F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 21:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Us226Qe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75D12065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88F4589F71;
	Tue, 19 May 2020 21:10:18 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 033C889F2D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 21:10:16 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id f83so1266177qke.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 14:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=70rJSxiK3XmSSAsIfVB2J5/4VdmWDqEqQq1pyI8b/j0=;
 b=Us226Qe0KVrOzVYJx+1oOuUgPYGmMaCt8uSfDQN4gv+1e8HTxpDklTgLiwHWdxc9+9
 96AAagJc9wHF7dvxe9sDtVg3Sw+53JOZkzMupPDQAaatc8tkWl0L0+PYStqyjAElYN7l
 HRxGmmiwvZenf4cLshSSloKmNCrZgm0xnSqaMmOcxcAA1ySwmn4KX45ugXTz7vBVVXl3
 0zRgFLVCEbICbei5+A5i+CZkliKpQvonvTqccMgya4TPbHKYRvGMu9kPsEJTB6Gu+pSi
 +B3espJpvV/tNXg9YRVmeQLHpAjlfP57l1+RuqEALBU6Am6FLTQoyV4hDN73sTssBvpU
 xXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=70rJSxiK3XmSSAsIfVB2J5/4VdmWDqEqQq1pyI8b/j0=;
 b=RbaV5aDzlWmwXz5WEEcdrw//bvm4ubrjZb/XU7YXl7YzDJLFjEB4jk5QE2VxX4kBc+
 H9ZQ3wZGy1JtNUC23/asR0Z2uGplBsDFuGggk+pubLwyMdR5T/R+ss7RiMwh9XQ6AVV3
 PN7jSpFhPy8cWv/DJq62A1ougVS432XuErGATAd80KuHKAT5B8sPcwVE1HTg9H5vLVUX
 08aoZCDRco9Wh9/DnzgUH54xb2w/lgXR0vNWwUDSkNtKDUdY2IdD2zkEjJioK5XXpIDg
 Xvn1+GLA77zyBYpJP2izCX1AVGVUPS/UyD8hEUVNhzYFetWFxqEV09VXBtccZBbVg4Vm
 yB5w==
X-Gm-Message-State: AOAM5329QEuZlvHGJUIBly8NtKfIvFl4XhqpH7qrrMOjaORjFrD85OeR
 ervkUYVTI+fyYw1x7F0d3b9wMLvN
X-Google-Smtp-Source: ABdhPJxWRPaNK00vEMtZW/+Ni6a+R2OpvvmZkYsjp0MD6EkT1G5gyWoK8iGvZv0SEgESOOkG3vEtLw==
X-Received: by 2002:a05:620a:227:: with SMTP id
 u7mr1432197qkm.182.1589922615702; 
 Tue, 19 May 2020 14:10:15 -0700 (PDT)
Received: from localhost.localdomain ([71.51.180.250])
 by smtp.gmail.com with ESMTPSA id 21sm576176qkv.126.2020.05.19.14.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 14:10:15 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: drop navi pcie bw callback
Date: Tue, 19 May 2020 17:10:06 -0400
Message-Id: <20200519211006.80492-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200519211006.80492-1-alexander.deucher@amd.com>
References: <20200519211006.80492-1-alexander.deucher@amd.com>
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

It's not implemented yet so just drop it so the sysfs
pcie bw file returns an appropriate error instead of
garbage.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 9c42316c47c0..6655dd2009b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -548,13 +548,6 @@ static bool nv_need_full_reset(struct amdgpu_device *adev)
 	return true;
 }
 
-static void nv_get_pcie_usage(struct amdgpu_device *adev,
-			      uint64_t *count0,
-			      uint64_t *count1)
-{
-	/*TODO*/
-}
-
 static bool nv_need_reset_on_init(struct amdgpu_device *adev)
 {
 #if 0
@@ -629,7 +622,6 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
 	.invalidate_hdp = &nv_invalidate_hdp,
 	.init_doorbell_index = &nv_init_doorbell_index,
 	.need_full_reset = &nv_need_full_reset,
-	.get_pcie_usage = &nv_get_pcie_usage,
 	.need_reset_on_init = &nv_need_reset_on_init,
 	.get_pcie_replay_count = &nv_get_pcie_replay_count,
 	.supports_baco = &nv_asic_supports_baco,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
