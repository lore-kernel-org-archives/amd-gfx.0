Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08100C87FCA
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 07:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5B9F10E456;
	Fri, 25 Jul 2025 07:29:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jacqn34n";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CFF310E456
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 07:29:56 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45600581226so18707025e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 00:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753428595; x=1754033395; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fYitZNXB5TMJlw801+Zbsn7LGo5N/sIGGrhCJVrF0kw=;
 b=jacqn34n0+o+jxum0LYsKCgNU9ghxd08MQBmkIOxHAiIqSX+xzMhg3h/8CUtx5JGht
 A16KdHTBMj5Sep1/L+Oq2Cur/JMtDrrV5xhHKTLDCWRajpMHYcy2b/76mzYtvQxupEVU
 UNitSK2+/tNTjUi8QwtVj3rHaxM8NtKdrTFh4+PW22Cs+Cbqy0pKTV9agkou7bCL+aky
 Vr3P22R4pQbfOuIfYsxzh888zjs/U+tNgGXxWL9Yu+M037o1NgbKrw41cHpw55nYv+Xd
 rKzOo6ylmkdW92ojWIPPn2kKKMM+BWTZk+VTKveUHEoDTsEwGzZc+cwpLkwmskGLkH2r
 THQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753428595; x=1754033395;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fYitZNXB5TMJlw801+Zbsn7LGo5N/sIGGrhCJVrF0kw=;
 b=BCCoudhoS6nHFwgcWcGw2XjTIlDUfTmiWqDmVi40feGYERcKwbaooHLB7+3XxV1+U1
 S9iVrvp12tR045ifUzFaPcK3Se11640UqYrmdFTLBJMuL3eB9zOTQB4FhgV19X0DAeEY
 /HZp7AVZKOHIL9VgixmZZrDk/wgmMhh6pi/wZ0BA1DrY2zBRhosNlt9+7qvxNo6KOdGd
 YYhKXFZFQ42lmSFSB+M0j2RhZjhqK0zbJ9Ymb8CSVREh0Cr23+TH6sp5+Vf7LUaKAHx/
 nW77ptkMUtQhebsKfDPQMBPRiCpuSA9cAnphhT762iFJqQvg9SatggUt03XieVJ79UqX
 sRVQ==
X-Gm-Message-State: AOJu0YzEDXukedD2Awke0AcLbT2KDh+CYREYNxXDUcjvnjcTjQlcNCZm
 5D1CBKgjEkzs2cZJUo022jXiZYyVPHieM63wDfmFUc/MHLRHg7U1X8yf00v6KLLJ
X-Gm-Gg: ASbGncvYQ+Kl2iMMi+D3OyaCIdbMRwkMO+TvFEl7BCJr7Q7vna8z55JF/ZlPtbS0USZ
 qm8n3hw7d3gou7kXVvq2AN+3dkVUSIqylbqFL/uLya8CASDKd8hADreHU1WhJMtBKyLBCRHXorR
 Je4ECAQ3Cx0EP/CBOMnWL7FeOMwXUHbjhW7102Jy5aSBm+uuh+/HmEnv8rGcpi4h/JkEf71OVUj
 VtlufOPPCy+cjEnnad5CxBTpolE1jdI9sIdz5YCeAGbV1juR8QqLa3sRt76d1tPBexFU0vmoN4j
 Hta+UjxhP6omiaE77j0/ooGFSv2Nxa8Bjjhdq9r4/vcZ6+CSOeIcEJPYwNK+/3u16Fhj1z8etVy
 5LEiuCcogyLFjR37UuHkgYgi470aJvX9Gt2o7cxH2mAt47Fm5xJ1WjJ2Opw0RrIIpJls+MmI=
X-Google-Smtp-Source: AGHT+IGeVfj1xvHMhaupykO/HI5vL6xJA+0EHpJ0c0OHpsokBi9QaHLIqLdFQRjtzcL8503VO9U2Eg==
X-Received: by 2002:a05:600c:1c86:b0:43c:fc04:6d35 with SMTP id
 5b1f17b1804b1-45876307432mr6549525e9.4.1753428594252; 
 Fri, 25 Jul 2025 00:29:54 -0700 (PDT)
Received: from [192.168.0.188] (93-33-89-54.ip43.fastwebnet.it. [93.33.89.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4586ec77799sm38555265e9.2.2025.07.25.00.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 00:29:53 -0700 (PDT)
Message-ID: <85b988bbc30337c939affaa61507363544f6a3c5.camel@gmail.com>
Subject: Re: [PATCH 2/3] drm/amd/display: Don't overwrite dce60_clk_mgr
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Rodrigo Siqueira <siqueira@igalia.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Hung
 <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Date: Fri, 25 Jul 2025 09:29:52 +0200
In-Reply-To: <tyay5kxsv5fwm53gdobd2kn4l3b5y5v4ac6wv6n4lg2iefwdjw@u6gokzk4esx2>
References: <20250722155830.67401-1-timur.kristof@gmail.com>
 <20250722155830.67401-3-timur.kristof@gmail.com>
 <tyay5kxsv5fwm53gdobd2kn4l3b5y5v4ac6wv6n4lg2iefwdjw@u6gokzk4esx2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
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

On Thu, 2025-07-24 at 16:40 -0600, Rodrigo Siqueira wrote:
> On 07/22, Timur Krist=C3=B3f wrote:
> > dc_clk_mgr_create accidentally overwrites the dce60_clk_mgr
> > with the dce_clk_mgr, causing incorrect behaviour on DCE6.
>=20
> Could you ellaborate on what do you mean by incorrect behaviour?

By incorrect behaviour, I mean that the code was using dce_clk_mgr when
it should have used the dce60_clk_mgr. So the DCE 6 specific functions
were not correctly hooked up.

dce60_clk_mgr was added in 3ecb3b794e2c and according to that commit,
the main difference is that DCE 6 doesn't have the DPREFCLK_CNTL
registers.

>=20
> > Fix it by removing the extra dce_clk_mgr_construct.
> >=20
> > Fixes: 62eab49faae7 ("drm/amd/display: hide VGH asic specific
> > structs")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 1 -
> > =C2=A01 file changed, 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> > b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> > index 33b9d36619ff..4071851f9e86 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> > @@ -158,7 +158,6 @@ struct clk_mgr *dc_clk_mgr_create(struct
> > dc_context *ctx, struct pp_smu_funcs *p
> > =C2=A0			return NULL;
> > =C2=A0		}
> > =C2=A0		dce60_clk_mgr_construct(ctx, clk_mgr);
> > -		dce_clk_mgr_construct(ctx, clk_mgr);
>=20
> I suppose this error was not detected at the time because of the
> CONFIG_DRM_AMD_DC_SI guard. This lgtm, but I guess it would be nice
> to
> test this patch with other SI devices just to be sure

This series just contains some obvious regression fixes that I felt
were the most important and easiest to review.

SI definitely needs more work. I have a work in progress branch for
this; I'll send the patches in a separate series. (The main things that
are currently missing are fixing the display clock and taking
pm_display_cfg into use in legacy_dpm and si_dpm to include DC display
requirements in power management decisions.)

>=20
> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
>=20
> I added other display folks.
>=20
> Thanks
>=20
> > =C2=A0		return &clk_mgr->base;
> > =C2=A0	}
> > =C2=A0#endif
> > --=20
> > 2.50.1
> >=20
