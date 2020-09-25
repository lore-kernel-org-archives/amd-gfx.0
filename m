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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718F3C4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF9B23A31
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxR8YaWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF9B23A31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61F946ED37;
	Fri, 25 Sep 2020 20:11:51 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B26446ED37
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:50 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id d1so3082288qtr.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SDq3At62oS2GslER2TqUAy5HRsphK0A4KqGkc+9IxEU=;
 b=UxR8YaWtyCKLv/n8Df4fI4k+baWfvK9KhxfTL1XL2j9yFvJ4BVPXAY1bpz2F5zAbB+
 nBZEz5yRfCSTOURMB1c86c3ZZvi2xR9Lld4UaDagYC+H15xaorue6cq4DUgfvBtcVfHl
 Z/bg+eBUoIGtWRuWC831z4ldGa0Ydq4LvFavBNDrRSwWKWUOMD2evN6y69BlOpShJ1Ly
 r1/muTIv8/zfftdEqS+xK96sAeq6K826xxd3tOSOFV0wAah7c2KtYNpCIcmwYeQnOb71
 nzPIRsQsg84BuhQO+Wmp46Gk0vzE+pZyZjCWsj8JvqtPGGurXXlGGRDcL5inUGOvtRiy
 1aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SDq3At62oS2GslER2TqUAy5HRsphK0A4KqGkc+9IxEU=;
 b=apu/3n1RjbscfEVSW65n96ro4GTTjKUz3vl+Kg5i09dtntzBk5iiubA13XcQ8YhHxJ
 ZZ5k/XI3QvF+scX1/qbeN3E5slKp1a15OCn5fomCXa/9bPNZ2rzRjUQCYE8TemvGMVFS
 JYGnajST4EJWk212KNFlRiWpxzlAobADqu5KXBKxQXZxGaAsiBKpPNqEpWKQ1j9DGhTf
 23gKlXT/U3ycvVORBI2n0spL75xaPnje7Ot0+nawH7YvKGdXKVAEHFRbF3Xs3w87oTNx
 xg3s8COuNCfRSjE/f6TTZW9k3SrzEwEQ0yURUUJQ7lok1vCz05MIa3A2PuVLC8e0dQHw
 KZsQ==
X-Gm-Message-State: AOAM5314O5mMHWsZ/8AYn2BLMsCqc7hehx+WfhtJe/0+npnwA3teNaJK
 /gD9L9DlnGQgbP/1AZnU8ip7tPlbego=
X-Google-Smtp-Source: ABdhPJzfpL5GRBhG+qz/t/8nmRG/cduu25fCKx12oTD975JDgFDkF/sVk2axyy7jOKsAQ76qz+Vi/g==
X-Received: by 2002:ac8:37b5:: with SMTP id d50mr1495297qtc.228.1601064709755; 
 Fri, 25 Sep 2020 13:11:49 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:49 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 39/45] drm/amdgpu: IP discovery table is not ready yet for VG
Date: Fri, 25 Sep 2020 16:10:23 -0400
Message-Id: <20200925201029.1738724-39-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fallback to legacy path for now.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 568e33b7fda8..4bd2e2f35fa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -484,6 +484,10 @@ static int nv_reg_base_init(struct amdgpu_device *adev)
 {
 	int r;
 
+	/* IP discovery table is not available yet */
+	if (adev->asic_type == CHIP_VANGOGH)
+		goto legacy_init;
+
 	if (amdgpu_discovery) {
 		r = amdgpu_discovery_reg_base_init(adev);
 		if (r) {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
