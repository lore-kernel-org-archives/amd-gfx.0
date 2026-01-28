Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89BAD3F06D
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 14:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 371E710E700;
	Wed, 28 Jan 2026 14:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZzxDUukM";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B40210E6FE;
 Wed, 28 Jan 2026 14:26:00 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f1PhN5tj1z9tgl;
 Wed, 28 Jan 2026 15:25:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769610356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N0KtvZAiq279HnErsKYQgcwSwzbk4w29Y1YUwEgWny8=;
 b=ZzxDUukMaT/EbRAEIPsnHYwOz9yDynRwR1aftvVUZ1reJv55G2u4QqSKms5a/rJHVh/p2t
 AhjgG8PorgdxneTZ4Rmo+6iv5Y1sTdZVPv9gNg5vhvhYFh2EEPYrGdAlGQyMDxM7TiVfGA
 TFZaPjfZXsnpOyZBm1K++Y5FmyU99uTrrBhYFnzbt4Fgso5vg6dlXYcScIEvK7ZMgtlCo2
 sjCV7ImySbt2v2SKQ1Y4Mq2qvKL0bXuQHETXEIlJP+dM4TWFPkinTZc19yTeHhkY98gg8Q
 QqKCW/TjrQXxvdS+N2FQLpKGiO9lCXZ80hBt1ZW+Ha3xLgMTsN1MV5J91bwWzg==
Message-ID: <15d1d986-e9cf-48fb-be4e-b2c33974dffc@mailbox.org>
Date: Wed, 28 Jan 2026 15:25:49 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] drm: introduce page_flip_timeout()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Hamza Mahfooz <someguy@effective-light.com>, dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Sunil Khatri <sunil.khatri@amd.com>, Ce Sun <cesun102@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Melissa Wen <mwen@igalia.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <79ed136a-cedd-4e97-adb8-bc3f4f2b8bb4@mailbox.org>
 <601b38b5-1890-48f9-adf9-54fb85650852@amd.com> <5173841.OV4Wx5bFTl@timur-max>
 <a2fe8187-9271-4cbf-8b7e-37ffda0799de@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <a2fe8187-9271-4cbf-8b7e-37ffda0799de@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: bf72866054627a691d2
X-MBO-RS-META: q93up3dt83qansi51w3cy3495qcbbxdn
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

On 1/28/26 12:25, Christian König wrote:
> On 1/28/26 10:19, Timur Kristóf wrote:
>> On 2026. január 26., hétfő 14:00:59 közép-európai téli idő Christian König 
>> wrote:
>>> On 1/26/26 11:27, Michel Dänzer wrote:
>>>> On 1/26/26 11:14, Christian König wrote:
>>>>>
>>>>> But looking at the slide Harry actually pointed out what immediately came
>>>>> to my mind as well, e.g. that the Compositor needs to issue a full
>>>>> modeset to re-program the CRTC.> 
>>>> In principle, the kernel driver has all the information it needs to
>>>> reprogram the HW by itself. Not sure why the compositor would need to be
>>>> actively involved.
>>>
>>> [...]
>>>
>>> Then second even if the kernel can do it I'm not sure if it should do it.
>>>
>>> [...]
>>
>> I agree with Michel here. It's a kernel bug, it should be solved by the 
>> kernel. I don't like the tendency of pushing userspace to handle kernel bugs, 
>> especially if this is just needed for one vendor's buggy driver. (No offence.)
> 
> Well I strongly disagree. The kernel is not here to serve userspace, [...]

Can't say I agree with that statement.

Anyway, user space certainly isn't here to kick the kernel back into gear after it hit a bug, or to tell it things it already knows.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
