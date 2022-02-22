Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD108C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 09:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2280B10E1EF;
	Tue, 22 Feb 2022 09:14:04 +0000 (UTC)
X-Greylist: delayed 405 seconds by postgrey-1.36 at gabe;
 Tue, 22 Feb 2022 09:14:02 UTC
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050::465:102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 134A910E369
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 09:14:02 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4K2tbS02nTz9smh;
 Tue, 22 Feb 2022 10:07:16 +0100 (CET)
Message-ID: <aab017e3-6229-690c-32ac-e9acbf640132@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1645520833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IMO/ciGxSa7UtFlnLNbo4s9O6cPkCw/RYqbXRnjdcbU=;
 b=ryJihyiUy5ZHphjW/CV43mm/KFFErTNU4lGWmrS2qxLu9UgxxqVrmzTHi26xZI4SlzyvNE
 sygHhkVsZnHFC2laCN54JJ9F7BtkKoIIuHfoMIyBVO8l4Ty5LR7u6bVipIiPhUL3GVdnP/
 Ol5GtAnpV4Dbjx9akM3hktA36XLBStgmZk+sMNE6WEjAsVcycYck3Ni/BKQ3MzSKqa50rF
 MgwGdKVSQZ9mMB/c6HRQNqi9vGH7YM1bsL1ipd1DpWPEOhiLWial1FSmGq1drOQhJoWAIN
 v7xDICms6IVBFEsOrhcWsQL/W08I1fYjNCV9n96PpuxG2zuq0SLRf7u3+YmFYg==
Date: Tue, 22 Feb 2022 10:07:10 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 7/7] drm/amdgpu: drop testing module parameter
Content-Language: en-CA
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220218222603.25470-1-alexander.deucher@amd.com>
 <20220218222603.25470-7-alexander.deucher@amd.com>
 <4009de28-8add-97b9-0dd3-8d44704af322@mailbox.org>
 <CADnq5_P2ffjt7L27vUo+iwRUJNu2+Wmo9ORNwv42XYdgHwhPkA@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <CADnq5_P2ffjt7L27vUo+iwRUJNu2+Wmo9ORNwv42XYdgHwhPkA@mail.gmail.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-02-21 22:35, Alex Deucher wrote:
> On Mon, Feb 21, 2022 at 12:44 PM Michel Dänzer
> <michel.daenzer@mailbox.org> wrote:
>>
>> On 2022-02-18 23:26, Alex Deucher wrote:
>>> This was always duplicate functionality with the benchmark tests.
>>
>> Not really. The purpose of amdgpu_do_test_moves is testing that copies between GTT & VRAM work across the whole GTT aperture (when I originally wrote radeon_do_test_moves, they didn't on the PowerBook I was using at the time).
>>
> 
> Fair enough.  I'll drop it for now.  Might be useful to convert to
> debugfs at some point as well.

To be clear, I'm not saying this needs to stay — maybe it's not useful anymore. I'm just pointing out that it's not redundant with the benchmarks.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
