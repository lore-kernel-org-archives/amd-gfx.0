Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339E5C636D3
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 08:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F240F10EC8B;
	Fri, 10 Feb 2023 08:04:07 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B9D10EC55
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 04:50:28 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id n2so2772140pfo.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Feb 2023 20:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zqShi3EgLDtgztLIgW/MuPsWv2vSLPgVWXrp/LobXww=;
 b=Om+u/6VnAJG9TE8AtmP7qvhlFAe++DibsHxfnKB/uw1rT0M0wwXXptoFr0Xv+20ydo
 eakNNTYlCCk2g+ALxRE6kmjCfzNbNOYJFbMBHqWvHvIm2k/uZfv6KIo0xugx3nQig2py
 J1no3BHk6c8ezYo6oWs4KfkhLQOu7YRb0G1aFzEpM6YreNPESvbQ4vwbkdQg1ll66Mfa
 qmCJAD9lIdQ09n5BrE3kzDSLu8s0jx5ZJ2hqM233WpFqKrLUDc8SXFgEQ8iWwYwFo7zR
 SkcsIvSD7qiSPHhO2o5OR47wO55x0ECXZiVlRFfBnNKUyj1V+gZQOOhi2rAshPHtOKDE
 yP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zqShi3EgLDtgztLIgW/MuPsWv2vSLPgVWXrp/LobXww=;
 b=l/7SdRGyT1WLdts6F42nApka5teDhLLgSNhdxUNKgpVGvZx37Ym3kVQxkJD1Q04Vdz
 qYqwFZBv8ba+a7YK6xg3+l+8Dd6QZLJaEUr9L+cHsEV7cwMSbSUOyhUtkb9oPe3++3B9
 L72LcRCVsOYyuVrGZARZZGSsrv9OESxteMhJJkulnA3nG6LRsfO18xH+u69GW5aSiYth
 wnNEqroTt3/0MTDFfpkWx+8lj8ygal90zkI+WvyZZDy3Oq+cQWxCDRSUi+Tu9PwbRcYC
 EKAIDNkT9WdJZaS1LBL3sTHkY8juzveSmdpQutmSR7R6vlRvW3Lb3RZTYzjeIbF5ws3k
 y5lQ==
X-Gm-Message-State: AO0yUKViwfG4TarQWnvlDRBNz8rtYlAE6G1p9VXpoLEe4pAdjHER8Vyg
 SWk6kgOXPWkYxsYi60yXe9I=
X-Google-Smtp-Source: AK7set//ZS0OEdNcYuTp0DRJ59S0YHaU7AVoVK7clC6F+urpcBjbK1/I7g8ZJg3rnX+smO5B0TtQfg==
X-Received: by 2002:a62:6458:0:b0:5a8:6bb7:5fc5 with SMTP id
 y85-20020a626458000000b005a86bb75fc5mr1170747pfb.19.1676004628485; 
 Thu, 09 Feb 2023 20:50:28 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a62ea0d000000b0057fec210d33sm2269218pfh.152.2023.02.09.20.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Feb 2023 20:50:28 -0800 (PST)
From: Orlando Chamberlain <orlandoch.dev@gmail.com>
To: platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [RFC PATCH 3/9] apple-gmux: use first bit to check switch state
Date: Fri, 10 Feb 2023 15:48:20 +1100
Message-Id: <20230210044826.9834-4-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210044826.9834-1-orlandoch.dev@gmail.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Feb 2023 08:04:04 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Rander Wang <rander.wang@intel.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Evan Quan <evan.quan@amd.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Yong Zhi <yong.zhi@intel.com>, Aun-Ali Zaidi <admin@kodeit.net>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Bokun Zhang <Bokun.Zhang@amd.com>,
 Orlando Chamberlain <orlandoch.dev@gmail.com>,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Kerem Karabay <kekrby@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Jack Xiao <Jack.Xiao@amd.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 Takashi Iwai <tiwai@suse.com>, Aditya Garg <gargaditya08@live.com>,
 Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On T2 Macs with MMIO gmux, when GMUX_PORT_SWITCH_DISPLAY is read, it can
have values of 2, 3, 4, and 5. Odd values correspond to the discrete gpu,
and even values correspond to the integrated gpu. The current logic is
that only 2 corresponds to IGD, but this doesn't work for T2 Macs.
Instead, check the first bit to determine the connected gpu.

As T2 Macs with gmux only can switch the internal display, it is
untested if this change (or a similar change) would be applicable
to GMUX_PORT_SWITCH_DDC and GMUX_PORT_SWITCH_EXTERNAL.

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 67628104f31a..6109f4c2867c 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -332,10 +332,10 @@ static void gmux_read_switch_state(struct apple_gmux_data *gmux_data)
 	else
 		gmux_data->switch_state_ddc = VGA_SWITCHEROO_DIS;
 
-	if (gmux_read8(gmux_data, GMUX_PORT_SWITCH_DISPLAY) == 2)
-		gmux_data->switch_state_display = VGA_SWITCHEROO_IGD;
-	else
+	if (gmux_read8(gmux_data, GMUX_PORT_SWITCH_DISPLAY) & 1)
 		gmux_data->switch_state_display = VGA_SWITCHEROO_DIS;
+	else
+		gmux_data->switch_state_display = VGA_SWITCHEROO_IGD;
 
 	if (gmux_read8(gmux_data, GMUX_PORT_SWITCH_EXTERNAL) == 2)
 		gmux_data->switch_state_external = VGA_SWITCHEROO_IGD;
-- 
2.39.1

