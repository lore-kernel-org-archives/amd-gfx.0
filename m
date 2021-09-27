Return-Path: <SRS0=K0ja=OR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17AEC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 20:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1D96103B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 20:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD1D96103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A51C6E043;
	Mon, 27 Sep 2021 20:50:11 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 896E16E043
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 20:50:10 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id u22so27289542oie.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 13:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rWV8Hk15h0KgEMfXJjt3aFNWBOE9qS+GJ1vuXVEGxIg=;
 b=qPhpF85KRX+wnRoyR4nykylzubrGfQjuCx92SYcvaC51GFfYDuPBARuPfUW44KU1TN
 cEHvVmVaH/t6N4K1CaZpEuWefA/lm2EaJAcno07FplhBjVry5FKVsCG9g9KqSlg+1TYL
 GTfV6uD+6SsnfdWzZ9Yo4WSAlGDpeiRl5sZcu6aa48rkt3IwnW4D2/wa3Pz5Kao4W+Mb
 djKlbNdt5Eos3HghTuu1ZEonHry9SrS4GpKVfrdbe26I1quF5Hm1GRy+AVWpIzQzJLs0
 frvartEKuT/IWuJmYgz1RCqikLbglbbEVx/Cbd4klKgSqqQyeyY20+Ro06pIdRGAjkPK
 xfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rWV8Hk15h0KgEMfXJjt3aFNWBOE9qS+GJ1vuXVEGxIg=;
 b=A+P5stMsrfiMzN3llBloBA8nNwEzMnB8X20vSA6TgE4tajz1wSUzp5GTYyoCmwY2Ot
 syqp2yymVoPHVlp8JF7F3jB51UPGEcXvsxTcZq3d07lI6Vw9gBfnFDUACc6fmg7SuEel
 1Dsv00u86mdV34rzTX+s69xQTeTg1IYaMYPM6Qnxh8f5wFCQOqU3b0/+ES0BUBimKobh
 4Kiyxdyh3/AY4RNC2+Em1FZBf2B4BwOsEIiV8oKYJ1ariNHleqT/dph+dgwxTawks4mJ
 YBEZHat6W484Pc18ECZB733oscf3oxZWnChvibJNi1ohisF9jxertOYtBIePdFTXFj7W
 3PHQ==
X-Gm-Message-State: AOAM5308RjnAfwKj7neOvyBl5UjnrGcQqDNOROO0V4YuVCV7PjyUL4K7
 u4CNcAuWGHJzb1oqFE0RcmF4WXUh0kXCnNUk+dc=
X-Google-Smtp-Source: ABdhPJyVRZr2PcsqxdeWcpVe50H8nafql6YlAPYFNyeoTZwg6BhVqOPUhFb+qb8nU+nI4HTj6ZC8f1pONjmriIku3RE=
X-Received: by 2002:aca:706:: with SMTP id 6mr819879oih.5.1632775809806; Mon,
 27 Sep 2021 13:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <CH0PR12MB5201597F1A8806EA0456548D9EA79@CH0PR12MB5201.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5201597F1A8806EA0456548D9EA79@CH0PR12MB5201.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Sep 2021 16:49:58 -0400
Message-ID: <CADnq5_PoDA1C72AwVBDibA947=U0ojWho7bQXk6VJvnB2jmhyg@mail.gmail.com>
Subject: Re: [PATCH 02/02] drm/amd/display: add cyan_skillfish display support
To: "Liu, Zhan" <Zhan.Liu@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Charlene" <Charlene.Liu@amd.com>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Lei, Jun" <Jun.Lei@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 27, 2021 at 4:43 PM Liu, Zhan <Zhan.Liu@amd.com> wrote:
>
> [Public]
>
> [Why]
> add display related cyan_skillfish files in.
>
> makefile controlled by CONFIG_DRM_AMD_DC_DCN201 flag.
>
> Signed-off-by: Charlene Liu <charlene.liu@amd.com>
> Signed-off-by: Zhan Liu <zhan.liu@amd.com>
> Reviewed-by: Charlene Liu <charlene.liu@amd.com>
> Acked-by: Jun Lei <jun.lei@amd.com>
> ---
<snip>

> @@ -1457,34 +1460,33 @@
>  #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
>         adev->dm.crc_rd_wrk = amdgpu_dm_crtc_secure_display_create_work();
>  #endif
> -       if (dc_enable_dmub_notifications(adev->dm.dc)) {
> -               init_completion(&adev->dm.dmub_aux_transfer_done);
> -               adev->dm.dmub_notify = kzalloc(sizeof(struct dmub_notification), GFP_KERNEL);
> -               if (!adev->dm.dmub_notify) {
> -                       DRM_INFO("amdgpu: fail to allocate adev->dm.dmub_notify");
> -                       goto error;
> -               }
>
> -               adev->dm.delayed_hpd_wq = create_singlethread_workqueue("amdgpu_dm_hpd_wq");
> -               if (!adev->dm.delayed_hpd_wq) {
> -                       DRM_ERROR("amdgpu: failed to create hpd offload workqueue.\n");
> -                       goto error;
> -               }
> -
> -               amdgpu_dm_outbox_init(adev);
> -#if defined(CONFIG_DRM_AMD_DC_DCN)
> -               if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_AUX_REPLY,
> -                       dmub_aux_setconfig_callback, false)) {
> -                       DRM_ERROR("amdgpu: fail to register dmub aux callback");
> -                       goto error;
> -               }
> -               if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD, dmub_hpd_callback, true)) {
> -                       DRM_ERROR("amdgpu: fail to register dmub hpd callback");
> -                       goto error;
> -               }
> -#endif
> +       init_completion(&adev->dm.dmub_aux_transfer_done);
> +       adev->dm.dmub_notify = kzalloc(sizeof(struct dmub_notification), GFP_KERNEL);
> +       if (!adev->dm.dmub_notify) {
> +               DRM_INFO("amdgpu: fail to allocate adev->dm.dmub_notify");
> +               goto error;
>         }
>
> +       adev->dm.delayed_hpd_wq = create_singlethread_workqueue("amdgpu_dm_hpd_wq");
> +       if (!adev->dm.delayed_hpd_wq) {
> +               DRM_ERROR("amdgpu: failed to create hpd offload workqueue.\n");
> +               goto error;
> +       }
> +
> +       amdgpu_dm_outbox_init(adev);
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +       if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_AUX_REPLY,
> +               dmub_aux_setconfig_callback, false)) {
> +               DRM_ERROR("amdgpu: fail to register dmub aux callback");
> +               goto error;
> +       }
> +       if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD, dmub_hpd_callback, true)) {
> +               DRM_ERROR("amdgpu: fail to register dmub hpd callback");
> +               goto error;
> +       }
> +#endif
> +

This change above looks unrelated.  Please double check this is correct.

Alex
