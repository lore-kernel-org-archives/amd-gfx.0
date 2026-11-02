Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97003606A326
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=jahs-net.20260707.gappssmtp.com header.i=@jahs-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Ej1F0YGy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 312D610F49E;
	Tue,  3 Nov 2026 09:36:48 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D7EE10E713
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 23:24:55 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so2172059f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2026 15:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jahs-net.20260707.gappssmtp.com; s=20260707; t=1793661894; x=1794266694;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BOJF5pQ3Y3qra0fVhUmJwEYQYKAdz/RQknbT5cdg1Y4=;
 b=Ej1F0YGyD4xUB2G4NttxbumzlHVqntpVyAcJaS9FyvS0S/BVFrIsf2E6yBnhlXj2vq
 Nui6I3p9Kb5wDmcujdrbaYd+voOiC/xZgZbATBrpX6gqPio9GNU76LGO/k7TBCfK1mN6
 /kfN59GONMY0ywp+VbHadByf/MnPW/NO3k9h26JL7k7vYBS5QJtkvTss4nVjGpp8X1fH
 AJLdEB7V8zDXrHJxE4ay7mUPHfgW600lOelr0tKYqCsERJ3Pje/W60N4FwOPYH6YBWNZ
 T5UymAk8NmUmtWAhpcZsYShIETTe2pCRS8lsj05toLUBfoz5geBa4j49FQMVbKZj0MiA
 BnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793661894; x=1794266694;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BOJF5pQ3Y3qra0fVhUmJwEYQYKAdz/RQknbT5cdg1Y4=;
 b=fN5P/EDjTdeapLl32pPYpTDfGSbiw9vsIO8WXPsHsc+pt39reIsGNmaD6MspglLN3d
 8MdqVXF90eTZP9gCUJSzT0eaQbn3AoGnCRpk1hlvM8xR220aNh/ydZMMZb0hoTmS48gz
 LYVe8c2LBCUEvZuS04wBnFxNE6hHLw6rshWeg32r2ZYQZkd9GowRaKw22t8MJ9ht6Z34
 CluMrpKRm6pqfRQ/JZc3UF9UvLNZE8LQ4STTw8yXhnfdgn6BsY5MmOB3zaqzDgzZgme3
 aQtBWhbCPQgBCGUs3gg+dpb3oQASgFVBTIMOpHFhJO57hP5vMW7K/4mAZ14QB4aeEkI8
 y2aQ==
X-Gm-Message-State: APuU4Z/81I/+3zSZ0hzEuTvCgZIHiU9/nkupRMwFnN/0c3A7Inrw05yR
 1LP/zrhme4bFm+egP1WuM/ImHQy4/pvIKKOk9qSqN3Sz0PPSqGlqLR7yFHONc3XYtA==
X-Gm-Gg: AYBFou3rTT0etZBMhy/b7ViOajNQNS72GXOL9XV1Go+oDKag2xNEozZ3YFiCNCTrI09
 cfS1mGQfQB+kUe460QTRMj4WE/A/ZUUZQWGWStaroJd/5tYNdngKHrOI6UwCiyqdWrYXEScKUcF
 JWqEz+Dbk5Akzg5FKLG3daRyoNpSNt6EkpeVERyiHNQcErpljzIjQWPp9ttXFe82VuMYdPIC3BX
 Rehs0ervuc918NyBy0GWlr4d3oxwzjhsLJsDeoGkhT3Pj1RN0gWGh6Uh2raPxZvwbUqySD4EuRO
 ENQRf7X2y+hVQieuOG8qXZHphAuWoo6OJRKcoxEwZtYq/SqPewsoqqnYRGhKJEWRSUX6ON4o9Ij
 WqAABFtbxwLM/bs74gD2jdNzSN4BgNVRRtYHaw183Jv7PXFgFD7gSLeOBJq8DQxElEN4s/0VfP3
 NARfcK7+2fZw7w2JXncMHNDkSqO8fOiyWgMyS3UnYjhPpdJFqITNULEEssTEJTTXgZO2Ho4G0dY
 sjuMxL4iciGzjQDjYsWpl1xbmIJPxRVijU3PplZJBJWTgcps6zZAzM+In5BR6P8xmCdekkmxY07
 3MC/cHT1dNK+xrvDfH69ZpPIBsUEfGLFyzCzF3M3rcwVM2vNykGDRhZW8Bcphw==
X-Received: by 2002:adf:e19d:0:b0:48d:ffcb:28e1 with SMTP id
 ffacd0b85a97d-48e6e4f570dmr26032786f8f.11.1793661893544; 
 Mon, 02 Nov 2026 15:24:53 -0800 (PST)
Received: from mbp2019.tail53dac2.ts.net
 ([2a00:23cc:b5dc:701:a5b4:75a8:ede:9f7e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d4f9sm22522868f8f.2.2026.11.02.15.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 15:24:52 -0800 (PST)
From: James Skillen <jahs@jahs.net>
To: Andre Eikmeyer <dev@deq.rocks>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd/pm: use the VBIOS trained UCLK levels on the
 MacBookPro16, 1
Date: Mon,  2 Nov 2026 23:24:50 +0000
Message-ID: <20261102232450.61301-1-jahs@jahs.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024162109.307247-1-dev@deq.rocks>
References: <20261024162109.307247-1-dev@deq.rocks>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Nov 2026 09:36:47 +0000
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 24 Oct 2026 18:21:09 +0200, Andre Eikmeyer wrote:
> The Radeon Pro 5300M and 5500M of the MacBookPro16,1 (Navi 14 boards
> 1002:7340/106b:0210 and 1002:7340/106b:020f) stop answering SMU messages
> as soon as UCLK switches into its third level.

This is the hang reported in drm/amd issue 6005, which has the
umc_info analysis and test results from both boards:

  https://gitlab.freedesktop.org/drm/amd/-/work_items/6005

Could v2 carry a Closes: tag for it?

I tested the patch on a MacBookPro16,1 with the Pro 5300M (1002:7340
rev 0x43, 106b:0210, VBIOS 113-D32207P1-019), on linux-t2 7.2.11 (Arch
v7.2.11-arch1 plus the t2linux patches) with this patch on top. The
userspace pp_table upload from the issue was disabled for these boots,
so the corrected levels came from the patch alone.

All at DPM auto unless noted:

 - both "UCLK level ..." lines at boot and again after every resume,
   pp_dpm_mclk 95/496/598/736
 - forced pp_dpm_mclk switches through every level transition, idle
   and under memtest_vulkan load (57 switches, every 3 s): all landed
 - UCLK pinned at level 2 (598 MHz): llama.cpp benchmark and 180 s of
   memtest_vulkan, no errors
 - 60 min soak of llama.cpp runs with idle gaps, and 30 min of normal
   desktop use with the soak running
 - 8 deep suspend/resume cycles (rtcwake, lid, systemctl suspend)

I ran these with the internal panel on the iGPU and again with the
Radeon driving it (apple-gmux force_igd=n). No "SMU: No response", GPU
reset, ring timeout or DC errors in any of them. With the stock driver,
level 2 hung within seconds.

For the runs with the Radeon on the panel I also had
amdgpu.dcdebugmask=0x1. That is for a separate DC issue (the MPC pipe
split on the 3072x1920 eDP plane makes DRAM clock change unsupported,
so UCLK stays at the top level). It is not related to this patch and
I will report it separately.

Tested-by: James Skillen <jahs@jahs.net> # MacBookPro16,1, Pro 5300M (106b:0210)

The testing above and this reply were prepared with help from
claude-opus-5-5; I have checked the results and the text.

Thanks,
James
