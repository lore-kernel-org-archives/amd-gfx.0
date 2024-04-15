Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541E7C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 14:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2AF310FE9C;
	Mon, 15 Apr 2024 14:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mm+QMVSj";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4779410F8B1;
 Mon, 15 Apr 2024 14:24:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D73EFCE0E01;
 Mon, 15 Apr 2024 14:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DCEC3277B;
 Mon, 15 Apr 2024 14:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713191042;
 bh=wM44Mb5X99jQyNH+X8BXp++TNUNY8/+5fKzpsl6KLD8=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
 b=mm+QMVSjBO17w3UOqliEQBXEfwBRh9NChcMkC2CdXl00C9UNcY2J/iwTLyUcPFP+9
 iQ4MXLD1X4dFtW1YC3Sf2Qjg5iw5eopMUnbiuuz0a6HaKP5vhsGOJdZy5xWi36Ve8J
 rpQXc1blDpl8zX62czvE+aHiBhbCej15rC5qkgG6pUSn0vvfU2bmH1G0pschRz9h3B
 a34+zpTy+Su6BONocM/vXKUxktT6kVkLo7ZR4tPmt4niqSJFqOyT74osIegUw/s3Aa
 mWB7ZHZLbjl1FK3m8WnSKp1Mk03+0UDew0pmDLH/6HaLDpxeSgaj4GX4FbptAa70JY
 V4m/Qfd011MgQ==
Message-ID: <f9ef8b9bced6f4656907d4a14355e970@kernel.org>
Date: Mon, 15 Apr 2024 14:23:59 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Jani Nikula" <jani.nikula@intel.com>
Subject: Re: Re: [PATCH 1/2] drm/print: drop include debugfs.h and include
 where needed
In-Reply-To: <878r1e3h8d.fsf@intel.com>
References: <878r1e3h8d.fsf@intel.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, "Alex
 Deucher" <alexander.deucher@amd.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 =?utf-8?b?Q2hyaXN0aWFuS8O2bmln?= <christian.koenig@amd.com>,
 "Daniel Vetter" <daniel@ffwll.ch>, "Danilo
 Krummrich" <dakr@redhat.com>, "David Airlie" <airlied@gmail.com>, "Huang
 Rui" <ray.huang@amd.com>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jonas
 Karlman" <jonas@kwiboo.se>, "Karol Herbst" <kherbst@redhat.com>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Lyude Paul" <lyude@redhat.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, =?utf-8?b?IlwiUGFuLCBYaW5odWlc?=
 =?utf-8?b?IiI=?= <Xinhui.Pan@amd.com>, "Robert Foss" <rfoss@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
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

On Mon, 15 Apr 2024 16:09:22 +0300, Jani Nikula wrote:
> On Wed, 10 Apr 2024, Jani Nikula <jani.nikula@intel.com> wrote:
> > Surprisingly many places depend on debugfs.h to be included via
> > drm_print.h. Fix them.
> 
> While all of this is trivial, merely adding some includes, please
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
