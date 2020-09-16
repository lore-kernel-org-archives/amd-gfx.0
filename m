Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30D3C43461
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 07:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF4B2076C
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 07:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Q2xM5bAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF4B2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8E696E9D5;
	Wed, 16 Sep 2020 07:52:01 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEB7A6E9D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 07:52:00 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id y15so1912567wmi.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 00:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=dVvKltWqBEU89BlHB4WRQdNVMd2wZl+8cOFR2ESkNKo=;
 b=Q2xM5bAJA/Q2WFGxfesK2VFF/My8eoWs6bHKJhos95mBiqc9lVTNUtWxEjtDNhw9P+
 o2nW4Oc7bpXzn5htepF+j+WG1QREUrbdjd8zyVZii+omDNhTHcBpXOgfr1/APV87AC2S
 +H6ZwmSx2gokn9FmGFszkLtNCBIMZ3a4lT/FM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=dVvKltWqBEU89BlHB4WRQdNVMd2wZl+8cOFR2ESkNKo=;
 b=UvKTNAxMMXO2a7J+GZO/h1CMV5WHNEANlyNqSJQk6pii7kmBk5SU+kzEWhyqF2xbdL
 G2DyiDb8Mu8zG83RfgyDWUpFv8flodAwAfxn+fiQWqbKgO1EYCW/41u5FhGUVKY8K+Gh
 hsEJBCW+wRmPCpzVE4LZ/7yB5b+OWudpzu1GfMt9HlANOSa3P8bnL91L5XzU+CPsJGBc
 LsgF4vgn1imhVF0PP4/l9fBpz/Zevmzgc4tD+PXjmi4ZZ7TydFdRBB5LSIUFHW4J4GCj
 WZDoWMtlhMUA/JzqQZAOohAGTr72ZktADgf2JvM1mqqYkwxoS9GQsYi1ZKbqJYA7Tf2b
 JzvA==
X-Gm-Message-State: AOAM533+5Dn1KD6qfGJLC2vajeaPE4bXp7vjfZlsfUmZHtjc8RBrw4cu
 2pY+6ixKmbaSZ/bsX7rT6b0UpQ==
X-Google-Smtp-Source: ABdhPJywveMidt4/e57hl8eEyBcYSOyCCUhd5x9XtTRmTYAj/r/rHiq9Oz3XsLdH6qy6VOddsTRFfg==
X-Received: by 2002:a1c:a551:: with SMTP id o78mr3315971wme.4.1600242719437;
 Wed, 16 Sep 2020 00:51:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id m10sm3771805wmi.9.2020.09.16.00.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 00:51:58 -0700 (PDT)
Date: Wed, 16 Sep 2020 09:51:56 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: christian.koenig@amd.com
Subject: Re: [PATCH -next 0/8] drm/amd/amdgpu: fix comparison pointer to bool
 warning
Message-ID: <20200916075156.GU438822@phenom.ffwll.local>
Mail-Followup-To: christian.koenig@amd.com,
 Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
 Alex Deucher <alexdeucher@gmail.com>, yi.zhang@huawei.com,
 Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Zheng Bin <zhengbin13@huawei.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 "Deucher, Alexander" <alexander.deucher@amd.com>
References: <20200909130720.105234-1-zhengbin13@huawei.com>
 <1fce0f2a-3777-e6d8-5a09-30261f843cfd@amd.com>
 <CADnq5_NoeFbBAMT6s_ictVXsUc2tx1U48MLxnMbAr2Sd58jyYA@mail.gmail.com>
 <20200915193549.GP6112@intel.com>
 <6658f89f-6957-e6ea-af41-7625f1fd3cb1@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6658f89f-6957-e6ea-af41-7625f1fd3cb1@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: yi.zhang@huawei.com, Dave Airlie <airlied@linux.ie>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Zheng Bin <zhengbin13@huawei.com>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>,
 Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 16, 2020 at 09:38:34AM +0200, Christian K=F6nig wrote:
> Am 15.09.20 um 21:35 schrieb Ville Syrj=E4l=E4:
> > On Tue, Sep 15, 2020 at 03:16:32PM -0400, Alex Deucher wrote:
> > > I question the value of these warnings.  Why even have a boolean type
> > > if you are going to get warnings when you use them...
> > > That said, applied to avoid getting these patches again and again
> > > every time someone sees this.
> > if (this_is_sparta)
> > if (this_is_sparta =3D=3D true)
> > if (this_is_sparta !=3D false)
> > =

> > I think the first one reads the best, and avoids having to
> > decide between truth and falsehood :)
> =

> +1

+1, especially because we also have the inversion when using negative
errno codes for failures and 0 as success, which results in

	if (errno =3D=3D 0) /* success case */

but
	if (bool =3D=3D 0) /* failure case */

now creative people do sometimes

	if (!errno) /* success case */

which I think is horribly confusing. So imo for more easier telling apart
of these too I think consistently using the short form for booleans, and
consistently using the more explicit long form for errno checks is a Very
Good Pattern :-)

Cheers, Daniel

> =

> Christian.
> =

> > =

> > > Alex
> > > =

> > > On Wed, Sep 9, 2020 at 9:21 AM Christian K=F6nig <christian.koenig@am=
d.com> wrote:
> > > > Acked-by: Christian K=F6nig <christian.koenig@amd.com> for the seri=
es.
> > > > =

> > > > Am 09.09.20 um 15:07 schrieb Zheng Bin:
> > > > > Zheng Bin (8):
> > > > >     drm/amd/amdgpu: fix comparison pointer to bool warning in gfx=
_v9_0.c
> > > > >     drm/amd/amdgpu: fix comparison pointer to bool warning in gfx=
_v10_0.c
> > > > >     drm/amd/amdgpu: fix comparison pointer to bool warning in sdm=
a_v5_0.c
> > > > >     drm/amd/amdgpu: fix comparison pointer to bool warning in sdm=
a_v5_2.c
> > > > >     drm/amd/amdgpu: fix comparison pointer to bool warning in si.c
> > > > >     drm/amd/amdgpu: fix comparison pointer to bool warning in uvd=
_v6_0.c
> > > > >     drm/amd/amdgpu: fix comparison pointer to bool warning in
> > > > >       amdgpu_atpx_handler.c
> > > > >     drm/amd/amdgpu: fix comparison pointer to bool warning in sdm=
a_v4_0.c
> > > > > =

> > > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 4 ++--
> > > > >    drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c           | 2 +-
> > > > >    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c            | 2 +-
> > > > >    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c           | 4 ++--
> > > > >    drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c           | 2 +-
> > > > >    drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c           | 2 +-
> > > > >    drivers/gpu/drm/amd/amdgpu/si.c                  | 2 +-
> > > > >    drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c            | 4 ++--
> > > > >    8 files changed, 11 insertions(+), 11 deletions(-)
> > > > > =

> > > > > --
> > > > > 2.26.0.106.g9fadedd
> > > > > =

> > > > _______________________________________________
> > > > amd-gfx mailing list
> > > > amd-gfx@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> =

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
