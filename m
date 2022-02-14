Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FBBC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 18:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3092D10E258;
	Mon, 14 Feb 2022 18:24:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE9B10E28C
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 18:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644862961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6KphgiHwgRe3NkAsq1kWFGjvzJI/mlc7nnNKh2wAjkA=;
 b=VSFm4sibOIjm3A+++6v3bbR9bj12ka0JterZOKWd6oaGWkmJ2MQkaPjPusIelVpgMTvwBf
 yCZcIf5WWFge+Be0HuIbx+qeXWIbzExELpYANWA6E3fBRm+yiuOXDW8zlvgyfDEgRc4X+g
 TKmH5ShZdzLYvQhfSNrs7dEmtFnj7Os=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-NHe1S0zxNvuf4oSGszHMIA-1; Mon, 14 Feb 2022 13:22:38 -0500
X-MC-Unique: NHe1S0zxNvuf4oSGszHMIA-1
Received: by mail-ot1-f69.google.com with SMTP id
 l34-20020a0568302b2200b005a22eb442daso10789875otv.15
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 10:22:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6KphgiHwgRe3NkAsq1kWFGjvzJI/mlc7nnNKh2wAjkA=;
 b=ss7kbowxYHO/mSWH292Q4LJ8388BD3JuwvMEm0DGunKS6JHqFSI8mobEy61xjSIEK/
 5XpJj9pS5yi16+Lw3/ig/GQ1RXP9MGm9YKKgnC2cenJQ+CSuWY1kxUdsOgobEqw5LWPj
 dJTV/wwd1UZC8LJhprxTwX2Jeo/rTr5IvIth0so0BYaexfS6MHKP5u/fNCkomTb96qcC
 ghtnG0m+D0NgmGRepJnOdm9EtC+ywiaJ6UBS0P+pqfBIv07pRXO4TKSqkWUyKiV6yLeh
 Xl9oZ55SAIuQhsZyQq1PZ4fj+Fh91iW4xRDfQlvJk8Z/QPeT+XIc2AAmgAgZTnI3R3E9
 RdRA==
X-Gm-Message-State: AOAM531kLpQf8pCto+75uMGLNrJKmmCeTRLdxK/Dfgu/BI6opG4Vhcy4
 2LRWVAZtAuU4BgudciSjc6hr7z/MevT5vWThzICbZoBzNrB80fvyjjFkTWJSZd0DQSIK49MxAzt
 Q1e72iW1KOfxVFG2h7YoawXZJXg==
X-Received: by 2002:a05:6808:2227:: with SMTP id
 bd39mr64705oib.142.1644862956380; 
 Mon, 14 Feb 2022 10:22:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVpfes2LLHqPuaIsi0+RkM/zs2xkzYjID6G+ExdR/vMlhePhV1G0FpY7aHAfq8EanEFOo3Eg==
X-Received: by 2002:a05:6808:2227:: with SMTP id
 bd39mr64640oib.142.1644862954708; 
 Mon, 14 Feb 2022 10:22:34 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com.
 [24.205.208.113])
 by smtp.gmail.com with ESMTPSA id j6sm12673419otq.76.2022.02.14.10.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Feb 2022 10:22:34 -0800 (PST)
From: trix@redhat.com
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@linux.ie, daniel@ffwll.ch, nathan@kernel.org,
 ndesaulniers@google.com, luben.tuikov@amd.com, david.nieto@amd.com,
 nirmoy.das@amd.com, Ken.Xue@amd.com, Roy.Sun@amd.com, evan.quan@amd.com
Subject: [PATCH] drm/amdgpu: check return status before using stable_pstate
Date: Mon, 14 Feb 2022 10:22:24 -0800
Message-Id: <20220214182224.2906060-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-Mailman-Approved-At: Mon, 14 Feb 2022 18:24:32 +0000
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
Cc: Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this problem
amdgpu_ctx.c:616:26: warning: Assigned value is garbage
  or undefined
  args->out.pstate.flags = stable_pstate;
                         ^ ~~~~~~~~~~~~~
amdgpu_ctx_stable_pstate can fail without setting
stable_pstate.  So check.

Fixes: 8cda7a4f96e4 ("drm/amdgpu/UAPI: add new CTX OP to get/set stable pstates")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 1c72f6095f08..f522b52725e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -613,7 +613,8 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 		if (args->in.flags)
 			return -EINVAL;
 		r = amdgpu_ctx_stable_pstate(adev, fpriv, id, false, &stable_pstate);
-		args->out.pstate.flags = stable_pstate;
+		if (!r)
+			args->out.pstate.flags = stable_pstate;
 		break;
 	case AMDGPU_CTX_OP_SET_STABLE_PSTATE:
 		if (args->in.flags & ~AMDGPU_CTX_STABLE_PSTATE_FLAGS_MASK)
-- 
2.26.3

