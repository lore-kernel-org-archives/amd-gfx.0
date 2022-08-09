Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD936C19F2D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 22:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3C32D0EE5;
	Tue,  9 Aug 2022 22:02:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D695495986
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 22:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660082513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXClH5jdUWIe5M+ib/xHzOhaf9sL3Q8vI0p0DQ3TOBg=;
 b=WK9fWFmwB53DwlLts7hOQLl8LbxTHCs40U0FSr7v1VTk8/QU9E5ggawd+SuZIeK0T16D3w
 bTd0V7HiTA7xTAm35DnBO2Ly1aP32g62M0zvmlrgXs0cDGBP9+Zn1OFdU9+7s1gVSzSu+v
 NINgCJBzlSc7zBq3c2VoyF2crRvTloU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-37-vEJzVEUlOqWQw7Py7hGpbA-1; Tue, 09 Aug 2022 18:01:52 -0400
X-MC-Unique: vEJzVEUlOqWQw7Py7hGpbA-1
Received: by mail-qt1-f200.google.com with SMTP id
 e30-20020ac8011e000000b00342f61e67aeso6054741qtg.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Aug 2022 15:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:organization
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc;
 bh=hXClH5jdUWIe5M+ib/xHzOhaf9sL3Q8vI0p0DQ3TOBg=;
 b=GxF+ydoOTCWZL3ikaqm9WKsHtFjy50PWXeWdkWedcnojVAlv7t50/y2kie4BOqmNb8
 hvShXYZwqZfqub5I5MyNgIAMo01wOowIjsQOEKHlPiGGqrMeaV6bkfrMyO3by4IPcpNq
 rkbWV0cAZoCB1GUayPeAh5K80gY9ehTm/QfIOGw3dnHphFMBk77qtH5zx/HlilSmfBfe
 GBNqYtN/Kf/RkFq+zPEz5kkVD+BQ6tFZUtX6U3fRuHqEZ4YIrmzMN3foYafNPqqTP+AH
 F4RF82a2V6g2NrahkD2f2bq9lrUtVROocwC8TYGqvxSIkn+g36a7UxerNA3J9bRfAY51
 qDnw==
X-Gm-Message-State: ACgBeo0nSUjEYFT+SvdpwV/coAArSzm70U9HYgH2s6bmTho8hFga7ysz
 51pUpQKA7WviUCHl/+fGuuZA9b8b7Wi3EW4sX/0lLiUG5R0H3+4betnt0T/sWqPd7vBbSUZiVbJ
 LAXWZKXCcnneiisoQMWEqIKk7IQ==
X-Received: by 2002:a05:622a:406:b0:343:7ae:4fe9 with SMTP id
 n6-20020a05622a040600b0034307ae4fe9mr4263130qtx.541.1660082511911; 
 Tue, 09 Aug 2022 15:01:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7j97sgEEk3li4n4X8PZTGGsvKpjv63PR41p3SkEOYsJC//AlysS6kFFWEKTw7244zroa4EKg==
X-Received: by 2002:a05:622a:406:b0:343:7ae:4fe9 with SMTP id
 n6-20020a05622a040600b0034307ae4fe9mr4263108qtx.541.1660082511664; 
 Tue, 09 Aug 2022 15:01:51 -0700 (PDT)
Received: from [192.168.8.138] (pool-100-0-245-4.bstnma.fios.verizon.net.
 [100.0.245.4]) by smtp.gmail.com with ESMTPSA id
 u18-20020a37ab12000000b006b945519488sm5268186qke.88.2022.08.09.15.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 15:01:51 -0700 (PDT)
Message-ID: <3690a632acc9d5d83ae8a33dfc8b88db7fe8aebf.camel@redhat.com>
Subject: Re: [PATCH v2 1/3] drm/dp_mst: add passthrough_aux to struct
 drm_dp_mst_port
From: Lyude Paul <lyude@redhat.com>
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, linux-kernel@vger.kernel.org
Date: Tue, 09 Aug 2022 18:01:49 -0400
In-Reply-To: <b6e10f4a-6834-fccb-0cba-0990dda37a76@amd.com>
References: <20220805211317.176672-1-hamza.mahfooz@amd.com>
 <8db8a726d1aac25b3590497db9cbdcc3fe161227.camel@redhat.com>
 <b6e10f4a-6834-fccb-0cba-0990dda37a76@amd.com>
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

Ah yes of course! Probably should have asked when I gave the r-b :). Also,
just so patchwork actually catches it I will say the magic incantation:

Reviewed-by: Lyude Paul <lyude@redhat.com>

Do we want to merge just this patch to drm-misc-next, or do you want to merge
the whole series through there? If you'd rather just merge this through amd's
branch I'm fine with that as well

On Tue, 2022-08-09 at 11:15 -0400, Hamza Mahfooz wrote:
> Hey Lyude,
> 
> On 2022-08-05 17:17, Lyude Paul wrote:
> > lgtm!
> > 
> 
> Any chance you can apply this to drm-misc-next?
> 
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > 
> > On Fri, 2022-08-05 at 17:13 -0400, Hamza Mahfooz wrote:
> > > Currently, there is no way to identify if DSC pass-through can be
> > > enabled and what aux DSC pass-through requests ought to be sent to. So,
> > > add a variable to struct drm_dp_mst_port that keeps track of the
> > > aforementioned information.
> > > 
> > > Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> > > ---
> > > v2: define DP_DSC_PASSTHROUGH_IS_SUPPORTED
> > > ---
> > >   drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
> > >   include/drm/display/drm_dp.h                  | 1 +
> > >   include/drm/display/drm_dp_mst_helper.h       | 3 +++
> > >   3 files changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > index 67b3b9697da7..71915afd9892 100644
> > > --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > @@ -5921,8 +5921,10 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
> > >   		/* Enpoint decompression with DP-to-DP peer device */
> > >   		if ((endpoint_dsc & DP_DSC_DECOMPRESSION_IS_SUPPORTED) &&
> > >   		    (endpoint_fec & DP_FEC_CAPABLE) &&
> > > -		    (upstream_dsc & 0x2) /* DSC passthrough */)
> > > +		    (upstream_dsc & DP_DSC_PASSTHROUGH_IS_SUPPORTED)) {
> > > +			port->passthrough_aux = &immediate_upstream_port->aux;
> > >   			return &port->aux;
> > > +		}
> > >   
> > >   		/* Virtual DPCD decompression with DP-to-DP peer device */
> > >   		return &immediate_upstream_port->aux;
> > > diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
> > > index 9e3aff7e68bb..4d0abe4c7ea9 100644
> > > --- a/include/drm/display/drm_dp.h
> > > +++ b/include/drm/display/drm_dp.h
> > > @@ -239,6 +239,7 @@
> > >   
> > >   #define DP_DSC_SUPPORT                      0x060   /* DP 1.4 */
> > >   # define DP_DSC_DECOMPRESSION_IS_SUPPORTED  (1 << 0)
> > > +# define DP_DSC_PASSTHROUGH_IS_SUPPORTED    (1 << 1)
> > >   
> > >   #define DP_DSC_REV                          0x061
> > >   # define DP_DSC_MAJOR_MASK                  (0xf << 0)
> > > diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
> > > index 10adec068b7f..4a39c95f8afd 100644
> > > --- a/include/drm/display/drm_dp_mst_helper.h
> > > +++ b/include/drm/display/drm_dp_mst_helper.h
> > > @@ -86,6 +86,8 @@ struct drm_dp_vcpi {
> > >    * @next: link to next port on this branch device
> > >    * @aux: i2c aux transport to talk to device connected to this port, protected
> > >    * by &drm_dp_mst_topology_mgr.base.lock.
> > > + * @passthrough_aux: parent aux to which DSC pass-through requests should be
> > > + * sent, only set if DSC pass-through is possible.
> > >    * @parent: branch device parent of this port
> > >    * @vcpi: Virtual Channel Payload info for this port.
> > >    * @connector: DRM connector this port is connected to. Protected by
> > > @@ -140,6 +142,7 @@ struct drm_dp_mst_port {
> > >   	 */
> > >   	struct drm_dp_mst_branch *mstb;
> > >   	struct drm_dp_aux aux; /* i2c bus for this port? */
> > > +	struct drm_dp_aux *passthrough_aux;
> > >   	struct drm_dp_mst_branch *parent;
> > >   
> > >   	struct drm_dp_vcpi vcpi;
> > 
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

