Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249BB10A88E6
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 16:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC5C10EB02;
	Thu, 26 Mar 2026 16:40:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="LO6GwwGv";
	dkim-atps=neutral
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7161810EB0C
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 16:40:48 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-89a6ac6f389so13198776d6.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 09:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774543247; cv=none;
 d=google.com; s=arc-20240605;
 b=e/OadaQtPBLSDvfxVLwzFBhPpw7sDy5PJoGGCcXQdJ7V87Khfe7wRgocAufKuozY8Q
 3zJ5eNacIYDuVY6yYSL+AVjANZSNtOT0WqGcw/zoj2dwvoxik/6+u0H9i0XnGxDPdLYR
 mUovngZyF3bNCSHGImRyPEaiXG0qrIajLJqUtfXgOm6bkfk5U75Bf/Xo5I6WvIFVf0Pz
 UPH0E9fnHU7wTbKWz8MiZguQf9f3cBucJz5flfkiCzFxIJTV6pEaGqfMwE1Knb0/uibm
 Ihn35W3NSaIgUtGiuuh3BDSI7Ip1iPcJk+l6LCeJZuhBWoOUs5jJN3BktSlVrFoIyknp
 b4EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lMVh41/flJhHXUmskY74HI0cHDnV8XVUzcIyI3Tc5Ws=;
 fh=/BEhzu/tk9EQq6790NeigkVww6rr1iRHIpHPOrn112A=;
 b=PS6Dcqfz8PGBDo0+2zLNg+S1E9sN18qswdUC35R23QsmdyXmamAY3IlHdGiyrWeL/m
 U4/uGl0cnm8dYxJHi5TQxkPNjBJZDFm6LRTxUFMRJ3ve1dpR0OVTM6wm1ZVekh8OrxRJ
 3JIv6d4wUWfRl5m5GqdqdlHS8zaKvv1QYuTD/z3eknQIledBWzwZwBr+DU9ow3ZKsfY7
 QkF9Lgg6K97udrIRzUcLEDSLLqQKZy/9rZ9JqoqbHjnbxpxe+FXWl/RqLvrBh2C/O7b0
 Exc9ZaT3XimtTv2I/RSkTpxETVo7bGFiOFqF6VSQtrPr/xVZW7R6Vvajs3jZywB2TC5S
 B7Cw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1774543247; x=1775148047;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMVh41/flJhHXUmskY74HI0cHDnV8XVUzcIyI3Tc5Ws=;
 b=LO6GwwGv/JaHH26tDrTgWbtKEk6Zl5H++3b5k6NXxCs99yEpBNroviodHIR+bs7+tM
 hB/SqVSvWb10RY+t+IJZDN0yeibQRUtprTSSqXuTaHId5aTsaouEMLkF56naW/MwV8do
 pyr6RywYpdm0Qhhw9TCs48jtmKTdUf8ViXbeh8Mq5qIF4nki4uMJrfA/QOMY9uqN1Agq
 gLo22R/TENGz8mS3hGfy3AYUqjiJ/mbakJ+0PwTeHdVxySYCLg1nYe29/B6Ms9FXTG0u
 YTO6CDALWFXlpTsK113DxVB8PwLs1KP0Ro7vEig7XWlkfY6zwfd7YrezZMXvDVEwmdof
 DUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774543247; x=1775148047;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lMVh41/flJhHXUmskY74HI0cHDnV8XVUzcIyI3Tc5Ws=;
 b=azIOEE4EkZ7aybxyFB+VDRWnAkVkJeq5eoIZcecmbD7Ym1Hm3Gy2uI5992dey7tw7O
 okoEjdPtHvcYk4PddllvOMlY8snLsReC11JRblgUQSRqCG6gaJyCUZuXr2kkeZP4gNaA
 B+9QBg1UQpNJ7kwDGtSfAIbNB2Pw3Voe4gLgZ+um2GX40YoZLi/XetxdQ2CimD+az77i
 AywaAl4oQP1etiqXCSaNzZQ0ImuS6EUbFn1zwSQU/czGL6CgLMuGxSmQp4/6FzYlomCV
 xWHltrxtvL8njj/onO22BasxHNMjLXFf3LTLkEjHjT5RWg2R5b6pdENvXe6bVXOOzyqD
 f6ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz+Hqh4bjXZlxve6vdztVYPylSRE545TAo1sLCFzPHj0SlcnoXp6cpVvSJvJjgxDBebPxJh1lo@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxz3TalXyIldQRqUKVSOXlL+pPpzJvALAico9TtOqhT80FX9QDS
 8MbOniPBue0L/s6MrIS8F/lFXTOLAVMrpTfLM32ufDWpyrId9H6v8WXkWNIG55uF9xtZpPArGi2
 C50u+9LPSAImcIV2aXj7OePrNp+qZvVoyqvd5uREFew==
X-Gm-Gg: ATEYQzyYXlWoOF5DrbP2w5a7/gW7uqST/uzqH2bl2Pwkig7mAEG6kGyszQ7bWox0h0n
 sQbsu07wqXrWvSAZdJmh/jWxKlKrY0oDGW03eetHkeeI2TRsVqah7D3Y/amzTj0wDIz3pO1qrcI
 4BRdPkqi8II2PlRuT3GZtmCU/1EO6FFqL9CCN8x3lM9/nB/iP8rmwJDWw3NxolLrTZ9kpxhR+SH
 XWLHfwZynFpcVvYL8UnTjeRP3t4XLkuC6iZG0rys8qJcn7NRVFw+arnicmOK6r4+lQo8QosS/Bc
 YgJQFaU=
X-Received: by 2002:a05:6214:d6f:b0:89c:866d:15c9 with SMTP id
 6a1803df08f44-89cc4b07bc2mr122325186d6.56.1774543244239; Thu, 26 Mar 2026
 09:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260324-color-format-v11-0-605559af4fb4@collabora.com>
 <20260325-neat-elegant-raven-ebc9ab@houat> <acPA60Ci3n_t__xF@intel.com>
 <3979783.tdWV9SEqCh@workhorse>
In-Reply-To: <3979783.tdWV9SEqCh@workhorse>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 26 Mar 2026 16:40:32 +0000
X-Gm-Features: AQROBzB2J1rLcK9oOY95uN7pO5Y8iJWro7kBrTyJSKQV06IZlwAC79afqJRLPi8
Message-ID: <CAPj87rMpu-ZL45_uNPcZe3gu8Eqn2ALp3r0zRgghvT08-6RGVg@mail.gmail.com>
Subject: Re: [PATCH v11 03/22] drm: Add new general DRM property "color format"
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 kernel@collabora.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Werner Sembach <wse@tuxedocomputers.com>, Andri Yngvason <andri@yngvason.is>, 
 Marius Vlad <marius.vlad@collabora.com>
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

Hi there,

On Thu, 26 Mar 2026 at 12:44, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
> On Wednesday, 25 March 2026 12:03:07 Central European Standard Time Ville=
 Syrj=C3=A4l=C3=A4 wrote:
> > But I'm not really concerned about documenting struct members.
> > What I'm talking about is the *uapi* docs. Surely userspace
> > will want to know what the new property actually does so the
> > uapi needs to be documented properly. And down the line some
> > new driver might also implement the wrong behaviour if there
> > is no clear specification.
> >
> > So I'm thinking (or perhaps hoping) the rule might be something like:
> > - YCbCr limited range
> > - RGB full range if "Broadcast RGB" property is not present
> > - RGB full or limited range based on the "Broadcast RGB" property
> >   if it's present
> >
> > I think the "Broadcast RGB" property itself might also be lacking
> > proper uapi docs, so that may need to be remedied as well.
>
> Alright, so in v12 I'll do the following:
>
> - Add a line to all YCBCR connector formats that specifies they're
>   limited range as long as Broadcast RGB is limited. Whether it's limited
>   range when Broadcast RGB is full is purposefully left undefined.
>   In the future, we can expand this to state they're limited range by
>   default unless some other property is set. If we're not re-using
>   Broadcast RGB for that, this will work out fine, because users who
>   don't know about the eventual new property won't have this behaviour
>   changed. If we do re-use "Broadcast RGB" for that, then only users
>   relying on things we explicitly left undefined will get surprise
>   full range YCBCR.
> - Add a line to the RGB connector format that specifies its range
>   depends on the "Broadcast RGB" property
>
> This is a bit of a mess, because it's entirely reasonable that a
> future YCBCR range property would want to default to full range
> so that users get the most color out of their monitors. But with
> this description of the connector color formats, we can't do that.
>
> If there are alternate suggestions, I'm open for them. We can't
> really rename "Broadcast RGB" but if I had a time machine, that'd
> be my first choice.

'Broadcast RGB' isn't what you want even if it could handle YUV, since
it also sets up colour transforms to modify the data ... so we need a
separate, orthogonal, property which only affects the HDMI infoframe,
rather than applying any transforms.

Cheers,
Daniel
