Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC65CA5FE2
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 12:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2357E10F827;
	Fri,  2 Oct 2026 12:52:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I/atsHNg";
	dkim-atps=neutral
Received: from mail-qv2-f40.google.com (mail-qv2-f40.google.com
 [74.125.230.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1387410E2FF
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 19:30:11 +0000 (UTC)
Received: by mail-qv2-f40.google.com with SMTP id
 6a1803df08f44-917a3545923so19337936d6.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Oct 2026 12:30:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790883010; cv=none;
 d=google.com; s=arc-20260327;
 b=gah0QTaRWuzt9604oVGdFbkrbKuwjAhnhGD6WTU+5gvw6OaXKnoKGmEEs73DJurVmS
 mW/Qr/+m7Yc4WBdQ3s57PiQGy94sw27qxM5S6wf59rSOv1UMXwqAm/IdpEPKI2ozP/Gv
 7MalIA4Rr+HrPJb9fAUDb+jPw7m6XlZ5Cxwsk6HCB2MrvU1unyulXueeh18tjPml5T2y
 iZ6bxiS17rrGRhzUpLBKnbc7SNXT28HtatrDJ8d/cL+ijvq+6F5991DQbSfWhmfuxKzb
 MxO8iTLDhcW7EXlllWlxx5wncQuGd2O7ffKh/59qLriWsZY2ol3pbWHzhAV5Yr/xlcS1
 XX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bE/ZpayYaMuQJ2cjUw/XMionGOYmv8DuAlly9njYYE8=;
 fh=m+oHwv+pl4WdF3oxNh5bLMojDoy/ClarIsoVNp2/Vaw=;
 b=r6r+Cx09Pbm5iTDe2UTORJld1SYApRFpOxV0EIyYSRV9226NvyOvrO1TajOmGyu1r1
 OySFdoGKH2xSR03yCwDsxzRY1lD8Bc4HFoYwODb6JPuyfWq0K/ZME5c+RlCjZox9pVTk
 XjjsMT+240F9tvNCyHq/ouFpsgBmFuzsaIMrN8pUA/tDbB0MIHRIuDTOvJw6blE6HvvN
 GnhJ7c3xh8uCLVJ8aghVAy3mpvnahHnG2p7YM+oaGhlgGF1uX48lgG/UWSOSXNyAjQgR
 OKdAaiPK3eiK46kFSf/370u0Fwp407n9zPthT67T5fe751rVqPnGBH5WalQUYYqDUnxt
 0Onw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790883010; x=1791487810; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bE/ZpayYaMuQJ2cjUw/XMionGOYmv8DuAlly9njYYE8=;
 b=I/atsHNg+8htBTg+w5pzrDB4AzXTGsXqw0YYMs+N9hzdUXwCXTKyBE/wU3Wml9Gwp5
 Idm7Jm+T5ZaYkjRkUHF59Avb5bj8gvj4m7GcE1uaZjJCN67u0KAQVWc1IPGPrFrkcO8R
 J8gM2MntBM/BFVXkK9zpHmvjXliRL0dj5TWmMY22/H4mnbZJp/Dv/uW3DGBQlYvIJQ0O
 jzS6e8lUemCD3vYDRUVg21SugqWhiP93x2NDvNoyyTnj5D93pJeHMW0oOqThn44f1rNJ
 VHuqBi8j+yxqiLbtx3ArUlYdDpDPtdZerOukcv8I4ogNmpJ63Y2uWNOdLUf/JwTGL8qW
 +spQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790883010; x=1791487810;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bE/ZpayYaMuQJ2cjUw/XMionGOYmv8DuAlly9njYYE8=;
 b=W+mdXSgmUqztptGOH7OSW5AgYsvmF5uzxfYWlBaBFleChpOX6U2QyDpgfXxTEtfrol
 203jued6WIW0h84VG7Em9dzx+MkCRj4DBZJpBj6i1KACwDEpmJ8/rriw5P/MAgMFjscn
 BFfgHZbkBOztYpUyvn9BSorm/3TWUqnH4Yf3U+IgIPwQil/fMvLEvVsjYTijMFHPlvXg
 CZnvtDMxmzL0o4C65SAylV1XBMqKjXJseQMrEHmbM8q2f/jzreY0Jc9HMlKHUxzy5MHG
 HgK2lQjSG+rg8Xm3jM79/n0DfeOBECNVUGvOte5WT75ccdxssThJrtvHpEDAJeLHqfqi
 D/5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIXdFIM3z8AmKAhony8XgW5fuEto4jc1Cs0Vx/P7aGta9ojfw7qmNXZUGtf8iUgcj69SddB7dA@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJPU6XUVZOMwRoRwkWi2P0GGIjkvkKI68xNqOEfY8ya4vUNN7AL
 kRi9jTNR/BJZVvyqd5Qpy44YyRKw4+3ZWdcGaFt/fKZsspxag4f68Zl+Z9Js/bILkzc4BgLE17m
 ESDVMe9WxuQ1hcr4lwMbi5nT1a+9gyWc=
X-Gm-Gg: AYBFou39Wvnwdaud9LRei+2QTvTQk7nbvVB8Bfb2PSigoci+GxX0TWJPG0QoDOpt3cA
 /Ni0mywHkOI0ZR0/Rm44ZHAnrNpyo2qdXYAUgjHcOq5ZMxL94SBcx9qdBQxSEq7EUNub4KYkE3h
 EOBFuDqOkfNfWgNkIdZLfXYAWa4zSB21rzKIVFl/eS3CS86pw1cWOSMwIo0unCsJcr+QMJpBQfN
 QROQnqsm6PhANYgx6IvzA8G3wL2VTVT6XglzbxLBYoRm7Vy2aM3tASDj+DkofI4+MzIIuXjh++8
 TkdjPxtu1AsCn12RIJ64GaiJ+aPV4onXHe1ZAYGlZohk44Q243g7pMTW
X-Received: by 2002:a05:6214:1301:b0:914:5471:e569 with SMTP id
 6a1803df08f44-917c011aa47mr9730326d6.18.1790883009819; Thu, 01 Oct 2026
 12:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-5-mario.limonciello@amd.com>
 <25c3dd77-bedc-4822-b687-0ea429db0dc7@amd.com>
In-Reply-To: <25c3dd77-bedc-4822-b687-0ea429db0dc7@amd.com>
From: Xaver Hugl <xaver.hugl@gmail.com>
Date: Thu, 1 Oct 2026 15:29:57 -0400
X-Gm-Features: AclHuK-bx6IInYg2xVtTEtZOke_ojMQyvMv_9lNx9GZqWxpIrzw65JUNJ9QqnL8
Message-ID: <CAFZQkGxz6Sn7AU2_ATt_kpwTf9g0Orc6tTOOsmOzkHJo94E+-Q@mail.gmail.com>
Subject: Re: [PATCH v8 04/14] drm: add connector backlight (LUMINANCE)
 infrastructure
To: Harry Wentland <harry.wentland@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, 
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 amd-gfx@lists.freedesktop.org, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>, 
 David Herrmann <dh.herrmann@gmail.com>, Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 02 Oct 2026 12:52:19 +0000
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

Am Do., 1. Okt. 2026 um 15:12 Uhr schrieb Harry Wentland
<harry.wentland@amd.com>:
> Why not simply call it BACKLIGHT, which is what it is? Later, if we then
> add support for luminance (in absolute nits) we can use the LUMINANCE
> term for that. Otherwise it'll be lost to us and be apt to confuse
> people.
BACKLIGHT suggests there's a backlight, which isn't the case with OLED
panels for example.
I'd say luminance is the most technically correct term for this, even
if it doesn't come attached with a unit for now.

- Xaver
