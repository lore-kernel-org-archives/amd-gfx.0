Return-Path: <SRS0=YeOH=4B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87893C3B18B
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 11:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D177222C2
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 11:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gISUHEgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D177222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 071DF6EB3F;
	Thu, 13 Feb 2020 11:59:44 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EC236E2E9;
 Thu, 13 Feb 2020 11:59:41 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id c9so6334368wrw.8;
 Thu, 13 Feb 2020 03:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uoRiz/yCfYmISchjpyJf1hrpfWSLdm8PUF+EU7Rtbqw=;
 b=gISUHEgOKM+fMZ7ETkKrvkvINDbpL3B/PsmYt8DtFzNlpIJwIWI+Fk8JpZtURzJs4T
 6ehxIrlYDnM1GwZH3AitzvxtPyL3KgmwFhgo3IWUyXHmr5VtkSXRe4uPFT18fWqJU1mO
 /ispIaGng8CWNcqnKVxu3F9McToP2lvl5QUbxi0NfCwGtpNQgVnnE2I89iOewXsxTz2w
 5HudRG8uAC5PtsfMUWiN/pkqQ+bTV8dBxBQPVaW26gce0pxugQcEGyKODofvDgN6M/Hm
 Z10emjX/0XChNrBuI6OXIfCN7OV7x5G8tNQMud68NIOGV/+lhNOithxnNee7BhAqJ4+A
 P31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uoRiz/yCfYmISchjpyJf1hrpfWSLdm8PUF+EU7Rtbqw=;
 b=TWvptfQcxoGPm1P3nhEZ5jC5RZokVDmsAqpSUS5kgyZqBCMsI0KN20zPjJAyhLelDI
 Kjl1712bJXJr3j77Xz/kSigqvarKnkHc55ubcIb8AyUeRWLFI2gsy77F0RYxVgmHfAvZ
 zlCh44nO5kZp9obvHjzJ60UBPq7NxyzzWS3CUF/whZggIap4vAhR72YWJtQIRZ72s6mw
 ItQQKXRkv8FKUFdQh9Gjb/lCOopr66/omz4fCsbD8lJsoGzD732gu3WQQB6K9opqyZFR
 qkx8IzaZ772Y4ibQX4FhSSNnsmuum1wxTKPu+ZtCT+bQw6z0Wkoij45iZMirSNPn/SuQ
 gQfQ==
X-Gm-Message-State: APjAAAW8SbrmwWfGZeo3QcBY3BI0567E0wo1f8PANsyilB7kBL/ChnGP
 tw7SYaTIWwGcKmG1KmRIW/402xrqxmS3lw==
X-Google-Smtp-Source: APXvYqy8AdIpRVgljtPvh9is/2rVfDRLrfGJxy08f3QDz7HPiZ4jJyZlF7ZPZoWXje7c7r/saMbZ4g==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr20934443wro.310.1581595179333; 
 Thu, 13 Feb 2020 03:59:39 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2A5E004DB99F42976E8A13.dip0.t-ipconnect.de.
 [2003:c5:8f2a:5e00:4db9:9f42:976e:8a13])
 by smtp.gmail.com with ESMTPSA id y131sm2803985wmc.13.2020.02.13.03.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 03:59:38 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 6/6] drm/ttm: do not keep GPU dependent addresses
Date: Thu, 13 Feb 2020 13:02:03 +0100
Message-Id: <20200213120203.29368-7-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213120203.29368-1-nirmoy.das@amd.com>
References: <20200213120203.29368-1-nirmoy.das@amd.com>
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
Cc: David1.Zhou@amd.com, thellstrom@vmware.com, airlied@linux.ie,
 kenny.ho@amd.com, brian.welty@intel.com, maarten.lankhorst@linux.intel.com,
 amd-gfx@lists.freedesktop.org, nirmoy.das@amd.com,
 linux-graphics-maintainer@vmware.com, bskeggs@redhat.com, daniel@ffwll.ch,
 alexander.deucher@amd.com, sean@poorly.run, christian.koenig@amd.com,
 kraxel@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GPU address handling is device specific and should be handle by its device
driver.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c    | 7 -------
 include/drm/ttm/ttm_bo_api.h    | 2 --
 include/drm/ttm/ttm_bo_driver.h | 1 -
 3 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 229205e499db..2ccfebc3c9a2 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -85,7 +85,6 @@ static void ttm_mem_type_debug(struct ttm_bo_device *bdev, struct drm_printer *p
 	drm_printf(p, "    has_type: %d\n", man->has_type);
 	drm_printf(p, "    use_type: %d\n", man->use_type);
 	drm_printf(p, "    flags: 0x%08X\n", man->flags);
-	drm_printf(p, "    gpu_offset: 0x%08llX\n", man->gpu_offset);
 	drm_printf(p, "    size: %llu\n", man->size);
 	drm_printf(p, "    available_caching: 0x%08X\n", man->available_caching);
 	drm_printf(p, "    default_caching: 0x%08X\n", man->default_caching);
@@ -382,12 +381,6 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
 		bo->evicted = false;
 	}
 
-	if (bo->mem.mm_node)
-		bo->offset = (bo->mem.start << PAGE_SHIFT) +
-		    bdev->man[bo->mem.mem_type].gpu_offset;
-	else
-		bo->offset = 0;
-
 	ctx->bytes_moved += bo->num_pages << PAGE_SHIFT;
 	return 0;
 
diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 65e399d280f7..3cf8bb82c899 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -219,8 +219,6 @@ struct ttm_buffer_object {
 	 * either of these locks held.
 	 */
 
-	uint64_t offset; /* GPU address space is independent of CPU word size */
-
 	struct sg_table *sg;
 
 	struct mutex wu_mutex;
diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
index cac7a8a0825a..302b0aaf8d13 100644
--- a/include/drm/ttm/ttm_bo_driver.h
+++ b/include/drm/ttm/ttm_bo_driver.h
@@ -177,7 +177,6 @@ struct ttm_mem_type_manager {
 	bool has_type;
 	bool use_type;
 	uint32_t flags;
-	uint64_t gpu_offset; /* GPU address space is independent of CPU word size */
 	uint64_t size;
 	uint32_t available_caching;
 	uint32_t default_caching;
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
