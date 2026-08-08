Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7F2C5B56B
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5057E10E6CE;
	Mon, 10 Aug 2026 06:42:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NoX22I93";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAE5D10E085
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2026 21:09:58 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cea3004256so7697195ad.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 14:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786223398; x=1786828198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JEDozRCApOyIBa6Mlu5Ff5h7lMmTA4l7LeQfPER4AT0=;
 b=NoX22I93gZXlztW3//XaIgTkz8FYFU2NGA/xsvfvXtAXGt1bLxKz3RhtZqupyXmagj
 oLLUxWQ2f8GexkuNv+mg1lFxzJitNPTVJnL1QhZRG2XPlx+nr0mp2ZXv127aJ31P7SU2
 21ajRRQpAJsM2EL2LBJ6ZK5yilowvMJVRUtenflItYt/FsEstI4BII+XqErt2ky3wgSn
 vpTp9jxkIqchQyiPEqC6YrKgDw5ohcUfY9KyxFVUe8AhumcK5WTbaJqgVNm3eLIwflF5
 TNMAIQHePzRuh7VjFfzUEFkRWo/52hPL7eGAYO8BfRYbDBgLrdUy9ZmwEIZfeRVh/efd
 QyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786223398; x=1786828198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JEDozRCApOyIBa6Mlu5Ff5h7lMmTA4l7LeQfPER4AT0=;
 b=YP1TWioClgYO2a2qezXcoz+S6RQ4kG0YHfrlAT+YMxEb/tfIa8LYR5WGw+GZUqcx8b
 lZgzPVrorBUL2nl0kTvLsoqcuN2mbywd5W2iVQngEm/PvCVDpyzV9Gpx8uxnAeRDRsBM
 2IxdBIuvuAaJ8g1tZWJaAdltod48TBIrJVYTs1ap/GwxCsVkRBKXqyN4+IV/PveXSoeG
 cbAarA3cNwAtfhX6kdfpwVoH63TvHEEnjKeCFjtzxs99wBz3PTSgpPyyJQC6DUdJsDKK
 9/FpsDC/wZp81Eey25gZJaR4xiOKB/FbXzlgkbUH3bMbYeZw3TNPd2hx6ERjW935PCjx
 jisw==
X-Gm-Message-State: AOJu0Yx4Zmg3o5tqpZk00dv1w+f71QNrfC3UlOso1zLZl51pWaIqM8an
 InCXKCuIUKFT6F6t/nCBsBVv9IoEPlifEBINpMwBOe7zpLS0OiPE/vjQ
X-Gm-Gg: AR+sD139N9KrvPEKLdOwwvLaPUEwMzbo5sYoRhA0eKqP9bN0bGP+MLo/O9YrDbMk8tI
 +UcmhM7rHLY7D0OK5VI47JXQrTKAT653BW2+wiIMHkavoPvHHe9louxwll+tx6JZp04j41yGRQM
 t1p17w0jMiGUVdp1ecIFpwOqgUN99NoPhSULPB4utPV03V1ZUa8Kad4Q+5vlgIbAJdjsDgFXI2r
 KKB+sm52SX4Og3qJKNiEiZ2J3sk7erxVYrNkLzp2PGJe3dNH5wsgcc5bRxu/RLGeO5EU6Zq8HjV
 8C9kittvb7VdBRHk/+4wMXsKJVScLFww8AvNjPPCDRW0yhoJZa5Tgdu4yVDvhMBM9oRdNBdZB0f
 GejK9+/1luilheKh83FyAsMuthhIPDclxrWhca+GiOZYlXi3QIssEKEwG5Y4mTwucQr63WhXBZc
 RVQtTmzieYoyTmzM61fT1+OEUbV1x/eRTWqLGBRSqpSbriMP39zpO1isg5VN7iVjaLSVZ0ijPMH
 aEtALYbhEs=
X-Received: by 2002:a05:6a20:d4b:b0:3c3:a722:59cc with SMTP id
 adf61e73a8af0-3cb85ea6f6bmr37753432637.22.1786223398152; 
 Sat, 08 Aug 2026 14:09:58 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bec5aac2sm25713133eec.30.2026.08.08.14.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 14:09:57 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH 0/5] drm/amdgpu/aca: Robustness and safety fixes for ACA driver
Date: Sat,  8 Aug 2026 21:08:47 +0000
Message-ID: <20260808210852.2938-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:03 +0000
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

This patch series addresses several race conditions, boundary check bugs,
logic inversions, NULL pointer checks, and buffer size parameters across
the AMDGPU ACA (Accelerated Compute Architecture) driver subsystem:

Sreeraj S Kurup (5):
  drm/amdgpu/aca: Fix race condition and UAF in error cache logging
  drm/amdgpu/aca: Add upper bounds check in aca_bank_hwip_is_matched
  drm/amdgpu/aca: Fix inverted validation logic in
    amdgpu_aca_get_error_data
  drm/amdgpu/aca: Add missing NULL check for banks parameter in
    aca_banks_add_bank
  drm/amdgpu/aca: Fix off-by-one buffer size parameter in add_aca_sysfs

 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 31 ++++++++++---------------
 1 file changed, 12 insertions(+), 19 deletions(-)

-- 
2.54.0

