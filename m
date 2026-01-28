Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDDFD3F06D
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 14:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB6910E6FB;
	Wed, 28 Jan 2026 14:25:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bMa52G8O";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B75810E6FB;
 Wed, 28 Jan 2026 14:25:22 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f1Pgf4tKQz9tjX;
 Wed, 28 Jan 2026 15:25:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769610318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xo2PUTC7FFhnXypRzYjVg5zeByp0vVFeAjVGsUVuktU=;
 b=bMa52G8OAzbGFL2ILE7gP9CjU3nc0NM8cNvGHSzE8eI99EIbiuNdWqrFhOQ5xiV4ZPfHci
 AQ7cIcAtjgnZpKFNMHvrYhjrusC352sSxs92OMVMWKWSNny0folG6JyrtJEODt623DZ2CW
 VDVo2VKYRFItnDnZORkLB7XayD4Ub/owHd3bcAfovHb32mrQVkYikz/mXcwnGPQUkuGwBP
 7zKAK2YxDbt5W8MzAUsBaphBFoV+m+0xqyIZlOQjZRCVF/9P+e1oCNIAFnrtjZ7kc4A3mp
 4sNouoo+WrptnXW23uO3Rt9MnNanAcuuOoLGykUMJ/f8u2iCF18Zy5uCJIuP7g==
Message-ID: <ab52825d-8f26-4b52-af5d-4051760b2aa4@mailbox.org>
Date: Wed, 28 Jan 2026 15:25:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] drm: introduce page_flip_timeout()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Hamza Mahfooz <someguy@effective-light.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Sunil Khatri <sunil.khatri@amd.com>, Ce Sun <cesun102@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Melissa Wen <mwen@igalia.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <17cd6378-e3fa-419b-90d3-7e0549817110@amd.com>
 <f71df23e-f267-46b7-8fd8-4235e9a7a7fb@mailbox.org>
 <2203806.9o76ZdvQCi@timur-hyperion>
 <eef1982a-ddff-4aea-8ece-5aa1995cc2ec@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <eef1982a-ddff-4aea-8ece-5aa1995cc2ec@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9dd2d33cda4345fcdbb
X-MBO-RS-META: oz8pm1kmkkhg3ezazqfhnxbg8hnzzqbk
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/28/26 13:48, Christian König wrote:
> On 1/28/26 13:14, Timur Kristóf wrote:
>> On Wednesday, January 28, 2026 12:26:20 PM Central European Standard Time 
>> Michel Dänzer wrote:
>>> On 1/28/26 11:39, Christian König wrote:
>>>>
>>>> Even if we missed a vblank interrupt that thing is reoccurring, so the
>>>> worst thing that can happen is that we delayed reporting back success by
>>>> one frame.
>>>>
>>>> So something must have turned the CRTC fully off.
>>>
>>> Not sure that's a generally valid conclusion (do the gitlab issues talk
>>> about the display going black, or about it staying on but freezing?).
>>
>> In all the bug reports I've seen about page flip timeouts, and in all the 
>> timeouts I've seen on my machine, the screen remains on, but frozen.
>> It doesn't go black and doesn't turn off.
>>
>> Christian, why would the CRTC be turned off?
> 
> Exactly that's the question we need to answer.
> 
> But from what you describe the CRTC keeps on, just doesn't send any more vblank events.

The vblank interrupt source getting accidentally disabled might be one possible cause though.


>>> P.S. Completing the atomic commit and sending the completion event must work
>>> even if user space turns off any CRTCs as part of the commit[0].
> 
> Wait a second. What happens if we never complete that? So when the completion event is never signaled?
> 
> Does the kernel then reject any new atomic commit as well?

Fundamentally, current atomic KMS UAPI is that any attempt to do a commit before the previous one completes fails with EBUSY.

(Another possible scenario is that the commit completes as far as the kernel is concerned, but the completion events for it are never sent to user space for some reason. In that case, user space would hang waiting for the completion events. That's not the scenario we're talking about here though, or there would be no timeout in the kernel)


> If yes then I think that is not defensive at all. In other words when you are right and the page flip interrupt is used and missed then we are stuck forever.

I guess it's basically up to the driver to prevent that from happening. Other drivers don't seem to have such issues.


> In other words could it be that userspace does something illegal which the kernel fails to reject?

That's possible in theory, we haven't ruled out all simpler explanations on the kernel side though.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
