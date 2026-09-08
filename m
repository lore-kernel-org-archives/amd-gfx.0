Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09201C79FAA
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 06:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F9310EF5E;
	Wed,  9 Sep 2026 06:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IewJOAna";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B482910ECDB
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 15:46:48 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396672b2565so896455a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 08:46:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788882408; cv=none;
 d=google.com; s=arc-20260327;
 b=UX0OZwQMKU2qJ0inWEplzDj+hipGJlcHoSKVZjgZZEwhH0+QiIj2MbMMThWnrYOfBu
 DzVuGFCDrt0wu9+zGrtAdwJJeZy1bK7T95lbsrhY6x0OaE69Gq0cUOLVsqXzc+A8LY8z
 8QlzPBZ4nC+WfYMt+1qectjd5etNvXEoa8cX21fCGkhi8udCUdb5Z3H76jATy5I01Wx1
 VrWy6lwTQU6P/M46hzD9nifptiwWtjPt8OSO7IPFiFZCfMP0V0CkHMLAZ/ml+ChOlG8K
 kSP18uWJrl/YW0v6KurpsSEOlstypA1fD/5Xxu7kJjmAFEXv+FJjn9wQJkHog0jkgRpx
 qdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WDHmQZuMHbf5qYqxvV/utcQu5YS7zXBqPLQhJFSMwks=;
 fh=d7gHVjyr+ea6pZO5NwNA5ziPdox/39AgZ0Obt1ohEng=;
 b=RFawu6pSexLYfNbZTfWThvicRd8qKZLNbN7sAzxIUVnlC2twBUnU7Xm3d+P9X4QP/7
 xkx9jVL1sqyd9b6m3/wy/NOLgs9SMeSxmv+AFlzaCG0AGZorDsP5GPZgak2wWs9TVImy
 RjvfECVmIbUC7tIQsgCw+MjadwEf9hxWNAZcVdHOaOFoecWnMQIfoAwiJwoWEbsQlWxW
 WyYWA3jtG86NXQkWbKHk388D3vBhYWLsgfGpaEtJXrCqrpL70TePNDlcVT/dVOwUiOmJ
 iRv947YhnFsAd1+0CqgzRB4/FwJ9uYSy+yaw3fKCdoy9e90P8A/M664VlD9HL08KEDsJ
 Up7w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788882408; x=1789487208; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WDHmQZuMHbf5qYqxvV/utcQu5YS7zXBqPLQhJFSMwks=;
 b=IewJOAna0gXWnvlyJO8nFPvFGugZnR95+qOueJXcSPgYKomyJeadkuwH1D8MUTNCrN
 hkkeBX+ec4NBq0T/S0CmC/E2EmGuYUqERzvM2lPmqGYwQRH7QLG1tWWhhb+v3kf5s27q
 9k1HoVBd66g8yvDUszvw6sYDs4W3HCkX9ap8h9a6JoFZDyAcQfoojiP3Nzb4VX/OEh5p
 g6tasLK6fmMaf33rMheNT1ZamTYJu6t7qCgA5vQKAkY4p+g6HTVuIvccPddSk5wBhz9L
 QUFrP7o7Ok9KxrOyvQtDGcwhw11sEzP99Yp2PWV7YE4gDfBGPBkApiicEgRpKQcMe5PS
 alGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788882408; x=1789487208;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WDHmQZuMHbf5qYqxvV/utcQu5YS7zXBqPLQhJFSMwks=;
 b=dP3X8XbPg2GdmpjOjua6KoQVTj+EuyncdJJWQ9Z9c1B596krzeMMnezy3/sX9rbGMa
 4QphdPpNEdTs/uYeGkazqNx7JMpgPQiDENpE376TLQUS1vINhN+k+BfG66ihD9sVbD0v
 kxMLCvFiGybO+hqLujErqotn9cYLsPvFOy2kMi2UA63RlP73zGtpwwgPzSgKW5dbvfLC
 pvotrNdf8uQo5eN9ufg6WZCJU8ue0iwjn5VacPJ8zwPT2WvjW6/ZLTpXDlGkd4aPnX/n
 8O9/H0D0UGDE5oApE3iDu90MkVoWYfBlwBPVJLKnpuiVJqBCnom++q3o5Lf8N/LT7O8G
 q4Og==
X-Forwarded-Encrypted: i=1;
 AKwUvByWu51cHfsbOIv79wvs3sAapVBdJK78LQdy8S+RiTokqrfRh4k4VkkDikL0K62bSV1Iso3GG2Lx@lists.freedesktop.org
X-Gm-Message-State: AFuF++lQla9Ipc1rQSHzQt8L11XZCFpeMX1l96MksDKt6hT6xgqJLz2Y
 bYFDTHcgnbP0SvG1i6diNB6qqsjARCdbtsDHrNtdPc5/z7uTB/P3tdR5/UhkhTXXOrtZ1jfT21u
 Xh8sl5qCXWcWvW5frVzs/qloaZ8xNwic=
X-Gm-Gg: AYBFou2B7skwH3EXHCXWPU0RrYCNyO72T3YfghSTlJ5071GGnk0gj8D5s8Jbb2GeiIb
 85YZPMIC8mn4v6K4hXrkNQ0q1UOHhpLc8LpG/UCqJtDr6Xa+kAPdCDx5hn5WSWLSgxtIG46py5n
 SBfT9neFwERjuBt3CPNofzdieLGvT/IQ4eUpB+onxFMlC3GihTqNiBmoQCsQKJD/1RM/n2J9iO9
 ru0T+wfwtd2cGMK7ZT3ioEOTD+TF4dLtLj8Cx+KwD+jUAL8BWduVE96PqInmrmSNSTqaP4EgLzq
 Mwgvyo5Z10VaF5rcPRhT8TW96qOC9EmdZJIPwMs8UhFIUVQNruqSyZNioZlJI8f2lJqhoztuqOD
 v6Oe0N3Lr5xp/o4+nFffKQgXg6WkwupSo7c+NIUPsi0J47jRWk7s+mIQkOt6o
X-Received: by 2002:a17:90b:498c:b0:398:a2e4:c784 with SMTP id
 98e67ed59e1d1-39b3d5c4449mr20100311a91.1.1788882408145; Tue, 08 Sep 2026
 08:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <4da62a4b-c4ef-492a-9a27-b56bd4784acf@suse.de>
 <1b3d0eb2-9e9a-4d4e-b8c0-ff966033ef03@leemhuis.info>
In-Reply-To: <1b3d0eb2-9e9a-4d4e-b8c0-ff966033ef03@leemhuis.info>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 8 Sep 2026 17:46:30 +0200
X-Gm-Features: AcwNN1UZy9klDHYXIQdjFGVCMKJTy69JyKumGJIN9nRq9tK-al_paSfA5ZANsw8
Message-ID: <CANiq72mUW5d1dOQDgpYjuKoUaZAi-im7j3v30Wd4KTDznmM9zw@mail.gmail.com>
Subject: Re: rust: Build error in DRM bindings
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel <dri-devel@lists.freedesktop.org>, 
 "open list:RUST:Keyword:b(?i:rust)b" <rust-for-linux@vger.kernel.org>,
 Mukul Joshi <mukul.joshi@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, 
 Linux kernel regressions list <regressions@lists.linux.dev>, 
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:56:16 +0000
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

On Tue, Sep 8, 2026 at 5:35=E2=80=AFPM Thorsten Leemhuis <linux@leemhuis.in=
fo> wrote:
>
> And I already wondered if I'm the only one that is running into this, as
> I reported this a few days ago already. Pseudo-patch to work around this
> can be found here:

You are definitely not the only one! I have been seen it in my CI too
-- I didn't reply here or there because I had already seen the other
replies in the other thread and I expected it to be folded or dropped
the next day or so.

But, yeah, it is painful to have it in linux-next.

Cheers,
Miguel
