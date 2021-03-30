Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FE8C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8575D61994
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8575D61994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46FB76E8ED;
	Tue, 30 Mar 2021 13:24:41 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AFE06E8B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 11:19:43 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id c204so11944744pfc.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 04:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nEiq5VYqidlia0rfaVKXey2aQI1J0UOeUfwbZ7SzFqw=;
 b=qIay2yJaGw8H+hG15KImlYeu0r6L9MLLcQDEnZF2qFdTW2zSpQ40IXg+/vxlnJQz4o
 TKzi5YqlKrIHttRWaLvFbdM20gKQ/igZVcwm8SFzdsf0/GzVTOyvvDeB6kqpBolWhn33
 iI+TCXiaVJhMe/oW7DCLEON36LzdAAwFwyEShryYOFQyky1isZ0YY5RVfN5W3oiAYvwy
 8+KnWX/nQwEbJaqACWTSuM18VOAT1ks9X9zr7SchWYDgwTLwBD/knap1CJ7Ca9tlGG8b
 sFpNlx44sNZxtyb4faahEv9qJLV1qWz1e1po03itPLigsO5ao0DVK7AqSPfVLMue7R6H
 nwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nEiq5VYqidlia0rfaVKXey2aQI1J0UOeUfwbZ7SzFqw=;
 b=C223pNCL9dTuwZ0gkJgK8UDvAZT3VaZeWif0j06xU2UOkWPwZ6xoeeqdBR5yi81y9X
 I/xzt3AkmEVCk2qjeYpoLQgL/q2cQ39+UZDRhrIW2cb2U/zjFSRvePHTRNHOHzCMaqOH
 TeALt3j468mu1loJSAFXdNbDp6vlXFnPM7autNN0rd1AcQ9moaGP9lVbyU+ZCxX71wiV
 XiHMvSIaAGvTtSfiabFTo79YJhhdZDHO6LYhA7rDTMoj00qdUO2dihEXTxypYmvixva2
 PuABjLis1jxCwopAosF3RE1MKbyH5zf5EBTxhvHoWaMaW/5xLgbFdkTyAMfPf1ATJYE5
 S8Ow==
X-Gm-Message-State: AOAM530H7QJF992MAANQjpDp2CzkA1Y2AQj/HTrYd4h4mqp0SVJe+Roc
 c9S6fy85qno0JcMyEKwMD/5gdPYqNA0P4wRMFxPGNA==
X-Google-Smtp-Source: ABdhPJxq5q/aaT+6jdvgQQdbDwMNlvYfZjAmKD/2J/yR3c6DqBDMvry2T/Awy6EWGZ+THIsQHdyfhPbS801PyKVA3nE=
X-Received: by 2002:a05:6a00:b54:b029:207:2a04:7b05 with SMTP id
 p20-20020a056a000b54b02902072a047b05mr29651828pfo.12.1617103182535; Tue, 30
 Mar 2021 04:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210326203807.105754-1-lyude@redhat.com>
 <20210326203807.105754-21-lyude@redhat.com>
In-Reply-To: <20210326203807.105754-21-lyude@redhat.com>
From: Robert Foss <robert.foss@linaro.org>
Date: Tue, 30 Mar 2021 13:19:31 +0200
Message-ID: <CAG3jFyvEvb=YWopYUmi1bf=fe3ZX7VmtvnnmT5dHcNjLhHvsQg@mail.gmail.com>
Subject: Re: [PATCH v2 20/20] drm/dp_mst: Convert drm_dp_mst_topology.c to
 drm_err()/drm_dbg*()
To: Lyude Paul <lyude@redhat.com>
X-Mailman-Approved-At: Tue, 30 Mar 2021 13:24:40 +0000
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
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Lyude,

This patch looks good, but I have one question below. With it
addressed, feel free to add my r-b.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

>
> -static bool drm_dp_sideband_parse_req(struct drm_dp_sideband_msg_rx *raw,
> +static bool drm_dp_sideband_parse_req(const struct drm_dp_mst_topology_mgr *mgr,
> +                                     struct drm_dp_sideband_msg_rx *raw,
>                                       struct drm_dp_sideband_msg_req_body *msg)
>  {
>         memset(msg, 0, sizeof(*msg));
> @@ -1117,12 +1125,12 @@ static bool drm_dp_sideband_parse_req(struct drm_dp_sideband_msg_rx *raw,
>
>         switch (msg->req_type) {
>         case DP_CONNECTION_STATUS_NOTIFY:
> -               return drm_dp_sideband_parse_connection_status_notify(raw, msg);
> +               return drm_dp_sideband_parse_connection_status_notify(mgr, raw, msg);
>         case DP_RESOURCE_STATUS_NOTIFY:
> -               return drm_dp_sideband_parse_resource_status_notify(raw, msg);
> +               return drm_dp_sideband_parse_resource_status_notify(mgr, raw, msg);
>         default:
> -               DRM_ERROR("Got unknown request 0x%02x (%s)\n", msg->req_type,
> -                         drm_dp_mst_req_type_str(msg->req_type));
> +               drm_err(mgr->dev, "Got unknown request 0x%02x (%s)\n",
> +                       msg->req_type, drm_dp_mst_req_type_str(msg->req_type));
>                 return false;
>         }
>  }
>

.. snip ..

> @@ -4118,12 +4121,12 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
>
>         INIT_LIST_HEAD(&up_req->next);
>
> -       drm_dp_sideband_parse_req(&mgr->up_req_recv, &up_req->msg);
> +       drm_dp_sideband_parse_req(mgr, &mgr->up_req_recv, &up_req->msg);

drm_dp_sideband_parse_req() is only called here, and the function
arguments could probably stand to have `&mgr->up_req_recv` removed
(here and in the func. declaration) since the same data structure is
accessible through the `mgr` pointer inside of
drm_dp_sideband_parse_req(). I guess this is a matter of taste, so
feel free to do what you want with this.

>
>         if (up_req->msg.req_type != DP_CONNECTION_STATUS_NOTIFY &&
>             up_req->msg.req_type != DP_RESOURCE_STATUS_NOTIFY) {
> -               DRM_DEBUG_KMS("Received unknown up req type, ignoring: %x\n",
> -                             up_req->msg.req_type);
> +               drm_dbg_kms(mgr->dev, "Received unknown up req type, ignoring: %x\n",
> +                           up_req->msg.req_type);
>                 kfree(up_req);
>                 goto out;
>         }
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
