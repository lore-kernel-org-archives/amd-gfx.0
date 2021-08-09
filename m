Return-Path: <SRS0=nf5+=NA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFD9C43214
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 18:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30DAF61004
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 18:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30DAF61004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5850589C82;
	Mon,  9 Aug 2021 18:27:54 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82AD78924F;
 Mon,  9 Aug 2021 18:27:52 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id o20so24824355oiw.12;
 Mon, 09 Aug 2021 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4mNkfoQ58OXkFxY5lXT0JLBnZKMBlmPjenNWxHTzG5U=;
 b=HDi1+VGiQq4I0uS40zFvgbSs8RSxYe0sbWq3bJu/Bh/F5NZONXb8z9Wo2hupnakHQv
 A4Tct8GU+hqFrZD3cR9w+n/3P8+nk9a9imS4Uq4XlePYvIckSXTs9eZ2+zHtMcqy3sQA
 cpIGgkvpw8Y5C6el2nlFYfCHpg/v4OE97spIvpsgKawGEp49hGU3fzApUTbdUHCkP5Qw
 5DKUf47+LEbRqLCFcF5Gwi6KJvdDXCPrVTreYbedsJ1xmDgFidKujl/SoLGp08gDYpql
 sWaH+3gWW1XVj6QJloLbVWkKS91lpuaZk0OLQ98yNCTp+B3EFEdU/iFQ8sWjdkLbC+4U
 zgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4mNkfoQ58OXkFxY5lXT0JLBnZKMBlmPjenNWxHTzG5U=;
 b=OkSqortaHGIfAB8w7XX0Qma5KIZ6l1a1vGqOcFvJiwpMtPWDVxWfehZJfdakTNlzLP
 U+KQWKzQGL0TAgtgGjEexCiz92WcZZqml3orHHwI7S2oY+sRfeuuORrA+smmLwQng9Kj
 Ua3LSuw0FNiZoBj4miPiTFOIFAxez688BeLkWoR3kf9UPg1gI0GNkCaXzwRMhK9qU9GZ
 cXggYXflJeVNBCI+a0l+Rw4Pqxd6XgaSBDCE/Bn58dtEc8KHiPrqQFrouHfbYgltWgZB
 ZGm5Ltw/AIcEDfBDNuhQi8uEtJJsT++9D0DTh4Z6FPFap0Rm4io7cODYTMLA+nK1tXe4
 gxNA==
X-Gm-Message-State: AOAM5308a0JxRmLVJuN+R/ag9oKhwUaqW3TYtZDAViV64R5/SUERsz3W
 rysY4MbpjczvlUAg/tA7MwEimqoWCsXpfJyq0ig=
X-Google-Smtp-Source: ABdhPJw73VZa3ndUg9SSCAZTIxbMDiQHT+SywD30VuGs1/DnYxFu+7itTeGa/riMDHRl1ljZqNkD9Oo3pA/WtNcYnDo=
X-Received: by 2002:a05:6808:1390:: with SMTP id
 c16mr16992375oiw.123.1628533671832; 
 Mon, 09 Aug 2021 11:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210809025208.10182-1-rdunlap@infradead.org>
In-Reply-To: <20210809025208.10182-1-rdunlap@infradead.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Aug 2021 14:27:40 -0400
Message-ID: <CADnq5_OrWJSLNMJwZ8jY-RPTZRLHhxhOcoaxE5HFdu3qKfyqBw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: use do-while-0 for
 DC_TRACE_LEVEL_MESSAGE()
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Wyatt Wood <wyatt.wood@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Aug 8, 2021 at 10:52 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Building with W=3D1 complains about an empty 'else' statement, so use the
> usual do-nothing-while-0 loop to quieten this warning.
>
> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:113:53: warnin=
g: suggest braces around empty body in an 'else' statement [-Wempty-body]
>   113 |                                 *state, retry_count);
>
> Fixes: b30eda8d416c ("drm/amd/display: Add ETW log to dmub_psr_get_state"=
)
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Wyatt Wood <wyatt.wood@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20210806.orig/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.=
c
> +++ linux-next-20210806/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> @@ -29,7 +29,7 @@
>  #include "dmub/dmub_srv.h"
>  #include "core_types.h"
>
> -#define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
> +#define DC_TRACE_LEVEL_MESSAGE(...)    do {} while (0) /* do nothing */
>
>  #define MAX_PIPES 6
>
