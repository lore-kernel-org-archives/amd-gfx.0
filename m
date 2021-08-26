Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C89C4320E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 13:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8CF560F44
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 13:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E8CF560F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A34C6E85C;
	Thu, 26 Aug 2021 13:49:37 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10AF26E5A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 09:53:48 +0000 (UTC)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A2A353F043
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 09:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1629971626;
 bh=2n09rGyOQB/wpI+orO8w3BF4LTIEVVa3v8VqgqYfvy4=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=Wc2ajDuE9KO2Hnb6PgW20AxSkGmYNNG4zrQzuaYPJW/88uC5NpaPPWtvZ4w7tpvzc
 eubiMQL3Agim5kvF2U4TJ7odJhU2OlJ5Ij6nA+ICC3C4CmbhKkiKSE7pFiNXExC234
 wmEcUVqlRHRR1via/ePz9QlbcyXkshYNOn9ckwpSZ63NANW2IqUtB/nufeAfeAvV3S
 r7e1AnWAPCHJb1pBg8Xo6KM3Z/Kf+Lk2KHad3YEFNCzY+3VFTfk0v2Z+0PUiBMGcaW
 hwC/g76BxbDhuWVBjK9l2Wuqi4/kDGklWS7pGA539lXHAzuH0gsh25sPhTmjpcoHtx
 1VobFhQxU3gCQ==
Received: by mail-pl1-f197.google.com with SMTP id
 p21-20020a1709028a95b029012c31764588so830659plo.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 02:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2n09rGyOQB/wpI+orO8w3BF4LTIEVVa3v8VqgqYfvy4=;
 b=MtCPOnY6S4J5IXAMmrzJQ3aeYAnA02VjrQAprbit+hgZdz6EoHwGnkF96Wo4NcYEYx
 aWAJeCof2sU6QaKcEhtkT+FGWS77+CXjVxqNby+j6QCK8fYd/S0gDjZRf+bIqVY/fqzG
 QPtP9Qnrqz9tB/6mAWMoxbTcSBxi415uVQPb871mf6v9qOnyU9Y22mJKCdlvlFoiHtw+
 BPN0cdm9x93dCsgUq/ivLInatV4uBGy7ZssORo5mBpIqp006136l1UvN1Buqp2q5jZvS
 vDyBJKjWnYCvojCl+t/94jb+Tm0zl7bK6snxiuGG3lXYTOPoA20yZtAfN1sGxHUVNgSJ
 s+eQ==
X-Gm-Message-State: AOAM530kYT7tztM/8Bc1BatSgOIC/c59wVwsorFjgihErd0cPslTdWmZ
 coxe2D4DePBzu0ADB4HcKSaHQfEuYiSkY4olf34/2TISbb+nL8Ol1XNdp1JDQoQtjaakhlFlTn6
 4rgzPWkwYstCFX+BLVWmB3ziQFgtNYAAWdovMt7ONj1E=
X-Received: by 2002:a17:90a:c89:: with SMTP id
 v9mr3450814pja.175.1629971625030; 
 Thu, 26 Aug 2021 02:53:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJJbgcC1O5Fl+EPxBBBtNkYsoG/gp66j0Zo2CPQYAWKV2xi3+K+J/tGGOGfCYofykyWbs1Dg==
X-Received: by 2002:a17:90a:c89:: with SMTP id
 v9mr3450778pja.175.1629971624619; 
 Thu, 26 Aug 2021 02:53:44 -0700 (PDT)
Received: from canonical.com (61-220-137-34.HINET-IP.hinet.net.
 [61.220.137.34])
 by smtp.gmail.com with ESMTPSA id f5sm2406577pjo.23.2021.08.26.02.53.44
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Aug 2021 02:53:44 -0700 (PDT)
From: Koba Ko <koba.ko@canonical.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH V3 0/1] drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform
Date: Thu, 26 Aug 2021 17:53:42 +0800
Message-Id: <20210826095343.426397-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Aug 2021 13:49:36 +0000
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

AMD polaris GPUs have an issue about audio noise on RKL platform,
they provide a commit to fix but for SMU7-based GPU still
need another module parameter,

modprobe amdgpu ppfeaturemask=0xfff7bffb

to avoid the module parameter, switch PCI_DPM by determining
intel platform in amd drm driver is a better way.

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

