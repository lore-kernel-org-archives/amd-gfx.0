Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D45EC87FD2
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Aug 2025 16:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EAD110E0B9;
	Sat,  2 Aug 2025 16:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VWe7RVm7";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34DD810E05E
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Aug 2025 16:06:07 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4560cdf235cso16404965e9.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 02 Aug 2025 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754150766; x=1754755566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kuh34ja+NXkIptLnxanWh23C1ly83qr6SQdpPlf6xGE=;
 b=VWe7RVm7cX39a7tysXG942bQurZSFRm4tZHFS8sXSWQMIrusfqE9ijsnScN1ej/8TW
 diVWp1jmgkxwGB3bqK50Rj1RsRJ/d2YWv/0QJeEv+FMoXVIECd5TMgEKCn8nacCQgTzy
 mQXzsJ+iyrNbEqUJG2nX0FBLrwOObptiGMFh4lSpYa6gESBBe3HNrO1fksN7DtC7GDD7
 L10EWBa7giyv9Uq92xWOGcdDg9j0Xp4dGNTCh3JUQ1L0l7EBbuKXHQnQUNU2Y+LG4QPC
 xEGc7hH7rJMt56T88pK32PBHmzRGz5MB+HF6PFsstirEnOlk2USlrzXAP4eXbySbML0h
 4IAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754150766; x=1754755566;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kuh34ja+NXkIptLnxanWh23C1ly83qr6SQdpPlf6xGE=;
 b=f45AdgIzL9O5KBoLm6X3Lc8QXBXjeSI10X0ZX2qfbM0L6ITuhalzR1iL4tg9to7D9I
 LOCaA6pHX8iurHIc3/TrY208QWonNf/0zb/ayCdBU2iz9e69pb4PHVedPRnJAXMqlmN6
 RSG9Jq0yklIgnV4Qs3oiARscuLQgfi6t4Q+FEQ6C32Djv+V5agMSi48eC89T5iF0z5Ks
 xVafMU9n613TV1/o5J64RWyeeICj84LWkPcYNHm8UNVLJ6rqEw+Y3xQsmpzHeRiuGCX4
 6mny0gevkBwXO+SA3z/kC++RIAx+WZX7YECWG6Bi/LObOK17Y4eBRfEC3w5UM9q7pBoA
 vBpA==
X-Gm-Message-State: AOJu0YxyflpeAkKAJMUn7mJqUtNuGtSzF9pyTgsxoPNckV9giadTom/X
 M+QNFypD2bd/8HYXAIIQvM4JzAT/GwO/MnQmU2n2738Ld3XJ8yrGV9TIjmgBeg==
X-Gm-Gg: ASbGncv1mQ29IB6x0fp2GPMODDLIo02GxOsumavWQzTfj/jXWt9zg/PEV4FqWUNXuCc
 Ni6dXIhe0y0be9zxpZgOU6u/Bbdi7D2qQH5VFT1pdJY/LD6UijPUvDxTeGVaiRHfbVbbBDLNbKF
 oPk7K/tjq4whFTyLtU1N2KwEO0Y5UZOeZAy88ddqb7NHtMj+PXA9/poQMlvGEgIXXzw8it15Fy9
 Dv7TDGZmTkBjdhOpwDRe6h1216y2BBWzEtGjd5Ch6GrpdzAKLhAiWq2YzNkwFonp9Vt7scAaaBi
 OMtIKDG6L5DjlPGYXxAqIR/vC3QzHKO6LxlL4rntptyzNprRu4UT7BOhc/AB0GSYa3axEq/ZKdy
 NupcI0BH5Wuu4XP2q34LK1AjcEdnjs4fZFbcvX6URDs4ZTGGvqjbcoXvKuz4M+R+ZQVlsQC2V8A
 GjEHrFMGldisHbDXZvtJTd3W6G3UejYA==
X-Google-Smtp-Source: AGHT+IFXoMtNhkY94CO92eaeuJWWq63uPfn+fUeYgUr+4vrfSE+0opLWVMikshDbof8EfZGu9Vy0vw==
X-Received: by 2002:a05:600c:4247:b0:458:bb0e:4181 with SMTP id
 5b1f17b1804b1-458bb0e438amr13608655e9.10.1754150765295; 
 Sat, 02 Aug 2025 09:06:05 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24DDB700267C66B850A0E369.dsl.pool.telekom.hu.
 [2001:4c4e:24dd:b700:267c:66b8:50a0:e369])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953cfcc1sm151164245e9.17.2025.08.02.09.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 09:06:04 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/3] DC: Fix page flip timeouts on DCE 6
Date: Sat,  2 Aug 2025 18:05:59 +0200
Message-ID: <20250802160602.12698-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
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

Currently when using DC on DCE 6, it produces a page flip timeout
after a suspend/resume.

After some investigation, it turns out that the issue is because
DC uses different interrupts between DCE 6 and newer HW versions,
and it assumes that the VUPDATE interrupt is always present, when
in fact it's not. It also assumes that the HW is capable of VRR
when a VRR capable monitor is plugged in, when in fact this is
not the case.

This series marks VRR as unsupported on DCE 6 even when a VRR
capable monitor is plugged in. Furthermore, it fixes the code
trying to access the unregistered VUPDATE interrupt.

As a side note, I also attempted to actually use the same
interrupts as newer DCE versions, but this didn't work.
Apparently DCE 6 was not advertised with VRR support anyway.

Finally, there is also a patch to disable fast boot mode
on DCE 6. The rationale is that this already didn't work
on DCE 8, and even if it did I have no means to test it.

Timur Kristóf (3):
  drm/amd/display: Disable fastboot on DCE 6 too.
  drm/amd/display: Disable VRR on DCE 6
  drm/amd/display: Don't use non-registered VUPDATE on DCE 6

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 ++++++++++++-------
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 16 +++++++-----
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |  5 ++++
 drivers/gpu/drm/amd/display/dc/dm_services.h  |  2 ++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  6 ++---
 5 files changed, 35 insertions(+), 20 deletions(-)

-- 
2.50.1

