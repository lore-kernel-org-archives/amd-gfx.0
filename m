Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32C8C33CA9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 17:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6459222C2
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 17:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUFV4VyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6459222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49F186E120;
	Mon, 13 Jan 2020 17:59:15 +0000 (UTC)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 252136E106
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 17:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578938353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nb8j+GFd6k9OPTxXI1Xxas/o4T4IzIui0F6wvqvv42s=;
 b=XUFV4VyTc1P1ZVKbwqqtvMXJPje59vg4k3Mysc6482z/d/8GegH71iwhrQo0P4VXXtvZi/
 9AFjGRSd1rX+UYXqGAEtjOMChbzSSSJmMYORUbJZJ0cbwWjDrz0PVL288RF0z62g4CkSoB
 68AlEdiTcp4NbHSD5zQn9+s2c8Egu+A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-m0QnipBxPRCk8g-o0njscA-1; Mon, 13 Jan 2020 12:59:08 -0500
Received: by mail-qk1-f197.google.com with SMTP id a6so6408045qkl.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 09:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=Nb8j+GFd6k9OPTxXI1Xxas/o4T4IzIui0F6wvqvv42s=;
 b=jwICCLYgvfA0FjVw2bxeM9tULb3FejhIAg8KFfETCSHYZgLfRxqoSJsd3p2avP1GUh
 01qvhGAG0bc6R4FTTAFnPHh9fGlHKUHKYYtBUtEwETDJvuoSAx8zuuRInr7+8mA45pyq
 Y4bsG5ukFJwWaTzqE9WkftZlRfK4uFXo+1wHAT85fmrVCcPPiGvOiKpWizzcIvCitVuK
 TcIcNH5VlK61h86YN9pCK7RKmaAGnLpFw6ZGijV7Y7w0uU2qAGD0IckswmWGOYdAZ6pl
 fF9WdyAa9FCS3HaMRLs/pjG+c1PQLBC0YDV6irCsMy8V0hZ4UkafGuu8I0qTC6E5/b0H
 lWzw==
X-Gm-Message-State: APjAAAVly+4DPUCsKSXZ/JjFSHkyeswyUFS4TJG9uI/1O2O0nqDVutLw
 1XIAogKn26F95JmWGhnpc/O4IVnqCCaQ03BN8Chs11tMKo0QLxfX4+WxZ/q9Bf77szHW37twAgw
 LTzmWagSy/eITulDvxLnTBzpoOw==
X-Received: by 2002:a05:620a:133a:: with SMTP id
 p26mr16957299qkj.233.1578938347649; 
 Mon, 13 Jan 2020 09:59:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZAy6Sg/8mBRMyIlzjZh6e3v0bG6ZuAIJ3fEAsCqVuWjZtPRgBJ3cxmnfskVSuKnuswz0viQ==
X-Received: by 2002:a05:620a:133a:: with SMTP id
 p26mr16957278qkj.233.1578938347327; 
 Mon, 13 Jan 2020 09:59:07 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
 by smtp.gmail.com with ESMTPSA id o6sm5250067qkk.53.2020.01.13.09.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 09:59:06 -0800 (PST)
Message-ID: <7e60f25010669799afe5bf77c943244809c744bf.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: Have DP_Tx send one msg at a time
From: Lyude Paul <lyude@redhat.com>
To: Wayne Lin <Wayne.Lin@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Date: Mon, 13 Jan 2020 12:59:05 -0500
In-Reply-To: <20200113093649.11755-1-Wayne.Lin@amd.com>
References: <20200113093649.11755-1-Wayne.Lin@amd.com>
Organization: Red Hat
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-MC-Unique: m0QnipBxPRCk8g-o0njscA-1
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

Hey! Haven't taken a look at this patch yet but just wanted to let you know
I'm going to try to get to most of the stuff you've got pending for me. I came
down with a really nasty cold last week so sorry if you've had any other
patches waiting until now!

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
