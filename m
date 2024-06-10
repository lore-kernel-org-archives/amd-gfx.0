Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A36C27C5E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jun 2024 09:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F036410E3CD;
	Mon, 10 Jun 2024 09:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PZB/ptsu";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26EC410E3CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 09:26:18 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-35f1cb7a40fso1161592f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 02:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718011576; x=1718616376; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wNTeqhx2x/FvfKoMHWMh9DZPQXl82k9xIEpDwTC84bI=;
 b=PZB/ptsu+zAmYayf8Sb5820ml4Ct9M0yFryzTAjsfyPduKbNlWCNQXkb83DC5se0A5
 CTeIZfud7T+xfI8ATHplCPwi8qWi6acEDaboTi7xcvctpnz54pe5OKKlOf7dFSK3lm8Q
 4RSeM80MLcbecI2fdckQJ2S0VeLHhPXiSlbgEN5FjpyMgWyHb31V57taDF7W2R0riNrA
 rK705/V7HGzf/cSIjqjQgPZdCNv5Ohc18n+ZiQv8PJ5txLPPn+weaD4Eid/0EDsor5ns
 9oXOfVqJGnKFDC6NU2TfH1O4RO+5oqMtCIW48QivOiWWbIGUtz6uypc4R20cQcMDPiPk
 u/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718011576; x=1718616376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wNTeqhx2x/FvfKoMHWMh9DZPQXl82k9xIEpDwTC84bI=;
 b=V/Bmeu1CxMCkWhaKBLbueNFfygNihkgk6shrWTWOlekfBOJzpISleJkPYuucXwp+ax
 8zt09EFxZlL1ucHqQLMTT3cyXrokfddyme67B76rVd3SzWo4NN2X/YallRdxf0U98u8X
 up83PLqi0HdSrAYwKWjXu5Ee+o2CS30pLY7WkR5PM2iJcXeYW3eOAkofYdQdC1ZymU9j
 cB2Xfsr4ejjHMgvYeJVQordQ/zKdPgv3K3klGbQgtmkWtgl/r79bRnxDSwiBOuIOpWhf
 I1/Ypi+DvcN9O11Wcuzvki4lFvxTAcy74R5EpwDo+ujGie5/OUss7mkTn9aH+1iF2+7e
 fAmA==
X-Gm-Message-State: AOJu0YzbG1mNuc45j1/DffIa1HymHaUn5U68KgIqJPt3IWJyT7ZIHEIJ
 cGezTm/0ZzJS3tjDVHdS1IOdTmwlLmA80CjWB8tjxNHJY+M9M67TCeKfBzK0OFw=
X-Google-Smtp-Source: AGHT+IH1WgldoKoSyPUo/tABNrlnTdyvwUnpbXQ8U4GwrF7F9maSQIQHHf8fxL+2YONZ0msQhwl5Tw==
X-Received: by 2002:a5d:64cc:0:b0:35f:2160:8e30 with SMTP id
 ffacd0b85a97d-35f21608f2dmr2248944f8f.68.1718011576352; 
 Mon, 10 Jun 2024 02:26:16 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15f9:7000:4916:a8ec:dd12:5894])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f2169fc45sm3075827f8f.10.2024.06.10.02.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:26:16 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: pierre-eric.pelloux-prayer@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/9] drm/amdgpu: stop updating the SEQ64 VA during open
Date: Mon, 10 Jun 2024 11:26:08 +0200
Message-Id: <20240610092611.2894-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610092611.2894-1-christian.koenig@amd.com>
References: <20240610092611.2894-1-christian.koenig@amd.com>
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

Stop updating the SEQ64 VA when the KMS device is opened. Instead update
it on first use in the CS.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c    | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 7 -------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index ec888fc6ead8..37b0ce86c256 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1117,6 +1117,14 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			return r;
 	}
 
+	r = amdgpu_vm_bo_update(adev, fpriv->seq64_va, false);
+	if (r)
+		return r;
+
+	r = amdgpu_sync_fence(&p->sync, fpriv->seq64_va->last_pt_update);
+	if (r)
+		return r;
+
 	/* FIXME: In theory this loop shouldn't be needed any more when
 	 * amdgpu_vm_handle_moved handles all moved BOs that are reserved
 	 * with p->ticket. But removing it caused test regressions, so I'm
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index e22cb2b5cd92..8d0a3cce979e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -97,13 +97,6 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		goto error;
 	}
 
-	r = amdgpu_vm_bo_update(adev, *bo_va, false);
-	if (r) {
-		DRM_ERROR("failed to do vm_bo_update on userq sem\n");
-		amdgpu_vm_bo_del(adev, *bo_va);
-		goto error;
-	}
-
 error:
 	drm_exec_fini(&exec);
 	return r;
-- 
2.34.1

