Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E54FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 08:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F1961076
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 08:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C2F1961076
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 708176E44F;
	Mon,  8 Nov 2021 08:10:50 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC336E44F
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 08:10:48 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aef86.dynamic.kabel-deutschland.de
 [95.90.239.134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9875361E5FE00;
 Mon,  8 Nov 2021 09:10:46 +0100 (CET)
Message-ID: <75e1d301-f92f-3237-8bf8-5f0ab308b9a4@molgen.mpg.de>
Date: Mon, 8 Nov 2021 09:10:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] drm/amdgpu/gmc6: fix DMA mask from 44 to 40 bits
Content-Language: en-US
To: stable@vger.kernel.org
References: <20211028142144.210568-1-alexander.deucher@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20211028142144.210568-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Linux stable folks,


Am 28.10.21 um 16:21 schrieb Alex Deucher:
> The DMA mask on SI parts is 40 bits not 44.  Copy
> paste typo.
> 
> Fixes: 244511f386ccb9 ("drm/amdgpu: simplify and cleanup setting the dma mask")
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1762
> Acked-by: Christian König <christian.koenig@amd.com>
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

This is commit 403475be6d8b122c3e6b8a47e075926d7299e5ef in Linus’ master 
branch. Could you please apply it to the stable series (5.4+)?


Kind regards,

Paul
