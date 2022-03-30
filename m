Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01A3C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Mar 2022 06:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4347910ECC7;
	Wed, 30 Mar 2022 06:39:33 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F188910E230
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Mar 2022 06:39:31 +0000 (UTC)
Received: from [192.168.0.4] (unknown [95.90.232.238])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 464E261EA192A;
 Wed, 30 Mar 2022 08:39:30 +0200 (CEST)
Message-ID: <5e0bbb6e-304a-dd96-b129-c4785b0bd956@molgen.mpg.de>
Date: Wed, 30 Mar 2022 08:39:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2] drm/amdgpu: fix incorrect GCR_GENERAL_CNTL address
Content-Language: en-US
To: Ruili Ji <Ruili.Ji@amd.com>
References: <20220328045845.1986195-1-ruili.ji@amd.com>
 <1b99c19a-b2fd-5ad3-4313-eea56f42e369@molgen.mpg.de>
 <MWHPR1201MB00791612FD34CFC916828CAE9B1E9@MWHPR1201MB0079.namprd12.prod.outlook.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <MWHPR1201MB00791612FD34CFC916828CAE9B1E9@MWHPR1201MB0079.namprd12.prod.outlook.com>
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
Cc: Yifan Zhang <Yifan1.Zhang@amd.com>, Aaron Liu <Aaron.Liu@amd.com>,
 amd-gfx@lists.freedesktop.org, Prike Liang <Prike.Liang@amd.com>,
 Ray Huang <Ray.Huang@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Ruili,


Am 29.03.22 um 11:17 schrieb Ji, Ruili:

> This is not related to any issue.

I didn’t mean an issue (where I’d use Resolves to differentiate the two 
cases), but the commit introducing the incorrect address.


Kind regards,

Paul


PS: Please use interleaved style when replying instead of top-posting.
