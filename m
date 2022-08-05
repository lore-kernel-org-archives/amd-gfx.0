Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2478FC00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 21:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E4E5B9871;
	Fri,  5 Aug 2022 21:30:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C9F4BA0DE
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 21:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659734272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RZNlrEXt8H3ovW/I1Y4O4JfffQjM6ZL4QQdyq55TVvI=;
 b=cvSjVkFGxjiSMixSzROHcZKCRXY61XezV55im2ONZZi9jHkrq4mubx3INpQyq3O+tC842z
 XeDXrH1j/Bs/WPgVQfDM3UzSoXYrP1WkIRrYZED0FQicTtyYcH+Kr+XrutAlVQj82NdWbO
 4zIKAGimtg7DO9j+7djkwN1GphOnAVY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-JPOaiw_SOK2YyAfH8AXp7w-1; Fri, 05 Aug 2022 17:17:49 -0400
X-MC-Unique: JPOaiw_SOK2YyAfH8AXp7w-1
Received: by mail-qt1-f198.google.com with SMTP id
 t20-20020ac865d4000000b00342ce56573cso1265292qto.21
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Aug 2022 14:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:organization
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc;
 bh=RZNlrEXt8H3ovW/I1Y4O4JfffQjM6ZL4QQdyq55TVvI=;
 b=Ei8UW2n45R4lDVpLP+bB4W2zBkv6SChi3cQ50k2/jMg5sMXDWPDGEvzbV1wyFC0miz
 mn5RXu0QrSg2pHG38Cs+MJjUqZSQ4Gcs6xs9liDFZw1OZQw/jrCxvtWBkBV8f/5HqEBx
 eyHTJTCuNwHRwpSIb0aPWFXwR6bncO4J1IGsOVR55+96sqZa5YmWmqb76eu4o5yECkiE
 J2yCIazAUBiaKf1fp5ehtqknFD1YkeVNFjJ1yOtUH6hCNEwalc69Z6SEaKlZPlXDXRT0
 kKvXa4/KJ7r8XfqCB7H7YjwyGCMwZIRGHEH4CReYWv8yNFBlVsKVM3R50shZqisxSgn3
 6J6A==
X-Gm-Message-State: ACgBeo3sNiZoQtzOWxMSJ6TlFl9vFevwjYjnaD2heRP4vbaJUQrRLc2I
 UPMe+s0F1TwG019Fa+/MCOU6spSRlhWE1WwHRoVKInn7gPeZt6meRQ5QMIcuH1PzkiEslNpyhEx
 Z2Eu9u43DLXbPrP7iEO+sdahVbw==
X-Received: by 2002:a37:b483:0:b0:6b5:8688:5299 with SMTP id
 d125-20020a37b483000000b006b586885299mr6636106qkf.147.1659734269044; 
 Fri, 05 Aug 2022 14:17:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7pmL6DY3sVN5gCS02n3AEyH096euzmB9SRpV1Pn7JxBN+0iCPYIk1jwjNp9v201FEnnIEpPw==
X-Received: by 2002:a37:b483:0:b0:6b5:8688:5299 with SMTP id
 d125-20020a37b483000000b006b586885299mr6636063qkf.147.1659734268786; 
 Fri, 05 Aug 2022 14:17:48 -0700 (PDT)
Received: from [192.168.8.138] (pool-100-0-245-4.bstnma.fios.verizon.net.
 [100.0.245.4]) by smtp.gmail.com with ESMTPSA id
 d3-20020a05620a158300b006b5e3ca6400sm3439923qkk.103.2022.08.05.14.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Aug 2022 14:17:48 -0700 (PDT)
Message-ID: <8db8a726d1aac25b3590497db9cbdcc3fe161227.camel@redhat.com>
Subject: Re: [PATCH v2 1/3] drm/dp_mst: add passthrough_aux to struct
 drm_dp_mst_port
From: Lyude Paul <lyude@redhat.com>
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, linux-kernel@vger.kernel.org
Date: Fri, 05 Aug 2022 17:17:46 -0400
In-Reply-To: <20220805211317.176672-1-hamza.mahfooz@amd.com>
References: <20220805211317.176672-1-hamza.mahfooz@amd.com>
Organization: Red Hat Inc.
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
Cc: Ian Chen <ian.chen@amd.com>, David Airlie <airlied@linux.ie>,
 Imre Deak <imre.deak@intel.com>, dri-devel@lists.freedesktop.org,
 Imran Khan <imran.f.khan@oracle.com>,
 Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
 Kees Cook <keescook@chromium.org>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>, amd-gfx@lists.freedesktop.org,
 Leo Li <sunpeng.li@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jani Nikula <jani.nikula@intel.com>, hersenxs.wu@amd.com,
 Mikita Lipski <mikita.lipski@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 David Zhang <dingchen.zhang@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Roman Li <Roman.Li@amd.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Claudio Suarez <cssk@net-c.es>, Thomas Zimmermann <tzimmermann@suse.de>,
 Wayne Lin <Wayne.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Colin Ian King <colin.king@intel.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

lgtm!

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Fri, 2022-08-05 at 17:13 -0400, Hamza Mahfooz wrote:
> Currently, there is no way to identify if DSC pass-through can be
> enabled and what aux DSC pass-through requests ought to be sent to. So,
> add a variable to struct drm_dp_mst_port that keeps track of the
> aforementioned information.
> 
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
> v2: define DP_DSC_PASSTHROUGH_IS_SUPPORTED
> ---
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
>  include/drm/display/drm_dp.h                  | 1 +
>  include/drm/display/drm_dp_mst_helper.h       | 3 +++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 67b3b9697da7..71915afd9892 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -5921,8 +5921,10 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
>  		/* Enpoint decompression with DP-to-DP peer device */
>  		if ((endpoint_dsc & DP_DSC_DECOMPRESSION_IS_SUPPORTED) &&
>  		    (endpoint_fec & DP_FEC_CAPABLE) &&
> -		    (upstream_dsc & 0x2) /* DSC passthrough */)
> +		    (upstream_dsc & DP_DSC_PASSTHROUGH_IS_SUPPORTED)) {
> +			port->passthrough_aux = &immediate_upstream_port->aux;
>  			return &port->aux;
> +		}
>  
>  		/* Virtual DPCD decompression with DP-to-DP peer device */
>  		return &immediate_upstream_port->aux;
> diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
> index 9e3aff7e68bb..4d0abe4c7ea9 100644
> --- a/include/drm/display/drm_dp.h
> +++ b/include/drm/display/drm_dp.h
> @@ -239,6 +239,7 @@
>  
>  #define DP_DSC_SUPPORT                      0x060   /* DP 1.4 */
>  # define DP_DSC_DECOMPRESSION_IS_SUPPORTED  (1 << 0)
> +# define DP_DSC_PASSTHROUGH_IS_SUPPORTED    (1 << 1)
>  
>  #define DP_DSC_REV                          0x061
>  # define DP_DSC_MAJOR_MASK                  (0xf << 0)
> diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
> index 10adec068b7f..4a39c95f8afd 100644
> --- a/include/drm/display/drm_dp_mst_helper.h
> +++ b/include/drm/display/drm_dp_mst_helper.h
> @@ -86,6 +86,8 @@ struct drm_dp_vcpi {
>   * @next: link to next port on this branch device
>   * @aux: i2c aux transport to talk to device connected to this port, protected
>   * by &drm_dp_mst_topology_mgr.base.lock.
> + * @passthrough_aux: parent aux to which DSC pass-through requests should be
> + * sent, only set if DSC pass-through is possible.
>   * @parent: branch device parent of this port
>   * @vcpi: Virtual Channel Payload info for this port.
>   * @connector: DRM connector this port is connected to. Protected by
> @@ -140,6 +142,7 @@ struct drm_dp_mst_port {
>  	 */
>  	struct drm_dp_mst_branch *mstb;
>  	struct drm_dp_aux aux; /* i2c bus for this port? */
> +	struct drm_dp_aux *passthrough_aux;
>  	struct drm_dp_mst_branch *parent;
>  
>  	struct drm_dp_vcpi vcpi;

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

