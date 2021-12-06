Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBB1C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 23:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CB2F7B28F;
	Mon,  6 Dec 2021 23:13:22 +0000 (UTC)
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4EC17B28E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 23:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=net-c.es; s=mailo;
 t=1638832392; bh=1lG3OTSwfCqe/1WIm9Zv9vDzj7/RWLJ5rUJDVQZAIIc=;
 h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:In-Reply-To;
 b=oZriGok1vlan4KyI1pTl1Qlsvzj5pWimAtAKZG9vkOeKUOtxYtefnWdmBinl72KcU
 xuNiMaYFpahXbjIjL4l95L9AmscceK8waeUAdyCoyfVfrOyJzRdgFbe1MpT+IP9PF1
 BPJVrv1ymEvJ7O/eoKlgh9uRHTqff0aYndpbXJk4=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
 via ip-206.mailobj.net [213.182.55.206]
 Tue,  7 Dec 2021 00:13:12 +0100 (CET)
X-EA-Auth: Fw5ZCTLQnqGjEXn25U1sKFvb7iQBV+g2gPlcJS4qOm5vI+8l4Mn7rRaTkwE8Voqux83F2F7Mw/7c1gS73WEmUy9ORApuWTTJ
Date: Tue, 7 Dec 2021 00:13:10 +0100
From: Claudio Suarez <cssk@net-c.es>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 0/3] drm/amdgpu replace drm_detect_hdmi_monitor() with
 drm_display_info.is_hdmi
Message-ID: <Ya6ZBtiE3CZyl1Pp@gineta.localdomain>
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
> Do you have push rights to drm-misc?

No, I am sorry. I have not.

Best regards.
Claudio Suarez.


  IIRC, these patches depend on
> the is_hdmi changes that recently went into drm-misc, so these patches
> should probably go upstream via drm-misc rather than amdgpu.
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


