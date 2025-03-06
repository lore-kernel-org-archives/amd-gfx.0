Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC68C19F32
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 01:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 281A810E896;
	Thu,  6 Mar 2025 01:50:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EFE4Nrc/";
	dkim-atps=neutral
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F5B110E896
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 01:50:22 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-6e8a8d6c38fso2471906d6.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Mar 2025 17:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741225821; x=1741830621; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dp73GZrlpHcOPatAw1qE15lMTudfukf7Ig7rRt9SxLc=;
 b=EFE4Nrc/YD+9Jy/DC3Yuxm8pIr/tKMuBvTxuRu5AusbZDuysNTK7W1LUU70WlPkEYj
 +6aPjavmPuzIFjH2xnP2NYhZtkt9ybpPy/r+p8lJZK96xojLMUQnGWVPRX2CiZ2BQJZZ
 JAu9cNiS9nCYaujDZynwOTyie4GY60s2vPwM1hxUfTWxP6FlWQUWq5/nZQPek7tmkB8G
 l1oKBDu0Vy478iQiFaD4WcUzcCR0w/7BLFZqrzrNm+zbbCOYk2sQRfxpyTXKQHZjY72+
 DOedqM85I9SZG10mXsV5bf9QFNf2GeuQBV0krOV2k4TTZp2Hmn1f9UblNI5udPpXGuVy
 /XXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741225821; x=1741830621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dp73GZrlpHcOPatAw1qE15lMTudfukf7Ig7rRt9SxLc=;
 b=s6gzSorRs4BFM+pZeZFO5a0KSCSd64UyXdtRw97xjxcdYpTFv/C3kNDBwk1rGtYuPo
 vnhb92T0h6NlE0ePt5PErjd6RBfRR0dvRupyyFLAwnE1Ik7cFDOBoS1iL0snw14hfMz4
 NC2+z5zt/SDJyNoO24hpPSqNzcGQkM2BpHJtSYPnUo6yTQpsflAk0I9jlfFKxSS6xVdo
 0B3Czu7lK5V/qLpR6F7v6b5ZJDhl1ijVXiqL1o6WnKJrCqH5Pes6c4wrVxLxaRINilip
 P+bOSQNoqSWglifGbRFFTD/Kupo8i7twi7/ffY9kOsffiiBi6JAxoGypbBPWxQRz+T/V
 5g6g==
X-Gm-Message-State: AOJu0Yy+l6NWZ7Sp1Ox8wF48+xmFV37oUdCjAxStGmmb+5g3PI9nYAV8
 +Ars1vmfQEO9yOksMP7Jm+DbE8JMlIurvtkoe753rmhQRNc6i5SwVMUJgw==
X-Gm-Gg: ASbGncvuHU1VN8DkqLAmGn0FEW+Xb+JhdPYO19MWuRTDLXqcP1SvJ0j+FuRcgfDa+K6
 Jftzvg3JjzbrlNpGu0x8C9EN4PeaR7egwgwwh4nC3wxPx3B0QgyDsZHuEXtCTLU665Cu83Kt9WW
 6t11ryOFx+iX07QEswyRR8UKZ04VM3p4veqSie1bNuUk0/ApFyma1DXGCeTNKDpmg5H89NE/fGK
 MZDfZ5os2bUSGH5jovCBgvKQO6kRwBE2nqINek/aLrVPkJbsz3eF5Woks1mEvwHS/BLJMRLVW9h
 46WaoCtCx8bMhAJ4nsp5H3yEINp9xMHaS9TPQsOzT1UDAqUJtaNnzC97TGv//5PD2Lk=
X-Google-Smtp-Source: AGHT+IHMzCm9LXyN7h+HISW1UOYLkrmac03cwdOVii3PG7NxXdIEBoensjgmdXopbu/KMOxwjaxiSQ==
X-Received: by 2002:a05:6214:2584:b0:6e8:9224:483e with SMTP id
 6a1803df08f44-6e8e6cc365dmr84834826d6.5.1741225821121; 
 Wed, 05 Mar 2025 17:50:21 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715b65csm1489786d6.76.2025.03.05.17.50.20
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 17:50:20 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 0/4] Uniformize defines between DCE6, DCE8 and DCE10
Date: Wed,  5 Mar 2025 20:49:54 -0500
Message-ID: <20250306014958.785021-1-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
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

Keep a uniform way of where and how variables are defined between
DCE6, DCE8 and DCE10. It is easier to understand the code, their
similarities and their modifications.

Since sid.h is being wired up in dce_v6_0.c, duplicated defines need
to be cleaned up.

Alexandre Demers (5):
  drm/amdgpu: add or move defines for DCE6 in sid.h
  drm/amdgpu: add defines for pin_offsets in DCE8
  drm/amdgpu: add dce_v6_0_soft_reset() to DCE6
  drm/amdgpu: move and fix X_GB_ADDR_CONFIG_GOLDEN values
  drm/amdgpu: fix warning and errors caused by duplicated defines in
    sid.h

 drivers/gpu/drm/amd/amdgpu/cikd.h     |   9 +
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 126 ++++++---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c |  14 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c |  15 +-
 drivers/gpu/drm/amd/amdgpu/si.c       |  68 ++---
 drivers/gpu/drm/amd/amdgpu/si_enums.h |  13 -
 drivers/gpu/drm/amd/amdgpu/sid.h      | 369 ++------------------------
 7 files changed, 178 insertions(+), 436 deletions(-)

-- 
2.48.1

