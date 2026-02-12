Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D3FEB48F0
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 10:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5592A10E1AD;
	Thu, 12 Feb 2026 10:20:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eryi6RMZ";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F4410E1AD;
 Thu, 12 Feb 2026 10:20:27 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fBWX75kgzz9tJR;
 Thu, 12 Feb 2026 11:20:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770891623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EvlNh4whGfRORlPs4ksfhA1L1r7Z2CtEieq3IwPk7Ic=;
 b=eryi6RMZAVZx/Z17Dv6jBLpnlhuJU3F9ucktibIq+euPBYgSLh8TuFcbZ4eRgl13sMCIlQ
 iKKo4ak83Q6OGd6uCiMWIb/CbjTpKT80JLRo8pjAqHC37LvlraPDDIWFzd3Xu4+CfwpInG
 1+68sJZGuSo+4brEnA7yBTd7XEhjQxDhLjZFX0NZz9LKBQ/frtSUbyX8Q3TqbLT4woT6uu
 EyE5dcCCzVRf6cort2/YCIGMsysKjgOeBjzI6YyXq+GQg4awpcbwdGsZdxA/HMAKSQxPN/
 TAVcmOiFXJuYaf7UbBAcS6nFUyrxHms029oeKj5QOW+oqMfU1Q5LIk1lzAop7A==
Message-ID: <5c5363a4-a337-40b0-9ee5-11fbe6fd3edf@mailbox.org>
Date: Thu, 12 Feb 2026 11:20:20 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amd/display: add module param to disable immediate
 vblank off
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Michele Palazzi <sysdadmin@m1k.cloud>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 mario.limonciello@amd.com, Rodrigo.Siqueira@igalia.com, alex.hung@amd.com,
 aurabindo.pillai@amd.com
References: <20260211074529.131290-1-sysdadmin@m1k.cloud>
 <2026021146-mockup-pushup-5f47@gregkh>
 <7a1fa826-cddc-4f8d-ae45-afe6ddecd6e0@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <7a1fa826-cddc-4f8d-ae45-afe6ddecd6e0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f2fbebcb4843a3059bf
X-MBO-RS-META: o8njixjm3uzjgjrjbgatzthy79dzzp5g
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

On 2/11/26 11:07, Christian König wrote:
> Dropping stable, putting Grep on BCC.
> 
> On 2/11/26 10:19, Greg KH wrote:
>> On Wed, Feb 11, 2026 at 08:45:29AM +0100, Michele Palazzi wrote:
>>> Add amdgpu.no_vblank_immediate parameter to optionally disable the
>>> immediate vblank disable path on DCN35+ non-PSR CRTCs. When set to 1,
>>> a 2-frame offdelay is used instead, matching the behavior used for
>>> older hardware and DGPUs.
>>
>> Please no more module parameters, this is not the 1990's with only one
>> one device in the system.  Please fix this the proper way.
> 
> I just wanted to write the same.
> 
> We can of course implement something in DAL/DC, but clearly not behind a module parameter.
> 
> Or is there any other negative consequence except for that the display blanking is delayed by ~40ms?

It doesn't affect display blanking, only how long the vblank interrupt stays enabled. (If it stays enabled unnecessarily, that might waste some energy)


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
