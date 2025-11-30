Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19A3D116E2
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Nov 2025 01:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A55410E23B;
	Sun, 30 Nov 2025 01:38:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LXnpwTwD";
	dkim-atps=neutral
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com
 [209.85.161.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 964C410E23B
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Nov 2025 01:38:29 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id
 006d021491bc7-65745a436f7so1261586eaf.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Nov 2025 17:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764466708; x=1765071508; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YaDWYZkZFegtwIfomfvor4hTBeb3IvYyfXCgFsMCmvo=;
 b=LXnpwTwDjgx77uJ9gZu6IeD2zBf5TCctDcSLlntTdwNNNDy0O1oZTkYNlMt74oRGKe
 5rbNtk6C9cg84O2omeloeGua/eflm973SldUl2Fj6My2OXE48M7YdyECAXlusMhmdCEm
 7eSdJ9CRUGjSdDrknPLHqLj5jbEe4x0r/4V/7vTnQMzZFDxIHwMd/cSm1Vi6D8bbMQcA
 w6h4bnEpenriYx/QobYzljB+VMqc1Dv3ETrR2bmLAOk82nppROHLp2IdPl0TZ8x/iveB
 6YFYjkESLMgEsjziCz/pLcU97ylPEu3Nv5d9uaFokfncsp4fhXTELPHH5V+2lSMYnYko
 rF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764466708; x=1765071508;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YaDWYZkZFegtwIfomfvor4hTBeb3IvYyfXCgFsMCmvo=;
 b=bz2q/mI2Wyq7GfTZZD/3cOxNA85wg3cJ66unHk9NjvawsBXwGL4D6NA15iWoF51sJ8
 v9KazY1bqXsmRKZKTF1PHbOUJBlsr9nvuccKbFJfC5s68XR/LZrCZ5aLNrBU2E0whsEy
 Ctdn4ZBItjJl0pavTEFQgo2H+0iNM/SOEJ+MmKBXW2/BeuARQeIEuvfqQr3fjmQODWn6
 WKP2uvOzETpM9xaKGHrC1z9GXrbXm58KO45IPCrgMm5wtdQ+8iIAApvQ7szAFHV2jYbd
 mtMewi0/3AVDWFkJqSJQ7zb5kcktbQjaO9sw70TTBIoihFbyNDQEzbZLqQM6f6vBS4Bi
 66Bw==
X-Gm-Message-State: AOJu0Ywat1Av+B45oO2J/RmqU7MbToEG5eIS5Di5UgNTBcytqGl3oT3I
 HNWC38HSr3AOtp8RPiJYmybagdr2NBX9JOZHMeI2hojE5umTXDyKkSKA9txiNMrxhfI8Q1pZ5LN
 PMTsj1ijSm1dK8EKWJPtAlS3VUOCezHY5pLjd
X-Gm-Gg: ASbGnctFEOoBR+FYeG2FxCZ6jTlgu/oEbTe7c3hOMT4h6BbxySx1eH9r870WARDWVSQ
 7wy7v+vAMf+VzQciSx4pTr2xKmITofoqQHs7nW3fgDUMA2HBIRx7SrYU8Ny8S75aeWDt9wYGUR8
 pVtUN2rgmuOhYjbCQ8H1rU2pFXX1uq2aqHx1UH1wNpDVl8b/Fzrp4rxzV8voCpZ4ODK336IyvzP
 bliq3TXui6daBAPdgwIWGOFBG9qBJKJr7iCfC4F0m8LpJ7lTUFukPC1oF17F8HGjXvanks6
X-Google-Smtp-Source: AGHT+IE3t4o8+NKRA+BJhnooXfWHxtAf+Gtf377UnunCi6CoRM4mETRIG5t2jo2lwYXqPT5KIV2tKH8dWlWqEE/IiUw=
X-Received: by 2002:a05:6820:81c9:b0:657:6fdd:9875 with SMTP id
 006d021491bc7-65790b48f4emr12814330eaf.5.1764466708411; Sat, 29 Nov 2025
 17:38:28 -0800 (PST)
MIME-Version: 1.0
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Sat, 29 Nov 2025 20:38:17 -0500
X-Gm-Features: AWmQ_bkTmdumqnbTYe7uy_5Amv6r_0EY0uRgJZWVrtHPvsHIzzWuqV0CSSmIPCs
Message-ID: <CAPEhTTGamEFapOA4pKgMQxDz9Go1k0QeGRkk5bR-X2jR+iBCcg@mail.gmail.com>
Subject: SI - are power and voltage readings supported by the hardware
To: Freedesktop - AMD-gfx <amd-gfx@lists.freedesktop.org>
Cc: Alexander Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

I was wondering if SI GPUs support reporting power and voltage values
at the hardware level? I read somewhere that it was supported from
GCN1.2 (Tonga and over), but I haven't found anything on prior
generations. Going through the register names, I wasn't able to
identify any who may correspond to power or voltage level.

So I'm asking, just in case it is supported and I missed the
information while searching for it.

Cheers,
Alexandre Demers
