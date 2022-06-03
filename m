Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74426C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 15:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B64BC10E021;
	Fri,  3 Jun 2022 15:38:40 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA9C10E3E5;
 Fri,  3 Jun 2022 14:44:16 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4A5F4615B7;
 Fri,  3 Jun 2022 14:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4B2C385B8;
 Fri,  3 Jun 2022 14:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1654267453;
 bh=CpjnsTFOIV6VM6JRW+RluS/ZLi3gemWGh7xo+U+GKCQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tu24t6s9UYNqpISH5l7Vapy7l1I6CZ0s/6diqn9e3oh3qhNNF+vhDjYbX0bbMkZxs
 DEwOGDerMKjUxvOgaoPgCSSiUKi+gLT9R7kQN7ZDyetjHmfKnxBExs9addJLYZulby
 A7r550GzzNu6aLpPv7auP31RyX18TvSNH2Fut6+E=
Date: Fri, 3 Jun 2022 16:44:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Lin, Tsung-hua (Ryan)" <Tsung-hua.Lin@amd.com>
Subject: Re: [PATCH] BACKPORT: drm/amdgpu/disply: set num_crtc earlier
Message-ID: <YpoeOu9rxeBAwI7U@kroah.com>
References: <20220530092902.810336-1-tsung-hua.lin@amd.com>
 <YpTBBPVxcdJ8sn8m@kroah.com>
 <DM6PR12MB441701EC6E6D2A678F42A480B2DF9@DM6PR12MB4417.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB441701EC6E6D2A678F42A480B2DF9@DM6PR12MB4417.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Fri, 03 Jun 2022 15:38:39 +0000
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
Cc: David Airlie <airlied@linux.ie>, "Li, Leon" <Leon.Li@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ikshwaku Chauhan <ikshwaku.chauhan@amd.corp-partner.google.com>,
 Sasha Levin <sashal@kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Swarnakar,
 Praful" <Praful.Swarnakar@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, Sean Paul <seanpaul@chromium.org>, "Li,
 Ching-shih \(Louis\)" <Ching-shih.Li@amd.com>, Simon Ser <contact@emersion.fr>,
 "Li, Roman" <Roman.Li@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "S,
 Shirish" <Shirish.S@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, Mark Yacoub <markyacoub@google.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Jun 01, 2022 at 04:04:45AM +0000, Lin, Tsung-hua (Ryan) wrote:
> [AMD Official Use Only - General]
> 
> Hi Greg,
> 
> Thanks for your advice. I have modified the commit and submitted it to Gerrit and it's under code review now.

This makes no sense to me, we do not use gerrit for kernel development.

confused,

greg k-h
