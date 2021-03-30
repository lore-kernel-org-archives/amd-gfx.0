Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEB0C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA817619BD
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA817619BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 830076E8F0;
	Tue, 30 Mar 2021 13:24:48 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE5316E8AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 11:06:12 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id e14so5977052plj.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 04:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DskNrmJoVlSyLul5rgVfAIyNWef+AlzHHvEOelMyti0=;
 b=slVa6+xoi3BdoEmDA0VoVWkO8tuL/lXxZmvTYGJg7wGz1ScYaIRXrCfzU8ZDfT3ZM0
 ggp/ygaQGKJGhFRA5QW7f9U3EfpbXSMsXTYWx7p1nwBA8Ekc49nwzUS6jMME7z7gTQer
 pMAXay4GGKQ56ztl5Jx1BBEy9AL93xGYlIGeODixUv/aqu+Qb+EPVu6yig6as9K82Ctm
 Pc3Lb0tpzXuQ5QcHBiBeRUxF6g9QB2ZdsgL/8/oYQe2iFwggUqNONxGYgSPBasb/yQF+
 y9q6PFdQulOmXT/wl+s9SdMhbJRohu5/5mZE85W2ZPZCmG6ZrLW1OBmlPFp3zsxQu37T
 whJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DskNrmJoVlSyLul5rgVfAIyNWef+AlzHHvEOelMyti0=;
 b=bDf8Ad4OVxIQXAzsfYbTqg5L+i/ye+zAnu4WlQ8ttungfXcJyD1i2OHepah9+3Oq4j
 wXUAvI/Gli4R35rgGuz2KQQESazmDS7t1PwX0IL+1FBoS4ZkXhdXK1SAkT25FOTAVzfr
 XabzcjQICrApSdzzuf7JIhewICyKVZyNDnrm8R0cluHyOlFTIKbvln9YaP4xeIQemNPn
 S/9Y6d1d0RTwVdcly9B8j06PTX+MyncUSKJEAajKTGJWZveuCeS+scvWfR0B6jv8J3O3
 yWr2dc6TuwC2tKStzSfS2VjcQ/6EYxGX6L9z65tFB7BmWvFZx0HiLwDLbxVO+FlK2nhZ
 tkWg==
X-Gm-Message-State: AOAM531IQyS0mL5XC7V/U/SpIjjwNjlqS/NmyLoEvcGqpCgq40cynb5n
 3IEURjuNfIyQp7/c/pFq+Tw8SZ80cpbHbWi6F+kakg==
X-Google-Smtp-Source: ABdhPJxfOmfQB9fzlhBcQ+PyXZQEzxSloSUbr4UVE6rrRVfcHfZyWFno3tNgnDlI6rBdjWZE6AMTaSFq8fb0+pHpeFc=
X-Received: by 2002:a17:902:f68a:b029:e5:b17f:9154 with SMTP id
 l10-20020a170902f68ab02900e5b17f9154mr32285479plg.28.1617102372210; Tue, 30
 Mar 2021 04:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210326203807.105754-1-lyude@redhat.com>
 <20210326203807.105754-20-lyude@redhat.com>
In-Reply-To: <20210326203807.105754-20-lyude@redhat.com>
From: Robert Foss <robert.foss@linaro.org>
Date: Tue, 30 Mar 2021 13:06:01 +0200
Message-ID: <CAG3jFytEUCqh6U6oG8hKqk-2bmr+qtcwg1gbWRQp_KxXTxfVsw@mail.gmail.com>
Subject: Re: [PATCH v2 19/20] drm/dp_mst: Drop DRM_ERROR() on kzalloc() fail
 in drm_dp_mst_handle_up_req()
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

This patch looks good to me.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Fri, 26 Mar 2021 at 21:40, Lyude Paul <lyude@redhat.com> wrote:
>
> Checkpatch was complaining about this - there's no need for us to print
> errors when kzalloc() fails, as kzalloc() will already WARN for us. So,
> let's fix that before converting things to make checkpatch happy.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Robert Foss <robert.foss@linaro.org>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index ec2285595c33..74c420f5f204 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -4113,10 +4113,9 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
>                 return 0;
>
>         up_req = kzalloc(sizeof(*up_req), GFP_KERNEL);
> -       if (!up_req) {
> -               DRM_ERROR("Not enough memory to process MST up req\n");
> +       if (!up_req)
>                 return -ENOMEM;
> -       }
> +
>         INIT_LIST_HEAD(&up_req->next);
>
>         drm_dp_sideband_parse_req(&mgr->up_req_recv, &up_req->msg);
> --
> 2.30.2
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
