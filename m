Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952A1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 15:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED8010F4B7;
	Fri, 28 Jan 2022 15:16:50 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73CCD10F4B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 15:16:48 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id u24so10393840eds.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 07:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0SSiIZQ49heLyfWRIO9M1yzFS2BLPUdWyAIWWPeQg4I=;
 b=i5qkjIj8q3B7HxwXirami3ZtE47+aoV/ygesZZuHDd+2rEd7s95f/Z2iZrV96X8SGo
 4eyywPzKkDHZWxlYgRbGh9I8swB/1V9usR6e4nRxwvPCz9yx3pMZHEKGRZNcavU+SJmW
 NpdNkmqJZiun8WP1Wk+kTpZymQZarWByQLSVWejgXoAWarED+2RJZtqnanH5uVhpw6Mz
 0UNpHz4M8HnyK+enTjOBYTAtm/Da+5QqW/6W5eGUJ/MuwBB1N84w8cX83yXsExFUf3vC
 LSQZezUTCZQmVMO+f81uyhjRF96RWycGqHDF72sX0RPOH4ASrJBhT4GQXCxsg9TwE7x8
 /vhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0SSiIZQ49heLyfWRIO9M1yzFS2BLPUdWyAIWWPeQg4I=;
 b=aUTti2C7hNwtejq6Hdd+8bC5Lvo1Bjnj4kV28eSjlVJ0tiIAgxmo60aDNmYPR0rT0y
 yurZHMPelkJzG6yvDvuYIKhWjRxR9qSqRil3vYa8JsGFeLoBTHzNf3rzHPIRSRulMhMd
 WBehiqGQmYT3UHitiIPUGMaTSrJ0jNM13Bkhtx/mmDxsHoD0pafeiq5ruqg/N4/5wemF
 tiqyuM1+0eSc77ndrDRQ3QtWXwviJr/yzH4AEbtif1qZgJiIhdQvMf/t+SqoaRx8D9Iy
 4afin/GJ/nveY38TDO5HsSTQ37b09HS8cbUmSyxWyvC5zVW7VLeY5Rptfqooif2NzyxX
 ZwDg==
X-Gm-Message-State: AOAM530yEkW3vpNYUhZikGevo1ndGoIBfyCuqCR9ZegvKtnLlEqEnjPd
 2RIV8S2aOr3p7EFJ84JrNHPoAayt9E0=
X-Google-Smtp-Source: ABdhPJz/sqLhl65jNynH4ZEeN/vgwVKNBJIW3l9D/A9t4Q4yrMKmPTdQfBjW5f0Z58JKWmfzsZ5InQ==
X-Received: by 2002:a05:6402:2071:: with SMTP id
 bd17mr8742706edb.330.1643383006897; 
 Fri, 28 Jan 2022 07:16:46 -0800 (PST)
Received: from baker.fritz.box (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id dv14sm2653220ejb.91.2022.01.28.07.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jan 2022 07:16:44 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: harish.kasiviswanathan@amd.com, benjaminadam.price@amd.com,
 felix.kuehling@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: fix logic inversion in check
Date: Fri, 28 Jan 2022 16:16:36 +0100
Message-Id: <20220128151637.1403-1-christian.koenig@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We probably never trigger this, but the logic inside the check is
inverted.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3d8a20956b74..2b0e83e9fa8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1938,7 +1938,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 	unsigned i;
 	int r;
 
-	if (direct_submit && !ring->sched.ready) {
+	if (!direct_submit && !ring->sched.ready) {
 		DRM_ERROR("Trying to move memory with ring turned off.\n");
 		return -EINVAL;
 	}
-- 
2.25.1

