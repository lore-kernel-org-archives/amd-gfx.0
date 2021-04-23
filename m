Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26592C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 21:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E232F61467
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 21:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E232F61467
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 605BF6EC60;
	Fri, 23 Apr 2021 21:42:47 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6992F6E0DA;
 Fri, 23 Apr 2021 21:40:11 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id p12so36060807pgj.10;
 Fri, 23 Apr 2021 14:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=ZdewDA3O/vpf75aCvIGPbrONaUjKUEiVp0e2T7LbJsM=;
 b=QABHy58z2VRDtQCbsBKAchLL2ZsK3fKYgls12hiZv6d+eauTc/yqd3y2PMMFPaWiN7
 p7ZXmog20r3A+hZh1xLtCVI2OULoqYBI/vUfwoOMP1InMZXRQIDDOmHdJcOGhqrmk1OL
 9NdRWWZypzOgTDicWTnJNUAs+oTJLAr/Y8eKCV5djQLEkvUqAC0w/v7J8XW/Rl6x43Yq
 xHx1dU8KCp3pRZyRYBLGu7GKjsXiM9jHHMe0zgtSz5b7jKMr1oj3yMZIMPl+nEl5Lv8s
 Za+2dMNTywfi4yUl8pg+IxDJ851/U5v8zShS5iPWSjqFpFpOB4+OqRr3JfJ4iQRGXOpH
 IiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ZdewDA3O/vpf75aCvIGPbrONaUjKUEiVp0e2T7LbJsM=;
 b=SeC/KgiHPH4jttelfbazSwR403Q3CZ3Fcf+znjrD7J9QLxQYOMEFlL2ajh0Coheplk
 8it61Dg4e0Y8oqP0ekb5aRX9BCIGfO1tqvynz1v+altSgSE1wyDOV4/8Lc/zRF+qPQCn
 XnutzXKgRO/tHSPtyCMcI1i6A/a+CYrQvsLruB0jNPsdgzddWFNY3G2qdK0dVqlwGP5j
 wzkcn1jlWmn530cUpeIrRUrulHRm6zBf9t0irhPZxTHR/5iHRTb+zGQlDLnpqshGjhr8
 4IP6k3k/fezZFLmLKdsnGnL3Y7IDzZ1CSBXP2pNUtuakXmChujshcweCxvoPawZsD1KK
 6bpA==
X-Gm-Message-State: AOAM533Dp6WZUmgjj82rpD8K8jCL0wbiz5LW3dd6iEP4h6cZVP09vORw
 m4YkEL86vRA6CwTRYlUMYMg=
X-Google-Smtp-Source: ABdhPJwtj1HeimjSsv/t/Vm+7rVULlKphY6FH/hjJl5J1zEO1n34ZGFhg4PNHiicYoDfTmOnf/J1ag==
X-Received: by 2002:a62:1ec1:0:b029:24d:b3de:25be with SMTP id
 e184-20020a621ec10000b029024db3de25bemr5671238pfe.17.1619214010912; 
 Fri, 23 Apr 2021 14:40:10 -0700 (PDT)
Received: from localhost.localdomain ([49.37.83.54])
 by smtp.gmail.com with ESMTPSA id e7sm5553001pjd.6.2021.04.23.14.40.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Apr 2021 14:40:10 -0700 (PDT)
From: Souptick Joarder <jrdr.linux@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, Hawking.Zhang@amd.com, evan.quan@amd.com,
 Dennis.Li@amd.com, luben.tuikov@amd.com, jonathan.kim@amd.com
Subject: [PATCH] drm/amdgpu: Added missing prototype
Date: Sat, 24 Apr 2021 03:09:57 +0530
Message-Id: <1619213997-5475-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
X-Mailman-Approved-At: Fri, 23 Apr 2021 21:42:46 +0000
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
Cc: Souptick Joarder <jrdr.linux@gmail.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Kernel test robot throws below warning ->

>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c:125:5: warning:
>> no previous prototype for 'kgd_arcturus_hqd_sdma_load'
>> [-Wmissing-prototypes]
     125 | int kgd_arcturus_hqd_sdma_load(struct kgd_dev *kgd, void
*mqd,

>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c:227:6: warning:
>> no previous prototype for 'kgd_arcturus_hqd_sdma_is_occupied'
>> [-Wmissing-prototypes]
     227 | bool kgd_arcturus_hqd_sdma_is_occupied(struct kgd_dev *kgd,
void *mqd)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c:246:5: warning:
>> no previous prototype for 'kgd_arcturus_hqd_sdma_destroy'
>> [-Wmissing-prototypes]
     246 | int kgd_arcturus_hqd_sdma_destroy(struct kgd_dev *kgd, void
*mqd,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Added prototype for these functions.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index dc3a692..8fff0e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -316,6 +316,11 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 				   enum amd_ip_block_type block_type);
 bool amdgpu_device_ip_is_idle(struct amdgpu_device *adev,
 			      enum amd_ip_block_type block_type);
+int kgd_arcturus_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
+				uint32_t __user *wptr, struct mm_struct *mm);
+bool kgd_arcturus_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd);
+int kgd_arcturus_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
+					unsigned int utimeout);
 
 #define AMDGPU_MAX_IP_NUM 16
 
-- 
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
