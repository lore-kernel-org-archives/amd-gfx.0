Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DCBC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 17:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED65DEBFFA;
	Tue,  7 Dec 2021 17:48:03 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 032D6EBFFB
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 17:48:02 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 r10-20020a056830080a00b0055c8fd2cebdso19003728ots.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Dec 2021 09:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=StisW4UzL0l6yTqRpcSGZBxWxEXSdW5kVT5c3OGaRYE=;
 b=m4UagNSbqe76NvMD4Rnw7TD9KDUcXa1G55KgikpB1NwFkhFiKB8mcq/8SJYmfh4rsc
 vO2JCJ76zNO+fKF/Fq3WD0STo8ygnoggVqgsuZon185UjUMZtmtQ/1QSmjJlOjRjb4P7
 GUF0Udf1ItPNSkDYtqusiEaF+DnylQeTng1PRpzuSGywsgn1aAokwwQRAE7+Ye+e/O6n
 SYLI3TxM23lRItwQGgy679kyfub3KHkjzldjEUjmU15FQaImV3oFu2uFRB2F9fMGyXYX
 2F7G9mUVUntWcO3K4ScsXTt+Wlq6+JQozFJKMgizqMgelVx48VKCN/3/ZRjeZJ8prOV2
 aROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=StisW4UzL0l6yTqRpcSGZBxWxEXSdW5kVT5c3OGaRYE=;
 b=iOT9Ds1uQhsrIekb7S1wbbl5Nb/K0SEQhJVa83J7WvlCWRmiGk1CCofkpv+mKUOEJE
 81yHx5RdFlTKdx2NBzoQeAk2mzfnot4kpSzjurH8uLShA7TDRagSLeCgu14iIsPG/VkV
 KNDQDsKgO0D3Z+1iiKHjARVadk+Ay2WmVwLno7NdHNao9qOj28Ocofu4EkRynKBtJdHo
 WZu5L2Z3Ug7bW2Nn+RE4jzGaT0TqZVv28ccF1B7ZjNgvju8E57DjOt31awYenaWfrD0C
 8985Imeu8G11//TzP8J0VeDaEJshwIouBAQv5zxZoZiidQdjaW/ZWGTFx2JE5GYbvf+F
 FZpA==
X-Gm-Message-State: AOAM5303pdlufdUVDlDgg52UZTif/x9BVp4i4325/5o9b4rntezUmAps
 tG9TDPMUP9kvAFap3MnCg6W8Xlr5y8uEcxXYmZHTax1h
X-Google-Smtp-Source: ABdhPJwbqpA/8bOgJ4JS21z0ZqChTPrZzPRKAz3gCVrf2cpFRbfQSlCulUFS1D1aqZRyCebnzB48jA+Df0FKp6j8ta0=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id
 v15mr37823071ota.200.1638899282184; 
 Tue, 07 Dec 2021 09:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20211017113500.7033-1-cssk@net-c.es>
 <4217d1f5-e189-e3a5-547a-9ae205c3d539@amd.com>
 <YatMeIUyVJnoT3JG@gineta.localdomain>
 <CADnq5_MVpupUnkHrb9xFZOvVR9qVhUob06jsC72CUW_xY4nbuA@mail.gmail.com>
 <Ya9ldMI0+jC4RCsK@gineta.localdomain>
In-Reply-To: <Ya9ldMI0+jC4RCsK@gineta.localdomain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Dec 2021 12:47:51 -0500
Message-ID: <CADnq5_MgiZdBbTZUdkCwDFt_s_bH8rGj8ujuNaGm-Wzzc08a=w@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/amdgpu replace drm_detect_hdmi_monitor() with
 drm_display_info.is_hdmi
To: Claudio Suarez <cssk@net-c.es>
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

yeah, sorry about that.  I was mixing these up with another patch set.
I've applied them.  Sorry for the delay.

Alex

On Tue, Dec 7, 2021 at 8:45 AM Claudio Suarez <cssk@net-c.es> wrote:
>
> On Mon, Dec 06, 2021 at 05:15:11PM -0500, Alex Deucher wrote:
> > Do you have push rights to drm-misc?  IIRC, these patches depend on
> > the is_hdmi changes that recently went into drm-misc, so these patches
> > should probably go upstream via drm-misc rather than amdgpu.
>
> Sorry, I have missed to answer the second part.
> This patch depends on nothing. The only dependency is
> a92d083d08b0 (drm/edid: Add flag to drm_display_info to identify HDMI sinks, 2020-02-26)
> and it is in the kernel source since February 2020.
>
> These patches are not uploaded to misc:
> https://cgit.freedesktop.org/drm/drm-misc/tree/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> I don't think these patches will go upstream via drm-misc.
> The only post was to this list.
>
> I thought this is the list for pathches to amd drivers.
> Hope I am not wrong.
>
> Best regards,
> Claudio Suarez
>
>
> >
> > Alex
> >
> > On Mon, Dec 6, 2021 at 5:21 AM Claudio Suarez <cssk@net-c.es> wrote:
> > >
> > >
> > > Hello,
> > >
> > > These patches
> > >
> > > https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg69247.html
> > >
> > > are not uploaded to the linux source. I suppose I have to ping here.
> > >
> > > Best regards,
> > > Claudio Suarez.
> > >
> > >
> > >
> > >
> > > On Mon, Oct 18, 2021 at 09:37:13AM -0400, Harry Wentland wrote:
> > > > On 2021-10-17 07:34, Claudio Suarez wrote:
> > > > >
> > > > > From the TODO list Documentation/gpu/todo.rst
> > > > > -----------------------
> > > > > Once EDID is parsed, the monitor HDMI support information is available through
> > > > > drm_display_info.is_hdmi. Many drivers still call drm_detect_hdmi_monitor() to
> > > > > retrieve the same information, which is less efficient.
> > > > >
> > > > > Audit each individual driver calling drm_detect_hdmi_monitor() and switch to
> > > > > drm_display_info.is_hdmi if applicable.
> > > > > -----------------------
> > > > > The task is divided in three small patches. The last patch depends on the
> > > > > first one.
> > > > >
> > > >
> > > > Thanks.
> > > >
> > > > This series is
> > > > Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> > > >
> > > > Harry
> > > >
> > > > >
> > > > >
> > > > > Claudio Suarez (3):
> > > > >   drm/amdgpu: update drm_display_info correctly when the edid is read
> > > > >   drm/amdgpu: use drm_edid_get_monitor_name() instead of duplicating the
> > > > >     code
> > > > >   drm/amdgpu: replace drm_detect_hdmi_monitor() with
> > > > >     drm_display_info.is_hdmi
> > > > >
> > > > >  .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 17 +++++----
> > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  2 +-
> > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c  |  4 +-
> > > > >  .../gpu/drm/amd/amdgpu/atombios_encoders.c    |  6 +--
> > > > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
> > > > >  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 37 +++++--------------
> > > > >  drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
> > > > >  drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  2 +-
> > > > >  8 files changed, 29 insertions(+), 44 deletions(-)
> > > > >
> > > >
> > >
> > >
>
>
