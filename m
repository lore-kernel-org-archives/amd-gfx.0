Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A19C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 10:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A20B61159
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 10:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A20B61159
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BF656EA83;
	Thu,  8 Apr 2021 10:49:56 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 591366EA82
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 10:49:55 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id x15so1632809wrq.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Apr 2021 03:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=67+MEKdvuuMmCuXManwso7qCBU9d61GDUt3D3nSdJRI=;
 b=eZ9xAYZzhlN3bvWf644DlpRvCzmAZPi0nNpynvkef1+Qle1fiXDPl9fTbhK0wREdJh
 /8wyYg6JWjy+pE65hERPmb4qHPkSD79TuanL9t2j4dnhCK0OAPYA13niDKuRLReM+M3W
 rfU94T6nxv/HNjaJx5P3LatYYl/ftLIThBx6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=67+MEKdvuuMmCuXManwso7qCBU9d61GDUt3D3nSdJRI=;
 b=Mr7vdN/Pr5/RxJN1RoS6ECcVGrje2RpOic0xOpSt3bvVVoHxyes2jRyOOCqaLnM3ty
 KCeMqIH5rWJf3Ij2Qz6LGjTpPRYewltplWL/MX9oQtM85Fi5R0mfj0+DHkrjELzAsn9N
 WEd2mfnSLTvSvSjf6Bi5dIu3A0bpVM8zAbg44naZJ/+fg132OO5TgccTH2S7+E6u4L/D
 A4PhnFn5TwuZvnCeczVuxOaAYotTzdz0rl9F2TVEk+txTrlY3grb7dCVQSvVcbsGRp/d
 qQ2FTqkW861a2Ysacqvzu8CAFTSMpBhY50a0CL7DHnAXA1/+c3przSqnk1pKPZdrI5bX
 4WOA==
X-Gm-Message-State: AOAM531NMcki9j1Uc62vODgzkxNEZTA0ypAc75gxRH3UPVcGaC9rmPne
 J6fMimeyT5Ws7ZdcnSkR8eBVYw==
X-Google-Smtp-Source: ABdhPJx5Dx4A60v8D/m0vrvrUtVGA0fYNamrAGx3037txALHjxNqc+Py46j1tCroPoMc10toF/BU8w==
X-Received: by 2002:adf:c10a:: with SMTP id r10mr10792914wre.40.1617878994006; 
 Thu, 08 Apr 2021 03:49:54 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id v3sm13108164wmj.25.2021.04.08.03.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Apr 2021 03:49:53 -0700 (PDT)
Date: Thu, 8 Apr 2021 12:49:51 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH v2 00/20] drm: Use new DRM printk funcs (like
 drm_dbg_*()) in DP helpers
Message-ID: <YG7fz5UmK/SaoY/U@phenom.ffwll.local>
References: <20210326203807.105754-1-lyude@redhat.com>
 <87blaym8by.fsf@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87blaym8by.fsf@intel.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 01, 2021 at 04:40:33PM +0300, Jani Nikula wrote:
> On Fri, 26 Mar 2021, Lyude Paul <lyude@redhat.com> wrote:
> > Since it's been asked quite a few times on some of the various DP
> > related patch series I've submitted to use the new DRM printk helpers,
> > and it technically wasn't really trivial to do this before due to the
> > lack of a consistent way to find a drm_device for an AUX channel, this
> > patch series aims to address this. In this series we:
> >
> > * Clean-up potentially erroneous usages of drm_dp_aux_init() and
> >   drm_dp_aux_register() so that actual AUX registration doesn't happen
> >   until we have an associated DRM device
> > * Clean-up any obvious errors in drivers we find along the way
> > * Add a backpointer to the respective drm_device for an AUX channel in
> >   drm_dp_aux.drm_dev, and hook it up in every driver with an AUX channel
> >   across the tree
> > * Add a new ratelimited print helper we'll need for converting the DP
> >   helpers over to using the new DRM printk helpers
> > * Fix any inconsistencies with logging in drm_dp_helper.c so we always
> >   have the aux channel name printed
> > * Prepare the various DP helpers so they can find the correct drm_device
> >   to use for logging
> > * And finally, convert all of the DP helpers over to using drm_dbg_*()
> >   and drm_err().
> >
> > Series-wide changes in v2:
> > * Address most checkpatch issues ('most' as in all except for one line
> >   going two chars over 100 in "drm/dp_mst: Pass drm_dp_mst_topology_mgr
> >   to drm_dp_get_vc_payload_bw()" as this was the style in use
> >   previously, and 2 chars over the limit looks nicer then trying to
> >   line-wrap this
> > * Don't rewrap comments
> 
> For anything touching i915, and for merging via whichever tree or branch
> seems best,
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> 
> That said, gut feeling says there will be conflicts before latest
> drm-misc-next and drm-intel-next have been merged to drm-next, and
> drm-next has been backmerged to drm-misc-next and drm-intel-next.
> 
> It just might be a good idea to wait for those (as well as other driver
> feature pulls) to settle, do a topic branch with a common ancestor
> between drm-next and drm-misc-next, apply there, merge the topic branch
> to drm-misc-next, and let all drivers merge the topic branch as
> needed. Due to the timing, otherwise we might have to carry the
> conflicts for quite a while.

I think Dave caught up on pulls to drm-next, so after a backmerge of that
to drm-misc-next I think should be all fine to apply directly, no need for
topic branch.
-Daniel

> 
> BR,
> Jani.
> 
> 
> >
> > Lyude Paul (20):
> >   drm/dp: Fixup kernel docs for struct drm_dp_aux
> >   drm/tegra: Don't register DP AUX channels before connectors
> >   drm/bridge/cdns-mhdp8546: Register DP aux channel with userspace
> >   drm/nouveau/kms/nv50-: Move AUX adapter reg to connector late
> >     register/early unregister
> >   drm/dp: Add backpointer to drm_device in drm_dp_aux
> >   drm/dp: Clarify DP AUX registration time
> >   drm/print: Fixup DRM_DEBUG_KMS_RATELIMITED()
> >   drm/dp: Pass drm_dp_aux to drm_dp_link_train_clock_recovery_delay()
> >   drm/dp: Pass drm_dp_aux to drm_dp*_link_train_channel_eq_delay()
> >   drm/dp: Always print aux channel name in logs
> >   drm/dp_dual_mode: Pass drm_device to drm_dp_dual_mode_detect()
> >   drm/dp_dual_mode: Pass drm_device to
> >     drm_dp_dual_mode_set_tmds_output()
> >   drm/dp_dual_mode: Pass drm_device to drm_dp_dual_mode_max_tmds_clock()
> >   drm/dp_dual_mode: Pass drm_device to
> >     drm_dp_dual_mode_get_tmds_output()
> >   drm/dp_dual_mode: Pass drm_device to drm_lspcon_(get|set)_mode()
> >   drm/dp_mst: Pass drm_dp_mst_topology_mgr to drm_dp_get_vc_payload_bw()
> >   drm/dp: Convert drm_dp_helper.c to using drm_err/drm_dbg_*()
> >   drm/dp_dual_mode: Convert drm_dp_dual_mode_helper.c to using
> >     drm_err/drm_dbg_kms()
> >   drm/dp_mst: Drop DRM_ERROR() on kzalloc() fail in
> >     drm_dp_mst_handle_up_req()
> >   drm/dp_mst: Convert drm_dp_mst_topology.c to drm_err()/drm_dbg*()
> >
> >  drivers/gpu/drm/amd/amdgpu/atombios_dp.c      |   5 +-
> >  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   1 +
> >  .../drm/bridge/analogix/analogix-anx6345.c    |   1 +
> >  .../drm/bridge/analogix/analogix-anx78xx.c    |   1 +
> >  .../drm/bridge/analogix/analogix_dp_core.c    |   1 +
> >  .../drm/bridge/cadence/cdns-mhdp8546-core.c   |  12 +-
> >  drivers/gpu/drm/bridge/tc358767.c             |   1 +
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c         |   1 +
> >  drivers/gpu/drm/drm_dp_aux_dev.c              |   6 +
> >  drivers/gpu/drm/drm_dp_dual_mode_helper.c     |  68 ++--
> >  drivers/gpu/drm/drm_dp_helper.c               | 181 +++++----
> >  drivers/gpu/drm/drm_dp_mst_topology.c         | 381 +++++++++---------
> >  drivers/gpu/drm/i915/display/intel_dp_aux.c   |   1 +
> >  .../drm/i915/display/intel_dp_link_training.c |   6 +-
> >  drivers/gpu/drm/i915/display/intel_dp_mst.c   |   3 +-
> >  drivers/gpu/drm/i915/display/intel_hdmi.c     |   7 +-
> >  drivers/gpu/drm/i915/display/intel_lspcon.c   |  17 +-
> >  drivers/gpu/drm/msm/dp/dp_ctrl.c              |   6 +-
> >  drivers/gpu/drm/msm/edp/edp.h                 |   3 +-
> >  drivers/gpu/drm/msm/edp/edp_aux.c             |   5 +-
> >  drivers/gpu/drm/msm/edp/edp_ctrl.c            |   8 +-
> >  drivers/gpu/drm/nouveau/nouveau_connector.c   |  27 +-
> >  drivers/gpu/drm/radeon/atombios_dp.c          |   5 +-
> >  drivers/gpu/drm/tegra/dpaux.c                 |  12 +-
> >  drivers/gpu/drm/xlnx/zynqmp_dp.c              |   5 +-
> >  include/drm/drm_dp_dual_mode_helper.h         |  14 +-
> >  include/drm/drm_dp_helper.h                   |  61 +--
> >  include/drm/drm_dp_mst_helper.h               |   3 +-
> >  include/drm/drm_print.h                       |  20 +-
> >  29 files changed, 478 insertions(+), 384 deletions(-)
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
