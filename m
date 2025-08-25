Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F18ACA0FE9
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7BFB10E58D;
	Mon, 25 Aug 2025 21:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DiCKc2kY";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E1410E5A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:46:55 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3c98b309804so1216064f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756158414; x=1756763214; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XFdmORoZUombVJIp4QfR9XdB6u8WApE4NhDTg91+kaU=;
 b=DiCKc2kY45h3rFVZA519aNwBOdEKw4Zd7dAv5vyUwchRGXTGGYC/2wgJaReTcbjeJx
 8M5Ub94LshC6IERv92Z8BhcJkFyCa9m1blQ/lKAOjEupE++Z8uwlqCISxaJKzBKmsqKy
 8p1eWCcK9BPHed6VRTsPwJavPCu4MLlb02arkk10UMu1dIJ1s22cR1/tToeGwwboZmer
 8ilSjjHmSBuGm+p6vbqLrAabFb1JeCvmWRvCkX4hde2vKL+gL8YtsHju35SOBM1eQybq
 MpxoLgncmGcAj/2rIEGXlvHPT/ykVhLAPRD7DMt7wa/U/j5SSe8kPGKhFp+myjOkc4AI
 1v9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756158414; x=1756763214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XFdmORoZUombVJIp4QfR9XdB6u8WApE4NhDTg91+kaU=;
 b=j5cm7L54t1OP4NScQh8sccFN/2dfSq887FccJK9GhrDy7SR0/T9YZTbjHHvpUWCb9T
 nlAIO86Cx+9d0Ze9YrOFsABbQHTT7W9Zk3pJtKCEubIaf7yk0/pbCslZHVgO9sAodKPl
 C1pBomjZFItmfxXoVU+uOuikufvw2Ie7vaKTsqsuVP30Y8M4V4Zf56lormfDAc41waKN
 xWF+zbj84LIrRuTLgG9DUyxeKWK1jISJe0DqwNBKotyPc2q6719HV1Zccqo42N82at3q
 3AqoKcoK4NZC/Q/43FlGDqJ9sDnARk9kBjK/zCxBuA93UZ5cl/6F5bTkZHvoJwUn1hau
 75jA==
X-Gm-Message-State: AOJu0YwdBxLmkoZkGl7UGK3fz8y3wwZ5z0WIKBkQVr3ISW3deReHthIH
 X9yunhB7pgGw92ZtQZlz8zf4NlAMGwalA0e6r/Qw9yW+C7jLXQgYC/FemqszQg==
X-Gm-Gg: ASbGncuAzJF+EHNxtDyuuTivJTD1AAIMK5gkp8tfv6nJVt9G9i/BPaYJVgpBPzJhJUg
 eyX7jp8SnpP5voolc4MOBO2+9jimNXcuXkRmcdHYFovEkcS/zTn5A+zh5A/T+F0Jynmrw0nQErB
 hySOX4uiDi+X2GwkwMhF6oTsRR5+okuRDCUWPk+3SIr1w6QBJ0MyvDDJa5+fdTcWvdvr2Wwy+kC
 n8R9/MvmuECWxpGYzuj22A5ju23B367lmpkaEe0yyXzlMLQKAejxQhPKG/+/JyrIXjLOJJvYOni
 zJ7DXdPMdXUqcRHC6lW9EwcMUbOLHgOW43Crb5RrMCus2V8LiG2iXNU3srJ0WtGdzqrJ1kZULpi
 Orl2to/k8uBKWJV0jbmOOuzQtMNloCseN+gK6r9AjUEmcYtSygEZNFTO2XFuXQCtgRuSbpas99B
 ext+2/y7/gagpVhINfxvsP8H/YzA==
X-Google-Smtp-Source: AGHT+IGRytdga65KGkHvgrxj5sAzkqIh79ytAb+P4ces1EGV+dJj/N6/5b+J0ZsTXl/+cLH4hfawaw==
X-Received: by 2002:a05:6000:40df:b0:3c7:5844:333d with SMTP id
 ffacd0b85a97d-3c758443855mr7028244f8f.45.1756158413876; 
 Mon, 25 Aug 2025 14:46:53 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7117d5977sm13348110f8f.51.2025.08.25.14.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 14:46:53 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/8] drm/amd/pm: Fix si_upload_smc_data register programming
 (v2)
Date: Mon, 25 Aug 2025 23:46:31 +0200
Message-ID: <20250825214635.621539-5-timur.kristof@gmail.com>
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

Based on some comments in dm_pp_display_configuration
above the crtc_index and line_time fields, these values
are programmed to the SMC to work around an SMC hang
when it switches MCLK.

According to Alex, the Windows driver programs them to:
mclk_change_block_cp_min = 200 / line_time
mclk_change_block_cp_max = 100 / line_time
Let's use the same for the sake of consistency.

Previously we used the watermark values, but it seemed buggy
as the code was mixing up low/high and A/B watermarks, and
was not saving a low watermark value on DCE 6, so
mclk_change_block_cp_max would be always zero previously.

Split this change off from the previous si_upload_smc_data
to make it easier to bisect, in case it causes any issues.

Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index b16009d342c3..db46fc0817a7 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -5846,11 +5846,11 @@ static int si_upload_smc_data(struct amdgpu_device *adev)
 
 	si_write_smc_soft_register(adev,
 		SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
-		amdgpu_crtc->wm_high / first_crtc_line_time);
+		200 / first_crtc_line_time);
 
 	si_write_smc_soft_register(adev,
 		SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
-		amdgpu_crtc->wm_low / first_crtc_line_time);
+		100 / first_crtc_line_time);
 
 	return 0;
 }
-- 
2.50.1

