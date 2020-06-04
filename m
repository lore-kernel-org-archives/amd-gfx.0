Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C51C433E4
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 08:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1D5206C3
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 08:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RUvuRoaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1D5206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2636F6E2BC;
	Thu,  4 Jun 2020 08:12:36 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9CF46E2B2
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 08:12:35 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id t18so5045272wru.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jun 2020 01:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ys1lEmo1OrglME8cWbIXSVFR7KWfyvCPNKiL9IEbmhc=;
 b=RUvuRoaAUx3zoTg0dekOOqbI1T8Sgso/qeY9AgIY+69YkzMVoxVd2zcJLUgcBipdk7
 bfLnFFHUCXlCtl7HOikMZEY9KbeA3ZJCmbGvpYaKPSFaizoR8g1G0iiiWixkm2fyo6ve
 uHh1ScOQIMEnMrZouE9W6fbm6RZuu2BrIaMFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ys1lEmo1OrglME8cWbIXSVFR7KWfyvCPNKiL9IEbmhc=;
 b=iBCUuTlmvUmL7zjdXLvoO5tR+Pk1fFxeyPAKso1kdJCAZaAxPhDSRLG+0f5Z8slMTk
 APeZ31AigFWHg5fb7GQpXLmPsTCyPXpLDL+mFiRX3bK4trtRePEqOdItzgf2jX+JKNCI
 nv3mZg/Cnzt1/7qP9hqVL9Yu38Tg2HW+5mGrJLGqB1qplBHz1TX8KjT83RL2vYums/2/
 ElZxfcjS2MJTkiFdBRAUyQrIr2h4Qoal7FRT5S6nhD/flQXrXaX0CywEX+iTIr650yRJ
 QTss7alL3toptJUXd58RXXeYbE2GlqyfqUYfAN33SfHz6o0jXhoraSJjbUYI9b+3SxFd
 /+KQ==
X-Gm-Message-State: AOAM5306n3i/BK9DfoCCTWXpXSk65rhFGJCXMGzUZwgKPNzJxsV49nmd
 dftjAVGaS3p5uMJMrGz0CBdoQg==
X-Google-Smtp-Source: ABdhPJyMtbbr4YZr5XgYcavaaABocIWgVVWO+6bIVkLH86w/gWfWScj44NFGJ8WhcZD+YmTAw14Znw==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr3495849wrv.58.1591258354483; 
 Thu, 04 Jun 2020 01:12:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id f11sm6873305wrj.2.2020.06.04.01.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 01:12:33 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH 02/18] dma-buf: minor doc touch-ups
Date: Thu,  4 Jun 2020 10:12:08 +0200
Message-Id: <20200604081224.863494-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
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
Cc: linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Just some tiny edits:
- fix link to struct dma_fence
- give slightly more meaningful title - the polling here is about
  implicit fences, explicit fences (in sync_file or drm_syncobj) also
  have their own polling

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/dma-buf/dma-buf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 01ce125f8e8d..e018ef80451e 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -161,11 +161,11 @@ static loff_t dma_buf_llseek(struct file *file, loff_t offset, int whence)
 }
 
 /**
- * DOC: fence polling
+ * DOC: implicit fence polling
  *
  * To support cross-device and cross-driver synchronization of buffer access
- * implicit fences (represented internally in the kernel with &struct fence) can
- * be attached to a &dma_buf. The glue for that and a few related things are
+ * implicit fences (represented internally in the kernel with &struct dma_fence)
+ * can be attached to a &dma_buf. The glue for that and a few related things are
  * provided in the &dma_resv structure.
  *
  * Userspace can query the state of these implicitly tracked fences using poll()
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
