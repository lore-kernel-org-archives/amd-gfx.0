Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEAACA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC59210E291;
	Mon, 25 Aug 2025 21:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IfOLIasI";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B90C210E291
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:46:52 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-45b60fd5a1dso11766685e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756158411; x=1756763211; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JaSdc0BSgIHLfjLQqOtSaVAqfWc35w9KEE/WEn80kFA=;
 b=IfOLIasI8fIHlznaMzZr1w3WWiW/OhMuzuL3N+fVkvyhwW/lVdk66ydjLWLrU8QgCw
 l/jLJDta9QIjmw/5IRxVxjooVrxiE60ci+8unqel7fJetaTduKMu0Z04uYnU/4236Bau
 gtHO+DD61um6C4Z3LWg1LgcaE/96DDVDQqzhMFaBtA7HKhvh5PkoWCdLEOLxRGbmek0E
 s2h+SZL83bLxWKCFfJvmW1zjmJv11KhWKSsBNoYzmCHM6qI+yqjj+ky7uxqCuwBgVfEP
 bATyQ9xxO2+j+FRzEQ22I4oHjQ0R+HxgnXCV4nYtABPYvCFgdMP8frfj6vPqr6iudY1S
 fxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756158411; x=1756763211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JaSdc0BSgIHLfjLQqOtSaVAqfWc35w9KEE/WEn80kFA=;
 b=KNxuNlYBaRSOFF2reI4ERlgpl29VpPehqQWgoFh/s8noTUm3Qk4yBKB5C1tCA/62dJ
 xPvOPyj7NwKijjq0WMeB65Q49BNsAt9H0s2iq1Xec6M7De4rYOn+DtnkLRmRoROUeINh
 4hqJCDl2o4WBeSfwcHfVDItFR2Zxb2cjm/Q5QfNguQRxI5DAlBgk8eCvuWs0tzzGtVLS
 BHDxR5vD6YmrEWiDZ+1fU1HxCM8o3oxafI18OP67zy4iKzriMm4xfsCISyPqssdkNooX
 M5xUH6OHK+GKj3wnW+aRdRAGxjFJD+Ox4owIb5nbS9bumtZrsg2YYLr63Uz+afx1PABL
 3dnQ==
X-Gm-Message-State: AOJu0Yx5onWC7h+wilD1tFi37lUSi7lAVRW9wjpOJQCQ43TrExaJujwv
 9qgjBShtm82HzaWjlg9io3437q0NQrbGxBDaoPAw+/ioLe4fmBVWAjD1ad5nbw==
X-Gm-Gg: ASbGnctmymcBrNQusY3w+tQZLvWZB2wAr/IMaaxkHqBRjuA8oJk/sUKWhW9H7yY7Unj
 AIdRux1OH8vHtGONysrnUfhMu1nzKYSbOT0iqfwU5Kb6GWu9nFDqg4FccdR2cPXvZfIKPovWhTF
 2SXagQbrtx8xxavEthfUhtpp+aEOtmPkWB0UhyoxQKdMMi+3YGV18FVFry/jR5z9kYz4gdK2OIf
 ZDWFBpE4zNa30+Jrfw17cb+afQq5qZEx8M5b+HJdFa9Bw+MBB6VtDqdoQXWJ3iJTFgSe8Ei+VJb
 h6lzGKvWOgyw+MJ8xcL6MqLEBs2zd5hE8Ol5Rh0X7z+3yb+4fTnmgXI7LaZ+2gjXbe58NQKgmal
 BCPxdcu2IQCdO+fI2yTcKoB2ryCPFTIKL0fSNPu4J6nMbvKNOhmwTYvbwk3FOxrMfa6nfTHfo+i
 LiRhmTnZ+irBhzdlY7TacHjvp1HQ==
X-Google-Smtp-Source: AGHT+IEJtV71q59hOqTx0n8LrqJqnk07hb+bTzSlVoeEdqFBFcYdTJQIEN1G+YntcVXUemgT77BmFw==
X-Received: by 2002:a05:6000:310c:b0:3b8:ff5e:f3cf with SMTP id
 ffacd0b85a97d-3c5dc54284emr7759156f8f.32.1756158411131; 
 Mon, 25 Aug 2025 14:46:51 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7117d5977sm13348110f8f.51.2025.08.25.14.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 14:46:48 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/8] drm/amd/pm: Disable ULV even if unsupported
Date: Mon, 25 Aug 2025 23:46:29 +0200
Message-ID: <20250825214635.621539-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825214635.621539-1-timur.kristof@gmail.com>
References: <20250825214635.621539-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This commit fixes some instability on Tahiti.

Sometimes UVD initialization would fail when using DC.
I suspect this is because DC doesn't immediately turn on the
display clock, so it changes how DPM behaves.

Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 52e732be59e3..33b9d4beec84 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -5639,10 +5639,13 @@ static int si_disable_ulv(struct amdgpu_device *adev)
 {
 	struct si_power_info *si_pi = si_get_pi(adev);
 	struct si_ulv_param *ulv = &si_pi->ulv;
+	PPSMC_Result r;
 
+	r = amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_DisableULV);
+
+	/* Only care about SMC reply when ULV is supported. */
 	if (ulv->supported)
-		return (amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_DisableULV) == PPSMC_Result_OK) ?
-			0 : -EINVAL;
+		return (r == PPSMC_Result_OK) ? 0 : -EINVAL;
 
 	return 0;
 }
-- 
2.50.1

