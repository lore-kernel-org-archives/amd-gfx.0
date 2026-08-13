Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0C2C5CFDB
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 22:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80A4710F562;
	Thu, 13 Aug 2026 22:02:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n42abIMK";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8941C10F562
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 22:01:59 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38f57e312ecso60820a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 15:01:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786658519; cv=none;
 d=google.com; s=arc-20260327;
 b=SJ6aD3u0gUoDIZRLScR3GY2E6cFN0AHDG9cI9tkS86D5lBJGI7jISU0XGKtoE5HKi8
 pCzYgyORcp/lyX+0N9syLcFYY3FM1/HsnkmQvVo/YcE/ZUSJTZxpEe+soz6wMe4H1EMp
 UCrJqkd05MgqTV+omuV1uCwbAszP1HeP7rlaMLWhvZoE7khWKMzUidV04z/aGo/4KyOL
 CIuBZYJamdhFgRVMTq7jciy/YGm604tMRFYw+hw7xa7LUb1IUEOhm9fZa0hnXdlM+iJm
 VBr1n184irCgJNZt1gxaQa2lFZmutkHHl7qjmt2AoEmLMlbbNSKW+KdX2XYPhtbyHcD2
 O0TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4Mq4lnCpPXsLK97g8OxvoVmu/P5LTp2GxHOYzB464gE=;
 fh=YuzfeWdNnh9j86CB2En9qiKjjv+9fnlWrt9NLjaIfwU=;
 b=c9JdOAjaTQK6fy1M69hjtuIMMRql70bEOUUaA/hBZkEJrUNcMBu5W/ciFOAW5LcgAD
 D8iR/n7zf09kYeWBCAt23RTbzRjaeFKCYckEXoWwbvKCwgn1DZQdPDXEqJOHxWTIkhh4
 oyX2tjU37JNXF9V3FK2M3tIX/b1z8/eFfMSdIhiNJm+gx5SUORyJacTQWuSdqs0lGKA0
 gxlYDHm3b6SXT03B4IqzmfJIEwFoZabamyygErLoIdu7k+yEsPtgPywk0NvXb/3cdUC0
 hgkV/tIzjJ+JY2jzdBPvUtHyp53xbBBuoNVHj35yxa+T5G1F4kOMKu18C5kL3TZUu+n4
 E6lg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786658519; x=1787263319; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4Mq4lnCpPXsLK97g8OxvoVmu/P5LTp2GxHOYzB464gE=;
 b=n42abIMK1o3+ZheEgPyFVIlRApzlC61KJouOqILFlPWV9lomc2jA0UJ6iN3/1o8N5q
 z402PkyNk935W2Kv7MYaFP5Rfpmfak4PWjk9HyMzfLPFek9xiUPPIuPzyBmqetiGVoSV
 N+HDfDeHn8WqelTPFP9hYj4KVYsmXYAv8bb8nTdqhgXdrrNJSDt2q3X5UR7T44C0wjX1
 mrn3ETE+PDWZHdfaoN1dw+Gcj7odbMnoQHu5qpjm6st+Z9GHQpreXrT0uB2wTvVt8mea
 GKFHl6TziBiB6EC1l1ZBnKh9YypCDsxGupsvXHYqWE2TNXxbwWbc1hpaFzTOvcrEMpDr
 7srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786658519; x=1787263319;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4Mq4lnCpPXsLK97g8OxvoVmu/P5LTp2GxHOYzB464gE=;
 b=aog39GiR+EbvpIBvYd5U3rMIwgJyvD2PKMK8/n3UFPZfqpgFNw/5/+L3/D1EIVEV9t
 oV+Ip/Wya5MxOmPZeE+3lbMQPwR5kdqhVDy0ft5v1orstRdfQqQhPCDZjyFjcZC/x4ZK
 4cqbvFWQoKY7Rt+GUwpKQg3cp1tjELd1namPq2rNkD6BvSv4j10auY0KJqXCIJtbKUyg
 qp0R/XzQJvFiyAkV26/zye8NFps6zqL8ab1XGhYS2p2dBZx2n7DAcLbWkONi05CWR5tj
 OktVS/ZTWgqNZ2I5r9p6/QjmcIpj5wNOhLLveJnynzjx8AxMu0967ceNObH+Tf6UYofn
 5A6A==
X-Gm-Message-State: AOJu0Yzlx5QGs9xG84xNUpyatEAlpxfszkq1AU2z1rqrI0hL3L5Pph8+
 w6dfk//jYzov7PZsOqHa/fqTMiFa5woCDxfWp0Qd4oRPvfFS15HB+5RztJ/lMcoq7+GaS6gRFOk
 vJYSlw/Mrz3au3IvUR3anGcmby8cO5uY=
X-Gm-Gg: AR+sD11JCHB7zRzGUXp5nUvRLIgA51ivW8S7HE1BpykWCa9xxXm/pk3c4K2/jnWGyhh
 BIPkHGNIehQSPoruFw4eGEntyVs5Y11u/cn4DIVCeGmAahblEflPEaT7TWZGhvZkgUBSYH+fSts
 MjkEG0GGZqtDWB6NBp86/WVeriTHYeqUuxUQZNtQtbQhIIOsVruW42H3glvutfd9i1cYkT+Y7Zn
 1aJt5h4A7cwzMm7RSorQuPnW0CZ9q7lESVkyGFvc57aBOTsIbc3C2vsy6kYeQ4wDWmHkjhulJS1
 jaH4cIf12mxf3d2VWXEspdw0+Yx2RSGVvdn9JF4pyHwfLkgPoToTO+rvBMg1QA0MrbFW33+qMi2
 w0M166IVS8SRqO7j+Hby1IBIZTOYrcDU=
X-Received: by 2002:a17:90b:1fc8:b0:38e:7069:7117 with SMTP id
 98e67ed59e1d1-3933b50729fmr918723a91.0.1786658518991; Thu, 13 Aug 2026
 15:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260805140227.44868-1-boqun@kernel.org>
 <an44yIv7WG7vqTqQ@tardis.local>
In-Reply-To: <an44yIv7WG7vqTqQ@tardis.local>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Aug 2026 18:01:47 -0400
X-Gm-Features: AUfX_mwrCLsatx0Sle_Nl-2BbcnZsP50vwFu_lWeNoqprpd0PhoDhEdHVhOZSkw
Message-ID: <CADnq5_PLV1rDw8DSawdHfQxyk8XgPp94TQa0HuFVdZVvZo+zmQ@mail.gmail.com>
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
 linux-kernel@vger.kernel.org
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

On Thu, Aug 13, 2026 at 5:36=E2=80=AFPM Boqun Feng <boqun@kernel.org> wrote=
:
>
> On Wed, Aug 05, 2026 at 07:02:21AM -0700, Boqun Feng wrote:
> > In a Strix Halo system, a >100 average_vcn_activity in gpu_metrics can
> > be observed by running the following command:
> >
> >     ffmpeg -hwaccel vappi -vappi_device /dev/dri/renderD128 -i \
> >     ~/sample-10s.mp4 -vf hwupload,scale_vappi=3Dformat=3Dnv12 -c:v \
> >     h264_vappi /tmp/output.mp4
> >
> > This is incorrect because the value is supposed to be in [0-100] range.
> >
> > The cause of the issue is that the metrics.VcnActivity reported by
> > smu_cmn_get_metrics_table() is a permyriad value instead of a percentag=
e
> > value (e.g. smu_v14_0_0_get_smu_metrics_data() has a division by 100 to
> > report the vcn_busy_percent). Therefore fix this by applying the same
> > division in smu_v14_0_0_get_gpu_metrics().

I think this is correct as is.  smu_v14_0_0_get_smu_metrics_data() is
used to fetch data for standardized formats like hwmon while
smu_v14_0_0_get_gpu_metrics() is for dumping the raw metrics data.

Alex

> >
> > Reported-by: Mark Janes <mjanes@netflix.com>
> > Signed-off-by: Boqun Feng <boqun@kernel.org>
>
> Ping?
>
> Regards,
> Boqun
>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > index 568665265a13..1058338344b0 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > @@ -566,7 +566,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct s=
mu_context *smu,
> >       gpu_metrics->temperature_skin =3D metrics.SkinTemp;
> >
> >       gpu_metrics->average_gfx_activity =3D metrics.GfxActivity;
> > -     gpu_metrics->average_vcn_activity =3D metrics.VcnActivity;
> > +     /* metrics.VcnActivity is permyriad, convert it to percentage. */
> > +     gpu_metrics->average_vcn_activity =3D metrics.VcnActivity / 100;
> >       memcpy(&gpu_metrics->average_ipu_activity[0],
> >               &metrics.IpuBusy[0],
> >               sizeof(uint16_t) * 8);
> > --
> > 2.50.1 (Apple Git-155)
> >
