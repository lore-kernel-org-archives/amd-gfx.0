Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60444C34056
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 19:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28498206F4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 19:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7ZJfkAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28498206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3C896EC88;
	Wed, 19 Feb 2020 19:19:55 +0000 (UTC)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C608D6EC92
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 19:19:54 +0000 (UTC)
Received: by mail-io1-xd2f.google.com with SMTP id m25so1818959ioo.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 11:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GroLeKVp/28zd9+d6KOFzjn6jDZF238c89724oJ3wdA=;
 b=B7ZJfkAJ2C1+z+ZKjxVqldZiQcZOMoAEes6pHBquObWVsSDiZMWwcyZbZb04w6fS1t
 0/mP5k/lUxGz7sWXAIdDxegViiPXiPzTsx98EJ/h7oNdPbARbrTUSv+IgklroaWcYBl8
 2Ivos03+CCuWgat0OnX8f6Rf9PQIgW7wuEIyzsEPM3KY63h57C1Rfq6OIwgz2Kpl7HBY
 Z2VFhNu+thNC8zUgHsYX91J7CLWk581/ITEHS+7QXRAIM8lY63FxdbStkTJxIE/GIU7U
 VXviYMPUzqWadl0Zj0BUIvgBGGgaYIeaE79v6ew9q2iSM5ZW4LEOm9MMVK+l6X/trcrN
 to3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GroLeKVp/28zd9+d6KOFzjn6jDZF238c89724oJ3wdA=;
 b=PSEo5zPN6QTNSPeQcyTodhtxkVPojwTDiM2kJ/zagvDTMhDKcvFCyEGhJ+ANN6jIqN
 pAog1wrgreZvd/EQGJbvD9A97F9Obb6kfhOTpHvU2niFVnbYcWigLwIT5EBp5XHcpHgQ
 QTaDdgknoy4uoSYFbKUt8caysNAO9KCVVd8XajmHobo2VVxN22MyR0BWCU1UMSZA+REH
 Mpx3eklSbIk+KyPwhYc3hIvhvAWXhWCub7yQMGDzdtCXI1ir5lU0LYiHtk7oF/quK0mc
 0+puUu2SrR6ii81GLsdxJdCvFquC/otHlWPu9IfgYsNIzWt1NUJ1zOBD4zGdnupUV1K7
 Pn1g==
X-Gm-Message-State: APjAAAV8VOf/329cTlz2Z+Lf6id0eDqxr2YV/Cw7/shQ3RzuXbDMLOPs
 yzF30icLuU4ORRv9iT+OwJLgQrPw1Fo=
X-Google-Smtp-Source: APXvYqzmBnQtSSmW3RAFsXXCHddtkPeJq1KbIj1r6eC7DjcmsL8KnrwOSDkCsnTtn2MOTRTO8WErlw==
X-Received: by 2002:a6b:7b0d:: with SMTP id l13mr20198741iop.147.1582139993961; 
 Wed, 19 Feb 2020 11:19:53 -0800 (PST)
Received: from mcoffin-dev-tower.ec2.internal
 ([2602:ae:10d1:b00:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id h19sm245706ild.76.2020.02.19.11.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 11:19:53 -0800 (PST)
From: Matt Coffin <mcoffin13@gmail.com>
To: alexdeucher@gmail.com
Subject: [PATCH 0/2] Implement SMU message register protection
Date: Wed, 19 Feb 2020 12:19:39 -0700
Message-Id: <20200219191941.67724-1-mcoffin13@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <5d301d58-49c7-6c3c-0652-6e051514d1ff@amd.com>
References: <5d301d58-49c7-6c3c-0652-6e051514d1ff@amd.com>
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
Cc: Matt Coffin <mcoffin13@gmail.com>, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Alex,

I took a crack at the implementation I was talking about here, where we
can protect the read argument register reads as well. I only
transitioned the actual implementation for hardware that I have funds
for/access to, and left an '_unsafe' path for the other implementations
since I cannot test.

What do you think of this implementation?

Matt Coffin (2):
  drm/amdgpu/powerplay: Refactor SMU message handling for safety
  drm/amdgpu/smu: Add message sending lock

 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  47 +++----
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  18 +--
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |   3 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |   7 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |   3 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  76 ++++++-----
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  22 ++--
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  15 ++-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 118 +++++++++---------
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     |  65 ++++++----
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |  42 +++----
 11 files changed, 216 insertions(+), 200 deletions(-)

-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
