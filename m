Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFF5CA0FF6
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 09:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E80CF10E7A0;
	Wed, 27 Aug 2025 09:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iHnngabd";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B73B010E79C
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 09:59:53 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-45a1b004954so52360165e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 02:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756288792; x=1756893592; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ej+AAb48HdbebFHcRZ+ZxF/PT+57dEaJQ/VY50vcLVw=;
 b=iHnngabdyVR8yY1Kb2v9JkixaZ6li0frZwuwOt3PWX/RYmPjuPcd326YlXMv04zFyZ
 BBHw9jZsGH4g3+O0WMgIfAUrOyEhp/af/9booVp0TmXVvaVCgVH1CnO/iYPaMFdx55qn
 Q+2WDoy04fjzwtqS56VM2+xU7+SV5B/2vAB0x0b8OEwsn3czv7ClQDf6g7DIcXjittyc
 dhRYFCAOOuc01ja/JRiXHDCg6VzCcF0SjptPc1NMRURHxRoFixhKcV0iyi6LPY9U6Q38
 m0MrP0nuaRm5DBcN4Z9XFbdOvLeqL0AevP5/lR6xglwM5RUD4e7OhHVcUzdZ7lEbMJrj
 Gv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756288792; x=1756893592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ej+AAb48HdbebFHcRZ+ZxF/PT+57dEaJQ/VY50vcLVw=;
 b=s0GR7w1oh4bwwbEWr2dG//XxTvQooUcSfd8kNAto/1A8qUjztIdzY079WRrpCgY4eH
 7uiCHQK2lrOxdb1llYdygdWFv7VO14nNS1sphs0nfHw4d5Hv2kd7KPdq0thTLNwYHVu9
 n0GXPr7eaapNMoc3r9BaOEF5kV3e4YEe1AV2/TAcxeH2XN57Eha5MHTBgkwsLuwCc2Qz
 ry/MYeJyDE1AAcvab+bqixAYXIxEs9QkLhLXAQH52Dn0oQ0HmOSI3fYqxtgjPXq6ujK4
 DQoEVHUDjtnM3OkKlwghxkGUGZHXMRlk+BoYxHNy2T0EVfKUq2XnYyygoCB5uoPUzeB4
 Kfdw==
X-Gm-Message-State: AOJu0YxzO/CCfem1eiRBMHGYflgwf5kOKeOwe2TJHh/8tnMHh/DCZkcp
 6m2a5UQg70bxULuPaJHr1bsJ07wkeIWrfLhU2qaeCSZCvXyMi/l17yW+Mo6wdOaq
X-Gm-Gg: ASbGncvbzaHvL0OHbzpIevIJejMeMCiQ1ju22FWQizlPc4GmJtLQLN1Kf9n/dqDBIT/
 +6XtLSzZgSDQWgex/kAf7S9S0h+PQ6KYceAIAOo0uTDGurUOp5i49K50zSE3K972nOCg+b7XRWD
 7iBoSS4nlag8ypPpgnC55bRBjMW0GgMlW0PzO51VVrnwQoEbBJKDWnnPgOTlxq6UeI4lypYk/54
 j6qdPluorOarK0aCioS80sOpPOgo+sRGx5Ndo1g3zMReHHjXcKnOVIk2mbaEXNnCThYqgQpXZPR
 m+MtSa/4GkGtc+lwYVY1WQYeRI1s0Cx16SqAVoZsKBRjkTgwrB0P4HHH98SPIC/A1ItrR7TFCS8
 LP6nd9FTEK0FXWm+xxQ4q/tAw9liQ/wuPKKzekX40LkE6fQ==
X-Google-Smtp-Source: AGHT+IEqjjq+FoO0H/Ic1tLPjcCNNSPd4kSDeIuwoNVVB04FCa2Ftvow3lQowM//Ry+NBeBbW4GN+w==
X-Received: by 2002:a05:600c:1c98:b0:456:214f:f78d with SMTP id
 5b1f17b1804b1-45b53cfa151mr139769715e9.22.1756288792083; 
 Wed, 27 Aug 2025 02:59:52 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1498:5800:1e25:9081:2109:a4cd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6db6sm25236415e9.2.2025.08.27.02.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 02:59:51 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com,
	Sunil.Khatri@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: remove check for BO reservation add assert
 instead
Date: Wed, 27 Aug 2025 11:59:49 +0200
Message-ID: <20250827095950.2672-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827095950.2672-1-christian.koenig@amd.com>
References: <20250827095950.2672-1-christian.koenig@amd.com>
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

We should leave such checks to lockdep and not implement something
manually.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bf42246a3db2..1dec07513cd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -616,18 +616,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		spin_unlock(&vm->status_lock);
 
 		bo = bo_base->bo;
-
-		if (dma_resv_locking_ctx(bo->tbo.base.resv) != ticket) {
-			struct amdgpu_task_info *ti = amdgpu_vm_get_task_info_vm(vm);
-
-			pr_warn_ratelimited("Evicted user BO is not reserved\n");
-			if (ti) {
-				pr_warn_ratelimited("pid %d\n", ti->pid);
-				amdgpu_vm_put_task_info(ti);
-			}
-
-			return -EINVAL;
-		}
+		dma_resv_assert_held(bo->tbo.base.resv);
 
 		r = validate(param, bo);
 		if (r)
-- 
2.43.0

