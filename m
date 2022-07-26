Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636E5C00140
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 15:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A098F2A38A;
	Tue, 26 Jul 2022 15:21:16 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D7418A9CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 15:21:13 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id os14so26822930ejb.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nxE9dsdGfDUY/VfyIGG78mRxftlTU10K9gu1mEdo23Y=;
 b=ckMsRWr7YlkkzqeotkXcQtA7HHUMtrEG1XOKqcn3ixg+LTElRxlGNOh1TJ4Vqmusjp
 FaWwwzi5motga55a6BO6798OiIcBw3oGhqyt7okLN+Pv0nbRo07z29z+CEWNQjzBpa7C
 LgUkYc8+5P0mQMPa5VrBbVExWIeXWxQY/mzw6ozznpkk17vbZdn423yRV8JsE2G14V3L
 4C6gbJO3u+GZoOijmGrnok1TVVaYGpk9pnsTKqrXiUkPg32ziMCBnI2LM3+9B2aYqYBx
 bQ/RC2pCEv5iCyL/y1cKm1PsNy5UFg1RsWxL2EhmJfmiSeyGMIWSgAEFjqBk+vVziVr2
 pJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nxE9dsdGfDUY/VfyIGG78mRxftlTU10K9gu1mEdo23Y=;
 b=xLjBEiSGnGSt3Kcdr991HcL3NBJsDPN3RN3W0VCtfRMk/sgDb3PBwNeRCzUrX7AuWB
 oC0PF6kbtvUZZZCxRAdYgACjMDaPpywLylRhkSr/1GtI3uh6uRSia2GAgl359pnlMwwB
 FWlTO8SFMctI7+3r6thI5JP9vGkjV7tEwBg5sP+8M+5PY4w0WWtvNYCZV1mVelm3SlLZ
 7O+8uxodAoAk9P1xRFozrQUxBxx9A4R3Bois5fTcuBq4SEfvYLvrw6zbjRju8ilw/bGQ
 da/Sn7mc/kvKs5XhlYx0VXaqfGHdvXkeb0BHFGz69ZQIfYV8XHsEBcfBiqFys0vm/OSh
 ibEQ==
X-Gm-Message-State: AJIora/91nlVMMsVn0SuHQ7V+KIWYng8DqpxZ/T9j8xhfjpfPinWthpg
 pa+/gHzDJzbMet4AcK0xjMFk5He7d+cGfTE8TJuuY+jy
X-Google-Smtp-Source: AGRyM1teIkHeseea0bqiju3SGyrsx2ZDIHXTB0cU3k/9ys8L6lcyHdytDzruS9TDDHKYDti27AB0/6kbTwyU9XD+Ego=
X-Received: by 2002:a17:907:a06f:b0:72b:564c:465b with SMTP id
 ia15-20020a170907a06f00b0072b564c465bmr14522939ejc.344.1658848872115; Tue, 26
 Jul 2022 08:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <YuAFEwKmf1uJz0e3@kili>
In-Reply-To: <YuAFEwKmf1uJz0e3@kili>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Jul 2022 11:21:00 -0400
Message-ID: <CADnq5_PJvsOUxXa-eQB8P8y0arN+tjTawm8Cw-R=QPzk60BEEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix signedness bug in
 execute_synaptics_rc_command()
To: Dan Carpenter <dan.carpenter@oracle.com>
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
Cc: Ian Chen <ian.chen@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, kernel-janitors@vger.kernel.org,
 Roman Li <Roman.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, David Airlie <airlied@linux.ie>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Claudio Suarez <cssk@net-c.es>,
 Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, Jul 26, 2022 at 11:16 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The "ret" variable needs to be signed for the error handling to work.
>
> Fixes: 2ca97adccdc9 ("drm/amd/display: Add Synaptics Fifo Reset Workaround")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index d66e3cd64ebd..a0154a5f7183 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -569,7 +569,7 @@ static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
>         unsigned char rc_cmd = 0;
>         unsigned char rc_result = 0xFF;
>         unsigned char i = 0;
> -       uint8_t ret = 0;
> +       int ret;
>
>         if (is_write_cmd) {
>                 // write rc data
> --
> 2.35.1
>
