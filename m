Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B942C87FCA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 14:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C99D910E86B;
	Thu,  7 Aug 2025 14:20:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b="ycDc+Gqf";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC90710E86B
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 14:20:21 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b42348bae1fso628184a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Aug 2025 07:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20230601.gappssmtp.com; s=20230601; t=1754576421; x=1755181221;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gme0KrEEsWMq3KsuCTH7StJnzfVE5lLI2hFwEmjGx7o=;
 b=ycDc+GqfbcLsdpQkhMKbQwhD1I2SKgeHAEyndEUmOhhhu4Bj6HlWl5QpphpVuArkXm
 qRZQllvyyqFTvbwg0e+1xAAbrGcsnI5PhMXColWo0pbSyTOoKrsolPcC+kHcemEyZ2pz
 sb7VNFeD4la14Ifh0GKYEo18VrGmsqts1yMJ6DsEen1Z+d/ECHXjQH7lJOs9U5MgCVGs
 RNNk6ek2rN2+IDzHIl6mniWa7lSuI+PoiY627sp8etrgOJxBNHIQmvyB5k9LkkY1HJ3g
 6TtYfDF2c0oWsZV5rSgn+IiPG9aati4wgH0p30M7YDLBtLifD0tG/tg+CBWUIBM8wgqm
 C+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754576421; x=1755181221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gme0KrEEsWMq3KsuCTH7StJnzfVE5lLI2hFwEmjGx7o=;
 b=WTGLacxO0WxMl8nerMOUy5RefmD3YoQ2ITf4UjzyQghUU4xx3dZidwPVJ4d2wqXTHS
 vjL+ed4fV4yaKf90knsm3iWIgK5P4gfCiOKf7c9OVNxsP4CQoBBJNbaDOapsjX9xEaCd
 ZBTxmFBIgNUF0S/uGJGzy7a6qS198fVk6cr9eYPIlK4olBdDeGOADmm+qOA/4z1uCyUa
 gTcy0Gd6BcGPut/Rm0hJmNMI/Okrz6TpCs5MH+lA9h6lhxPolqNLbyFS6VPcBA3Rrs1C
 uLI6hLejV3S0n2zaEQz6QuWUJJEHU8wiZZUORcavtzAgs4wy4keSRsnx3Pf6qQTo2CSp
 5mlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVJzDVQZjHs3LLdOrCgM/9hkKsOWg1AamBO4ANle2Lu890UJEu62WtjPM7LJWgGYmOdRNZLH0U@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxN4c3WFvGBjlrtsmJIwSqWLJ781fjxowxkpwgEryf45z/D+Et/
 hniSJCwUaaceig3KwhEoZJX6nFGimb4AtINo7jYK3k1HUBgRPwKZ8yKWQlWOPBufDLuV2ZyGwTt
 88T18qjEA8+94CGteC1VwHggE7g97i43kN/XdqtWf
X-Gm-Gg: ASbGncvywShpNu1BDI8bTB4sU71h/Etgrf5WI1mxgOTwriBvGkaFOwuZlALj873fTsP
 gkN/PX0xGdA0cfrXDWScZlKJzIf0TNAGLThW1U3KXFt/mpKX8+nRPWJRRsqe6paP5F4/Zn9iQc1
 W11J+8f+0hSMjwv2BBtnHpuJhUdQrO8tAKwvzrY8sMY5HFNL03hJwAGhkPmWIwyYPnkRNtUCuuG
 k1IGB5/UFpdsAcvrvSBBSXBx6KYq/cVs9zgwOGB5Q==
X-Google-Smtp-Source: AGHT+IFXROpKljKSnKMtzbtgCANR6dqlioumceI2A+gqIZ+dh8QveoowiXfKOnmChzl9p4UGLP+n/nFT7jptS22CiqM=
X-Received: by 2002:a17:903:1206:b0:23f:cd6e:8d0f with SMTP id
 d9443c01a7336-2429ee89ecamr86131545ad.13.1754576421042; Thu, 07 Aug 2025
 07:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <hzobspwqosrmrdmzicwabpsr4lcisuwck5nfsh5qwkoek562to@ybja5yzucsbh>
 <CADnq5_O1PyEqtK-GGPgPzkMDeNmTCFFNDLd-+73NDqFtPVL2oA@mail.gmail.com>
In-Reply-To: <CADnq5_O1PyEqtK-GGPgPzkMDeNmTCFFNDLd-+73NDqFtPVL2oA@mail.gmail.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Thu, 7 Aug 2025 15:20:09 +0100
X-Gm-Features: Ac12FXxbWB9APD5YDdI6KY4rTukhubIfAR7iWqIsmzMBr1waXBEIc1Bz4jvQwc4
Message-ID: <CAHbf0-EA6-jn8tOCuXv=9JyZr-4kKhoFBZC-pqQcG4ydncHTOw@mail.gmail.com>
Subject: Re: Is amdgpu open to converting logging to drm_* functions
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Brahmajit Das <listout@listout.xyz>, alexander.deucher@amd.com, 
 christian.koenig@amd.com, sean@poorly.run, amd-gfx@lists.freedesktop.org
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

On Thu, 7 Aug 2025 at 14:22, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Aug 7, 2025 at 9:13=E2=80=AFAM Brahmajit Das <listout@listout.xyz=
> wrote:
> >
> > Hello Alex, Christian,
> >
> > I'm a mentee at Linux kernel Bug Fixing Summer 2025. I came across the
> > TODO list on the kernel doc, and specifically this section[0]. Would
> > amdgpu be open to this conversion. I saw that before starting it is
> > recommended to talk with Sean and the relevant maintainer. Hence I'm
> > emailing you folks.
>
> It would be nice to get rid of the old DRM_INFO/ERROR/DEBUG macros and
> replace them with the dev_ or drm_ replacements.
>
> Alex
>
> >
> > I guess you can also refer to this,
> > https://patchwork.freedesktop.org/patch/msgid/20191219161722.2779994-1-=
daniel.vetter@ffwll.ch
> >
> > [0]:
> > https://docs.kernel.org/gpu/todo.html#convert-logging-to-drm-functions-=
with-drm-device-parameter
> >
> > --
> > Regards,
> > listout

Pet peve I get random HDR SB messages printed to my dmesg by the following =
line:

https://gitlab.freedesktop.org/drm/kernel/-/commit/88694af9e4d1feaf635c2384=
4833960f8958af78#298241cee0e184ade58580011daae827741f9838_3874_3927

I'm not sure how this is useful, or how someones supposed to realise
it's from amdgpu either
