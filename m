Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B69C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 21:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574042465A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 21:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUd9kfQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574042465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1389E6E0D0;
	Wed, 15 Jan 2020 21:58:26 +0000 (UTC)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60EA16E0D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 21:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579125503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLejL7LiXdZwFfbuZh/v/T3dKRMv+nlS9XzC4Fva3QM=;
 b=gUd9kfQ6vg3qztja62YhmVIRbpO3yf1sjIOIqbxflly4yjkR31jttc4GCoPOjWsSJ6ej+q
 pHRaxrBxCTUCew5/d8tK3v1pjSe8CUaBQERxIZs8t6QE3HmGXwegKYFW3A0cyzNubGmMz9
 TsCt+c5rCSHK1p0zN8n49kCXjA15mVo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422--aooeR0EOTOOFlyIBas5mA-1; Wed, 15 Jan 2020 16:58:21 -0500
Received: by mail-qv1-f71.google.com with SMTP id e14so12052430qvr.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 13:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=ZLejL7LiXdZwFfbuZh/v/T3dKRMv+nlS9XzC4Fva3QM=;
 b=jL0DIJSyjndLbH6b2GRUS7HZyh8hiSUW5LbWchT62W9IAYh9xqZjdwvqVru4/76vrv
 bEs6JW++y/b/W2/TuWNTH8UYPwEoxei++x6DurDp2xll0+L+Wl12VOvOy+fgMTWEwC7/
 LRESbnjb2LE6EIUtL8tWgErVfls8Hptd9iS0xdwJ0SjOpq+TUidE+Yk56R9ugoawMKCz
 v71VCxukbNMgpq8EbZbFD1iLoLwUsAF1gO9OMdMlebG9Nd6fx8xNQayR+wtjDMsAfn3y
 P/AuzlCgFJA+y0LpzNDb/sVHOUUwDgrmkNVtafQOmcCc5MRtlV6Qhx37glzLF6OlHesZ
 vBdw==
X-Gm-Message-State: APjAAAUBoZ8t1Dxhw/dsZ9otEKVwmIvNMc/5wW918MjXVDaOcN3eL5oL
 PDRrHGnLJzU+cjCuwBxtcL1h+NSZDPdgH0Mb2WCangy5qj1QBLhaqHh19IDL7YM54UdAnDJ97Ov
 9E1BGoHfPr9G+u4ZYJnZJBbrXVg==
X-Received: by 2002:a05:620a:1467:: with SMTP id
 j7mr27951634qkl.76.1579125500801; 
 Wed, 15 Jan 2020 13:58:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqwopy70yMyr6EfR5FILxijaJwSYUhFKMabnc1Bt78Rctg0wUNCjG/VToWWwam7IdjvvJyJaYQ==
X-Received: by 2002:a05:620a:1467:: with SMTP id
 j7mr27951611qkl.76.1579125500488; 
 Wed, 15 Jan 2020 13:58:20 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
 by smtp.gmail.com with ESMTPSA id b7sm10026851qtj.15.2020.01.15.13.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 13:58:19 -0800 (PST)
Message-ID: <f7b0b918e56aac5ef184ca3f8c2d43f9f202b189.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: Have DP_Tx send one msg at a time
From: Lyude Paul <lyude@redhat.com>
To: Wayne Lin <Wayne.Lin@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Date: Wed, 15 Jan 2020 16:58:18 -0500
In-Reply-To: <20200113093649.11755-1-Wayne.Lin@amd.com>
References: <20200113093649.11755-1-Wayne.Lin@amd.com>
Organization: Red Hat
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31)
MIME-Version: 1.0
X-MC-Unique: -aooeR0EOTOOFlyIBas5mA-1
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
Cc: jerry.zuo@amd.com, harry.wentland@amd.com, Nicholas.Kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Lyude Paul <lyude@redhat.com>

I will push this to drm-misc-fixes in just a moment, thanks!

On Mon, 2020-01-13 at 17:36 +0800, Wayne Lin wrote:
> [Why]
> Noticed this while testing MST with the 4 ports MST hub from
> StarTech.com. Sometimes can't light up monitors normally and get the
> error message as 'sideband msg build failed'.
> 
> Look into aux transactions, found out that source sometimes will send
> out another down request before receiving the down reply of the
> previous down request. On the other hand, in drm_dp_get_one_sb_msg(),
> current code doesn't handle the interleaved replies case. Hence, source
> can't build up message completely and can't light up monitors.
> 
> [How]
> For good compatibility, enforce source to send out one down request at a
> time. Add a flag, is_waiting_for_dwn_reply, to determine if the source
> can send out a down request immediately or not.
> 
> - Check the flag before calling process_single_down_tx_qlock to send out
> a msg
> - Set the flag when successfully send out a down request
> - Clear the flag when successfully build up a down reply
> - Clear the flag when find erros during sending out a down request
> - Clear the flag when find errors during building up a down reply
> - Clear the flag when timeout occurs during waiting for a down reply
> - Use drm_dp_mst_kick_tx() to try to send another down request in queue
> at the end of drm_dp_mst_wait_tx_reply() (attempt to send out messages
> in queue when errors occur)
> 
> Cc: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 14 ++++++++++++--
>  include/drm/drm_dp_mst_helper.h       |  6 ++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 4395d5cc0645..3542af15387a 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1195,6 +1195,8 @@ static int drm_dp_mst_wait_tx_reply(struct
> drm_dp_mst_branch *mstb,
>  		    txmsg->state == DRM_DP_SIDEBAND_TX_SENT) {
>  			mstb->tx_slots[txmsg->seqno] = NULL;
>  		}
> +		mgr->is_waiting_for_dwn_reply = false;
> +
>  	}
>  out:
>  	if (unlikely(ret == -EIO) && drm_debug_enabled(DRM_UT_DP)) {
> @@ -1204,6 +1206,7 @@ static int drm_dp_mst_wait_tx_reply(struct
> drm_dp_mst_branch *mstb,
>  	}
>  	mutex_unlock(&mgr->qlock);
>  
> +	drm_dp_mst_kick_tx(mgr);
>  	return ret;
>  }
>  
> @@ -2770,9 +2773,11 @@ static void process_single_down_tx_qlock(struct
> drm_dp_mst_topology_mgr *mgr)
>  	ret = process_single_tx_qlock(mgr, txmsg, false);
>  	if (ret == 1) {
>  		/* txmsg is sent it should be in the slots now */
> +		mgr->is_waiting_for_dwn_reply = true;
>  		list_del(&txmsg->next);
>  	} else if (ret) {
>  		DRM_DEBUG_KMS("failed to send msg in q %d\n", ret);
> +		mgr->is_waiting_for_dwn_reply = false;
>  		list_del(&txmsg->next);
>  		if (txmsg->seqno != -1)
>  			txmsg->dst->tx_slots[txmsg->seqno] = NULL;
> @@ -2812,7 +2817,8 @@ static void drm_dp_queue_down_tx(struct
> drm_dp_mst_topology_mgr *mgr,
>  		drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
>  	}
>  
> -	if (list_is_singular(&mgr->tx_msg_downq))
> +	if (list_is_singular(&mgr->tx_msg_downq) &&
> +	    !mgr->is_waiting_for_dwn_reply)
>  		process_single_down_tx_qlock(mgr);
>  	mutex_unlock(&mgr->qlock);
>  }
> @@ -3743,6 +3749,7 @@ static int drm_dp_mst_handle_down_rep(struct
> drm_dp_mst_topology_mgr *mgr)
>  	mutex_lock(&mgr->qlock);
>  	txmsg->state = DRM_DP_SIDEBAND_TX_RX;
>  	mstb->tx_slots[slot] = NULL;
> +	mgr->is_waiting_for_dwn_reply = false;
>  	mutex_unlock(&mgr->qlock);
>  
>  	wake_up_all(&mgr->tx_waitq);
> @@ -3752,6 +3759,9 @@ static int drm_dp_mst_handle_down_rep(struct
> drm_dp_mst_topology_mgr *mgr)
>  no_msg:
>  	drm_dp_mst_topology_put_mstb(mstb);
>  clear_down_rep_recv:
> +	mutex_lock(&mgr->qlock);
> +	mgr->is_waiting_for_dwn_reply = false;
> +	mutex_unlock(&mgr->qlock);
>  	memset(&mgr->down_rep_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
>  
>  	return 0;
> @@ -4591,7 +4601,7 @@ static void drm_dp_tx_work(struct work_struct *work)
>  	struct drm_dp_mst_topology_mgr *mgr = container_of(work, struct
> drm_dp_mst_topology_mgr, tx_work);
>  
>  	mutex_lock(&mgr->qlock);
> -	if (!list_empty(&mgr->tx_msg_downq))
> +	if (!list_empty(&mgr->tx_msg_downq) && !mgr->is_waiting_for_dwn_reply)
>  		process_single_down_tx_qlock(mgr);
>  	mutex_unlock(&mgr->qlock);
>  }
> diff --git a/include/drm/drm_dp_mst_helper.h
> b/include/drm/drm_dp_mst_helper.h
> index 942575de86a0..d0b45468135a 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -610,6 +610,12 @@ struct drm_dp_mst_topology_mgr {
>  	 * &drm_dp_sideband_msg_tx.state once they are queued
>  	 */
>  	struct mutex qlock;
> +
> +	/**
> +	 * @is_waiting_for_dwn_reply: indicate whether is waiting for down
> reply
> +	 */
> +	bool is_waiting_for_dwn_reply;
> +
>  	/**
>  	 * @tx_msg_downq: List of pending down replies.
>  	 */
-- 
Cheers,
	Lyude Paul

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
