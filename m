Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D005BC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 28 May 2022 23:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC8210E418;
	Sat, 28 May 2022 23:52:22 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64FCA10E1FC
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 May 2022 23:52:21 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id bo5so7486882pfb.4
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 May 2022 16:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Nufpgj4WrVDOY3pDZhjA4ff1zW3gqCcbtHnisr85ZyY=;
 b=s0JQFCLPbNMyIAn/e51czi5dJtQ+dUeQ2gvMOdGi6tS2NgbI49v0VsbB+PAc82PIw4
 nQgco7a3P8lLmLsPJVHQB9E71kRVsqug5ma+EM8qIxBCmqM5oXD0la1ELVD8Ulz9yzYD
 VnKBV+KJK4jypCIAVWQzOmVG3LmFDIfNR0MMDEAYR08xOW2QMX5qesJKm+Uf7E+hDduJ
 Pcq6QlB4Uf3I3qy3ztboQvxZyfMrKJlj5Wkqq0ktf4k6Tb6JaWrwXSkA7p1mhDXONON0
 BKFL3A0ImJ/Y1TRYh8tL8JqKGqc4ToS/epezYxWCjZbGqwgXt9zYfGPYU3c0uyilt+qo
 9ZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Nufpgj4WrVDOY3pDZhjA4ff1zW3gqCcbtHnisr85ZyY=;
 b=AJo5pdh9pbugP/AzjxP3ajHsCeewr5fuI7xheOcJKRCU+iUQ4phAsIv4xLkVny/qe0
 KbfzJuSOjwAw1qDDLtEv2jMkqFWTbNdCnJkWEQMyWcOLHhDt5KFiLjgQqRLSU6ehq48h
 Se1AV6XY61aQY/ldWH3cn9+M7ZEi18dCvEeB24FguElCauQldsFpVyHnqa3imLnwnuon
 1NhDcf/33RvDBKITrB/Z0iMFcQY9KFY/GEZjZ23DR2bYsG/cAlRIrqtmpb1Yd2K6lcK3
 yyQbK217yGyuv/FvujCl6oDRZDyBBM4NE6P+uNDxz8EXKNOBXPHndQmYdLNWA5qnzfag
 qkJQ==
X-Gm-Message-State: AOAM533dgPqjPjLcZk2iuaDWNqxBFu+rNfhfx15v0+sGYR/pv20hnArV
 1JihOHKSmbUqjhq7bpWsxgdnjrLfOBghVNnoHHJ4qg==
X-Google-Smtp-Source: ABdhPJyUehceXYDZKshl8AFUK3x2Dnnl2LNGICbZeEaV/YzFZUoSDJRYF36aS3WgW9cUC8wLZHJcUOJztjxi9ebdfEw=
X-Received: by 2002:a63:d747:0:b0:3db:74a9:ff92 with SMTP id
 w7-20020a63d747000000b003db74a9ff92mr43048483pgi.293.1653781940899; Sat, 28
 May 2022 16:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220407054651.3924-1-Arunpravin.PaneerSelvam@amd.com>
 <CAHbf0-H5uE4RtZwY0L8Wz0VG6QnU1+E3yhg3fDFVc3n__=nrNQ@mail.gmail.com>
 <c0facbf4-0e14-fde5-4334-499135a36f0c@amd.com>
 <CAHbf0-FMqAA3vWx_uRDYG_vr=FX+tFoLAL6BZLDe5upv7KJqrg@mail.gmail.com>
 <CAHbf0-En606VT_HYDyeo6TtsfSZmR_+wsZaVgS4XiedLO9ndiA@mail.gmail.com>
 <8b99ca20-f711-ec32-0cd2-16fc52846ce0@amd.com>
 <CAHbf0-EzPP5gAyZQmxeAo3Ep0g-rO4XbDgEB_SdsR84xY+at9A@mail.gmail.com>
 <CAHbf0-G-rnvNXaXxMzkPerW6h=9vkxJyysUUV-oJV5UGD67KqA@mail.gmail.com>
 <CADnq5_PTRPTsCvGwKFzNA_k7diAVqYEv1xV1yJszRD1K-v2FfQ@mail.gmail.com>
 <MN2PR12MB43425B6EC07A7F6877B884C7E4DB9@MN2PR12MB4342.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB43425B6EC07A7F6877B884C7E4DB9@MN2PR12MB4342.namprd12.prod.outlook.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Sun, 29 May 2022 00:52:09 +0100
Message-ID: <CAHbf0-G8Qgv-uKHBYxhv=SLUv7-z4gzjMziN_x+oAobTrqW0PQ@mail.gmail.com>
Subject: Re: [PATCH v12] drm/amdgpu: add drm buddy support to amdgpu
To: "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
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
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, Matthew Auld <matthew.auld@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, 28 May 2022 at 08:44, Paneer Selvam, Arunpravin
<Arunpravin.PaneerSelvam@amd.com> wrote:
>
> [Public]
>
> Hi,
>
> After investigating quite some time on this issue, found freeze problem i=
s not with the amdgpu part of buddy allocator patch as the patch doesn=E2=
=80=99t throw any issues when applied separately on top of the stable base =
of drm-next. After digging more into this issue, the below patch seems to b=
e the cause of this problem,
>
> drm/ttm: rework bulk move handling v5
> https://cgit.freedesktop.org/drm/drm/commit/?id=3Dfee2ede155423b0f7a55905=
0a39750b98fe9db69
>
> when this patch applied on top of the stable (working version) of drm-nex=
t without buddy allocator patch, we can see multiple issues listed below, e=
ach thrown randomly at every GravityMark run, 1. general protection fault a=
t ttm_lru_bulk_move_tail() 2. NULL pointer deference at ttm_lru_bulk_move_t=
ail() 3. NULL pointer deference at ttm_resource_init().
>
> Regards,
> Arun.

Thanks for tracking it down, fee2ede155423b0f7a559050a39750b98fe9db69
isn't trivial to revert

Hopefully Christian can figure it out
