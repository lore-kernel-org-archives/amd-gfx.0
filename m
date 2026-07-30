Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED4BC54FDF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 07:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E2A10EDF9;
	Thu, 30 Jul 2026 07:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q9iMOp+i";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EAE410E104
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 03:32:32 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso1253556a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 20:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785382351; x=1785987151; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pIcjyKLr9ppSis6rpQgpnx6np+skn/qzP0qaQZSDG10=;
 b=q9iMOp+igNf35sQwffFuxIkyFz5i+bixTc+oYDJCH5M0t43VeTeqAtotKBhA6tMAkb
 x2eM+Hj4im96AF/b5/gofc7jHDji9jKZ3tYuI1xu1VPZ3NBnF4mFpiR7oIG4Thz8Ku8E
 5GgH7gxRb0N31SyqOfKKb9Jya19lXdsKCqXUNAuWiczXz8d/tHQwxd7m7XALSldd7gDc
 CAuX/biye2zkf90yL2Xpj8y22JcZL2+jKg9ov9VEVMfYOkVyZuk5pOEzLet/bOEKm6xV
 MLU+lScAe3akhfTo8KsaD/GZEej0WS+0D1pVUQUPqNP4Qfrw6nD1ZyGnAgtcpUCzeKur
 YoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785382351; x=1785987151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pIcjyKLr9ppSis6rpQgpnx6np+skn/qzP0qaQZSDG10=;
 b=Kkb4IBVKLoIhMCRcxO+GtndgW0dkaJysdqKUbVUvYCcQljZghk/CkDj2OOGLcp33wt
 E4Ig4nVzx83b3bsi7IP7VJmyuVPWRMcBZFZjbVYjGXaJNn77Dut4qKzHG8JLvyc2Pzpp
 hi3MYl11YEkRdZ7vZMoJFvqOoxVTS2sGhEdqOEh4bnZqwUJasHKentsLRfocL83tEbMQ
 sDszc9GFcFy1yBzcr1S7oywZTVoOx+9w6GADHYr0HahwECAWw7jDBgYb54QbLe4IpsnQ
 dKsnRg1BJmw1ha7aj7ZbkGYWJvSiOHxgBX5RRLemcNP87Zznm/977ZBLC5dqmTOwejim
 ULiQ==
X-Gm-Message-State: AOJu0YwKz5kcjNYHK7ZBRvNgNDddFPqzfh8tb6t5AKPEkutfNnqsYBUB
 sIgyBKuZ6rYtIji0OfoWMl6H2+O9TOy7k10A7TPcxF6ZHRKlqnCUuSKCXddgm7W/
X-Gm-Gg: AR+sD10qiq+TjSWGlYudcmIQrmFEKj4H7pDmsfzuyQ+Bsc0iG/s2j5udJXiypZQjHO4
 7DVAKHuOOLAgowyrObIUgQ/1iBbqFWyvL47UMknllfG3yeiw45Y7lgatz5pF80+ZzI/bDEC1BgE
 tSwC4M6v/XLnKAMtuuctl/j+ubIENyte25oQVp8XCXrixYI07VnFobFCCpiv6vmHuf/UbgWfENz
 MuxVHVXyG4/EQPpS77LmYti/gZ1T5dSgfgVMAFklLvzr/CJ/x+p9EbN7gtR+6kTF8w5bGsjBzuH
 5Gj9FE7XqiKCVy04HCBlg1EZAhKcKphwPQv1ZQRrErON3ZKbi9q8hGIN8wTi1WEkq/66QUXizF9
 Nk7f3uws5U8UUilcQlRGGHLD5dGHT1JeEKqJyRR7++GiyagoEYvU2EymrJswgXtlEJf3C0HXo16
 LIe9Y8lQSX5fKcQN4JWpksdclGzRuIDWzlnUsUj8BgGSZZWTIAswX2YoJqnIWeIL6bdXPtWIq/z
 Ej4b+6740EcnnUIwcmLgjrJk4s4SbXANDU=
X-Received: by 2002:a17:90b:4cc6:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-38f9bd6e641mr873569a91.5.1785382351458; 
 Wed, 29 Jul 2026 20:32:31 -0700 (PDT)
Received: from localhost ([64.176.39.245]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f9b42d6c8sm273249a91.3.2026.07.29.20.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 20:32:31 -0700 (PDT)
From: David Weber <weber.aulendorf@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, ray.wu@amd.com, dri-devel@lists.freedesktop.org,
 David Weber <weber.aulendorf@gmail.com>
Subject: [PATCH 0/1] drm/amd/display: allow self-refresh exit while entry is
 blocked
Date: Thu, 30 Jul 2026 05:31:59 +0200
Message-ID: <20260730033200.441730-1-weber.aulendorf@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Jul 2026 07:26:00 +0000
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

Hi,

I have a ThinkPad T14s Gen 4 with a Ryzen 5 PRO 7540U and Radeon 740M
(Phoenix1, DCN 3.1.4). Its internal eDP panel advertises PSR version 3,
but the driver configures it for PSR1. This system has experienced
PSR-related instability for a long time.

While testing patches for:
https://gitlab.freedesktop.org/drm/amd/-/work_items/4141

I had the idea of developing a PSR stress test suite to make these
problems easier to reproduce and patches easier to test. Another goal
was to provide a larger test suite that could detect regressions in new
kernel releases.

The project is still experimental and the code needs considerable
cleanup, but if you are interested, its README is available here:
https://gitlab.com/weber.aulendorf/amdgpu-psr-stress/-/blob/psr-coverage-clean/README.md?ref_type=heads

I can now reproduce a flip timeout quite reliably with it.

Branch: psr-coverage-clean

Leave SDDM running, switch to another VT, and run:

  ./quiet_tty.sh; ./freeze-vt-handoff.sh

The script repeatedly switches between the SDDM login screen and a text
console, modifies the console framebuffer, and immediately lets a
direct-KMS program take control of the display.

On Linux 7.2-rc5 with de665f07 ("drm/amd/display: Exit idle
optimizations before programming") applied, the timeout usually occurs
after a few minutes.

dmesg:
https://paste.sh/w_knebDa#uKedDECw3b8aasEdb1YBHHaR

Tail of the stress log:
https://paste.sh/VoRFHrUM#G1MRjBQ97JD9u4TGK_-_SopI

I used Claude Opus 5 and Codex GPT-5.6 SOL extensively to analyze the
failure and develop this patch. With the patch applied, I have not been
able to reproduce the timeout using freeze-vt-handoff.sh.

My understanding of the AMD display code is limited, so careful review
of the analysis and fix would be particularly welcome. I have tested
the resulting behavior on this system.

I am not yet convinced that I can maintain the stress suite as a side
project: it is very time-consuming, and I only have one system on which
to develop and test it. However, some of its ideas might still be useful
for future IGT tests.

David Weber (1):
  drm/amd/display: allow self-refresh exit while entry is blocked

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.54.0
