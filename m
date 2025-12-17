Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4171BD637DF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 00:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C283D10E99D;
	Wed, 17 Dec 2025 00:26:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mj6OJNng";
	dkim-atps=neutral
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AF1910E99D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 00:26:35 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id
 46e09a7af769-7c6d1ebb0c4so4066915a34.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 16:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765931193; x=1766535993; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a1gwXonSvkJ/WHc6pf4yPdhmchAmeTVlihT5ATXgBe8=;
 b=Mj6OJNngjFDC/nE2dbTxdYCLO+i1s2q8yOrirVLN4ai1uUUP67BPcjUDLY/dAvhmFv
 BmQGi6sjFfeULiZy1yH818VFbpSsOKQiJJH5depgW7yaVQTnm5bUt2y8QFxJf7z1Un2e
 c7agDzN9whxknJQzbJ6hvTa25qEzuV5NQoG/ZRKU0gMULtKBpjaYlQ3SnmTladAZ+a4a
 VKzZfOzwpOqjYNRImEoOx1QHZ5n6yY6eEhFNCfPoDm1rk7uQv6ZkAuXUadOWIA8lw3Me
 53Lq57qCEJ+VB7JBGm5h+IrXBgpj3fS+VUV99aWLzi+mijSBqqvSaiGR0IRUCy/obsin
 75gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765931193; x=1766535993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a1gwXonSvkJ/WHc6pf4yPdhmchAmeTVlihT5ATXgBe8=;
 b=DW/+x6uuqSS1c1w9Jp0zEnzmFbp3fXTW+8U7XLcULwjWfirjMrJ+AHjzubpG9MYDxx
 kwE0dPmc6/qmLKImhu5F36qKeoKsIEG7PHXZ+nyU2B5yHLzJYtW2yRfPgfly87urpgJH
 vQ5rRhGbev7Mx4ovinhMZ/EbafQUPZfWe8ZwBYTo/J4Q+5o1njK2NUZDwGDQaJtdr4SO
 itbe9Gj6NyWEXyQsNpU9ymhXkpiXWQk80nzguIsCvXaifY/Z2/NVKsK7vvhUNJtWVTNW
 BFuosE7D2KVcKP01nOHYWFztkRu9T6rmfueHakCY3WHUCJIv6LEUnUtCgVmDp21SYm8B
 6Dlw==
X-Gm-Message-State: AOJu0Yyj1paQ0JVYk72UWRa4Zv2qFwUBJaWvXY4kHL8YfIJKLqX4vdEu
 tuY0BgCfTGpnOasAS81f/939Nto5xbVqwGcSN8Fi1W5ajzzgDYtCcsFt
X-Gm-Gg: AY/fxX5iann7fnep9lCu7HVfTUeL0bAr+s9e3+4n9wtoKWJQy+wkazNjhcQ09rPayxo
 SCSde8Rf8QFBAqlf8U/15ToIL5rhmM3gnZIl/ojPuRTNU9+Uh+M88XjkevKktAnpkYQSXhg2kXE
 +VGoyztFvMaKBV6tAvxRPSuiaNno9fyaROj5fQtAEx1UpzOk1+lxYlczRBi7wkxcT8g8qJYZ823
 uZtVnbHsEfVFGOFtcONGvFrkVYcT5/WSEfnlsS3PSlnrdmNNnd5zK48lMNR+aIn7fWHC2dOj2Oy
 3Ggr7Dtq7+OtgrRWx4xxIHNZECjAi9LNKc0mhiRp9LgicfdGqpc/38yqNoF/52DFW05COsj4P5F
 x/sWklWdIV3CuVKsr87AHInDDKQn7XlMagOBuWLCiw776AKVOatJCYWed0cRDrQd8fdgiFPwQKU
 0JtKaT5slsHp8H8d19x5Xc8msIXYE=
X-Google-Smtp-Source: AGHT+IGEVjk2vwFwm/wKw+4wbYp0IdxsKvJSw87sq7XSjWk2qdvTsm8xyo9hp9mNoEvLmh+QUPVWgA==
X-Received: by 2002:a05:6830:2701:b0:7c7:6348:5946 with SMTP id
 46e09a7af769-7cae82d5406mr9187039a34.5.1765931193147; 
 Tue, 16 Dec 2025 16:26:33 -0800 (PST)
Received: from timur-max.localnet ([189.171.135.243])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb2fcc39sm12414980a34.19.2025.12.16.16.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 16:26:32 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>, Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <Harry.Wentland@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, alexander.deucher@amd.com,
 siqueira@igalia.com
Subject: Re: [PATCH 0/5] drm/amd/display: DC analog connector fixes
Date: Tue, 16 Dec 2025 18:26:31 -0600
Message-ID: <5017406.vXUDI8C0e8@timur-max>
In-Reply-To: <96ac728e-1d58-46e8-a4a4-b722023f6a45@amd.com>
References: <20251206023106.8875-1-timur.kristof@gmail.com>
 <2595415.XAFRqVoOGU@timur-max> <96ac728e-1d58-46e8-a4a4-b722023f6a45@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

> >> 
> >> Did you have an update for this series, or are they ready to be applied?
> >> 
> >> Alex
> > 
> > Hi,
> > 
> > I re-reviewed my patches in this series again and I realized that my
> > comment was mistaken (I confused link encoder with stream encoder). So
> > the patches should be good as-is.
> > 
> > However, in the meantime Mauro got back to me this weekend, and told me
> > that he determined that the patch "Setup DAC encoder before using it" not
> > only doesn't fix it, but regresses the analog connector on his HD 7790
> > further. Before this patch, he got a black screen on boot, but the DAC
> > started working after suspend/resume. After this patch, it no longer
> > works for him even after suspend/resume.
> > 
> > What do you think is the way to proceed?
> > 
> > A) Merge all patches but that one. I'll submit a corrected patch once we
> > figure out the HD 7790.
> > B) Merge the whole series as-is and I can submit a fix once we figured out
> > what is going on with the HD 7790.
> 
> Plan A sounds better. Let's not merge a patch with a known issue. I will
> also share test results by the end of the week.
> 

Hi Alex,

Thank you, that sounds like a good plan to me.

Timur



