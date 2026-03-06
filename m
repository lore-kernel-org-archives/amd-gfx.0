Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54CCFD004E
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Mar 2026 14:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4E4C10E45E;
	Sun,  8 Mar 2026 14:14:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qau6CML+";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 759AB10ED4C
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 14:03:05 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-7986c7b8076so101156527b3.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Mar 2026 06:03:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772805784; cv=none;
 d=google.com; s=arc-20240605;
 b=iCntaQovjcPOlYCK2Cp3jgmQm4SAAvuHSSvVBgjfCij2vIA2enqCzkWC2JzAgQNXAW
 B+16ZI4sCCzXd57/GpchrUuZ1RukYVrw9UR+c0WE5H6Rt2530RZkSchy5udxWbaRikjd
 Gmm3Y48d4tpNMJsJh/fG+GNeIJ/dBMwlmOx84wASTuwh/2Fpdwh+VWkV31bf4QlqF5Bt
 p0INErZYNQZ4naygyirzKJy477QI9j31rTtKqf0dxg97ptrVeIl+oIDipMhDT2iJ0fDl
 /HO3T1UJ78G8tZnlyx689je7glRWRD2Rr2aAg14e9KjbFKExPypyyf6PWWH2MABQWuoV
 6N/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mKF5k211NtUeIcGa6uptRsEXiW/hV471fc5S/IDch2A=;
 fh=3gbkR29BF6PhFOjW29UIV13L4mhLE2BRy0MKPjf0ad8=;
 b=AitR3GdMqjeA2Af/AlXm0IikAb1sLiF2Kl9lgoNwsfDHPbw/FuRcb1zD5Wi/zr8+Oa
 sZEtMh7GnOyNElNkVA1vF7AUt9nm+wVVuH25d2gpue8uInq7RBYYwl7yKUEDGbhp0wKJ
 aTaheVH47LSJoRNz7iQtyHD6rrvlScvkfJwBkoonJq+jXxzeRzftoJXoHnRAHjO7YBLf
 fkNqoNvKnoOLk0mi3YCbYd9n6Tzdk6M4Esc+B8XMlDJaX2d/eph7F0bca2gjtaBDZDYa
 El2dfa0soj9NcTKH8R7wdJkItvgHD05I+3G/YLf36YPiwq6rJW/562SkIYplsxvWJ84P
 TC1g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772805784; x=1773410584; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKF5k211NtUeIcGa6uptRsEXiW/hV471fc5S/IDch2A=;
 b=Qau6CML+yiU/U6ticC0YdY0ouic7E2IKjUeEDRDWliaeooXqgKBXwRJrv3CNiI0rnk
 523FzqmDHYkI5SD3TK32EoRpOQYDdQQ/0fXnFTBMqVwNPaZsEIf0k8RPYxdELFEiWh+P
 yOd1VBsksRR1FmxGt+PjwmLAmOMoX3j6IUl1cpa1geHk1VlXuOWUavX0JpkaDoIvdQI+
 NOk0r+ch64Go68HTXDhS9d28kxGlaie2JnBsy+rtQEe9ozuMJQcLJ2IURGodeRl7B+oT
 yBKgYWfMeihQIU35h3n6v5Z54s3ZrNN1eLazHlonLBNncGXtK9JE70sg6eSgBwZtWKzX
 e0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772805784; x=1773410584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mKF5k211NtUeIcGa6uptRsEXiW/hV471fc5S/IDch2A=;
 b=uTz0/70QrYu3Kz/tFhcxP+Ya0iNiRZOnrpVhgEtMMUdJWaDbW1HJ9UKiGDuWPV8pyE
 zovBHP2kXswSFcPU3ruwmFayc6+yu7R1M58pC0nnW/2XTw0xLaPoTu8ooYvmc03S7HeN
 QSYu3rduGGn3m2RmOknBgOf524dttBCYtsslLTcTBrRofUUBmfebbThHNRLDQuL6T2Ve
 wI+0sPva4ghjo9NYxZ4xn4esCYLzAO7UHT8zDRX9j5jL3RiBOeLpL60yLoQYhAjMT++H
 AwmYzu06c4UobQSgVpeKuITx/gQQq+kw7r/ZbjHfUKRVD9m1X7cPSYnTkpwj+/0NukeS
 OHNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxFTT9awimMmLQ2WQsUbg5E3izADMTau5hga3SimiPUr+ljF7+1rsMvbhGjxaUwWcWEJz5Y7xg@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXYhtn0Azbj96NMQzo/SoZtR4jFAQWznFRLjWTUvmKyI6fW1j8
 CKtpcE32BTlaofqYnkvt+YUF0JKv1uA8jaJnG/stkqqx2wHuwyUhZNEQOlYvHFUPSZYgIbjCbrX
 J8Z44+5TrZEYKeSRkPDUH5tOpzxo0ucQ=
X-Gm-Gg: ATEYQzzYaEYcDC7PPPI87eFLJmbwQIhRDoEZjd8Fu6pcvn5YrOG6IrEzraVTOI5sIv5
 8pHT/4svqQpCq0wqE4YD5PVGSVx2mm6XmJ3T92Vzd7wNPCo3xdnpbFHmIyeJgKSRym4gqbIw2QA
 g5jIgokU0lMVIce6LxJWn4yaXAwSV1hF35K0PpLL1mupY+7sr+CUAsd4SxpeUaudkW6mYK/c1eI
 esZ+Mf6CH9KiT+LPRM9DRJVAWd4+A9dL8fq0vnClmoRDrxSpFk3aFR9x5WZRSkITuE2NV3RZWvp
 0ZPC
X-Received: by 2002:a05:690c:f03:b0:798:740f:6af1 with SMTP id
 00721157ae682-798dd6e9b55mr17942317b3.24.1772805784050; Fri, 06 Mar 2026
 06:03:04 -0800 (PST)
MIME-Version: 1.0
References: <20260306015022.1940986-1-jim.cromie@gmail.com>
 <20260306015022.1940986-4-jim.cromie@gmail.com>
 <51fed793-869b-4a5b-b90f-2ba80c13d773@kernel.org>
In-Reply-To: <51fed793-869b-4a5b-b90f-2ba80c13d773@kernel.org>
From: jim.cromie@gmail.com
Date: Fri, 6 Mar 2026 07:02:38 -0700
X-Gm-Features: AaiRm51wLCC9Sug6nG1UgnDvIstzQQFHwne8N2p7gQVCpTt4Mc1sv69X0Jjm7fU
Message-ID: <CAJfuBxxe5uJc0=nLC45JMp1dcQhyiyyyNuv06jZJX++YJaN58g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] drivers/tty/serial/serial_core: ratelimit
 uart_wait_until_sent
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Joseph Tilahun <jtilahun@astranis.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 08 Mar 2026 14:14:10 +0000
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

On Thu, Mar 5, 2026 at 11:32=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 06. 03. 26, 2:50, Jim Cromie wrote:
> > Ratelimiting these pr_debug()s can reduce the console flood during
> > bulk dynamic-debug activation, in environments where a serial console
> > is used.
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >   drivers/tty/serial/serial_core.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
> > index 487756947a96..6db465619c70 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -1790,8 +1790,8 @@ static void uart_wait_until_sent(struct tty_struc=
t *tty, int timeout)
> >
> >       expire =3D jiffies + timeout;
> >
> > -     pr_debug("uart_wait_until_sent(%u), jiffies=3D%lu, expire=3D%lu..=
.\n",
> > -             port->line, jiffies, expire);
> > +     pr_debug_ratelimited("waiting on (%u) jiffies=3D%lu, expire=3D%lu=
...\n",
> > +                          port->line, jiffies, expire);
>
> The changed message does not make any sense.
>

Ackn.  Given the narrow rate-limiting purpose,
I should have ignored the checkpatch warning
and kept the message as is.

In any case, my test setup didnt actually use serio,
and didnt get flooded by it, so I dont know that this
single change would be enough to fix it.

I withdraw this particular patch.

>
> --
> js
> suse labs
