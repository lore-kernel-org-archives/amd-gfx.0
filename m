Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3B7CA5FFF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 18:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A3D110E2FD;
	Tue,  6 Oct 2026 18:34:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s0G59dz0";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB4C810E2FD
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 18:34:47 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a01933b584so9402745e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Oct 2026 11:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791311686; x=1791916486; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EPldbamGOA2/FqKolO+l+yDSqIItM2ZliiuMEa8sPWY=;
 b=s0G59dz0uM3jS8MjmTreQqBa0ctxCsJuGQHYngD7vG92NW1QyxHeptNrfnvTQWdzDO
 EcPg6pox9ujzWfxdG/UaUvLnwSDqDvyNtgmHoGl5eSs7wUGjad1XLSNpF0euf2oMegTc
 Pmb06cGN8XMm3zqtK33nispCGzWlNz6jpgxoCrFJHIaRKTBQXVL6oBdU3acWrfV2rWa3
 FogsVAdTYKiRRa31bPUYuBdxdZB4Lw5HOM+Cmg2vv1augXNuc2SoWuKOxSmC1BWNPdWz
 3UZlGwNkhK+6qCiL+dz/altVC+/1V1zmmNw1vrc9ypBCPkjuOib2K1py5xhyw+5IEVFH
 lpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791311686; x=1791916486;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EPldbamGOA2/FqKolO+l+yDSqIItM2ZliiuMEa8sPWY=;
 b=BGRUOXK+vGerCVjqXCZtD6ckylwW4CiSyMypCikNm2LZ+mcDr8SzGocaJJoFr8AFBz
 L6RNCTsbevBQ2sI4QwI7GF+OtBmlJfh6XOf8dN9HWsYgGg2sCdOldA6SZVOpnC+0GMJl
 DPCQKtnyDsCVpl38+p4YBlC9mx9GsEslvbQEQx3naXhe+M5QUGxCl7JB9U7ITUOh62b1
 UUDi+vM4LsjQbnNlq2HjNzlWQSzqBxnW3PY/MgkHCKkfl4K+YVq8jFc6uVx6RGrIg2xJ
 +SceqjCTjEfRldeD0xLW4uqm2QKUoLnFRI5Q5r9mG5p40n0ebwvfMEV2ZE/xYZUfCyRI
 64Og==
X-Gm-Message-State: AFuF++k8x3L8l9+3Qtj/QOxlcr508DsT5IjJC80BMNVgAZnnG/mC04yR
 AFr9jKL6EdvMXMtLVdwhdDPDocfeN9Kq7PX0mNBQvFYwDpctwMABUTUQay+T3Q==
X-Gm-Gg: AYBFou2PlVjUxngo1mDoI0Krf+rJj5+0r08Kx+wcluk7rbsrmml7ZwBD4x257lrarAa
 cG1jX5gSrSneQuywt2xW71875lCcZuJDmwqZYYsrbgiwpQ1dMNntf7YlLk0QtI6BXVn+OHXp4cX
 2aOhl6+oBvm3H6XEPpUpTVy6Utnxnxfr/img/GFzj2hTRd4pTpqxiX2zzymd8cpsP+NU8HlrInD
 /butHDw06nBcdXFUiG5sv6Fhzr7QBcl2zdfzg/wUl6V/wo0+X0AEoif18sNxvdYAkDHYrfuvJAc
 CgYsmB4NfGKfuPSLNB+ndAmGBxHXEk0NoQjskol+BkZiwklNu8yTNAeWj90ygL49iyCab958NPh
 A1Z2SxKslKew1qIIh6lCcjtyWloNoCY2N1gHvXNqR5zT8vWZTLB8ZbwKgiXSc/wRS5kVyrgbsV2
 1rEky7kfqQG/DZBBpOjPACHinDGuwINrvKnx8UYuMJB7f+ZUgPXQFS5n9QiSyTXqnVKCPVYuvG1
 mXLfFEXuVGNmnBaTEeBnltbqvIv+f++PTeu4eLmdqWkOUchVSbe25hIsp6dGb0Vl5WFUDmPw552
 F2tmSlM7DdRVfT8024sU2Mvd2kE/FGZWIXe9Dv/fEdgDC3/CTnF2fS3pzH17y9nValbMG11vymw
 WTcz+5EIrH1rPus1FoeT2M7N8NmL+iqJhoOQdhG54lnDzGbsS4ZYLaf384pXa7uA7Xb8TRLuC8w
 droVlcb7eSuTwkMs8=
X-Received: by 2002:a05:600c:474e:b0:4a0:1c69:f607 with SMTP id
 5b1f17b1804b1-4a17b556526mr38004185e9.29.1791311685856; 
 Tue, 06 Oct 2026 11:34:45 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:41ef:ba36:bd76:1e3c:1e5:c273])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c50f54sm84411485e9.10.2026.10.06.11.34.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Oct 2026 11:34:45 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 1/2] drm/amdkfd: fix NULL deref and unbounded wait in
 teardown_processes on surprise removal
Date: Tue,  6 Oct 2026 20:34:44 +0200
Message-ID: <20261006183444.68744-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <8e289c9a-bb0e-44a5-9e96-997e8fa1ec61@amd.com>
References: 
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

Hi Felix,

> Do we have a sequencing issues? Should kgd2kfd_teardown_processes run
> before the KFD dev is destroyed?

Yes — that's exactly what the v3 resend does (patch 1/3): on the
pci_dev_is_disconnected() branch, amdgpu_device_fini_hw() now calls
amdgpu_amdkfd_teardown_processes() before the early
amdgpu_amdkfd_device_fini_sw(), so the drain runs while kfd.dev and
kfd_processes_count are still valid. ftrace on the repro confirms the
ordering: teardown from fini_hw, count drains, fini_sw ~8s later.

> A reference count leak of the kfd_process or the mm_struct could
> prevent this from happening.

Doesn't look like a leak — the SIGBUS'd process simply never gets to
exit. Its own fault path wedges: coredump -> gup -> do_swap_page ->
svm_migrate_to_ram submits an SDMA copy to the already-killed sched
entity and then svm_migrate_copy_done() waits uninterruptibly on a
fence that can never signal, all while holding svms->lock. Exit never
completes, the MMU notifier/cleanup path never runs, and the count
never drains. Patch 3/3 makes the SVM migration paths return -ENODEV
on a gone device; with that, the process dies and the count drains in
~7s on real hardware (MI50 behind TB3, slot power-off).

Olivier
