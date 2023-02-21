Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7A0C61DA3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Feb 2023 12:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7B010E7E1;
	Tue, 21 Feb 2023 12:32:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B82410E7E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Feb 2023 12:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676982725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kcBSztIBu8Elzf5YULsmxeT71u7vQPkAxFlgEGJG8QI=;
 b=LjDlzMFXrK/PtHNKp4WzwmqISaD0eXCohpJRqytsJR3MiIgnRPozs/ml7ScuYylRt2gCHi
 kgdAjgMgeycl4C7Kz5P1MWUS9H7oDdjHyIwCyvJxDstFscKefzpOdLXR9WMraGjIxmdrvH
 OmTfTNPgCjs9wGTaRilBfDJvduLU8TE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-146-uo4zUVebNyCDG4EDlgeB0g-1; Tue, 21 Feb 2023 07:31:56 -0500
X-MC-Unique: uo4zUVebNyCDG4EDlgeB0g-1
Received: by mail-wr1-f70.google.com with SMTP id
 o15-20020a05600002cf00b002c54a27803cso786059wry.22
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Feb 2023 04:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kcBSztIBu8Elzf5YULsmxeT71u7vQPkAxFlgEGJG8QI=;
 b=zOwWcIYbluB5wneHyQPdbUrkqe7fiy43t0iSGuelN6SjtFUFEGh/PNag1ggHcX+VF8
 2Zkk2epnyNhl+qB2wkv4URfIigMclRSOPW2dS3iuPacwWVUHo59D6Gd5Fzb6KsVo7xbl
 qHsybPXalsyZ2sjgJJSHal17ljXjOUP2J/VUnmQxLcP3oBS9D5CEpITdJBLyAs2Qj+Es
 acbLJ0pRvyL688q3/we+4ym6VtKBygwob/GuGV+XBzMnS0v78MkYA90kGLNq9RJhBNj2
 MFUnr0EluBR5Rx8szEVzz95nqXbxyS5/sSkoLHB0ynva0GjdFNlbtGmB7suvGr+0Kk5d
 6TQQ==
X-Gm-Message-State: AO0yUKX2xeJkihdauSmseoVHn/5guNcfQLCBPBsQBypKSaDoz5prhzRT
 eKIlxiDguxkL3cQMeldYVfDpuSoWvWAOpmVLbVgDlT4nhwqtTLadASTn5k51ycUnrqQVTG9/JYM
 a5dkCfmMD8CcNxPGPUdNrAOKlIA==
X-Received: by 2002:a05:6000:1141:b0:2c5:a19e:6d16 with SMTP id
 d1-20020a056000114100b002c5a19e6d16mr2636600wrx.61.1676982715781; 
 Tue, 21 Feb 2023 04:31:55 -0800 (PST)
X-Google-Smtp-Source: AK7set//Tf+JISa2y2oGaFX5tzeBEqdv+t7SGO62K3gr9LhE0gq2UicpG1BcV6nfaQQIe6dvwwpV3Q==
X-Received: by 2002:a05:6000:1141:b0:2c5:a19e:6d16 with SMTP id
 d1-20020a056000114100b002c5a19e6d16mr2636581wrx.61.1676982715510; 
 Tue, 21 Feb 2023 04:31:55 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 j8-20020a5d6048000000b002c553e061fdsm6967238wrt.112.2023.02.21.04.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Feb 2023 04:31:55 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org
Subject: Re: [PATCH] drm/fb-helper: Remove drm_fb_helper_unprepare() from
 drm_fb_helper_fini()
In-Reply-To: <95ea4783-8eb4-63e5-767b-3b7feece955d@suse.de>
References: <20230216140620.17699-1-tzimmermann@suse.de>
 <87y1orxqiz.fsf@minerva.mail-host-address-is-not-set>
 <95ea4783-8eb4-63e5-767b-3b7feece955d@suse.de>
Date: Tue, 21 Feb 2023 13:31:54 +0100
Message-ID: <87ttzftd1h.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi
>
> Am 21.02.23 um 11:27 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>> 
>>> Move drm_fb_helper_unprepare() from drm_fb_helper_fini() into the
>>> calling fbdev implementation. Avoids a possible stale mutex with
>>> generic fbdev code.
>>>
>>> As indicated by its name, drm_fb_helper_prepare() prepares struct
>>> drm_fb_helper before setting up the fbdev support with a call to
>>> drm_fb_helper_init(). In legacy fbdev emulation, this happens next
>>> to each other. If successful, drm_fb_helper_fini() later tear down
>>> the fbdev device and also unprepare via drm_fb_helper_unprepare().
>>>
>>> Generic fbdev emulation prepares struct drm_fb_helper immediately
>>> after allocating the instance. It only calls drm_fb_helper_init()
>>> as part of processing a hotplug event. If the hotplug-handling fails,
>>> it runs drm_fb_helper_fini(). This unprepares the fb-helper instance
>>> and the next hotplug event runs on stale data.
>>>
>>> Solve this by moving drm_fb_helper_unprepare() from drm_fb_helper_fini()
>>> into the fbdev implementations. Call it right before freeing the
>>> fb-helper instance.
>>>
>>> Fixes: 4825797c36da ("drm/fb-helper: Introduce drm_fb_helper_unprepare()")
>> 
>> I think this should be Fixes: 032116bbe152 ("drm/fbdev-generic: Minimize
>> client unregistering") instead? Because commit 4825797c36da just added a
>> wrapper function for mutex_destroy(&fb_helper->lock), but it was commit
>> 032116bbe152 that made drm_fbdev_cleanup() to call that helper function.
>
> Good point. After looking through the recent fbdev commits, I'll use 
> commit 643231b28380 ("drm/fbdev-generic: Minimize hotplug error 
> handling") for the tag. This is the one that added the call to 
> drm_fb_helper_fini() to the client's hotplug handler. And _fini() 
> currently does the _unprepare(), when it shouldn't.
>

Ah, much better indeed.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

