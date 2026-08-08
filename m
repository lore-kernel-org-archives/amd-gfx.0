Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7EBC5B568
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACDF110E6AF;
	Mon, 10 Aug 2026 06:42:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pYcEhLtX";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8034510E08D
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2026 22:29:29 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-84f38f3b36eso420158b3a.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 15:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786228169; x=1786832969; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l7mobE6iuvRSDNq5l6lCLR+AOwfPsO7VXjaRec5r9EE=;
 b=pYcEhLtX/m/JyuyasHWdyevFuMgK4zZm+WALPEsDO0sUuTVORahWbqEpiTmq7fOAKP
 edXL+2d6fFDWvKrf6tcI6CXR8YEDFU20nAKPFWIQmDd9WtpIeQraPZ+pnc9gvZG16C45
 Xkb78DleOXPfUmGHxI8NXritWEYFImsFIGOkbN6uurUJ88zOHIO1Eu2irzEeriv7dkXG
 AQD/t2FZtiBOD8ufUBir7IHyptmuo6rJDMzNsQf0rG4Phh0rkHmq/BB/7ZLctPG9Ae6j
 rw1VxcUWVVuhRDu27QmCbT42mxcjTfAqRhH4R86woBqE++gX0kTtXsh+DrEizp7dGSeK
 EGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786228169; x=1786832969;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l7mobE6iuvRSDNq5l6lCLR+AOwfPsO7VXjaRec5r9EE=;
 b=pE0ECkGfS3uekxAI0QglZosJm+ax8HVwQ3IYvByvZvpqngWpm0nnD2h/XnhO/kK9zo
 KKIqnvvEsMUAGM8JPOAiQu/ypSpjnm24KkX6N8UWGq4zkpNmpeSMx2c+ElgPMSpMVTPT
 nj6edKkqeba2VYK++sT8HoK0fFD8VUGyLpp1S+3AhlSzhI+wLzYYRCr7GN9HgaejWHg9
 cBLP2h3pV8IpcZLS+ph4jyP6HTap6N4ZzMsJ0l9pFggTFakP96XsRYePOG6s7B+MfHN0
 WgbK01Z+HNpdLJQcUUYi/7hk/D/7yV5ckz91WPu2Q+5VUCIIrkOAnICLTSzfSk3HCGt6
 cp7Q==
X-Gm-Message-State: AOJu0YyaPzCUb6N0V7g6X3QV81hMlEp0ZN22OKO47HWy5Hx4igCfNLW3
 ol2mGL+uuMFi+F3aZ5FuscnCCt+8iuLAKhH9N3s0QMl65rrqFrhqIp9F
X-Gm-Gg: AR+sD10QaXJj9TXNjilsdSH/pp9ZyJ35dncptLJFtwp/sjYy4l6nhE/3nO7mvpEVYYp
 igDRVAV5hw/TqTtkJxVKFTD+qguWU1TO96yl5K7AeE0c5aCacaappzpjXR79GoH/71LxhmTrBBt
 fgwjrjs5N8HFwrzSMBOUPIi/mXrOSMEMFVDk/Oht6wq3/f97FTO/mL0qRRz3ZYo/AhZEbSVZzID
 IueZquxZZi87vKjhXu6Sq5nH4eLHUHZxEzsjTP1sk6OIGTrLXitA+xgxgf6QSLYwayij2eRO6pc
 rWjb9kr/QvRQCYyPDty9XuZieoEvcL0fzi1+PXx+E+3hRJuu6tL7X9eLm5bGoKRWlZDvMbxXBox
 fsXUF0MVfMQSkh0KFOHghduIDFNCXOnayEviYCQr/QWO1QaiTGI1nqITDTgP2j6Lq3XcFVDUvwa
 LoxnQ9UEM0HCsVDL+Va820kSXFYGQoNvcIAVKl+lzeaEwhUAMWMsT5mc61Nml5lKH/EEwfjB93U
 Oj9qkOpKg072A45l1drig==
X-Received: by 2002:a05:6a20:7349:b0:3c6:3c5b:f2e1 with SMTP id
 adf61e73a8af0-3cbadcfcacfmr19149793637.32.1786228168911; 
 Sat, 08 Aug 2026 15:29:28 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb877b4sm27463910eec.19.2026.08.08.15.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 15:29:28 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v2 0/5] drm/amdgpu/aca: Robustness and safety fixes for ACA
 driver
Date: Sat,  8 Aug 2026 22:27:37 +0000
Message-ID: <20260808222742.2859-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:02 +0000
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
the AMDGPU ACA (Accelerated Compute Architecture) driver subsystem.

v1 -> v2:
  - Patch 3: Updated remove_aca_handle() to use list_del_init() instead
    of list_del(), ensuring list_empty() properly evaluates removed
    handles and avoiding potential UAF during device teardown.

Sreeraj S Kurup (5):
  drm/amdgpu/aca: Fix race condition and UAF in error cache logging
  drm/amdgpu/aca: Add upper bounds check in aca_bank_hwip_is_matched
  drm/amdgpu/aca: Fix inverted validation logic and handle cleanup
  drm/amdgpu/aca: Add missing NULL check for banks parameter in
    aca_banks_add_bank
  drm/amdgpu/aca: Fix off-by-one buffer size parameter in add_aca_sysfs

 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 33 ++++++++++---------------
 1 file changed, 13 insertions(+), 20 deletions(-)

-- 
2.54.0

