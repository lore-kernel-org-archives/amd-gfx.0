Return-Path: <SRS0=+Fjx=BT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1443DC433E1
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Aug 2020 23:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8F1206A1
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Aug 2020 23:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0wkBOA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8F1206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C22B6E33C;
	Sun,  9 Aug 2020 23:59:04 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FF6E6E171;
 Sun,  9 Aug 2020 06:17:54 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id m22so6211699eje.10;
 Sat, 08 Aug 2020 23:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=8/WAyXxEK6f4eGf236GZbQc5j4me7n0Ad/X2a4kTwOE=;
 b=g0wkBOA3EmdhKYruxbUmwfZmyVVTTidomJP8brzeZl79rzKBdFEI8mraRU6x8pZqlf
 OMasWBFRtzBR+dXkmerWTSMGVErG+6gCap7t9JAqwsy7SZvwAyvDHYOh29Fo8hXC+C6N
 VkU+xRYgfagEmoUY8iuHEKYtB+GOmRNYTGb8sUJoktf4T6P530ou9X63PDraRWYODKHT
 FAt5M4KU4em8Ppf1hcOU4by0PYNgM66MkWOx+ZJSjqqgBHV6o648IG8e3c02PmV+OGm1
 YfwJ62JXegpiBF0rA1UZppSgk9lC+O1TqsAqx+1YSCbL+HyvK7xTt2+1tBDOnE/z94p6
 uR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=8/WAyXxEK6f4eGf236GZbQc5j4me7n0Ad/X2a4kTwOE=;
 b=OPsIbN56xtFIqZEmzo47iHyGLlGAlbcdG2Oh4z6/z8SuvnzXg+Yuph4V/N7gqFqRzd
 Ce6yb8gE0dZti17xmrcoC9IaZ53efroQfzqvBUW7NgbQTsyWGD7xHHh06cRP2Ggkr9x8
 MTUX5vvE0hzUFTD49rO1etcFJ6KZh7wrTj05GNo7Z42tE61veaXKbLfNxSPBNjxS9sLM
 A4lTG3nbki7nXlbG52jcAAj6Ekx2eFEsEoYLT8QBveQu6VyBJWSaYTZys+inNTLg7ymM
 dCVc1+IL4/ZWyruXaLjPrvsn0I3Cj7goCIcotXRkO7I61RYm5kSn+ZG6/zTD2P/tHnZw
 R39A==
X-Gm-Message-State: AOAM530RQzsHy9M0j3/QQWIB9Rj1dDbapWdjW/GAVtH7YxLNdk2e7yIF
 nozC+l1v4sWYcLxB3EZ87KQ=
X-Google-Smtp-Source: ABdhPJzAWTtG0O3pCQAx7xu92rq1VP07wg1HoGT+dX5bPPDs3LBi5kspOwUUzgtQT2hF3gwlm3mvyA==
X-Received: by 2002:a17:906:24d0:: with SMTP id
 f16mr15910842ejb.325.1596953873009; 
 Sat, 08 Aug 2020 23:17:53 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d48:c300:9164:4bc4:8f8b:2b7d])
 by smtp.gmail.com with ESMTPSA id j1sm5175454edq.58.2020.08.08.23.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2020 23:17:52 -0700 (PDT)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH] dma-buf.rst: repair length of title underline
Date: Sun,  9 Aug 2020 08:17:39 +0200
Message-Id: <20200809061739.16803-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Sun, 09 Aug 2020 23:59:03 +0000
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
Cc: linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With commit 72b6ede73623 ("dma-buf.rst: Document why indefinite fences are
a bad idea"), document generation warns:

  Documentation/driver-api/dma-buf.rst:182: \
  WARNING: Title underline too short.

Repair length of title underline to remove warning.

Fixes: 72b6ede73623 ("dma-buf.rst: Document why indefinite fences are a bad idea")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Daniel, please pick this minor non-urgent fix to your new documentation.

 Documentation/driver-api/dma-buf.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
index 100bfd227265..13ea0cc0a3fa 100644
--- a/Documentation/driver-api/dma-buf.rst
+++ b/Documentation/driver-api/dma-buf.rst
@@ -179,7 +179,7 @@ DMA Fence uABI/Sync File
    :internal:
 
 Indefinite DMA Fences
-~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~
 
 At various times &dma_fence with an indefinite time until dma_fence_wait()
 finishes have been proposed. Examples include:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
