Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A213ECA0FE8
	for <amd-gfx@archiver.kernel.org>; Sun, 31 Aug 2025 16:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1356110E2FE;
	Sun, 31 Aug 2025 16:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HsYo9YEz";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9F4910E2D1
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 Aug 2025 10:12:09 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b0225483ca0so155716666b.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 Aug 2025 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756635128; x=1757239928; darn=lists.freedesktop.org;
 h=content-transfer-encoding:autocrypt:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yS2sg5kZaA0Vp7mqSBwUoVj3i81Ijlko/a0R7dL57yc=;
 b=HsYo9YEzmXdTNJZ6VaAIEyvkI2FFdrHXb1dA3yjtBIpmQ2wFYJADH0FlVbbyysXdQM
 aoPZw8U/Yiq/IcQlAyzOIxmY2OFu3pZg8ATyXHafeQk4uabBNG79DYqp6fk5kSkcZw/0
 cKrMnh2JARigScyLCGq0vrpcPuPwHBAxiuhW2apDhcvER46PJAw6GwB+s5/WUCqbG19l
 tPtqqYFlQAk/3n4MIV/5gteCP4e1xLWXWLbi1w70C0Yjg9rajWr8tFboU+IV3kBGQCo3
 7HkjGDLJRUE6Xv/DDij4MBiUWivf8BtTlceHuUBnJXuOyTGGG4tYSgP+GgcbOCIkJ37E
 H6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756635128; x=1757239928;
 h=content-transfer-encoding:autocrypt:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yS2sg5kZaA0Vp7mqSBwUoVj3i81Ijlko/a0R7dL57yc=;
 b=Wr6BnriPYv1Z6nr45+XdowmUpgFX+iQaTqcrZb4fgcWRGWPCQbIa0lGeS1OQUDIkJb
 Lvn9VxrfLKXwVOTV9KCcxSeniU3I+vV3CqDwjvjfLUMvoji3cKKtbn3u0uyRujWXbv9k
 uUTeJeHaAJ73GBrvZzKK1Lm56eZWDzoUHwu7ZKwzx/H3qGC45Gpkf7am3kLjgU0scGG9
 O9Bjicys88TUn/1sZPmHCr1+3K1YQmDyMeYX6lA2OHzFb0mDEQQ7XmR4jEsl4btcFq45
 GJxi1ASrrcMsiAeF4TaL0PjtaESjgdESmoGtNNEnJswnY/gBDBiqScPtfYO6sHrWX9my
 qvRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzOtZDsh+JBX2HR8sQyuYe74v7p9wu34IgG9FTsfH0Bxb6EuX3jv1H0ukBLYFgNtEqy7yaEsC1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDhV90wV59VTU81DKflzT+KrE7mbNp2w01wauvydMT42WEkyXs
 7UwSy1CMtErrj/YTQSB1nUxGJEB8txqWIgSdCZkA+gHemmCJMKOVVxsc
X-Gm-Gg: ASbGncsKD/YXQQPyKm6ssFvm3CKJjpo8xr92NqeinptUTJ72cAlSLWWE6itpdaGNOTx
 NEjK78u+IQ+1jSuKegQOVu77lMxUXFEmxaiaVfEnP+HxZ4K33mS0bSFU1JGwAqjiIqhxYIdXTnU
 XSDbChKa0HPntVQeMKApZMlmvy5UENBGtoBs7+qwsYARuDyHoQqVkBLy7iIlD0ImWVOINrT3LGc
 vDeIq8Qx/wjZariSRCWe06HRHHKMhth4ufF0knrmrHZE5fY9c3yWvKvnL7cjgw4vDp4JoKCWIMN
 dPbU4fVLYIyotDk04hZYRb8E+ddrxeaPBJoqVx2kUWngIEX4HZ9gUyAbxJIeRvz2A7PLgANDB+5
 25dR7CvY5qgPyI4ImjA0gQz9Y78+ijnon0VxjAKklTm8MT6ohnso=
X-Google-Smtp-Source: AGHT+IE/2q4Oga+wV9W50QNCCCAzx8LvMjhenNdt2Y6RTRoqABhfZAuS7QDqPCw7WgzMJMiG8Olz3Q==
X-Received: by 2002:a17:906:6a02:b0:b01:8fa4:6bb0 with SMTP id
 a640c23a62f3a-b01d976af68mr395429366b.44.1756635127627; 
 Sun, 31 Aug 2025 03:12:07 -0700 (PDT)
Received: from [192.168.0.20] (89-66-79-203.dynamic.play.pl. [89.66.79.203])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc575b94sm4802916a12.53.2025.08.31.03.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Aug 2025 03:12:07 -0700 (PDT)
Message-ID: <967d5380-1db1-4252-a3b5-cfa283cf960d@gmail.com>
Date: Sun, 31 Aug 2025 12:12:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pl-PL, en-GB-large
To: Harry Wentland <harry.wentland@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
From: =?UTF-8?Q?Przemys=C5=82aw_Kopa?= <prz.kopa@gmail.com>
Subject: [REGRESSION] AMD HDMI/DP audio broken after suspend since commit
 50e0bae34fa6
Autocrypt: addr=prz.kopa@gmail.com; keydata=
 xjMEZbtqRhYJKwYBBAHaRw8BAQdAGojMeKfRebJC5+U3Pk20jCWmOv/wtj0kK+7SRlSeasPN
 JVByemVteXPFgmF3IEtvcGEgPHByei5rb3BhQGdtYWlsLmNvbT7CkwQTFgoAOxYhBDwLVsMk
 0R41tYJQaRDBtFqhE5HJBQJlu2pGAhsDBQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJ
 EBDBtFqhE5HJnxgBAJ2HbntRTvOAMMDWU0h0Gu8Vxn4MMuyKivIcYXX/mXTlAQCE8c1I1bVI
 5ottwyoAcQIYZz8JhiZu/PMW3YID7iMtD844BGW7akYSCisGAQQBl1UBBQEBB0BfitF05Bez
 rVGUMKVNceXhQOEAzBYPQG2t09xWbwuAWQMBCAfCeAQYFgoAIBYhBDwLVsMk0R41tYJQaRDB
 tFqhE5HJBQJlu2pGAhsMAAoJEBDBtFqhE5HJ9YcA/i/SOJkwwYoWJp+sKFOcrPZSVMPvQ9ry
 wk5oemiTzoJVAP0dYnuEMP3N7zP1I5XkS1TToezcTX5Pc/ytafL+1js+Bw==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 Aug 2025 16:00:11 +0000
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

Hello,

I'm running Radeon RX 9060 XT and since upgrading to the kernel 6.15 I'm
facing an issue with audio via DisplayPort. After waking from S3 suspend
(sometimes, but not always) audio doesn't work - pavucontrol shows that
the output is disconnected and I don't get sound from my display. If I
manually reselect the Digital/HDMI output in pavucontrol after resume,
sound starts working again. Besides my main screen, GPU is also
connected (via HDMI) to a TV set - I've found out that this issue occurs
more often if the TV is on (not displaying output from GPU) when I put
my PC to sleep and I turn the TV off before resuming PC.

The issue persists on the current mainline kernel (6.17-rc3).

I've bisected it and this is the commit that introduced the issue:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=50e0bae34fa6b8b18e13473ddf0bcdab6ab68310

I've also found a similar report on the alsa mailing list:
https://lore.kernel.org/alsa-devel/1855350181c58300-webhooks-bot@alsa-project.org/

I'm running Arch Linux with pipewire and wireplumber. The following is
an excerpt from the WirePlumber log after bad resume:

D spa.alsa [alsa-util.c:1996:pa_alsa_get_hdmi_eld]: ELD info empty (for device=7)
I spa.alsa [alsa-acp-device.c:893:card_props_changed]: card properties changed
D spa.alsa [acp.c:760:report_jack_state]: Jack 'HDMI/DP,pcm=7 Jack' is now unplugged
I spa.alsa [alsa-acp-device.c:975:card_port_available]: card port hdmi-output-1 available yes -> no
I spa.alsa [acp.c:702:profile_set_available]: Profile output:hdmi-stereo-extra1 available yes -> no
I spa.alsa [alsa-acp-device.c:941:card_profile_available]: card profile output:hdmi-stereo-extra1 available yes -> no

Please let me know what additional information I might provide to
pinpoint this issue.

Thanks,
Przemysław Kopa

