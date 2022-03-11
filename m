Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D49C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Mar 2022 10:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C2C10E897;
	Fri, 11 Mar 2022 10:24:41 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050::465:201])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13B2910E897
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Mar 2022 10:24:41 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4KFMVs0cf2z9sb9;
 Fri, 11 Mar 2022 11:24:37 +0100 (CET)
Message-ID: <ed66fa3d-51c8-1cd1-8709-30f66eb82fd3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1646994274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TmKehW2lin5M3m+VWauWz7853vrpgP5A6lYj4Hdz9mQ=;
 b=i+oSLHBGqxD8i1t0xNJh+7sYhXQQ4C5wWuUG/fpDmw73SdEXWA/WziVMqQrw3nL9SRYLaI
 gKQ8Mxh2Mvh786diV5DQeFRLI2Oj/lGLYG5j3wWFuLca6U5oZ721H1b2D05eUlyHkiBYgT
 mPqAi7ABEOce97gDnSLWl5Wkzzl6dqItibo//pD4aNKvr0xgiidV1r+6ebfyg4HNnZXUDU
 LE5IHtmRBMxtCzTZUaVOc+Kxj/a8Z6Le0auzJOslPzI/IpJ+HA5nG76Aa090q5/M+zoS/X
 yXdP95uovx1aiO3c7bzdl3Jc8qQgAayNOTyUA1Ldbn6srd2Ove8LaQCC/ea0sQ==
Date: Fri, 11 Mar 2022 11:24:31 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu/gmc: use PCI BARs for APUs in passthrough
Content-Language: en-CA
To: Alex Deucher <alexander.deucher@amd.com>
References: <20220310180615.2245997-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20220310180615.2245997-1-alexander.deucher@amd.com>
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

On 2022-03-10 19:06, Alex Deucher wrote:
> If the GPU is passed through to a guest VM, use the PCI
> BAR for CPU FB access rather than the physical address of
> carve out.  The physical address is not valid in a guest.

I think amdgpu_device_flush_hdp & amdgpu_device_invalidate_hdp need to be modified accordingly.


Also, I wonder if BAR resizing could work with APUs?


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
