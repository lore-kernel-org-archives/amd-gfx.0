Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACB2F54AB0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 13:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 985BD10E6B5;
	Tue, 24 Mar 2026 13:21:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ahlLYRIN";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2AE10E6B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 13:21:13 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2c1410009a8so86026eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 06:21:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774358473; cv=none;
 d=google.com; s=arc-20240605;
 b=ETdQn31NDnY5PUYTULVx5TIPE/3TV5UmJBYP9WZhj10uF33sFMv9SRWgwhd3STico2
 er7JONnIBzO8A9w1pk64X/TRYzKD5SdyWTHLafT+gp+aqK9I+Wzh4Pa6y19yX18IXnIg
 ee1Hc+5g1BKFk12kZxLQwDQhHMNalGs1RTPM+zqW1besQ9fo9KPZ2TShgapchM9oqyLj
 WDMvhScX3tyBWY36PfRL3hGFRLsSCtz04OouirTq4yffGT4wHzk5Eob2bFngBRdmIMKJ
 +roX6wkrYnJabbJNLwzbP7HVL16w7YkKUzXAkMH8COuQw1Hxa3lS5uklTEX/CwRPXrMH
 cxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CutxZk0UywMMX9SEC6rWk5Mmx6PoN5/HmY4U6NLKJsA=;
 fh=/Ffeq7zYXvNLI8MsPqGN7e1C9pBWEwWECt+O3wsmOLs=;
 b=dG9iwRzt8Y1BA47UxuMESrMuCTrvFC8P/m/HL7PsKMkVBpZumW5R9o+RmKxxNhmMRQ
 Iu+qMk0hl3qAk8k8wt0HnweUsntH0Rc3mV7SFhhCu6Mfz5yEIriU2uyn2JE6VftncGuQ
 P2NuRV3p4kEwLULdu1uRSGPJN5I98XEP4Bq7tqLp9syHMSj51Xiztsu+efYlZCIm2GNU
 4pBd0wdr/RnD35neL05pAPdxjFZORsiYVgoQP8uuYQoNUwutcauPkX6tXIkwV2M0Zrbe
 RzpsY+6pimUmLRn7JLg/bJyohBs8ogBUEngkbulmFJ/B6jhvZFG7mDo8jbgpLj+83hE8
 9xeA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774358473; x=1774963273; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CutxZk0UywMMX9SEC6rWk5Mmx6PoN5/HmY4U6NLKJsA=;
 b=ahlLYRIN1ZudEmBhLHheNKZaz6xMm9fSFXZLIPOnmq0aOy1Dy5v5ZDKYgPM4HaN63t
 PR0GwN5qOEVzwcNYp3UFoTcLQ0TZQz99gKvk0LdIHRRt+tWDPcwcF95/+EPYhX4x0Egs
 3PN9gNMZ+ED6xdiu5cy9oDdC91JHKNZNi18D7/vwExhvAQi6pwlilb4f5RTJDXKvhOTu
 cbHnbDnUa5p2WnutNt3343bErxmb6gmihjwkfCCHfDrM0eWKbPXx35dATHTEKcPmSTCs
 BNgVFyoEhsMgDVIDYKtMfmOUMz/UTqdBb6/uQsszf6deKU9wohgmm3mOmM3ZlA44ttbM
 MPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774358473; x=1774963273;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CutxZk0UywMMX9SEC6rWk5Mmx6PoN5/HmY4U6NLKJsA=;
 b=KmE2TIWsq0oHvLrPGWaIlwdfvCIcabfc1v6YgIzJr0h5xZmRTMuXmCsRoYUZIcea91
 9Pizq35E5hM0aihcMMjIi9nOtYl+hm6+4oBLmm1RBpagycdv7Zs55hxNdKyT0iIa89MC
 IiLIk9i9tq1UcbyDoAJRvoRD5mzvLYSaZLYDO0HXr0VVTcGNtypt+T/v5a7IqApmwWZk
 +hXkM/WbJseqpMfy08WPRcSf5m8FzyPf3jDmB8YuUFlY+4kaoKiWdtohZ2HWEbZsDYQK
 W1QmWdlGCTfJ/wO5h1S67dzuVqfDbDcRoVPUvSFSQFu0n9U6AiajxyttxMJ1SIXjGn7D
 8b6A==
X-Gm-Message-State: AOJu0YzLQCdMK389J9XhADq5p/PSp0yozNJjr1LXTpUGfieCzyJzqQAH
 WySId+EC9FCL4/PWWz84hhbGiq1/O4SSdPkGYakT8UfWMUG/GBdpaqELeAnM04KId66c0k/kDfy
 wL//c8yWHbeWRfedpg83Ls1tyrGisyKw=
X-Gm-Gg: ATEYQzxc9JVPU2NlM5E96ew+POq7FgRfPxw21XOpJUrTTIK19Pbvt92zRFf5sAOO/mQ
 /E1BTJY0jk6W3Dci39txFD46T7LS7zXDsHIuJRVApYCmQKmv4kFlun7M/83gh2kAQ9QBHIASeWT
 Cb28TUuIh94odQAISWwMmgwi40KgLZcYv5iJgy/euxvNtynwRo3lj/c+VPk8GT3282TkxQdtymZ
 XVWkHEecEITVquC/NWEgvk0qOTqxzyFFItPtQ2spe9oMZ0qaQVrQ8+sBCrRF1xCf5wRGDS4prI4
 rQJmrD31AXAW//wi1+2SDXdqfK0/Lh3OKCvKZLIoOsHSlblbnN8zrydHjUPwEEZCf6lKKQ==
X-Received: by 2002:a05:7022:6b81:b0:119:e56b:c3f3 with SMTP id
 a92af1059eb24-12a726b5c4emr3201201c88.3.1774358472868; Tue, 24 Mar 2026
 06:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
In-Reply-To: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 09:21:01 -0400
X-Gm-Features: AaiRm53DpWv5pr0QiHY6HEkx6D6NV3ewBXmw1gn7c17yw41TFZ5-avxtdFneTm4
Message-ID: <CADnq5_OTKJCJf-szPfak1r04fawGhJ-9H=Uzvyh3dmTmP1KYLg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Change dither policy for 10 bpc output
 back to dithering
To: Mario Kleiner <mario.kleiner.de@gmail.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, Aric Cyr <aric.cyr@amd.com>, 
 Anthony Koo <anthony.koo@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Krunoslav Kovac <krunoslav.kovac@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
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

+ Harry, Alex

On Sat, Mar 21, 2026 at 1:29=E2=80=AFAM Mario Kleiner
<mario.kleiner.de@gmail.com> wrote:
>
> Commit d5df648ec830 ("drm/amd/display: Change dither policy for 10bpc to
> round") degraded display of 12 bpc color precision output to 10 bpc sinks
> by switching 10 bpc output from dithering to "truncate to 10 bpc".
>
> I don't find the argumentation in that commit convincing, but the
> consequences highly unfortunate, especially for applications that
> require effective > 10 bpc precision output of > 10 bpc framebuffers.
>
> The argument wasn't something strong like "there are hardware design
> defects or limitations which require us to work around broken dithering
> to 10 bpc", or "there are some special use cases which do require
> truncation to 10 bpc", but essentially "at some point in the past we
> used truncation in Polaris/Vega times and it looks like it got
> inadvertently changed for Navi, so let's do that again". I couldn't find
> evidence for that in the git commit logs for this. The commit message als=
o
> acknowledges that using dithering "...makes some sense for FP16...
> ...but not for ARGB2101010 surfaces..."
>
> The problem with this is that it makes fp16 surfaces, and especially
> rgba16 fixed point surfaces, less useful. These are now well
> supported by Mesa 25.3 and later via OpenGL + EGL, Vulkan/WSI, and by
> OSS AMDVLK Vulkan/WSI/display, and also by GNOME 50 mutter under Wayland,
> and they used to provide more than 10 bpc effective precision at the
> output.
>
> Even for 8 or 10 bpc surfaces, the color pipeline behind the framebuffer,
> e.g., gamma tables, CTM, can be used for color correction and will
> benefit from an effective > 10 bpc output precision via dithering,
> retaining some precision that would get lost on the way through the
> pipeline, e.g., due to non-linear gamma functions.
>
> Scientific apps rely on this for > 10 bpc display precision. Truncating
> to 10 bpc, instead of dithering the pipeline internal 12 bpc precision
> down to 10 bpc, causes a serious loss of precision. This also creates the
> undesirable and slightly absurd situation that using a cheap monitor
> with only 8 bpc input and display panel will yield roughly 12 bpc
> precision via dithering from 12 -> 8 bpc, whereas investment into a
> more expensive monitor with 10 bpc input and native 10 bpc display will
> only yield 10 bpc, even if a fp16 or rgb16 framebuffer and/or a properly
> set up color pipeline (gamma tables, CTM's etc. with more than 10 bpc out
> precision) would allow effective 12 bpc precision output.
>
> Therefore this patch proposes reverting that commit and going back to
> dithering down to 10 bpc, consistent with the behaviour for 6 bpc or 8 bp=
c
> output.
>
> Successfully tested on AMD Polaris DCE 11.2 and Raven Ridge DCN 1.0 with
> a native 10 bpc capable monitor, outputting a RGBA16 unorm framebuffer an=
d
> measuring resulting color precision with a photometer. No apparent visual
> artifacts or problems were observed, and effective precision was measured
> to be 12 bpc again, as expected.
>
> Fixes: d5df648ec830 ("drm/amd/display: Change dither policy for 10bpc to =
round")
> Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Tested-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Cc: stable@vger.kernel.org
> Cc: Aric Cyr <aric.cyr@amd.com>
> Cc: Anthony Koo <anthony.koo@amd.com>
> Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index c9fbb64d706a..29db5404c4a0 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -5056,7 +5056,7 @@ void resource_build_bit_depth_reduction_params(stru=
ct dc_stream_state *stream,
>                         option =3D DITHER_OPTION_SPATIAL8;
>                         break;
>                 case COLOR_DEPTH_101010:
> -                       option =3D DITHER_OPTION_TRUN10;
> +                       option =3D DITHER_OPTION_SPATIAL10;
>                         break;
>                 default:
>                         option =3D DITHER_OPTION_DISABLE;
> --
> 2.43.0
>
