Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDE0C5CFED
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 12:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F139A10EB6A;
	Tue, 11 Aug 2026 12:05:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="E+iD1Xxa";
	dkim-atps=neutral
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5F6010E267
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 00:53:32 +0000 (UTC)
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0F0D03FBC0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 00:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1786409611;
 bh=Y4eA19hx+XsZ/wBAfUZRzoJWKWMEnnMwb3FVUKdkmMc=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=E+iD1XxayZy6WobTAA1JMD9Rl5KnWosFK6dFj+E5iM4Xmfvp0YIuYq1u9QFPn3G1v
 dNJR0R7TGn4xftH1JsSAwzdunsXIuaEBMbrt0zkvKQl4oiVYKFp4+bMpVk93P8VCfD
 Q+jXw95AAocY2pp6IadaXAvglLUe8kFO52LirFfOtdpzOMP0f30e9erutdYArPNAvs
 /bp7PvZkqYbSfPJht1bQLrdasgG0ADQydbpWxOdJiLElQ7oD5Bf/ZQJoSKgrZNUtBz
 0rHMKoz8E+dmw0fkt1dz9SoF7w+YxEPp/auULp9YuIGN8r98eUEhyLG0uk/vTdE9+j
 ACD/6ioLn9gYCRDwI4tzPtlIF33FXf9oAsrm/nsWHrivLZvQKMm7rTjsKjjjah0JqI
 jM3I6db5JN7CmOz/Dnp3bsTYjjr37aaygPpXybMIhYqlXQLNBMv3LOdSShwomDOZRr
 jykygpfO57hz7q6W3ljUuWEAc5yhYMwxOm4cezt8AxHuvMQvswGoH+0wMu7cUG7kdG
 rPt4BI8XTO7QD8ee2nsaGjOPC8i+NRBREClxhZeElg6waefzQE6CHsMAGlGqFr7Bwh
 cZ/wegELYxaU4TvL62zVZc5+CCztjWAWjNFA3Yjx9nxHKo47X8FPKV7o0VI4JOh7k6
 pa6FfNdQJYcpIKhOEGVaoZzA=
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-456b5122c7cso538078fac.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 17:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786409609; cv=none;
 d=google.com; s=arc-20260327;
 b=iLEpMqLsgru7iXT4GCLdgQizWXZxBxfZyf7VgaLyy80DrwS+wPtHWsiIkvBukIn34P
 MwUizNjiXhSW6dtTsjaZckMF7INpxMjmMlGNXW7Z/A54mlTTdylhtNYZslKwEVnvEGRU
 N0h3xwUxmigbWIKP6mPM3JpDYjfQdcXrjmFPAK9iG6wxk3K7B0Ykloex/f6T3/Obm+xt
 H18yIlKHObnErpQZWbq5yNt69dRPZEU+SyQ1Oi9Uc8Fg3WHwAoM/ZCNtU6SkvgeYZcSL
 cEnmK6oZv2z8PGqq3QeYCIzLH5dbNCqEgkQ+dYZ+t/3nCahxanMreT6u+p4cgnwSH3kj
 lwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=Y4eA19hx+XsZ/wBAfUZRzoJWKWMEnnMwb3FVUKdkmMc=;
 fh=Oq5oSzOQ1XX8U7BYgdltR96ZVeXvHgTh9i0/rblw6l0=;
 b=QKWHXEIrGuSmmq+UC/r0oZnmmKkG5I7NaVzYUg3JpDvtEpSHl9sWzpHHoNxkeTUes8
 dSRdz8ccCgRo10LeIKBj9WDV35UaUfuMaHQAVcSIYb8u0K0tzrvjuL82rpd1rBlYwJar
 6+/6RQOYb4WP65a5x5W9fYkOTMoUuxDxue9B+j80FBYTqPyTnYvxnTE2zkyIVGKEd/TV
 Tgoy0PzeG3zJBMCIA8VzKLi/QXpx88Q8VACNSEwtlF7ZSBkBbmXS2iO5nkOF0zJazAGW
 SxqVnGXj9AC3WU48rBrjYkwZebFPHv0dIGW0y2EJA7w7zvUpSHHAiK62BwM72qCWvcFI
 b7Pg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786409609; x=1787014409;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y4eA19hx+XsZ/wBAfUZRzoJWKWMEnnMwb3FVUKdkmMc=;
 b=VAFB1tgi3rNUSslALiv73ksu5oCK0vot371Myz4Cdxv2PnwtuYIUydMr8psgpePRzN
 9Po0JbSqHQrl23CyPgymnFh81IsUztwNVZE+ILR0MfYJ4YBmMhh7F32P+J6q1VIzAKCY
 Y3hbYkNueZ0BNgHY0klgrTpmy/AE8Mg48SESruxXBZ4sRdCT/4Ul/zUEz8boYjk4CV5D
 29i5FPTLg8MHPZCIo86KUds2SXkMeIkCaSqk0F3wyabRs4qWbzbw7b6OEhUo7O4Q5KqF
 UnaTf3M9diDlffYmtmLjocm6FCV8MAidyWtRypN3tZLXuNYtj4LS3KmRLVBqzpjGUsOp
 0n/Q==
X-Gm-Message-State: AOJu0YyAJV446CLLvwz7pFwnLH0Ghx9ZKseijeZ22yb2GdC5w3L0Iitu
 3W/fvuZ9kqo+ATX8psOZteZy9m6FIX71oxk1zqCn9iZ6p0xQw5YerAa1i/cDzX05ycF7OXbvz1p
 qPCa2EZT3/4Ja8SN7oaEwcFVTXwAyDCQJazf3OvobloQx22HM1TBmaplK75zjdKN0YAxdMYJSKq
 0CK9aDxhEed1TLkdDbzkH15FAUP9/o/75fRqeASc0mSj7dEkulfg4Uuv+G7g==
X-Gm-Gg: AR+sD11mUxZorB5gi7xfxmnSEjgCN2QaumE5MLUYmlpq29AUV6xMJk8o6zTeETj3/Pr
 vrjCjHj8mMHmtEpgBNFwDRj+o7EShaNkaXdHrGk+inyR4cOEby1AZyKE6LEt3yVFlgProKSX5GF
 3RXfaq+SWu1A0kOaau1FSHtkcsNjWswGcAANlb27s5kTqBom6GXhP3IamkSWI9kc+VM9oNzgggX
 OnPC30bs6a5fQSkH+M=
X-Received: by 2002:a05:6808:1a19:b0:4a4:66f8:1279 with SMTP id
 5614622812f47-4b1efd58dbamr1330821b6e.1.1786409609711; 
 Mon, 10 Aug 2026 17:53:29 -0700 (PDT)
X-Received: by 2002:a05:6808:1a19:b0:4a4:66f8:1279 with SMTP id
 5614622812f47-4b1efd58dbamr1330807b6e.1.1786409609432; Mon, 10 Aug 2026
 17:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260806143408.979209-1-mitchell.augustin@canonical.com>
 <20260806143408.979209-2-mitchell.augustin@canonical.com>
 <30d3e377-cbf3-4ab2-b7a1-0557b6cdb690@amd.com>
 <CAHTA-ubuVAMn8wnrWpBvnvMd6gH-80cSygbmS5Sy-AhU+Oy0XQ@mail.gmail.com>
 <ed48a0e9-d32f-417f-8066-c74aebc319c3@amd.com>
 <CAHTA-uYkATo+Nw==rioAeQXni5xmUBVw5fMbDikT==YtEkpMHA@mail.gmail.com>
In-Reply-To: <CAHTA-uYkATo+Nw==rioAeQXni5xmUBVw5fMbDikT==YtEkpMHA@mail.gmail.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Mon, 10 Aug 2026 19:53:17 -0500
X-Gm-Features: AUfX_mxv1BNZWySiV59P643MSkKMBGCFRmBLsgAnpw8d3suUgjDk_LalB_U1zTg
Message-ID: <CAHTA-uYY3x3R0gJcMjkJwoZ+Gsx6B22cQHde1PE8Lq=TpGUanw@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: Do not enter PSR if multiple displays are
 active
To: Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 11 Aug 2026 12:05:18 +0000
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

Hi Leo,

That series did not fix the bug on my ASUS ROG Zephyrus G15 running
Ubuntu Resolute.

On Fri, Aug 7, 2026 at 10:29=E2=80=AFAM Mitchell Augustin
<mitchell.augustin@canonical.com> wrote:
>
> Perfect, thank you! I will apply those all to my Ubuntu kernel and see
> if it eliminates the issue there (hopefully sometime next week).
>
> On Fri, Aug 7, 2026 at 10:18=E2=80=AFAM Leo Li <sunpeng.li@amd.com> wrote=
:
> >
> >
> >
> > On 2026-08-07 11:06, Mitchell Augustin wrote:
> > > [You don't often get email from mitchell.augustin@canonical.com. Lear=
n why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > Hi Leo,
> > >
> > > I am not sure - I have only personally tested the latest
> > > Ubuntu kernel based on 7.0.0 (7.0.0-27.27). Could you link me to the
> > > relevant commits / mailing list entries? I can read through them and
> > > will try to give it a test soon if I have time.
> >
> > I created a 7.0.y based branch with all the fixes here, see the top 5 c=
ommits:
> > https://gitlab.freedesktop.org/leoli/linux-asdn/-/commits/lileo%2Fflip_=
done_timeout_corruption_fixes-7.0.y/?ref_type=3Dheads
> >
> > - Leo
> >
> >
> >
> > >
> > > -Mitchell Augustin
> >
>
>
> --
> Mitchell Augustin
> Software Engineer / Tech Lead - Ubuntu on NVIDIA DGX
> Email:mitchell.augustin@canonical.com
> mitchellaugustin@ubuntu.com
> Location:United States of America (Central Time)
>
>
> canonical.com
> ubuntu.com



--=20
Mitchell Augustin
Software Engineer / Tech Lead - Ubuntu on NVIDIA DGX
Email:mitchell.augustin@canonical.com
mitchellaugustin@ubuntu.com
Location:United States of America (Central Time)


canonical.com
ubuntu.com
