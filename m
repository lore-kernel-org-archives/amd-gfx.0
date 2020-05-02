Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176A9C47247
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 08:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26B521582
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 08:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxJsTXbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26B521582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B2016EDA3;
	Sat,  2 May 2020 08:35:45 +0000 (UTC)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E261E6ED79;
 Sat,  2 May 2020 03:11:50 +0000 (UTC)
Received: by mail-ot1-x344.google.com with SMTP id j26so4194702ots.0;
 Fri, 01 May 2020 20:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TRgN7dqYpnfJ32iv0mEp+A1meuKHRpjuIr6fo6bZQDI=;
 b=RxJsTXbup9QlEvWS3tzliDOKUX4V8Ve9nGRFJT1tPzsN41ZaP28hHRRjaQmVMXYH4X
 jxts4KMj4xPuN0zLE+MUuwbxdM6n4rfUiJea6QlzNwcT5eJJQJclqPnYZbAM/QvpGcsR
 GxXMEB+FoAwX7zEcUWqYGmcYoGW10XFa9/FwFp7y9pF7D/Q5qN362YPRXDPgtyLgisqZ
 kzGuKyegQx5QjgazWys8w7f6+/aSLhn5Bp01HY+CiRPNiKZ2vp6+JaBOyJ3OVjRY39PW
 SGq2AzacvGQsBFLshM9JVauz2hcankfK0kJmBIJcB6CgNRNYP6pEqmmtpSr/XZ+jvudK
 Cv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TRgN7dqYpnfJ32iv0mEp+A1meuKHRpjuIr6fo6bZQDI=;
 b=T2N29MbIcu0DbktImyCP0uBucgdIpkBUWRb8txhfsq1EMRLTQcOMKAS0gOSwK1yVHK
 YNNVSzCD++b8M8BAWEjYCBTyN0NoCdLqx4wKvBexK+wRq25ql4aNNw9GIiymM8oHQCAJ
 xZcJfsNwKLaek0lq/4r4uPo4IU0rufUEQKomcs2DQ65Vy2qD7bM0TWPpMToxAxk6R4Px
 a6pJ0hZGvT/ccEI5C4uQipnt5yIxmfxLomdb0E0NFXQJTxn2Ik5wHVdPgUqRMeJSXoBC
 1JkGGWDFO1bTReFLG5M5MBtrkqa7gTCuYUjrqGEiBBMjV4Wrr0T0LzC8cjpJQDjUXgV+
 qBiQ==
X-Gm-Message-State: AGi0PuYUF43GC3lVtamNVeRSqKsB6ibDTI7XKyP6U5KdGUiZ/lzSENeG
 FfUdSVOgwZDi50teodnyMcI=
X-Google-Smtp-Source: APiQypKZcYdkpeLuzk63sx5uVK3c25pfnOfguhe3seCLZhWjtHD4C6Zuh/aw67LW6ih2Vhcg2sVuWw==
X-Received: by 2002:a9d:57cb:: with SMTP id q11mr6060158oti.11.1588389110029; 
 Fri, 01 May 2020 20:11:50 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
 by smtp.gmail.com with ESMTPSA id l6sm1317704otq.48.2020.05.01.20.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 20:11:49 -0700 (PDT)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Subject: [PATCH] drm/amdgpu: Avoid integer overflow in
 amdgpu_device_suspend_display_audio
Date: Fri,  1 May 2020 20:11:41 -0700
Message-Id: <20200502031141.2732221-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
X-Mailman-Approved-At: Sat, 02 May 2020 08:35:44 +0000
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
Cc: clang-built-linux@googlegroups.com,
 Nathan Chancellor <natechancellor@gmail.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When building with Clang:

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4160:53: warning: overflow in
expression; result is -294967296 with type 'long' [-Winteger-overflow]
                expires = ktime_get_mono_fast_ns() + NSEC_PER_SEC * 4L;
                                                                  ^
1 warning generated.

Multiplication happens first due to order of operations and both
NSEC_PER_SEC and 4 are long literals so the expression overflows. To
avoid this, make 4 an unsigned long long literal, which matches the
type of expires (u64).

Fixes: 3f12acc8d6d4 ("drm/amdgpu: put the audio codec into suspend state before gpu reset V3")
Link: https://github.com/ClangBuiltLinux/linux/issues/1017
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6f93af972b0a..caa38e7d502e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4157,7 +4157,7 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
 		 * the audio controller default autosuspend delay setting.
 		 * 4S used here is guaranteed to cover that.
 		 */
-		expires = ktime_get_mono_fast_ns() + NSEC_PER_SEC * 4L;
+		expires = ktime_get_mono_fast_ns() + NSEC_PER_SEC * 4ULL;
 
 	while (!pm_runtime_status_suspended(&(p->dev))) {
 		if (!pm_runtime_suspend(&(p->dev)))

base-commit: fb9d670f57e3f6478602328bbbf71138be06ca4f
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
