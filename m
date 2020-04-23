Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A5DC54FD0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 20:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 879532073A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 20:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nk/jrrE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879532073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3360C6E9CE;
	Thu, 23 Apr 2020 20:47:33 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEC696E9CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 20:47:32 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id o19so8004464qkk.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 13:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8dlNYzuch5VqJKphQ+jkb9CyeZd8i5VcmJNU5lGTcz0=;
 b=nk/jrrE5Wf46BWkOdYDxf1YtysdnLpe5BcCRgcglHT1batWPDOKD82ah757TzzXBiV
 8kghqMRicwpd0yrFJ3kmHAXYxPc9jR0/64C5MzgLUYOzYn0Pj/4q5Y4/PGJzadmTWwtg
 F2s2N/EOZwWrZJ3zjcvCLVHFNwqYAagwMIGXM/6Oq7FFXjBuESEld93P+NAF1knVSEiM
 pjOvVukRcmmyHWP6aQq4q0wgOKeDnd0ffsfKfs6bY11dcVr8N8WDna0a0EBZF0dhrLwM
 fB8e1J/Pb6ZE2QOrDEFAsJ34tE0zybp1keTJfAfhjENb3V8VMO85PNXbXc+9uyTeb8Vo
 BaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8dlNYzuch5VqJKphQ+jkb9CyeZd8i5VcmJNU5lGTcz0=;
 b=Kx/bkgkd8bC8KamjAEZDAc5sAzJVu+AbHWAbjboxicpXbvqzVuqx0v52Pw4EIzzDEJ
 vBVHJYaBYrEv27v/1M2kYlGlnHSboNkgvjhYChb3s79WbzJhkrhNkKQCeOf6gWB7nGSZ
 hWyCD2UkQ6KXMmY8+lbVXFlpRhuF93zPWw33mZb/SSux5ezfRuScDkBbhrsdqv38QG4z
 bKuuPWi9r/7hIrC2P/31crhzzXZgTpLRWj4qGeLreNsuDzzaEy/b5+VvWXVXMyhwBmw4
 AB5KQ9UQmFrPSBpM82gOh3S3prIrWcp0IHhpxC5kG87W/Peg9ngM9bZsi9sJ7NUjq5Ub
 gdkA==
X-Gm-Message-State: AGi0Pua7yI52gHIAhUtUtREDw+yBX+0bwY8I3rlQnDkjrzLgfGF2xrs5
 1VQmTqPHJD271nus/I3sl4KcPDiq
X-Google-Smtp-Source: APiQypI7rvfcOXU6DGzYNhDpL2kAzQZcrIuJ1VALzKgpznYNqBRXv3co4184+lTGDuIONTdxZ+av8w==
X-Received: by 2002:a37:4a14:: with SMTP id x20mr5620780qka.357.1587674851612; 
 Thu, 23 Apr 2020 13:47:31 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id j25sm2367912qtn.21.2020.04.23.13.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 13:47:30 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: check ring type for secure IBs
Date: Thu, 23 Apr 2020 16:47:20 -0400
Message-Id: <20200423204720.1063581-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We don't support secure operation on compute rings at the
moment so reject them.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index ec2c5e164cd3..b91853fd66d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -161,6 +161,12 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		return -EINVAL;
 	}
 
+	if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
+	    (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)) {
+		dev_err(adev->dev, "secure submissions not supported on compute rings\n");
+		return -EINVAL;
+	}
+
 	alloc_size = ring->funcs->emit_frame_size + num_ibs *
 		ring->funcs->emit_ib_size;
 
-- 
2.25.3

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
