Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC36C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 23:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986A0603E8
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 23:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 986A0603E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 013CB89B30;
	Wed, 27 Oct 2021 23:27:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16D9F89B22
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 23:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635377251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NQ2EX/iGlxfUkLSrXEN+pF97BYMN0m5HzyxRhk6Sil8=;
 b=ZV7zTewLhzW7rGvip9sz3vOU70Fnqgo59JV+Y5iRUNOXrPi2ZgYXHj13zX+ChGtXrXXq+S
 KVNKJ1xyqjoCTu5PU7f1asoQlohxpmyAGXdopodEidyA6Afq/7F1vXIq6E6eXWZhD0Syvs
 6nUFahCI2dJg1fF8jP1sLphaFUETAug=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-CcYIWNwCOACMwlVkG7QzRA-1; Wed, 27 Oct 2021 19:27:28 -0400
X-MC-Unique: CcYIWNwCOACMwlVkG7QzRA-1
Received: by mail-qk1-f197.google.com with SMTP id
 l27-20020a05620a211b00b0045fbe374e2dso2699033qkl.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 16:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=NQ2EX/iGlxfUkLSrXEN+pF97BYMN0m5HzyxRhk6Sil8=;
 b=o/+rzR0IPwtbZglo70AupSPUcSzwlIZHCj9fuNmOuT5DfzxCgSvM+Ex4LatyZmHKCe
 p7dPSBEr7szWtQl8nbMn4qodUTTq5AXAW31+aa87CHxKMOCXjv3Ttn0q5R9dlymdQMYP
 ncJ0blqvtCMmvtUPtTQ77D7yWTDUySp9vmhPPQWdzm3bpUaP7d+MHsN6g/jskilLZBm8
 Tvpt5pVjAxd4ODfkXMXsW1F7C7gDSS/tULSiMg1Zc+hpWAxbnJ0u2rRwJ0aC5PmCpsYd
 4ocqWDEoaiOP5bf8FvRrqj0JqRLXNIVjHZv9xre/rfS4UlsA1JhmTJ+dHEkfI/TVXntX
 YMVA==
X-Gm-Message-State: AOAM532vT3yyu9gC7phJB47J2Ki3VPRyeEHerUahpNOVfFqONpBer/7N
 ia8GOwRC3GRAd726zrW5w6U9erwZCjFvK3dJKj3g2XlvBkwz+6EE2iXYbyS2sq4gePUIJk0tJ0e
 wAuR2xRdQVfOeK8wSn0Y3v+3dhg==
X-Received: by 2002:ac8:7146:: with SMTP id h6mr876683qtp.293.1635377248530;
 Wed, 27 Oct 2021 16:27:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBkyy2RwimWfX7VxkNXauR8I71fABvtV9veMvEdqL9SGevyEryTrEq2bMb7UYbShHKL30RWA==
X-Received: by 2002:ac8:7146:: with SMTP id h6mr876657qtp.293.1635377248307;
 Wed, 27 Oct 2021 16:27:28 -0700 (PDT)
Received: from [192.168.8.138] (pool-96-230-249-157.bstnma.fios.verizon.net.
 [96.230.249.157])
 by smtp.gmail.com with ESMTPSA id z30sm822186qtm.55.2021.10.27.16.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 16:27:27 -0700 (PDT)
Message-ID: <f3c83ab8498ebff3d1f9dc57d0118a72f1411cb1.camel@redhat.com>
Subject: Re: [PATCH] drm/amdgpu/display: fix build when
 CONFIG_DRM_AMD_DC_DCN is not set
From: Lyude Paul <lyude@redhat.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Dave Airlie <airlied@gmail.com>
Date: Wed, 27 Oct 2021 19:27:26 -0400
In-Reply-To: <20211027223914.1776061-1-alexander.deucher@amd.com>
References: <20211027223914.1776061-1-alexander.deucher@amd.com>
Organization: Red Hat
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will add to the topic branch right now

On Wed, 2021-10-27 at 18:39 -0400, Alex Deucher wrote:
> Need to guard some things with CONFIG_DRM_AMD_DC_DCN.
> 
> Fixes: 41724ea273cdda ("drm/amd/display: Add DP 2.0 MST DM Support")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Dave Airlie <airlied@gmail.com>
> ---
> 
> Lyude, can you apply this to topic/amdgpu-dp2.0-mst? or Dave, if it's
> already pulled can you apply this to drm-next?
> 
> Thanks!
> 
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         | 2 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a02ca525610c..3f36dbb2c663 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10723,9 +10723,9 @@ static int amdgpu_dm_atomic_check(struct drm_device
> *dev,
>         struct dm_crtc_state *dm_old_crtc_state;
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>         struct dsc_mst_fairness_vars vars[MAX_PIPES];
> -#endif
>         struct drm_dp_mst_topology_state *mst_state;
>         struct drm_dp_mst_topology_mgr *mgr;
> +#endif
>  
>         trace_amdgpu_dm_atomic_check_begin(state);
>  
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 719cbec4c45e..c200e07d2fb2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -219,7 +219,7 @@ bool dm_helpers_dp_mst_write_payload_allocation_table(
>         struct drm_dp_mst_topology_mgr *mst_mgr;
>         struct drm_dp_mst_port *mst_port;
>         bool ret;
> -       u8 link_encoding_cap;
> +       u8 link_encoding_cap = DP_8b_10b_ENCODING;
>  
>         aconnector = (struct amdgpu_dm_connector *)stream-
> >dm_stream_context;
>         /* Accessing the connector state is required for vcpi_slots
> allocation
> @@ -239,7 +239,9 @@ bool dm_helpers_dp_mst_write_payload_allocation_table(
>  
>         mst_port = aconnector->port;
>  
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>         link_encoding_cap =
> dc_link_dp_mst_decide_link_encoding_format(aconnector->dc_link);
> +#endif
>  
>         if (enable) {
>  

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

