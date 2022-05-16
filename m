Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D214BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 17:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7167910F8E7;
	Mon, 16 May 2022 17:21:23 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F9810F8E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 17:21:22 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-edf3b6b0f2so20992386fac.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 10:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=p+yCAlJAm+a1xgqswKvkBkBoKw6T+Aj8JCSaZiVq7NM=;
 b=RszJO1RiKxXXmIMzPYpSmxjzo2hRrZEq9w48rARJGJ249OlZyq8voWiIS2ocF7Ebr7
 seCEDx68LbhNaMXLsYgaurJI3jd9kQTypP8RyjhiDxB1ICEQ4jmiIlwipAyp4Qw8X+QD
 kEa8uPnxg0jJ8ewtX4kxdO9CV5aFQU/aPpZX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=p+yCAlJAm+a1xgqswKvkBkBoKw6T+Aj8JCSaZiVq7NM=;
 b=Ylmy/s0cQU3omsFtApffMf8PUrCcKvS+27xCwjbsH7gSfViaemrTU0sB7/+RbGPttI
 G1MTxkXf9Nm1XOvlihN6DloM4fR3Q829xNLv53oJB8TbI/7XaRrz+bnCzYk+v0kwMx9Y
 Mh5DlcoEjnQVDyndJgOjWXSXYAxMBry4ILj/Fcxh/hSryMCa2qwSdfh4hMFCDRgXHKxo
 Q7I1Np/kNo5RZtZ27gGLf6Nfitl85cJRMO0wv6mgTNdu18Zpe6BpnwKa8CxbUBseRxOp
 CgN241gzLpByeqGXCZgSLYyix7TuX3QFftBb0ddnnuaQ0MxRS+6UuZvriAdk4pp48F76
 fZyA==
X-Gm-Message-State: AOAM530UW2aVs60e1vRFxt89ddc/6128oEeHqy1/iyDo4SNlB8Fnd/pd
 8VZG3N+/9fc5oZGn/W05GoccFLuKabHeURhuUDkfWg==
X-Google-Smtp-Source: ABdhPJzvFkHqUv7yBkUODCzRyxecek0o1naJJsEHRMccmORSY8MICTmx65et6QHtWB1cQ21dPl61eH6+bVC7Rku2ZQY=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr16012561oap.228.1652721681391; Mon, 16
 May 2022 10:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
 <CADnq5_PZVo0GkkLqnhDA8THxQ2wgqx7zt1cARx+tTnsYo5gAOg@mail.gmail.com>
 <CAKMK7uGMsxAJGaPbPR9fhmdwKgV=hOG73H=Ju0hYU9G=8hfa7A@mail.gmail.com>
 <BN9PR12MB5145FCDE79EC4C5600CFCD858DCB9@BN9PR12MB5145.namprd12.prod.outlook.com>
 <CAKMK7uEkTZzTc+WU+6gFh7nrCuywpb4e_K=J4Row=Od1sEaPtw@mail.gmail.com>
 <e956c8a1-08fe-6e46-5d3a-0e3be4e80692@amd.com>
In-Reply-To: <e956c8a1-08fe-6e46-5d3a-0e3be4e80692@amd.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 16 May 2022 19:21:10 +0200
Message-ID: <CAKMK7uGN4jMh-Q101WnPcPn=1zFvhnHhTdxawjVyzUhf3jH9DQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] DC/DM changes needed for amdgpu PSR-SU
To: Leo Li <sunpeng.li@amd.com>
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Zhang,
 Dingchen \(David\)" <Dingchen.Zhang@amd.com>, "Lakha,
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

On Mon, 16 May 2022 at 18:23, Leo Li <sunpeng.li@amd.com> wrote:
>
>
>
> On 2022-05-12 13:39, Daniel Vetter wrote:
> > On Thu, 12 May 2022 at 19:22, Zhang, Dingchen (David)
> > <Dingchen.Zhang@amd.com> wrote:
> >>
> >> [AMD Official Use Only - General]
> >>
> >> Hi Daniel
> >>
> >> Thanks for your comments and explanations. I replied in-line and look =
forward to more discussion.
> >>
> >> regards
> >> David
> >>
> >>
> >> From: Daniel Vetter <daniel@ffwll.ch>
> >> Sent: Thursday, May 12, 2022 7:22 AM
> >> To: Alex Deucher <alexdeucher@gmail.com>
> >> Cc: Zhang, Dingchen (David) <Dingchen.Zhang@amd.com>; amd-gfx list <am=
d-gfx@lists.freedesktop.org>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>=
; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@=
amd.com>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon =
<Solomon.Chiu@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Pillai, Aurabindo <=
Aurabindo.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpre=
et <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.c=
om>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
> >> Subject: Re: [PATCH v2 00/19] DC/DM changes needed for amdgpu PSR-SU
> >>
> >> On Wed, 11 May 2022 at 17:35, Alex Deucher <alexdeucher@gmail.com> wro=
te:
> >>>
> >>> On Tue, May 10, 2022 at 4:45 PM David Zhang <dingchen.zhang@amd.com> =
wrote:
> >>>>
> >>>> changes in v2:
> >>>> -----------------------
> >>>> - set vsc_packet_rev2 for PSR1 which is safer
> >>>> - add exposure of AMD specific DPCD regs for PSR-SU-RC (rate-control=
)
> >>>> - add DC/DM change related to amdgpu PSR-SU-RC
> >>>>
> >>>>
> >>>> David Zhang (18):
> >>>>    drm/amd/display: align dmub cmd header to latest dmub FW to suppo=
rt
> >>>>      PSR-SU
> >>>>    drm/amd/display: feed PSR-SU as psr version to dmub FW
> >>>>    drm/amd/display: combine dirty rectangles in DMUB FW
> >>>>    drm/amd/display: update GSP1 generic info packet for PSRSU
> >>>>    drm/amd/display: revise Start/End SDP data
> >>>>    drm/amd/display: program PSR2 DPCD Configuration
> >>>>    drm/amd/display: Passing Y-granularity to dmub fw
> >>>>    drm/amd/display: Set default value of line_capture_indication
> >>>>    drm/amd/display: add vline time in micro sec to PSR context
> >>>>    drm/amd/display: fix system hang when PSR exits
> >>>>    drm/amd/display: Set PSR level to enable ALPM by default
> >>>>    drm/amd/display: use HW lock mgr for PSR-SU
> >>>>    drm/amd/display: PSRSU+DSC WA for specific TCON
> >>>>    drm/amd/display: add shared helpers to update psr config fields t=
o
> >>>>      power module
> >>>>    drm/amd/display: calculate psr config settings in runtime in DM
> >>>>    drm/amd/display: update cursor position to DMUB FW
> >>>>    drm/amd/display: expose AMD source specific DPCD for FreeSync PSR
> >>>>      support
> >>>>    drm/amd/display: PSR-SU rate control support in DC
> >>>>
> >>>> Leo Li (1):
> >>>>    drm/amd/display: Implement MPO PSR SU
> >>>
> >>> A couple of suggestions from Daniel on IRC:
> >>> 1.  Might be good to extract the "calculate total crtc damage" code
> >>> from i915 in intel_psr2_sel_fetch_update, stuff that into damage
> >>> helpers and reuse for i915 and amdgpu
> >>
> >> To expand a bit on this. There is currently a helper for total damage,
> >> but it's at the fb/plane level for drivers which need to upload
> >> buffers (usb/spi or virtual) drm_atomic_helper_damage_merged(). That
> >> one probably needs to be renamed to signify it's about the plane, and
> >> then we need a new drm_atomic_helper_crtc_damage_merged() which
> >> (extract from i915 code ideally) which computes total crtc damage for
> >> stuff like psr2/su or the command mode dsi panels (unfortunately none
> >> of the drivers for android for these panels have been upstreamed yet).
> >>
> >> <<<
> >> Checked the DRM comment for the helper `drm_atomic_helper_damage_merge=
d()` and
> >> quoted below:
> >> *****
> >> Drivers might want to use the helper functions drm_atomic_helper_damag=
e_iter_init()
> >> and drm_atomic_helper_damage_iter_next() or drm_atomic_helper_damage_m=
erged()
> >> if the driver can only handle a single damage region at most.
> >> *****
> >> Currently for amdgpu, the multiple damage clips combination (merging) =
is handled in
> >> DMUB firmware. And the DRM comment shows that the usage of "damage_mer=
ged()"
> >> helper is for the driver which can only handle single damage region at=
 most.
> >>
> >> Since AMDGPU is capable of handling multiple damaged clip (in DMUB FW)=
, can I
> >> understand that the group of helpers of `damage_merged()` in DRM is no=
t mandatory
> >> but optional?
> >
> > Ah I didn't see from a quick read that this was possible. How does
> > this work when the plane is enabled/disabled or resized or moved?
> > -Daniel
>
> Hi Daniel,
>
> When a plane is disabled, enabled, and/or resized(*), PSR is temporarily
> disabled. The mechanism to do so isn't in this patchset, but was added
> when PSR1 was first introduced to amdgpu_dm.
>
> In short, amdgpu_dm will disable PSR whenever DC requires a full update
> to program an atomic state (needs bandwidth recalculations and/or
> shuffling hw resources). For DC, enabling, disabling, and changing the
> scaling of a plane are considered full updates.
>
> When the plane is moved, both the old and new plane bounds are given to
> FW as dirty rectangles. (*)Resize should fall under the same bucket,
> though DC would consider that as a full update. I think disabling PSR
> would take precedence... will give this another spin to check.

That sounds a bit suboptimal with compositors that want to maximize
plane usage, but I guess if your hw can't do anything (i.e. no upload
rectangle that's in crtc coordinates) then that's just what it is. And
for that case I guess there's not much more helpers that make sense to
share, since the hw is just so different than what I've heard about
thus far.

Ofc if all these limitations are just DC and not the hw, then that
would indicate DC has become a midlayer in this area and needs to
expose the actual hw interface and all that, but sounds like that's
not the case. Just fairly strange hw design.

Cheers, Daniel

>
> Thanks,
> Leo
>
> >
> >> I also think that the split between dc and kms is a bit funny, I'd put
> >> only the resulting damage rect into dc_pipe and do the computation of
> >> that in the drm/kms linux code outside of dc functions (or in the glue
> >> code for dc), since I'm assuming on windows it's completely different
> >> approach in how you compute damage. Especially once we have the crtc
> >> damage helper on linux.
> >>
> >>> 2.  The commit message on "drm/amd/display: Implement MPO PSR SU" is =
a
> >>> bit funny, since if you use the helpers right you always get damage
> >>> information, just when it's from userspace that doesn't set explicit
> >>> damage it's just always the entire plane.
> >>
> >> <<<
> >> The current implementation to mark the entire MPO as dirt RECT is not =
the final
> >> version. Our next step is to implement the translation of DRM damaged =
clips to
> >> DC regions and pass to let DMUB FW to handle, which is able to handle =
at most
> >> 3 damaged regions for each DC surface.
> >>
> >>
> >>
> >> Yeah so that one was just another reason to use the helpers more in
> >> amdgpu for this.
> >> -Daniel
> >>
> >>>
> >>> Alex
> >>>
> >>>>
> >>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 142 +++++++++-
> >>>>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  21 +-
> >>>>   drivers/gpu/drm/amd/display/dc/core/dc.c      |  54 ++++
> >>>>   drivers/gpu/drm/amd/display/dc/core/dc_link.c |  47 +++-
> >>>>   drivers/gpu/drm/amd/display/dc/dc_link.h      |   4 +
> >>>>   drivers/gpu/drm/amd/display/dc/dc_stream.h    |   5 +
> >>>>   drivers/gpu/drm/amd/display/dc/dc_types.h     |  23 +-
> >>>>   .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   2 +
> >>>>   drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  64 +++++
> >>>>   drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   2 +
> >>>>   .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |   2 +
> >>>>   .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 131 +++++++++
> >>>>   .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |   2 +
> >>>>   .../dc/dcn30/dcn30_dio_stream_encoder.c       |  15 ++
> >>>>   drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
> >>>>   .../drm/amd/display/dc/inc/hw/link_encoder.h  |  21 +-
> >>>>   .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 250 ++++++++++++++=
+++-
> >>>>   .../amd/display/include/ddc_service_types.h   |   1 +
> >>>>   .../display/modules/info_packet/info_packet.c |  29 +-
> >>>>   .../amd/display/modules/power/power_helpers.c |  84 ++++++
> >>>>   .../amd/display/modules/power/power_helpers.h |   6 +
> >>>>   21 files changed, 887 insertions(+), 19 deletions(-)
> >>>>
> >>>> --
> >>>> 2.25.1
> >>>>
> >>
> >>
> >>
> >> --
> >> Daniel Vetter
> >> Software Engineer, Intel Corporation
> >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fblo=
g.ffwll.ch%2F&amp;data=3D05%7C01%7CSunpeng.Li%40amd.com%7C2e39f7cf022f46ee9=
17b08da343e5867%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63787973962449=
9442%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik=
1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D5Scos4KwScr%2F5MRPprq%2B0u=
yp76QRPDNRDt04afOVm5Y%3D&amp;reserved=3D0
> >
> >
> >



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
