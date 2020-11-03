Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDCAC2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 23:12:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB0624671
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 23:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPVME70r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB0624671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01EB06E90B;
	Tue,  3 Nov 2020 23:12:32 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4BA16E909
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 22:44:10 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id l2so16999829qkf.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 14:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=1bM2cutRhdcR6XXpMZPYHyjRSLxGLbA4Viz+MAgQH/E=;
 b=DPVME70rwJR7WwJHe6eNx3icYQtf3Qy6hXnrnsMhvE82kbO5i0xe4z65gRDVzeWskc
 Wu3wI14qZKW3Ne4xl9PXtRz6Ln+kklEo0Uw3Dzif12uS+vEJfaLiXtYbzSEEmcgs1Qw2
 BPrdFo1rBSD667yeY+TBr+3V17W4oN+vc0nuMSOHTkpTyecRHHFW4tifjSzSWSqk2hpL
 h+QlaX9PzhCdnkw2ppFpCC3+V3aqlxw7XrW244kGilmcBXXiINdz5bs7x0XgNsj1tq7x
 k6Xmlsc2OWmxIJb5e497rMLtMdaDfmM72+QI7vRmCXJcOJ7XGQ58M/+KHmbvElgb7+bY
 rQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1bM2cutRhdcR6XXpMZPYHyjRSLxGLbA4Viz+MAgQH/E=;
 b=hWppiH4F91wh9EFKSe6VZVnNHNs8CxW+Ix/uEdR8230JbdCED9NrqiW4Ej8BzHgotP
 OgELkwYww8+vImzzThxvOO9r9eDR7eTW28mPIeS4mLKSSkX0px0g02qfeqnKanybGu29
 r52zROyAKEZazWeHuz76fWv2NkjF/j7dI0bcEDvFLq6xju0TjDf/5szCwdC0Q26Vep08
 jpSLonO/nPwXFoGddhWnBJWurpcbERZcv330zpdtHrejNzCGBZUmXHE35m/fhhdHz/by
 5iBEaUC4LuxhqziGxiLBQGDl1J1+v9DjilRZbWU6Lwn8NAXh4Asn4gFAt2WJ3Yn5uX7I
 mLkQ==
X-Gm-Message-State: AOAM530dnlgMp6SIVmhKFJnwsnZlgFjcHm7NyZuuMs2PAPfxfSGxrWNd
 ZdpU42EJd19NbYEHxmSLkeQ=
X-Google-Smtp-Source: ABdhPJxbFUjnSay5MjmW/ynFjNOyIcNgvUY0TRbAzbxHIzTj0OJEIe9iEcx2AFrKeePbaE8lIwOdiA==
X-Received: by 2002:a37:a80b:: with SMTP id r11mr21965864qke.380.1604443449933; 
 Tue, 03 Nov 2020 14:44:09 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
 by smtp.gmail.com with ESMTPSA id d133sm247057qke.106.2020.11.03.14.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 14:44:09 -0800 (PST)
Date: Tue, 3 Nov 2020 15:44:07 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: fold CONFIG_DRM_AMD_DC_DCN3* into
 CONFIG_DRM_AMD_DC_DCN
Message-ID: <20201103224407.GA1807194@ubuntu-m3-large-x86>
References: <20201016165004.1218352-1-alexander.deucher@amd.com>
 <20201016165004.1218352-4-alexander.deucher@amd.com>
 <20201029221410.GA1982624@ubuntu-m3-large-x86>
 <CADnq5_OKYmpobjJGQ0sGTbkz3RNuuOBadySLE5URvh0CjxdD8w@mail.gmail.com>
 <20201103010059.GA3268770@ubuntu-m3-large-x86>
 <CADnq5_NrPOc26rzHWxS9TpBqCjpv3rhnaTS_O6B++YX7wEwOjA@mail.gmail.com>
 <20201103182705.GA1750585@ubuntu-m3-large-x86>
 <CADnq5_MTcdH=OjbESa3fV33DhnDRG2-ZkmnC1zJjQEe80kpd=w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_MTcdH=OjbESa3fV33DhnDRG2-ZkmnC1zJjQEe80kpd=w@mail.gmail.com>
X-Mailman-Approved-At: Tue, 03 Nov 2020 23:12:31 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 03, 2020 at 04:36:05PM -0500, Alex Deucher wrote:
> On Tue, Nov 3, 2020 at 1:27 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Tue, Nov 03, 2020 at 12:41:27PM -0500, Alex Deucher wrote:
> > > On Mon, Nov 2, 2020 at 8:01 PM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > On Mon, Nov 02, 2020 at 05:33:14PM -0500, Alex Deucher wrote:
> > > > > On Thu, Oct 29, 2020 at 6:14 PM Nathan Chancellor
> > > > > <natechancellor@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Oct 16, 2020 at 12:50:04PM -0400, Alex Deucher wrote:
> > > > > > > Avoids confusion in configurations.
> > > > > > >
> > > > > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > > >
> > > > > > This patch causes a build failure with Fedora's aarch64 config (at
> > > > > > commit 2e3a5bc5feeab1ed21f0105f1440a2ff0aef62f9):
> > > > > >
> > > > >
> > > > > Does the attached patch fix it?
> > > > >
> > > > > Alex
> > > >
> > > > Closer:
> > > >
> > >
> > > How about this one?
> > >
> > > Alex
> >
> > I still see three errors it looks like.
> >
> 
> Third time is the charm.
> 
> Alex

Two remaining ones related to -msse2 flags:

drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: In function 'dcn_bw_calc_rq_dlg_ttu':
drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:516:1: warning: the frame size of 1600 bytes is larger than 1024 bytes [-Wframe-larger-than=]
  516 | }
      | ^
aarch64-linux-gcc: error: unrecognized command-line option '-msse2'
make[5]: *** [scripts/Makefile.build:283: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.o] Error 1
aarch64-linux-gcc: error: unrecognized command-line option '-msse2'
make[5]: *** [scripts/Makefile.build:283: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.o] Error 1
make[5]: Target '__build' not remade because of errors.
make[4]: *** [scripts/Makefile.build:500: drivers/gpu/drm/amd/amdgpu] Error 2
make[4]: Target '__build' not remade because of errors.
make[3]: *** [scripts/Makefile.build:500: drivers/gpu/drm] Error 2
make[3]: Target '__build' not remade because of errors.
make[2]: *** [scripts/Makefile.build:500: drivers/gpu] Error 2
make[2]: Target '__build' not remade because of errors.
make[1]: *** [Makefile:1797: drivers] Error 2
make[1]: Target 'drivers/gpu/drm/amd/amdgpu/amdgpu.ko' not remade because of errors.
make: *** [Makefile:335: __build_one_by_one] Error 2
make: Target 'clean' not remade because of errors.
make: Target 'olddefconfig' not remade because of errors.
make: Target 'drivers/gpu/drm/amd/amdgpu/amdgpu.ko' not remade because of errors.

Cheers,
Nathan
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
