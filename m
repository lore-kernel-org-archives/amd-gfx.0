Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC1DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 08:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CAC210F325;
	Mon,  7 Feb 2022 08:07:50 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C2D10F324
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 08:07:48 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id cn6so5539871edb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Feb 2022 00:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bfGDLmPqZAfGnkaBnwMstMuoVf2IimkIXphouHayMUI=;
 b=qAXPp5xYdQAZOopdn90wLCGR1hCDGcmzaA+ET8EQnbRr8+Le5Hh6FwG77lHEw6vrRg
 Q/8pPFeD4V1gT7z3shbaKgWGYkSYaMVauWtdPPjCX4Fwk2N3Lq/x9oAXFZpDfo84Xk4v
 CKinBtixyM90/OF5Zb6Cw6fSQq4lfj9QE2+4XWnUbgWk9ADZ4NiV6JEcFxzvC9cGVMgV
 Deuv01dh2UxsF8qOazuSex6zMl/BJ7l3XLdjLaK8BuTB7btlG+MCWQjdCAWCA3+Zhb6e
 ugXcIEDcUhqcAkTw7HrqeUf3aPoNuTAhPf6xjVLy8ZAxcdVzzENGGyMNSkW6ycBkM4Vf
 Zwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bfGDLmPqZAfGnkaBnwMstMuoVf2IimkIXphouHayMUI=;
 b=2sxgX9BAIpNPsMnxgb3aPijFp3zCX1qRLSOmebwr2bWphCp/4mC/pBDzcuhXbPdBCH
 Pa5/wkMJj+Z6sTQnUGiqrlesQiBWBvNh90rH9EUQEGwjBhAdAVWM9rYpq2ubIEVW8GvI
 cLFCcWqpbpmqT5To5V8lp6ojc7MRFVuIaHARRhOd7myd5geflqLWQLA33qDec4oc23Hx
 0QWdLrKsLU+yAXQnW7EfsD+TDiTiXeDhCXAT9kdWEc2lVUdF8CGzOTsM56zNnDYd088f
 z/Fb0IxvJcxKyMkUN68kkcOdzaumhUnYNz4T7udSJd+uSELT06QWtE7b0mnUlt6QvJHL
 I5fQ==
X-Gm-Message-State: AOAM531Ex7YNTOoHTKYrdgxaP1Uj2SzBBk81Edc6y5sDptC0etbR/1uU
 f8LIQva8aNK3DcDPu/mMgNc=
X-Google-Smtp-Source: ABdhPJyo6mNgXy+6lA/1paAo0vu6TlmPj5ezkaRd51xXhprHUdhTFdSK6e3ZQSXbQKvPBM3YN08GOw==
X-Received: by 2002:a50:bb0c:: with SMTP id y12mr12710277ede.421.1644221267573; 
 Mon, 07 Feb 2022 00:07:47 -0800 (PST)
Received: from baker.fritz.box (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id en9sm203701edb.71.2022.02.07.00.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Feb 2022 00:07:47 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: rajneesh.bhardwaj@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: reserve the pd while cleaning up PRTs
Date: Mon,  7 Feb 2022 09:07:45 +0100
Message-Id: <20220207080745.1711-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We want to have lockdep annotation here, so make sure that we reserve
the PD while removing PRTs even if it isn't strictly necessary since the
VM object is about to be destroyed anyway.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index efd13898c83e..9f985bd463be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1194,8 +1194,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE) != NULL)
 		amdgpu_vce_free_handles(adev, file_priv);
 
-	amdgpu_vm_bo_del(adev, fpriv->prt_va);
-
 	if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
 		/* TODO: how to handle reserve failure */
 		BUG_ON(amdgpu_bo_reserve(adev->virt.csa_obj, true));
@@ -1206,6 +1204,10 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 
 	pasid = fpriv->vm.pasid;
 	pd = amdgpu_bo_ref(fpriv->vm.root.bo);
+	if (!WARN_ON(amdgpu_bo_reserve(pd, true))) {
+		amdgpu_vm_bo_del(adev, fpriv->prt_va);
+		amdgpu_bo_unreserve(pd);
+	}
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
 	amdgpu_vm_fini(adev, &fpriv->vm);
-- 
2.25.1

