Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15598C282CD
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Mar 2025 02:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3622310E0D8;
	Sat,  1 Mar 2025 02:31:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gW1Ymv40";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 660C210E0D8
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Mar 2025 02:31:32 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7c0892e4b19so303588985a.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 18:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740796291; x=1741401091; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zeYYZeoyddqPH+Pu6LRYAx7aXtJnAi7pBYLHUPh+RVo=;
 b=gW1Ymv40hCua2evrtYN+KmXJJVJ8Sm6e23t1RGcGCjuvvgH2b4EUaLf0NN2aC0Vv49
 irr++Y6bYK8n+xMdajN7a0/ZVpQtUbbm4W95675LNWb0hQhss3CPFsA4/sX7q9iXxGah
 un0SK27abaCAeKgjgrqFGthXKvL3dOmFYxS/w9lGSazpsJYrl3dWNzHCO3+gYW9pUaDm
 pdLGQ4H5mnpiLy/9egM028ow1C79EZbZkqyqLw6brQT0f+2Idm6dtInDonsuY+NVtWa3
 0YZ32qk6a8leqQcmvbudJAINrlVoltXKMe44/PuE1LYwM7l+qGlemmqKNEmziKQhlnfG
 09Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740796291; x=1741401091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zeYYZeoyddqPH+Pu6LRYAx7aXtJnAi7pBYLHUPh+RVo=;
 b=swZ772aJ9Skyw0QVpV4V+Yat9FG2EZQRwjP8ygCt74r1Vv5aAaZi4V3samo2LzR9lq
 NR5L4AQWegV44We84B1b1e1vPtxhukm0ate6tqrwxHxv/nZnSxFh21i611GgzJsHhwuU
 0J/WqZ1fGrRrJ6YZ1lssECU2Df0+wn1gGHIu3MC78NHUoQE4PCY5cM27rL264pnzgiEh
 BeA/9wUX4SGOvqiQtnRJ8egvuk4HjbZbEo9nMA42zydzBSFb64l2xDd8CzV7++L4OuFC
 q8CWPmMyCLwcr63/VlCR0EDEJOxTpko5SDfsXzzrnJMdjmARmkFcbGWx0c9sZmUDA4rN
 vqIw==
X-Gm-Message-State: AOJu0YxEVJmQvd5/DZvBa4NUoCRhNv7gDwM6LjOIn9lW4zNp/Um6ryZ9
 R7jGk2zbKLJUjc0gX/Zjlm9jtdHybaA+jOpo6BwaRF7LddVpdKDjOyjJhg==
X-Gm-Gg: ASbGnctDaXCgBP/9PvOHbaaFX4bV4FNZ1UdpIZI+IIZ3FD51I1vKInfRwR/a/fBNwPv
 X2Hr6Klq4K7iDj5Bn/wDg+dDZDTmlbCfFhJHx5ovpXALy3I/GRBGnecWzMhZmKg64ah12KvF9e8
 WEvAy/h0DD5TDCpQH3qtqktrsk35XB9fJX084fqrBUAbXmnt0O4XCyZ0A+uz0g6XobntL4RL4v4
 Bc8vPVHTfgE9eoUmZT+AUNS1EJ5r/m04/AVvpKp6JU/tTXPVuZE+petjwCRBRTAN8JDxa4ddGYx
 r1cMggQZpGpFiBL9S8aeJ9JNym2dgUqPVuCPvLMpTBNTh7uaX6Bwty0WmJGEmxEpo7Y=
X-Google-Smtp-Source: AGHT+IF82a2D9EGtmJOJmKwAeBdgJJSdzbuP1vTiX8KLI1VheAANrZis5roAro4qlZIGsbdOIl6mWA==
X-Received: by 2002:a05:620a:f02:b0:7c0:ab10:1125 with SMTP id
 af79cd13be357-7c39c67f36cmr970068185a.55.1740796291361; 
 Fri, 28 Feb 2025 18:31:31 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c36fef5beesm322857085a.32.2025.02.28.18.31.30
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 18:31:31 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 0/2] Uniformize defines between DCE6, DCE8 and DCE10
Date: Fri, 28 Feb 2025 21:31:28 -0500
Message-ID: <20250301023130.31277-1-alexandre.f.demers@gmail.com>
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

Alexandre Demers (2):
  drm/amdgpu: add or move defines for DCE6 in sid.h
  drm/amdgpu: add defines for pin_offsets in DCE8

 drivers/gpu/drm/amd/amdgpu/cikd.h     |  9 ++++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 63 ++++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 14 +++---
 drivers/gpu/drm/amd/amdgpu/si_enums.h |  7 ---
 drivers/gpu/drm/amd/amdgpu/sid.h      | 29 +++++++++---
 5 files changed, 71 insertions(+), 51 deletions(-)

-- 
2.48.1

