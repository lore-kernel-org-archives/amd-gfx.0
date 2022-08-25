Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AA8C28D13
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 13:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E7810E09F;
	Thu, 25 Aug 2022 13:32:07 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BCC510E042
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 13:31:53 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id c93so1419587edf.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 06:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=AdvFut0rh/uAXAtDtXUY+tZD5YgCj1fQLBVIkWg1+DY=;
 b=gwb/YyvpWb47Jf0bdJK7iFL/JQw3LmX2BLFlvxfcufCYfOyn5Z5qImMRLx0DSv7R8J
 xoLqkQBDXnx4qddeZA1T2/bK5+JOHQS2SHf6ELNShacAHPa2Z5TDIyhG6AxsTES80Dya
 R/iA2tNPTyLkmc7bTWTpeMdb+KolKuN8lOqMXNbbOLo0ynzM0+wQwivKFNgw6V13Hh9G
 n8gbDXIuYUdy+IQfyQWbsUMffSNmmdgWABBjhXH08205NzmC3PAGRfSkxBzmSyLH72xF
 mhy8MmK5xcfM6ReaZ8OWrLA2a/MjeVVhVaEEJMfG+Msqwd/tYSCu7WtMoPgRNU48BHcV
 juEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=AdvFut0rh/uAXAtDtXUY+tZD5YgCj1fQLBVIkWg1+DY=;
 b=1uaArAjqjMW5KkL1fm4nyR8sT/nZgM63MIjp4vKkOoFdAdX8lBw4YkQAyAbOuR3byC
 yk+9rnNdxexZsqLSNczl/QBqJzGzgB3MMDlK3cwM+JBiazXxQvq57UoQquP1wXdWLyB0
 aak9kZVNlwDgrkHBz9rJg/UGGlTNgNFXi8/4Y57JUPktW47/ig3w9m8t3ix/+wvfwJ4C
 LBEw10F0hyB4sOqSXdj6XRCQl1nHLAkc9NrhwqbG4+vkEFNWlkOm/KjHuCmZp6OcwQmV
 V83TvnaoyT27GKrRwoAyr+z/C2rsmQdcNoRbNWAExfwwxVog3fifkZKbdF5/CPTdqzmL
 XcbQ==
X-Gm-Message-State: ACgBeo0yC08oaAyO2F/H2cEkZk+tqtxoZ2sqTQkz7gINm/5d14EbWfq3
 +vczbkfYtGsdAXmdrPBfDB0x03rk/ablWQ==
X-Google-Smtp-Source: AA6agR4s0aT4f/HUUpYeYPKRXC+pwKUzrdPbagsXJT36rCV60jbDnmMRUJ+jKR9u3k6BZNoaLO69Ug==
X-Received: by 2002:a05:6402:254b:b0:447:1a34:a5dd with SMTP id
 l11-20020a056402254b00b004471a34a5ddmr3241699edb.166.1661434311694; 
 Thu, 25 Aug 2022 06:31:51 -0700 (PDT)
Received: from able.fritz.box (p4fc20ad4.dip0.t-ipconnect.de. [79.194.10.212])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a509b12000000b004404e290e7esm4913471edi.77.2022.08.25.06.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Aug 2022 06:31:51 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/11] drm/amdgpu: remove SRIOV and MCBP dependencies from the
 CS
Date: Thu, 25 Aug 2022 15:31:36 +0200
Message-Id: <20220825133142.8272-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220825133142.8272-1-christian.koenig@amd.com>
References: <20220825133142.8272-1-christian.koenig@amd.com>
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
Cc: Alexander.Deucher@amd.com, bas@basnieuwenhuizen.nl, timur.kristof@gmail.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Trigger.Huang@amd.com
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

