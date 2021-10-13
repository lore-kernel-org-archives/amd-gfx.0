Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9732CC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 17:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C44260F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 17:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C44260F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBEB86E0D7;
	Wed, 13 Oct 2021 17:19:19 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 817276E0D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 17:19:18 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 d21-20020a9d4f15000000b0054e677e0ac5so4580256otl.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 10:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RGILKbEqa8GBT9rqszH4NiqVoFEG3A3gPPyOtiipdfA=;
 b=NKDljYR8/OUhtWY0mzVAKTg1lxy5YP6NaV/m/ONzwbJV3SSGkSfej40gOQGRHMCKNX
 /1lZ0XHbn37tS0ITADLJ9ZUAvoErEY6K2GmOXUJuwVmoPMAvNKua+b79GdrVEmSLgnXM
 up3e3GnYSVxG7DuR5/oUenk5G5m/Blx87oBhwjw9d/BTYz+pMqRFwrFt09RUCjDDlL24
 GF9cnA6v/kQZkhaBN6ON2F6p43zpRMWwf5vaFd7oH9Zpjp/lZWqisPcfatQTeWYCpyI+
 JSPPdSrN/8deeCZtJTKPABpomERed3MGFupIeCJOhzNF3xaBQZG3UN6vA+w50lsPJrhs
 t8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RGILKbEqa8GBT9rqszH4NiqVoFEG3A3gPPyOtiipdfA=;
 b=nEeRpwP2HZtK+OJSlqwrZp2yj54pkni/+SlbrNasPIwYlO2o/Q3AvjfgtoVxK1lv+n
 sAjwPClhvmtyfiLAYvxYb+Z5puloOt6AGU/UweP86eHgIT/60UeJ5/Ov/8wHYuSOfXD5
 bPDkKvt/gdBXVFpeNNJlJOegSiLHhUs3VGiKYX8XSRDg9TGk6NRIZlSYqqrGLXsFO3fq
 CWq7CNhdc/l533yxnA3tTm4BuS7KQr/GzMDTD4cmwZbaiSKSPhlpGQmPMRewKm1r2aWI
 GETzY3X31iLqQ5/1oj29HOGX4lbLaJLNXDZSL8zqxhQdDiJ3H80glRj4igQvNMBaw2S3
 2Npg==
X-Gm-Message-State: AOAM532eQJnUvfD/J7LDC5QS6yidgX1XwoHx446e513Tx0ist946I6qK
 w6sqOR6M1fAEIAxCXlS3lninfDSERU8qF/UKG1A=
X-Google-Smtp-Source: ABdhPJwUD0noSoxIixpsBQ6SLbGJsDerN1I44ZqESXK5SfF6arHxampVvtM2bChgzVrGnym+bIRUoaj3WRjCEmz/LEE=
X-Received: by 2002:a05:6830:214c:: with SMTP id
 r12mr390089otd.200.1634145557822; 
 Wed, 13 Oct 2021 10:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211013031042.53540-1-luben.tuikov@amd.com>
 <858da53c-7937-3ebf-360d-f20f30f825d9@amd.com>
 <e3d94e8a-ea9b-85cc-8e85-2ee2e6725f2f@amd.com>
 <DM6PR12MB39307EA02DE72479774D8FF297B79@DM6PR12MB3930.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB39307EA02DE72479774D8FF297B79@DM6PR12MB3930.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Oct 2021 13:19:06 -0400
Message-ID: <CADnq5_P1b4zTr3Rko_4VDTWR-+OAA-pSL8JHQZNOOEQd9=JLfg@mail.gmail.com>
Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
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

On Wed, Oct 13, 2021 at 1:06 PM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>
> [AMD Official Use Only]
>
>
> >Or maybe just a list without default hint, i.e. no asterisk?
>
> I think this is also fine meaning we are having trouble in determining the current frequency or DPM level. Evan/Alex? Don't know if this will crash the tools.
>

That seems reasonable to me.

Alex

> Thanks,
> Lijo
> ________________________________
> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> Sent: Wednesday, October 13, 2021 9:52:09 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
>
> On 2021-10-13 00:14, Lazar, Lijo wrote:
> >
> > On 10/13/2021 8:40 AM, Luben Tuikov wrote:
> >> Some ASIC support low-power functionality for the whole ASIC or just
> >> an IP block. When in such low-power mode, some sysfs interfaces would
> >> report a frequency of 0, e.g.,
> >>
> >> $cat /sys/class/drm/card0/device/pp_dpm_sclk
> >> 0: 500Mhz
> >> 1: 0Mhz *
> >> 2: 2200Mhz
> >> $_
> >>
> >> An operating frequency of 0 MHz doesn't make sense, and this interface
> >> is designed to report only operating clock frequencies, i.e. non-zero,
> >> and possibly the current one.
> >>
> >> When in this low-power state, round to the smallest
> >> operating frequency, for this interface, as follows,
> >>
> > Would rather avoid this -
> >
> > 1) It is manipulating FW reported value. If at all there is an uncaught
> > issue in FW reporting of frequency values, that is masked here.
> > 2) Otherwise, if 0MHz is described as GFX power gated case, this
> > provides a convenient interface to check if GFX is power gated.
> >
> > If seeing a '0' is not pleasing, consider changing to something like
> >        "NA" - not available (frequency cannot be fetched at the moment).
>
> There's a ROCm tool which literally asserts if the values are not ordered in increasing order. Now since 0 < 550, but 0 is listed as the second entry, the tool simply asserts and crashes.
>
> It is not clear what you'd rather see here:
>
> $cat /sys/class/drm/card0/device/pp_dpm_sclk
> 0: 550Mhz
> 1: N/A *
> 2: 2200MHz
> $_
>
> Is this what you want to see? (That'll crash other tools which expect %uMhz.)
>
> Or maybe just a list without default hint, i.e. no asterisk?
>
> $cat /sys/class/drm/card0/device/pp_dpm_sclk
> 0: 550Mhz
> 1: 2200MHz
> $_
>
> What should the output be?
>
> We want to avoid showing 0, but still show numbers.
>
> Regards,
> Luben
>
> >
> > Thanks,
> > Lijo
> >
> >> $cat /sys/class/drm/card0/device/pp_dpm_sclk
> >> 0: 500Mhz *
> >> 1: 2200Mhz
> >> $_
> >>
> >> Luben Tuikov (5):
> >>    drm/amd/pm: Slight function rename
> >>    drm/amd/pm: Rename cur_value to curr_value
> >>    drm/amd/pm: Rename freq_values --> freq_value
> >>    dpm/amd/pm: Sienna: 0 MHz is not a current clock frequency
> >>    dpm/amd/pm: Navi10: 0 MHz is not a current clock frequency
> >>
> >>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 60 +++++++++------
> >>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 73 ++++++++++++-------
> >>   2 files changed, 86 insertions(+), 47 deletions(-)
> >>
>
