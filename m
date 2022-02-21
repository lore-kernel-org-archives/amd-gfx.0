Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DA2C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 17:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D2E10E2AA;
	Mon, 21 Feb 2022 17:44:57 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050::465:201])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D93C210E2AA
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 17:44:56 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4K2V7C0THDz9sSp;
 Mon, 21 Feb 2022 18:44:55 +0100 (CET)
Message-ID: <4009de28-8add-97b9-0dd3-8d44704af322@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1645465492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yw092lAUgsfaQ0zPq1NuunikDF/9/miFdYIksl++CCY=;
 b=DaAKXA8omZd528dAYG8jNvznP/xXfmqZ1Vw5hMoI5+ngenr45vMSip62hkTayS1M8WIXWq
 +hykVEAiwAsZqIdF7mrh1syBOn1r12TpDdI+NdHKZSCX2cyGiYZ2Ov27vvuF8Rcy/3D6Ng
 UCNvaS7Yz3yHmRSZ3E3UoRtLwBin7xFlgICKmlxj1Wd1jBEAJhkTWNzu10hcOQF6CZmtlt
 rVMxmoKD5pUFxZEmLIQmXIwf+kyhg1pmXNMUkAWaWT7Jvjeq2chnBlpCsuBv7ADmhq9UhA
 a7HDZ3flC/aj/71jjHOsMQyx59m63XcuAezp8+/SaVH/6GudmVfcQEdBwd5XeA==
Date: Mon, 21 Feb 2022 18:44:50 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 7/7] drm/amdgpu: drop testing module parameter
Content-Language: en-CA
To: Alex Deucher <alexander.deucher@amd.com>
References: <20220218222603.25470-1-alexander.deucher@amd.com>
 <20220218222603.25470-7-alexander.deucher@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20220218222603.25470-7-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-02-18 23:26, Alex Deucher wrote:
> This was always duplicate functionality with the benchmark tests.

Not really. The purpose of amdgpu_do_test_moves is testing that copies between GTT & VRAM work across the whole GTT aperture (when I originally wrote radeon_do_test_moves, they didn't on the PowerBook I was using at the time).


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
