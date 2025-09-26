Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2467FCAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2E7610E4CD;
	Fri, 26 Sep 2025 18:26:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b28VS7z+";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2B8E10E4CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:26:26 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-77f169d8153so2557592b3a.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758911186; x=1759515986; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AeeeiZm6S7OBoIq3XInavCs+0ah/l9IKm+5s+ltc1rw=;
 b=b28VS7z+pfwuFJ1fydimgdPhXrH7O+JWbggwKkcLAlpqkNjdBSDgLudefROTjhyQAl
 gN3jrOqJzmZSxGJ4E2NcyTg2q9s5EtYgrE93uEdtXPmIRwSLMOLMdlXCGBuZAM8mmfk3
 iyRkDmRyIywJIwnxDf15b+okOL25cjFlmmj7sr6nZ27qdVzlF315X4zD5G59MrjB+0B0
 kZq8EJXj12/5QUBiIoHldg9Cit3ESLHzrbiOFZ0sCADdsyHDqPBTpGZzVlOPTClmEZas
 UP44AOFI+wSIa4R6WG8YaAy9lFEs7qQVg2ER5OR3j4mtxHXrLf/UB0lrzR/gmmlUR9/q
 i68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758911186; x=1759515986;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AeeeiZm6S7OBoIq3XInavCs+0ah/l9IKm+5s+ltc1rw=;
 b=fIW29sL9vb2RpHqoqqMxiEM6AAnHHgfomciSV3kh/rU4DVuVEToLJLZ1KlBZZK55Lw
 wYXFeD7IoM+5GAQx8VkcjWq34WPnR8QL3BthN5SBXBEkOAKaP2AmJdlrMskB3mRa2Zds
 dASViPdX2Ipi5pmvo6jBNUJExZuWZEhUU7sNULBjFyaXCeNwBrbBG/fwk/N6VwKURqoa
 cMEuPxJDrEF5QTgoAj2QF7hukwfeXHqUirJYzuvZ59x8UyAHlC3D9Bd9MT3vJThpTiFc
 KenUJETkwt/uDe3vvVCtvgQZfqfKcSPfCKf/N0h3N2ad9V4M3mPJl2x+/+VZDU/C7Mvn
 VJIA==
X-Gm-Message-State: AOJu0Yzdjd2jbXuIVIGoCs06lbNeFgWkJ7jof5aGSXcBP2rGJfM3UOjL
 HyQrCBVqd/Z8lp1XF+6croDE+fcm/GW3HiZMa209g1XfOl/TSDOq2l6dKec+QCw4
X-Gm-Gg: ASbGnctqz/TJrrCr0BB9L3u/FhmtrtLD0wkEVrtDWxLvLfAzBSh8Gi2aftHdzggwfLl
 YTjFAQ68+8IelbL3WlbanJ/LQr7DfmEImSYIrHA5WooWswz/HAdrDuzDUjdVvF9uvu7qK7FnWiD
 U1h+URok4z0CEWE4TBrVZGjCJojqu54VEF5OqKfHcnEAqb1143elRIXB05UeN4iRUwd+QGJMuz/
 KUfPAHkTUWuRiE/2og8ugGi2W650OoojxTY+Itaa3QSXQDy89ihI54A9Ib9Y6IwAfPQy3D5Gjjw
 0J6Kwgnog91XSnr3dPk+Jw7+oQzNR3Os/KR1sfrjJL/0Nn6lWex7VF174iul3F8PJmyQ35qKMkn
 2WgGooEKhbdtOj85zzFyKiS4UvaGn0fvZ5mo5hWdwW958zcHyfCtvSMAgaW/uOsxYAxYJDRZTEs
 x6qVQHU1kWhxA/q56ax0GaL+QV4aOGRg==
X-Google-Smtp-Source: AGHT+IGh8rHpbFj57mhB/9splrjcdtOuP6kXOGGXLJrnhzKCLMqdEY26YhmMhw6+u5bafOOjCOFa0Q==
X-Received: by 2002:a05:6a20:734e:b0:2c6:cdcc:5dd2 with SMTP id
 adf61e73a8af0-2e7be80995fmr10954571637.11.1758911186215; 
 Fri, 26 Sep 2025 11:26:26 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb255sm5352131a12.5.2025.09.26.11.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:26:25 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/3] More SI power management and PLL fixes
Date: Fri, 26 Sep 2025 20:26:11 +0200
Message-ID: <20250926182614.26629-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
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

This series has a few minor patches to address some SI issues.

When a 4K 60Hz display is connected to Tahiti or Pitcairn
there is a slight flickering near the bottom of the display.
Disabling MCLK switching fixes that.
(Other SI parts are likely affected too, but I didn't test
them thoroughly enough to say.)

When enabling ASPM on Zen 4 with Tahiti and Oland,
there are random hangs when the GPU usage is low.
Disabling ASPM fixes that.
At the moment I don't know if this is a platform-specific or
GPU-specific issue and I don't think we can reasonably
determine that without spending more time than we have.
(Other SI parts may be affected, but I didn't test them
for a long enough time to judge that.)

Finally, there is a DC patch to change the minimum PLL
dividers to the same value as the legacy non-DC display code.
This doesn't fix any visible issue but I think it's still
good to have just in case.

Timur Kristóf (3):
  drm/amd/pm: Disable MCLK switching on SI at high pixel clocks
  drm/amd: Disable ASPM on SI
  drm/amd/display: Set stricter clock dividers on DCE 6-10

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c            | 7 +++++++
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 7 +++++++
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c            | 5 +++++
 3 files changed, 19 insertions(+)

-- 
2.51.0

