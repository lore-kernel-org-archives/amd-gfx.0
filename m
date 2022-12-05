Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CCDC4708D
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Dec 2022 10:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 427F210E19C;
	Mon,  5 Dec 2022 10:43:46 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0116410E099
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Dec 2022 10:43:38 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id ml11so26733948ejb.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Dec 2022 02:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUDzpVjwxAngaMNNtgbpOIS9aUwCkfgRa3udhyNoc8E=;
 b=g3JCeLmkQ78rxEQ8eSXIXUpVihRdd1mzh2wIEc9ed/lqtYct6XpJdEo4LZfc7wnR7g
 hz2MSktNV/8mwFVuslXThXdA4xLDDLs0CMa3dM7/hg3lQhAnwrDw5fnldqtZkZHkgwV8
 SO2WDdPc6h8hFY/GKRLBJppP9MaZQTMjoNRfcdugzmDeKHqtiEftSvaH//672SmedHWo
 101lPohqyN/NUitzdHXJncSROq2dXlNsFbfpW8GPHxJnEkAjQHJclQJxHJJOqc41EmIG
 ZlpE0d+2oqNzDqp1HNkV0qgiHeeYaGLPBiXrsKTgstCK2NyW4QSic/26HJhvBsgQq6PB
 F9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xUDzpVjwxAngaMNNtgbpOIS9aUwCkfgRa3udhyNoc8E=;
 b=BgxIpR0zQnMTU3PhqolPAwjO6wcpd9EcHPUOG10TCN76os1nft0TN0tCkybdwOOOtZ
 dWxZ1j6Ca60iQdxiq2pSBIfIYwy3CjYxxPRRr3bfu7akY3yI4zG0IYYgPFppIzo5I+av
 wNWqQiE1dkOEtWYfgTWxhk7K22/b5pXwB/mECtLMx15VZbBPH51PTnw36BMkbo1ppgbY
 ROIPOo3abAT6TaLmWZGJa+SI63BhS6NwFYRPRX/5rAjN/EX+1nBy29vS/HNL84UubevQ
 DKezhRLuOD9ez8CVkwgA9RzUpErrrU3jPHPtOwNSggcWuk5DLHvq2wlttKHLRCTtDjoV
 4/hg==
X-Gm-Message-State: ANoB5pkSpKUeWWTw0elr/yjY4xHLN5Y18IkwbVOQYNOPg7PdQVQ7NPm1
 KonbKB3X9+gkRUE6ba6rMUwpjWixoao=
X-Google-Smtp-Source: AA0mqf6dmje6VqeS3v5E06EnFG935I9/ypab2i0sBUqLpaU2zSR+yP5i7NdotmHClhu5a+2dq6x8gw==
X-Received: by 2002:a17:906:fc3:b0:7c0:a880:dc71 with SMTP id
 c3-20020a1709060fc300b007c0a880dc71mr17948813ejk.705.1670237017439; 
 Mon, 05 Dec 2022 02:43:37 -0800 (PST)
Received: from able.fritz.box (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a056402444700b0044dbecdcd29sm4609432edb.12.2022.12.05.02.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Dec 2022 02:43:37 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: stop waiting for the VM during unreserve
Date: Mon,  5 Dec 2022 11:43:32 +0100
Message-Id: <20221205104333.12536-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221205104333.12536-1-christian.koenig@amd.com>
References: <20221205104333.12536-1-christian.koenig@amd.com>
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is completely pointless since the VMID always stays allocated until
the VM is idle.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index cf91e4440251..c18fefba5b80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2345,7 +2345,6 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	union drm_amdgpu_vm *args = data;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
-	long timeout = msecs_to_jiffies(2000);
 	int r;
 
 	switch (args->in.op) {
@@ -2357,21 +2356,6 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			return r;
 		break;
 	case AMDGPU_VM_OP_UNRESERVE_VMID:
-		if (amdgpu_sriov_runtime(adev))
-			timeout = 8 * timeout;
-
-		/* Wait vm idle to make sure the vmid set in SPM_VMID is
-		 * not referenced anymore.
-		 */
-		r = amdgpu_bo_reserve(fpriv->vm.root.bo, true);
-		if (r)
-			return r;
-
-		r = amdgpu_vm_wait_idle(&fpriv->vm, timeout);
-		if (r < 0)
-			return r;
-
-		amdgpu_bo_unreserve(fpriv->vm.root.bo);
 		amdgpu_vmid_free_reserved(adev, &fpriv->vm, AMDGPU_GFXHUB_0);
 		break;
 	default:
-- 
2.34.1

