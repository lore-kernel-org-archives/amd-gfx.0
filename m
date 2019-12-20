Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6062FC43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 17:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39A8A206CB
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 17:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guMYoqEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A8A206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0987A6E134;
	Fri, 20 Dec 2019 17:31:09 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B66A6E134
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 17:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576863067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KiiVtA64ZzOD09ZN5phv+ksxlbwnWqM72ngiuQsVVe8=;
 b=guMYoqEeexxV1dOkRjI6hiCVUuraMKCd+dHPgNOot3mh1tB/+FeAvsl1cQpAJ0vxvJ2zLX
 Jii3CBq9yuaUiswLZ4lJ63nRBNhfWRgBnyTskqx41PwgdfAADMQVlTOU0k1cjW0JHV9R+X
 k+ZaXZgA3CD5SckiopmWoqj9eLgepRk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-tXSTdOUSNdavKEPeSLhvCw-1; Fri, 20 Dec 2019 12:31:02 -0500
Received: by mail-qv1-f69.google.com with SMTP id l1so6311815qvu.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 09:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=KiiVtA64ZzOD09ZN5phv+ksxlbwnWqM72ngiuQsVVe8=;
 b=UPb0sXUwEZHGPRk5ePw32HKPvK5xpyRHk7la9u81nn1qBWhRuCQdP62+ht4GynEI8t
 ooctOAWzPod0ovMh/3HWMxbSJLqV+3pJ6YpAUztev5SFS/CgTejyvxr9W5WmNqa9X7Lw
 FoHli+1rLBld5oXTKKflurMeJGSioAsh43MOSVWCHxSBnqDujjDyqsFf/gf9xuDlu0Qt
 a1zTbvDj36ZVdDxaiOtg76xTqrjz3qy+a4eMGBGN+99dRNdE9O4sQS3MzGZ+Fx/gLxAJ
 qzpCXUq3FZMndm2/2OJzk8OnnupAh04b1DFXZSSM7vjPnn/tk9o9nBKVC03+7M/gb7po
 l5JA==
X-Gm-Message-State: APjAAAUTQNOiHYd/BGqVvvyeXVLeXnFtFlC2v2mJ8NXT2laXY9q3hxpv
 3gC9Ki3m+Gh8O/9vyzX9gSlKNS3ngZhs5mCXFI4evQJJJzTB4Yhq3xA7UfdB+XJz7YdFwup4gpe
 0PxKQtKhgxsFgYlq2snGUIW4lfQ==
X-Received: by 2002:a05:6214:1090:: with SMTP id
 o16mr13518240qvr.105.1576863062005; 
 Fri, 20 Dec 2019 09:31:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6QwQKl2gKERz10vX0sGJVk3xwnLIOPGwkEraifPfUPEGy6/h4yzOx4CTtJcnzfTtzRsU2yQ==
X-Received: by 2002:a05:6214:1090:: with SMTP id
 o16mr13518211qvr.105.1576863061753; 
 Fri, 20 Dec 2019 09:31:01 -0800 (PST)
Received: from malachite.lyude.net
 (static-173-76-190-23.bstnma.ftas.verizon.net. [173.76.190.23])
 by smtp.gmail.com with ESMTPSA id b7sm3269979qtj.15.2019.12.20.09.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 09:31:01 -0800 (PST)
Message-ID: <a0345eca33c0a41ef83ba50bec4d13a9a6a29edb.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: clear time slots for ports invalid
From: Lyude Paul <lyude@redhat.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Date: Fri, 20 Dec 2019 12:30:59 -0500
In-Reply-To: <DM6PR12MB41379C431DBB59A0C0A4C910FC2D0@DM6PR12MB4137.namprd12.prod.outlook.com>
References: <20191206083937.9411-1-Wayne.Lin@amd.com>
 <DM6PR12MB41379C431DBB59A0C0A4C910FC2D0@DM6PR12MB4137.namprd12.prod.outlook.com>
Organization: Red Hat
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-MC-Unique: tXSTdOUSNdavKEPeSLhvCw-1
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
Cc: "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi! I will try to review this patch today, must have gotten lost in the noise

On Fri, 2019-12-20 at 01:46 +0000, Lin, Wayne wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> Pinged.
> Hi, can someone help to review please.
> 
> Thanks a lot.
> 
> Regards,
> Wayne
> 
> ________________________________________
> From: Wayne Lin <Wayne.Lin@amd.com>
> Sent: Friday, December 6, 2019 16:39
> To: dri-devel@lists.freedesktop.org; amd-gfx@lists.freedesktop.org
> Cc: Kazlauskas, Nicholas; Wentland, Harry; Zuo, Jerry; lyude@redhat.com; 
> stable@vger.kernel.org; Lin, Wayne
> Subject: [PATCH] drm/dp_mst: clear time slots for ports invalid
> 
> [Why]
> When change the connection status in a MST topology, mst device
> which detect the event will send out CONNECTION_STATUS_NOTIFY messgae.
> 
> e.g. src-mst-mst-sst => src-mst (unplug) mst-sst
> 
> Currently, under the above case of unplugging device, ports which have
> been allocated payloads and are no longer in the topology still occupy
> time slots and recorded in proposed_vcpi[] of topology manager.
> 
> If we don't clean up the proposed_vcpi[], when code flow goes to try to
> update payload table by calling drm_dp_update_payload_part1(), we will
> fail at checking port validation due to there are ports with proposed
> time slots but no longer in the mst topology. As the result of that, we
> will also stop updating the DPCD payload table of down stream port.
> 
> [How]
> While handling the CONNECTION_STATUS_NOTIFY message, add a detection to
> see if the event indicates that a device is unplugged to an output port.
> If the detection is true, then iterrate over all proposed_vcpi[] to
> see whether a port of the proposed_vcpi[] is still in the topology or
> not. If the port is invalid, set its num_slots to 0.
> 
> Thereafter, when try to update payload table by calling
> drm_dp_update_payload_part1(), we can successfully update the DPCD
> payload table of down stream port and clear the proposed_vcpi[] to NULL.
> 
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 5306c47dc820..2e236b6275c4 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -2318,7 +2318,7 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch
> *mstb,
>  {
>         struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
>         struct drm_dp_mst_port *port;
> -       int old_ddps, ret;
> +       int old_ddps, old_input, ret, i;
>         u8 new_pdt;
>         bool dowork = false, create_connector = false;
> 
> @@ -2349,6 +2349,7 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch
> *mstb,
>         }
> 
>         old_ddps = port->ddps;
> +       old_input = port->input;
>         port->input = conn_stat->input_port;
>         port->mcs = conn_stat->message_capability_status;
>         port->ldps = conn_stat->legacy_device_plug_status;
> @@ -2373,6 +2374,27 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch
> *mstb,
>                 dowork = false;
>         }
> 
> +       if (!old_input && old_ddps != port->ddps && !port->ddps) {
> +               for (i = 0; i < mgr->max_payloads; i++) {
> +                       struct drm_dp_vcpi *vcpi = mgr->proposed_vcpis[i];
> +                       struct drm_dp_mst_port *port_validated;
> +
> +                       if (vcpi) {
> +                               port_validated =
> +                                       container_of(vcpi, struct
> drm_dp_mst_port, vcpi);
> +                               port_validated =
> +                                       drm_dp_mst_topology_get_port_validat
> ed(mgr, port_validated);
> +                               if (!port_validated) {
> +                                       mutex_lock(&mgr->payload_lock);
> +                                       vcpi->num_slots = 0;
> +                                       mutex_unlock(&mgr->payload_lock);
> +                               } else {
> +                                       drm_dp_mst_topology_put_port(port_va
> lidated);
> +                               }
> +                       }
> +               }
> +       }
> +
>         if (port->connector)
>                 drm_modeset_unlock(&mgr->base.lock);
>         else if (create_connector)
> --
> 2.17.1
> 
-- 
Cheers,
	Lyude Paul

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
