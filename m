Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1196EC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 15:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9234F10E771;
	Wed, 23 Mar 2022 15:04:08 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A41410E771
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 15:04:08 +0000 (UTC)
Received: by mail-yb1-xb31.google.com with SMTP id t11so3194114ybi.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/q655hlpcKbYdO9fJyRr0g9SmFAUcvg0z56HSQrgBXs=;
 b=qaBK8sKppcaRzErNHs7XlKcRTafbewC4j9oQigOyjY+1s0DB/UVnbR2vqwyYSSVBmC
 9mSet1LA5w51T3rypL0RtYttSwMvpfGcHmyDFwpkgH/Z0sVuJkHy6754X9Atm2DRqH8K
 z+ZIeNy7BKAPSUH66Cucd2p1FCxNRax/c0fd9eJYtC9eAj0VGJShMuo0Ob0CoKy8LlBd
 Is+4Sj1BeQDIyGI1XUzAVUqXg3lpF0HBxCY5D8Eo69tpkaEJYLTWNGTEdxbZ9IXhu5bw
 z90PuLKPDYRsFMNE4zSeNGnzmhmTLDPRv/g2FEcX8uRShNbC4SsRP0KJ3qQ9DI3QP9no
 AImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/q655hlpcKbYdO9fJyRr0g9SmFAUcvg0z56HSQrgBXs=;
 b=WhzW5NVklsLTIqGgvXM7VxqhhA5CdU337GJkFrRdVognaJgecs+YLQX6McnHA5lHgD
 pZzxFRp5Ruzn53kb10PDe4qOpKJmEWMnC9VT+o29BjQQuSnUf46Xo+mMV1o4dL/BuyM2
 d8gwbsL4hBIQ0g5XxNfVi8LUtsAB3wnp7/jHzLOtxjrduaPYcBNTo7NsWAxomJ4R21U+
 6c9kGYByXZ0oFK2PThAFHgl/2YZNapxKtzS6dSyiUPKdhIEMxqgFM+WuGXdZuAQCxhzc
 t5agba1x/Gci2YvZiJqqq9oVJjBQp2D45SgdP41vrvrFl2e26bSz9g3PPvEOaD+F3c2u
 dVDw==
X-Gm-Message-State: AOAM531TUIn6fJl76BLpMxEy6lHAq0MhcWSfseEV1oKzBoNg12bnbibb
 5Sx2cb3YH2TBRsp6U2LWzOoAEh8xP465P+CaHxeCng==
X-Google-Smtp-Source: ABdhPJxcMJ6+Hr2/I5UkaYfdaVtR0YnwOzthjjTl3lrRLZf4luG1nyVOV8v2NzvJt/qNmoaX0MFmxJtsdmgiECwWvn8=
X-Received: by 2002:a25:b7c8:0:b0:633:5650:781e with SMTP id
 u8-20020a25b7c8000000b006335650781emr339945ybj.466.1648047847294; Wed, 23 Mar
 2022 08:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220323062552.228429-1-Arunpravin.PaneerSelvam@amd.com>
 <7addb3e7-d265-c1a7-d449-7d0056f06d63@molgen.mpg.de>
 <fc60c561-c12a-c031-9558-abae3e3474ec@amd.com>
 <6f0888a2-f74d-f41f-d593-a8362e7dc673@molgen.mpg.de>
 <398f8851-d37b-4020-24ce-8f2ab9723e40@amd.com>
 <CAPj87rMETV9UkpbGRYAT3mjVhRtW75m0e9OLON6_+gdcD0Fo2Q@mail.gmail.com>
 <CADnq5_NuaN_ZziNipdqvvTQ41you==VqJg5oxQovowokaJ2K1Q@mail.gmail.com>
In-Reply-To: <CADnq5_NuaN_ZziNipdqvvTQ41you==VqJg5oxQovowokaJ2K1Q@mail.gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 23 Mar 2022 15:03:56 +0000
Message-ID: <CAPj87rNyjd1xkEEARMoiaEdjLxy2rvcKa03fnNCnpN91DLhF1A@mail.gmail.com>
Subject: Re: Commit messages (was: [PATCH v11] drm/amdgpu: add drm buddy
 support to amdgpu)
To: Alex Deucher <alexdeucher@gmail.com>
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthew Auld <matthew.auld@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

On Wed, 23 Mar 2022 at 14:42, Alex Deucher <alexdeucher@gmail.com> wrote:
> On Wed, Mar 23, 2022 at 10:00 AM Daniel Stone <daniel@fooishbar.org> wrot=
e:
> > On Wed, 23 Mar 2022 at 08:19, Christian K=C3=B6nig <christian.koenig@am=
d.com> wrote:
> > > Well the key point is it's not about you to judge that.
> > >
> > > If you want to complain about the commit message then come to me with
> > > that and don't request information which isn't supposed to be publicl=
y
> > > available.
> > >
> > > So to make it clear: The information is intentionally hold back and n=
ot
> > > made public.
> >
> > In that case, the code isn't suitable to be merged into upstream
> > trees; it can be resubmitted when it can be explained.
>
> So you are saying we need to publish the problematic RTL to be able to
> fix a HW bug in the kernel?  That seems a little unreasonable.  Also,
> links to internal documents or bug trackers don't provide much value
> to the community since they can't access them.  In general, adding
> internal documents to commit messages is frowned on.

That's not what anyone's saying here ...

No-one's demanding AMD publish RTL, or internal design docs, or
hardware specs, or URLs to JIRA tickets no-one can access.

This is a large and invasive commit with pretty big ramifications;
containing exactly two lines of commit message, one of which just
duplicates the subject.

It cannot be the case that it's completely impossible to provide any
justification, background, or details, about this commit being made.
Unless, of course, it's to fix a non-public security issue, that is
reasonable justification for eliding some of the details. But then
again, 'huge change which is very deliberately opaque' is a really
good way to draw a lot of attention to the commit, and it would be
better to provide more detail about the change to help it slip under
the radar.

If dri-devel@ isn't allowed to inquire about patches which are posted,
then CCing the list is just a fa=C3=A7ade; might as well just do it all
internally and periodically dump out pull requests.

Cheers,
Daniel
