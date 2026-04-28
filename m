Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4C5FF885D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 12:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02A7C10EBEE;
	Tue, 28 Apr 2026 12:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dj6Zrweg";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36CC10E6A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 11:45:37 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-362bb3260f1so5472472a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777376737; x=1777981537; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1pkP0/dDsbN7BRJkxdoTN59hq9O2Teltgpo/B86M5m4=;
 b=Dj6ZrwegSiiEUwFFUD82QQ5j7GLoCtiPArU6C+VlAhzcK78/Pt39QhICQX7esGvXE7
 jTv1dl9eGgcaFLdQZSs0VJBjbZz1xOSCr1tFJnAw8jo7yaAFdBpKy6aTud/vZ1ZZ1rno
 71sg41xm5MS+t+uCnupxzOlx2afq36/adc1k/dMSeIz5ECkPI4Ol4Zesdp9wUPKLByoL
 mXgn5XPGZYlpfhgoFPe01REdAEOzphUMX1wtPOvhoXXMtElTTaVfvZn1IHm+eW7rrxhR
 Sbu7r/D09tYVuXha2w1psyseqZ73jbMDnGjgC6YWfC3+idveMuRPec1asC9dHW0uldIj
 D0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777376737; x=1777981537;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1pkP0/dDsbN7BRJkxdoTN59hq9O2Teltgpo/B86M5m4=;
 b=KMQlAcixqg43ZZ8JgPir8Q0+sBLW7h/NAZLMa0KCyYU58K2rg18fa1ikqCoYgKH0t6
 h2CU2YmMeT9L8KBu425ZZ+8nzLfP0jolBcAPIQnZtLXzFrN59jiY/qT2TKG99CAwyZMA
 SUbUkFS5BQFvJHbTVCtN8HEF4S8MgR7zgX5P/haW8Nnf/dKQw2q8NEvnlTVc41VCvva1
 gW7REU2ts/tq2X96y1SiozpMEkhLwXoFRuIvSQkIMXvm/1grEjmZNX3HLmROq9fmTIn3
 KjdnC1JdETHdKGg+PuhuYF2BjhRH9D+141AXPGuqUlaAZRBgT+elQQrwHBerwa5tUd6E
 c99Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9o23eEtxABLqBhz/Y9lIgtGgurC0y1Z49Y0N3jkgW1LigZj/f6tEyKF+4/SHxyMu1NubCcLiVD@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHKssxXPv/d0SX4oSmqIriAlLf7wL4ravhrz0ludoGxzc1cdh6
 KK5kvBtVsM8tLZ6Kl8Zqk8fF+E6J1qcN1W6efC7hGd20CUTiI00CCUPE
X-Gm-Gg: AeBDiesEDYmawt4+oWimZhqb5cf2yHxPuQhyWph3CneyejtDRHgbyob8LumZ7Av2GZ2
 dsIOh2Rb/plL5pJVFK8PSUWcIw8uC+88J4B/W1Ocop38dghlVJWbudgGQ8BbOdyy9ze94zf5xQo
 17zAzu1ZP65koDupDzPH19Kh5nJJSAMBBFqNg6tdkLMHFEn7l1j32X7LmSreJ3aTaIONuqfFAo2
 ei+1ryoMqxUKFKqifX/KrAe3l2AVIwDtK0VB7ti3MAgUKI7QBrE78lzjxrD0w5eUdCDekgPWx3X
 STQwK5axzK4eitGgWIkP0L2oVMSZ5c2mrItzgseMWiUqSFgZn8gukj3h3SLRPPxl6PjWYLQDdu6
 tTyodO+krGr+mjm3rDE/8Jry5eGiGBpZhd6+jtqm1bKwbkcS9cgQyMiXGUBKAvT8/JocMw822eN
 uisFpisgTBepCxAyOvMpv8G9c=
X-Received: by 2002:a17:90a:d64e:b0:35d:8fdb:4f26 with SMTP id
 98e67ed59e1d1-36491f89e50mr2890066a91.1.1777376737142; 
 Tue, 28 Apr 2026 04:45:37 -0700 (PDT)
Received: from lgs.. ([101.36.111.22]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36490fbfccesm2690890a91.14.2026.04.28.04.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:45:36 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Likun Gao <Likun.Gao@amd.com>, Asad Kamal <asad.kamal@amd.com>,
 Ce Sun <cesun102@amd.com>, Kees Cook <kees@kernel.org>,
 Meng Li <li.meng@amd.com>, Guangshuo Li <lgs201920130244@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix error handling in amdgpu_xcp_cfg_sysfs_init()
Date: Tue, 28 Apr 2026 19:45:21 +0800
Message-ID: <20260428114521.364863-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 28 Apr 2026 12:54:20 +0000
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

Once kobject_init_and_add() fails for an XCP resource kobject, we
should call kobject_put() to decrement the reference count for cleanup.
Otherwise, it could cause a memory leak.

The error handling loop also uses xcp_res[i] instead of xcp_res[j],
so it fails to put the previously added resource kobjects and may put
the failed kobject more than once.

Fix this by putting the failed resource kobject before jumping to the
error path, and by using the correct loop index when putting the
previously added resource kobjects.

Found by code review.

Fixes: 4ae86dc87850 ("drm/amdgpu: Add sysfs nodes to get xcp details")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index cc5f4e01e38f..315e33a9d7c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -948,15 +948,17 @@ static void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
 					 &xcp_cfg_res_sysfs_ktype,
 					 &xcp_cfg->kobj, "%s",
 					 xcp_res_names[rid]);
-		if (r)
+		if (r) {
+			kobject_put(&xcp_res->kobj);
 			goto err;
+		}
 	}
 
 	adev->xcp_mgr->xcp_cfg = xcp_cfg;
 	return;
 err:
 	for (j = 0; j < i; j++) {
-		xcp_res = &xcp_cfg->xcp_res[i];
+		xcp_res = &xcp_cfg->xcp_res[j];
 		kobject_put(&xcp_res->kobj);
 	}
 
-- 
2.43.0

