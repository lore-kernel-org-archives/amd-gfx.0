Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D866C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 13:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B9D61128E6;
	Wed, 12 Jan 2022 13:26:30 +0000 (UTC)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE364113E43
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 10:59:07 +0000 (UTC)
Received: by mail-il1-x136.google.com with SMTP id i14so1919374ila.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 02:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MfwR9+Vn3jORLxr1DCzz5sw91FiMcAgXShlKPQP07jQ=;
 b=NDZBc/s1vAw8tQA5LjF31oTBrFLLcmW+F8lIL8mO9e1iiuzWvOVpkL1c9Uw3JvgGgQ
 lW01tlg/wfoycDe2ykWw52j01N7BRgIUTZHpPrdDmepvuZAUmpkG0YQzkRmb9mbMAOVa
 27N6dOP70T+yPfhseSXJ33v4jkRK9JoRgIEx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MfwR9+Vn3jORLxr1DCzz5sw91FiMcAgXShlKPQP07jQ=;
 b=mmNd5iiajNed2x512kkAQcmrLve3g6quLTAUCG6jCW/Pcx8G/E9gw7aS6fCkR8cVs0
 Jf1qmf3ZlCv0wXcT2gxLqCnBrXcgI4gUVXx5J1EnKbB9TIfMtxm/iBRl0qpbwAEbF/BD
 z0yzHcdqZqfNVhUrSdORQBMxkrn3iRLN+XGUyiNufywGLdJiSJVjlDQLLkEYRf1CFlrT
 03gUhvgpVi6qYwLhFlLY7EIcJPJXfTlnk+ERsa5Qb9SylQ+i4ZNJKhTNuRLUPmidpcip
 dIwZyC0E9fbiu8I2SrHR6MW25309is/PKzm6mLRMPUoJLYq6rHisEq6pwYmNE0wHEEyL
 3liQ==
X-Gm-Message-State: AOAM530YRxnG0PGQUsySU+zidLESOKpg764xcdkAwYH7LSH42uLtVJC0
 dnu0PPOglEam+t5ZVHPvY+kcfB5M1fJaguZX6GGYWQ==
X-Google-Smtp-Source: ABdhPJxMD3Payzn92jPXXv9nrRvXDf6eBuPX2VU3t1MbasTCzgSWT0uLtDReSbroas9QGt1LuRqwsjrJcGI2QNNuxqE=
X-Received: by 2002:a05:6e02:1c27:: with SMTP id
 m7mr4511705ilh.114.1641985147116; 
 Wed, 12 Jan 2022 02:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20220106122452.18719-1-wsa@kernel.org> <Yd6gRR0jtqhRLwtB@ninjato>
 <98ed8d6d16a3d472d9432eb169aa2da44b66b5cc.camel@yandex.ru>
 <4dfbee97-14c2-718b-9cbd-fdeeace96f59@yahoo.com>
In-Reply-To: <4dfbee97-14c2-718b-9cbd-fdeeace96f59@yahoo.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Wed, 12 Jan 2022 18:58:41 +0800
Message-ID: <CAJMQK-h38XdN=QD6ozVNk+wxmpp1DKj21pkFZ+kY31+Lb8ot6Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "i2c: core: support bus regulator controlling in
 adapter"
To: Tareque Md Hanif <tarequemd.hanif@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 12 Jan 2022 13:26:25 +0000
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
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
 Bibby Hsieh <bibby.hsieh@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

hi Konstantin and Tareque,

Can you help provide logs if we apply
5a7b95fb993ec399c8a685552aa6a8fc995c40bd but revert
8d35a2596164c1c9d34d4656fd42b445cd1e247f?

Thanks

On Wed, Jan 12, 2022 at 6:02 PM Tareque Md Hanif
<tarequemd.hanif@yahoo.com> wrote:
>
>
> On 1/12/22 15:51, Wolfram Sang wrote:
> > would the reporters of the
> > regression be available for further testing?
> Sure. I am available.
