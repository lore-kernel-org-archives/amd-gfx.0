Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B075C369B2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 19:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F4010E09B;
	Mon, 14 Apr 2025 19:38:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ebPlohhV";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9110010E09B
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 19:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Oyv9aHhZPqsjVauooNMszUkbtKcrF0flXwDzUVlf8q0=; b=ebPlohhVAT29FlC8K1Gb/YTSHv
 N+airQ1xt0t0izaBin/2WrBTxkAgU1udsbo1JnEs+CgLQTn2IxJYY17s78o1WIORIEc+18iAt9tEE
 Fzl1I3WBPp/QznwYeQJy4LG6lVGHQiJr4/4Imw0z0Fj1BdjD+fOLnjoVdabpYu1KmXgp9sydsp16N
 zuJExfwnU9Lhh/4hz9038MvNauMz67jZegiYykqcSqfOVXKTopGRDWqsuKedLXtRWxFp2XHSPwlSV
 OPbOx/5T64QlJM+S7E80iUFvNC0NRDfBiM1iPIFtZIPVsH61TW8lkV8pVcJ9iZdrMhhV3a3O+ANU2
 BrDcS6pg==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u4PdS-00Geml-RF; Mon, 14 Apr 2025 21:38:27 +0200
Date: Mon, 14 Apr 2025 13:38:22 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH v2 7/9] drm/amdgpu/gfx: Clean up gfx_v7_0_get_csb_buffer
Message-ID: <kg62gvo454qwwogrkadsv5chufzn6heyqtxkqtonqspuzhodqy@jt3iyllwmogh>
References: <20250412202134.3025051-1-siqueira@igalia.com>
 <20250412202134.3025051-8-siqueira@igalia.com>
 <CADnq5_NCyuZdO4gHzpjfV_ASZ+ExkWAb41jeE+N+DBqfQuUaZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_NCyuZdO4gHzpjfV_ASZ+ExkWAb41jeE+N+DBqfQuUaZA@mail.gmail.com>
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

On 04/13, Alex Deucher wrote:
> On Sat, Apr 12, 2025 at 4:22 PM Rodrigo Siqueira <siqueira@igalia.com> wrote:
> >
> > CHIP_KAVERI, CHIP_KABINI, and CHIP_MULLINS have the same buffer
> > manipulation as the default option in the switch case. Remove those
> > specific manipulations and rely on the default behavior for them.
> >
> > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > index 16b94ff5a959..4d8d68b737d1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > @@ -3902,15 +3902,6 @@ static void gfx_v7_0_get_csb_buffer(struct amdgpu_device *adev,
> >                 buffer[count++] = cpu_to_le32(0x16000012);
> >                 buffer[count++] = cpu_to_le32(0x00000000);
> >                 break;
> > -       case CHIP_KAVERI:
> > -               buffer[count++] = cpu_to_le32(0x00000000); /* XXX */
> > -               buffer[count++] = cpu_to_le32(0x00000000);
> > -               break;
> > -       case CHIP_KABINI:
> > -       case CHIP_MULLINS:
> > -               buffer[count++] = cpu_to_le32(0x00000000); /* XXX */
> > -               buffer[count++] = cpu_to_le32(0x00000000);
> > -               break;
> 
> These should be fixed rather than removed.  Actually, all of these
> should be fixed up for all chips.  We should use the values calculated
> by the driver similar to what we do in gfx_v8.  E.g.,
>         buffer[count++] =
> cpu_to_le32(adev->gfx.config.rb_config[0][0].raster_config);
>         buffer[count++] =
> cpu_to_le32(adev->gfx.config.rb_config[0][0].raster_config_1);
> 

ok, I checked the code sequence, and fwiu gfx_v7_0_setup_rb() ->
gfx_v7_0_raster_config() is called before gfx_v7_0_get_csb_buffer().
 gfx_v7_0_raster_config() has the setup for all of the ASICs in this
part. I also have a HAWAII and confirmed that using raster_config
directly had the same value as the one hardcoded in this part. Anyway,
I'll send a v3 with this fix.

When I was looking into the code, it was not clear to me these things:

1. What is this config RB? Why is there a field for User RB? Also, what
   RB stands for?
2. Why there is raster_config and raster_config_1? Is raster_config_1
   some sort of fallback?

Thanks

> Alex
> 
> >         case CHIP_HAWAII:
> >                 buffer[count++] = cpu_to_le32(0x3a00161a);
> >                 buffer[count++] = cpu_to_le32(0x0000002e);
> > --
> > 2.49.0
> >

-- 
Rodrigo Siqueira
