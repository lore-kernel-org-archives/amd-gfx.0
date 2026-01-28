Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0857DD25B44
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 11:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E84810E697;
	Wed, 28 Jan 2026 11:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qJw3Ji5p";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9512610E694;
 Wed, 28 Jan 2026 11:26:33 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f1KjL1TZXz9tmC;
 Wed, 28 Jan 2026 12:26:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769599590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UgMqvRxiMInROhFo09cCsWov6HfEo9x2oEpjYZtqkjM=;
 b=qJw3Ji5pgV7YO8j2CKYL46Zm0LAnV4tkneRpDowzhJHTQGwgdmeQbV5sSQLu0dxioQjUpI
 +sqK346GVPrrA9VG4ZfVgyf72EfZvK9mLawealRB6mv6F57eUti8NZlyyEOkgnqK5QNQiB
 QQjHi6ok6nk5mmikDOYcRT0f0wI2mw6HRdXSAeC7zxqVPv3PZPexM8ay1z7eGUWgUmFKEt
 vsf14wftsylNXmQV6axEFI/w6zkJoHkjA3YVVGM9gXOb6ai872Yn+ZypRw3vhqkkSofq5q
 dgu7sjGru+J0zD7pNwk87GYDKQTyf+3PWfhprTnfIIhnwwfOmIOzp+tJYOyi8Q==
Message-ID: <f71df23e-f267-46b7-8fd8-4235e9a7a7fb@mailbox.org>
Date: Wed, 28 Jan 2026 12:26:20 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] drm: introduce page_flip_timeout()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Hamza Mahfooz <someguy@effective-light.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
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
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <2de6d428-b997-4ba8-8766-a211e5612e72@amd.com>
 <2349754.vFx2qVVIhK@timur-hyperion>
 <a8b972be-7265-492f-9855-cdec94a0e0dc@amd.com>
 <aXUQKSJGkz7nzHJ4@hal-station.localdomain>
 <CADnq5_Ob8yiivco+szanSiXuRwdAu4xHMe=8OQSk+Ufqykgobg@mail.gmail.com>
 <aXlBx528d11lMJvl@hal-station>
 <CADnq5_NXd7HYipJTW_riwQDjrZ7S-PW7oFJ=C94_FGAAesV3kA@mail.gmail.com>
 <17cd6378-e3fa-419b-90d3-7e0549817110@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <17cd6378-e3fa-419b-90d3-7e0549817110@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d8bd9bd850864ad67a1
X-MBO-RS-META: a5jk46pmjgbh87au54hpo1sbf1zjj4wd
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

On 1/28/26 11:39, Christian König wrote:
> On 1/27/26 23:57, Alex Deucher wrote:
>> On Tue, Jan 27, 2026 at 5:53 PM Hamza Mahfooz
>> <someguy@effective-light.com> wrote:
>>>
>>> On Mon, Jan 26, 2026 at 09:20:55AM -0500, Alex Deucher wrote:
>>>> I suspect just calling drm_crtc_send_vblank_event() here on the
>>>> relevant crtcs would be enough.
>>>>
>>>
>>> Seems like an interesting idea, though I would imagine we would still
>>> want to attempt a reset (of some kind) assuming that the subsequent page
>>> flip also experiences a timeout.
>>
>> Is it actually a timeout or just missed interrupts?  I'm wondering if
>> some power feature races with the modeset and causes the interrupt to
>> get missed from time to time.
> 
> That is my strong suspicion as well.
> 
> Even if we missed a vblank interrupt that thing is reoccurring, so the worst thing that can happen is that we delayed reporting back success by one frame.
> 
> So something must have turned the CRTC fully off.

Not sure that's a generally valid conclusion (do the gitlab issues talk about the display going black, or about it staying on but freezing?). AFAIR at least in some cases amdgpu uses a dedicated "page flip" interrupt instead of the vblank interrupt, in which case missing a single interrupt could cause a timeout.


P.S. Completing the atomic commit and sending the completion event must work even if user space turns off any CRTCs as part of the commit[0]. So your hypothesis would be a kernel bug, accidentally turning off the CRTC and/or not handling a CRTC getting turned off correctly.

[0] If any CRTC for which the commit has state is off both before and after the commit though, the commit fails with an error before it could result in a timeout.

-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
