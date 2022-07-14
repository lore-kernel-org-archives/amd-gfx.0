Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4448FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 10:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDB6BA458D;
	Thu, 14 Jul 2022 10:39:14 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFFC6A458D
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 10:39:12 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id b11so2608942eju.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 03:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AdvFut0rh/uAXAtDtXUY+tZD5YgCj1fQLBVIkWg1+DY=;
 b=BDaT4ZzEjPVkTVfRoLxQbf8cYGy3N4Sli6Ag49ri7hoGWkQpHAFwSmVmspOvVtj1zB
 mBM14GMXgGZA7zAdl9rOZM3I4UKozTWamazF3sigPWPpOc5eJgzDKTRkULaMWgn0uMrc
 up0EMhVIpFRzMmgCamwoNE+imzPC9Aeag9CltoU1bpXnLtr0taozpbNwCPzMfMrFTZtP
 c7ygpesvTf3qat8fibWxRNvETfC+zM/CpTuzMYoERam65c/n36OY/kD2DfPScUKpEE2o
 ipMO5U/AMv7nwuosdyi13J9XEEmHOcpCZHOcWTZikXTyuUMFDaSQ3qdD/Lh8a+/0ux9L
 1kKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AdvFut0rh/uAXAtDtXUY+tZD5YgCj1fQLBVIkWg1+DY=;
 b=r9x9YAG3LJuCtzwg9j8DT14oh59ppdZGsx1J+M/HXs/DLkfZIm4D4DveqR6AGioKlf
 bDkW7IMlvG0HEI6nDSfOWBI0c7VFefIbVCu67qYoDrtORgUv/BDv1GHUicVPS86204ya
 BTKuYeDw3HW4/O063Tnagbh6q7weZV3PFnuq1TTlLWHUpqouMkBrMhK9ru7/u9fVC8lM
 cd4SZpzq6uJQen6qKZR1fgTgDk0DDkl2aOHlWfC9VMXddg4l7ouRcWeIeRcdR2Alcl1e
 4CXxI1XHP0y3GABTFJz+dz6gJsYohRgnsC/JvIyhzxpNKy2Qb+hNPHGkbyIW6KnaUiRP
 x2JQ==
X-Gm-Message-State: AJIora97CH96N1TP08GUROf4Q//ezCjsAgHl/Jb7KKTIoVBYiuQ8huT1
 zJlng1jLlKzQriTkv0qHj7NH+NWRJU0=
X-Google-Smtp-Source: AGRyM1u/Z1YY7Wj3TXqlGD+3i1tqzwtCw8y6ba6lfg4x6dkhKgVNeO7JTWk01WqCu5qgvk9ogfm/8Q==
X-Received: by 2002:a17:906:1ca:b0:715:73f3:b50f with SMTP id
 10-20020a17090601ca00b0071573f3b50fmr8196452ejj.374.1657795151474; 
 Thu, 14 Jul 2022 03:39:11 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
 by smtp.gmail.com with ESMTPSA id
 z13-20020aa7d40d000000b0043adc6552d6sm799487edq.20.2022.07.14.03.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jul 2022 03:39:11 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com,
 timur.kristof@gmail.com, andrey.grodzovsky@amd.com,
 Yogesh.Mohanmarimuthu@amd.com
Subject: [PATCH 06/10] drm/amdgpu: remove SRIOV and MCBP dependencies from the
 CS
Date: Thu, 14 Jul 2022 12:38:58 +0200
Message-Id: <20220714103902.7084-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714103902.7084-1-christian.koenig@amd.com>
References: <20220714103902.7084-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We should not have any different CS constrains based
on the execution environment.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index b9de631a66a3..dfb7b4f46bc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -323,8 +323,7 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 		return -EINVAL;
 
 	if (chunk_ib->ip_type == AMDGPU_HW_IP_GFX &&
-	    chunk_ib->flags & AMDGPU_IB_FLAG_PREEMPT &&
-	    (amdgpu_mcbp || amdgpu_sriov_vf(p->adev))) {
+	    chunk_ib->flags & AMDGPU_IB_FLAG_PREEMPT) {
 		if (chunk_ib->flags & AMDGPU_IB_FLAG_CE)
 			(*ce_preempt)++;
 		else
@@ -1084,7 +1083,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
+	if (fpriv->csa_va) {
 		bo_va = fpriv->csa_va;
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
-- 
2.25.1

