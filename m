Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5328AECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 13:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5B5410F1F6;
	Mon, 29 Aug 2022 13:18:41 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABED210F1CA
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 13:18:30 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id se27so7903452ejb.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=0F5VjphCf/p6HIDHOgIuMgAXv0+8dhgnjRsYcqfHOaQ=;
 b=qPaUBwJalpTlm2JbaB406ACuJlO74PSs9Z8TybwrM07hejkqvuTlqBpv/bEnO7+7vb
 T99J5DLcFdeNq4XNzrFVKSSjaXWJDJrUfBcB02Z2/qFRxnUwzamiVeH7Sk01Egc5J6+M
 nnA8bn2UnCgCUSVA8kxlcLIXf+jd0BfQl3x6VPgrybpP2d60+LrJwuwlOe1rmpENza2L
 WizRLhZKF7sogJmRpQXuP2l/3irteX66GfZTXZwgO9tE/EYR1Oge5yaS6QeqzDH5Gp9p
 2X01rKaPB93P0tPGAHy1PN51Pq2lke2GzPu6CfGh9n1hV0t/gySp+iR56MKi39uFJITY
 s8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=0F5VjphCf/p6HIDHOgIuMgAXv0+8dhgnjRsYcqfHOaQ=;
 b=j1zWSMxPExOArz19IcaIwjhdtrt1xjrRBwUwHwwCu6d57Zx+XFjtVWCC9EGdiE6Yff
 YiJ9ZDhBPzjvdE2GFmZ5aB5cPpxI8Tfh+55kvpJDG+HtnpIhrCIWiao0sgfSWzgnrRQt
 t0FCiKarIKxr+oInwe3w9FOYU+F0JH4ST2Ui5bIk4/79ktQYDxv6Yn8CKW3fo9K0gHZu
 mAsumocWb+iuTgcNrRXVPsqzYisRAYvGGE9B5hWQ2/oQycwXkNCX7ySM+T4y5iTzOIt6
 PiTq8BPY+V8h7Gys6uk0aUu4E9qcBuxMz4X20P4oRRpKo7eKHYvW4qz3ia0w8popYDhN
 OyDA==
X-Gm-Message-State: ACgBeo1mgbMsP3e+j8/nhaXQoxHEBlUcF6zW20egDRjM8CsS2KUoual+
 WSLagjur38cuhhj/342Myho=
X-Google-Smtp-Source: AA6agR7egSsKotrNf2cq6H0dQVFEJJKW/cYE4hZ2L5sPkXm9Zay2HRl0nJ9pLKcc/39IaTMXxkUWhQ==
X-Received: by 2002:a17:906:8442:b0:73d:a2fc:a87 with SMTP id
 e2-20020a170906844200b0073da2fc0a87mr13434630ejy.625.1661779110322; 
 Mon, 29 Aug 2022 06:18:30 -0700 (PDT)
Received: from able.fritz.box (p4fc20ad4.dip0.t-ipconnect.de. [79.194.10.212])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a50cd16000000b00445f9faf13csm5726218edi.72.2022.08.29.06.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Aug 2022 06:18:29 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Ruijing.Dong@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/11] drm/amdgpu: remove SRIOV and MCBP dependencies from the
 CS
Date: Mon, 29 Aug 2022 15:18:15 +0200
Message-Id: <20220829131821.2049-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829131821.2049-1-christian.koenig@amd.com>
References: <20220829131821.2049-1-christian.koenig@amd.com>
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
index dfffc3c5666c..73845eea66b4 100644
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

