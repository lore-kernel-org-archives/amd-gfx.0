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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41A7C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 16:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFD660EBA
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 16:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8BFD660EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51FB16E06D;
	Tue,  7 Sep 2021 16:59:15 +0000 (UTC)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA42D6E063;
 Tue,  7 Sep 2021 16:59:13 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 j11-20020a4a92cb000000b002902ae8cb10so3121764ooh.7; 
 Tue, 07 Sep 2021 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yGhlEcWAmkOIUP0KcWj+kobRkgQf1kC9BN+bCXhgInU=;
 b=nlLEhmuIw37kyWO+W+izNA5oEpC//ZXt13F33/D9ZojjKBXu73jbv61UPIGkmMgC0Q
 cqi/3dW9asI+eDILJr4YhiagPZRYuvXqJBQaGqDuw13uX5tZjt5Yotki/TL+OGsKV0WZ
 PdHoZtrACfkVJXMmm3NyxzI6yE2TzHF+RSaCXPpHoObGjlJw5sL1aF3gFqRhX9Hf55cr
 eGBb+pO4tUabBBFmO7F5jaHGVzhj+4KgykGgEBLWghNS5E8XpNROulgLRXRv3HM5RwUR
 0PANTYfuyEEh+VfW95UX8p93dEnGnb+JQm8tVRLliu5Gg06/pZC7tz+i7RXXZGgYXelH
 XLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yGhlEcWAmkOIUP0KcWj+kobRkgQf1kC9BN+bCXhgInU=;
 b=UXc6M6ZdKHYWq5vUMsDkwyKA+F4PCsUo6+mWlsIYPlkD9QVpBzn+zdGH9Zl4scrN0L
 H6QPuxeZz0ywk3fRbtn2tW3iHbbgt7EXI+5JZkEIx35ILyCGV9i4y3ZKOwdklx6kznUv
 AqpmaZWlCdfo7HPaYTlVuHFnjWkyoa85WD0dA/y19mJthGPHprR8lE56+K1mp98knrfL
 5AmF4JvaMzijK0TElg/ke4um0tq31tTuZam0Wi8jDaFgPbdOW3UIc7zjjN94JCYYAKpD
 tMnJI85fa0w6adzKq6XWocGAIqg5rVDc7/YvCrrBnvPi0vTn1za5Rpl5NWQUqIVfgO2b
 5MuA==
X-Gm-Message-State: AOAM532W03vET4pWktS+CLLFdBEb6icmfa2hD6DvAAMqZEu+vV8Nl47F
 GmdGzCp3ZVk1eJShhe5dZyYB7bEs8iOcCslu9FM=
X-Google-Smtp-Source: ABdhPJztexkmO6F4hC0uTaplz22vYnXIkvWMVIv6HMvkULpmAknxRcB9k8FShKGIQZf3yT5nYu9/1rtbZGwuoyMMmrA=
X-Received: by 2002:a4a:d794:: with SMTP id c20mr692176oou.23.1631033953123;
 Tue, 07 Sep 2021 09:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210902215127.55330-1-colin.king@canonical.com>
 <bb5105f8-2ec6-e494-8764-3dcc5fc0681b@amd.com>
In-Reply-To: <bb5105f8-2ec6-e494-8764-3dcc5fc0681b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Sep 2021 12:59:02 -0400
Message-ID: <CADnq5_Psv9HG5C=9OwaXY64uRLnmJ4NjnsbviG6zwvpdmuNcRA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: sdma: clean up identation
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
> Am 02.09.21 um 23:51 schrieb Colin King:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There is a statement that is indented incorrectly. Clean it up.
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v5_2.c
> > index 779f5c911e11..e4a96e7e386d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > @@ -375,10 +375,10 @@ static void sdma_v5_2_ring_emit_ib(struct amdgpu_=
ring *ring,
> >    */
> >   static void sdma_v5_2_ring_emit_mem_sync(struct amdgpu_ring *ring)
> >   {
> > -    uint32_t gcr_cntl =3D
> > -                 SDMA_GCR_GL2_INV | SDMA_GCR_GL2_WB | SDMA_GCR_GLM_INV=
 |
> > -                     SDMA_GCR_GL1_INV | SDMA_GCR_GLV_INV | SDMA_GCR_GL=
K_INV |
> > -                     SDMA_GCR_GLI_INV(1);
> > +     uint32_t gcr_cntl =3D SDMA_GCR_GL2_INV | SDMA_GCR_GL2_WB |
> > +                         SDMA_GCR_GLM_INV | SDMA_GCR_GL1_INV |
> > +                         SDMA_GCR_GLV_INV | SDMA_GCR_GLK_INV |
> > +                         SDMA_GCR_GLI_INV(1);
> >
> >       /* flush entire cache L0/L1/L2, this can be optimized by performa=
nce requirement */
> >       amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_GCR_REQ));
>
