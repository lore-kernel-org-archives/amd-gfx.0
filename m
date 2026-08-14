Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F4AC5DF66
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 00:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57A6510E098;
	Fri, 14 Aug 2026 00:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mITKlQaT";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35BC210E061
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 00:51:35 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-38f0f3c8da5so48670a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 17:51:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786668695; cv=none;
 d=google.com; s=arc-20260327;
 b=EJGvEDwgqSlr6ObKVXvoPtvlNyzjQnKj9dUzV/ykoNs6j8PuRU2TdUrkdfCXKXbWx1
 lVB/9Yov/EMSPE2ixguHMRHh2xQcqSgLU67JUxTB+yp+R9bwgp96JJv0yxbaNv9V1C0m
 pJ9zbvXyyjXm1gdH24xuUjLjn6Z16tbPGMoDy2SY6C00CdBd2+35soOM8vFVgSqkpIds
 6utYjV6qvtuC2EnvMvc1gdVO9MlrHH5i9s5bVyoGwwDFVYinFRvMf6wAH43CSn4wm6sq
 Z7otq0md/usNAWQU2hwytHeqU9QV4UVOreZQTnmBuTmtsh5F2sBzuz3a5RhdgsL7fMhE
 K9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yxCYRgUfiupLw1ZARQEtlHxBkRDTpGsKuDLKUmEpvGY=;
 fh=EFQ7JZBa8J4NEj5/HUyK/hYNF+fH+Ze6cTpcgnTo7Ss=;
 b=U81diRBVHe0+ITHSYcKs2PYFUqEQwbiJMwF7mIr8PMHX7q2jT4jQZmAzh5/QBmvBKN
 uevCXAjJ2KAxgJ8HYMyCLUKV0exH+c6w2W0rzss1aCZFeF8R7UOE244vApeuwjDbZPl9
 0fYdvMHrNJ8BWT0f/8N20M9pBkE5OIKnfvH//H2qnxmjxbb3XXKmfawDOlYRAQ18D3JM
 M5Afb76d9WkKurcH0KSyoxW+9QfMHfKdyKTq+4JuXX2v8KFwBOsMlq+6yx6ucx4XHxDq
 5XEuvfYt1CVR+ZbJkV1AOtMMorFyJ27OLmwRrF1otxPgakgRVBxEdlOQOqoBdcPTH6zY
 dGsg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786668695; x=1787273495; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yxCYRgUfiupLw1ZARQEtlHxBkRDTpGsKuDLKUmEpvGY=;
 b=mITKlQaT11reGOIrSfzi0hjHbRVZum4JiSODcS4K8wNsSoUzkvUXvQXl84QqZrUS7J
 JH4rcD1J+TsBMt9y1XyyuchyIDFbefrWkXSUVMST9dRS+ZnOL/FWAAirWeEWTi+6oMur
 hRHvbYfdA4mxHvntwfbwrqPNoWG2OCaKXC8yyPkDhICca5Tw0zZ55V/T2uue7OIX3nrD
 WCiXqq9rILVwDSzmutH1XDBJXHtybmjuyZyy8SnP37XD6h21hbfP1Q8DgOdbF/l50ZaB
 0g6FtdIsgSYJ5vT6RafiWrQXByEco1+zFBujdUa+KcKrdgoBnCfARisCzjlZVXtQ52RI
 Llng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786668695; x=1787273495;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yxCYRgUfiupLw1ZARQEtlHxBkRDTpGsKuDLKUmEpvGY=;
 b=hdJ/mTc5TfO4SNJXeHm8Lfto9bpzWJcbhCrivGh3iSsqcU22epWKGnM3mSrMr4jtbx
 Wq2ryWnKGEgq+gUd9tbaRCLj2s0y4VDGvmFNULp66Qulnrk3O3foVk+9E7lMqeBiA+Il
 siT2+Ijxsmr1wP791+MQ51XFXD9YIKnst0iZXkscmwIYtnVXJepaKM/UdCo6cGflWw0+
 RNXgflacW/Ee1J+VBNwWAlLGy5KKpR5Oe6MZIEGF5zVxQyzuUBz/K1fPfnqLaKl6/7lu
 CjNADmFZcYkh0y7h9wjL6yg+pBfaI4ycgW5FtfFYfDunktBgcRNa1QkST7VWBeuzGa6U
 ZsyA==
X-Gm-Message-State: AOJu0YxZQVzuxxV2NceGjMvtYCrtcwQZW3dx+YJJwoMqmzduVTiPh9Qv
 Z7MDK8qe4Tfot7n+B/4h1Vws4bIUEIpMzwDKB26sTkCQ0WFUnKMSJ6xfSFvdl8O1QC1y0RH+B25
 LFLF+g3+Sx8SRv3FsM+fDJbj9pWsIz4Q=
X-Gm-Gg: AR+sD13uvL97gKpPqr2lju1dD+fS23pwadmy35EwsBX42CCL6iCQyeew5QklIwmGPTL
 fkoEpb8FKkBlcLWym/+Nxt5nI8o2YIiB+FfSIotsae7VsQPym/RnGseJ1fS8gHvluG8GherKbGh
 8X9dJRFZ6CpUa/YjCaukyG1YRscuWBfi1LiY6tqCcNhUXv12KdWnf5SDQncsd2BWUv5muwi5vAe
 0IAir3Zqym5bOdbmliLNGmfhOkVz/+LxiSAqzeK8+mTc8gtdgvMXN3fFaZJYyNcWuKVICR/haMa
 hgknFvUpyS6+SkXQsNvsUXnJ2L1yAvbjp3mOZ6Oo96EgFp6Xyt//QASS9RSHzyPi7Scg5cbLsat
 2CzRfUC4pRHBH4x91fhep2XN9SDQc4FQ=
X-Received: by 2002:a17:90b:1c91:b0:390:3936:8760 with SMTP id
 98e67ed59e1d1-3933b4d0640mr1460281a91.0.1786668694607; Thu, 13 Aug 2026
 17:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260805140227.44868-1-boqun@kernel.org>
 <an44yIv7WG7vqTqQ@tardis.local>
 <CADnq5_PLV1rDw8DSawdHfQxyk8XgPp94TQa0HuFVdZVvZo+zmQ@mail.gmail.com>
 <an5ESxy8-OMYvD4d@tardis.local>
In-Reply-To: <an5ESxy8-OMYvD4d@tardis.local>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Aug 2026 20:51:22 -0400
X-Gm-Features: AUfX_mwyptKu7Aa9Xb0KCbzA8D3qBwzeTvuqVJBVUaxF9RhYYZfTMTOpr3yCJc0
Message-ID: <CADnq5_PQgYboc8pPCRYimpf7fALgSPid-GGJzNsA+TuODsa8gA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Fix incorrect avg vcn utilization in
 gpu_metrics
To: Boqun Feng <boqun@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, Mark Janes <mjanes@netflix.com>, 
 Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, 
 Asad Kamal <asad.kamal@amd.com>, Yang Wang <kevinyang.wang@amd.com>, 
 Priya Hosur <Priya.Hosur@amd.com>, mythilam <mythilam@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Umio Yasuno <coelacanth_dream@protonmail.com>
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

On Thu, Aug 13, 2026 at 6:25=E2=80=AFPM Boqun Feng <boqun@kernel.org> wrote=
:
>
> On Thu, Aug 13, 2026 at 06:01:47PM -0400, Alex Deucher wrote:
> > On Thu, Aug 13, 2026 at 5:36=E2=80=AFPM Boqun Feng <boqun@kernel.org> w=
rote:
> > >
> > > On Wed, Aug 05, 2026 at 07:02:21AM -0700, Boqun Feng wrote:
> > > > In a Strix Halo system, a >100 average_vcn_activity in gpu_metrics =
can
> > > > be observed by running the following command:
> > > >
> > > >     ffmpeg -hwaccel vappi -vappi_device /dev/dri/renderD128 -i \
> > > >     ~/sample-10s.mp4 -vf hwupload,scale_vappi=3Dformat=3Dnv12 -c:v =
\
> > > >     h264_vappi /tmp/output.mp4
> > > >
> > > > This is incorrect because the value is supposed to be in [0-100] ra=
nge.
> > > >
> > > > The cause of the issue is that the metrics.VcnActivity reported by
> > > > smu_cmn_get_metrics_table() is a permyriad value instead of a perce=
ntage
> > > > value (e.g. smu_v14_0_0_get_smu_metrics_data() has a division by 10=
0 to
> > > > report the vcn_busy_percent). Therefore fix this by applying the sa=
me
> > > > division in smu_v14_0_0_get_gpu_metrics().
> >
> > I think this is correct as is.  smu_v14_0_0_get_smu_metrics_data() is
> > used to fetch data for standardized formats like hwmon while
> > smu_v14_0_0_get_gpu_metrics() is for dumping the raw metrics data.
> >
>
> Well, then kgd_pp_interface.h needs some help?
>
> struct gpu_metrics_v3_0 {
>         ...
>         /* Utilization */
>         /* time filtered GFX busy % [0-100] */
>         uint16_t                        average_gfx_activity;
>         /* time filtered VCN busy % [0-100] */
>         uint16_t                        average_vcn_activity;
>         ...
> }
>
> Clearly it's not true.

That was likely copy and pasted from the firmware interface
(smu14_driver_if_v14_0_0.h):
uint16_t VcnActivity;                //Time filtered VCN busy % [0-100]

Other generations seem to do the same thing (raw data in metrics table
and % in the hwmon type interfaces). E.g., smu_v13_0_4_ppt.c:
smu_v13_0_4_get_gpu_metrics()
gpu_metrics->average_mm_activity =3D metrics.UvdActivity;
vs smu_v13_0_4_get_smu_metrics_data():
*value =3D metrics->UvdActivity / 100;

Alex

>
> [Cc amdgpu_top]
>
> Regards,
> Boqun
>
> > Alex
> >
> > > >
> > > > Reported-by: Mark Janes <mjanes@netflix.com>
> > > > Signed-off-by: Boqun Feng <boqun@kernel.org>
> > >
> > > Ping?
> > >
> > > Regards,
> > > Boqun
> > >
> > > > ---
> > > >  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b=
/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > > > index 568665265a13..1058338344b0 100644
> > > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > > > @@ -566,7 +566,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(stru=
ct smu_context *smu,
> > > >       gpu_metrics->temperature_skin =3D metrics.SkinTemp;
> > > >
> > > >       gpu_metrics->average_gfx_activity =3D metrics.GfxActivity;
> > > > -     gpu_metrics->average_vcn_activity =3D metrics.VcnActivity;
> > > > +     /* metrics.VcnActivity is permyriad, convert it to percentage=
. */
> > > > +     gpu_metrics->average_vcn_activity =3D metrics.VcnActivity / 1=
00;
> > > >       memcpy(&gpu_metrics->average_ipu_activity[0],
> > > >               &metrics.IpuBusy[0],
> > > >               sizeof(uint16_t) * 8);
> > > > --
> > > > 2.50.1 (Apple Git-155)
> > > >
