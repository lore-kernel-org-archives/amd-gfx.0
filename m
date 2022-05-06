Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C676C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 11:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D326112120;
	Fri,  6 May 2022 11:23:18 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAB6411211F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 11:23:16 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id y21so8347034edo.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 May 2022 04:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Ff2EGTqsKu+rUDC/M1M8a06oGsiTdX4jobguET77gq8=;
 b=GeYXU/RpdkJqA7pM/gvjTwDX1e9ShfBB4Cd8qcwZ6neqPMkaQMzOCe68fwK9CT63Yi
 nxwsSilqCWvDmyIJotJ/6Fm2cwaVRIBZt4zxRuVsktx+vLFPJJ73StBBBDtg/7wOYZDl
 I9Ni01ek3bRLnkv27Rr6yQdqXt1Mc4s1b4T724wQKXFUzDZbTV3OMiSjbaTGnW54vumc
 1gCHHJWGOR/u4V4RWgIAdWlBNtSJF+rutE8A40E7+jRLngN3qaUTpf6FQwwQ4IC9lWHK
 /1yytTs60PvpIVS6/tufizmVOuzz5rQEE6wPR0nq8hx++6CPFLPRFPmovZ2q1V34moAz
 5jgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ff2EGTqsKu+rUDC/M1M8a06oGsiTdX4jobguET77gq8=;
 b=ONjMGDNum5z2ABeS6bKTqR5yVVub4mKjZAnf9ByN3NnhStGVpR3PQEY+6QAZbQ37Ko
 YRTCXq5VY/GG9IrcIdFrdll+Y+vBJMi6sdvfS0/hOyTuD937qkXwTDpfSTtu8LaeKssF
 XJ6pADv7u0ZsS0CJrGHkWtYAibQzgrJhCLZlX1Fjn+sXpsB6QjfzUxvl//D7mO8PhfFA
 4TRF7Vegkw0uv3IyOC8fQsC4S0aKMCoL0op2XrBX+IYtuP6ilb5VebimktqEpMD5wd2g
 Vhk0bJF28aT2OBV96z7liklLzU93hOV5rPaVSiiJyl5jDH2wdutRitWKdj+KVkQDLMuJ
 gJIA==
X-Gm-Message-State: AOAM531LZc+p4TLfAKgCdn0gzyrIrI8+F1Ly4M+etnlghSuJYOgkFc8a
 UdPYN4xa8di7MF3RMnh0H7o=
X-Google-Smtp-Source: ABdhPJw6KrhN83zEfjOiW4fo6+q/oO3dgpRfFZLb5RhY4AMhnAuFoGR65wDZNABFI0s8t5U476N24w==
X-Received: by 2002:a05:6402:f08:b0:428:53c1:a867 with SMTP id
 i8-20020a0564020f0800b0042853c1a867mr2972120eda.224.1651836195170; 
 Fri, 06 May 2022 04:23:15 -0700 (PDT)
Received: from baker.fritz.box (p57b0b3fd.dip0.t-ipconnect.de.
 [87.176.179.253]) by smtp.gmail.com with ESMTPSA id
 a24-20020a170906369800b006f3ef214e37sm1816684ejc.157.2022.05.06.04.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 May 2022 04:23:14 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Marek.Olsak@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: add AMDGPU_VM_NOALLOC
Date: Fri,  6 May 2022 13:23:11 +0200
Message-Id: <20220506112312.347519-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506112312.347519-1-christian.koenig@amd.com>
References: <20220506112312.347519-1-christian.koenig@amd.com>
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

Add the AMDGPU_VM_NOALLOC flag to let userspace control MALL allocation.

Only compile tested!

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 3 +++
 include/uapi/drm/amdgpu_drm.h           | 2 ++
 4 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index bf97d8f07f57..d8129626581f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -650,6 +650,8 @@ uint64_t amdgpu_gem_va_map_flags(struct amdgpu_device *adev, uint32_t flags)
 		pte_flag |= AMDGPU_PTE_WRITEABLE;
 	if (flags & AMDGPU_VM_PAGE_PRT)
 		pte_flag |= AMDGPU_PTE_PRT;
+	if (flags & AMDGPU_VM_PAGE_NOALLOC)
+		pte_flag |= AMDGPU_PTE_NOALLOC;
 
 	if (adev->gmc.gmc_funcs->map_mtype)
 		pte_flag |= amdgpu_gmc_map_mtype(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index b8c79789e1e4..9077dfccaf3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -613,6 +613,9 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
 	*flags &= ~AMDGPU_PTE_MTYPE_NV10_MASK;
 	*flags |= (mapping->flags & AMDGPU_PTE_MTYPE_NV10_MASK);
 
+	*flags &= ~AMDGPU_PTE_NOALLOC;
+	*flags |= (mapping->flags & AMDGPU_PTE_NOALLOC);
+
 	if (mapping->flags & AMDGPU_PTE_PRT) {
 		*flags |= AMDGPU_PTE_PRT;
 		*flags |= AMDGPU_PTE_SNOOPED;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 8d733eeac556..32ee56adb602 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -508,6 +508,9 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
 	*flags &= ~AMDGPU_PTE_MTYPE_NV10_MASK;
 	*flags |= (mapping->flags & AMDGPU_PTE_MTYPE_NV10_MASK);
 
+	*flags &= ~AMDGPU_PTE_NOALLOC;
+	*flags |= (mapping->flags & AMDGPU_PTE_NOALLOC);
+
 	if (mapping->flags & AMDGPU_PTE_PRT) {
 		*flags |= AMDGPU_PTE_PRT;
 		*flags |= AMDGPU_PTE_SNOOPED;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 57b9d8f0133a..9d71d6330687 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -533,6 +533,8 @@ struct drm_amdgpu_gem_op {
 #define AMDGPU_VM_MTYPE_UC		(4 << 5)
 /* Use Read Write MTYPE instead of default MTYPE */
 #define AMDGPU_VM_MTYPE_RW		(5 << 5)
+/* don't allocate MALL */
+#define AMDGPU_VM_PAGE_NOALLOC		(1 << 9)
 
 struct drm_amdgpu_gem_va {
 	/** GEM object handle */
-- 
2.25.1

