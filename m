Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA99C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Apr 2022 08:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 098DC10EAA1;
	Mon,  4 Apr 2022 08:22:36 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0EB310EAA1
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Apr 2022 08:22:34 +0000 (UTC)
Received: from [192.168.0.7] (ip5f5aef69.dynamic.kabel-deutschland.de
 [95.90.239.105])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6CA6E61E6478B;
 Mon,  4 Apr 2022 10:22:32 +0200 (CEST)
Message-ID: <f52945c8-92c2-7065-bd22-cb18c05bd76e@molgen.mpg.de>
Date: Mon, 4 Apr 2022 10:22:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at
 drivers/dma-buf/dma-fence-array.c:191 dma_fence_array_create+0x101/0x120" and
 some games stopped working.
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
 <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com>
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
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, daniel.vetter@ffwll.ch,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 thomas.hellstrom@linux.intel.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Christian,


Am 04.04.22 um 08:30 schrieb Christian König:

> those are two independent and already known problems.
> 
> The warning triggered from the sync_file is already fixed in 
> drm-misc-next-fixes, but so far I couldn't figure out why the games 
> suddenly doesn't work any more.
> 
> There is a bug report for that, but bisecting the changes didn't yielded 
> anything valuable so far.
> 
> So if you can come up with something that would be rather valuable.

It’d be great, if you (or somebody else) could provide the URL to that 
issue.


Kind regards,

Paul
