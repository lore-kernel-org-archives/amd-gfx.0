Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E79C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jun 2022 18:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B85A0112AF8;
	Tue, 14 Jun 2022 18:30:30 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93ED9112AF8
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 18:30:29 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-fe539f9afbso13574634fac.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 11:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6Ta4OVPF9t2n3DStY+tyeBicFUUnO4XpWPTbgyVzBm8=;
 b=OfMpfFyuZXVUmtyA8880mt7nN+3mQ45hMh6vf8vlUIqCmcz5yaa1Hb8N39CAKsjC+/
 wTXtDy5Q3+VbnC27578+/NRxWHzOnADRKwTKiaGXQnKIBXbB17qQmuOYUMbSSvESbUZf
 9SW9p8/FRI5a56Rqdjb9wL5OsKQJ6kpDmP/BDPu68of5SI4EUY4fWZtn3OQMRFQXRE1/
 QucunmH1Q/2s9Rn2Ne5KZw6pfoKXFB199GdhJiixVZoraGjvf7BhQ1N/tfcDaHalki4w
 rTPJnkc0yeq6vZa97W4/6Yn5YO1sg1FuB2v64OQJjGCPU/r3iOVe1S9VQPMhUcIbHMxP
 /BcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6Ta4OVPF9t2n3DStY+tyeBicFUUnO4XpWPTbgyVzBm8=;
 b=E3Tyr6zX1gMNcUR/2/T1FAdGlAZi5mAXUwwpgWih9omsLAM1JxN+KB6E5K4WPnW9pN
 4t9gqhJj1PyxROhKIhHDpySC25E7fA+E1GlgrtxhHz2NRU+eNITS4qXRc2DZnaNbSMB+
 094dFPBd8nTp7zfjj6HH5AmirBfAfS3lOdLYmNZ7vAlzs3afS3TBk8ganHjgm4qVyOYW
 vItdsiZAHoLk32nh3VaHVyPTZWElhGH2sEazXZx08lB9OkqXcbnntwDuGqdZ9QD/Gwx6
 QZhqF3v+S1Ggj/WQXByKva8tyQvlfcn9ZAaYB2KBd8/MLooqKa92KjvTXMvF54WWg0u1
 tGvQ==
X-Gm-Message-State: AJIora+kMGPj/fCpw2PlDNrKxgb0fNT2StmQJ/YDfjQ4Z5si9fcbIfih
 pkRZdG44vCtPe5zWmpNXBJFxvQVJkgm4KtouokE=
X-Google-Smtp-Source: AGRyM1sbyVodUhtmPHTfJas/oU9oEy61/eJf4/CqVBVtfum3XAFLGr9UuE2U4bW0LVQrMgH2OsiMsSUzTLrcJv6F1mc=
X-Received: by 2002:a05:6870:538b:b0:101:17f2:d6e with SMTP id
 h11-20020a056870538b00b0010117f20d6emr3110989oan.200.1655231428805; Tue, 14
 Jun 2022 11:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220613200112.3377638-1-Rodrigo.Siqueira@amd.com>
 <20220613200112.3377638-2-Rodrigo.Siqueira@amd.com>
 <pp_VMylAJoi-vp3VAJIjkeIfC89ncoHCCBFR_7ook2cjR9uC7bgBWcsjaFGNPFPgRMJHkwli2RNeXP0L32NQ8-Qvwf1IbTSyG8U5KNhTdJ8=@emersion.fr>
In-Reply-To: <pp_VMylAJoi-vp3VAJIjkeIfC89ncoHCCBFR_7ook2cjR9uC7bgBWcsjaFGNPFPgRMJHkwli2RNeXP0L32NQ8-Qvwf1IbTSyG8U5KNhTdJ8=@emersion.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jun 2022 14:30:17 -0400
Message-ID: <CADnq5_Pp+xSJO1mR24PQmm5bHhjY1Q-wC8GG97pr6axvrkmZeQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] Documentation/gpu: Add info table for ASICs
To: Simon Ser <contact@emersion.fr>
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Alex Hung <alex.hung@amd.com>, Mark Yacoub <markyacoub@chromium.org>,
 Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Melissa Wen <mwen@igalia.com>,
 Leo Li <sunpeng.li@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
 Sean Paul <seanpaul@chromium.org>, Isabella Basso <isabbasso@riseup.net>,
 andrealmeid@riseup.net, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Pierre-Loup <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 14, 2022 at 2:16 PM Simon Ser <contact@emersion.fr> wrote:
>
> On Monday, June 13th, 2022 at 22:01, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com> wrote:
>
> > Amdgpu driver is used in an extensive range of devices, and each ASIC
> > has some specific configuration. As a result of this variety, sometimes
> > it is hard to identify the correct block that might cause the issue.
> > This commit expands the amdgpu kernel-doc to alleviate this issue by
> > introducing one ASIC table that describes dGPU and another one that
> > shares the APU info.
>
> Nice!
>
> Are there plans to keep this list up-to-date?
>
> FWIW, my go-to reference tables are [1], updated by Alex.
>
> Would it make sense to add a "GFX Core" column?

That's what the GC column is for.

Alex


>
> [1]: https://www.x.org/wiki/RadeonFeature/
