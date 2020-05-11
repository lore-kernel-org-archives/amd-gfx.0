Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54283C54E8D
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 17:17:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ADB1206D7
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 17:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXESWEdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADB1206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE3C089DEC;
	Mon, 11 May 2020 17:17:27 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE10489DD5;
 Mon, 11 May 2020 17:17:26 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id e16so11973579wra.7;
 Mon, 11 May 2020 10:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xleAvHyIdERIHs0V7p6NTnOWDbFvP5htSmxpmd/zQGg=;
 b=qXESWEdC2zYZPOh28XpoLtksYhLg9YBUwbg9awlun35eZOVgpb+WtBj6L5V4hZwyxI
 ja912MFH3aAqx47dkgCxGHTGOO2d4nSDXfS0UAgwMZHU0kiL9elawYxBXkVlVciPYol7
 PfjyzlRYuVpdAjHKI6ea/pktf2XxD6NtNp/OWFzYjJhmNmUT5QGBZNpiLj8653NdeyQ/
 LOyj6nfW8yrXd0cwUWnzqzTIkw/yezmL8WxD953DaVFx7Ebyvu2C/LRnmNcKceODvhXF
 QrhtQea2EzTw95Du7bliRtAXMe3V/9og9I06kmsODLREyrZvsyIgqgW2icqvj4TtXfEa
 7nOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xleAvHyIdERIHs0V7p6NTnOWDbFvP5htSmxpmd/zQGg=;
 b=pzICBxYuQgXpeJXs7NWMEGhL6T7LoLYPksY54KlVxSFouCzC21DSPB4KWGeLd5OHge
 M65VmKnqtCBJ/Jrdf8CPKsOfEXrawzX50zVW/9qqRzHv2BjxojUfrZMGxVymdGkyrSOT
 yZIj4ctrAEr3tkT7gOnNaVg6gZZkMyDxenV7RFVeYu0tbblMAS9LumCIrf8vrDSQY/mF
 KwCGxzGOzZMFcn9Xxr6A3ThG24AhvjNHL5b2F2HU5bWuQq3CdyZW3OTI1FHx0tU98Xc1
 hcdx5fuWuQlxiSENzm1IYr+ze5QqdRJi4p3HO5HIDY0t/XuUlwYZJa8HNjpay3UHfhfn
 U7vQ==
X-Gm-Message-State: AGi0PuYoQYTuda0YHpPlBkJK2svbgyVPLZF+N4y9qXTqZNSiYgJcBZbX
 2trfidQpC3h0fNfDQ1XWKGsaQARe
X-Google-Smtp-Source: APiQypLftZHLilYucv+0PvNsw7u2BMtzEIyLEYtmK2zmY4jcOHNMz96XAdSqeNrDU+eOouNp+IMhbQ==
X-Received: by 2002:adf:a4c5:: with SMTP id h5mr19767720wrb.408.1589217445306; 
 Mon, 11 May 2020 10:17:25 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:d8ef:6c45:1f3c:c5dd])
 by smtp.gmail.com with ESMTPSA id x1sm9843232wrt.86.2020.05.11.10.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 10:17:24 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
Subject: [RFC] Remove AGP support from Radeon/Nouveau/TTM
Date: Mon, 11 May 2020 19:17:19 +0200
Message-Id: <20200511171722.96576-1-christian.koenig@amd.com>
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

Hi guys,

Well let's face it AGP is a total headache to maintain and dead for at least 10+ years.

We have a lot of x86 specific stuff in the architecture independent graphics memory management to get the caching right, abusing the DMA API on multiple occasions, need to distinct between AGP and driver specific page tables etc etc...

So the idea here is to just go ahead and remove the support from Radeon and Nouveau and then drop the necessary code from TTM.

For Radeon this means that we just switch over to the driver specific page tables and everything should more or less continue to work.

For Nouveau I'm not 100% sure, but from the code it of hand looks like we can do it similar to Radeon.

Please comment what you think about this.

Regards,
Christian.


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
