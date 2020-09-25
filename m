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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD99C4741F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EFF23A31
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ep/qNvCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EFF23A31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C11A6ED62;
	Fri, 25 Sep 2020 20:11:16 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A66866ED5F
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:15 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id f142so4063308qke.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4tohG8na0h/+M+Pys37sQXjJGt8foqNaKdXQik5SaTw=;
 b=Ep/qNvCpCq6mQzYgB9ufzIJ91HGwE4yc5RMyS/nf7ohJ8zfckAQOztUFyvhYUrmgtL
 Njh65ZLD6kYiL0LolOIelB2KrJqvwMrQG1L0FkT9gWnj4s/RQnyQe6mM04nHjr2KYM64
 62TUMmZYvBYnVUlcwJ6RxjavMnu5zAbk7QxEogBhRWzar4KRT0kaurY8yfi4d3rsDQ/Y
 dDqoig6pr98TzIioiDwBfRfVE66Gm5EPIXwDpyvzfhHozvGnK/KlwQqhLGopOXb9OEqR
 bw22fYlTjA7sHIdiGzoz1eLVE9nYYos7yLIdhz8CVOhWuZ5CMV7zGr/IHtEcO+VphYB2
 f7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4tohG8na0h/+M+Pys37sQXjJGt8foqNaKdXQik5SaTw=;
 b=W/y34LJJDuUy1GJCmbVXpV2Td+6jTItcUfG9eh+U0ylbLFpVrL+8lf2+4WW6Uy4lnb
 zWmyTa3MXi8D3EkFUuNnrIu9eV4xokFJpzeQxfm9vAuPN7bFtuyb6XoO7EmANsqIb7u2
 WZ8O4742w5kRJ4GZwrurrfadpqxSO31FXVEtM5FaVWGBmkg1f3NPWFIu5lljWIGP86TP
 h2R3p3YNIRhHeiiPMu3wSUX0bAs8NoGo8w/2JGPb8YuZ+RaMQpr4oqxyrSSO0LrWBLlX
 WPeOluwC94FIjyqj+26pKCp5pC6SDN6qm21/uxmITfEls1Syb5Rm1BFmfaq5CIZGs18+
 /fYw==
X-Gm-Message-State: AOAM532dQv7z7LBHHFGnngtsEO/ViCyPhIwJfpKdf/VRPvlbo73els06
 LHX71DIaKlbFxkvHuApSxiGTYJbDb5g=
X-Google-Smtp-Source: ABdhPJyKDD9tMhexyCgNDSG8rlgtG4SF/hTVPGRS4hrPYCKJy445kVrvWn4D/g3EuWV/q0GnOiR4Xw==
X-Received: by 2002:a37:5fc6:: with SMTP id t189mr1651190qkb.78.1601064674677; 
 Fri, 25 Sep 2020 13:11:14 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:14 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/45] drm/amdgpu: set fw load type for van gogh
Date: Fri, 25 Sep 2020 16:09:59 -0400
Message-Id: <20200925201029.1738724-15-alexander.deucher@amd.com>
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

This patch sets fw load type as direct for van gogh for the moment.
Will switch to psp when psp is ready.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 55fe19a2f332..3f791ca73ff7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -395,6 +395,8 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
 			return AMDGPU_FW_LOAD_DIRECT;
 		else
 			return AMDGPU_FW_LOAD_PSP;
+	case CHIP_VANGOGH:
+		return AMDGPU_FW_LOAD_DIRECT;
 	default:
 		DRM_ERROR("Unknown firmware load type\n");
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
