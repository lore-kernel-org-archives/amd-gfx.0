Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52721CD98E6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 07:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7FC610E06E;
	Fri, 19 Jun 2026 07:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YaT6AVi+";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08F7010E021
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 04:59:43 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2bf20f6be6bso11755645ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 21:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781845182; x=1782449982; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uIYOjMSuKZhWjcQJw9HHG0dGZKivsExPv7gnoCGT+tQ=;
 b=YaT6AVi+9f216xkkMSloyrfXd2yv2rOUXqgi+P8zRBVk0+w4ZC9ROTtE4DsogKfEbQ
 pA6LULj4lTH0KcazR7uWa6ljhdQnqx+CS/GcQa1gHkK1O0EjEzU5aGNSpcsSjBwm8CNT
 RJU+kdcdGapluRGAu+0ViBsxoS90TEtMXrCfUIH8r3l8cbUbEk1+/vvFc2mHd1XJ1bHe
 O9uOTrO3Z68Fz7hIVRxhp1J7gyFTBXhJ9SPp8ioTfquOR37bq96mXkz+C8YYF+Dtq9mH
 9o0tVwsF0NMbb4Lwn8kcUtguHPQfphhbI8Rc96A65QA8R0NOi3h7kyVEnpztlEuPwthq
 K/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781845182; x=1782449982;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uIYOjMSuKZhWjcQJw9HHG0dGZKivsExPv7gnoCGT+tQ=;
 b=pIDQ4c3LIAcnkVoA5+OZi8zlhkblyJr/IhLGc6mtWJB0UWxXjfKw/ANSajiD2wVn86
 OUIO6JxMpGzZdmmh4sdgPtx1C7R2d3vdR6Le7gf6T6SqRfnXAhJ4YSpjdr+VgcrjbBhs
 3chPzum0ZCS2ciGAd/QiCjwp9Xd1t5fQejV1+84La1mS6vmb/7qLZhOeAVroUbMLuvik
 +Tde0kOMY47Bc3Lx6owlJnq2eLyM4/rC2TRTiNe/3HfiuHEl+MPxPReHneZi0tyqtzW2
 l+zQN0eJenjOscWMjKh6SgBM32Nh8/67NRnVQL4AGMuQjouTWqJX16siCagFIhz0PexH
 KYnA==
X-Gm-Message-State: AOJu0YzWfLeoXJ6nznyiv8mi8ajyFDaQ6i6VLRfQmGUoxZkevWFEkf2F
 4LMGI7dAMbLVRhzMi/S4QXmmMSG4hmrPe72GuamNXR9yPMIoV45w6ymqckkG5/sG
X-Gm-Gg: AfdE7cl4nbwGK6PlmWJXdJz0rJAEwiFiN59NeMXR16Fsd18xMPp9w2SUcZgB+TqK2Ij
 2st3XBl3PD9oeo7AQpOmZyiCmbMMXHm7cb6ijNW5WrRxApNX7n03gO+PtHYLkULhveaB1zXAxDk
 JCeM3EWFiXV69AG5uyB07dg3OKSdcKiz2/G66ePjQpo1aqrf8eXPO6vx/pzrY2JVUkp0fMUPjB0
 rIvguLvyR//IqC7Jbjysh1rYGF075Ia6b/aWQTd/Jb/v3CWb91uTm3Nccbun3m/+EbEyAe8Lwbt
 lJRZFkZEYPJD5fSpa2M3+nyIgHbiowBXqwCGzbh5ZaVO4oz7CoVDgCREsEeN4GkXrxc8NdnCS+Y
 SfrADA+s9P1Klh1gORsCQB35Ta6qx5U96sIA1gFAk51xS+rvCI8J/RLRorzs8+93ouoLZfTaSfC
 b+bkLYiQG4cEeU
X-Received: by 2002:a17:903:22d1:b0:2c0:ab82:6b99 with SMTP id
 d9443c01a7336-2c718fc11b2mr23178225ad.33.1781845182503; 
 Thu, 18 Jun 2026 21:59:42 -0700 (PDT)
Received: from deskarch ([50.47.212.45]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c72089c1cdsm8784255ad.17.2026.06.18.21.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 21:59:42 -0700 (PDT)
From: Charles Munger <charleslmunger@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Charles Munger <charleslmunger@gmail.com>
Subject: [PATCH] drm/amdgpu: Add Paradetech OUI to VRR compat list
Date: Thu, 18 Jun 2026 21:59:04 -0700
Message-ID: <20260619045904.5872-1-charleslmunger@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 19 Jun 2026 07:14:26 +0000
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

There's at least two firmware versions on the CalDigit DP20-HDMI21
adapter, which is powered by the ParadeTech PS196G chip. The first version
has a bug where it incorrectly neglects to set the DOWN_STREAM_PORT_PRESENT
field in the DPCD:

$ sudo dpcd_reg read --offset=0x2205 --count=1 --device=0
0x2205:  00
$ sudo dpcd_reg read --offset=0x0005 --count=1 --device=0
0x0005:  00

The newer one fixes this, and with this patch correctly negotiates VRR.

[~]$ sudo dpcd_reg read --offset=0x5 --count=1 --device=2
0x0005:  1d
[~]$ sudo dpcd_reg read --offset=0x2205 --count=1 --device=2
0x2205:  1d

So if you're using a Paradetech adapter and it doesn't negotiate VRR,
check that it has a firmware that produces the correct DPCD.

Signed-off-by: Charles Munger <charleslmunger@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 6c827e6703a0..f463495d1c87 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1410,6 +1410,7 @@ bool dm_helpers_is_vrr_pcon_allowed(const struct dc_link *link, const struct drm
 	case DP_BRANCH_DEVICE_ID_00E04C:
 	case DP_BRANCH_DEVICE_ID_90CC24:
 	case DP_BRANCH_DEVICE_ID_2B02F0:
+	case DP_BRANCH_DEVICE_ID_001CF8:
 		return true;
 	}
 
-- 
2.54.0

