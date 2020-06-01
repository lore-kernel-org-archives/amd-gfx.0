Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE55C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33177206E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0HrJQp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33177206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E854B6E296;
	Mon,  1 Jun 2020 18:03:55 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 322EB6E296
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:54 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id q14so8170403qtr.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dKS7iWPmORFcjkwZg1xUl1cFRsnUpTvtM51h2Ryh7ug=;
 b=a0HrJQp6Z+oh8PO+VqIHnn9bbjc4LHkilEFw/AFKbgsKVMjP5C96icz+wVkex3hW4Y
 d35jx6Dgi60+wT7gvWoYh8SyPS3NLkgMFJ7qJPD0wF911zefiSIMqXTVt8/ACfukXfGD
 g6F2G0wvtVhKEzfYYUdBkj6aKeILd0RwSw2RhMkRsWo4H/znglDHynOcCTuKi7/P7sEu
 zX9PR7YPnfT8L5WmyFi06+Z1P+BJo9nSA9Dj3yOKID8WMfG/RE0I6L1dT0usZ6CgDDG/
 c9Cm85dp9H+E+fNhsGheUwubKL8CKm2FYnqfyPUfiBi5N5fWAzXiNfXMF13KgKDYmrRY
 s0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dKS7iWPmORFcjkwZg1xUl1cFRsnUpTvtM51h2Ryh7ug=;
 b=gOKHDom7ZThrjsPNjn3fvbeDKrq6/H7i97rOPCTJR1oZUegNHxm4oCDNwRIbIahp3z
 8ITi/ggMMQQqSApT6DN5zi/JqltfXhdJweetKhxqk1L/fQP9MpEA90+CSED+8Fvp8YNs
 GOpQWL+CJg4o1fQeo51TbgUX4nQlJXLEKEiirV7pXnj0J1RweVxVr63F/VrQIHIf5BVq
 TMzikfqIh95/5TKLUhxi33HsArqcv9HY3ktFN0I19Z/UbjyLq88nupZxG2kyFj8RMNLK
 7aAZ5hwYGrzsQpGoUf/3W+6NqTHSVSiXncHQ5EwxJLlyj//J1OuYNcKXPnPeGrueqAXK
 rztw==
X-Gm-Message-State: AOAM5302GTN2jA0RJaIO3iM3Ftv2vmZl6E6WoIXJVwK+jZ+Jdk18v0E4
 +fJvznarA3og4+PBNQHGtR1/r+oZ
X-Google-Smtp-Source: ABdhPJymOCevswGfHeaf8sBby+D9w9723SZCtKNykKRvDqGKOfL5q8iSm2tr3h6Cw1uginiVga+JLQ==
X-Received: by 2002:aed:2d87:: with SMTP id i7mr10071123qtd.291.1591034633186; 
 Mon, 01 Jun 2020 11:03:53 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:52 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 047/207] drm/amdgpu: skip for reroute ih for sienna_cichlid
 psp ring init currently
Date: Mon,  1 Jun 2020 13:59:59 -0400
Message-Id: <20200601180239.1267430-44-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Jack Xiao <Jack.Xiao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 349fc6f2de12..234ba127ec2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -363,7 +363,8 @@ static int psp_v11_0_ring_init(struct psp_context *psp,
 	struct psp_ring *ring;
 	struct amdgpu_device *adev = psp->adev;
 
-	if (!amdgpu_sriov_vf(adev))
+	if ((!amdgpu_sriov_vf(adev)) &&
+	    (adev->asic_type != CHIP_SIENNA_CICHLID))
 		psp_v11_0_reroute_ih(psp);
 
 	ring = &psp->km_ring;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
