Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A2CC352A4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 15:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F7D20661
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 15:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vGSIZkYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F7D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC52F6EC79;
	Mon, 10 Feb 2020 15:09:15 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97B866EC76;
 Mon, 10 Feb 2020 15:09:13 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id c9so8195426wrw.8;
 Mon, 10 Feb 2020 07:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=r5mVuBCwfz8SoQwbmOmXpFGzG7QyWnOLUt2gZbIzyD0=;
 b=vGSIZkYnpK9ZCPJXgm3dqgCQtgjIK7WqGfI4gwTVUTBvZAZMLsV7firg3K5+gy2Fbz
 pviUWwQ1JOsGRi6WXVeEkmYPHxKpZrYEc/R05HOUyK0H4j7MQcP/j6gPiKpoT31Um3dd
 TLZYVT3hAf+ITsOLJSYR0gi2V9Pn7/sBJJHaMsvB5+wlGpURSy+3hIag3MOAqQ8pAbkh
 9m5NifjPfDh5pOJfeqSv07zBgCnoRjeFza9v8H69mHYCphvfgVHthKXAR7VqNTjnL3V5
 Ra8oeAypF+uDq1ZW/wKTtBEly7Dmdm67LsX5gC/d75W/Ke0GpzewPHeY0sxu5TZVVgQC
 uwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=r5mVuBCwfz8SoQwbmOmXpFGzG7QyWnOLUt2gZbIzyD0=;
 b=AXTEVox5yk3nCX/3OgHW3wJW0Mjjj3oxe9ZGylJNqK7bx24oyKHcCTbgn6PoSxW2+X
 yQU7Cgr2vUGgupIejsCbi29dWo2spA3MDBy9dVWxYJ8U6MfIwl4G6GEuS8mgqcfew91k
 pRkfkFVZeHEujuCf+4N0ZbAEvxFQskk/flG1KwILQXWgL5D7qPZ1HZBxUiUAaiH/XYd4
 mGuswMMM9JM5/36XD8zQp/cPFhGI//BhEAqi0Nl+ofMuvZ5O74Hnj+nQCn5qA/mf8dmV
 oQbGT06X7COtsl7qnQtBrv+QZkd0C2xWB5E54fpu48Tk6G25L5wykz3RvhaHbZEJ9F14
 qCxQ==
X-Gm-Message-State: APjAAAUrwTqD0Op5UzeghqWgFuaiYep3YyyJpiFPcK4XO7ArQfLEAnc2
 8UVUoo2xBdJrkD3RYLy/8LM=
X-Google-Smtp-Source: APXvYqxgGQcQ9DAbvKl8Qs1Ozthv35MRKlddJ/Sna94eecUFJohNqmOvEQL9Y/ZCRHTZOAohfxhHyQ==
X-Received: by 2002:adf:f886:: with SMTP id u6mr2430722wrp.409.1581347352336; 
 Mon, 10 Feb 2020 07:09:12 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:7d3b:a71c:475c:1e99])
 by smtp.gmail.com with ESMTPSA id q10sm1021996wme.16.2020.02.10.07.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2020 07:09:11 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Cleanup TTMs delayed delete handling
Date: Mon, 10 Feb 2020 16:09:01 +0100
Message-Id: <20200210150907.20616-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This series of patches cleans up TTMs delayed delete handling.

The core of the new handling is that we new only have a single reference counter instead of two and use kref_get_unless_zero() to grab BOs from the LRU during eviction.

This reduces the overhead of LRU moves and allows us to properly individualize the BOs reservation object during deletion to allow adding BOs for clearing memory, unmapping page tables etc..

Please review and comment,
Christian.


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
