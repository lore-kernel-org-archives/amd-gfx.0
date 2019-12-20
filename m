Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CB9C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 21:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F7720866
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 21:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbrUkkuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F7720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12EB16ECB8;
	Fri, 20 Dec 2019 21:47:13 +0000 (UTC)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82B816ECB8
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 21:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576878430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C5YX782Zv+g3uFQMicLe3D/pBuqpdZXdmdHZhVTJP8U=;
 b=SbrUkkuqOko5M/Q4cBiUS5h4A6DH41uBAG4AK1eILb8DmH4pez1s6/u/FQGTLoLDWmC7GW
 9k9Rss7WR+f+yLWS2eluH8ITix2wTWFN3MTFsex9LxEjd2pro9pc5Hd2BuxxhmsTWSBLs0
 q9WxalFfJtDjCQFSB/UQwXVImQ6WNlg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-A3jH5QBKOZKx88K5W1Md_Q-1; Fri, 20 Dec 2019 16:46:00 -0500
Received: by mail-qv1-f72.google.com with SMTP id g15so72473qvk.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 13:46:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=C5YX782Zv+g3uFQMicLe3D/pBuqpdZXdmdHZhVTJP8U=;
 b=E5wpY/7wrCFXHLKvjQOMWlhiut67Jr8d3+f6u6igVZPQkRlxuJAwb0cuLLa8GM4Xly
 T2CExSTXRkGkW52MAMgdCo+CbVsPZ+kNH6iCINlwZVV3XcXq/ZvvkBTYvkKr4ve5ZY/y
 Y9quwi/SGZ85Gk7QlDp9+qiJlCTp/Xq11gVK2Alov+9n345X3aSP3kNchnJ70aNC7jQI
 pht92ADhFvDb5hQnXrESEB/dMDVYZBB8ZiWYpDOsWCJ53R5k1BC3NMWaU4rK1QoIax0D
 2qLaIj2UrG0SROu3wHbcywvFFxXAWfkSQvRx9aPj8ZTWHG3TJ+aW9iVyzb9BaXJmdldB
 XLcA==
X-Gm-Message-State: APjAAAWH0Vlp6vcv2SjhFPf8DkqlpqEL+seUYruspHb/69JAj5Ag0Uz2
 PT0rx+nOgJUldCC/45UD/caIQdsu+aiJ59Z+I2ldBAicKJx9UZRXWV6HYFBRTJGtYiJD5Cvrhxw
 F3U9G9nF/v739rxFccl50xVDbhQ==
X-Received: by 2002:ac8:a8b:: with SMTP id d11mr13214629qti.94.1576878360443; 
 Fri, 20 Dec 2019 13:46:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqy3UgmjigMay5mNjhXatasnf6IA6DO5rs8e0SOVqhr4oXw3nWP8czosu+fzS8HQoYVRzdBDQw==
X-Received: by 2002:ac8:a8b:: with SMTP id d11mr13214614qti.94.1576878360247; 
 Fri, 20 Dec 2019 13:46:00 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
 by smtp.gmail.com with ESMTPSA id r80sm3249491qke.134.2019.12.20.13.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 13:45:59 -0800 (PST)
Message-ID: <dbdf8fff79f00aba7e5d54c8faf75af7fddca401.camel@redhat.com>
Subject: Re: [PATCH v9 10/18] drm/dp_mst: Manually overwrite PBN divider for
 calculating timeslots
From: Lyude Paul <lyude@redhat.com>
To: mikita.lipski@amd.com, amd-gfx@lists.freedesktop.org
Date: Fri, 20 Dec 2019 16:45:58 -0500
In-Reply-To: <20191213200854.31545-11-mikita.lipski@amd.com>
References: <20191213200854.31545-1-mikita.lipski@amd.com>
 <20191213200854.31545-11-mikita.lipski@amd.com>
Organization: Red Hat
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-MC-Unique: A3jH5QBKOZKx88K5W1Md_Q-1
X-Mimecast-Spam-Score: 0
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
Cc: Manasi Navare <manasi.d.navare@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Fri, 2019-12-13 at 15:08 -0500, mikita.lipski@amd.com wrote:
> From: Mikita Lipski <mikita.lipski@amd.com>
> 
> [why]
> For DSC case we cannot use topology manager's PBN divider
> variable. The default divider does not take FEC into account.
> Therefore the driver has to calculate its own divider based
> on the link rate and lane count its handling, as it is hw specific.
> 
> [how]
> Pass pbn_div as an argument, which is used if its more than
> zero, otherwise default topology manager's pbn_div will be used.
> 
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Manasi Navare <manasi.d.navare@intel.com>
> Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>  drivers/gpu/drm/drm_dp_mst_topology.c             | 9 +++++++--
>  drivers/gpu/drm/i915/display/intel_dp_mst.c       | 2 +-
>  drivers/gpu/drm/nouveau/dispnv50/disp.c           | 3 ++-
>  include/drm/drm_dp_mst_helper.h                   | 3 ++-
>  5 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9fc03fc1017d..753a79734817 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4972,7 +4972,8 @@ static int dm_encoder_helper_atomic_check(struct
> drm_encoder *encoder,
>  	dm_new_connector_state->vcpi_slots =
> drm_dp_atomic_find_vcpi_slots(state,
>  									   mst
> _mgr,
>  									   mst
> _port,
> -									   dm_
> new_connector_state->pbn);
> +									   dm_
> new_connector_state->pbn,
> +									   0);
>  	if (dm_new_connector_state->vcpi_slots < 0) {
>  		DRM_DEBUG_ATOMIC("failed finding vcpi slots: %d\n",
> (int)dm_new_connector_state->vcpi_slots);
>  		return dm_new_connector_state->vcpi_slots;
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 74bed71f7315..bb0844dfb3d2 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -4020,6 +4020,7 @@ static int drm_dp_init_vcpi(struct
> drm_dp_mst_topology_mgr *mgr,
>   * @mgr: MST topology manager for the port
>   * @port: port to find vcpi slots for
>   * @pbn: bandwidth required for the mode in PBN
> + * @pbn_div: divider for DSC mode that takes FEC into account
>   *
>   * Allocates VCPI slots to @port, replacing any previous VCPI allocations
> it
>   * may have had. Any atomic drivers which support MST must call this
> function
> @@ -4046,7 +4047,8 @@ static int drm_dp_init_vcpi(struct
> drm_dp_mst_topology_mgr *mgr,
>   */
>  int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
>  				  struct drm_dp_mst_topology_mgr *mgr,
> -				  struct drm_dp_mst_port *port, int pbn)
> +				  struct drm_dp_mst_port *port, int pbn,
> +				  int pbn_div)
>  {
>  	struct drm_dp_mst_topology_state *topology_state;
>  	struct drm_dp_vcpi_allocation *pos, *vcpi = NULL;
> @@ -4079,7 +4081,10 @@ int drm_dp_atomic_find_vcpi_slots(struct
> drm_atomic_state *state,
>  	if (!vcpi)
>  		prev_slots = 0;
>  
> -	req_slots = DIV_ROUND_UP(pbn, mgr->pbn_div);
> +	if (pbn_div <= 0)
> +		pbn_div = mgr->pbn_div;
> +
> +	req_slots = DIV_ROUND_UP(pbn, pbn_div);
>  
>  	DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] [MST PORT:%p] VCPI %d -> %d\n",
>  			 port->connector->base.id, port->connector->name,
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> index 92be17711287..a068f54a6793 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -65,7 +65,7 @@ static int intel_dp_mst_compute_link_config(struct
> intel_encoder *encoder,
>  						       false);
>  
>  		slots = drm_dp_atomic_find_vcpi_slots(state, &intel_dp-
> >mst_mgr,
> -						      port, crtc_state->pbn);
> +						      port, crtc_state->pbn,
> 0);
>  		if (slots == -EDEADLK)
>  			return slots;
>  		if (slots >= 0)
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index 1c9e23d5a6fd..edb78966c5b6 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -787,7 +787,8 @@ nv50_msto_atomic_check(struct drm_encoder *encoder,
>  
>  		slots = drm_dp_atomic_find_vcpi_slots(state, &mstm->mgr,
>  						      mstc->port,
> -						      asyh->dp.pbn);
> +						      asyh->dp.pbn,
> +						      0);
>  		if (slots < 0)
>  			return slots;
>  
> diff --git a/include/drm/drm_dp_mst_helper.h
> b/include/drm/drm_dp_mst_helper.h
> index 32e60b9d7098..0f813d6346aa 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -771,7 +771,8 @@ struct drm_dp_mst_topology_state
> *drm_atomic_get_mst_topology_state(struct drm_a
>  int __must_check
>  drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
>  			      struct drm_dp_mst_topology_mgr *mgr,
> -			      struct drm_dp_mst_port *port, int pbn);
> +			      struct drm_dp_mst_port *port, int pbn,
> +			      int pbn_div);
>  int __must_check
>  drm_dp_atomic_release_vcpi_slots(struct drm_atomic_state *state,
>  				 struct drm_dp_mst_topology_mgr *mgr,
-- 
Cheers,
	Lyude Paul

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
