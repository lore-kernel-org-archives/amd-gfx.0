Return-Path: <SRS0=Av9g=OK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CE8C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Sep 2021 06:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE52A60F9D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Sep 2021 06:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE52A60F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9965F6E3D0;
	Mon, 20 Sep 2021 06:52:21 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B7A36E3CE;
 Mon, 20 Sep 2021 06:52:20 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id d6so26854640wrc.11;
 Sun, 19 Sep 2021 23:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=2LIh1KerY3JtJ0aYbNEJlxHLuCRBIdLof8Xl0ZpKiPI=;
 b=kaEKHwosDLN3kcYJMgo8w9LBdhj6kNN+b6ZNyT72unz1+KvEGsi7WnAAPPLUR/sMnB
 htSOLBoEuZxMmmcgzR4OCXbcHiN+kp7OsRC/p79QsRLa+SZNTlxZ08wOJhFAG1uvw5WG
 pzJxHHzyrF1diy1uosxpeTvjFKMXOzkXNP+VcvK3/JJmPLrnpu7hANhNrXtgu4t3B0PP
 brvRDAlbKIdRGFWd40COtCB9QE5+RE8U5tQ3TuDJ8ai12QLIaSLzS8mScd4wEzRGD5vE
 3oIzofQk7NAcCswTExg9+8vNRmETyLc+yHQOwe584r6WHLogThob+hcO4KFB/55PU5Mv
 MxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2LIh1KerY3JtJ0aYbNEJlxHLuCRBIdLof8Xl0ZpKiPI=;
 b=vSySQakS8Ouxe8xjQMnc1QvGqKS3hrXQcb6qmN0Yd2epWYQpCWFfXMtYaYiK++oRj7
 inkmnJi6631hEuc2l4joBa2QZXrhnkD3XSwY/akCd3D75DxHiBjFmtjJCZo7+9/wUUB3
 m5MW9pwz6geW/GmXNfILqGIGa4PpPmwk8xkLZzh7gSXeKU1QXM5vV8w3u+75WlPU/Z6+
 PJk4KXPuXajPG0AW/EA9SJ1XvEn++bWPSCL3MdY3BaF3AN0wMm48kEO5SJy3PtjuYBPL
 4MxM0OXC8j6bGkyd4HP7nDn0ahmjtv2pZOlj3A4/qKJi4SZKSk5OrNMJ9qPYpUixnzwL
 DIgg==
X-Gm-Message-State: AOAM533qjri7IeEnRB0NmgvFpPfJo5pE6ERjp5crlbLyc+N1bYrcGI39
 n7qJ96EIGnSIhU/EFWsEcWs=
X-Google-Smtp-Source: ABdhPJxSAYZK4Nee162yByqKMxPYT0pwmeQgdS1+EbA3eVSlZfksRWlfDldDFZqcIBvzMQcWWCZpZw==
X-Received: by 2002:a5d:6a8b:: with SMTP id s11mr26766512wru.127.1632120738533; 
 Sun, 19 Sep 2021 23:52:18 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id a72sm18849095wme.5.2021.09.19.23.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Sep 2021 23:52:18 -0700 (PDT)
Subject: Re: [PATCH 2/2] MAINTAINERS: add Andrey as the DRM GPU scheduler
 maintainer
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, airlied@gmail.com,
 daniel.vetter@ffwll.ch
References: <20210917161540.822282-1-alexander.deucher@amd.com>
 <20210917161540.822282-2-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8a914580-fc19-7c43-21b9-51543c956a53@gmail.com>
Date: Mon, 20 Sep 2021 08:52:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210917161540.822282-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.09.21 um 18:15 schrieb Alex Deucher:
> Now that the scheduler is being used by more and more
> drivers, we need someone to maintain it.  Andrey has
> stepped up to maintain the scheduler.
>
> Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Cc: airlied@gmail.com
> Cc: daniel.vetter@ffwll.ch
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   MAINTAINERS | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 379092f34fff..9d567e66a65f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6369,6 +6369,14 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>   F:	drivers/gpu/drm/ttm/
>   F:	include/drm/ttm/
>   
> +DRM GPU SCHEDULER
> +M:	Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> +L:	dri-devel@lists.freedesktop.org
> +S:	Maintained
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +F:	drivers/gpu/drm/scheduler/
> +F:	include/drm/gpu_scheduler.h
> +
>   DSBR100 USB FM RADIO DRIVER
>   M:	Alexey Klimov <klimov.linux@gmail.com>
>   L:	linux-media@vger.kernel.org

