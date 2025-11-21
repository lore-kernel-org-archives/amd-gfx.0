Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27369CFC28A
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Nov 2025 14:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A788010E088;
	Fri, 21 Nov 2025 14:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oj80IPnX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B1F210E069
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 14:54:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F2AB4040E;
 Fri, 21 Nov 2025 14:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418DBC4CEF1;
 Fri, 21 Nov 2025 14:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763736850;
 bh=xxeVhzxOzXKO+TcE4ueHKeJnmmJ4XDSRaxJj/xYz5W0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oj80IPnXrU7crdKexbMfpXShYX8Kcd6pgLz01+gobk4Vn31o09vVqie6DrmbIymiE
 m5EkTQbF6xqYvzz+hMDwzS3WJtPVc2Z4b+Vkmmu1ZaLnApUGlR0faCA81E2qGNwXR9
 0iDVbM3ExsEo+9quVLfbgsKPCVlVAyPGsN/a9BiePlFRVkDdFisWUO/Rw6Za7KerxL
 UKLYox52jV9dmO9e3HhpnFvMypJeK2TJYoduI2VZtTwoBkruXXjKLikYRpSoBEe9Ig
 8DGgUeVJueFeg279KJfRsGErrTKgPzXsYZ0PEj9yeJGobi1a0/rmHg3PRNThAf5nw3
 75G2p+xc2GGiQ==
Message-ID: <26905082-9c78-4d29-afad-c5dd7b8251d9@kernel.org>
Date: Fri, 21 Nov 2025 08:54:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] Address amdgpu reload issues in APUs
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Robert Beckett <bob.beckett@collabora.com>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20251121135658.459620-1-siqueira@igalia.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20251121135658.459620-1-siqueira@igalia.com>
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



On 11/21/2025 7:55 AM, Rodrigo Siqueira wrote:
> This series addresses the issue of amdgpu reload failures in APUs. The
> first commit adds a GPU reset during unload time, and the second commit
> removes a specific fix for the Renoir device that becomes outdated with
> the first patch.
> 
> Changes since V4:
> - Add a code comment about PSP behavior.
> 
> Thanks
> Siqueira
> 
> Rodrigo Siqueira (2):
>    drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu is reloaded
>    Revert "drm/amd: fix gfx hang on renoir in IGT reload test"
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 ++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 ----
>   2 files changed, 14 insertions(+), 4 deletions(-)
> 

Series looks good to me.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
