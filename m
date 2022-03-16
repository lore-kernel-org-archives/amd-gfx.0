Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89599C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 15:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1014910E80C;
	Wed, 16 Mar 2022 15:52:56 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050::465:102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80BEB10E80C
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 15:52:54 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4KJZYG4WTXz9sc3;
 Wed, 16 Mar 2022 16:52:50 +0100 (CET)
Message-ID: <0fc2af87-4c9d-f2b8-c14b-703299fc6367@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1647445968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dt7JF0tOTmmQcaaKTNwG9o3bd4EbxKhwIxfs0Q0Szvg=;
 b=JPV7ZTn3wCxYxzFh6wHCVbn1Hqvt5wFy9TCapyY0lmI/F4+TmbmWCXRAYA3GYX/ayPRwBe
 evVr8zFy79+Ec5ISlmIfrf82jzpWO+TGVxcZaNByiI6+TFGWUUWLcDCkhe9jvNZsFbT+0N
 rtBt21qoHuPYtwx+Yy/7a0JpVIUlRAszu1WQPZRtohE8Hn1/l3RpJRbbmsAzcq8OnvLHtz
 kyfES+tT2Xm5RER5FlZ7qHTICRcbc/w/ofkk8TqX7wABWxXpu4cHu3Me5GhHydqlE0mgmR
 yjV5l4Eoai9/z2DvyNMBb3Z9qs6VFRD9Li/P9muIobnsGR+bgx4tRpinQ+2pRA==
Date: Wed, 16 Mar 2022 16:52:41 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu/gmc: use PCI BARs for APUs in passthrough
Content-Language: en-CA
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20220310180615.2245997-1-alexander.deucher@amd.com>
 <ed66fa3d-51c8-1cd1-8709-30f66eb82fd3@mailbox.org>
 <541dc1eb-cf50-17d2-0ae3-5c3cb3dc3ac0@gmail.com>
 <238d136e-d060-d1b3-57f9-ee23b00d5ed9@mailbox.org>
In-Reply-To: <238d136e-d060-d1b3-57f9-ee23b00d5ed9@mailbox.org>
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

On 2022-03-11 18:43, Michel Dänzer wrote:
> On 2022-03-11 11:32, Christian König wrote:
>> Am 11.03.22 um 11:24 schrieb Michel Dänzer:
>>> On 2022-03-10 19:06, Alex Deucher wrote:
>>>> If the GPU is passed through to a guest VM, use the PCI
>>>> BAR for CPU FB access rather than the physical address of
>>>> carve out.  The physical address is not valid in a guest.
>>> I think amdgpu_device_flush_hdp & amdgpu_device_invalidate_hdp need to be modified accordingly.
> 
> I'm surprised you gave your R-b despite this. Surely the HDP cache needs to be handled when going through the BAR?

I'm a bit confused why there's still been no response on this point from either of you. Are you guys checking internally whether or not this is needed?


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
