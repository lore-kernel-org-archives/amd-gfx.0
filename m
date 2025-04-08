Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C84FC3601E
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 02:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8A210E1FF;
	Tue,  8 Apr 2025 02:11:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Oxx+P8Mk";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E0C10E1FF
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 02:11:31 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7c56321b22cso473957285a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 19:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744078288; x=1744683088; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+HByfcEIrCp5NzM1IVSFhjNWA4BrpsRxJSpITxCQrbE=;
 b=Oxx+P8MkTMiVN/uRP0z50XBUHefYsa6tJy5f5x/L7BNamitY2oyipD4MN33AopQ6jE
 6TfCxblAWKJnaWpya/6LeSkZ+oG0wrIneqALVDJvT7vhS5hV+UV47gxT/r+JxN4Sz8nJ
 nCoElM8o2GJhmVjuTr3ML3IQNYZG8ghz0FjVb8UA3tUJ6u+sFwwzNL5qHgf0CIMzbvm/
 QRnHSjzgvIn/MfQ9bl6bMP6BgGLmWl5n+QQy+TbI/Szsi3qdNoVbMJK/4PyWjPB0IxiM
 reLMinV/ZWP+InF9aAHvi/si/sDGU1ecOJPKrH+0FQ6+W/qKjNM23jUzGp84hEg6dmBO
 SSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744078288; x=1744683088;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+HByfcEIrCp5NzM1IVSFhjNWA4BrpsRxJSpITxCQrbE=;
 b=Cj3M1YTwtUNd6lM3aVuUwIzLs4B3D2jiY7AXpaoffN27d8sAIVBvhHiaeK0xtDEmuf
 MgzxvNOvKwOaoF/LzZ8zGqjCwXX5kLxQgNPYZQN3Dvggf1tcuuqAGpd41vO0kqAnbp88
 7bvvhX1JftN2oRoIBKhiHaHlF2dKyW9k0KkkbmdpOYp2b1fIW0kVcXNkMyEKuOiU8WnK
 vCD/OgqI93Nn5vjHsNcZKt2Q2r0cQc49t3j98/F07TD/IfWfmNq0tspPykQMDPQH3yei
 PMykaQ73+IhyRZlP4hbk8cHmhlsu6Plsi2xwM5rNmh89RktWTgtXW+5ZTK/rI/WE9Fof
 RSGw==
X-Gm-Message-State: AOJu0Yx3YgfLx01HFW+gLyzZGPZ9EmTcuL2T1qlMesVCeTtsPhP/ozNZ
 r7zOrPtA0uXT5QX3EcgTskh3Yx6omi74mSTdvA4AHGfLPAPTMp1+xPt8fA==
X-Gm-Gg: ASbGncsK2ZZZx6UuXAor1ey9qRAV5OVIEjiIhBSkEaLZTS1IbOSvdaV1zFUfiEdTIff
 2CyN7/mbhUqX4d2C+h8xSFYPC8R2v3NUDiFbXrq/0bYvENsTQuxNqczRdTmFMDgcI05Ia+61ywG
 yll0hf8dOx6UEqbEVBDZTVho6NA5MpD9sfeAi+esHrIxS4gSIsK/G1lbkZLOF1v7NlLYAjbG+M6
 hlFshiih7ImqcpPGfQYhbyjA56NBHizUCmPRcuiCFfb9l8JrPjc4/ahwgaMQOGUqKBnyX/ppfS2
 1VDFA8t2JBn3mUoSq6yeyVngGf3emx++ceRagIQc94T3Ux2/BWbS1hMdoDVwVVaKCsJY
X-Google-Smtp-Source: AGHT+IFCrcheuDDWmUrSoCeztaXeHuyyqHlwtmZdzsH62Fnh7Sekpuv9LIOLnVlVsKWajQNRCOGU/g==
X-Received: by 2002:a05:620a:3182:b0:7c5:94ac:344a with SMTP id
 af79cd13be357-7c7940a30f1mr256983185a.15.1744078287950; 
 Mon, 07 Apr 2025 19:11:27 -0700 (PDT)
Received: from localhost.localdomain ([38.121.253.36])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c76ea5992csm687693985a.84.2025.04.07.19.11.26
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 19:11:27 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/6] drm/amdgpu and drm/radeon: a slew of small fixes
Date: Mon,  7 Apr 2025 22:10:54 -0400
Message-ID: <20250408021100.5439-1-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
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

This series goes from fixing typos in amdgpu and radeon to renaming functions
in DCE11.0 so it follows the convention of using a DCE/DCN version prefix for
naming functions.

Alexandre Demers (6):
  drm/amdgpu: rename function to follow naming convention in dce110
  drm/amdgpu: add missing parameter name in dce110_clk_src_construct()
    declaration
  drm/amdgpu: fix typo in atombios.h
  drm/radeon: fix typo in atombios.h
  drm/amdgpu: fix duplicated value setting in
    dce100_resource_construct()
  drm/amdgpu: fix typo in bios_parser.c

 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c         | 4 ++--
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h     | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 8 ++++----
 .../drm/amd/display/dc/resource/dce100/dce100_resource.c  | 2 +-
 drivers/gpu/drm/amd/include/atombios.h                    | 2 +-
 drivers/gpu/drm/radeon/atombios.h                         | 5 ++---
 6 files changed, 11 insertions(+), 12 deletions(-)

-- 
2.49.0

