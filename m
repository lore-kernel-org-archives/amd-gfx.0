Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6DA606A326
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=frZuJEvB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D31C112471;
	Thu,  5 Nov 2026 13:45:41 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB5B10FCC4
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 15:06:41 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-36d6e342f98so630613eec.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Nov 2026 07:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793804801; x=1794409601; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XWmzhsNQRB07nNAqARUA25IM06jzZZBNn2XShTl+N+4=;
 b=frZuJEvB4yHXlSUGJYJ8jAXv++OL7ikleMIGMLGcKqs1fam6whI2n/Xir+YTXFcnuR
 hjV5Rpe6avRriEf1F90kL1x4Bub/jBmhLPSduDpSvbV1Tf3Gm/VITPSIZi3+H7V3t0N8
 T1oJWnpsfocaaHBcKQSa+wUs5wGtOZ//8z14p685BxMDA/sXV5WbvahNMQa7JiM5CeZW
 7Wi5uF/sEgnTiygerXOYk+Ng6d4NFxabRpG9K7RNX4jHV8bmf+MV/vCAq/AUj+cc1eXy
 3gtYeN21q5gCKsJVEqZ8edZgWDkq3rQbSbzle1BV+VzMf04LXZAWbZjf/oaxs3FgBvY5
 VDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793804801; x=1794409601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XWmzhsNQRB07nNAqARUA25IM06jzZZBNn2XShTl+N+4=;
 b=b7mYiJ2DTBRKl3jPW1t5IKZepf3oCX4akNENr67mxVFWJjUOiz27hrQvJCtvTiJTJ8
 SBLdrP0RjqRfXQBVEg5sLs7mJCA4LLj0FkWKpqxqM2s0KDNN/r2MVt0egBhgvqf5oNX+
 FBj861QZFjurXaSCkFn7ZBt1M2mxIghFJBp7ufI5MPhwMBjyhF2bc8UjEBj6odIB6AE3
 wYTZnKyg/8q4Ve7N8WifINlSq67wDvlA7StJVO2kp6jK4gfVz3kWnt61J2pCiS57on0W
 T5VmaS0H6Luwl8r499f2K2FYYhRWlxME0tzco5nu7uoaoGBIrw0bVo4lZn7CMpPW+CLt
 XShg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDfGuUhHuRh12mJ4a0fKTChpXh6SZI5zaeMbJ4T8wVvJE8aDSfQmatQ9pEL4jFPVlqC9uH5y8q@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+w9rWjcbSQTMEzmzYi4ASOF+7d2HZUJt5e/x8Wh6rQI1oekXOW
 guspYEv5i5WhTpHmMXB3Z2xqabaGLBU2VgomqhLM8uWLhy0O8npqeKbW
X-Gm-Gg: AYBFou2W4jExYAaYcO4bVr7ps90sVIY6Fx2x/jlcbWlgp1WiBJwpAFDvo+8ZTK3ESFq
 XfcMHMK/+xAzW3IpUklokvN5YNRPYudMqX7f9pXX4oIkpF+xGEt7xAkI6lpbRukm+T9DNpgMSOR
 CiZOLwHMvzQ7dgtHJweYNL45UskyO3opn50/VG6B9ItyMRb4uv3Sm4gaItQSKW4P+3+Td51b7xa
 F/QBioXpPGkUpn9Nj/YQUSZY7ZW/qs507WK87WDh0feZx5jtFNFOsUGncyO3SWFCJ/3ujUOEUg9
 azgIOf7VhfVkVuoj9cmMSbhPjowkGhmpnHGv05LDKpMyIqN+5yyUGoPMaP/FJaTgtARcKCOchN+
 coghr1TTC1UUiTcLrcOoUhJU7r9a/0wJM7htjqW4FKjALAH5SyqRBRebBtPZVMlgTLRTvcUQfG6
 JcOm1vBmKuWvtqEVqyYVSNYL1WRuxb0uGIZz4+Yaqv3JXPMa+YeKV369CBdWoadXAXScYLUY2th
 e4Wy9BE0Cvt17JMOJh3h8nSd7EA1QaoFboUnYZ3r2UOei/PHpvFIkMic0TOy7OOv16Qri6m0bCa
 TIa3uYb8QnliRXzWwK3Ymfp3o9XEQ/2KoMgWLAHiEsZzNL8Zm7YJJD37JKPR4gz0pJoKUmJfehq
 NcW8A8p5+ISHRwPRnKQa0/vpYlQBR
X-Received: by 2002:a05:693c:42cd:b0:34d:755b:d60b with SMTP id
 5a478bee46e88-36a42435386mr23523976eec.34.1793804800593; 
 Wed, 04 Nov 2026 07:06:40 -0800 (PST)
Received: from localhost.localdomain ([2405:201:301c:f8cd:5040:8550:f5e4:709a])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36db94376b1sm527287eec.10.2026.11.04.07.06.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Nov 2026 07:06:39 -0800 (PST)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Aryan Sinha <sinha.aryan03@gmail.com>,
 kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] drm/amdgpu: fix kernel-doc in amdgpu_ualink.c
Date: Wed,  4 Nov 2026 20:36:22 +0530
Message-ID: <20261104150632.33843-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 05 Nov 2026 13:45:29 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The two comments do not describe what follows them. The one above
amdgpu_ualink_npa_vm_unmap_range() is missing the ualink prefix, and the other one for amdgpu_ualink_gart_npa_addr() sits above two defines instead of the function, so kernel-doc attaches it to the first defined one.

hence, Move the defines up and fix the name.
The description also had a stray blank line splitting it in two and said dst_accid_id where it meant dst_accel_id, so join & fix it back up.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202609241952.zFr1FYRB-lkp@intel.com/
Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 6cd3927a7..f875209e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -4631,7 +4631,7 @@ static int amdgpu_ualink_npa_vm_map_range(struct amdgpu_device *adev, struct amd
 }
 
 /**
- * amdgpu_npa_vm_unmap_range - Unmap a range from the NPA VM
+ * amdgpu_ualink_npa_vm_unmap_range - Unmap a range from the NPA VM
  * @adev: amdgpu device pointer
  * @bo: buffer object backing the mapping
  * @pte_flags: page table entry flags
@@ -4727,6 +4727,9 @@ static u64 amdgpu_ualink_npa_addr(struct amdgpu_device *adev, u32 type,
 	return npa;
 }
 
+#define AMDGPU_UALINK_GART_NPA_ADDR_GPUID_SHIFT		41
+#define AMDGPU_UALINK_GART_NPA_ADDR_GPUID_MASK		GENMASK_ULL(50, 41)
+
 /**
  * amdgpu_ualink_gart_npa_addr - Get GART-mapped NPA address for ring buffer
  * @adev: amdgpu device pointer
@@ -4734,18 +4737,12 @@ static u64 amdgpu_ualink_npa_addr(struct amdgpu_device *adev, u32 type,
  * @src_accel_id: Source accelerator ID
  * @dst_accel_id: Destination accelerator ID
  *
- * Computes the NPA address suitable for GART mapping by adding dst_accid_id to
- * NPA address to access remote by SDMA.
-
- * clears the source GPU ID bits from the NPA address which is set for
- * address-identification mode.
+ * Computes the NPA address suitable for GART mapping by adding dst_accel_id to
+ * NPA address to access remote by SDMA. It also clears the source GPU ID bits
+ * from the NPA address which is set for address-identification mode.
  *
  * Return: NPA address adjusted for GART mapping
  */
-
-#define AMDGPU_UALINK_GART_NPA_ADDR_GPUID_SHIFT		41
-#define AMDGPU_UALINK_GART_NPA_ADDR_GPUID_MASK		GENMASK_ULL(50, 41)
-
 static u64 amdgpu_ualink_gart_npa_addr(struct amdgpu_device *adev, u32 type,
 					u32 src_accel_id, u32 dst_accel_id)
 {
-- 
2.46.0

