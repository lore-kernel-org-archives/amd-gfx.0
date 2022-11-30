Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380DFC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 15:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5F010E488;
	Wed, 30 Nov 2022 15:24:06 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED5B410E48C;
 Wed, 30 Nov 2022 15:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oQ9dPsuO3NH7LD/dPayMRzr2bJuPWc28ti+5YXyo6Lo=; b=h6hMWKg1nF8fxST1CkhnfvYovh
 ufRy684CUnMt5QyuAmcYo14AF5YDB2vyNT3O42Y2fKH3Q5GISG6rqCI2F2uaQQyTjkgg4F5hfT0rN
 AqEX9MH+8uyV/K6AYPa177HqQBd1+gAcIlkcHi9V5/LP69UppHI4YcS1ldcG6v8XEYuA0jQmyQrvV
 KOV5ZtWRl/nprilkrGXDr0LbaXCkIiTY0YAsg+3qFD99cefkB5WTRQ6j8shE87MNfmdYij4h5J2F2
 Wes50rDCDJBtwWKV8XVn9aJN8jPs8Qa0B+3fgkvOqfUdA43xW5JDhmp5CSbcziKlhyRqVfX+RZDxw
 t9Ci+U7w==;
Received: from 200-207-99-62.dsl.telesp.net.br ([200.207.99.62]
 helo=[192.168.1.111]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1p0OwH-00BgmO-9q; Wed, 30 Nov 2022 16:23:57 +0100
Message-ID: <2dbf222e-7694-ea5e-c35d-663011c16e84@igalia.com>
Date: Wed, 30 Nov 2022 12:23:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 0/2] drm: Add GPU reset sysfs
Content-Language: en-US
To: Simon Ser <contact@emersion.fr>, Pekka Paalanen <ppaalanen@gmail.com>
References: <20221125175203.52481-1-andrealmeid@igalia.com>
 <20221128112528.1206b1f5@eldfell>
 <584UdQAqoPr4vSxCTJg70LFQm--HpHH-EhnAo78lRAZ89OnrDkUeKlTnDGT_DMzDT3PeEtmXNsrqB6GuiV4TsZv3pBU8kFWjyPLWGrevIMw=@emersion.fr>
From: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <584UdQAqoPr4vSxCTJg70LFQm--HpHH-EhnAo78lRAZ89OnrDkUeKlTnDGT_DMzDT3PeEtmXNsrqB6GuiV4TsZv3pBU8kFWjyPLWGrevIMw=@emersion.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: pierre-eric.pelloux-prayer@amd.com, Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>, amaranath.somalapuram@amd.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Rob Clark <robdclark@gmail.com>, Daniel Stone <daniel@fooishbar.org>,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 alexander.deucher@amd.com, contactshashanksharma@gmail.com,
 Dave Airlie <airlied@gmail.com>, christian.koenig@amd.com,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/28/22 06:30, Simon Ser wrote:
> The PID is racy, the user-space daemon could end up killing an
> unrelated process… Is there any way we could use a pidfd instead?

Is the PID race condition something that really happens or rather 
something theoretical?

Anyway, I can't see how pidfd and uevent would work together. Since 
uevent it's kind of a broadcast and pidfd is an anon file, it wouldn't 
be possible to say to userspace which is the fd to be used giving that 
file descriptors are per process resources.

On the other hand, this interface could be converted to be an ioctl that 
userspace would block waiting for a reset notification, then the kernel 
could create a pidfd and give to the blocked process the right fd. We 
would probably need a queue to make sure no event is lost.

Thanks
	André
