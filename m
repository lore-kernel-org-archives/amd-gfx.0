Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85DCC48BD1
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 15:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F7B8613BF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 15:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7B8613BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D39F89F27;
	Wed,  9 Jun 2021 15:03:46 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC57B89FA9
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 15:03:44 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id i94so20828369wri.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Jun 2021 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=NhWMTI3K3PvSyT4NX7+k9YdckpneaIXEDt7tMcMwDfc=;
 b=CUnfqPaSTOC4qTLr1T+8SHq/dQ5EswOC7eRbj66eMP8gV9oDaPfsI20KBYIaclnOBa
 bS6EznDT1K5skEB4NXJ3bldYrYdJHhTTd6LTDACBY4IK9izJ4Kv8Kq2koJBBfnYnfvsC
 LLTga4raXNj6JOxYdMe4oEyq3WNqDeO+JoxHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NhWMTI3K3PvSyT4NX7+k9YdckpneaIXEDt7tMcMwDfc=;
 b=hvfUtIWLtkjwgRxgdY1jSXJRa+DqcCnrrhPns8HxIrxG19Eu26+SAEYbVWJLLdCuUx
 44LdgieFrDFsUfWBLY7C5f0JNw6tJyWPG79RA5D+FJOypDga57g+uC4GPYzzCksFBVw/
 PQkPpW8/Enccp75JJ/u671m/7eWyXU+/r3wCypf0z9BBM4KKZIBi9t+8l95QAj+wbEL8
 S78hj0w1DA4TFGSJB5udCXAoLt4qw9vrFagrM952UUOv5qIOs+JIPvy3IEcT1pu6rEbR
 k23AegQ9pSasjQDMUfFiK2N8danrVBF80TuceFlbH4kVXBxWpAU6IC5zYAuhdmmbdDGg
 xU/Q==
X-Gm-Message-State: AOAM5312+v59Oh7DGv3bStjUJmywJjwrA8HiCMXO2vKu25ukHQMKxvf8
 ChQuQ+WhYTCfik6LCcre6egC7w==
X-Google-Smtp-Source: ABdhPJyoGh4/10EMowah85We+jCaIYLAki3i8bo9vvnJEmzrzQ6xVOSuoyOCsu99TuT3F3lSHURXsA==
X-Received: by 2002:a5d:61d0:: with SMTP id q16mr239612wrv.175.1623251023568; 
 Wed, 09 Jun 2021 08:03:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id u2sm219793wrn.38.2021.06.09.08.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jun 2021 08:03:42 -0700 (PDT)
Date: Wed, 9 Jun 2021 17:03:40 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 0/4] drm: add per-connector hotplug events
Message-ID: <YMDYTNXAE+EeB/TI@phenom.ffwll.local>
References: <H6LOTVFhdBPSi5N5zQIYRvkif2VhbZgfDIyWTvdSrY@cp3-web-051.plabs.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <H6LOTVFhdBPSi5N5zQIYRvkif2VhbZgfDIyWTvdSrY@cp3-web-051.plabs.ch>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
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
Cc: pekka.paalanen@collabora.com, michel@daenzer.net,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, alexander.deucher@amd.com, daniel@fooishbar.org,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 09, 2021 at 10:39:03AM +0000, Simon Ser wrote:
> When a uevent only updates a single connector, add a CONNECTOR property
> to the uevent. This allows user-space to ignore other connectors when
> handling the uevent. This is purely an optimization, drivers can still
> send a uevent without the CONNECTOR property.
> 
> The CONNECTOR property is already set when sending HDCP property update
> uevents, see drm_sysfs_connector_status_event.
> 
> This has been tested with a wlroots patch [1].
> 
> amdgpu has been updated to use these new fine-grained uevents.

That's a bit thin for motivating roll-out ... Also my idea was that with
the per-connector epoch counter we could make this happen for anyone using
the probe helpers.

I also thought that the dp hotplug code was a bit more unified by now to
not need the duplication across all drivers. But there's only three for
that.

Ofc drivers that hand-roll their hpd code need to be adjusted, but I've
hoped that with the epoch counter we could just make the current hotplug
event code dtrt thing here automatically maybe?

Consistent kms interface across drivers is good, and I think we should
aim for that.
-Daniel

> 
> [1]: https://github.com/swaywm/wlroots/pull/2959
> 
> Simon Ser (4):
>   drm/sysfs: introduce drm_sysfs_connector_hotplug_event
>   drm/probe-helper: add drm_kms_helper_connector_hotplug_event
>   drm/connector: use drm_sysfs_connector_hotplug_event
>   amdgpu: use drm_kms_helper_connector_hotplug_event
> 
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 +++---
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  4 +--
>  drivers/gpu/drm/drm_connector.c               |  2 +-
>  drivers/gpu/drm/drm_probe_helper.c            | 20 +++++++++++++++
>  drivers/gpu/drm/drm_sysfs.c                   | 25 +++++++++++++++++++
>  include/drm/drm_probe_helper.h                |  1 +
>  include/drm/drm_sysfs.h                       |  1 +
>  7 files changed, 54 insertions(+), 7 deletions(-)
> 
> -- 
> 2.31.1
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
