Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB21C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 21:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27C891139DC;
	Tue, 17 May 2022 21:50:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AD261139DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 21:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652824203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HRKvH9KEBatDJJuPRgKX+VhUTZYSocPHrPJWbNphZo0=;
 b=Jr2Jy4uiIxqB9N8MjJDepfopFp3xrucancYwmET7u7RaWj4JJEYhMXpFd+q9t6FtJKdlps
 8B440mDojQgnNMOO+p+ojeYX4oOEE+Rr1Z4BUCZ7dNArXUOZ9oERHVYgt5txfhOyEyvGoQ
 hY4R367lyIb4Z0TXhOC5rpYG33Rq3XQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-IrJSIGYbN_qmAKlNLCaaEw-1; Tue, 17 May 2022 17:50:02 -0400
X-MC-Unique: IrJSIGYbN_qmAKlNLCaaEw-1
Received: by mail-qk1-f198.google.com with SMTP id
 o13-20020a05620a0d4d00b0069f47054e58so159923qkl.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 14:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=HRKvH9KEBatDJJuPRgKX+VhUTZYSocPHrPJWbNphZo0=;
 b=0Jlr82bxwduRrPFpvY4DXBpAjQsBm0IIhJVDUQYDJYrXonS0r0rS0YyUQoOCJpQqqH
 fvBnTrNxaTisw82cFx///VICP8tLUsYyTdsRRcc8ed3NzotacV2xKfSKPmhrDN/XSSih
 jTQXVxmSLt6WIei5QGZ0L0z70mBcF6Jr1f/ViAVE0ouoHYwoyxbQ0yMP3K/E228X16Tx
 P/+XE8SuvOamJfrwd2h/RZR2hJMk+U+4+UL1F8gchvjhYIV8df+WNlbcBlxd2Wo0XoFv
 AVr/1FAWpfTdzyxoqMnpCSSvsnjKTFGcG83r/AIK07IKksrdhajkyfPZUyedDe3NGmiU
 JsKA==
X-Gm-Message-State: AOAM5312tT+LqrHtgLVKHpVZdlokhN07kyybfrazVg3LlOO2+ZOc/Im8
 qIu7Ur54n8F+dyzu4rUFNEUpKLFvbqzJ19ZL84yakumQciVBCV0BX2vURjxx7BppeBMm23jFiUq
 rRFtgYcffVwe6A+JnU5ZU6nobbw==
X-Received: by 2002:a05:622a:353:b0:2f3:d23f:f703 with SMTP id
 r19-20020a05622a035300b002f3d23ff703mr21787841qtw.623.1652824201415; 
 Tue, 17 May 2022 14:50:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJRJWXoR7tJJkS+OXCKFWHJ25Yiw575K76ExcAuJKS3da7azvAgNJMozA/eslorLYlMDp+8Q==
X-Received: by 2002:a05:622a:353:b0:2f3:d23f:f703 with SMTP id
 r19-20020a05622a035300b002f3d23ff703mr21787789qtw.623.1652824200292; 
 Tue, 17 May 2022 14:50:00 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net.
 [71.184.137.158]) by smtp.gmail.com with ESMTPSA id
 e7-20020ac81307000000b002f3dc9ebb4bsm54845qtj.65.2022.05.17.14.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 May 2022 14:49:59 -0700 (PDT)
Message-ID: <3030ea8dc4ebba24eada69a743b74996b9accd60.camel@redhat.com>
Subject: Re: [PATCH 0/3] Fix issues when unplung monitor under mst scenario
From: Lyude Paul <lyude@redhat.com>
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Date: Tue, 17 May 2022 17:49:58 -0400
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

I will try to take a look at this during this week btw

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

