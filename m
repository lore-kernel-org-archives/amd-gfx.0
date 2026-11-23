Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E2606A331
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m4RSK8za
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7949310F35D;
	Tue, 24 Nov 2026 08:40:21 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A42C10EFB4
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 16:26:41 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5c14f7768acso2822049e87.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 08:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795451199; x=1796055999; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=B0Ks8vaqzAFxKNvJKolZuLwofGRXjUyWCRFWX2q+/Gg=;
 b=m4RSK8zawUmobn84rN+rqwJsQ2mVDpODz8nVSTdD7erVicxQokziMuxFS36wXgnNZr
 Zv4CgDiupdBINoOUF+0jEAdcbhncZyyzobIz8RlpTf9r9P0WLPxMQXMEWaofppjv7MYt
 3LQW9ylxB3F49riPEryeAlScBGLino33zPDSv5cf9ZD7nOf89++sQWMl8sIEszx15cw/
 8izAWW0GeWje4vBFTYnA5kvs+Ce7N5nO8VPS0g+ECbt4X5R2UjPGPNffiqS+ZN9AJh8d
 gRzR2nUcFhrNI/Q+oqUzXLGZkt9wxmzd9RDelef+Rlw/ONytUZyeNWC6tAEq4XyPR35J
 nN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795451199; x=1796055999;
 h=content-transfer-encoding:content-type:subject:from:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B0Ks8vaqzAFxKNvJKolZuLwofGRXjUyWCRFWX2q+/Gg=;
 b=il5j9cyepAhzjG2/kdGRjZOIV2E6ziqJ1zZnZbOEQBem/xpynuN8S0+74H9ciBlf2G
 ARtcYoT486ciV9vEygzd80xxv34/IQ1VN+WjdJXxoqxBl2745Xjmup90owfBhXOvykI+
 pZZZuTw2YIghCCJ3ewk/rWlyiRnK2Od8HgkfOSIhTVlIf8djY86wPY4g298raUvhAo2K
 ph2Uy3bxvi0Fwl4uWPEQB/hr0R/tkIFP+DrgeV8XO5S56hCvOvvinmGbMGyB7MahlrV+
 qOVuk3/TpPissmGJBKTV7U2uBekNcry8Fe2MkxtDexQutEaSNI14hsF5mrvg0ZZg0BeX
 sgUg==
X-Gm-Message-State: APuU4Z8trZx1zyeOGyc6PIAIpWzhnwmQFEcJDYgXD+D+N1yoUP7Fm0hf
 SMmK1s+ZOdwBe8uD4aX1CljYv5StAUNrR4k4MY9JSij0Nk8gLtCk6lWGnKrgjA==
X-Gm-Gg: AZFdTZcQioQrBuPmfjBHRyCg6deIsfzB1ulXwTYlFzXYLuSRFERyZnr8f8lYYtHPLP6
 jzpUBWhC2ecsqM6AgUaZKzdM9HQmP1PE+VWMtXWBul2Omvw0UWJlJwXEukBGJuDI5cIIOxKgM/2
 na+Qbca29qtPFuWMc04CndrpV35WV6IaYilH1leLV1MYiqJQMvpjdkGTLQZd7dnN7zW0l8DoOFg
 R6SbpngWvKcj1TgdYNvETxBwiKirEEgpvggu+sUCIITQLF0IfDMsUcRlSgzAqIrIfrSTQ1FL9HZ
 K6XE9XpCAq2cniEW+uf8zmwFSMqAcLpzqgsKjl5ynEEoC+kc9o16oG5RYhKx9No32jXlPmdBBRS
 maj3N0IRl+Mp2LrhZ4hCqlGQb1nf/MSBlNfmijBvOCM35cn+t8JJj96SB3SYgT0EoMdF8V+CON3
 mi+zivhKY510qdpCbTMYOFR2fZeWcY7IUPboJ/Ss79emUICapR3w9PatdHFEm4DZ9gFZsm3uamd
 pcrq6Fg2iRn5wO/JeNNzAQNMl1mVbZnYnKQ21yLeL7q/PY5VMX8qFojYfbS2Voqtw4peH9WpAnC
 40ePHwYamZ23ZFA0T9b1XIeTawxuj9BLjt2cDs+/BWsgGBysgNJkqnJTC4NOR3Fc5qEQm9BpPg=
 =
X-Received: by 2002:a05:6512:23a0:b0:5bc:ca83:1fc0 with SMTP id
 2adb3069b0e04-5c1bc84e614mr3313430e87.60.1795451198778; 
 Mon, 23 Nov 2026 08:26:38 -0800 (PST)
Received: from [192.168.1.2] (85-253-172-224.ip.elisa.ee. [85.253.172.224])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1bd07a390sm3080549e87.77.2026.11.23.08.26.38
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 08:26:38 -0800 (PST)
Message-ID: <fe3a7c6f-5365-4a18-b9d2-f77b003c1145@gmail.com>
Date: Mon, 23 Nov 2026 18:26:37 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
From: Oleksandr Mikriukov <mikriukov.oleksandr@gmail.com>
Subject: [PATCH] drm/amd/display: Add DP power-up delay quirk for LG
 SMARTGAME+ (32G810SA)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:40:19 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The LG 32G810SA-WB only starts answering AUX about 2 seconds after
leaving D3.  With the default four 8b/10b link-training attempts
(4 x 50 ms, ~1 s total) the driver gives up while the sink is still
waking, logs "enabling link 1 failed: 15" and the compositor drops the
output; the display then stays black after a DPMS wake until it is
power-cycled on its own panel.

A second stream enable a moment later trains fine, so this is a timing
race against the sink's wake-up latency.  The EDID quirk table already
carries a multi-second delay for another panel, so reuse
dc_panel_patch.dppowerup_delay for this sink.

Reported and diagnosed in:
https://gitlab.freedesktop.org/drm/amd/-/work_items/6193

Signed-off-by: Oleksandr Mikriukov <mikriukov.oleksandr@gmail.com>
---
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -112,2 +112,13 @@
 		break;
+	/* LG SMARTGAME+ (32G810SA-WB): the DP receiver answers AUX only
+	 * ~2 s after leaving D3; with four 8b/10b retries (~1 s) link
+	 * training gives up while the sink is still waking, the
+	 * connector is reported disconnected and the output stays black.
+	 */
+	case drm_edid_encode_panel_id('G', 'S', 'M', 0x77dd):
+		drm_dbg_driver(dev,
+			       "Add 2s DP power-up delay for panel id %X\n",
+			       panel_id);
+		edid_caps->panel_patch.dppowerup_delay = 2000;
+		break;
 	/* Workaround for some monitors which does not work well with FAMS */
