Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31531C33CB3
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 18:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EDC62176D
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 18:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA3ZrOFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDC62176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B635B6EE7D;
	Thu, 16 Jan 2020 18:07:58 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BCDB6EE7D
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 18:07:57 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id u2so4803158wmc.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 10:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZuabgvR4Z4VYmlg8g7iJcEM2bodSedmckq4Zz4RFiws=;
 b=LA3ZrOFGMnkIMBGzAJFBjz1p0AolT+68Cxl1n9Zy+1px/19XvJHETxGdcQ7jbdJ+ua
 d5aq+MBC0edJAw13zcNFRGIIodvEWF/6V0Qvq4bqj3FRQoZQ246tLLYJYQZrP5pp+JR5
 mYsxOk0mmjWsYNR2B/k6Q1ON461nEJxK0T3boPhkCUcE52cp5nG/dX188LzbMlu/YI0Q
 FFJNKJEzm4P/rH+2PGokjwYoTRHj4pOCa4QgmNKYBEg94b+HUrKLFpaF9SlSlxDCQHtu
 I87WH2RKR1PS53rFDzx2a0d898PGYm9eGKtMtcTMstgEDwImp6F9krtBqYGGJjt15M4V
 YbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZuabgvR4Z4VYmlg8g7iJcEM2bodSedmckq4Zz4RFiws=;
 b=CU2mR7KWz/gzucyI1ncu3CzYkw1E/KuhZNAxc/esWnpaakBuo7HDyvGQzMWq7sem1V
 yOyAYiRSjhAMqxIa1EIrjTUSpTchZkrYPEoK1kuVBF87ZK7Zt7Ux/2xn3eqfZSwOKvaV
 rlHq51ynas1/trL8wpmov+tEHLADDfakBNhmRc9vvHWl0Tdeplt3NdbKWh3YAzgkQMHj
 CE61OOLfrztZnatrhRPOvGHjums8mulSl+HHWXBeepKAbAd8hBFKLIqu2/ldDFBT1Lsk
 UhvCHPfYScfOyBdvwrNOZAikbUXkRZOHthDai2Qr/sHHVVfMvxHU/ny+P0+p7c7vJQ55
 YEGw==
X-Gm-Message-State: APjAAAUhEGJuAlJNqX4nDb5HjVAaMm81KG6TCsU/xkUGSwVrSouLixYY
 6Bzn9M0TprwJBIdiL38F5NZFFAGw03rJN5zFPF1KsA==
X-Google-Smtp-Source: APXvYqyF6iUWAATHv8VPHNVr/LNiFVW0X3p1r1T9+LTkioRUiPgpIDla+Rwxw99SXiMkSAjoveJNmYKwN0aW1oy4vxU=
X-Received: by 2002:a1c:3d07:: with SMTP id k7mr262050wma.79.1579198076135;
 Thu, 16 Jan 2020 10:07:56 -0800 (PST)
MIME-Version: 1.0
References: <20200115173139.1392429-1-alexander.deucher@amd.com>
 <122fd08d-2881-f45a-183a-9190db93192d@amd.com>
In-Reply-To: <122fd08d-2881-f45a-183a-9190db93192d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jan 2020 13:07:43 -0500
Message-ID: <CADnq5_MahxQi3p04pQrDhjeu8r8hEC7NWTZBxUwVsX+ypXNT8A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: attempt to enable gfxoff on more raven1 boards
To: Luben Tuikov <luben.tuikov@amd.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 16, 2020 at 12:27 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> On 2020-01-15 12:31, Alex Deucher wrote:
> > Switch to a blacklist so we can disable specific boards
> > that are problematic.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 42 ++++++++++++++++++++++++---
> >  1 file changed, 38 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index e3d466bd5c4e..b48b07bcd0fb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -1031,6 +1031,37 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgpu_device *adev)
> >       }
> >  }
> >
> > +struct amdgpu_gfxoff_quirk {
> > +     u16 chip_vendor;
> > +     u16 chip_device;
> > +     u16 subsys_vendor;
> > +     u16 subsys_device;
> > +     u8 revision;
> > +};
> > +
> > +static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
> > +     /* https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D204689&amp;data=02%7C01%7Cluben.tuikov%40amd.com%7C683669e5a2c74bcbbc9108d799e0cda4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637147063903364365&amp;sdata=UL9SCKI7OchzK6a27AxkjrpeLNw%2BWH5DmpWGKutCI4A%3D&amp;reserved=0 */
> > +     { 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 },
> > +     { 0, 0, 0, 0, 0 },
> > +};
> > +
> > +static bool gfx_v9_0_raven_check_disable_gfxoff(struct pci_dev *pdev)
> > +{
> > +     const struct amdgpu_gfxoff_quirk *p = amdgpu_gfxoff_quirk_list;
> > +
> > +     while (p && p->chip_device != 0) {
>
> Maybe a "for" loop would make it compact?

Seems like the same difference either way.

>
> for ( ; p && p->chip_device != 0; p++) {
>         if (pdev->vendor == p->chip_vendor &&
>             pdev->device == p->chip_device &&
>             pdev->subsystem_vendor == p->subsys_vendor &&
>             pdev->subsystem_device == p->subsys_device &&
>             pdev->revision == p->revision) {
>                 return true;
>         }
> }
>
> I wonder if the structure "amdgpu_gfxoff_quirk" which stores
> device ID information can be named something more generic, (struct device_id?)
> and also used in "pdev"? (Reuse the struct.)
>
> Then we'd only compare structs:
>
> for ( ; p && p->chip_device != 0; p++) {
>         if (pdev->dev_id == *p)
>                 return true;
> }

pdev structure is huge.  All we need are the ids.

Alex

>
> Regards,
> Luben
>
> > +             if (pdev->vendor == p->chip_vendor &&
> > +                 pdev->device == p->chip_device &&
> > +                 pdev->subsystem_vendor == p->subsys_vendor &&
> > +                 pdev->subsystem_device == p->subsys_device &&
> > +                 pdev->revision == p->revision) {
> > +                     return true;
> > +             }
> > +             ++p;
> > +     }
> > +     return false;
> > +}
> > +
> >  static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
> >  {
> >       switch (adev->asic_type) {
> > @@ -1039,10 +1070,13 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
> >       case CHIP_VEGA20:
> >               break;
> >       case CHIP_RAVEN:
> > -             if (!(adev->rev_id >= 0x8 ||
> > -                   adev->pdev->device == 0x15d8) &&
> > -                 (adev->pm.fw_version < 0x41e2b || /* not raven1 fresh */
> > -                  !adev->gfx.rlc.is_rlc_v2_1)) /* without rlc save restore ucodes */
> > +             if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8) &&
> > +                 ((adev->gfx.rlc_fw_version != 106 &&
> > +                   adev->gfx.rlc_fw_version < 531) ||
> > +                  (adev->gfx.rlc_fw_version == 53815) ||
> > +                  (adev->gfx.rlc_feature_version < 1) ||
> > +                  !adev->gfx.rlc.is_rlc_v2_1) &&
> > +                 !gfx_v9_0_raven_check_disable_gfxoff(adev->pdev))
> >                       adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> >
> >               if (adev->pm.pp_feature & PP_GFXOFF_MASK)
> >
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
