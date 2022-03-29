Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314C3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 08:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B82C310E2CE;
	Tue, 29 Mar 2022 08:21:26 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F21510E2CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 08:21:25 +0000 (UTC)
Received: from [192.168.0.4] (ip5f5aef5a.dynamic.kabel-deutschland.de
 [95.90.239.90])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 987FA61EA1929;
 Tue, 29 Mar 2022 10:21:23 +0200 (CEST)
Message-ID: <e74ef8c6-32fd-9684-5f8d-8976d72322e4@molgen.mpg.de>
Date: Tue, 29 Mar 2022 10:21:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: Support AMDGPU RAS debugfs poll interface
Content-Language: en-US
To: YiPeng.Chai@amd.com
References: <20220329073843.772795-1-YiPeng.Chai@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220329073843.772795-1-YiPeng.Chai@amd.com>
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
Cc: yipechai@amd.com, Tao.Zhou1@amd.com, John.Clements@amd.com,
 amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Yi Peng,


Thank you for the patch. Two nits regarding the commit message.

Am 29.03.22 um 09:38 schrieb yipechai:
> Some AMDGPU RAS debugfs operations like UE injection
> can cause gpu reset. Before doing the next debugfs
> operation, the application should call poll to check
> if the gpu has finished recovering.

Please use a text width of 75 characters per line for the commit message 
body.

> Signed-off-by: yipechai <YiPeng.Chai@amd.com>

Could you please configure git (and your email program) to use your full 
name?

     $ git config --global user.name "Yi Peng Chai" # no idea if correct

[…]


Kind regards,

Paul
