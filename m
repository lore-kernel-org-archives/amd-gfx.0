Return-Path: <SRS0=ZIXC=7U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B443C433DF
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Jun 2020 04:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129F1206A5
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Jun 2020 04:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4G6ogiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129F1206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 336B26E114;
	Sun,  7 Jun 2020 04:06:15 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A48426E114;
 Sun,  7 Jun 2020 04:06:13 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id e12so10624622eds.2;
 Sat, 06 Jun 2020 21:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/4M9n/jjdZ6jTzSVw7Lm0ovP1fYki6oC+p2XEevFF+8=;
 b=O4G6ogiPxqxqF93BRXpHaKQqOjsNunt+gDqsjpqQ7ZYZUf5JZAJTxamqAOpmImhC0t
 amvtjDlE2lrA+sIxok72lG6r1m/pRyE7x1kP9+LPDgGHgwUJyyY8xlblJvTrWcNbRXgy
 cZx6YO7CaickBeZhpNC/qSE0tOoTmzfilviKfDZVEk6hnh1jp8U9sbENvOOsC9HEXz8Y
 tUNbR9CpSBXDMFW4TQ5Jd7eCVvhLDViCHJEFkLC7iOWyCZx3dzeeICORRfkAfSsE/va+
 Mghz725kEH0tRJc9Zmyn4xkISXS6qxcWX9s1zMxxCTIvHDGMDpAHxRwdrK+zblHwlvAC
 5PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/4M9n/jjdZ6jTzSVw7Lm0ovP1fYki6oC+p2XEevFF+8=;
 b=XhcbanNz3+kRI7vtviX7MVedpHTr2k4ZIz3t3UDS19DJLG9TLNo/NZAiQAXXPAhg0G
 s6qiVxRDcMUlBMEmJD4BEWEvt9hT8QEsXWh73FPgyPMpdvoLPKvmLMf2h52Ihh6H1XBS
 bOwhgO1UgxqekC2l99LgLgJZ9NU6zf2MvFL/HwUr5ohk/7HimdeDEzrDUYNik82kb9X1
 +Dxkb9DvbYfxhfYIvM3hwAdXM5khpZiy5sGWIaByL9SvwOGzY4M6chx5tw/HU3vQLxrJ
 rzK15h9vneb80rIOHsfEhwcOGKA7+Sv2ZqF3P+L3hQAfMAhFJ+qOvdoc4J1/P2m4JOzs
 3txQ==
X-Gm-Message-State: AOAM530Mcqn9MYBB+PB0oqLBByiu1JL0JAI6qGBgvoBDxQYLeDb+LXyk
 Ogw7Sstyy1Q/rbttx3iJxb8/xgES
X-Google-Smtp-Source: ABdhPJzkOthh8GTIJtfj/aSkVe9hiFPkXPFVBbW+sRIXe260iHSKDP9LHEYfOzIk9qv8mcPTZF+j5A==
X-Received: by 2002:a50:a701:: with SMTP id h1mr14707123edc.170.1591502771825; 
 Sat, 06 Jun 2020 21:06:11 -0700 (PDT)
Received: from twisty.localdomain
 (dynamic-2a01-0c23-8430-e100-f914-43b7-6b66-02cf.c23.pool.telefonica.de.
 [2a01:c23:8430:e100:f914:43b7:6b66:2cf])
 by smtp.gmail.com with ESMTPSA id w13sm7797243eju.124.2020.06.06.21.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2020 21:06:10 -0700 (PDT)
From: Mario Kleiner <mario.kleiner.de@gmail.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: Enable fp16 scanout on DCE 8 and DCE 10
Date: Sun,  7 Jun 2020 06:05:56 +0200
Message-Id: <20200607040558.15996-1-mario.kleiner.de@gmail.com>
X-Mailer: git-send-email 2.24.0
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
Cc: alexander.deucher@amd.com, mario.kleiner.de@gmail.com,
 nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So i'm sending these on the off-chance that DCE-8/10 do
support fp16 scanout without hw bugs. Would be nice to
enable this if it is supported, even if the hw can't do
HDR. This is also useful for non-HDR to get effectively
11 bpc precision from the fb to the display outputs for
more precise color reproduction.

thanks,
-mario


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
