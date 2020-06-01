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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93C5C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F9A2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faAILorA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F9A2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4224E6E32F;
	Mon,  1 Jun 2020 18:22:01 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E7346E32E
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:00 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id c14so8977958qka.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b0RMcGSePa/u/ZIsqV49VgCaInCpOY8eHw8sJc2YW0I=;
 b=faAILorApQz4n9ogWsJmnINlau/6TviaVi5N9eo2vs3Vl1LE3MRdWELL4mScvrbNu/
 Ln+YLI6C6dy/MH72naU0Ecjfo6J7Rx76YTSzO81PxDYiSFkBbZaZL1MipZ5MR3L3m/3D
 +ss4NUn7/mCAvY83mrmZAwHi6URRvbu7MzHdITgBN4GsDaBT1TOmFb2i515pVuwibHfQ
 fribyJjJcQER/eXb9jFwsP6+FGufwhz7b8i4taB69WMk03V83oDLe/YyqFA20QKAeKJy
 KmqNUXrk4qe5CdwaOmtKssMnBPgwc2j6cMWF+tm37xItLrQZNnhAeJYJL5oGNX1RDIAp
 MzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b0RMcGSePa/u/ZIsqV49VgCaInCpOY8eHw8sJc2YW0I=;
 b=sQDLfbLcw/GUGoOh/R//6v/gzeq02DVTG5a9TmknZ7TfHTvrC1gWQAtdGjXHh7fJUo
 BBJCvL0q878iFuosA+mDz7341HxoON695lnU2JnMm0ho1IaBuihvwtNJM1Mpx3SzuMk9
 JmrTAtZIX+TF+f/CwCFsP21olzB0+DS1sTMekeV/3PRp3Ixo+TFP5GnJp64sERfJwTbA
 Z80Mc/EgSRWr9kH2hrvHENYgSs/M3zU9UuQ2/prMLVsN0wTm9Mv4gMltV4ygGZTHQmLH
 fdad1iQ+7qbnSMCwvBkmlHi+9VHVSiQ6UkEzABzNXLidPnUBVG0jndJbkty3P1CXRuXk
 3ADg==
X-Gm-Message-State: AOAM5335BI64DoOOfI7ZtEv+DHQ93pvjA6YuKEUaRCJL9/3ciX/Gc5r5
 RCFwG/KQrmgDGwR5/+f//D1uaVrS
X-Google-Smtp-Source: ABdhPJw15WhwAAkrkRfeYc0hOLJJJtVELRbZwLWqFGdaoyRZJvhk4G7SC/z4gG30o6J395FsNSeRLA==
X-Received: by 2002:ae9:c10d:: with SMTP id z13mr19840458qki.3.1591035719603; 
 Mon, 01 Jun 2020 11:21:59 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:59 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 132/207] drm/amdgpu: skip VM inv eng assignment for mes ring
Date: Mon,  1 Jun 2020 14:19:39 -0400
Message-Id: <20200601182054.1267858-43-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Statically allocated VM inv eng of gfxhub on sienna_cichlid is used up.
Also VM inv eng is no need for mes ring.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index acabb57aa8af..34cbd6f6a56b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -357,6 +357,9 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 		ring = adev->rings[i];
 		vmhub = ring->funcs->vmhub;
 
+		if (ring == &adev->mes.ring)
+			continue;
+
 		inv_eng = ffs(vm_inv_engs[vmhub]);
 		if (!inv_eng) {
 			dev_err(adev->dev, "no VM inv eng for ring %s\n",
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
