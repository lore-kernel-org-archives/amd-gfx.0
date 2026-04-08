Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E093E9DE6E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 08:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B959410E7AF;
	Thu,  9 Apr 2026 08:45:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="FE6R7rKz";
	dkim-atps=neutral
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A8710E6E6
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 21:33:57 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-50d8e11b948so2540411cf.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Apr 2026 14:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775684036; cv=none;
 d=google.com; s=arc-20240605;
 b=JQuycutBOXloqSaRe9/kGhTw8C2LL94wahSwD22Zp3KH1U41aP0cDo50NhMvOAKuQZ
 ALaNt1ExGYhaKT/XikosE9C9f42A12jPzST1r1aySxyrPee6AQT2RsYtVPzU69uErQDu
 04SFzWxm7ScwO8tONc37AeKk1VPPorp4SYucnFjOBBKFJWROaMw9UvbphIEs9jJzI6+N
 d3lyoWdLPYzvie+GVPs/I70H/MWMWpPM7KNBzNQLOup/og6UGag6c+nsyDM1DNKG/ZUX
 FnmMCKGAwJ5ZRAMDz6UtH/KwVElBkwQhYe9rcfRh0BpAF2UZQsGx5xvdtr5L2GgVEhBb
 R5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=doGjfSdqGxWaaf0j31ZX+HNVKXX84w/qCErdZPoH15Y=;
 fh=LYN8rUkjKrk8P/z4hxTLJgSk8ZFtrFPhcLjEY5H8VoM=;
 b=DrsVr00gKwASn+T4/cRYBb4vPafpzUlAIREse2ZRPGKFFHJknCY188uZMAMxLLIWSQ
 sq4xn2OLlpNVgqEkNsBqhX3JEu7+SCZibQwft55+QtIXRhTF6IUrO0xqcGq2NMyqH+WG
 RcTYOZIfEw+a305XxqLf9/mw+PxyvVkVig2kw7w6rQ5dJCuPEtBB5isfApG4/PkurYfi
 Bkqu1BZ4Rt/M8NsjmRxB4QWdIGV0piP2nnSE4copAlyA07T/OpUSELMyMX6IN1XDmC5S
 HEfHzApUi5/G/IZ3mRT3dXATMsmrYtd48A5Va/Fn1rdZmGpErCuP+Qaw5LsEKP+XwpR9
 N3Vg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1775684036; x=1776288836;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=doGjfSdqGxWaaf0j31ZX+HNVKXX84w/qCErdZPoH15Y=;
 b=FE6R7rKzbHHsA2nJE+fRao2V5qmjFqGJzZVA1YV4qiSPm9q35kgYENvkMrDed+/KU9
 0Ug0Dm/eXOZE4+p4mX0jECXuTs4V8atWNpHlO23u+ybq0gC8D87MOS8U3x6w32lU1e3M
 XUEmd9qGeffFvcmtRI1yaMCZch15KPWrHesPYEdmo4LUSPa4bW3N/LgPQH1sf8H0jwlT
 Cx+DCFlb7Pwpkl47NMwNqvZuiKchCQQPXcsLBaKN2O/L4dwUjOenBrMi6yScOnyEADGf
 5rWqVG6oBz+yeud8DpqDz/FedmTWaXRolvXq3IW3UckAPWzuGEofzFXhAz2MSBjBiMK9
 ei6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775684036; x=1776288836;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=doGjfSdqGxWaaf0j31ZX+HNVKXX84w/qCErdZPoH15Y=;
 b=abTUZ1MSCFRlK6u6+abtLWFGJKf39Pcl+9m5azebfevV218cN6Jq9Fd+hMtTGsjt0O
 IuTF//x0djRiOsB+h1BdXrxyz+2BVhHj5q0P8j2nMUMbnY5xVo9RFk62m1NopU1Ww0iG
 vU+pYjeBSkBIfo6vrJ2oivEPvnMrqdfLTdXccLuobV73BK1lnHYzfXZPRWrGq3z5wJ9m
 2ILxVqUBjYIhLqymdSkzZYWOFwoxibzMLOqLtgLA67fZDV5vUp9dSzOwlEZVmnNhZsLg
 Y+ZmH5yi+LR2eduiOXXCGLI0dfwr8zGymRaNSGehRTYmb/knFNORz7/xXYKH+jDWwGpK
 ROuQ==
X-Gm-Message-State: AOJu0Yw98cT7eOZI5yO6yUNMBAT8xD/4m6lVdZ4BB3GmenwbZAr7/MV2
 Zjd2n4ZBMEWqfVmAWZAPsuZQsDE53IRVqEzjS5ZFjqDc8wCwIUzsuigEBkU6MUkqwrJk3/4fvhu
 BF+wqv78qo2eVITrvD8w4JN7o0lIYEb+HWN2HxYL7hewjGDr1QM8KjIYi9Q==
X-Gm-Gg: AeBDiett60YV/YkOmJ1qS3KLWb13BHtss/YtkhK6Q877CZHYgychIeSDKKMP94BizGs
 13klGgmllj8a2wvqopAV9yTIWrAXj6RVrPT/sKfqfih+jD3PbTd+gWXC9tM65UVSYU4laglrfPa
 8V8i7FXX9UwOh+Zf5OchQ6ljq1kNpzcjci8ikrtDLzedAgxJfH2HBS90e2m4wbgfTi6OAOlAf5t
 3vD/23RKuTQ4eC6lsejEjrJRtHJXbYs55undW40v9CgCeURRINy09JLn3Iq/fQ5J8RY+k1ub18C
 8ZfQ
X-Received: by 2002:ac8:7e91:0:b0:4ff:c08a:52c4 with SMTP id
 d75a77b69052e-50d62772eb2mr346712311cf.18.1775684036030; Wed, 08 Apr 2026
 14:33:56 -0700 (PDT)
MIME-Version: 1.0
From: Geramy Loveless <gloveless@jqluv.com>
Date: Wed, 8 Apr 2026 14:33:44 -0700
X-Gm-Features: AQROBzBhZoBiVroABRauZPhvuFMI8xBt-FnXYyap62Sm9CP41gzrWwXXmHQAnmk
Message-ID: <CAGpo2meuqBDvbkX1_rmCacoLnixbQXdVw6+j5n-kYe25fj5cVw@mail.gmail.com>
Subject: [PATCH] amdgpu: teardown after failed init causes NULL deref in
 fw_reg_write_reg_wait
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 09 Apr 2026 08:45:39 +0000
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

When GPU initialization fails (e.g. IP discovery failure), the teardown
path frees TTM buffers which triggers GART unbind, following the call
chain down to amdgpu_gmc_fw_reg_write_reg_wait. This function tries to
emit commands to the KIQ ring, but the ring buffer was never mapped
because of the initial failure to bring the device online.

Check that ring->ring is non-NULL before continuing.

Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 ++++++
1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 5179fa008..09db87139 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -876,6 +876,12 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct
amdgpu_device *adev,
return;
}
+ /* Ring buffer may not be mapped if GPU init failed early
+ * such as a discovery failure. Check for NULL and return to stop a
kernel crash.
+ */
+ if (unlikely(!ring->ring))
+ return;
+
spin_lock_irqsave(&kiq->ring_lock, flags);
amdgpu_ring_alloc(ring, 32);
amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
-- 
2.51.0
