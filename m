Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED74C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 12:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88AAF10ECE3;
	Wed, 26 Aug 2026 12:46:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UJK4J3Zc";
	dkim-atps=neutral
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com
 [209.85.222.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFE7110E1A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 21:18:52 +0000 (UTC)
Received: by mail-ua1-f53.google.com with SMTP id
 a1e0cc1a2514c-97caa212bf3so134773241.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787692731; x=1788297531; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bh6hw4lNpnpTEOon2swojuWS7+DiWcpyyvZc9c5JemE=;
 b=UJK4J3ZcI2ljRcgsvP5WS5vMN+LYfcR3LQIy0DYJyG1n63O3OS5BeypHpe5p4QxlF5
 9IF4FVgkfj6/4Vh7vNARYpIi5mH5cE7/oIPEmtPyka1M2DxlDLT3wc+UmPJI4Ggd43oz
 /3CkOaHOFfikwsJg6vDLDG/asEQu8ptARj/O7dfRNcjQRSU5jeran6S6Y/3utnPkQeS0
 lfYsdvrCbBg4ookHfoGfQbWFb9oL6W4gt42p/Dd8XBpJJp8tXivSCGi9XbDWGNwqKQNj
 Qvi+YY/49fq+8nxLrH0bkRvbCq+x+CxCl5ckdRyvaOlPxm3voFROmGUpItTdq/Ls9ohD
 zkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787692731; x=1788297531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bh6hw4lNpnpTEOon2swojuWS7+DiWcpyyvZc9c5JemE=;
 b=dF0JdahZNOnQpWUf5QehJNLF/Nad/olwR9EaTyCOx/l0by5nFn+TIjTSlCUmPveN4/
 D2oIwEkQKmkJUVQ5FXc6Px8Am2q4J65KQPAtTGVVr8oMRZIuxTpnJBj5mueIpcMkrYrm
 /xNOg3NlrOzFf2PYLIjCVz4TrGunqukHelCX5T3zKNLGsGsFRgD2YXYuxAY0XW5jNmBE
 pckIxSRJDVHEjdB1S3dGxdr8s4vFVVMkQmHvQ/j9Nxlrj4f/YlcMtS2TBv8fuq9G8oK6
 BOydSa/KzunqXg4XDEFnUrrii57yqms4NVmn4gI/pmLHbHC0dDqxqZ/PZU//S/QJZ6DW
 44qA==
X-Gm-Message-State: AFuF++mus8O0zYqOvObMNWwFRVtsiOMmAcUpprz5lfbDGhLzbT8jindj
 e7gssAWiURVh239OVYTeHsf3GxJ7u34Ie99kttTYwhxZqBzcaBGDzhecAGV1tw0aOoU=
X-Gm-Gg: AR+sD13tKgK3bwTK9LSDdWD0CiKBPKHLLJt6HIWGwbZ7FQpNVtKQ26knlmWHhjjoR8c
 TlbzQ8Jrt+L0gNNRuMq+BsqUnCec/6u/RN+zR8vjOzaEeXfoZ1jk+9UCdC3HmjxlovZCdpPyMYv
 UTyQUZBqY8kXNN+RFZbEFR8O8wlfAzVvDDfZRMy+kHsNN4laVhj8R7HWBqUHfyoIzgf4M8uML1s
 6/KpR7RVC3ibZKaYhD0dXis9r9jk67QyIGuLHBZ80ospGkNISpNBgV+jsY2XV+w3cD5tSyfeZEj
 b3hVUwdXJMsiovYSD9m3FyKDd2jrVIIRGeAGefVwkkgylgoxGhvvfuvw+b7JTWiH91O5MWAQta7
 oZnl+U+v7S1lfn68Xs1TvYqDWdbzE2pPB6SZfY7P5zrStf8k2aXZoqOEvY1EYEFZ9DckMfJsMzc
 kvDm5Z+OIebpnQK9jIcM+KyETK0/MPZ9gpjizIBm6uZC82+DkNKPxZw9lp
X-Received: by 2002:a05:6102:6b09:b0:77f:9729:f3a0 with SMTP id
 ada2fe7eead31-782c03e0804mr807724137.6.1787692731362; 
 Tue, 25 Aug 2026 14:18:51 -0700 (PDT)
Received: from t14 ([189.39.221.242]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-78307cb51b9sm47611137.7.2026.08.25.14.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:18:50 -0700 (PDT)
From: Mauricio Bellon <mauriciobellon@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Wayne Lin <Wayne.Lin@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mauricio Bellon <mbellon@lenovo.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Subject: [PATCH 0/2] drm/amd/display: stabilize DCN35 ODM and DSC sequencing
Date: Tue, 25 Aug 2026 18:18:17 -0300
Message-ID: <20260825211819.100210-1-mauriciobellon@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Aug 2026 12:46:21 +0000
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

From: Mauricio Bellon <mbellon@lenovo.com>

Two related direct DisplayPort failures occur on DCN35 with a
high-refresh DSC stream using two-way ODM. A normal transition from
4K120 to 4K144 can commit successfully but produce no visible output.
After 4K144 is working, a long-pulse hotplug can reconstruct the same
stream but leave the monitor black.

The first patch stabilizes the DCN35 ODM update. It exposes the missing
ODM double-buffer pending-clear callback, keeps the horizontal timing
divider under manual control while programming the ODM topology, waits
for the update to complete, and restores the timing-derived target
manual mode.

The second patch enables sink DSC before source DSC in the DPMS-on
pre-enable path and removes the later redundant sink DSC enablement.

The complete series was built and booted as
7.1.0-bellon18-amd-final+ on a Lenovo ThinkPad X13 Gen 6 AMD with a
Krackan Point Radeon 840M and Corsair Xeneon 32UHD144 connected directly
through USB-C DP Alt Mode SST.

The following scenarios all produced stable visible output:

- 4K144 initial modeset
- 4K120 to 4K144
- 4K144 to 4K120 to 4K144
- 4K144 long-pulse unplug/replug
- repeated 4K144 unplug/replug cycles

This series covers the direct-SST modeset and hotplug reconstruction
failures. It does not claim to address the separate DPIA/MST warning
observed through the USB4 dock.

The commits retain my Lenovo author and Signed-off-by address. This
submission is sent through my personal Gmail account because Lenovo
email is not compatible with git send-email.

Bug report:
https://gitlab.freedesktop.org/drm/amd/-/issues/5033

Mauricio Bellon (2):
  drm/amd/display: stabilize DCN35 ODM update sequencing
  drm/amd/display: enable sink DSC before source DSC

 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 20 +++++++++++++++++--
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  5 +++--
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |  2 ++
 3 files changed, 23 insertions(+), 4 deletions(-)


base-commit: 232bf7d5453df6cc0d877a1003f9aa172e9750de
-- 
2.53.0
