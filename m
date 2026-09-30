Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2589DCA5FC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 15:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACCE910E200;
	Wed, 30 Sep 2026 15:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nj371Meg";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F13E210E200
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 15:55:21 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ffe281cb1so28373625e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790783720; x=1791388520; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ycpIURId7rKP3x172gP4mZJ4LLseCO66YY86MDk9R/4=;
 b=Nj371MegGvqYB/ZvIbIIyeyI3Z74IsZ+c4k/hrLWhZkEHm5m351vWrkQX6Ev/ImvIu
 nG2jnGefXX8wY+1f0rXmA4l81SM+i9lbx+/9DpM6OW7v4irA3TB1cMoOBvjM567teHIK
 6QUfDAOwq2SFPkIf40379OQZdRaWsEpftMuo9MFVl7NXcfXFwrRD8tKpZBx/x8GNmxPv
 SVV2ls8hpjXLMTiz9hKDbH3QxGyUUeuCqubc2NGiRr8bsIWVVf5adseLq2eDz3VmKo+4
 m9JBQzQRkoJlQsCb/HTvlkSrxNOZzbcEx8+K51iX3JP5+WpjGUREwiqoGhjsDqtBCYrV
 Vt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790783720; x=1791388520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ycpIURId7rKP3x172gP4mZJ4LLseCO66YY86MDk9R/4=;
 b=klbxcMdUx6ZJ0O7j0J8MBiAc7qP0plgaKUvD/bHS/Iv8dmEuDyee3FE7yLAxeaOZUa
 z/s6bKRFk0+vRnsH3MhNZ9lxqA2aqmP+qmFC2oGxo5xbJUzmnL2kS+t7gdN0E3oo+4lr
 IHRei4NZXNg0EcIvXHzBm8x1ja+/JtEiVkR2bpiB+tVZnzDy8rq0/lfipx3fGrVT9CtK
 fIcL/ZU8gebG0CUiUpT5uMaLWB6Cu4Iz1AzyGmU7Fp5eC67NfHf+p1F5KTNu9EeO65dS
 DHWmh7XwIcFlhj3XliNGn0GOy3M22wc/z7yOcqc4pjiQP9IUv1zB68s6zcKWnknkBNcc
 9//Q==
X-Gm-Message-State: AFuF++kKCyh6dhpALGs7Xec58bk2I6WuA0lKklYFLiFE43WaEB3YRB/A
 Tw906elihNsy5JOEMZAfiNnZADvCz+xAG4XHxERy9NFbCgGIkcWcegNDmTtI2aMEBJ7pgjLE
X-Gm-Gg: AYBFou1g7SPL8WWfVLF6fKK0kOj8cmgZMughRlJv29sIyXR6zMy2sYfQY9qQbv2/9yr
 jFRkQ8m92kCWHfd43Po/pyHLHa0QfGCalmRgu+asZFL4uM4MLOXvgEctBM/m02nL6Ng8h/gFxvC
 rmyzTaw5aCjUFO868m7A+3CLVK3lff15/n4SR/+NS6p61myoomQDHWnsJ3gubeNlfPpQAMFLsGl
 tVCIrB3wWrvEa8H/Lie+tzQdT09rwD/M8O7kToxdKbZdha+EYF6lu1t6ELcS9dUQ2Mo2M4bn1JY
 QVSsCLSeBFqU6MxjYSOCmL0szeXlsUBiYMu+KT5/vRO09kP5Un9Pg2VX28LfzZqATCy0Re517CC
 00hEUofufP0/k0nBpFdNPFqqTCQte+Og5xVPjtsk5Ewj0R0QsoZZ9amDIZiOuLw5Qask/XiQKmY
 wAmmOVvPznrUFpfndu2njK+OCI50BjsS7yVLbmVY32rE4aIJx865UySwGUFXLmx/45Fmu4SbFg/
 rsXGDXVThP0aLiisOmtbIwBHPitsL+qcsfjfoT2RCfDxna68oCBdQO30X9iN+wCvaCm1Fk=
X-Received: by 2002:a05:600c:6815:b0:49f:f963:7093 with SMTP id
 5b1f17b1804b1-4a01b00d679mr33327255e9.23.1790783720293; 
 Wed, 30 Sep 2026 08:55:20 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01e672ee5sm12247765e9.9.2026.09.30.08.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:55:19 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 vitaly.prosyak@amd.com, tom.stdenis@amd.com,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: copy debugfs register data outside the
 GRBM/SRBM locks
Date: Wed, 30 Sep 2026 20:55:16 +0500
Message-ID: <20260930155516.29560-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930154934.27981-1-mikhail.v.gavrilov@gmail.com>
References: <20260930154934.27981-1-mikhail.v.gavrilov@gmail.com>
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

Tested on Navi 31 (gfx1100), 7.3.0-rc5 at 551c722f4080, with lockdep.

Without this patch the first GRBM-banked access through amdgpu_regs2
produces the report quoted in the commit message: from the write
branch when umr halts waves, and from the read branch for a single
"umr -b x x x -r '*.gfx1100.regGRBM_STATUS'" on a fresh boot.

With this patch, and with the chain from reservation_ww_class_mutex
through &amdgpu_notifier_lock_key down to &amdgpu_grbm_lock_key present
in /proc/lockdep, none of the following produced a report, and
debug_locks stayed 1:
- the banked read of GRBM_STATUS* above;
- "umr -O halt_waves -wa gfx_0.0.0" (banked SQ_CMD writes);
- writing SCRATCH_REG0 and reading it back through amdgpu_regs2 with
  GRBM broadcast, and through amdgpu_regs with the bank bits in the
  offset; both reads returned the value written.

The patch is against 551c722f4080 and also applies to
amd-staging-drm-next and next-20260929.
