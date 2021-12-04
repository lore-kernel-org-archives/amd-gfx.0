Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0DCC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46E3073F04;
	Mon,  6 Dec 2021 10:19:46 +0000 (UTC)
Received: from msg-6.mailo.com (ip-16.mailobj.net [213.182.54.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCCB06E8F7
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Dec 2021 11:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=net-c.es; s=mailo;
 t=1638616186; bh=9hpDyo2by+LyJLJJ2NRMp0vBiXsXP628+LaUNYm9X0A=;
 h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:In-Reply-To;
 b=PuOPi54GVeEjCWadeWqIMfdig9d8k0iWZUUHIlSQjlsNzy7GJ5lY9nT5rSMl1Xhjn
 +Pm7rNGcn006ClEqsLW1EVl5npafZDOYBXpbu+8abcbFy6Ig3ouTlZn69tm4KDbA3D
 fWCfVGBYfT0jAWINDHj9hpOK4rNoEH6x+1qdWTsQ=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
 via ip-206.mailobj.net [213.182.55.206]
 Sat,  4 Dec 2021 12:09:46 +0100 (CET)
X-EA-Auth: BaLkIVL8UORq7SI06xJncm4D3hxV2kq8nbwzZN0ACUaeMpPWsLSQu1iCfq6ar6SX6oGU07ahQVclQPV9y6w0HixkATmK3opI
Date: Sat, 4 Dec 2021 12:09:44 +0100
From: Claudio Suarez <cssk@net-c.es>
To: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH 0/3] drm/amdgpu replace drm_detect_hdmi_monitor() with
 drm_display_info.is_hdmi
Message-ID: <YatMeIUyVJnoT3JG@gineta.localdomain>
References: <20211017113500.7033-1-cssk@net-c.es>
 <4217d1f5-e189-e3a5-547a-9ae205c3d539@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4217d1f5-e189-e3a5-547a-9ae205c3d539@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Hello,

These patches

https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg69247.html

are not uploaded to the linux source. I suppose I have to ping here.

Best regards,
Claudio Suarez.




On Mon, Oct 18, 2021 at 09:37:13AM -0400, Harry Wentland wrote:
> On 2021-10-17 07:34, Claudio Suarez wrote:
> > 
> > From the TODO list Documentation/gpu/todo.rst
> > -----------------------
> > Once EDID is parsed, the monitor HDMI support information is available through
> > drm_display_info.is_hdmi. Many drivers still call drm_detect_hdmi_monitor() to
> > retrieve the same information, which is less efficient.
> > 
> > Audit each individual driver calling drm_detect_hdmi_monitor() and switch to
> > drm_display_info.is_hdmi if applicable.
> > -----------------------
> > The task is divided in three small patches. The last patch depends on the
> > first one.
> > 
> 
> Thanks.
> 
> This series is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> Harry
> 
> > 
> > 
> > Claudio Suarez (3):
> >   drm/amdgpu: update drm_display_info correctly when the edid is read
> >   drm/amdgpu: use drm_edid_get_monitor_name() instead of duplicating the
> >     code
> >   drm/amdgpu: replace drm_detect_hdmi_monitor() with
> >     drm_display_info.is_hdmi
> > 
> >  .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 17 +++++----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c  |  4 +-
> >  .../gpu/drm/amd/amdgpu/atombios_encoders.c    |  6 +--
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
> >  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 37 +++++--------------
> >  drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
> >  drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  2 +-
> >  8 files changed, 29 insertions(+), 44 deletions(-)
> > 
> 


