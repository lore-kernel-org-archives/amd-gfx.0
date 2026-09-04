Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC78C624D3
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 18:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3CFD10E58D;
	Fri,  4 Sep 2026 18:34:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GUcm4SBA";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA35510E58D
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 18:34:35 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-495437bb891so9795995e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Sep 2026 11:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788546874; x=1789151674; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xTGRgoRasqeHPsK3yaONdLKfC9LPIsYX5/8iWREQqQY=;
 b=GUcm4SBA4b1DJABwv2glWbdkZr5UKwcjCfZnhncPe52I9VLEa45RKpv9Kmn7nqVjUd
 hgo/9qT/w5WoumTlJ4I48T08DoUbwmTLRfWUYFB7cX5ZPzddq0urukzwHBrOIwRrcw3u
 MNcPRclUJytgqOqGQA3hR4eg2uJoA55GeB6ZyFEBWRfenMKWqgC58w70lztfGm/Le4Ku
 8sQnw8YHci3yObgGlWyZlp05mZ4U6N9qPQKzelQ7seYFGqBLKux1DLW0VZ9xl+hBLr71
 uVNUURAwMYoixFkmIiCrS5BIoO7mRePtrdCzzMIH0jST8LN9EWVWp9KZ+c5Twi2WcBut
 veQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788546874; x=1789151674;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xTGRgoRasqeHPsK3yaONdLKfC9LPIsYX5/8iWREQqQY=;
 b=rtleK7tCv3FdZwplsjW/czzy9BoxhHo1rw3xKUzzEYnRSzslVxv1EtyizEPx47qxum
 3jQ7lTpG2GnL0xlHvibsUeapozGc8j9CnpE+wtRf08aLcnWCB2hZOxos/txC3yhPTtQZ
 8QxXROJ3Gmn8xm27GI1kCSDO94Mykj2GhERiL4UJTQCvu0mBaI0TCAMPN1YklePx1T1S
 i1g5/WgFYmBJa0X7u6cDFVl2WJfpnyBXwoY09+y3fgwVhvtbryub/Y6BFHNDlTDtT3EB
 bGe6jfKp5HH7R9/pfNcWECr/RaANRQ8HmiWVuikqLqLV7IOSejXGy7U8DC6yvrjBKB9E
 NY8A==
X-Gm-Message-State: AFuF++nGq0q1WDdg9RMey74AlXzq9eFKpXN+JfKw7gBgq5SEVjHDtbJH
 bGbvIGgDLI7//EZL4ZDeRGwLcfbTXTMCbRKk1zCxjWTlXxCwj2Kn9BHEq4QjSzzl
X-Gm-Gg: AYBFou0FW06Iab0yUpCcTvePDqCcSKwngDu8PL03v748ugjRNEL8n/sJkSXNy77GQGS
 z0gdLqND3z58y+YG11Z9cwm7p5iSWZOMN7K0oSd2WfcMkOWOGRzyvRUDUr6XIum4O3rthgmagbz
 T5VmPCTawQZHE7GpH9d6m3qJT/ACMuJfUj/vtksvKqxaAXe8cIZNAcHGdvGkTJ2qBHFn2Lq346i
 7d96l5Vl5kB72KOibAd528djokOj+m4+/BibTMHEovoSkoWE4vncWnVTMQCoHxE4Q1/za5jQOaz
 BvfmejkMhsNI9o0Ko4e/Yi3aFxbnU+4YGbUGR3GFrLVUVOQu7UJ0sNHxNRvg0+7i6HxBFZdPyZH
 +o1AhmUSDlDuX+ocp19rW7SjrlnTqUxVU04LRJrNWD+vvvLehjXHHvdDxvQe1JEAJKL6EBtQ0hQ
 d7QPARvm2syAEE+EBDP2lWDRCNpzPPu8oqWc6DI6FcGgPvzJPoR1ac1b+eNZfQU0028hZ53XGPq
 XTfXAkBmxtO4hfubJ/p
X-Received: by 2002:a05:600c:3544:b0:49b:8f5e:51fb with SMTP id
 5b1f17b1804b1-49cf82bea0amr62786355e9.3.1788546874157; 
 Fri, 04 Sep 2026 11:34:34 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7703cefsm118373095e9.5.2026.09.04.11.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 11:34:33 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/5] drm/amdgpu: Delete unimplemented GMC v9 soft_reset() code
Date: Fri,  4 Sep 2026 20:34:08 +0200
Message-ID: <20260904183409.571117-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904183409.571117-1-timur.kristof@gmail.com>
References: <20260904183409.571117-1-timur.kristof@gmail.com>
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

The soft_reset() function for GMC (memory controller) block
of Vega has never been implemented, and there are no
plans to implement it.

Let's delete this function, it doesn't do anything and
also isn't called from anywhere.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 633772fa71fd..999c4d9a6deb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2312,12 +2312,6 @@ static int gmc_v9_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v9_0_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	/* XXX for emulation.*/
-	return 0;
-}
-
 static int gmc_v9_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					enum amd_clockgating_state state)
 {
@@ -2356,7 +2350,6 @@ const struct amd_ip_funcs gmc_v9_0_ip_funcs = {
 	.suspend = gmc_v9_0_suspend,
 	.resume = gmc_v9_0_resume,
 	.wait_for_idle = gmc_v9_0_wait_for_idle,
-	.soft_reset = gmc_v9_0_soft_reset,
 	.set_clockgating_state = gmc_v9_0_set_clockgating_state,
 	.set_powergating_state = gmc_v9_0_set_powergating_state,
 	.get_clockgating_state = gmc_v9_0_get_clockgating_state,
-- 
2.55.0

