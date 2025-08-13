Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D5ACA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 00:02:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 324CE10E4A0;
	Wed, 13 Aug 2025 00:02:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MEhWPGXV";
	dkim-atps=neutral
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D616810E4A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 00:02:01 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7e864c4615aso43409985a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 17:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755043320; x=1755648120; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WKctTtMetUdGeBEGMWEj8dnsRy45pvWcd/BgPpQaBNc=;
 b=MEhWPGXV4adoNjEE+DGRsB9zfUuLiSkjEO1fl2jvEGg2zstMKGuH5BQQAl+3HsxBC6
 Ob9BFBkHXqE4B1dTRCNXHxu78W3gC6G+JDQcFvDzr6fNv1b+SXMRFp7ioXEEnFFgdQ/F
 OpUveplYki6NsyaMhw5t0U9ruYmtIQVVTOHOn4C6Qev+UMUzdjAsI8nATy035NC7Uqs1
 Vnaq4DcRwowMTzqTTbqE5fcl7p5BkWelDAS39MsIZ3R9tU2MVeZyICWN2e0gWYdwla9c
 VpXr1Zs1kEgfTHggafU3xgrVc/VymiIBrlVzc2fk5MXv3NsCZUjUIE7odSKy/Uff5TtF
 KQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755043320; x=1755648120;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WKctTtMetUdGeBEGMWEj8dnsRy45pvWcd/BgPpQaBNc=;
 b=YyBALYJrIABU4jfwc/iygnVNfiKS1QWdK0yt+hdf3utDybS8rIojHyonCmSv6sqjEn
 liLwT2Om6yYofRwG9/Cg30makll6REwJJA2kLqRHtq6vCAhGcigPgC5uUcbysKHiVck3
 /2nb3wmLygLc3/YooCvX8rOdXtxMqQJfjLZ8rXqOiMUOQ6Tv8+3WWjgSWFWsQvkpe9fA
 oxJNDFJ9IXVwZS4opKI+zTyCmLgzu62zIJ/p8suEOPLPG/iahufQt1xuB8OpFJYvQfXi
 nEbbcSsMpSLd1dmzwvxEWoGF2mdMvplfJ/KVlcJchr9I3GePE70ysqXkYRXNMQaA4VzK
 wplg==
X-Gm-Message-State: AOJu0Yy8uZCpLLBg1Q6L4a02xNey5ZgElvpgn0Pzig+3drFWRnejz/VZ
 af0UIX109clERHznnaCk+xTk5VURasbioO4rZGHS7lWYvcKhHe1ZWdUZQQ6as7Kc
X-Gm-Gg: ASbGncspaiT74mhzzo7G2eUX/kReJWuxAbDtVlZ6635QGTCPv2N2699K9lxyPxbaAjx
 3awcTycFgp0uNRaVmCUuwsvisQhSXD6zB1g/Y9Gv6kB2kFMdwAapitV2NpH/LeHZ85Nnsv6xlPo
 0LccGe+JLNWE92Mn6ODBWuQC0gDI9VcshxD3OJB+aw37dHH3kakBdycEMPYLlwhxt9S+le/7aWI
 PrynjLDp3Ufz3/p73DIoWAhiItzHa8qEVM/tWp0J3zUO+QB6RM/0T8vxh5AT+GurMLr5h5kOuiO
 xz9/pLG795eejwOjUXUdkGvxSnFxA0HyWmO1xmavoGpgtNjA/M31W9M9ymVKKIhMrBzNclz/zRj
 k3WjKrpKDERNdU1G69mAgUMWRonw=
X-Google-Smtp-Source: AGHT+IF6fhIC5paxlKlCPDhout82/f4A5m9LX94KCB+KIRDcrOH7IOW3zvU28y2ZdFe1rL0Ff4l/QA==
X-Received: by 2002:a05:6214:76f:b0:707:4bb4:cf76 with SMTP id
 6a1803df08f44-709eaeba6bamr6307366d6.3.1755043320410; 
 Tue, 12 Aug 2025 17:02:00 -0700 (PDT)
Received: from Xander ([104.251.39.208]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077ce3a099sm185937416d6.81.2025.08.12.17.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 17:02:00 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Subject: [PATCH 0/4] Add and use "name" member to radeon_ring struct
Date: Tue, 12 Aug 2025 20:01:37 -0400
Message-ID: <20250813000141.105508-1-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.50.1
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

This series adds a "name" member to the radeon_ring structure and
uses it instead of ring indexes in logs and std outputs. This change is
proposed for better logs readability and ring identification as much
for the average user as for debugging purposes.

It uses the same naming convention as the one used under amdgpu for
coherence between the two drivers.

Alexandre Demers (4):
  drm/radeon: add name member to radeon_ring structure
  drm/radeon: rename ring to ring_idx in
    radeon_fence_driver_start_ring()
  drm/radeon: name rings
  drm/radeon: switch from ring->idx to ring->name for printouts

 drivers/gpu/drm/radeon/cik.c          | 33 +++++++++++++++------
 drivers/gpu/drm/radeon/cik_sdma.c     |  6 ++--
 drivers/gpu/drm/radeon/ni.c           | 10 +++++--
 drivers/gpu/drm/radeon/r600.c         |  8 ++---
 drivers/gpu/drm/radeon/r600_dma.c     |  8 ++---
 drivers/gpu/drm/radeon/radeon.h       |  1 +
 drivers/gpu/drm/radeon/radeon_fence.c | 42 ++++++++++++++-------------
 drivers/gpu/drm/radeon/radeon_ring.c  |  4 +--
 drivers/gpu/drm/radeon/radeon_vce.c   | 13 +++++----
 drivers/gpu/drm/radeon/si.c           | 36 +++++++++++++++++------
 drivers/gpu/drm/radeon/uvd_v1_0.c     | 14 ++++-----
 11 files changed, 109 insertions(+), 66 deletions(-)

-- 
2.50.1

