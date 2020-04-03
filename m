Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA11C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F418C206E9
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUzO0Ux5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F418C206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4B576EB9E;
	Fri,  3 Apr 2020 16:47:55 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D98DD6EB9E
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 16:47:54 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id t128so7849680wma.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2020 09:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LDxw6pwRFZdD8prF+jCmbI47Dp1VjtZTmdLSGGQQVH8=;
 b=hUzO0Ux5Aip5S27wyEQNcxJ748SRJ3apQbDCkQrStZkeAHgoOFxJ02PkMi22BmG2mE
 E0/iM2oU8IyUsKolzVxRS3kVQqC/uIAJkF/1s7F7+34uyoEdQCIL5zMCL6E8fRaueM7g
 NlyU87nHBR6uhrTwIiqcZQviYSONdNmo0gMTCyv8s8FJGzCTztH3Uhg2uL4vRMad4STl
 Cs/CYYgtWKM22tmwx9tO9HpHDoQ1gCJ+QwYew6Czuz7VmZHVw7hjFaWTlDGL9xOYwrsx
 0/7NGgvsysDIlpXVHvsl6DJUVP4/HIV2uyl+KRaMQo3hDRVbRtynWYVFgqQ0/Mt+6R8Z
 JLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LDxw6pwRFZdD8prF+jCmbI47Dp1VjtZTmdLSGGQQVH8=;
 b=aJdwHBmwCPjccGNMgANBAQqz5nnDhFFPo6h5mSYV0lDnHJDRywqu5dGT4zkdctOskT
 l/xyk6aL7CIcOz+m64tHEYRkBEIJsPArj7siDuE/Tl2xvTmXeXrhPeinyGWSkGST/Ok3
 2BYE4s4mNPhhGSkFC4nmSIZTyoz21TB83qf/EZ+qXXLeHklOpQSqRysGdKQrtUVjoBLB
 rvwU4mLZnfgTIt23iizgVXD/eJeis64fSchh93P+dt5bILuMqIJc1WD8P5y0rFha6/Nj
 fTlLylvu11Soqpls/q0H9V1NPaPN6ON/BB9R458jXyYrIbqlCj/RQAzxQnkViX3Xajdp
 aEFg==
X-Gm-Message-State: AGi0PuZLaz1BgcjUoNJ6jH0ep6rWIluQpo+Cnib/zGsylpOjHWKzFj5n
 bIRdYint14MROTCZouV+9hJKeSHxKbNTX1mZH/d+pZMe
X-Google-Smtp-Source: APiQypIWrWac20PATlZ57Rfi+lrrcXD0aHUyOudWeGGxrUCxWUTjPhJwChX/nMH6fY/+iKuSvEpx2yQwnVPBjfY1WnE=
X-Received: by 2002:a1c:4b19:: with SMTP id y25mr9379060wma.70.1585932472562; 
 Fri, 03 Apr 2020 09:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200403163035.19177-1-kent.russell@amd.com>
 <CADnq5_MXO7sGC4ThC=5xxxvOUTEo3c1d5h-zipQrC9UPaYg+kg@mail.gmail.com>
 <DM6PR12MB3721BF3638E93E8811A7500485C70@DM6PR12MB3721.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3721BF3638E93E8811A7500485C70@DM6PR12MB3721.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Apr 2020 12:47:41 -0400
Message-ID: <CADnq5_OGNr_kfpyxofh0oVWT5ma+kqCJiJoq9uWQuE5RngD_6w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Re-enable FRU check for most models
To: "Russell, Kent" <Kent.Russell@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 3, 2020 at 12:41 PM Russell, Kent <Kent.Russell@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Friday, April 3, 2020 12:36 PM
> > To: Russell, Kent <Kent.Russell@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> > Subject: Re: [PATCH] drm/amdgpu: Re-enable FRU check for most models
> >
> > On Fri, Apr 3, 2020 at 12:30 PM Kent Russell <kent.russell@amd.com> wrote:
> > >
> > > There are 2 VG20 SKUs that do not have the FRU on there, and trying to
> > > read that will cause a hang. For now, check for the gaming SKU until a
> > > proper fix can be implemented. This re-enables serial number reporting
> > > for server cards
> > >
> > > Signed-off-by: Kent Russell <kent.russell@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 16
> > ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > > index bfe4259f9508..9582469a70cb 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > > @@ -31,9 +31,21 @@
> > >
> > >  bool is_fru_eeprom_supported(struct amdgpu_device *adev)  {
> > > -       /* TODO: Resolve supported ASIC type */
> > > +       struct atom_context *atom_ctx = adev->mode_info.atom_context;
> > >
> > > -       return false;
> > > +       if (!atom_ctx)
> > > +               return false;
> > > +
> > > +       /* TODO: Gaming SKUs don't have the FRU EEPROM.
> > > +        * Use this to address hangs on modprobe on gaming SKUs
> > > +        * until a proper solution can be implemented
> > > +        */
> > > +       if (adev->asic_type == CHIP_VEGA20)
> > > +               if (strnstr(atom_ctx->vbios_version, "D360",
> > > +                               sizeof(atom_ctx->vbios_version)))
> > > +                       return false;
> > > +
> > > +       return true;
> >
> > I think you want to default to false and only return true if it's a
> > vega20 and it's the right vbios version otherwise we'll try to fetch
> > the info on all asics.
>
> I was trying to go for the smallest list. There are 2 SKUs in all of VG20 that don't work, and none in Arcturus (and the FRU check is only for VG20+) , so I assumed that I could just cover the 2 bad cases. It's supported on Arcturus, and it's supported on server VG20, and we don't touch it at all on VG10-and-older.

Right, but if you return true by default, then the driver will try and
fetch the FRU stuff from every asic right?

I would do something like:

if ((adev->asic_type == CHIP_VEGA20) ||
   (adev->asic_type == CHIP_ARCTURUS) {
  /* do whatever logic makes sense here to sort out these asics */
    if (...)
        return false;
    else
        return true;
}

/* return false for everything else */
return false;

>
>  Kent
>
>
> >
> > Alex
> >
> > >  }
> > >
> > >  int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t
> > addrptr,
> > > --
> > > 2.17.1
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > >
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fr
> > eedesktop.org%2Fmailman%2Flistinfo%2Famd-
> > gfx&amp;data=02%7C01%7Ckent.russell%40amd.com%7C0f2e5090b21b4807b
> > 66808d7d7ed28f1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
> > 37215285907421019&amp;sdata=yBc0%2FrNnnWgRBiJcAvav4JtvmoG0Tyhd6p
> > X6gfFeW%2FU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
