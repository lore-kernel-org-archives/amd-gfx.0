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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A421C433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736AC2077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G55gqwDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736AC2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FA086E28A;
	Mon,  1 Jun 2020 18:03:46 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C5B6E286
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:44 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id cv17so430602qvb.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jWhUGUQIaG/4yKJDZreBckHyk2XeOi4Y4Nq/g8vAsoI=;
 b=G55gqwDECbngDxfuqaWfgIp7WMdF0XqjHtaJbRR70cMmJi8fyLNS34pbVb9yCsuYXj
 y9vzQCo960S5/Q9bsa+oezzJZ5ZkJUOHpO11B3+baatUD8tUnJ1cTY6/4PNR88SHHiUH
 rm2ZYO0+mxuJuCmIiNCZR44Lpk8Is/kDMkhK1Ih0jduALBpUaXiR5ou7G3Q8bqE+DLCb
 FSFAnffPjhXRsVdZFQcdhQjRIJQbYJYlBhgfASnwZJ8Hg9u+XnvNTXQ4HDxdPbtwJ/rB
 lyYij0bEWn98dOaVhVqd9FDSJTSZ8gTeFI86nfOJm8yK1QJ3vWl9PiRedYuOkANXnd3e
 pMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jWhUGUQIaG/4yKJDZreBckHyk2XeOi4Y4Nq/g8vAsoI=;
 b=UnjgQvWsNDMbbcXut6lSZIiRU+W/zCYOGdhskJJLL1n1Ms23lds4DIRzLxaeTojCrL
 oGnOj1SAV1XecsQ8lD4HYDd7Ro965yQ1sBnGI1crcm7Pj60x8RdKWfHoVpM+ZAgxc6c+
 IAwDhEW2+F5kpyavj5ngpubJRA4sywui4DSNEQQMhvIa8Dw8sVw1ZBIBqojISxlyaxEU
 ONMv04jGxu7Bq0Ui/IUmtLLDuXSPhUQZKwJThQ9DEvbVdmHQMWNH+vhsOpPPGA+Yt1Nb
 iBDiXm8IjGAs3JsD7za9vH9+l3q7RsiiPtdIkPZYOWxaAqVJDmb/uUeY6YcOZwb5mg7Q
 fuWg==
X-Gm-Message-State: AOAM532Dtp6DoAqoCMS+p/zPN3ZVIYL4UuOwR55BLjsKDAQHnxGIky6R
 CtTEla4tr8mHtTE1FCTHsDp9cmZZ
X-Google-Smtp-Source: ABdhPJxEkkj7YNj8dyfpr+S5VX/D1zb3OMAuKiSdZBvwPAvuc8NRjiLPUXBSGUdvIstmzqbvtcZvQQ==
X-Received: by 2002:ad4:510c:: with SMTP id g12mr4586614qvp.231.1591034623781; 
 Mon, 01 Jun 2020 11:03:43 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:43 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 040/207] drm/amd/powerplay: enable GFX SS for sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:52 -0400
Message-Id: <20200601180239.1267430-37-alexander.deucher@amd.com>
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
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Enable Graphics Clock (GFXCLK) Spread Spectrum for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index e4bbd282eede..1c0dbc5b5d94 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -278,6 +278,7 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 				| FEATURE_MASK(FEATURE_DS_DCEFCLK_BIT)
 				| FEATURE_MASK(FEATURE_FW_DSTATE_BIT)
 				| FEATURE_MASK(FEATURE_DF_CSTATE_BIT)
+				| FEATURE_MASK(FEATURE_GFX_SS_BIT)
 				| FEATURE_MASK(FEATURE_THERMAL_BIT);
 
 	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
