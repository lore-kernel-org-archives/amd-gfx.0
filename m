Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB453C35FF3
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 10:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043C610E0A3;
	Mon, 17 Mar 2025 10:53:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MV+5ck33";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E5D210E291
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Mar 2025 20:16:04 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-ac30d4ee0f5so52638266b.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Mar 2025 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742069762; x=1742674562; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4F1P85LFGlYZc94oJlgyeA1o/yMUDcoXNAuyMT9DVJc=;
 b=MV+5ck33/XwaY7+pp78tKFZGb/Zs9shZ9lkX1UBsXCMl5ITg3ECFKoyg8fB919nc5/
 b24kLTLQglrioX/3U/IXeclNfC1vC/ryVBvkbaZfNjFePJkxADvjrPufub4LAIytokpe
 uEDURysy7ZyQ6JtypwONxCXPpPchkIPKOy9VLBJ+w0VKITBufG8x4K9eW1v/CJGXp4Q1
 as7jTMsXDMQJsuZVYKETugmPezQguEDmzkirCTPzgEi6xHXBLsMIfazQEt8tJdMeqqOx
 +zrW5h6wEok3ooJDKaDUQRzIQfezFdqp6Uk8Rxv0Pm7cEhmdzjgNU1Woa5FBk74zlf8y
 oHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742069762; x=1742674562;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4F1P85LFGlYZc94oJlgyeA1o/yMUDcoXNAuyMT9DVJc=;
 b=j9Je/BQSWUBdnn11fQnIHRbIPiqTxwzZ/sqAKspeRqDqAGokzKQnzBDI8HwZrElgsv
 Wokx4e2a6qesv3KFm6/VNLRnCYG4OAtarn90+I1TIVTnyZ0LFZ7c0csiftv6TT2cwKoG
 3KVMw4MVKx2+AK1dvubASwyC/Af8y2n7cAn+yx38ujUgQRq0yQoBth9t48XipaRAiHAo
 F4bGfdmSNk6fgmFDt0cmneF82v9SNvZb9XBXZUQJDnwrumKvF9DKK+6vpRVHnhWo7hJ+
 9ln2bJVOlfwak+MI2ToBVgMVic+EyCOAQ+xIdz5ojBIj5/944KE07wPVW1UDFO9q/Ql2
 ykUg==
X-Gm-Message-State: AOJu0YxyDoM6xCUn91UUjcooasZx1ifuR8FTLuNQkkqh7yUO9/srajUI
 C7RthLWbS6RorDIw1pStJrKvLtVB82nLFKJlnRREl1NM6Np1kE1p
X-Gm-Gg: ASbGncuxLKIpeOXZek/ueaZ32R66qbmh4VEeq1SACNzrfcHd/AQP2RLs78RhoDCK62m
 GX3gSUvwd6kX0GSywhrWGUXjKGuHeIdcGW8So+GWHBHXzsDtSb5I4py2gR1aGJoSKlLiqYYjwia
 DXZQDUU2Ki5ZVBzbvXygOUxqKzL2Z9xYc92+HklsBQiA2tRsi+26fSBQgDRcavAyZYuhMjZQU56
 Wbm1hi6gA23MnVuMpBcwzpbnDsOHaeDyLgUYcMYUYZXS4ku8Q9A2RY+O25T+iTH2hOilNWYgVFG
 EfG84rtmIEVFMTIT0C0DA4eoyEaHYrVuMGrEb/GMVQlhUmbiQwg3JYcPpRkqfXriAH0z/etYOjZ
 g+c8qgyw4ANIz2pk=
X-Google-Smtp-Source: AGHT+IHnBzDrDcm6utSjVMSzvsIWec8vNLRoC/ionjOQQnl0sL77kWzBlxFbiKl9W5Jn1B9J4jW3fw==
X-Received: by 2002:a17:907:970e:b0:abb:e5ac:28b2 with SMTP id
 a640c23a62f3a-ac3304e98dcmr310114766b.13.1742069762204; 
 Sat, 15 Mar 2025 13:16:02 -0700 (PDT)
Received: from laptok.lan (89-64-31-121.dynamic.chello.pl. [89.64.31.121])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314aa5a7csm416922766b.179.2025.03.15.13.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 13:16:01 -0700 (PDT)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	kenneth.feng@amd.com,
	KevinYang.Wang@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/2] drm/amdgpu/pm: Add RDNA 4 Zero RPM settings
Date: Sat, 15 Mar 2025 21:15:56 +0100
Message-ID: <20250315201558.339913-1-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Mar 2025 10:53:32 +0000
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

This little patch series adds Zero RPM mode settings support (enable
and stop temperature) for smu 14.0.2. This is based on the existing 
RDNA 3 (smu 13.0.0 and 13.0.7) code.

Based on top of amd-drm-next-6.15-2025-03-14

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

Tomasz Pakuła (2):
  drm/amd/pm: add zero RPM OD setting support for SMU14.0.2
  drm/amd/pm: add zero RPM stop temp OD setting support for SMU 14.0.2

 .../swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h |   3 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 103 +++++++++++++++++-
 2 files changed, 104 insertions(+), 2 deletions(-)


base-commit: eb6cdfb807d038d9b9986b5c87188f28a4071eae
-- 
2.48.1

