Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37647C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 13:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 936B711288F;
	Wed, 12 Jan 2022 13:26:29 +0000 (UTC)
X-Greylist: delayed 417 seconds by postgrey-1.36 at gabe;
 Wed, 12 Jan 2022 10:00:03 UTC
Received: from forward500o.mail.yandex.net (forward500o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 997491136D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 10:00:03 +0000 (UTC)
Received: from vla1-b85deedef156.qloud-c.yandex.net
 (vla1-b85deedef156.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0d:89c:0:640:b85d:eede])
 by forward500o.mail.yandex.net (Yandex) with ESMTP id 018989427F9;
 Wed, 12 Jan 2022 12:53:04 +0300 (MSK)
Received: from vla3-23c3b031fed5.qloud-c.yandex.net
 (vla3-23c3b031fed5.qloud-c.yandex.net [2a02:6b8:c15:2582:0:640:23c3:b031])
 by vla1-b85deedef156.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 YKgBHTejNI-r3fa0jiw; Wed, 12 Jan 2022 12:53:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1641981183; bh=GBvPYx5xlO7r/in7vKblwwrgfU2MCoognfarC7rdbak=;
 h=In-Reply-To:To:From:Subject:Message-ID:Cc:References:Date;
 b=Uyp2Osp97srb3rUFOzCKjMYP5R2DOaxljSfrW8/Ojcp7zjeQ0OpRwWiaBxbz3sYod
 ku77jABkKYRqFa2ZfKkTRUtzLBkqjn6mah06d/1YhPzVPmyipL3PxyvpG86xgIVwj3
 z4cI38USXEAszEPFexrJrkmB9PehIyjMSgQMdtd8=
Authentication-Results: vla1-b85deedef156.qloud-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by vla3-23c3b031fed5.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id PaDBeQX1JP-r2QqdOrT; Wed, 12 Jan 2022 12:53:02 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
X-Yandex-Fwd: 2
Message-ID: <98ed8d6d16a3d472d9432eb169aa2da44b66b5cc.camel@yandex.ru>
Subject: Re: [PATCH] Revert "i2c: core: support bus regulator controlling in
 adapter"
From: Konstantin Kharlamov <hi-angel@yandex.ru>
To: Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org
Date: Wed, 12 Jan 2022 12:51:31 +0300
In-Reply-To: <Yd6gRR0jtqhRLwtB@ninjato>
References: <20220106122452.18719-1-wsa@kernel.org> <Yd6gRR0jtqhRLwtB@ninjato>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 Bibby Hsieh <bibby.hsieh@mediatek.com>, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "Tareque Md.Hanif" <tarequemd.hanif@yahoo.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 2022-01-12 at 10:32 +0100, Wolfram Sang wrote:
> Hi everyone,
> 
> On Thu, Jan 06, 2022 at 01:24:52PM +0100, Wolfram Sang wrote:
> > This largely reverts commit 5a7b95fb993ec399c8a685552aa6a8fc995c40bd. It
> > breaks suspend with AMD GPUs, and we couldn't incrementally fix it. So,
> > let's remove the code and go back to the drawing board. We keep the
> > header extension to not break drivers already populating the regulator.
> > We expect to re-add the code handling it soon.
> > 
> > Reported-by: "Tareque Md.Hanif" <tarequemd.hanif@yahoo.com>
> > Link:
> > https://lore.kernel.org/r/1295184560.182511.1639075777725@mail.yahoo.com
> > Reported-by: Konstantin Kharlamov <hi-angel@yandex.ru>
> > Link:
> > https://lore.kernel.org/r/7143a7147978f4104171072d9f5225d2ce355ec1.camel@yandex.ru
> > BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1850
> > Signed-off-by: Wolfram Sang <wsa@kernel.org>
> 
> So, it has been reverted now. Is someone of the original patch
> submitters interested in re-adding it? And would the reporters of the
> regression be available for further testing?

I am available for further testing.

> Thanks and happy hacking,
> 
>    Wolfram
> 

