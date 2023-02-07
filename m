Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFB8C636CC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 04:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC3A410E2D6;
	Tue,  7 Feb 2023 04:05:52 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3544910E1BD
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 04:05:50 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-16346330067so17664421fac.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Feb 2023 20:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OX96IF7tIWxdfZZdyEjjjTRQ5A66qit8raNQL5Wxx4g=;
 b=bAeRpk4XTc0N95BCRh6vGUuyo4ZHG60a22RM4kWIBYfJKW70VP/cBLwlyLe1dPaK7c
 of2O89zKcWS4YImT3yCjqfgUOOfIjBDu7xKZAWq4U4mHEiZf6+joQrXtJsKAANKjG4o5
 uAFdt2YKflnh+hrMxN/RwpISuc5z4Bu3n2Pr8m+ubn4c7xenVnd2LKe77mzWfz50aVIG
 vWtZ73qe1XDWREjEU+2Zm68NHApacDUDLa6TM6kSlgrFFONwA+Om3zJ360K8HaiAgP9j
 5N6f6hhTTHokALIfKLz/FR7KbdTq3i/V32u/v6G33evYIWtTehW7pTJCgbq3I/7Admjh
 Z49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OX96IF7tIWxdfZZdyEjjjTRQ5A66qit8raNQL5Wxx4g=;
 b=T98W3ddTUTJ8dAd3Iz3owc5Bbmrka9g/bEVU0VvX6RuPVEkSQDTIpqHK9llpfabWWf
 kGCO3q/6ag5OVFJXCik/LWah0XcgVjqfvp3fxQv7lejQKSWMZlPat43sdgwDXaZGJZhb
 FEp00P5XdyZRpV8qE21x1k2AR73kX9NyJOb9fVHxNSWJwsLgsjgaNTCEiYRh4nmf8lYF
 PfJggPRSLkw531UI7s7fjeEyTuMCfHIXY2uMRk00a0CAYpEOK054Dt15nB3ztVgNkC7f
 GfsXKNcSu/KZh7NttDNx90zA3wdC0s3fh0ZvUGXB/SoCVXGBA3WM7StZPjRgbQdUXgjB
 04Ag==
X-Gm-Message-State: AO0yUKUxV9qYyvgexDV0B1va4yAry0eTLNjChhUppMvrrZd2dWiFXQXp
 dIzq3PvAapwRVzLfHrc8l930P5S7e032h9SyZCM=
X-Google-Smtp-Source: AK7set/IyJVYs5y5BUdM9EBr9Ex1jk34b7WRAsTDS3k1mxKexnJevsmf/kzcCnlsHJOQonQsQstrZh/zhE/qJrcEmr0=
X-Received: by 2002:a05:6870:ac0d:b0:163:a303:fe2f with SMTP id
 kw13-20020a056870ac0d00b00163a303fe2fmr263849oab.96.1675742749383; Mon, 06
 Feb 2023 20:05:49 -0800 (PST)
MIME-Version: 1.0
References: <rEMJPv8L9uDl7PSSJ_OtbkCcM9ABocJ_Mk8DuSUQpaB2fPEPNB6EBBo7XLlCKqsfF5bCz5jvr9CFt1pVzb37_KZBldUNBMcf2-2B3xDNVN0=@protonmail.com>
 <CADnq5_O__w5jkOoUALv96hybKP8qJs-=wcQAhcxy5kbiBg_vCw@mail.gmail.com>
 <IGhLMOrDFqjKG7Ct93T4NCqIKeGLdSNO9Q5p3CkgzBVK15kInfRfGdv4aFCRJO3TmR2shr_bqjxYmlAgI3BojoM0F9q24Jv82FLmm2fvpp0=@protonmail.com>
In-Reply-To: <IGhLMOrDFqjKG7Ct93T4NCqIKeGLdSNO9Q5p3CkgzBVK15kInfRfGdv4aFCRJO3TmR2shr_bqjxYmlAgI3BojoM0F9q24Jv82FLmm2fvpp0=@protonmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Feb 2023 23:05:37 -0500
Message-ID: <CADnq5_OUwsNzGJA1Hmj9okyhC3BkfTkEw==V88mv_uAApZgo3Q@mail.gmail.com>
Subject: Re: gpu_metrics does not provide 'current_gfxclk', 'current_uclk',
 'average_cpu_power' & 'temperature_core' on AMD Ryzen 7000 CPU
To: sfrcorne <sfrcorne@protonmail.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 6, 2023 at 5:48 PM sfrcorne <sfrcorne@protonmail.com> wrote:
>
> Dear Alex,
>
> First of all, thank you for your response. Personally, I use a Ryzen 5 76=
00X however people with a Ryzen 9 7900X are also reporting this issue. The =
relevant bug report in Mangohud can be found here: "https://github.com/flig=
htlessmango/MangoHud/issues/868".
>
> I looked around a bit in both the Mangohud source code and the Linux kern=
el source code.
>
> (Mangohud source): From what I understand, Mangohud looks for a file "/sy=
s/class/drm/card*/device/gpu_metrics". If this file exists (and it does exi=
sts on my machine), it tries to read this file and extract the relevant GPU=
 data (and in case of an APU also the CPU data) from it (these are the valu=
es I was talking about in my previous mail). When the file "/sys/class/drm/=
card*/device/gpu_metrics" exists, it will not use the data provided by hwmo=
n (/sys/class/hwmon/hwmon*/*).
>
> (Linux kernel): The gpu_metrics file contains different data, depending o=
n what version is used. All valid versions can be found in the source code:=
 "https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/includ=
e/kgd_pp_interface.h#L725". For my CPU/APU the 'gpu_metrics_v2_1' structure=
 is used (I tested this by reading the gpu_metrics file myself). Furthermor=
e, I think that for my case, this structure is set by the function "https:/=
/elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/pm/swsmu/smu13/=
smu_v13_0_5_ppt.c#L459" but I am not completely sure about this.

The metrics provided by the SMU firmware varies from asic to asic.
For things that are not supported by the metrics table for a
particular asic, those fields would be 0.  You can see what metrics
are supported for your asic in smu_v13_0_5_get_gpu_metrics() as that
function populates the supported fields from the firmware to the
common structure.  current_gfxclk is not supported in your asic, but
average_gfxclk_frequency is.  So you'd want to use whichever field is
available for a particular asic in Mangohud.

>
> Lastly, I am not familiar with umr. I assume that you are referring to "h=
ttps://gitlab.freedesktop.org/tomstdenis/umr"? If I find some time this wee=
kend, then I will look into this some more.

Yes, that is the right link.  umr uses the same interface as mangohud,
so you should see the same data.

Alex


>
> Kind regards,
> sfrcorne
>
> ------- Original Message -------
> On Monday, February 6th, 2023 at 22:22, Alex Deucher <alexdeucher@gmail.c=
om> wrote:
>
> > On Mon, Feb 6, 2023 at 9:22 AM sfrcorne sfrcorne@protonmail.com wrote:
> >
> > > Hello,
> > >
> > > I hope this is the correct place to ask my question. I was not sure i=
f I should have opened a new issue on Gitlab or send an email here, since I=
 don't know know whether this is a bug or intended behaviour.
> > >
> > > The question is about the new AMD Ryzen 7000 CPU's. These new CPU's h=
ave an iGPU and consequently provide a gpu_metrics file for monitoring the =
GPU/CPU (APU?). This file is used by programs like Mangohud, that try to re=
ad (among other values) the following 4 values:
> > > - current_gfxclk
> > > - current_uclk
> > > - average_cpu_power
> > > - temperature_core
> > > However it appears that on AMD Ryzen 7000 CPU's these 4 values are no=
t provided/updated in the gpu_metrics file. Other values like 'average_core=
_power', 'temperature_l3' and the other 'current_<x>clk' are also not provi=
ded/updated but these are not used by Mangohud at the moment.
> > >
> > > Is this intentional or a bug? And will this be fix and/or will suppor=
t for these 4 values be added in the future?
> >
> >
> > What specific CPU/APU is this? I don't recall off hand how mangohud
> > queries this stuff, but you can take a look at the hwmon interfaces
> > exposed by the driver or if you want the whole metrics table, you can
> > use umr to fetch and decode it via the kernel interface. That will
> > allow you to verify that the firmware is producing the proper data.
> >
> > Alex
