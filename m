Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F436CA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C3E310E58A;
	Mon, 25 Aug 2025 21:46:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EDtXZymP";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2640510E59A
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:46:50 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-45a1b05a59fso38878915e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756158408; x=1756763208; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vmJCY5SDfvIGvxNC8s+i9H4TjuNcLs6SN74902d73Ns=;
 b=EDtXZymPkROEdyIsiQgQ1ycRor2coM7QEeJIUSGcqix8eDgNh2uOxl61W8ZOy+0Ela
 gWPk9LqVdtkGZeNmvgN7UiXh3oe22+5LGv7UjcrVF+QQhZhunuvTgLLlkx+vrC2F2M2P
 deiKpcfJbuQXq5eBk8mKL7acsl3DkYrthIpJjNZEOksHfDsW3g4Fuj+91wISsD5z3bj4
 BeUtFnod4jnucgTIcDY1TKgh1pXp2SmHN0Ec/upbsNFocH1Dzr8VUJPlElEFM1AdlVaa
 +qz9NR0916JED5jS8VmVhxix85M35LsxJcNqBYi4ap3RiFFCgagY9B2h9YJQJGXTSJDO
 /z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756158408; x=1756763208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vmJCY5SDfvIGvxNC8s+i9H4TjuNcLs6SN74902d73Ns=;
 b=dDgho/UMKOREoEMb9JA6GPHIfj15ayhgbNG0eYTWTqRkVMvO6ZsL+HAnp8v6Xobn7f
 ehjiO3FRM1165b0AjuSesW2ZViAF9mXMs83JB1gwbyz+D7j0L4uriuYQjw0BpxvIE9S8
 SxJgqsJNJORB5bhieiba0kbD2bzYOiTKxjp+KyBHmCUCHo6B+wIky4vmb/rIvUvAkTua
 aYshN5OhP3zuFe75ShrDJ5U3jSGsjCzVhL1cSKktSBfwJ3/AkR5PwT5aZYZIFM680qYL
 AhBXceLp6q4+TLSeq3I64n4B49K8CpK/qdLjReGt1qCtWyfSb/crFFQ2VbnywCTC0bVC
 EkKQ==
X-Gm-Message-State: AOJu0YyvMv9yu8O/pIkbL3pQVqiViw8j4Vb1GcQdYaHN6n8mINEWVTJg
 ZTLNo7K0nfVSfyM1XM71YVlyYXXv7EzaZo7Pmil044/+aJ0wHLs9BFz+1yc+WA==
X-Gm-Gg: ASbGnctO7zwxJG6+K1/SwOZd96cs+ROAb/IHTIgURA6lpWX0LjllJCp6F1hJamKEvkm
 RN/zs/D2pPsVjUz3gsoujTotXYUGL9GxbYhKPkLUSwZWiFAAbhbBgq2ENYD005OyU2DgiFif7NY
 YY7INZcLufFptYQ4indHZG2P21lhkLZGB4ZUJ08f3qTIohDDHyOa26lEcr6DSgzV4vJJXIipiT5
 GE1/zjachdyPx+u9sIvKWjW7HwoTlTseC6NepBA7Gt6r0zEXvhk40nm6oarZqR1OR/IeuDiy+iN
 AlW/Jq7np9JoViyd7bULFeVlmWXYoMC9WtR4M4ZKcqdGigT8zjIx6gCEHqA9rYkYDYMGUnu2FdV
 NV4pG+K+2AUlt19AuMwABysLxqrQG6Ooyd48e0KjMztU0Y4q08x5gvRvo0vkX4gBYVmtBGq5FIq
 for2rtrR588cR/KmMdw2CfL6LOCg==
X-Google-Smtp-Source: AGHT+IF0xWdesldl4NoftTy+k7v6SUDnMHnWRksafyVCjokyjGNlAinH7vnHqPpVGpAa93tVjj0oUw==
X-Received: by 2002:a05:600c:3b2a:b0:453:2066:4a26 with SMTP id
 5b1f17b1804b1-45b5179f3d1mr166548525e9.16.1756158407509; 
 Mon, 25 Aug 2025 14:46:47 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7117d5977sm13348110f8f.51.2025.08.25.14.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 14:46:46 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/8] drm/amdgpu: Power up UVD 3 for FW validation (v2)
Date: Mon, 25 Aug 2025 23:46:28 +0200
Message-ID: <20250825214635.621539-2-timur.kristof@gmail.com>
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

Unlike later versions, UVD 3 has firmware validation.
For this to work, the UVD should be powered up correctly.

When DPM is enabled and the display clock is off,
the SMU may choose a power state which doesn't power
the UVD, which can result in failure to initialize UVD.

v2:
Add code comments to explain about the UVD power state
and how UVD clock is turned on/off.

Fixes: b38f3e80ecec ("drm amdgpu: SI UVD v3_1 (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 29 +++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 5dbaebb592b3..2e79a3afc774 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -623,7 +623,22 @@ static void uvd_v3_1_enable_mgcg(struct amdgpu_device *adev,
  *
  * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
  *
- * Initialize the hardware, boot up the VCPU and do some testing
+ * Initialize the hardware, boot up the VCPU and do some testing.
+ *
+ * On SI, the UVD is meant to be used in a specific power state,
+ * or alternatively the driver can manually enable its clock.
+ * In amdgpu we use the dedicated UVD power state when DPM is enabled.
+ * Calling amdgpu_dpm_enable_uvd makes DPM select the UVD power state
+ * for the SMU and afterwards enables the UVD clock.
+ * This is automatically done by amdgpu_uvd_ring_begin_use when work
+ * is submitted to the UVD ring. Here, we have to call it manually
+ * in order to power up UVD before firmware validation.
+ *
+ * Note that we must not disable the UVD clock here, as that would
+ * cause the ring test to fail. However, UVD is powered off
+ * automatically after the ring test: amdgpu_uvd_ring_end_use calls
+ * the UVD idle work handler which will disable the UVD clock when
+ * all fences are signalled.
  */
 static int uvd_v3_1_hw_init(struct amdgpu_ip_block *ip_block)
 {
@@ -633,6 +648,15 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 
 	uvd_v3_1_mc_resume(adev);
+	uvd_v3_1_enable_mgcg(adev, true);
+
+	/* Make sure UVD is powered during FW validation.
+	 * It's going to be automatically powered off after the ring test.
+	 */
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_uvd(adev, true);
+	else
+		amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
 
 	r = uvd_v3_1_fw_validate(adev);
 	if (r) {
@@ -640,9 +664,6 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 	}
 
-	uvd_v3_1_enable_mgcg(adev, true);
-	amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
-
 	uvd_v3_1_start(adev);
 
 	r = amdgpu_ring_test_helper(ring);
-- 
2.50.1

