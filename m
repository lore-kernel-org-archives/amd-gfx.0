Return-Path: <SRS0=q6mt=NV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC10C432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 07:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C4860F8F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 07:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 08C4860F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2AD889BA1;
	Mon, 30 Aug 2021 07:17:52 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A2DA89C84
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Aug 2021 02:02:06 +0000 (UTC)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7A8D43F046
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Aug 2021 02:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1630288924;
 bh=nlBTRUxEXbUOBqJd5SosHVt9AVv9qfD/t1JUhw1deas=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=gLraJAoA9DoSq+UNXGZqYFBf5SOSE1/uh1ChB+1TO3QZnwnk6dC+97bv3ynTW8emj
 J8UP+g5cI5ye1eA2gAdfvkOgLLBc1f99FvXJR/bq7o69Lzfmv+bPVHZjZxIP8lg47I
 aDOIP/DICBDkbhnyk2jVDbfm2321pcmxBKgMjY5kV7vaRbiXE0AA9xXF9KIjbdyp+t
 zMIUCBOB+0mguvModmQvdulDzhNNTlmQDH77OVfWXdjPhCMBdvX4rszxPRhfwGRjJX
 0YJOBuUAAAL6Ez0xVV3uzjN491uni8dubFaF0A4B09a4T7/jqh+acGx2GzO+qGqEH1
 pZBjr/ODGBoQA==
Received: by mail-pg1-f198.google.com with SMTP id
 v33-20020a634821000000b002530e4cca7bso311113pga.10
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Aug 2021 19:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nlBTRUxEXbUOBqJd5SosHVt9AVv9qfD/t1JUhw1deas=;
 b=PXN0+1XDfjqpfdUP15GPO5jSwjL//65AVnGxKzQ9p5y7cTXHsvQM/p7IMpshpXIkvb
 Ong0L7Sa34ULOvq0GI5GjVZCHlE1iyAy4B4xdxSjo86UytgkxA+DSwM6TCveWcHCyNSn
 NwFRW8fwUm1k0F9WVufvdCMML9LGIAt0rgQkd0rb85xEDklW0VTQ7p0Co6QCP+h9TGak
 7oCIWREXQvxvEwgzHLqb5j9nBakmfTFTMzOn0JSjsRrGhgQfjWY8DZRNTXI2mS0SyacQ
 j1/6gbmtJXOe9a2T74+idPVSSvujgzYgtQ3LV3LZ4eB2g3Qf8yrEmQhjwVLHYDit7xZC
 kLkA==
X-Gm-Message-State: AOAM530z7UnZYNkPfYfHoqV1NbEshhMjAqLKe4UMDx0HP8pZIsH1o2l1
 p7qRZc1StScAC2/1UUzdg/K5sGLRa1RyPxH8JTDdRrxvHiXfY/TI+JQ/xrTJbKMogpeLsjcABnh
 7oZUIp722InvEv3AKsXj+gSawCdnAVIF0ivqpJOByc58=
X-Received: by 2002:a17:90a:74c6:: with SMTP id
 p6mr14676957pjl.20.1630288922797; 
 Sun, 29 Aug 2021 19:02:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9P0sTiA1JkJ8NCAOoOXl85H4CEHbKoyquGk+v195VJ1JI5HtlyDR1YHW2Nd1Uqb/sduEY9A==
X-Received: by 2002:a17:90a:74c6:: with SMTP id
 p6mr14676925pjl.20.1630288922501; 
 Sun, 29 Aug 2021 19:02:02 -0700 (PDT)
Received: from canonical.com (61-220-137-34.HINET-IP.hinet.net.
 [61.220.137.34])
 by smtp.gmail.com with ESMTPSA id i8sm13231140pfo.117.2021.08.29.19.02.01
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Aug 2021 19:02:02 -0700 (PDT)
From: Koba Ko <koba.ko@canonical.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH V4 0/1] drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform
Date: Mon, 30 Aug 2021 10:01:59 +0800
Message-Id: <20210830020200.611574-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 30 Aug 2021 07:17:52 +0000
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

Due to high latency in PCIE clock switching on RKL platforms,
switching the PCIE clock dynamically at runtime can lead to HDMI/DP
audio problems. On newer asics this is handled in the SMU firmware.
For SMU7-based asics, disable PCIE clock switching to avoid the issue.

AMD provide a parameter to disable PICE_DPM.

modprobe amdgpu ppfeaturemask=0xfff7bffb

It's better to contorl PCIE_DPM in amd gpu driver,
switch PCI_DPM by determining intel RKL platform for SMU7-based asics.

V4: Modify the patch comments.
V3:
1. Use IS_ENABLED()
2. include conditionally for X86_64
V2: Determine RKL by using intel core type&model.

Koba Ko (1):
  drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform

 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--
2.25.1

