Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6305BF8A145
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 08:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F197510E1AB;
	Thu, 16 Apr 2026 08:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="st/Zcig/";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C20910E1AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 08:55:40 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fxBgD5K1pz9vBB;
 Thu, 16 Apr 2026 10:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776329736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/Bj/dHYw9246ijFmj+cIiTb9TZfJtc5DzY0uZWsZdU=;
 b=st/Zcig/UYW6ZT++qpDL9DUo+XquyuhoOvlD32yV1KEB2UQvL9UP3VptnCrNRF31WFtoiK
 DU2BIaG94uID9QayIWlg2ZDYIoFKVVjDN3DMHOLRKH+deKjhezrqBK/3n2tBDlDKIWT+B2
 gS9o8YV2eA7AoEMWQavxYbg70oO4v6jyV8uz1eyW6KeIXHVJniKO/uTPbzn5q+mXBd8IZ2
 dnK6OdmOoHXiqfehLaDPkpDTZ53+NSTiBJWIgMjbu8AOVi8uPjpg/Bhs25PdWB63O+/DLf
 kb720cMOXhStW5a4OiD3DiptaXufpQfD7yBU7lD++vCn3kqeqWLF7v2SqaQOvA==
Message-ID: <5bb25240-0596-4fb0-9c95-e5139f3ea74f@mailbox.org>
Date: Thu, 16 Apr 2026 10:55:32 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu/userq: gnome shell uses max priority
To: "Khatri, Sunil" <sukhatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>,
 "Mohan Marimuthu, Yogesh" <yogesh.mohanmarimuthu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260413084943.819126-1-sunil.khatri@amd.com>
 <5976d500-d768-4a63-8fbe-4e68e20fc0e6@amd.com>
 <4e862955-3437-40f4-bf04-2bdab7d84909@amd.com>
 <3e220f91-a89e-42fa-9186-c9658d41839b@mailbox.org>
 <9ad4a8a9-7888-4634-aa50-15d22e98dc1d@amd.com>
 <1cd26979-9b60-48cb-a0fa-308769245e38@mailbox.org>
 <acaac7c3-178b-480c-b11f-3731bd215282@mailbox.org>
 <7a264972-aa82-4e7b-9780-7cbf6359d04a@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <7a264972-aa82-4e7b-9780-7cbf6359d04a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1bejphpg9hijj7ybyk4tbrfx6p4kuhj1
X-MBO-RS-ID: cee98feca23dfe32ac2
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

On 4/16/26 10:49, Khatri, Sunil wrote:
> On 15-04-2026 02:40 pm, Michel Dänzer wrote:
>> On 4/14/26 16:50, Michel Dänzer wrote:
>>> On 4/14/26 15:51, Khatri, Sunil wrote:
>>>>
>>>> Below is the check that we have for userqueues during queue creation, and for gnome it did not hit any of the condition and eventually return with -EACCES that is wrong. It has to be maste or CAP_SYS_NICE capable.
>>>> if(priority<AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH)
>>>>                  return0;
>>>>          if(capable(CAP_SYS_NICE))
>>>>                  return0;
>>>>          if(drm_is_current_master(filp))
>>>>                  return0;
>>>>          return-EACCES;
>>> Indeed, looks like at least in some cases mutter creates the EGL context before it has DRM master status. I'll look into fixing this in mutter.
>> I realized what I'm seeing is a regression from https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40519 , since a render node file description can't have DRM master status.
>>
>> I created https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40974 to fix that.
>
> Seems to work. Not seeing the queue creation failures anymore after i used the change.
That's good.

There can still be scenarios where it'll fail though, which should be handled as gracefully with user queues as with kernel ones.


P.S. Please don't top-post.

-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
