Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0B8C88E6A
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 07:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F76E10EBB0;
	Mon, 14 Sep 2026 07:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A7NDYGL/";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C9610E718
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Sep 2026 15:03:57 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49b965570d7so23983285e9.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Sep 2026 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789225436; x=1789830236; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W/ljStNwe21EAHMT5pfp7bjQZDrUvNzZwLlTRaNK94Q=;
 b=A7NDYGL/lF4kSKv4AOTinCKoLUzUZjRuz12iYmf8eMNThnS7XIwFSIsCSQJpt9K5Q1
 F3sYPQJAAN3gtjn3XUWYG+OdGCUCpbCZf3mRtX5wfZ9vV71Lpj3gWbU4z9J5Un2IhXhM
 zpYaGinQ5HH2dG5ANaGetYObLJrp7Af/zTw94YkJYZ51j5pJWpAPW7y0cuSsQ5JvnaU4
 +oZ/DWiQUZ5E8opFmZ6zS3t37hLztHQbwA333sBLs9zxepwrOcn9FhFWNjJTb5PO6Q8h
 eJAXl/hQrSw4+oweDJ17R7cpFFsxVmPFZGIVMnhfCCwZV9fqR6EqRCI/D4gKSV2L9RgD
 /rbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789225436; x=1789830236;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W/ljStNwe21EAHMT5pfp7bjQZDrUvNzZwLlTRaNK94Q=;
 b=YJ7+jlgzaJdXNN2aYK9k8HDkBXfqmDrZnzL+q46NQEacf2EzPbStuX9pfNUXYQyLfE
 r7khvX6IGOcRY8TqdlAnavjTl8V7Ni0D5tRk8H4cjXpUGZD2O6GKG2FHCnbfHjdnOBKe
 o8CCP/5NK+6d98Ck3ssGzMmMmjyUkDhScQwVjfdpbHl++a6cEUhLYNXLqXHyezTKrzAf
 ui+/7xjssXDhhXLySzexYDDF5PS8Znii6xY6rEAPJsRJWAJUu5NMt4i/igns4+kHfiBJ
 JcZ6oLkNyTD5HeOUL2rDb/9o5Z4+zU/W4ZATdMhc6NLSg5RlLtTi8pH+qSTRxh8Yk6rp
 DO7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkdWTnUD9LDhhgijWt+TluBGIozAHuCXkz9tLEVwo3hGXYWs2dkQEWoZOoNpqXU/AACpnJlK7w@lists.freedesktop.org
X-Gm-Message-State: AFuF++nn03iFTmmf0J7BhdiXoyLmQoGtsfLPD2VokPe5HavS0QNFeRdL
 OyKbX4YiGEfdSZd959i+RXND2cug+AA/dT7YdH97C/osAvO+ZKwWJAmE
X-Gm-Gg: AYBFou0T87Byq9ZaGDGVIPV1LJHLy+OjGlWnej+ilPFhVDlNiVe2IUFkO48K4kpIQv2
 bos2FZaIcoLuRioZM1sVpqtoYqSwcVrp7vaIk6O5jLlPfUCqRZpNBe0cOr1lqBNLo8pd+FFJlzQ
 ZSlFNsrmv7D8Jv1yUHmLtoPyxm5LUiGGU0Q0bWmZaR773pSw4S09HqZKWajmDT0gDpQ8U8qssJc
 L+K5+VnMfPz36PGgaZzEnqHGZo4oqb4Zg9eg/Xzs5+AbkbtNBGiBRboMLAGD3GRSUHJt/XB3apN
 Utdhbrl/3xfWkiySKws6gEPvGA3J/LNAxicjenjnpEzQ1gOCLEH7w5UuvYmAYZHEy9I+r3bn4QS
 lT00mpzx1dvXTLVKYF9HgT+QbvN3KdhGxF/2K8ZtKjMrMjaAWfBJZj0rqSYyzOV3um2SYtZJ6/m
 0wPUmJGB8e+PTGljjC8zACB3g2+JlvRCi/X6azIatbG6V5qs5BbjR7s1qRhPapgx1PSuCY0WJby
 Yc9Sw==
X-Received: by 2002:a05:600c:3b8c:b0:49e:73d3:78ab with SMTP id
 5b1f17b1804b1-49e73d379e4mr9568925e9.0.1789225435447; 
 Sat, 12 Sep 2026 08:03:55 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6420de77sm69964935e9.3.2026.09.12.08.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 08:03:54 -0700 (PDT)
Date: Sat, 12 Sep 2026 18:03:51 +0300
From: Dan Carpenter <error27@gmail.com>
To: Asad Kamal <asad.kamal@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Sonny Jiang <sonny.jiang@amd.com>,
 Gabriel Almeida <gabrielsousa230@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] drm/amdgpu: Remove redundant mode2 restore check
Message-ID: <94ccd0e0f47be9ec1985cbc786093c01d7693aa5.1789224159.git.error27@gmail.com>
References: <cover.1789224159.git.error27@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789224159.git.error27@gmail.com>
X-Mailman-Approved-At: Mon, 14 Sep 2026 07:29:45 +0000
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

The "r" variable is checked twice.  We already know it is zero/success
at this point so there is no need to check again.  Delete the redundant
check and pull the code in a tab.

Fixes: 208e5d4b3f1e2 ("drm/amd/amdgpu: Add soc_v1_0 reset handler")
Assisted-by: Codex:GPT-5
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
In retrospect, I probably could have deleted these tabs without AI help.

 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 757da0a30fdc..39a748e38e9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -729,19 +729,16 @@ soc_v1_0_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
 
 		amdgpu_ras_resume(tmp_adev);
 
-		if (!r) {
-			amdgpu_set_init_level(tmp_adev,
-					      AMDGPU_INIT_LEVEL_DEFAULT);
-			amdgpu_irq_gpu_reset_resume_helper(tmp_adev);
+		amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_DEFAULT);
+		amdgpu_irq_gpu_reset_resume_helper(tmp_adev);
 
-			r = amdgpu_ib_ring_tests(tmp_adev);
-			if (r) {
-				dev_err(tmp_adev->dev,
-					"ib ring test failed (%d).\n", r);
-				r = -EAGAIN;
-				tmp_adev->asic_reset_res = r;
-				goto end;
-			}
+		r = amdgpu_ib_ring_tests(tmp_adev);
+		if (r) {
+			dev_err(tmp_adev->dev,
+				"ib ring test failed (%d).\n", r);
+			r = -EAGAIN;
+			tmp_adev->asic_reset_res = r;
+			goto end;
 		}
 	}
 
-- 
2.53.0

