Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DF2C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 07:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 852FC10F33D;
	Fri, 14 Aug 2026 07:13:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D1ctloHi";
	dkim-atps=neutral
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E664E10E027
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 18:26:31 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-92e6391b114so15324185a.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 11:26:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786645591; cv=none;
 d=google.com; s=arc-20260327;
 b=Uz9MqPMkvlxClFN7ok8o2yOhsVWixC9iujJWiA3aRIfqSv0cY2bmR27Jkr5JrAg7wC
 gqI7nuZPG9WvyE6zbubNObl20c6LpS4C72oFullrY2D8mhivaYyfau8IgomiONs42Wor
 K4AsjoeeD6MVy/9jj5YSafJDXf397XfAfyuSF094R6R9wZFDQeGf0dx/XvtNqTi3p9B4
 qz4jIhi+yeXxwAqDNCQ88yWdD2VzNaUnj4v6LSp0+rNFrp0jt4KZ2YQfS0o4kFzpt+MX
 tMMAxyXL8uas3vl9ZhORIv3/jOVnaoKJ9OUf5oH5lb2SFSp6FrouuZUgUDLoQ0w8WE54
 yQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3GdkHDTH1pSo8fy2lfq+SzZj1fBJy47v0jj+oNnZRWc=;
 fh=DWbP4ckgJJ3wrASNcOnoDXn1Wo2NHE49NKye1ErrjJw=;
 b=ryyJ9i+D2U92xbn7otcJ1NDGJK9h+sO6BGPEY1XRKhahZvqm4djjLtBT2vgQzoLgUo
 KqmUTD0QOGHhe7GIE/KSlKoXaihFjM2Fe3Bj3cLS0yi0naErPq+NlHquT5ax3VTFr79o
 1GBzzEPPWszmLLYYxJuPyDHEFebd5+XnvyBh3xZrr4NXF4VRFyPr3pflEh89GZJR+JWt
 EytP3v1wCjzfKlrUoHve9F5v6++u3RryLmmQptLye8OQD70Yr4Od1B5/qBlbbIoUkrU0
 BBlIREr6B063bXC9PE8HKsBdHNxKqyavtYe1l/SyfmeLiz/Rh6+oTO83UsibUva9uDbQ
 MBJw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786645591; x=1787250391; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3GdkHDTH1pSo8fy2lfq+SzZj1fBJy47v0jj+oNnZRWc=;
 b=D1ctloHiCqwgGMg8qNDWzN3yTksBmE9+/096annf7WKroDbBE2LTyuREJEw/pQ5fR2
 UScQ2pkT7q9Ai19JD29DP56vCGzCwOH2hnEYyLZxK+zQsAnSLm+xrhOLW+iNBE+hqm/q
 F7Q0H57hdkzpkK5RGyAbcSa/9Tt273ySVvk9Quyabqw5bRee1uhzP37E4c4tUcbU1AyN
 pgFL0yN7gdrK1WeLQ55mT9HYnixjkU8Q5Yp3FBZ+6UIOUpEWhSUDTSgXNz5BkG1QbrRa
 eYejouFPKdKi5q02uMWwsFPFQTYuEDjf7fgZCXt0rBvfDRlnZTVJvI8P/HBFFwmJ56PL
 Yv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786645591; x=1787250391;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3GdkHDTH1pSo8fy2lfq+SzZj1fBJy47v0jj+oNnZRWc=;
 b=sPcDZcXb0dSYD8zWnhbF5R8ZqKL0QGxAfPM1I2Ziv8wh/mqfjMcrIvhBdFtpx4yU0q
 V9/bQVBwCU7Z5vIiu+iagPGBWArgIePorvQ+DRwI+ZaOHEWBmudUGyAW4ut0frdwvpDt
 tAW+IsEFWuugQl/TarZ0RVgRFH7mHgAfT8e9WcFUqecwoygOpiwyknHkkrgYR1kdskLK
 sZXi8da4ZbtheWUZJj02vF0AZDubGzuEtYrgCNfvPhO1C1QbxHUH7CIRexM2sak0crze
 UW7dNdKP4+yXqDYnGrLqSYIKxbFD2sQD0ZqBSFzowapQVZQLfexPuQ2XblxCvR+RiHPw
 iZmg==
X-Gm-Message-State: AOJu0YwVrvfUtgdbk8IfCQCd19kJXc9FLJJPwHgJo3vnyffT5W1FGwxv
 FFIsVGt6Z05YhwQZZLGTvPtRAq31XhYrS1GdGm9Gk4BmGjBSsywa3DPDAZxDlb51q3y/tt7ac80
 cTvErqXb+350MGmcOMukP99sZNnPi1+0=
X-Gm-Gg: AR+sD102BXeedmZp8oanuSVrhuEUYNgS4mu9jhxOwZVL38cx1tHHw7U1ouiN9saxbjB
 H/ztZB7qqSO6kcBdBUfpMjniJ1d0+x1t/rEmDw41EKl/Wc05Fx39VbhywUhNGuFZU/LfCvHZhKX
 DomeYWjVnLh33AJ0S6/UntYs0WPNoPQADFNQRk2y++i1iMSNhxHSDJ0Tts1gCxWgTRORoltx+KB
 Ycl55p7xqPNP41kT4I+6R6AoVZYn0iMKktZJBooYkzKHr/7MUySmqlKLftmi78KZ2yK6vjyi4XF
 erHaCsKaoymsc4IJIWY11R7NwYHWrpMn/OYQCc/a89jxx2pDpCIjMNB+BcyubwnkI2GFXFuGQjS
 +0Q==
X-Received: by 2002:a05:620a:a40a:10b0:936:b8ea:3366 with SMTP id
 af79cd13be357-936bf853467mr676498585a.4.1786645590872; Thu, 13 Aug 2026
 11:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260813170959.22073-1-zhitaevakh@gmail.com>
 <20f0d0e6-c551-4982-9820-68169039e504@amd.com>
In-Reply-To: <20f0d0e6-c551-4982-9820-68169039e504@amd.com>
From: =?UTF-8?B?0JDRhdC80LXQtCDQltC40YLQsNC10LI=?= <zhitaevakh@gmail.com>
Date: Thu, 13 Aug 2026 23:26:19 +0500
X-Gm-Features: AUfX_mw-38zlBHu8TWWHByMsk7m551ieF-G2AoUNDG7_Z167QTQz5WAyx6YmL4E
Message-ID: <CAGJKGUzjqofpXFQqv=hwg4schv3NaZth9974NLfmwYJLG04C-g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Scale custom brightness curve from full
 range
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
 siqueira@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, alex.hung@amd.com, roman.li@amd.com, 
 stable@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:13:01 +0000
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

Yes, this is still needed.

f1b5d8f9cc54 fixes the advertised max_brightness mismatch by restoring
the full userspace range [0..max].

The issue fixed by this patch is different: the custom brightness curve
input is still normalized by (max - min). On panels with a non-zero PWM
minimum, valid userspace requests near the top of the [0..max] range can
therefore produce a curve input above 255.

On my panel, min=3D3084 and max=3D65535. Without this patch, requests above
the upper boundary caused the backlight to drop dark; with this patch,
the full range maps into [0..255] and the issue no longer reproduces.

I also tested with the f1b5d8f9cc54 semantics present, so the regression
is still present without this change.


=D1=87=D1=82, 13 =D0=B0=D0=B2=D0=B3. 2026=E2=80=AF=D0=B3. =D0=B2 22:45, Mar=
io Limonciello <mario.limonciello@amd.com>:
>
>
>
> On 8/13/26 12:09, Akhmed Zhitaev wrote:
> > Custom brightness curves use an 8-bit input signal.  After exporting th=
e
> > full PWM range to userspace, the curve normalizer still divides request=
s
> > by the physical PWM span.  On panels with a nonzero minimum PWM level,
> > this can produce a curve input greater than 255 and send an invalid
> > backlight level to DC.
> >
> > Scale the userspace [0..max] range to the curve's [0..255] range
> > instead.  This retains the full advertised range and keeps the reverse
> > readback conversion unchanged.
> >
> > Fixes: 8dbd72cb7900 ("drm/amd/display: Export full brightness range to =
userspace")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Akhmed Zhitaev <zhitaevakh@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 40d82a3ee..533c69f0b 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -5131,10 +5131,10 @@ static int get_brightness_range(const struct am=
dgpu_dm_backlight_caps *caps,
> >       return 1;
> >   }
> >
> > -/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
> > -static inline u32 scale_input_to_fw(int min, int max, u64 input)
> > +/* Rescale userspace [0..max] to the firmware curve's [0..255]. */
> > +static inline u32 scale_input_to_fw(int max, u64 input)
> >   {
> > -     return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - m=
in);
> > +     return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
> >   }
> >
> >   /* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
> > @@ -5147,7 +5147,7 @@ static void convert_custom_brightness(const struc=
t amdgpu_dm_backlight_caps *cap
> >                                     unsigned int min, unsigned int max,
> >                                     uint32_t *user_brightness)
> >   {
> > -     u32 brightness =3D scale_input_to_fw(min, max, *user_brightness);
> > +     u32 brightness =3D scale_input_to_fw(max, *user_brightness);
> >       u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
> >       int left, right;
> >
>
> Is this still needed with
>
> "drm/amd/display: Fix backlight max_brightness to match exported range"
>
> https://github.com/torvalds/linux/commit/f1b5d8f9cc54ae8a2567ac126867ae48=
8e1bf625
