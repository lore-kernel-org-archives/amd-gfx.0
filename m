Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D235D3B7EA
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 22:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A85BF10E053;
	Mon,  8 Dec 2025 22:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SkVaPrX+";
	dkim-atps=neutral
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A76710E053
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 22:02:14 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7c6e815310aso3375442a34.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Dec 2025 14:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765231334; x=1765836134; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fVt8IgvjZabxvRirg5KOF283yCYth/IJqlz0h01fgmo=;
 b=SkVaPrX+9y21sZFYCRozgkXD2l8Z2v3l/JSpsz/4mixhSnaALlMaAqxP+rm067NLtN
 y336tmMGaVW6aS4+4Hjt/B3ZQcGcC2n4kri7BKoSzkhIvgYTh4TEXcrz7pyqHIFR1mcC
 GbwWxSMqcDsjIJBE0fCTGaJ0qEtfyZNPW6bi8qcOE+S/jp79fpYTX193LfKdr98QJjOg
 di9fnFxtEzKcjv8Bxv/y05vpQ4ihpgf0aSH+w2NNuvcBT6jF1Yoft7FHPxY672SlkuMN
 7mGIPVQ/jKpr3tf4VnWYFK8yX1qSklNLaswye1bDBxPLjKVzJLXWdjWx9IG8y2p7E2BG
 THSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765231334; x=1765836134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fVt8IgvjZabxvRirg5KOF283yCYth/IJqlz0h01fgmo=;
 b=MuIX2904isr9ay4MVzs/iMkTlUv5Px3PLEQkfcc6BtzZAlqVZh2LKJkb8YVtD+6FlM
 OAkK1YXeWYMMkJQjpaBL2nVumqEVXNLKjZaYM4f9dOcYvOYbYKrH7i1Rbo5D5vvkoZJ3
 uSGwhb2Ci8zJditBpShBiZRaCqmzVs7PG7W0GrLQ9BffJziHX/Hu1BDfzb3SuOcTeUIz
 9pZS62hQx2IFUZ/28m+fbXU0HXebnZt1DkHWVowg1sraAEGNRh7v/xzlavNZtxHl7SNC
 7np+Deu/rVtw9u1b+xdwkA7OPvM8oa2FaSRJ+2RvbsO0UGiLSeRBukoLfT1vIBz4wO02
 fxfQ==
X-Gm-Message-State: AOJu0YysXvdXZxqyfWHhO1+ZuXZR81gxlkAsYG2fm1FMB20bPnf2P9K6
 HXrfIef9e+FoyYhwzfcvsTWW9rTaTHvUJGkm+AG8HN5KfS5w+e9l+Rk++phV35dJ+88Ody3uCNY
 xZw6DdkRg8WNWUIEKIfBljZn+HOHmN7I=
X-Gm-Gg: ASbGnctj2bL0Y9cppJpEWnQD2FWCOVpmg9W//OlAVRGuhiRv5xsInA60D0XfsmTCdqs
 ZeE6AAIYsar1EQAwGDRs5kDFAxFNMxu8Me6cKfh4sVxYklU/+S4PH2tUELxm2JnGdh+DoS/TYBi
 UN5GBa1lDCBTHwCsHhKhh+0xw+WSibz2tLJn96cBvBQ36Vyd4ndlUtOQgoNNkDwou5GJtq4HfVt
 3ch1+mnQ5vA6LkqiEjyZ0mTrtMpJ1lod0+dccp/BDLhKf95FIXbxtuO+Lf9sHOPrgIm4tmj
X-Google-Smtp-Source: AGHT+IEGQPmABfFYWyRnPmHVJ4hHiJjupAvq1McgKI5R4WuLpi020AOcnlO668vjhlanH/ONYj2SsH2SpkF4W+oifI8=
X-Received: by 2002:a05:6830:30a2:b0:7c7:66f7:2caf with SMTP id
 46e09a7af769-7c97078640dmr3952087a34.10.1765231333280; Mon, 08 Dec 2025
 14:02:13 -0800 (PST)
MIME-Version: 1.0
References: <CAPEhTTGamEFapOA4pKgMQxDz9Go1k0QeGRkk5bR-X2jR+iBCcg@mail.gmail.com>
 <CADnq5_Mh7M=019sJ274GLtMyKDH5MSMfR=k6pVTS1z2DV1tQCw@mail.gmail.com>
 <CAPEhTTGJb85fP4iJXAWVkg+vai2xDi-76RFhbmuG0Gc-XT+dKg@mail.gmail.com>
 <CADnq5_PJ+1pJcoxGZPU3xv19nTac76e8bTi+rabfXCRmdnfcQw@mail.gmail.com>
 <CAPEhTTGYADUKQPrF2R4NOm7sRzzpJbYVH+j3ECVyKMNHXTjiBg@mail.gmail.com>
In-Reply-To: <CAPEhTTGYADUKQPrF2R4NOm7sRzzpJbYVH+j3ECVyKMNHXTjiBg@mail.gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Mon, 8 Dec 2025 17:02:02 -0500
X-Gm-Features: AQt7F2qCMQh0rX77bOA7T7sWgFAgqIK3bXqe-lk1zyNB2R6BO87pb3dzai8y7JA
Message-ID: <CAPEhTTEdO70Ggey15zioH68En-oH5W_w_1=gqoqUW-qzrp_3rw@mail.gmail.com>
Subject: Re: SI - are power and voltage readings supported by the hardware
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Freedesktop - AMD-gfx <amd-gfx@lists.freedesktop.org>, 
 Alexander Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Mon, Dec 8, 2025 at 4:12=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> I should have asked previously: were SI gpus based on SMU6 or are they
> using SMU7?

Forget this question, I found the answer in the DPM IP block.

>
> On Mon, Dec 8, 2025 at 9:32=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
> >
> > On Sat, Dec 6, 2025 at 11:30=E2=80=AFAM Alexandre Demers
> > <alexandre.f.demers@gmail.com> wrote:
> > >
> > > OK, I was hoping for a similar SMU7 implementation never completed.
> > >
> > > I see both VDDC and VDDCI (for Evergreen+) values available. When
> > > looking at amdgpu_pm_info, VDDC would be reported as VDDGFX I suppose
> > > (and inX_label under /sys/class/drm/cardX/device/hwmon/hwmonY/), isn'=
t
> > > it?
> >
> > Yes.
> >
> > >
> > > What would VDDCI correspond to? I mean, how should it be displayed
> > > (maybe it has its specific inX_label)?
> >
> > I don't recall off hand what voltage domain VDDCI was off hand.  I
> > think it may have been the memory interface.  I'll see if I can dig it
> > up.
> >
> > Alex
>
> Thanks
> Alexandre
> >
> > >
> > > Cheers,
> > > Alexandre
> > >
> > > On Mon, Dec 1, 2025 at 10:26=E2=80=AFAM Alex Deucher <alexdeucher@gma=
il.com> wrote:
> > > >
> > > > On Sat, Nov 29, 2025 at 8:44=E2=80=AFPM Alexandre Demers
> > > > <alexandre.f.demers@gmail.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > I was wondering if SI GPUs support reporting power and voltage va=
lues
> > > > > at the hardware level? I read somewhere that it was supported fro=
m
> > > > > GCN1.2 (Tonga and over), but I haven't found anything on prior
> > > > > generations. Going through the register names, I wasn't able to
> > > > > identify any who may correspond to power or voltage level.
> > > > >
> > > > > So I'm asking, just in case it is supported and I missed the
> > > > > information while searching for it.
> > > >
> > > > Correct.  There is no interface to query the power.  For voltages y=
ou
> > > > can look at mmTARGET_AND_CURRENT_PROFILE_INDEX to find out the curr=
ent
> > > > DPM level and then convert that into struct si_ps to look up the
> > > > voltages, similar to what is done for sclk and mclk.  See
> > > > si_dpm_read_sensor().
> > > >
> > > > Alex
