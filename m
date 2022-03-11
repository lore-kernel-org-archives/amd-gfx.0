Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5509CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Mar 2022 17:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCD5410E58D;
	Fri, 11 Mar 2022 17:43:45 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050::465:201])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82CA810E58D
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Mar 2022 17:43:44 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:105:465:1:4:0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4KFYFV4YYqz9sWF;
 Fri, 11 Mar 2022 18:43:42 +0100 (CET)
Message-ID: <238d136e-d060-d1b3-57f9-ee23b00d5ed9@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1647020620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iATSE8Yml+Rrr1tAymEYb1rBiP2rdPcC6qAINlns2Vk=;
 b=p3buIwvVIjHxsRT2HZbrz5B69CsfcIjlR6OD7Q6dZGHDMDnH+fY2ayXTRpV6qzsifWyDk/
 Ef7Eimkq8q1DU/QtnPZ86p80DJywg/A1gT9rRafjSbUeWO7knUbs6XSelhBcVsAqmANqbV
 CjoDGG8Ew5gruGL/Wezv8zeVUNgRSjrxe+Kzj1O+vbjUagab3qX80p8Qhc00ymMBKqlcrH
 WTNWifa2IZX7fKCPDFXM7XU1t6kPERth/+VkkYkFn3D6R2TGFtEV/qNw13xNQhG42BammJ
 iiOeDuv5yPtVV7MuZy5pJ9AGMwIlvNndwRhJ0KC0QUbxyM9OhqB6Jkfv939qRQ==
Date: Fri, 11 Mar 2022 18:43:37 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu/gmc: use PCI BARs for APUs in passthrough
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20220310180615.2245997-1-alexander.deucher@amd.com>
 <ed66fa3d-51c8-1cd1-8709-30f66eb82fd3@mailbox.org>
 <541dc1eb-cf50-17d2-0ae3-5c3cb3dc3ac0@gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <541dc1eb-cf50-17d2-0ae3-5c3cb3dc3ac0@gmail.com>
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

On 2022-03-11 11:32, Christian König wrote:
> Am 11.03.22 um 11:24 schrieb Michel Dänzer:
>> On 2022-03-10 19:06, Alex Deucher wrote:
>>> If the GPU is passed through to a guest VM, use the PCI
>>> BAR for CPU FB access rather than the physical address of
>>> carve out.  The physical address is not valid in a guest.
>> I think amdgpu_device_flush_hdp & amdgpu_device_invalidate_hdp need to be modified accordingly.

I'm surprised you gave your R-b despite this. Surely the HDP cache needs to be handled when going through the BAR?


>> Also, I wonder if BAR resizing could work with APUs?
> 
> At least trivial to implement.
> 
> The host had to resize the BAR for the client or otherwise the client could easily bring down the system.

Gotcha, makes sense.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
