Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D321094468
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2026 09:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F6B10E2BB;
	Sat, 21 Mar 2026 09:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NV6Ysiew";
	dkim-atps=neutral
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E35610E172
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 23:30:23 +0000 (UTC)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-64e8cdafeffso3679362d50.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 16:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774049422; cv=none;
 d=google.com; s=arc-20240605;
 b=b8d4TJe3ZolNKw7cLPByjpjy9A7q3YBPfABpGiUurcjr/4cdQv/99v1v/ZNKMzp8+a
 ldiBuBRIcWUMCa61LLkaUZJ8haXRy11FaWjWYxJjLSW5JCOD/S4X9DspHYR+biD1300X
 RpairffUiHqiUaYKz04+jkMJzSCaUPxXtuCPYuSfY+zAfcAeYbRFuGAuHvg47ziPrZZO
 et6LqFuyL7eBQLLYcD0fLftq2Ulkc7by5k0hFPdZos2C4ph3lg74kck/x7Fbpds7THNf
 idXMTha8MpccEBCRg3HoZ/o9TZ5JRpuQ3qGCPEJn1gjvSapcriE6xaCH9FM/zeVdzfd+
 OJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gGm27wM+81bWCfb+V5biCQ0jTOal6htbF3yNa3Lpemo=;
 fh=qrhMRU9GzTgu499Qv5kcHDyOrdGuarkt1F26NYBI1Ys=;
 b=LZHQ6pwwDyR40gFJjLxJKzt6tbvBqt8UmbwSioGn2c6DcPUPYeJtqA5IZp2iQ2ZwlV
 ShLNRkFkPIsDGqSo4knnuR7W+BUF6GW2zUOI7Qa5iAAVhGjTs01IogEUb8P7NliU5+sf
 KlZQKqdyJ0+rMPsZmrgr8qw+rT7pVbXJ5HJLBKOQ1jGgYZjAEd9T0oPJTxkF0LSdH2cz
 6cOm4QVO17RiJ/gfvp1vuvKLzfk8fw6BzoN0CmEBf6di97a7yhWJ2fVuSU2t3+kfdmEw
 XMc+XpJ57p/NNWR5sf39/R2J4CHzUMqDia05ovsz/Q/AG+ZT7Ek4Z8TQqQxkaoP4kj0j
 JTNA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774049422; x=1774654222; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGm27wM+81bWCfb+V5biCQ0jTOal6htbF3yNa3Lpemo=;
 b=NV6YsiewSSNPsqrX7X4BwL3zNJeycxL/qa7XszUSuZhIOJSGUXNen3VFEAs8/cYSzU
 PXo0WfxCOAVqheJUGRr6P+TS3ECcHuFmuC2Bvy6SigneanYEKswbPfO3hC727hu/k1BO
 EQ01a4myHwGl5Sp2rGoFmOuMPc2zbNfxjbynkOLwWHAlJNaZzkjbO5Llg7qL63F2u0L0
 J4U36Ar/HHykSdMKoi2pdyKZ6sLuVVGLFRD6OOGDw+44REH3qrN+acvNdP+3yvql2c5R
 G5RodL2tEeU9HM++mSORBl+bzk+tw5azZHrFU8ofNZ+fs52I7BrVIVCnYIixskQSD23h
 q8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774049422; x=1774654222;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gGm27wM+81bWCfb+V5biCQ0jTOal6htbF3yNa3Lpemo=;
 b=CinswoFzKMfe/S7xzp891Tc5obP0n/0btRrH7nCDSilVibmmsHpiJqK15Ua/z4T63b
 5M4si4NMEB/xedgsArsmrAWgPIr6ZemH3COMR5B3HXcg4JXUY2OQM5XWxhxUEbqjcGJA
 HDa2GUCp2RQ/TqDoODhjj+9KbaczbwY6pmikOJRMjq0GmwcnHJclMUhR6IvKQ015kqCC
 8ddr45BDMb5BZs4NxA42Uu5DT63kZlT3De/C2qk6UwG37OtLCTdyrm5lSn4u2wb8olqB
 B+gcHgDuerIBWlzGA2q6yfRXB9oo9weyoENxdD5bol2MKs7hNP7RT446NWT5cUwxP9wA
 yrIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHGwhaNfV4pdpFNKkbuhYUypRVhsp1jKJilkY1/Lt7fY12EeFiajWSOy15HUnxZTkrk5VGolU9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwECteQnn6vSWcYFT5gJUL9syMy4DE7tK02sKXYDhUs+trTIr9m
 nIPjJHDenusECsBHnbcNem1yBHTuF28QiCLI7Wxl/HxBKJ/kiYlxbrrpj1PDUfqKR8hyKlh397L
 aMkuaMVi1OLIJ4w90HHzS1kMfudq1dHA=
X-Gm-Gg: ATEYQzx41QxjIkNVI3KDV/T3/3BvZyidhofucLTJHyXprxGcOcvufQxFzt4t8DNxB/N
 KXuSANs978h0Ogu8j9FLkN3VkkPByjUDXPs5vSE8ouTeSxgLwcIfO+al0hnjs243QALJDsMaiH8
 3nnccALWVR94T9awUzXjds3v3OTmKviedhIa6QGQqYn7DC75dJVty5gn5SABvAH1EgsL14dCN+j
 eMln7tk8tInIBJXAk68nrgIVWpgB5pLEJTCM0hJDQHBQq206GjBD0cxnq+KBO0yzI/vkaRnlIyS
 PPgV
X-Received: by 2002:a05:690e:e88:b0:64c:2590:e454 with SMTP id
 956f58d0204a3-64eaabf5724mr4407440d50.14.1774049421463; Fri, 20 Mar 2026
 16:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-60-jim.cromie@gmail.com>
 <177402491476.6181.12723360930731783132.b4-review@b4>
In-Reply-To: <177402491476.6181.12723360930731783132.b4-review@b4>
From: jim.cromie@gmail.com
Date: Fri, 20 Mar 2026 17:29:55 -0600
X-Gm-Features: AaiRm52E-e5beknCm0D3IoqJOtVzVrqihcI488lZobOssZKy_IBRdDrXcsBQ3Ac
Message-ID: <CAJfuBxwihP5ANOqgEmQAJF_PcHsa54T7Urn486DqbOy6rtcPHQ@mail.gmail.com>
Subject: Re: [PATCH v11 59/65] accel/ivpu: implement IVPU_DBG_* as a dyndbg
 classmap
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org, mripard@kernel.org, tzimmermann@suse.de, 
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com, 
 ville.syrjala@linux.intel.com, christian.koenig@amd.com, 
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 21 Mar 2026 09:47:17 +0000
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

On Fri, Mar 20, 2026 at 10:43=E2=80=AFAM Louis Chauvet
<louis.chauvet@bootlin.com> wrote:
>
> On Fri, 13 Mar 2026 07:20:24 -0600, Jim Cromie <jim.cromie@gmail.com> wro=
te:
> > [...]
> > Anyway, to play nice with DRM, we change all the constants, from
> > macros calling BIT(X), to an explicit "enum ivpu_dbg_category"
> > starting at 16 to avoid DRM_UT_CORE..RES.  This is all in an indef to
> > avoid changing the constants for the non-dyndbg case.
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
>
> Hello,
>
> I have a maybe dumb question: if you enable CONFIG_DRM_USE_DYNAMIC_DEBUG,
> then the meaning of ivpu_dbg_mask will change no?
>
> In one case you will have to use ivpu_dbg_mask=3D0x01 and in the other ca=
se
> you need ivpu_dbg_mask=3D0x10. I think this is very missleading.
>
> In this case, I think it will be way easier to completly change the
> expected value for ivpu_dbg_mask to have the same behavior with or withou=
t
> dyndbg.

yes, it takes a bit more explaining certainly.

The reason I kept the old numbers for the old way was to preserve obviousne=
ss.

The /sys/modules/ivpu/parameter/<name> maps bits 0..N, not 16..N+16
I didnt want to fiddle with the conversion, and possibly get it wrong
(miss something).

> In addition, I think this could be nice to have a "rule" like: "cores"
> should use LSB for their classes, "drivers" should use MSB for theirs
> clases.
>
> This way, if DRM decide to create a new class there is less chance of
> conflicts.
>

some guidance makes sense, Im not so sure a hard rule wouldnt just over-spe=
cify.

a simple rule would be reserve-in-8-bit-chunks.
drm.debug has 10-12 bits (not sure exactly) leaving 4-6 for "growth".
So I started IVPU_DBG_* at 16 iirc.

Theres also some question if ACCEL should have their own set of debug-class=
es,
or should be reusing DRM_UT_*.  currently we have both,
1 or 2 accel/* drivers use DRM_UT_CORE (but no others IIRC),

ivpu had many, so I took it as a real-world example of the need
for multiple classes (not just the test-dynamic-debug* scenario).

This maybe isnt optimal.  But it might be premature to fit the strait-jacke=
t.

> >
> >
> > diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_dr=
v.h
> > index 5b34b6f50e69..ef5a96b961fc 100644
> > --- a/drivers/accel/ivpu/ivpu_drv.h
> > +++ b/drivers/accel/ivpu/ivpu_drv.h
> > @@ -81,6 +85,41 @@
> > [ ... skip 9 lines ... ]
> > +
> > +enum ivpu_dbg_category {
> > +     /*
> > +      * since accels are drm-devices (CONFIG_DRM_ACCEL_*), adjust
> > +      * IVPU_DBG_* to avoid DRMs 0..10 class_id reservations.
> > +      */
>
> Here that could be nice to start the enum at 48, so there is a real hole
> between "core" and "drivers" categories.

Im unconvinced the distinction is that clear -
DRM_UT_CORE is used in drivers, as are KMS and ATOMIC ( iirc)
And is ACCEL classes core or drivers ? probably a bit of both ??


>
> --
> Louis Chauvet <louis.chauvet@bootlin.com>
