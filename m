Return-Path: <SRS0=JMr/=PQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692C3C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 14:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27DA4610F8
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 14:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 27DA4610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9813C6E971;
	Thu, 28 Oct 2021 14:14:48 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 525C86E971
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Oct 2021 14:14:47 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 w12-20020a056830410c00b0054e7ceecd88so8815355ott.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Oct 2021 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vjoekqz0IVKCPHndwLj/kPSYvD4vgsAIeQrYalZumdc=;
 b=HBn0bWx/LdVZKb7kwiMgnPztiK9TDqNHMTza6iuyK3VU9o2XJDuV/k4CeVWL2tPgze
 zzHzDiLKAjKE7+v3/MFheoav/PRIvrwCjqUnMoietfN4+0aDFhUmBEXcnjCM6Qyn6pz1
 gYKhMItShcFnd3lRakMmHL6dneh5IR/JDMXJjkTpd2r6VWm2W5TwoHL2IlSPegDCP1wL
 NArEHK0rYZMcypeT19owAIdwFSLZ28UHwUzbBszmKTOGVELfUc0pKJE7ocQHjDWrTuUR
 ipEo6v6yjyGI12DIQ9mfRB3JJW0Hst+ED1TuXVCF4zejFll7TsdK6tmQI0dxajxhZT03
 +Blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vjoekqz0IVKCPHndwLj/kPSYvD4vgsAIeQrYalZumdc=;
 b=hKAgJqEoue+nhk3x7Kjtu6fY4Hf3noeHKGtaTH0MVTEIGFUySTcnJ9tPVuAT4plaKJ
 ReFwZh76s45V7ee27cpEizQ5tXnVUagXVyakIF89ZwEbpWJIIudtKFVFFkhcsxzDDfJm
 V8rTxOs4q6b9Yc5d1/UBGpZs3W+n3SLwxLZeSB4RBDC9Q9421qpzeSc5eu8zDnFzbvh2
 saPbgGVYICgWNWPZeOlPbvv+MhIkQb0jDDrTiqADio+SoE5ZL6oXDQj+QIdhxqtLJzcR
 vOxW6vbYhWaayxLn97bcKQgf85OFbKUTvm6n+1QmapZUBxS3JfLOSADPhtCTXzN63oej
 1jyA==
X-Gm-Message-State: AOAM5313y8m5sSxoDTlAZEngfNox4TAJEiwQueRUlBCHnyb2PyGPAncZ
 Fv4uB0aord7aKcUF0SiomgaGV3a1nQiRvrhsMUM=
X-Google-Smtp-Source: ABdhPJwo2/UEIlVcI5lBm6PVOhhaymqCPeTt7i/cZ0DNVtraqW+4ZpQ/gZnl20Bc5n4a4Glldg61MEF5UCqYiN+Gl9s=
X-Received: by 2002:a9d:1b4f:: with SMTP id l73mr3704514otl.200.1635430486568; 
 Thu, 28 Oct 2021 07:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211027182212.1484689-1-alexander.deucher@amd.com>
 <CADnq5_PzD5h0UmhQko7YE86a1xhm2LnPFhDgwgEhBe7iKNov0A@mail.gmail.com>
 <a0801433-fd70-f15d-3f63-7ca18fbf2244@molgen.mpg.de>
 <b1b2b722-d21e-421a-e8b1-5452d404533d@molgen.mpg.de>
In-Reply-To: <b1b2b722-d21e-421a-e8b1-5452d404533d@molgen.mpg.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Oct 2021 10:14:35 -0400
Message-ID: <CADnq5_NgW88qf-zGa4Tvc2pwHXRLVNLAXc5o4_h1XPk3LJadiA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gmc6: fix DMA mask
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, it+linux-iommu@molgen.mpg.de
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

On Thu, Oct 28, 2021 at 4:33 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Alex,
>
>
> On 28.10.21 00:19, Paul Menzel wrote:
>
> > On 27.10.21 20:23, Alex Deucher wrote:
> >> On Wed, Oct 27, 2021 at 2:22 PM Alex Deucher
> >> <alexander.deucher@amd.com> wrote:
> >>>
> >>> The DMA mask on SI parts is 40 bits not 44.  Looks like a copy
> >>> paste typo.
> >>
> >> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1762
> >>
> >> Fixed locally.
> >
> > As I have no way to reproduce this, as the ring gfx timeout error is
> > logged ten seconds after the IO_PAGE_FAULT, is very likely to be relate=
d?
> >
> > Hopefully I am going to be able to test this on Friday. Does AMD=E2=80=
=99s QA
> > team have the cards to test the `iommu.forcedac=3D1` case? Is that test
> > case going to be added to the =E2=80=9Ctest protocol=E2=80=9D?
> >
> > Lastly, should a Fixes tag be added, so it=E2=80=99s picked up for the =
stable
> > series?
>
> Does the value of 44 need to be changed to 40 also five lines below?
>
> -       adev->need_swiotlb =3D drm_need_swiotlb(44);
> +       adev->need_swiotlb =3D drm_need_swiotlb(40);
>

Good catch.  I'll fix that too for consistency, but the driver is not
functional with the swiotlb due to the amount of memory the driver
maps.

Thanks!

Alex

>
> Kind regards,
>
> Paul
