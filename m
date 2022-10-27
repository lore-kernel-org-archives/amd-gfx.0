Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BEAFA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 21:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A4D410E702;
	Thu, 27 Oct 2022 21:53:53 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A99E010E6B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 17:47:48 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id w14so3480816wru.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 10:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NaWWPRvCAyMPCfX4/Y0ERaqvsjaXA9ScF5AnTZAlR9I=;
 b=pRXXo2G60j2qt6Ghzp9dqqRMD+1pmSqhVGCDAEO/r49+NkTJqlf+8e2w5HaS7RH0/m
 U/0FAABHVlFgzkUGn6vBXoCiKJGsGT6ulYizp9KD1RIAeQ58SwDw+Z8hjG7lk8Cr8lhn
 kFbi24IW6OlqG0M/AnhXEA5edBQ7YPkQw8tZYO83c/FCB2waqkU/Lc7QGofQs16cygLH
 KmnTXjNBPVkcX+kf5DSh5CPSlh1/bOVUsJYc0R3O9raGsVuXfRaBmHi1r2p5+x51WVU6
 95iSgJL3mL7F0pFt2ayh7SSBZj3zmI94uFsTvz8zEn8fECx6ol4W2eBWZxMVfZ5hm0ia
 1swQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NaWWPRvCAyMPCfX4/Y0ERaqvsjaXA9ScF5AnTZAlR9I=;
 b=fvlTuFY8E8cSWMooOp1WcRV4w/G/J3tFA/OoMEDb2J8WM9Q58jMk4d2R3vB9g9Bzn0
 +pNj52HxJRP9T7RcqFBXHN3VFi2tF9bsGEWeeZbO08+TYn0ql8bgSsHHGfbs+7oZbQE7
 zdqLafPziaknDrTncaXaQZdtYTMafusqV6OVddw+LEDOw2yEaVfB3OotCh+wAqijdBoV
 xc7nP0HTqa6MUiYGSpjGdgoAGjwxhdLNGt1oYiXMZpYxHy0atyLisfW0gVshhSicIfTd
 4A0TnaO677kH2RZZ3luO5ng1ZvGB3hBEQGmVDR4M9hSvQhcWkNJd3KaMxRHe5ITWgRFY
 /SNA==
X-Gm-Message-State: ACrzQf0tK4s5HV7ronWuZVpjaM5GgK3CwwRcK31sBuINSKT3c094I3HK
 rrzDfThiwiyOYbi/RTfP1go=
X-Google-Smtp-Source: AMsMyM6vHFdWS2nw9FDnpXVO9vXvFE6RoHSKW2FlgvM9Q4iCeH4q92V86UEZpu6CO2CyZ+oNJobH/A==
X-Received: by 2002:a05:6000:1c17:b0:236:547e:df7e with SMTP id
 ba23-20020a0560001c1700b00236547edf7emr22944470wrb.134.1666892866131; 
 Thu, 27 Oct 2022 10:47:46 -0700 (PDT)
Received: from ?IPV6:2a02:908:4f6:d280::9a6? ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a05600000c800b002305cfb9f3dsm1543662wrx.89.2022.10.27.10.47.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Oct 2022 10:47:45 -0700 (PDT)
Message-ID: <45242561-3f34-cadc-77db-9f857ab92f53@gmail.com>
Date: Thu, 27 Oct 2022 19:47:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RESEND 1/1] drm/amd/display: add DCN support for ARM64
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Arnd Bergmann
 <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20221027002528.15983-1-hacc1225@gmail.com>
 <20221027002528.15983-2-hacc1225@gmail.com>
 <c41b45cb-8a1a-4140-b7f9-08aa481a25c1@app.fastmail.com>
 <8eb69dfb-ae35-dbf2-3f82-e8cc00e5389a@amd.com>
From: Ao Zhong <hacc1225@gmail.com>
In-Reply-To: <8eb69dfb-ae35-dbf2-3f82-e8cc00e5389a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Oct 2022 21:53:48 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 linux-arm-kernel@lists.infradead.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Here is the output from kms_flip:

IGT-Version: 1.26-NO-GIT (aarch64) (Linux: 6.0.5-gentoo-arm64 aarch64)
Using monotonic timestamps
Starting subtest: nonblocking-read
Subtest nonblocking-read: SUCCESS (0.000s)
Starting subtest: wf_vblank-ts-check
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest A-DP1: SUCCESS (8.475s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest B-DP1: SUCCESS (8.230s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest A-HDMI-A1: SUCCESS (7.932s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest B-HDMI-A1: SUCCESS (7.932s)
Subtest wf_vblank-ts-check: SUCCESS (32.569s)
Starting subtest: 2x-wf_vblank-ts-check
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Expected frametime: 16667us; measured 16666.8us +- 0.447us accuracy 0.01%
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (30.672s)
Subtest 2x-wf_vblank-ts-check: SUCCESS (30.673s)
Starting subtest: blocking-wf_vblank
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.0us +- 0.000us accuracy 0.00%
Dynamic subtest A-DP1: SUCCESS (8.242s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest B-DP1: SUCCESS (8.230s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest A-HDMI-A1: SUCCESS (7.932s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.8us +- 0.447us accuracy 0.01%
Dynamic subtest B-HDMI-A1: SUCCESS (7.932s)
Subtest blocking-wf_vblank: SUCCESS (32.337s)
Starting subtest: 2x-blocking-wf_vblank
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (30.688s)
Subtest 2x-blocking-wf_vblank: SUCCESS (30.689s)
Starting subtest: absolute-wf_vblank
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (7.902s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (7.890s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (7.648s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (7.648s)
Subtest absolute-wf_vblank: SUCCESS (31.090s)
Starting subtest: 2x-absolute-wf_vblank
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (30.389s)
Subtest 2x-absolute-wf_vblank: SUCCESS (30.389s)
Starting subtest: blocking-absolute-wf_vblank
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (7.902s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (7.890s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (7.651s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (7.651s)
Subtest blocking-absolute-wf_vblank: SUCCESS (31.096s)
Starting subtest: 2x-blocking-absolute-wf_vblank
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (30.389s)
Subtest 2x-blocking-absolute-wf_vblank: SUCCESS (30.389s)
Starting subtest: basic-plain-flip
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (0.822s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (0.790s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (0.665s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (0.648s)
Subtest basic-plain-flip: SUCCESS (2.926s)
Starting subtest: 2x-plain-flip
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (2.390s)
Subtest 2x-plain-flip: SUCCESS (2.390s)
Starting subtest: busy-flip
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (0.822s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (0.810s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (0.648s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (0.648s)
Subtest busy-flip: SUCCESS (2.929s)
Starting subtest: 2x-busy-flip
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (1.388s)
Subtest 2x-busy-flip: SUCCESS (1.388s)
Starting subtest: flip-vs-fences
Test requirement not met in function run_test, file ../igt-gpu-tools-1.26/tests/kms_flip.c:1444:
Test requirement: !(flags & TEST_FENCE_STRESS) || gem_available_fences(drm_fd)
Subtest flip-vs-fences: SKIP (0.000s)
Starting subtest: 2x-flip-vs-fences
Test requirement not met in function run_pair, file ../igt-gpu-tools-1.26/tests/kms_flip.c:1499:
Test requirement: !(flags & TEST_FENCE_STRESS) || gem_available_fences(drm_fd)
Subtest 2x-flip-vs-fences: SKIP (0.000s)
Starting subtest: plain-flip-ts-check
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest A-DP1: SUCCESS (8.142s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest B-DP1: SUCCESS (8.150s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.8us +- 0.447us accuracy 0.01%
Dynamic subtest A-HDMI-A1: SUCCESS (7.932s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest B-HDMI-A1: SUCCESS (7.931s)
Subtest plain-flip-ts-check: SUCCESS (32.156s)
Starting subtest: 2x-plain-flip-ts-check
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Expected frametime: 16667us; measured 16666.8us +- 0.447us accuracy 0.01%
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (30.672s)
Subtest 2x-plain-flip-ts-check: SUCCESS (30.672s)
Starting subtest: plain-flip-fb-recreate
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest A-DP1: SUCCESS (8.142s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest B-DP1: SUCCESS (8.130s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest A-HDMI-A1: SUCCESS (7.932s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.447us accuracy 0.01%
Dynamic subtest B-HDMI-A1: SUCCESS (7.931s)
Subtest plain-flip-fb-recreate: SUCCESS (32.136s)
Starting subtest: 2x-plain-flip-fb-recreate
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Expected frametime: 16667us; measured 16666.8us +- 0.447us accuracy 0.01%
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (30.689s)
Subtest 2x-plain-flip-fb-recreate: SUCCESS (30.689s)
Starting subtest: flip-vs-rmfb
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (7.711s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (7.638s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (7.679s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (7.679s)
Subtest flip-vs-rmfb: SUCCESS (30.708s)
Starting subtest: 2x-flip-vs-rmfb
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (30.549s)
Subtest 2x-flip-vs-rmfb: SUCCESS (30.549s)
Starting subtest: basic-flip-vs-dpms
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (0.884s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (0.852s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (0.709s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (0.712s)
Subtest basic-flip-vs-dpms: SUCCESS (3.157s)
Starting subtest: 2x-flip-vs-dpms
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (2.535s)
Subtest 2x-flip-vs-dpms: SUCCESS (2.536s)
Starting subtest: flip-vs-panning
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (7.839s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (7.841s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (7.663s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (7.662s)
Subtest flip-vs-panning: SUCCESS (31.005s)
Starting subtest: 2x-flip-vs-panning
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (30.437s)
Subtest 2x-flip-vs-panning: SUCCESS (30.437s)
Starting subtest: basic-flip-vs-modeset
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (0.865s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (0.872s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (0.658s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (0.658s)
Subtest basic-flip-vs-modeset: SUCCESS (3.054s)
Starting subtest: 2x-flip-vs-modeset
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (2.435s)
Subtest 2x-flip-vs-modeset: SUCCESS (2.435s)
Starting subtest: flip-vs-expired-vblank
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (7.790s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (7.790s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (7.648s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (7.665s)
Subtest flip-vs-expired-vblank: SUCCESS (30.893s)
Starting subtest: 2x-flip-vs-expired-vblank
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (30.388s)
Subtest 2x-flip-vs-expired-vblank: SUCCESS (30.389s)
Starting subtest: flip-vs-absolute-wf_vblank
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.342us accuracy 0.01%
Dynamic subtest A-DP1: SUCCESS (8.242s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.342us accuracy 0.01%
Dynamic subtest B-DP1: SUCCESS (8.230s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.447us accuracy 0.01%
Dynamic subtest A-HDMI-A1: SUCCESS (7.932s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.8us +- 0.447us accuracy 0.01%
Dynamic subtest B-HDMI-A1: SUCCESS (7.931s)
Subtest flip-vs-absolute-wf_vblank: SUCCESS (32.336s)
Starting subtest: 2x-flip-vs-absolute-wf_vblank
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Expected frametime: 16667us; measured 16666.7us +- 0.447us accuracy 0.01%
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (30.689s)
Subtest 2x-flip-vs-absolute-wf_vblank: SUCCESS (30.689s)
Starting subtest: basic-flip-vs-wf_vblank
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.342us accuracy 0.01%
Dynamic subtest A-DP1: SUCCESS (1.242s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest B-DP1: SUCCESS (1.230s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.447us accuracy 0.01%
Dynamic subtest A-HDMI-A1: SUCCESS (0.931s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.447us accuracy 0.01%
Dynamic subtest B-HDMI-A1: SUCCESS (0.931s)
Subtest basic-flip-vs-wf_vblank: SUCCESS (4.335s)
Starting subtest: 2x-flip-vs-wf_vblank
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Expected frametime: 16667us; measured 16666.8us +- 0.447us accuracy 0.01%
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (2.672s)
Subtest 2x-flip-vs-wf_vblank: SUCCESS (2.672s)
Starting subtest: flip-vs-blocking-wf-vblank
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.342us accuracy 0.01%
Dynamic subtest A-DP1: SUCCESS (8.242s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest B-DP1: SUCCESS (8.230s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.447us accuracy 0.01%
Dynamic subtest A-HDMI-A1: SUCCESS (7.935s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.8us +- 0.447us accuracy 0.01%
Dynamic subtest B-HDMI-A1: SUCCESS (7.931s)
Subtest flip-vs-blocking-wf-vblank: SUCCESS (32.339s)
Starting subtest: 2x-flip-vs-blocking-wf-vblank
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Expected frametime: 16667us; measured 16666.7us +- 0.447us accuracy 0.01%
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (30.671s)
Subtest 2x-flip-vs-blocking-wf-vblank: SUCCESS (30.671s)
Starting subtest: flip-vs-modeset-vs-hang
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Test requirement not met in function gem_require_ring, file ../igt-gpu-tools-1.26/lib/ioctl_wrappers.c:1073:
Test requirement: gem_has_ring(fd, ring)
Dynamic subtest A-DP1: SKIP (0.162s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Test requirement not met in function gem_require_ring, file ../igt-gpu-tools-1.26/lib/ioctl_wrappers.c:1073:
Test requirement: gem_has_ring(fd, ring)
Dynamic subtest B-DP1: SKIP (0.582s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Test requirement not met in function gem_require_ring, file ../igt-gpu-tools-1.26/lib/ioctl_wrappers.c:1073:
Test requirement: gem_has_ring(fd, ring)
Dynamic subtest A-HDMI-A1: SKIP (0.249s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Test requirement not met in function gem_require_ring, file ../igt-gpu-tools-1.26/lib/ioctl_wrappers.c:1073:
Test requirement: gem_has_ring(fd, ring)
Dynamic subtest B-HDMI-A1: SKIP (0.153s)
Subtest flip-vs-modeset-vs-hang: SUCCESS (1.146s)
Starting subtest: 2x-flip-vs-modeset-vs-hang
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Test requirement not met in function gem_require_ring, file ../igt-gpu-tools-1.26/lib/ioctl_wrappers.c:1073:
Test requirement: gem_has_ring(fd, ring)
Dynamic subtest AB-DP1-HDMI-A1: SKIP (0.320s)
Subtest 2x-flip-vs-modeset-vs-hang: SUCCESS (0.321s)
Starting subtest: flip-vs-panning-vs-hang
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Test requirement not met in function gem_require_ring, file ../igt-gpu-tools-1.26/lib/ioctl_wrappers.c:1073:
Test requirement: gem_has_ring(fd, ring)
Dynamic subtest A-DP1: SKIP (0.365s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Test requirement not met in function gem_require_ring, file ../igt-gpu-tools-1.26/lib/ioctl_wrappers.c:1073:
Test requirement: gem_has_ring(fd, ring)
Dynamic subtest B-DP1: SKIP (0.582s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Test requirement not met in function gem_require_ring, file ../igt-gpu-tools-1.26/lib/ioctl_wrappers.c:1073:
Test requirement: gem_has_ring(fd, ring)
Dynamic subtest A-HDMI-A1: SKIP (0.232s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Test requirement not met in function gem_require_ring, file ../igt-gpu-tools-1.26/lib/ioctl_wrappers.c:1073:
Test requirement: gem_has_ring(fd, ring)
Dynamic subtest B-HDMI-A1: SKIP (0.153s)
Subtest flip-vs-panning-vs-hang: SUCCESS (1.333s)
Starting subtest: 2x-flip-vs-panning-vs-hang
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Test requirement not met in function gem_require_ring, file ../igt-gpu-tools-1.26/lib/ioctl_wrappers.c:1073:
Test requirement: gem_has_ring(fd, ring)
Dynamic subtest AB-DP1-HDMI-A1: SKIP (0.337s)
Subtest 2x-flip-vs-panning-vs-hang: SUCCESS (0.337s)
Starting subtest: flip-vs-dpms-off-vs-modeset
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (1.573s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (1.354s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (0.641s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (0.642s)
Subtest flip-vs-dpms-off-vs-modeset: SUCCESS (4.210s)
Starting subtest: 2x-flip-vs-dpms-off-vs-modeset
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (1.226s)
Subtest 2x-flip-vs-dpms-off-vs-modeset: SUCCESS (1.226s)
Starting subtest: single-buffer-flip-vs-dpms-off-vs-modeset
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (1.355s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (1.355s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (0.641s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (0.642s)
Subtest single-buffer-flip-vs-dpms-off-vs-modeset: SUCCESS (3.993s)
Starting subtest: 2x-single-buffer-flip-vs-dpms-off-vs-modeset
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (1.226s)
Subtest 2x-single-buffer-flip-vs-dpms-off-vs-modeset: SUCCESS (1.226s)
Starting subtest: dpms-off-confusion
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (7.790s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (7.790s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (7.648s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (7.648s)
Subtest dpms-off-confusion: SUCCESS (30.877s)
Starting subtest: nonexisting-fb
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (0.791s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (0.791s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (0.648s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (0.648s)
Subtest nonexisting-fb: SUCCESS (2.879s)
Starting subtest: 2x-nonexisting-fb
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (0.889s)
Subtest 2x-nonexisting-fb: SUCCESS (0.889s)
Starting subtest: dpms-vs-vblank-race
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest A-DP1: SUCCESS (3.453s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest B-DP1: SUCCESS (3.461s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.8us +- 0.447us accuracy 0.01%
Dynamic subtest A-HDMI-A1: SUCCESS (2.879s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.8us +- 0.447us accuracy 0.01%
Dynamic subtest B-HDMI-A1: SUCCESS (2.880s)
Subtest dpms-vs-vblank-race: SUCCESS (12.674s)
Starting subtest: 2x-dpms-vs-vblank-race
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Expected frametime: 16667us; measured 16666.8us +- 0.447us accuracy 0.01%
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (10.867s)
Subtest 2x-dpms-vs-vblank-race: SUCCESS (10.867s)
Starting subtest: modeset-vs-vblank-race
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.342us accuracy 0.01%
Dynamic subtest A-DP1: SUCCESS (3.361s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest B-DP1: SUCCESS (3.360s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.447us accuracy 0.01%
Dynamic subtest A-HDMI-A1: SUCCESS (3.016s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.8us +- 0.447us accuracy 0.01%
Dynamic subtest B-HDMI-A1: SUCCESS (3.016s)
Subtest modeset-vs-vblank-race: SUCCESS (12.754s)
Starting subtest: 2x-modeset-vs-vblank-race
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Expected frametime: 16667us; measured 16666.8us +- 0.447us accuracy 0.01%
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (10.708s)
Subtest 2x-modeset-vs-vblank-race: SUCCESS (10.708s)
Starting subtest: bo-too-big
Starting dynamic subtest: A-DP1
Stack trace:
Dynamic subtest A-DP1: FAIL (0.003s)
Starting dynamic subtest: B-DP1
Stack trace:
Dynamic subtest B-DP1: FAIL (0.002s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (0.634s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (0.635s)
Subtest bo-too-big: FAIL (1.275s)
Starting subtest: flip-vs-suspend
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Test requirement not met in function suspend_via_rtcwake, file ../igt-gpu-tools-1.26/lib/igt_aux.c:769:
Test requirement: ret == 0
rtcwake test failed with 1
This failure could mean that something is wrong with the rtcwake tool or how your distro is set up.
Dynamic subtest A-DP1: SKIP (0.133s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Stack trace:
Dynamic subtest B-DP1: FAIL (0.542s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Stack trace:
Dynamic subtest A-HDMI-A1: FAIL (0.214s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Stack trace:
Dynamic subtest B-HDMI-A1: FAIL (0.119s)
Subtest flip-vs-suspend: FAIL (1.009s)
Starting subtest: 2x-flip-vs-suspend
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Stack trace:
Dynamic subtest AB-DP1-HDMI-A1: FAIL (0.285s)
Subtest 2x-flip-vs-suspend: FAIL (0.285s)
Starting subtest: wf_vblank-ts-check-interruptible
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Stack trace:
Dynamic subtest A-DP1: FAIL (3.651s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Stack trace:
Dynamic subtest B-DP1: FAIL (3.862s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Stack trace:
Dynamic subtest A-HDMI-A1: FAIL (3.482s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Stack trace:
Dynamic subtest B-HDMI-A1: FAIL (3.386s)
Subtest wf_vblank-ts-check-interruptible: FAIL (14.382s)
Starting subtest: 2x-wf_vblank-ts-check-interruptible
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Stack trace:
Dynamic subtest AB-DP1-HDMI-A1: FAIL (3.537s)
Subtest 2x-wf_vblank-ts-check-interruptible: FAIL (3.537s)
Starting subtest: absolute-wf_vblank-interruptible
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: CRASH (0.326s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (8.300s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (7.648s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (7.648s)
Subtest absolute-wf_vblank-interruptible: SUCCESS (23.924s)
Starting subtest: 2x-absolute-wf_vblank-interruptible
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (30.389s)
Subtest 2x-absolute-wf_vblank-interruptible: SUCCESS (30.389s)
Starting subtest: blocking-absolute-wf_vblank-interruptible
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (7.903s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (7.890s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (7.651s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (7.648s)
Subtest blocking-absolute-wf_vblank-interruptible: SUCCESS (31.093s)
Starting subtest: 2x-blocking-absolute-wf_vblank-interruptible
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (30.389s)
Subtest 2x-blocking-absolute-wf_vblank-interruptible: SUCCESS (30.389s)
Starting subtest: plain-flip-interruptible
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (0.802s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (0.790s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (0.648s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (0.648s)
Subtest plain-flip-interruptible: SUCCESS (2.890s)
Starting subtest: 2x-plain-flip-interruptible
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (2.387s)
Subtest 2x-plain-flip-interruptible: SUCCESS (2.388s)
Starting subtest: flip-vs-fences-interruptible
Test requirement not met in function run_test, file ../igt-gpu-tools-1.26/tests/kms_flip.c:1444:
Test requirement: !(flags & TEST_FENCE_STRESS) || gem_available_fences(drm_fd)
Subtest flip-vs-fences-interruptible: SKIP (0.000s)
Starting subtest: 2x-flip-vs-fences-interruptible
Test requirement not met in function run_pair, file ../igt-gpu-tools-1.26/tests/kms_flip.c:1499:
Test requirement: !(flags & TEST_FENCE_STRESS) || gem_available_fences(drm_fd)
Subtest 2x-flip-vs-fences-interruptible: SKIP (0.000s)
Starting subtest: plain-flip-ts-check-interruptible
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest A-DP1: SUCCESS (8.142s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest B-DP1: SUCCESS (8.130s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest A-HDMI-A1: SUCCESS (7.935s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.447us accuracy 0.01%
Dynamic subtest B-HDMI-A1: SUCCESS (7.931s)
Subtest plain-flip-ts-check-interruptible: SUCCESS (32.140s)
Starting subtest: 2x-plain-flip-ts-check-interruptible
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Expected frametime: 16667us; measured 16666.7us +- 0.447us accuracy 0.01%
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (30.672s)
Subtest 2x-plain-flip-ts-check-interruptible: SUCCESS (30.672s)
Starting subtest: plain-flip-fb-recreate-interruptible
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest A-DP1: SUCCESS (8.142s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.342us accuracy 0.01%
Dynamic subtest B-DP1: SUCCESS (8.130s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest A-HDMI-A1: SUCCESS (7.931s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest B-HDMI-A1: SUCCESS (7.935s)
Subtest plain-flip-fb-recreate-interruptible: SUCCESS (32.140s)
Starting subtest: 2x-plain-flip-fb-recreate-interruptible
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Expected frametime: 16667us; measured 16666.8us +- 0.447us accuracy 0.01%
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (30.689s)
Subtest 2x-plain-flip-fb-recreate-interruptible: SUCCESS (30.689s)
Starting subtest: flip-vs-rmfb-interruptible
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (7.651s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (7.679s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (7.679s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (7.682s)
Subtest flip-vs-rmfb-interruptible: SUCCESS (30.692s)
Starting subtest: 2x-flip-vs-rmfb-interruptible
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (30.242s)
Subtest 2x-flip-vs-rmfb-interruptible: SUCCESS (30.242s)
Starting subtest: flip-vs-panning-interruptible
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (7.852s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (7.840s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (7.662s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (7.662s)
Subtest flip-vs-panning-interruptible: SUCCESS (31.018s)
Starting subtest: 2x-flip-vs-panning-interruptible
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (30.438s)
Subtest 2x-flip-vs-panning-interruptible: SUCCESS (30.438s)
Starting subtest: flip-vs-expired-vblank-interruptible
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (7.802s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (7.790s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (7.648s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (7.648s)
Subtest flip-vs-expired-vblank-interruptible: SUCCESS (30.890s)
Starting subtest: 2x-flip-vs-expired-vblank-interruptible
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (30.389s)
Subtest 2x-flip-vs-expired-vblank-interruptible: SUCCESS (30.389s)
Starting subtest: flip-vs-absolute-wf_vblank-interruptible
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.342us accuracy 0.01%
Dynamic subtest A-DP1: SUCCESS (8.242s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest B-DP1: SUCCESS (8.230s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest A-HDMI-A1: SUCCESS (7.932s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest B-HDMI-A1: SUCCESS (7.931s)
Subtest flip-vs-absolute-wf_vblank-interruptible: SUCCESS (32.337s)
Starting subtest: 2x-flip-vs-absolute-wf_vblank-interruptible
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (30.672s)
Subtest 2x-flip-vs-absolute-wf_vblank-interruptible: SUCCESS (30.672s)
Starting subtest: flip-vs-wf_vblank-interruptible
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest A-DP1: SUCCESS (1.242s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest B-DP1: SUCCESS (1.230s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest A-HDMI-A1: SUCCESS (0.934s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.447us accuracy 0.01%
Dynamic subtest B-HDMI-A1: SUCCESS (0.931s)
Subtest flip-vs-wf_vblank-interruptible: SUCCESS (4.338s)
Starting subtest: 2x-flip-vs-wf_vblank-interruptible
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (2.688s)
Subtest 2x-flip-vs-wf_vblank-interruptible: SUCCESS (2.688s)
Starting subtest: flip-vs-dpms-off-vs-modeset-interruptible
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (1.367s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (1.354s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (0.642s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (0.641s)
Subtest flip-vs-dpms-off-vs-modeset-interruptible: SUCCESS (4.005s)
Starting subtest: 2x-flip-vs-dpms-off-vs-modeset-interruptible
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (1.226s)
Subtest 2x-flip-vs-dpms-off-vs-modeset-interruptible: SUCCESS (1.226s)
Starting subtest: single-buffer-flip-vs-dpms-off-vs-modeset-interruptible
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (1.354s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (1.394s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (0.641s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (0.642s)
Subtest single-buffer-flip-vs-dpms-off-vs-modeset-interruptible: SUCCESS (4.031s)
Starting subtest: 2x-single-buffer-flip-vs-dpms-off-vs-modeset-interruptible
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (1.227s)
Subtest 2x-single-buffer-flip-vs-dpms-off-vs-modeset-interruptible: SUCCESS (1.227s)
Starting subtest: dpms-off-confusion-interruptible
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (7.790s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (7.789s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (7.647s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (7.647s)
Subtest dpms-off-confusion-interruptible: SUCCESS (30.875s)
Starting subtest: nonexisting-fb-interruptible
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest A-DP1: SUCCESS (0.791s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Dynamic subtest B-DP1: SUCCESS (0.790s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (0.647s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (0.648s)
Subtest nonexisting-fb-interruptible: SUCCESS (2.877s)
Starting subtest: 2x-nonexisting-fb-interruptible
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (0.888s)
Subtest 2x-nonexisting-fb-interruptible: SUCCESS (0.889s)
Starting subtest: dpms-vs-vblank-race-interruptible
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest A-DP1: SUCCESS (3.453s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.342us accuracy 0.01%
Dynamic subtest B-DP1: SUCCESS (3.442s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest A-HDMI-A1: SUCCESS (2.880s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest B-HDMI-A1: SUCCESS (2.883s)
Subtest dpms-vs-vblank-race-interruptible: SUCCESS (12.659s)
Starting subtest: 2x-dpms-vs-vblank-race-interruptible
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (10.834s)
Subtest 2x-dpms-vs-vblank-race-interruptible: SUCCESS (10.834s)
Starting subtest: modeset-vs-vblank-race-interruptible
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest A-DP1: SUCCESS (3.341s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Expected frametime: 20000us; measured 20000.1us +- 0.250us accuracy 0.00%
Dynamic subtest B-DP1: SUCCESS (3.400s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest A-HDMI-A1: SUCCESS (3.015s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest B-HDMI-A1: SUCCESS (3.015s)
Subtest modeset-vs-vblank-race-interruptible: SUCCESS (12.772s)
Starting subtest: 2x-modeset-vs-vblank-race-interruptible
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Expected frametime: 16667us; measured 16666.7us +- 0.479us accuracy 0.01%
Dynamic subtest AB-DP1-HDMI-A1: SUCCESS (10.708s)
Subtest 2x-modeset-vs-vblank-race-interruptible: SUCCESS (10.708s)
Starting subtest: bo-too-big-interruptible
Starting dynamic subtest: A-DP1
Stack trace:
Dynamic subtest A-DP1: FAIL (0.003s)
Starting dynamic subtest: B-DP1
Stack trace:
Dynamic subtest B-DP1: FAIL (0.002s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest A-HDMI-A1: SUCCESS (0.634s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Dynamic subtest B-HDMI-A1: SUCCESS (0.635s)
Subtest bo-too-big-interruptible: FAIL (1.275s)
Starting subtest: flip-vs-suspend-interruptible
Starting dynamic subtest: A-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Test requirement not met in function suspend_via_rtcwake, file ../igt-gpu-tools-1.26/lib/igt_aux.c:769:
Test requirement: ret == 0
rtcwake test failed with 1
This failure could mean that something is wrong with the rtcwake tool or how your distro is set up.
Dynamic subtest A-DP1: SKIP (0.134s)
Starting dynamic subtest: B-DP1
  3440x1440 50 3440 3488 3520 3600 1440 1443 1448 1481 0x9 0x48 266580
Stack trace:
Dynamic subtest B-DP1: FAIL (0.543s)
Starting dynamic subtest: A-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Stack trace:
Dynamic subtest A-HDMI-A1: FAIL (0.214s)
Starting dynamic subtest: B-HDMI-A1
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 0x5 0x48 148500
Stack trace:
Dynamic subtest B-HDMI-A1: FAIL (0.119s)
Subtest flip-vs-suspend-interruptible: FAIL (1.010s)
Starting subtest: 2x-flip-vs-suspend-interruptible
Starting dynamic subtest: AB-DP1-HDMI-A1
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
  3840x2160 60 3840 4016 4104 4400 2160 2168 2178 2250 0x5 0x40 594000
Stack trace:
Dynamic subtest AB-DP1-HDMI-A1: FAIL (0.285s)
Subtest 2x-flip-vs-suspend-interruptible: FAIL (0.285s)

Am 27.10.22 um 16:29 schrieb Rodrigo Siqueira:
> Hi Ao/Arnd/Stephen/Nathan,
>
> Ao,
>
> Thanks a lot for this new patch.
>
> Since you have an ARM64 + AMD GPU, could you also run a couple of tests in your setup? If so, this is a good set of tests imho:
>
> 1. Check plug and unplug displays (let says 5x)
> 2. Change resolutions
> 3. (most wanted test) Could you run some IGT tests?
>
> About IGT, this is the official repository:
>
> https://gitlab.freedesktop.org/drm/igt-gpu-tools
>
> It should be easy to run IGT in your system. Follow a brief summary:
>
> 1. Install dependencies
>
> (maybe I missed something)
>
> Debian
> apt install flex bison pkg-config x11proto-dri2-dev python-docutils valgrind peg libpciaccess-dev libkmod-dev libprocps-dev libunwind-dev libdw-dev zlib1g-dev liblzma-dev libcairo-dev libpixman-1-dev libudev-dev libgsl-dev libasound2-dev libjson-c-dev libcurl4-openssl-dev libxrandr-dev libxv-dev meson libdrm-dev qemu-user qemu-user-static
>
> ArchLinux
> pacman -S gcc flex bison pkg-config libpciaccess kmod procps-ng libunwind libdwarf zlib xz cairo pixman libudev0-shim gsl alsa-lib xmlrpc-c json-c curl libxrandr libxv xorgproto python-docutils valgrind peg meson libdrm libtool make autoconf automake gtk-doc python-docutils git vim sudo
>
> 2. Build IGT
>
> meson build && ninja -C build
>
> 3. Turn off your GUI
>
> (You must run IGT without any GUI)
>
> sudo systemctl isolate multi-user.target
>
> After run this command, you should see the TTY.
>
> 4. Try to run this IGT test
>
> sudo ./build/tests/kms_flip
>
> And let me know if this test looks ok for you.
>
> On 10/27/22 06:52, Arnd Bergmann wrote:
>> On Thu, Oct 27, 2022, at 02:25, Ao Zhong wrote:
>>> After moving all FPU code to the DML folder, we can enable DCN support
>>> for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG from the
>>> code in the DML folder that needs to use hardware FPU, and add a control
>>> mechanism for ARM Neon.
>
> I recommend you to add the following info in your commit:
>
> 1. System that you use to validate this change (CPU name, monitor, distro, wayland/X, etc).
> 2. Describe the set of tests that you tried.
>
>>>
>>> Signed-off-by: Ao Zhong <hacc1225@gmail.com>
>>
>> There have been problems with stack frame overflows on this code
>> in the past, how much have you tested this with random configurations
>> to see if we still hit them in corner cases on arm64 that may not
>> show up on x86 or powerpc? I would expect to see a few more of them
>> for every new architecture port.
>
> Hi Arnd,
>
> We followed your suggestion to isolate all FPU code inside a single place (DML), and we recently completed most of this task. As a result, all FPU flags are only used in the DML code. I guess we might have issues in other non-x86 platforms, but this is something that we can improve over time, and from Ao message, it looks like that DCN is working on ARM.
>
> At this point, my main concern is that enabling ARM64 may causes some compilation issues that we did not reproduce yet. I cross-compiled amd-staging-drm-next + this patch with aarch64-linux-gnu-gcc version 12.2.0 and everything looks fine.
>
> Nathan/Stephen,
>
> Maybe I'm wrong, but I think you have access to some sort of CI that tests multiple builds with different compiles and configs, right? Is it possible to check this patch + amd-staging-drm-next in the CI to help us to anticipate any compilation issue if we merge this change?
>
> Or should we merge it and wait until it gets merged on the mainline? In case of a problem, we can easily revert a small patch like this, right?
>
> Thanks
> Siqueira
>
>>> index d0c6cf61c676..3cdd109189e0 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>> @@ -33,6 +33,12 @@ ifdef CONFIG_PPC64
>>>   dml_ccflags := -mhard-float -maltivec
>>>   endif
>>>
>>> +ifdef CONFIG_ARM64
>>> +ifdef CONFIG_DRM_AMD_DC_DCN
>>> +dml_rcflags_arm64 := -mgeneral-regs-only
>>> +endif
>>> +endif
>>> +
>>
>>>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
>>>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
>>>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags)
>>> -Wno-tautological-compare
>>> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
>>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o :=
>>> $(dml_rcflags) $(dml_rcflags_arm64)
>>
>> Why do you need separate $(dml_rcflags) and $(dml_rcflags_arm64)
>> rather than adding -mgeneral-regs-only to $(dml_rcflags) directly?
>>
>>      Arnd
