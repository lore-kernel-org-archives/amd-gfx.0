Return-Path: <SRS0=QHOg=2L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740DBC2D0D2
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Dec 2019 00:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6EF20866
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Dec 2019 00:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYddrydP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6EF20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0D3C6ECD6;
	Sat, 21 Dec 2019 00:11:55 +0000 (UTC)
X-Greylist: delayed 8861 seconds by postgrey-1.36 at gabe;
 Sat, 21 Dec 2019 00:11:53 UTC
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 357C66ECD2
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Dec 2019 00:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576887112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UpvjyHddomTBVlnRy5D6G8OJ5mZnjYRh6mZ8SNVnyW4=;
 b=bYddrydPknaQIsbkxy7H0+SbRkiJXGjDYvRsEtm1HdMbFR/ODT27bCu76DLzGLO+EXPxE9
 RvUxa+bqO19DWPw0OohIILP0ZVcQY8xhCkiPfdlTMMyRYL6+viVgTc8xooDRx7YY5lRWIV
 VNiSqI6kA3A/j31fX5FBZiTwC/4OdVk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-mYMehrzJMf-G6rpWObPltw-1; Fri, 20 Dec 2019 19:11:50 -0500
Received: by mail-qv1-f70.google.com with SMTP id k2so6994015qvu.22
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 16:11:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=UpvjyHddomTBVlnRy5D6G8OJ5mZnjYRh6mZ8SNVnyW4=;
 b=EmE/AeN22e2r35o/kdjMgN+A1GMZqLFjT5SFxULzeA3cqpwfsLF7XL/ph9zd60lzLS
 V6LkRkSe6xatZjw4Vnr2qbuFvwFbUHcyYsKZZ1mmAEOPTNSa99haVlMMxouGeJJk8Wxu
 VJJApo6gKqqgBk8XO4CZVzPxGRsPQlKgUqR7E30lTezZsXlWHClvu+c/G+l+YY9pXPZr
 JqzRU+L7nKGCfkcqjgPafvzv0u9jfcoHCKMKWynZpKtnk50wOogpifYqA/5asc0RE0AV
 5Pw6VFiLJ4gpolj2leZXyyYV4fXMzTjrL4ErZANo1QIYwZhTiydW59yfd3XyM35MQsPD
 WfsA==
X-Gm-Message-State: APjAAAWR2/d+Mf1l4L3fZC+NvRudRwQhniOGzOUS+l52P75IA3PMpWpS
 pEwMWlmTI69EhFrEwNEfPCnJeZqoV8qOY4s2Qg+SEhO0zNYq1CYvlhy4tMKoZU5zGNgNWemYjlN
 5fUMQSLmFWwBl7Oyc1FoMcEDV4Q==
X-Received: by 2002:a05:620a:133a:: with SMTP id
 p26mr15607861qkj.233.1576887110295; 
 Fri, 20 Dec 2019 16:11:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqwJw7kWbDwJzTxH+r2C3U8rbRcclU7cd3GFT2xwOnuXlYRM/9NpWWAyP0v0yC9CMPL8x0a/Cg==
X-Received: by 2002:a05:620a:133a:: with SMTP id
 p26mr15607830qkj.233.1576887109935; 
 Fri, 20 Dec 2019 16:11:49 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
 by smtp.gmail.com with ESMTPSA id d143sm3364778qke.123.2019.12.20.16.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 16:11:49 -0800 (PST)
Message-ID: <589e939efca5209af318645fa6799c423897eea6.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: clear time slots for ports invalid
From: Lyude Paul <lyude@redhat.com>
To: Wayne Lin <Wayne.Lin@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Date: Fri, 20 Dec 2019 19:11:48 -0500
In-Reply-To: <20191206083937.9411-1-Wayne.Lin@amd.com>
References: <20191206083937.9411-1-Wayne.Lin@amd.com>
Organization: Red Hat
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-MC-Unique: mYMehrzJMf-G6rpWObPltw-1
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
Cc: jerry.zuo@amd.com, harry.wentland@amd.com, Nicholas.Kazlauskas@amd.com,
 stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mhh-I think I understand the problem you're trying to solve here but I think
this solution might be a bit overkill. When I did the rework of topology
references for ports, I made it so that we can guarantee memory access to a
port without it needing to be a valid part of the topology. As well, all
parents of the port are guaranteed to be accessible for as long as the child
is. Take a look at:

https://01.org/linuxgraphics/gfx-docs/drm/gpu/drm-kms-helpers.html#refcount-relationships-in-a-topology

It's also worth noting that because of this there's a lot of
get_port_validated()/put_port_validated() calls in the MST helpers that are
now bogus and need to be removed once I get a chance. For new code we should
limit the use of topology references to sections of code where we need a
guarantee that resources on the port/branch (such as a drm connector, dp aux
port, etc.) won't go away for as long as we need to use them.

Do you think we could change this patch so instead of removing it from the
proposed payloads on the CONNECTION_STATUS_NOTIFY, we keep the port's memory
allocation around until it's been removed from the proposed payloads table and
clean it up there on the next payload update?

On Fri, 2019-12-06 at 16:39 +0800, Wayne Lin wrote:
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
>  	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
>  	struct drm_dp_mst_port *port;
> -	int old_ddps, ret;
> +	int old_ddps, old_input, ret, i;
>  	u8 new_pdt;
>  	bool dowork = false, create_connector = false;
>  
> @@ -2349,6 +2349,7 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch
> *mstb,
>  	}
>  
>  	old_ddps = port->ddps;
> +	old_input = port->input;
>  	port->input = conn_stat->input_port;
>  	port->mcs = conn_stat->message_capability_status;
>  	port->ldps = conn_stat->legacy_device_plug_status;
> @@ -2373,6 +2374,27 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch
> *mstb,
>  		dowork = false;
>  	}
>  
> +	if (!old_input && old_ddps != port->ddps && !port->ddps) {
> +		for (i = 0; i < mgr->max_payloads; i++) {
> +			struct drm_dp_vcpi *vcpi = mgr->proposed_vcpis[i];
> +			struct drm_dp_mst_port *port_validated;
> +
> +			if (vcpi) {
> +				port_validated =
> +					container_of(vcpi, struct
> drm_dp_mst_port, vcpi);
> +				port_validated =
> +					drm_dp_mst_topology_get_port_validated
> (mgr, port_validated);
> +				if (!port_validated) {
> +					mutex_lock(&mgr->payload_lock);
> +					vcpi->num_slots = 0;
> +					mutex_unlock(&mgr->payload_lock);
> +				} else {
> +					drm_dp_mst_topology_put_port(port_vali
> dated);
> +				}
> +			}
> +		}
> +	}
> +
>  	if (port->connector)
>  		drm_modeset_unlock(&mgr->base.lock);
>  	else if (create_connector)
-- 
Cheers,
	Lyude Paul

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
