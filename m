Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FD5C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3541F2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efDGD7bF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3541F2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04B156E343;
	Mon,  1 Jun 2020 18:22:19 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 747EE6E343
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:17 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id s1so9989685qkf.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eUPxJkRy/vpF5A/fiyqMqJPR9qTkboSQcGq+Izs+8AM=;
 b=efDGD7bFQBrA8Xctm7eiRPrJHxoYmmb4w9Zng6rjRFUDhOFZHpXKrh+0WvyJNhqKq0
 IDUZevFRVIsSeUTJdeEkSU1lBbnRrQNfZ8gGnSzYAgC8t7HUsQvzcDogm3H05nzizWT+
 r3I98gd02EQDxFVmz0GQxyFq6I36HWqAP8bhwe6npP0YjV/ttm5Y+zrQMLGpPxShzhde
 qbfJTHV74Dq7zDuBJxSWPynSVakq/1dvbW7Hcnqmliio8wIz8KA62YYBf6a0taPTDZ7B
 lKZWiv1xo+N2RpAZioes5ZDOqeYPTNGppGO9gVGuWmlp7dE6bBwjy/vjrmZgiHpl5xGA
 Kknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eUPxJkRy/vpF5A/fiyqMqJPR9qTkboSQcGq+Izs+8AM=;
 b=RSnGvJXkPTxVkoSYmXL5QcVb0FSAELYzMcgHTgvvTP7igzVR/E86WghGB1bE6amZxU
 xLkug6EYiVmdjv6hb266Y1m+GmX1f/So/r1N4gzzk++apWsxksR4JWBpN4JFYmi8PL+D
 4JHeA/BE4gW+8N4RwMRjWX10GzdpzAPQGIV/911QwH9W0j9Ln+JLM5gKyNbt4uO3lNwz
 wITbfjgBvWC4/O09JMWq8WNWLoVjsfDBOw2A5a9lXJ0PT4s7RvD/CkxQgj80PQo0/zlr
 pm3N10GYAjoB1xYOCyPMfhE4vQSO294upauUKajF3D/ZoYaCm3bq1c+16hcjRVQfwS1s
 eapA==
X-Gm-Message-State: AOAM533W9b3CmUgtvhP7ISIja/VqnLbHeld0DCE4Pyd4c6JQdlIx43ax
 WjdYDuHUL3xb89IvWuCPFHYsj7iU
X-Google-Smtp-Source: ABdhPJzp/ZYHQj8Jx4x+5UmSOQbrGIqW07CKkw8zvHatz43MgbIP6gK7aCw3CQpVUOIBqygrANGjVA==
X-Received: by 2002:a37:7244:: with SMTP id n65mr20805063qkc.483.1591035736417; 
 Mon, 01 Jun 2020 11:22:16 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:16 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 145/207] drm/amdgpu: set indirect sram mode for VCN3.0
Date: Mon,  1 Jun 2020 14:19:52 -0400
Message-Id: <20200601182054.1267858-56-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>, James Zhu <james.zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Boyuan Zhang <boyuan.zhang@amd.com>

Use indirect sram for secure DPG mode

V2: update description.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: James Zhu <james.zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index fff77b629d04..15ff30c53e24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -111,6 +111,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		break;
 	case CHIP_SIENNA_CICHLID:
 		fw_name = FIRMWARE_SIENNA_CICHLID;
+		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
+		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
+			adev->vcn.indirect_sram = true;
 		break;
 	default:
 		return -EINVAL;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
