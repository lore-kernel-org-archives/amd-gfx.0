Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B65C07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 14:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AEF061A2D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 14:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEF061A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46FFC6E4CB;
	Tue,  6 Jul 2021 14:00:21 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F766E4C7;
 Tue,  6 Jul 2021 14:00:20 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 e85-20020a4a55580000b02902579a1a1393so1474446oob.6; 
 Tue, 06 Jul 2021 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/GnHAbokkse9CugRmFElMjvp9JZ+A9ohrcEc2jPZiTg=;
 b=DEqIryYBGcUed7HgCEbSFEgyk8OiDFQ+u0MnF83z3PZiCHimhlFeviHMiKA2rRt+TP
 5VW2+PwXS8YY+dKR/DgB+822gfXhAo0g6EvyEOUeuYyJR2fGAlqo4FoIhqg+BEi0R84M
 4WBHBdTt1G0/Fo8RuDV5zN/IHwE1wRtVYYO4pDKGW2oV1wycNjvnYEOCUddjGI45Ew2k
 SnOK7DBQWWfxh17ZEktSBnVyfRwKsDdETfRLqo8zXs+lOriBTQnG/QbBfbAuid0HelBY
 Ao6Bd5hJm4x3tacccykg3HVGb5vpJu/cm7UppCkfhEdPptHbNRArIbaFzquX3rs49jVZ
 NmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/GnHAbokkse9CugRmFElMjvp9JZ+A9ohrcEc2jPZiTg=;
 b=BQwXsVG5/50RpnDeTsIvKkPgpBnY9kcmSTt451xgqGuRtNzsA2xWJ1bFTB0teG5NkB
 H9cIM3Ma0s9BD+hoTNOpJyDRdKknr/IGhqCG5lXvpFDMzujyWNY4PWXeI1WqvFrw0GAw
 h9FgMB0QZ9wviEDj3Cck9PVZQdN15ueVdIMekPpGS3DbWJ8FDnWShJYkldeFf1KpQTf9
 oaQUKIClYll8pjn9/prLSJ9d7FqE0sXMOO9j/nethVQM2Z6a9olDZJEfiafxLw4id9rd
 MmUAG5S2FyeLyQzj5MuZMH4UDGqyjqgokTZuJ92o9zqfPPZoMitz+fa2s64jVQO7PbW6
 aP8g==
X-Gm-Message-State: AOAM531faMscAFrau3qul6bLZPZ5IUHgiqMTW4rzhFkG4lt7LHed8DTT
 U+ueWoBh04jWM5d4KYeKmUfdLrgDX5JSL/hdHGY=
X-Google-Smtp-Source: ABdhPJwWDwMyFrj8stYkzuIgh4nFkXxkm3YhsPqNE4ZGGZlUxsiMG3CmLDhKuCFmoUR1JeZW5g5BMjYlOoqOwK4otGg=
X-Received: by 2002:a4a:dc09:: with SMTP id p9mr14242920oov.27.1625580019894; 
 Tue, 06 Jul 2021 07:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210705130314.11519-1-ogabbay@kernel.org>
 <20210705130314.11519-3-ogabbay@kernel.org>
 <20210705165226.GJ4604@ziepe.ca>
 <CAFCwf100mkROMw9+2LgW7d3jKnaeZ4nmfWm7HtXuUE7NF4B8pg@mail.gmail.com>
 <20210706135451.GM4604@ziepe.ca>
In-Reply-To: <20210706135451.GM4604@ziepe.ca>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Tue, 6 Jul 2021 17:00:07 +0300
Message-ID: <CAFCwf11p_uNKLV7SgjmShVgoRuSCax4DQmKZEdydK2SBrH6w8A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] habanalabs: add support for dma-buf exporter
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Cc: Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
 linux-rdma <linux-rdma@vger.kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Oded Gabbay <ogabbay@kernel.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Doug Ledford <dledford@redhat.com>, Christoph Hellwig <hch@lst.de>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Deucher <alexander.deucher@amd.com>, Tomer Tayar <ttayar@habana.ai>,
 Dave Airlie <airlied@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: multipart/mixed; boundary="===============1696491409=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1696491409==
Content-Type: multipart/alternative; boundary="000000000000a3cd9a05c674d7d6"

--000000000000a3cd9a05c674d7d6
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 6, 2021, 16:54 Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Tue, Jul 06, 2021 at 12:44:49PM +0300, Oded Gabbay wrote:
>
> > > > +     /* In case we got a large memory area to export, we need to
> divide it
> > > > +      * to smaller areas because each entry in the dmabuf sgt can
> only
> > > > +      * describe unsigned int.
> > > > +      */
> > >
> > > Huh? This is forming a SGL, it should follow the SGL rules which means
> > > you have to fragment based on the dma_get_max_seg_size() of the
> > > importer device.
> > >
> > hmm
> > I don't see anyone in drm checking this value (and using it) when
> > creating the SGL when exporting dmabuf. (e.g.
> > amdgpu_vram_mgr_alloc_sgt)
>
> For dmabuf the only importer is RDMA and it doesn't care, but you
> certainly should not introduce a hardwired constant instead of using
> the correct function.
>
> Jason
>

Got it, will change
Thanks,
Oded

>

--000000000000a3cd9a05c674d7d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Jul 6, 2021, 16:54 Jason Gunthorpe &lt;<a href=
=3D"mailto:jgg@ziepe.ca">jgg@ziepe.ca</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">On Tue, Jul 06, 2021 at 12:44:49PM +0300, Oded Gabbay wro=
te:<br>
<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0/* In case we got a large memory area t=
o export, we need to divide it<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 * to smaller areas because each entry =
in the dmabuf sgt can only<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 * describe unsigned int.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt;<br>
&gt; &gt; Huh? This is forming a SGL, it should follow the SGL rules which =
means<br>
&gt; &gt; you have to fragment based on the dma_get_max_seg_size() of the<b=
r>
&gt; &gt; importer device.<br>
&gt; &gt;<br>
&gt; hmm<br>
&gt; I don&#39;t see anyone in drm checking this value (and using it) when<=
br>
&gt; creating the SGL when exporting dmabuf. (e.g.<br>
&gt; amdgpu_vram_mgr_alloc_sgt)<br>
<br>
For dmabuf the only importer is RDMA and it doesn&#39;t care, but you<br>
certainly should not introduce a hardwired constant instead of using<br>
the correct function.<br>
<br>
Jason<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Got it, will change</div><div dir=3D"auto">Thanks,=C2=A0</div><div dir=
=3D"auto">Oded=C2=A0</div><div dir=3D"auto"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000a3cd9a05c674d7d6--

--===============1696491409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1696491409==--
