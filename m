Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614A7D3ABDA
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Dec 2025 02:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D380B10EB2A;
	Sat,  6 Dec 2025 02:31:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BBSEOtz4";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4464410EB2A
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Dec 2025 02:31:11 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-477b5e0323bso21306325e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Dec 2025 18:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764988270; x=1765593070; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zbAhDek9jZOzhJer5bjTM+K+8yIUNQlmHNTAfrNqXsA=;
 b=BBSEOtz4gyfSB7l9bl88390CqJoMSsINkPXkvsrsV7CE9OJUE2ExkxNYJTdDVLqsg1
 PSyuSkBuEV5Zr5fsCqTCYXZRWOewrq4a9FLxioBmvKB56pdLouTwQBSfivs2IFH7V+Er
 1t2joo6YrJ9RDztQYF92VmhW1Wtu+Z81s0Z3DAP66sQP4E/EBm6tnrkp0HjYT4asic8P
 NvAHYpjniFuHXQd62BVlN8G/LPMsl/Ty1oG0/r0Xy9uuqse3GSZsz4Zx9PGM7kgv5oOP
 xrAt2wJ7spD6PRWrcMWmN9Gq39p1pckN+nyxTKPjSqyOPV5eKOyPJakXlqzh3igbIFVb
 myjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764988270; x=1765593070;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zbAhDek9jZOzhJer5bjTM+K+8yIUNQlmHNTAfrNqXsA=;
 b=dCPzecE6NydHXiNlKHRD3vlPQiMB2BV3v1hXQ9wLODuA4YdmRZNzaEVs1DGpufewb+
 7SoZ1oUn/4dOiiSVl370hERk242EeyBdx1LzHyo2KoEnFiAqkoyzx2sGCdChEMxgRs83
 9qExxYuN0jXP566ECEj9pKPqrayNSZbVanXRMqcERskgPTcxQkpcvqERP8djbpxCWrdo
 yvR+r3VZrnuNYGrGMgXFpP0dPyzQg5xAlSxUpyRqcvKKpB1ezg343HqS3C+9Cn/7vxgI
 wlaE010SwdAmdRF++thDlkGlBQI5RHd901iFQ942tVp/73hJDOCzDnCVZZeVGiaFplRu
 ZQWw==
X-Gm-Message-State: AOJu0Yw4Pa97EzLg4GsTJg9ZWPdHx7+9EqNTqdrWcpK7WO84sG6vtR3S
 zdIxf+mNSPeeHz5r+e6KtYeh6fPASPScSYgFu+kajaG92YyU9hvQ4taI9KYZXA==
X-Gm-Gg: ASbGnctT49DJuSMlJ8u1wQItSu29pVU/RFFw+KRiygjJoUcpx/EePTDpZ1MbPcH63A2
 oDC5cvGjsPz7NDU9YPvIHUpIzLHf8XBgSveqQhStwpZ0NuLbi4VwvYq/kUD7KhCz5iACu1180ZF
 BjNTuJ3WCtFZS/EWWb/NTAbQ8ampsEVC145lhCdsjHsVS3COaPOrM2MyjDb0InfDMwZA+43KcHa
 yMlkKfvDOQxGMqZeLHR9QxdHD0cTSwglTReHppMQQJByGsiBOuGYqQhZIT43ZyKjc5Ui4KrY4vA
 2B5xv8wkWmzghhvE49pedAnNLAGCwnjdiUMKkWheXm8hA8fyaF8iDyGTy2A8CmSEdQq9d3KJiTm
 ISCYD08/MZMxDW0JUcZJsQEKTExq3XO+gcUYDRwFFrRAzQ3UHASpKBjhkA0VpQabcIT1miBpCf8
 yz2csZL4as6QNEVGcy9MN1RqrtdmyIQ7FnOS4EDTpU2K6JhWO0LaEvQjeyhsjgbkNQLJrlw3iEq
 /0+1Mt3lfr903xZ3XY=
X-Google-Smtp-Source: AGHT+IEP2KuwBQUNVr2zWKek412emHBihNYm6N3bay7bF7z09k7bOCtiFQg4ilhj/Es9Swv71hgI8g==
X-Received: by 2002:a05:6000:2404:b0:42f:8816:ee6c with SMTP id
 ffacd0b85a97d-42f89ef90c7mr1362156f8f.30.1764988269241; 
 Fri, 05 Dec 2025 18:31:09 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24E095001DEDB2C8B6514266.dsl.pool.telekom.hu.
 [2001:4c4e:24e0:9500:1ded:b2c8:b651:4266])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbff320sm12133689f8f.18.2025.12.05.18.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 18:31:08 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 alexander.deucher@amd.com, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/5] drm/amd/display: DC analog connector fixes
Date: Sat,  6 Dec 2025 03:31:01 +0100
Message-ID: <20251206023106.8875-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
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

Fix a few issues with the initial DC analog connector
implementation that I've noticed since. I highly recommend
to backport this series to kernel versions that include
the DC analog series.

Timur Kristóf (5):
  drm/amd/display: Pass proper DAC encoder ID to VBIOS
  drm/amd/display: Correct color depth for SelectCRTC_Source
  drm/amd/display: Add missing encoder setup to DACnEncoderControl
  drm/amd/display: Setup DAC encoder before using it
  drm/amd/display: Don't repeat DAC load detection

 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  4 +-
 .../drm/amd/display/dc/bios/command_table.c   | 44 +++++++++++++++----
 .../drm/amd/display/dc/bios/command_table.h   |  4 +-
 .../drm/amd/display/dc/dce/dce_link_encoder.c |  2 +
 .../amd/display/dc/dce/dce_stream_encoder.c   | 25 ++++++++++-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 28 +-----------
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  2 +
 .../amd/display/dc/inc/hw/stream_encoder.h    |  4 ++
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |  4 ++
 .../drm/amd/display/dc/link/link_detection.c  |  7 ++-
 .../drm/amd/display/dc/link/link_factory.c    | 10 ++---
 .../dc/resource/dce110/dce110_resource.c      |  2 +
 .../amd/display/include/bios_parser_types.h   |  2 +-
 13 files changed, 87 insertions(+), 51 deletions(-)

-- 
2.52.0

