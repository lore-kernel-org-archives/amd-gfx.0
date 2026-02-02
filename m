Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8DCE7DEF2
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 15:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 410AA10E4F6;
	Mon,  2 Feb 2026 15:24:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XzFpoDw4";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE14410E4F6
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 15:24:47 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2b8095668ebso120667eec.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 07:24:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770045887; cv=none;
 d=google.com; s=arc-20240605;
 b=lDXaSH/9D4Fj7K+5CftpEjNbREuO29lOw89cWN9DEvVFlQHv12y2xIk1L1+LS5Kl4H
 Rh8QYwMBRFist6RUGAuQNA6LygnU2jdbe2kEUWo/nygRM73TTac+OsxUd9NsLmujiABZ
 uNMvDrNwR2YXkN2xujEowywr6UnIGUsaan9ObPRUxiXICd24/ZGBSHOk9YzCgMFyZCIz
 hsjxoi6uBMY8bgY+dVcyk5FFo9ScTHVUOe2+kVQtviuqFq34vVxqLEUTduFab6t+ALCI
 ev20U7r+cQewdH+B5zW4l1SJ7d7+0zwsHaHpUIoFZuddBMstZ+SvDmtcrxR6iQusgq7C
 FzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P1RXX5pBZr4vOxuQ49vdAedx4SsqZW6cwnAHGDl/pDE=;
 fh=79Gpq17Cf1ukndWqzoxKcCqVnVgPFSguhZ8OvfLdA+0=;
 b=IN8LLo8+U1ljHEFQkytsBRk1Y2SbQoP0uH7Lm8ldmtoDf0NWUJo/UvhtytadMM8415
 orN65/CGaGTG6of4gmHs3WP0++AnK1jpBplkr387DqwRGzK9RYuyNRSYs8tQFhK6erwb
 EPF5492Py0bF15HdK6bYjRDDehBgVtKdYRIzYA0+rH94HqxQn0OJURiYzoX5X3mjlP4Y
 HGhuoBmCG6aOSvjp5/m7Kgvc3+us848YfOAUa9wjKEMySVyLpvrPVW6chsrCbOj2AwHX
 kd8XcCSf9A6bT94g8WF5rSuGQ5pdMJ63kg4G0F2QN/GzbM6ERc3rabk9kn4Gp+o0Tf3N
 Mf7A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770045887; x=1770650687; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1RXX5pBZr4vOxuQ49vdAedx4SsqZW6cwnAHGDl/pDE=;
 b=XzFpoDw4wxPluQOYR2ehlQalhNIsD1XkHa9puR94lXvmo9hPBZ+xJcpgeJ3icpIwqN
 wV2nykhI2NmkrBm/K4V3E24kcDz6NIylhvAQsq6J7AUnIKad9tDYjmhD2Bzrku0RJItd
 W/0YyCLpsWmRdwFK/EUSP1SwypcPs3JPnEpbZle6jUCHIIOuvYEdIJ41/0XNwjVM9TZ7
 lrBIRsWT/PrSJ0tMDjwwq7BXfiakx+0GzjuCLiwTZtggDZunr88bPd31hINBrFmvw3ic
 HAPBoGF4Gd8avmakKV+CW20RIF7zpJ5CkUxyvzx+aykSViBj0VorXGLhhU3H3qgBkWai
 BSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770045887; x=1770650687;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P1RXX5pBZr4vOxuQ49vdAedx4SsqZW6cwnAHGDl/pDE=;
 b=lppfAK5KNv7SoZ8nLeMYHg813mFKA/s24mSZORmN52KrhgCGbiJpTbPz02MDdpi/oy
 ihCVYIERcrXO114UfcY9uBTw7rmrxfzYoxXRBbwsYvDniBVGFkrfG71Zv3rb/pgr/TBm
 dFzBOmSOqEPJlNW42J12ApfWnhz0VGdnJbS1QGDMF2mLesUv3yeZ0P8spB0FiHUBkVfA
 sa3rQGSS1uAwZffx4dEMx8Nh8wAed9CZjAJ9i3x5tkDmiuYYyY6WA1U15kfIjZdQME46
 3P6XyeWp+4UHqsPMygAWuZs8/iXM7TcOZb7eM3HEsMCDKftPPDKALKlJpwu+58VDydkv
 1q2g==
X-Gm-Message-State: AOJu0YwkjC1ZsVsHDzS5+6cO02YFR7dxt4qXPuJa6X0/BJlkfh2TwsKu
 1lFbqdK3hI4vuvTjjQl7dN6N5WQrrQQM4jwgoJVc9Of6zPZ5QD2r6kpJmTl6YAqDbSLTeODGA/r
 k7FvYuJGcNGMd53UsjYm1+JmAOHMpHvY=
X-Gm-Gg: AZuq6aLEl5JI1TT70mxK1iwTITfVcet3fbwvwUr9WvdHe00bqZjS/ET4siFQ8HIUDao
 GTTq/E7DvXZ/9CGvycqg28M+5ZjfjE3KNHYyY72tOIGrHlZz78HKvrvgQ4QVzzKanBFiwn/6jUh
 h4QPXkCCdoJc/M6DM8o0XJk7DancTHLY+csTtn6EOhzsWY4ED+SpmOdC02P3s7CaUaI4z0mivNW
 SJGE4V+vuDceW8EdUXIYcB4/vR7Z5UC/qEyqqB1n2prB6YJHfyUt5cPTolkLIyQWAm5Lzau
X-Received: by 2002:a05:693c:300c:b0:2b7:2bf3:ce06 with SMTP id
 5a478bee46e88-2b7c864df5cmr3253946eec.3.1770045887084; Mon, 02 Feb 2026
 07:24:47 -0800 (PST)
MIME-Version: 1.0
References: <20260117095421.12700-1-decce6@proton.me>
 <CADnq5_Nrp6xsEOgs8PVy5cmO3rV9QhdoyBDB6DdTdOtXpmnZ6Q@mail.gmail.com>
 <20260130221743.8667-1-decce6@proton.me>
In-Reply-To: <20260130221743.8667-1-decce6@proton.me>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Feb 2026 10:24:35 -0500
X-Gm-Features: AZwV_QhzVpB9PgeWe9ztmZEasDkV5488UywGJSrg9vmlVkgzicT3VLkWFD_ERFY
Message-ID: <CADnq5_Pgw5pLYh87HgcFcue96mUVwOJLrtXVMtWE9QPLaCuZtQ@mail.gmail.com>
Subject: Re: [PATCH] drm/[radeon|amdgpu]: Add HAINAN clock adjustment
To: decce6 <decce6@proton.me>
Cc: amd-gfx@lists.freedesktop.org
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

On Sun, Feb 1, 2026 at 6:12=E2=80=AFAM decce6 <decce6@proton.me> wrote:
>
> Thank you for the instructions. I can split the patches later. The revisi=
on is 0x00, is that correct? I did not check the revision seeing the adjust=
ment for other cards only checked either the device or the revision. Should=
 I change it to apply only when both device and revision match mine?
>

Yes please match the revision as well.  Thanks!

Alex
