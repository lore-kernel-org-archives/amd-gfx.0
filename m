Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4EDC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 19:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC90410E30B;
	Tue, 31 May 2022 19:38:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E673F10E30B
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 19:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654025899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GuWteBN5HMY3nZU4yN7bM0chq/fB+qSkd7IIkAR/Ynw=;
 b=aP5wFkDn3/8jjO8AAgKb8GHz8BLh4VCPblGKjbEKS5E27/14jgDWs2eUxvLVbeQpRteV9t
 8K1zirL27a6u8WTpuB9dgBWwBiSH7qrSYeqomrvlGDQgseBasKqiCS0I8sHpcBIFTWGu55
 9vxKsRhMusUyCAw8QADQP8aWQ4smC88=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-RF4WlcFUNS-8DG76jrX1tw-1; Tue, 31 May 2022 15:38:16 -0400
X-MC-Unique: RF4WlcFUNS-8DG76jrX1tw-1
Received: by mail-qk1-f198.google.com with SMTP id
 j12-20020a37c24c000000b006a375a433bbso11244026qkm.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 12:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=GuWteBN5HMY3nZU4yN7bM0chq/fB+qSkd7IIkAR/Ynw=;
 b=Ab8rr7N4KTPgu5sgk/xvLHH/m2jy/nJI7zPL2n9xdOGBc4xXK/jVV9hht0CaNJqGfD
 ccKr9QID33qdI01ysEsCKc/hZuJ/5PAZgvDb61Y4OF8nbbmhdun7u8Wt3YrXKqFsJQgb
 6+pQn0q+/1Ucqe+ya1NGYVqfzGFCHlorpvVAt/OUnUExhwGIeK/1iI00deIqa69cenxU
 2s6rLsmX2v19DQKNiH+vE+OEPk/gQOKzZwjHxuxHMZelvJVUDYPJuUTXhKIAXdgRZ+fV
 pQXCErXaM7Ld3oipfEg7pUqm/0IXAxWJm134prLK8QDory8gRQdfGDVh3slkR4nw8k4i
 EOmA==
X-Gm-Message-State: AOAM530J2t7Rg6XExpb7jwk0YkIaiTKkqM66d6MVFI8qVC6qzuapSGRD
 g/afDG2x62/+rpBsjJU0bbQrLAHwsjt05H8VJYz7tMfQQBERbPCG4g8hjn5Nk6gqIq/mPZFrE65
 MfOzwAhOprXYqmP6a9dITFJxQqw==
X-Received: by 2002:a05:622a:2:b0:304:b8df:46f9 with SMTP id
 x2-20020a05622a000200b00304b8df46f9mr4992671qtw.620.1654025896261; 
 Tue, 31 May 2022 12:38:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy94ZgOHo+CLhZWC3PBgzIMpoDuBjaR/P6MRYzCZcKRSb65OM68q7oAzEMEIVDTOn7eVVQWMg==
X-Received: by 2002:a05:622a:2:b0:304:b8df:46f9 with SMTP id
 x2-20020a05622a000200b00304b8df46f9mr4992647qtw.620.1654025895997; 
 Tue, 31 May 2022 12:38:15 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net.
 [71.184.137.158]) by smtp.gmail.com with ESMTPSA id
 w21-20020a05620a445500b0069fc13ce209sm11040778qkp.58.2022.05.31.12.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 May 2022 12:38:15 -0700 (PDT)
Message-ID: <a8c85afd8940ae8368e152d72d937d7046f65c8a.camel@redhat.com>
Subject: Re: [PATCH 0/3] Fix issues when unplung monitor under mst scenario
From: Lyude Paul <lyude@redhat.com>
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Date: Tue, 31 May 2022 15:38:14 -0400
In-Reply-To: <20220510095701.57375-1-Wayne.Lin@amd.com>
References: <20220510095701.57375-1-Wayne.Lin@amd.com>
Organization: Red Hat Inc.
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
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
Cc: Rodrigo.Siqueira@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For the whole series:

Acked-by: Lyude Paul <lyude@redhat.com>

This looks a lot better for sure :)

On Tue, 2022-05-10 at 17:56 +0800, Wayne Lin wrote:
> This patch set is trying to resolve issues observed when unplug monitors
> under mst scenario. Revert few commits which cause side effects and seems
> no longer needed. And propose a patch to address the issue discussed
> within the thread:
> https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg396300.html
> 
> ---
> 
> Wayne Lin (3):
>   Revert "drm/amd/display: Add flag to detect dpms force off during HPD"
>   Revert "drm/amd/display: turn DPMS off on connector unplug"
>   drm/amd/display: Release remote dc_sink under mst scenario
> 
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 49 +++----------------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 -
>  .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 16 ++----
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 18 +------
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 39 +++++++++++++--
>  drivers/gpu/drm/amd/display/dc/core/dc.c      | 13 -----
>  drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 -
>  7 files changed, 46 insertions(+), 92 deletions(-)
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

