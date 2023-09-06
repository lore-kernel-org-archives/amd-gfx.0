Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88348EB8FD4
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 13:25:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0C6010E654;
	Wed,  6 Sep 2023 13:25:08 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E05310E5FA
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 10:54:43 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31c65820134so3011315f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Sep 2023 03:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693997681; x=1694602481; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LCKeiVfXbpOHNlhl0gQNMuWrM7Q36OD6Fy+jaBM3zr0=;
 b=Ad3xXY/acXv6X86+iwmvRHC1Fx3T6O/moSLWcGPlzYHSLYEnLsS5lN0me1h9J4DKBK
 gOyKY0Z9/WYzp5aZirKfV5CZqTus7btjN3YzD5vOcFQTPE3JVKnyHXmjdfPl4bLE+7Gh
 YUPUrIj1DK22o0E8eY8s3TrPUcY/D4ON89Nys8CFGnkb4kod3kCFtdTikagb55BIxqIb
 q7ceyrdbE4FHuT9h9jHjP8tBfqzFEZ07dmgZGpz3jlXWyC2lXM4wugnB6hwa1nExidGA
 GA9EQvHYatI4ixyh336IZ9Pr//kQ4FINYwDtRMzi5Fa4KsDxF3eEqlkrNyEP8bEIGAM4
 sYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693997682; x=1694602482;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LCKeiVfXbpOHNlhl0gQNMuWrM7Q36OD6Fy+jaBM3zr0=;
 b=BUmVrCYOaqIki7UKPi9nRqzlj3nhatzuW3RLAMkYXb28lAe8rtov1HoiprbxJHnVDo
 4Qlq+bRSilRvx/6cr5qXOzvAHFcWIKUzuwgYPBRWTefy8VaGvpssO01qYyOQ9Dw56MKq
 sXcZo4ce6v4UkLu33/I62YOb3g7WlqdEeA6t37PEPyryFahpbW4UjbrqcEGm1ZECDFqK
 4SKsxriGZPMQLpG14dH9YKNTp+KMRRyRiClhff+XMgp3CzWo3+IOzVI5qIWO/BXMCMEb
 Fw8bdXNSphQVNbSnzHeR3P+ULpt0YtDvqtKjKyBXaIG8XsPevcZQ+w8aGMHoaMskX6Az
 5tsQ==
X-Gm-Message-State: AOJu0Yz8ka5bnc/fwKAE6+MuT0sfArUhTQOqN4ogA8SxpHHI6i/RPwHk
 IujIO083Yz6d7KgD0zXNcb7Z3A==
X-Google-Smtp-Source: AGHT+IEgpsMHaoM6HOfWi7u9qCzbaxmCm1tHHH2l8saUdqiH4tWYuh1cPZiI1bMgsHD5B4zKGALA6g==
X-Received: by 2002:adf:fa46:0:b0:317:6ef1:7939 with SMTP id
 y6-20020adffa46000000b003176ef17939mr1722000wrr.23.1693997681665; 
 Wed, 06 Sep 2023 03:54:41 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 r12-20020adfce8c000000b00317afc7949csm19979128wrn.50.2023.09.06.03.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 03:54:41 -0700 (PDT)
Date: Wed, 6 Sep 2023 13:54:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Evan Quan <evan.quan@amd.com>, Yang Wang <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: fix retry loop test
Message-ID: <ea9bfa9b-2689-45cf-95b7-57577f0d76c2@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Wed, 06 Sep 2023 13:25:05 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
 Lijo Lazar <lijo.lazar@amd.com>, kernel-janitors@vger.kernel.org,
 Asad Kamal <asad.kamal@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This loop will exit with "retry" set to -1 if it fails but the code
checks for if "retry" is zero.  Fix this by changing post-op to a
pre-op.  --retry vs retry--.

Fixes: e01eeffc3f86 ("drm/amd/pm: avoid driver getting empty metrics table for the first time")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Obviously this only loop 99 times now instead of a hundred but that's
fine, this is an approximation.

 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ff58ee14a68f..20163a9b2a66 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -336,7 +336,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 
 	/* Store one-time values in driver PPTable */
 	if (!pptable->Init) {
-		while (retry--) {
+		while (--retry) {
 			ret = smu_v13_0_6_get_metrics_table(smu, NULL, true);
 			if (ret)
 				return ret;
-- 
2.39.2

