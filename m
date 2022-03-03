Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D936C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 08:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB84D10EF11;
	Thu,  3 Mar 2022 08:23:12 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5511610EF11
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 08:23:12 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id kt27so9035763ejb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Mar 2022 00:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8c1oVlZnmU0DaQ0nFlB2IQDk8BqQVIBU7FyT5pLcN9s=;
 b=JihWGgHYfutCp0eqMDVLOi/BhfGJD1XUCIf3gr0FA72mSjDPoNlLAMl6nn+DBbjJ6M
 4ntIVjM0qKuIMSbiP2gf01LJ8bLePtzzLKwbLaRUksbe7alt2+Uiv8UOcBukGAGX9Wjj
 GOaDf7E74/DUKGQ7SdaSegv0w5BlxZRSsTdatzpijZRPPNs1ByL2Q6f7IIjxexWnVspa
 JVKFlCJWwT9aniQMXXoeJcLqdjwEFU718ExL6wroJVNuK65yJPmVgQwZw5Qdppc2BDxM
 6PAhkjhMUHf/Sn/FPP7bvOHfEPATvjMtBxVEeDakqOINHa+LVKoMnnR2H90JTDHZXhtm
 QrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8c1oVlZnmU0DaQ0nFlB2IQDk8BqQVIBU7FyT5pLcN9s=;
 b=hEmpy1Hy+KE3RAMjHMnPbnW2Jtyf2yd5k5Fj/mj9I/mm3ttaTaO0b1E4T7WgNdnEXv
 +DvUKH8KuXoG6U54BWfLG2PF2oX8VyXyy8fsJ8GSTV9zdNW8zD3FpZ+Ctg+vAnGOwot9
 k/LAmDg4RgLJyFkizSQBk/WCFx0oCh/PLiRqRDrHUuuSBx5241ML5+4xszqQxF1NQ5xT
 c311j+7HEo/wh1dc/mkwwV9Sfpsfu25jW1ABh3lT8ldH32Uu6jvX6N+fpZcfZJYJEL8m
 6P7bPJy5n/tYgC8K4gItBQgvbrLvwkR5VwaPVxSJzT03dojtRCZCY2AS1TVAAROfHLuT
 Mtxw==
X-Gm-Message-State: AOAM5326qI70bd8MRGi5NdNrpxOpiiXifaJIs6OpH23ypHR4Jqfs10GF
 3rDaOm1x8J7CoZbUwnq1QZNzb+KvqgM=
X-Google-Smtp-Source: ABdhPJwt/qvsKRl4UQHezXP9Yt/mh2AVI4MwDmkjp2qRjhLlDKQSzImVjndpk6Tw2qCUciIW37N11A==
X-Received: by 2002:a17:906:c14e:b0:6da:970b:cc33 with SMTP id
 dp14-20020a170906c14e00b006da970bcc33mr422374ejc.307.1646295790819; 
 Thu, 03 Mar 2022 00:23:10 -0800 (PST)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a056402060400b00415a1f9a4dasm548308edv.91.2022.03.03.00.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 00:23:10 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Marek.Olsak@amd.com
Subject: Gang submit
Date: Thu,  3 Mar 2022 09:22:58 +0100
Message-Id: <20220303082308.38217-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi guys,

this patch set implements the the requirement for so called gang submissions in the CS interface.

A gang submission guarantees that multiple IBs can run on different engines at the same time.

This is implemented by keeping a global per-device gang around represented by a dma_fence which signals as soon as all jobs in a gang are pushed to the hardware.

The effect is that as long as members of a gang are waiting to be submitted no other gang can start pushing jobs to the hardware and so deadlocks are effectively prevented.

The whole set is based on top of my dma_resv_usage work and a few patches merged over from amd-staging-drm-next, so it won't easily apply anywhere.

Please review and comment,
Christian.


