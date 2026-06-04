Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54DACD6E6B
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 13:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6193D112805;
	Thu,  4 Jun 2026 13:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d0juI2/z";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE1ED112805
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 13:21:06 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-304d3d3d8f8so88556eec.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jun 2026 06:21:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780579266; cv=none;
 d=google.com; s=arc-20240605;
 b=YtR+LAHlExMmj5q8io7BoClLq2M4WZ93p9CTnzdU7/Imrnqvi3Ryd3gymF0dUc/qFK
 lSOzt+HAbtgxY8PiY61h0ZVJS3GAscfSxGqQ/hGRnz23OWaFHUehVKroEeZPmAHgyhfB
 LumO9jeEx6b7kMZW7myRjCTHg3HI7e/zXw3P9+WXHmd4ku7mMOsukC6c57xXD1tEw0mA
 46xEjTBEpW+INNgVFTCd9jWmT6dXOjsAY6ZUdbdupcRnhqRS2RImb4j8+0dg413mJr//
 6UzJT20bzUQ7NYidwpqkGtizaEMpQZOw6GEJgFDQdRwctzltzLlmSJy7cKuPEOHiGcnL
 659Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GVpfbT32R/82qSV+18QDKxGtI3kc5zmvjXoLt5ITgqA=;
 fh=kaErKi6AH0uBn4YQjkNtTatYELAvDPFYWdm/pD4sad4=;
 b=XrOOZd3xmYnDoYXK5F+QmU1oM47bCDeUTtEME31TmsTqTjUKALws3QtG8fzaQ1DHmm
 xUGnnIHXirniz7aKN6yHTqbnW9O0PkkMFUf9EC0ouexu+Jf4cTrC5AwrKMuH3SZFza+k
 QiW7cMYl9VBl10JD5H/GZ02qXW65TNvlEvwR1K6DQU7dMrs6yr3IyN3vPDcseAIkmuCD
 cKXjawvD6H0b3nH26KbGuCah/y8e+xYCzIB0S1zCjNi/OHigUloNZZKB/xLwlDaf4Cx0
 5vi3JXys3kHlGJy14YG5eidnSnt/28io1nfPZuBW4wWZmT8GQCZzE/joLs450mHP3gk2
 /0Rw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780579266; x=1781184066; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVpfbT32R/82qSV+18QDKxGtI3kc5zmvjXoLt5ITgqA=;
 b=d0juI2/zIx986jKeG+0FL7vY25ajGwRdAyeKLNDmaP56kmxt5YewQVyHeYZASolnAQ
 XMUTY+FdpTSoeeQzWwKDS9R8flBOxsnmAPd0cQcMGuRAIYVGxVmhUedNkHF+u8mZa9bH
 Prm+0KO5m5CPpOTZQvd0C0BJ+yDYlzw+IRfsuPnnjt+5sU9fjifKiR/RGtmRarW1lkPm
 IogAa/D/dkH1htNGieauTtdMQsx3mqwD3SfK3CwgPghZ/vOLGoSJjk/szvdLnbosGKOy
 NrAtMKk60LS4KUSRHJrqNiXWzEYzQw8oEET6Bf++2rsPLqFt6rnhH/qpqhg8xMl2yAsM
 2YCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780579266; x=1781184066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GVpfbT32R/82qSV+18QDKxGtI3kc5zmvjXoLt5ITgqA=;
 b=n6eXdY7UsVEHM+Ho0ojsG7EKEIq1SYO70pn6OTQDfkxXA4+cCplC2Uc31e6BdNF8jG
 yrrCo2pPXrT/PxRKDkjF1rbi4CADfNI6PRyi3qYEO2sOeVLna2ElaC/qS11R/fO+b0MO
 fqtqSifqACjme+NRW2EjkBdQsfVK8xkYRlP1MQoes1PXnSKUXR80shp1iCAgscCkwHRh
 3IwrQbJXAbrCq4pYUhR5BBCB6kZY/S3K+qdpSgG+OwrbSkUgPUXKBOk5q3LHPIY5Zl4H
 S8uwBGMOUeVTNDx01XpBX4PDnduV/+m2Eik9kFIvr+kjr3v57VFKlmiNltO9knCi3aV/
 8VKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8otLtKTjW3ZKjwGT2XKoMriNevwknlTzZZFEp/NPgvMr/OzLPB8YfCUvuZEYjQ+l+1FQdYQHSd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkBrApY6ZXyE1JgxD+cRZ+6lLy9MyVBOKoXbm5veWp+tLx2fbX
 moQUmvEXulRb6Z9GH/zjtiQKA3Do1wyTKXhelNaug6ZTSSBS0OfUTTGB7cdr05iHNkBcEmXURsX
 Hvifec4FgF3+Pu9u22BvgITxS0VkipHg=
X-Gm-Gg: Acq92OEsn8dsCzKvIPBfvmSY6CUkE9C3h435//K3yPiqYJ27IOuRdA3Vk1Tn1O+hgOI
 uI7FsBWI3rUOygdfeayhnj5ty522pKPEUYBe93QDja5v4fJMUxPa6YJ09KNIg+htM7lUivKZ6+2
 tPxNo97/hed+kXsj9c3KZQ3HIXrJ9XnoJ0vqDjhb4cINMzVCFrQBKEPl1YIS5SIqLlG8PrxbRj8
 FqA3KqZq6IQLRr/VJU+fqD9wy//CtcOvSTJ52AuWJDchI86+ArAGRcWrUl2x/U6lIUCRVH0yefE
 Ty+D2eqq15eYM+Q6S51e/VOD6Mqt+Pd6uJSyrJt+wMs0eHIs07YP0XNlhbVeWkVohXjbt3uN5js
 4RWql
X-Received: by 2002:a05:7022:f9b:b0:135:1b3a:bffb with SMTP id
 a92af1059eb24-137ff5987ddmr544213c88.0.1780579266081; Thu, 04 Jun 2026
 06:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <44069eb146824aa195312f5b02c49287@valvesoftware.com>
 <7a9021cd-fd78-4b0d-846b-135d0d72224e@mailbox.org>
 <16231b1742004f848af243ce398281ec@valvesoftware.com>
 <ce51243c-3b98-4f99-911f-70dd0b860da0@mailbox.org>
 <1c522568-1d5e-4210-8f25-1aa96e0d3c3a@leemhuis.info>
 <BL1PR12MB51447AB016BB28843BAD0216F7092@BL1PR12MB5144.namprd12.prod.outlook.com>
 <af4dff0f-0c62-4a7d-9a3f-fc029c8757f4@mailbox.org>
In-Reply-To: <af4dff0f-0c62-4a7d-9a3f-fc029c8757f4@mailbox.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Jun 2026 09:20:54 -0400
X-Gm-Features: AVHnY4LjJNxJVvMBj9GVxXTCQGY3mGJk_7vTLN-2s2YrwHEyFdbbXxgb1Bauqxo
Message-ID: <CADnq5_O9xMagapKQSO-6waXtmmFkDV-47ExVaNuiZd2xVdhefw@mail.gmail.com>
Subject: Re: Test result / finding of "drm/amd/display: Consult MCCS FreeSync
 cap only if requested & supported"
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Pei-Hsin Yang <peihsiny@valvesoftware.com>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Li,
 Sun peng (Leo)" <Sunpeng.Li@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 Linux kernel regressions list <regressions@lists.linux.dev>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>
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

On Thu, Jun 4, 2026 at 3:59=E2=80=AFAM Michel D=C3=A4nzer <michel.daenzer@m=
ailbox.org> wrote:
>
> On 5/29/26 00:02, Deucher, Alexander wrote:
> >> From: Thorsten Leemhuis <regressions@leemhuis.info>
> >> On 5/21/26 09:09, Michel D=C3=A4nzer wrote:
> >>>
> >>> Note that some kind of short-term solution is needed for the regressi=
on(s) in
> >> 7.1-rc.
> >>
> >> Yeah, that would be good. Makes me wonder how the rough plan to realiz=
e
> >> this looks like? Sounds like Michael's patch[1] that was discussed her=
e is not a
> >> good option? Reminder, Linus ideally wants known regression fixed by -=
rc6,
> >> which is why I'm asking.
> >
> > @Wentland, Harry can you sort this out for next week's -fixes PR?
>
> Looks like this regression will make it to 7.1 final?
>
> I filed https://gitlab.freedesktop.org/drm/amd/-/work_items/5286 3 weeks =
ago, and proposed a fix the following week. There's been no reaction by any=
 AMD display developer.
>
> This is pretty sad.

@Wentland, Harry , @Leo (Sunpeng) Li come on guys!  I've picked up
Michel's patch and I'll send an update -PR today.

Alex

>
>
> --
> Earthling Michel D=C3=A4nzer       \        GNOME / Xwayland / Mesa devel=
oper
> https://redhat.com             \               Libre software enthusiast
