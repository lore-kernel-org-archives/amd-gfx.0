Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F349C54FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 17:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F33482077D
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 17:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1LgMCh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33482077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B074789F0A;
	Wed, 25 Mar 2020 17:23:12 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D58889F0A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 17:23:11 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id h15so4154005wrx.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 10:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=27VZdVRY9pMlXy2u5aK3u9XY7jLLo6xwKp6bSVdD0NU=;
 b=f1LgMCh1bbc/vt2GiviE9vk22qgxmNu87YqGPPrpUHUrdbaWH8YDaeiqD3zBhtaLMi
 RLrYVzFo39w2wfym9wxLdSaAhwtEfQ+8NHmhZS2ZAgjRFNmekBbNYeEKKXIH1NB+vUP2
 xbpJ+dvRJczi46gaJ2UAsOx+U9Pr/GFGAcnOOmQp/AWWvbnWYcTqPksXdJfUsKwrYPXO
 eDKc8cWVjbyUgZWRTebNCHiAy5D56SHRlL6XVqPhHiF/0vAR9ethp2zl5/uXUifN4xCN
 sFuLguh5vKgoVp0EzzyKY/aMomecEc+8aWXQdftru+Vij/AR1Qx6fbKd9ziWqwRnIrIc
 h97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=27VZdVRY9pMlXy2u5aK3u9XY7jLLo6xwKp6bSVdD0NU=;
 b=YzMolpS8ugefK9sOW6yw6+hy0zDrn+hoJ07QoOkhKTs8Pq9eyRYEuWMhzv9NKgQWKD
 sS75MQaq1Ao3PFvHb8jGhR89KVabbYINLIGkpfU4fIGRRYO0/oKR/LHto7PCraZ1vqKH
 c0nmo++5pdSNdgxP/vAVApxDT9wgquw4O3xwopBO/cRuv0Cz171ZSmj1sxOEZqVC5SvI
 TDkB5iN2vwDz86JIWih2dt0gJ2MtDUCSohqmAzqcQ+ykbHY5of2FI2XMokBi/6PXQlZd
 EBbUVlfkNKlUSANRSzMeN+4XApGURQggCOMsqc5dYUNKrG4smN/XJ5LgV7W3GaghYvex
 tcjw==
X-Gm-Message-State: ANhLgQ3IuboQxFFj71swed4T9045GnFwJr8gy0M/BGDYwDkQzrBWRWI1
 m4xaol3RVNne7RbIYXwU9WoNvc6FV5lF7VqMqiinWsst
X-Google-Smtp-Source: ADFU+vty2MhttSnlfM+gl9/10hXLSwLDMsC2aFUrNXL/OTM3KfrVY/2xpp3k+uH6ZbYmcijjuRo3onkzWqaAVfWE1Ps=
X-Received: by 2002:adf:b35e:: with SMTP id k30mr4471691wrd.362.1585156990205; 
 Wed, 25 Mar 2020 10:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <f3ee9d2f-ab80-5e66-08e2-02bc773699c3@earthlink.net>
In-Reply-To: <f3ee9d2f-ab80-5e66-08e2-02bc773699c3@earthlink.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Mar 2020 13:22:59 -0400
Message-ID: <CADnq5_NQ=NUueGK4+V1Z0ZjfjKzis9bHJLZdxqtsNdhw_oW8Sg@mail.gmail.com>
Subject: Re: rv200 video corruption caused by what? kernel? Xserver? DDX? Mesa?
To: Felix Miata <mrmazda@earthlink.net>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 25, 2020 at 11:36 AM Felix Miata <mrmazda@earthlink.net> wrote:
>
> 01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] RV200 [Radeon 7500/7500 LE] [1002:5157]
>
> Debian Buster and Mageia 7 are OK, but with Fedora 30 and Tumbleweed with
> kernels newer than 5.3.x, solid background and mouse pointer are all that
> paint properly: http://fm.no-ip.com/SS/rv200corrupt.png
>
> Is this a known problem? If not, whose bug tracker do I file this on, and
> which component?

Can you bisect?  The relevant radeon code in all of these components
hasn't really been touched in ages.  Maybe related to this:
https://lkml.org/lkml/2019/12/14/263
but that was kernel 5.4 not 5.3.

Alex


Alex

>
> # Debian 10 Buster
> ii libdrm-amdgpu1:i386       2.4.97-1        i386
> ii libdrm-common             2.4.97-1        all ii libdrm-radeon1:i386       2.4.97-1        i386
> ii libdrm2:i386              2.4.97-1        i386
> ii libgl1-mesa-dri:i386     18.3.6-2+deb10u1 i386
> ii libva-drm2:i386           2.4.0-1         i386
> ii libdrm-radeon1:i386       2.4.97-1        i386
> ii xserver-xorg-core         2:1.20.4-1      i386
> ii xserver-xorg-video-radeon 1:19.0.1-1      i386
> ii linux-image-4.19.0-8-686  4.19.98-1       i386  # OK Xorg video
> # Mageia 7
> libdricore1-9.2.4-1.mga4
> libdri-drivers-20.0.1-1.mga7
> libdrm2-2.4.100-1.mga7
> libdrm_amdgpu1-2.4.100-1.mga7
> libdrm_radeon1-2.4.100-1.mga7
> libmesaegl1-20.0.1-1.mga7
> libmesagl1-20.0.1-1.mga7
> libmesaglu1-9.0.0-8.mga7
> mesa-20.0.1-1.mga7
> radeontool-1.6.3-9.mga7
> x11-driver-video-ati-19.1.0-1.mga7
> x11-server-xorg-1.20.7-1.mga7
> kernel-desktop-5.3.13-2.mga7-1-1.mga7   # OK
> kernel-desktop-5.4.17-1.mga7-1-1.mga7   # OK Xorg video
> # Fedora 30
> libdrm-2.4.100-1.fc30.i686
> mesa-dri-drivers-19.1.8-1.fc30.i686
> mesa-libEGL-19.1.8-1.fc30.i686
> mesa-libgbm-19.1.8-1.fc30.i686
> mesa-libGL-19.1.8-1.fc30.i686
> mesa-libglapi-19.1.8-1.fc30.i686
> mesa-libGLU-9.0.0-17.fc30.i686
> xorg-x11-drv-ati-19.0.1-2.fc30.i686
> xorg-x11-server-Xorg-1.20.6-1.fc30.i686
> kernel-core-5.3.7-200.fc30.i686         # OK
> kernel-core-5.4.19-100.fc30.i686        # Corrupt Xorg video
> # openSUSE Tumbleweed 2020030322
> Mesa-20.0.1-245.1.i586
> Mesa-dri-20.0.1-245.1.i586
> Mesa-gallium-20.0.1-245.1.i586
> Mesa-libEGL1-20.0.1-245.1.i586
> Mesa-libGL1-20.0.1-245.1.i586
> Mesa-libglapi0-20.0.1-245.1.i586
> libdrm2-2.4.100-2.2.i586
> libdrm_amdgpu1-2.4.100-2.2.i586
> libdrm_radeon1-2.4.100-2.2.i586
> xf86-video-ati-19.1.0-2.2.i586
> xorg-x11-server-1.20.7+0-3.1.i586
> kernel-default-5.3.12-2.2.i586          # OK
> kernel-default-5.4.14-2.1.i586          # corrupt Xorg video
> --
> Evolution as taught in public schools is religion, not science.
>
>  Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!
>
> Felix Miata  ***  http://fm.no-ip.com/
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
