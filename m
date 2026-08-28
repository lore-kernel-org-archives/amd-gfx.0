Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BB6C61DCB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 12:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD2AA10E4D0;
	Fri, 28 Aug 2026 12:07:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NbzlMLUF";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F03010E00F
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 12:07:35 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c2022323c37so137062966b.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 05:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787918854; x=1788523654; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YQptJskLN+bhXYN8LRtMhM0AusLcVVY3UbBc0utTO2k=;
 b=NbzlMLUFZBeJIQpt6LN6vGlP8ze2KPFW2ACwvTfyXGI1IOdvbEq01PCkxBefQ30BJA
 gdHKM0qO4KRekaEP9jUzSyGCgJDkmDjWRtAxGxuGF00TO+1wBPxbOeCe59UT6MFgWsOc
 FNqpdHc+NripDaiNDkk7U+RFskdodEoG9Zlf2YtAVu8RFYJfA09ywDbux+ufq2NKQ8X9
 DmloeTxjtYdZh4Cq4jF9euW0IfNqCrsHTv26tLi1JiD660yq8YFPfDCkjx+Z90rWdiWn
 GraR9MkUKC5O2Y1lmblBT0JtrF8iThzUGyOIRQDMHEBG/IFCYKwx3D0CimXSI6lbm4Qc
 JVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787918854; x=1788523654;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YQptJskLN+bhXYN8LRtMhM0AusLcVVY3UbBc0utTO2k=;
 b=Kz7MwsO4KtkFTxW5UwOLay8ebWgZQJoWmKI4S+gslDRlmjEMYEslvC1dPBLORRLTk4
 vuUtAN7WUurqeyE52H8v+p3ti/pd3v+Qth6ocS/CfZ1YEq6au1zfL/oNeiStPyxEyXDG
 ehcJxJc74BfhTHb0GoesVk0WS7Kt7TXl865zozp5mfssHJK38T5+w3ZuW888KOV/Yn5r
 lW+PwSDk4P8qS0AUxyKBWtHvjZ9IZSYcD/m7+9ko/xelgXeWdVfL2+tR2YOrXXOxl+sB
 AvewvI368yAlym6ZFRAw4AiZkIw5OFD3S01KwwVmV2wC/hnIDA4cpvSxyRzwSjuoL1jN
 4XCg==
X-Gm-Message-State: AFuF++nVVCroaYYUw83p1zKOs19gotG8r/OHOFsamjaa9wh4b1jnlH0/
 hdDkwrS2j/yomWrz1ehpQt5qitbwFaU/4bSMd61s3KGZiFst51up5vJxsl4OtQvM
X-Gm-Gg: AR+sD102bGEsAhQcN2eNRhAunJjDhJUjngoJdfYv/tR7Fjok2TfWqAH1npBrtAS/TC+
 Q/h79PzXf6pCc27CDJVQAYVoTdkPZTdh+aoT8mTdbLhP5bjrd6Bewb3U6tEtUW7BFElFiW2rfkN
 ejSyCJ9Xx5ZGPU5s4Xb1j1eCXXMcTLaTTvhtekk/F0vvnddA5Q2S9+8xwN84nFYOeXxLPfhN3wF
 vAnUm5POnUrsBIfFSPv4iuq/BhIN+hoQSfaqATbFL9BsDnnv5W4EH8wQbkaWMNFfyjRN/VBURHQ
 fRyWwUYwt0z8bkiioYgoi4pif9Otqqr+SEf56RVfoL/A+wCYNpTD1TmGz9NpCzhp5+w1I5yrym7
 vIa7EsHwCToIK3ZEWk5kx6iQMa80zYoKTPCm7qU+JGeWzlN8YbeKoJoxNLfrGc5etlwgyaTyLFw
 WyseWjB8FeyjZHYKw30xJQuVvFhw8BbtF1kHR/odxGu3SYVpPOsdRw5UkWBoM4DlHtX3fKEX+XM
 C7Oddfz4CrnVYJTDJFGAIjl
X-Received: by 2002:a17:906:478c:b0:c25:4b3e:ff24 with SMTP id
 a640c23a62f3a-c25571312b1mr445248266b.10.1787918853600; 
 Fri, 28 Aug 2026 05:07:33 -0700 (PDT)
Received: from Timur-Hyperion (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255f29a9dfsm75364066b.63.2026.08.28.05.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:07:33 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/5] drm/amdgpu/sdma: Improve existing SDMA queue resets
Date: Fri, 28 Aug 2026 14:07:24 +0200
Message-ID: <20260828120729.25908-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Improve SDMA queue reset for SDMA v4.4.2, v5.0, v5.2
and also moves some functionality from backend-specific
code to common code in the amdgpu_sdma.c file.

This prepares for implementing SDMA queue resets
on more generations, as the same logic can be shared
with all SDMA HW generations that don't use the MES.
The actual queue reset implementations for various
older SDMA versions will come in subsequent patch series
after this one is accepted.

Timur Kristóf (5):
  drm/amdgpu/sdma: Clear SDMA rings after reset before starting them
  drm/amdgpu/sdma: Remove unimplemented soft_reset() for SDMA and SI DMA
  drm/amdgpu/sdma: Move SDMA v5.x queue reset to common code
  drm/amdgpu/sdma: Use common SDMA legacy queue reset on SDMA v4.4.2
  drm/amdgpu/sdma: In legacy queue reset function, check if KFD is
    initialized

 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 54 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  4 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  8 ----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 26 +-----------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 33 +--------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 25 +----------
 drivers/gpu/drm/amd/amdgpu/si_dma.c      |  7 ---
 7 files changed, 62 insertions(+), 95 deletions(-)

-- 
2.55.0

