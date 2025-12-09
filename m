Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757F8D3B7F3
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 13:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9F0510E54D;
	Tue,  9 Dec 2025 13:14:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="rmgfkwlw";
	dkim-atps=neutral
X-Greylist: delayed 589 seconds by postgrey-1.36 at gabe;
 Tue, 09 Dec 2025 01:44:32 UTC
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com
 [91.218.175.185])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BEDF10E45E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 01:44:32 +0000 (UTC)
Message-ID: <6fbc0496-9a96-4f72-a8d8-66b7885bdaf6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1765244070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jzxbq76rY7sat5ZfHgHcg7YgVaVN+fglvDNlTOGAYdI=;
 b=rmgfkwlwmvfdYElte9oePQyKa43vNAJdirR7GdVB94QROP8UE22PGYllW8lX+uD58cF+3i
 g8IZL3TyBat8mJrajPxPDunxwxYF5J/2j2rF79mIrg0WfODnTNZHu8EWkaN+MA4H2ukGYy
 zMlFHiO7QMmP1dxCk8g3bilaRy5Tg9s=
Date: Mon, 8 Dec 2025 17:34:25 -0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: Re: [RFC PATCH 0/2] Fixes on CM3 helper for plane shaper LUT
To: Melissa Wen <mwen@igalia.com>
Cc: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Melissa Wen <mwen@igalia.com>
References: <20251208234741.293037-1-mwen@igalia.com>
Content-Language: en-US
In-Reply-To: <20251208234741.293037-1-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Tue, 09 Dec 2025 13:14:36 +0000
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



> On Dec 8, 2025, at 3:48 PM, Melissa Wen <mwen@igalia.com> wrote:
> 
> ﻿There are some unexpected banding and shimmer effects when using
> steamOS/gamescope color pipeline for HDR on DCN32 or newer families.
> Those problems are not present in Steam Deck (DCN301). It happens on
> DCN32 because plane shaper LUT uses DCN30 CM3 helper to translate curves
> instead of DCN10 CM helper. This series identifies the necessary changes
> on CM3 helper to reduce differences on color transformation made by
> those two helpers.
> 
> Patch 1 aims to solve the shimmer/colorful points that looks like a
> wrong map of black values on red/green/blue colors. Patch 2 extends the
> delta clamping fix made in commit 27fc10d1095f ("drm/amd/display: Fix
> the delta clamping for shaper LUT") to solve some banding effects.
> 
> Banding is not fully solved by any helper and needs further
> investigation.
> 
> One easy way to check the current and expected behavior is moving the
> cursor (doing composition) to get the expected result from GFX. When the
> cursor disappears, those color transformations are back to be done by
> the display hw.

Hi Melissa,

Could you share how you’re testing the gamescope color pipeline with HDR on DCN32, i.e display and connection type? Are any extra gamescope or kernel patches required? 

At least on my own DCN32 setup (AMD 7900XTX) + my primary monitor (an LG 45gx950a-b) via DisplayPort or my DCN35 setup + integrated HDR OLED screen (Legion Go 2), gamescope always composites when HDR is enabled. I applied your patches on top of kernel 6.18, and my kernel is built with CONFIG_DRM_AMD_COLOR_STEAMDECK=y (the downstream name of AMD_PRIVATE_COLOR for SteamOS), so that shouldn't be an issue. I tried everything from 1280x720p -> 5120x2160p, and it does not work on any resolution.

Thanks,
Matt

> 
> Lemme know your thoughts!
> 
> Melissa
> 
> Melissa Wen (2):
>  drm/amd/display: fix wrong color value mapping on DCN32 shaper LUT
>  drm/amd/display: extend delta clamping logic to CM3 LUT helper
> 
> .../amd/display/dc/dcn30/dcn30_cm_common.c    | 32 +++++++++++++++----
> .../display/dc/dwb/dcn30/dcn30_cm_common.h    |  2 +-
> .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  9 +++---
> .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 17 ++++++----
> .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 16 ++++++----
> 5 files changed, 50 insertions(+), 26 deletions(-)
> 
> --
> 2.51.0
> 

