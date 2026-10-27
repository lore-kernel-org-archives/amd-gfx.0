Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B49606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l8Zdrbpo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 935DC10E032;
	Tue, 27 Oct 2026 22:30:52 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C177B10E032
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 22:30:46 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5bfa686881fso362186e87.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 15:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793140245; x=1793745045; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fF+hhLhhGF6DZRpl45mUYSu/W2Cwx5CQUq9wX62q4sI=;
 b=l8ZdrbpoJb1h36zifkrY8du3l5cbkEn27sCmSKoNrSOFuf5UA56mVjYQOrAQ9UrgKQ
 /0TNLpflLI3VuFjOaqSd0q4eaHv3AbnpUyfoerZeDjtcb6cTKD9TtECw/c3JxzK714/5
 QqRiZP79sgz94Vm1FrtMlOGoA/dHIXlHy4/h56XK6Wi4OJ83Yh/FvsBooYloeLpZBJ47
 mtG9juLubn7Cg4nm/jMlYtOw6MQHjfGuewT1pcw7Hzfb0MlU9ncdUQuGD1aTSrbu05+u
 c1G6OKyassviWGkvRN+2r3+UPN/m/NYW5lqOQvNsMzpfcp69pwUqg841hch/+l8+TE6z
 069A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793140245; x=1793745045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fF+hhLhhGF6DZRpl45mUYSu/W2Cwx5CQUq9wX62q4sI=;
 b=mcPp2wN8k1tSCsw3axUdCy4EqxlFfTOr3+8NOJeLQS/qWh2GFhM0+SSb4rh4icH8wa
 EPzD4IhsFCY47oJ80ROHe9ZUrVpHyCGYDqQAKiQwfIoxYEMipBd8NumcGLBYgW45NAtl
 H2V3y0swPpWYzAvTdxNa6di7lGRDJhqxESIDGyV0EJgSfnWwhQBfProNtH6etGTouLb2
 EOQahgI7h9dbS5v4z86YenQ9/UMjj9xWt+mymYUrjA4BfWgoKSgnCdWw99JYihidP6xq
 QxkgH3tREFmMG1fhaFI6/Q4LsAQjpvrrgM384SMs0RoHUFfxtlbD+oLTlQoGruRXXI0v
 yD6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPHxT5mzvVNUGivYc3PI2qwu4o53rMdRR145M5ixmqANJ6Zf6nzDRmSUU7bVGve2yB8k4nHTNa@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI/mT/yVE7doYEf9jlHjTB/4cfWskraGET+pTh+SO39bz15L6Fx
 LlGINU5eZRLFGVYBRp5isSSxpxALKBoNHvVBectZn8I9k5uenVduHiuW
X-Gm-Gg: AYBFou0ojQARrivDstNOH87t8FZq86wfLsMngBw28HzEyGMB9OmOncqz5Fn56sFLQNj
 37IHQmJVz0pFMyCl07mgE9gbLKuIx5Af8fvptTmd8Ok0XOLJZ2xB9z6Lq/96CuqOXRE1B3wbvG8
 2eFQYvVxUzV27DVVy4DBa/p7WMueNv6BxCOVQPxN7Leoom+vkzAECl0lT+ckQxgANcUF4C33k5u
 +KFpGIMv1mh+EK6UeMNw9DVG+VsUTDZvEt6WczJFJpzEuU2uWb5dp+uNKqRsPWaNny6zD0yLQp9
 sAhHLDi6b3M8Z+wTjxVyg+6QhLX/urYXI6C5Quf+FD7Z7YHaWttwbt8s52hPVW1sf8IUX8qxAy9
 Dk4LYl2LDKUqwMl4F/pjBvqK63uk8IiaFWWJAdAVeaJpkFKsqXnjKPIl/EDQUvsn0ebrBiEVix9
 67Rdh1rGBKXHpkeI5Tj4wapwBuLrSw0awAUtWUa6/6g2s36O4G+NMh6QfnXLmEKK8hGvFD2K/HC
 rAz8B3gq62tGacByj8SkjjOfgXHJsD05Ki5CfD/MGEFXLVPnKJBuwn+uzIvwBHpsawWkR5KJd7D
 pkt8VU0mo8YBhkkHwqILpMVQwguoa+hK+Lkc8OWg6sdGxn0T6XeUPQ==
X-Received: by 2002:ac2:4e11:0:b0:5bc:c9e3:d5bc with SMTP id
 2adb3069b0e04-5bfcad1f499mr228031e87.29.1793140244602; 
 Tue, 27 Oct 2026 15:30:44 -0700 (PDT)
Received: from localhost ([178.214.243.78]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfca5c9ebdsm205370e87.84.2026.10.27.15.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 15:30:43 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, George Zhang <george.zhang@amd.com>,
 regressions@lists.linux.dev
Subject: Re: [PATCH] Revert "drm/amd/display: Allocate DCN32/1 dmub memory to
 GTT"
Date: Wed, 28 Oct 2026 03:30:37 +0500
Message-ID: <20261027223038.299768-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <25995707c39c0c191e3ac46c4813f55a7f928403.1793131583.git.calvin@wbinvd.org>
References: <25995707c39c0c191e3ac46c4813f55a7f928403.1793131583.git.calvin@wbinvd.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I see the same kind of single-frame band across the whole screen on an
RX 7900 XTX driving a 3840x2160 TV over HDMI, and measured a637a140ab86
against the same parent: 35 times more events, over about eleven hours
each [1].  What I found since may help decide how to fix it: here the
band needs both the commit and DC switching the memory clock through
sub-viewport (SubVP).  With either one missing, the rate stays at the
same low level.

Events per 1000 eligible frames (frames whose neighbours show unchanged
content), counted with the CRTC CRC as described in my report [4]:

  kernel                 refresh  SubVP  events / eligible  per 1000
  1d8327353de6 (parent)  4K@120   yes       7 / 3,019,571     0.0023
  a637a140ab86           4K@120   yes     293 / 3,632,444     0.0807
  7.3-rc6                4K@120   no        5 / 1,582,072     0.0032
  7.3-rc6                4K@100   yes     139 /   712,333     0.195

7.3-rc6 contains the commit.  The 4K@120 runs with and without SubVP
differ in the TV's VRR setting, which decides whether DC may use SubVP
at that rate; without SubVP, DC keeps the memory clock at its
maximum [2].  In the 4K@100 run, 138 of the 139 bad frames have CRCs
that occur nowhere else in the capture, so the content of the band is
new nearly every time, which fits your "non-framebuffer data".

A second user, on an RX 7900 XT, sees the band over HDMI and over
DisplayPort whenever amdgpu_dm_capabilities reports SubVP enabled, and
not when it is disabled [3].  The DC debugging documentation describes
this kind of symptom: "a horizontal fillet of flickering happens in some
specific part of the screen.  This could be an indication of
Sub-Viewport issues" (Documentation/gpu/amdgpu/display/dc-debug.rst).
It suggests force_disable_subvp to check; on a stock kernel that is
amdgpu.dcdebugmask=0x20000.

Since it reproduces within 30 minutes for you, could you check three
things on an unreverted kernel?

  1. The refresh rate, HDMI or DisplayPort, whether VRR/FreeSync is
     on, and what amdgpu_dm_capabilities says:

       sudo sh -c 'head -v /sys/kernel/debug/dri/0000:*/amdgpu_dm_capabilities'

  2. Whether the bars always appear in the same part of the screen,
     as in the documentation's description, and if so, where.

  3. Whether they come back when booted with amdgpu.dcdebugmask=0x20000.
     amdgpu_dm_capabilities should then say "sub-viewport supported:
     yes, enabled: no", and the memory clock may stay at its maximum.

I have not run the third test myself.

The commit moved DMUB memory to GTT because data from DMCUB sometimes
reached the driver late, after DMCUB had signalled it.  SubVP is a path
where DMCUB itself works to a deadline: DC budgets 15 us for its
processing when it sizes the SubVP region (subvp_fw_processing_delay_us
in dcn32_resource.c).  Since the commit, the windows the driver sets up
for the firmware's data, mailbox and state are in system memory.
Whether that can make the firmware miss its deadline is what I asked
AMD earlier [2]; it is still open.

If this goes in, Fixes: a637a140ab86 with Cc: stable would take it to
7.3.y, and a Closes: tag pointing at my report [4] would let the
regression tracker close it.

[1] https://lore.kernel.org/all/20260919200820.799243-1-mikhail.v.gavrilov@gmail.com/
[2] https://lore.kernel.org/all/20261011201833.853907-1-mikhail.v.gavrilov@gmail.com/
[3] https://gitlab.freedesktop.org/drm/amd/-/work_items/5714
[4] https://lore.kernel.org/all/20260829010525.29935-1-mikhail.v.gavrilov@gmail.com/

-- 
Thanks,
Mikhail
