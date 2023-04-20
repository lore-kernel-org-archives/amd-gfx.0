Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A55C77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 15:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69EEF10E073;
	Thu, 20 Apr 2023 15:03:52 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9213710EC81
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 15:02:57 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4D6CA61811;
 Thu, 20 Apr 2023 15:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F43BC4339B;
 Thu, 20 Apr 2023 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1682002975;
 bh=wLFf/3UduQT115De5anbj1jAUqCYioVOyfeOTB/iTsY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bcK31wBsQF16z3QtPGxFKKaX3N/WLgvhK3ISNENMKF1GTMr1Dl06Ruqs0q055mAxk
 +nOXXUIjpU+YYq4a11Bde6shLjTP5wRDH6RzbQ+r5l84lA7Rxx69A6dySQpk7EV0AV
 auR3fIN1I82ivpdUumVHUt/pk4uVuvCNO1N3LZ6E=
Date: Thu, 20 Apr 2023 17:02:49 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH 6.1.y] drm/amdgpu/vcn: Disable indirect SRAM on Vangogh
 broken BIOSes
Message-ID: <ZEFUGSlqQu3v8ryf@kroah.com>
References: <20230418221522.1287942-1-gpiccoli@igalia.com>
 <BL1PR12MB514405B37FC8691CB24F9DADF7629@BL1PR12MB5144.namprd12.prod.outlook.com>
 <be4babae-4791-11f3-1f0f-a46480ce3db2@igalia.com>
 <BL1PR12MB51443694A5FEFA899704B3EBF7629@BL1PR12MB5144.namprd12.prod.outlook.com>
 <9b9a28f5-a71f-bb17-8783-314b1d30c51f@igalia.com>
 <ZEEzNSEq-15PxS8r@kroah.com>
 <94b63d19-4151-c294-50eb-c325ea9c699f@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94b63d19-4151-c294-50eb-c325ea9c699f@igalia.com>
X-Mailman-Approved-At: Thu, 20 Apr 2023 15:03:51 +0000
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
Cc: "sashal@kernel.org" <sashal@kernel.org>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhu, James" <James.Zhu@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 20, 2023 at 09:59:17AM -0300, Guilherme G. Piccoli wrote:
> On 20/04/2023 09:42, gregkh@linuxfoundation.org wrote:
> > [...]
> >> @Greg, can you pick this one? Thanks!
> > 
> > Which "one" are you referring to here?
> > 
> > confused,
> > 
> > greg k-h
> 
> This one, sent in this email thread.

I don't have "this email thread" anymore, remember, some of us get
thousand+ emails a day...

> The title of the patch is "drm/amdgpu/vcn: Disable indirect SRAM on
> Vangogh broken BIOSes", target is 6.1.y and (one of the) upstream
> hash(es) is 542a56e8eb44 heh

But that commit says it fixes a problem in the 6.2 tree, why is this
relevant for 6.1.y?

thanks,

greg k-h
