Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65981ECAAD8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 12:16:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D005D10E510;
	Tue, 20 Sep 2022 12:16:07 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C860510E510
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 12:16:02 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id bq9so3983324wrb.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 05:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=dWA8484IuvOKOM/Zra59VJNkFv+v1G1SetaGkDLdp7k=;
 b=R1m4zYdsxJ6eZYqDU8V5GSXBsD/wQ/O09ZSXagkbSZLsPc5q05SMtGcGLiYuCaLuwn
 PIrYFD1khTZ2m21U/Jc+Cez8gYUVtonhU1OJq7xZK1o/SQaX8mxpR6d1C9uILjf3fNX4
 coEO7ZoJBNKulQOXFfz4iR692f2sRp39Hutz4EJ9+IB4/v4GIjFxEiRwUGr620fU7EHN
 BEIdzq2XSSitptAI3anKgTAJt0FQOoJK98KvNd8q1WICt94xzLOqoK3uE39iI0Bga4hG
 eDW674db0Y8ZyW3VQ1C2erHD9dmbnuloyb/cixjk0kZFxkC7FlMu5Me2/KCTaOyxrC+v
 1aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=dWA8484IuvOKOM/Zra59VJNkFv+v1G1SetaGkDLdp7k=;
 b=uD1RziFh3jTeHfGCovVqLXOiSXkAuunfV8Ma+yWmeUskoZ9o0ZebJBVwXLL92eOeql
 js9tv6SkDl5kE5Gjn6lrNWiiroFw/JSCbIR6mqIGnKv/tHur1BUILMTelKQkzAEDVgKr
 2ohdHq9jhimM6HFFEATw5o7nxhAII+WWWASTWjG3l2B+bt+yill8aLnYnLe66JU+pf4I
 3NRjWAxzv71pNmEIu8B7vSVP7eLdZhaVGmuB7EqzdyTf5mb1NBlcNqjX3zCm/uUeQBJQ
 hK3I0R+g/h9hTEg8UbiKGtguptsFxPqfc9mCMlqpHRhZplds2tGGMPgv3GSLaa2dKDLF
 CjoA==
X-Gm-Message-State: ACrzQf1q7dUxlktnlhAbcsHaFI1Ur3MUEGurTihesU3VvqtGBgnOoDYw
 PmNY4o4OFI89avNUweNxm0Ry+nGg5+g=
X-Google-Smtp-Source: AMsMyM6/eH6kvKu63EVB7xheR1QdB2v+aKNaZa4JuDTcpzvxJZDxxpRgxfEtHJmqUqCQ1VPVqKvZfw==
X-Received: by 2002:a05:6000:1688:b0:22a:fba6:77fe with SMTP id
 y8-20020a056000168800b0022afba677femr6804044wrd.266.1663676161184; 
 Tue, 20 Sep 2022 05:16:01 -0700 (PDT)
Received: from able.fritz.box (p4fc20ebf.dip0.t-ipconnect.de. [79.194.14.191])
 by smtp.gmail.com with ESMTPSA id
 m28-20020a05600c3b1c00b003a6a3595edasm2913370wms.27.2022.09.20.05.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Sep 2022 05:16:00 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: properly initialize return value during CS
Date: Tue, 20 Sep 2022 14:15:59 +0200
Message-Id: <20220920121559.2815-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The return value is no longer initialized before the loop because of
moving code around.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 1ce5d2d0c831 ("drm/amdgpu: move entity selection and job init earlier during CS")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 58088c663125..e452350f462a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1184,6 +1184,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	/* If userptr are invalidated after amdgpu_cs_parser_bos(), return
 	 * -EAGAIN, drmIoctl in libdrm will restart the amdgpu_cs_ioctl.
 	 */
+	r = 0;
 	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
 		struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
 
-- 
2.25.1

