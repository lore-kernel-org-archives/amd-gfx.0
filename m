Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F3FC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 13:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9679E10E29A;
	Mon, 24 Jan 2022 13:55:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E08410EA38
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 13:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643032417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=10jjCwVWraQntNdBxVG806Q7wvKbwg1gvSBpyTQbEiA=;
 b=KauLkxBkqXPBaLxVGXSuNMMpzZ80s5JLm0FM5FNLt41Mac3bgT1mhH0Pt3kZNyfDMfk9fm
 T1JKz5Sz0U+9dvpS4GPcMtOawGvIScqU3SjaA3uCNYfQO5e3Z/Cl8+2+eGouTPbByToI4D
 ffEj9RYeeEgQa/NqlkUIey7hVQFXI3k=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-m1V3bhKDOWu3a5rxpthcvw-1; Mon, 24 Jan 2022 08:53:34 -0500
X-MC-Unique: m1V3bhKDOWu3a5rxpthcvw-1
Received: by mail-ot1-f69.google.com with SMTP id
 h17-20020a9d7991000000b0059b4230fc63so11435165otm.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 05:53:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=10jjCwVWraQntNdBxVG806Q7wvKbwg1gvSBpyTQbEiA=;
 b=7+DekTcJl5tdb5dWo1j7I6CoJxusWCSZOio1In6E/CFxrGvrv20O9qa3t4KJrM41Ly
 S2lDqT/hm2+REDktDyk/CFiyC+sMj5BxHGUBQc3CKfYBzl2JUgcXClR6xM9MrAs+kkWd
 uvjN92EGkI3gsK7FnVS9x9hNu0s0tb66iw0zO+zMnGKmjudBFrAFHX3yvys6XSm+cuZL
 gTNdPrsfnQ6R12mZKqUOFNb9pRhcbVuu8xfSWM9SxJHUgDRMmlirhxpVyx9sOLBvT2qx
 3pRumbV6wy26Ow4W9dp3bQqtChVW825vu0V0AyfpV9dZcrThKi1LEbTlPY4yP3rPD9DE
 nzCw==
X-Gm-Message-State: AOAM530ql2troSLbUictWXQbjPGA51sg5F1MnmmzCR3IwOJKRLUDmZpH
 RYRWbUsJi7fVGyCrIIrz879PifpNmZ0B5UjKuKkvc3zP1Np9gEaSYEH3xSAm8q3P/ak8zhcUZMV
 ioM33tpRj7jN8N4Qn7OFL+Zl20g==
X-Received: by 2002:a4a:d095:: with SMTP id i21mr3016402oor.66.1643032414028; 
 Mon, 24 Jan 2022 05:53:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXcXYp8AXPTplh6to4AiTnWP2fz7OgXjj9IzEQpUNCJmvn968uNUEQkbgSQYBOEJwbNzIXMA==
X-Received: by 2002:a4a:d095:: with SMTP id i21mr3016389oor.66.1643032413803; 
 Mon, 24 Jan 2022 05:53:33 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com.
 [24.205.208.113])
 by smtp.gmail.com with ESMTPSA id v26sm1881619ooq.20.2022.01.24.05.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jan 2022 05:53:33 -0800 (PST)
From: trix@redhat.com
To: evan.quan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch, nathan@kernel.org,
 ndesaulniers@google.com, lijo.lazar@amd.com, darren.powell@amd.com,
 guchun.chen@amd.com, Arunpravin.PaneerSelvam@amd.com,
 andrey.grodzovsky@amd.com
Subject: [PATCH] drm/amd/pm: set min,
 max to 0 if there is no get_dpm_ultimate_freq function
Date: Mon, 24 Jan 2022 05:52:59 -0800
Message-Id: <20220124135259.1057828-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-Mailman-Approved-At: Mon, 24 Jan 2022 13:55:48 +0000
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
Cc: Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Rix <trix@redhat.com>

clang static analysis reports this represenative problem
amdgpu_smu.c:144:18: warning: The left operand of '*' is a garbage value
        return clk_freq * 100;
               ~~~~~~~~ ^

If there is no get_dpm_ultimate_freq function,
smu_get_dpm_freq_range returns success without setting the
output min,max parameters.  Because this is an extern function,
set the min,max to 0 when there is no get_dpm_ultimate_freq.

Fixes: e5ef784b1e17 ("drm/amd/powerplay: revise calling chain on retrieving frequency range")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5ace30434e603..35fbe51f52eaa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -121,11 +121,17 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 	if (!min && !max)
 		return -EINVAL;
 
-	if (smu->ppt_funcs->get_dpm_ultimate_freq)
+	if (smu->ppt_funcs->get_dpm_ultimate_freq) {
 		ret = smu->ppt_funcs->get_dpm_ultimate_freq(smu,
 							    clk_type,
 							    min,
 							    max);
+	} else {
+		if (min)
+			*min = 0;
+		if (max)
+			*max = 0;
+	}
 
 	return ret;
 }
-- 
2.26.3

