Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57759C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 15:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CE9C10E829;
	Tue, 11 Oct 2022 15:59:11 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E3B10E63A;
 Tue, 11 Oct 2022 15:59:07 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id m81so16366737oia.1;
 Tue, 11 Oct 2022 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hCRaapQLVmEofLP4NgKlOxU1foJi+Wo9dhzQ90svRlY=;
 b=bnbrdNLdT/bUPd0qhqZflGfE0jb110BVyq5iZfWoFq/M1zGduhnVg/vJ6erAnWFVi0
 deI+RfMqMTmYGZ0mw4be3stcKCcAaUfcgv83ld/iToqMsDm396BrQ2mfKex9UrOAdfUK
 SrZfd/FrkJ56a6s/rHvp0yMLdUHnXhbGrb54vMEOxKPfC+mNZWtoYTWirLlX1x6GBao4
 dcIvEifUKLE/8P4HSRH7XSxJjO2pEjFpxtZUDdJpGHBSDMW2hWpWNKj7TZCa+eCGBQtH
 3zn8vNhkuwuUGFyu3hEyn5xQcLop2mUoPhXPjfze8XTFIRxN+BPqpDdXE1Jdsd0lkOTN
 hdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hCRaapQLVmEofLP4NgKlOxU1foJi+Wo9dhzQ90svRlY=;
 b=RTdPLS7k6FaKDRU0xolNWS10RUqGbKMBj785ETCMudIhVdxsD9WdOCVXlkktY447+d
 G9ovLkm7OcfgHmqk430cko+G18dHgPbMl/ipr4Z7DWuE3ksdJk2NU/ai25UXg5kbMgMn
 zPIVoTnDK2+RiNpdpBLkF4BUVBrWQQ6uW0Maz2RcjRIBvnPOBKjs1EzVHmh4p90PvWXY
 Zf+DJuTabVLycB351mQPg0j4p/WvRF7ZQUJe6tI5nXun11R8AvkqxkdEtc+yqtKuYGqy
 peziZoo1As9eLBoPf8NPGWq8YGLnfMydTZ9QZ9v8XVjVRdOBaTU8TB96YSyTHfBcIXke
 vZIg==
X-Gm-Message-State: ACrzQf0XqJvPcadaz4JhhePaa4D13FnbDHN6CBd2yoKQR2C85UdZOqc+
 psDIKD7/BNuQeRyD9+TxlSBNVe0CoglGWakgN84=
X-Google-Smtp-Source: AMsMyM7bwOho1qC7OTbxH6DCCxTstEkqnH7nzwHY1xa44J0GzA+KA77eabXicN9UxDao65ssP4ZBPY2SB3/kE+Q7qFE=
X-Received: by 2002:a05:6808:14d2:b0:354:c733:abd3 with SMTP id
 f18-20020a05680814d200b00354c733abd3mr1202719oiw.96.1665503946454; Tue, 11
 Oct 2022 08:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221010073803.88244-1-yang.lee@linux.alibaba.com>
 <41663e73-6eb6-3624-7e7e-661745a72193@amd.com>
In-Reply-To: <41663e73-6eb6-3624-7e7e-661745a72193@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 11 Oct 2022 11:58:54 -0400
Message-ID: <CADnq5_My7KXYqQ1SrGqK2nj4P67NUh1hoYD+C+BngRJNC9YcCg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Simplify bool conversion
To: Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: sunpeng.li@amd.com, Abaci Robot <abaci@linux.alibaba.com>,
 Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Yang Li <yang.lee@linux.alibaba.com>,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com,
 airlied@gmail.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, Oct 11, 2022 at 11:27 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2022-10-10 03:38, Yang Li wrote:
> > The result of 'pwr_status == 0' is Boolean, and the question mark
> > expression is redundant.
> >
> > Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2354
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> > index 955ca273cfe1..cbda458bf040 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> > @@ -1401,7 +1401,7 @@ bool dcn32_dsc_pg_status(
> >               break;
> >       }
> >
> > -     return pwr_status == 0 ? true : false;
> > +     return pwr_status == 0;
> >  }
> >
> >  void dcn32_update_dsc_pg(struct dc *dc,
>
