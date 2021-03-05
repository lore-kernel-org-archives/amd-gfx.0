Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72982C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 04:53:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0810F64EF6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 04:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0810F64EF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADFAE6E0E3;
	Fri,  5 Mar 2021 04:53:32 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 519576EACD;
 Fri,  5 Mar 2021 03:54:43 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id l18so1103044pji.3;
 Thu, 04 Mar 2021 19:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=NAXf8RMnJpADBoaOf4LNGzMlYrRlmVtLwiw8GRRuOZU=;
 b=pIW0aBMY2TlkhvRip0uhHih55G5srjANFX17kViGM/RnSdxQvkzO6ZSljohzCwH5Zr
 c9YB45hISibqfNFvojTbHLX1HTT1g5lErjVwENvoMqXYKValn6vh0apJYur5RWOG5s1d
 aNMXTpmcGotESELfZzJwxm4MKgEYpCy1b6vdd4Hj9yhsW2+Nx1ZupczssrvXW3KUkqpZ
 tiUnPolHwO7+bQAcjr+/sRvlxvWz28sk1BTpXnMzMQC2wK96zZu6EQNORbQ7wYsfIu36
 tw9i+CNpyXrW4kOGBVzxWIsMAKbFvvZY5IpaOroinLQ+LqTUAtWNQ7uPRa2JpBRCkJWt
 Nx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=NAXf8RMnJpADBoaOf4LNGzMlYrRlmVtLwiw8GRRuOZU=;
 b=f0PiDCNMrm6/Lb2TNEZeya08Rtofd098fGHag4WZUTN6qw2FRC0yeA1DX+cImdMbTB
 E3zUxYK+Gg1DCvaWhwNZPFITCAzKE0MfljHwXLdX66K0FMviVkgyHjFCjq/i4Zj+xZ51
 JSFKA3hxqVfSAQG75bmiLn90/jw4vc+PTPu8sNiqEHryv7z5bqBjDugFW+Vl+/DxHq0h
 i7w3ZEUVB1kBZjQnHZmFxl470AYsXIvh+9gVohiq65JLhEIH6sQofv+ZbPQRHAth90oY
 W50vUfnl0Cljeb1y+V/0UU2UxopNGtZ8ZB/6EviJ88AX0B4wzxVC1hIyV54Ysfx1OEJ0
 xEIg==
X-Gm-Message-State: AOAM530lzXutvG/ntv8ex5wBxrBwd+3B6/2WvY0kDTvx6oHRsikXdBkA
 Fcas2vXtqKARickupQiIZrw=
X-Google-Smtp-Source: ABdhPJxFhc5WEZjHgDo3N8QWr8dMIKAfsosSITeeqCXpCs9fHejy0sOsY0exXfysxg4kvuI35YrD5Q==
X-Received: by 2002:a17:90a:5901:: with SMTP id
 k1mr8030028pji.213.1614916482952; 
 Thu, 04 Mar 2021 19:54:42 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.129])
 by smtp.gmail.com with ESMTPSA id w4sm589207pjk.55.2021.03.04.19.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Mar 2021 19:54:42 -0800 (PST)
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, evan.quan@amd.com, Hawking.Zhang@amd.com,
 kevin1.wang@amd.com, Likun.Gao@amd.com
Subject: [PATCH] gpu: drm: swsmu: fix error return code of
 smu_v11_0_set_allowed_mask()
Date: Thu,  4 Mar 2021 19:54:28 -0800
Message-Id: <20210305035428.6750-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Fri, 05 Mar 2021 04:53:31 +0000
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
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When bitmap_empty() or feature->feature_num triggers an error, 
no error return code of smu_v11_0_set_allowed_mask() is assigned.
To fix this bug, ret is assigned with -EINVAL as error return code.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 90585461a56e..82731a932308 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -747,8 +747,10 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 
-	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64)
+	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64) {
+		ret = -EINVAL;
 		goto failed;
+	}
 
 	bitmap_copy((unsigned long *)feature_mask, feature->allowed, 64);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
