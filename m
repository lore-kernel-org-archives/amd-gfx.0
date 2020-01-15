Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C372C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 17:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E812077B
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 17:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1JDZtmy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E812077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D20F6EA68;
	Wed, 15 Jan 2020 17:58:42 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD8536EA68
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 17:58:40 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id c24so5756580qtp.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 09:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=omZU/HIw+D1J4H3NFlNbx4GGEXD/G5g2SsL9hF+quuc=;
 b=Q1JDZtmy4Pe1Rnx52INgoTD10idLzwYTZZ4wkvVz+uxU0Js1c8hpk8Po6FUkYX6YqV
 tYJiExOyPEDOb6g0W3KX5eJAyYCd6ELKT8Zv2bD7YHFI8nBsmu3Gw8Bp37CPnyL3uW6N
 2+8AJsVlTRv9dkPvSqiVbNhV33NhBLp9rQFwdSw1l7vf+X/VtOc1XcboY3//ZIpdHdv8
 6sxaXReP5szZgFdM7+NHhiWDBTutzY9LmxH6XtsGAQpCMcNbFk3vDoNfNnCDHe1rnN1J
 o+Yick/FJ3lWmSQ8oiCWbLbKAcFbuBVeEEIspBySfhBuCtZUU7ys4/z9KvFauuijKLUb
 wCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=omZU/HIw+D1J4H3NFlNbx4GGEXD/G5g2SsL9hF+quuc=;
 b=j0r1fJsEwi8QvevChEKXPpikPh7Pmao5pM96aiTEknJLoHDYjeDosTeHDPm0oZR0yQ
 EfScwKhHP0y1k5GOPHk+myOXdXDkvP1GASmr86lE6kW6Cy+V3Xthhvu3Ha9GakQVfrNM
 IenYsxPNDwkKrqRKDkmfyumwCOmETlxQbot4jips/vdLGG/UhPy3vw/w24RO+wkWSuEv
 KfBpxnfu1vlWTmFmBqWeoK5G/iXDTGIS4w3TKl+T4C3slKYtA4jt3yYz3aEvE3RzGQ+s
 lyDItV5hDONS1piRKA+hHwfD/UBNOlTyhE5QM4I8k/IfMMAXEug+DCoAus/e54KMBKLR
 vLsg==
X-Gm-Message-State: APjAAAWjw4ZpWPj6L4NcMjaoG09cCNLry0/GVUpiAefBhRIftphhZLaC
 ztoppprVFPwLNcJweSgiZLu1XTzE
X-Google-Smtp-Source: APXvYqygc6mSU7JhrwHcJZNgwfVCIcM1GqMT2hrnBMZUp/mQc80B/5MsmU+mOWflSZSzq1rdit/StQ==
X-Received: by 2002:ac8:33ab:: with SMTP id c40mr4769093qtb.250.1579111119652; 
 Wed, 15 Jan 2020 09:58:39 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id u16sm8760067qku.19.2020.01.15.09.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 09:58:39 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: original raven doesn't support full asic reset
Date: Wed, 15 Jan 2020 12:58:30 -0500
Message-Id: <20200115175830.1433967-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

So don't use it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 317803f6a561..a672c10ecff7 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -537,6 +537,10 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 
 static int soc15_asic_reset(struct amdgpu_device *adev)
 {
+	/* original raven doesn't have full asic reset */
+	if (adev->pdev->device == 0x15dd && adev->rev_id < 0x8)
+		return 0;
+
 	switch (soc15_asic_reset_method(adev)) {
 		case AMD_RESET_METHOD_BACO:
 			if (!adev->in_suspend)
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
