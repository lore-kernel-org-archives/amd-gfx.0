Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8045C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 08:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 928AE10EF1C;
	Thu,  3 Mar 2022 08:23:18 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6764410EF1C
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 08:23:16 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id qa43so8870594ejc.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Mar 2022 00:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ra2VQo+mW/ff7mDC/DShy/q8IsNu+VS+0kTLns9PWXY=;
 b=RDHptPMAeTpBIIVFheNlPsISor6lENtYA5/nXWEUXhjuWHAl9pfLUy6O3BZ2YWls6x
 oEsF4u7mnla1e7W+cC9NjCDALqai71YeNAGyU67UDpB+/wbpcBaL3RggrKPUNppx4K+v
 o/jEEAMCZTEo6QwLc96/gbfQGN7GMIFBS5q0Acv15/3hgY3Dy+oVAmk/zuZJ9gk6g57e
 282k3vdmMOREZhbCBUyDTB5sj5K4uLWe+OFpbxcD8eYBOYgR4RKh4OuYc3VVpIJ3DnYN
 NUbEbR1Qtwvecx075zOgwmLTfmxgXRcqs5hwjfCv50Vfp7pTJk1l5zcrImgSUVqNG7pv
 2oTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ra2VQo+mW/ff7mDC/DShy/q8IsNu+VS+0kTLns9PWXY=;
 b=2Jt3tc0vrvt6idGqnwuyEnS/+P7gHzU1MevSxd8H0+r0vy2zzTf4cFPqcOoBlYBoqt
 ACr4KtFClwUlgCYy6Gw0BbGaMPtbqJwe+aBZBQHO7TkwMiSwKDbwITngEB1GE99NOg3d
 29uHKoLf9+4wlrHnCS17Pz1usv89VP7kzblWnJvVJCqh6kQS1AtaDSfs99dLCVJkhY7g
 RAE2aXBp1YQrbcxn+yxRGb6+mpO6Tz65qqJzdOLkMZJpcH+eSyJFAMDnuoNpJjSihVLG
 llzEqMdUUDpyI5a/XjzWvQbP3Rx+dA59/oVOvob7MRct0+Nv4JnD1a29d8rLUkIdmfXr
 0uyQ==
X-Gm-Message-State: AOAM532q20a7ZA9ywCD4FYvynE7rheWlPH4ywrcggp1uVHI60c96xM18
 Fl2CNmTFzM49NCsp094FS1Adx+N0ma910A==
X-Google-Smtp-Source: ABdhPJyfj9k0lw7boCsJPy0qbabtqor3b7XYcegacGHMx6lGKRLgiDI5XUFjE2qKReBE8RFmDTPtCw==
X-Received: by 2002:a17:906:32cf:b0:6d5:83bc:e962 with SMTP id
 k15-20020a17090632cf00b006d583bce962mr26748359ejk.108.1646295794969; 
 Thu, 03 Mar 2022 00:23:14 -0800 (PST)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a056402060400b00415a1f9a4dasm548308edv.91.2022.03.03.00.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 00:23:14 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Marek.Olsak@amd.com
Subject: [PATCH 04/10] drm/amdgpu: remove SRIOV and MCBP dependencies from the
 CS
Date: Thu,  3 Mar 2022 09:23:02 +0100
Message-Id: <20220303082308.38217-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303082308.38217-1-christian.koenig@amd.com>
References: <20220303082308.38217-1-christian.koenig@amd.com>
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
index 58ddc4241f04..20bf6134baca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -320,8 +320,7 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 		return -EINVAL;
 
 	if (chunk_ib->ip_type == AMDGPU_HW_IP_GFX &&
-	    chunk_ib->flags & AMDGPU_IB_FLAG_PREEMPT &&
-	    (amdgpu_mcbp || amdgpu_sriov_vf(p->adev))) {
+	    chunk_ib->flags & AMDGPU_IB_FLAG_PREEMPT) {
 		if (chunk_ib->flags & AMDGPU_IB_FLAG_CE)
 			(*ce_preempt)++;
 		else
@@ -1062,7 +1061,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
+	if (fpriv->csa_va) {
 		bo_va = fpriv->csa_va;
 		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
 		if (r)
-- 
2.25.1

