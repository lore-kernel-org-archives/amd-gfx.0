Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDC7C3DA7A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 16:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ADF510E9CD;
	Wed, 14 Oct 2026 16:58:21 +0000 (UTC)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6C0610EA63
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 16:58:15 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-5e8e8228312so201057e0c.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 09:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791997094; cv=none;
 d=google.com; s=arc-20260327;
 b=gkz9BvbsxXct+S+81JhVDfRZ1T7m7cbnF4/BIj/URqxZUzNe0ws2XggBgXLG3+KQ7D
 m5W2AuIM3xZGrW3x7mmtUWe9t/XXl2chGhHlFgKLnHTbFmpgYlSeqtNKFfZGMIH31/tg
 r7evDhItldViikR1VtjKvEYW0vA4ald7nfPuYC+eSGF22j1M3jSYjz0ACVcZTwYlxQd9
 4dzNi7tlQ+rnlI2VUuPSdhGoAtZg0x3jBPuN/VijbSmmZRZJn14bQ+pwL79+UMgjAtGZ
 FAc98cwAMJyoa0RB7Nd9sr4MFDwCtMbl5gazce8rI16T6j3YL3DddiDDAPlkQ/KJhbJg
 SCLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/HhNnMIsDqB1+l9DBxS7zqLucMRzhiJvM22vwbSViEA=;
 fh=LH7fF0w7SBC0yNbeYi3ojw6uSRfiTbR40poP1RXA1s8=;
 b=MBUj15RIP+ZeQfMT92oHh7OzFqCtl114k/xbPf5gM0wcBtxUzlNtQ0L+PPpCV1Iiai
 HK/Cp3TOLGJ5nHCPoK07Y5Y0vagfabgH9FhAT4Fbg8G4ZL/r1rdihElg0b+glohCD5OA
 A54dOGZLNoMDk3lYWajWcBXx2FRzEmIVNPAGfDRyp2W1Aq6A6m3aSz/MGIQzOkr26etO
 ULri/7NyCzLASdfZsECju/RduAZArFJG60WKLb8ztNJ7piBxy/gW8Opp2yfc+nIY8L9T
 bldjGAWQRczm1/qsFADzLXEIwUkbtc4kqZBm7IIN/WJpBNjNhd1OEBxqB1sqMN8jr2Ht
 /LEg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791997094; x=1792601894; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/HhNnMIsDqB1+l9DBxS7zqLucMRzhiJvM22vwbSViEA=;
 b=PiYr733LrEKLCT0J+yNkqyt3wsx5uDbMJfLo1IhFaY/5A24+8CGcnLOMqlqw1fuRcy
 /hvbTQhmjNWWFKLpuMVaCPfdPl+/5xD2HcRIEdZJ2xrfGdGzDCQ79DRFO+NYZwYx1CC+
 NQIl9mq1lgwduVpfktit3wSOQIt5+QzuQymz/wA695P4n5JS0RvuDNT+QgZntV+wkO+4
 PtCqeO7A5txAUtUrPpM/ujqN2bYGHxEZyhipC8lGor6yYpPCHsy+UM6WipiYtmJVocgT
 Vu7XCC0VNB68mCY9JKnF+3SY6usPUyhkdDFnj0dtuMGHILzwMO8lUJ5kSsUEijhl5w/7
 QGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791997094; x=1792601894;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/HhNnMIsDqB1+l9DBxS7zqLucMRzhiJvM22vwbSViEA=;
 b=dzItVBVws+iiYDQJEnSM98V+1nzlG4SlsHSjOZHlLIHPzl9CdEI6QuhHdPsdZzFE0z
 zQrWTPSYRxKIqrd38WLnUAfGCHYDozpoNBfhiY7yQ2oWz6CMjCJRLUoEH2b5s3Hy/Qq5
 hdyBMyWe3oHEEN5LOJ8GwXIG6dcRWIqs/R/T2BrCXOq1ptgxppRRwl2xw8KAAgic57BE
 ASemn32P8yJi6bHN4iWCEfMAvaWtGiA86kGtPxPjSHwnX/IwIi32nmTK8+ZGiw9ldFW2
 kkvgxisMDbNfY9J82sNuMlVvn5/vcEYyii8S3kDu+fI0T5tcPZbfaEetKiuEr/v/fOlF
 5a8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiZ6heGSAj01UeGATikUmXyUlxoxL+lMqi4PiHSRZp0I6QsFIFzVQyFUwiTzysBr/ziA6CgI0l@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK2OxTVyJo0R6yWDz4nCxWINpe/gfKjMLHtW6QGEv4axOpN7M8q
 Lf+ciOL0pWIom6U0Y56mGhhA50iFt9I/zvFrUXdssxKtSbTnaU1TpLVVVFdsCQTeFK5E5tUOIWc
 hDrfYRp5lYSmN8+KOAS5hu6aH29J3+Ac=
X-Gm-Gg: AYBFou3Y94MCL44Zy/kfPxdAKdpuI6xFm8AJ5RtB33EyfWq/LS6k4Opfs1maP8Cman5
 +lYONPeAOLFORURrwhkg9aGf9FA3Ks0fCDmTRQUQJLXe35RLwhl9tJNilhWsVS6WWSL4jF2kmaB
 N/fkllkxaGZ8K2lDEvOMNGys7bpWP/FTmVtBTg2PvAleh6JuTcl2nCK+QiigvoVB4bvWch7lX4d
 kqLVJhxX7LjKYSdju1av9YNgupFSOQJiI8yG5HU0UitKF62Mw75flDSsAcS+cxDe+stMHyq9jY1
 VBmkbAHcOe/uLL8Mx/NfBvADbOcb8jpdGZSfZxTJubkOounP1lr71PLFBl6cUDFFOcz6xpWqqt+
 mh7FvWzpBIVoejVjeI0R9E90rgaianw1IJGYY3ywKoQ==
X-Received: by 2002:a05:6102:c07:b0:7b4:f1cd:80dd with SMTP id
 ada2fe7eead31-7cb3668aa3fmr4094273137.1.1791997094312; Wed, 14 Oct 2026
 09:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20261014002858.172853-1-williandossantosdeoliveira287@gmail.com>
 <CADnq5_O0gGsDD96KkCTc71rPh1QJsBnWPw_XVvuwRoRQ9Wbhjg@mail.gmail.com>
In-Reply-To: <CADnq5_O0gGsDD96KkCTc71rPh1QJsBnWPw_XVvuwRoRQ9Wbhjg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Oct 2026 12:58:01 -0400
X-Gm-Features: AclHuK-keNlpItKGRgHS5Ga4AVpU-D6rkogwfe7eeC6U3-_jmpZg5nefB2U8zCI
Message-ID: <CADnq5_O=kVgSZoqe_ZVQDmVTWNb+OZ2XhmVx=0CPQQfCaf2idg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx8: remove redundant RLC cleanup
To: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Wed, Oct 14, 2026 at 12:47=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Tue, Oct 13, 2026 at 8:46=E2=80=AFPM Willian Oliveira
> <williandossantosdeoliveira287@gmail.com> wrote:
> >
> > gfx_v8_0_sw_fini() already releases the RLC objects used by gfx8
> > (clear_state_obj and cp_table_obj). The generic
> > amdgpu_gfx_rlc_fini() also frees save_restore_obj, which is not used
> > by gfx8.
> >
> > Signed-off-by: Willian Oliveira <williandossantosdeoliveira287@gmail.co=
m>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v8_0.c
> > index 7f91186ef1d1..088428e41f44 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > @@ -2059,7 +2059,6 @@ static int gfx_v8_0_sw_fini(struct amdgpu_ip_bloc=
k *ip_block)
> >         amdgpu_gfx_kiq_fini(adev, 0);
> >
> >         gfx_v8_0_mec_fini(adev);
> > -       amdgpu_gfx_rlc_fini(adev);
>
> I'd suggest dropping the explicit free calls and just use
> amdgpu_gfx_rlc_fini() for symmetry with other gfx IPs and the rlc init
> calls.

While you are at it can you fix up gfx7 as well?

Alex

>
> Alex
>
> >         amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
> >                                 &adev->gfx.rlc.clear_state_gpu_addr,
> >                                 (void **)&adev->gfx.rlc.cs_ptr);
> > --
> > 2.47.3
> >
