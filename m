Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA68CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 15:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1595B88D1E;
	Thu, 13 Jan 2022 15:00:28 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C10FD88D1E
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 15:00:26 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id g205so8014168oif.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 07:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lgpQS2Ev6D4tHPtETfEK2unFwJICopCqDHcvSTUSs3U=;
 b=QC69U+eYQfXeNHWOCGjrVKMl+uF7/InTME8bRr2n/CcIWLhK8Xovu9vyqUuH65QvJG
 vdBFY6p5jTNs7IGcE4W17t3NMzaowdQ4+i0LTHIbO9wiAi79nCSLVNZD2ZTsQmtmeJLk
 EOso6w3jsmwTGKfnqy+74EjnQ0wS1CwdE03h0GQCIFBnEjLB/VRCbbO04OeFh+XuSvhV
 9mfy8lSkaNmuXr+4O5wPnOEaq1+DsHnz8d+Oj0WmTO7FNfyqF/dcbKBLtVtVNJ7kDtFA
 OH7zOByJN7MIEbAQe9WSLE8/GsUtsewhu6Wmrj5cdB888vLzBlV/iXUDhjACrrNOKveA
 JCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lgpQS2Ev6D4tHPtETfEK2unFwJICopCqDHcvSTUSs3U=;
 b=VQP1mIharbJ8B5DHzBc9Tnslh+ZOJOHTToNJiDokGETef/AR5YiUfncdwQ69U9QAvI
 2PXcEvXfXDNsnqbFVDLMlCp0P8/Pb+/CYcsLv6FPnT/5JPY2lbyRXBg346O9H6omXW6B
 SJyLWN/nVCiAgG1zWqxPIGrvCNXtYilF1RPed8k8n6KT6Qb22g8S8BZUDTMa0DEK4+NN
 5VD4QEsrnh5V4ufYhzTd6LqXSbiF1g+GIwxmz0B2yq/ivhl5vuKvn2G9zCn2QwGIQiFF
 YRcSNoWXbXRMufOnzOoTxkpwnaLZByyD2sLauQxvQpME+pFP8eO9wec0smqSWjmcDUqx
 ufAA==
X-Gm-Message-State: AOAM532qgUSZlRf0z2Lsks0sUk0wHmvqY//WhU9sRp0OB2BriQQ4iGrk
 1fBbwHtUHcZJ9K5LOYctTDJbki1mZnmMv+rnTmI=
X-Google-Smtp-Source: ABdhPJykKZ017BQ47eDrAkrwuvGzIWuhI9b5QLfaW8b5fuEwOw9A6KPP1mwK+LSNfO78LsyJVO0LlXV36sTUxdDVbSw=
X-Received: by 2002:a05:6808:300b:: with SMTP id
 ay11mr3396140oib.120.1642086026062; 
 Thu, 13 Jan 2022 07:00:26 -0800 (PST)
MIME-Version: 1.0
References: <20220113040103.311160-1-alexander.deucher@amd.com>
 <1586c31f-9e84-c63b-8abc-1862b08cf707@amd.com>
In-Reply-To: <1586c31f-9e84-c63b-8abc-1862b08cf707@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Jan 2022 10:00:14 -0500
Message-ID: <CADnq5_OwmDh_TDkGJLBYKbOcLWeXvreYSu-OY+E7w+uqYYG+Kw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: don't do resets on APUs which don't support it
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "for 3.8" <stable@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 13, 2022 at 1:56 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
> Hi Alex,
>
> What about something like this?
>
> bool amdgpu_device_reset_on_suspend(struct amdgpu_device *adev)
> {
>          if (adev->in_s0ix || adev->gmc.xgmi.num_physical_nodes > 1)
>                  return false;
>
>          switch (amdgpu_asic_reset_method(adev)) {
>          case AMD_RESET_METHOD_BACO:
>          case AMD_RESET_METHOD_MODE1:
>          case AMD_RESET_METHOD_MODE2:

This should also work on AMD_RESET_METHOD_LEGACY, at least for dGPUs.
I think the current approach is probably better since I don't think
GPU resets work reliably on these chips anyway (it's not enabled by
default on them gor hangs), so better to just not do it as it may make
the problem worse.

Alex


>                  return true;
>          }
>
>          return false;
> }
>
> Thanks,
> Lijo
>
> On 1/13/2022 9:31 AM, Alex Deucher wrote:
> > It can cause a hang.  This is normally not enabled for GPU
> > hangs on these asics, but was recently enabled for handling
> > aborted suspends.  This causes hangs on some platforms
> > on suspend.
> >
> > Fixes: daf8de0874ab5b ("drm/amdgpu: always reset the asic in suspend (v2)")
> > Cc: stable@vger.kernel.org
> > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1858
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/cik.c | 4 ++++
> >   drivers/gpu/drm/amd/amdgpu/vi.c  | 4 ++++
> >   2 files changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
> > index 54f28c075f21..f10ce740a29c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> > @@ -1428,6 +1428,10 @@ static int cik_asic_reset(struct amdgpu_device *adev)
> >   {
> >       int r;
> >
> > +     /* APUs don't have full asic reset */
> > +     if (adev->flags & AMD_IS_APU)
> > +             return 0;
> > +
> >       if (cik_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
> >               dev_info(adev->dev, "BACO reset\n");
> >               r = amdgpu_dpm_baco_reset(adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> > index fe9a7cc8d9eb..6645ebbd2696 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> > @@ -956,6 +956,10 @@ static int vi_asic_reset(struct amdgpu_device *adev)
> >   {
> >       int r;
> >
> > +     /* APUs don't have full asic reset */
> > +     if (adev->flags & AMD_IS_APU)
> > +             return 0;
> > +
> >       if (vi_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
> >               dev_info(adev->dev, "BACO reset\n");
> >               r = amdgpu_dpm_baco_reset(adev);
> >
