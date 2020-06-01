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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BCFC433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E66022065C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjO0Ep1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66022065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F9D96E0CD;
	Mon,  1 Jun 2020 18:02:56 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18FF06E0CC
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:02:55 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id fc4so469135qvb.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=leRsZSG+GbkQasXlASBozrktc2Em9/ACZEeO5rMVEnc=;
 b=VjO0Ep1cSBc8YM9j23CM4fBbyjVHTG/gG0ja2+09x1Ou6bgMuDH3QPq8C9hGA8uRBy
 E8pPnX7Rqpb/7X+F4zaIGX+0gE9DgWyuGAuMTXr2m2x2W2MqZgGFeMtzcAhG8oGvAQl/
 Ya7ydTSLdRtRYguulj5YQ1uDUMkEQDONwOZjoKh3aEV0QAT9nMMfgKXGQLg1OZJ+RG1E
 +hDcTDLzpKmt+L35VXz6Y8UIXKObRTw1f6J73GTK1iYvBBgSXgnJxg2KDO+wUjEPIV3/
 ihm9bd1mjhDNLI57t8Fdguv1rKXWPUJSzRooA+gFs50FJ1SnAgrbK79WsHfcqo/yeNe5
 aaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=leRsZSG+GbkQasXlASBozrktc2Em9/ACZEeO5rMVEnc=;
 b=VU6bFFwK0xKEkwFPbTuYe5QBMtaITt+B0/ZnpNhNMOa3I45RWAiXssnvtSNgf1tFPH
 W2qaSu5ELZanXOpWUSF9PXrSDoLe+brs7Qr5pORpbbiH1WY0BiVmGHM1or1mMfqiFSzD
 yxUD+psjQwVUS25dq7nOcSaJuJ/7MXXDKlAsO57oqHEduszTMmciybzzjpX4rMXzt3ed
 9FZOJbhFE63OwP+XQd9cUJoAS59isVlzCVnpdwyTyZXvdzFk/ryzJT+yYgUE9IsRDVsP
 s7uE/DfgfUg/7FWJV46gIzrjC74NuBuddhgRqO9zce77fZjtR5YMy1IgrwKp2PyKKs37
 KNPQ==
X-Gm-Message-State: AOAM530DvlrvfDHDAXibBat2w19EreMJiWUKRsPCeVucZz/sBunDZw9U
 uT95nca7OCB0atDH3OSF3h2VpTCz
X-Google-Smtp-Source: ABdhPJzhJsiGmm57RqLtf/iFsKrw9u/sTyr0DH86BP3kUZ+fjI8dXtz/ju00Z88Xrx/HZU/65JV9og==
X-Received: by 2002:ad4:5668:: with SMTP id bm8mr21733379qvb.248.1591034574076; 
 Mon, 01 Jun 2020 11:02:54 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:02:53 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 008/207] drm/amdgpu: set asic family and ip blocks for
 sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:20 -0400
Message-Id: <20200601180239.1267430-5-alexander.deucher@amd.com>
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2a284d4bcf3c..3b6588e15c6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1758,6 +1758,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	case  CHIP_NAVI10:
 	case  CHIP_NAVI14:
 	case  CHIP_NAVI12:
+	case  CHIP_SIENNA_CICHLID:
 		adev->family = AMDGPU_FAMILY_NV;
 
 		r = nv_set_ip_blocks(adev);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
