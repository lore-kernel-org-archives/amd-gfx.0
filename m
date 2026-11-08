Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6383606D804
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=jahs-net.20260707.gappssmtp.com header.i=@jahs-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EsPShtvr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C233910F2EC;
	Mon,  9 Nov 2026 14:09:36 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2307510E0EA
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Nov 2026 22:15:44 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4b7252a32c8so2553415e9.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 08 Nov 2026 14:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jahs-net.20260707.gappssmtp.com; s=20260707; t=1794176142; x=1794780942;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Uvr+F/2JK1AaGLCznMP5hvSKtAyjP1MI/tlzlJAmTmQ=;
 b=EsPShtvrddRy4MozG9bxhIGQvspAT9/aY6Uyni0mAGtrDBvE8aSMbZhb3/C4MZ30Vq
 IIe87UbEloT+pecaweaW3Dw2zr6V5Shv6nW5Yl5Ggwq9+oU32kS9RrrUIpuz4jnL7xOK
 aswkvH+v9Y/uL0p1at5wCc43/JSprK781fy6AozS58EVHaZCQLtPqHZGCgCGigslrlND
 MU+EZnuVsdyIEdD6M1t4UJl0gm7lXS+R4j9ZL1p7XaPz4PffgfDsBmP3yWS2O7gVKdz0
 TLGgk/5TAkGUzfHk9LYhw23oDkof7brq9x9dna3g82BCZVR0qdwGAKYDhZ/odPkzYSmr
 u9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794176142; x=1794780942;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uvr+F/2JK1AaGLCznMP5hvSKtAyjP1MI/tlzlJAmTmQ=;
 b=VyRzvgvbYO/znRAtiqaGpIQBGsqlPy4MxGZgG+/OK4Uz7nQ8O679UZK/DaHgw+fOF/
 /oIDJkuatl/NuErbSQ6QHYGydx9yI26DwN45Bpmn6Vy22/GUNzr5EfxDyIRg4Jye+QWI
 dWSF5oqn2AxO3chbeS/5Bh0287ww1vQ5rC5tlETmj/3msi7zcXIUzdUk9k3AkXCvKqW9
 bjOgT1CEYirmroc30JOtDjiW16Or6XGNZpOxsFT1PYzaRh+/yVZeN2iqqG6JllnPUaGK
 n7kRdhjmLx/KUo1JCad5NmlZtkiVIZl4kJw2yd6Qe6NCcwL/zARNleEMI3C2tKazER86
 19qg==
X-Forwarded-Encrypted: i=1;
 AL+hErFDiYKRE5ylns/rnVl3CjkwBL+T4rikpgk3m2orXF3nbzLl7UnLrYLnIRQ3jUlNBzW7uCLwi2HI@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8r7bFUXUFlMDjYKayrooiPPU+A8tQcyKtUV5UeB7NcTmjyqb5q
 iG26CUsQJLwdRvnFMUXbp2z1Vsio811MQG9gGDaX61lCFT2DmT49S30w9asdAVYeeg==
X-Gm-Gg: AYBFou3lhvdTqna/J1h5Pq135iOPhOQ4hnl9GBQVHwE7qBe+daWioG/vCexZlLdTmTL
 E0PC47K8pyWsCGjzHgZyPMLvUYwh4AQncCxfmE8HtIEr6tQHCy43dbvPqyLbFVLo8hd1jeCYw2f
 yFEN0OKmN702hDAsp+6dMl0z9dAbWr307lo8oyJHrQBDZKsBqiZY2opqJzYv9T3nQnvpl+bJhIY
 qY9pDZUW4tiAJIkaboC7mjXkxrCKbEf1H5ACzJFNm0LrXIt7RNnsnITlf5kexEjs0LS5Csirrh7
 v/m6czC8kiC+KMXOEGQQ8jaKFe18qqn8b4XAdK/7L/iIEtwpExrgemUNDS7OAphOETkD3e8h/pF
 tTB9TeZaTUDGflW+pJPrmuWDA21dWFVL/8DHp5eWq4jg1+y+k1zSKAyQZzrOFmAtKNQqMf3MVFF
 o/mpzyTPNzJshsP6mxZkQCdWhfkX0T7oL8FqkDR2bMg7+9YppbIY34fg9FkmbanXTwTB8jeMuBB
 bM6HXchB/Fr7IvJCaUzSFZ3stnJ93eySV85db8JEdVSAX2d61CBly830KKSOLNur/WLOuU4/t9s
 iIn/Vj9s1D6j/VSG9+2nzfCiUp8xsyCaWunhzXpw
X-Received: by 2002:a05:600c:4e87:b0:4a1:e69d:90e8 with SMTP id
 5b1f17b1804b1-4b963c8e6e7mr40922425e9.22.1794176141294; 
 Sun, 08 Nov 2026 14:15:41 -0800 (PST)
Received: from mbp2019.tail53dac2.ts.net
 ([2a00:23cc:b5dc:701:a5b4:75a8:ede:9f7e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7bb101537sm76735525e9.0.2026.11.08.14.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 14:15:40 -0800 (PST)
From: James Skillen <jahs@jahs.net>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Andre Eikmeyer <dev@deq.rocks>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd/pm: use the VBIOS trained UCLK levels on the
 MacBookPro16, 1
Date: Sun,  8 Nov 2026 22:15:38 +0000
Message-ID: <20261108221538.32132-1-jahs@jahs.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CADnq5_P5Ly4Pb8WqPaN28yDHG8jSjoEHAfDKAqSgTrSj14Pr1Q@mail.gmail.com>
References: <20261024162109.307247-1-dev@deq.rocks>
 <20261102232450.61301-1-jahs@jahs.net>
 <CADnq5_P5Ly4Pb8WqPaN28yDHG8jSjoEHAfDKAqSgTrSj14Pr1Q@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 14:09:35 +0000
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
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alex,

On Tue, 3 Nov 2026 09:35:29 -0500, Alex Deucher wrote:
> Can you try this patch instead:
> https://patchwork.freedesktop.org/patch/765668/?series=174386&rev=2

Many thanks for following this up, and for checking with the Windows
team.

I tested v5 ("drm/amd/pm: defer UCLK DPM on selected Apple Navi
GPUs") on the same MacBookPro16,1 (Pro 5300M, 1002:7340 rev 0x43,
106b:0210, VBIOS 113-D32207P1-019). Kernel 7.3.3 plus the t2linux
patches, v5 applied unmodified. Its navi10_ppt.c differs from
amd-staging-drm-next 178d00b only in the error returns of
navi10_force_clk_levels ("return 0" vs "return ret"); none of these
tests took an error path there. Panel on the Radeon, dcdebugmask=0x1
as before, and SMU messages logged with
amdgpu.dyndbg="file smu_cmn.c +p".

v5 works as described: UCLK is left out of the allowed mask at init
(SetAllowedFeaturesMaskLow 0xa7dfbfb3, stock 0xa7dfbfbb) and enabled
with EnableSmuFeaturesLow(0x8) about 1.2 s after DC init. It boots
cleanly, as stock does on this board. It does not change the UCLK
levels, and the hang is in level 2:

                     UCLK levels       UCLK level 2 pinned at idle,
                     (MHz)             ~5 min after boot
  stock 7.3.3        95/496/736/750    SMU no response after 3.4 s,
                                       GPU reset fails, machine hangs
  v5                 95/496/736/750    SMU no response after 3.5 s,
                                       same
  v5 + trained       95/496/598/736    ok, also under load (below)
  levels

"Machine hangs": a heartbeat sent over the network every 5 s stopped
within ~10 s of the failed GPU reset in both runs, so it was the whole
machine, not only the display.

v5, SMU messages around the pin:

  [311.750451] smu send message: SetSoftMaxByFreq(27), resp: 0x00000001
               in params:000202e0
  [311.750635] smu send message: SetSoftMinByFreq(26), resp: 0x00000001
               in params:000202e0
  [315.231058] SMU: No response msg_reg: 12 resp_reg: 0

For the last row the levels came from a pp_table upload with the
umc_info training points, the values Andre's patch sets in the
driver. v5's late enable ran again after the SMU restart. Forced
switches through every level transition at idle, level 2 pinned under
llama.cpp and memtest_vulkan, memtest_vulkan with forced switches
every 3 s, and a load run at DPM auto all passed, with no SMU or ring
errors. So on this board v5 and the corrected levels work together.

The root cause is in the board's VBIOS: its pptable UCLK levels
(736/750 MHz) don't match the umc_info training points (598/736 MHz).
A corrected VBIOS would be the clean fix; failing that, a driver check
that uses umc_info when the two disagree (a no-op on a correct VBIOS)
seems the practical one.

The testing above and this reply were prepared with help from
claude-opus-5-5; I have checked the results and the text.

Kind regards,
James
