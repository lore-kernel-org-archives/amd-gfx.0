Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDACBC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 15:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741ED10E699;
	Wed, 16 Mar 2022 15:58:36 +0000 (UTC)
X-Greylist: delayed 343 seconds by postgrey-1.36 at gabe;
 Wed, 16 Mar 2022 15:58:35 UTC
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E4710E1A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 15:58:35 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:105:465:1:2:0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4KJZgs361Wz9scd;
 Wed, 16 Mar 2022 16:58:33 +0100 (CET)
Message-ID: <d68190bf-c4c9-4557-dfc2-4e26aab83924@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1647446311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tCByKk2J7Fkgg2S7U3X9MSs+4u/tnV53fNkOsDdZurg=;
 b=ajguRF++YmtBcHbgA+JSq2gTALyT5nHPMzX15MCAUpDx/fd48YPgBSaP7wOaDUATOIUll8
 /YQGAF78qctlwqBfxGQEhND+RYZ2SNdlXagbTwgJtuLYB6jYUSz7m4XmVeuwU/EbVbtJsm
 ggzS4a6uuM11YEMINTsDMweW9bZIJH9VavO0hFEz4A0SLV1GW/C3rBMQ/I2zTyXc3u2338
 TTdmMqgd+KzCETpQYRUJCb4p1GDzGwudIGBdVORKba8elr2GrmVIZRpBUI1Dj097nMhVDO
 zAnr8PxbnQlUuCm6ebi4sdmxyRyYrVBYxTjeqOxL7KEhHi+yNX4AGSynq0oT8Q==
Date: Wed, 16 Mar 2022 16:58:28 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu/gmc: use PCI BARs for APUs in passthrough
Content-Language: en-CA
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220310180615.2245997-1-alexander.deucher@amd.com>
 <ed66fa3d-51c8-1cd1-8709-30f66eb82fd3@mailbox.org>
 <541dc1eb-cf50-17d2-0ae3-5c3cb3dc3ac0@gmail.com>
 <238d136e-d060-d1b3-57f9-ee23b00d5ed9@mailbox.org>
 <0fc2af87-4c9d-f2b8-c14b-703299fc6367@mailbox.org>
 <CADnq5_MBK2VP9A6r1MtiMFvBrmO7Tc5Y=RtENWoEhopp8BY3aw@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <CADnq5_MBK2VP9A6r1MtiMFvBrmO7Tc5Y=RtENWoEhopp8BY3aw@mail.gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-03-16 16:55, Alex Deucher wrote:
> On Wed, Mar 16, 2022 at 11:52 AM Michel Dänzer
> <michel.daenzer@mailbox.org> wrote:
>>
>> On 2022-03-11 18:43, Michel Dänzer wrote:
>>> On 2022-03-11 11:32, Christian König wrote:
>>>> Am 11.03.22 um 11:24 schrieb Michel Dänzer:
>>>>> On 2022-03-10 19:06, Alex Deucher wrote:
>>>>>> If the GPU is passed through to a guest VM, use the PCI
>>>>>> BAR for CPU FB access rather than the physical address of
>>>>>> carve out.  The physical address is not valid in a guest.
>>>>> I think amdgpu_device_flush_hdp & amdgpu_device_invalidate_hdp need to be modified accordingly.
>>>
>>> I'm surprised you gave your R-b despite this. Surely the HDP cache needs to be handled when going through the BAR?
>>
>> I'm a bit confused why there's still been no response on this point from either of you. Are you guys checking internally whether or not this is needed?
> 
> Yes, it is needed.  I added it in v2 of the patch.

Ah, great, hadn't seen the v2 patch yet. :)


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
