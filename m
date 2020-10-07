Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE505C47095
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E332064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9bF0L2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E332064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B57A6E97B;
	Wed,  7 Oct 2020 16:32:56 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64DA56E979
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:54 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id q26so2404704qtb.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gBhcjXJbCCNxFoXu1vSSKtve6DrqmB2rIPOUF1DWRGg=;
 b=t9bF0L2OfbMjIvLDgzDADQJPetN8RWCu5dpajiAJT/0P9cdqhumf5Qhph35ZlallKB
 Pg3N8paWBUJMUPCD2e0rgxyGVMNVf1sIHonQiHL3tokyM98bGclRcWWQXwQRlZQG9XZ2
 KPct/RRZbTg60vdp+C8Qxdf8r02xaDOFgz1/jREBB5xcjSRhNNkyj2vNmU4SAC+3qD8l
 S8xfcMGahsL7/feeWmXEVXNLMv77sU9PpKYu5SyBlrQYH9vOZy2J3tVCRAWFaFlg3H2A
 U+ZKbWz7kEy/BP5l9Zn96PuPHls1fbRdN4JJjzh3aSErCM7MwTQyeQ3kLj8NATG0oXFo
 iZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gBhcjXJbCCNxFoXu1vSSKtve6DrqmB2rIPOUF1DWRGg=;
 b=LRdpjYYXEE9ZqMKyV8wf0PozuZshRBbY+4hAloXBujiF0pfN6RsmmFtrApgFL9hz3U
 vL8VONHjnfkyHw6671lWeciFcw0M2+aRN+FqAwAIzGD6x8GjW5GujKdtoL6Xyl5hBVmq
 eID/yn5B93wTdzz/vlFP5zPjVh2GGdMA1zbWWrG8x9fxwwXkRAFV7GlKRYFFk+LIKB/0
 UjJzsmknhFuSDGSjTWWuE/h32D7i4wrN2uDtMGS5PZyHElEtN1P+sY5Xn13Xypc1Tab0
 UtVyAke942072G6c1mfjxXKZhsvEGtXs7bL57ZB+1//+430fCMmBL1QipmsH4Q/JuEdU
 7OOg==
X-Gm-Message-State: AOAM532ZKzCjLzVvYlU6k2RTLteJ4or1xonXsBzDzagBy77jls0YTi4P
 W3dFPYtJ7yF2DmhwBuFicB1V5bJ83bk=
X-Google-Smtp-Source: ABdhPJxW3RvtcBf8WQ0Ym5pFHDrh/QSMFsMTCF2Q3AlicaCYxbWfp2FH0qxFCDP0V2MUzfVGdrUU/Q==
X-Received: by 2002:ac8:b8b:: with SMTP id h11mr3966709qti.28.1602088373407;
 Wed, 07 Oct 2020 09:32:53 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:52 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 48/50] drm/amdgpu/swsmu: update driver if version for
 dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:31:33 -0400
Message-Id: <20201007163135.1944186-49-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Per PMFW 59.7.0.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index ee13dad65e7b..2fba050b3180 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -33,7 +33,7 @@
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x39
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x5
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x01
-#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0x7
+#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0x9
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
