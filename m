Return-Path: <SRS0=3NI5=5Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BE0C2BB1D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 15:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AABA120753
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 15:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LELtXpKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AABA120753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 685B56E24B;
	Thu,  9 Apr 2020 15:43:04 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B78366E24B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2020 15:43:02 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id x2so276571qtr.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Apr 2020 08:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YEUP83zJtiXjKf5FPe/FKe+gRdOm3jUefYNvMb2J8A4=;
 b=LELtXpKLs34J1ZwNGaacx4NCeTgqbHyOz1+o47rjHjC1JHTHkd0o9jcUviEMFfpfCO
 hCk+W5tASNM1QY7LIaRuvDFuu/JFvRIvqLR3BwEccQyOx9qZrQD4PlZUbHXByYR1DXj/
 IIOjW8/oRkPVRx6Nged3Z2jb9pH4f4f/NV07rOv2Z9KcZDAgg5buMjw3IKYjpZlASR27
 D1NngxXM8ECvxQjJav3El+kNDEJ9LTA40upK+LsbkhTe3Hx2GlWb2/6afit6O+CQbxX2
 ocaWSHzAe29yIbtqA0OfMD5O6U3E8Vu7nHgnElqu6vdCzmyemDzTQrUSzTuDxB7bya5u
 01IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YEUP83zJtiXjKf5FPe/FKe+gRdOm3jUefYNvMb2J8A4=;
 b=Wo/g1+Hl59+JFjtvfgyM77AqW0KSlIovb6nmLAJJQkuLuxFGr8pEwI3WIsoVNM3eTJ
 8qGIvUCvAnz0kqZMrDn8MFgwfAgIr0ucsa1sJiEUdd+cjVQDAYkLQ44d9KkItZU9kRcw
 S3jUA9vMFiYPHKzPzoXjtb6MRkwZCjKd5bcVsOejM4OE5+5T9hG/elATP9O7cDRWUEOR
 MbMPW1d1ZyzwzOvTCTdVe7gAw8Dhx/Ned4Kqa+7XEcDxupijVA65qqU+OcVzg1iEpLPg
 UFFyU0ZnCSxosVrSsf7qVg8v6q+6Vr8m75tJ7Aqrl7BK8TWuhvuf/9cCCV7r/ERDLF1R
 v9Iw==
X-Gm-Message-State: AGi0PubCyGqWyOxxfB9uooDYRR/t74a3ApYt4OTPoDQyUvmDNqgYl8rL
 GyXzUtItAV+uXLVqJKwR+Pcnz112
X-Google-Smtp-Source: APiQypJYX+baHjGF581AF7LQAAiX3UANdn+qLhJNTz86r7/yMq1GanHZo6m6fl55yR9dH1KPnfsbDA==
X-Received: by 2002:ac8:d0b:: with SMTP id q11mr5389062qti.83.1586446981444;
 Thu, 09 Apr 2020 08:43:01 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id z90sm2455325qtd.75.2020.04.09.08.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 08:43:00 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/gfx9: add gfxoff quirk
Date: Thu,  9 Apr 2020 11:42:53 -0400
Message-Id: <20200409154253.77102-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.2
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

Fix screen corruption with firefox.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=207171
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1d18447129b1..e14ff65ac735 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1231,6 +1231,8 @@ struct amdgpu_gfxoff_quirk {
 static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=204689 */
 	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 },
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=207171 */
+	{ 0x1002, 0x15dd, 0x103c, 0x83e7, 0xd3 },
 	{ 0, 0, 0, 0, 0 },
 };
 
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
