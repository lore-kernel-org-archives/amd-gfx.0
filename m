Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93FFC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 19:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91A4B6E87C;
	Wed,  1 Dec 2021 19:39:06 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBCF06E87C
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 19:39:04 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id bf8so50791614oib.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Dec 2021 11:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6UcKwnXRAA8Tk34sG61dx6fu5FQSmvmOazCS4nSETEI=;
 b=Nj9N766CruP8q3U6AwgG8xxtxZ473CMjMau7B31PaN+QkEUefiFNQ5TmQDn3JHr2Yp
 KcyAJBWI9o5CYuaMvuL/2abiXd6Z+6vPPD/xhE0b/SOiWqnHduoyR8wpNYN8354SORIr
 A8D2dcp+fgbSG4EQFDBBasbhyvHmm6sehXga6Tmb3cOaMsdUlkW9VM4Le+P82XzYB02j
 DX1xB/GalmtPgT7NB57LU3agPv8IjSlrpx4P7zJQ2l1eG/1B6fx7O5iiEE0+HZ/VM0Fx
 9zGBIXl5nxFMIVKgPp99XAoUFK9NEfCRCA4vobyckjCKiq8nBnpAXcvcWf7Q3oryCaMH
 5bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6UcKwnXRAA8Tk34sG61dx6fu5FQSmvmOazCS4nSETEI=;
 b=RX0h38/DeTfH4DT6TpByJr+xtY4xHStxBXMEUT8XVjaOHkH8LgqMzdm5BnLKbhWhwX
 WJfyhXY60TMQ2SzM6J+jcR+VF6rACq+vRQL3C6sGmVF1Yd1RKNVS/JcwAKKioEOC+r7y
 OABOkmTatXFsoBnQesk6li1DYIiELm84Q6KBeU/oE9Rvovg/76WZXxGjqZ8QNX8SfA2o
 xWiJyDioLK4BqjkND024COrcwrSzpr7N3HL3fyxtJqTSdqPqkN9+kuC7jwcW+pPR8Uyc
 4tWYqnh2aq8SAQhVZPyKg5zmrRs4szSShCxUSS+BOj/1jL2ExITTRlIbopKIYO2X3Z0n
 EaVQ==
X-Gm-Message-State: AOAM531gD8JnjDDOhBM2/fGzowCPYlPr92vKymnNUpJp7pzALhi9bBaD
 +66+pEzla0Q7vlW03vkEwZJCTBjL2O53dMSVgxY=
X-Google-Smtp-Source: ABdhPJx8emaQ2DfZ90c0mUVORR2jqjay2m8a5z8/pnXTN6JU1osaec1XX1i/zhkD8iJEFznrxeZfiOWJ4cMQU2Xa77k=
X-Received: by 2002:a05:6808:44:: with SMTP id v4mr247880oic.123.1638387543996; 
 Wed, 01 Dec 2021 11:39:03 -0800 (PST)
MIME-Version: 1.0
References: <1637819291-4159-1-git-send-email-Prike.Liang@amd.com>
 <0bf43968-25fb-7303-ad93-e7d79a0105a5@amd.com>
In-Reply-To: <0bf43968-25fb-7303-ad93-e7d79a0105a5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Dec 2021 14:38:52 -0500
Message-ID: <CADnq5_Pqbgvpmra2RPtgP4Ww8DUOCZ1hz7hwdmKoQLKOF=M1xg@mail.gmail.com>
Subject: Re: [v3] drm/amdgpu: reset asic after system-wide suspend aborted (v3)
To: "Limonciello, Mario" <mario.limonciello@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 Huang Rui <ray.huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 1, 2021 at 1:46 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 11/24/2021 23:48, Prike Liang wrote:
> > Do ASIC reset at the moment Sx suspend aborted behind of amdgpu suspend
> > to keep AMDGPU in a clean reset state and that can avoid re-initialize
> > device improperly error. Currently,we just always do asic reset in the
> > amdgpu resume until sort out the PM abort case.
> >
> > v2: Remove incomplete PM abort flag and add GPU hive case check for
> > GPU reset.
> >
> > v3: Some dGPU reset method not support at the early resume time and
> > temprorary skip the dGPU case.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 7d4115d..f6e1a6a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3983,6 +3983,14 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
> >       if (adev->in_s0ix)
> >               amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry);
> >
> > +     /*TODO: In order to not let all-always asic reset affect resume latency
> > +      * need sort out the case which really need asic reset in the resume process.
> > +      * As to the known issue on the system suspend abort behind the AMDGPU suspend,
> > +      * may can sort this case by checking struct suspend_stats which need exported
> > +      * firstly.
> > +      */
> > +     if (adev->flags & AMD_IS_APU)
> > +             amdgpu_asic_reset(adev);
>
> Ideally you only want this to happen on S3 right?  So shouldn't there be
> an extra check for `amdgpu_acpi_is_s0ix_active`?

Shouldn't matter on the resume side.  Only the suspend side.  If we
reset in suspend, we'd end up disabling gfxoff.  On the resume side,
it should safe, but the resume paths for various IPs probably are not
adequate to deal with a reset for S0i3 since they don't re-init as
much hardware.  So it's probably better to skip this for S0i3.

Alex


>
> >       /* post card */
> >       if (amdgpu_device_need_post(adev)) {
> >               r = amdgpu_device_asic_init(adev);
> >
>
