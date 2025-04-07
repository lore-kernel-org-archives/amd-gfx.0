Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4B2C3601E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 15:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 167F610E4DA;
	Mon,  7 Apr 2025 15:05:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VLNgmfpF";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 194D110E4D9;
 Mon,  7 Apr 2025 15:05:21 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-30363975406so847345a91.0; 
 Mon, 07 Apr 2025 08:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744038320; x=1744643120; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ssQkPgtWHpg5qaEQQQk7L7Pz6LQv2SK5PMPPrhZLDD0=;
 b=VLNgmfpFVayBZZwKoLR5+f5oAP1IV7E4sm0o19efizYpcETW6iOU3luSbIogv7Crbf
 qKecPyV74gtlkf+xgyljrzQFpf02AySPPT+Ft8Oc+/2AldXFOeS/9rAaHZ3a2BLqxurf
 FCx5E4OPRt0vIDYEAqDfFNOIABuVERD/AA5ITH5RIICQacOFASnIeS3utwBMIVsmzVoP
 5+ddl4lcMR6jKBNiF+ODixQ/pos85ij6u3BXl62wA0UeKdNa4cARL77x6Knz0YB19Y3R
 U/MSDoZCq78h2T9512dmedpNEis2oRMXSmTjCnxYk/qlrIokutAgnxp0+UQZHAIBEQJ0
 zYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744038320; x=1744643120;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ssQkPgtWHpg5qaEQQQk7L7Pz6LQv2SK5PMPPrhZLDD0=;
 b=e/VNnn1TrpVC30onXYdEU0vDRhyvjaR5iTLqAplrxRcWPGZpAnAsjuNJ3ceOPhoVec
 6gk4S9NdbD4ctYXcWPdNri+3vGCr9KWaxcYDwFXa2fakatSsL+/5RaMv1jQTlEmxW1WG
 pNjOtJyKLGarsww5nfEuRUPckdccGNZbZkVHNpeWU15HmW+U3MCIai9bwtN7CVqU6QQf
 2/lmk80xvU4eUwWQxT98gH9kcFZ0wkNQHDfMjClgcuxNiIkjLoRDXjoARVHZ/rq58/GQ
 mIpdmwxvXRkXK6V40HZfyVgPw84CTsDA9IanhPdM0yd3agAA1ngwRsxrWO4IX4V2Dyjs
 T1vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4oZgk7BUs0XOdmFQ3oERinwDhyGP45Zdr5ksEhlLn5ruYvX/gXy7kEejXvROceTvzsMd1WZLHBzw=@lists.freedesktop.org,
 AJvYcCXvCTIeDODjUMIbO/IAhf26G+Dh0mG/3PCnqrx/W0DvGxAk/jJR3PXsnhnAJpdhp9Lz76Abbf/U@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBXKv+oh9W2/BWHK9qxnTJzkD505mKS96fJDVr/7F4CVOit2sm
 25BtLQl2DMc6AuOkzyJRLRR0Q5a3W1NeQ/Exl3uBkdXBNS4dccMIIvhuyHfsUsP105iRjdVyStv
 T/cfKz0UUMFU7ZCaU42nBgZ+2Wfs=
X-Gm-Gg: ASbGncsBCtFCoHGMYLj2aisO4npUfXI20Tbr+P2LJGi/CEyiOUWVX5B2RHrF7xS/3fN
 dm0foY8E5X14ziXvgKcN4vqkTWqIi7075Dnmz6RuxVXUhy6eqw435+m03uVzPkzhStNMOLYJ/lu
 zD3k5Hoisb0ky2B83Tv0wSlvFHfg==
X-Google-Smtp-Source: AGHT+IG3CcW8PNxBithByiKIoDwQtwb4MnM6pyE6J7swZNrMySsujjXMjLGzZDeXRyeckuo1cr6kBZnjAKY9R5oxkrk=
X-Received: by 2002:a17:90b:1c91:b0:2ff:4be6:c5bd with SMTP id
 98e67ed59e1d1-306a496b0c7mr7190956a91.8.1744038320305; Mon, 07 Apr 2025
 08:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250407141823.44504-3-matthew.auld@intel.com>
 <20250407141823.44504-4-matthew.auld@intel.com>
 <a4b1190d-4d4f-4c66-9fb7-2be19d2ea3dc@gmail.com>
In-Reply-To: <a4b1190d-4d4f-4c66-9fb7-2be19d2ea3dc@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Apr 2025 11:05:08 -0400
X-Gm-Features: ATxdqUFzbinX2Mkhe3iiE61F6xMhv6ybqKJIZzLsDt3WD66qk-EiQvU74RAp5zs
Message-ID: <CADnq5_NKa0seCJs7XvxUemyWPFCsuO3dX=n34OVJVn0cz2DuzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/dma_buf: fix page_link check
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
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

On Mon, Apr 7, 2025 at 10:42=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 07.04.25 um 16:18 schrieb Matthew Auld:
> > The page_link lower bits of the first sg could contain something like
> > SG_END, if we are mapping a single VRAM page or contiguous blob which
> > fits into one sg entry. Rather pull out the struct page, and use that i=
n
> > our check to know if we mapped struct pages vs VRAM.
> >
> > Fixes: f44ffd677fb3 ("drm/amdgpu: add support for exporting VRAM using =
DMA-buf v3")
> > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: <stable@vger.kernel.org> # v5.8+
>
> Good point, haven't thought about that at all since we only abuse the sg =
table as DMA addr container.
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Were is patch #1 from this series?
>
> Thanks,
> Christian.
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_dma_buf.c
> > index 9f627caedc3f..c9842a0e2a1c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > @@ -184,7 +184,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_att=
achment *attach,
> >                                struct sg_table *sgt,
> >                                enum dma_data_direction dir)
> >  {
> > -     if (sgt->sgl->page_link) {
> > +     if (sg_page(sgt->sgl)) {
> >               dma_unmap_sgtable(attach->dev, sgt, dir, 0);
> >               sg_free_table(sgt);
> >               kfree(sgt);
>
