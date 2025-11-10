Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D435ECCFA18
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Nov 2025 13:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F0E10E57E;
	Tue, 11 Nov 2025 13:39:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xoqqzTwy";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD57410E403
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 15:26:48 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47755de027eso21712075e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 07:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762788407; x=1763393207;
 darn=lists.freedesktop.org; 
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4hufuGaFBjIQOeY3oiJn4UcPMAxeKU5nx6U0+OKioQY=;
 b=xoqqzTwytzXMQgMawBvqBCsyLgLsiI6WKUrNeUebhDtVwNymu2cctX7ImSk7WqPUU9
 gR5FFG7a3A/kxpjP+pGr4BaXaFfwH3Nni+aNV7W8W4Y5a+X3YDy7YVAnwz/4Y5zJMInG
 GJq6B7hCtAD9enURRw0/aXhtykY6zLO83+eLQmzL5FiFdJWQAKQ5hbRmhgHzbuB9CuhT
 N+sz4pPyENWuy8PCEXKdyC02T6SZL6dwPXETymwrF+ZD8LNc7MlEo1lDOTYT/jku2eY8
 H067iyAqSh43GvR3cWxFSlVdbLNMfd8SbMqlekCdvlw+RmWt4ZwSfe5zmRSvGCmW/CRy
 +Fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762788407; x=1763393207;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4hufuGaFBjIQOeY3oiJn4UcPMAxeKU5nx6U0+OKioQY=;
 b=M0J4naPn6dNg/cp9SQBveVEgIkhIhgSCzzMh3Z2hltKyYrmYBP+9w0EjffXWYbYj3p
 8p2lam9wuEZDjTNDq5dA6/h9G5HmOwl6khbfwW0HHbYV0fBXuKdNliNJ79e8TN6j2Hq5
 rZY2LUAtXD1wMDOCu/9cPNB6BY2/oiusHhhmLvULSAIczsZxe8ONziIjY597NJ9vC74j
 yg2ySxkyyg0Ep16mu0ajGwWuAyZcgrF4qatIwRpsZOEg/tyWMAk9XTK67KBnDtk381LS
 sqV347dDb5P6OB/iV/65aeWxI3G9OyMrziW5nlaAnPMDXcapiEZrvkrmGx8Mobdk4jv3
 VOvQ==
X-Gm-Message-State: AOJu0YwTBT2dkK78AI7ca8pOxYIqs8sHYY7xnr3YCCkMESoUzoIoQS+J
 JlZ4d2PyKN/njiAx/MFfzqiKIPlxMT+I6kh5axrMvGbPMkdGFZCBlpuJtXpJRHnJqj4=
X-Gm-Gg: ASbGncvAKjvGXydyO9Nag/6qmeSmZAhvB7VX4+YPknDGkWONJua1N7WFo6Sm9p3baOB
 1jlOo230zByljz0cWXpi3mpN3qrZcXiJ8nabYJ4YdZ6BouRQPpS/NOC6L1+DhKM/sdt/4/p3Q+U
 Qi2cn/lIDC0iYvcO7A1Da5xVgpxNxrES39FFfovZYywAujh1G6fxSXK+Ha6zvweond1UsgWzOrn
 xNsgA6BQf9EBftJ8Agp99Fy/rV+3qoSuGt5d61qbCpsnoviK0fwqcHOl0XaZRwbkhwrpUzMRVcB
 +YpRpP4jFPT5JRxCOs50IXKIN9CVHg8UEkGIrbxBkAEp9UJZzSYW2Gl4jr8MHh9PC4hRrgJk5L3
 Q2Zvl/fxbMWILvVRa+3Hlt7MH7zgzoAsuY8eITtRg+MEbvPf5VMJc0zqdmoOob/Dd2tOwymQRQ3
 f1iow9PQJW81qodHpeulse9ydb1zlh/tPl7D/OcmzAWqCIZ1mpLzF1iPGWcUmgM8DE
X-Google-Smtp-Source: AGHT+IE3KsiTvJIewXb+3ogBMUER1zAAa71pK2E88TNZuIfMA+ylYPhSN6HW/0RuZinFnwLY++wYCw==
X-Received: by 2002:a05:600c:46d0:b0:45d:d8d6:7fcc with SMTP id
 5b1f17b1804b1-4777327b249mr80284175e9.27.1762788406946; 
 Mon, 10 Nov 2025 07:26:46 -0800 (PST)
Received: from localhost
 (p200300f65f235304535ebd79d849669b.dip0.t-ipconnect.de.
 [2003:f6:5f23:5304:535e:bd79:d849:669b])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4776bcfd021sm256714785e9.11.2025.11.10.07.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:26:46 -0800 (PST)
Date: Mon, 10 Nov 2025 16:26:45 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 1118349@bugs.debian.org, 
 Roman Savochenko <roman@oscada.org>
Subject: dpm broken on Radeon HD 8570D
Message-ID: <epyf7tdz3azb3fflb6rwuhax7mpccmqlsmzqqe2pcm7mxrdur4@zpx2uo5pvoqs>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4j45tlwdfnxrvonm"
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 11 Nov 2025 13:39:06 +0000
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


--4j45tlwdfnxrvonm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: dpm broken on Radeon HD 8570D
MIME-Version: 1.0

Control: forwarded -1 https://lore.kernel.org/amd-gfx/epyf7tdz3azb3fflb6rwuhax7mpccmqlsmzqqe2pcm7mxrdur4@zpx2uo5pvoqs

Hello,

A Debian user (Roman Savochenko, on Cc:) reports issues (freezing with
black screen) with a Radeon HD 8570D graphics adapter. When passing
`radeon.dpm=0` on the kernel commandline the problems are gone.

Is it a sensible quirk to let dpm default to 0 with that hardware? Or
does the behaviour depend on (e.g.) the actual monitor in use?

Or is there a bug to fix? If so, do you have a hint what to do, is there
more information needed from the affected system?

The full bug history is available at https://bugs.debian.org/1118349,
which also contains some hardware information.

Best regards
Uwe

--4j45tlwdfnxrvonm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkSBDMACgkQj4D7WH0S
/k5zWAgAqju8BpDB1hAAAVNE8j7dLI56fUYPPChiiaX/8H59lbni/EpSQOsN+U06
U1PBZEtriZBDtmP733YLF0SWG53XsJCNKZFUVJ+kFP9Frh6UmAvthxWAmY0YYgvM
gQABgVrWPEzFRoUR29vaJQj2K/fAnUxyWMLRiqSHrSWFsloxVNeVqkj7Z77ppOeq
6IvXgzA2EQ0YJalqC/bGJsON+6lX70MaRTUiWV5FUeXTACrqSkpFdFAnV+PW6k3W
ago+PyxsTXPI+5v/I1cbJ1wPBUmE5ORICZ8nG5fg84gAQSXuG9RW4ByXtjtfGjsF
YppEhe2+pcjPBgHWTkFuADfr7qWe0Q==
=oWab
-----END PGP SIGNATURE-----

--4j45tlwdfnxrvonm--
