Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA11BC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 16:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A9A60EBA
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 16:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 74A9A60EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 682716E069;
	Tue,  7 Sep 2021 16:58:26 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A8446E062;
 Tue,  7 Sep 2021 16:58:24 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id h133so13588403oib.7;
 Tue, 07 Sep 2021 09:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SvBBnr80NWkvIsim2a+nqfVn5CtPkVnz5CJmaxVXNrY=;
 b=Abd3ZEMoBaLVMobq1zM2GvTELFuBOdk0S3vpbSCxkgJNnKeu+2tR5aK7EHe5z1W7u/
 Y6wly0x/Ke3x94C4VGIo6nZklRVuFaMh0aCZ3zm/HRCW9tLGkZMvzKw0RPEiEjUrsFF2
 nJHJJI/y/dSSmMneRYatqOF9FtuEXKLrYgQp8dSwtaoeIA0LJjxhcSLMS0fPvt0jHc+1
 wEukmpABWoOV0D8McUMdS0jW74Is6mblYGKY9ZHgdfhTn4V1CexKgsUMaOhOT0gzyPZT
 MHQDHeZOZHqDKOi4NReUMYcnLTKwR4L/ENUH80tqRrKp9kipnZRze6toFyi7ENCblZ2h
 /rGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SvBBnr80NWkvIsim2a+nqfVn5CtPkVnz5CJmaxVXNrY=;
 b=NVsGy/cqPMDWNrBqFKxXL8TEyvyC34oD9KHH9zNHNZS6OuIKRKWKa3V12IhffYFYpS
 lBlBU5AkpTQfuFypgjsnFlYiD2rB3y7stLTw810nKA3fSCeUYK7koKw4Gfnb46anApGi
 QtsUkzYRaflAse92GgSHVwTYnarTvwGBZTzyeGCQJSAKv1mHMH1Gqe2q+xlb+UjLWVpn
 8exwbf+TIBnY9ArzCsAv/Gr4YBTsk+pNkopyafNgo/560aGw8CNjM/smBDw/pFeNxQ0h
 O/mXP5ZkxUYYV3S32GebDMvdGvBG2xNUgaAiUO1btYQZm5lbOKSH7veIjJ+LySfIUVIS
 2LnA==
X-Gm-Message-State: AOAM531ogh0TUXue+5pkU0IAH3LxYOo0nxsrS/Jqz0F782O9KkqxbQxH
 sFk7KSj2Y8OzujNwX0NTDgRVFXPtr5P+3a5wp0zIPQTn
X-Google-Smtp-Source: ABdhPJwX8AvM29XUfK/LG2v17nA8C38ihZmRL2Sr0hMbXUNbjSSiBrR/yt0fFsp0N/OneIDzRpPT8sV003ExuGTJp2c=
X-Received: by 2002:aca:ab06:: with SMTP id u6mr2611956oie.120.1631033903838; 
 Tue, 07 Sep 2021 09:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210902214510.55070-1-colin.king@canonical.com>
 <62384d80-8ef8-35bb-083e-61036d989efc@amd.com>
In-Reply-To: <62384d80-8ef8-35bb-083e-61036d989efc@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Sep 2021 12:58:12 -0400
Message-ID: <CADnq5_NgVEO6JhSmY=Fyz0QVjt1gYLmPb1G7u0k4aGp37+Vf2Q@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: clean up inconsistent indenting
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Colin King <colin.king@canonical.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 xinhui pan <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
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

Applied.  Thanks!

Alex

On Fri, Sep 3, 2021 at 2:31 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 02.09.21 um 23:45 schrieb Colin King:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There are a couple of statements that are indented one character
> > too deeply, clean these up.
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gem.c
> > index d6aa032890ee..a573424a6e0b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > @@ -60,10 +60,9 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *=
vmf)
> >                       goto unlock;
> >               }
> >
> > -              ret =3D ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_=
prot,
> > -                                             TTM_BO_VM_NUM_PREFAULT, 1=
);
> > -
> > -              drm_dev_exit(idx);
> > +             ret =3D ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_p=
rot,
> > +                                            TTM_BO_VM_NUM_PREFAULT, 1)=
;
> > +             drm_dev_exit(idx);
> >       } else {
> >               ret =3D ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot)=
;
> >       }
>
