Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DC8CD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 13:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77F5E10E2FF;
	Mon, 18 May 2026 13:01:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l73z4DeQ";
	dkim-atps=neutral
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5278D10E6F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 08:08:49 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-4042fe53946so706665fac.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 01:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779091728; x=1779696528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+QLmDk5oLv8YlQxU58cLUijUUkaHidAoC22pfi4gEsY=;
 b=l73z4DeQgESN4Q54BEO4YFJMfG63zacncp7RtD6d9w7ekHWkAULVkUNUlQ2B17/gHJ
 vwcXm8uhh07rvA5ZOx0Jauiyw2se67kH+VO6VL+gSkqEbYCZyByC9TQEH81hQaFZR5ex
 HVnXGS0qT/6Qy185XvV2zrD5CVJg5Zo5FKCgIwwJEztGbsUYN/Foi/zUwBxlNlwlVSXI
 J6rj+GeDLhFn1aCOfOTtUw8vu7WgTLVkHvHmaLtDFoPVgYHR9F+iQJmXcetbcgyNHEWm
 FpeOJhrNKIkmXroDOjiVzTcJ8tIUzFttnOGQiduPO8E0kutnU4Zxe2U60gfu0X+h8xaQ
 31fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779091728; x=1779696528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+QLmDk5oLv8YlQxU58cLUijUUkaHidAoC22pfi4gEsY=;
 b=Xy1oDl3m4lV/W/aDWaML284CKozpZTz8wNWb7V2cRacK/xpflILAjUEx9eUcxjxvBj
 dFj+sp9CI5h7I2Rx+PxXK1BogZdYJvHrwsttncvpkYkrufj0ICOHr8WKm17sUMms8CHv
 S6cL1wZ45e2IGmxeD/6CycDQKP81ysq5y34gpit1kalQU/e/7xtUpRV/D/X8MgrAoMzm
 rcnM9TD5qk/FTGRHUNsm+uLniuHxmZoGOiLMqpyDGCB/xTjsV6t/J5QyrAne5SVNzF+a
 rBIzWaAeImIa1Bvm2ltUOPGA+rWt3T/9MszoG6ThIAx5LmbNqD5Z1NtFHk3+9Odby8uc
 Fqsg==
X-Gm-Message-State: AOJu0YxbxQZQZbhJsyIughrtH1MQqtXv0FlVxXLuxCZ2gBVYi0u3qiNf
 XjpT9SeoefsYUpdVrTfIj27NIX52jBmCTGHngxW7z98Ha0dHOqMFlex0
X-Gm-Gg: Acq92OHJs0/FHD6IwBRHyD9vwJT3VjOsPqCb2nMbzGe9qbjG8tfpYAmN6ct1b2HnQjw
 FMNyFIegO5NJsmjKbDlHrGCfGDvcQ/kEKrhn00mUUI2ZvEWbf6lJWM4R/66R85w7XLnkb3ZEuon
 6wLx4s1Y6EGR+8e01oWA9/kh2jiNf0/VBwtbUC8VhvJ8WyE36o3HsLxDIPSP4lzzq3IqeJkeaza
 ZrCw8dULw63H7OLROsyuJGLWcjMTLNAQVvX5Nq/X9IfinzKPBhsfD9wT3Ad1yulVJFfV4GTg1gV
 0hjT7ZKLlZ+qh8HcJSGen5j/szMtyqp6AS3VZTqxSZ5sDN8A5eHc7z+7A0wuMUslXsQrPVHovFj
 +Bg1DwbNZEJ83jJi84XIlLW9H3M2NRkeVfb+RV7V71wMNqgV8qiQn0qPZLSWhDZGOk9xCfqkcJw
 3sGmdrLRI8PYBer0A=
X-Received: by 2002:a05:6871:b21:b0:42f:cd67:2b84 with SMTP id
 586e51a60fabf-43a2d9cb7damr8743171fac.9.1779091728336; 
 Mon, 18 May 2026 01:08:48 -0700 (PDT)
Received: from houminxi ([72.244.37.221]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a957b84fdsm3602215fac.18.2026.05.18.01.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 01:08:46 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: jwollrath@web.de
Cc: amd-gfx@lists.freedesktop.org,
	Minxi Hou <houminxi@gmail.com>
Subject: Re: 7.0-rc4 dcn31_program_compbuf_size trace
Date: Mon, 18 May 2026 16:08:35 +0800
Message-ID: <20260518080835.100682-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260316094232.6bb6f0bf@schienar>
References: <20260316094232.6bb6f0bf@schienar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 May 2026 13:01:46 +0000
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

On Mon, 16 Mar 2026 09:42:32 +0100, Julian Wollrath wrote:
> when turning the display off via 'xset dpms force off' I observe the
> following warning and trace under 7.0-rc4 with a AMD Ryzen 7 PRO 8840U

I can reproduce the same warning on different hardware with a different
trigger.

Machine: HP Z66 G6 14 (ProBook 4 G1ah), AMD Ryzen 7 H 255 (HawkPoint1),
kernel 7.0.8-200.fc44.x86_64.

Trigger: HDMI hotplug with an external 4K monitor. The Z66's HDMI port
uses a DP-to-HDMI protocol converter with FRL support (dmesg shows
"DP-HDMI FRL PCON supported"). Connecting the monitor at boot causes
the first timeout during initialization; subsequent hotplug events
repeat it at runtime.

The call trace matches yours exactly:
  dcn31_program_compbuf_size line:141
  dcn20_optimize_bandwidth
  dc_commit_state_no_check
  dc_commit_streams
  amdgpu_dm_atomic_commit_tail

Not seen with 6.19.x. CachyOS community bisected this to:

  commit 592c5b80110d5e9e50873b5364818cb6f401e26d
  "drm/amd/display: Migrate HUBBUB register access from hwseq to hubbub component"

One thing I noticed on my setup: the amdgpu driver defaults to
max_bpc=16 for the HDMI connector. With a HDMI 2.0 monitor (BenQ
EL2870U, Max TMDS 340 MHz) at 4K@60Hz, the higher color depth
increases bandwidth demand during compbuf reprogramming and makes the
timeout happen more often. Adding amdgpu.deep_color=0 helps but does
not fix the root cause.

Partial workaround:
  amdgpu.runpm=0 amdgpu.gfx_off=0 amdgpu.deep_color=0

A patch proposed by Giuseppe Ranieri in the CachyOS issue tracker [1]
changes the REG_WAIT parameters from 1us*100 to 1000us*30 and resolves
the warning for several users with DCN 3.1 hardware. Discussion there
is ongoing about whether 2-10us*1000 would be a better fit.

[1] https://github.com/CachyOS/linux-cachyos/issues/810

Minxi Hou
