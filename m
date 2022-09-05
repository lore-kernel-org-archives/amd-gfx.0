Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC4AC54EE9
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Sep 2022 12:32:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FAAB10E363;
	Mon,  5 Sep 2022 12:32:43 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6106110E358
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Sep 2022 12:32:37 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id fy31so16797106ejc.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Sep 2022 05:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=n8m5/Y6MpUvPe1e/1gGmGx4fix9qgu3Q8BvFeDGYwog=;
 b=cwiChTYJm5Ig5uOco5H/5zUOuD4kgpzOCyJWB8Ahqg5QTyLm282tSxXY4QjeQv38Ac
 LbZLnS8hOQ2B8kzifFFltS4jZSKPmuhUx/YzmJ6egvY9LA+ktdVFMhoyXR1ptZOeapoP
 IuS+CIMaZb+nkjt3STZLAvWUD1T2vpQs0QA16GDl4nNnYnXJuMJn7nloRCOAXhjO/XjK
 N63po0k9LvdwhPJZWekbpPhOTt2eGWSzXamHPzYhj3UF941EbqzjXZJj3ohPTN9UnaKA
 9mRi1k8lWK8ks1dJ2KkMj+1ozb7SlAmYQHGidIoEbQK+qFvFw3QkqpA/m2PctlOFeft2
 YI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=n8m5/Y6MpUvPe1e/1gGmGx4fix9qgu3Q8BvFeDGYwog=;
 b=zt70DjlUAT3sasrTguyXR66n0loJE7ivQHrLCbxFhyrnCKNcExwOe5hr9/8FtjhXfM
 bS5NGbVFsaHhUIpA6S9V3uL+Dj23MDD98q226gf1nylJIwuRkV4RV61K6fGZwbJTNE2T
 847XXso19ve0yVPmH0W8J6E5OdRlS93zPhHdwy1PXTuNTMhhOCbhTfQbHEBfyd+3QlDe
 JJjZQX2Tdx/R8SoyInjbnv4ygKI03e2O23qinTMvjgSpatKZzbzShT36yncR9o7epmiV
 ub1+I1tEHU7gh/R1BUDfVS8az8cKl585i8LY7/4GesD1w6lHvp16PQBl1cmDuhQzV0zJ
 zM1A==
X-Gm-Message-State: ACgBeo1V62PfeeFieG3tH7rUSbXZKAoOFf1T625kRfyi9Es31dJAsKu7
 Dw+w/cWT52mXawy1EA236g20P/w5l/k=
X-Google-Smtp-Source: AA6agR58KLehYa9BzxHvRZmX+88FpFJUMEaJFgU3FbH8qae4jzx8QSMQ6zPyPEn94SdnjpEw3AsRbw==
X-Received: by 2002:a17:906:fd8d:b0:73a:7424:6c0d with SMTP id
 xa13-20020a170906fd8d00b0073a74246c0dmr35858861ejb.425.1662381155510; 
 Mon, 05 Sep 2022 05:32:35 -0700 (PDT)
Received: from able.fritz.box (p4fc20f4e.dip0.t-ipconnect.de. [79.194.15.78])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a17090632c600b0073c0b87ba34sm4970341ejk.198.2022.09.05.05.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 05:32:35 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Ruijing.Dong@amd.com
Subject: [PATCH 02/12] drm/amdgpu: remove SRIOV and MCBP dependencies from the
 CS
Date: Mon,  5 Sep 2022 14:32:22 +0200
Message-Id: <20220905123232.2809-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905123232.2809-1-christian.koenig@amd.com>
References: <20220905123232.2809-1-christian.koenig@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index b7bae833c804..6f80cf2ea9ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -814,7 +814,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
+	if (fpriv->csa_va) {
 		bo_va = fpriv->csa_va;
 		BUG_ON(!bo_va);
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
@@ -898,13 +898,11 @@ static int amdgpu_cs_ib_fill(struct amdgpu_device *adev,
 			continue;
 
 		if (chunk_ib->ip_type == AMDGPU_HW_IP_GFX &&
-		    (amdgpu_mcbp || amdgpu_sriov_vf(adev))) {
-			if (chunk_ib->flags & AMDGPU_IB_FLAG_PREEMPT) {
-				if (chunk_ib->flags & AMDGPU_IB_FLAG_CE)
-					ce_preempt++;
-				else
-					de_preempt++;
-			}
+		    chunk_ib->flags & AMDGPU_IB_FLAG_PREEMPT) {
+			if (chunk_ib->flags & AMDGPU_IB_FLAG_CE)
+				ce_preempt++;
+			else
+				de_preempt++;
 
 			/* each GFX command submit allows 0 or 1 IB preemptible for CE & DE */
 			if (ce_preempt > 1 || de_preempt > 1)
-- 
2.25.1

