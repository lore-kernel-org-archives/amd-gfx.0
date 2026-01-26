Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62EDCF65D0
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 10:27:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83F6310E3F9;
	Mon, 26 Jan 2026 10:27:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MFO9X/U8";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF89710E141;
 Mon, 26 Jan 2026 10:27:11 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f04Tm1B2wz9vHl;
 Mon, 26 Jan 2026 11:27:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769423228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6sbMh/LZTBjf3oYvxQIR9x4onJflTFsFCSrqHGiubVw=;
 b=MFO9X/U8S3g9QZ6Ch9XzUAlCTjuMqszagtzTpspqiBL/kabTg1A4aQMcY5LDKy2ZSNyJOu
 tDapIiRysO5+5DhYRBoUU/vMDZ+r1aVGRQQsIHC0yJ7mffRel9J+YWNEI+iAnl9p7FYqae
 DRD3R9OMihrcxQxnwQWWaqTguI26mwkaZasWgUPVnFeunjqngVibLZWXkXWxoyYKitLfmk
 G+h/Z03tzCz/lzsp7ciemXmhYWOcM36qjMNRI2U3skbmNhFW5T3e1iHyqQ78RhAA5OS57i
 h2U4c3Fmohgmhqa+i1AE1+TbTprEW50wE1BDSs9V3/KRW2pPFWX0p45NJdsbGQ==
Message-ID: <79ed136a-cedd-4e97-adb8-bc3f4f2b8bb4@mailbox.org>
Date: Mon, 26 Jan 2026 11:27:00 +0100
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
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <2de6d428-b997-4ba8-8766-a211e5612e72@amd.com>
 <2349754.vFx2qVVIhK@timur-hyperion>
 <fd3f2b16-41e7-4a9b-999d-e137e5abb7df@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <fd3f2b16-41e7-4a9b-999d-e137e5abb7df@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ixkoxd48584githc67c175m8fyfajjso
X-MBO-RS-ID: 346b3f83828de2369ac
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

On 1/26/26 11:14, Christian König wrote:
> On 1/23/26 15:44, Timur Kristóf wrote:
>> On Friday, January 23, 2026 2:52:44 PM Central European Standard Time 
>> Christian König wrote:
>>
>>> So as far as I can see the whole approach doesn't make any sense at all.
>>
>> Actually this approach was proposed as a solution at XDC 2025 in Harry's 
>> presentation, "DRM calls driver callback to attempt recovery", see page 9 in 
>> this slide deck:
>>
>> https://indico.freedesktop.org/event/10/contributions/431/attachments/
>> 267/355/2025%20XDC%20Hackfest%20Update%20v1.2.pdf
>>
>> If you disagree with Harry, please make a counter-proposal.
> 
> Well I must have missed that detail otherwise I would have objected.
> 
> But looking at the slide Harry actually pointed out what immediately came to my mind as well, e.g. that the Compositor needs to issue a full modeset to re-program the CRTC.

In principle, the kernel driver has all the information it needs to reprogram the HW by itself. Not sure why the compositor would need to be actively involved.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
