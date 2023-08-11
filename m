Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3772DC001B0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 13:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF57D10E69A;
	Fri, 11 Aug 2023 13:46:38 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A297010E69A
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 13:46:35 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3a43cbb432aso1673804b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 06:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691761595; x=1692366395;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vl/OpKDg8FsnPpo0t8dds9G+MykiwY13cYOXQron0lQ=;
 b=D+i2Ib2l2JQuTU2FG3HzxTENEd4pscIIE/+PkaCMJY01azsNwsRe9GiSN8FGkLLEN5
 e7Dec+BLFGC4XkOUU90e0sQwU7aoAHNNmg5nSnr23N+a0h3yd3ReGIn4nDLbMQvtK3Ec
 RoTm1X7kmiG0YrjH3PYRCErwGFER50++xVed06ns+pzRWfrx9nx+Vjfqzv8LBfygoDos
 QeoUIcaIgy5WPE56XtCT0l2EG7/GiJ2ZNCKflNh4ARtL0vrlYg6AraWoBX/X11Q2L2Go
 Bh79urHCSPx8nbiaVozcopWCaeC2fMb9dvbDAlGltHraUZeynKeF328zCg57Zzu/9QsK
 Qc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691761595; x=1692366395;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vl/OpKDg8FsnPpo0t8dds9G+MykiwY13cYOXQron0lQ=;
 b=Eqkqw7+hop7JWyRvGpScTGk099tLK1DCSq6jlpxqXelCexLPUrFz85ekp6Vd9hTB8X
 LI8p+OfAWj7gn0HhvlEleISGbxGJ1+wrtDwo3z6IByuz52Ez/xE0FDRJyfWjLcQK82Pp
 W/MnaMebUrE79nOKOqrs0qPdWE6Zj+GZR0q0k6EpmUCwUA5GO+b8zEdEhGR/hEnPEmnF
 ICaKJooWxy87K4LtXk7k+oOTg84ac1cKTjoOdNuF4eFrUNzhjY9IVvc3MO/nCnwaPdZ2
 pQ7qivUlAhdE74VLNf+OcV56RMM9rUH1wsdzaW/n9UNTVgWnZ5AF6fVO3u3hFoVG4P0A
 m2Iw==
X-Gm-Message-State: AOJu0YxzFw8d8y0YaLvLYZdtzY1+YAizE8S3J6Sx8L5uJ/uIQKAMfVcl
 p0rqI8s5tDIGgO75Zal70pTdC090eCDg/t8X3ro=
X-Google-Smtp-Source: AGHT+IGO+LBUHtOWLTb5zijQx40o+Hgr7D5dd7t6uE96+b9pMNBbMAvRedONzz82VZWXpEyLnWovkNv0N7+B7FmrXdI=
X-Received: by 2002:a05:6808:1b0e:b0:3a7:6a5d:9aeb with SMTP id
 bx14-20020a0568081b0e00b003a76a5d9aebmr2630000oib.21.1691761594909; Fri, 11
 Aug 2023 06:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230807220545.1320198-1-alexander.deucher@amd.com>
 <ZNY6f7gUuxw7jXSK@nvidia.com>
In-Reply-To: <ZNY6f7gUuxw7jXSK@nvidia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Aug 2023 09:46:24 -0400
Message-ID: <CADnq5_MhTZTOB_VtVt4xKFr7ob6rjzPLdo91F1ww=-Cz2TLygQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/5] drm/amdkfd: ignore crat by default
To: Jason Gunthorpe <jgg@nvidia.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 11, 2023 at 9:45=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Mon, Aug 07, 2023 at 06:05:41PM -0400, Alex Deucher wrote:
> > We are dropping the IOMMUv2 path, so no need to enable this.
> > It's often buggy on consumer platforms anyway.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 4 ----
> >  1 file changed, 4 deletions(-)
>
> For the series, please can we go ahead with this ASAP?
>
> The iommu side desperately needs the removal of the iommu_v2 private
> interface to the GPU.
>
> I'm really glad to see we can just delete the whole thing!

Yes, that is the plan.

Alex
