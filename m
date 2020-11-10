Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A73C388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 18:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E47D207D3
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 18:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnGrGl8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E47D207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A391A89AC0;
	Tue, 10 Nov 2020 18:35:49 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B3E897C8;
 Tue, 10 Nov 2020 18:35:48 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id w24so4170565wmi.0;
 Tue, 10 Nov 2020 10:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fkc0ycbUoUtG+FjZeVMynAGeVGfFXsGCK1nH0SmgLw8=;
 b=GnGrGl8ndYX01vNQKIrlc8zSj69FGGJXTLXD7M3TAAt8RH+ROZUTNu+3vHZsgC59Tn
 BRRCF0o+A3dsav5WV3VHNRsqFwNyRkKL6rqcYYgg0bOlDdiL4KMs4o7DwxGN0lufrMZV
 1NWEJcTF3zCLZ/oSPDMqbsBV/RsZg6xLh2h3xj4oZHd/rTwmUfWHfIUGRF/E82cwW6+c
 XTUuPzPb3L12eXh3yT1X2sg56SXh5Jb12PgZKq5NStypmLmDIlEQyT6UoQJfEdYYp1Lf
 LEXkIWBxfxECp++Fyyr3o9j3BomLmLdNs7DCpG4qsHaJyA6P8ENyZuAl/1BR2h8zua1n
 elKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fkc0ycbUoUtG+FjZeVMynAGeVGfFXsGCK1nH0SmgLw8=;
 b=fe9HJdxFdSHIrydlCMm9HFoiHpvmJu4IJom/86wpadbNIAq5VRWNai10RuFJ9NSaXY
 dSxQsG+ExEMJe8poJcuof/EihY9eJMQNi7PSdSgmxOwQ07ieoC3siK9qfVd9INlVTmRV
 +QcZ7pL++20WLc0zzQUAgCBDWXHM056aBsX0sIuOI1C3EVgTsFMBHI+81tS2g0kZ9pea
 IKzPUoiKOUAuWgKTc3oiySzhdKZ0w9iIDhgruXCQBrCdsn4yH0vdpd03b/WLNanS8fSH
 +onQeGL2ftOadSYEds3RWRgY+ubnruqhhgQQ84BL4FauH1xHHDZiWcsPTc8dnK6/JC0S
 X2qQ==
X-Gm-Message-State: AOAM533aGCpk6JfY9RSimdggSWEo2WMO6otN4wfNUJ0yu6MkD/2Yn1Uv
 slwMCTxXgnNHfRAkapMSY9cNsJqblVahQ6uy64c=
X-Google-Smtp-Source: ABdhPJy2ChBuZ6+CQB/VWapMjPxaAAPkbc670SCDgbKEh+lkqy+WwsAKQ2Dt+ne308QWwZAyJH8O53zHCeeE+VpiVCk=
X-Received: by 2002:a1c:46c6:: with SMTP id t189mr463104wma.79.1605033346841; 
 Tue, 10 Nov 2020 10:35:46 -0800 (PST)
MIME-Version: 1.0
References: <20201110080318.36305-1-bernard@vivo.com>
 <2fcfe666-3c83-17ad-f287-6a1801268285@amd.com>
In-Reply-To: <2fcfe666-3c83-17ad-f287-6a1801268285@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Nov 2020 13:35:35 -0500
Message-ID: <CADnq5_NdtkOgt7rwiaQcaWJ2P--7sz49+NC0iWYU+R-L5LN5Gw@mail.gmail.com>
Subject: Re: [PATCH] amd/display/amdgpu_dm: delete same check in if condition
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: Stylon Wang <stylon.wang@amd.com>, opensource.kernel@vivo.com,
 Leo Li <sunpeng.li@amd.com>, Bernard Zhao <bernard@vivo.com>,
 Alexander Monakov <amonakov@ispras.ru>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <Roman.Li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 David Airlie <airlied@linux.ie>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 hersen wu <hersenxs.wu@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, Nov 10, 2020 at 9:13 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2020-11-10 3:03 a.m., Bernard Zhao wrote:
> > In function amdgpu_dm_connector_get_modes, drm_edid_is_valid
> > will check weather (!edid), no need to check again in the if
> > branch.
> >
> > Signed-off-by: Bernard Zhao <bernard@vivo.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index e93e18c06c0e..0a283d07fe10 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -6352,7 +6352,7 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
> >
> >       encoder = amdgpu_dm_connector_to_encoder(connector);
> >
> > -     if (!edid || !drm_edid_is_valid(edid)) {
> > +     if (!drm_edid_is_valid(edid)) {
> >               amdgpu_dm_connector->num_modes =
> >                               drm_add_modes_noedid(connector, 640, 480);
> >       } else {
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
