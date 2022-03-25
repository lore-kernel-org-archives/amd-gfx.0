Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B8BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 09:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4461A10EA79;
	Fri, 25 Mar 2022 09:41:50 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB6210EA79
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 09:41:49 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id j18so10061495wrd.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 02:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2k5W4EKfiqUdIaqglI+EnCbkgiOb46iR5/LW+/N7v3U=;
 b=A1x5fUrXY9QwcT7LsyKltPLON2vhGgrDaqQwMxos90TyvfBEz+mBcg8yYi3HruZlay
 t+96OuZ+oKiWbZKVDP/qQu0ELbmPzIgk1qWphxHu+1+1oskY3o/Ca9RrifdIiGY1HM+u
 yHGh9yKjJr/7em2pYQ8NUJm5Vo4zOgJ7lL1jKvE8yQdqsdbfHmU9qewpM5BKRXzqAx/1
 lmfrIYaL5pVQQWngLiuKz9umlV94jxblVG8DmXEHSiFML035Y75xWQIgY+BvLDydkA72
 RhUneb6pTegXfA6HWTJu2jmN+a5xr7C8LyfzvB0wQI5mlq+3CnVrvlsLXH+xM3F70Ijh
 6yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2k5W4EKfiqUdIaqglI+EnCbkgiOb46iR5/LW+/N7v3U=;
 b=yNgsPEpO2UpB+T8DV7dn06HUakxwaPNJVXqWBDH12LkwhpjYWhM1OdJOrw2c8dDp+F
 JwAz1kaK/ct6txpUKKQKFvRyy2e5AuK3tAbGadSail5oj1ltGl8AJWgFM/I4UPgYzpBK
 FUSwieLFYN6I20DcCf6iZIO1sMLdYLPp6B/GQvEPtgx0YQqasJQHFOsSk48Dc2dtCRkH
 qlwE6UWNDASeSfpYwNiNGP9x9EEQ0MWkfBmjP1/uZyI65ttnf1IvDG6tMXJ80h/B56cA
 09Xa4uFspJwqdIRrWuG3jFowQn0o1sbuKhXK/bXpQeIdWPWdvyHyjvPcObRWszx0d2mg
 YTwQ==
X-Gm-Message-State: AOAM533AqTKYWYTxkxZJ29hqUbYd5ZED3PCDA7F7KIvdwi7FGl6r6ByW
 BOfmIrXu7fqneJu0BSmgeInEk8V+jSc=
X-Google-Smtp-Source: ABdhPJyZCtyStktXbK5YNxAgxc3ubKcjIBoGQ/WmfxpX7QReC1F/otGpFFLTyTXQfLmOsKWda1b8hQ==
X-Received: by 2002:adf:e197:0:b0:205:7b24:678f with SMTP id
 az23-20020adfe197000000b002057b24678fmr8375776wrb.670.1648201308100; 
 Fri, 25 Mar 2022 02:41:48 -0700 (PDT)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a05600c144a00b0038ccc75a6adsm3737330wmi.37.2022.03.25.02.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Mar 2022 02:41:47 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix some kerneldoc in the VM code
Date: Fri, 25 Mar 2022 10:41:45 +0100
Message-Id: <20220325094145.311420-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix two incorrect kerneldocs for the recent VM code changes.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 48f326609976..fa4def290dec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -89,7 +89,7 @@ struct amdgpu_prt_cb {
 };
 
 /**
- * amdgpu_vm_tlb_seq_cb - Helper to increment the TLB flush sequence
+ * struct amdgpu_vm_tlb_seq_cb - Helper to increment the TLB flush sequence
  */
 struct amdgpu_vm_tlb_seq_cb {
 	/**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index a821ada5f8ca..ecd8a3d60803 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -620,7 +620,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
 }
 
 /**
- * amdgpu_vm_free_table - fre one PD/PT
+ * amdgpu_vm_pt_free - fre one PD/PT
  *
  * @entry: PDE to free
  */
-- 
2.25.1

