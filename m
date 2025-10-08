Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBD6CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 754A410E8AE;
	Wed,  8 Oct 2025 18:53:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="INPuDBqu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D61810E8B0
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:53:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 31DE844DF8;
 Wed,  8 Oct 2025 18:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB49C4CEE7;
 Wed,  8 Oct 2025 18:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759949592;
 bh=k3lytE0p7KVsLVlYjNZCVlbF041jOLgpw1F2nELOjT4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=INPuDBquSprAn38leJ19zfe5UraDVAqK7BEu15Cgxl25e+qzQb8zMPEK7vE/KZrqi
 2pmZr3naNfS6mnJZQ5Fv8wnPBsU1B/SSdXS9VWhRnOVSDWpdJAzIOUR8vZ39aqrx2/
 TXZtZGMDRoIS9tBnjz9TN69U+sVEvUq3hatJ7DRX6Ix1zBVWz7SutkudjKWeG7UxmG
 Hmg+DChENN5LdYdgMqF9YIQkRX/SYGfOLA8DZ6FXBczvEK0OGDFfcGOiToyvsbpfGl
 qJ6lrMY5Rly3FD/kyY/RCgOIvji2eaeMQO9kkEhGcVtvCyqGQXPTQH8vlExSYjIfwJ
 uaB65i2Sj2PnQ==
Message-ID: <c6c0d71d-4486-4aac-a6b6-618614292767@kernel.org>
Date: Wed, 8 Oct 2025 13:53:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Adjustment to power limit setting
To: Robert Beckett <bob.beckett@collabora.com>
Cc: amd-gfx <amd-gfx@lists.freedesktop.org>, Lijo Lazar <Lijo.Lazar@amd.com>
References: <20251007164116.371340-1-bob.beckett@collabora.com>
 <20251007193110.763709-1-bob.beckett@collabora.com>
 <76272528-5167-445d-9a71-5c693323da8d@kernel.org>
 <199c51728f5.778006f5430494.3779269787170457909@collabora.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <199c51728f5.778006f5430494.3779269787170457909@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/8/25 1:30 PM, Robert Beckett wrote:
> 
>   ---- On Tue, 07 Oct 2025 20:40:43 +0100  Mario Limonciello <superm1@kernel.org> wrote ---
>   > On 10/7/25 2:31 PM, Bob Beckett wrote:
>   > > --- quoted message ---
>   > >> From: Robert Beckett <bob.beckett@collabora.com>
>   > >>> Lijo pointed out to me that
>   > >>> commit ed4efe426a49 ("drm/amd: Restore cached power limit during resume")
>   > >>> commit 796ff8a7e01b ("drm/amd: Restore cached manual clock settings during resume")
>   > >>> both should be unnecessary because smu_restore_dpm_user_profile() already
>   > >>> restores them.  However in looking at the code there is a case that isn't
>   > >>> properly restored - the FAST PPT limits supported by Van Gogh. The nuance
>   > >>> isn't immediately obvious because the limit variable is overloaded with
>   > >>> limit type.
>   > >>> This series attempts to address that issue by passing limit type around
>   > >>> and saving/restoring both types.
>   > >>> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
>   > >>> Mario Limonciello (5):
>   > >>>    drm/amd: Remove some unncessary header includes
>   > >>>    drm/amd: Stop overloading power limit with limit type
>   > >>>    drm/amd: Save and restore all limit types
>   > >>>    drm/amd: Drop calls to restore power limit and clock from smu_resume()
>   > >>>    drm/amd: Adjust whitespace for vangogh_ppt
>   > >>>   .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +-
>   > >>>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  3 +-
>   > >>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +-
>   > >>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +-
>   > >>>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  5 +--
>   > >>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 40 ++++++++-----------
>   > >>>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 +-
>   > >>>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 13 +++---
>   > >>>   8 files changed, 29 insertions(+), 42 deletions(-)
>   > >>> --
>   > >>> 2.51.0
>   > >> entire series
>   > >> Tested-by: Robert Beckett <bob.beckett@collabora.com>
>   > >
>   > > apologies, I need to retract this Tested-by.
>   > > I inadvertently tested v1. v2 looks like it still has the restore issue.
>   > > I'll debug and get back to you.
>   >
>   > Oh thanks for getting back.  Let me hold up our merge on the patches
>   > then too.
>   >
> 
> The issue with v2 turned out to be quite simple in the end.
> You dropped
> 
> drm/amd: Drop superfluous call to set_power_limit()
> 
> from v1.
> picking that on top of v2 series makes it work again, so assuming v3 adds this back, have another:
> 
> entire series
> Tested-by: Robert Beckett <bob.beckett@collabora.com>
> 

Lijo had commented that limits are different for default and fast PPT, 
so we shouldn't be dropping that.  There is already a check in 
vangogh_set_power_limit() which is used for checking fast limits.

So to me it appears the issue here is with the handling of fast PPT. 
With that patch (Drop superfluous call to set_power_limit) in place do 
you see "New power limit (%d) is out of range" in the logs?

If not; maybe can you annotate with the v2 applied but not that "Drop 
superfluous call to set_power_limit" patch what each call to 
smu_set_power_limit() has for arguments and what max_power_limit, 
min_power_limit are.

I wonder if you're ending up with a call with a fast limit of 0.  If so; 
throw a dump_stack() in that condition so we can understand why.
I see max_fast_ppt_limit is hard coded to 30 in vangogh_ppt.
