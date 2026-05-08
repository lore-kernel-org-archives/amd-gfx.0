Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C3FCD37B9
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 07:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADCE610E4A1;
	Mon, 11 May 2026 07:30:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="RccVnukP";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E57710E320
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 10:37:03 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12c8ccc7755so2952463c88.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 May 2026 03:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1778236623; x=1778841423; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gthuyIjuskldV0oRrX2vMoLDNxHLbykzRnx9SsAWOYI=;
 b=RccVnukPoel/tQ40wr147aNYBSGueKv3RcOj+dKOnh5mC8L0LH7xJ3m6RcYhlRKpDx
 vEzB+42cCMXeSYbVPOI76KsRQfCf5WbEGI22KrwEQHHowiT+VE8CY2OBqAAJLNrq37eH
 ZOSpji4y8MsZVtQuBijydR5tlqADqNcFfrjRTxTcdpbTIGtNy2oZUVsBJN+FEZhh4MN7
 tvlg/HtaIEvMpQO7VZEEWjGC43QbUHiGitKYG0iq46W3hDEidK0l1XG7++eqrvr5afAQ
 coiVR00FaK7qXcJO2t2xgQpigEAULuUUv9wD7ARo7UisW5OR8emdpm60/NINFhxPtCvo
 WB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778236623; x=1778841423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gthuyIjuskldV0oRrX2vMoLDNxHLbykzRnx9SsAWOYI=;
 b=YKK5y7Z5jo9m/yncBh6WypbXwHoyYEx20+W5Bd7dQJ0tBfrVS4AFDG5+fuVpea4JJg
 TTBFBkWOdE39XbA6tFny2q/5z39Jwp5BCLyuqU043St2jwq4ArQLSO8WLObFzXtmB1/n
 PpsyEshuvYofkqXpZTO15n3MD3EIKyNM5eJSUhziEyCI65GoNr3kb5CopDlZ7NYYVeJR
 sbRxd2wVtpAG6PPcKLai3Hsfks3NtjdL0xHCgzXgYafq0xL5cBP1dhLCOnExAA4Gp1gy
 Ln2VTmlaStMIb3A7BetkDDXQ9Zxf0BGi3xPkqT5KUz0KAeLo3HgArBfG+cElyPPtaVjd
 0C2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+cs95yxyxsYLUbcbF+TWqYcceRZidTpri/sxJr2Ff3chUqqdCYBYCqxHU0uM7HDDFIo6GkNLsA@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7+hvslmbfQNQXFrfvritEs7zuPnuDL5SPtbLhpk5fao5x9DGK
 sI/ytdCz19N+67Onwzniz4F+P5err23bkop7lPFbOYMn0S1NoYy93/2vrBcOMSS99+k=
X-Gm-Gg: AeBDieuXqNI3f1QCu/kFfFkyodHtdbFC5GbIyCTL5BdCAwJVTQxcEOLML7UFmXX8VdC
 e6yS/HajjV7tN6M+JdcoTTY4PvTSpZIK7dUInrXMUmdNOC1oUHjQaF+ZV9kHSPYK151zVmAx6jk
 FQAz0FwNN707N1Q4J5t/4GY1esBmnAaaPmpP6LkmmSprfUNDmgaPLPyIYNde9Z299EJvFvaCOTL
 42uUVsPZ9btOM+jkx71P33Bo59dkylgh4eUAcKGtzu9WVDytb4dvJ1MCU1AJpgVbbOKJ8INI8HL
 T6Dsa+86Oiq3rb3QlMFCmQQBHHBg4+Sbbh2EFbEY55rvORl3EFzCAuVLlQ1o2qs+owuTh+RxA9T
 9wPAmzroStdKM517wfWMpnXvcCDoCkyBNcgmyFHGi+IMU5TXwddboAX6PDhcWzdo9rmVzSRBEf+
 y5Xa9WPen2c7Ig5vjClgV91xvyfBrMtkBISbH9pcPI7kIcP/1VCHsnm7XTJVPsyozwtujNoFmHA
 p59CdokeJObvU6ow/LCUlSIlJsapw==
X-Received: by 2002:a05:7022:438c:b0:12d:de3e:86b6 with SMTP id
 a92af1059eb24-1318ea40d7cmr5717123c88.38.1778236623061; 
 Fri, 08 May 2026 03:37:03 -0700 (PDT)
Received: from DontFreeze.tail1d9320.ts.net (201-68-218-231.dsl.telesp.net.br.
 [201.68.218.231]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888e3e285sm1933755eec.27.2026.05.08.03.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 03:37:02 -0700 (PDT)
From: Andre Jun Hirata <andrejhirata@usp.br>
To: christian.koenig@amd.com
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, andrejhirata@usp.br,
 dri-devel@lists.freedesktop.org, gabriel.dimant@usp.br,
 guilhermesangabriel@usp.br, kenneth.feng@amd.com, simona@ffwll.ch
Subject: Re: [PATCH RESEND] drm/amd/pm: Use guard(mutex) instead of manual
 lock+unlock
Date: Fri,  8 May 2026 07:36:53 -0300
Message-ID: <20260508103653.39000-1-andrejhirata@usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <dcc966e0-da1d-4589-ad04-02aeb1a8e06f@amd.com>
References: <dcc966e0-da1d-4589-ad04-02aeb1a8e06f@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 May 2026 07:30:27 +0000
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

Thanks for the feedback! I'll prepare a v2 incorporating both suggestions.
