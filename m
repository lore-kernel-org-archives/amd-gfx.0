Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C160606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hb0rTRa0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7A921124E3;
	Thu, 22 Oct 2026 10:55:18 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AC501124E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 10:55:12 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a1e266fca2so11947115e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 03:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792666510; x=1793271310; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=elLXg3w+uftutke8mR3uoqDn0vGvbA3T2VIjPuIvzN0=;
 b=Hb0rTRa0G0D2WIm5YS/TEU7+2n8M0BwotEwkGd04ZbA1OKt9iNcKWCH0LIUqbICDNw
 p4bSxjiw9i/1fg7D6MTlIX2H/rZsauEsCyzqMK/Vuwz/x8eSH06DmpTC2Wj8/g0XzvW4
 HtJLdPlOwrO4N3sHJDg71d3zvS6N5lPsqjxWwskWCnmDXv6UOOXDt8tbSGAQAgsPTsQb
 0twBCRrM10cHT1Tqn9X96Oek9QJ1u16jwSNQBpoyTyHTYJF+pRvqGxvte/ciZbHS3m1U
 TSoU45ujcbf1pKI9+Ofc2izjM9Tl8FY47p3Dhg/16GGaVrryciDkXysZt4+Le/ff0j1Z
 3w5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792666510; x=1793271310;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=elLXg3w+uftutke8mR3uoqDn0vGvbA3T2VIjPuIvzN0=;
 b=XThZO3BG7t98X0nfMD1ZC9VTlSoue5VCzt4ynliyTutAMyGi8/m8Jlmp+HHjKSuHWo
 ng3QOBNqJbUcK5JMvg5mjvZynqvY96eC1pRsrkGKtaCp6F5xp+x5vPSJUuypa3/x5lIU
 jzBTYtlUSk3CgEXzELVADT3KKaP4n13DZ3QgUEHNGUu++fqeOJdunM9Kmlnvwg/N9RdA
 CTVG1L+6c5yQAc6+HBHJ/INHAY/b/PGpi871Pre0U20fE/vk7hz2dpy39mMfcq6hImPn
 blOrhKAPwLi/QQ3iImLxim2eQxnRwYTnrSwV9+hdAsCisxw7olhwsPLWbnsYPU6RslMO
 09PQ==
X-Gm-Message-State: AFq9FYIW4G2s1d6xD8rD8znbE4LuOppUWiAxyqVVJ8DHTBZsCEwF1Lwu
 BrJnqFmdctG5Ne4PngndI0ZIL554wQeHqbKkVMEGjF5tJ1V7JnxsQmx+j9960V/E
X-Gm-Gg: AYBFou3wIPhW0VV4w3FofW+TQ9uSDLNFcuOi90emndkO2i/xjkozzcUQHFfHTcBvQIM
 A8HZxBHKbMqHpMJrGa77x5HWws+zIG9/eilc0duE5JXA5ZOaqyaCPkF9R7BoNc+X6JlmeoWJNUn
 UjujXslEEaLLnd1bk7Zlu4egekIGzGvZCN93pQTEVeQzIZgrqyksvclQ7ZFYJ0XAmRmh7/g9brl
 5819QGpFwyILehI1Wrrg9EyeARG9qvcRnnLY6dermGgIwD1gge94Ple0EIgeEhthIr2PLSp+5fu
 R90HvJsxvRD+nACtoyyvjqNXPdwPZ6rT+xt/19UX+3IGChy0q6Xtl2Y8dFWGvi2nrh6fROn+2oJ
 L0wQaxP8rW5hZTfCb1w4RNdSLokRNNXd8El14iaQgtlENTN2rRovBEjVrz3/rwlgemHAuMD8Xhc
 oQ0ETRu0zrOZa8uv838xOi6L4omEMg+No/8FFp9lkerX7BHrM4w0e3S+EYJBbFlKmdk+pCRUWOp
 xto37KW+UBdGOMkltXgv78+iigxgkEZENBC3bgAMFpZ1Qe8I1zcbdsSlHP7M6xGj7g7eP6S1h9Y
 Y5WJZmAmgfLeozZ5RSu9Iafz+k2kAeBw5eTJB+c4cjkakoHnXeG+s4BdL6in7dSLdEzAriTsn2c
 9EhfYcziceyerdHeu1ne4iv04mZ6ozO4VxG4CLX8Z8AoFFB3vbkcuylP+ZYXCMDYz18oOZ2hNJC
 zZsxd5Gi0NSE2hyGpeDEkEzqCC5k8x/U+FqbrGLvwlhCuG8MPwoP692OyDezDZ0VvxASXvSN3+8
 lnU9iHl1gQGpBC6PLZJdT7PfP/CxLe4wv8=
X-Received: by 2002:a05:600c:1c1c:b0:4a1:d307:d578 with SMTP id
 5b1f17b1804b1-4a1fdb20a75mr100912915e9.11.1792666510313; 
 Thu, 22 Oct 2026 03:55:10 -0700 (PDT)
Received: from localhost.localdomain (188.42.205.77.rev.sfr.net.
 [77.205.42.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2583e25asm12227393f8f.46.2026.10.22.03.55.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 03:55:09 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, felix.kuehling@amd.com,
 alexander.deucher@amd.com, xiaogang.chen@amd.com,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH v7 1/3] drm/amdkfd: tear down KFD processes before early
 fini_sw on disconnect
Date: Thu, 22 Oct 2026 12:55:01 +0200
Message-ID: <20261022105503.60372-2-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022105503.60372-1-olivier.kaloudoff@gmail.com>
References: <20261022105503.60372-1-olivier.kaloudoff@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On surprise removal, amdgpu_device_fini_hw() calls
amdgpu_amdkfd_device_fini_sw() when pci_dev_is_disconnected() is true.
fini_sw frees kfd.dev, but KFD processes may still be alive and hold
references to it: kfd_process_destroy() dereferences kfd.dev via
kfd_processes_remove(), and svm_range_list_fini() /
kfd_process_free_outstanding_kfd_bos() touch per-device SVM state.

The kfd_processes_count wait only happens later in
kgd2kfd_teardown_processes(), called from the top-half remove path
well after fini_sw. In the observed failure the killed KFD process
(SIGBUS on unplug) stuck in D state on its exit path, so
kfd_processes_count never drained and the PCIe removal thread wedged
permanently in cond_resched(), producing soft-lockup and hung-task
splats.

Tear KFD processes down before freeing kfd.dev on the disconnect
path, and guard kgd2kfd_teardown_processes() against kfd.dev already
being gone when it runs a second time.

Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
Changes in v6: none
Changes in v5: none
Changes in v4: none
Changes in v3:
- added NULL guard for the second teardown_processes call once
  kfd.dev is already freed (Christian König)
- dropped the bounded-wait mechanism from v1; the drain now happens
  before fini_sw instead (Christian König)
Changes in v2: none
---
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9269e78..bd9d73a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4315,8 +4315,11 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	 * before ip_fini_early to prevent kfd locking refcount issues by calling
 	 * amdgpu_amdkfd_suspend()
 	 */
-	if (pci_dev_is_disconnected(adev->pdev))
+	if (pci_dev_is_disconnected(adev->pdev)) {
+		/* Drain KFD processes while kfd.dev is still valid */
+		amdgpu_amdkfd_teardown_processes(adev);
 		amdgpu_amdkfd_device_fini_sw(adev);
+	}
 
 	amdgpu_coredump_fini(adev);
 	amdgpu_device_ip_fini_early(adev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 586e640..43029b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1801,7 +1801,14 @@ void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
 
 	mutex_unlock(&kfd_processes_mutex);
 
-	/* wait all kfd processes use adev terminate */
+	/* kfd.dev may already be freed on surprise removal */
+	if (!adev->kfd.dev)
+		return;
+
+	/*
+	 * Wait for all KFD processes using adev to terminate. Must be
+	 * unbounded: device state is freed once they are gone.
+	 */
 	while (!!atomic_read(&adev->kfd.dev->kfd_processes_count))
 		cond_resched();
 }
-- 
2.47.3
