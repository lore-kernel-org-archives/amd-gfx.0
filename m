Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC16C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 13:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5F960F94
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 13:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BC5F960F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BFA66E0C1;
	Wed, 13 Oct 2021 13:58:46 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD1B76E0C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 13:58:44 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 i1-20020a4ab241000000b002b7069d0e88so821929ooo.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TG0W3rdDuQbkyUv2ZSnaHM/2kKC+z18SeSMibRFmE14=;
 b=FFnnARdUEcN/idKprranyFZCE81vQLTSl0uviY/4/hAl+DWTw6zqqN1899Epb2499s
 bwGmevVAS38IjXZJ2xKObg32ycJWl07FNopoBgahXcsmS8dOWGdKnnnedJQ+qLUqnZFy
 iq9XqN4B3FNPQ59UvOaRX6jZtoQ55Ibuq+xO2Q2Yxz2O6S0BvCP5/xRFroQX5dbax6N4
 rCkINDXOc+BSYR9N0LuwDOMDzPaYJRI9ntWovK5DdYdvv2Lf5VTexO8H0E6CqFuwIWqO
 LfQt0XWvveRkAz+sIc3ouUOQkAjrab71Bq0nRSgU2iDIUH8rR4WoWYA1RndIWWjGqQh5
 /3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TG0W3rdDuQbkyUv2ZSnaHM/2kKC+z18SeSMibRFmE14=;
 b=TaeBdF3fFEz3Mm8LHW6MSugmQZeOBeVSBXn1+xxzE2NnBERqtDO+pw7K/SFPr34izK
 8rXzpTnmMuFJvRp+mWBrshzbnKBSOlwyFIFr+h6B1cEp64qOYa/BzCn1Pb65AypEd0PP
 6nhw5AP7rqGaXPrPXj2Z5GFEcEPZfivXlhFSkImuGPIZzsI3Zyem+IC9Eh1+Pivc9DDv
 L8wTRSwL3NByULp3JVStwfLa6w+VXgocxSdj+7IZB93FoOd97JkRYNHojIILquev9gUx
 Ni4x3W6KkgidxV2SrWVwQ/2kQ1iAAPROma/20pTmLiYw17VtHHLFqflXyKPmuDsK6wgT
 FAFw==
X-Gm-Message-State: AOAM532jn9w7m8+a0ys6NewyWCM5Qxof5abVnDQ9YSZ1Wx3psTa/IWev
 efh6iyLtTAe4ek4KJgJ40U5iXEVWMqO5HKYwv7A=
X-Google-Smtp-Source: ABdhPJyJ4G3WLlAt8pU2jMCZjal+rWN0uUptYgtLNLY3yV6XFYkoCctLhMyezaGV9gRfTGOmWxfPOJXsHFnfqkgCYzk=
X-Received: by 2002:a4a:b881:: with SMTP id z1mr8145719ooo.68.1634133523826;
 Wed, 13 Oct 2021 06:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211013031042.53540-1-luben.tuikov@amd.com>
 <858da53c-7937-3ebf-360d-f20f30f825d9@amd.com>
In-Reply-To: <858da53c-7937-3ebf-360d-f20f30f825d9@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Oct 2021 09:58:32 -0400
Message-ID: <CADnq5_MAoug4Ex=Dq0wudhrVz6TyhgQn8JuvVhqt5MMzXCBMAw@mail.gmail.com>
Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Luben Tuikov <luben.tuikov@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Alex Deucher <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Oct 13, 2021 at 12:14 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 10/13/2021 8:40 AM, Luben Tuikov wrote:
> > Some ASIC support low-power functionality for the whole ASIC or just
> > an IP block. When in such low-power mode, some sysfs interfaces would
> > report a frequency of 0, e.g.,
> >
> > $cat /sys/class/drm/card0/device/pp_dpm_sclk
> > 0: 500Mhz
> > 1: 0Mhz *
> > 2: 2200Mhz
> > $_
> >
> > An operating frequency of 0 MHz doesn't make sense, and this interface
> > is designed to report only operating clock frequencies, i.e. non-zero,
> > and possibly the current one.
> >
> > When in this low-power state, round to the smallest
> > operating frequency, for this interface, as follows,
> >
>
> Would rather avoid this -
>
> 1) It is manipulating FW reported value. If at all there is an uncaught
> issue in FW reporting of frequency values, that is masked here.
> 2) Otherwise, if 0MHz is described as GFX power gated case, this
> provides a convenient interface to check if GFX is power gated.
>
> If seeing a '0' is not pleasing, consider changing to something like
>         "NA" - not available (frequency cannot be fetched at the moment).
>

I don't think this interface is really supposed to be the way to get
the current clock, although some use it that way.  It's supposed to
show the DPM states and which are active.  conflating the interface
with other information confuses things in my opinion.  Why is the
current clock less than the minimum clock?  Whether or not an IP is
turned off or in deep sleep or not is independent of DPM states.  When
the IP is active, it will never go below the minimum DPM level.  If we
want to query deep sleep or gfxoff we can use the amdgpu_pm_info
debugfs interface or add some other new interface.

Alex


> Thanks,
> Lijo
>
> > $cat /sys/class/drm/card0/device/pp_dpm_sclk
> > 0: 500Mhz *
> > 1: 2200Mhz
> > $_
> >
> > Luben Tuikov (5):
> >    drm/amd/pm: Slight function rename
> >    drm/amd/pm: Rename cur_value to curr_value
> >    drm/amd/pm: Rename freq_values --> freq_value
> >    dpm/amd/pm: Sienna: 0 MHz is not a current clock frequency
> >    dpm/amd/pm: Navi10: 0 MHz is not a current clock frequency
> >
> >   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 60 +++++++++------
> >   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 73 ++++++++++++-------
> >   2 files changed, 86 insertions(+), 47 deletions(-)
> >
