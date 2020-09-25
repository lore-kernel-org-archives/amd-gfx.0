Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F11C4727F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DDE62399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lku3t7/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDE62399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7A956ED40;
	Fri, 25 Sep 2020 20:11:06 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29AA36ED13
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:02 +0000 (UTC)
Received: by mail-qt1-x830.google.com with SMTP id a4so3103967qth.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OQTL16Hw4kpXMVV1DV6EWjTFUQcsshzzECERZ/LJJno=;
 b=lku3t7/huK52ElKb2FqQui50fN4vCTvAfo3zlQhUqyp+YUVz2razbOefmonik5XUB7
 HnsH4gfvh0DtRBXe/i1rVffzhDBgPqhbIEIUVGI7QtGRLrk4QH3r0m8Y/FHFYpRtwyzg
 /MmxUavj6gbITC8EJ0yOe0kT/5DvTh1lqQWaRuKqHv3bJFboNETXN0wXCZYpMupq0MC4
 21Xc97CUlTpxeb+xqlQFSfu1QDRIVR2ICnHxP4IAqHIIhlYiAVPIOazeI+5OaMqxUHAT
 3HaQemrLfRwyDmcvdlMaoOw7L8sPHjrOdHhTFw0ltd0Zl2RP1VMJeJXcnlZwp9lHauEi
 OTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OQTL16Hw4kpXMVV1DV6EWjTFUQcsshzzECERZ/LJJno=;
 b=ZSqJkOWqjGb2yME0smqUdGbusNomX8MRe567iphKbm2kqFVv6f23c9gua+gUGewQhd
 B9KkG480n9DgCj5/+Qyw1CotQXIEvMfHKuV17uhYmn8/fpJqa1eI5hmQozXAepULkUqE
 S3WlZEpIvKgyDbrwBRCLEgl0WuJJCA4WszeuiGBRzuxrfHskw4RtEK/SZ+wv0UFcWwFG
 8SWXSeEToY1IWJcPCAyT9hU97j75QU1KLFhrqvIYSTzu8RROUPg7jS06EER86f1upnzq
 4yZP0EQJRDo2UVNHt0s+qRNAXpWfeZd8629bkBd7wydCq08pb730GF/h23efrVJx666p
 bUww==
X-Gm-Message-State: AOAM533lK5aG+Qd5qkP6jov8KlKQUugOrbiIkH7OIflqmVE7XnnE1xbC
 QnrYTaJNNhe7/+epmq43irMZV5XdhFA=
X-Google-Smtp-Source: ABdhPJzbDLQHsLTwhHWmJtQ41PSYA2lozjx5RUlN6m3x7oPiw+7COjh2pqym2FWJCqSC4yYy4+xwog==
X-Received: by 2002:ac8:7a6b:: with SMTP id w11mr1392448qtt.316.1601064660060; 
 Fri, 25 Sep 2020 13:11:00 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:10:59 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/45] drm/amdgpu: add van gogh asic_type enum (v2)
Date: Fri, 25 Sep 2020 16:09:46 -0400
Message-Id: <20200925201029.1738724-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

This patch adds van gogh to amd_asic_type enum and amdgpu_asic_name[].

v2: add missing comma

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 include/drm/amd_asic_type.h                | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1fc216cac345..ecaa35ada79c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -114,6 +114,7 @@ const char *amdgpu_asic_name[] = {
 	"NAVI12",
 	"SIENNA_CICHLID",
 	"NAVY_FLOUNDER",
+	"VANGOGH",
 	"LAST",
 };
 
diff --git a/include/drm/amd_asic_type.h b/include/drm/amd_asic_type.h
index 8712e14991ed..6d01cf04b77f 100644
--- a/include/drm/amd_asic_type.h
+++ b/include/drm/amd_asic_type.h
@@ -56,6 +56,7 @@ enum amd_asic_type {
 	CHIP_NAVI12,	/* 27 */
 	CHIP_SIENNA_CICHLID,	/* 28 */
 	CHIP_NAVY_FLOUNDER,	/* 29 */
+	CHIP_VANGOGH,	/* 30 */
 	CHIP_LAST,
 };
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
