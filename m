Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77843C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 16:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 173BF10F00E;
	Wed,  1 Jul 2026 16:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lR9oFPbn";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86CB910F00E
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 16:17:47 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493ba729dbdso4410005e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jul 2026 09:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782922666; x=1783527466; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBlACH2C4iv5ZybLKifkA2Ezk3XJ6Xr+LllVu3CeYcg=;
 b=lR9oFPbnJ4oCdANU7yKbxPgNhcqeRwWNAKNxVtBCnFtf3M20XNXMPfy4IMtHTSKV6X
 5zKA7lkwN5rlyXgeEo4EJCnr+aMddYXL4AiLV0EEoLoH7xt/Z6ktNQZ8UA2+pVTt6xol
 oMt4DNClsb8crNPyhTAw5D7IiK7Gp/PKlVy16NVbNyu7WIQcEcsXdSufcXWIi/1x8ROA
 gygZAHDtZ8FX4AxVGhy7EeZ9VRIrLaQiAE5TDu8osdCUMMnRjl8xwya18bm9YKVFvghu
 oPixzp4fM40xW/aTsiYapH1ulOKZx3djy1UxqfXDZ3o6ZlkdJlAy3oVZilIfU4MqbtST
 ef4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922666; x=1783527466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lBlACH2C4iv5ZybLKifkA2Ezk3XJ6Xr+LllVu3CeYcg=;
 b=iLOddawVy8H1FNbEikm3cXIGvIxmZ7iQY3ffAgmSSyi7zSLv4yt5cUuP/J77btuPvo
 OzLdtdaP14i3MgpCFQYZTLGLLwLYEKIneBkA1mFfFO4KjwR/0QyvfLiG2PGK6yZ1CYDZ
 8mW9NpV71qjBYD1ZUO2xzyPa4P/87eUSDnHBPdEqbQmGxziHOg9ZmvOkETy4vzAp68ui
 EWcpQNzhIn07TVEtus2hoy8FY8+QjBcjbzgut6VtINrnK1NnGopednyooY4JnbJEuX+W
 Q3k7mUkIte9ddunBCC+ifokl8mT3Zs9um5qPwMNTJX3a3OhCdVB9AOsa7qNOYf3ftKtw
 Vaqw==
X-Gm-Message-State: AOJu0YzBsz6D+A182AET4knmsSEA9EiSgprEm9eC3MHpvVPEvdgqHEDG
 AQXeu0jK3ZkiIUvrcB6HhYvyVboM1puZjQbJ2rvPuSHK9cb+j3viTl8+S+GGrK6S
X-Gm-Gg: AfdE7cnkFkjzBxi501lh2fgqjocGkkelKlJ6FtWBwFT4voyWZirsFZUC0ryaVG+g3Tr
 WtizawGqolVPFnmMIDOyNaiiG4kgy0jmqHOvs/sunswUXtygeqeqAcp5rmcx5yA9FkzX8brvfdT
 4R86Ac7Zv+0DdKKHeBBzgw5ls0V1zRWmZBlCq6IdxMnbXpuJsMBRM+pV+oaOmQQ0xkU1rcTxlyz
 dPrYiaqVAhFA20UAq9v1TkdxnOAxOafVI9su3K3AwNry+jcjS2EAn3wIbAYdVV0vUuna0Upaxiu
 7zY5v/drhkxEzIIfFRtX2VVAtk8+yTC+SWoUUf/70nSRb21Awe7tpAaGJiu95a4tVZ53sZengdm
 j0ffk7tbMHaWhutJKrmb2VA+9sz3lpHnG6CA2M1PSQUO/vRa5uv5s6dk/mKi6VXl3SKZj3u+s5x
 SDihsfj9ri8CSTRacJ
X-Received: by 2002:a05:600c:a00f:b0:493:a573:179b with SMTP id
 5b1f17b1804b1-493c3cfafddmr20332765e9.30.1782922665538; 
 Wed, 01 Jul 2026 09:17:45 -0700 (PDT)
Received: from Timur-Max ([212.108.193.106]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be81df2asm168812255e9.12.2026.07.01.09.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:17:45 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 10/14] drm/amdgpu/vm: Use init PTE flags and NOALLOC in
 amdgpu_vm_handle_fault()
Date: Wed,  1 Jul 2026 18:17:17 +0200
Message-ID: <20260701161721.85681-11-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701161721.85681-1-timur.kristof@gmail.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
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

PTE_IS_PTE seems necessary for handling retry faults on GFX12.

For reference see:
amdgpu_vm_pte_update_flags() that explains the problem
svm_range_get_pte_flags() that uses the flag on GFX12

Also add NOALLOC on GFX10.3+ as we don't need to allocate
the fault handling PTE in the infinity cache (MALL).

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 32719f31b6c9..a915d061085f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3044,7 +3044,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	}
 
 	addr /= AMDGPU_GPU_PAGE_SIZE;
-	flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
+	flags = adev->gmc.init_pte_flags |
+		AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
 		AMDGPU_PTE_SYSTEM;
 
 	if (is_compute_context) {
@@ -3054,11 +3055,14 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		flags = AMDGPU_VM_NORETRY_FLAGS;
 		value = 0;
 	} else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
+		/* Don't allocate this PTE in the MALL */
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 3, 0))
+			flags |= AMDGPU_PTE_NOALLOC;
+
 		/* Redirect the access to the dummy page */
 		value = adev->dummy_page_addr;
 		flags |= AMDGPU_PTE_EXECUTABLE | AMDGPU_PTE_READABLE |
 			AMDGPU_PTE_WRITEABLE;
-
 	} else {
 		/* Let the hw retry silently on the PTE */
 		value = 0;
-- 
2.54.0

