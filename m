Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF63C4452B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E0A310E78C;
	Mon, 20 Jul 2026 07:15:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jpvlXEEo";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D75210E00B
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jul 2026 08:55:19 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-698a9f11776so9690278a12.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jul 2026 01:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784451318; cv=none;
 d=google.com; s=arc-20260327;
 b=Ua9DJXlH3h6Q2AbxEeWPycl/+t/CDK5gIimOmZInjTtobZcd8gL5S/vEnJmbZ9K3Bn
 KK5mWIDBKUQHfGkgnd3aKepsyiSZIRH8Rf4cyanVsFbDc+2ClA45l9dwXUn2KENq0SZu
 mh9WF1b6AENJQMZxMf+Mpt20jSAYa+6209DVi2aRP4zHjKnHpCfJ+L+UqfotUGwxMO7+
 4QJRoyiAjW8Abz9sdNGRmCYLSHMowis114QsTP7ukpBDXksP8XhCtS9+C0Z6oCndzkHR
 nuB+paAT/qefNwNh6WHQHL6S/U6szSN3+GgIiYfC5gMhZjiMScMmKrIUJ1vIRom64Mug
 rEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=CiiLNCG9U/RvgKCEYl1D89/6BRrsPRcsTcQYsj6zRSo=;
 fh=hs9oynQb3YjZT40omR8IZyt+l0QN8nu4Bye5abBVWug=;
 b=cjizHu2fFKMFRv5b5PysKTnrZo8IX1jNlxQFfqzuMNipXH51kUSPyokMCRgZQiJp3T
 xmilej4WquIOgeJWM0rd5fyoIEVknh+MZYMuX8AFG/vyumqHdYamU7n0AEM6BkMEWcTU
 IUfLVWv1s8NlCJ849geAic+BcxsWaKH8E6X5OOKJrhC7D/lq5mZsS3zZaHXD7xAXBr7v
 HZ1paJxtQkzTIZ631L+czzP5WtyjhDnHeYPY5ak/lZ/z2oi89brlXXCrkgsOtjiU86Ju
 /SSyYie5Be2knNyrSEWLQEf/YgowDVKmW7f3uBws19CUPbKsrXOf0YYe+3PVUJ0a/X8m
 SQaQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784451318; x=1785056118; darn=lists.freedesktop.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CiiLNCG9U/RvgKCEYl1D89/6BRrsPRcsTcQYsj6zRSo=;
 b=jpvlXEEoVLrBVgXSHAOs7I+L/TnxVtAigVk/ICQ+7lUZRJlKw/vq0j8uub7k8ZGs44
 OjL+cdLzJCdzDIdd4+3JxMsYamsjbV0ARYTqZdwZN/LXQ7pyI3m5FavBazYQ01BNJcW4
 QCBtB/WHFy+9XBEAKOOTsrkxjSy87v1vCcQGaki3JQEmbGNf/+F9hGrzvsP9HaQvTqGR
 XFnIcKYNvOlZtei0XFNrfpzgIuYTQm/BdkQaJgUJjf3ilR5CjjLXN6DQ+E50mpmkuYVA
 rxgUT71F01cTu7agYnsVDt+iMJRYUfIQPBLWxVGZEN2X8Wn4k+FfAvSiGhRHy+sE9SmT
 Jn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784451318; x=1785056118;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CiiLNCG9U/RvgKCEYl1D89/6BRrsPRcsTcQYsj6zRSo=;
 b=TRkQ6ut1vjWeKl6dM+BCuDPjsE0iD63q0dEvgFdsPQBd72GpBhLUz+jLJFSpmOouMB
 vb6M/vekq0cJS3MMYTly0LEB54ET7liPCIlNqUWKa+VRZtgWYUJSjjC6NLcDzvOBa6fE
 UXURFPBMfvzV4mtt6Hn9coBhZgq496BRvpHyEMMRg30XuzoQVl0kixA+U53s9C38G7Ho
 +BYWEBP+HReSk7+jAxsqdHCXL+hk5AS28hUJig3MXwwm33isSoFAW/0AKWywzFXUsG6R
 bkjuZN2D4qDDd8XgA/MrDLGf7spcC65Yft3OWvLvp6nYRk80X3Crdk8xprIZsQ4L320+
 44nA==
X-Gm-Message-State: AOJu0YyxGmMNp7sOvfUSXXM8IzG4I5gFKmvuB7LP9qtSE6xIqJeR4McB
 fC4fg1mbn6KO/CBAxNqYEdyHRLh46vy5G8IX0M+MlCBC2hqO2hXhSK78tGHkn4i4+50sOJ8+so9
 wyPQJQguvU/g0h2XMUawhDdAneaqMiPj4YDEj
X-Gm-Gg: AfdE7cl6Tfc3wZHzw5gVoa2O6v6V330Dh8M5W0UTaVnQ96zf1ciUPzDNBzfKcvHNy+d
 J0zPMaXj9Zbt6aI7Ubb0GMyjLsbZS1pbNJS9vqWUGb8Ykp2v4YCE+ppBRGKeIQoXmhqW75FT4h7
 yWh/hPW4LeM7KjT+C1KCrXrm/uR0KKFgUEXQVeymUF4VZ4WDwTrr0wkdxrv1mjsgYC1on+jC5nv
 YtsJBfFDZPvXfZzpWh0hZzX1fFNrj9p5WZIXeKzcjK6FWs6DV7w3FMRoEdPvL+V/Xbm0Y1KUgKs
 IXIZ22jKN3a75w0qCw==
X-Received: by 2002:a05:6402:5292:b0:698:1504:bb23 with SMTP id
 4fb4d7f45d1cf-69e652f9099mr3535086a12.29.1784451317863; Sun, 19 Jul 2026
 01:55:17 -0700 (PDT)
MIME-Version: 1.0
From: Mario Mora <moram333666@gmail.com>
Date: Sun, 19 Jul 2026 02:55:05 -0600
X-Gm-Features: AUfX_myK84FtmR3PK4mKZpz-RC49T918hTTsHH-X3jPynt5cFIQ4vJtgXuKNErs
Message-ID: <CAHsDOAabzP1d9FRwn0ixUBfoEvALRkGPjf4Zsyq8TiuWKanhWQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amd/display: unify HDMI/DVI/DP SST HPD debounce
 delay
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000eb974f0656f2f216"
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:21 +0000
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

--000000000000eb974f0656f2f216
Content-Type: text/plain; charset="UTF-8"

xoxo

--000000000000eb974f0656f2f216
Content-Type: text/html; charset="UTF-8"

<div dir="auto"><div><br></div><div><br></div><div data-smartmail="gmail_signature">xoxo</div></div>

--000000000000eb974f0656f2f216--
