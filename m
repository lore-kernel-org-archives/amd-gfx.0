Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69091C07E97
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 04:09:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B56DF10E7B2;
	Fri,  1 Dec 2023 04:09:30 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE24A10E78A
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 00:30:45 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-28655c04da3so244944a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 16:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701390645; x=1701995445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=caGgQN2zt8grZs3U0xbayh8pbJ7WuHPF2boIZk41q/I=;
 b=PVsgq7xg7O0VYcEFVJXNMbwgGpx0aauuLWi68lzYw0XkOjcZK+rIrPp1kZsW69dUs+
 G6JtiNb7i5kcPvNVjieEjrgBQfs2rsxgBSrZ1xVbNgZO+KkH4VbYJ7pjNcLjq5pTE8NH
 w7nOioAUmhW7LJX7NFx41kUOg+hUS1VuCWrlTQUmN1vPDv0jyoVV9QdpCGVTIOcnga1p
 C9+O+u2OsELowW6qgaDnco/bHUW2fnrwv6RS5NBHCZKdUjcdQ/aNACnqtZwwy+u/zh8e
 qHTI9gX8EJXgPVngYuwkRG1M4Rjuohp9lYDS/UZOck1gen7uAY426D5F/l6XxyIGOX0o
 AHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701390645; x=1701995445;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=caGgQN2zt8grZs3U0xbayh8pbJ7WuHPF2boIZk41q/I=;
 b=IrEsxSow8ytDe5+ZDSZjztBpd43L7y21qSdrVO27sbm7HtTwmI3ITA70Xe9L5FfXJ7
 kxvbYvJ9CCCOHZxYiaYtGov8pQOXmphpY1t2d5Oxb4HfnWH1mbFDuoNfBdND9XQ9IP7K
 NIyjKRmD590lYNNwac0ql+lQztEo8m7iKxw0krD3Szq8Z21M/xLfiKP2PdGpNFwnAVwY
 yGsfUhMkD+uEywhYioylQx2p9DLdblK5yQhM8VpmvIPZLiOTInMMj7LdDtW2ac309z3m
 2eAUkebA1WXNU0H9oGByxdQw1NawsioMSeWcVNofsRfg4dgKWa3x+RpR7K6BrTSBKxeS
 fv2Q==
X-Gm-Message-State: AOJu0Yz9c7A4wI2sMIox7zwXPyH42Vt4rvmZkKBr57zU23xrZOWtuom7
 AyKF+fuq6gBNlBWT6NAS00Ennhp3yog28w==
X-Google-Smtp-Source: AGHT+IGavLSgfLIFqgzeRpJJkSpkkqVUuQDRKrB/Bufnp+gm00i5dOUOGGZIZ3Pf4HupAYvGp4kBGg==
X-Received: by 2002:a17:90a:62cb:b0:286:4827:807d with SMTP id
 k11-20020a17090a62cb00b002864827807dmr3313646pjs.23.1701390645269; 
 Thu, 30 Nov 2023 16:30:45 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
 by smtp.gmail.com with ESMTPSA id
 c12-20020a17090a020c00b0028089fdce19sm2092716pjc.52.2023.11.30.16.30.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Nov 2023 16:30:44 -0800 (PST)
Message-ID: <8da256ea-b069-44f0-9cc2-93482c2f5eec@gmail.com>
Date: Fri, 1 Dec 2023 07:30:40 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>
From: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Thinkpad X13 AMD: Problems with external monitor wake up after
 suspend
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 01 Dec 2023 04:09:00 +0000
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
Cc: Stylon Wang <stylon.wang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Oliver Schmidt <oliver@luced.de>,
 Wayne Lin <wayne.lin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Since kernel version 6.1.57 I have problems with external monitor wakeup after suspend on Thinkpad X13 AMD Gen2 Notebook.
> 
> Notebook is in docking station with closed lid. Suspend & Resume. The external monitor gets no signal. After randomly typing Ctrl+Alt+Fn for switchung consoles, the monitor at some point gets signal and is usable again.
> 
> It worked with kernel 6.1.56.
> 
> I managed to compile a 6.1.57 kernel and also a 6.1.64 kernel by reverting the changes from commit ec5fa9 "drm/amd/display: Adjust the MST resume flow" (https://github.com/torvalds/linux/commit/ec5fa9fcdeca69edf7dab5ca3b2e0ceb1c08fe9a?diff=split&w=1?diff=split&w=1) and with this suspend & resume worked like before without any problems.
> 
> I reported this also to the Manjaro's support forum, since I tried this on Manjaro Linux (https://forum.manjaro.org/t/problems-with-external-monitor-wake-up-after-suspend/151840).

See Bugzilla for the full thread.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: ec5fa9fcdeca69 https://bugzilla.kernel.org/show_bug.cgi?id=218211
#regzbot title: MST resume flow adjustment breaks external monitor wakeup after suspend on Thinkpad X13
#regzbot link: https://forum.manjaro.org/t/problems-with-external-monitor-wake-up-after-suspend/151840

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218211

-- 
An old man doll... just what I always wanted! - Clara
