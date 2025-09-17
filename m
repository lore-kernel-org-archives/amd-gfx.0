Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCA2CAC59A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 20:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D048410E07F;
	Wed, 17 Sep 2025 20:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CyPDJ9kN";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DFAE10E07F
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 20:32:22 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-265f97930baso322685ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 13:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758141142; x=1758745942; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEJcdy+5MVUyQL7jPZAhapdQeE97ZQGwmXbGzbeBXag=;
 b=CyPDJ9kNkBFHXzsFrBuowG8lIR5uwpVJHuOxAjZAHVDMizKELp8eD9PFEzmpcSj9ZI
 w2aC1eHwtOnETCqJRGw7fNHOvzQuagGBhxI8dBTrFl1mrc1FgsAvJ5/rivvbXxal4r7u
 D1UxAuFM+YtZCZ/4lO4iBWhbKRnwT7GCT8c40JrdshtaU5L77fwXs5JR3oMP8MoZkZuQ
 ZIPr+AUzQZ0a88nlukRDQttSfL+LBGOMmUaK5bq84DgNMUZ6iMC+jlhpA9WDPHtbvoiK
 +hR5bALjpP/XvUf6jzZMH4WXHq/uipVdTTZij7jF7OI2IeoObzGOaIpjnFLRcJ3KbWd1
 TiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758141142; x=1758745942;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tEJcdy+5MVUyQL7jPZAhapdQeE97ZQGwmXbGzbeBXag=;
 b=fkE77+qIBaZEOPNc+IK46iLY28AYb4NLFoZeTS7arGLmOSNGdl1+xBkEXWChpguRZ4
 IByCOQ/saeDs04rsFZZmKTtM5IWG+rfmASQdLG6g4+tj0VkmOkLqXulXfzWycUiaFQcP
 7WJ3do8wNB2JUt/DTriUF/R9IM/CCh0zKseUa3SpnafM3ZgFTUJm/buj4NP6z302M0Wo
 yJJivs1dVL/SOPyE5LWRbpd5mNrEUol/af82/wKO+I/iskpwXsvvMeXOfbu49zx5L720
 IvGRlgahc5fkCu2gNEPhBrk5eapbYrVVHstYsp3dwSQVvJaYvKemDuCADQKegwmJnvH9
 gLWQ==
X-Gm-Message-State: AOJu0Yxx5XNm9y73fP4oozGfSsWB4fc/CeHOTDop5hJWm6rZfCVkJLEO
 /dky6SQAL+di52EgU5EesizVIgLLUB2Xig3U9AEUgEU+YcRReE5l9UFXbfUFYzJZEoDS+u5JOVw
 SIHWsvf6cEgP+po1joYQPyVlvtyYfaKU=
X-Gm-Gg: ASbGnctaiFDO83iAA9MyEa2vFvkUM3kx3zlNJVeywXStOAmFOLyWJgezwMrIzBQNdwk
 dJoYpB17UcxJwz1wGxKZHNdI7fBvb9QBIWyHEjqZ4ALgbw6n1K6WSnRY8MHkwMl0K/QosscQFyD
 FTiKheA9Z0EGn7mJ4tHvV6nIV3GZ9bg2DX20ldxtxLWWQBpu9FULYfSE5xR7ZkIq3FCkpdA5aFb
 vDcaMlx
X-Google-Smtp-Source: AGHT+IFKgZOStnPEqJ4GRII+2Cp21g5CTW9dqlPq4lGAGrjdradLb1YDo5gbiAyZQ1ghU014KaYyYgBTsu329ygqIl0=
X-Received: by 2002:a17:903:111:b0:253:a668:b638 with SMTP id
 d9443c01a7336-268119b91c0mr16439225ad.2.1758141141801; Wed, 17 Sep 2025
 13:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <DM4PR12MB60644B81C64090A93DE19AF58C17A@DM4PR12MB6064.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB60644B81C64090A93DE19AF58C17A@DM4PR12MB6064.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Sep 2025 16:32:07 -0400
X-Gm-Features: AS18NWA3zI51lpeSHh86StIIn4CK5i70D6erNbUhi9EtbgDk6LbZEaOpBTCh8MU
Message-ID: <CADnq5_MLhTbsfLxLvF1W6OA541bkfmbfYtC7NB0uGTU6hpeaXA@mail.gmail.com>
Subject: Re: add missed PRT flag back to gfx12
To: "Wang, Joe" <joe.wang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Please add:
Fixes: 6716a823d18d ("drm/amdgpu: rework how PTE flags are generated v3")
With that,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Sep 17, 2025 at 4:39=E2=80=AFAM Wang, Joe <joe.wang@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> see attachment for details. Thanks.
>
> Best regards,
>
> Jun Wang(Joe)
>
>
