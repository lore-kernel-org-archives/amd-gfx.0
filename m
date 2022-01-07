Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30819C433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Jan 2022 15:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 873BE10E9D3;
	Sat,  8 Jan 2022 15:14:12 +0000 (UTC)
X-Greylist: delayed 384 seconds by postgrey-1.36 at gabe;
 Fri, 07 Jan 2022 18:41:44 UTC
Received: from forward103j.mail.yandex.net (forward103j.mail.yandex.net
 [IPv6:2a02:6b8:0:801:2::106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 794F810EB5C
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 18:41:44 +0000 (UTC)
Received: from myt5-c81fdca3da50.qloud-c.yandex.net
 (myt5-c81fdca3da50.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:19b:0:640:c81f:dca3])
 by forward103j.mail.yandex.net (Yandex) with ESMTP id 2EC96101369;
 Fri,  7 Jan 2022 21:35:15 +0300 (MSK)
Received: from myt6-efff10c3476a.qloud-c.yandex.net
 (myt6-efff10c3476a.qloud-c.yandex.net [2a02:6b8:c12:13a3:0:640:efff:10c3])
 by myt5-c81fdca3da50.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 30vQDQHSJU-ZEfOHudj; Fri, 07 Jan 2022 21:35:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1641580515; bh=LfM4E//CgUEjI1DdLUtxQtDo6ENRzw5Pg0ou76vlGYc=;
 h=In-Reply-To:References:Date:To:From:Subject:Message-ID;
 b=wRHxxrAOhatPrrsmOvd3rajz+Sgy7qmskN7YJ1KunnlyhPUK4S4rhvImxbyz+ntwq
 6RoMbKXSJ6FrvcyKVp4WAjD1Olt63HYa9HVWPUN7tAyodtrbNCkaUkGT23L/keVYID
 H+IoD2x/TrmMakhFpN810ni/ir+ANSIyI2GB85tI=
Authentication-Results: myt5-c81fdca3da50.qloud-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by myt6-efff10c3476a.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id KEsX1LLLoA-ZDPSYMNE; Fri, 07 Jan 2022 21:35:13 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
X-Yandex-Fwd: 2
Message-ID: <2cb9b469ab16eaad35aab9461588cfe9977eb8fd.camel@yandex.ru>
Subject: Re: [PATCH] Revert "i2c: core: support bus regulator controlling in
 adapter"
From: Konstantin Kharlamov <hi-angel@yandex.ru>
To: "Tareque Md.Hanif" <tarequemd.hanif@yahoo.com>, Konstantin Kharlamov
 <hi-angel@yandex.ru>, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, Bibby Hsieh <bibby.hsieh@mediatek.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Hsin-Yi Wang
 <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>, Wolfram
 Sang <wsa@kernel.org>
Date: Fri, 07 Jan 2022 21:35:13 +0300
In-Reply-To: <5849ab287df1b06e141d87bbffdbcd627e999578.camel@yandex.ru>
References: <20220106122452.18719-1-wsa () kernel ! org>
 <5849ab287df1b06e141d87bbffdbcd627e999578.camel@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 08 Jan 2022 15:14:10 +0000
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

On Fri, 2022-01-07 at 21:20 +0300, Konstantin Kharlamov wrote:
> Thank you! I tested it (had to resolve a small conflict), works for me. So, in
> case you need it, the patch is
> 
>         Tested-by: Konstantin Kharlamov <hi-angel@yandex.ru>
> 
> By the way, shouldn't the patch include a field 
> 
>         Cc: <stable@vger.kernel.org> # 5.14+
> 
> ?
> 
> P.S.: sorry, for all mangled up CC fields. For some reason I didn't get your
> email, I found this patch in the archive. And the mbox that archive provides
> breaks all TO and CC fields, so I manually restored addresses that I have.

Restored the fields now, sorry, I found the mail, it was moved to another folder by a filter
