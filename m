Return-Path: <SRS0=XXlo=6X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2A6C28CBC
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2020 13:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C342071C
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2020 13:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQ9LU9NP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C342071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01AAE6E34C;
	Sat,  9 May 2020 13:35:48 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A5846E353
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 May 2020 13:35:46 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id e16so5180163wra.7
 for <amd-gfx@lists.freedesktop.org>; Sat, 09 May 2020 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TYC+RVToqMKv2SfxT8G5JOuCt9k4rDSr4NzPE3lC1nE=;
 b=qQ9LU9NPMjmJEIIH/p05AX++FPYTMlbE1reaA+lOWIMVyTQjZbke9Nh60oQqfC/xP7
 norE4z/eA/RumgW5nX7RyeDTNIQLOIVhInVISuOXbeBjEaihQIxbrPRwzsbwnt7M/0XI
 tDF9hWNZwtlfYvpWr3zG4SKbmCvhi8k+lVq4oW1nNDm3Ev4Ppy7CaGntUykonrasANjG
 MI0+8i8gYcxlpDek8gIPYkh6Z7OIW2MO/a95pblpg9TPSxbOt0Q8X8CGAMbg1LtL3r9K
 HPjrcqgLzLK6JSuFgCxMoHLygsjQ+sXyeLAj5k4ZrnLuJ6by/m4PCpMHkvQBUksBYbAO
 0GBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TYC+RVToqMKv2SfxT8G5JOuCt9k4rDSr4NzPE3lC1nE=;
 b=Vi2J2b7Il4+qJVxZxYJQYl0i6F43mDrYQ6JqdbHgFkwoQ4W3fTbxLJnNjvvu7aSVb3
 NnWIbjX8Oky1vx0qgQ7pYoOtrT+/c5k2SAy9hES3HEA24Jo5r5T6cIh0u/iUwiDZR/v7
 nN/IzjXCPu+GBs+YvKPQpnELEp8/ESpVByw0zOzCOBiqQEFq/kj5LsAxYhCsjNxGIeNo
 Y3/DKvX376+5x08KGizGCgbTl4mLefwt/6n2pS4DH5+0BckVacRz/gtMBwxkTalAbmtO
 WLAw+AISdZXLCvi8+I+bCehun9DOZyk0FqH9ErZLjTMoEVz+dkOQh4y6rsTPaAjedo1t
 Z6Qw==
X-Gm-Message-State: AGi0PuZzMLEe+bgHwldMGM0gQ0VCJ3Vlzy/LlCOqtpk/NfVMRJHJLqCI
 hmJ7I9SGkNcbV2mmY9/HLAvaZ1Vdo1lbsWa1MZLrm8gg
X-Google-Smtp-Source: APiQypJGE6KN9oKNEy+SmIjOS175e+a13ORSkbUh4Uh+X/s0iqCgd1IB75O5IlXqKibyczTXI7XvPuLxXS3WFiIuHgY=
X-Received: by 2002:adf:ee86:: with SMTP id b6mr9019687wro.419.1589031345593; 
 Sat, 09 May 2020 06:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200509054834.21484-1-zhoubb.aaron@gmail.com>
In-Reply-To: <20200509054834.21484-1-zhoubb.aaron@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 9 May 2020 09:35:34 -0400
Message-ID: <CADnq5_Ms1oyxqODE4j_-4+WKwUbE6VthECRgA8cvsYBzMwzs5g@mail.gmail.com>
Subject: Re: [PATCH] drm/admgpu: check HDMI HPD status after ddc probe
To: Binbin Zhou <zhoubb.aaron@gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 zhoubinbin <zhoubinbin@uniontech.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, hristian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, May 9, 2020 at 1:48 AM Binbin Zhou <zhoubb.aaron@gmail.com> wrote:
>
> Now, we check the presence of the EDID to determine if there is a monitor
> present.
>
> DVI-I connectors have both analog and digital encoders and the HPD pin
> is only reliable on the digital part.
>
> But when I pull out the Radeon HD8570's HDMI connector, the HDMI status
> in system is still perform connected.
>
> asd@asd-PC:~$ cat /sys/class/drm/card0-HDMI-A-1/status
> connected
>
> At this moment, if I want to read the EDID by /dev/i2c-X with I2C
> driver, there is no EDID can be read.
>
> Dmesg witha drm.debug=0x6, we can find the following message:
>
> [drm:drm_helper_hpd_irq_event] [CONNECTOR:41:HDMI-A-1] status
> updated from connected to connected
>
> Based on the appearance, I thought to check the HPD status again, because
> the HPD status is perform disconnected, after amdgpu_display_ddc_probe().
> If the amdgpu_display_hpd_sense() return false, I think the HDMI connector
> status is undefined, and just return disconnected simply.
>
> I'm not sure if it happened to other AMD cards.

This is the part I don't understand.  The logic already checks the HPD
status in amdgpu_connector_check_hpd_status_unchanged().  Does it
still report connected at that point?  After that it tires to read the
EDID in amdgpu_display_ddc_probe().  If the monitor is disconnected,
there should be no EDID so dret should be false.  We should try and
figure out why the first HPD check reports connected and the EDID
probe returns true.

Alex

>
> Signed-off-by: Binbin Zhou <zhoubb.aaron@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> index f355d9a752d2..ee657db9a228 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -973,7 +973,7 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
>         const struct drm_encoder_helper_funcs *encoder_funcs;
>         int r;
>         enum drm_connector_status ret = connector_status_disconnected;
> -       bool dret = false, broken_edid = false;
> +       bool dret = false, broken_edid = false, undefined_flag = false;
>
>         if (!drm_kms_helper_is_poll_worker()) {
>                 r = pm_runtime_get_sync(connector->dev->dev);
> @@ -988,7 +988,12 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
>
>         if (amdgpu_connector->ddc_bus)
>                 dret = amdgpu_display_ddc_probe(amdgpu_connector, false);
> -       if (dret) {
> +
> +       /* Check the HDMI HPD pin status again */
> +       if (!amdgpu_display_hpd_sense(adev, amdgpu_connector->hpd.hpd))
> +               undefined_flag = true;
> +
> +       if (dret && !undefined_flag) {
>                 amdgpu_connector->detected_by_load = false;
>                 amdgpu_connector_free_edid(connector);
>                 amdgpu_connector_get_edid(connector);
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
