Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFF4C5B56D
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D39A10E6BC;
	Mon, 10 Aug 2026 06:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZG09p04m";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29CCD10E161
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2026 14:47:00 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-38fdeaed181so1268191a91.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Aug 2026 07:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786286820; x=1786891620; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TTdDEO4C2pVqpnKnvMmpty/7Skli343KUkxbaW4hUmA=;
 b=ZG09p04mXy4F6+d4ciqrsws1XEPJHrRD44OIur2v3Rj7gD6UmVg9eu1+nawfMlayyZ
 7TE7cjHWNzC8Ff1d23kGFe4DWCrZclth6EwjTcUScoPjgPPRneOE5yWbvuXre/40d/IA
 5W6Q2AUMvsC/ZdZJwM4FvydlYZ5Xw29Th5xv+hDPpBNcIa97P+hJ1MuAkUtdlkiMHrSV
 GLw0gvX39Zy5vfmr4e9IWlJMo4LZIOY5mMI8rdqOufr04TNQE65HwToKX77tELqa0Glz
 trxryPpUSFazMnqEPzmF00aAjZWq+FmQtel8MPifxj01nRlkAw1UrRS4io+YvrGZ1jgO
 WP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786286820; x=1786891620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TTdDEO4C2pVqpnKnvMmpty/7Skli343KUkxbaW4hUmA=;
 b=gzXivxBaPbKa8dB/zza+pBAWxIOmk9LCJU5fFI9WYObNXXtDe6FR8GCR2CLPC61vCI
 Oe2plle8HN0sMlR1WoNJTqCSxl1E3yS2URsKF+H3EP8TFAdUxBQg+JZSfFR7ZCf3/g9i
 qRRXRriPQb4Gn0Xnv+Y73aKhOv48FF4CwuEg1t+DZwTdvbRPoNMyd68DganSNCKsHbhl
 qh+XTwyko131RbqpiQtfkQr/Q8hX+j6Hw/CWY91ZyvirRQFWSefU1Kl0XgmzbPpftLr5
 1l6+UsmIJ19kI9A0U+IOIsmjETfCH0j2oeLsIgle5cUQWKHcs6sThpWnGWviWcJlVA8S
 Ue7Q==
X-Gm-Message-State: AOJu0YxPhewlNTfX1gFV2ugunjNv/L7pF5yDOxZ4yMGu9TmOGuI4lQ61
 UMlAPcAl9dV7IWbW+kFDyr67D7wCCKb+lcwTA+r4kBE8V1DhTyfI79f3
X-Gm-Gg: AR+sD10CHggpOqV5CzfAioTuaXy5qHGgQ7sWtXv0H8BxWI2TMk6iTj1A+zX4Jjt0pcA
 7qVI1/08+3bKy1ge82kkHNTLgpe+xlxY8Umw092oeMpaRVNUqkpP9nN8F2rs3WnqqrNwZYj7iMq
 P4XAJbQG8yay10ZgCLm2qupnCq/oDKhCZmUq9jMJ7OLqit8DXnujEF66AJ2VhcLGTrt1A42GVNh
 UkzGA/vgGed/s1BFZ+OctO2lh7WzzrWn2twoWpqRE1csnsUImYqk6m4pAelGllu/IXdwf2qgfqE
 sH3eGoq1uaB+ZLHAyZKzb6Y395rWbeMXd1KygvylvosXbVRmh30x9au8Ztkp91/qpi811FXK6uC
 g1GbVZCIC4WYU1rtbVztMhpSInBBUb7IrO8MvzBjsnHOHI/E82VjjVe6nZeX0os1ASQhI8PBu70
 TAGEgXSqhUMSw3DkcdU0Ld8T3A3K7DYnCXU6EWAeOgrWxGDHHGVSjRQb3z4ktBzn+FMQ6HkXO0B
 FVt4OckQaA=
X-Received: by 2002:a17:90b:3889:b0:38f:57f0:1f5d with SMTP id
 98e67ed59e1d1-3903c5c4491mr34362200a91.15.1786286819656; 
 Sun, 09 Aug 2026 07:46:59 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14101b7ad29sm25911224c88.13.2026.08.09.07.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 07:46:59 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v5 4/4] drm/amdgpu/ras: Fix delayed work cancellation order
 during teardown
Date: Sun,  9 Aug 2026 14:44:51 +0000
Message-ID: <20260809144451.35431-5-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809144451.35431-1-sreekuttan2156239@gmail.com>
References: <20260809144451.35431-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:03 +0000
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

In amdgpu_ras_recovery_fini(), mutex_destroy(&con->page_rsv_lock) was
called prior to cancel_work_sync(&con->recovery_work) and
cancel_delayed_work_sync(&con->page_retirement_dwork).

If pending work ran during teardown, it could attempt to acquire
page_rsv_lock after its destruction, leading to a locking violation and
potential use-after-free.

Fix this by moving cancel_work_sync(&con->recovery_work) and
cancel_delayed_work_sync(&con->page_retirement_dwork) before
mutex_destroy(&con->page_rsv_lock), ensuring both work items are
synchronously canceled while the lock remains intact.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 764cd4950408..1d6b4300d80a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3994,15 +3994,14 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
 	if (con->page_retirement_thread)
 		kthread_stop(con->page_retirement_thread);
 
+	cancel_work_sync(&con->recovery_work);
+	cancel_delayed_work_sync(&con->page_retirement_dwork);
+
 	atomic_set(&con->page_retirement_req_cnt, 0);
 	atomic_set(&con->poison_creation_count, 0);
 
 	mutex_destroy(&con->page_rsv_lock);
 
-	cancel_work_sync(&con->recovery_work);
-
-	cancel_delayed_work_sync(&con->page_retirement_dwork);
-
 	amdgpu_ras_ecc_log_fini(&con->umc_ecc_log);
 
 	mutex_lock(&con->recovery_lock);
-- 
2.54.0

