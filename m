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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D3DC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 21:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B5620719
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 21:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASm/hNs9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B5620719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B633E6ECAE;
	Fri,  3 Apr 2020 21:16:44 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C84456ECAE
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 21:16:43 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id d77so8602984wmd.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2020 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=f/2NJ9TllPCgydq0YObvtRRJQ0xbAWsV8tzwtD+2Ais=;
 b=ASm/hNs9auJ4dDG/+uHYkjPinPn1dJeDH/8nsdsH1D5YGo8lGh+8PN95dRCfdcBTif
 JpxRfcglcr1PAT5iO1tNFIAOTTD36oSfNDWK8UOo6CSXhNgAFs1BA4DRlV4w56GzA5l1
 2O0guQy32OJWauWkfkL8Y8v9nSN0q6TWU4/OBpecSdzBkHG1Lqnf3cZKLYoRMJIlDtoL
 8TUcJPRqazoxpQaotNjmOCHHoD5/pFNdWl2x6p5OXdUhVP3CIS/ugwP1eyCV9D6MNhNR
 UI4K20qR2p+9bezMGBDvoM11cgx11U3+A7aYLpPdwa/AolmVyGi+wGqldpjO32sFToQ8
 DXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=f/2NJ9TllPCgydq0YObvtRRJQ0xbAWsV8tzwtD+2Ais=;
 b=n7lAHqBhLjzBn4Tsf1c0jcW4dKTuMF9UIJvr2lNRUkGmqNJ0G0J2FZ3MWLzLTkOn5n
 ueOPdyGN9aIxJM0sjgNNuFppjAWhPv/nbM8uGBuGyoawfr2Kk4wGBfWh8MjZTTrzXxvP
 quJz3K0QUfxA/ZsSHCa0IzdVc1zvqFbbScVQJT7E/mIdn/agkuG7SdOX4R4CwQM6vUP9
 X9jI7aupUOvpgL2QZwnPj/1oxd0zwowOEmU1dZCddDl0SFft4k+io1wqzHcFTbY2hTb2
 /2pfCSOxuZAvopnN/00SeOaZgvVtr5WNK3ELedjG/LUqBT0ofjEdrGDQInjVPKqzBEWc
 K9Pg==
X-Gm-Message-State: AGi0PuYIuFYHH79gGaBOodTjLQNVNlWh943HwZyFc60aJkUypriGmR5H
 zODPisiw+DCpP6T5zwzk/ZUc5gim8qsUfxZOd3STyg==
X-Google-Smtp-Source: APiQypKXQOOFq1zna/kWs/ZHYZi57/XSP4bDdd6+g+QUiMo3oO+MU435onrOA0HRm+T3x8g6SOU8KCi9ZIGKLSJzKnM=
X-Received: by 2002:a1c:2842:: with SMTP id o63mr10535638wmo.73.1585948602463; 
 Fri, 03 Apr 2020 14:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200403170856.7397-1-kent.russell@amd.com>
 <CADnq5_NfjqeS0AaEom0sTMjs2cD8kzcaw3ZxXMVg8Er-f8676w@mail.gmail.com>
 <DM6PR12MB3721A86D7E52F644CC97860E85C70@DM6PR12MB3721.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3721A86D7E52F644CC97860E85C70@DM6PR12MB3721.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Apr 2020 17:16:31 -0400
Message-ID: <CADnq5_OOCm676Zh8tS_Yo9PpNTSwnTo_mB+Z+A8oApxWqq13-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Re-enable FRU check for most models v3
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

On Fri, Apr 3, 2020 at 5:02 PM Russell, Kent <Kent.Russell@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Friday, April 3, 2020 4:51 PM
> > To: Russell, Kent <Kent.Russell@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> > Subject: Re: [PATCH] drm/amdgpu: Re-enable FRU check for most models v3
> >
> > On Fri, Apr 3, 2020 at 1:09 PM Kent Russell <kent.russell@amd.com> wrote:
> > >
> > > There are 2 VG20 SKUs that do not have the FRU on there, and trying to
> > > read that will cause a hang. For now, check for the gaming SKU until a
> > > proper fix can be implemented. This re-enables serial number reporting
> > > for server cards
> > >
> > > v2: Add ASIC check
> > > v3: Don't default to true for pre-VG10
> > >
> > > Signed-off-by: Kent Russell <kent.russell@amd.com>
> > > ---
> > >  .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 22
> > +++++++++++++++++--
> > >  1 file changed, 20 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > > index bfe4259f9508..508906177cad 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > > @@ -31,9 +31,27 @@
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
> > > +       switch (adev->asic_type) {
> > > +       case CHIP_VEGA20:
> > > +               if (strnstr(atom_ctx->vbios_version, "D360",
> > > +                               sizeof(atom_ctx->vbios_version)))
> > > +                       return false;
> >
> > Most skus are separated by pci revision ids.  Maybe it would be more
> > reliable to check that than a vbios string?
> I can look into that. This was really meant as a temporary workaround until we found the right way to poll the card altogether. I lifted this from John Clements' patch to isolate the D342 variant of Arcturus due to that whole EEPROM addressing thing. I'll see if I can find the revision IDs for those and see if they can be used instead. Maybe I can use that for John's D342 check as well.

In that case, we have two of the same sku, but with different EEPROM
chips, so the vbios version was the only thing we could use to
differentiate.  Really the EEPROM stuff should live in a vbios table
so we can query it.  For the pci revision id, in most cases there are
different revision ids for each sku.  There are generally more client
skus than server skus, so it's probably best to match on the server
sku and return true in that case.  I think the same logic also makes
sense if you end up having to use the vbios version (i.e., reverse the
current logic in this hunk of the patch).  I'd prefer to match the
vbios version of the server skus and return true for them and false
for everything else because I'm not sure what the vbios string will be
on AIB boards.  The DXXX naming is an AMD thing as far I know.

Alex

>
>
> >
> > Alex
> >
> >
> > > +               return true;
> > > +       case CHIP_ARCTURUS:
> > > +               /* There are no gaming Arcturus SKUs */
> > > +               return true;
> > > +       default:
> > > +               return false;
> > > +       }
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
> > gfx&amp;data=02%7C01%7Ckent.russell%40amd.com%7Cd1d72c89825549c6f
> > 06e08d7d810c83e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
> > 37215438899199940&amp;sdata=BnHE%2BT8D0j%2BHKD7s9J%2BXePsSYcXLG
> > bEYkmawDv3GNbw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
