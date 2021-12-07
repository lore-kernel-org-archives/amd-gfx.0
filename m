Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A161BC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 13:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287446F9C4;
	Tue,  7 Dec 2021 13:45:33 +0000 (UTC)
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D09F6F612
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 13:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=net-c.es; s=mailo;
 t=1638884725; bh=HW6dTz3D33n5rVfZBxa79V/ZcMG3fmNlK41HvBZWnfA=;
 h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:In-Reply-To;
 b=myADxgL20UePVe+N2i2ABGGrhe91iL4TEq/vKbmTVtKPd0GdjQn88u2h7/NnW2AxK
 F+UhkI+nFoxV7nxa4RQPhwFHN+BJLM4M4c7SXZk3yBcgUy4D+crzOMfjs0JHHNDGty
 EvhqBQRQnaS7c14NuMq9rqddFWyipLQZ+lyt4TEk=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
 via ip-206.mailobj.net [213.182.55.206]
 Tue,  7 Dec 2021 14:45:25 +0100 (CET)
X-EA-Auth: TRqmyO/oI8GBLMJttoRfxxQlE7TBiwcSTVPDT7sp3fvhw7MmZNshLEwgLcUwWdywVvRRzQO3/JbTwVCaPu9+3gn5tgbDln0X
Date: Tue, 7 Dec 2021 14:45:24 +0100
From: Claudio Suarez <cssk@net-c.es>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 0/3] drm/amdgpu replace drm_detect_hdmi_monitor() with
 drm_display_info.is_hdmi
Message-ID: <Ya9ldMI0+jC4RCsK@gineta.localdomain>
References: <20211017113500.7033-1-cssk@net-c.es>
 <4217d1f5-e189-e3a5-547a-9ae205c3d539@amd.com>
 <YatMeIUyVJnoT3JG@gineta.localdomain>
 <CADnq5_MVpupUnkHrb9xFZOvVR9qVhUob06jsC72CUW_xY4nbuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_MVpupUnkHrb9xFZOvVR9qVhUob06jsC72CUW_xY4nbuA@mail.gmail.com>
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 06, 2021 at 05:15:11PM -0500, Alex Deucher wrote:
> Do you have push rights to drm-misc?  IIRC, these patches depend on
> the is_hdmi changes that recently went into drm-misc, so these patches
> should probably go upstream via drm-misc rather than amdgpu.

Sorry, I have missed to answer the second part.
This patch depends on nothing. The only dependency is
a92d083d08b0 (drm/edid: Add flag to drm_display_info to identify HDMI sinks, 2020-02-26)
and it is in the kernel source since February 2020.

These patches are not uploaded to misc:
https://cgit.freedesktop.org/drm/drm-misc/tree/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
I don't think these patches will go upstream via drm-misc.
The only post was to this list.

I thought this is the list for pathches to amd drivers.
Hope I am not wrong.

Best regards,
Claudio Suarez


> 
> Alex
> 
> On Mon, Dec 6, 2021 at 5:21 AM Claudio Suarez <cssk@net-c.es> wrote:
> >
> >
> > Hello,
> >
> > These patches
> >
> > https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg69247.html
> >
> > are not uploaded to the linux source. I suppose I have to ping here.
> >
> > Best regards,
> > Claudio Suarez.
> >
> >
> >
> >
> > On Mon, Oct 18, 2021 at 09:37:13AM -0400, Harry Wentland wrote:
> > > On 2021-10-17 07:34, Claudio Suarez wrote:
> > > >
> > > > From the TODO list Documentation/gpu/todo.rst
> > > > -----------------------
> > > > Once EDID is parsed, the monitor HDMI support information is available through
> > > > drm_display_info.is_hdmi. Many drivers still call drm_detect_hdmi_monitor() to
> > > > retrieve the same information, which is less efficient.
> > > >
> > > > Audit each individual driver calling drm_detect_hdmi_monitor() and switch to
> > > > drm_display_info.is_hdmi if applicable.
> > > > -----------------------
> > > > The task is divided in three small patches. The last patch depends on the
> > > > first one.
> > > >
> > >
> > > Thanks.
> > >
> > > This series is
> > > Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> > >
> > > Harry
> > >
> > > >
> > > >
> > > > Claudio Suarez (3):
> > > >   drm/amdgpu: update drm_display_info correctly when the edid is read
> > > >   drm/amdgpu: use drm_edid_get_monitor_name() instead of duplicating the
> > > >     code
> > > >   drm/amdgpu: replace drm_detect_hdmi_monitor() with
> > > >     drm_display_info.is_hdmi
> > > >
> > > >  .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 17 +++++----
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  2 +-
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c  |  4 +-
> > > >  .../gpu/drm/amd/amdgpu/atombios_encoders.c    |  6 +--
> > > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
> > > >  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 37 +++++--------------
> > > >  drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
> > > >  drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  2 +-
> > > >  8 files changed, 29 insertions(+), 44 deletions(-)
> > > >
> > >
> >
> >


