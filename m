Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CFDC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 17:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F7A810E53E;
	Thu, 12 May 2022 17:39:21 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C10610E53E
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 17:39:20 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-edf3b6b0f2so7494492fac.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 10:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0NiZgjdQC6EfPXCKCUISc+1/5WUxll2tPcwsxQUz+qY=;
 b=Z2iA9NNbSBQcDluadB1QDauDMgA2qw0DXY9ZomsOrk9pk0kIapBX2k403YcQHuIHJr
 9IsJwXH6UnVsh4BXorGPR2akLM30S8MMC9fvtt86+KHp6ErSOFxsxolAPkG0+T+3QgTG
 H8n9rT0fXDPXBJABG7St1PP8yrZEsRXmggYgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0NiZgjdQC6EfPXCKCUISc+1/5WUxll2tPcwsxQUz+qY=;
 b=M9rl0zf2s2lRUbt+VwfigJa79B3MWca1MYy1mjsPJjryCV1PPnTr6UPXzKKypInmOW
 po73rcNBhDpWRGn9t4Zl/206cW/y1qxRU10K7PGcYQm1ikNTIYcif4bWhIgKLhsAeHya
 wEU4tZdi491y34w5pXIkMrD0b2SOTEPfjcaLabXK9O8jion0cXCcv93rGUsbYgyKP72V
 ESmUpaEkffUai8JSkOhHx63HZDx8i7uCvn+ksPtIr2dHIAUE2tceIq42N14/staef1Qg
 eBLUkogZJH3DCt7qSG5F56o7YX8Utf37pMi3PPUXdF852wFRiUIx7OjECUKYPQiyAlsk
 yNbQ==
X-Gm-Message-State: AOAM5338e+JwTd8dVWCv7kaPtpon4mmF9k7lE+XH0m+W1XE7nWCrnXWT
 wZ0rlSmPo/5zE3O20j97rNE40olYpvWgx0Gva1K2zA==
X-Google-Smtp-Source: ABdhPJyw9PG6DIaFaGmIGuAkoW4mXnR0cU0tE1acnSnKK2Km7u+IXpYv4v6zNIa4kFCSce+OOV434qYDR6hIN6jXuG4=
X-Received: by 2002:a05:6870:b4a2:b0:ee:326e:58fb with SMTP id
 y34-20020a056870b4a200b000ee326e58fbmr543549oap.7.1652377159465; Thu, 12 May
 2022 10:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
 <CADnq5_PZVo0GkkLqnhDA8THxQ2wgqx7zt1cARx+tTnsYo5gAOg@mail.gmail.com>
 <CAKMK7uGMsxAJGaPbPR9fhmdwKgV=hOG73H=Ju0hYU9G=8hfa7A@mail.gmail.com>
 <BN9PR12MB5145FCDE79EC4C5600CFCD858DCB9@BN9PR12MB5145.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5145FCDE79EC4C5600CFCD858DCB9@BN9PR12MB5145.namprd12.prod.outlook.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 12 May 2022 19:39:08 +0200
Message-ID: <CAKMK7uEkTZzTc+WU+6gFh7nrCuywpb4e_K=J4Row=Od1sEaPtw@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] DC/DM changes needed for amdgpu PSR-SU
To: "Zhang, Dingchen (David)" <Dingchen.Zhang@amd.com>
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, 12 May 2022 at 19:22, Zhang, Dingchen (David)
<Dingchen.Zhang@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Hi Daniel
>
> Thanks for your comments and explanations. I replied in-line and look for=
ward to more discussion.
>
> regards
> David
>
>
> From: Daniel Vetter <daniel@ffwll.ch>
> Sent: Thursday, May 12, 2022 7:22 AM
> To: Alex Deucher <alexdeucher@gmail.com>
> Cc: Zhang, Dingchen (David) <Dingchen.Zhang@amd.com>; amd-gfx list <amd-g=
fx@lists.freedesktop.org>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; L=
i, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd=
.com>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo =
<Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <So=
lomon.Chiu@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Pillai, Aurabindo <Aur=
abindo.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet =
<Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>=
; Kotarac, Pavle <Pavle.Kotarac@amd.com>
> Subject: Re: [PATCH v2 00/19] DC/DM changes needed for amdgpu PSR-SU
>
> On Wed, 11 May 2022 at 17:35, Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Tue, May 10, 2022 at 4:45 PM David Zhang <dingchen.zhang@amd.com> wr=
ote:
> > >
> > > changes in v2:
> > > -----------------------
> > > - set vsc_packet_rev2 for PSR1 which is safer
> > > - add exposure of AMD specific DPCD regs for PSR-SU-RC (rate-control)
> > > - add DC/DM change related to amdgpu PSR-SU-RC
> > >
> > >
> > > David Zhang (18):
> > >   drm/amd/display: align dmub cmd header to latest dmub FW to support
> > >     PSR-SU
> > >   drm/amd/display: feed PSR-SU as psr version to dmub FW
> > >   drm/amd/display: combine dirty rectangles in DMUB FW
> > >   drm/amd/display: update GSP1 generic info packet for PSRSU
> > >   drm/amd/display: revise Start/End SDP data
> > >   drm/amd/display: program PSR2 DPCD Configuration
> > >   drm/amd/display: Passing Y-granularity to dmub fw
> > >   drm/amd/display: Set default value of line_capture_indication
> > >   drm/amd/display: add vline time in micro sec to PSR context
> > >   drm/amd/display: fix system hang when PSR exits
> > >   drm/amd/display: Set PSR level to enable ALPM by default
> > >   drm/amd/display: use HW lock mgr for PSR-SU
> > >   drm/amd/display: PSRSU+DSC WA for specific TCON
> > >   drm/amd/display: add shared helpers to update psr config fields to
> > >     power module
> > >   drm/amd/display: calculate psr config settings in runtime in DM
> > >   drm/amd/display: update cursor position to DMUB FW
> > >   drm/amd/display: expose AMD source specific DPCD for FreeSync PSR
> > >     support
> > >   drm/amd/display: PSR-SU rate control support in DC
> > >
> > > Leo Li (1):
> > >   drm/amd/display: Implement MPO PSR SU
> >
> > A couple of suggestions from Daniel on IRC:
> > 1.  Might be good to extract the "calculate total crtc damage" code
> > from i915 in intel_psr2_sel_fetch_update, stuff that into damage
> > helpers and reuse for i915 and amdgpu
>
> To expand a bit on this. There is currently a helper for total damage,
> but it's at the fb/plane level for drivers which need to upload
> buffers (usb/spi or virtual) drm_atomic_helper_damage_merged(). That
> one probably needs to be renamed to signify it's about the plane, and
> then we need a new drm_atomic_helper_crtc_damage_merged() which
> (extract from i915 code ideally) which computes total crtc damage for
> stuff like psr2/su or the command mode dsi panels (unfortunately none
> of the drivers for android for these panels have been upstreamed yet).
>
> <<<
> Checked the DRM comment for the helper `drm_atomic_helper_damage_merged()=
` and
> quoted below:
> *****
> Drivers might want to use the helper functions drm_atomic_helper_damage_i=
ter_init()
> and drm_atomic_helper_damage_iter_next() or drm_atomic_helper_damage_merg=
ed()
> if the driver can only handle a single damage region at most.
> *****
> Currently for amdgpu, the multiple damage clips combination (merging) is =
handled in
> DMUB firmware. And the DRM comment shows that the usage of "damage_merged=
()"
> helper is for the driver which can only handle single damage region at mo=
st.
>
> Since AMDGPU is capable of handling multiple damaged clip (in DMUB FW), c=
an I
> understand that the group of helpers of `damage_merged()` in DRM is not m=
andatory
> but optional?

Ah I didn't see from a quick read that this was possible. How does
this work when the plane is enabled/disabled or resized or moved?
-Daniel

> I also think that the split between dc and kms is a bit funny, I'd put
> only the resulting damage rect into dc_pipe and do the computation of
> that in the drm/kms linux code outside of dc functions (or in the glue
> code for dc), since I'm assuming on windows it's completely different
> approach in how you compute damage. Especially once we have the crtc
> damage helper on linux.
>
> > 2.  The commit message on "drm/amd/display: Implement MPO PSR SU" is a
> > bit funny, since if you use the helpers right you always get damage
> > information, just when it's from userspace that doesn't set explicit
> > damage it's just always the entire plane.
>
> <<<
> The current implementation to mark the entire MPO as dirt RECT is not the=
 final
> version. Our next step is to implement the translation of DRM damaged cli=
ps to
> DC regions and pass to let DMUB FW to handle, which is able to handle at =
most
> 3 damaged regions for each DC surface.
>
>
>
> Yeah so that one was just another reason to use the helpers more in
> amdgpu for this.
> -Daniel
>
> >
> > Alex
> >
> > >
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 142 +++++++++-
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  21 +-
> > >  drivers/gpu/drm/amd/display/dc/core/dc.c      |  54 ++++
> > >  drivers/gpu/drm/amd/display/dc/core/dc_link.c |  47 +++-
> > >  drivers/gpu/drm/amd/display/dc/dc_link.h      |   4 +
> > >  drivers/gpu/drm/amd/display/dc/dc_stream.h    |   5 +
> > >  drivers/gpu/drm/amd/display/dc/dc_types.h     |  23 +-
> > >  .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   2 +
> > >  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  64 +++++
> > >  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   2 +
> > >  .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |   2 +
> > >  .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 131 +++++++++
> > >  .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |   2 +
> > >  .../dc/dcn30/dcn30_dio_stream_encoder.c       |  15 ++
> > >  drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
> > >  .../drm/amd/display/dc/inc/hw/link_encoder.h  |  21 +-
> > >  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 250 ++++++++++++++++=
+-
> > >  .../amd/display/include/ddc_service_types.h   |   1 +
> > >  .../display/modules/info_packet/info_packet.c |  29 +-
> > >  .../amd/display/modules/power/power_helpers.c |  84 ++++++
> > >  .../amd/display/modules/power/power_helpers.h |   6 +
> > >  21 files changed, 887 insertions(+), 19 deletions(-)
> > >
> > > --
> > > 2.25.1
> > >
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fblog.f=
fwll.ch%2F&amp;data=3D05%7C01%7Cdingchen.zhang%40amd.com%7Cbf7f256980c04124=
f60808da3409b3d4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6378795135420=
24968%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6I=
k1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Dtlr9ThR7DPE%2B8wv9e3n7Ud6=
3Ju9%2FRrka4OdK1KRgeWI%3D&amp;reserved=3D0



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
