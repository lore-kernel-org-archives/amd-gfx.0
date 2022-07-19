Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240C2C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 19:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E3BC112E48;
	Tue, 19 Jul 2022 19:52:14 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 894D0112264;
 Tue, 19 Jul 2022 19:52:13 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id fy29so28061126ejc.12;
 Tue, 19 Jul 2022 12:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wcWkViARSNdUyuwzdaEiSCLG/eyyzOrKPQf2VzjXtig=;
 b=QgSES/TyFjtv7+8i9uYc11G3zcakgHhlIrNMk0G5knRRpfikvXxEKpRgp8Xh2Vn526
 gPDp9nxQRvHl7uFV415hUWGn05L3gE27aYTTmIfmWmxE7f9KhYUohWyl/MUADndQRMDS
 U3wIKhaKQQGzt5qDvTHTrKW0j4CQunYGgxVylFiYiP85E6+EOLfe5bRPv2FOf+OtrBdg
 3h2HGNW2CRQdwl621H3R2cAfycvm11roc+0pCzoJKZas1KtuPKgs84qHyjoxezmbZ2mk
 z0neaEnPmX9wbS29KkEpB3ZwEacpDFlm5tUiE2OEo6rmRB5xtDVtQ7IFmFBGZHS4ffjm
 XkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wcWkViARSNdUyuwzdaEiSCLG/eyyzOrKPQf2VzjXtig=;
 b=VhmVqqWrt0i0fidIvzJNHecpHVRMXZrXOZMpjGieh1YAYudK3F6Y3qjHjz9KmOQWy8
 xr5Qx3q6O9Bq+C16FVxzX3nnsVCzhj8TAxVFc/W7bfzaStwBu60+WldE2PnU/z/zO4b0
 iJj8N5qWtW5IeGUy7uzFGookHXutXkbGXzQIdvzAF02DRt14Srhi/diRbKFOC6hTMLrZ
 hsTfXkprjFfyb82O1BTo0ACpFzZBGTtT8FMYPfA+8xtr0SJqJ/mEEHK1C+yFlsg8ey3U
 5ydMKfPx/+VOZrjrgAI+g8XpYQcdOT9M7x1/7SuogvIu5rJZgn3EYCnPT4uPAW7vyXXL
 3GqQ==
X-Gm-Message-State: AJIora8qZiXAic+T7HQn0JI4zQFEN6sGOs/Uv5FYe7xuHUulBmWSBcyE
 y4ZyhAVXQCYJcGng2v7Dmue0BKWCNrSsq0iXGJU=
X-Google-Smtp-Source: AGRyM1vIPPaaNzMOh/Rvxld6XCfgXubOFV0G5wpuC7Z/7ARAOyHNBP7HdKmJGw21KVr0L9W264i8QPBX1kQzmqikP9w=
X-Received: by 2002:a17:907:2888:b0:72b:8f41:1405 with SMTP id
 em8-20020a170907288800b0072b8f411405mr30979322ejc.564.1658260332079; Tue, 19
 Jul 2022 12:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220716042841.40555-1-wangborong@cdjrlc.com>
 <9012daf3-1fbd-524c-55b5-21e9c7c70327@amd.com>
In-Reply-To: <9012daf3-1fbd-524c-55b5-21e9c7c70327@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Jul 2022 15:52:00 -0400
Message-ID: <CADnq5_OwNR=9k=z7Qj6-puoe_40V0ycCGgrxyXM19H7Bu_-rtA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix comment typo
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org, airlied@linux.ie, Xinhui.Pan@amd.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Hawking.Zhang@amd.com, solomon.chiu@amd.com, kai.heng.feng@canonical.com,
 Jason Wang <wangborong@cdjrlc.com>, daniel@ffwll.ch, alexander.deucher@amd.com,
 evan.quan@amd.com, mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Tue, Jul 19, 2022 at 8:34 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 16.07.22 um 06:28 schrieb Jason Wang:
> > The double `to' is duplicated in the comment, remove one.
> >
> > Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index e3d139708160..b45cd7cbbea8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -80,7 +80,7 @@
> >    * - 3.24.0 - Add high priority compute support for gfx9
> >    * - 3.25.0 - Add support for sensor query info (stable pstate sclk/m=
clk).
> >    * - 3.26.0 - GFX9: Process AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE.
> > - * - 3.27.0 - Add new chunk to to AMDGPU_CS to enable BO_LIST creation=
.
> > + * - 3.27.0 - Add new chunk to AMDGPU_CS to enable BO_LIST creation.
> >    * - 3.28.0 - Add AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES
> >    * - 3.29.0 - Add AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID
> >    * - 3.30.0 - Add AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE.
>
