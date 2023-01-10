Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82399C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 19:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A92310E657;
	Tue, 10 Jan 2023 19:41:57 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A073110E657
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 19:41:54 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id r130so10997009oih.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 11:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AEJkXFqby1yqVMn9wcYhOSmRMUoMFoY9K+OwIFwllPI=;
 b=WsmILlS2kyqCKABo8g4loVArESQcinADkizmlMlsqaceOfvfAUyhKOK7bfJIL8+NJx
 aZ1nEzexKFYknFzo1K0I5yFWba9pywPIQU+0WgX+poWmlJo2kuJ2W45Rca1J2QOoO6PR
 8drKHRRlkn01IOBnfkgLJqvSsEJWuJTE+la4g9odJPJv91rxtMmqp+9sVseiNJqEaxBc
 KNuzzTx45MxCe9gU1Nw5HO/WVkHAPZwn+M7mZdDJADtVik2bKO3cCWw7t3RF+lMks8i3
 vlmqg+3WRYy1wbO61wXPRZc9rKE6XKqA+57ksMfAky715clSCrWkrDoo1p8WnjZEHL7R
 9aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AEJkXFqby1yqVMn9wcYhOSmRMUoMFoY9K+OwIFwllPI=;
 b=Uled9SpBMBfRfWBqk86N5hjhZJHxXhPMxu5g8/rI3Gc1BQlcrHO3m0MgXfnWeCyik9
 eYv2O3F6YWjKnv2+naJHH5f98oPpMMyzVP4UzfSBnEUMTiQvutA84mFGrnMgi2w8C4wC
 0Zxiq5mpkuHTIi7d+jrcs4Clhz4cnx70vJtcvUztHAo67JROUrlEfS1ntIe8vBsHBiDl
 AX6eqhurtjqRXwLdoY5lhkfaHvIPj5eN6hYfUn58kGuu1s1BswFg+L0yUsYCoph/y7FR
 +tib5OInL5Btu9pksEw6JN5xHXbqaWWIKjIXdGnH2TgT8CC0aIiiRKPJIlW8Up2GuELd
 MpgA==
X-Gm-Message-State: AFqh2kotcA6fNpbyDxNuVqQxltn5bc4OE45C8RnPcblmW4N6maveJAlK
 mblJjgmCQiDWxj8k7hAcouaPJPGiM7civNe8E0k=
X-Google-Smtp-Source: AMrXdXs8ln7d10CUJKFG9nLaX/NW7v4s3Al0ih7DDkDJO6V0tEI6P/Ux+lFljqoYqrIak34/g34SVYMgKXgMNNRRtmQ=
X-Received: by 2002:a05:6808:2994:b0:35b:f5f7:3ed0 with SMTP id
 ex20-20020a056808299400b0035bf5f73ed0mr4803617oib.46.1673379713730; Tue, 10
 Jan 2023 11:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20230110191547.5042-1-mario.limonciello@amd.com>
 <CADnq5_M1z0j1559YkadccZ-d3MAw1K7ZZb-gJeyrykdQgn=utg@mail.gmail.com>
 <MN0PR12MB6101F4E129A260830E72B2BEE2FF9@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101F4E129A260830E72B2BEE2FF9@MN0PR12MB6101.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Jan 2023 14:41:41 -0500
Message-ID: <CADnq5_NsDsHUytcJAi86Mwj9+M92xaDwSOA5AesZ7JSvyzdNoQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Only load TA microcode for psp v12_0 once
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 10, 2023 at 2:40 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
>
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Tuesday, January 10, 2023 13:29
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Subject: Re: [PATCH] drm/amd: Only load TA microcode for psp v12_0 once
> >
> > On Tue, Jan 10, 2023 at 2:16 PM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> > >
> > > During rebase from patch series accidentally ended up with two calls
> > > to load TA microcode for psp v12_0. Only one is needed, so remove the
> > > second.
> > >
> > > Fixes: f1efed401badb ("drm/amd: Parse both v1 and v2 TA microcode
> > headers using same function")
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > I'll squash this into f1efed401badb.
>
> You mean when you send it up for drm-next?  At least for amd-staging-drm-next it
> should probably be it's own separate commit though still right?

Correct.

Alex


>
> >
> > Alex
> >
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> > b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> > > index e82a0c2bf1faa..fcd708eae75cc 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> > > @@ -55,9 +55,6 @@ static int psp_v12_0_init_microcode(struct
> > psp_context *psp)
> > >         amdgpu_ucode_ip_version_decode(adev, MP0_HWIP, ucode_prefix,
> > sizeof(ucode_prefix));
> > >
> > >         err = psp_init_asd_microcode(psp, ucode_prefix);
> > > -       if (err)
> > > -               return err;
> > > -       err = psp_init_ta_microcode(psp, ucode_prefix);
> > >         if (err)
> > >                 return err;
> > >
> > > --
> > > 2.25.1
> > >
